local UI = shared.UI or {}

function UI.Register(name, inst)
    if not name or not inst then return end
    if UI[name] and UI[name] ~= inst then
        local i = 2
        while UI[name .. "_" .. i] do i += 1 end
        UI[name .. "_" .. i] = inst
    else
        UI[name] = inst
    end
end

function UI.Get(name)
    return UI[name]
end

function UI.RegisterAll(root)
    if not root then return end
    for _, inst in ipairs(root:GetDescendants()) do
        if inst:IsA("GuiObject") or inst:IsA("ScreenGui") then
            UI.Register(inst.Name, inst)
        end
    end
end

function UI.List()
    local t = {}
    for k,v in pairs(UI) do
        if typeof(v) == "Instance" then
            table.insert(t, k)
        end
    end
    table.sort(t)
    return t
end

shared.UI = UI
return UI
