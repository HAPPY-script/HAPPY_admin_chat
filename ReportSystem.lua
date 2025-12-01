--=====================================================
-- AUTO DETECT HTTP REQUEST
--=====================================================
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

--=====================================================
-- CONFIG
--=====================================================
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerName = player.Name

-- Firebase link
local PROJECT_URL = "https://happy-script-bada6-default-rtdb.asia-southeast1.firebasedatabase.app/reports/"
local USER_URL = PROJECT_URL .. playerName .. ".json"

--=====================================================
-- UI OBJECTS
--=====================================================
local gui = player:WaitForChild("PlayerGui"):WaitForChild("HAPPYscript")
local scrolling = gui:WaitForChild("Main"):WaitForChild("ScrollingFrame")
local systemFrame = scrolling:WaitForChild("System")

local textBox = systemFrame:WaitForChild("TextBox")
local sendButton = textBox:WaitForChild("SendButton")
local maxText = textBox:WaitForChild("MaxText")

local MAX_LEN = 222

--=====================================================
-- FUNCTIONS
--=====================================================

-- 📌 Kiểm tra người chơi đã có report chưa
local function CheckExistReport()
	local res = HttpRequest({
		Url = USER_URL,
		Method = "GET"
	})

	if not res or res.StatusCode ~= 200 then
		return false -- coi như chưa có
	end

	local data = {}

	if res.Body and res.Body ~= "null" then
		data = HttpService:JSONDecode(res.Body)
	end

	-- Nếu có data → còn report chưa được xoá
	if data and data.message then
		return true
	end

	return false
end

-- 📌 Gửi report mới lên Firebase
local function SendReport(msg)
	local payload = {
		message = msg
	}

	local res = HttpRequest({
		Url = USER_URL,
		Method = "PUT",
		Headers = { ["Content-Type"] = "application/json" },
		Body = HttpService:JSONEncode(payload)
	})

	return (res and res.StatusCode == 200)
end

--=====================================================
-- UI HANDLER
--=====================================================

-- 📌 Cập nhật số ký tự
textBox:GetPropertyChangedSignal("Text"):Connect(function()
	local len = #textBox.Text
	if len > MAX_LEN then
		textBox.Text = textBox.Text:sub(1, MAX_LEN)
		len = MAX_LEN
	end

	maxText.Text = len .. "/" .. MAX_LEN
end)

-- 📌 Xử lý khi nhấn nút gửi
sendButton.MouseButton1Click:Connect(function()

	local content = textBox.Text
	local length = #content

	-- Điều kiện độ dài
	if length < 1 then
		warn("Không thể gửi. Chưa nhập nội dung.")
		return
	end

	if length > MAX_LEN then
		warn("Vượt quá giới hạn kí tự.")
		return
	end

	-- Kiểm tra có đang có report tồn tại không
	local exists = CheckExistReport()
	if exists then
		warn("Không thể gửi. Report cũ chưa được Admin xoá.")
		return
	end

	-- Gửi report
	local success = SendReport(content)

	if success then
		print("Gửi report thành công!")
		textBox.Text = ""
		maxText.Text = "0/" .. MAX_LEN
	else
		warn("Gửi thất bại!")
	end
end)
