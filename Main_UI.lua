local PGUI = game.Players.LocalPlayer.PlayerGui

local HAPPYscript = Instance.new("ScreenGui")
HAPPYscript.Name = "HAPPYscript"
HAPPYscript.ResetOnSpawn = false
HAPPYscript.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HAPPYscript.DisplayOrder = 9999
HAPPYscript.Parent = PGUI

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0.75, 0, 0.75, 0)
Main.BackgroundColor3 = Color3.new(1, 1, 1)
Main.BorderSizePixel = 0
Main.BorderColor3 = Color3.new(0, 0, 0)
Main.Visible = false
Main.ZIndex = 9996
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Parent = HAPPYscript

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint.AspectRatio = 1.75
UIAspectRatioConstraint.Parent = Main

local UIDragDetector = Instance.new("UIDragDetector")
UIDragDetector.Name = "UIDragDetector"

UIDragDetector.Parent = Main

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Position = UDim2.new(0.675, 0, 0.5, 0)
ScrollingFrame.Size = UDim2.new(0.65, 0, 1, 0)
ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.BorderColor3 = Color3.new(0, 0, 0)
ScrollingFrame.ZIndex = 2
ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ScrollingFrame.Transparency = 1
ScrollingFrame.Active = true
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1.25, 0)
ScrollingFrame.ScrollBarImageColor3 = Color3.new(1, 0, 0.45098)
ScrollingFrame.ScrollBarImageTransparency = 0.5
ScrollingFrame.ScrollBarThickness = 7
ScrollingFrame.Parent = Main

local UIStroke = Instance.new("UIStroke")
UIStroke.Name = "UIStroke"
UIStroke.Color = Color3.new(1, 0, 0.470588)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = ScrollingFrame

local UICorner = Instance.new("UICorner")
UICorner.Name = "UICorner"
UICorner.CornerRadius = UDim.new(0.025, 0)
UICorner.Parent = ScrollingFrame

local UICorner2 = Instance.new("UICorner")
UICorner2.Name = "UICorner"
UICorner2.CornerRadius = UDim.new(0.025, 0)
UICorner2.Parent = Main

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Position = UDim2.new(0.175, 0, 0.075, 0)
Title.Size = UDim2.new(0.3, 0, 0.125, 0)
Title.BackgroundColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 0
Title.BorderColor3 = Color3.new(0, 0, 0)
Title.ZIndex = 2
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.Transparency = 1
Title.Text = "HAPPY script"
Title.TextColor3 = Color3.new(1, 0, 0.901961)
Title.TextSize = 14
Title.FontFace = Font.new("rbxassetid://12187368843", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
Title.TextScaled = true
Title.TextWrapped = true
Title.Parent = Main

local UIGradient = Instance.new("UIGradient")
UIGradient.Name = "UIGradient"
UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0.615686)), ColorSequenceKeypoint.new(1, Color3.new(0.8, 0, 1))})
UIGradient.Rotation = -45
UIGradient.Parent = Title

local Character = Instance.new("TextButton")
Character.Name = "Character"
Character.Position = UDim2.new(0.025, 0, 0.475, 0)
Character.Size = UDim2.new(0.3, 0, 0.15, 0)
Character.BackgroundColor3 = Color3.new(1, 1, 1)
Character.BackgroundTransparency = 1
Character.BorderSizePixel = 0
Character.BorderColor3 = Color3.new(0, 0, 0)
Character.ZIndex = 2
Character.Transparency = 1
Character.Text = "Utilities"
Character.TextColor3 = Color3.new(0, 1, 0.588235)
Character.TextSize = 14
Character.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Character.TextScaled = true
Character.TextWrapped = true
Character.TextXAlignment = Enum.TextXAlignment.Left
Character.Parent = Main

local GameHub = Instance.new("TextButton")
GameHub.Name = "GameHub"
GameHub.Position = UDim2.new(0.025, 0, 0.275, 0)
GameHub.Size = UDim2.new(0.3, 0, 0.15, 0)
GameHub.BackgroundColor3 = Color3.new(1, 1, 1)
GameHub.BackgroundTransparency = 1
GameHub.BorderSizePixel = 0
GameHub.BorderColor3 = Color3.new(0, 0, 0)
GameHub.ZIndex = 2
GameHub.Transparency = 1
GameHub.Text = "GameHub"
GameHub.TextColor3 = Color3.new(0, 1, 0.588235)
GameHub.TextSize = 14
GameHub.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
GameHub.TextScaled = true
GameHub.TextWrapped = true
GameHub.TextXAlignment = Enum.TextXAlignment.Left
GameHub.Parent = Main

local System = Instance.new("TextButton")
System.Name = "System"
System.Position = UDim2.new(0.025, 0, 0.675, 0)
System.Size = UDim2.new(0.3, 0, 0.15, 0)
System.BackgroundColor3 = Color3.new(1, 1, 1)
System.BackgroundTransparency = 1
System.BorderSizePixel = 0
System.BorderColor3 = Color3.new(0, 0, 0)
System.ZIndex = 2
System.Transparency = 1
System.Text = "System"
System.TextColor3 = Color3.new(0, 1, 0.588235)
System.TextSize = 14
System.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
System.TextScaled = true
System.TextWrapped = true
System.TextXAlignment = Enum.TextXAlignment.Left
System.Parent = Main

local Particle = Instance.new("ImageLabel")
Particle.Name = "Particle"
Particle.Position = UDim2.new(0.5, 0, -100, 0)
Particle.Size = UDim2.new(0.25, 0, 0.25, 0)
Particle.BackgroundColor3 = Color3.new(1, 1, 1)
Particle.BackgroundTransparency = 1
Particle.BorderSizePixel = 0
Particle.BorderColor3 = Color3.new(0, 0, 0)
Particle.AnchorPoint = Vector2.new(0.5, 0.5)
Particle.Transparency = 1
Particle.Image = "rbxassetid://81834701835654"
Particle.ImageColor3 = Color3.new(1, 1, 0.0980392)
Particle.ImageTransparency = 0.25
Particle.Parent = Main

local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint2.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint2.Parent = Particle

local BackGround = Instance.new("ImageLabel")
BackGround.Name = "BackGround"
BackGround.Position = UDim2.new(0.5, 0, 0.5, 0)
BackGround.Size = UDim2.new(1, 0, 1, 0)
BackGround.BackgroundColor3 = Color3.new(1, 1, 1)
BackGround.BackgroundTransparency = 1
BackGround.BorderSizePixel = 0
BackGround.BorderColor3 = Color3.new(0, 0, 0)
BackGround.AnchorPoint = Vector2.new(0.5, 0.5)
BackGround.Transparency = 1
BackGround.Image = "rbxassetid://110000264938069"
BackGround.Parent = Main

local UICorner3 = Instance.new("UICorner")
UICorner3.Name = "UICorner"
UICorner3.CornerRadius = UDim.new(0.025, 0)
UICorner3.Parent = BackGround

local UIGradient2 = Instance.new("UIGradient")
UIGradient2.Name = "UIGradient"
UIGradient2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0), NumberSequenceKeypoint.new(0.4, 0, 0), NumberSequenceKeypoint.new(1, 0, 0)})
UIGradient2.Rotation = 50
UIGradient2.Parent = BackGround

local UIGradient3 = Instance.new("UIGradient")
UIGradient3.Name = "UIGradient"
UIGradient3.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.25098, 0, 0.541176)), ColorSequenceKeypoint.new(1, Color3.new(0.384314, 0, 0.00784314))})
UIGradient3.Rotation = 95
UIGradient3.Parent = Main

local Button = Instance.new("ImageButton")
Button.Name = "Button"
Button.Position = UDim2.new(0.5, 0, 0.5, 0)
Button.Size = UDim2.new(0, 50, 0, 50)
Button.BackgroundColor3 = Color3.new(1, 1, 1)
Button.BackgroundTransparency = 1
Button.BorderSizePixel = 0
Button.BorderColor3 = Color3.new(0, 0, 0)
Button.Visible = false
Button.ZIndex = 9999
Button.AnchorPoint = Vector2.new(0.5, 0.5)
Button.Transparency = 1
Button.Image = "rbxassetid://90219562764375"
Button.Parent = HAPPYscript

local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint3.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint3.Parent = Button

local UICorner4 = Instance.new("UICorner")
UICorner4.Name = "UICorner"
UICorner4.CornerRadius = UDim.new(0.1, 0)
UICorner4.Parent = Button

local Version = Instance.new("TextLabel")
Version.Name = "Version"
Version.Position = UDim2.new(0.8, 0, 0.95, 0)
Version.Size = UDim2.new(1, 0, 0.5, 0)
Version.BackgroundColor3 = Color3.new(1, 1, 1)
Version.BackgroundTransparency = 1
Version.BorderSizePixel = 0
Version.BorderColor3 = Color3.new(0, 0, 0)
Version.Rotation = -15
Version.AnchorPoint = Vector2.new(0.5, 0.5)
Version.TextStrokeTransparency = 0
Version.TextStrokeColor3 = Color3.fromRGB(145, 0, 0)
Version.Text = "v0.07"
Version.TextColor3 = Color3.new(1, 0.933333, 0)
Version.TextSize = 14
Version.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Version.TextScaled = true
Version.TextWrapped = true
Version.Parent = Button

local Effect = Instance.new("Frame")
Effect.Name = "Effect"
Effect.Size = UDim2.new(1, 0, 1, 0)
Effect.BackgroundColor3 = Color3.new(1, 1, 1)
Effect.BorderSizePixel = 0
Effect.BorderColor3 = Color3.new(0, 0, 0)
Effect.Parent = Button

local UICorner5 = Instance.new("UICorner")
UICorner5.Name = "UICorner"
UICorner5.CornerRadius = UDim.new(0.1, 0)
UICorner5.Parent = Effect

local UIGradient4 = Instance.new("UIGradient")
UIGradient4.Name = "UIGradient"
UIGradient4.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.35, 1, 0), NumberSequenceKeypoint.new(0.5, 0.5, 0), NumberSequenceKeypoint.new(0.65, 1, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient4.Rotation = -45
UIGradient4.Offset = Vector2.new(0, 1.5)
UIGradient4.Parent = Effect

local Noti = Instance.new("Frame")
Noti.Name = "Noti"
Noti.Position = UDim2.new(0.5, 0, 0.5, 0)
Noti.Size = UDim2.new(0.45, 0, 0.45, 0)
Noti.BackgroundColor3 = Color3.new(0.333333, 0, 0.270588)
Noti.BorderSizePixel = 0
Noti.BorderColor3 = Color3.new(0, 0, 0)
Noti.Visible = false
Noti.ZIndex = 9998
Noti.AnchorPoint = Vector2.new(0.5, 0.5)
Noti.Parent = HAPPYscript

local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint4.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint4.AspectRatio = 1.75
UIAspectRatioConstraint4.Parent = Noti

local UIGradient5 = Instance.new("UIGradient")
UIGradient5.Name = "UIGradient"
UIGradient5.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.968627, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.235294, 0, 1))})
UIGradient5.Rotation = -45
UIGradient5.Parent = Noti

local UICorner6 = Instance.new("UICorner")
UICorner6.Name = "UICorner"
UICorner6.CornerRadius = UDim.new(0.05, 0)
UICorner6.Parent = Noti

local UIStroke2 = Instance.new("UIStroke")
UIStroke2.Name = "UIStroke"
UIStroke2.Color = Color3.new(0.784314, 0.392157, 1)
UIStroke2.Parent = Noti

local Back = Instance.new("TextButton")
Back.Name = "Back"
Back.Position = UDim2.new(0, 0, 0.749668, 0)
Back.Size = UDim2.new(0.25, 0, 0.25, 0)
Back.BackgroundColor3 = Color3.new(1, 1, 1)
Back.BackgroundTransparency = 1
Back.BorderSizePixel = 0
Back.BorderColor3 = Color3.new(0, 0, 0)
Back.Transparency = 1
Back.Text = "< Back"
Back.TextColor3 = Color3.new(1, 0, 0.196078)
Back.TextSize = 14
Back.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Back.TextScaled = true
Back.TextWrapped = true
Back.Parent = Noti

local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Position = UDim2.new(0.025, 0, 0.05, 0)
Logo.Size = UDim2.new(0.4, 0, 0.4, 0)
Logo.BackgroundColor3 = Color3.new(0.364706, 0.192157, 0.486275)
Logo.BorderSizePixel = 0
Logo.BorderColor3 = Color3.new(0, 0, 0)
Logo.Parent = Noti

local UIAspectRatioConstraint5 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint5.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint5.Parent = Logo

local UICorner7 = Instance.new("UICorner")
UICorner7.Name = "UICorner"
UICorner7.CornerRadius = UDim.new(0.15, 0)
UICorner7.Parent = Logo

local Name = Instance.new("TextLabel")
Name.Name = "Name"
Name.Position = UDim2.new(0.5, 0, 1.25, 0)
Name.Size = UDim2.new(1.15, 0, 0.4, 0)
Name.BackgroundColor3 = Color3.new(1, 1, 1)
Name.BackgroundTransparency = 1
Name.BorderSizePixel = 0
Name.BorderColor3 = Color3.new(0, 0, 0)
Name.AnchorPoint = Vector2.new(0.5, 0.5)
Name.Transparency = 1
Name.Text = "---"
Name.TextColor3 = Color3.new(1, 0, 1)
Name.TextSize = 14
Name.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Name.TextScaled = true
Name.TextWrapped = true
Name.Parent = Logo

local Done = Instance.new("TextButton")
Done.Name = "Done"
Done.Position = UDim2.new(0.75, 0, 0.75, 0)
Done.Size = UDim2.new(0.25, 0, 0.25, 0)
Done.BackgroundColor3 = Color3.new(1, 1, 1)
Done.BackgroundTransparency = 1
Done.BorderSizePixel = 0
Done.BorderColor3 = Color3.new(0, 0, 0)
Done.Transparency = 1
Done.Text = "Done"
Done.TextColor3 = Color3.new(0.392157, 1, 0)
Done.TextSize = 14
Done.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Done.TextScaled = true
Done.TextWrapped = true
Done.Parent = Noti

local Tip = Instance.new("TextLabel")
Tip.Name = "Tip"
Tip.Position = UDim2.new(0.625, 0, 0.25, 0)
Tip.Size = UDim2.new(0.65, 0, 0.35, 0)
Tip.BackgroundColor3 = Color3.new(1, 1, 1)
Tip.BackgroundTransparency = 1
Tip.BorderSizePixel = 0
Tip.BorderColor3 = Color3.new(0, 0, 0)
Tip.AnchorPoint = Vector2.new(0.5, 0.5)
Tip.Transparency = 1
Tip.Text = "If you want the script to run automatically once the next time you run the script, press Return[1], if you want it to run automatically forever, press Return[ifn]."
Tip.TextColor3 = Color3.new(1, 0.882353, 0)
Tip.TextSize = 14
Tip.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Tip.TextScaled = true
Tip.TextWrapped = true
Tip.Parent = Noti

local Return1 = Instance.new("ImageButton")
Return1.Name = "Return1"
Return1.Position = UDim2.new(0.35, 0, 0.5, 0)
Return1.Size = UDim2.new(0.25, 0, 0.25, 0)
Return1.BackgroundColor3 = Color3.new(0, 0, 0)
Return1.BorderSizePixel = 0
Return1.BorderColor3 = Color3.new(0, 0, 0)
Return1.Image = "rbxassetid://88913662931777"
Return1.Parent = Noti

local UIAspectRatioConstraint6 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint6.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint6.Parent = Return1

local UICorner8 = Instance.new("UICorner")
UICorner8.Name = "UICorner"
UICorner8.CornerRadius = UDim.new(1, 0)
UICorner8.Parent = Return1

local ReturnIfn = Instance.new("ImageButton")
ReturnIfn.Name = "ReturnIfn"
ReturnIfn.Position = UDim2.new(0.525, 0, 0.5, 0)
ReturnIfn.Size = UDim2.new(0.25, 0, 0.25, 0)
ReturnIfn.BackgroundColor3 = Color3.new(0, 0, 0)
ReturnIfn.BorderSizePixel = 0
ReturnIfn.BorderColor3 = Color3.new(0, 0, 0)
ReturnIfn.Image = "rbxassetid://121046862191317"
ReturnIfn.Parent = Noti

local UIAspectRatioConstraint7 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint7.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint7.Parent = ReturnIfn

local UICorner9 = Instance.new("UICorner")
UICorner9.Name = "UICorner"
UICorner9.CornerRadius = UDim.new(1, 0)
UICorner9.Parent = ReturnIfn

local gui = HAPPYscript
if gui then
	for _, obj in ipairs(gui:GetDescendants()) do
		if obj:IsA("TextLabel") or obj:IsA("TextButton") then
			obj.TextTransparency = 0
		end
	end
end
