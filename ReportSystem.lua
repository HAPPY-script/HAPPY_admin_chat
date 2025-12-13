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

-- ============================
-- SUPPORT STATUS: realtime poll + UI binding
-- ============================
local supportFrame = systemFrame:FindFirstChild("SupportStatus")
if supportFrame then
    local MyFeedback = supportFrame:WaitForChild("MyFeedback")
    local AdminFeedback = supportFrame:WaitForChild("AdminFeedback")
    local OKButton = supportFrame:WaitForChild("OkButton")

    -- default off
    supportFrame.Visible = false

    -- internal state
    local polling = true
    local pollInterval = 3 -- giây giữa mỗi lần GET
    local dotCoroutine = nil
    local dotSession = 0

    local function setOKButtonState(isOk)
        if isOk then
            OKButton.Text = "OK"
            OKButton.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        else
            OKButton.Text = "Cancel"
            OKButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        end
    end

    local function stopDotAnimation()
        dotSession = dotSession + 1 -- invalidate previous session
        if dotCoroutine then
            -- allow coroutine to self-exit
            dotCoroutine = nil
        end
        -- restore AdminFeedback alpha/text color if you changed it
    end

    local function startDotAnimation(baseText)
        -- ensure previous stopped
        stopDotAnimation()
        local mySession = dotSession + 1
        dotSession = mySession
        dotCoroutine = task.spawn(function()
            local i = 0
            while dotSession == mySession do
                i = (i % 3) + 1
                local dots = string.rep(".", i)
                pcall(function() AdminFeedback.Text = baseText .. dots end)
                task.wait(0.6) -- speed for dots (adjust if needed)
            end
        end)
    end

    local function deleteReportRequest()
        -- try DELETE; fallback PUT null if DELETE unsupported
        local ok, res = pcall(function()
            return HttpRequest({ Url = USER_URL, Method = "DELETE" })
        end)
        if not ok or not res or (res.StatusCode ~= 200 and res.StatusCode ~= 204) then
            -- fallback: PUT null
            pcall(function()
                HttpRequest({
                    Url = USER_URL,
                    Method = "PUT",
                    Headers = { ["Content-Type"] = "application/json" },
                    Body = "null"
                })
            end)
        end
    end

    -- khi bấm OK/Cancel
    OKButton.MouseButton1Click:Connect(function()
        -- nếu đang visible và có trạng thái Cancel (nghĩa admin chưa phản hồi)
        if OKButton.Text == "Cancel" then
            -- xoá report và ẩn UI
            deleteReportRequest()
            supportFrame.Visible = false
            stopDotAnimation()
            Notify("Report Cancelled", "Your report has been removed.")
        else
            -- OK state (admin đã phản hồi) -> xóa report và ẩn
            deleteReportRequest()
            supportFrame.Visible = false
            stopDotAnimation()
            Notify("Report Closed", "Your report has been cleared.")
        end
    end)

    -- Kiểm tra Firebase xem có report hiện tại không
    local function fetchReport()
        local ok, res = pcall(function()
            return HttpRequest({ Url = USER_URL, Method = "GET" })
        end)
        if not ok or not res then return nil end
        if res.StatusCode ~= 200 then return nil end
        if not res.Body or res.Body == "null" then return nil end
        local success, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
        if not success or type(data) ~= "table" then return nil end
        return data
    end

    -- Cập nhật UI dựa trên data từ Firebase
    local function updateSupportUIFromData(data)
        if not data then
            -- không có report
            supportFrame.Visible = false
            stopDotAnimation()
            return
        end

        -- hiển thị frame
        supportFrame.Visible = true

        -- MyFeedback show message
        local message = tostring(data.message or "")
        MyFeedback.Text = message

        -- Admin feedback logic: nếu admin đã phản hồi (responded = true)
        if data.responded or data.response then
            stopDotAnimation()
            local adminText = tostring(data.response or "No response text.")
            AdminFeedback.Text = adminText
            setOKButtonState(true) -- OK (xanh)
        else
            -- chưa phản hồi -> chạy animation
            AdminFeedback.Text = "Waiting for a response from the admin"
            startDotAnimation("Waiting for a response from the admin")
            setOKButtonState(false) -- Cancel (đỏ)
        end
    end

    -- Poll loop (non-blocking)
    task.spawn(function()
        while polling do
            local data = fetchReport()
            if data then
                updateSupportUIFromData(data)
            else
                -- nếu không có data thì ẩn UI
                if supportFrame.Visible then
                    supportFrame.Visible = false
                end
                stopDotAnimation()
            end
            task.wait(pollInterval)
        end
    end)
end

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

	local newData = fetchReport()
	updateSupportUIFromData(newData)

	if success then
		Notify("Report Sent", "Your report has been submitted successfully.")
		textBox.Text = ""
		maxText.Text = "0/" .. MAX_LEN
	else
		Notify("Error", "Failed to send report. Try again later.")
	end
end)
