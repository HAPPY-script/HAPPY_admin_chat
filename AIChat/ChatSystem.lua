local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- UI Path mới:
local mainFrame = playerGui:WaitForChild("SupportReportGui")
	:WaitForChild("Main")

local chatFrame = mainFrame:WaitForChild("ChatFrame")

print("[UI] Loaded ChatFrame from PlayerGui.SupportReportGui.Main.ChatFrame")

-- core UI (global trong ChatFrame)
local chatBox    = chatFrame:FindFirstChild("ChatBox")
local sendButton = chatFrame:FindFirstChild("SendButton")
local waitDot    = chatFrame:FindFirstChild("WaitDot")
local doneButton = chatFrame:FindFirstChild("DoneButton")

-- tìm ChatDeveloper và ChatAI trong parent của ChatFrame
local parentContainer = chatFrame.Parent
local chatDeveloper = parentContainer and parentContainer:FindFirstChild("ChatDeveloper")
local chatAI        = parentContainer and parentContainer:FindFirstChild("ChatAI")

-- tìm hai nút chuyển kênh và title ở script.Parent.Parent
local panelParent = mainFrame
local btnAI        = panelParent and panelParent:FindFirstChild("AI")
local btnDeveloper = panelParent and panelParent:FindFirstChild("Developer")
local titleChannel = panelParent and panelParent:FindFirstChild("TitleChannel")

-- warn nếu thiếu
if not (chatBox and sendButton) then
	warn("Không tìm thấy ChatBox hoặc SendButton trong ChatFrame")
end
if not chatDeveloper then warn("Không tìm thấy ChatDeveloper") end
if not chatAI then warn("Không tìm thấy ChatAI") end
if not btnAI or not btnDeveloper then warn("Không tìm thấy nút 'AI' hoặc 'Developer' ở script.Parent.Parent") end
if not titleChannel then warn("Không tìm thấy TitleChannel ở script.Parent.Parent — title sẽ không animate") end

local myChatEvent = nil
do
	myChatEvent = chatFrame:FindFirstChild("MyChatSent")
	if not myChatEvent then
		local ok, ev = pcall(function()
			local e = Instance.new("BindableEvent")
			e.Name = "MyChatSent"
			e.Parent = chatFrame
			return e
		end)
		if ok then
			myChatEvent = ev
		end
	end
end

-- helper tìm con Icon
local function findIcon(parent)
	if not parent then return nil end
	for _, v in ipairs(parent:GetDescendants()) do
		if v.Name == "Icon" and (v:IsA("ImageLabel") or v:IsA("ImageButton")) then
			return v
		end
	end
	return nil
end

-- tween helpers
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

-- trạng thái & cấu trúc kênh
local channels = {
	Developer = {
		container = chatDeveloper,
		myChat = chatDeveloper and chatDeveloper:FindFirstChild("MyChat"),
		chat  = chatDeveloper and chatDeveloper:FindFirstChild("DevChat"),
		isWaiting = false,
		doneVisible = false,
		lastResponse = nil,
		waitTween = nil
	},
	AI = {
		container = chatAI,
		myChat = chatAI and chatAI:FindFirstChild("MyChat"),
		chat  = chatAI and chatAI:FindFirstChild("AIChat"),
		isWaiting = false,
		doneVisible = false,
		lastResponse = nil,
		waitTween = nil
	}
}

-- UI color config
local COLOR_DEFAULT = Color3.fromRGB(24,24,24)
local COLOR_ACTIVE  = Color3.fromRGB(35,35,35)
local COLOR_HOVER   = Color3.fromRGB(70,70,70)

local disabledBg = Color3.fromRGB(35, 35, 35)
local disabledIconColor = Color3.fromRGB(255, 255, 255)
local enabledBg = Color3.fromRGB(255, 255, 255)
local enabledIconColor = Color3.fromRGB(0, 0, 0)

-- hiện kênh mặc định
local activeChannelName = (chatDeveloper and "Developer") or (chatAI and "AI") or "Developer"

-- hàm kiểm tra text đủ điều kiện gửi
local function checkSendable(text)
	if not text then return false end
	local trimmed = text:match("^%s*(.-)%s*$") or ""
	return #trimmed >= 2
end

-- cập nhật màu icon
local function setIconColor(canSend)
	local icon = findIcon(sendButton)
	if icon then
		icon.ImageColor3 = canSend and enabledIconColor or disabledIconColor
	end
end

-- cập nhật send button dựa theo trạng thái kênh active
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

-- wait animation runner (chỉ chạy cho channel active)
local waitLoopRunning = false
local function startWaitLoopFor(channelName)
	local ch = channels[channelName]
	if not ch then return end
	ch.isWaiting = true
	ch.doneVisible = false
	-- nếu đây kênh active thì hiển thị waitDot và bắt loop
	if channelName == activeChannelName then
		if waitDot then waitDot.Visible = true end
		updateSendButtonVisual(false)
		if waitLoopRunning then return end
		waitLoopRunning = true
		-- animate pulsing
		task.spawn(function()
			local small = UDim2.new(0.25, 0, 0.25, 0)
			local big   = UDim2.new(0.4, 0, 0.4, 0)
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
			-- cleanup
			if ch.waitTween then pcall(function() ch.waitTween:Cancel() end) ch.waitTween = nil end
			if waitDot then waitDot.Visible = false end
			waitLoopRunning = false
		end)
	end
end

local function stopWaitFor(channelName, responseText)
	local ch = channels[channelName]
	if not ch then return end
	ch.isWaiting = false
	ch.lastResponse = responseText
	ch.doneVisible = true

	-- đặt text nội bộ luôn (dù kênh không active) và đặt vị trí ban đầu trước khi tween
	if ch.chat and ch.chat:FindFirstChild("TextChat") then
		ch.chat.TextChat.Text = tostring(responseText or "")
		local startYScale = (ch.chat.Position and ch.chat.Position.Y.Scale) or 0.175
		local startYOffset = (ch.chat.Position and ch.chat.Position.Y.Offset) or 0
		ch.chat.Position = UDim2.new(-0.55, 0, startYScale, startYOffset)
	end

	-- nếu kênh active thì tween vào và show DoneButton, ngược lại giữ ẩn
	if channelName == activeChannelName then
		if ch.chat then
			tweenX(ch.chat, 0.1, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		end
		if doneButton then doneButton.Visible = true end
		-- dừng wait loop nếu đang chạy
		waitLoopRunning = false
		if ch.waitTween then pcall(function() ch.waitTween:Cancel() end) ch.waitTween = nil end
	end

	updateSendButtonVisual(checkSendable(chatBox and chatBox.Text or ""))
end

-- public exposure for other scripts
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

local function doSend(message)
	if not message then return end
	local trimmed = message:match("^%s*(.-)%s*$") or ""
	if #trimmed < 2 then return end

	-- clear box
	if chatBox then chatBox.Text = "" end

	local ch = channels[activeChannelName]
	if ch and ch.myChat and ch.myChat:FindFirstChild("TextChat") then
		local t = ch.myChat.TextChat
		t.Text = tostring(trimmed)
		local startYScale = (ch.myChat.Position and ch.myChat.Position.Y.Scale) or 0.1
		local startYOffset = (ch.myChat.Position and ch.myChat.Position.Y.Offset) or 0
		ch.myChat.Position = UDim2.new(1, 0, startYScale, startYOffset)
		tweenX(ch.myChat, 0.35, 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	end

	-- FIRE event để LocalScript client khác xử lý (channelName, message)
	if myChatEvent and myChatEvent:IsA("BindableEvent") then
		-- pcall để tránh lỗi làm dừng UI nếu listener lỗi
		pcall(function()
			myChatEvent:Fire(activeChannelName, trimmed)
		end)
	end

	startWaitLoopFor(activeChannelName)
end

-- chuyển kênh (AI <-> Developer)
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

-- ---------- Title animation (delete then type) ----------
-- animation token to cancel previous runs
local titleAnimToken = 0

-- safe set text (immediate)
local function setTitleImmediate(text)
	if not titleChannel then return end
	if not titleChannel:IsA("TextLabel") and not titleChannel:IsA("TextBox") then
		-- try to set Text property anyway
		pcall(function() titleChannel.Text = text end)
		return
	end
	titleChannel.Text = text
end

-- animate: delete current text char-by-char then type new text char-by-char
-- total durations: deleteDuration + typeDuration = 0.3s (split evenly)
local function animateTitle(newText)
	if not titleChannel then return end
	titleAnimToken = titleAnimToken + 1
	local myToken = titleAnimToken

	local current = tostring(titleChannel.Text or "")
	-- if same text, do nothing
	if current == newText then return end

	local deleteDuration = 0.15
	local typeDuration = 0.15

	-- delete phase
	local curLen = #current
	if curLen > 0 then
		local delay = deleteDuration / curLen
		for i = curLen, 1, -1 do
			if titleAnimToken ~= myToken then return end
			local sub = string.sub(current, 1, i-1)
			titleChannel.Text = sub
			task.wait(delay)
		end
	end

	-- short pause (very small) to make transition visible
	if titleAnimToken ~= myToken then return end
	task.wait(0.01)

	-- type phase
	local newLen = #newText
	if newLen > 0 then
		local delay = typeDuration / newLen
		for i = 1, newLen do
			if titleAnimToken ~= myToken then return end
			local sub = string.sub(newText, 1, i)
			titleChannel.Text = sub
			task.wait(delay)
		end
	else
		-- if newText empty, ensure cleared
		titleChannel.Text = ""
	end
end

-- ---------- Button color / hover handling ----------
-- helper to set base colors for both buttons (call when state changes)
local function refreshButtonColors()
	-- default both to default color
	if btnAI and btnAI:IsA("GuiObject") then btnAI.BackgroundColor3 = COLOR_DEFAULT end
	if btnDeveloper and btnDeveloper:IsA("GuiObject") then btnDeveloper.BackgroundColor3 = COLOR_DEFAULT end

	-- set active
	if activeChannelName == "AI" then
		if btnAI and btnAI:IsA("GuiObject") then btnAI.BackgroundColor3 = COLOR_ACTIVE end
	elseif activeChannelName == "Developer" then
		if btnDeveloper and btnDeveloper:IsA("GuiObject") then btnDeveloper.BackgroundColor3 = COLOR_ACTIVE end
	end
end

-- hover state trackers to avoid race/conflict with active color
local hoverStates = { AI = false, Developer = false }

local function applyHover(button, channelKey)
	if not button or not button:IsA("GuiObject") then return end
	hoverStates[channelKey] = true
	button.BackgroundColor3 = COLOR_HOVER
end

local function clearHover(button, channelKey)
	if not button or not button:IsA("GuiObject") then return end
	hoverStates[channelKey] = false
	-- restore color: if active channel -> active color else default
	if activeChannelName == channelKey then
		button.BackgroundColor3 = COLOR_ACTIVE
	else
		button.BackgroundColor3 = COLOR_DEFAULT
	end
end

-- attach hover & touch handlers safely
local function attachPointerHandlers(button, channelKey)
	if not button or not button:IsA("GuiObject") then return end

	-- MouseEnter / MouseLeave (desktop)
	if button.MouseEnter then
		button.MouseEnter:Connect(function()
			applyHover(button, channelKey)
		end)
	end
	if button.MouseLeave then
		button.MouseLeave:Connect(function()
			clearHover(button, channelKey)
		end)
	end

	-- Touch / Input for mobile: set hover on InputBegan.Touch and clear on InputEnded.Touch
	button.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			applyHover(button, channelKey)
		end
	end)
	button.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			clearHover(button, channelKey)
		end
	end)
end

-- ---------- setActiveChannel (extended: update title & button colors) ----------
local function setActiveChannel(name)
	if not channels[name] then return end
	-- set visibility of containers
	for k, v in pairs(channels) do
		if v.container then
			v.container.Visible = (k == name)
		end
	end

	activeChannelName = name

	-- update button colors
	refreshButtonColors()

	-- manage wait visuals: if active channel is waiting => show waitDot and block send; else hide waitDot
	if channels[name].isWaiting then
		if waitDot then waitDot.Visible = true end
		-- start wait loop animation
		startWaitLoopFor(name)
	else
		-- stop global wait loop if any
		waitLoopRunning = false
		if waitDot then waitDot.Visible = false end
	end

	-- manage DoneButton: only show if active channel has doneVisible true
	if doneButton then
		doneButton.Visible = channels[name].doneVisible == true
	end

	-- if the channel already has a lastResponse and doneVisible true but we switched back, ensure its chat tweened in (so user sees it)
	local ch = channels[name]
	if ch.doneVisible and ch.chat then
		pcall(function()
			tweenX(ch.chat, 0.1, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		end)
	end

	-- animate TitleChannel text
	if titleChannel then
		local wanted = (name == "Developer") and "Chat with developer" or "Chat with AI"
		-- run animation in task to avoid blocking
		task.spawn(function()
			animateTitle(wanted)
		end)
	end

	-- update send button according to active channel's state & chatBox content
	updateSendButtonVisual(checkSendable(chatBox and chatBox.Text or ""))	
end

-- nút chuyển kênh click handlers
if btnAI then
	btnAI.MouseButton1Click:Connect(function()
		setActiveChannel("AI")
	end)
end
if btnDeveloper then
	btnDeveloper.MouseButton1Click:Connect(function()
		setActiveChannel("Developer")
	end)
end

-- attach pointer handlers to both buttons (safe even if nil)
attachPointerHandlers(btnAI, "AI")
attachPointerHandlers(btnDeveloper, "Developer")

-- DoneButton reset (chỉ reset kênh active)
if doneButton then
	doneButton.Visible = false
	doneButton:GetPropertyChangedSignal("Visible"):Connect(function()
		-- khi Visible thay đổi, cập nhật send button
		updateSendButtonVisual(checkSendable(chatBox and chatBox.Text or ""))
	end)

	doneButton.MouseButton1Click:Connect(function()
		local ch = channels[activeChannelName]
		-- stop wait and hide effects
		ch.isWaiting = false
		ch.doneVisible = false
		ch.lastResponse = nil
		if ch.waitTween then pcall(function() ch.waitTween:Cancel() end) ch.waitTween = nil end
		if waitDot then waitDot.Visible = false end
		doneButton.Visible = false

		-- reset myChat & response chat positions/texts for this channel only
		if ch.myChat then
			if ch.myChat:FindFirstChild("TextChat") then ch.myChat.TextChat.Text = "" end
			local startYScale = (ch.myChat.Position and ch.myChat.Position.Y.Scale) or 0.1
			local startYOffset = (ch.myChat.Position and ch.myChat.Position.Y.Offset) or 0
			ch.myChat.Position = UDim2.new(1, 0, startYScale, startYOffset)
		end
		if ch.chat then
			if ch.chat:FindFirstChild("TextChat") then ch.chat.TextChat.Text = "" end
			local startYScale = (ch.chat.Position and ch.chat.Position.Y.Scale) or 0.175
			local startYOffset = (ch.chat.Position and ch.chat.Position.Y.Offset) or 0
			ch.chat.Position = UDim2.new(-0.55, 0, startYScale, startYOffset)
		end

		updateSendButtonVisual(checkSendable(chatBox and chatBox.Text or ""))
	end)
end

-- kết nối chatBox và sendButton
if chatBox then
	chatBox:GetPropertyChangedSignal("Text"):Connect(function()
		-- nếu active channel có doneVisible => luôn disable
		if channels[activeChannelName] and channels[activeChannelName].doneVisible then
			updateSendButtonVisual(false)
			return
		end
		-- nếu active channel đang chờ => disable
		if channels[activeChannelName] and channels[activeChannelName].isWaiting then
			updateSendButtonVisual(false)
		else
			updateSendButtonVisual(checkSendable(chatBox.Text))
		end
	end)

	chatBox.FocusLost:Connect(function(enterPressed)
		if enterPressed and not (channels[activeChannelName] and channels[activeChannelName].isWaiting) and not (channels[activeChannelName] and channels[activeChannelName].doneVisible) and checkSendable(chatBox.Text) then
			doSend(chatBox.Text)
		end
	end)
end

if sendButton then
	sendButton.MouseButton1Click:Connect(function()
		-- if active channel has doneVisible -> block
		if channels[activeChannelName] and channels[activeChannelName].doneVisible then return end
		if channels[activeChannelName] and channels[activeChannelName].isWaiting then return end
		if not checkSendable(chatBox and chatBox.Text or "") then return end
		doSend(chatBox.Text)
	end)
end

-- INIT: an toàn set vị trí ban đầu (tắt layout tạm để set Position)
local function safeSetInitialPositions()
	local tokenDev, tokenAI
	if chatDeveloper then tokenDev = temporarilyDisableLayout(chatDeveloper) end
	if chatAI then tokenAI = temporarilyDisableLayout(chatAI) end
	RunService.Heartbeat:Wait()

	-- myChat & response default positions
	if channels.Developer.myChat then
		pcall(function()
			channels.Developer.myChat.Position = UDim2.new(1, 0, (channels.Developer.myChat.Position and channels.Developer.myChat.Position.Y.Scale) or 0.1, (channels.Developer.myChat.Position and channels.Developer.myChat.Position.Y.Offset) or 0)
		end)
	end
	if channels.Developer.chat then
		pcall(function()
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

-- hide waitDot/done initially
if waitDot then waitDot.Visible = false end
if doneButton then doneButton.Visible = false end

safeSetInitialPositions()

-- initial button colors and title
refreshButtonColors()
if titleChannel then
	-- set initial title immediately (no animation on first load)
	local initial = (activeChannelName == "Developer") and "Chat with developer" or "Chat with AI"
	setTitleImmediate(initial)
end

-- set active channel visible
setActiveChannel(activeChannelName)

-- update send button initially
updateSendButtonVisual(checkSendable(chatBox and chatBox.Text or ""))
