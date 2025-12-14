local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/refs/heads/main/UIRegistry.lua"))()

local function set(name, prop, value)
    local obj = UI[name]
    if obj then
        obj[prop] = value
    end
end

set("Version", "TextTransparency", 0)
set("Tip", "TextStrokeTransparency", 0.5)
set("OkButton", "TextTransparency", 0)
set("MyFeedback", "TextTransparency", 0)
set("AdminFeedback", "TextTransparency", 0)
