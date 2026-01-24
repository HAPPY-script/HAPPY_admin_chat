-------------------------------------------------------------------------------
--! json library
--! cryptography library
local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;local e;local l={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local P={["/"]="/"}for Q,R in pairs(l)do P[R]=Q end;local S=function(T)return"\\"..(l[T]or string.format("u%04x",T:byte()))end;local B=function(M)return"null"end;local v=function(M,z)local _={}z=z or{}if z[M]then error("circular reference")end;z[M]=true;if rawget(M,1)~=nil or next(M)==nil then local A=0;for Q in pairs(M)do if type(Q)~="number"then error("invalid table: mixed or invalid key types")end;A=A+1 end;if A~=#M then error("invalid table: sparse array")end;for a0,R in ipairs(M)do table.insert(_,e(R,z))end;z[M]=nil;return"["..table.concat(_,",").."]"else for Q,R in pairs(M)do if type(Q)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(_,e(Q,z)..":"..e(R,z))end;z[M]=nil;return"{"..table.concat(_,",").."}"end end;local g=function(M)return'"'..M:gsub('[%z\1-\31\\"]',S)..'"'end;local a1=function(M)if M~=M or M<=-math.huge or M>=math.huge then error("unexpected number value '"..tostring(M).."'")end;return string.format("%.14g",M)end;local j={["nil"]=B,["table"]=v,["string"]=g,["number"]=a1,["boolean"]=tostring}e=function(M,z)local x=type(M)local a2=j[x]if a2 then return a2(M,z)end;error("unexpected type '"..x.."'")end;local a3=function(M)return e(M)end;local a4;local N=function(...)local _={}for a0=1,select("#",...)do _[select(a0,...)]=true end;return _ end;local L=N(" ","\t","\r","\n")local p=N(" ","\t","\r","\n","]","}",",")local a5=N("\\","/",'"',"b","f","n","r","t","u")local m=N("true","false","null")local a6={["true"]=true,["false"]=false,["null"]=nil}local a7=function(a8,a9,aa,ab)for a0=a9,#a8 do if aa[a8:sub(a0,a0)]~=ab then return a0 end end;return#a8+1 end;local ac=function(a8,a9,J)local ad=1;local ae=1;for a0=1,a9-1 do ae=ae+1;if a8:sub(a0,a0)=="\n"then ad=ad+1;ae=1 end end;error(string.format("%s at line %d col %d",J,ad,ae))end;local af=function(A)local a2=math.floor;if A<=0x7f then return string.char(A)elseif A<=0x7ff then return string.char(a2(A/64)+192,A%64+128)elseif A<=0xffff then return string.char(a2(A/4096)+224,a2(A%4096/64)+128,A%64+128)elseif A<=0x10ffff then return string.char(a2(A/262144)+240,a2(A%262144/4096)+128,a2(A%4096/64)+128,A%64+128)end;error(string.format("invalid unicode codepoint '%x'",A))end;local ag=function(ah)local ai=tonumber(ah:sub(1,4),16)local aj=tonumber(ah:sub(7,10),16)if aj then return af((ai-0xd800)*0x400+aj-0xdc00+0x10000)else return af(ai)end end;local ak=function(a8,a0)local _=""local al=a0+1;local Q=al;while al<=#a8 do local am=a8:byte(al)if am<32 then ac(a8,al,"control character in string")elseif am==92 then _=_..a8:sub(Q,al-1)al=al+1;local T=a8:sub(al,al)if T=="u"then local an=a8:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",al+1)or a8:match("^%x%x%x%x",al+1)or ac(a8,al-1,"invalid unicode escape in string")_=_..ag(an)al=al+#an else if not a5[T]then ac(a8,al-1,"invalid escape char '"..T.."' in string")end;_=_..P[T]end;Q=al+1 elseif am==34 then _=_..a8:sub(Q,al-1)return _,al+1 end;al=al+1 end;ac(a8,a0,"expected closing quote for string")end;local ao=function(a8,a0)local am=a7(a8,a0,p)local ah=a8:sub(a0,am-1)local A=tonumber(ah)if not A then ac(a8,a0,"invalid number '"..ah.."'")end;return A,am end;local ap=function(a8,a0)local am=a7(a8,a0,p)local aq=a8:sub(a0,am-1)if not m[aq]then ac(a8,a0,"invalid literal '"..aq.."'")end;return a6[aq],am end;local ar=function(a8,a0)local _={}local A=1;a0=a0+1;while 1 do local am;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="]"then a0=a0+1;break end;am,a0=a4(a8,a0)_[A]=am;A=A+1;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="]"then break end;if as~=","then ac(a8,a0,"expected ']' or ','")end end;return _,a0 end;local at=function(a8,a0)local _={}a0=a0+1;while 1 do local au,M;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="}"then a0=a0+1;break end;if a8:sub(a0,a0)~='"'then ac(a8,a0,"expected string for key")end;au,a0=a4(a8,a0)a0=a7(a8,a0,L,true)if a8:sub(a0,a0)~=":"then ac(a8,a0,"expected ':' after key")end;a0=a7(a8,a0+1,L,true)M,a0=a4(a8,a0)_[au]=M;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="}"then break end;if as~=","then ac(a8,a0,"expected '}' or ','")end end;return _,a0 end;local av={['"']=ak,["0"]=ao,["1"]=ao,["2"]=ao,["3"]=ao,["4"]=ao,["5"]=ao,["6"]=ao,["7"]=ao,["8"]=ao,["9"]=ao,["-"]=ao,["t"]=ap,["f"]=ap,["n"]=ap,["["]=ar,["{"]=at}a4=function(a8,a9)local as=a8:sub(a9,a9)local a2=av[as]if a2 then return a2(a8,a9)end;ac(a8,a9,"unexpected character '"..as.."'")end;local aw=function(a8)if type(a8)~="string"then error("expected argument of type string, got "..type(a8))end;local _,a9=a4(a8,a7(a8,1,L,true))a9=a7(a8,a9,L,true)if a9<=#a8 then ac(a8,a9,"trailing garbage")end;return _ end;
local lEncode, lDecode, lDigest = a3, aw, Z;
-------------------------------------------------------------------------------

-- ==========================
-- Platoboost client + helpers (kept from your working copy)
-- ==========================

-- CONFIG (set your service + secret)
local service = 19439 -- <-- giữ hoặc thay id của bạn
local secret = "d7b9fc40-28ee-4df9-a4be-a7d9abf2a2c2" -- <-- giữ hoặc thay secret của bạn
local useNonce = true

-- default onMessage
local onMessage = function(message)
    local ok, _ = pcall(function()
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", { Text = tostring(message) })
    end)
    if not ok then
        print("Platoboost:", tostring(message))
    end
end

-- wait for player presence (client)
repeat task.wait(0.1) until game:IsLoaded() and game.Players.LocalPlayer

-- helpers & wrappers
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local function defaultGetHwid()
    local pl = Players.LocalPlayer
    if pl then return pl.UserId end
    return "unknown"
end

local fSetClipboard = setclipboard or toclipboard or function(_) end

-- pick request function (fRequest) for platoboost
local fRequest = request or http_request or syn_request or http and http.request or function(req)
    local ok, res = pcall(function()
        return HttpService:RequestAsync({
            Url = req.Url,
            Method = req.Method or "GET",
            Headers = req.Headers or {},
            Body = req.Body or ""
        })
    end)
    if not ok or not res then return nil end
    return { StatusCode = res.StatusCode, Body = res.Body }
end

local fStringChar, fToString, fStringSub, fOsTime, fMathRandom, fMathFloor, fGetHwid =
    string.char, tostring, string.sub, os.time, math.random, math.floor, (gethwid or defaultGetHwid)

-- check crypto/json exist (they do from block above)
if type(lEncode) ~= "function" or type(lDecode) ~= "function" or type(lDigest) ~= "function" then
    warn("Platoboost: lEncode/lDecode/lDigest not found; crypto block missing")
    lEncode = function(t) return HttpService:JSONEncode(t) end
    lDecode = function(s) return HttpService:JSONDecode(s) end
    lDigest = function(s)
        local str = tostring(s)
        local out = {}
        for i = 1, #str do table.insert(out, string.format("%02x", string.byte(str, i))) end
        return table.concat(out)
    end
end

-- state
local cachedLink, cachedTime = "", 0
local requestSending = false

-- pick host (try .com then .net fallback)
local host = "https://api.platoboost.com"
do
    local ok, hostResponse = pcall(function()
        return fRequest({ Url = host .. "/public/connectivity", Method = "GET" })
    end)
    if not ok or hostResponse == nil or (hostResponse.StatusCode ~= 200 and hostResponse.StatusCode ~= 429) then
        host = "https://api.platoboost.net"
    end
end

-- cacheLink
local function cacheLink()
    local now = fOsTime()
    if cachedTime + (10 * 60) < now then
        local bodyTbl = { service = service, identifier = lDigest(fGetHwid()) }
        local req = {
            Url = host .. "/public/start",
            Method = "POST",
            Body = lEncode(bodyTbl),
            Headers = { ["Content-Type"] = "application/json" }
        }

        local ok, response = pcall(function() return fRequest(req) end)
        if not ok or not response then
            onMessage("Failed to contact platoboost (request failed).")
            return false, "Failed to contact server"
        end

        if response.StatusCode == 200 then
            local success, decoded = pcall(function() return lDecode(response.Body) end)
            if not success or type(decoded) ~= "table" then
                onMessage("Invalid response from platoboost.")
                return false, "Invalid response"
            end

            if decoded.success == true and decoded.data and decoded.data.url then
                cachedLink = decoded.data.url
                cachedTime = fOsTime()
                return true, cachedLink
            else
                onMessage(tostring(decoded.message or "Unknown response"))
                return false, tostring(decoded.message or "Unknown response")
            end

        elseif response.StatusCode == 429 then
            local msg = "you are being rate limited, please wait 20 seconds and try again."
            onMessage(msg)
            return false, msg
        else
            local msg = "Failed to cache link."
            onMessage(msg)
            return false, msg
        end
    else
        return true, cachedLink
    end
end

-- nonce generator
local function generateNonce()
    local str = ""
    for _ = 1, 16 do
        str = str .. fStringChar(fMathFloor(fMathRandom() * (122 - 97 + 1)) + 97)
    end
    return str
end

-- nonce sanity
for _ = 1, 5 do
    local oNonce = generateNonce()
    task.wait(0.12)
    if generateNonce() == oNonce then
        onMessage("platoboost nonce error.")
        error("platoboost nonce error.")
    end
end

-- copyLink: returns (true, link) if clipboard set, or (false, link) fallback
local function copyLink()
    local ok, linkOrMsg = cacheLink()
    if not ok then
        return false, tostring(linkOrMsg or "Failed to get link")
    end

    local link = linkOrMsg
    local okCopy, err = pcall(function() fSetClipboard(link) end)
    if okCopy then
        return true, link
    else
        return false, link
    end
end

-- redeemKey
local function redeemKey(key)
    local nonce = generateNonce()
    local endpoint = host .. "/public/redeem/" .. fToString(service)
    local body = { identifier = lDigest(fGetHwid()), key = key }
    if useNonce then body.nonce = nonce end

    local req = {
        Url = endpoint,
        Method = "POST",
        Body = lEncode(body),
        Headers = { ["Content-Type"] = "application/json" }
    }

    local ok, response = pcall(function() return fRequest(req) end)
    if not ok or not response then
        onMessage("Failed to send redeem request.")
        return false
    end

    if response.StatusCode == 200 then
        local success, decoded = pcall(function() return lDecode(response.Body) end)
        if not success or type(decoded) ~= "table" then
            onMessage("Invalid redeem response.")
            return false
        end

        if decoded.success == true then
            if decoded.data and decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true
                    else
                        onMessage("failed to verify integrity.")
                        return false
                    end
                else
                    return true
                end
            else
                onMessage("key is invalid.")
                return false
            end
        else
            if type(decoded.message) == "string" and fStringSub(decoded.message, 1, 27) == "unique constraint violation" then
                onMessage("you already have an active key, please wait for it to expire before redeeming it.")
                return false
            else
                onMessage(decoded.message or "Redeem failed.")
                return false
            end
        end
    elseif response.StatusCode == 429 then
        onMessage("you are being rate limited, please wait 20 seconds and try again.")
        return false
    else
        onMessage("server returned an invalid status code, please try again later.")
        return false
    end
end

-- verifyKey
local function verifyKey(key)
    if requestSending == true then
        onMessage("a request is already being sent, please slow down.")
        return false
    else
        requestSending = true
    end

    local nonce = generateNonce()
    local endpoint = host .. "/public/whitelist/" .. fToString(service) .. "?identifier=" .. lDigest(fGetHwid()) .. "&key=" .. key
    if useNonce then endpoint = endpoint .. "&nonce=" .. nonce end

    local req = { Url = endpoint, Method = "GET" }
    local ok, response = pcall(function() return fRequest(req) end)
    requestSending = false

    if not ok or not response then
        onMessage("Failed to contact server for verification.")
        return false
    end

    if response.StatusCode == 200 then
        local success, decoded = pcall(function() return lDecode(response.Body) end)
        if not success or type(decoded) ~= "table" then
            onMessage("Invalid verify response.")
            return false
        end

        if decoded.success == true then
            if decoded.data and decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true
                    else
                        onMessage("failed to verify integrity.")
                        return false
                    end
                else
                    return true
                end
            else
                if type(key) == "string" and fStringSub(key, 1, 5) == "FREE_" then
                    return redeemKey(key)
                else
                    onMessage("key is invalid.")
                    return false
                end
            end
        else
            onMessage(decoded.message or "verify failed.")
            return false
        end
    elseif response.StatusCode == 429 then
        onMessage("you are being rate limited, please wait 20 seconds and try again.")
        return false
    else
        onMessage("server returned an invalid status code, please try again later.")
        return false
    end
end

-- getFlag
local function getFlag(name)
    local nonce = generateNonce()
    local endpoint = host .. "/public/flag/" .. fToString(service) .. "?name=" .. name
    if useNonce then endpoint = endpoint .. "&nonce=" .. nonce end

    local req = { Url = endpoint, Method = "GET" }
    local ok, response = pcall(function() return fRequest(req) end)
    if not ok or not response then return nil end

    if response.StatusCode == 200 then
        local success, decoded = pcall(function() return lDecode(response.Body) end)
        if not success or type(decoded) ~= "table" then
            onMessage("Invalid flag response.")
            return nil
        end

        if decoded.success == true then
            if useNonce then
                if decoded.data and decoded.data.hash == lDigest(fToString(decoded.data.value) .. "-" .. nonce .. "-" .. secret) then
                    return decoded.data.value
                else
                    onMessage("failed to verify integrity.")
                    return nil
                end
            else
                return decoded.data.value
            end
        else
            onMessage(decoded.message)
            return nil
        end
    else
        return nil
    end
end

-- expose (optional)
_G.Platoboost = { copyLink = copyLink, verifyKey = verifyKey, getFlag = getFlag }

-- hook onMessage to also show notifications (preserve original behavior)
do
    local original_onMessage = onMessage
    onMessage = function(msg)
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Platoboost", Text = tostring(msg), Duration = 4 })
        end)
        pcall(original_onMessage, msg)
    end
end

-------------------------------------------------------------------------------
-- Firebase/Data storage + UI (uses Platoboost's copyLink & verifyKey)
-------------------------------------------------------------------------------

--==========================
--  AUTO DETECT HTTP REQUEST (for Firebase)
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
        error("Executor không hỗ trợ http request!")
    end
end

-- CONFIG for Firebase
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
repeat task.wait(0.05) until player
local userId = player.UserId

-- Replace this root with your Firebase Realtime DB root (ensure ends with /users/)
local PROJECT_URL = "https://coin-system-efb92-default-rtdb.asia-southeast1.firebasedatabase.app/users/"
local URL = PROJECT_URL .. userId .. ".json"

local EXPIRE_SECONDS = 3600 -- 1 hour
local REWARD_ENERGY = 10

-- Helpers: notify
local function notify(title, text, duration)
    duration = duration or 3
    local ok, _ = pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title or "Notification",
            Text = text or "",
            Duration = duration
        })
    end)
    if not ok then warn(title .. ": " .. tostring(text)) end
end

-- DATABASE FUNCTIONS
local function GetUserData()
    local ok, res = pcall(function() return HttpRequest({ Url = URL, Method = "GET" }) end)
    if not ok or not res then
        warn("[GetUserData] Request error")
        return nil
    end
    local body = res.Body or "{}"
    local success, data = pcall(function() return HttpService:JSONDecode(body) end)
    if not success or type(data) ~= "table" then
        return nil
    end
    return data
end

local function CreateUser()
    local payload = { energy = 0, usedKeys = {} }
    local ok, res = pcall(function()
        return HttpRequest({
            Url = URL,
            Method = "PUT",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode(payload)
        })
    end)
    if not ok or not res then
        warn("[CreateUser] Request failed")
        return false
    end
    if res.StatusCode == 200 then return true end
    warn("[CreateUser] Status:", res.StatusCode)
    return false
end

local function PatchUserData(tbl)
    local ok, res = pcall(function()
        return HttpRequest({
            Url = URL,
            Method = "PATCH",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode(tbl)
        })
    end)
    if not ok or not res then
        warn("[PatchUserData] Request failed")
        return false
    end
    if res.StatusCode == 200 then return true end
    warn("[PatchUserData] Status:", res.StatusCode)
    return false
end

local function EnsureUser()
    local data = GetUserData()
    if not data then
        local create_ok = CreateUser()
        return create_ok
    end
    local changed = false
    local patch = {}
    if data.energy == nil then patch.energy = 0; changed = true end
    if data.usedKeys == nil then patch.usedKeys = {}; changed = true end
    if changed then PatchUserData(patch) end
    return true
end

local function GetEnergy()
    local data = GetUserData()
    if not data then return nil end
    return tonumber(data.energy) or 0
end

local function AddEnergy(amount)
    local data = GetUserData()
    if not data then
        CreateUser()
        data = GetUserData()
        if not data then warn("[AddEnergy] Could not get/create user data"); return false end
    end
    local current = tonumber(data.energy) or 0
    local newVal = current + tonumber(amount)
    local ok = PatchUserData({ energy = newVal })
    return ok, newVal
end

local function RemoveUsedKey(key)
    -- manual PATCH body: {"usedKeys": {"KEY": null}}
    local manualBody = '{"usedKeys": {"' .. tostring(key) .. '": null}}'
    local ok2, res2 = pcall(function()
        return HttpRequest({ Url = URL, Method = "PATCH", Headers = { ["Content-Type"] = "application/json" }, Body = manualBody })
    end)
    if ok2 and res2 and res2.StatusCode == 200 then return true end
    local cur = GetUserData()
    if cur and cur.usedKeys then
        cur.usedKeys[tostring(key)] = nil
        return PatchUserData({ usedKeys = cur.usedKeys })
    end
    return false
end

local function MarkKeyUsed(key)
    local now = os.time()
    local ok, res = pcall(function()
        return HttpRequest({
            Url = URL,
            Method = "PATCH",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode({ usedKeys = { [key] = now } })
        })
    end)
    if ok and res and res.StatusCode == 200 then return true end
    local cur = GetUserData() or { usedKeys = {} }
    cur.usedKeys = cur.usedKeys or {}
    cur.usedKeys[key] = now
    return PatchUserData({ usedKeys = cur.usedKeys })
end

local function IsKeyCurrentlyUsed(key)
    local data = GetUserData()
    if not data then return false end
    local used = data.usedKeys or {}
    local ts = used[key]
    if not ts then return false end
    local now = os.time()
    if tonumber(ts) == nil then
        RemoveUsedKey(key); return false
    end
    if now - tonumber(ts) < EXPIRE_SECONDS then
        return true
    else
        pcall(RemoveUsedKey, key)
        return false
    end
end

local function CleanupExpiredKeys()
    local data = GetUserData()
    if not data then return false end
    local used = data.usedKeys or {}
    local now = os.time()
    local changed = false
    for k, v in pairs(used) do
        if tonumber(v) and now - tonumber(v) >= EXPIRE_SECONDS then
            used[k] = nil; changed = true
        elseif not tonumber(v) then
            used[k] = nil; changed = true
        end
    end
    if changed then return PatchUserData({ usedKeys = used }) end
    return true
end

-- Ensure user on load
print("====================================")
print(" KIỂM TRA DATA USER:", userId)
print("====================================")
local okEnsure = EnsureUser()
if not okEnsure then warn("[SYSTEM] Không thể đảm bảo user data.") else print("[SYSTEM] User data có sẵn.") end
print("====================================")
print("   HỆ THỐNG SẴN SÀNG TEST")
print("====================================")

-- UI: one-shot GET energy on init, update only when AddEnergy returns new value
task.spawn(function()
    local PlayerGui = player:WaitForChild("PlayerGui")

    local function makeGui()
        local screen = Instance.new("ScreenGui")
        screen.Name = "EnergyKeyUI"
        screen.ResetOnSpawn = false
        screen.Parent = PlayerGui

        local frame = Instance.new("Frame", screen)
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
        frame.Position = UDim2.new(0.5, 0, 0.15, 0)
        frame.Size = UDim2.new(0, 420, 0, 140)
        frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        frame.BorderSizePixel = 0
        frame.Active = true
        frame.Draggable = true

        local title = Instance.new("TextLabel", frame)
        title.Size = UDim2.new(1, 0, 0, 28)
        title.Position = UDim2.new(0, 0, 0, 0)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.Text = "Energy & Key"
        title.TextSize = 18
        title.TextColor3 = Color3.fromRGB(255,255,255)

        local energyLabel = Instance.new("TextLabel", frame)
        energyLabel.Size = UDim2.new(0.45, 0, 0, 28)
        energyLabel.Position = UDim2.new(0.03, 0, 0.28, 0)
        energyLabel.BackgroundTransparency = 1
        energyLabel.Font = Enum.Font.Gotham
        energyLabel.TextSize = 16
        energyLabel.TextColor3 = Color3.fromRGB(200,200,200)
        energyLabel.Text = "Energy: ..."

        local keyBox = Instance.new("TextBox", frame)
        keyBox.Size = UDim2.new(0.9, 0, 0, 34)
        keyBox.Position = UDim2.new(0.05, 0, 0.45, 0)
        keyBox.PlaceholderText = "Nhập key tại đây..."
        keyBox.Font = Enum.Font.Gotham
        keyBox.TextSize = 16
        keyBox.ClearTextOnFocus = false
        keyBox.Text = ""

        local getBtn = Instance.new("TextButton", frame)
        getBtn.Size = UDim2.new(0.36, 0, 0, 30)
        getBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
        getBtn.Text = "Get Key"
        getBtn.Font = Enum.Font.GothamBold
        getBtn.TextSize = 14
        getBtn.BackgroundColor3 = Color3.fromRGB(0,120,215)
        getBtn.TextColor3 = Color3.fromRGB(255,255,255)

        local checkBtn = Instance.new("TextButton", frame)
        checkBtn.Size = UDim2.new(0.36, 0, 0, 30)
        checkBtn.Position = UDim2.new(0.59, 0, 0.75, 0)
        checkBtn.Text = "Check Key"
        checkBtn.Font = Enum.Font.GothamBold
        checkBtn.TextSize = 14
        checkBtn.BackgroundColor3 = Color3.fromRGB(0,150,80)
        checkBtn.TextColor3 = Color3.fromRGB(255,255,255)

        local statusLabel = Instance.new("TextLabel", frame)
        statusLabel.Size = UDim2.new(0.9, 0, 0, 20)
        statusLabel.Position = UDim2.new(0.05, 0, 0.92, 0)
        statusLabel.BackgroundTransparency = 1
        statusLabel.Font = Enum.Font.Gotham
        statusLabel.TextSize = 14
        statusLabel.TextColor3 = Color3.fromRGB(200,200,200)
        statusLabel.Text = "Trạng thái: sẵn sàng"

        local cachedEnergy = nil

        local function refreshEnergyLabelInitial()
            local energy = GetEnergy()
            if energy == nil then
                energyLabel.Text = "Energy: (lấy lỗi)"
                cachedEnergy = nil
            else
                cachedEnergy = energy
                energyLabel.Text = "Energy: " .. tostring(energy)
            end
        end

        -- initial single fetch
        refreshEnergyLabelInitial()

        -- Get Key behavior
        getBtn.MouseButton1Click:Connect(function()
            statusLabel.Text = "Trạng thái: Lấy link..."
            if type(copyLink) == "function" then
                local ok, a, b = pcall(function() return copyLink() end)
                if not ok then
                    notify("Get Key", "Lỗi khi gọi copyLink: " .. tostring(a), 4)
                    statusLabel.Text = "Trạng thái: Lỗi lấy link"
                    return
                end
                if a == true and type(b) == "string" then
                    notify("Get Key", "Đã copy link vào clipboard.", 3)
                    statusLabel.Text = "Trạng thái: Link đã copy"
                    keyBox.Text = b
                    return
                elseif a == false and type(b) == "string" then
                    keyBox.Text = b
                    notify("Get Key", "Không thể copy; link đặt vào ô nhập.", 4)
                    statusLabel.Text = "Trạng thái: Link trả về (xem ô nhập)"
                    return
                elseif type(a) == "string" then
                    keyBox.Text = a
                    notify("Get Key", "Link trả về (vui lòng copy).", 4)
                    statusLabel.Text = "Trạng thái: Link trả về (xem ô nhập)"
                    return
                else
                    notify("Get Key", "copyLink trả về giá trị không rõ.", 4)
                    statusLabel.Text = "Trạng thái: Lỗi lấy link"
                    return
                end
            elseif type(cacheLink) == "function" then
                local ok2, r1, r2 = pcall(function() return cacheLink() end)
                if not ok2 then
                    notify("Get Key", "Lỗi khi gọi cacheLink: " .. tostring(r1), 4)
                    statusLabel.Text = "Trạng thái: Lỗi lấy link"
                    return
                end
                local success = r1
                local linkOrMsg = r2
                if success and type(linkOrMsg) == "string" then
                    keyBox.Text = linkOrMsg
                    notify("Get Key", "Link trả về, đặt vào ô nhập.", 4)
                    statusLabel.Text = "Trạng thái: Link trả về (xem ô nhập)"
                    return
                else
                    notify("Get Key", tostring(linkOrMsg or "Không lấy được link"), 4)
                    statusLabel.Text = "Trạng thái: Lỗi lấy link"
                    return
                end
            else
                notify("Get Key", "Hàm copyLink/cacheLink không tồn tại trong script.", 4)
                statusLabel.Text = "Trạng thái: copyLink không khả dụng"
                return
            end
        end)

        -- Check Key behavior (calls verifyKey then Firebase logic)
        checkBtn.MouseButton1Click:Connect(function()
            local key = tostring(keyBox.Text or ""):gsub("^%s*(.-)%s*$", "%1")
            if key == "" then
                notify("Key", "Vui lòng nhập key trước khi kiểm tra.", 3)
                statusLabel.Text = "Trạng thái: chưa nhập key"
                return
            end
            if type(verifyKey) ~= "function" then
                notify("Key", "Hàm verifyKey(key) không tồn tại. Không thể xác thực key.", 4)
                statusLabel.Text = "Trạng thái: verifyKey không khả dụng"
                return
            end

            statusLabel.Text = "Trạng thái: Đang kiểm tra key..."
            local okVerify, verifyRes = pcall(function() return verifyKey(key) end)
            if not okVerify then
                notify("Key", "Lỗi khi gọi verifyKey: " .. tostring(verifyRes), 4)
                statusLabel.Text = "Trạng thái: Lỗi verify"
                return
            end

            if verifyRes ~= true then
                notify("Key", "Key không hợp lệ.", 3)
                statusLabel.Text = "Trạng thái: Key không hợp lệ"
                return
            end

            -- Key valid remotely -> apply Firebase checks
            EnsureUser()
            pcall(CleanupExpiredKeys)

            if IsKeyCurrentlyUsed(key) then
                notify("Key", "Key đã được dùng trong vòng 1 giờ. Không có hiệu lực.", 4)
                statusLabel.Text = "Trạng thái: Key đã dùng (chưa đủ 1 giờ)"
                return
            end

            local markOk = MarkKeyUsed(key)
            if not markOk then
                notify("Key", "Lỗi lưu thông tin key đã dùng.", 4)
                statusLabel.Text = "Trạng thái: Lỗi lưu key"
                return
            end

            local addOk, newEnergy = AddEnergy(REWARD_ENERGY)
            if addOk then
                cachedEnergy = newEnergy
                energyLabel.Text = "Energy: " .. tostring(newEnergy)
                notify("Key", "Key hợp lệ! Bạn được +" .. tostring(REWARD_ENERGY) .. " Energy.", 4)
                statusLabel.Text = "Trạng thái: Nhận +" .. tostring(REWARD_ENERGY) .. " Energy"
            else
                notify("Key", "Lỗi cập nhật Energy.", 4)
                statusLabel.Text = "Trạng thái: Lỗi cập nhật Energy"
            end
        end)

        return screen, refreshEnergyLabelInitial
    end

    local screen, refreshFunc = makeGui()
    -- no periodic refresh: UI fetched energy once at init; updates occur only on successful AddEnergy
end)
