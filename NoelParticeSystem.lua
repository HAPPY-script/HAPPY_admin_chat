--EFFECT
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui"):WaitForChild("HAPPYscript")
local main = gui:WaitForChild("Main")
local particleTemplate = main:WaitForChild("Particle")

local SETTINGS = {
	SpawnRate = 0.5,
	MinSize = 10,
	MaxSize = 20,
	MinFallTime = 17,
	MaxFallTime = 25,
	MinRotation = -10,
	MaxRotation = 10,
}

local function createParticle()
	if #main.ScrollingFrame:GetChildren() > 180 then return end

	local particle = particleTemplate:Clone()
	particle.Visible = true
	particle.Parent = main.ScrollingFrame
	particle.ImageTransparency = 1 -- Bắt đầu mờ 100%

	-- Random size
	local size = math.random(SETTINGS.MinSize, SETTINGS.MaxSize)
	particle.Size = UDim2.fromOffset(size, size)

	-- Rotation
	particle.Rotation = math.random(SETTINGS.MinRotation, SETTINGS.MaxRotation)
	particle.ZIndex = 1

	particle.AnchorPoint = Vector2.new(0.5, 0.5)
	particle.Position = UDim2.new(math.random(), 0, 0, -15)

	local fallTime = math.random(SETTINGS.MinFallTime, SETTINGS.MaxFallTime)
	local sideOffset = math.random(-40, 40)

	----------------------------------------------------
	-- 1. FADE IN
	----------------------------------------------------
	local fadeIn = TweenService:Create(
		particle,
		TweenInfo.new(fallTime * 0.1, Enum.EasingStyle.Linear),
		{ImageTransparency = 0}
	)
	fadeIn:Play()

	----------------------------------------------------
	-- 2. MOVE
	----------------------------------------------------
	local move = TweenService:Create(
		particle,
		TweenInfo.new(fallTime, Enum.EasingStyle.Linear),
		{
			Position = UDim2.new(
				particle.Position.X.Scale + (sideOffset / main.AbsoluteSize.X),
				0,
				1,
				20
			)
		}
	)
	move:Play()

	----------------------------------------------------
	-- 3. FADE OUT (sau 90% thời gian)
	----------------------------------------------------
	task.delay(fallTime * 0.9, function()
		local fadeOut = TweenService:Create(
			particle,
			TweenInfo.new(fallTime * 0.1, Enum.EasingStyle.Linear),
			{ImageTransparency = 1}
		)
		fadeOut:Play()

		-- Destroy sau fade-out, KHÔNG phụ thuộc tween move
		fadeOut.Completed:Connect(function()
			particle:Destroy()
		end)
	end)
end

task.spawn(function()
	while true do
		createParticle()
		task.wait(SETTINGS.SpawnRate)
	end
end)
