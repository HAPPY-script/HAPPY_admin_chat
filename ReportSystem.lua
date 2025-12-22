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
-- SUPABASE CONFIG (replace if needed)
--=====================================================
local SUPABASE_BASE = "https://koqaxxefwuosiplczazy.supabase.co"
local SUPABASE_KEY  = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtvcWF4eGVmd3Vvc2lwbGN6YXp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYyNzA1NDMsImV4cCI6MjA4MTg0NjU0M30.c_hoE6Kr3N9OEgS2WOUlDj-2-EL3H_CRzKO3RLbBlwU"
local REPORTS_ENDPOINT = SUPABASE_BASE .. "/rest/v1/reports" -- PostgREST table endpoint

-- Default headers for Supabase REST
local function defaultHeaders()
	return {
		["apikey"] = SUPABASE_KEY,
		["Authorization"] = "Bearer " .. SUPABASE_KEY,
		["Content-Type"] = "application/json",
		["Accept"] = "application/json"
	}
end

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
	local s = encoded:gsub("%{0x(%x%x)%}", function(h)
		local n = tonumber(h, 16)
		if n and n >= 0 and n <= 255 then
			return string.char(n)
		end
		return ""
	end)
	for token, ch in pairs(FIREBASE_UNESCAPE_MAP) do
		s = s:gsub(token, ch)
	end
	return s
end

--=====================================================
-- UTILS
--=====================================================
local function UrlEncode(str)
	-- use HttpService:UrlEncode if available
	local ok, enc = pcall(function() return HttpService:UrlEncode(str) end)
	if ok and enc then return enc end
	-- fallback simple encode
	str = tostring(str)
	str = str:gsub("([^A-Za-z0-9_%-%.~])", function(c)
		return string.format("%%%02X", string.byte(c))
	end)
	return str
end

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
		"⚙Report System⚠",
		"The data system is temporarily under maintenance. Please try again later."
	)
end

-- If REST_DATA flag true -> maintenance mode (kept)
if REST_DATA then
	pcall(function()
		sendButton.Active = false
		sendButton.AutoButtonColor = false
		textBox.PlaceholderText = "The Reporting system is undergoing maintenance due to data overload."
		textBox.PlaceholderColor3 = Color3.fromRGB(255, 0, 0)
	end)

	NotifyMaintenance()
	return
end

local function GetTime()
	local t = os.date("*t")
	return string.format("%02d:%02d - %02d/%02d/%04d",
		t.hour, t.min, t.day, t.month, t.year)
end

--=====================================================
-- Supabase Report helpers
--=====================================================
-- Get report for current player. Returns table or nil.
local function fetchReport()
	local encoded = UrlEncode(playerName)
	local url = REPORTS_ENDPOINT .. "?player=eq." .. encoded .. "&select=*"
	local ok, res = pcall(function()
		return HttpRequest({ Url = url, Method = "GET", Headers = defaultHeaders() })
	end)
	if not ok or not res then return nil end
	if res.StatusCode < 200 or res.StatusCode >= 300 then return nil end
	-- PostgREST returns JSON array
	local success, body = pcall(function() return HttpService:JSONDecode(res.Body) end)
	if not success or type(body) ~= "table" or #body == 0 then return nil end
	return body[1]
end

-- Check existence quick (true if player has a report row with message)
local function CheckExistReport()
	local ok, res = pcall(function()
		return HttpRequest({ Url = REPORTS_ENDPOINT .. "?player=eq." .. UrlEncode(playerName) .. "&select=message", Method = "GET", Headers = defaultHeaders() })
	end)
	if not ok or not res then return false end
	if res.StatusCode < 200 or res.StatusCode >= 300 then return false end
	local s, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
	if not s or type(data) ~= "table" or #data == 0 then return false end
	-- data[1].message may be nil/empty
	return (data[1] and data[1].message ~= nil and data[1].message ~= "")
end

-- Send report: POST to Supabase (will create new row). Returns boolean
local function SendReport(msg)
	local safeMsg = CleanMessage(msg)
	local payload = {
		player = player.Name,
		user_id = player.UserId,
		message = safeMsg,
		timestamp = os.time() * 1000,
		responded = false,
		response = nil,
		responded_at = nil,
		response_type = nil
	}
	local body = HttpService:JSONEncode(payload)
	local ok, res = pcall(function()
		-- use POST to insert new row
		return HttpRequest({
			Url = REPORTS_ENDPOINT,
			Method = "POST",
			Headers = defaultHeaders(),
			Body = body
		})
	end)
	if not ok or not res then return false end
	-- PostgREST returns 201 Created on insert; accept any 2xx
	return (res.StatusCode >= 200 and res.StatusCode < 300)
end

-- Delete player's report row (DELETE where player=eq.<player>)
local function deleteReportRequest()
	local ok, res = pcall(function()
		return HttpRequest({
			Url = REPORTS_ENDPOINT .. "?player=eq." .. UrlEncode(playerName),
			Method = "DELETE",
			Headers = defaultHeaders()
		})
	end)
	if not ok or not res then
		-- fallback: nothing we can do client-side
		return false
	end
	-- 2xx indicates success (204 likely)
	return (res.StatusCode >= 200 and res.StatusCode < 300)
end

--=====================================================
-- UI UPDATE (cho phép gõ tự do; chỉ enforce độ dài)
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

	-- Polling loop
	task.spawn(function()
		if REST_DATA then return end
		while true do
			local ok, rep = pcall(fetchReport)
			local data = nil
			if ok and rep then data = rep end
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

	-- Check existence using Supabase query
	local exists = false
	do
		local ok, res = pcall(function()
			return HttpRequest({
				Url = REPORTS_ENDPOINT .. "?player=eq." .. UrlEncode(playerName) .. "&select=message",
				Method = "GET",
				Headers = defaultHeaders()
			})
		end)
		if ok and res and res.StatusCode >= 200 and res.StatusCode < 300 and res.Body then
			local s, d = pcall(function() return HttpService:JSONDecode(res.Body) end)
			if s and type(d) == "table" and #d > 0 and d[1] and d[1].message and d[1].message ~= "" then
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
		local ok, rep = pcall(fetchReport)
		if ok and rep and supportFrame then
			pcall(function()
				MyFeedback.Text = DecodeMessage(tostring(rep.message or ""))
				if rep.responded or rep.response then
					AdminFeedback.Text = DecodeMessage(tostring(rep.response or ""))
					if OKButton then
						OKButton.Text = "OK"
						OKButton.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
					end
				end
			end)
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
