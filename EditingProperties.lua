local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = player:WaitForChild("PlayerGui"):WaitForChild("HAPPYscript")

--=====================================================
-- RULES: Name -> { Property = Value }
--=====================================================
local RULES = {
    Version = {
        TextTransparency = 0,
        TextStrokeTransparency = 0,
    },

    Back = {
        TextTransparency = 0,
    },

    Done = {
        TextTransparency = 0,
    },

    Tip = {
        TextTransparency = 0,
        TextStrokeTransparency = 0.5,
    },

    Tip2 = {
        TextTransparency = 0,
    },

    Title = {
        TextTransparency = 0,
    },

    System2 = { TextTransparency = 0 },
    Character2 = { TextTransparency = 0 },
    GameHub2 = { TextTransparency = 0 },

    System = { TextTransparency = 0 },
    Character = { TextTransparency = 0 },
    GameHub = { TextTransparency = 0 },

    Name11 = { TextTransparency = 1 },
    Name12 = { TextTransparency = 1 },
    Name13 = { TextTransparency = 0 },

    ReportTitle = { TextTransparency = 0 },
    MaxText     = { TextTransparency = 0 },
    TextBox     = { TextTransparency = 0 },
    OkButton    = { TextTransparency = 0 },

    MyFeedback     = { TextTransparency = 0 },
    AdminFeedback  = { TextTransparency = 0 },
    MyTitle        = { TextTransparency = 0 },
    AdminTitle     = { TextTransparency = 0 },
}

--=====================================================
-- APPLY
--=====================================================
for _, inst in ipairs(gui:GetDescendants()) do
    local rule = RULES[inst.Name]
    if rule then
        for prop, value in pairs(rule) do
            pcall(function()
                inst[prop] = value
            end)
        end
    end
end
