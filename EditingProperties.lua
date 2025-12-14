local UI = shared.UI
if not UI or type(UI.Get) ~= "function" then
    warn("[EditingProperties] UI Registry not ready")
    return
end

local function safeSet(name, prop, value)
    local inst = UI.Get(name)
    if not inst then return end

    pcall(function()
        inst[prop] = value
    end)
end

-- APPLY
safeSet("Version", "TextTransparency", 0)
safeSet("Version", "TextStrokeTransparency", 0)

safeSet("Back", "TextTransparency", 0)
safeSet("Done", "TextTransparency", 0)

safeSet("Tip", "TextTransparency", 0)
safeSet("Tip", "TextStrokeTransparency", 0.5)
safeSet("Tip2", "TextTransparency", 0)

safeSet("Title", "TextTransparency", 0)

safeSet("Character2", "TextTransparency", 0)
safeSet("GameHub2", "TextTransparency", 0)
safeSet("System2", "TextTransparency", 0)

safeSet("Character", "TextTransparency", 0)
safeSet("GameHub", "TextTransparency", 0)
safeSet("System", "TextTransparency", 0)

safeSet("Name11", "TextTransparency", 1)
safeSet("Name12", "TextTransparency", 1)
safeSet("Name13", "TextTransparency", 1)

safeSet("ReportTitle", "TextTransparency", 0)
safeSet("MaxText", "TextTransparency", 0)
safeSet("TextBox", "TextTransparency", 0)
safeSet("OkButton", "TextTransparency", 0)

safeSet("MyFeedback", "TextTransparency", 0)
safeSet("AdminFeedback", "TextTransparency", 0)

safeSet("MyTitle", "TextTransparency", 0)
safeSet("AdminTitle", "TextTransparency", 0)
