-------------------------------------------------------------------------------
--! json library
--! cryptography library
local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;local e;local l={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local P={["/"]="/"}for Q,R in pairs(l)do P[R]=Q end;local S=function(T)return"\\"..(l[T]or string.format("u%04x",T:byte()))end;local B=function(M)return"null"end;local v=function(M,z)local _={}z=z or{}if z[M]then error("circular reference")end;z[M]=true;if rawget(M,1)~=nil or next(M)==nil then local A=0;for Q in pairs(M)do if type(Q)~="number"then error("invalid table: mixed or invalid key types")end;A=A+1 end;if A~=#M then error("invalid table: sparse array")end;for a0,R in ipairs(M)do table.insert(_,e(R,z))end;z[M]=nil;return"["..table.concat(_,",").."]"else for Q,R in pairs(M)do if type(Q)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(_,e(Q,z)..":"..e(R,z))end;z[M]=nil;return"{"..table.concat(_,",").."}"end end;local g=function(M)return'"'..M:gsub('[%z\1-\31\\"]',S)..'"'end;local a1=function(M)if M~=M or M<=-math.huge or M>=math.huge then error("unexpected number value '"..tostring(M).."'")end;return string.format("%.14g",M)end;local j={["nil"]=B,["table"]=v,["string"]=g,["number"]=a1,["boolean"]=tostring}e=function(M,z)local x=type(M)local a2=j[x]if a2 then return a2(M,z)end;error("unexpected type '"..x.."'")end;local a3=function(M)return e(M)end;local a4;local N=function(...)local _={}for a0=1,select("#",...)do _[select(a0,...)]=true end;return _ end;local L=N(" ","\t","\r","\n")local p=N(" ","\t","\r","\n","]","}",",")local a5=N("\\","/",'"',"b","f","n","r","t","u")local m=N("true","false","null")local a6={["true"]=true,["false"]=false,["null"]=nil}local a7=function(a8,a9,aa,ab)for a0=a9,#a8 do if aa[a8:sub(a0,a0)]~=ab then return a0 end end;return#a8+1 end;local ac=function(a8,a9,J)local ad=1;local ae=1;for a0=1,a9-1 do ae=ae+1;if a8:sub(a0,a0)=="\n"then ad=ad+1;ae=1 end end;error(string.format("%s at line %d col %d",J,ad,ae))end;local af=function(A)local a2=math.floor;if A<=0x7f then return string.char(A)elseif A<=0x7ff then return string.char(a2(A/64)+192,A%64+128)elseif A<=0xffff then return string.char(a2(A/4096)+224,a2(A%4096/64)+128,A%64+128)elseif A<=0x10ffff then return string.char(a2(A/262144)+240,a2(A%262144/4096)+128,a2(A%4096/64)+128,A%64+128)end;error(string.format("invalid unicode codepoint '%x'",A))end;local ag=function(ah)local ai=tonumber(ah:sub(1,4),16)local aj=tonumber(ah:sub(7,10),16)if aj then return af((ai-0xd800)*0x400+aj-0xdc00+0x10000)else return af(ai)end end;local ak=function(a8,a0)local _=""local al=a0+1;local Q=al;while al<=#a8 do local am=a8:byte(al)if am<32 then ac(a8,al,"control character in string")elseif am==92 then _=_..a8:sub(Q,al-1)al=al+1;local T=a8:sub(al,al)if T=="u"then local an=a8:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",al+1)or a8:match("^%x%x%x%x",al+1)or ac(a8,al-1,"invalid unicode escape in string")_=_..ag(an)al=al+#an else if not a5[T]then ac(a8,al-1,"invalid escape char '"..T.."' in string")end;_=_..P[T]end;Q=al+1 elseif am==34 then _=_..a8:sub(Q,al-1)return _,al+1 end;al=al+1 end;ac(a8,a0,"expected closing quote for string")end;local ao=function(a8,a0)local am=a7(a8,a0,p)local ah=a8:sub(a0,am-1)local A=tonumber(ah)if not A then ac(a8,a0,"invalid number '"..ah.."'")end;return A,am end;local ap=function(a8,a0)local am=a7(a8,a0,p)local aq=a8:sub(a0,am-1)if not m[aq]then ac(a8,a0,"invalid literal '"..aq.."'")end;return a6[aq],am end;local ar=function(a8,a0)local _={}local A=1;a0=a0+1;while 1 do local am;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="]"then a0=a0+1;break end;am,a0=a4(a8,a0)_[A]=am;A=A+1;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="]"then break end;if as~=","then ac(a8,a0,"expected ']' or ','")end end;return _,a0 end;local at=function(a8,a0)local _={}a0=a0+1;while 1 do local au,M;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="}"then a0=a0+1;break end;if a8:sub(a0,a0)~='"'then ac(a8,a0,"expected string for key")end;au,a0=a4(a8,a0)a0=a7(a8,a0,L,true)if a8:sub(a0,a0)~=":"then ac(a8,a0,"expected ':' after key")end;a0=a7(a8,a0+1,L,true)M,a0=a4(a8,a0)_[au]=M;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="}"then break end;if as~=","then ac(a8,a0,"expected '}' or ','")end end;return _,a0 end;local av={['"']=ak,["0"]=ao,["1"]=ao,["2"]=ao,["3"]=ao,["4"]=ao,["5"]=ao,["6"]=ao,["7"]=ao,["8"]=ao,["9"]=ao,["-"]=ao,["t"]=ap,["f"]=ap,["n"]=ap,["["]=ar,["{"]=at}a4=function(a8,a9)local as=a8:sub(a9,a9)local a2=av[as]if a2 then return a2(a8,a9)end;ac(a8,a9,"unexpected character '"..as.."'")end;local aw=function(a8)if type(a8)~="string"then error("expected argument of type string, got "..type(a8))end;local _,a9=a4(a8,a7(a8,1,L,true))a9=a7(a8,a9,L,true)if a9<=#a8 then ac(a8,a9,"trailing garbage")end;return _ end;
local lEncode, lDecode, lDigest = a3, aw, Z;
-------------------------------------------------------------------------------

-- ===================================================================
--  UI hookup + UX improvements (replace previous makeGui block with this)
--  - Uses existing GUI at PlayerGui > HAPPYscript > Main > ScrollingFrame > System
--  - Implements GetCode tween + disable during anim
--  - Implements CheckButton temporary messages in CodeBox with color swap
--  - Implements capped AddEnergy and Energy display as "X/100"
--  - Implements EnergyEffect clone spawns (10 clones) with parabolic-ish tween and fade
-- ===================================================================

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
repeat task.wait(0.05) until player and player:FindFirstChild("PlayerGui")

-- GUI path (as you declared)
local playerGui = player:WaitForChild("PlayerGui")
local happy = playerGui:WaitForChild("HAPPYscript", 5)
local main = happy and happy:WaitForChild("Main", 5)
local scrolling = main and main:WaitForChild("ScrollingFrame", 5)
local systemFrame = scrolling and scrolling:WaitForChild("System", 5)
if not systemFrame then
    warn("[EnergyKeyUI] Không tìm thấy System frame tại PlayerGui > HAPPYscript > Main > ScrollingFrame > System")
    return
end

-- find controls
local codeBox = systemFrame:WaitForChild("CodeBox", 5)
local getBtn = systemFrame:WaitForChild("GetCodeButton", 5)
-- CheckButton is inside CodeBox as you said
local checkBtn = codeBox:WaitForChild("CheckButton", 5)
local energyIcon = systemFrame:WaitForChild("EnergyIcon", 5)
local energyValueLabel = energyIcon and energyIcon:WaitForChild("Value", 5)

-- config
local MAX_ENERGY = 100
local REWARD_ENERGY = REWARD_ENERGY or 10 -- keep existing variable if defined earlier; otherwise 10

-- local cached value
local cachedEnergy = nil

-- utility: safe notify wrapper
local function notify(title, text, duration)
    duration = duration or 3
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title = title or "Notice", Text = text or "", Duration = duration})
    end)
end

-- --------------- Modify AddEnergy to cap at MAX_ENERGY ---------------
-- Replace original AddEnergy function with a capped version, still using PATCH
local function AddEnergy(amount)
    amount = tonumber(amount) or 0
    local data = GetUserData()
    if not data then
        CreateUser()
        data = GetUserData()
        if not data then
            warn("[AddEnergy] Could not get/create user data")
            return false, nil
        end
    end
    local current = tonumber(data.energy) or 0
    if current >= MAX_ENERGY then
        return false, current -- already full; don't add
    end
    local newVal = current + amount
    if newVal > MAX_ENERGY then newVal = MAX_ENERGY end

    -- push update
    local ok = PatchUserData({ energy = newVal })
    if ok then
        return true, newVal
    else
        return false, current
    end
end

-- --------------- helper: update energy label UI ---------------
local function updateEnergyLabel(val)
    val = tonumber(val) or 0
    cachedEnergy = val
    if energyValueLabel and energyValueLabel:IsA("TextLabel") then
        energyValueLabel.Text = tostring(val) .. "/" .. tostring(MAX_ENERGY)
    else
        -- fallback: try an energyLabel elsewhere
        local fallback = systemFrame:FindFirstChild("EnergyLabel")
        if fallback and fallback:IsA("TextLabel") then
            fallback.Text = "Energy: " .. tostring(val) .. "/" .. tostring(MAX_ENERGY)
        end
    end
end

-- initial fetch + display
local function refreshEnergyInitial()
    local energy = GetEnergy()
    if energy == nil then
        updateEnergyLabel(0)
    else
        updateEnergyLabel(energy)
    end
end

-- --------------- GetCodeButton: copy + tween UX ---------------
do
    if getBtn and getBtn:IsA("GuiButton") then
        local origText = getBtn.Text
        local origTextTransparency = getBtn.TextTransparency or 0
        local origBg = getBtn.BackgroundColor3
        local disabled = false

        getBtn.MouseButton1Click:Connect(function()
            if disabled then return end
            -- try copyLink (defined earlier)
            if type(copyLink) ~= "function" and type(cacheLink) ~= "function" then
                notify("Get Key", "Hàm copyLink/cacheLink không tồn tại trong script.", 3)
                return
            end

            -- call copyLink or cacheLink similar to previous logic
            local ok, link = pcall(function() 
                if type(copyLink) == "function" then
                    return copyLink()
                else
                    return cacheLink()
                end
            end)

            -- normalize results:
            -- copyLink returns (true, link) or (false, link)
            -- our pcall returns either boolean or table — handle both
            local success, returnedLink
            if ok then
                -- copyLink returned value in 'link' var
                if type(link) == "table" then
                    -- in case of unexpected return, use tostring
                    success = false
                    returnedLink = tostring(link)
                elseif type(link) == "boolean" then
                    -- pcall returned boolean; this means copyLink returned true/false only
                    success = link
                    returnedLink = nil
                else
                    -- copyLink may return (true, link) packaged as multiple return; pcall returns only first
                    -- safe approach: call copyLink again safely to get two returns
                    local ok2, a, b = pcall(function() return copyLink() end)
                    if ok2 then
                        success = a
                        returnedLink = b
                    else
                        success = false
                        returnedLink = tostring(a)
                    end
                end
            else
                success = false
                returnedLink = tostring(link)
            end

            -- If copy succeeded (boolean true), animate. If not, put link/text in CodeBox and show notify.
            if success == true then
                -- optionally write link into codeBox if returnedLink
                if type(returnedLink) == "string" and returnedLink ~= "" then
                    pcall(function() codeBox.Text = returnedLink end)
                end

                -- animation: TextTransparency 0->1, swap text to "Copied", then 1->0. BackgroundColor tween to magenta-ish then back.
                disabled = true
                getBtn.Active = false
                getBtn.Selectable = false

                -- tween text to transparent
                local t1 = TweenService:Create(getBtn, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1})
                t1:Play(); t1.Completed:Wait()

                -- swap text
                getBtn.Text = "Copied"

                -- tween text back visible
                local t2 = TweenService:Create(getBtn, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 0})
                -- background color flash
                local colorA = Color3.fromRGB(255, 0, 100)
                local colorB = Color3.fromRGB(0, 200, 100)
                -- set to colorA first just in case
                getBtn.BackgroundColor3 = colorA
                local tcol1 = TweenService:Create(getBtn, TweenInfo.new(0.28, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = colorB})
                local tcol2 = TweenService:Create(getBtn, TweenInfo.new(0.28, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {BackgroundColor3 = colorA})
                t2:Play()
                tcol1:Play()
                t2.Completed:Wait()
                -- then tween back color
                tcol2:Play()
                tcol2.Completed:Wait()

                -- restore text to original
                local t3 = TweenService:Create(getBtn, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1})
                t3:Play(); t3.Completed:Wait()
                getBtn.Text = origText or "Get code"
                local t4 = TweenService:Create(getBtn, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = origTextTransparency or 0})
                t4:Play(); t4.Completed:Wait()

                -- restore properties
                getBtn.BackgroundColor3 = origBg
                disabled = false
                getBtn.Active = true
                getBtn.Selectable = true
                notify("Get Key", "Link đã được copy vào clipboard.", 2)
            else
                -- fallback: place returnedLink or error text in codeBox
                if type(returnedLink) == "string" and returnedLink ~= "" then
                    pcall(function() codeBox.Text = returnedLink end)
                    notify("Get Key", "Không thể copy; link đã đặt trong ô nhập.", 3)
                else
                    notify("Get Key", "Không thể lấy link: " .. tostring(returnedLink or "unknown"), 3)
                end
            end
        end)
    end
end

-- --------------- CheckButton: validation + temporary messages + energy effect ---------------
do
    if checkBtn and checkBtn:IsA("GuiButton") then
        local tempMessageDelay = 2 -- seconds to show temp messages in CodeBox
        local energyEffectTemplate = checkBtn:FindFirstChild("EnergyEffect")
        if energyEffectTemplate and energyEffectTemplate:IsA("ImageLabel") then
            energyEffectTemplate.Visible = false -- ensure template is hidden
        else
            energyEffectTemplate = nil -- if not present, we'll warn but continue
        end

        local function showTempInCodeBox(msg, color, duration)
            duration = duration or tempMessageDelay
            if not codeBox then return end
            local old = codeBox.Text
            local oldColor = codeBox.TextColor3
            codeBox.Text = tostring(msg)
            if color then pcall(function() codeBox.TextColor3 = color end) end
            task.delay(duration, function()
                -- only clear if message hasn't been manually changed by user (simple check)
                if codeBox and codeBox.Text == tostring(msg) then
                    codeBox.Text = ""
                end
                if codeBox then pcall(function() codeBox.TextColor3 = oldColor end) end
            end)
        end

        checkBtn.MouseButton1Click:Connect(function()
            local key = tostring(codeBox.Text or ""):gsub("^%s*(.-)%s*$", "%1")
            if key == "" then
                showTempInCodeBox("Vui lòng nhập key trước khi kiểm tra.", Color3.fromRGB(255, 100, 100))
                notify("Key", "Vui lòng nhập key trước khi kiểm tra.", 2)
                return
            end

            if type(verifyKey) ~= "function" then
                showTempInCodeBox("Hàm xác thực không tồn tại.", Color3.fromRGB(255, 150, 100))
                notify("Key", "Hàm verifyKey(key) không khả dụng.", 3)
                return
            end

            -- call verifyKey (this may take time)
            showTempInCodeBox("Đang kiểm tra...", Color3.fromRGB(200,200,200), 1.5)
            local ok, res = pcall(function() return verifyKey(key) end)
            if not ok then
                showTempInCodeBox("Lỗi khi gọi verifyKey.", Color3.fromRGB(255, 120, 120))
                notify("Key", "Lỗi khi gọi verifyKey: " .. tostring(res), 3)
                return
            end
            if res ~= true then
                -- invalid key
                showTempInCodeBox("Key không hợp lệ.", Color3.fromRGB(255, 100, 100))
                notify("Key", "Key không hợp lệ.", 3)
                return
            end

            -- remote valid -> proceed with Firebase checks
            EnsureUser()
            pcall(CleanupExpiredKeys)

            if IsKeyCurrentlyUsed(key) then
                showTempInCodeBox("Key đã được sử dụng trong 1 giờ.", Color3.fromRGB(255, 160, 100))
                notify("Key", "Key đã được dùng trong vòng 1 giờ.", 3)
                return
            end

            local markOk = MarkKeyUsed(key)
            if not markOk then
                showTempInCodeBox("Lỗi lưu key.", Color3.fromRGB(255, 120, 120))
                notify("Key", "Lỗi lưu thông tin key đã dùng.", 3)
                return
            end

            -- attempt add energy (capped)
            local addOk, newEnergy = AddEnergy(REWARD_ENERGY)
            if addOk then
                updateEnergyLabel(newEnergy)
                notify("Key", "Key hợp lệ! +"..tostring(REWARD_ENERGY).." Energy", 3)
            else
                -- AddEnergy returns false and current energy
                local cur = newEnergy or GetEnergy() or 0
                if tonumber(cur) and tonumber(cur) >= MAX_ENERGY then
                    showTempInCodeBox("Energy đã đầy (" .. tostring(cur) .. "/" .. tostring(MAX_ENERGY) .. ").", Color3.fromRGB(180, 255, 180))
                    notify("Key", "Energy đã đạt tối đa.", 3)
                else
                    showTempInCodeBox("Lỗi cập nhật Energy.", Color3.fromRGB(255, 120, 120))
                    notify("Key", "Lỗi cập nhật Energy.", 3)
                end
            end

            -- regardless whether energy changed, run the visual EnergyEffect burst if template exists
            if energyEffectTemplate then
                -- create n clones in quick succession
                local n = 10
                for i = 1, n do
                    task.spawn(function()
                        local clone = energyEffectTemplate:Clone()
                        clone.Parent = checkBtn -- keep it within button (so position coordinates consistent)
                        clone.Visible = true
                        clone.Position = energyEffectTemplate.Position
                        clone.AnchorPoint = energyEffectTemplate.AnchorPoint
                        clone.Size = energyEffectTemplate.Size
                        clone.ZIndex = energyEffectTemplate.ZIndex + 1
                        -- ensure children copied automatically
                        -- define target position -- user requested: {-11.25, 0},{0.5, 0}
                        -- interpret as UDim2.new(-11.25, 0, 0.5, 0)
                        local targetUDim2 = UDim2.new(-11.25, 0, 0.5, 0)

                        -- create a parabolic-like motion by tweening to a raised midpoint then to target
                        local startPos = clone.Position
                        -- midpoint approx (raise Y upward by 60 + small i to vary)
                        local raise = 60 + (i * 4)
                        local mid = UDim2.new(
                            startPos.X.Scale + (targetUDim2.X.Scale - startPos.X.Scale) * 0.5,
                            startPos.X.Offset + (targetUDim2.X.Offset - startPos.X.Offset) * 0.5,
                            startPos.Y.Scale + (targetUDim2.Y.Scale - startPos.Y.Scale) * 0.5,
                            startPos.Y.Offset + (targetUDim2.Y.Offset - startPos.Y.Offset) * 0.5 - raise
                        )

                        -- tween to mid (fast), then tween to target (slower) while fading out
                        local tween1 = TweenService:Create(clone, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = mid})
                        tween1:Play()
                        tween1.Completed:Wait()

                        -- slight random small delay for natural look
                        task.wait(0.04 * (i % 3))

                        local tween2 = TweenService:Create(clone, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = targetUDim2})
                        local fade = TweenService:Create(clone, TweenInfo.new(0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {ImageTransparency = 1})
                        tween2:Play()
                        fade:Play()
                        tween2.Completed:Wait()
                        -- remove clone after complete
                        pcall(function() clone:Destroy() end)
                    end)
                    task.wait(0.05) -- spawn spacing
                end
            end
        end)
    end
end

-- final: initial energy display call
task.spawn(function()
    refreshEnergyInitial()
end)

-- expose a small helper to manually refresh UI if needed
_G.__EnergyUI_Refresh = refreshEnergyInitial

-- ========================= END UI BLOCK =========================
