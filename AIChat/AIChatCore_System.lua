--==========================
--  AUTO DETECT HTTP REQUEST
--==========================
local function HttpRequest(data)
	if syn and syn.request then
		return syn.request(data)
	elseif http and http.request then
		return http.request(data)
	elseif http_request then
		return http_request(data)
	elseif request then
		return request(data)
	elseif fluxus and fluxus.request then
		return fluxus.request(data)
	else
		error("Executor không hỗ trợ HTTP Request!")
	end
end

--==========================
--  CONFIG
--==========================
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player and player:FindFirstChild("PlayerGui")

-- Worker URL của bạn
local AI_URL = "https://chatai.happy37135535.workers.dev"

--==========================
--  FUNCTION: ASK AI
--==========================
local function AskAI(question)
	print("[YOU] Sending:", question)

	local payload = {
		message = question
	}

	local ok, res = pcall(function()
		return HttpRequest({
			Url = AI_URL,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json"
			},
			Body = HttpService:JSONEncode(payload)
		})
	end)

	if not ok or not res then
		warn("[AI] Không nhận được phản hồi hoặc request lỗi!")
		return nil
	end

	if res.StatusCode ~= 200 then
		warn("[AI] StatusCode:", res.StatusCode)
		warn("[AI] Body:", res.Body)
		return nil
	end

	local decoded
	local ok2, dec = pcall(function()
		return HttpService:JSONDecode(res.Body or "{}")
	end)
	if not ok2 then
		warn("[AI] Lỗi decode JSON:", res.Body)
		return nil
	end
	decoded = dec

	if not decoded.reply then
		warn("[AI] Response lỗi (không có field 'reply'):", res.Body)
		return nil
	end

	return decoded.reply
end

--==========================
--  TEST AI SYSTEM (giữ nếu bạn muốn test manual)
--==========================
print("====================================")
print("   HAPPY SCRIPT AI ASSISTANT READY")
print("====================================")

-- (Tùy chọn) test manual
-- local answer = AskAI("Hoho Hub là hãng script như nào?, gồm có chức năng gì?")
-- if answer then
--     print("====================================")
--     print("AI Reply:")
--     print(answer)
--     print("====================================")
-- else
--     warn("AI không trả lời được!")
-- end

--==========================
--  LISTENER: lắng nghe MyChatSent và trả reply qua _G.AIChat()
--==========================
-- Helper: tìm BindableEvent "MyChatSent" trong PlayerGui descendants (chờ tới khi có)
local function waitForMyChatEvent()
	if not playerGui then
		-- cố gắng lấy PlayerGui nếu chưa có
		player = Players.LocalPlayer
		playerGui = player and player:WaitForChild("PlayerGui", 2)
	end

	local ev = nil
	repeat
		if playerGui then
			for _, v in ipairs(playerGui:GetDescendants()) do
				if v.Name == "MyChatSent" and v:IsA("BindableEvent") then
					ev = v
					break
				end
			end
		end
		if not ev then task.wait(0.05) end
	until ev
	return ev
end

task.spawn(function()
	local myChatEvent = waitForMyChatEvent()
	if not myChatEvent then
		warn("[AIResponder] Không tìm thấy MyChatSent BindableEvent")
		return
	end

	print("[AIResponder] MyChatSent found, listening...")

	myChatEvent.Event:Connect(function(channelName, message)
		-- Chỉ xử lý kênh AI — nếu muốn xử lý Developer đổi điều kiện
		if tostring(channelName) ~= "AI" then
			-- bạn có thể uncomment dòng dưới để auto phản hồi developer bằng AI nếu cần
			-- return
			return
		end

		-- xử lý async (không block event loop)
		task.spawn(function()
			-- optional: debounce / rate limit nếu muốn (ở đây không có)
			if not message or message == "" then
				warn("[AIResponder] Received empty message")
				return
			end

			-- gọi AskAI trong pcall để catch lỗi
			local ok, reply = pcall(AskAI, message)
			if not ok or not reply then
				warn("[AIResponder] AskAI lỗi hoặc không trả về reply")
				-- bạn có thể gửi thông báo lỗi về UI nếu muốn:
				-- if _G and type(_G.AIChat) == "function" then pcall(_G.AIChat, "AI lỗi hoặc không trả lời") end
				return
			end

			-- gửi reply trở lại UI bằng _G.AIChat
			if _G and type(_G.AIChat) == "function" then
				pcall(function()
					_G.AIChat(reply)
				end)
			else
				warn("[AIResponder] _G.AIChat không tồn tại để trả lời")
			end
		end)
	end)
end)
