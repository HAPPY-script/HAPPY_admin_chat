-------------------------------------------------------------------------------
--! json library
--! cryptography library
local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;local e;local l={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local P={["/"]="/"}for Q,R in pairs(l)do P[R]=Q end;local S=function(T)return"\\"..(l[T]or string.format("u%04x",T:byte()))end;local B=function(M)return"null"end;local v=function(M,z)local _={}z=z or{}if z[M]then error("circular reference")end;z[M]=true;if rawget(M,1)~=nil or next(M)==nil then local A=0;for Q in pairs(M)do if type(Q)~="number"then error("invalid table: mixed or invalid key types")end;A=A+1 end;if A~=#M then error("invalid table: sparse array")end;for a0,R in ipairs(M)do table.insert(_,e(R,z))end;z[M]=nil;return"["..table.concat(_,",").."]"else for Q,R in pairs(M)do if type(Q)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(_,e(Q,z)..":"..e(R,z))end;z[M]=nil;return"{"..table.concat(_,",").."}"end end;local g=function(M)return'"'..M:gsub('[%z\1-\31\\"]',S)..'"'end;local a1=function(M)if M~=M or M<=-math.huge or M>=math.huge then error("unexpected number value '"..tostring(M).."'")end;return string.format("%.14g",M)end;local j={["nil"]=B,["table"]=v,["string"]=g,["number"]=a1,["boolean"]=tostring}e=function(M,z)local x=type(M)local a2=j[x]if a2 then return a2(M,z)end;error("unexpected type '"..x.."'")end;local a3=function(M)return e(M)end;local a4;local N=function(...)local _={}for a0=1,select("#",...)do _[select(a0,...)]=true end;return _ end;local L=N(" ","\t","\r","\n")local p=N(" ","\t","\r","\n","]","}",",")local a5=N("\\","/",'"',"b","f","n","r","t","u")local m=N("true","false","null")local a6={["true"]=true,["false"]=false,["null"]=nil}local a7=function(a8,a9,aa,ab)for a0=a9,#a8 do if aa[a8:sub(a0,a0)]~=ab then return a0 end end;return#a8+1 end;local ac=function(a8,a9,J)local ad=1;local ae=1;for a0=1,a9-1 do ae=ae+1;if a8:sub(a0,a0)=="\n"then ad=ad+1;ae=1 end end;error(string.format("%s at line %d col %d",J,ad,ae))end;local af=function(A)local a2=math.floor;if A<=0x7f then return string.char(A)elseif A<=0x7ff then return string.char(a2(A/64)+192,A%64+128)elseif A<=0xffff then return string.char(a2(A/4096)+224,a2(A%4096/64)+128,A%64+128)elseif A<=0x10ffff then return string.char(a2(A/262144)+240,a2(A%262144/4096)+128,a2(A%4096/64)+128,A%64+128)end;error(string.format("invalid unicode codepoint '%x'",A))end;local ag=function(ah)local ai=tonumber(ah:sub(1,4),16)local aj=tonumber(ah:sub(7,10),16)if aj then return af((ai-0xd800)*0x400+aj-0xdc00+0x10000)else return af(ai)end end;local ak=function(a8,a0)local _=""local al=a0+1;local Q=al;while al<=#a8 do local am=a8:byte(al)if am<32 then ac(a8,al,"control character in string")elseif am==92 then _=_..a8:sub(Q,al-1)al=al+1;local T=a8:sub(al,al)if T=="u"then local an=a8:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",al+1)or a8:match("^%x%x%x%x",al+1)or ac(a8,al-1,"invalid unicode escape in string")_=_..ag(an)al=al+#an else if not a5[T]then ac(a8,al-1,"invalid escape char '"..T.."' in string")end;_=_..P[T]end;Q=al+1 elseif am==34 then _=_..a8:sub(Q,al-1)return _,al+1 end;al=al+1 end;ac(a8,a0,"expected closing quote for string")end;local ao=function(a8,a0)local am=a7(a8,a0,p)local ah=a8:sub(a0,am-1)local A=tonumber(ah)if not A then ac(a8,a0,"invalid number '"..ah.."'")end;return A,am end;local ap=function(a8,a0)local am=a7(a8,a0,p)local aq=a8:sub(a0,am-1)if not m[aq]then ac(a8,a0,"invalid literal '"..aq.."'")end;return a6[aq],am end;local ar=function(a8,a0)local _={}local A=1;a0=a0+1;while 1 do local am;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="]"then a0=a0+1;break end;am,a0=a4(a8,a0)_[A]=am;A=A+1;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="]"then break end;if as~=","then ac(a8,a0,"expected ']' or ','")end end;return _,a0 end;local at=function(a8,a0)local _={}a0=a0+1;while 1 do local au,M;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="}"then a0=a0+1;break end;if a8:sub(a0,a0)~='"'then ac(a8,a0,"expected string for key")end;au,a0=a4(a8,a0)a0=a7(a8,a0,L,true)if a8:sub(a0,a0)~=":"then ac(a8,a0,"expected ':' after key")end;a0=a7(a8,a0+1,L,true)M,a0=a4(a8,a0)_[au]=M;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="}"then break end;if as~=","then ac(a8,a0,"expected '}' or ','")end end;return _,a0 end;local av={['"']=ak,["0"]=ao,["1"]=ao,["2"]=ao,["3"]=ao,["4"]=ao,["5"]=ao,["6"]=ao,["7"]=ao,["8"]=ao,["9"]=ao,["-"]=ao,["t"]=ap,["f"]=ap,["n"]=ap,["["]=ar,["{"]=at}a4=function(a8,a9)local as=a8:sub(a9,a9)local a2=av[as]if a2 then return a2(a8,a9)end;ac(a8,a9,"unexpected character '"..as.."'")end;local aw=function(a8)if type(a8)~="string"then error("expected argument of type string, got "..type(a8))end;local _,a9=a4(a8,a7(a8,1,L,true))a9=a7(a8,a9,L,true)if a9<=#a8 then ac(a8,a9,"trailing garbage")end;return _ end;
local lEncode, lDecode, lDigest = a3, aw, Z;
-------------------------------------------------------------------------------

-- LocalScript (place inside System)
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
if not player then repeat task.wait() until Players.LocalPlayer; player = Players.LocalPlayer end
local playerGui = player:WaitForChild("PlayerGui")

-- Wait path (no timeout)
local System = playerGui:WaitForChild("HAPPYscript"):WaitForChild("Main"):WaitForChild("ScrollingFrame"):WaitForChild("System")

-- UI refs (use WaitForChild to guarantee presence)
local CodeBox = System:WaitForChild("CodeBox")
local GetCodeButton = System:WaitForChild("GetCodeButton")
-- CheckButton is described as inside CodeBox; fallback to System child
local CheckButton = (CodeBox:FindFirstChild("CheckButton") or System:FindFirstChild("CheckButton"))
local EnergyIcon = System:FindFirstChild("EnergyIcon")
local EnergyValueLabel = EnergyIcon and (EnergyIcon:FindFirstChild("Value") or EnergyIcon:FindFirstChildWhichIsA("TextLabel"))

-- config
local REWARD_ENERGY = 10
local ENERGY_MAX = 100

-- safe notify
local function uiNotify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", { Title = title or "Notice", Text = text or "", Duration = duration or 3 })
    end)
end

-- safe wrappers for optional functions
local function safeCall(fn, ...)
    if type(fn) ~= "function" then return false, "fn_missing" end
    local ok, a, b = pcall(fn, ...)
    if not ok then return false, a end
    -- return true and returned values (if any)
    return true, a, b
end

-- refresh energy display from GetEnergy()
local function refreshEnergyLabel()
    if not EnergyValueLabel then return end
    if type(GetEnergy) == "function" then
        local ok, val = pcall(GetEnergy)
        if ok and tonumber(val) then
            local n = math.clamp(tonumber(val), 0, ENERGY_MAX)
            EnergyValueLabel.Text = tostring(n) .. "/" .. tostring(ENERGY_MAX)
            return
        end
    end
    EnergyValueLabel.Text = "0/" .. tostring(ENERGY_MAX)
end
refreshEnergyLabel()

-- helper: show temporary message inside CodeBox and restore color/text
local function showTempMessageInBox(text, color3, duration)
    duration = duration or 2
    if not CodeBox or not CodeBox:IsA("TextBox") then return end
    local origText = CodeBox.Text
    local origColor = CodeBox.TextColor3
    CodeBox.Text = tostring(text)
    if color3 then CodeBox.TextColor3 = color3 end
    task.delay(duration, function()
        if CodeBox and CodeBox:IsA("TextBox") then
            CodeBox.Text = ""
            CodeBox.TextColor3 = origColor or Color3.fromRGB(255,255,255)
        end
    end)
end

-- ========== GetCodeButton upgraded behavior ==========
if GetCodeButton then
    local locked = false
    GetCodeButton.MouseButton1Click:Connect(function()
        if locked then return end
        locked = true
        GetCodeButton.Active = false
        GetCodeButton.Selectable = false

        -- store originals
        local origText = tostring(GetCodeButton.Text or "Get code")
        local origBg = GetCodeButton.BackgroundColor3
        local origTextTransparency = GetCodeButton.TextTransparency or 0

        -- target colors per your request: flash start and alt
        local flashColor = Color3.fromRGB(255, 0, 100)
        local altColor = Color3.fromRGB(0, 200, 100)

        -- immediately start copy in background so we don't block the animation
        local copyResult = nil
        task.spawn(function()
            -- prefer copyLink, fallback cacheLink
            if type(copyLink) == "function" then
                local ok, a, b = pcall(copyLink)
                copyResult = { ok = ok, a = a, b = b }
            elseif type(cacheLink) == "function" then
                local ok2, a2, b2 = pcall(cacheLink)
                copyResult = { ok = ok2, a = a2, b = b2 }
            else
                copyResult = { ok = false, a = "no_copy_fn" }
            end
        end)

        -- Animation sequence:
        -- 1) Fade text out + tween BG to flashColor
        local tOut = TweenService:Create(GetCodeButton, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { TextTransparency = 1 })
        local tBgToAlt = TweenService:Create(GetCodeButton, TweenInfo.new(0.22, Enum.EasingStyle.Quad), { BackgroundColor3 = altColor })
        tOut:Play(); tBgToAlt:Play()
        tOut.Completed:Wait()

        -- 2) Set 'Copied' text, fade in
        GetCodeButton.Text = "Copied"
        local tIn = TweenService:Create(GetCodeButton, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { TextTransparency = 0 })
        tIn:Play()
        tIn.Completed:Wait()

        -- wait 2s visible
        local waited = 0
        while waited < 2 do
            task.wait(0.05); waited = waited + 0.05
            -- if copy result ready earlier, break to update CodeBox quicker
            if copyResult ~= nil then break end
        end

        -- If copy finished while animating, apply result to CodeBox (if appropriate)
        if copyResult ~= nil then
            if copyResult.ok == false and copyResult.a == "no_copy_fn" then
                -- nothing to call
                showTempMessageInBox("Hàm copy không khả dụng.", Color3.fromRGB(255,160,0), 2)
            else
                if copyResult.ok then
                    -- copyLink returned values in copyResult.a, copyResult.b depending on implementation
                    -- copyLink normally returns (true, link) or (false, link)
                    local a, b = copyResult.a, copyResult.b
                    if a == true and type(b) == "string" then
                        if CodeBox and CodeBox:IsA("TextBox") then CodeBox.Text = b end
                        uiNotify("Get Key", "Đã copy link vào clipboard.", 3)
                    elseif a == false and type(b) == "string" then
                        if CodeBox and CodeBox:IsA("TextBox") then CodeBox.Text = b end
                        uiNotify("Get Key", "Không thể copy; link đặt vào ô nhập.", 3)
                    elseif type(a) == "string" then
                        if CodeBox and CodeBox:IsA("TextBox") then CodeBox.Text = a end
                        uiNotify("Get Key", "Link trả về (vui lòng copy).", 3)
                    else
                        uiNotify("Get Key", "Không nhận được link.", 3)
                    end
                else
                    -- pcall failed (runtime error), copyResult.a is error
                    uiNotify("Get Key", "Lỗi khi lấy link: "..tostring(copyResult.a), 3)
                end
            end
        else
            -- copy still pending: spawn a watcher to update CodeBox once it returns (timeout 6s)
            task.spawn(function()
                local waited2 = 0
                while copyResult == nil and waited2 < 6 do
                    task.wait(0.08); waited2 = waited2 + 0.08
                end
                if copyResult ~= nil then
                    if copyResult.ok then
                        local a, b = copyResult.a, copyResult.b
                        if a == true and type(b) == "string" then
                            if CodeBox and CodeBox:IsA("TextBox") then CodeBox.Text = b end
                            uiNotify("Get Key", "Đã copy link vào clipboard.", 3)
                        elseif a == false and type(b) == "string" then
                            if CodeBox and CodeBox:IsA("TextBox") then CodeBox.Text = b end
                            uiNotify("Get Key", "Không thể copy; link đặt vào ô nhập.", 3)
                        elseif type(a) == "string" then
                            if CodeBox and CodeBox:IsA("TextBox") then CodeBox.Text = a end
                            uiNotify("Get Key", "Link trả về (vui lòng copy).", 3)
                        else
                            uiNotify("Get Key", "Không nhận được link.", 3)
                        end
                    else
                        uiNotify("Get Key", "Lỗi khi lấy link: "..tostring(copyResult.a), 3)
                    end
                end
            end)
        end

        -- 3) Fade text out -> restore orig text -> fade in, tween BG back to original
        local tOut2 = TweenService:Create(GetCodeButton, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { TextTransparency = 1 })
        local tBgBack = TweenService:Create(GetCodeButton, TweenInfo.new(0.28, Enum.EasingStyle.Quad), { BackgroundColor3 = origBg })
        tOut2:Play()
        tOut2.Completed:Wait()
        GetCodeButton.Text = origText
        local tIn2 = TweenService:Create(GetCodeButton, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { TextTransparency = origTextTransparency or 0 })
        tIn2:Play()
        tBgBack:Play()
        tIn2.Completed:Wait()

        -- unlock
        locked = false
        GetCodeButton.Active = true
        GetCodeButton.Selectable = true
    end)
end

-- ========== Energy visual spawn helper ==========
local function getCenterUDim2(gui)
    if not gui or not gui:IsA("GuiObject") then return UDim2.new(0.5,0,0.5,0) end
    local pos = gui.Position
    local size = gui.Size
    return UDim2.new(pos.X.Scale, pos.X.Offset + (size.X.Offset * 0.5), pos.Y.Scale, pos.Y.Offset + (size.Y.Offset * 0.5))
end

local function spawnEnergyEffects(prototype, count, targetUDim2)
    if not prototype or not prototype:IsA("GuiObject") then return end
    count = math.max(1, count or 10)
    for i = 1, count do
        task.spawn(function()
            local clone = prototype:Clone()
            clone.Visible = true
            clone.Parent = prototype.Parent
            clone.ZIndex = (prototype.ZIndex or 1) + 5
            -- ensure starts where prototype is
            clone.Position = prototype.Position
            clone.AnchorPoint = prototype.AnchorPoint

            -- timing
            local upTime = 0.20 + (math.random() * 0.07)
            local downTime = 0.30 + (math.random() * 0.12)

            local start = clone.Position
            local target = targetUDim2 or getCenterUDim2(prototype)
            -- mid point with lift to make arc (use scale blend + offset average)
            local midX = (start.X.Scale + target.X.Scale) / 2
            local midOffsetX = (start.X.Offset + target.X.Offset) / 2
            local midY = (start.Y.Scale + target.Y.Scale) / 2 - 0.12
            local midOffsetY = (start.Y.Offset + target.Y.Offset) / 2 - 8
            local mid = UDim2.new(midX, midOffsetX, midY, midOffsetY)

            -- fade tween (fade out)
            local fadeTween = TweenService:Create(clone, TweenInfo.new(0.18, Enum.EasingStyle.Linear), { ImageTransparency = 1 })

            local tUp = TweenService:Create(clone, TweenInfo.new(upTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = mid })
            local tDown = TweenService:Create(clone, TweenInfo.new(downTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Position = target })

            tUp:Play()
            tUp.Completed:Wait()
            tDown:Play()
            -- start fade shortly before end
            task.delay(math.max(0, downTime - 0.18), function() pcall(function() fadeTween:Play() end) end)
            tDown.Completed:Wait()
            pcall(function() clone:Destroy() end)
        end)
        task.wait(0.03) -- stagger
    end
end

-- ========== CheckButton logic ==========
if CheckButton and CheckButton:IsA("GuiButton") then
    CheckButton.MouseButton1Click:Connect(function()
        local key = ""
        if CodeBox and CodeBox:IsA("TextBox") then
            key = tostring(CodeBox.Text or ""):gsub("^%s*(.-)%s*$", "%1")
        end

        if key == "" then
            showTempMessageInBox("Vui lòng nhập key trước khi kiểm tra.", Color3.fromRGB(255,120,120), 2)
            return
        end

        if type(verifyKey) ~= "function" then
            showTempMessageInBox("Hệ thống xác thực không khả dụng.", Color3.fromRGB(255,160,0), 2)
            return
        end

        -- disable while verifying
        CheckButton.Active = false
        CheckButton.Selectable = false

        local okVerify, verifyRes = pcall(verifyKey, key)
        if not okVerify then
            showTempMessageInBox("Lỗi khi gọi verifyKey.", Color3.fromRGB(255,120,120), 2)
            CheckButton.Active = true; CheckButton.Selectable = true
            return
        end
        if verifyRes ~= true then
            showTempMessageInBox("Key không hợp lệ.", Color3.fromRGB(255,120,120), 2)
            CheckButton.Active = true; CheckButton.Selectable = true
            return
        end

        -- server-side checks
        if type(EnsureUser) == "function" then pcall(EnsureUser) end
        if type(CleanupExpiredKeys) == "function" then pcall(CleanupExpiredKeys) end

        if type(IsKeyCurrentlyUsed) == "function" then
            local okUsed, usedRes = pcall(IsKeyCurrentlyUsed, key)
            if okUsed and usedRes == true then
                showTempMessageInBox("Key đã được dùng trong vòng 1 giờ.", Color3.fromRGB(255,160,0), 2)
                CheckButton.Active = true; CheckButton.Selectable = true
                return
            end
        end

        -- mark used
        if type(MarkKeyUsed) == "function" then
            local okM, resM = pcall(MarkKeyUsed, key)
            if not okM or not resM then
                showTempMessageInBox("Lỗi lưu key đã dùng.", Color3.fromRGB(255,120,120), 2)
                CheckButton.Active = true; CheckButton.Selectable = true
                return
            end
        end

        -- energy handling
        local curEnergy = 0
        if type(GetEnergy) == "function" then
            local okE, vE = pcall(GetEnergy)
            if okE and tonumber(vE) then curEnergy = tonumber(vE) else curEnergy = 0 end
        end

        if curEnergy >= ENERGY_MAX then
            showTempMessageInBox("Energy đã đầy ("..tostring(ENERGY_MAX)..").", Color3.fromRGB(200,200,200), 2)
            CheckButton.Active = true; CheckButton.Selectable = true
            return
        end

        local allowed = math.min(REWARD_ENERGY, ENERGY_MAX - curEnergy)
        local addOk, newVal = false, curEnergy
        if type(AddEnergy) == "function" then
            local okA, retA = pcall(AddEnergy, allowed)
            if okA and retA then addOk = true; newVal = retA else addOk = false end
        end

        if addOk then
            if EnergyValueLabel then EnergyValueLabel.Text = tostring(math.clamp(tonumber(newVal) or newVal, 0, ENERGY_MAX)) .. "/" .. tostring(ENERGY_MAX) end

            -- spawn energy effect clones if prototype exists (search inside CheckButton first)
            local prototype = CheckButton:FindFirstChild("EnergyEffect") or System:FindFirstChild("EnergyEffect")
            if prototype and prototype:IsA("ImageLabel") then
                prototype.Visible = false
                local targetUDim2 = getCenterUDim2(EnergyIcon or prototype)
                spawnEnergyEffects(prototype, 10, targetUDim2)
            end

            showTempMessageInBox("Key hợp lệ! +"..tostring(allowed).." Energy", Color3.fromRGB(180,255,180), 2)
        else
            showTempMessageInBox("Lỗi cập nhật Energy.", Color3.fromRGB(255,120,120), 2)
        end

        CheckButton.Active = true
        CheckButton.Selectable = true
    end)
end

-- optional periodic refresh
task.spawn(function()
    while true do
        refreshEnergyLabel()
        task.wait(15)
    end
end)
