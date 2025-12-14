local UI = loadstring(game:HttpGet("RAW_GITHUB_URL/UIRegistry.lua"))()

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
