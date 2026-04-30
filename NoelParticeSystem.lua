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
local activeParticles = {}

--------------------------------------------------
-- PAUSE / RESUME SYSTEM
--------------------------------------------------
local function pauseParticle(p)
	if p._moveTween then
		p._moveTween:Cancel()
	end
	if p._fadeTween then
		p._fadeTween:Cancel()
	end
end

local function resumeParticle(p)
	if not p or not p.Parent then return end

	local remainingTime = p._remainingTime or 5
	local targetY = 1

	p._moveTween = TweenService:Create(
		p,
		TweenInfo.new(remainingTime, Enum.EasingStyle.Linear),
		{
			Position = UDim2.new(
				p.Position.X.Scale,
				0,
				targetY,
				20
			)
		}
	)
	p._moveTween:Play()

	-- Fade out cuối
	task.delay(remainingTime * 0.9, function()
		if not p.Parent then return end

		p._fadeTween = TweenService:Create(
			p,
			TweenInfo.new(remainingTime * 0.1),
			{ ImageTransparency = 1 }
		)
		p._fadeTween:Play()

		p._fadeTween.Completed:Once(function()
			if p.Parent then
				p:Destroy()
			end
		end)
	end)
end

--------------------------------------------------
-- HANDLE VISIBILITY
--------------------------------------------------
main:GetPropertyChangedSignal("Visible"):Connect(function()
	effectEnabled = main.Visible

	if not effectEnabled then
		-- PAUSE tất cả
		for p in pairs(activeParticles) do
			if p and p.Parent then
				p._remainingTime = 5 -- fallback (có thể nâng cấp tracking real time)
				pauseParticle(p)
			end
		end
	else
		-- RESUME tất cả
		for p in pairs(activeParticles) do
			resumeParticle(p)
		end
	end
end)

--------------------------------------------------
-- CREATE PARTICLE
--------------------------------------------------
local function createParticle()
	if not effectEnabled then return end
	if table.getn(activeParticles) >= SETTINGS.MaxParticles then return end

	local p = particleTemplate:Clone()
	p.Visible = true
	p.Parent = scroll
	p.ImageTransparency = 1

	activeParticles[p] = true

	p.AncestryChanged:Connect(function(_, parent)
		if not parent then
			activeParticles[p] = nil
		end
	end)

	local size = math.random(SETTINGS.MinSize, SETTINGS.MaxSize)
	p.Size = UDim2.fromOffset(size, size)
	p.Rotation = math.random(SETTINGS.MinRotation, SETTINGS.MaxRotation)
	p.AnchorPoint = Vector2.new(0.5, 0.5)
	p.Position = UDim2.new(math.random(), 0, 0, -15)

	local fallTime = math.random(SETTINGS.MinFallTime, SETTINGS.MaxFallTime)
	p._remainingTime = fallTime

	-- Fade in
	local fadeIn = TweenService:Create(
		p,
		TweenInfo.new(fallTime * 0.1),
		{ ImageTransparency = 0 }
	)
	fadeIn:Play()

	-- Move
	p._moveTween = TweenService:Create(
		p,
		TweenInfo.new(fallTime, Enum.EasingStyle.Linear),
		{ Position = UDim2.new(p.Position.X.Scale, 0, 1, 20) }
	)
	p._moveTween:Play()

	-- Fade out
	task.delay(fallTime * 0.9, function()
		if not p.Parent then return end

		p._fadeTween = TweenService:Create(
			p,
			TweenInfo.new(fallTime * 0.1),
			{ ImageTransparency = 1 }
		)
		p._fadeTween:Play()

		p._fadeTween.Completed:Once(function()
			if p.Parent then
				p:Destroy()
			end
		end)
	end)
end

--------------------------------------------------
-- LOOP
--------------------------------------------------
task.spawn(function()
	while gui.Parent do
		if effectEnabled then
			createParticle()
			task.wait(SETTINGS.SpawnRate)
		else
			task.wait(0.3)
		end
	end
end)
