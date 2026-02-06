--=== AutoExChatBox ==================================================================================================================================================--

do
    local Players = game:GetService("Players")
    local TextService = game:GetService("TextService")
    
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    --========================================
    --  FIND UI ROOT
    --========================================
    
    local main = playerGui:WaitForChild("SupportReportGui")
    	:WaitForChild("Main")
    
    local ChatFrame = main:WaitForChild("ChatFrame")
    
    if not ChatFrame or not ChatFrame:IsA("Frame") then
    	warn("Không tìm thấy ChatFrame trong SupportReportGui > Main")
    	return
    end
    
    --========================================
    --  UI REFERENCES
    --========================================
    
    local ExtendButton = ChatFrame:FindFirstChild("ExtendButton")
    local ChatBox = ChatFrame:FindFirstChild("ChatBox")
    
    local MAX_CHARS = 225
    
    if not ExtendButton then warn("ExtendButton không tìm thấy dưới ChatFrame") end
    if not ChatBox then warn("ChatBox không tìm thấy dưới ChatFrame") end
    
    local Icon = ExtendButton and ExtendButton:FindFirstChild("Icon")
    if not Icon then warn("Icon không tìm thấy trong ExtendButton") end
    
    --========================================
    --  FIND ChatFrameExtend (optional)
    --========================================
    
    local ChatFrameExtend = main:FindFirstChild("ChatFrameExtend", true)
    
    if not ChatFrameExtend then
    	warn("Không tìm thấy ChatFrameExtend trong Main (recursive)")
    end
    
    --========================================
    --  STATE
    --========================================
    
    local isExtended = false
    local autoExtended = false
    
    --========================================
    --  APPLY STATE
    --========================================
    
    local function applyState(state)
    	isExtended = state and true or false
    
    	-- Button Color
    	if Icon and ExtendButton then
    		if isExtended then
    			Icon.ImageColor3 = Color3.fromRGB(0, 0, 0)
    			ExtendButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    		else
    			Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    			ExtendButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    		end
    	end
    
    	-- ChatBox Expand
    	if ChatBox then
    		ChatBox.AnchorPoint = Vector2.new(0.5, 0.5)
    
    		if isExtended then
    			ChatBox.Size = UDim2.new(0.8, 0, 4.5, 0)
    			ChatBox.Position = UDim2.new(0.5, 0, -1.5, 0)
    			ChatBox.TextYAlignment = Enum.TextYAlignment.Top
    
    			if ChatFrameExtend then
    				ChatFrameExtend.Visible = true
    			end
    		else
    			ChatBox.Size = UDim2.new(0.8, 0, 1, 0)
    			ChatBox.Position = UDim2.new(0.5, 0, 0.5, 0)
    			ChatBox.TextYAlignment = Enum.TextYAlignment.Center
    
    			if ChatFrameExtend then
    				ChatFrameExtend.Visible = false
    			end
    		end
    	end
    end
    
    --========================================
    --  MANUAL TOGGLE
    --========================================
    
    local function tryToggleManual()
    	autoExtended = false
    	applyState(not isExtended)
    end
    
    if ExtendButton and ExtendButton:IsA("GuiButton") then
    	ExtendButton.MouseButton1Click:Connect(tryToggleManual)
    end
    
    --========================================
    --  MULTI LINE CHECK
    --========================================
    
    local function textNeedsMultipleLines(text)
    	if not ChatBox then return false end
    
    	if string.find(text, "\n") then
    		return true
    	end
    
    	if ChatBox.AbsoluteSize.X <= 1 then
    		return false
    	end
    
    	local font = ChatBox.Font
    	local fontSize = ChatBox.TextSize
    
    	local constraint = Vector2.new(ChatBox.AbsoluteSize.X, math.huge)
    
    	local ok, result = pcall(function()
    		return TextService:GetTextSize(text, fontSize, font, constraint)
    	end)
    
    	if not ok or not result then
    		return false
    	end
    
    	local _, oneLine = pcall(function()
    		return TextService:GetTextSize("A", fontSize, font, Vector2.new(9999, 9999))
    	end)
    
    	local lineHeight = oneLine and oneLine.Y or fontSize
    	local lines = math.max(1, math.floor((result.Y + lineHeight * 0.5) / lineHeight))
    
    	return lines > 1
    end
    
    --========================================
    --  ENFORCE LIMIT + AUTO WRAP
    --========================================
    
    local function enforceTextLimitsAndWrap(text)
    	if #text > MAX_CHARS then
    		text = string.sub(text, 1, MAX_CHARS)
    		ChatBox.Text = text
    	end
    
    	local multi = textNeedsMultipleLines(text)
    
    	if multi then
    		if not isExtended then
    			autoExtended = true
    			applyState(true)
    		end
    	else
    		if autoExtended and isExtended then
    			autoExtended = false
    			applyState(false)
    		end
    	end
    end
    
    --========================================
    --  DEBOUNCE UPDATE
    --========================================
    
    local debounce = false
    
    local function scheduleUpdate()
    	if debounce then return end
    	debounce = true
    
    	task.defer(function()
    		task.wait(0.06)
    
    		if ChatBox then
    			enforceTextLimitsAndWrap(ChatBox.Text)
    		end
    
    		debounce = false
    	end)
    end
    
    --========================================
    --  LISTEN EVENTS
    --========================================
    
    if ChatBox then
    	ChatBox:GetPropertyChangedSignal("Text"):Connect(scheduleUpdate)
    	ChatBox:GetPropertyChangedSignal("AbsoluteSize"):Connect(scheduleUpdate)
    
    	scheduleUpdate()
    end
    
    --========================================
    --  INIT DEFAULT CLOSED
    --========================================
    
    applyState(false)
    
    print("[ChatFrame Extend] Loaded successfully in PlayerScripts!")
end

--=== AutoScaleSetChat ==================================================================================================================================================--

do
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local TextService = game:GetService("TextService")
    
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    --========================================
    --  UI PATH
    --========================================
    
    local main = playerGui:WaitForChild("SupportReportGui")
    	:WaitForChild("Main")
    
    -- 2 roots nằm trong Main
    local ChatDeveloper = main:WaitForChild("ChatDeveloper")
    local ChatAI = main:WaitForChild("ChatAI")
    
    --========================================
    --  CONFIG
    --========================================
    
    local TWEEN_TIME = 0.18
    local EASING = Enum.EasingStyle.Sine
    local EASING_DIR = Enum.EasingDirection.Out
    
    --========================================
    --  TWEEN HELPER
    --========================================
    
    local function tween(instance, properties, time)
    	local info = TweenInfo.new(time or TWEEN_TIME, EASING, EASING_DIR)
    	local tw = TweenService:Create(instance, info, properties)
    	tw:Play()
    	return tw
    end
    
    --========================================
    --  LINE CALC
    --========================================
    
    local function calcLinesFrom(textObj)
    	local text = tostring(textObj.Text or "")
    	if text == "" then return 1 end
    
    	local width = math.max(1, textObj.AbsoluteSize.X)
    
    	local size = TextService:GetTextSize(
    		text,
    		textObj.TextSize,
    		textObj.Font,
    		Vector2.new(width, math.huge)
    	)
    
    	local approxLineH = textObj.TextSize * 1.2
    	return math.max(1, math.ceil(size.Y / approxLineH))
    end
    
    --========================================
    --  RESIZE FUNCTION
    --========================================
    
    local function resizeChat(bg, textObj, lines)
    	local targetY = 1 + (lines - 1) * 0.5
    	local size = UDim2.new(1, 0, targetY, 0)
    
    	tween(bg, { Size = size })
    	tween(textObj, { Size = size })
    end
    
    --========================================
    --  APPLY SYSTEM FOR ONE ROOT
    --========================================
    
    local function SetupChat(root)
    	print("[SupportChat] Setup:", root.Name)
    
    	-- MyChat (user)
    	local myChat = root:WaitForChild("MyChat")
    	local bgFrame = myChat:WaitForChild("BackGroundFrame")
    	local avatarImg = myChat:WaitForChild("Avatar")
    	local textChat = myChat:WaitForChild("TextChat")
    
    	-- DevChat hoặc AIChat
    	local botChat =
    		root:FindFirstChild("DevChat")
    		or root:FindFirstChild("AIChat")
    
    	if not botChat then
    		warn("[SupportChat] Không tìm thấy DevChat/AIChat trong:", root.Name)
    		return
    	end
    
    	local botBg = botChat:WaitForChild("BackGroundFrame")
    	local botText = botChat:WaitForChild("TextChat")
    
    	-- Save initial values
    	local initialBgSize = bgFrame.Size
    	local initialTextSize = textChat.Size
    	local initialBotPos = botChat.Position
    
    	--====================================
    	--  AVATAR LOAD
    	--====================================
    
    	local function setAvatar()
    		local userId = player.UserId
    
    		task.spawn(function()
    			for i = 1, 10 do
    				local ok, content, ready = pcall(function()
    					return Players:GetUserThumbnailAsync(
    						userId,
    						Enum.ThumbnailType.HeadShot,
    						Enum.ThumbnailSize.Size352x352
    					)
    				end)
    
    				if ok and ready and content then
    					avatarImg.Image = content
    					print("[SupportChat] Avatar Loaded:", root.Name)
    					return
    				end
    
    				task.wait(0.3)
    			end
    
    			warn("[SupportChat] Avatar Load Failed:", root.Name)
    		end)
    	end
    
    	--====================================
    	--  UPDATE MYCHAT
    	--====================================
    
    	local lastMyLines = 0
    
    	local function updateMyChat()
    		if textChat.AbsoluteSize.X <= 1 then return end
    
    		local lines = calcLinesFrom(textChat)
    		if lines == lastMyLines then return end
    		lastMyLines = lines
    
    		-- Resize user bubble
    		resizeChat(bgFrame, textChat, lines)
    
    		-- Push bot bubble down
    		local base = initialBotPos
    		local newY = base.Y.Scale + (lines - 1) * 0.025
    
    		tween(botChat, {
    			Position = UDim2.new(
    				base.X.Scale, base.X.Offset,
    				newY, base.Y.Offset
    			)
    		})
    	end
    
    	--====================================
    	--  UPDATE BOT CHAT
    	--====================================
    
    	local lastBotLines = 0
    
    	local function updateBotChat()
    		if botText.AbsoluteSize.X <= 1 then return end
    
    		local lines = calcLinesFrom(botText)
    		if lines == lastBotLines then return end
    		lastBotLines = lines
    
    		resizeChat(botBg, botText, lines)
    	end
    
    	--====================================
    	--  CONNECT EVENTS
    	--====================================
    
    	textChat:GetPropertyChangedSignal("Text"):Connect(updateMyChat)
    	textChat:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateMyChat)
    	textChat:GetPropertyChangedSignal("TextSize"):Connect(updateMyChat)
    	textChat:GetPropertyChangedSignal("Font"):Connect(updateMyChat)
    
    	botText:GetPropertyChangedSignal("Text"):Connect(updateBotChat)
    	botText:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateBotChat)
    	botText:GetPropertyChangedSignal("TextSize"):Connect(updateBotChat)
    	botText:GetPropertyChangedSignal("Font"):Connect(updateBotChat)
    
    	--====================================
    	--  INIT
    	--====================================
    
    	task.spawn(function()
    		task.wait(0.5)
    		setAvatar()
    	end)
    
    	bgFrame.Size = initialBgSize
    	textChat.Size = initialTextSize
    	botChat.Position = initialBotPos
    
    	print("[SupportChat] Ready:", root.Name)
    end
    
    --========================================
    --  START BOTH ROOTS
    --========================================
    
    SetupChat(ChatDeveloper)
    SetupChat(ChatAI)
end

--=== END ==================================================================================================================================================--
