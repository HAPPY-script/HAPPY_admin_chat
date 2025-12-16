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

local FIREBASE_UNESCAPE_MAP = {}
for k,v in pairs(FIREBASE_ESCAPE_MAP) do FIREBASE_UNESCAPE_MAP[v] = k end

local function CleanMessage(str)
	if type(str) ~= "string" then return "" end
	local out = {}
	for i = 1, #str do
		local ch = str:sub(i,i)
		local byte = string.byte(ch) or 0
		if FIREBASE_ESCAPE_MAP[ch] then
			table.insert(out, FIREBASE_ESCAPE_MAP[ch])
		elseif byte < 32 or byte == 127 then
			table.insert(out, string.format("{0x%02X}", byte))
		else
			table.insert(out, ch)
		end
	end
	return table.concat(out)
end

local function DecodeMessage(encoded)
	if type(encoded) ~= "string" then return "" end

	-- decode hex tokens {0xNN}
	local s = encoded:gsub("%{0x(%x%x)%}", function(h)
		local n = tonumber(h,16)
		if n and n >= 0 and n <= 255 then
			return string.char(n)
		end
		return ""
	end)

	-- unescape tokens {DOT} {HASH} ...
	for token, ch in pairs(FIREBASE_UNESCAPE_MAP) do
		-- tokens like {DOT}
		s = s:gsub(token, ch)
	end

	return s
end

--=====================================================
-- FIREBASE HELPERS (available globally in this file)
--=====================================================
local function Notify(title, text)
	StarterGui:SetCore("SendNotification", {
		Title = title,
		Text = text,
		Duration = 5,
	})
end

local function GetTime()
    local t = os.date("*t")
    return string.format("%02d:%02d - %02d/%02d/%04d",
        t.hour, t.min, t.day, t.month, t.year)
end

-- fetchReport và updateSupportUIFromData được khai báo ở đây (dùng lại trong nhiều nơi)
local function fetchReport()
	local ok, res = pcall(function() return HttpRequest({ Url = USER_URL, Method = "GET" }) end)
	if not ok or not res then return nil end
	if res.StatusCode ~= 200 then return nil end
	if not res.Body or res.Body == "null" then return nil end
	local success, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
	if not success or type(data) ~= "table" then return nil end
	return data
end

-- các biến UI (có thể nil nếu SupportStatus không xuất hiện)
local supportFrame = nil
local MyFeedback, AdminFeedback, OKButton = nil, nil, nil

local function updateSupportUIFromData(data)
	-- Nếu không có Support UI thì không làm gì
	if not supportFrame then return end

	if not data then
		supportFrame.Visible = false
		return
	end

	supportFrame.Visible = true

	-- giải mã message trước khi hiển thị
	local rawMessage = tostring(data.message or "")
	if MyFeedback then
		MyFeedback.Text = DecodeMessage(rawMessage)
	end

	if data.responded or data.response then
		if AdminFeedback then
			AdminFeedback.Text = DecodeMessage(tostring(data.response or "No response text."))
		end
		if OKButton then
			OKButton.Text = "OK"
			OKButton.BackgroundColor3 = Color3.fromRGB(50,255,50)
		end
	else
		if AdminFeedback then
			AdminFeedback.Text = "Waiting for a response from the admin"
		end
		if OKButton then
			OKButton.Text = "Cancel"
			OKButton.BackgroundColor3 = Color3.fromRGB(255,50,50)
		end
	end
end

local function deleteReportRequest()
	-- try DELETE; fallback PUT null
	local ok, res = pcall(function()
		return HttpRequest({ Url = USER_URL, Method = "DELETE" })
	end)
	if not ok or not res or (res.StatusCode ~= 200 and res.StatusCode ~= 204) then
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

--=====================================================
-- SUPPORT STATUS: bind UI nếu tồn tại
--=====================================================
do
	local sf = systemFrame:FindFirstChild("SupportStatus")
	if sf then
		supportFrame = sf
		MyFeedback = supportFrame:WaitForChild("MyFeedback")
		AdminFeedback = supportFrame:WaitForChild("AdminFeedback")
		OKButton = supportFrame:WaitForChild("OkButton")

		supportFrame.Visible = false

		-- internal state
		local polling = true
		local pollInterval = 3
		local dotCoroutine = nil
		local dotSession = 0

		local function stopDotAnimation()
			dotSession = dotSession + 1
			if dotCoroutine then dotCoroutine = nil end
		end

		local function startDotAnimation(baseText)
			stopDotAnimation()
			local mySession = dotSession + 1
			dotSession = mySession
			dotCoroutine = task.spawn(function()
				local i = 0
				while dotSession == mySession do
					i = (i % 3) + 1
					local dots = string.rep(".", i)
					pcall(function() if AdminFeedback then AdminFeedback.Text = baseText .. dots end end)
					task.wait(0.6)
				end
			end)
		end

		OKButton.MouseButton1Click:Connect(function()
			if OKButton.Text == "Cancel" then
				deleteReportRequest()
				supportFrame.Visible = false
				stopDotAnimation()
				Notify("Report Cancelled", "Your report has been removed.")
			else
				deleteReportRequest()
				supportFrame.Visible = false
				stopDotAnimation()
				Notify("Report Closed", "Your report has been cleared.")
			end
		end)

		-- poll loop
		task.spawn(function()
			while true do
				local data = fetchReport()
				if data then
					updateSupportUIFromData(data)
					-- if not responded -> animate dots
					if not (data.responded or data.response) then
						startDotAnimation("Waiting for a response from the admin")
					else
						stopDotAnimation()
					end
				else
					if supportFrame.Visible then supportFrame.Visible = false end
					stopDotAnimation()
				end
				task.wait(pollInterval)
			end
		end)
	end
end

--=====================================================
-- REPORT SEND (mã hóa lúc gửi)
--=====================================================
local function SendReport(msg)
	local safeMsg = CleanMessage(msg or "")
	local payload = {
		userId = player.UserId,
		playerName = player.Name,
		message = safeMsg,
		timestamp = os.time() * 1000
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
-- UI UPDATE: cho phép gõ mọi ký tự, chỉ enforce độ dài
--=====================================================
textBox:GetPropertyChangedSignal("Text"):Connect(function()
	local txt = textBox.Text or ""
	local len = #txt
	if len > MAX_LEN then
		textBox.Text = txt:sub(1, MAX_LEN)
		len = MAX_LEN
	end
	maxText.Text = len .. "/" .. MAX_LEN
end)

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

	if CheckExistReport() then
		Notify("Report Locked", "You already have a pending report. Wait for admin approval.")
		return
	end

	local ok = SendReport(content)

	-- fetch again and update UI if possible
	local newData = fetchReport()
	if newData and supportFrame then
		updateSupportUIFromData(newData)
	end

	if ok then
		Notify("Report Sent", "Your report has been submitted successfully.")
		textBox.Text = ""
		maxText.Text = "0/" .. MAX_LEN
	else
		Notify("Error", "Failed to send report. Try again later.")
	end
end)
