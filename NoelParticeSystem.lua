--EFFECT
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui"):WaitForChild("HAPPYscript")
local main = gui:WaitForChild("Main")
local particleTemplate = main:WaitForChild("Particle")

local SETTINGS = {
	SpawnRate = 0.5,
	MinSize = 10,
	MaxSize = 20,
	MinFallTime = 17,
	MaxFallTime = 25,
	MinRotation = -10,
	MaxRotation = 10,
}

local function createParticle()
	if #main.ScrollingFrame:GetChildren() > 180 then return end

	local particle = particleTemplate:Clone()
	particle.Visible = true
	particle.Parent = main.ScrollingFrame
	particle.ImageTransparency = 1 -- Bắt đầu mờ 100%

	-- Random size
	local size = math.random(SETTINGS.MinSize, SETTINGS.MaxSize)
	particle.Size = UDim2.fromOffset(size, size)

	-- Rotation
	particle.Rotation = math.random(SETTINGS.MinRotation, SETTINGS.MaxRotation)
	particle.ZIndex = 1

	particle.AnchorPoint = Vector2.new(0.5, 0.5)
	particle.Position = UDim2.new(math.random(), 0, 0, -15)

	local fallTime = math.random(SETTINGS.MinFallTime, SETTINGS.MaxFallTime)
	local sideOffset = math.random(-40, 40)

	----------------------------------------------------
	-- 1. FADE IN
	----------------------------------------------------
	local fadeIn = TweenService:Create(
		particle,
		TweenInfo.new(fallTime * 0.1, Enum.EasingStyle.Linear),
		{ImageTransparency = 0}
	)
	fadeIn:Play()

	----------------------------------------------------
	-- 2. MOVE
	----------------------------------------------------
	local move = TweenService:Create(
		particle,
		TweenInfo.new(fallTime, Enum.EasingStyle.Linear),
		{
			Position = UDim2.new(
				particle.Position.X.Scale + (sideOffset / main.AbsoluteSize.X),
				0,
				1,
				20
			)
		}
	)
	move:Play()

	----------------------------------------------------
	-- 3. FADE OUT (sau 90% thời gian)
	----------------------------------------------------
	task.delay(fallTime * 0.9, function()
		local fadeOut = TweenService:Create(
			particle,
			TweenInfo.new(fallTime * 0.1, Enum.EasingStyle.Linear),
			{ImageTransparency = 1}
		)
		fadeOut:Play()

		-- Destroy sau fade-out, KHÔNG phụ thuộc tween move
		fadeOut.Completed:Connect(function()
			particle:Destroy()
		end)
	end)
end

task.spawn(function()
	while true do
		createParticle()
		task.wait(SETTINGS.SpawnRate)
	end
end)

--==================================================================================================================--

--ADMIN COMMAND

--============================--
--  CLIENT-ONLY ADMIN SYSTEM
--============================--

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Admin danh sách
local ADMINS = {
	["Happy_bmg"] = true,
	[7326395533] = true,
}

-- Kiểm tra người gửi có phải admin không
local function isAdmin(plr)
	if not plr then return false end
	if ADMINS[plr.Name] then return true end
	if ADMINS[plr.UserId] then return true end
	return false
end

-- Xử lý lệnh
local function processCommand(sender, message)
	if not isAdmin(sender) then return end  -- không phải admin thì bỏ qua

	message = string.lower(message)

	-- Lệnh /kill username
	if message:sub(1, 6) == "/kill " then
		local targetName = message:sub(7)

		-- nếu đúng tên mình thì tự kill
		if string.lower(targetName) == string.lower(LocalPlayer.Name) then
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				LocalPlayer.Character.Humanoid.Health = 0
			end
		end
	end
end

-- Theo dõi chat của người chơi khác
local function onPlayerAdded(plr)
	plr.Chatted:Connect(function(msg)
		processCommand(plr, msg)
	end)
end

-- Gán cho tất cả người chơi đã có
for _, plr in ipairs(Players:GetPlayers()) do
	onPlayerAdded(plr)
end

-- Khi có người mới vào
Players.PlayerAdded:Connect(onPlayerAdded)

--======================================================================================================--

--DATA MEMBER

--==================================================--
--  HTTP REQUEST AUTO-DETECT
--==================================================--
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
		error("[DataMember] Executor không hỗ trợ http request!")
	end
end

--==================================================--
--  SERVICES
--==================================================--
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

local USERNAME = LocalPlayer.Name
local USERID = LocalPlayer.UserId

-- Lấy tên game thật bằng API Roblox

-- Chuyển tên game thành key an toàn cho Firebase
local function MakeSafeKey(str)
    return str:gsub("[.%$#%[%]/]", "_")
end

local function GetRealGameName()
    local universeId = game.GameId
    local url = "https://games.roblox.com/v1/games?universeIds=" .. universeId

    local response = HttpRequest({
        Url = url,
        Method = "GET"
    })

    if not response or response.StatusCode ~= 200 then
        warn("[GetRealGameName] Lỗi API → dùng fallback")
        return "Unknown Game"
    end

    local data = HttpService:JSONDecode(response.Body)
    if data and data.data and data.data[1] and data.data[1].name then
        return data.data[1].name
    end

    return "Unknown Game"
end

-- Tên game thật + PlaceId
local REAL_GAME_NAME = GetRealGameName()
local CURRENT_GAME = REAL_GAME_NAME .. " (" .. game.PlaceId .. ")"
local SAFE_GAME_KEY = MakeSafeKey(CURRENT_GAME)

local PROJECT_URL = "https://happy-script-bada6-default-rtdb.asia-southeast1.firebasedatabase.app/Member/" .. USERNAME .. ".json"

--==================================================--
--  GET USER DATA (NEEDED TO AVOID OVERWRITE)
--==================================================--
local function GetUserData()
	local response = HttpRequest({
		Url = PROJECT_URL,
		Method = "GET"
	})

	if not response or response.StatusCode ~= 200 or response.Body == "null" then
		return nil
	end

	return HttpService:JSONDecode(response.Body)
end

--==================================================--
--  REPORT PLAYER + SAVE GAME HISTORY
--==================================================--
local function ReportPlayer()
	local data = GetUserData()

	if not data then
		-- Player chưa tồn tại -> tạo mới
		data = {
			ID = USERID,
			Games = {}
		}
	end

	-- Nếu chưa có bảng Games thì tạo
	data.Games = data.Games or {}

    -- Thêm game mới nếu chưa có
    if not data.Games[SAFE_GAME_KEY] then
        data.Games[SAFE_GAME_KEY] = true
    end

	print("[DataMember] Lưu:", USERNAME, USERID, CURRENT_GAME)

	-- Gửi dữ liệu hoàn chỉnh lên server
	local response = HttpRequest({
		Url = PROJECT_URL,
		Method = "PUT",
		Headers = { ["Content-Type"] = "application/json" },
		Body = HttpService:JSONEncode(data)
	})

	if response and response.StatusCode == 200 then
		print("[DataMember] Thành công!")
	else
		warn("[DataMember] Thất bại! Status:", response and response.StatusCode)
	end
end

--==================================================--
--  AUTO SEND
--==================================================--
task.wait(1)

ReportPlayer()

print("Done DataMember✅")
