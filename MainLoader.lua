local Players = game:GetService("Players")
local player = Players.LocalPlayer

--=====================================================
-- 1. Load UI Registry (shared.UI)
--=====================================================
loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/main/UIRegistry.lua"
))()

-- đảm bảo registry tồn tại
local UI = shared.UI
if not UI then
    error("UIRegistry failed to load")
end

--=====================================================
-- 2. Load UI creation files
--=====================================================
loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/main/UI1.lua"
))()

loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/main/UI2.lua"
))()

-- nếu còn UI3, UI4 thì thêm ở đây

--=====================================================
-- 3. Register ALL UI instances (1 lần duy nhất)
--=====================================================
local gui = player:WaitForChild("PlayerGui"):WaitForChild("HAPPYscript")
UI.RegisterAll(gui)

--=====================================================
-- 4. Apply UI properties / settings
--=====================================================
loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/main/EditingProperties.lua"
))()
