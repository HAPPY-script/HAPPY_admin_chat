local sf = game.Players.LocalPlayer.PlayerGui:WaitForChild("HAPPYscript").Main.ScrollingFrame

local GameHub = Instance.new("Frame")
GameHub.Name = "GameHub"
GameHub.Size = UDim2.new(1, 0, 1, 0)
GameHub.BackgroundColor3 = Color3.new(1, 1, 1)
GameHub.BackgroundTransparency = 1
GameHub.BorderSizePixel = 0
GameHub.BorderColor3 = Color3.new(0, 0, 0)
GameHub.Transparency = 1
GameHub.Parent = sf

local BloxFruit = Instance.new("ImageButton")
BloxFruit.Name = "BloxFruit"
BloxFruit.Position = UDim2.new(0.2, 0, 0.2, 0)
BloxFruit.Size = UDim2.new(0.25, 0, 0.25, 0)
BloxFruit.BackgroundColor3 = Color3.new(1, 1, 1)
BloxFruit.BackgroundTransparency = 1
BloxFruit.BorderSizePixel = 0
BloxFruit.BorderColor3 = Color3.new(0, 0, 0)
BloxFruit.AnchorPoint = Vector2.new(0.5, 0.5)
BloxFruit.Transparency = 1
BloxFruit.Image = "rbxassetid://135114933434081"
BloxFruit.Parent = GameHub

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint.Parent = BloxFruit

local UICorner = Instance.new("UICorner")
UICorner.Name = "UICorner"
UICorner.CornerRadius = UDim.new(0.1, 0)
UICorner.Parent = BloxFruit

local UIStroke = Instance.new("UIStroke")
UIStroke.Name = "UIStroke"
UIStroke.Color = Color3.new(1, 1, 1)
UIStroke.Thickness = 1.5
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = BloxFruit

local UIGradient = Instance.new("UIGradient")
UIGradient.Name = "UIGradient"
UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient.Rotation = 90
UIGradient.Offset = Vector2.new(0, 1)
UIGradient.Parent = BloxFruit

local Name = Instance.new("TextLabel")
Name.Name = "Name"
Name.Position = UDim2.new(0, 0, 0.7, 0)
Name.Size = UDim2.new(1, 0, 0.3, 0)
Name.BackgroundColor3 = Color3.new(1, 1, 1)
Name.BackgroundTransparency = 1
Name.BorderSizePixel = 0
Name.BorderColor3 = Color3.new(0, 0, 0)
Name.ZIndex = 2
Name.Transparency = 1
Name.Text = "Blox Fruit"
Name.TextColor3 = Color3.new(1, 0.588235, 0)
Name.TextSize = 14
Name.FontFace = Font.new("rbxasset://fonts/families/PermanentMarker.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Name.TextScaled = true
Name.TextWrapped = true
Name.Parent = BloxFruit

local Effect = Instance.new("Frame")
Effect.Name = "Effect"
Effect.Size = UDim2.new(1, 0, 1, 0)
Effect.BackgroundColor3 = Color3.new(1, 1, 1)
Effect.BorderSizePixel = 0
Effect.BorderColor3 = Color3.new(0, 0, 0)
Effect.Parent = BloxFruit

local UICorner2 = Instance.new("UICorner")
UICorner2.Name = "UICorner"
UICorner2.CornerRadius = UDim.new(0.1, 0)
UICorner2.Parent = Effect

local UIGradient2 = Instance.new("UIGradient")
UIGradient2.Name = "UIGradient"
UIGradient2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.35, 1, 0), NumberSequenceKeypoint.new(0.5, 0.25, 0), NumberSequenceKeypoint.new(0.65, 1, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient2.Rotation = -45
UIGradient2.Offset = Vector2.new(0, -1.5)
UIGradient2.Parent = Effect

local Loading = Instance.new("Frame")
Loading.Name = "Loading"
Loading.Position = UDim2.new(0.5, 0, 0.5, 0)
Loading.Size = UDim2.new(1, 0, 1, 0)
Loading.BackgroundColor3 = Color3.new(0, 0, 0)
Loading.BackgroundTransparency = 0.10000000149011612
Loading.BorderSizePixel = 0
Loading.BorderColor3 = Color3.new(0, 0, 0)
Loading.Visible = false
Loading.AnchorPoint = Vector2.new(0.5, 0.5)
Loading.Transparency = 0.10000000149011612
Loading.Parent = BloxFruit

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Name = "ImageLabel"
ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel.Size = UDim2.new(0.75, 0, 0.75, 0)
ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel.BackgroundTransparency = 1
ImageLabel.BorderSizePixel = 0
ImageLabel.BorderColor3 = Color3.new(0, 0, 0)
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.Transparency = 1
ImageLabel.Image = "rbxassetid://17687447043"
ImageLabel.Parent = Loading

local UICorner3 = Instance.new("UICorner")
UICorner3.Name = "UICorner"
UICorner3.CornerRadius = UDim.new(0.1, 0)
UICorner3.Parent = Loading

local MM2 = Instance.new("ImageButton")
MM2.Name = "MM2"
MM2.Position = UDim2.new(0.5, 0, 0.2, 0)
MM2.Size = UDim2.new(0.25, 0, 0.25, 0)
MM2.BackgroundColor3 = Color3.new(1, 1, 1)
MM2.BackgroundTransparency = 1
MM2.BorderSizePixel = 0
MM2.BorderColor3 = Color3.new(0, 0, 0)
MM2.AnchorPoint = Vector2.new(0.5, 0.5)
MM2.Transparency = 1
MM2.Image = "rbxassetid://135054338652333"
MM2.Parent = GameHub

local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint2.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint2.Parent = MM2

local UICorner4 = Instance.new("UICorner")
UICorner4.Name = "UICorner"
UICorner4.CornerRadius = UDim.new(0.1, 0)
UICorner4.Parent = MM2

local UIStroke2 = Instance.new("UIStroke")
UIStroke2.Name = "UIStroke"
UIStroke2.Color = Color3.new(1, 1, 1)
UIStroke2.Thickness = 1.5
UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke2.Parent = MM2

local UIGradient3 = Instance.new("UIGradient")
UIGradient3.Name = "UIGradient"
UIGradient3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient3.Rotation = 90
UIGradient3.Offset = Vector2.new(0, 1)
UIGradient3.Parent = MM2

local Name2 = Instance.new("TextLabel")
Name2.Name = "Name"
Name2.Position = UDim2.new(0, 0, 0.7, 0)
Name2.Size = UDim2.new(1, 0, 0.3, 0)
Name2.BackgroundColor3 = Color3.new(1, 1, 1)
Name2.BackgroundTransparency = 1
Name2.BorderSizePixel = 0
Name2.BorderColor3 = Color3.new(0, 0, 0)
Name2.ZIndex = 2
Name2.Transparency = 1
Name2.Text = "Murder Mystery 2"
Name2.TextColor3 = Color3.new(0.235294, 1, 0)
Name2.TextSize = 14
Name2.FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name2.TextScaled = true
Name2.TextWrapped = true
Name2.Parent = MM2

local Effect2 = Instance.new("Frame")
Effect2.Name = "Effect"
Effect2.Size = UDim2.new(1, 0, 1, 0)
Effect2.BackgroundColor3 = Color3.new(1, 1, 1)
Effect2.BorderSizePixel = 0
Effect2.BorderColor3 = Color3.new(0, 0, 0)
Effect2.Parent = MM2

local UICorner5 = Instance.new("UICorner")
UICorner5.Name = "UICorner"
UICorner5.CornerRadius = UDim.new(0.1, 0)
UICorner5.Parent = Effect2

local UIGradient4 = Instance.new("UIGradient")
UIGradient4.Name = "UIGradient"
UIGradient4.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.35, 1, 0), NumberSequenceKeypoint.new(0.5, 0.25, 0), NumberSequenceKeypoint.new(0.65, 1, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient4.Rotation = -45
UIGradient4.Offset = Vector2.new(0, -1.5)
UIGradient4.Parent = Effect2

local Loading2 = Instance.new("Frame")
Loading2.Name = "Loading"
Loading2.Position = UDim2.new(0.5, 0, 0.5, 0)
Loading2.Size = UDim2.new(1, 0, 1, 0)
Loading2.BackgroundColor3 = Color3.new(0, 0, 0)
Loading2.BackgroundTransparency = 0.10000000149011612
Loading2.BorderSizePixel = 0
Loading2.BorderColor3 = Color3.new(0, 0, 0)
Loading2.Visible = false
Loading2.AnchorPoint = Vector2.new(0.5, 0.5)
Loading2.Transparency = 0.10000000149011612
Loading2.Parent = MM2

local ImageLabel2 = Instance.new("ImageLabel")
ImageLabel2.Name = "ImageLabel"
ImageLabel2.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel2.Size = UDim2.new(0.75, 0, 0.75, 0)
ImageLabel2.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel2.BackgroundTransparency = 1
ImageLabel2.BorderSizePixel = 0
ImageLabel2.BorderColor3 = Color3.new(0, 0, 0)
ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel2.Transparency = 1
ImageLabel2.Image = "rbxassetid://17687447043"
ImageLabel2.Parent = Loading2

local UICorner6 = Instance.new("UICorner")
UICorner6.Name = "UICorner"
UICorner6.CornerRadius = UDim.new(0.1, 0)
UICorner6.Parent = Loading2

local DeadRails = Instance.new("ImageButton")
DeadRails.Name = "DeadRails"
DeadRails.Position = UDim2.new(0.8, 0, 0.2, 0)
DeadRails.Size = UDim2.new(0.25, 0, 0.25, 0)
DeadRails.BackgroundColor3 = Color3.new(1, 1, 1)
DeadRails.BackgroundTransparency = 1
DeadRails.BorderSizePixel = 0
DeadRails.BorderColor3 = Color3.new(0, 0, 0)
DeadRails.AnchorPoint = Vector2.new(0.5, 0.5)
DeadRails.Transparency = 1
DeadRails.Image = "rbxassetid://128584266579507"
DeadRails.Parent = GameHub

local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint3.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint3.Parent = DeadRails

local UICorner7 = Instance.new("UICorner")
UICorner7.Name = "UICorner"
UICorner7.CornerRadius = UDim.new(0.1, 0)
UICorner7.Parent = DeadRails

local UIStroke3 = Instance.new("UIStroke")
UIStroke3.Name = "UIStroke"
UIStroke3.Color = Color3.new(1, 1, 1)
UIStroke3.Thickness = 1.5
UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke3.Parent = DeadRails

local UIGradient5 = Instance.new("UIGradient")
UIGradient5.Name = "UIGradient"
UIGradient5.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))})
UIGradient5.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient5.Rotation = 90
UIGradient5.Offset = Vector2.new(0, 1)
UIGradient5.Parent = DeadRails

local Name3 = Instance.new("TextLabel")
Name3.Name = "Name"
Name3.Position = UDim2.new(0, 0, 0.7, 0)
Name3.Size = UDim2.new(1, 0, 0.3, 0)
Name3.BackgroundColor3 = Color3.new(1, 1, 1)
Name3.BackgroundTransparency = 1
Name3.BorderSizePixel = 0
Name3.BorderColor3 = Color3.new(0, 0, 0)
Name3.ZIndex = 2
Name3.Transparency = 1
Name3.Text = "Dead Rails"
Name3.TextColor3 = Color3.new(1, 0.635294, 0)
Name3.TextSize = 14
Name3.FontFace = Font.new("rbxasset://fonts/families/Fondamento.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name3.TextScaled = true
Name3.TextWrapped = true
Name3.Parent = DeadRails

local Effect3 = Instance.new("Frame")
Effect3.Name = "Effect"
Effect3.Size = UDim2.new(1, 0, 1, 0)
Effect3.BackgroundColor3 = Color3.new(1, 1, 1)
Effect3.BorderSizePixel = 0
Effect3.BorderColor3 = Color3.new(0, 0, 0)
Effect3.Parent = DeadRails

local UICorner8 = Instance.new("UICorner")
UICorner8.Name = "UICorner"
UICorner8.CornerRadius = UDim.new(0.1, 0)
UICorner8.Parent = Effect3

local UIGradient6 = Instance.new("UIGradient")
UIGradient6.Name = "UIGradient"
UIGradient6.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.35, 1, 0), NumberSequenceKeypoint.new(0.5, 0.25, 0), NumberSequenceKeypoint.new(0.65, 1, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient6.Rotation = -45
UIGradient6.Offset = Vector2.new(0, -1.5)
UIGradient6.Parent = Effect3

local Loading3 = Instance.new("Frame")
Loading3.Name = "Loading"
Loading3.Position = UDim2.new(0.5, 0, 0.5, 0)
Loading3.Size = UDim2.new(1, 0, 1, 0)
Loading3.BackgroundColor3 = Color3.new(0, 0, 0)
Loading3.BackgroundTransparency = 0.10000000149011612
Loading3.BorderSizePixel = 0
Loading3.BorderColor3 = Color3.new(0, 0, 0)
Loading3.Visible = false
Loading3.AnchorPoint = Vector2.new(0.5, 0.5)
Loading3.Transparency = 0.10000000149011612
Loading3.Parent = DeadRails

local ImageLabel3 = Instance.new("ImageLabel")
ImageLabel3.Name = "ImageLabel"
ImageLabel3.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel3.Size = UDim2.new(0.75, 0, 0.75, 0)
ImageLabel3.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel3.BackgroundTransparency = 1
ImageLabel3.BorderSizePixel = 0
ImageLabel3.BorderColor3 = Color3.new(0, 0, 0)
ImageLabel3.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel3.Transparency = 1
ImageLabel3.Image = "rbxassetid://17687447043"
ImageLabel3.Parent = Loading3

local UICorner9 = Instance.new("UICorner")
UICorner9.Name = "UICorner"
UICorner9.CornerRadius = UDim.new(0.1, 0)
UICorner9.Parent = Loading3

local ZombieStories = Instance.new("ImageButton")
ZombieStories.Name = "ZombieStories"
ZombieStories.Position = UDim2.new(0.5, 0, 0.5, 0)
ZombieStories.Size = UDim2.new(0.25, 0, 0.25, 0)
ZombieStories.BackgroundColor3 = Color3.new(1, 1, 1)
ZombieStories.BackgroundTransparency = 1
ZombieStories.BorderSizePixel = 0
ZombieStories.BorderColor3 = Color3.new(0, 0, 0)
ZombieStories.AnchorPoint = Vector2.new(0.5, 0.5)
ZombieStories.Transparency = 1
ZombieStories.Image = "rbxassetid://121477254315198"
ZombieStories.Parent = GameHub

local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint4.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint4.Parent = ZombieStories

local UICorner10 = Instance.new("UICorner")
UICorner10.Name = "UICorner"
UICorner10.CornerRadius = UDim.new(0.1, 0)
UICorner10.Parent = ZombieStories

local UIStroke4 = Instance.new("UIStroke")
UIStroke4.Name = "UIStroke"
UIStroke4.Color = Color3.new(1, 1, 1)
UIStroke4.Thickness = 1.5
UIStroke4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke4.Parent = ZombieStories

local UIGradient7 = Instance.new("UIGradient")
UIGradient7.Name = "UIGradient"
UIGradient7.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))})
UIGradient7.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient7.Rotation = 90
UIGradient7.Offset = Vector2.new(0, 1)
UIGradient7.Parent = ZombieStories

local Name4 = Instance.new("TextLabel")
Name4.Name = "Name"
Name4.Position = UDim2.new(0, 0, 0.7, 0)
Name4.Size = UDim2.new(1, 0, 0.3, 0)
Name4.BackgroundColor3 = Color3.new(1, 1, 1)
Name4.BackgroundTransparency = 1
Name4.BorderSizePixel = 0
Name4.BorderColor3 = Color3.new(0, 0, 0)
Name4.ZIndex = 2
Name4.Transparency = 1
Name4.Text = "Zombie Stories"
Name4.TextColor3 = Color3.new(0.686275, 1, 0)
Name4.TextSize = 14
Name4.FontFace = Font.new("rbxasset://fonts/families/Creepster.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Name4.TextScaled = true
Name4.TextWrapped = true
Name4.Parent = ZombieStories

local Effect4 = Instance.new("Frame")
Effect4.Name = "Effect"
Effect4.Size = UDim2.new(1, 0, 1, 0)
Effect4.BackgroundColor3 = Color3.new(1, 1, 1)
Effect4.BorderSizePixel = 0
Effect4.BorderColor3 = Color3.new(0, 0, 0)
Effect4.Parent = ZombieStories

local UICorner11 = Instance.new("UICorner")
UICorner11.Name = "UICorner"
UICorner11.CornerRadius = UDim.new(0.1, 0)
UICorner11.Parent = Effect4

local UIGradient8 = Instance.new("UIGradient")
UIGradient8.Name = "UIGradient"
UIGradient8.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.35, 1, 0), NumberSequenceKeypoint.new(0.5, 0.25, 0), NumberSequenceKeypoint.new(0.65, 1, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient8.Rotation = -45
UIGradient8.Offset = Vector2.new(0, -1.5)
UIGradient8.Parent = Effect4

local Loading4 = Instance.new("Frame")
Loading4.Name = "Loading"
Loading4.Position = UDim2.new(0.5, 0, 0.5, 0)
Loading4.Size = UDim2.new(1, 0, 1, 0)
Loading4.BackgroundColor3 = Color3.new(0, 0, 0)
Loading4.BackgroundTransparency = 0.10000000149011612
Loading4.BorderSizePixel = 0
Loading4.BorderColor3 = Color3.new(0, 0, 0)
Loading4.Visible = false
Loading4.AnchorPoint = Vector2.new(0.5, 0.5)
Loading4.Transparency = 0.10000000149011612
Loading4.Parent = ZombieStories

local ImageLabel4 = Instance.new("ImageLabel")
ImageLabel4.Name = "ImageLabel"
ImageLabel4.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel4.Size = UDim2.new(0.75, 0, 0.75, 0)
ImageLabel4.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel4.BackgroundTransparency = 1
ImageLabel4.BorderSizePixel = 0
ImageLabel4.BorderColor3 = Color3.new(0, 0, 0)
ImageLabel4.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel4.Transparency = 1
ImageLabel4.Image = "rbxassetid://17687447043"
ImageLabel4.Parent = Loading4

local UICorner12 = Instance.new("UICorner")
UICorner12.Name = "UICorner"
UICorner12.CornerRadius = UDim.new(0.1, 0)
UICorner12.Parent = Loading4

local GunfightArena = Instance.new("ImageButton")
GunfightArena.Name = "GunfightArena"
GunfightArena.Position = UDim2.new(0.2, 0, 0.5, 0)
GunfightArena.Size = UDim2.new(0.25, 0, 0.25, 0)
GunfightArena.BackgroundColor3 = Color3.new(1, 1, 1)
GunfightArena.BackgroundTransparency = 1
GunfightArena.BorderSizePixel = 0
GunfightArena.BorderColor3 = Color3.new(0, 0, 0)
GunfightArena.AnchorPoint = Vector2.new(0.5, 0.5)
GunfightArena.Transparency = 1
GunfightArena.Image = "rbxassetid://125737670706867"
GunfightArena.Parent = GameHub

local UIAspectRatioConstraint5 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint5.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint5.Parent = GunfightArena

local UICorner13 = Instance.new("UICorner")
UICorner13.Name = "UICorner"
UICorner13.CornerRadius = UDim.new(0.1, 0)
UICorner13.Parent = GunfightArena

local UIStroke5 = Instance.new("UIStroke")
UIStroke5.Name = "UIStroke"
UIStroke5.Color = Color3.new(1, 1, 1)
UIStroke5.Thickness = 1.5
UIStroke5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke5.Parent = GunfightArena

local UIGradient9 = Instance.new("UIGradient")
UIGradient9.Name = "UIGradient"
UIGradient9.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))})
UIGradient9.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient9.Rotation = 90
UIGradient9.Offset = Vector2.new(0, 1)
UIGradient9.Parent = GunfightArena

local Name5 = Instance.new("TextLabel")
Name5.Name = "Name"
Name5.Position = UDim2.new(0, 0, 0.7, 0)
Name5.Size = UDim2.new(1, 0, 0.3, 0)
Name5.BackgroundColor3 = Color3.new(1, 1, 1)
Name5.BackgroundTransparency = 1
Name5.BorderSizePixel = 0
Name5.BorderColor3 = Color3.new(0, 0, 0)
Name5.ZIndex = 2
Name5.Transparency = 1
Name5.Text = "Gunfight Arena"
Name5.TextColor3 = Color3.new(0.364706, 0.8, 1)
Name5.TextSize = 14
Name5.FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name5.TextScaled = true
Name5.TextWrapped = true
Name5.Parent = GunfightArena

local Effect5 = Instance.new("Frame")
Effect5.Name = "Effect"
Effect5.Size = UDim2.new(1, 0, 1, 0)
Effect5.BackgroundColor3 = Color3.new(1, 1, 1)
Effect5.BorderSizePixel = 0
Effect5.BorderColor3 = Color3.new(0, 0, 0)
Effect5.Parent = GunfightArena

local UICorner14 = Instance.new("UICorner")
UICorner14.Name = "UICorner"
UICorner14.CornerRadius = UDim.new(0.1, 0)
UICorner14.Parent = Effect5

local UIGradient10 = Instance.new("UIGradient")
UIGradient10.Name = "UIGradient"
UIGradient10.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.35, 1, 0), NumberSequenceKeypoint.new(0.5, 0.25, 0), NumberSequenceKeypoint.new(0.65, 1, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient10.Rotation = -45
UIGradient10.Offset = Vector2.new(0, -1.5)
UIGradient10.Parent = Effect5

local Loading5 = Instance.new("Frame")
Loading5.Name = "Loading"
Loading5.Position = UDim2.new(0.5, 0, 0.5, 0)
Loading5.Size = UDim2.new(1, 0, 1, 0)
Loading5.BackgroundColor3 = Color3.new(0, 0, 0)
Loading5.BackgroundTransparency = 0.10000000149011612
Loading5.BorderSizePixel = 0
Loading5.BorderColor3 = Color3.new(0, 0, 0)
Loading5.Visible = false
Loading5.AnchorPoint = Vector2.new(0.5, 0.5)
Loading5.Transparency = 0.10000000149011612
Loading5.Parent = GunfightArena

local ImageLabel5 = Instance.new("ImageLabel")
ImageLabel5.Name = "ImageLabel"
ImageLabel5.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel5.Size = UDim2.new(0.75, 0, 0.75, 0)
ImageLabel5.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel5.BackgroundTransparency = 1
ImageLabel5.BorderSizePixel = 0
ImageLabel5.BorderColor3 = Color3.new(0, 0, 0)
ImageLabel5.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel5.Transparency = 1
ImageLabel5.Image = "rbxassetid://17687447043"
ImageLabel5.Parent = Loading5

local UICorner15 = Instance.new("UICorner")
UICorner15.Name = "UICorner"
UICorner15.CornerRadius = UDim.new(0.1, 0)
UICorner15.Parent = Loading5
