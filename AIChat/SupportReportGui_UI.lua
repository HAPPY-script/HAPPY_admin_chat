local SupportReportGui = Instance.new("ScreenGui")
SupportReportGui.Name = "SupportReportGui"
SupportReportGui.ResetOnSpawn = false
SupportReportGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SupportReportGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Main4 = Instance.new("Frame")
Main4.Name = "Main"
Main4.Position = UDim2.new(0.5, 0, 0.5, 0)
Main4.Size = UDim2.new(0.7, 0, 0.7, 0)
Main4.BackgroundColor3 = Color3.new(0.0941177, 0.0941177, 0.0941177)
Main4.BorderSizePixel = 0
Main4.BorderColor3 = Color3.new(0, 0, 0)
Main4.AnchorPoint = Vector2.new(0.5, 0.5)
Main4.Visible = true
Main4.Parent = SupportReportGui

local UIARCMain = Instance.new("UIAspectRatioConstraint")
UIARCMain.Name = "UIARCMain"
UIARCMain.AspectRatio = 1.75
UIARCMain.Parent = Main4

local ChatDeveloper = Instance.new("ScrollingFrame")
ChatDeveloper.Name = "ChatDeveloper"
ChatDeveloper.Position = UDim2.new(0.625, 0, 0.5, 0)
ChatDeveloper.Size = UDim2.new(0.75, 0, 1, 0)
ChatDeveloper.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
ChatDeveloper.BorderSizePixel = 0
ChatDeveloper.BorderColor3 = Color3.new(0, 0, 0)
ChatDeveloper.AnchorPoint = Vector2.new(0.5, 0.5)
ChatDeveloper.Active = true
ChatDeveloper.ScrollBarThickness = 7
ChatDeveloper.Parent = Main4

local MyChat = Instance.new("Frame")
MyChat.Name = "MyChat"
MyChat.Position = UDim2.new(0.35, 0, 0.1, 0)
MyChat.Size = UDim2.new(0.55, 0, 0.04, 0)
MyChat.BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235)
MyChat.BorderSizePixel = 0
MyChat.BorderColor3 = Color3.new(0, 0, 0)
MyChat.Parent = ChatDeveloper

local TextChat = Instance.new("TextLabel")
TextChat.Name = "TextChat"
TextChat.Position = UDim2.new(0.5, 0, 0, 0)
TextChat.Size = UDim2.new(1, 0, 1, 0)
TextChat.BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235)
TextChat.BackgroundTransparency = 1
TextChat.BorderSizePixel = 0
TextChat.BorderColor3 = Color3.new(0, 0, 0)
TextChat.ZIndex = 2
TextChat.AnchorPoint = Vector2.new(0.5, 0)
TextChat.Transparency = 1
TextChat.Text = "..."
TextChat.TextColor3 = Color3.new(1, 1, 1)
TextChat.TextSize = 20
TextChat.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextChat.TextWrapped = true
TextChat.Parent = MyChat

local Avatar2 = Instance.new("ImageLabel")
Avatar2.Name = "Avatar"
Avatar2.Position = UDim2.new(1.075, 0, 0.75, 0)
Avatar2.Size = UDim2.new(1.15, 0, 1.15, 0)
Avatar2.BackgroundColor3 = Color3.new(1, 1, 1)
Avatar2.BackgroundTransparency = 1
Avatar2.BorderSizePixel = 0
Avatar2.BorderColor3 = Color3.new(0, 0, 0)
Avatar2.AnchorPoint = Vector2.new(0.5, 0.5)
Avatar2.Transparency = 1
Avatar2.Image = "rbxassetid://12928483360"
Avatar2.Parent = MyChat

local UIAspectRatioConstraint110 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint110.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint110.Parent = Avatar2

local UICorner200 = Instance.new("UICorner")
UICorner200.Name = "UICorner"
UICorner200.CornerRadius = UDim.new(1, 0)
UICorner200.Parent = Avatar2

local BackGroundFrame = Instance.new("Frame")
BackGroundFrame.Name = "BackGroundFrame"
BackGroundFrame.Position = UDim2.new(0.5, 0, 0, 0)
BackGroundFrame.Size = UDim2.new(1, 0, 1, 0)
BackGroundFrame.BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235)
BackGroundFrame.BorderSizePixel = 0
BackGroundFrame.BorderColor3 = Color3.new(0, 0, 0)
BackGroundFrame.AnchorPoint = Vector2.new(0.5, 0)
BackGroundFrame.Parent = MyChat

local DevChat = Instance.new("Frame")
DevChat.Name = "DevChat"
DevChat.Position = UDim2.new(-0.55, 0, 0.175, 0)
DevChat.Size = UDim2.new(0.55, 0, 0.04, 0)
DevChat.BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235)
DevChat.BorderSizePixel = 0
DevChat.BorderColor3 = Color3.new(0, 0, 0)
DevChat.Parent = ChatDeveloper

local BackGroundFrame2 = Instance.new("Frame")
BackGroundFrame2.Name = "BackGroundFrame"
BackGroundFrame2.Position = UDim2.new(0.5, 0, 0, 0)
BackGroundFrame2.Size = UDim2.new(1, 0, 1, 0)
BackGroundFrame2.BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235)
BackGroundFrame2.BorderSizePixel = 0
BackGroundFrame2.BorderColor3 = Color3.new(0, 0, 0)
BackGroundFrame2.AnchorPoint = Vector2.new(0.5, 0)
BackGroundFrame2.Parent = DevChat

local TextChat2 = Instance.new("TextLabel")
TextChat2.Name = "TextChat"
TextChat2.Position = UDim2.new(0.5, 0, 0, 0)
TextChat2.Size = UDim2.new(1, 0, 1, 0)
TextChat2.BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235)
TextChat2.BackgroundTransparency = 1
TextChat2.BorderSizePixel = 0
TextChat2.BorderColor3 = Color3.new(0, 0, 0)
TextChat2.ZIndex = 2
TextChat2.AnchorPoint = Vector2.new(0.5, 0)
TextChat2.Transparency = 1
TextChat2.Text = "..."
TextChat2.TextColor3 = Color3.new(1, 1, 1)
TextChat2.TextSize = 20
TextChat2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextChat2.TextWrapped = true
TextChat2.Parent = DevChat

local Avatar3 = Instance.new("ImageLabel")
Avatar3.Name = "Avatar"
Avatar3.Position = UDim2.new(-0.08, 0, 0.75, 0)
Avatar3.Size = UDim2.new(1.15, 0, 1.15, 0)
Avatar3.BackgroundColor3 = Color3.new(1, 1, 1)
Avatar3.BackgroundTransparency = 1
Avatar3.BorderSizePixel = 0
Avatar3.BorderColor3 = Color3.new(0, 0, 0)
Avatar3.AnchorPoint = Vector2.new(0.5, 0.5)
Avatar3.Transparency = 1
Avatar3.Image = "rbxassetid://90219562764375"
Avatar3.Parent = DevChat

local UIAspectRatioConstraint111 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint111.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint111.Parent = Avatar3

local UICorner201 = Instance.new("UICorner")
UICorner201.Name = "UICorner"
UICorner201.CornerRadius = UDim.new(1, 0)
UICorner201.Parent = Avatar3

local ChatAI = Instance.new("ScrollingFrame")
ChatAI.Name = "ChatAI"
ChatAI.Position = UDim2.new(0.625, 0, 0.5, 0)
ChatAI.Size = UDim2.new(0.75, 0, 1, 0)
ChatAI.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
ChatAI.BorderSizePixel = 0
ChatAI.BorderColor3 = Color3.new(0, 0, 0)
ChatAI.Visible = false
ChatAI.AnchorPoint = Vector2.new(0.5, 0.5)
ChatAI.Active = true
ChatAI.ScrollBarThickness = 7
ChatAI.Parent = Main4

local AIChat = Instance.new("Frame")
AIChat.Name = "AIChat"
AIChat.Position = UDim2.new(-0.55, 0, 0.175, 0)
AIChat.Size = UDim2.new(0.55, 0, 0.04, 0)
AIChat.BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235)
AIChat.BorderSizePixel = 0
AIChat.BorderColor3 = Color3.new(0, 0, 0)
AIChat.Parent = ChatAI

local BackGroundFrame3 = Instance.new("Frame")
BackGroundFrame3.Name = "BackGroundFrame"
BackGroundFrame3.Position = UDim2.new(0.5, 0, 0, 0)
BackGroundFrame3.Size = UDim2.new(1, 0, 1, 0)
BackGroundFrame3.BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235)
BackGroundFrame3.BorderSizePixel = 0
BackGroundFrame3.BorderColor3 = Color3.new(0, 0, 0)
BackGroundFrame3.AnchorPoint = Vector2.new(0.5, 0)
BackGroundFrame3.Parent = AIChat

local TextChat3 = Instance.new("TextLabel")
TextChat3.Name = "TextChat"
TextChat3.Position = UDim2.new(0.5, 0, 0, 0)
TextChat3.Size = UDim2.new(1, 0, 1, 0)
TextChat3.BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235)
TextChat3.BackgroundTransparency = 1
TextChat3.BorderSizePixel = 0
TextChat3.BorderColor3 = Color3.new(0, 0, 0)
TextChat3.ZIndex = 2
TextChat3.AnchorPoint = Vector2.new(0.5, 0)
TextChat3.Transparency = 1
TextChat3.Text = "..."
TextChat3.TextColor3 = Color3.new(1, 1, 1)
TextChat3.TextSize = 20
TextChat3.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextChat3.TextWrapped = true
TextChat3.Parent = AIChat

local Avatar4 = Instance.new("ImageLabel")
Avatar4.Name = "Avatar"
Avatar4.Position = UDim2.new(-0.08, 0, 0.75, 0)
Avatar4.Size = UDim2.new(1.15, 0, 1.15, 0)
Avatar4.BackgroundColor3 = Color3.new(1, 1, 1)
Avatar4.BackgroundTransparency = 1
Avatar4.BorderSizePixel = 0
Avatar4.BorderColor3 = Color3.new(0, 0, 0)
Avatar4.AnchorPoint = Vector2.new(0.5, 0.5)
Avatar4.Transparency = 1
Avatar4.Image = "rbxassetid://129880070293829"
Avatar4.Parent = AIChat

local UIAspectRatioConstraint112 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint112.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint112.Parent = Avatar4

local UICorner202 = Instance.new("UICorner")
UICorner202.Name = "UICorner"
UICorner202.CornerRadius = UDim.new(1, 0)
UICorner202.Parent = Avatar4

local MyChat2 = Instance.new("Frame")
MyChat2.Name = "MyChat"
MyChat2.Position = UDim2.new(0.35, 0, 0.1, 0)
MyChat2.Size = UDim2.new(0.55, 0, 0.04, 0)
MyChat2.BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235)
MyChat2.BorderSizePixel = 0
MyChat2.BorderColor3 = Color3.new(0, 0, 0)
MyChat2.Parent = ChatAI

local TextChat4 = Instance.new("TextLabel")
TextChat4.Name = "TextChat"
TextChat4.Position = UDim2.new(0.5, 0, 0, 0)
TextChat4.Size = UDim2.new(1, 0, 1, 0)
TextChat4.BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235)
TextChat4.BackgroundTransparency = 1
TextChat4.BorderSizePixel = 0
TextChat4.BorderColor3 = Color3.new(0, 0, 0)
TextChat4.ZIndex = 2
TextChat4.AnchorPoint = Vector2.new(0.5, 0)
TextChat4.Transparency = 1
TextChat4.Text = "..."
TextChat4.TextColor3 = Color3.new(1, 1, 1)
TextChat4.TextSize = 20
TextChat4.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextChat4.TextWrapped = true
TextChat4.Parent = MyChat2

local Avatar5 = Instance.new("ImageLabel")
Avatar5.Name = "Avatar"
Avatar5.Position = UDim2.new(1.075, 0, 0.75, 0)
Avatar5.Size = UDim2.new(1.15, 0, 1.15, 0)
Avatar5.BackgroundColor3 = Color3.new(1, 1, 1)
Avatar5.BackgroundTransparency = 1
Avatar5.BorderSizePixel = 0
Avatar5.BorderColor3 = Color3.new(0, 0, 0)
Avatar5.AnchorPoint = Vector2.new(0.5, 0.5)
Avatar5.Transparency = 1
Avatar5.Image = "rbxassetid://12928483360"
Avatar5.Parent = MyChat2

local UIAspectRatioConstraint113 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint113.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint113.Parent = Avatar5

local UICorner203 = Instance.new("UICorner")
UICorner203.Name = "UICorner"
UICorner203.CornerRadius = UDim.new(1, 0)
UICorner203.Parent = Avatar5

local BackGroundFrame4 = Instance.new("Frame")
BackGroundFrame4.Name = "BackGroundFrame"
BackGroundFrame4.Position = UDim2.new(0.5, 0, 0, 0)
BackGroundFrame4.Size = UDim2.new(1, 0, 1, 0)
BackGroundFrame4.BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235)
BackGroundFrame4.BorderSizePixel = 0
BackGroundFrame4.BorderColor3 = Color3.new(0, 0, 0)
BackGroundFrame4.AnchorPoint = Vector2.new(0.5, 0)
BackGroundFrame4.Parent = MyChat2

local ComeBackButton = Instance.new("ImageButton")
ComeBackButton.Name = "ComeBackButton"
ComeBackButton.Position = UDim2.new(0.04, 0, 0.93, 0)
ComeBackButton.Size = UDim2.new(0.125, 0, 0.125, 0)
ComeBackButton.BackgroundColor3 = Color3.new(1, 1, 1)
ComeBackButton.BackgroundTransparency = 1
ComeBackButton.BorderSizePixel = 0
ComeBackButton.BorderColor3 = Color3.new(0, 0, 0)
ComeBackButton.AnchorPoint = Vector2.new(0.5, 0.5)
ComeBackButton.Transparency = 1
ComeBackButton.Image = "rbxassetid://103860213946459"
ComeBackButton.Parent = Main4

local UIARCComeBackButton = Instance.new("UIAspectRatioConstraint")
UIARCComeBackButton.Name = "UIARCComeBackButton"

UIARCComeBackButton.Parent = ComeBackButton

local EnergyIcon = Instance.new("ImageLabel")
EnergyIcon.Name = "EnergyIcon"
EnergyIcon.Position = UDim2.new(0.01, 0, 0.015, 0)
EnergyIcon.Size = UDim2.new(0.1, 0, 0.1, 0)
EnergyIcon.BackgroundColor3 = Color3.new(1, 1, 1)
EnergyIcon.BackgroundTransparency = 1
EnergyIcon.BorderSizePixel = 0
EnergyIcon.BorderColor3 = Color3.new(0, 0, 0)
EnergyIcon.Transparency = 1
EnergyIcon.Image = "rbxassetid://542310892"
EnergyIcon.ImageColor3 = Color3.new(0.882353, 1, 0)
EnergyIcon.Parent = Main4

local UIAspectRatioConstraint114 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint114.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint114.Parent = EnergyIcon

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

local Developer = Instance.new("TextButton")
Developer.Name = "Developer"
Developer.Position = UDim2.new(0.01, 0, 0.2, 0)
Developer.Size = UDim2.new(0.23, 0, 0.078, 0)
Developer.BackgroundColor3 = Color3.new(0.0941177, 0.0941177, 0.0941177)
Developer.BorderSizePixel = 0
Developer.BorderColor3 = Color3.new(1, 1, 1)
Developer.Text = "Contact the developer"
Developer.TextColor3 = Color3.new(1, 1, 1)
Developer.TextSize = 14
Developer.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Developer.TextScaled = true
Developer.TextWrapped = true
Developer.TextXAlignment = Enum.TextXAlignment.Left
Developer.Parent = Main4

local UICorner204 = Instance.new("UICorner")
UICorner204.Name = "UICorner"
UICorner204.CornerRadius = UDim.new(0.2, 0)
UICorner204.Parent = Developer

local AI = Instance.new("TextButton")
AI.Name = "AI"
AI.Position = UDim2.new(0.01, 0, 0.3, 0)
AI.Size = UDim2.new(0.23, 0, 0.078, 0)
AI.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
AI.BorderSizePixel = 0
AI.BorderColor3 = Color3.new(1, 1, 1)
AI.Text = "Contact AI"
AI.TextColor3 = Color3.new(1, 1, 1)
AI.TextSize = 14
AI.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
AI.TextScaled = true
AI.TextWrapped = true
AI.TextXAlignment = Enum.TextXAlignment.Left
AI.Parent = Main4

local UICorner205 = Instance.new("UICorner")
UICorner205.Name = "UICorner"
UICorner205.CornerRadius = UDim.new(0.2, 0)
UICorner205.Parent = AI

local Instruct = Instance.new("TextLabel")
Instruct.Name = "Instruct"
Instruct.Position = UDim2.new(0.012, 0, 0.415, 0)
Instruct.Size = UDim2.new(0.225, 0, 0.45, 0)
Instruct.BackgroundColor3 = Color3.new(1, 1, 1)
Instruct.BackgroundTransparency = 1
Instruct.BorderSizePixel = 0
Instruct.BorderColor3 = Color3.new(0, 0, 0)
Instruct.Transparency = 1
Instruct.Text = "Contact the developer to send your message directly to the developer, but you'll have to wait a considerable amount of time for a response.\nContact the AI ​​to send a message to the developer's AI; the AI ​​will respond shortly, but the response won't be as accurate as the developer's."
Instruct.TextColor3 = Color3.new(0.541176, 0.541176, 0.541176)
Instruct.TextSize = 14
Instruct.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Instruct.TextScaled = true
Instruct.TextWrapped = true
Instruct.TextXAlignment = Enum.TextXAlignment.Left
Instruct.TextYAlignment = Enum.TextYAlignment.Top
Instruct.Parent = Main4

local InstructTitle = Instance.new("TextLabel")
InstructTitle.Name = "InstructTitle"
InstructTitle.Position = UDim2.new(0.5, 0, -0.0275, 0)
InstructTitle.Size = UDim2.new(0.35, 0, 0.085, 0)
InstructTitle.BackgroundColor3 = Color3.new(0.0941177, 0.0941177, 0.0941177)
InstructTitle.BorderSizePixel = 0
InstructTitle.BorderColor3 = Color3.new(0, 0, 0)
InstructTitle.AnchorPoint = Vector2.new(0.5, 0.5)
InstructTitle.Text = "Instruct"
InstructTitle.TextColor3 = Color3.new(1, 1, 1)
InstructTitle.TextSize = 14
InstructTitle.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
InstructTitle.TextScaled = true
InstructTitle.TextWrapped = true
InstructTitle.Parent = Instruct

local UIStroke148 = Instance.new("UIStroke")
UIStroke148.Name = "UIStroke"
UIStroke148.Color = Color3.new(1, 1, 1)
UIStroke148.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke148.Parent = Instruct

local ChatFrame = Instance.new("Frame")
ChatFrame.Name = "ChatFrame"
ChatFrame.Position = UDim2.new(0.625, 0, 0.925, 0)
ChatFrame.Size = UDim2.new(0.65, 0, 0.1, 0)
ChatFrame.BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235)
ChatFrame.BorderSizePixel = 0
ChatFrame.BorderColor3 = Color3.new(0, 0, 0)
ChatFrame.ZIndex = 2
ChatFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ChatFrame.Parent = Main4

local ChatBox = Instance.new("TextBox")
ChatBox.Name = "ChatBox"
ChatBox.Position = UDim2.new(0.5, 0, 0.5, 0)
ChatBox.Size = UDim2.new(0.8, 0, 1, 0)
ChatBox.BackgroundColor3 = Color3.new(1, 1, 1)
ChatBox.BackgroundTransparency = 1
ChatBox.BorderSizePixel = 0
ChatBox.BorderColor3 = Color3.new(0, 0, 0)
ChatBox.AnchorPoint = Vector2.new(0.5, 0.5)
ChatBox.Transparency = 1
ChatBox.Text = ""
ChatBox.TextColor3 = Color3.new(1, 1, 1)
ChatBox.TextSize = 20
ChatBox.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
ChatBox.TextWrapped = true
ChatBox.TextXAlignment = Enum.TextXAlignment.Left
ChatBox.ClearTextOnFocus = false
ChatBox.PlaceholderText = "You cannot undo the chat once you have started it."
ChatBox.PlaceholderColor3 = Color3.new(0.615686, 0.615686, 0.615686)
ChatBox.Parent = ChatFrame

local UICorner206 = Instance.new("UICorner")
UICorner206.Name = "UICorner"
UICorner206.CornerRadius = UDim.new(1, 0)
UICorner206.Parent = ChatFrame

local SendButton = Instance.new("ImageButton")
SendButton.Name = "SendButton"
SendButton.Position = UDim2.new(0.922, 0, 0.5, 0)
SendButton.Size = UDim2.new(0.8, 0, 0.8, 0)
SendButton.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
SendButton.BorderSizePixel = 0
SendButton.BorderColor3 = Color3.new(0, 0, 0)
SendButton.AnchorPoint = Vector2.new(0, 0.5)
SendButton.Parent = ChatFrame

local UIARCSendButton = Instance.new("UIAspectRatioConstraint")
UIARCSendButton.Name = "UIARCSendButton"

UIARCSendButton.Parent = SendButton

local UICorner207 = Instance.new("UICorner")
UICorner207.Name = "UICorner"
UICorner207.CornerRadius = UDim.new(1, 0)
UICorner207.Parent = SendButton

local Icon3 = Instance.new("ImageLabel")
Icon3.Name = "Icon"
Icon3.Position = UDim2.new(0.5, 0, 0.5, 0)
Icon3.Size = UDim2.new(0.75, 0, 0.75, 0)
Icon3.BackgroundColor3 = Color3.new(1, 1, 1)
Icon3.BackgroundTransparency = 1
Icon3.BorderSizePixel = 0
Icon3.BorderColor3 = Color3.new(0, 0, 0)
Icon3.AnchorPoint = Vector2.new(0.5, 0.5)
Icon3.Transparency = 1
Icon3.Image = "rbxassetid://93632981420289"
Icon3.Parent = SendButton

local ExtendButton = Instance.new("ImageButton")
ExtendButton.Name = "ExtendButton"
ExtendButton.Position = UDim2.new(0.01, 0, 0.5, 0)
ExtendButton.Size = UDim2.new(0.8, 0, 0.8, 0)
ExtendButton.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
ExtendButton.BorderSizePixel = 0
ExtendButton.BorderColor3 = Color3.new(0, 0, 0)
ExtendButton.AnchorPoint = Vector2.new(0, 0.5)
ExtendButton.Parent = ChatFrame

local UIARCSendButton2 = Instance.new("UIAspectRatioConstraint")
UIARCSendButton2.Name = "UIARCSendButton"

UIARCSendButton2.Parent = ExtendButton

local UICorner208 = Instance.new("UICorner")
UICorner208.Name = "UICorner"
UICorner208.CornerRadius = UDim.new(1, 0)
UICorner208.Parent = ExtendButton

local Icon4 = Instance.new("ImageLabel")
Icon4.Name = "Icon"
Icon4.Position = UDim2.new(0.5, 0, 0.5, 0)
Icon4.Size = UDim2.new(0.75, 0, 0.75, 0)
Icon4.BackgroundColor3 = Color3.new(1, 1, 1)
Icon4.BackgroundTransparency = 1
Icon4.BorderSizePixel = 0
Icon4.BorderColor3 = Color3.new(0, 0, 0)
Icon4.AnchorPoint = Vector2.new(0.5, 0.5)
Icon4.Transparency = 1
Icon4.Image = "rbxassetid://98892580149497"
Icon4.Parent = ExtendButton

local WaitDot = Instance.new("Frame")
WaitDot.Name = "WaitDot"
WaitDot.Position = UDim2.new(-0.025, 0, -0.5, 0)
WaitDot.Size = UDim2.new(0.25, 0, 0.25, 0)
WaitDot.BackgroundColor3 = Color3.new(1, 1, 1)
WaitDot.BorderSizePixel = 0
WaitDot.BorderColor3 = Color3.new(0, 0, 0)
WaitDot.AnchorPoint = Vector2.new(0.5, 0.5)
WaitDot.Parent = ChatFrame

local UICorner209 = Instance.new("UICorner")
UICorner209.Name = "UICorner"
UICorner209.CornerRadius = UDim.new(1, 0)
UICorner209.Parent = WaitDot

local UIAspectRatioConstraint115 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint115.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint115.Parent = WaitDot

local DoneButton = Instance.new("TextButton")
DoneButton.Name = "DoneButton"
DoneButton.Position = UDim2.new(0.8, 0, -1, 0)
DoneButton.Size = UDim2.new(0.175, 0, 0.7, 0)
DoneButton.BackgroundColor3 = Color3.new(1, 1, 1)
DoneButton.BorderSizePixel = 0
DoneButton.BorderColor3 = Color3.new(0, 0, 0)
DoneButton.Visible = false
DoneButton.Text = "Done"
DoneButton.TextColor3 = Color3.new(0, 0, 0)
DoneButton.TextSize = 14
DoneButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
DoneButton.TextScaled = true
DoneButton.TextWrapped = true
DoneButton.Parent = ChatFrame

local UICorner210 = Instance.new("UICorner")
UICorner210.Name = "UICorner"
UICorner210.CornerRadius = UDim.new(1, 0)
UICorner210.Parent = DoneButton

local Notification = Instance.new("TextLabel")
Notification.Name = "Notification"
Notification.Position = UDim2.new(-1, 0, 0.4, 0)
Notification.Size = UDim2.new(2, 0, 2, 0)
Notification.BackgroundColor3 = Color3.new(1, 1, 1)
Notification.BackgroundTransparency = 1
Notification.BorderSizePixel = 0
Notification.BorderColor3 = Color3.new(0, 0, 0)
Notification.AnchorPoint = Vector2.new(0.5, 0.5)
Notification.Transparency = 1
Notification.Text = "The conversation has ended, please confirm that the conversation is complete."
Notification.TextColor3 = Color3.new(1, 1, 1)
Notification.TextSize = 14
Notification.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Notification.TextScaled = true
Notification.TextWrapped = true
Notification.Parent = DoneButton

local ChatFrameExtend = Instance.new("Frame")
ChatFrameExtend.Name = "ChatFrameExtend"
ChatFrameExtend.Position = UDim2.new(0.625, 0, 0.725, 0)
ChatFrameExtend.Size = UDim2.new(0.65, 0, 0.5, 0)
ChatFrameExtend.BackgroundColor3 = Color3.new(0.188235, 0.188235, 0.188235)
ChatFrameExtend.BorderSizePixel = 0
ChatFrameExtend.BorderColor3 = Color3.new(0, 0, 0)
ChatFrameExtend.Visible = false
ChatFrameExtend.AnchorPoint = Vector2.new(0.5, 0.5)
ChatFrameExtend.Parent = Main4

local UICorner211 = Instance.new("UICorner")
UICorner211.Name = "UICorner"
UICorner211.CornerRadius = UDim.new(0.15, 0)
UICorner211.Parent = ChatFrameExtend

local TitleChannel = Instance.new("TextLabel")
TitleChannel.Name = "TitleChannel"
TitleChannel.Position = UDim2.new(0.625, 0, 0.05, 0)
TitleChannel.Size = UDim2.new(0.75, 0, 0.1, 0)
TitleChannel.BackgroundColor3 = Color3.new(0.164706, 0.164706, 0.164706)
TitleChannel.BorderSizePixel = 0
TitleChannel.BorderColor3 = Color3.new(0, 0, 0)
TitleChannel.AnchorPoint = Vector2.new(0.5, 0.5)
TitleChannel.Text = "Chat with developer"
TitleChannel.TextColor3 = Color3.new(1, 1, 1)
TitleChannel.TextSize = 14
TitleChannel.FontFace = Font.new("rbxasset://fonts/families/PatrickHand.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TitleChannel.TextScaled = true
TitleChannel.TextWrapped = true
TitleChannel.Parent = Main4

local Frame = SupportReportGui
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
