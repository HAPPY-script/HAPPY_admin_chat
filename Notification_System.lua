local HAPPYscriptNotification = Instance.new("ScreenGui")
HAPPYscriptNotification.Name = "HAPPYscriptNotification"
HAPPYscriptNotification.ResetOnSpawn = false
HAPPYscriptNotification.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HAPPYscriptNotification.DisplayOrder = 99999
HAPPYscriptNotification.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local NotificationFrame = Instance.new("Frame")
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Position = UDim2.new(1, 0, 0.9, 0)
NotificationFrame.Size = UDim2.new(0, 250, 0, 75)
NotificationFrame.BackgroundColor3 = Color3.new(1, 1, 1)
NotificationFrame.BackgroundTransparency = 0.15000000596046448
NotificationFrame.BorderSizePixel = 0
NotificationFrame.BorderColor3 = Color3.new(0, 0, 0)
NotificationFrame.Visible = false
NotificationFrame.AnchorPoint = Vector2.new(1, 0.5)
NotificationFrame.Transparency = 0.15000000596046448
NotificationFrame.Parent = HAPPYscriptNotification

local UIGradient = Instance.new("UIGradient")
UIGradient.Name = "UIGradient"
UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.0431373, 0, 0.0627451)), ColorSequenceKeypoint.new(0.698962, Color3.new(0.0980392, 0, 0.137255)), ColorSequenceKeypoint.new(1, Color3.new(0.203922, 0, 0.203922))})
UIGradient.Rotation = 90
UIGradient.Parent = NotificationFrame

local Line = Instance.new("Frame")
Line.Name = "Line"
Line.Position = UDim2.new(0.003, 0, 0, 0)
Line.Size = UDim2.new(0.015, 0, 1, 0)
Line.BackgroundColor3 = Color3.new(1, 0, 1)
Line.BorderSizePixel = 0
Line.BorderColor3 = Color3.new(0, 0, 0)
Line.ZIndex = 2
Line.Parent = NotificationFrame

local UICorner = Instance.new("UICorner")
UICorner.Name = "UICorner"
UICorner.CornerRadius = UDim.new(0.25, 0)
UICorner.Parent = Line

local Text = Instance.new("TextLabel")
Text.Name = "Text"
Text.Position = UDim2.new(0.515, 0, 0.75, 0)
Text.Size = UDim2.new(0.95, 0, 0.5, 0)
Text.BackgroundColor3 = Color3.new(1, 1, 1)
Text.BackgroundTransparency = 1
Text.BorderSizePixel = 0
Text.BorderColor3 = Color3.new(0, 0, 0)
Text.AnchorPoint = Vector2.new(0.5, 0.5)
Text.Transparency = 1
Text.Text = "Goodluck!"
Text.TextColor3 = Color3.new(1, 1, 1)
Text.TextSize = 30
Text.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Text.TextScaled = true
Text.TextWrapped = true
Text.RichText = true
Text.Parent = NotificationFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Position = UDim2.new(0.515, 0, 0.25, 0)
Title.Size = UDim2.new(0.95, 0, 0.5, 0)
Title.BackgroundColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 0
Title.BorderColor3 = Color3.new(0, 0, 0)
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.Transparency = 1
Title.Text = "HAPPY script"
Title.TextColor3 = Color3.new(1, 0, 1)
Title.TextSize = 30
Title.FontFace = Font.new("rbxasset://fonts/families/PatrickHand.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Title.TextScaled = true
Title.TextWrapped = true
Title.Parent = NotificationFrame

local TimeFrame = Instance.new("Frame")
TimeFrame.Name = "TimeFrame"
TimeFrame.Position = UDim2.new(0.015, 0, 0.99, 0)
TimeFrame.Size = UDim2.new(1, 0, 0.03, 0)
TimeFrame.BackgroundColor3 = Color3.new(0, 0, 0)
TimeFrame.BorderSizePixel = 0
TimeFrame.BorderColor3 = Color3.new(0, 0, 0)
TimeFrame.AnchorPoint = Vector2.new(0, 0.5)
TimeFrame.Parent = NotificationFrame

local Time = Instance.new("Frame")
Time.Name = "Time"
Time.Position = UDim2.new(0.5, 0, 0.5, 0)
Time.Size = UDim2.new(1, 0, 1, 0)
Time.BackgroundColor3 = Color3.new(1, 0, 0.392157)
Time.BorderSizePixel = 0
Time.BorderColor3 = Color3.new(0, 0, 0)
Time.AnchorPoint = Vector2.new(0.5, 0.5)
Time.Parent = TimeFrame

local Frame = NotificationFrame
if not Frame then return end
task.spawn(function()
	while true do
		local allOk = true
		for _, obj in ipairs(Frame:GetDescendants()) do
			if obj:IsA("TextLabel")
			or obj:IsA("TextBox")
			or obj:IsA("TextButton") then
				if obj.TextTransparency ~= 0 then
					obj.TextTransparency = 0
					allOk = false
				end
			end
		end
		if allOk then break end
		task.wait(0.1)
	end
end)

--==============================================================================--
--======== SYSTEM ==============================================================--
--==============================================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui"):WaitForChild("HAPPYscriptNotification")
local template = gui:WaitForChild("NotificationFrame")

template.Visible = false

local START_POS = UDim2.new(1, 0, 1.1, 0)
local BASE_POS = UDim2.new(1, 0, 0.9, 0)
local STACK_Y = 80
local MAX_NOTIF = 6

local active = {}
local pending = {}
local running = false

local function getFadeObjects(root)
	local list = {}

	for _, obj in ipairs(root:GetDescendants()) do
		if obj:IsA("Frame") then
			table.insert(list, {obj, "BackgroundTransparency"})
		elseif obj:IsA("TextLabel") then
			table.insert(list, {obj, "TextTransparency"})
		elseif obj:IsA("ImageLabel") then
			table.insert(list, {obj, "ImageTransparency"})
		elseif obj:IsA("UIStroke") then
			table.insert(list, {obj, "Transparency"})
		end
	end

	-- include root luôn
	if root:IsA("Frame") then
		table.insert(list, {root, "BackgroundTransparency"})
	end

	return list
end

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
	end

	if item.Frame and item.Frame.Parent then
		local fadeObjects = getFadeObjects(item.Frame)

		for _, data in ipairs(fadeObjects) do
			local obj = data[1]
			local prop = data[2]

			if obj and obj.Parent then
				TweenService:Create(
					obj,
					TweenInfo.new(0.15),
					{ [prop] = 1 }
				):Play()
			end
		end

		task.delay(0.16, function()
			if item.Frame and item.Frame.Parent then
				item.Frame:Destroy()
			end
			reflow()
		end)
	else
		reflow()
	end
end

local function showNotif(data)
	if #active >= MAX_NOTIF then
		removeNotif(active[#active])
	end

	local frame = template:Clone()
	frame.Visible = true
	frame.Parent = gui
	frame.Position = START_POS

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
		local tween = TweenService:Create(
			timeBar,
			TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
			{ Size = UDim2.new(0, 0, 1, 0) }
		)
		tween:Play()
	end

	task.delay(duration, function()
		removeNotif(item)
	end)

    -- reset transparency chuẩn
    for _, obj in ipairs(frame:GetDescendants()) do
        if obj:IsA("Frame") then
            obj.BackgroundTransparency = 0.15
        elseif obj:IsA("TextLabel") then
            obj.TextTransparency = 0
        elseif obj:IsA("ImageLabel") then
            obj.ImageTransparency = 0
        elseif obj:IsA("UIStroke") then
            obj.Transparency = 0
        end
    end

    frame.BackgroundTransparency = 0.15
end

local function consumeGlobalNotification()
	local data = rawget(_G, "HAPPYnotification")
	if type(data) == "table" then
		_G.HAPPYnotification = nil
		table.insert(pending, data)
	end
end

task.spawn(function()
	while gui.Parent do
		consumeGlobalNotification()

		while #pending > 0 do
			local data = table.remove(pending, 1)
			showNotif(data)
		end

		task.wait(0.1)
	end
end)

--[[ HOOK
_G.HAPPYnotification = {
	title = "",
	text = "",
	color = {255, 255, 255},
	time = 5
}
]]
