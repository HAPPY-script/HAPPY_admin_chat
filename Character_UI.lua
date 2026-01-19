local sf = game.Players.LocalPlayer.PlayerGui:WaitForChild("HAPPYscript").Main.ScrollingFrame

local Character = Instance.new("Frame")
Character.Name = "Character"
Character.Size = UDim2.new(1, 0, 1, 0)
Character.BackgroundColor3 = Color3.new(1, 1, 1)
Character.BackgroundTransparency = 1
Character.BorderSizePixel = 0
Character.BorderColor3 = Color3.new(0, 0, 0)
Character.Visible = false
Character.Transparency = 1
Character.Parent = sf

local Fly = Instance.new("ImageButton")
Fly.Name = "Fly"
Fly.Position = UDim2.new(0.2, 0, 0.2, 0)
Fly.Size = UDim2.new(0.25, 0, 0.25, 0)
Fly.BackgroundColor3 = Color3.new(1, 1, 1)
Fly.BackgroundTransparency = 1
Fly.BorderSizePixel = 0
Fly.BorderColor3 = Color3.new(0, 0, 0)
Fly.AnchorPoint = Vector2.new(0.5, 0.5)
Fly.Transparency = 1
Fly.Image = "rbxassetid://99007734437565"
Fly.Parent = Character

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint.Parent = Fly

local UICorner = Instance.new("UICorner")
UICorner.Name = "UICorner"
UICorner.CornerRadius = UDim.new(0.15, 0)
UICorner.Parent = Fly

local UIGradient = Instance.new("UIGradient")
UIGradient.Name = "UIGradient"
UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient.Rotation = 90
UIGradient.Offset = Vector2.new(0, 1)
UIGradient.Parent = Fly

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
Name.Text = "Fly Gui"
Name.TextColor3 = Color3.new(1, 1, 1)
Name.TextSize = 14
Name.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Name.TextScaled = true
Name.TextWrapped = true
Name.Parent = Fly

local Effect = Instance.new("Frame")
Effect.Name = "Effect"
Effect.Size = UDim2.new(1, 0, 1, 0)
Effect.BackgroundColor3 = Color3.new(1, 1, 1)
Effect.BorderSizePixel = 0
Effect.BorderColor3 = Color3.new(0, 0, 0)
Effect.Parent = Fly

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
Loading.Parent = Fly

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

local IfnJump = Instance.new("ImageButton")
IfnJump.Name = "IfnJump"
IfnJump.Position = UDim2.new(0.8, 0, 0.2, 0)
IfnJump.Size = UDim2.new(0.25, 0, 0.25, 0)
IfnJump.BackgroundColor3 = Color3.new(1, 1, 1)
IfnJump.BackgroundTransparency = 1
IfnJump.BorderSizePixel = 0
IfnJump.BorderColor3 = Color3.new(0, 0, 0)
IfnJump.AnchorPoint = Vector2.new(0.5, 0.5)
IfnJump.Transparency = 1
IfnJump.Image = "rbxassetid://100147318798859"
IfnJump.Parent = Character

local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint2.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint2.Parent = IfnJump

local UICorner4 = Instance.new("UICorner")
UICorner4.Name = "UICorner"
UICorner4.CornerRadius = UDim.new(0.15, 0)
UICorner4.Parent = IfnJump

local UIGradient3 = Instance.new("UIGradient")
UIGradient3.Name = "UIGradient"
UIGradient3.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))})
UIGradient3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient3.Rotation = 90
UIGradient3.Offset = Vector2.new(0, 1)
UIGradient3.Parent = IfnJump

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
Name2.Text = "Infinity Jump"
Name2.TextColor3 = Color3.new(1, 1, 1)
Name2.TextSize = 14
Name2.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name2.TextScaled = true
Name2.TextWrapped = true
Name2.Parent = IfnJump

local Effect2 = Instance.new("Frame")
Effect2.Name = "Effect"
Effect2.Size = UDim2.new(1, 0, 1, 0)
Effect2.BackgroundColor3 = Color3.new(1, 1, 1)
Effect2.BorderSizePixel = 0
Effect2.BorderColor3 = Color3.new(0, 0, 0)
Effect2.Parent = IfnJump

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
Loading2.Parent = IfnJump

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

local Speed = Instance.new("ImageButton")
Speed.Name = "Speed"
Speed.Position = UDim2.new(0.5, 0, 0.2, 0)
Speed.Size = UDim2.new(0.25, 0, 0.25, 0)
Speed.BackgroundColor3 = Color3.new(1, 1, 1)
Speed.BackgroundTransparency = 1
Speed.BorderSizePixel = 0
Speed.BorderColor3 = Color3.new(0, 0, 0)
Speed.AnchorPoint = Vector2.new(0.5, 0.5)
Speed.Transparency = 1
Speed.Image = "rbxassetid://73678941604961"
Speed.Parent = Character

local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint3.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint3.Parent = Speed

local UICorner7 = Instance.new("UICorner")
UICorner7.Name = "UICorner"
UICorner7.CornerRadius = UDim.new(0.15, 0)
UICorner7.Parent = Speed

local UIGradient5 = Instance.new("UIGradient")
UIGradient5.Name = "UIGradient"
UIGradient5.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient5.Rotation = 90
UIGradient5.Offset = Vector2.new(0, 1)
UIGradient5.Parent = Speed

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
Name3.Text = "Speed"
Name3.TextColor3 = Color3.new(1, 1, 1)
Name3.TextSize = 14
Name3.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name3.TextScaled = true
Name3.TextWrapped = true
Name3.Parent = Speed

local Effect3 = Instance.new("Frame")
Effect3.Name = "Effect"
Effect3.Size = UDim2.new(1, 0, 1, 0)
Effect3.BackgroundColor3 = Color3.new(1, 1, 1)
Effect3.BorderSizePixel = 0
Effect3.BorderColor3 = Color3.new(0, 0, 0)
Effect3.Parent = Speed

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
Loading3.Parent = Speed

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

local Explorer = Instance.new("ImageButton")
Explorer.Name = "Explorer"
Explorer.Position = UDim2.new(0.2, 0, 0.5, 0)
Explorer.Size = UDim2.new(0.25, 0, 0.25, 0)
Explorer.BackgroundColor3 = Color3.new(1, 1, 1)
Explorer.BackgroundTransparency = 1
Explorer.BorderSizePixel = 0
Explorer.BorderColor3 = Color3.new(0, 0, 0)
Explorer.AnchorPoint = Vector2.new(0.5, 0.5)
Explorer.Transparency = 1
Explorer.Image = "rbxassetid://106001322662528"
Explorer.Parent = Character

local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint4.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint4.Parent = Explorer

local UICorner10 = Instance.new("UICorner")
UICorner10.Name = "UICorner"
UICorner10.CornerRadius = UDim.new(0.15, 0)
UICorner10.Parent = Explorer

local UIGradient7 = Instance.new("UIGradient")
UIGradient7.Name = "UIGradient"
UIGradient7.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient7.Rotation = 90
UIGradient7.Offset = Vector2.new(0, 1)
UIGradient7.Parent = Explorer

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
Name4.Text = "Explorer"
Name4.TextColor3 = Color3.new(1, 1, 1)
Name4.TextSize = 14
Name4.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Name4.TextScaled = true
Name4.TextWrapped = true
Name4.Parent = Explorer

local Effect4 = Instance.new("Frame")
Effect4.Name = "Effect"
Effect4.Size = UDim2.new(1, 0, 1, 0)
Effect4.BackgroundColor3 = Color3.new(1, 1, 1)
Effect4.BorderSizePixel = 0
Effect4.BorderColor3 = Color3.new(0, 0, 0)
Effect4.Parent = Explorer

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
Loading4.Parent = Explorer

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

local HitBox = Instance.new("ImageButton")
HitBox.Name = "HitBox"
HitBox.Position = UDim2.new(0.5, 0, 0.5, 0)
HitBox.Size = UDim2.new(0.25, 0, 0.25, 0)
HitBox.BackgroundColor3 = Color3.new(1, 1, 1)
HitBox.BackgroundTransparency = 1
HitBox.BorderSizePixel = 0
HitBox.BorderColor3 = Color3.new(0, 0, 0)
HitBox.AnchorPoint = Vector2.new(0.5, 0.5)
HitBox.Transparency = 1
HitBox.Image = "rbxassetid://95975479545027"
HitBox.Parent = Character

local UIAspectRatioConstraint5 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint5.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint5.Parent = HitBox

local UICorner13 = Instance.new("UICorner")
UICorner13.Name = "UICorner"
UICorner13.CornerRadius = UDim.new(0.15, 0)
UICorner13.Parent = HitBox

local UIGradient9 = Instance.new("UIGradient")
UIGradient9.Name = "UIGradient"
UIGradient9.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))})
UIGradient9.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient9.Rotation = 90
UIGradient9.Offset = Vector2.new(0, 1)
UIGradient9.Parent = HitBox

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
Name5.Text = "Hit Box"
Name5.TextColor3 = Color3.new(1, 1, 1)
Name5.TextSize = 14
Name5.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name5.TextScaled = true
Name5.TextWrapped = true
Name5.Parent = HitBox

local Effect5 = Instance.new("Frame")
Effect5.Name = "Effect"
Effect5.Size = UDim2.new(1, 0, 1, 0)
Effect5.BackgroundColor3 = Color3.new(1, 1, 1)
Effect5.BorderSizePixel = 0
Effect5.BorderColor3 = Color3.new(0, 0, 0)
Effect5.Parent = HitBox

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
Loading5.Parent = HitBox

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

local ESP = Instance.new("ImageButton")
ESP.Name = "ESP"
ESP.Position = UDim2.new(0.8, 0, 0.5, 0)
ESP.Size = UDim2.new(0.25, 0, 0.25, 0)
ESP.BackgroundColor3 = Color3.new(1, 1, 1)
ESP.BackgroundTransparency = 1
ESP.BorderSizePixel = 0
ESP.BorderColor3 = Color3.new(0, 0, 0)
ESP.AnchorPoint = Vector2.new(0.5, 0.5)
ESP.Transparency = 1
ESP.Image = "rbxassetid://114063464141130"
ESP.Parent = Character

local UIAspectRatioConstraint6 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint6.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint6.Parent = ESP

local UICorner16 = Instance.new("UICorner")
UICorner16.Name = "UICorner"
UICorner16.CornerRadius = UDim.new(0.15, 0)
UICorner16.Parent = ESP

local UIGradient11 = Instance.new("UIGradient")
UIGradient11.Name = "UIGradient"
UIGradient11.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))})
UIGradient11.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient11.Rotation = 90
UIGradient11.Offset = Vector2.new(0, 1)
UIGradient11.Parent = ESP

local Name6 = Instance.new("TextLabel")
Name6.Name = "Name"
Name6.Position = UDim2.new(0, 0, 0.7, 0)
Name6.Size = UDim2.new(1, 0, 0.3, 0)
Name6.BackgroundColor3 = Color3.new(1, 1, 1)
Name6.BackgroundTransparency = 1
Name6.BorderSizePixel = 0
Name6.BorderColor3 = Color3.new(0, 0, 0)
Name6.ZIndex = 2
Name6.Transparency = 1
Name6.Text = "ESP"
Name6.TextColor3 = Color3.new(1, 1, 1)
Name6.TextSize = 14
Name6.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name6.TextScaled = true
Name6.TextWrapped = true
Name6.Parent = ESP

local Effect6 = Instance.new("Frame")
Effect6.Name = "Effect"
Effect6.Size = UDim2.new(1, 0, 1, 0)
Effect6.BackgroundColor3 = Color3.new(1, 1, 1)
Effect6.BorderSizePixel = 0
Effect6.BorderColor3 = Color3.new(0, 0, 0)
Effect6.Parent = ESP

local UICorner17 = Instance.new("UICorner")
UICorner17.Name = "UICorner"
UICorner17.CornerRadius = UDim.new(0.1, 0)
UICorner17.Parent = Effect6

local UIGradient12 = Instance.new("UIGradient")
UIGradient12.Name = "UIGradient"
UIGradient12.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.35, 1, 0), NumberSequenceKeypoint.new(0.5, 0.25, 0), NumberSequenceKeypoint.new(0.65, 1, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient12.Rotation = -45
UIGradient12.Offset = Vector2.new(0, -1.5)
UIGradient12.Parent = Effect6

local Loading6 = Instance.new("Frame")
Loading6.Name = "Loading"
Loading6.Position = UDim2.new(0.5, 0, 0.5, 0)
Loading6.Size = UDim2.new(1, 0, 1, 0)
Loading6.BackgroundColor3 = Color3.new(0, 0, 0)
Loading6.BackgroundTransparency = 0.10000000149011612
Loading6.BorderSizePixel = 0
Loading6.BorderColor3 = Color3.new(0, 0, 0)
Loading6.Visible = false
Loading6.AnchorPoint = Vector2.new(0.5, 0.5)
Loading6.Transparency = 0.10000000149011612
Loading6.Parent = ESP

local ImageLabel6 = Instance.new("ImageLabel")
ImageLabel6.Name = "ImageLabel"
ImageLabel6.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel6.Size = UDim2.new(0.75, 0, 0.75, 0)
ImageLabel6.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel6.BackgroundTransparency = 1
ImageLabel6.BorderSizePixel = 0
ImageLabel6.BorderColor3 = Color3.new(0, 0, 0)
ImageLabel6.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel6.Transparency = 1
ImageLabel6.Image = "rbxassetid://17687447043"
ImageLabel6.Parent = Loading6

local UICorner18 = Instance.new("UICorner")
UICorner18.Name = "UICorner"
UICorner18.CornerRadius = UDim.new(0.1, 0)
UICorner18.Parent = Loading6

local CameraViewer = Instance.new("ImageButton")
CameraViewer.Name = "CameraViewer"
CameraViewer.Position = UDim2.new(0.2, 0, 0.8, 0)
CameraViewer.Size = UDim2.new(0.25, 0, 0.25, 0)
CameraViewer.BackgroundColor3 = Color3.new(1, 1, 1)
CameraViewer.BackgroundTransparency = 1
CameraViewer.BorderSizePixel = 0
CameraViewer.BorderColor3 = Color3.new(0, 0, 0)
CameraViewer.AnchorPoint = Vector2.new(0.5, 0.5)
CameraViewer.Transparency = 1
CameraViewer.Image = "rbxassetid://87228966964189"
CameraViewer.Parent = Character

local UIAspectRatioConstraint7 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint7.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint7.Parent = CameraViewer

local UICorner19 = Instance.new("UICorner")
UICorner19.Name = "UICorner"
UICorner19.CornerRadius = UDim.new(0.15, 0)
UICorner19.Parent = CameraViewer

local UIGradient13 = Instance.new("UIGradient")
UIGradient13.Name = "UIGradient"
UIGradient13.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))})
UIGradient13.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient13.Rotation = 90
UIGradient13.Offset = Vector2.new(0, 1)
UIGradient13.Parent = CameraViewer

local Name7 = Instance.new("TextLabel")
Name7.Name = "Name"
Name7.Position = UDim2.new(0, 0, 0.7, 0)
Name7.Size = UDim2.new(1, 0, 0.3, 0)
Name7.BackgroundColor3 = Color3.new(1, 1, 1)
Name7.BackgroundTransparency = 1
Name7.BorderSizePixel = 0
Name7.BorderColor3 = Color3.new(0, 0, 0)
Name7.ZIndex = 2
Name7.Transparency = 1
Name7.Text = "Camera Viewer"
Name7.TextColor3 = Color3.new(1, 1, 1)
Name7.TextSize = 14
Name7.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name7.TextScaled = true
Name7.TextWrapped = true
Name7.Parent = CameraViewer

local Effect7 = Instance.new("Frame")
Effect7.Name = "Effect"
Effect7.Size = UDim2.new(1, 0, 1, 0)
Effect7.BackgroundColor3 = Color3.new(1, 1, 1)
Effect7.BorderSizePixel = 0
Effect7.BorderColor3 = Color3.new(0, 0, 0)
Effect7.Parent = CameraViewer

local UICorner20 = Instance.new("UICorner")
UICorner20.Name = "UICorner"
UICorner20.CornerRadius = UDim.new(0.1, 0)
UICorner20.Parent = Effect7

local UIGradient14 = Instance.new("UIGradient")
UIGradient14.Name = "UIGradient"
UIGradient14.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.35, 1, 0), NumberSequenceKeypoint.new(0.5, 0.25, 0), NumberSequenceKeypoint.new(0.65, 1, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient14.Rotation = -45
UIGradient14.Offset = Vector2.new(0, -1.5)
UIGradient14.Parent = Effect7

local Loading7 = Instance.new("Frame")
Loading7.Name = "Loading"
Loading7.Position = UDim2.new(0.5, 0, 0.5, 0)
Loading7.Size = UDim2.new(1, 0, 1, 0)
Loading7.BackgroundColor3 = Color3.new(0, 0, 0)
Loading7.BackgroundTransparency = 0.10000000149011612
Loading7.BorderSizePixel = 0
Loading7.BorderColor3 = Color3.new(0, 0, 0)
Loading7.Visible = false
Loading7.AnchorPoint = Vector2.new(0.5, 0.5)
Loading7.Transparency = 0.10000000149011612
Loading7.Parent = CameraViewer

local ImageLabel7 = Instance.new("ImageLabel")
ImageLabel7.Name = "ImageLabel"
ImageLabel7.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel7.Size = UDim2.new(0.75, 0, 0.75, 0)
ImageLabel7.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel7.BackgroundTransparency = 1
ImageLabel7.BorderSizePixel = 0
ImageLabel7.BorderColor3 = Color3.new(0, 0, 0)
ImageLabel7.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel7.Transparency = 1
ImageLabel7.Image = "rbxassetid://17687447043"
ImageLabel7.Parent = Loading7

local UICorner21 = Instance.new("UICorner")
UICorner21.Name = "UICorner"
UICorner21.CornerRadius = UDim.new(0.1, 0)
UICorner21.Parent = Loading7
