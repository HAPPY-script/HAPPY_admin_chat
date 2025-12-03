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
}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui"):WaitForChild("HAPPYscript")
local main = gui:WaitForChild("Main")
local scroll = main:WaitForChild("ScrollingFrame")
local toggleButton = gui:WaitForChild("Button")

--------------------------------------------------------
-- TAB BUTTONS
--------------------------------------------------------
local btnCharacter = main:WaitForChild("Character")
local btnGameHub = main:WaitForChild("GameHub")
local btnVisuals = main:WaitForChild("System")

local frameCharacter = scroll:WaitForChild("Character")
local frameGameHub = scroll:WaitForChild("GameHub")
local frameVisuals = scroll:WaitForChild("System")

local allFrames = {
	Character = frameCharacter,
	GameHub = frameGameHub,
	Visuals = frameVisuals
}

--------------------------------------------------------
-- BUTTON EFFECT SETTINGS
--------------------------------------------------------
local startSize = UDim2.new(0.01, 0, 0.01, 0)
local idleSize = UDim2.new(0.25, 0, 0.25, 0)
local hoverSize = UDim2.new(0.275, 0, 0.275, 0)

local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local fastInfo = TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

--BUTTON
local openSize = UDim2.new(0.75, 0, 0.75, 0)
local closeSize = UDim2.new(0.025, 0, 0.025, 0)

local menuOpen = false
local dragStartPos
local dragging = false
local clickThreshold = 8

local function openMenu()
	main.Visible = true
	main.Size = closeSize
	TweenService:Create(main, tweenInfo, {Size = openSize}):Play()
end

local function closeMenu()
	local tween = TweenService:Create(main, tweenInfo, {Size = closeSize})
	tween:Play()
	tween.Completed:Once(function()
		if not menuOpen then
			main.Visible = false
		end
	end)
end

--------------------------------------------------------
-- APPLY FIREBASE SYTEM
--------------------------------------------------------

-- ======= NOTI + FIREBASE SUPPORT =======

-- ============================
-- Loading helpers (improved)
-- ============================
local RunService = game:GetService("RunService")
-- weak-key table để lưu connection theo loadingFrame (auto GC khi frame mất)
local loadingConns = setmetatable({}, { __mode = "k" })

local function findSpinnerImage(loadingFrame)
	-- tìm ImageLabel an toàn, có thể là con trực tiếp hoặc descendant
	if not loadingFrame then return nil end
	-- ưu tiên FindFirstChildOfClass (direct child)
	local img = loadingFrame:FindFirstChildOfClass("ImageLabel")
	if img then return img end
	-- fallback: tìm descendant đầu tiên là ImageLabel
	for _, v in ipairs(loadingFrame:GetDescendants()) do
		if v:IsA("ImageLabel") then
			return v
		end
	end
	return nil
end

local function startLoading(btn)
	if not btn or not btn.Parent then return end
	local loadingFrame = btn:FindFirstChild("Loading")
	if not loadingFrame then return end

	-- nếu đã đang loading thì không tạo lại connection
	if loadingConns[loadingFrame] then
		loadingFrame.Visible = true
		return
	end

	local img = findSpinnerImage(loadingFrame)
	if img then
		-- reset rotation và show
		img.Rotation = 0
		loadingFrame.Visible = true

		-- tạo connection xoay
		local conn = RunService.Heartbeat:Connect(function(dt)
			-- xoay 360 độ / giây (mượt & frame-rate independent)
			img.Rotation = (img.Rotation + 360 * dt) % 360
		end)

		loadingConns[loadingFrame] = conn
	else
		-- nếu không có image thì chỉ show frame
		loadingFrame.Visible = true
	end
end

local function stopLoading(btn)
	if not btn then return end
	local loadingFrame = btn:FindFirstChild("Loading")
	if not loadingFrame then return end

	-- disconnect connection nếu có
	local conn = loadingConns[loadingFrame]
	if conn then
		pcall(function() conn:Disconnect() end)
		loadingConns[loadingFrame] = nil
	end

	-- reset rotation của image (nếu có) và ẩn frame
	local img = findSpinnerImage(loadingFrame)
	if img then
		img.Rotation = 0
	end
	loadingFrame.Visible = false
end

-- Auto-detect http request (giống script mẫu)
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

local HttpService = game:GetService("HttpService")
local PROJECT_URL = "https://happy-script-bada6-default-rtdb.asia-southeast1.firebasedatabase.app/users/"
local URL = PROJECT_URL .. tostring(player.UserId) .. ".json" -- endpoint giống mẫu

-- Noti GUI (tìm an toàn)
local happyGui = gui
local Noti = happyGui:WaitForChild("Noti")
local Noti_Logo = Noti:WaitForChild("Logo")
local Noti_Return1 = Noti:WaitForChild("Return1")
local Noti_ReturnIfn = Noti:WaitForChild("ReturnIfn")
local Noti_Back = Noti:WaitForChild("Back")
local Noti_Done = Noti:WaitForChild("Done")
local Lighting = game:GetService("Lighting")
local blur -- object
local menuWasOpen = false
local Noti_Name = Noti:FindFirstChild("Name") or (Noti_Logo:FindFirstChild("Name") and Noti_Logo:FindFirstChild("Name"))
if not Noti_Name then
	Noti_Name = Instance.new("TextLabel")
	Noti_Name.Size = UDim2.new(1,0,0,20)
	Noti_Name.BackgroundTransparency = 1
	Noti_Name.Text = ""
	Noti_Name.Parent = Noti
end

local function openNoti()
	-- Lưu trạng thái menu
	menuWasOpen = menuOpen

	-- Nếu menu đang mở thì đóng lại
	if menuOpen then
		menuOpen = false
		closeMenu()
	end

	-- Tạo Blur
	if not blur then
		blur = Instance.new("BlurEffect")
		blur.Size = 50
		blur.Name = "HappyBlur"
		blur.Parent = Lighting
	end

	-- Hiện Noti
	Noti.Visible = true
	Noti.Size = UDim2.new(0.025,0,0.025,0)
	TweenService:Create(Noti, tweenInfo, {Size = UDim2.new(0.4,0,0.4,0)}):Play()
end

local function closeNoti()
	local tw = TweenService:Create(Noti, tweenInfo, {Size = UDim2.new(0.025,0,0.025,0)})
	tw:Play()
	tw.Completed:Once(function()
		Noti.Visible = false

		-- Xóa Blur
		if blur then
			blur:Destroy()
			blur = nil
		end

		-- Mở lại Menu nếu trước đó nó đang mở
		if menuWasOpen then
			menuOpen = true
			openMenu()
		end
	end)
end

-- Firebase helpers using HttpRequest (GET / PUT)
local function firebaseGet()
	local ok, res = pcall(function()
		return HttpRequest({Url = URL, Method = "GET"})
	end)

	if not ok or not res then
		warn("[Firebase] GET request failed:", res)
		return { returns = { once = {}, forever = {} } }
	end

	-- response body might be in res.Body (executor returns table) or res (if syn returns table)
	local body = res.Body or res.body or res.Response or res
	-- if syn.request returns table with Body
	if type(body) ~= "string" then
		-- try extract fields
		if res.Body then body = res.Body
		elseif res.body then body = res.body
		elseif res.Response then body = res.Response
		else body = tostring(res)
		end
	end

	-- If status code check
	local status = res.StatusCode or res.status or res.Success and 200 or 0
	if status < 200 or status >= 300 then
		-- If 404 or no data, treat as empty
		if status == 404 or body == "null" then
			return { returns = { once = {}, forever = {} } }
		else
			warn("[Firebase] GET status:", status, body)
			return { returns = { once = {}, forever = {} } }
		end
	end

	-- decode body (could be "null")
	if not body or body == "null" or body == "" then
		return { returns = { once = {}, forever = {} } }
	end

	local decodeOk, data = pcall(function() return HttpService:JSONDecode(body) end)
	if not decodeOk or type(data) ~= "table" then
		warn("[Firebase] JSONDecode failed or invalid data")
		return { returns = { once = {}, forever = {} } }
	end

	-- ensure returns structure
	data.returns = data.returns or {}
	data.returns.once = data.returns.once or {}
	data.returns.forever = data.returns.forever or {}
	return data
end

local function firebaseSetFull(userData)
	-- userData should be a table representing the whole user object
	local json = nil
	local okEnc, enc = pcall(function() return HttpService:JSONEncode(userData) end)
	if not okEnc then
		warn("[Firebase] JSONEncode failed:", enc)
		return false
	end
	json = enc

	local okReq, res = pcall(function()
		return HttpRequest({
			Url = URL,
			Method = "PUT",
			Headers = { ["Content-Type"] = "application/json" },
			Body = json
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

-- convenience wrappers
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

-- UI helper: update the two toggle buttons visual
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

-- context
local NOTI_CONTEXT = {
	scriptName = nil,
	image = nil,
	btnObject = nil,
	scriptFunc = nil,
}

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

-- Hook Back / Done / Return1 / ReturnIfn
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

	-- persist current visual states to server (ensure server state matches UI)
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
			-- enable once and turn off forever
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
			-- enable forever and disable once
			if setForeverFlag(sname, true) and setOnceFlag(sname, false) then
				Noti_ReturnIfn.BackgroundColor3 = Color3.fromRGB(50,255,50)
				Noti_ReturnIfn.ImageColor3 = Color3.fromRGB(0,0,0)
				Noti_Return1.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Noti_Return1.ImageColor3 = Color3.fromRGB(255,255,255)
			end
		end
	end)
end)

local function runScriptByName(name)
	local fn = ScriptMapping[name]
	if not fn then return false end
	task.spawn(function() pcall(fn) end)
	return true
end

-- Startup: GET flags and auto-run
task.spawn(function()
	local data = firebaseGet()
	if not data then return end
	-- run forever
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
	-- run once then clear
	if data.returns and data.returns.once then
		for name, _ in pairs(data.returns.once) do
			if ScriptMapping[name] then
				game.StarterGui:SetCore("SendNotification", {
					Title = "Auto Run",
					Text = "Auto-running " .. name .. " (once).",
					Duration = 4
				})
				runScriptByName(name)
				-- clear once flag for this script
				clearOnceFlag(name)
			end
		end
	end
end)

-- ======= END NOTI + FIREBASE SUPPORT =======

--------------------------------------------------------
-- APPLY BUTTON EFFECTS
--------------------------------------------------------
local function applyButtonEffects(btn)
	local gradient = btn:FindFirstChildOfClass("UIGradient")
	local nameLabel = btn:FindFirstChild("Name")
	if not gradient or not nameLabel then return end

	local hovering = false
	local isRunning = false -- cờ kiểm tra script đang chạy

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

	-- replace previous running logic with this:
	btn.MouseButton1Click:Connect(function()
		-- Tween click effect (keep it)
		tween(btn, fastInfo, {Size = idleSize})
		task.wait(0.07)
		if hovering then
			tween(btn, fastInfo, {Size = hoverSize})
		end

		-- START LOADING trước khi gọi openNotiFor (openNotiFor sẽ gọi firebaseGet/updateReturnButtonsVisual)
		startLoading(btn)

		-- Mở Noti (đặt trong pcall để đảm bảo stopLoading luôn được gọi)
		task.spawn(function()
			local ok, err = pcall(function()
				openNotiFor(btn)
			end)

			-- nếu có lỗi thì log
			if not ok then
				warn("[openNotiFor] error:", err)
			end

			-- STOP LOADING ngay sau khi openNotiFor hoàn tất (dù thành công hay lỗi)
			stopLoading(btn)
		end)
	end)
end

--------------------------------------------------------
-- HIDE ALL FRAMES
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

--------------------------------------------------------
-- OPEN FRAME FOR TAB BUTTONS
--------------------------------------------------------
local appliedButtons = {}

local function openTabFrame(targetFrame)
	hideAllFrames()
	targetFrame.Visible = true

	local buttons = {}
	for _, child in ipairs(targetFrame:GetChildren()) do
		if child:IsA("TextButton") or child:IsA("ImageButton") then
			table.insert(buttons, child)

			-- chỉ apply lần đầu
			if not appliedButtons[child] then
				applyButtonEffects(child)
				appliedButtons[child] = true
			end
		end
	end

	table.sort(buttons, function(a, b)
		local ax, ay = a.Position.X.Scale, a.Position.Y.Scale
		local bx, by = b.Position.X.Scale, b.Position.Y.Scale
		if ay ~= by then
			return ay < by
		end
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

--------------------------------------------------------
-- TAB SWITCH BUTTONS
--------------------------------------------------------
btnCharacter.MouseButton1Click:Connect(function()
	openTabFrame(frameCharacter)
end)

btnGameHub.MouseButton1Click:Connect(function()
	openTabFrame(frameGameHub)
end)

btnVisuals.MouseButton1Click:Connect(function()
	openTabFrame(frameVisuals)
end)

--------------------------------------------------------
-- DRAG UI + CLICK TOGGLE
--------------------------------------------------------

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local frame = toggleButton -- GUI cần kéo
local dragSpeed = 0.1

local dragToggle = false
local dragStart = nil
local startPos = nil

-- DRAG SYSTEM (giống DragUI gốc)

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
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

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

UIS.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then

		if dragToggle then
			updateInput(input)
		end
	end
end)

-- CLICK TOGGLE (PC + MOBILE)

frame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		-- Nếu KHÔNG drag (di chuyển 0px → click thật)
		if not dragToggle then
			menuOpen = not menuOpen
			if menuOpen then
				openMenu()
			else
				closeMenu()
			end
		end
	end
end)

--------------------------------------------------------
-- HOVER COLOR EFFECT FOR 3 TAB BUTTONS
--------------------------------------------------------

local tabButtons = {btnCharacter, btnGameHub, btnVisuals}

local normalColor = Color3.fromRGB(0, 255, 150)
local hoverColor = Color3.fromRGB(255, 0, 100)

local tabTweenInfo = TweenInfo.new(
	0.3,
	Enum.EasingStyle.Quad,
	Enum.EasingDirection.Out
)

local function applyTabHover(btn)
	btn.TextColor3 = normalColor

	local function tweenColor(targetColor)
		TweenService:Create(btn, tabTweenInfo, {TextColor3 = targetColor}):Play()
	end

	-- PC RÊ CHUỘT
	btn.MouseEnter:Connect(function()
		tweenColor(hoverColor)
	end)

	btn.MouseLeave:Connect(function()
		tweenColor(normalColor)
	end)

	-- MOBILE RÊ NGÓN TAY
	btn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			tweenColor(hoverColor)
		end
	end)

	btn.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			tweenColor(normalColor)
		end
	end)
end

for _, tab in ipairs(tabButtons) do
	applyTabHover(tab)
end

--------------------------------------------------------
-- UIGradient HOVER EFFECT FOR ALL BUTTONS
--------------------------------------------------------

local function applyGradientEffect(btn)
	-- tìm Frame Effect > UIGradient
	local effectFrame = btn:FindFirstChild("Effect")
	if not effectFrame then return end

	local gradient = effectFrame:FindFirstChildOfClass("UIGradient")
	if not gradient then return end

	-- giá trị offset mặc định
	gradient.Offset = Vector2.new(0, 1.5)

	local hoverInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local function tweenGradient(offset)
		TweenService:Create(gradient, hoverInfo, {Offset = offset}):Play()
	end

	-- PC hover
	btn.MouseEnter:Connect(function()
		tweenGradient(Vector2.new(0, -1.5))
	end)

	btn.MouseLeave:Connect(function()
		-- KHÔNG tween, đặt trực tiếp
		gradient.Offset = Vector2.new(0, 1.5)
	end)

	-- MOBILE hover
	btn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			tweenGradient(Vector2.new(0, -1.5))
		end
	end)

	btn.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			-- KHÔNG tween, đặt trực tiếp
			gradient.Offset = Vector2.new(0, 1.5)
		end
	end)
end

--------------------------------------------------------
-- APPLY GRADIENT EFFECT TO ALL BUTTON IN FRAMES
--------------------------------------------------------

local function applyGradientToFrameButtons(frame)
	for _, obj in ipairs(frame:GetChildren()) do
		if obj:IsA("TextButton") or obj:IsA("ImageButton") then
			applyGradientEffect(obj)
		end
	end
end

-- apply cho toàn bộ các frame
applyGradientToFrameButtons(frameCharacter)
applyGradientToFrameButtons(frameGameHub)
applyGradientToFrameButtons(frameVisuals)

--------------------------------------------------------
-- APPLY GRADIENT FOR MAIN MENU BUTTON
--------------------------------------------------------
applyGradientEffect(toggleButton)
