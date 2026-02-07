do
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	local Players = game:GetService("Players")
	
	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")
	
	-- UI Path
	local mainFrame = playerGui:WaitForChild("SupportReportGui"):WaitForChild("Main")
	local chatFrame = mainFrame:WaitForChild("ChatFrame")
	
	print("[UI] Loaded ChatFrame from PlayerGui.SupportReportGui.Main.ChatFrame")
	
	-- core UI
	local chatBox    = chatFrame:FindFirstChild("ChatBox")
	local sendButton = chatFrame:FindFirstChild("SendButton")
	local waitDot    = chatFrame:FindFirstChild("WaitDot")
	local doneButton = chatFrame:FindFirstChild("DoneButton")
	local doneFrame  = chatFrame:FindFirstChild("DoneFrame")
	
	-- chat roots
	local parentContainer = chatFrame.Parent
	local chatDeveloper = parentContainer and parentContainer:FindFirstChild("ChatDeveloper")
	local chatAI        = parentContainer and parentContainer:FindFirstChild("ChatAI")
	
	-- controls & title
	local panelParent = mainFrame
	local btnAI        = panelParent and panelParent:FindFirstChild("AI")
	local btnDeveloper = panelParent and panelParent:FindFirstChild("Developer")
	local titleChannel = panelParent and panelParent:FindFirstChild("TitleChannel")
	
	-- warns
	if not (chatBox and sendButton) then warn("Không tìm thấy ChatBox hoặc SendButton trong ChatFrame") end
	if not chatDeveloper then warn("Không tìm thấy ChatDeveloper") end
	if not chatAI then warn("Không tìm thấy ChatAI") end
	if not btnAI or not btnDeveloper then warn("Không tìm thấy nút 'AI' hoặc 'Developer' ở Main") end
	if not titleChannel then warn("Không tìm thấy TitleChannel ở Main — title sẽ không animate") end
	
	-- create/find MyChatSent BindableEvent
	local myChatEvent = chatFrame:FindFirstChild("MyChatSent")
	if not myChatEvent then
		local ok, ev = pcall(function()
			local e = Instance.new("BindableEvent")
			e.Name = "MyChatSent"
			e.Parent = chatFrame
			return e
		end)
		if ok then myChatEvent = ev end
	end
	
	-- helpers
	local function findIcon(parent)
		if not parent then return nil end
		for _, v in ipairs(parent:GetDescendants()) do
			if v.Name == "Icon" and (v:IsA("ImageLabel") or v:IsA("ImageButton")) then
				return v
			end
		end
		return nil
	end
	
	local function tweenX(guiObject, targetXScale, duration, easingStyle, easingDir)
		if not guiObject then return end
		local currentPos = guiObject.Position
		local target = UDim2.new(targetXScale, currentPos.X.Offset, currentPos.Y.Scale, currentPos.Y.Offset)
		local info = TweenInfo.new(duration or 0.3, easingStyle or Enum.EasingStyle.Quad, easingDir or Enum.EasingDirection.Out)
		local tw = TweenService:Create(guiObject, info, {Position = target})
		tw:Play()
		return tw
	end
	local function tweenSize(guiObject, targetSize, duration)
		if not guiObject then return end
		local info = TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		local tw = TweenService:Create(guiObject, info, {Size = targetSize})
		tw:Play()
		return tw
	end
	
	-- channels table (refs)
	local channels = {
		Developer = {
			container = chatDeveloper,
			myChat = chatDeveloper and chatDeveloper:FindFirstChild("MyChat"),
			chat  = chatDeveloper and chatDeveloper:FindFirstChild("DevChat"),
			isWaiting = false,
			doneVisible = false,
			lastResponse = nil,
			waitTween = nil,
			typingToken = 0
		},
		AI = {
			container = chatAI,
			myChat = chatAI and chatAI:FindFirstChild("MyChat"),
			chat  = chatAI and chatAI:FindFirstChild("AIChat"),
			isWaiting = false,
			doneVisible = false,
			lastResponse = nil,
			waitTween = nil,
			typingToken = 0
		}
	}
	
	-- typing default duration (seconds)
	local TYPING_DURATION = 0.5
	
	-- colors
	local COLOR_DEFAULT = Color3.fromRGB(24,24,24)
	local COLOR_ACTIVE  = Color3.fromRGB(35,35,35)
	local COLOR_HOVER   = Color3.fromRGB(70,70,70)
	
	local disabledBg = Color3.fromRGB(35, 35, 35)
	local disabledIconColor = Color3.fromRGB(255, 255, 255)
	local enabledBg = Color3.fromRGB(255, 255, 255)
	local enabledIconColor = Color3.fromRGB(0, 0, 0)
	
	-- active channel default
	local activeChannelName = (chatDeveloper and "Developer") or (chatAI and "AI") or "Developer"
	
	local function checkSendable(text)
		if not text then return false end
		local trimmed = text:match("^%s*(.-)%s*$") or ""
		return #trimmed >= 2
	end
	
	local function setIconColor(canSend)
		local icon = findIcon(sendButton)
		if icon then
			icon.ImageColor3 = canSend and enabledIconColor or disabledIconColor
		end
	end
	
	local function updateSendButtonVisual(canSend)
		if not sendButton then return end
		local ch = channels[activeChannelName]
		local blockedByDone = ch and ch.doneVisible
		local finalCanSend = canSend and (not blockedByDone) and not (ch and ch.isWaiting)
		sendButton.BackgroundColor3 = finalCanSend and enabledBg or disabledBg
		setIconColor(finalCanSend)
		if pcall(function() return sendButton.TextColor3 end) then
			sendButton.TextColor3 = finalCanSend and Color3.new(0,0,0) or Color3.fromRGB(200,200,200)
		end
		sendButton.Active = finalCanSend
		sendButton.AutoButtonColor = true
	end
	
	-- MOD: time-based typing that completes in chunks of 0.5s per 100 chars
	-- If `duration` is passed (non-nil), that value is used. Otherwise:
	-- duration = ceil(max(1, n) / 100) * 0.5
	local function typeTextIntoLabel(label, fullText, duration, channel)
		if not label then return end
	
		local s = tostring(fullText or "")
		local n = #s
	
		-- compute duration automatically if not provided:
		if not duration then
			-- ensure at least 1 char bucket so empty strings still use 0.5s
			local bucketCount = math.ceil(math.max(1, n) / 100)
			duration = bucketCount * 0.5
		end
	
		-- bump token to cancel any previous typing for this channel
		if channel then
			channel.typingToken = (channel.typingToken or 0) + 1
		end
		local myToken = channel and channel.typingToken or math.random(1,1000000)
	
		-- quick path for empty string: still respect duration by doing nothing (or set empty)
		pcall(function() label.Text = "" end)
		if n == 0 then return end
	
		task.spawn(function()
			local startTime = tick()
			local displayed = 0
			local tickWait = 0.016 -- ~60 FPS updates
	
			while true do
				-- cancel if another typing started
				if channel and channel.typingToken ~= myToken then return end
	
				local elapsed = tick() - startTime
				if elapsed >= duration then break end
	
				-- fraction progress [0,1)
				local frac = elapsed / duration
				local want = math.floor(frac * n)
	
				if want > displayed then
					displayed = want
					pcall(function() label.Text = string.sub(s, 1, displayed) end)
				end
	
				task.wait(tickWait)
			end
	
			-- final cancel check then set full text
			if channel and channel.typingToken ~= myToken then return end
			pcall(function() label.Text = s end)
		end)
	end
	
	-- wait loop
	local waitLoopRunning = false
	local function startWaitLoopFor(channelName)
		local ch = channels[channelName]
		if not ch then return end
		ch.isWaiting = true
		ch.doneVisible = false
		if channelName == activeChannelName then
			if waitDot then waitDot.Visible = true end
			updateSendButtonVisual(false)
			if waitLoopRunning then return end
			waitLoopRunning = true
			task.spawn(function()
				local small = UDim2.new(0.25,0,0.25,0)
				local big = UDim2.new(0.4,0,0.4,0)
				while waitLoopRunning and channels[activeChannelName] and channels[activeChannelName].isWaiting do
					if waitDot then
						ch.waitTween = tweenSize(waitDot, big, 0.45)
						if ch.waitTween then pcall(function() ch.waitTween.Completed:Wait() end) end
					end
					if not (channels[activeChannelName] and channels[activeChannelName].isWaiting) then break end
					if waitDot then
						ch.waitTween = tweenSize(waitDot, small, 0.45)
						if ch.waitTween then pcall(function() ch.waitTween.Completed:Wait() end) end
					end
				end
				if ch.waitTween then pcall(function() ch.waitTween:Cancel() end) ch.waitTween = nil end
				if waitDot then waitDot.Visible = false end
				waitLoopRunning = false
			end)
		end
	end
	
	-- Reset a channel to a clean initial state (cancels typing/tweens, clears texts, hides done/wait)
	local function resetChannel(channelName)
		local ch = channels[channelName]
		if not ch then return end
	
		-- cancel wait tween
		if ch.waitTween then
			pcall(function() ch.waitTween:Cancel() end)
			ch.waitTween = nil
		end
	
		-- stop waiting/done state
		ch.isWaiting = false
		ch.doneVisible = false
		ch.lastResponse = nil
	
		-- bump typing token to cancel any active typing
		ch.typingToken = (ch.typingToken or 0) + 1
	
		-- hide waitdot if active channel
		if channelName == activeChannelName then
			if waitDot then waitDot.Visible = false end
			if doneButton then doneButton.Visible = false end
			if doneFrame then doneFrame.Visible = false end
		end
	
		-- reset myChat and chat UI positions and text safely
		if ch.myChat then
			pcall(function()
				if ch.myChat:FindFirstChild("TextChat") then ch.myChat.TextChat.Text = "" end
				local startYScale = (ch.myChat.Position and ch.myChat.Position.Y.Scale) or 0.1
				local startYOffset = (ch.myChat.Position and ch.myChat.Position.Y.Offset) or 0
				ch.myChat.Position = UDim2.new(1, 0, startYScale, startYOffset)
			end)
		end
	
		if ch.chat then
			pcall(function()
				if ch.chat:FindFirstChild("TextChat") then ch.chat.TextChat.Text = "" end
				local startYScale = (ch.chat.Position and ch.chat.Position.Y.Scale) or 0.175
				local startYOffset = (ch.chat.Position and ch.chat.Position.Y.Offset) or 0
				ch.chat.Position = UDim2.new(-0.55, 0, startYScale, startYOffset)
			end)
		end
	end
	
	local function stopWaitFor(channelName, responseText)
		local ch = channels[channelName]
		if not ch then return end
		ch.isWaiting = false
		ch.lastResponse = responseText
		ch.doneVisible = true
	
		-- set stored text and put hidden pos for that channel (safe)
		if ch.chat and ch.chat:FindFirstChild("TextChat") then
			-- clear text and set hidden X (we will tween in and type)
			pcall(function() ch.chat.TextChat.Text = "" end)
			local startYScale = (ch.chat.Position and ch.chat.Position.Y.Scale) or 0.175
			local startYOffset = (ch.chat.Position and ch.chat.Position.Y.Offset) or 0
			ch.chat.Position = UDim2.new(-0.55, 0, startYScale, startYOffset)
		end
	
		-- if active -> tween into view and type response
		if channelName == activeChannelName then
			if ch.chat and ch.chat:FindFirstChild("TextChat") then
				-- tween in
				local tw = tweenX(ch.chat, 0.1, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
				-- start typing concurrently (use channel typing token)
				typeTextIntoLabel(ch.chat.TextChat, tostring(responseText or ""), TYPING_DURATION, ch)
			end
			if doneButton then doneButton.Visible = true end
			if doneFrame then doneFrame.Visible = true end
			waitLoopRunning = false
			if ch.waitTween then pcall(function() ch.waitTween:Cancel() end) ch.waitTween = nil end
		end
	
		updateSendButtonVisual(checkSendable(chatBox and chatBox.Text or ""))
	end
	
	-- global exposure
	_G.DevChat = function(msg)
		task.spawn(function()
			if channels.Developer and channels.Developer.isWaiting then
				stopWaitFor("Developer", msg)
			else
				warn("DevChat gọi khi Developer không ở chế độ đợi - bỏ qua")
			end
		end)
	end
	_G.AIChat = function(msg)
		task.spawn(function()
			if channels.AI and channels.AI.isWaiting then
				stopWaitFor("AI", msg)
			else
				warn("AIChat gọi khi AI không ở chế độ đợi - bỏ qua")
			end
		end)
	end
	
	-- MOD: doSendFor - send a message for a specific channel WITHOUT forcing UI tab switch.
	-- Additionally: ensure Developer channel is reset before sending (so old states don't interfere).
	local function doSendFor(channelName, message)
		if not channelName or not message then return end
		local ch = channels[channelName]
		if not ch then return end
		local trimmed = tostring(message):match("^%s*(.-)%s*$") or ""
		if #trimmed < 2 then return end
	
		-- MOD: If target is Developer, reset it first (clear old state)
		if channelName == "Developer" then
			pcall(function() resetChannel("Developer") end)
		end
	
		-- if sending in active channel, preserve existing behavior
		if channelName == activeChannelName then
			-- clear chatBox for active channel (user pressed send)
			if chatBox then chatBox.Text = "" end
	
			if ch and ch.myChat and ch.myChat:FindFirstChild("TextChat") then
				local t = ch.myChat.TextChat
				-- clear and set hidden X first (we want consistent starting position)
				pcall(function() t.Text = "" end)
				local startYScale = (ch.myChat.Position and ch.myChat.Position.Y.Scale) or 0.1
				local startYOffset = (ch.myChat.Position and ch.myChat.Position.Y.Offset) or 0
				ch.myChat.Position = UDim2.new(1, 0, startYScale, startYOffset)
				-- tween in and type concurrently
				tweenX(ch.myChat, 0.35, 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				typeTextIntoLabel(t, trimmed, TYPING_DURATION, ch)
			end
		else
			-- inactive channel: do not touch chatBox or UI that is visible to the user.
			-- We set the hidden myChat text so the message is queued/stored for that channel.
			if ch and ch.myChat and ch.myChat:FindFirstChild("TextChat") then
				pcall(function()
					-- set text immediately (no typing animation since it's hidden)
					ch.myChat.TextChat.Text = trimmed
					-- ensure it stays hidden
					local startYScale = (ch.myChat.Position and ch.myChat.Position.Y.Scale) or 0.1
					local startYOffset = (ch.myChat.Position and ch.myChat.Position.Y.Offset) or 0
					ch.myChat.Position = UDim2.new(1, 0, startYScale, startYOffset)
				end)
			end
		end
	
		-- fire bindable so other systems see the chat (channelName param)
		if myChatEvent and myChatEvent:IsA("BindableEvent") then
			pcall(function() myChatEvent:Fire(channelName, trimmed) end)
		end
	
		-- start waiting visuals/state for that channel (if active, visuals will show; if not, state is still correct)
		startWaitLoopFor(channelName)
	end
	
	-- keep doSend wrapper for backward compatibility (calls doSendFor for activeChannel)
	local function doSend(message)
		doSendFor(activeChannelName, message)
	end
	
	-- layout helpers (unchanged)
	local function temporarilyDisableLayout(parent)
		if not parent then return nil end
		for _, c in ipairs(parent:GetChildren()) do
			if c:IsA("UIListLayout") or c:IsA("UIGridLayout") then
				local layout = c
				local originalParent = layout.Parent
				layout.Parent = nil
				return {layout = layout, originalParent = originalParent}
			end
		end
		return nil
	end
	local function restoreLayout(token)
		if not token then return end
		if token.layout and token.originalParent then
			token.layout.Parent = token.originalParent
		end
	end
	
	-- Title animation (unchanged) ------------------------------------------------
	local titleAnimToken = 0
	local function setTitleImmediate(text)
		if not titleChannel then return end
		pcall(function() titleChannel.Text = text end)
	end
	local function animateTitle(newText)
		if not titleChannel then return end
		titleAnimToken = titleAnimToken + 1
		local myToken = titleAnimToken
		local current = tostring(titleChannel.Text or "")
		if current == newText then return end
		local deleteDuration, typeDuration = 0.15, 0.15
		local curLen = #current
		if curLen > 0 then
			local delay = deleteDuration / curLen
			for i = curLen, 1, -1 do
				if titleAnimToken ~= myToken then return end
				titleChannel.Text = string.sub(current, 1, i-1)
				task.wait(delay)
			end
		end
		if titleAnimToken ~= myToken then return end
		task.wait(0.01)
		local newLen = #newText
		if newLen > 0 then
			local delay = typeDuration / newLen
			for i = 1, newLen do
				if titleAnimToken ~= myToken then return end
				titleChannel.Text = string.sub(newText, 1, i)
				task.wait(delay)
			end
		else
			titleChannel.Text = ""
		end
	end
	
	-- button color / hover (unchanged)
	local function refreshButtonColors()
		if btnAI and btnAI:IsA("GuiObject") then btnAI.BackgroundColor3 = COLOR_DEFAULT end
		if btnDeveloper and btnDeveloper:IsA("GuiObject") then btnDeveloper.BackgroundColor3 = COLOR_DEFAULT end
		if activeChannelName == "AI" then
			if btnAI and btnAI:IsA("GuiObject") then btnAI.BackgroundColor3 = COLOR_ACTIVE end
		elseif activeChannelName == "Developer" then
			if btnDeveloper and btnDeveloper:IsA("GuiObject") then btnDeveloper.BackgroundColor3 = COLOR_ACTIVE end
		end
	end
	local hoverStates = { AI = false, Developer = false }
	local function applyHover(button, channelKey)
		if not button or not button:IsA("GuiObject") then return end
		hoverStates[channelKey] = true
		button.BackgroundColor3 = COLOR_HOVER
	end
	local function clearHover(button, channelKey)
		if not button or not button:IsA("GuiObject") then return end
		hoverStates[channelKey] = false
		if activeChannelName == channelKey then
			button.BackgroundColor3 = COLOR_ACTIVE
		else
			button.BackgroundColor3 = COLOR_DEFAULT
		end
	end
	local function attachPointerHandlers(button, channelKey)
		if not button or not button:IsA("GuiObject") then return end
		if button.MouseEnter then button.MouseEnter:Connect(function() applyHover(button, channelKey) end) end
		if button.MouseLeave then button.MouseLeave:Connect(function() clearHover(button, channelKey) end) end
		button.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch then applyHover(button, channelKey) end end)
		button.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch then clearHover(button, channelKey) end end)
	end
	
	-- SET ACTIVE channel (preserve X when adjusting Y) ----------------------------
	local function setActiveChannel(name)
		if not channels[name] then return end
		for k, v in pairs(channels) do
			if v.container then v.container.Visible = (k == name) end
		end
	
		activeChannelName = name
		refreshButtonColors()
	
		-- wait visuals
		if channels[name].isWaiting then
			if waitDot then waitDot.Visible = true end
			startWaitLoopFor(name)
		else
			waitLoopRunning = false
			if waitDot then waitDot.Visible = false end
		end
	
		if doneButton then doneButton.Visible = channels[name].doneVisible == true end
	
		-- If channel has a response stored and doneVisible, tween in.
		local ch = channels[name]
		if ch.doneVisible and ch.chat then
			-- Important: we tween X to visible. This is fine.
			pcall(function() tweenX(ch.chat, 0.1, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out) end)
			-- If we have lastResponse stored, start typing it now (ensure typing token used)
			if ch.lastResponse and ch.chat and ch.chat:FindFirstChild("TextChat") then
				typeTextIntoLabel(ch.chat.TextChat, tostring(ch.lastResponse or ""), TYPING_DURATION, ch)
			end
		end
	
		-- Title animate
		if titleChannel then
			local wanted = (name == "Developer") and "Chat with developer" or "Chat with AI"
			task.spawn(function() animateTitle(wanted) end)
		end
	
		updateSendButtonVisual(checkSendable(chatBox and chatBox.Text or ""))
	end
	
	-- connect tab buttons
	if btnAI then btnAI.MouseButton1Click:Connect(function() setActiveChannel("AI") end) end
	if btnDeveloper then btnDeveloper.MouseButton1Click:Connect(function() setActiveChannel("Developer") end) end
	attachPointerHandlers(btnAI, "AI")
	attachPointerHandlers(btnDeveloper, "Developer")
	
	-- DoneButton reset (preserve X when resetting Y)
	if doneButton then
		doneButton.Visible = false
		if doneFrame then doneFrame.Visible = false end -- << thêm
	
		doneButton:GetPropertyChangedSignal("Visible"):Connect(function()
			-- DoneFrame bật/tắt chung DoneButton
			if doneFrame then
				doneFrame.Visible = doneButton.Visible
			end
	
			updateSendButtonVisual(checkSendable(chatBox and chatBox.Text or ""))
		end)
	
		doneButton.MouseButton1Click:Connect(function()
			local ch = channels[activeChannelName]
			if not ch then return end
			ch.isWaiting = false
			ch.doneVisible = false
			ch.lastResponse = nil
			if ch.waitTween then pcall(function() ch.waitTween:Cancel() end) ch.waitTween = nil end
			if waitDot then waitDot.Visible = false end
			doneButton.Visible = false
			if doneFrame then doneFrame.Visible = false end
	
			-- cancel typing
			ch.typingToken = (ch.typingToken or 0) + 1
	
			-- reset myChat (X preserved)
			if ch.myChat then
				if ch.myChat:FindFirstChild("TextChat") then ch.myChat.TextChat.Text = "" end
				local startYScale = (ch.myChat.Position and ch.myChat.Position.Y.Scale) or 0.1
				local startYOffset = (ch.myChat.Position and ch.myChat.Position.Y.Offset) or 0
				ch.myChat.Position = UDim2.new(1, 0, startYScale, startYOffset)
			end
	
			-- reset bot chat — set hidden X explicitly (we want it hidden after Done)
			if ch.chat then
				if ch.chat:FindFirstChild("TextChat") then ch.chat.TextChat.Text = "" end
				local startYScale = (ch.chat.Position and ch.chat.Position.Y.Scale) or 0.175
				local startYOffset = (ch.chat.Position and ch.chat.Position.Y.Offset) or 0
				ch.chat.Position = UDim2.new(-0.55, 0, startYScale, startYOffset)
			end
	
			updateSendButtonVisual(checkSendable(chatBox and chatBox.Text or ""))
		end)
	end
	
	-- chatBox/send connections
	if chatBox then
		chatBox:GetPropertyChangedSignal("Text"):Connect(function()
			if channels[activeChannelName] and channels[activeChannelName].doneVisible then
				updateSendButtonVisual(false); return
			end
			if channels[activeChannelName] and channels[activeChannelName].isWaiting then
				updateSendButtonVisual(false)
			else
				updateSendButtonVisual(checkSendable(chatBox.Text))
			end
		end)
	
		chatBox.FocusLost:Connect(function(enterPressed)
			if enterPressed and not (channels[activeChannelName] and channels[activeChannelName].isWaiting) and not (channels[activeChannelName] and channels[activeChannelName].doneVisible) and checkSendable(chatBox.Text) then
				-- MOD: If active is Developer, reset Developer first (so manual send also resets then sends)
				if activeChannelName == "Developer" then
					pcall(function() resetChannel("Developer") end)
				end
				doSend(chatBox.Text)
			end
		end)
	end
	
	if sendButton then
		sendButton.MouseButton1Click:Connect(function()
			if channels[activeChannelName] and channels[activeChannelName].doneVisible then return end
			if channels[activeChannelName] and channels[activeChannelName].isWaiting then return end
			if not checkSendable(chatBox and chatBox.Text or "") then return end
			-- MOD: If active is Developer, reset Developer first (manual Send also resets then sends)
			if activeChannelName == "Developer" then
				pcall(function() resetChannel("Developer") end)
			end
			doSend(chatBox.Text)
		end)
	end
	
	-- NEW: receive external SendMyChat commands
	-- We create a BindableFunction (SendMyChat) under chatFrame so other LocalScripts can invoke it.
	-- Also expose _G.SendMyChat as a convenience fallback (note: using _G across separate script environments may not always be reliable; prefer BindableFunction).
	local function _internalHandleIncomingSendMyChat(msg)
		task.spawn(function()
			if not msg then return end
			local trimmed = tostring(msg):match("^%s*(.-)%s*$") or ""
			if #trimmed < 2 then return end
	
			-- MOD: Always allow SendMyChat. Reset Developer channel first to ensure clean state, then send into Developer.
			local target = "Developer"
			local ch = channels[target]
			if not ch then return end
	
			-- reset Developer to clear any previous waiting/done/typing state
			pcall(function() resetChannel(target) end)
	
			-- now send into Developer (will start wait state)
			doSendFor(target, trimmed)
		end)
	end
	
	local sendMyChatFunc = chatFrame:FindFirstChild("SendMyChat")
	if not sendMyChatFunc then
		local ok, fn = pcall(function()
			local f = Instance.new("BindableFunction")
			f.Name = "SendMyChat"
			f.Parent = chatFrame
			return f
		end)
		if ok then sendMyChatFunc = fn end
	end
	if sendMyChatFunc and sendMyChatFunc:IsA("BindableFunction") then
		sendMyChatFunc.OnInvoke = function(msg)
			_internalHandleIncomingSendMyChat(msg)
			return true
		end
	end
	
	_G.SendMyChat = function(msg)
		_internalHandleIncomingSendMyChat(msg)
	end
	
	-- SAFE INITIAL POSITION SET (don't overwrite X on later updates)
	local function safeSetInitialPositions()
		local tokenDev, tokenAI
		if chatDeveloper then tokenDev = temporarilyDisableLayout(chatDeveloper) end
		if chatAI then tokenAI = temporarilyDisableLayout(chatAI) end
		RunService.Heartbeat:Wait()
	
		-- myChat & response default positions (set initial hidden X here)
		if channels.Developer.myChat then
			pcall(function()
				channels.Developer.myChat.Position = UDim2.new(1, 0, (channels.Developer.myChat.Position and channels.Developer.myChat.Position.Y.Scale) or 0.1, (channels.Developer.myChat.Position and channels.Developer.myChat.Position.Y.Offset) or 0)
			end)
		end
		if channels.Developer.chat then
			pcall(function()
				-- initial hidden X
				channels.Developer.chat.Position = UDim2.new(-0.55, 0, (channels.Developer.chat.Position and channels.Developer.chat.Position.Y.Scale) or 0.175, (channels.Developer.chat.Position and channels.Developer.chat.Position.Y.Offset) or 0)
			end)
		end
	
		if channels.AI.myChat then
			pcall(function()
				channels.AI.myChat.Position = UDim2.new(1, 0, (channels.AI.myChat.Position and channels.AI.myChat.Position.Y.Scale) or 0.1, (channels.AI.myChat.Position and channels.AI.myChat.Position.Y.Offset) or 0)
			end)
		end
		if channels.AI.chat then
			pcall(function()
				channels.AI.chat.Position = UDim2.new(-0.55, 0, (channels.AI.chat.Position and channels.AI.chat.Position.Y.Scale) or 0.175, (channels.AI.chat.Position and channels.AI.chat.Position.Y.Offset) or 0)
			end)
		end
	
		restoreLayout(tokenDev)
		restoreLayout(tokenAI)
	end
	
	-- hide wait/done initially
	if waitDot then waitDot.Visible = false end
	if doneButton then doneButton.Visible = false end
	
	safeSetInitialPositions()
	refreshButtonColors()
	if titleChannel then
		local initial = (activeChannelName == "Developer") and "Chat with developer" or "Chat with AI"
		setTitleImmediate(initial)
	end
	
	setActiveChannel(activeChannelName)
	updateSendButtonVisual(checkSendable(chatBox and chatBox.Text or ""))
end
--=== AI CORE SYSTEM ==================================================================================================================================================--

do
	--==========================
	--  AUTO DETECT HTTP REQUEST
	--==========================
	local function HttpRequest(data)
		if syn and syn.request then
			return syn.request(data)
		elseif http and http.request then
			return http.request(data)
		elseif http_request then
			return http_request(data)
		elseif request then
			return request(data)
		elseif fluxus and fluxus.request then
			return fluxus.request(data)
		else
			error("Executor không hỗ trợ HTTP Request!")
		end
	end
	
	--==========================
	--  CONFIG
	--==========================
	local HttpService = game:GetService("HttpService")
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	local playerGui = player and player:FindFirstChild("PlayerGui")
	
	-- Worker URL của bạn
	local AI_URL = "https://chatai.happy37135535.workers.dev"
	
	--==========================
	--  FUNCTION: ASK AI
	--==========================
	local function AskAI(question)
		print("[YOU] Sending:", question)
	
		local payload = {
			message = question
		}
	
		local ok, res = pcall(function()
			return HttpRequest({
				Url = AI_URL,
				Method = "POST",
				Headers = {
					["Content-Type"] = "application/json"
				},
				Body = HttpService:JSONEncode(payload)
			})
		end)
	
		if not ok or not res then
			warn("[AI] Không nhận được phản hồi hoặc request lỗi!")
			return nil
		end
	
		if res.StatusCode ~= 200 then
			warn("[AI] StatusCode:", res.StatusCode)
			warn("[AI] Body:", res.Body)
			return nil
		end
	
		local decoded
		local ok2, dec = pcall(function()
			return HttpService:JSONDecode(res.Body or "{}")
		end)
		if not ok2 then
			warn("[AI] Lỗi decode JSON:", res.Body)
			return nil
		end
		decoded = dec
	
		if not decoded.reply then
			warn("[AI] Response lỗi (không có field 'reply'):", res.Body)
			return nil
		end
	
		return decoded.reply
	end
	
	--==========================
	--  TEST AI SYSTEM (giữ nếu bạn muốn test manual)
	--==========================
	print("====================================")
	print("   HAPPY SCRIPT AI ASSISTANT READY")
	print("====================================")
	
	-- (Tùy chọn) test manual
	-- local answer = AskAI("Hoho Hub là hãng script như nào?, gồm có chức năng gì?")
	-- if answer then
	--     print("====================================")
	--     print("AI Reply:")
	--     print(answer)
	--     print("====================================")
	-- else
	--     warn("AI không trả lời được!")
	-- end
	
	--==========================
	--  LISTENER: lắng nghe MyChatSent và trả reply qua _G.AIChat()
	--==========================
	-- Helper: tìm BindableEvent "MyChatSent" trong PlayerGui descendants (chờ tới khi có)
	local function waitForMyChatEvent()
		if not playerGui then
			-- cố gắng lấy PlayerGui nếu chưa có
			player = Players.LocalPlayer
			playerGui = player and player:WaitForChild("PlayerGui", 2)
		end
	
		local ev = nil
		repeat
			if playerGui then
				for _, v in ipairs(playerGui:GetDescendants()) do
					if v.Name == "MyChatSent" and v:IsA("BindableEvent") then
						ev = v
						break
					end
				end
			end
			if not ev then task.wait(0.05) end
		until ev
		return ev
	end
	
	task.spawn(function()
		local myChatEvent = waitForMyChatEvent()
		if not myChatEvent then
			warn("[AIResponder] Không tìm thấy MyChatSent BindableEvent")
			return
		end
	
		print("[AIResponder] MyChatSent found, listening...")
	
		myChatEvent.Event:Connect(function(channelName, message)
			-- Chỉ xử lý kênh AI — nếu muốn xử lý Developer đổi điều kiện
			if tostring(channelName) ~= "AI" then
				-- bạn có thể uncomment dòng dưới để auto phản hồi developer bằng AI nếu cần
				-- return
				return
			end
	
			-- xử lý async (không block event loop)
			task.spawn(function()
				-- optional: debounce / rate limit nếu muốn (ở đây không có)
				if not message or message == "" then
					warn("[AIResponder] Received empty message")
					return
				end
	
				-- gọi AskAI trong pcall để catch lỗi
				local ok, reply = pcall(AskAI, message)
				if not ok or not reply then
					warn("[AIResponder] AskAI lỗi hoặc không trả về reply")
					-- bạn có thể gửi thông báo lỗi về UI nếu muốn:
					-- if _G and type(_G.AIChat) == "function" then pcall(_G.AIChat, "AI lỗi hoặc không trả lời") end
					return
				end
	
				-- gửi reply trở lại UI bằng _G.AIChat
				if _G and type(_G.AIChat) == "function" then
					pcall(function()
						_G.AIChat(reply)
					end)
				else
					warn("[AIResponder] _G.AIChat không tồn tại để trả lời")
				end
			end)
		end)
	end)
end
