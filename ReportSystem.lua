
_G.ReportLoaded = true

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
		error("Executor does NOT support http requests!")
	end
end

--=====================================================
-- SERVICES
--=====================================================
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local playerName = player.Name

--=====================================================
-- FIREBASE CONFIG
--=====================================================
local PROJECT_URL = "https://happy-script-bada6-default-rtdb.asia-southeast1.firebasedatabase.app/reports/"
local USER_URL = PROJECT_URL .. playerName .. ".json"

--=====================================================
-- UI REFERENCES
--=====================================================
local gui = player:WaitForChild("PlayerGui"):WaitForChild("HAPPYscript")
local scrolling = gui:WaitForChild("Main"):WaitForChild("ScrollingFrame")
local systemFrame = scrolling:WaitForChild("System")

local textBox = systemFrame:WaitForChild("TextBox")
local sendButton = textBox:WaitForChild("SendButton")
local maxText = textBox:WaitForChild("MaxText")

local MAX_LEN = 222

--=====================================================
-- CLEAN MESSAGE (FILTER INVALID FIREBASE CHARACTERS)
--=====================================================
local function CleanMessage(str)
	-- Firebase KHÔNG cho phép: . # $ [ ]
	local forbidden = "[%.#%$%[%]/\\]"

	-- xoá ký tự cấm
	str = str:gsub(forbidden, "")

	-- xoá ký tự không thể JSON encode
	local safe = {}
	for i = 1, #str do
		local byte = str:byte(i)
		if byte >= 32 and byte <= 126 then
			table.insert(safe, string.char(byte))
		end
	end

	return table.concat(safe)
end

--=====================================================
-- FIREBASE FUNCTIONS
--=====================================================

local function Notify(title, text)
	StarterGui:SetCore("SendNotification", {
		Title = title,
		Text = text,
		Duration = 5,
	})
end

--=====================================================
-- FORMAT TIME (giờ:phút - ngày/tháng/năm)
--=====================================================
local function GetTime()
    local t = os.date("*t") -- local time của thiết bị
    return string.format("%02d:%02d - %02d/%02d/%04d",
        t.hour, t.min, t.day, t.month, t.year
    )
end

-- Check xem user đã có report chưa
local function CheckExistReport()
	local res = HttpRequest({ Url = USER_URL, Method = "GET" })

	if not res or res.StatusCode ~= 200 then
		return false
	end

	if res.Body and res.Body ~= "null" then
		local data = HttpService:JSONDecode(res.Body)
		if data and data.message then
			return true
		end
	end

	return false
end

-- Gửi report
local function SendReport(msg)
    local payload = {
        userId = player.UserId,
        playerName = player.Name,
        message = msg,
        timestamp = os.time() * 1000  -- ms để web hiển thị chuẩn
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
-- UI UPDATE
--=====================================================

textBox:GetPropertyChangedSignal("Text"):Connect(function()
	local txt = textBox.Text
	local cleaned = CleanMessage(txt)

	-- Nếu có ký tự bị xoá → cập nhật lại
	if cleaned ~= txt then
		textBox.Text = cleaned
	end

	local len = #cleaned

	if len > MAX_LEN then
		textBox.Text = cleaned:sub(1, MAX_LEN)
		len = MAX_LEN
	end

	maxText.Text = len .. "/" .. MAX_LEN
end)

--=====================================================
-- SEND BUTTON HANDLER
--=====================================================

sendButton.MouseButton1Click:Connect(function()

	local content = textBox.Text
	local length = #content

	if length < 1 then
		Notify("Report Failed", "You must enter a message.")
		return
	end

	if length > MAX_LEN then
		Notify("Report Failed", "Message exceeds character limit!")
		return
	end

	local exists = CheckExistReport()
	if exists then
		Notify("Report Locked", "You already have a pending report. Wait for admin approval.")
		return
	end

	local success = SendReport(content)

	if success then
		Notify("Report Sent", "Your report has been submitted successfully.")
		textBox.Text = ""
		maxText.Text = "0/" .. MAX_LEN
	else
		Notify("Error", "Failed to send report. Try again later.")
	end
end)
