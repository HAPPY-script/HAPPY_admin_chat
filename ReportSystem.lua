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
-- CLEAN / DECODE MESSAGE (SAFE + REVERSIBLE FOR FIREBASE)
--=====================================================
local FIREBASE_ESCAPE_MAP = {
	["."]  = "{DOT}",
	["#"]  = "{HASH}",
	["$"]  = "{DOLLAR}",
	["["]  = "{LBRACKET}",
	["]"]  = "{RBRACKET}",
	["/"]  = "{SLASH}",
	["\\"] = "{BACKSLASH}",
}

-- Precompute reverse map
local FIREBASE_UNESCAPE_MAP = {}
for k,v in pairs(FIREBASE_ESCAPE_MAP) do FIREBASE_UNESCAPE_MAP[v] = k end

local function CleanMessage(str)
	if type(str) ~= "string" then
		return ""
	end

	local out = {}

	for i = 1, #str do
		local ch = str:sub(i, i)
		local byte = string.byte(ch)

		-- Firebase forbidden characters -> replace with token
		if FIREBASE_ESCAPE_MAP[ch] then
			table.insert(out, FIREBASE_ESCAPE_MAP[ch])

		-- Control characters (non-printable) -> encode as {0xNN}
		elseif byte < 32 or byte == 127 then
			table.insert(out, string.format("{0x%02X}", byte))

		-- Safe character
		else
			table.insert(out, ch)
		end
	end

	return table.concat(out)
end

local function DecodeMessage(encoded)
	if type(encoded) ~= "string" then return "" end

	-- first decode hex tokens {0xNN} -> char
	local s = encoded:gsub("%{0x(%x%x)%}", function(h)
		local n = tonumber(h, 16)
		if n and n >= 0 and n <= 255 then
			return string.char(n)
		end
		return ""
	end)

	-- then unescape special tokens {DOT}, {HASH}, etc.
	-- do a global replace; tokens do not overlap
	for token, ch in pairs(FIREBASE_UNESCAPE_MAP) do
		-- token contains braces like {DOT}
		-- use gsub plain to avoid pattern issues
		s = s:gsub(token, ch)
	end

	return s
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
		local ok, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
		if ok and data and data.message then
			return true
		end
	end

	return false
end

-- Gửi report (msg phải là RAW text — chúng ta sẽ CleanMessage bên trong SendReport)
local function SendReport(msg)
	local safeMsg = CleanMessage(msg) -- mã hóa trước khi gửi

    local payload = {
        userId = player.UserId,
        playerName = player.Name,
        message = safeMsg,
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
-- UI UPDATE (không chặn nhập)
--=====================================================
textBox:GetPropertyChangedSignal("Text"):Connect(function()
	local txt = textBox.Text or ""
	-- không sửa txt (không xóa ký tự), chỉ enforce độ dài
	local len = #txt
	if len > MAX_LEN then
		-- cắt nếu quá dài (vẫn là thao tác với văn bản gốc)
		textBox.Text = txt:sub(1, MAX_LEN)
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

    -- Cập nhật UI dựa trên data từ Firebase (GIẢI MÃ trước khi hiển thị)
    local function updateSupportUIFromData(data)
        if not data then
            -- không có report
            supportFrame.Visible = false
            stopDotAnimation()
            return
        end

        -- hiển thị frame
        supportFrame.Visible = true

        -- MyFeedback show message (decode)
        local rawMessage = tostring(data.message or "")
        local displayMsg = DecodeMessage(rawMessage)
        MyFeedback.Text = displayMsg

        -- Admin feedback logic: nếu admin đã phản hồi (responded = true)
        if data.responded or data.response then
            stopDotAnimation()
            local adminRaw = tostring(data.response or "No response text.")
            AdminFeedback.Text = DecodeMessage(adminRaw)
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
	local content = textBox.Text or ""
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

	-- CleanMessage will be called inside SendReport
	local success = SendReport(content)

	local newData = (function()
		-- fetchReport is local inside the earlier block; replicate safe GET here
		local ok, res = pcall(function() return HttpRequest({ Url = USER_URL, Method = "GET" }) end)
		if not ok or not res or not res.Body or res.Body == "null" then return nil end
		local s, d = pcall(function() return HttpService:JSONDecode(res.Body) end)
		if not s or type(d) ~= "table" then return nil end
		return d
	end)()

	if newData then
		-- reuse updateSupportUIFromData if available (it is in the outer scope)
		-- safe-call since function exists above only when supportFrame exists
		pcall(function()
			if supportFrame and type(supportFrame) == "Instance" then
				-- call existing function by reusing same code path:
				-- but we can't easily call the local updateSupportUIFromData from here if not in same scope,
				-- so just update MyFeedback/AdminFeedback directly:
				local rawMessage = tostring(newData.message or "")
				MyFeedback.Text = DecodeMessage(rawMessage)
				if newData.responded or newData.response then
					AdminFeedback.Text = DecodeMessage(tostring(newData.response or "No response text."))
				end
			end
		end)
	end

	if success then
		Notify("Report Sent", "Your report has been submitted successfully.")
		textBox.Text = ""
		maxText.Text = "0/" .. MAX_LEN
	else
		Notify("Error", "Failed to send report. Try again later.")
	end
end)
