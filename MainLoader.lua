-- Load registry
loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/refs/heads/main/UIRegistry.lua"))()

-- Load UI parts
loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/refs/heads/main/UI1.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/refs/heads/main/UI2.lua"))()

-- Register ALL UI (sau khi TẤT CẢ đã tạo xong)
local gui = game.Players.LocalPlayer.PlayerGui:WaitForChild("HAPPYscript")
shared.UI.RegisterAll(gui)
