local ALLOWED_PLACES = {
	85211729168715,
	2753915549,
	79091703265657,
	4442272183,
	7449423635,
	100117331123089,
}
local currentPlaceId = game.PlaceId
local allowed = false
for _, id in ipairs(ALLOWED_PLACES) do
	if id == currentPlaceId then
		allowed = true
		break
	end
end
if not allowed then
	return
end

local NotificationBloxFruit = Instance.new("ScreenGui")
NotificationBloxFruit.Name = "NotificationBloxFruit"
NotificationBloxFruit.ResetOnSpawn = false
NotificationBloxFruit.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
NotificationBloxFruit.DisplayOrder = 999999999
NotificationBloxFruit.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Effect = Instance.new("Frame")
Effect.Name = "Effect"
Effect.Position = UDim2.new(0.5, 0, 0.5, 0)
Effect.Size = UDim2.new(1, 0, 10, 0)
Effect.BackgroundColor3 = Color3.new(1, 1, 1)
Effect.BorderSizePixel = 0
Effect.BorderColor3 = Color3.new(0, 0, 0)
Effect.AnchorPoint = Vector2.new(0.5, 0.5)
Effect.Parent = NotificationBloxFruit

local UIGradient = Instance.new("UIGradient")
UIGradient.Name = "UIGradient"
UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.5, 1, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient.Parent = Effect

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Name = "ImageLabel"
ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel.Size = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel.BackgroundTransparency = 1
ImageLabel.BorderSizePixel = 0
ImageLabel.BorderColor3 = Color3.new(0, 0, 0)
ImageLabel.Visible = false
ImageLabel.ZIndex = 8889
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.Transparency = 1
ImageLabel.Image = "rbxassetid://103213240646444"
ImageLabel.Parent = NotificationBloxFruit

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint.AspectRatio = 1.7799999713897705
UIAspectRatioConstraint.Parent = ImageLabel

local UIStroke = Instance.new("UIStroke")
UIStroke.Name = "UIStroke"
UIStroke.Color = Color3.new(1, 1, 1)
UIStroke.Thickness = 2
UIStroke.Parent = ImageLabel

local Time = Instance.new("Frame")
Time.Name = "Time"
Time.Position = UDim2.new(0.75, 0, 0, 0)
Time.Size = UDim2.new(0.25, 0, 0.15, 0)
Time.BackgroundColor3 = Color3.new(0, 0, 0)
Time.BackgroundTransparency = 0.25
Time.BorderSizePixel = 0
Time.BorderColor3 = Color3.new(0, 0, 0)
Time.Transparency = 0.25
Time.Parent = ImageLabel

local S = Instance.new("TextLabel")
S.Name = "S"
S.Position = UDim2.new(0.675, 0, 0, 0)
S.Size = UDim2.new(0.33, 0, 1, 0)
S.BackgroundColor3 = Color3.new(1, 1, 1)
S.BackgroundTransparency = 1
S.BorderSizePixel = 0
S.BorderColor3 = Color3.new(0, 0, 0)
S.TextTransparency = 0
S.Text = "00"
S.TextColor3 = Color3.new(0.988235, 0.988235, 0.988235)
S.TextSize = 14
S.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
S.TextScaled = true
S.TextWrapped = true
S.Parent = Time

local UIGradient = Instance.new("UIGradient")
UIGradient.Name = "UIGradient"
UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.592157, 0.835294, 1)), ColorSequenceKeypoint.new(0.5, Color3.new(0.14902, 0.682353, 0.984314)), ColorSequenceKeypoint.new(0.6, Color3.new(0.988235, 0.980392, 0.0431373)), ColorSequenceKeypoint.new(1, Color3.new(0.988235, 0.980392, 0.0431373))})
UIGradient.Rotation = 100
UIGradient.Parent = S

local M = Instance.new("TextLabel")
M.Name = "M"
M.Position = UDim2.new(0.5, 0, 0, 0)
M.Size = UDim2.new(0.33, 0, 1, 0)
M.BackgroundColor3 = Color3.new(1, 1, 1)
M.BackgroundTransparency = 1
M.BorderSizePixel = 0
M.BorderColor3 = Color3.new(0, 0, 0)
M.AnchorPoint = Vector2.new(0.5, 0)
M.TextTransparency = 0
M.Text = "00"
M.TextColor3 = Color3.new(0.988235, 0.988235, 0.988235)
M.TextSize = 14
M.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
M.TextScaled = true
M.TextWrapped = true
M.Parent = Time

local UIGradient2 = Instance.new("UIGradient")
UIGradient2.Name = "UIGradient"
UIGradient2.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.592157, 0.835294, 1)), ColorSequenceKeypoint.new(0.5, Color3.new(0.14902, 0.682353, 0.984314)), ColorSequenceKeypoint.new(0.6, Color3.new(0.988235, 0.980392, 0.0431373)), ColorSequenceKeypoint.new(1, Color3.new(0.988235, 0.980392, 0.0431373))})
UIGradient2.Rotation = 100
UIGradient2.Parent = M

local H = Instance.new("TextLabel")
H.Name = "H"
H.Size = UDim2.new(0.33, 0, 1, 0)
H.BackgroundColor3 = Color3.new(1, 1, 1)
H.BackgroundTransparency = 1
H.BorderSizePixel = 0
H.BorderColor3 = Color3.new(0, 0, 0)
H.TextTransparency = 0
H.Text = "00"
H.TextColor3 = Color3.new(0.988235, 0.988235, 0.988235)
H.TextSize = 14
H.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
H.TextScaled = true
H.TextWrapped = true
H.Parent = Time

local UIGradient3 = Instance.new("UIGradient")
UIGradient3.Name = "UIGradient"
UIGradient3.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.592157, 0.835294, 1)), ColorSequenceKeypoint.new(0.5, Color3.new(0.14902, 0.682353, 0.984314)), ColorSequenceKeypoint.new(0.6, Color3.new(0.988235, 0.980392, 0.0431373)), ColorSequenceKeypoint.new(1, Color3.new(0.988235, 0.980392, 0.0431373))})
UIGradient3.Rotation = 100
UIGradient3.Parent = H

local Muli = Instance.new("TextLabel")
Muli.Name = "Muli"
Muli.Position = UDim2.new(0.67, 0, 0, 0)
Muli.Size = UDim2.new(0.33, 0, 1, 0)
Muli.BackgroundColor3 = Color3.new(1, 1, 1)
Muli.BackgroundTransparency = 1
Muli.BorderSizePixel = 0
Muli.BorderColor3 = Color3.new(0, 0, 0)
Muli.AnchorPoint = Vector2.new(0.5, 0)
Muli.TextTransparency = 0
Muli.Text = ":"
Muli.TextColor3 = Color3.new(0.988235, 0.988235, 0.988235)
Muli.TextSize = 14
Muli.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Muli.TextScaled = true
Muli.TextWrapped = true
Muli.Parent = Time

local UIGradient4 = Instance.new("UIGradient")
UIGradient4.Name = "UIGradient"
UIGradient4.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.14902, 0.682353, 0.984314)), ColorSequenceKeypoint.new(0.5, Color3.new(0.14902, 0.682353, 0.984314)), ColorSequenceKeypoint.new(0.6, Color3.new(0.988235, 0.980392, 0.0431373)), ColorSequenceKeypoint.new(1, Color3.new(0.988235, 0.980392, 0.0431373))})
UIGradient4.Rotation = 100
UIGradient4.Parent = Muli

local Muli2 = Instance.new("TextLabel")
Muli2.Name = "Muli"
Muli2.Position = UDim2.new(0.33, 0, 0, 0)
Muli2.Size = UDim2.new(0.33, 0, 1, 0)
Muli2.BackgroundColor3 = Color3.new(1, 1, 1)
Muli2.BackgroundTransparency = 1
Muli2.BorderSizePixel = 0
Muli2.BorderColor3 = Color3.new(0, 0, 0)
Muli2.AnchorPoint = Vector2.new(0.5, 0)
Muli2.TextTransparency = 0
Muli2.Text = ":"
Muli2.TextColor3 = Color3.new(0.988235, 0.988235, 0.988235)
Muli2.TextSize = 14
Muli2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Muli2.TextScaled = true
Muli2.TextWrapped = true
Muli2.Parent = Time

local UIGradient5 = Instance.new("UIGradient")
UIGradient5.Name = "UIGradient"
UIGradient5.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.14902, 0.682353, 0.984314)), ColorSequenceKeypoint.new(0.5, Color3.new(0.14902, 0.682353, 0.984314)), ColorSequenceKeypoint.new(0.6, Color3.new(0.988235, 0.980392, 0.0431373)), ColorSequenceKeypoint.new(1, Color3.new(0.988235, 0.980392, 0.0431373))})
UIGradient5.Rotation = 100
UIGradient5.Parent = Muli2

local UIStroke2 = Instance.new("UIStroke")
UIStroke2.Name = "UIStroke"
UIStroke2.Color = Color3.new(1, 1, 1)
UIStroke2.Thickness = 2
UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke2.Parent = Time

local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.AnchorPoint = Vector2.new(0.5, 0.5)
Close.Position = UDim2.new(0.043, 0, 0.925, 0)
Close.Size = UDim2.new(0.15, 0, 0.15, 0)
Close.BackgroundColor3 = Color3.new(0.882353, 0, 0)
Close.BorderSizePixel = 0
Close.BorderColor3 = Color3.new(0, 0, 0)
Close.Text = "x"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.TextSize = 14
Close.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Close.TextScaled = true
Close.TextWrapped = true
Close.Parent = ImageLabel

local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint2.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint2.Parent = Close

local UIStroke3 = Instance.new("UIStroke")
UIStroke3.Name = "UIStroke"
UIStroke3.Color = Color3.new(1, 1, 1)
UIStroke3.Thickness = 2
UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke3.Parent = Close

local Black = Instance.new("Frame")
Black.Name = "Black"
Black.Position = UDim2.new(0.5, 0, 0.5, 0)
Black.Size = UDim2.new(1, 0, 10, 0)
Black.BackgroundColor3 = Color3.new(0, 0, 0)
Black.BackgroundTransparency = 1
Black.BorderSizePixel = 0
Black.BorderColor3 = Color3.new(0, 0, 0)
Black.ZIndex = 8888
Black.AnchorPoint = Vector2.new(0.5, 0.5)
Black.Transparency = 1
Black.Parent = NotificationBloxFruit

local White = Instance.new("Frame")
White.Name = "White"
White.Position = UDim2.new(0.5, 0, 0.5, 0)
White.Size = UDim2.new(0.5, 0, 0.5, 0)
White.BackgroundColor3 = Color3.new(1, 1, 1)
White.BackgroundTransparency = 1
White.BorderSizePixel = 0
White.BorderColor3 = Color3.new(0, 0, 0)
White.ZIndex = 8890
White.AnchorPoint = Vector2.new(0.5, 0.5)
White.Transparency = 1
White.Parent = NotificationBloxFruit

local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint3.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint3.AspectRatio = 1.7799999713897705
UIAspectRatioConstraint3.Parent = White

local UIGradient6 = Instance.new("UIGradient")
UIGradient6.Name = "UIGradient"
UIGradient6.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient6.Rotation = -45
UIGradient6.Offset = Vector2.new(0, -2.5)
UIGradient6.Parent = White

-- SYSTEM --------------------------------------------------------------------------------------------

wait(5)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ========== CONFIG ==========
local TARGET_STR = "Dec 23, 11:00 PM" -- định dạng: "Mon D, HH:MM AM/PM" (hiểu là giờ VN)
local TEST_MODE = false              -- bật để test: đặt true => time = 75s (1m15s)
-- ============================

-- ===== GUI refs =====
local screenGui = playerGui:FindFirstChild("NotificationBloxFruit")
if not screenGui then return end

local black = screenGui:FindFirstChild("Black")
local white = screenGui:FindFirstChild("White")
local imageLabel = screenGui:FindFirstChild("ImageLabel")
if not (black and white and imageLabel) then return end

local closeBtn = imageLabel:FindFirstChild("Close")
local timeFrame = imageLabel:FindFirstChild("Time")
if not (closeBtn and timeFrame) then return end

local labelS = timeFrame:FindFirstChild("S")
local labelM = timeFrame:FindFirstChild("M")
local labelH = timeFrame:FindFirstChild("H")
if not (labelS and labelM and labelH) then return end

local whiteGradient = white:FindFirstChildOfClass("UIGradient")
-- Effect frame (may be nil => effect disabled)
local effectFrame = screenGui:FindFirstChild("Effect")
local effectGradient = effectFrame and effectFrame:FindFirstChildOfClass("UIGradient")

-- ===== date parsing & UTC helper (VN) =====
local monthMap = {
	Jan = 1, Feb = 2, Mar = 3, Apr = 4, May = 5, Jun = 6,
	Jul = 7, Aug = 8, Sep = 9, Oct = 10, Nov = 11, Dec = 12
}

local function parseTargetString(s)
	if type(s) ~= "string" then return nil end
	s = s:gsub("^%s*(.-)%s*$", "%1")
	local datePart, timePart = s:match("^([^,]+),%s*(.+)$")
	if not datePart then
		datePart, timePart = s:match("^([^%d]+%s%d+)%s+(.+)$")
	end
	if not datePart or not timePart then return nil end

	local monthStr, dayStr = datePart:match("^(%a+)%s+(%d+)$")
	local month = monthMap[monthStr]
	local day = tonumber(dayStr)
	if not month or not day then return nil end

	local hour, min, ampm = timePart:match("^(%d+):(%d+)%s*([AaPp][Mm])$")
	if not hour then return nil end
	hour = tonumber(hour)
	min = tonumber(min)
	ampm = ampm:upper()
	if ampm == "PM" and hour < 12 then hour = hour + 12 end
	if ampm == "AM" and hour == 12 then hour = 0 end

	return {month = month, day = day, hour = hour, min = min}
end

local function dateToUnixUTC(y, m, d, hh, mm, ss)
	if m <= 2 then y = y - 1; m = m + 12 end
	local A = math.floor(y / 100)
	local B = 2 - A + math.floor(A / 4)
	local jd = math.floor(365.25 * (y + 4716)) + math.floor(30.6001 * (m + 1)) + d + B - 1524.5
	local unixDays = jd - 2440587.5
	local seconds = math.floor(unixDays * 86400 + hh * 3600 + mm * 60 + ss + 0.5)
	return seconds
end

local function nowUnixUTC()
	local t = os.date("!*t")
	return dateToUnixUTC(t.year, t.month, t.day, t.hour, t.min, t.sec)
end

-- VN offset seconds
local VN_OFFSET = 7 * 3600

local function targetVNtoUTCunix(year, month, day, hourVN, minVN)
	local vn_asIfUTC = dateToUnixUTC(year, month, day, hourVN, minVN, 0)
	local targetUTC = vn_asIfUTC - VN_OFFSET
	return targetUTC
end

-- ===== parse target and early exit if in past (silent) =====
local parsed = parseTargetString(TARGET_STR)
if not parsed then return end

local currentUTC = nowUnixUTC()
local vnNowTable = os.date("!*t", currentUTC + VN_OFFSET)
local yearNowVN = vnNowTable.year

local targetUTCunix = targetVNtoUTCunix(yearNowVN, parsed.month, parsed.day, parsed.hour, parsed.min)
local nowUTC = currentUTC
local initialDelta = targetUTCunix - nowUTC

-- Test mode: override target to now + 75s
if TEST_MODE then
	targetUTCunix = nowUnixUTC() + 75
	initialDelta = targetUTCunix - nowUnixUTC()
end

if initialDelta <= 0 then return end

-- ===== helper tween =====
local function playTween(obj, info, props)
	local tw = TweenService:Create(obj, info, props)
	tw:Play()
	return tw
end

-- ===== size pop labels =====
local BASE_SIZE = UDim2.fromScale(0.33, 1)
local POP_SIZE  = UDim2.fromScale(0.36, 1.08)
labelS.Size = BASE_SIZE
labelM.Size = BASE_SIZE
labelH.Size = BASE_SIZE

local sizeTweens = {}
local function safeCancelTween(t) if t and t.Cancel then pcall(function() t:Cancel() end) end end

local function popLabel(label)
	if not label then return end
	local cur = sizeTweens[label]
	if cur then safeCancelTween(cur); sizeTweens[label] = nil end
	label.Size = BASE_SIZE
	local up = TweenService:Create(label, TweenInfo.new(0.08, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = POP_SIZE})
	local down = TweenService:Create(label, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = BASE_SIZE})
	sizeTweens[label] = up
	up:Play()
	up.Completed:Connect(function()
		sizeTweens[label] = down
		down:Play()
		down.Completed:Connect(function() sizeTweens[label] = nil end)
	end)
end

-- ===== Close sequence for ImageLabel (reuse existing behavior) =====
local closing = false
local function closeImageLabelSequence()
	if closing then return end
	closing = true

	-- cancel size tweens
	for lbl, t in pairs(sizeTweens) do
		safeCancelTween(t)
		sizeTweens[lbl] = nil
	end

	-- remove drag detector
	local drag = imageLabel:FindFirstChildOfClass("UIDragDetector")
	if drag then drag:Destroy() end

	-- White position + reset gradient
	white.Position = imageLabel.Position
	white.BackgroundTransparency = 1
	if whiteGradient then whiteGradient.Offset = Vector2.new(0, -2.5) end

	-- Fade in White
	local fadeIn = playTween(white, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0})
	fadeIn.Completed:Wait()

	-- hide ImageLabel
	imageLabel.Visible = false

	-- sweep gradient
	if whiteGradient then
		local sweep = playTween(whiteGradient, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Offset = Vector2.new(0, 2.5)})
		sweep.Completed:Wait()
	end
end

-- ===== Attach Close button =====
local closeConn
closeConn = closeBtn.MouseButton1Click:Connect(function()
	closeImageLabelSequence()
	if closeConn then closeConn:Disconnect() end
end)

-- ===== STARTUP ANIMATION (only if target in future) =====
black.BackgroundTransparency = 1
white.BackgroundTransparency = 1
imageLabel.Visible = false
if whiteGradient then whiteGradient.Offset = Vector2.new(0, -2.5) end

playTween(black, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}).Completed:Wait()
task.wait(0.5)
playTween(white, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}).Completed:Wait()
imageLabel.Visible = true
task.wait(1)
if whiteGradient then playTween(whiteGradient, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Offset = Vector2.new(0, 2.5)}).Completed:Wait() end
if not imageLabel:FindFirstChildOfClass("UIDragDetector") then Instance.new("UIDragDetector", imageLabel) end
playTween(black, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1})

-- ===== EFFECT SYSTEM (FIXED) =====
-- EFFECT RUN CONTROL FLAGS (ensure these exist once)
effectRunning = effectRunning or false
rainbowRunning = rainbowRunning or false
rainbowStop = rainbowStop or false

-- ====== Smooth Rainbow (slower & Sine InOut) ======
local function startRainbow(frame)
	if not frame then return end
	if rainbowRunning then return end
	rainbowRunning = true
	rainbowStop = false

	local colors = {
		Color3.fromRGB(255, 0, 0),
		Color3.fromRGB(255, 127, 0),
		Color3.fromRGB(255, 255, 0),
		Color3.fromRGB(0, 255, 0),
		Color3.fromRGB(0, 255, 255),
		Color3.fromRGB(0, 0, 255),
		Color3.fromRGB(255, 0, 255),
	}
	local idx = 1
	coroutine.wrap(function()
		while not rainbowStop do
			local nextIdx = (idx % #colors) + 1
			local c2 = colors[nextIdx]
			-- slower, smooth tween
			local tw = TweenService:Create(frame, TweenInfo.new(2.0, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundColor3 = c2})
			tw:Play()
			tw.Completed:Wait()
			idx = nextIdx
			-- tiny pause so transition looks continuous but smooth
			task.wait(0.02)
		end
		rainbowRunning = false
	end)()
end

local function stopRainbow()
	-- signal to stop; let ongoing tween finish the cycle
	rainbowStop = true
end

-- helper clamp & lerp
local function clamp(v, a, b) if v < a then return a elseif v > b then return b else return v end end
local function lerp(a, b, t) return a + (b - a) * t end

-- startEffectLoop:
-- WILL NOT use TweenService on effectGradient.Transparency (not tweenable).
-- Instead we'll set effectGradient.Transparency = NumberSequence.new({kp0,kp0_5,kp1}) each step.
local effectCoroutine
local function startEffectLoop()
	if effectRunning then return end
	if not effectFrame or not effectGradient then return end
	effectRunning = true

	local startClock = os.clock()
	local period = 1.0      -- pulse every 1 second (as requested)
	local updateRate = 0.06 -- how often we update (lower => smoother; ~60ms recommended)

	-- helper pulse shape (0..1)
	local function pulseShape(phase)
		-- smooth peak at phase=0.5, zero at 0 and 1
		-- using sin(pi*phase)^2 gives gentle rise/fall
		local s = math.sin(math.pi * phase)
		return s * s
	end

	effectCoroutine = coroutine.wrap(function()
		while true do
			local nowU = nowUnixUTC()
			local delta = targetUTCunix - nowU
			if delta <= 0 then break end
			local secs = delta

			-- default transparencies
			local v0, v05, v1 = 1, 1, 1

			-- compute elapsed phase [0..1] for pulse
			local elapsed = os.clock() - startClock
			local phase = (elapsed % period) / period
			local shape = pulseShape(phase) -- 0..1

			if secs > 60 then
				-- no effect
				v0, v05, v1 = 1, 1, 1

			elseif secs > 15 then
				-- 60 -> 15: Time0 & Time1 pulse; center stays 1.
				-- progress t from 0 (at 60s) -> 1 (at 15s)
				local t = (60 - secs) / 45
				t = clamp(t, 0, 1)

				-- base transparency falls linearly 1 -> 0 as t goes 0->1
				local base = 1 - t -- 1 -> 0

				-- amplitude grows smoothly from small -> larger
				local amp = lerp(0.08, math.min(0.9, base + 0.08), t) 
				-- v0 and v1 = base - amp * pulseShape
				-- give slight phase offset to v1 for visual variety
				local phase1 = ((elapsed + period * 0.22) % period) / period
				local shape1 = pulseShape(phase1)
				v0 = clamp(base - amp * shape, 0, 1)
				v1 = clamp(base - (amp * 0.85) * shape1, 0, 1)
				v05 = 1 -- center static during this phase

			else
				-- secs <= 15: Time0 & Time1 = 0; Time0.5 pulses from 1->0
				v0, v1 = 0, 0
				local t2 = clamp((15 - secs) / 15, 0, 1) -- 0 at 15s, 1 at 0s
				-- center base reduces 1->0
				local baseMid = 1 - t2
				-- amplitude increases as time goes down
				local ampMid = lerp(0.06, 0.95, t2)
				-- use pulseShape on same period (smooth)
				local shapeMid = pulseShape(phase)
				v05 = clamp(baseMid - ampMid * shapeMid, 0, 1)
			end

			-- apply NumberSequence directly (no Tween)
			local seq = NumberSequence.new({
				NumberSequenceKeypoint.new(0, v0),
				NumberSequenceKeypoint.new(0.5, v05),
				NumberSequenceKeypoint.new(1, v1),
			})
			effectGradient.Transparency = seq

			-- ensure rainbow running (slower & smooth)
			if effectFrame and not rainbowRunning then
				startRainbow(effectFrame)
			end

			task.wait(updateRate)
		end
	end)
	effectCoroutine()
end

-- ===== START COUNTDOWN LOOP =====
local function formatTwo(n) return string.format("%02d", math.max(0, math.floor(n))) end

local running = true
local lastS, lastM, lastH = nil, nil, nil

while running do
	local nowU = nowUnixUTC()
	local delta = targetUTCunix - nowU
	if delta <= 0 then
		-- reached -> first run ImageLabel close sequence
		closeImageLabelSequence()

		-- stop effect loop updating (it will naturally exit because delta<=0)
		-- Wait 3s (as you requested)
		task.wait(3)

		-- stop rainbow
		stopRainbow()

		-- Now fade effectGradient transparency to all 1 over 10s
		if effectGradient then
			-- read current keypoints values
			local curSeq = effectGradient.Transparency
			-- We'll interpolate each keypoint value toward 1 over duration
			local duration = 10
			local step = 0.08
			local steps = math.max(1, math.floor(duration / step))
			for i = 1, steps do
				local t = i / steps
				-- compute interpolated values
				-- If current sequence has 3 keypoints, map them; otherwise sample fallback.
				local k0 = curSeq.Keypoints[1] and curSeq.Keypoints[1].Value or 1
				local k05 = curSeq.Keypoints[2] and curSeq.Keypoints[2].Value or 1
				local k1 = curSeq.Keypoints[3] and curSeq.Keypoints[3].Value or 1
				local nv0 = lerp(k0, 1, t)
				local nv05 = lerp(k05, 1, t)
				local nv1 = lerp(k1, 1, t)
				effectGradient.Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, nv0),
					NumberSequenceKeypoint.new(0.5, nv05),
					NumberSequenceKeypoint.new(1, nv1),
				})
				-- also fade frame background transparency toward 1 if exists
				if effectFrame then
					local cur = effectFrame.BackgroundTransparency
					local target = 1
					local nt = lerp(cur, target, t)
					effectFrame.BackgroundTransparency = nt
				end
				task.wait(step)
			end
			-- ensure final = fully transparent
			effectGradient.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.5, 1),
				NumberSequenceKeypoint.new(1, 1),
			})
		end

		-- wait small buffer then destroy GUI
		task.wait(0.2)
		if screenGui and screenGui.Parent then screenGui:Destroy() end

		break
	end

	-- update labels
	local hours = math.floor(delta / 3600)
	local mins = math.floor((delta % 3600) / 60)
	local secs = math.floor(delta % 60)
	local displayH = hours
	if displayH > 99 then displayH = 99 end

	local sStr = formatTwo(secs)
	local mStr = formatTwo(mins)
	local hStr = formatTwo(displayH)

	if sStr ~= lastS then
		lastS = sStr
		pcall(function() labelS.Text = sStr end)
		popLabel(labelS)
	end
	if mStr ~= lastM then
		lastM = mStr
		pcall(function() labelM.Text = mStr end)
		popLabel(labelM)
	end
	if hStr ~= lastH then
		lastH = hStr
		pcall(function() labelH.Text = hStr end)
		popLabel(labelH)
	end

	-- Start effect when <= 60s (and only if Effect+UIGradient present)
	if delta <= 60 and effectFrame and effectGradient and not effectRunning then
		startEffectLoop()
	end

	-- short wait
	task.wait(0.2)
end

-- cleanup listeners if not already
if closeConn then
	pcall(function() closeConn:Disconnect() end)
	closeConn = nil
end

-- ensure rainbow stopped
stopRainbow()
