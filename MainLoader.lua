local UI = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/refs/heads/main/UIRegistry.lua"
))()

shared.__UI_REGISTRY__ = UI

-- load UI creators
loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/refs/heads/main/UI1.lua"
))()

loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/refs/heads/main/UI2.lua"
))()

-- load setting sau cùng
loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/HAPPY-script/HAPPY_admin_chat/refs/heads/main/EditingProperties.lua"
))()
