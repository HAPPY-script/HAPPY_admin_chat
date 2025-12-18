-- System.lua (refactor)
-- Giữ nguyên logic gốc, chỉ tái cấu trúc để dễ bảo trì

--------------------------------------------------------
-- SERVICES & UTILITIES
--------------------------------------------------------
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer

-- Safely get executors' http request
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
		error("Executor không hỗ trợ http request!")
	end
end

--------------------------------------------------------
-- CONFIG / MAPPING
--------------------------------------------------------
local ScriptMapping = {

	-- GameHud --
	BloxFruit = function()
		local code = game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/BLOX_FRUIT/main/BLOX_FRUIT.lua")
		loadstring(code)()
	end,
	ZombieStories = function()
		local code = game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/ZOMBIE_STORIES/refs/heads/main/ZOMBIE_STORIES")
		loadstring(code)()
	end,
	MM2 = function()
		local code = game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/Muder-Mystery-2/refs/heads/main/Muder%20Mystery%202")
		loadstring(code)()
	end,
	DeadRails = function()
		local code = game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/DEAD_RAILS/refs/heads/main/DEAD_RAILS")
		loadstring(code)()
	end,
	GunfightArena = function()
		local code = game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/Gunfight_Arena/refs/heads/main/Gunfight_Arena.lua")
		loadstring(code)()
	end,

	-- Character --
	Fly = function()
		local code = game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/FLY/refs/heads/main/FLY")
		loadstring(code)()
	end,
	IfnJump = function()
		local code = game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/IFN_JUMP/refs/heads/main/IFN_JUMP")
		loadstring(code)()
	end,
	Explorer = function()
		local code = game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/FILE_GAME/refs/heads/main/FILE_GAME")
		loadstring(code)()
	end,
	HitBox = function()
		local code = game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/HIT_BOX/refs/heads/main/HIT_BOX.lua")
		loadstring(code)()
	end,
	Speed = function()
		local code = game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/SPEED/refs/heads/main/SPEED.lua")
		loadstring(code)()
	end,
	ESP = function()
		local code = game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/ESP/refs/heads/main/ESP.lua")
		loadstring(code)()
	end,
	CameraViewer = function()
		local code = game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/Camera_Viewer/refs/heads/main/System.lua")
		loadstring(code)()
	end,
}

--------------------------------------------------------
-- UI SELECTORS
--------------------------------------------------------
local gui = player:WaitForChild("PlayerGui"):WaitForChild("HAPPYscript")
local main = gui:WaitForChild("Main")
local scroll = main:WaitForChild("ScrollingFrame")
local toggleButton = gui:WaitForChild("Button")

-- Tab buttons (header)
local btnCharacter = main:WaitForChild("Character")
local btnGameHub = main:WaitForChild("GameHub")
local btnVisuals = main:WaitForChild("System")

-- Tab frames (content)
local frameCharacter = scroll:WaitForChild("Character")
local frameGameHub = scroll:WaitForChild("GameHub")
local frameVisuals = scroll:WaitForChild("System")

local allFrames = {
	Character = frameCharacter,
	GameHub = frameGameHub,
	Visuals = frameVisuals
}

-- Noti GUI + components (Firebase/Noti section dùng nhiều)
local Noti = gui:WaitForChild("Noti")
local Noti_Logo = Noti:WaitForChild("Logo")
local Noti_Return1 = Noti:WaitForChild("Return1")
local Noti_ReturnIfn = Noti:WaitForChild("ReturnIfn")
local Noti_Back = Noti:WaitForChild("Back")
local Noti_Done = Noti:WaitForChild("Done")
local Noti_Name = Noti:FindFirstChild("Name") or (Noti_Logo:FindFirstChild("Name") and Noti_Logo:FindFirstChild("Name"))
if not Noti_Name then
	Noti_Name = Instance.new("TextLabel")
	Noti_Name.Size = UDim2.new(1,0,0,20)
	Noti_Name.BackgroundTransparency = 1
	Noti_Name.Text = ""
	Noti_Name.Parent = Noti
end

--------------------------------------------------------
-- UI / TWEEN CONSTANTS
--------------------------------------------------------
local startSize = UDim2.new(0.01, 0, 0.01, 0)
local idleSize = UDim2.new(0.25, 0, 0.25, 0)
local hoverSize = UDim2.new(0.275, 0, 0.275, 0)

local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local fastInfo = TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local openSize = UDim2.new(0.75, 0, 0.75, 0)
local closeSize = UDim2.new(0.025, 0, 0.025, 0)

local menuOpen = false

--------------------------------------------------------
-- LOADING SPINNER (safe, GC-friendly)
--------------------------------------------------------
local loadingConns = setmetatable({}, { __mode = "k" }) -- weak-keyed by loadingFrame

local function findSpinnerImage(loadingFrame)
	if not loadingFrame then return nil end
	local img = loadingFrame:FindFirstChildOfClass("ImageLabel")
	if img then return img end
	for _, v in ipairs(loadingFrame:GetDescendants()) do
		if v:IsA("ImageLabel") then return v end
	end
	return nil
end

local function startLoading(btn)
	if not btn or not btn.Parent then return end
	local loadingFrame = btn:FindFirstChild("Loading")
	if not loadingFrame then return end

	-- nếu đã đang loading thì show và return
	if loadingConns[loadingFrame] then
		loadingFrame.Visible = true
		return
	end

	local img = findSpinnerImage(loadingFrame)
	if img then
		img.Rotation = 0
		loadingFrame.Visible = true
		local conn = RunService.Heartbeat:Connect(function(dt)
			img.Rotation = (img.Rotation + 360 * dt) % 360
		end)
		loadingConns[loadingFrame] = conn
	else
		loadingFrame.Visible = true
	end
end

local function stopLoading(btn)
	if not btn then return end
	local loadingFrame = btn:FindFirstChild("Loading")
	if not loadingFrame then return end

	local conn = loadingConns[loadingFrame]
	if conn then
		pcall(function() conn:Disconnect() end)
		loadingConns[loadingFrame] = nil
	end

	local img = findSpinnerImage(loadingFrame)
	if img then img.Rotation = 0 end
	loadingFrame.Visible = false
end

--------------------------------------------------------
-- FIREBASE HELPERS + NOTI CONTROLS
--------------------------------------------------------
local PROJECT_URL = "https://happy-script-bada6-default-rtdb.asia-southeast1.firebasedatabase.app/users/"
local URL = PROJECT_URL .. tostring(player.UserId) .. ".json"

local function safeDecode(body)
	if not body or body == "null" or body == "" then return nil end
	local ok, decoded = pcall(function() return HttpService:JSONDecode(body) end)
	if ok and type(decoded) == "table" then return decoded end
	return nil
end

local function firebaseGet()
	local ok, res = pcall(function() return HttpRequest({Url = URL, Method = "GET"}) end)
	if not ok or not res then
		warn("[Firebase] GET request failed:", res)
		return { returns = { once = {}, forever = {} } }
	end

	local body = res.Body or res.body or res.Response or res
	local status = res.StatusCode or res.status or (res.Success and 200) or 0

	if type(body) ~= "string" then
		if res.Body then body = res.Body
		elseif res.body then body = res.body
		elseif res.Response then body = res.Response
		else body = tostring(res)
		end
	end

	if status < 200 or status >= 300 then
		if status == 404 or body == "null" then
			return { returns = { once = {}, forever = {} } }
		else
			warn("[Firebase] GET status:", status, body)
			return { returns = { once = {}, forever = {} } }
		end
	end

	local data = safeDecode(body)
	if not data then
		return { returns = { once = {}, forever = {} } }
	end

	data.returns = data.returns or {}
	data.returns.once = data.returns.once or {}
	data.returns.forever = data.returns.forever or {}
	return data
end

local function firebaseSetFull(userData)
	local okEnc, enc = pcall(function() return HttpService:JSONEncode(userData) end)
	if not okEnc then
		warn("[Firebase] JSONEncode failed:", enc)
		return false
	end

	local okReq, res = pcall(function()
		return HttpRequest({
			Url = URL,
			Method = "PUT",
			Headers = { ["Content-Type"] = "application/json" },
			Body = enc
		})
	end)

	if not okReq or not res then
		warn("[Firebase] PUT request failed:", res)
		return false
	end

	local status = res.StatusCode or res.status or 0
	if status >= 200 and status < 300 then
		return true
	end

	warn("[Firebase] PUT returned status:", status, res)
	return false
end

local function setOnceFlag(scriptName, enabled)
	local data = firebaseGet()
	data.returns = data.returns or { once = {}, forever = {} }
	if enabled then
		data.returns.once[scriptName] = true
		if data.returns.forever then data.returns.forever[scriptName] = nil end
	else
		if data.returns.once then data.returns.once[scriptName] = nil end
	end

	local ok = firebaseSetFull(data)
	if not ok then
		game.StarterGui:SetCore("SendNotification", {
			Title = "Firebase Error",
			Text = "Cannot update Return1 for " .. scriptName,
			Duration = 4
		})
	end
	return ok
end

local function setForeverFlag(scriptName, enabled)
	local data = firebaseGet()
	data.returns = data.returns or { once = {}, forever = {} }
	if enabled then
		data.returns.forever[scriptName] = true
		if data.returns.once then data.returns.once[scriptName] = nil end
	else
		if data.returns.forever then data.returns.forever[scriptName] = nil end
	end

	local ok = firebaseSetFull(data)
	if not ok then
		game.StarterGui:SetCore("SendNotification", {
			Title = "Firebase Error",
			Text = "Cannot update ReturnIfn for " .. scriptName,
			Duration = 4
		})
	end
	return ok
end

local function clearOnceFlag(scriptName)
	local data = firebaseGet()
	data.returns = data.returns or { once = {}, forever = {} }
	if data.returns.once then data.returns.once[scriptName] = nil end
	local ok = firebaseSetFull(data)
	if not ok then warn("[Firebase] clearOnceFlag failed for", scriptName) end
	return ok
end

-- Update Noti Return button visuals
local function updateReturnButtonsVisual(scriptName)
	local data = firebaseGet()
	local onceOn = data.returns and data.returns.once and data.returns.once[scriptName]
	local foreverOn = data.returns and data.returns.forever and data.returns.forever[scriptName]

	if onceOn then
		Noti_Return1.BackgroundColor3 = Color3.fromRGB(50,255,50)
		Noti_Return1.ImageColor3 = Color3.fromRGB(0,0,0)
	else
		Noti_Return1.BackgroundColor3 = Color3.fromRGB(0,0,0)
		Noti_Return1.ImageColor3 = Color3.fromRGB(255,255,255)
	end

	if foreverOn then
		Noti_ReturnIfn.BackgroundColor3 = Color3.fromRGB(50,255,50)
		Noti_ReturnIfn.ImageColor3 = Color3.fromRGB(0,0,0)
	else
		Noti_ReturnIfn.BackgroundColor3 = Color3.fromRGB(0,0,0)
		Noti_ReturnIfn.ImageColor3 = Color3.fromRGB(255,255,255)
	end
end

--------------------------------------------------------
-- NOTI CONTEXT & CONTROLS
--------------------------------------------------------
local NOTI_CONTEXT = {
	scriptName = nil,
	image = nil,
	btnObject = nil,
	scriptFunc = nil,
}
local blur -- BlurEffect object
local menuWasOpen = false

local function openNoti()
	menuWasOpen = menuOpen
	if menuOpen then
		menuOpen = false
		-- closeMenu uses tween Completed:Once in original code
		-- keep same behavior
		local tw = TweenService:Create(main, tweenInfo, {Size = closeSize})
		tw:Play()
		tw.Completed:Once(function()
			main.Visible = false
		end)
	end

	if not blur then
		blur = Instance.new("BlurEffect")
		blur.Size = 50
		blur.Name = "HappyBlur"
		blur.Parent = Lighting
	end

	Noti.Visible = true
	Noti.Size = UDim2.new(0.025,0,0.025,0)
	TweenService:Create(Noti, tweenInfo, {Size = UDim2.new(0.4,0,0.4,0)}):Play()
end

local function closeNoti()
	local tw = TweenService:Create(Noti, tweenInfo, {Size = UDim2.new(0.025,0,0.025,0)})
	tw:Play()
	tw.Completed:Once(function()
		Noti.Visible = false
		if blur then
			blur:Destroy()
			blur = nil
		end
		if menuWasOpen then
			menuOpen = true
			-- reuse openMenu function defined later; ensure main.Visible true + tween
			main.Visible = true
			main.Size = closeSize
			TweenService:Create(main, tweenInfo, {Size = openSize}):Play()
		end
	end)
end

local function openNotiFor(btn)
	local logoImage = nil
	local labelName = nil
	if (btn:IsA("ImageButton") or btn:IsA("ImageLabel")) and btn.Image then logoImage = btn.Image end
	local nameLbl = btn:FindFirstChild("Name")
	if nameLbl and nameLbl:IsA("TextLabel") then labelName = nameLbl.Text else labelName = btn.Name end

	if Noti_Logo:IsA("ImageLabel") or Noti_Logo:IsA("ImageButton") then Noti_Logo.Image = logoImage or "" end
	Noti_Name.Text = labelName or btn.Name

	NOTI_CONTEXT.scriptName = btn.Name
	NOTI_CONTEXT.image = logoImage
	NOTI_CONTEXT.btnObject = btn
	NOTI_CONTEXT.scriptFunc = ScriptMapping[btn.Name] or nil

	updateReturnButtonsVisual(NOTI_CONTEXT.scriptName)
	openNoti()
end

-- Hook Noti buttons
Noti_Back.MouseButton1Click:Connect(function() closeNoti() end)

Noti_Done.MouseButton1Click:Connect(function()
	local sname = NOTI_CONTEXT.scriptName
	if not sname then closeNoti(); return end

	if NOTI_CONTEXT.scriptFunc then
		game.StarterGui:SetCore("SendNotification", {
			Title = "Running Script⌛",
			Text = "Running " .. sname .. "...",
			Duration = 5
		})
		task.spawn(function()
			pcall(NOTI_CONTEXT.scriptFunc)
			game.StarterGui:SetCore("SendNotification", {
				Title = "Script Finished✅",
				Text = sname .. " finished running!",
				Duration = 5
			})
		end)
	else
		warn("Không tìm thấy script func cho", sname)
	end

	local r1On = (Noti_Return1.BackgroundColor3 == Color3.fromRGB(50,255,50))
	local rfOn = (Noti_ReturnIfn.BackgroundColor3 == Color3.fromRGB(50,255,50))

	if r1On then setOnceFlag(sname, true) else setOnceFlag(sname, false) end
	if rfOn then setForeverFlag(sname, true) else setForeverFlag(sname, false) end

	closeNoti()
end)

Noti_Return1.MouseButton1Click:Connect(function()
	local sname = NOTI_CONTEXT.scriptName
	if not sname then return end

	task.spawn(function()
		local wasOn = (Noti_Return1.BackgroundColor3 == Color3.fromRGB(50,255,50))
		if wasOn then
			if setOnceFlag(sname, false) then
				Noti_Return1.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Noti_Return1.ImageColor3 = Color3.fromRGB(255,255,255)
			end
		else
			if setOnceFlag(sname, true) and setForeverFlag(sname, false) then
				Noti_Return1.BackgroundColor3 = Color3.fromRGB(50,255,50)
				Noti_Return1.ImageColor3 = Color3.fromRGB(0,0,0)
				Noti_ReturnIfn.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Noti_ReturnIfn.ImageColor3 = Color3.fromRGB(255,255,255)
			end
		end
	end)
end)

Noti_ReturnIfn.MouseButton1Click:Connect(function()
	local sname = NOTI_CONTEXT.scriptName
	if not sname then return end

	task.spawn(function()
		local wasOn = (Noti_ReturnIfn.BackgroundColor3 == Color3.fromRGB(50,255,50))
		if wasOn then
			if setForeverFlag(sname, false) then
				Noti_ReturnIfn.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Noti_ReturnIfn.ImageColor3 = Color3.fromRGB(255,255,255)
			end
		else
			if setForeverFlag(sname, true) and setOnceFlag(sname, false) then
				Noti_ReturnIfn.BackgroundColor3 = Color3.fromRGB(50,255,50)
				Noti_ReturnIfn.ImageColor3 = Color3.fromRGB(0,0,0)
				Noti_Return1.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Noti_Return1.ImageColor3 = Color3.fromRGB(255,255,255)
			end
		end
	end)
end)

--------------------------------------------------------
-- SCRIPT RUN HELPERS & AUTORUN FROM FIREBASE
--------------------------------------------------------
local function runScriptByName(name)
	local fn = ScriptMapping[name]
	if not fn then return false end
	task.spawn(function() pcall(fn) end)
	return true
end

task.spawn(function()
	local data = firebaseGet()
	if not data then return end
	if data.returns and data.returns.forever then
		for name, _ in pairs(data.returns.forever) do
			if ScriptMapping[name] then
				game.StarterGui:SetCore("SendNotification", {
					Title = "Auto Run",
					Text = "Auto-running " .. name .. " (forever).",
					Duration = 4
				})
				runScriptByName(name)
			end
		end
	end
	if data.returns and data.returns.once then
		for name, _ in pairs(data.returns.once) do
			if ScriptMapping[name] then
				game.StarterGui:SetCore("SendNotification", {
					Title = "Auto Run",
					Text = "Auto-running " .. name .. " (once).",
					Duration = 4
				})
				runScriptByName(name)
				clearOnceFlag(name)
			end
		end
	end
end)

--------------------------------------------------------
-- BUTTON EFFECTS (apply to each button once)
--------------------------------------------------------
local appliedButtons = {}

local function applyButtonEffects(btn)
	local gradient = btn:FindFirstChildOfClass("UIGradient")
	local nameLabel = btn:FindFirstChild("Name")
	if not gradient or not nameLabel then return end

	local hovering = false

	local function tween(obj, info, props)
		TweenService:Create(obj, info, props):Play()
	end

	btn.MouseEnter:Connect(function()
		hovering = true
		tween(btn, tweenInfo, {Size = hoverSize})
		tween(gradient, tweenInfo, {Offset = Vector2.new(0, 0)})
		tween(nameLabel, tweenInfo, {TextTransparency = 0})
	end)

	btn.MouseLeave:Connect(function()
		hovering = false
		tween(btn, tweenInfo, {Size = idleSize})
		tween(gradient, tweenInfo, {Offset = Vector2.new(0, 1)})
		tween(nameLabel, tweenInfo, {TextTransparency = 1})
	end)

	btn.MouseButton1Click:Connect(function()
		tween(btn, fastInfo, {Size = idleSize})
		task.wait(0.07)
		if hovering then tween(btn, fastInfo, {Size = hoverSize}) end

		startLoading(btn)

		task.spawn(function()
			local ok, err = pcall(function()
				openNotiFor(btn)
			end)
			if not ok then warn("[openNotiFor] error:", err) end
			stopLoading(btn)
		end)
	end)
end

--------------------------------------------------------
-- TAB FRAME HANDLING
--------------------------------------------------------
local function hideAllFrames()
	for _, fr in pairs(allFrames) do
		fr.Visible = false
		for _, c in ipairs(fr:GetChildren()) do
			if c:IsA("TextButton") or c:IsA("ImageButton") then
				c.Visible = false
			end
		end
	end
end

hideAllFrames()

local function openTabFrame(targetFrame)
	hideAllFrames()
	targetFrame.Visible = true

	local buttons = {}
	for _, child in ipairs(targetFrame:GetChildren()) do
		if child:IsA("TextButton") or child:IsA("ImageButton") then
			table.insert(buttons, child)
			if not appliedButtons[child] then
				applyButtonEffects(child)
				appliedButtons[child] = true
			end
		end
	end

	table.sort(buttons, function(a, b)
		local ax, ay = a.Position.X.Scale, a.Position.Y.Scale
		local bx, by = b.Position.X.Scale, b.Position.Y.Scale
		if ay ~= by then return ay < by end
		return ax < bx
	end)

	task.spawn(function()
		for _, btn in ipairs(buttons) do
			btn.Visible = true
			btn.Size = startSize
			TweenService:Create(btn, tweenInfo, {Size = idleSize}):Play()
			task.wait(0.05)
		end
	end)
end

btnCharacter.MouseButton1Click:Connect(function() openTabFrame(frameCharacter) end)
btnGameHub.MouseButton1Click:Connect(function() openTabFrame(frameGameHub) end)
btnVisuals.MouseButton1Click:Connect(function() openTabFrame(frameVisuals) end)

--------------------------------------------------------
-- DRAG UI + CLICK TOGGLE (toggleButton)
--------------------------------------------------------
local frame = toggleButton
local dragSpeed = 0.1

local dragToggle = false
local dragStart = nil
local startPos = nil

local function updateInput(input)
	local delta = input.Position - dragStart
	local pos = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
	TweenService:Create(frame, TweenInfo.new(dragSpeed), {Position = pos}):Play()
end

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragToggle = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if dragToggle then updateInput(input) end
	end
end)

frame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		if not dragToggle then
			menuOpen = not menuOpen
			if menuOpen then
				main.Visible = true
				main.Size = closeSize
				TweenService:Create(main, tweenInfo, {Size = openSize}):Play()
			else
				local tween = TweenService:Create(main, tweenInfo, {Size = closeSize})
				tween:Play()
				tween.Completed:Once(function()
					if not menuOpen then main.Visible = false end
				end)
			end
		end
	end
end)

--------------------------------------------------------
-- TAB HOVER COLOR EFFECTS
--------------------------------------------------------
local tabButtons = {btnCharacter, btnGameHub, btnVisuals}
local normalColor = Color3.fromRGB(0, 255, 150)
local hoverColor = Color3.fromRGB(255, 0, 100)
local tabTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function applyTabHover(btn)
	btn.TextColor3 = normalColor
	local function tweenColor(targetColor)
		TweenService:Create(btn, tabTweenInfo, {TextColor3 = targetColor}):Play()
	end

	btn.MouseEnter:Connect(function() tweenColor(hoverColor) end)
	btn.MouseLeave:Connect(function() tweenColor(normalColor) end)

	btn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then tweenColor(hoverColor) end
	end)
	btn.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then tweenColor(normalColor) end
	end)
end

for _, tab in ipairs(tabButtons) do applyTabHover(tab) end

--------------------------------------------------------
-- UIGradient HOVER EFFECTS (generic)
--------------------------------------------------------
local function applyGradientEffect(btn)
	local effectFrame = btn:FindFirstChild("Effect")
	if not effectFrame then return end
	local gradient = effectFrame:FindFirstChildOfClass("UIGradient")
	if not gradient then return end

	gradient.Offset = Vector2.new(0, 1.5)
	local hoverInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local function tweenGradient(offset)
		TweenService:Create(gradient, hoverInfo, {Offset = offset}):Play()
	end

	btn.MouseEnter:Connect(function() tweenGradient(Vector2.new(0, -1.5)) end)
	btn.MouseLeave:Connect(function() gradient.Offset = Vector2.new(0, 1.5) end)

	btn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then tweenGradient(Vector2.new(0, -1.5)) end
	end)
	btn.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then gradient.Offset = Vector2.new(0, 1.5) end
	end)
end

local function applyGradientToFrameButtons(frame)
	for _, obj in ipairs(frame:GetChildren()) do
		if obj:IsA("TextButton") or obj:IsA("ImageButton") then
			applyGradientEffect(obj)
		end
	end
end

applyGradientToFrameButtons(frameCharacter)
applyGradientToFrameButtons(frameGameHub)
applyGradientToFrameButtons(frameVisuals)
applyGradientEffect(toggleButton)

--------------------------------------------------------
-- END OF FILE
--------------------------------------------------------
