local Tip2 = Instance.new("TextLabel")
Tip2.Name = "Tip"
Tip2.Position = UDim2.new(0.625, 0, 0.25, 0)
Tip2.Size = UDim2.new(0.65, 0, 0.35, 0)
Tip2.BackgroundColor3 = Color3.new(1, 1, 1)
Tip2.BackgroundTransparency = 1
Tip2.BorderSizePixel = 0
Tip2.BorderColor3 = Color3.new(0, 0, 0)
Tip2.AnchorPoint = Vector2.new(0.5, 0.5)
Tip2.Transparency = 1
Tip2.Text = "If you want the script to run automatically once the next time you run the script, press Return[1], if you want it to run automatically forever, press Return[ifn]."
Tip2.TextColor3 = Color3.new(1, 0.882353, 0)
Tip2.TextSize = 14
Tip2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Tip2.TextScaled = true
Tip2.TextWrapped = true
Tip2.Parent = Noti

local Return1 = Instance.new("ImageButton")
Return1.Name = "Return1"
Return1.Position = UDim2.new(0.35, 0, 0.5, 0)
Return1.Size = UDim2.new(0.25, 0, 0.25, 0)
Return1.BackgroundColor3 = Color3.new(0, 0, 0)
Return1.BorderSizePixel = 0
Return1.BorderColor3 = Color3.new(0, 0, 0)
Return1.Image = "rbxassetid://88913662931777"
Return1.Parent = Noti

local UIAspectRatioConstraint18 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint18.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint18.Parent = Return1

local UICorner44 = Instance.new("UICorner")
UICorner44.Name = "UICorner"
UICorner44.CornerRadius = UDim.new(1, 0)
UICorner44.Parent = Return1

local ReturnIfn = Instance.new("ImageButton")
ReturnIfn.Name = "ReturnIfn"
ReturnIfn.Position = UDim2.new(0.525, 0, 0.5, 0)
ReturnIfn.Size = UDim2.new(0.25, 0, 0.25, 0)
ReturnIfn.BackgroundColor3 = Color3.new(0, 0, 0)
ReturnIfn.BorderSizePixel = 0
ReturnIfn.BorderColor3 = Color3.new(0, 0, 0)
ReturnIfn.Image = "rbxassetid://121046862191317"
ReturnIfn.Parent = Noti

local UIAspectRatioConstraint19 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint19.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint19.Parent = ReturnIfn

local UICorner45 = Instance.new("UICorner")
UICorner45.Name = "UICorner"
UICorner45.CornerRadius = UDim.new(1, 0)
UICorner45.Parent = ReturnIfn
