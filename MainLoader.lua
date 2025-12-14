local Players = game:GetService("Players")
local player = Players.LocalPlayer

--=====================================================
-- 1. Load UI Registry
--=====================================================
loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/refs/heads/main/UIRegistry.lua"
))()

local UI = shared.UI
if not UI then
    warn("UIRegistry failed to load")
    return
end

--=====================================================
-- 2. Load UI creation files
--=====================================================
loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/refs/heads/main/UI1.lua"
))()

loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/refs/heads/main/UI2.lua"
))()

--=====================================================
-- 3. Register ALL UI instances
--=====================================================
local gui = player:WaitForChild("PlayerGui"):WaitForChild("HAPPYscript")
UI.RegisterAll(gui)
