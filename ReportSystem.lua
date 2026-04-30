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
		warn("Executor does NOT support http requests!")

		_G.HAPPYnotification = {
			title = "Executor Error",
			text = "Your executor does not support HTTP requests.",
			color = {255, 80, 80},
			time = 10
		}
		return nil
	end
end

--=====================================================
-- SERVICES
--=====================================================
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerName = player.Name

--=====================================================
-- SUPABASE CONFIG
--=====================================================
local SUPABASE_BASE = "https://koqaxxefwuosiplczazy.supabase.co"
local SUPABASE_KEY  = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtvcWF4eGVmd3Vvc2lwbGN6YXp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYyNzA1NDMsImV4cCI6MjA4MTg0NjU0M30.c_hoE6Kr3N9OEgS2WOUlDj-2-EL3H_CRzKO3RLbBlwU"
local REPORTS_ENDPOINT = SUPABASE_BASE .. "/rest/v1/reports"

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
-- CLEAN / DECODE MESSAGE
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
for k, v in pairs(FIREBASE_ESCAPE_MAP) do
	FIREBASE_UNESCAPE_MAP[v] = k
end

local function CleanMessage(str)
	if type(str) ~= "string" then return "" end
	local out = {}
	for i = 1, #str do
		local ch = str:sub(i, i)
		local byte = string.byte(ch)
		if FIREBASE_ESCAPE_MAP[ch] then
			out[#out + 1] = FIREBASE_ESCAPE_MAP[ch]
		elseif byte < 32 or byte == 127 then
			out[#out + 1] = string.format("{0x%02X}", byte)
		else
			out[#out + 1] = ch
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
	local ok, enc = pcall(function()
		return HttpService:UrlEncode(str)
	end)
	if ok and enc then return enc end
	str = tostring(str)
	return str:gsub("([^A-Za-z0-9_%-%.~])", function(c)
		return string.format("%%%02X", string.byte(c))
	end)
end

local lastNotify = 0
local NOTIFY_COOLDOWN = 0.25
local function Notify(title, text, time, color)
	if tick() - lastNotify < NOTIFY_COOLDOWN then return end
	lastNotify = tick()

	_G.HAPPYnotification = {
		title = title or "Notification",
		text = text or "",
		color = color or {255, 255, 255},
		time = time or 5
	}
end

local function NotifyMaintenance()
	Notify(
		"⚙Report System⚠",
		"The data system is temporarily under maintenance. Please try again later.",
		8,
		{255, 100, 100}
	)
end

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
	return string.format("%02d:%02d - %02d/%02d/%04d", t.hour, t.min, t.day, t.month, t.year)
end

--=====================================================
-- Supabase Report helpers
--=====================================================
local function fetchReport()
	local encoded = UrlEncode(playerName)
	local url = REPORTS_ENDPOINT .. "?player=eq." .. encoded .. "&select=*"
	local ok, res = pcall(function()
		return HttpRequest({ Url = url, Method = "GET", Headers = defaultHeaders() })
	end)
	if not ok or not res then return nil end
	if res.StatusCode < 200 or res.StatusCode >= 300 then return nil end

	local success, body = pcall(function()
		return HttpService:JSONDecode(res.Body)
	end)
	if not success or type(body) ~= "table" or #body == 0 then return nil end
	return body[1]
end

local function reportExistsFromData(data)
	return type(data) == "table" and data.message ~= nil and data.message ~= ""
end

local function SendReport(msg)
	local payload = {
		player = player.Name,
		user_id = player.UserId,
		message = CleanMessage(msg),
		timestamp = os.time() * 1000,
		responded = false,
		response = nil,
		responded_at = nil,
		response_type = nil
	}

	local body = HttpService:JSONEncode(payload)
	local ok, res = pcall(function()
		return HttpRequest({
			Url = REPORTS_ENDPOINT,
			Method = "POST",
			Headers = defaultHeaders(),
			Body = body
		})
	end)

	if not ok or not res then return false end
	return res.StatusCode >= 200 and res.StatusCode < 300
end

local function deleteReportRequest()
	local ok, res = pcall(function()
		return HttpRequest({
			Url = REPORTS_ENDPOINT .. "?player=eq." .. UrlEncode(playerName),
			Method = "DELETE",
			Headers = defaultHeaders()
		})
	end)

	if not ok or not res then return false end
	return res.StatusCode >= 200 and res.StatusCode < 300
end

--=====================================================
-- UI UPDATE
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

local supportFrame = systemFrame:FindFirstChild("SupportStatus")
local MyFeedback, AdminFeedback, OKButton
local currentReport = nil
local supportLoadedOnce = false
local dotSession = 0
local dotThread = nil

local function stopDotAnimation()
	dotSession += 1
	dotThread = nil
end

local function startDotAnimation(baseText)
	stopDotAnimation()
	local mySession = dotSession + 1
	dotSession = mySession
	dotThread = task.spawn(function()
		local i = 0
		while dotSession == mySession do
			i = (i % 3) + 1
			local dots = string.rep(".", i)
			if AdminFeedback then
				pcall(function()
					AdminFeedback.Text = baseText .. dots
				end)
			end
			task.wait(0.6)
		end
	end)
end

local OK_IDLE_COLOR = Color3.fromRGB(50, 255, 50)
local OK_BUSY_COLOR = Color3.fromRGB(140, 140, 140)
local CANCEL_IDLE_COLOR = Color3.fromRGB(255, 50, 50)
local BUTTON_BUSY_COOLDOWN = 0.15

local buttonBusy = {}

local function setButtonBusy(btn, busy, busyColor)
	if not btn then return end
	if busy then
		buttonBusy[btn] = true
		btn.Active = false
		btn.AutoButtonColor = false
		btn.BackgroundColor3 = busyColor or OK_BUSY_COLOR
	else
		buttonBusy[btn] = nil
		btn.Active = true
		btn.AutoButtonColor = true
	end
end

local function setOKButtonState(isOk)
	if not OKButton then return end
	if isOk then
		OKButton.Text = "OK"
		OKButton.BackgroundColor3 = OK_IDLE_COLOR
	else
		OKButton.Text = "Cancel"
		OKButton.BackgroundColor3 = CANCEL_IDLE_COLOR
	end
end

local function updateSupportUIFromData(data)
	if not supportFrame or not MyFeedback or not AdminFeedback or not OKButton then
		return
	end

	if not data then
		supportFrame.Visible = false
		stopDotAnimation()
		currentReport = nil
		return
	end

	currentReport = data
	supportFrame.Visible = true
	MyFeedback.Text = DecodeMessage(tostring(data.message or ""))

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

if supportFrame then
	MyFeedback = supportFrame:WaitForChild("MyFeedback")
	AdminFeedback = supportFrame:WaitForChild("AdminFeedback")
	OKButton = supportFrame:WaitForChild("OkButton")

	supportFrame.Visible = false

	OKButton.MouseButton1Click:Connect(function()
		if buttonBusy[OKButton] then return end
		setButtonBusy(OKButton, true, OK_BUSY_COLOR)

		task.spawn(function()
			local ok = deleteReportRequest()
			currentReport = nil
			supportFrame.Visible = false
			stopDotAnimation()

			if ok then
				Notify("Report Closed", "Your report has been cleared.", 6, {100, 255, 100})
			else
				Notify("Report Error", "Could not clear your report right now.", 6, {255, 100, 100})
			end

			task.wait(BUTTON_BUSY_COOLDOWN)
			setButtonBusy(OKButton, false)
			setOKButtonState(true)
		end)
	end)
end

--=====================================================
-- REFRESH ONLY WHEN SYSTEM FRAME IS RE-OPENED
--=====================================================
local REFRESH_COOLDOWN = 180
local lastSystemRefreshAt = 0
local lastSystemVisible = systemFrame.Visible

local function tryRefreshOnOpen()
	if REST_DATA then return end
	if not supportFrame or not MyFeedback or not AdminFeedback or not OKButton then return end

	local now = os.clock()
	if now - lastSystemRefreshAt < REFRESH_COOLDOWN then
		return
	end

	lastSystemRefreshAt = now
	local rep = fetchReport()
	if rep then
		updateSupportUIFromData(rep)
	elseif supportFrame then
		supportFrame.Visible = false
		stopDotAnimation()
		currentReport = nil
	end
end

systemFrame:GetPropertyChangedSignal("Visible"):Connect(function()
	local nowVisible = systemFrame.Visible
	if (not lastSystemVisible) and nowVisible then
		tryRefreshOnOpen()
	end
	lastSystemVisible = nowVisible
end)

if systemFrame.Visible then
	lastSystemVisible = false
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
		Notify("Report Failed", "You must enter a message.", 5, {255, 100, 100})
		return
	end

	if length > MAX_LEN then
		Notify("Report Failed", "Message exceeds character limit!", 5, {255, 100, 100})
		return
	end

	if currentReport and reportExistsFromData(currentReport) then
		Notify("Report Locked", "You already have a pending report.", 6, {255, 200, 100})
		return
	end

	local success = SendReport(content)

	if success then
		currentReport = {
			player = player.Name,
			user_id = player.UserId,
			message = CleanMessage(content),
			timestamp = os.time() * 1000,
			responded = false,
			response = nil,
			responded_at = nil,
			response_type = nil
		}

		updateSupportUIFromData(currentReport)
		Notify("Report Sent", "Your report has been submitted successfully.", 6, {100, 255, 100})
		textBox.Text = ""
		maxText.Text = "0/" .. MAX_LEN
	else
		Notify("Error", "Failed to send report. Try again later.", 6, {255, 100, 100})
	end
end)
