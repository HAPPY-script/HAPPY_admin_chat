local UI = shared.UI or {}
-- nếu UI đã có các hàm, giữ lại (tránh ghi đè)
if not UI.Register then
    function UI.Register(name, instance)
        if not name or name == "" or not instance then return false end
        -- tránh ghi đè; nếu trùng tên, tạo tên phụ bằng hậu tố
        if UI[name] and UI[name] ~= instance then
            local i = 2
            local base = name
            while UI[base .. "_" .. i] do i = i + 1 end
            UI[base .. "_" .. i] = instance
            return base .. "_" .. i
        end
        UI[name] = instance
        return name
    end

    function UI.Get(name) return UI[name] end

    -- Đăng ký tất cả GuiObject descendants của root (gọi sau khi UI đã tạo xong)
    function UI.RegisterAll(root)
        if not root or not root.GetDescendants then return end
        for _, inst in ipairs(root:GetDescendants()) do
            -- bạn có thể mở rộng điều kiện nếu muốn: TextLabel, Frame, ImageLabel, TextBox, Button, v.v.
            if inst and inst.Name and type(inst.Name) == "string" then
                -- filter: chỉ register GuiObjects, Value objects, hoặc những thứ bạn cần
                local okType = false
                if inst:IsA("GuiObject") or inst:IsA("GuiButton") or inst:IsA("TextService") or inst:IsA("ImageLabel")
                   or inst:IsA("TextLabel") or inst:IsA("TextBox") or inst:IsA("Frame") or inst:IsA("ScrollingFrame")
                   or inst:IsA("ScreenGui") or inst:IsA("UICorner") or inst:IsA("UIAspectRatioConstraint") or inst:IsA("UIStroke")
                then
                    okType = true
                end
                if okType then
                    UI.Register(inst.Name, inst)
                end
            end
        end
        return true
    end

    -- tiện ích: trả về tất cả keys đã đăng ký
    function UI.List()
        local out = {}
        for k,v in pairs(UI) do
            if type(k) == "string" and k ~= "Register" and k ~= "Get" and k ~= "RegisterAll" and k ~= "List" then
                table.insert(out, k)
            end
        end
        table.sort(out)
        return out
    end
end

shared.UI = UI
return UI
