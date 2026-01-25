local sf = game.Players.LocalPlayer.PlayerGui:WaitForChild("HAPPYscript").Main.ScrollingFrame

local System = Instance.new("Frame")
System.Name = "System"
System.Size = UDim2.new(1, 0, 1, 0)
System.BackgroundColor3 = Color3.new(1, 1, 1)
System.BackgroundTransparency = 1
System.BorderSizePixel = 0
System.BorderColor3 = Color3.new(0, 0, 0)
System.Transparency = 1
System.Parent = sf

local ReportTitle = Instance.new("TextLabel")
ReportTitle.Name = "ReportTitle"
ReportTitle.Position = UDim2.new(0, 0, 0.025, 0)
ReportTitle.Size = UDim2.new(0.3, 0, 0.1, 0)
ReportTitle.BackgroundColor3 = Color3.new(1, 1, 1)
ReportTitle.BackgroundTransparency = 1
ReportTitle.BorderSizePixel = 0
ReportTitle.BorderColor3 = Color3.new(0, 0, 0)
ReportTitle.Transparency = 1
ReportTitle.Text = "Support"
ReportTitle.TextColor3 = Color3.new(1, 0, 0.392157)
ReportTitle.TextSize = 14
ReportTitle.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
ReportTitle.TextScaled = true
ReportTitle.TextWrapped = true
ReportTitle.Parent = System

local TextBox = Instance.new("TextBox")
TextBox.Name = "TextBox"
TextBox.Position = UDim2.new(0.5, 0, 0.3, 0)
TextBox.Size = UDim2.new(0.9, 0, 0.3, 0)
TextBox.BackgroundColor3 = Color3.new(0, 0, 0)
TextBox.BackgroundTransparency = 0.5
TextBox.BorderSizePixel = 0
TextBox.BorderColor3 = Color3.new(0, 0, 0)
TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
TextBox.Transparency = 0.5
TextBox.Text = ""
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.TextSize = 25
TextBox.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextBox.TextWrapped = true
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.ClearTextOnFocus = false
TextBox.PlaceholderText = "Report the problem you encountered"
TextBox.PlaceholderColor3 = Color3.new(0.392157, 0.392157, 0.392157)
TextBox.Parent = System

local UIStroke = Instance.new("UIStroke")
UIStroke.Name = "UIStroke"
UIStroke.Color = Color3.new(1, 0, 0.392157)
UIStroke.Thickness = 1.25
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = TextBox

local MaxText = Instance.new("TextLabel")
MaxText.Name = "MaxText"
MaxText.Position = UDim2.new(0.773305, 0, 0.769086, 0)
MaxText.Size = UDim2.new(0.225, 0, 0.225, 0)
MaxText.BackgroundColor3 = Color3.new(1, 1, 1)
MaxText.BackgroundTransparency = 1
MaxText.BorderSizePixel = 0
MaxText.BorderColor3 = Color3.new(0, 0, 0)
MaxText.Transparency = 1
MaxText.Text = "0/222"
MaxText.TextColor3 = Color3.new(1, 0, 0.392157)
MaxText.TextSize = 25
MaxText.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
MaxText.TextWrapped = true
MaxText.TextXAlignment = Enum.TextXAlignment.Right
MaxText.TextYAlignment = Enum.TextYAlignment.Bottom
MaxText.Parent = TextBox

local SendButton = Instance.new("ImageButton")
SendButton.Name = "SendButton"
SendButton.Position = UDim2.new(0.5, 0, 1.125, 0)
SendButton.Size = UDim2.new(1, 0, 0.25, 0)
SendButton.BackgroundColor3 = Color3.new(1, 0, 0.392157)
SendButton.BorderSizePixel = 0
SendButton.BorderColor3 = Color3.new(0, 0, 0)
SendButton.AnchorPoint = Vector2.new(0.5, 0.5)
SendButton.Image = "rbxassetid://18940312887"
SendButton.ScaleType = Enum.ScaleType.Fit
SendButton.Parent = TextBox

local UIStroke2 = Instance.new("UIStroke")
UIStroke2.Name = "UIStroke"
UIStroke2.Color = Color3.new(1, 0, 0.392157)
UIStroke2.Thickness = 1.25
UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke2.Parent = SendButton

local Tip = Instance.new("TextLabel")
Tip.Name = "Tip"
Tip.Position = UDim2.new(0.3, 0, 0, 0)
Tip.Size = UDim2.new(0.65, 0, 0.15, 0)
Tip.BackgroundColor3 = Color3.new(1, 1, 1)
Tip.BackgroundTransparency = 1
Tip.BorderSizePixel = 0
Tip.BorderColor3 = Color3.new(0, 0, 0)
Tip.Transparency = 1
Tip.Text = "Submit your feedback, suggestions for new features, or bug reports for the admin to review and resolve. All constructive feedback is valued."
Tip.TextColor3 = Color3.new(1, 0.784314, 0)
Tip.TextSize = 2
Tip.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Tip.TextScaled = true
Tip.TextWrapped = true
Tip.Parent = System

local SupportStatus = Instance.new("Frame")
SupportStatus.Name = "SupportStatus"
SupportStatus.Position = UDim2.new(0.5, 0, 0.3, 0)
SupportStatus.Size = UDim2.new(0.9, 0, 0.3, 0)
SupportStatus.BackgroundColor3 = Color3.new(0.831373, 0, 1)
SupportStatus.BorderSizePixel = 0
SupportStatus.BorderColor3 = Color3.new(0, 0, 0)
SupportStatus.Visible = false
SupportStatus.ZIndex = 2
SupportStatus.AnchorPoint = Vector2.new(0.5, 0.5)
SupportStatus.Parent = System

local OkButton = Instance.new("TextButton")
OkButton.Name = "OkButton"
OkButton.Position = UDim2.new(0.5, 0, 1.125, 0)
OkButton.Size = UDim2.new(1, 0, 0.25, 0)
OkButton.BackgroundColor3 = Color3.new(0.196078, 1, 0.196078)
OkButton.BorderSizePixel = 0
OkButton.BorderColor3 = Color3.new(0, 0, 0)
OkButton.AnchorPoint = Vector2.new(0.5, 0.5)
OkButton.Text = "OK"
OkButton.TextColor3 = Color3.new(1, 1, 1)
OkButton.TextSize = 14
OkButton.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
OkButton.TextScaled = true
OkButton.TextWrapped = true
OkButton.Parent = SupportStatus

local UIStroke3 = Instance.new("UIStroke")
UIStroke3.Name = "UIStroke"
UIStroke3.Color = Color3.new(1, 0, 0.392157)
UIStroke3.Thickness = 1.25
UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke3.Parent = OkButton

local UIStroke4 = Instance.new("UIStroke")
UIStroke4.Name = "UIStroke"
UIStroke4.Color = Color3.new(1, 0, 0.392157)
UIStroke4.Thickness = 1.25
UIStroke4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke4.Parent = SupportStatus

local UIGradient = Instance.new("UIGradient")
UIGradient.Name = "UIGradient"
UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.117647, 0, 0.156863)), ColorSequenceKeypoint.new(0.5, Color3.new(0.117647, 0, 0.156863)), ColorSequenceKeypoint.new(0.724914, Color3.new(0.172959, 0.0626865, 0.209716)), ColorSequenceKeypoint.new(1, Color3.new(0.588235, 0, 0.686275))})
UIGradient.Rotation = 90
UIGradient.Parent = SupportStatus

local MyFeedback = Instance.new("TextLabel")
MyFeedback.Name = "MyFeedback"
MyFeedback.Position = UDim2.new(0, 0, 0.2, 0)
MyFeedback.Size = UDim2.new(0.5, 0, 0.8, 0)
MyFeedback.BackgroundColor3 = Color3.new(1, 1, 1)
MyFeedback.BackgroundTransparency = 1
MyFeedback.BorderSizePixel = 0
MyFeedback.BorderColor3 = Color3.new(0, 0, 0)
MyFeedback.Transparency = 1
MyFeedback.Text = "..."
MyFeedback.TextColor3 = Color3.new(1, 1, 1)
MyFeedback.TextSize = 15
MyFeedback.FontFace = Font.new("rbxasset://fonts/families/PatrickHand.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
MyFeedback.TextScaled = true
MyFeedback.TextWrapped = true
MyFeedback.TextXAlignment = Enum.TextXAlignment.Left
MyFeedback.TextYAlignment = Enum.TextYAlignment.Top
MyFeedback.Parent = SupportStatus

local AdminFeedback = Instance.new("TextLabel")
AdminFeedback.Name = "AdminFeedback"
AdminFeedback.Position = UDim2.new(0.5, 0, 0.2, 0)
AdminFeedback.Size = UDim2.new(0.5, 0, 0.8, 0)
AdminFeedback.BackgroundColor3 = Color3.new(1, 1, 1)
AdminFeedback.BackgroundTransparency = 1
AdminFeedback.BorderSizePixel = 0
AdminFeedback.BorderColor3 = Color3.new(0, 0, 0)
AdminFeedback.Transparency = 1
AdminFeedback.Text = "Waiting for a response from the admin..."
AdminFeedback.TextColor3 = Color3.new(0, 1, 0.784314)
AdminFeedback.TextSize = 15
AdminFeedback.FontFace = Font.new("rbxasset://fonts/families/PatrickHand.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
AdminFeedback.TextScaled = true
AdminFeedback.TextWrapped = true
AdminFeedback.TextXAlignment = Enum.TextXAlignment.Left
AdminFeedback.TextYAlignment = Enum.TextYAlignment.Top
AdminFeedback.Parent = SupportStatus

local LineY = Instance.new("Frame")
LineY.Name = "LineY"
LineY.Position = UDim2.new(0.5, 0, 0.5, 0)
LineY.Size = UDim2.new(0.003, 0, 1, 0)
LineY.BackgroundColor3 = Color3.new(1, 0, 0.392157)
LineY.BorderSizePixel = 0
LineY.BorderColor3 = Color3.new(0, 0, 0)
LineY.AnchorPoint = Vector2.new(0.5, 0.5)
LineY.Parent = SupportStatus

local MyTitle = Instance.new("TextLabel")
MyTitle.Name = "MyTitle"
MyTitle.Size = UDim2.new(0.5, 0, 0.2, 0)
MyTitle.BackgroundColor3 = Color3.new(1, 1, 1)
MyTitle.BackgroundTransparency = 1
MyTitle.BorderSizePixel = 0
MyTitle.BorderColor3 = Color3.new(0, 0, 0)
MyTitle.Transparency = 1
MyTitle.Text = "Your feedback"
MyTitle.TextColor3 = Color3.new(1, 0, 0.588235)
MyTitle.TextSize = 14
MyTitle.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
MyTitle.TextScaled = true
MyTitle.TextWrapped = true
MyTitle.Parent = SupportStatus

local AdminTitle = Instance.new("TextLabel")
AdminTitle.Name = "AdminTitle"
AdminTitle.Position = UDim2.new(0.5, 0, 0, 0)
AdminTitle.Size = UDim2.new(0.5, 0, 0.2, 0)
AdminTitle.BackgroundColor3 = Color3.new(1, 1, 1)
AdminTitle.BackgroundTransparency = 1
AdminTitle.BorderSizePixel = 0
AdminTitle.BorderColor3 = Color3.new(0, 0, 0)
AdminTitle.Transparency = 1
AdminTitle.Text = "Admin's response"
AdminTitle.TextColor3 = Color3.new(1, 0, 0.588235)
AdminTitle.TextSize = 14
AdminTitle.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
AdminTitle.TextScaled = true
AdminTitle.TextWrapped = true
AdminTitle.Parent = SupportStatus

local LineX = Instance.new("Frame")
LineX.Name = "LineX"
LineX.Position = UDim2.new(0.5, 0, 0.2, 0)
LineX.Size = UDim2.new(1, 0, 0.003, 0)
LineX.BackgroundColor3 = Color3.new(1, 0, 0.392157)
LineX.BorderSizePixel = 0
LineX.BorderColor3 = Color3.new(0, 0, 0)
LineX.AnchorPoint = Vector2.new(0.5, 0.5)
LineX.Parent = SupportStatus

local EnergyIcon = Instance.new("ImageLabel")
EnergyIcon.Name = "EnergyIcon"
EnergyIcon.Position = UDim2.new(0.05, 0, 0.55, 0)
EnergyIcon.Size = UDim2.new(0.125, 0, 0.125, 0)
EnergyIcon.BackgroundColor3 = Color3.new(1, 1, 1)
EnergyIcon.BackgroundTransparency = 1
EnergyIcon.BorderSizePixel = 0
EnergyIcon.BorderColor3 = Color3.new(0, 0, 0)
EnergyIcon.Transparency = 1
EnergyIcon.Image = "rbxassetid://542310892"
EnergyIcon.ImageColor3 = Color3.new(0.882353, 1, 0)
EnergyIcon.Parent = System

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint.Parent = EnergyIcon

local Value = Instance.new("TextLabel")
Value.Name = "Value"
Value.Position = UDim2.new(1.6, 0, 0.5, 0)
Value.Size = UDim2.new(1.15, 0, 0.75, 0)
Value.BackgroundColor3 = Color3.new(1, 1, 1)
Value.BackgroundTransparency = 1
Value.BorderSizePixel = 0
Value.BorderColor3 = Color3.new(0, 0, 0)
Value.AnchorPoint = Vector2.new(0.5, 0.5)
Value.Transparency = 1
Value.Text = "0/100"
Value.TextColor3 = Color3.new(1, 0.882353, 0)
Value.TextSize = 14
Value.FontFace = Font.new("rbxasset://fonts/families/RobotoCondensed.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Value.TextScaled = true
Value.TextWrapped = true
Value.Parent = EnergyIcon

local GetCodeButton = Instance.new("TextButton")
GetCodeButton.Name = "GetCodeButton"
GetCodeButton.Position = UDim2.new(0.5, 0, 0.66, 0)
GetCodeButton.Size = UDim2.new(0.25, 0, 0.075, 0)
GetCodeButton.BackgroundColor3 = Color3.new(1, 0, 0.392157)
GetCodeButton.BorderSizePixel = 0
GetCodeButton.BorderColor3 = Color3.new(0, 0, 0)
GetCodeButton.Text = "Get code"
GetCodeButton.TextColor3 = Color3.new(1, 1, 1)
GetCodeButton.TextSize = 14
GetCodeButton.FontFace = Font.new("rbxasset://fonts/families/PatrickHand.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
GetCodeButton.TextScaled = true
GetCodeButton.TextWrapped = true
GetCodeButton.Parent = System

local UIStroke5 = Instance.new("UIStroke")
UIStroke5.Name = "UIStroke"
UIStroke5.Color = Color3.new(1, 1, 1)
UIStroke5.Thickness = 2
UIStroke5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke5.Parent = GetCodeButton

local CodeBox = Instance.new("TextBox")
CodeBox.Name = "CodeBox"
CodeBox.Position = UDim2.new(0.35, 0, 0.575, 0)
CodeBox.Size = UDim2.new(0.5, 0, 0.06, 0)
CodeBox.BackgroundColor3 = Color3.new(0.588235, 0, 0.588235)
CodeBox.BackgroundTransparency = 0.5
CodeBox.BorderSizePixel = 0
CodeBox.BorderColor3 = Color3.new(0, 0, 0)
CodeBox.Transparency = 0.5
CodeBox.Text = ""
CodeBox.TextColor3 = Color3.new(1, 1, 1)
CodeBox.TextSize = 14
CodeBox.FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
CodeBox.TextScaled = true
CodeBox.TextWrapped = true
CodeBox.PlaceholderText = "Paste the code here."
CodeBox.PlaceholderColor3 = Color3.new(1, 0.85098, 1)
CodeBox.Parent = System

local UIStroke6 = Instance.new("UIStroke")
UIStroke6.Name = "UIStroke"
UIStroke6.Color = Color3.new(1, 0, 1)
UIStroke6.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke6.Parent = CodeBox

local TextTip = Instance.new("TextLabel")
TextTip.Name = "TextTip"
TextTip.Position = UDim2.new(0.5, 0, -0.4, 0)
TextTip.Size = UDim2.new(1, 0, 0.75, 0)
TextTip.BackgroundColor3 = Color3.new(1, 1, 1)
TextTip.BackgroundTransparency = 1
TextTip.BorderSizePixel = 0
TextTip.BorderColor3 = Color3.new(0, 0, 0)
TextTip.AnchorPoint = Vector2.new(0.5, 0.5)
TextTip.Transparency = 1
TextTip.Text = "Enter the code to receive extra Energy (+10)"
TextTip.TextColor3 = Color3.new(1, 0, 0.392157)
TextTip.TextSize = 14
TextTip.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextTip.TextScaled = true
TextTip.TextWrapped = true
TextTip.Parent = CodeBox

local CheckButton = Instance.new("ImageButton")
CheckButton.Name = "CheckButton"
CheckButton.Position = UDim2.new(1.075, 0, 0.5, 0)
CheckButton.Size = UDim2.new(1, 0, 1, 0)
CheckButton.BackgroundColor3 = Color3.new(0, 1, 0)
CheckButton.BackgroundTransparency = 0.5
CheckButton.BorderSizePixel = 0
CheckButton.BorderColor3 = Color3.new(0, 0, 0)
CheckButton.AnchorPoint = Vector2.new(0.5, 0.5)
CheckButton.Transparency = 0.5
CheckButton.Image = "rbxassetid://12690727184"
CheckButton.Parent = CodeBox

local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint2.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint2.Parent = CheckButton

local UIStroke7 = Instance.new("UIStroke")
UIStroke7.Name = "UIStroke"
UIStroke7.Color = Color3.new(1, 0, 1)
UIStroke7.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke7.Parent = CheckButton

local EnergyEffect = Instance.new("ImageLabel")
EnergyEffect.Name = "EnergyEffect"
EnergyEffect.Position = UDim2.new(0.5, 0, 0.5, 0)
EnergyEffect.Size = UDim2.new(1, 0, 1, 0)
EnergyEffect.BackgroundColor3 = Color3.new(1, 1, 1)
EnergyEffect.BackgroundTransparency = 1
EnergyEffect.BorderSizePixel = 0
EnergyEffect.BorderColor3 = Color3.new(0, 0, 0)
EnergyEffect.Visible = false
EnergyEffect.AnchorPoint = Vector2.new(0.5, 0.5)
EnergyEffect.Transparency = 1
EnergyEffect.Image = "rbxassetid://542310892"
EnergyEffect.ImageColor3 = Color3.new(1, 1, 0)
EnergyEffect.Parent = CheckButton

local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint3.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint3.Parent = EnergyEffect

local gui = System
if gui then
	for _, obj in ipairs(gui:GetDescendants()) do
		if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
			obj.TextTransparency = 0
		end
	end
end
