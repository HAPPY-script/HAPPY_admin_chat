local UI = shared.UI or {}

function UI.Register(name, instance)
    if not name or not instance then return end
    if not UI[name] then
        UI[name] = instance
    end
end

function UI.Get(name)
    return UI[name]
end

function UI.Wait(name, timeout)
    timeout = timeout or 10
    local t = 0
    while t < timeout do
        if UI[name] then
            return UI[name]
        end
        task.wait(0.1)
        t += 0.1
    end
    return nil
end

function UI.RegisterAll(root)
    for _, inst in ipairs(root:GetDescendants()) do
        if inst:IsA("GuiObject") or inst:IsA("GuiButton") then
            UI.Register(inst.Name, inst)
        end
    end
end

shared.UI = UI
return UI
