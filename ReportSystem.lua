local REST_DATA = getgenv().RestFireBase == true

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
		local ch = str:sub(i, i)
		local byte = string.byte(ch)
		-- replace forbidden single chars with tokens
		if FIREBASE_ESCAPE_MAP[ch] then
			table.insert(out, FIREBASE_ESCAPE_MAP[ch])
		-- control chars -> {0xNN}
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
	-- decode {0xNN} -> char
	local s = encoded:gsub("%{0x(%x%x)%}", function(h)
		local n = tonumber(h, 16)
		if n and n >= 0 and n <= 255 then
			return string.char(n)
		end
		return ""
	end)
	-- unescape tokens {DOT}... -> original char
	-- tokens are distinct so simple gsub is fine
	for token, ch in pairs(FIREBASE_UNESCAPE_MAP) do
		s = s:gsub(token, ch)
	end
	return s
end

--=====================================================
-- FIREBASE FUNCTIONS
--=====================================================
local function Notify(title, text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = title,
			Text = text,
			Duration = 5,
		})
	end)
end

local function NotifyMaintenance()
	Notify(
		"System Maintenance",
		"The data system is temporarily under maintenance. Please try again later."
	)
end

if REST_DATA then
	pcall(function()
		sendButton.Active = false
		sendButton.AutoButtonColor = false
		sendButton.Text = "Maintenance"
	end)

	NotifyMaintenance()
	return
end

local function GetTime()
	local t = os.date("*t")
	return string.format("%02d:%02d - %02d/%02d/%04d",
		t.hour, t.min, t.day, t.month, t.year)
end

local function CheckExistReport()
	local ok, res = pcall(function()
		return HttpRequest({ Url = USER_URL, Method = "GET" })
	end)
	if not ok or not res then return false end
	if res.StatusCode ~= 200 then return false end
	if not res.Body or res.Body == "null" then return false end
	local s, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
	if not s or type(data) ~= "table" then return false end
	return (data.message ~= nil)
end

local function SendReport(msg)
	-- msg is RAW text from textbox; we encode here
	local safeMsg = CleanMessage(msg)
	local payload = {
		userId = player.UserId,
		playerName = player.Name,
		message = safeMsg,
		timestamp = os.time() * 1000
	}
	local ok, res = pcall(function()
		return HttpRequest({
			Url = USER_URL,
			Method = "PUT",
			Headers = { ["Content-Type"] = "application/json" },
			Body = HttpService:JSONEncode(payload)
		})
	end)
	return (ok and res and (res.StatusCode == 200))
end

--=====================================================
-- UI UPDATE (cho phép gõ tự do; chỉ enforce độ dài)
--=====================================================
textBox:GetPropertyChangedSignal("Text"):Connect(function()
	local txt = textBox.Text or ""
	local len = #txt
	if len > MAX_LEN then
		-- cắt về kích thước cho phép (vẫn giữ nguyên ký tự)
		textBox.Text = txt:sub(1, MAX_LEN)
		len = MAX_LEN
	end
	maxText.Text = len .. "/" .. MAX_LEN
end)

-- ============================
-- SUPPORT STATUS: realtime poll + UI binding
-- ============================
local supportFrame = systemFrame:FindFirstChild("SupportStatus")
local MyFeedback, AdminFeedback, OKButton

if supportFrame then
	MyFeedback = supportFrame:WaitForChild("MyFeedback")
	AdminFeedback = supportFrame:WaitForChild("AdminFeedback")
	OKButton = supportFrame:WaitForChild("OkButton")

	supportFrame.Visible = false

	local polling = true
	local pollInterval = 3
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
		dotSession = dotSession + 1
		dotCoroutine = nil
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
				pcall(function() AdminFeedback.Text = baseText .. dots end)
				task.wait(0.6)
			end
		end)
	end

	local function deleteReportRequest()
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

	local function updateSupportUIFromData(data)
		if not data then
			supportFrame.Visible = false
			stopDotAnimation()
			return
		end

		supportFrame.Visible = true

		local rawMessage = tostring(data.message or "")
		MyFeedback.Text = DecodeMessage(rawMessage)

		if data.responded or data.response then
			stopDotAnimation()
			AdminFeedback.Text = DecodeMessage(tostring(data.response or "No response text."))
			setOKButtonState(true)
		else
			AdminFeedback.Text = "Waiting for a response from the admin"
			startDotAnimation("Waiting for a response from the admin")
			setOKButtonState(false)
		end
	end

	task.spawn(function()
		if REST_DATA then return end
		while true do
			local data = fetchReport()
			if data then
				updateSupportUIFromData(data)
			else
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
-- REPLACE the existing sendButton.MouseButton1Click handler with this block
sendButton.MouseButton1Click:Connect(function()
	if REST_DATA then
		NotifyMaintenance()
		return
	end

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

	-- Safe existence check (do GET directly, avoid calling CheckExistReport to prevent nil-call)
	local exists = false
	do
		local ok, res = pcall(function()
			return HttpRequest({ Url = USER_URL, Method = "GET" })
		end)
		if ok and res and res.StatusCode == 200 and res.Body and res.Body ~= "null" then
			local s, d = pcall(function() return HttpService:JSONDecode(res.Body) end)
			if s and type(d) == "table" and d.message then
				exists = true
			end
		end
	end

	if exists then
		Notify("Report Locked", "You already have a pending report. Wait for admin approval.")
		return
	end

	-- Send (CleanMessage is called inside SendReport)
	local success = SendReport(content)

	-- Fetch updated data and update UI if supportFrame present
	do
		local ok, res = pcall(function() return HttpRequest({ Url = USER_URL, Method = "GET" }) end)
		if ok and res and res.StatusCode == 200 and res.Body and res.Body ~= "null" then
			local s, d = pcall(function() return HttpService:JSONDecode(res.Body) end)
			if s and type(d) == "table" and supportFrame then
				pcall(function()
					-- decode before display
					MyFeedback.Text = DecodeMessage(tostring(d.message or ""))
					if d.responded or d.response then
						AdminFeedback.Text = DecodeMessage(tostring(d.response or ""))
						-- set OK button state if you want:
						if OKButton then
							OKButton.Text = "OK"
							OKButton.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
						end
					end
				end)
			end
		end
	end

	if success then
		Notify("Report Sent", "Your report has been submitted successfully.")
		textBox.Text = ""
		maxText.Text = "0/" .. MAX_LEN
	else
		Notify("Error", "Failed to send report. Try again later.")
	end
end)
