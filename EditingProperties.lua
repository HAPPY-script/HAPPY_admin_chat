local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/refs/heads/main/UIRegistry.lua"))()
-- hoặc lấy từ shared nếu đã load trước
UI = shared.UI or UI

local function safeSet(name, prop, value)
    local inst = UI.Get(name)
    if not inst then return false end
    pcall(function() inst[prop] = value end)
    return true
end

set("Version", "TextTransparency", 0)
set("Version", "TextStrokeTransparency", 0)

set("Back", "TextTransparency", 0)
set("Done", "TextTransparency", 0)

set("Tip", "TextTransparency", 0)
set("Tip", "TextStrokeTransparency", 0.5)
set("Tip2", "TextTransparency", 0)

set("System2", "TextTransparency", 0)

set("Title", "TextTransparency", 0)

set("Character2", "TextTransparency", 0)
set("GameHub2", "TextTransparency", 0)

set("Name11", "TextTransparency", 1)
set("Name12", "TextTransparency", 1)
set("Name13", "TextTransparency", 1)

set("ReportTitle", "TextTransparency", 0)
set("MaxText", "TextTransparency", 0)
set("TextBox", "TextTransparency", 0)
set("OkButton", "TextTransparency", 0)

set("MyFeedback", "TextTransparency", 0)
set("AdminFeedback", "TextTransparency", 0)

set("MyTitle", "TextTransparency", 0)
set("AdminTitle", "TextTransparency", 0)
