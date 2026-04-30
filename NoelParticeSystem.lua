-- EFFECT
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui"):WaitForChild("HAPPYscript")
local main = gui:WaitForChild("Main")
local scroll = main:WaitForChild("ScrollingFrame")
local particleTemplate = main:WaitForChild("Particle")

local SETTINGS = {
	SpawnRate = 0.5,
	MaxParticles = 180,
	MinSize = 5,
	MaxSize = 15,
	MinFallTime = 17,
	MaxFallTime = 25,
	MinRotation = -250,
	MaxRotation = 250,
}

local effectEnabled = main.Visible
local particleCount = 0
local activeParticles = {}

local function cleanupParticles()
	for particle in pairs(activeParticles) do
		if particle and particle.Parent then
			particle:Destroy()
		end
	end
	table.clear(activeParticles)
	particleCount = 0
end

main:GetPropertyChangedSignal("Visible"):Connect(function()
	effectEnabled = main.Visible
	if not effectEnabled then
		cleanupParticles()
	end
end)

local function createParticle()
	if not effectEnabled or not main.Visible or not main.Parent then return end
	if particleCount >= SETTINGS.MaxParticles then return end

	local particle = particleTemplate:Clone()
	particle.Visible = true
	particle.Parent = scroll
	particle.ImageTransparency = 1

	activeParticles[particle] = true
	particleCount += 1

	local function releaseParticle()
		if activeParticles[particle] then
			activeParticles[particle] = nil
			particleCount -= 1
		end
	end

	particle.AncestryChanged:Connect(function(_, parent)
		if not parent then
			releaseParticle()
		end
	end)

	local size = math.random(SETTINGS.MinSize, SETTINGS.MaxSize)
	particle.Size = UDim2.fromOffset(size, size)
	particle.Rotation = math.random(SETTINGS.MinRotation, SETTINGS.MaxRotation)
	particle.ZIndex = 1
	particle.AnchorPoint = Vector2.new(0.5, 0.5)
	particle.Position = UDim2.new(math.random(), 0, 0, -15)

	local fallTime = math.random(SETTINGS.MinFallTime, SETTINGS.MaxFallTime)
	local sideOffset = math.random(-40, 40)

	local fadeIn = TweenService:Create(
		particle,
		TweenInfo.new(fallTime * 0.1, Enum.EasingStyle.Linear),
		{ ImageTransparency = 0 }
	)
	fadeIn:Play()

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

	task.delay(fallTime * 0.9, function()
		if not particle.Parent or not effectEnabled then
			if particle.Parent then particle:Destroy() end
			return
		end

		local fadeOut = TweenService:Create(
			particle,
			TweenInfo.new(fallTime * 0.1, Enum.EasingStyle.Linear),
			{ ImageTransparency = 1 }
		)
		fadeOut:Play()

		fadeOut.Completed:Connect(function()
			if particle.Parent then
				particle:Destroy()
			end
		end)
	end)
end

task.spawn(function()
	while gui.Parent do
		if effectEnabled and main.Visible then
			createParticle()
			task.wait(SETTINGS.SpawnRate)
		else
			task.wait(0.25)
		end
	end
end)
