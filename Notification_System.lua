local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function ensureChild(parent, className, name)
	local obj = parent:FindFirstChild(name)
	if obj and obj.ClassName ~= className then
		obj:Destroy()
		obj = nil
	end
	if not obj then
		obj = Instance.new(className)
		obj.Name = name
		obj.Parent = parent
	end
	return obj
end

--------------------------------------------------------
-- UI CREATE / ENSURE
--------------------------------------------------------
local HAPPYscriptNotification = ensureChild(playerGui, "ScreenGui", "HAPPYscriptNotification")
HAPPYscriptNotification.ResetOnSpawn = false
HAPPYscriptNotification.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HAPPYscriptNotification.DisplayOrder = 99999

local NotificationFrame = ensureChild(HAPPYscriptNotification, "Frame", "NotificationFrame")
NotificationFrame.Position = UDim2.new(1, 0, 0.9, 0)
NotificationFrame.Size = UDim2.new(0, 250, 0, 75)
NotificationFrame.BackgroundColor3 = Color3.new(1, 1, 1)
NotificationFrame.BackgroundTransparency = 0.15
NotificationFrame.BorderSizePixel = 0
NotificationFrame.BorderColor3 = Color3.new(0, 0, 0)
NotificationFrame.Visible = false
NotificationFrame.AnchorPoint = Vector2.new(1, 0.5)

local UIGradient = ensureChild(NotificationFrame, "UIGradient", "UIGradient")
UIGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.new(0.0431373, 0, 0.0627451)),
	ColorSequenceKeypoint.new(0.698962, Color3.new(0.0980392, 0, 0.137255)),
	ColorSequenceKeypoint.new(1, Color3.new(0.203922, 0, 0.203922))
})
UIGradient.Rotation = 90

local Line = ensureChild(NotificationFrame, "Frame", "Line")
Line.Position = UDim2.new(0, 0, 0, 0)
Line.Size = UDim2.new(0.015, 0, 1, 0)
Line.BackgroundColor3 = Color3.new(1, 0, 1)
Line.BorderSizePixel = 0
Line.BorderColor3 = Color3.new(0, 0, 0)
Line.ZIndex = 2

local LineCorner = ensureChild(Line, "UICorner", "UICorner")
LineCorner.CornerRadius = UDim.new(0.25, 0)

local Text = ensureChild(NotificationFrame, "TextLabel", "Text")
Text.Position = UDim2.new(0.515, 0, 0.75, 0)
Text.Size = UDim2.new(0.95, 0, 0.5, 0)
Text.BackgroundColor3 = Color3.new(1, 1, 1)
Text.BackgroundTransparency = 1
Text.BorderSizePixel = 0
Text.BorderColor3 = Color3.new(0, 0, 0)
Text.AnchorPoint = Vector2.new(0.5, 0.5)
Text.Text = "Goodluck!"
Text.TextColor3 = Color3.new(1, 1, 1)
Text.TextTransparency = 0
Text.TextStrokeTransparency = 1
Text.TextSize = 30
Text.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Text.TextScaled = true
Text.TextWrapped = true
Text.RichText = true

local Title = ensureChild(NotificationFrame, "TextLabel", "Title")
Title.Position = UDim2.new(0.515, 0, 0.25, 0)
Title.Size = UDim2.new(0.95, 0, 0.5, 0)
Title.BackgroundColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 0
Title.BorderColor3 = Color3.new(0, 0, 0)
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.Text = "HAPPY script"
Title.TextColor3 = Color3.new(1, 0, 1)
Title.TextTransparency = 0
Title.TextStrokeTransparency = 1
Title.TextSize = 30
Title.FontFace = Font.new("rbxasset://fonts/families/PatrickHand.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Title.TextScaled = true
Title.TextWrapped = true

local TimeFrame = ensureChild(NotificationFrame, "Frame", "TimeFrame")
TimeFrame.Position = UDim2.new(0.015, 0, 0.99, 0)
TimeFrame.Size = UDim2.new(1, 0, 0.03, 0)
TimeFrame.BackgroundColor3 = Color3.new(0, 0, 0)
TimeFrame.BorderSizePixel = 0
TimeFrame.BorderColor3 = Color3.new(0, 0, 0)
TimeFrame.AnchorPoint = Vector2.new(0, 0.5)

local Time = ensureChild(TimeFrame, "Frame", "Time")
Time.Position = UDim2.new(0.5, 0, 0.5, 0)
Time.Size = UDim2.new(1, 0, 1, 0)
Time.BackgroundColor3 = Color3.new(1, 0, 0.392157)
Time.BorderSizePixel = 0
Time.BorderColor3 = Color3.new(0, 0, 0)
Time.AnchorPoint = Vector2.new(0.5, 0.5)

template = NotificationFrame
template.Visible = false

--------------------------------------------------------
-- SYSTEM
--------------------------------------------------------
local START_POS = UDim2.new(1, 0, 1.1, 0)
local BASE_POS = UDim2.new(1, 0, 0.9, 0)
local STACK_Y = 80
local MAX_NOTIF = 6

local active = {}
local pending = {}
local processing = false

local function toColor3(v)
	if typeof(v) == "Color3" then
		return v
	end

	if type(v) == "table" then
		local r, g, b = v[1], v[2], v[3]
		if type(r) == "number" and type(g) == "number" and type(b) == "number" then
			if r <= 1 and g <= 1 and b <= 1 then
				return Color3.new(r, g, b)
			end
			return Color3.fromRGB(r, g, b)
		end

		if type(v.r) == "number" and type(v.g) == "number" and type(v.b) == "number" then
			if v.r <= 1 and v.g <= 1 and v.b <= 1 then
				return Color3.new(v.r, v.g, v.b)
			end
			return Color3.fromRGB(v.r, v.g, v.b)
		end
	end

	return Color3.fromRGB(255, 255, 255)
end

local function clearText(s)
	if type(s) ~= "string" then
		return ""
	end
	return s
end

local function getTitleLabel(frame)
	return frame:FindFirstChild("Title")
end

local function getTextLabel(frame)
	return frame:FindFirstChild("Text")
end

local function getTimeBar(frame)
	local timeFrame = frame:FindFirstChild("TimeFrame")
	if not timeFrame then return nil end
	return timeFrame:FindFirstChild("Time")
end

local function collectFadeObjects(root)
	local list = {}

	local function add(obj, prop)
		list[#list + 1] = { obj = obj, prop = prop }
	end

	local function walk(obj)
		if obj:IsA("Frame") or obj:IsA("ScrollingFrame") then
			add(obj, "BackgroundTransparency")
		elseif obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
			add(obj, "TextTransparency")
			add(obj, "TextStrokeTransparency")
		elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
			add(obj, "ImageTransparency")
		elseif obj:IsA("UIStroke") then
			add(obj, "Transparency")
		end

		for _, child in ipairs(obj:GetChildren()) do
			walk(child)
		end
	end

	walk(root)
	return list
end

local function reflow()
	for i, item in ipairs(active) do
		if item and item.Frame and item.Frame.Parent then
			local target = UDim2.new(
				BASE_POS.X.Scale,
				BASE_POS.X.Offset,
				BASE_POS.Y.Scale,
				BASE_POS.Y.Offset - ((i - 1) * STACK_Y)
			)

			TweenService:Create(
				item.Frame,
				TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ Position = target }
			):Play()
		end
	end
end

local function removeNotif(item)
	if not item or item.Removed then return end
	item.Removed = true

	local idx = table.find(active, item)
	if idx then
		table.remove(active, idx)
		reflow()
	end

	if item.Frame and item.Frame.Parent then
		local fadeObjects = collectFadeObjects(item.Frame)

		for _, data in ipairs(fadeObjects) do
			local obj = data.obj
			local prop = data.prop

			if obj and obj.Parent then
				pcall(function()
					TweenService:Create(
						obj,
						TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ [prop] = 1 }
					):Play()
				end)
			end
		end

		task.delay(0.16, function()
			if item.Frame and item.Frame.Parent then
				item.Frame:Destroy()
			end
		end)
	end
end

local function showNotif(data)
	if #active >= MAX_NOTIF then
		removeNotif(active[#active])
	end

	local frame = template:Clone()
	frame.Visible = true
	frame.Parent = HAPPYscriptNotification
	frame.Position = START_POS
	frame.BackgroundTransparency = 0.15

	local titleValue = clearText(data.title)
	local textValue = clearText(data.text)
	local colorValue = toColor3(data.color)
	local duration = tonumber(data.time) or 1
	if duration <= 0 then duration = 1 end

	local title = getTitleLabel(frame)
	local text = getTextLabel(frame)
	local timeBar = getTimeBar(frame)

	if title then
		title.Text = titleValue
	end

	if text then
		text.RichText = true
		text.Text = textValue
		text.TextColor3 = colorValue
	end

	if timeBar then
		timeBar.Size = UDim2.new(1, 0, 1, 0)
	end

	local item = {
		Frame = frame,
		Removed = false,
	}

	table.insert(active, 1, item)
	reflow()

	if timeBar then
		TweenService:Create(
			timeBar,
			TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
			{ Size = UDim2.new(0, 0, 1, 0) }
		):Play()
	end

	task.delay(duration, function()
		removeNotif(item)
	end)
end

local function enqueueNotification(data)
	if type(data) ~= "table" then
		return
	end

	pending[#pending + 1] = data

	if processing then
		return
	end

	processing = true
	task.spawn(function()
		while #pending > 0 do
			local dataToShow = table.remove(pending, 1)
			showNotif(dataToShow)
		end
		processing = false
	end)
end

local oldMeta = getmetatable(_G)
local oldNewIndex = oldMeta and oldMeta.__newindex

pcall(function()
	setmetatable(_G, {
		__newindex = function(t, k, v)
			if k == "HAPPYnotification" and type(v) == "table" then
				enqueueNotification(v)
				return
			end

			if type(oldNewIndex) == "function" then
				oldNewIndex(t, k, v)
			else
				rawset(t, k, v)
			end
		end
	})
end)

local existing = rawget(_G, "HAPPYnotification")
if type(existing) == "table" then
	rawset(_G, "HAPPYnotification", nil)
	enqueueNotification(existing)
end

--[[ USE
_G.HAPPYnotification = {
	title = "title",
	text = "text",
	color = {255, 255, 255},
	time = 5
}
]]
