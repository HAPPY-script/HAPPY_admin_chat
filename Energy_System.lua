-------------------------------------------------------------------------------
--! json library
--! cryptography library
local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;local e;local l={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local P={["/"]="/"}for Q,R in pairs(l)do P[R]=Q end;local S=function(T)return"\\"..(l[T]or string.format("u%04x",T:byte()))end;local B=function(M)return"null"end;local v=function(M,z)local _={}z=z or{}if z[M]then error("circular reference")end;z[M]=true;if rawget(M,1)~=nil or next(M)==nil then local A=0;for Q in pairs(M)do if type(Q)~="number"then error("invalid table: mixed or invalid key types")end;A=A+1 end;if A~=#M then error("invalid table: sparse array")end;for a0,R in ipairs(M)do table.insert(_,e(R,z))end;z[M]=nil;return"["..table.concat(_,",").."]"else for Q,R in pairs(M)do if type(Q)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(_,e(Q,z)..":"..e(R,z))end;z[M]=nil;return"{"..table.concat(_,",").."}"end end;local g=function(M)return'"'..M:gsub('[%z\1-\31\\"]',S)..'"'end;local a1=function(M)if M~=M or M<=-math.huge or M>=math.huge then error("unexpected number value '"..tostring(M).."'")end;return string.format("%.14g",M)end;local j={["nil"]=B,["table"]=v,["string"]=g,["number"]=a1,["boolean"]=tostring}e=function(M,z)local x=type(M)local a2=j[x]if a2 then return a2(M,z)end;error("unexpected type '"..x.."'")end;local a3=function(M)return e(M)end;local a4;local N=function(...)local _={}for a0=1,select("#",...)do _[select(a0,...)]=true end;return _ end;local L=N(" ","\t","\r","\n")local p=N(" ","\t","\r","\n","]","}",",")local a5=N("\\","/",'"',"b","f","n","r","t","u")local m=N("true","false","null")local a6={["true"]=true,["false"]=false,["null"]=nil}local a7=function(a8,a9,aa,ab)for a0=a9,#a8 do if aa[a8:sub(a0,a0)]~=ab then return a0 end end;return#a8+1 end;local ac=function(a8,a9,J)local ad=1;local ae=1;for a0=1,a9-1 do ae=ae+1;if a8:sub(a0,a0)=="\n"then ad=ad+1;ae=1 end end;error(string.format("%s at line %d col %d",J,ad,ae))end;local af=function(A)local a2=math.floor;if A<=0x7f then return string.char(A)elseif A<=0x7ff then return string.char(a2(A/64)+192,A%64+128)elseif A<=0xffff then return string.char(a2(A/4096)+224,a2(A%4096/64)+128,A%64+128)elseif A<=0x10ffff then return string.char(a2(A/262144)+240,a2(A%262144/4096)+128,a2(A%4096/64)+128,A%64+128)end;error(string.format("invalid unicode codepoint '%x'",A))end;local ag=function(ah)local ai=tonumber(ah:sub(1,4),16)local aj=tonumber(ah:sub(7,10),16)if aj then return af((ai-0xd800)*0x400+aj-0xdc00+0x10000)else return af(ai)end end;local ak=function(a8,a0)local _=""local al=a0+1;local Q=al;while al<=#a8 do local am=a8:byte(al)if am<32 then ac(a8,al,"control character in string")elseif am==92 then _=_..a8:sub(Q,al-1)al=al+1;local T=a8:sub(al,al)if T=="u"then local an=a8:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",al+1)or a8:match("^%x%x%x%x",al+1)or ac(a8,al-1,"invalid unicode escape in string")_=_..ag(an)al=al+#an else if not a5[T]then ac(a8,al-1,"invalid escape char '"..T.."' in string")end;_=_..P[T]end;Q=al+1 elseif am==34 then _=_..a8:sub(Q,al-1)return _,al+1 end;al=al+1 end;ac(a8,a0,"expected closing quote for string")end;local ao=function(a8,a0)local am=a7(a8,a0,p)local ah=a8:sub(a0,am-1)local A=tonumber(ah)if not A then ac(a8,a0,"invalid number '"..ah.."'")end;return A,am end;local ap=function(a8,a0)local am=a7(a8,a0,p)local aq=a8:sub(a0,am-1)if not m[aq]then ac(a8,a0,"invalid literal '"..aq.."'")end;return a6[aq],am end;local ar=function(a8,a0)local _={}local A=1;a0=a0+1;while 1 do local am;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="]"then a0=a0+1;break end;am,a0=a4(a8,a0)_[A]=am;A=A+1;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="]"then break end;if as~=","then ac(a8,a0,"expected ']' or ','")end end;return _,a0 end;local at=function(a8,a0)local _={}a0=a0+1;while 1 do local au,M;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="}"then a0=a0+1;break end;if a8:sub(a0,a0)~='"'then ac(a8,a0,"expected string for key")end;au,a0=a4(a8,a0)a0=a7(a8,a0,L,true)if a8:sub(a0,a0)~=":"then ac(a8,a0,"expected ':' after key")end;a0=a7(a8,a0+1,L,true)M,a0=a4(a8,a0)_[au]=M;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="}"then break end;if as~=","then ac(a8,a0,"expected '}' or ','")end end;return _,a0 end;local av={['"']=ak,["0"]=ao,["1"]=ao,["2"]=ao,["3"]=ao,["4"]=ao,["5"]=ao,["6"]=ao,["7"]=ao,["8"]=ao,["9"]=ao,["-"]=ao,["t"]=ap,["f"]=ap,["n"]=ap,["["]=ar,["{"]=at}a4=function(a8,a9)local as=a8:sub(a9,a9)local a2=av[as]if a2 then return a2(a8,a9)end;ac(a8,a9,"unexpected character '"..as.."'")end;local aw=function(a8)if type(a8)~="string"then error("expected argument of type string, got "..type(a8))end;local _,a9=a4(a8,a7(a8,1,L,true))a9=a7(a8,a9,L,true)if a9<=#a8 then ac(a8,a9,"trailing garbage")end;return _ end;
local lEncode, lDecode, lDigest = a3, aw, Z;
-------------------------------------------------------------------------------

-- Platoboost client + helpers (kept from your working copy)
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

-- AUTO DETECT HTTP REQUEST (for Firebase)
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

-- UI: hookup to existing UI in PlayerGui (replaces previous makeGui)
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local PlayersSvc = game:GetService("Players")
local player = PlayersSvc.LocalPlayer
repeat task.wait(0.05) until player and player:FindFirstChild("PlayerGui")
local PlayerGui = player:WaitForChild("PlayerGui")

-- wait for the exact path: PlayerGui > HAPPYscript > Main > ScrollingFrame > System
local function waitPath(root, ...)
    local node = root
    for i = 1, select("#", ...) do
        local name = select(i, ...)
        node = node:WaitForChild(name)
    end
    return node
end

local ok, SystemFrame = pcall(function()
    return waitPath(PlayerGui, "HAPPYscript", "Main", "ScrollingFrame", "System")
end)
if not ok or not SystemFrame then
    warn("[EnergyUI] Không tìm thấy System UI theo đường dẫn PlayerGui > HAPPYscript > Main > ScrollingFrame > System")
    return
end

-- Elements (the user specified structure)
local CodeBox = SystemFrame:FindFirstChild("CodeBox")
if not CodeBox then
    warn("[EnergyUI] CodeBox không tồn tại trong System")
    return
end
local GetCodeButton = SystemFrame:FindFirstChild("GetCodeButton")
local CheckButton = CodeBox:FindFirstChild("CheckButton")

if not GetCodeButton or not CheckButton then
    warn("[EnergyUI] Thiếu GetCodeButton hoặc CheckButton (CheckButton phải nằm trong CodeBox).")
    return
end

-- Optional elements for status/energy label if present
local energyLabel = SystemFrame:FindFirstChild("EnergyLabel") or SystemFrame:FindFirstChild("energyLabel")
local statusLabel = SystemFrame:FindFirstChild("StatusLabel") or SystemFrame:FindFirstChild("statusLabel")

-- find EnergyEffect template inside CheckButton
local energyTemplate = CheckButton:FindFirstChild("EnergyEffect")
if energyTemplate then
    energyTemplate.Visible = false
else
    warn("[EnergyUI] Không tìm thấy EnergyEffect inside CheckButton. Hãy thêm một ImageLabel tên 'EnergyEffect' (Visible=false) làm mẫu.")
end

-- find EnergyIcon.Value
local EnergyIcon = SystemFrame:FindFirstChild("EnergyIcon")
local EnergyValueLabel = nil
if EnergyIcon then
    EnergyValueLabel = EnergyIcon:FindFirstChild("Value")
end

local MAX_ENERGY = 100
local cachedEnergy = nil

local function updateEnergyUI(val)
    val = tonumber(val) or 0
    if val < 0 then val = 0 end
    if val > MAX_ENERGY then val = MAX_ENERGY end
    cachedEnergy = val
    if EnergyValueLabel and EnergyValueLabel:IsA("TextLabel") then
        EnergyValueLabel.Text = tostring(math.floor(val)) .. "/" .. tostring(MAX_ENERGY)
    end
    if energyLabel and energyLabel:IsA("TextLabel") then
        energyLabel.Text = "Energy: " .. tostring(math.floor(val))
    end
end

-- helper: trim
local function trim(s) return tostring(s):gsub("^%s*(.-)%s*$", "%1") end

-- helper: simple debounce
local function makeDebounce()
    local busy = false
    return function(fn)
        if busy then return false end
        busy = true
        task.spawn(function()
            fn()
            busy = false
        end)
        return true
    end
end

-- ===========================
-- GetCodeButton behavior (copy + tween feedback)
-- ===========================
local getBtnBusy = false
GetCodeButton.AutoButtonColor = true
GetCodeButton.MouseButton1Click:Connect(function()
    if getBtnBusy then return end
    getBtnBusy = true

    statusLabel and pcall(function() statusLabel.Text = "Trạng thái: Lấy link..." end)

    -- call copyLink safely to get full returns
    local okCopy, a, b = pcall(function() return copyLink() end)
    local success, payload
    if okCopy then
        success = a
        payload = b
    else
        success = false
        payload = tostring(a or "Lỗi")
    end

    -- disable interaction
    GetCodeButton.Active = false
    GetCodeButton.AutoButtonColor = false

    -- prepare tweens
    local fadeOutInfo = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local fadeInInfo = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local colorInfo = TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

    local origBg = GetCodeButton.BackgroundColor3
    local origText = GetCodeButton.Text

    local colorA = Color3.fromRGB(255, 0, 100) -- from (branding)
    local colorB = Color3.fromRGB(0, 200, 100) -- to

    -- ensure initial
    GetCodeButton.TextTransparency = 0
    GetCodeButton.BackgroundColor3 = colorA

    local tFadeOut = TweenService:Create(GetCodeButton, fadeOutInfo, { TextTransparency = 1 })
    local tFadeIn = TweenService:Create(GetCodeButton, fadeInInfo, { TextTransparency = 0 })
    local tColorTo = TweenService:Create(GetCodeButton, colorInfo, { BackgroundColor3 = colorB })
    local tColorBack = TweenService:Create(GetCodeButton, colorInfo, { BackgroundColor3 = colorA })

    tFadeOut:Play()
    tColorTo:Play()
    tFadeOut.Completed:Wait()

    if success == true and type(payload) == "string" then
        GetCodeButton.Text = "Copied"
        pcall(function() CodeBox.Text = payload end)
        statusLabel and pcall(function() statusLabel.Text = "Trạng thái: Link đã copy" end)
    else
        GetCodeButton.Text = "Copied"
        pcall(function() CodeBox.Text = tostring(payload or "No link") end)
        statusLabel and pcall(function() statusLabel.Text = "Trạng thái: Link trả về (xem ô nhập)" end)
    end

    tFadeIn:Play()
    tColorBack:Play()
    tFadeIn.Completed:Wait()
    tColorBack.Completed:Wait()

    task.wait(0.35)
    GetCodeButton.Text = origText
    GetCodeButton.BackgroundColor3 = origBg
    GetCodeButton.TextTransparency = 0

    GetCodeButton.Active = true
    GetCodeButton.AutoButtonColor = true
    getBtnBusy = false
end)

-- ===========================
-- CheckButton behavior + messages + EnergyEffect spawn
-- ===========================
local function flashCodeBoxMessage(message, color, duration)
    duration = duration or 2
    color = color or Color3.fromRGB(255, 120, 120)
    local prevText = CodeBox.Text
    local prevColor = CodeBox.TextColor3
    CodeBox.Text = message
    CodeBox.TextColor3 = color
    task.delay(duration, function()
        if CodeBox.Text == message then
            CodeBox.Text = ""
        end
        CodeBox.TextColor3 = prevColor or Color3.fromRGB(255,255,255)
    end)
end

-- optimized spawn effect: tween-based (midpoint arc)
local function spawnEnergyEffects()
    if not energyTemplate or not SystemFrame then return end
    local parentForClones = SystemFrame

    -- compute target pixel = center of EnergyIcon (if present), fallback to some offset
    local targetPixel
    if EnergyIcon and EnergyIcon:IsA("GuiObject") then
        local absPos = EnergyIcon.AbsolutePosition
        local absSize = EnergyIcon.AbsoluteSize
        targetPixel = Vector2.new(absPos.X + absSize.X/2, absPos.Y + absSize.Y/2)
    else
        -- fallback: toward top-left of SystemFrame
        local sp = energyTemplate.AbsolutePosition
        targetPixel = sp + Vector2.new(-100, -100)
    end

    for i = 1, 10 do
        task.delay(0.06 * (i-1), function()
            local clone = energyTemplate:Clone()
            clone.Visible = true
            clone.Parent = parentForClones

            -- compute start pixel & place clone relative to parent
            local startPixel = Vector2.new(energyTemplate.AbsolutePosition.X, energyTemplate.AbsolutePosition.Y)
            local startRel = startPixel - parentForClones.AbsolutePosition
            clone.AnchorPoint = energyTemplate.AnchorPoint
            clone.Position = UDim2.new(0, math.floor(startRel.X), 0, math.floor(startRel.Y))
            clone.Size = energyTemplate.Size
            clone.Rotation = energyTemplate.Rotation

            -- compute target relative
            local targetRel = targetPixel - parentForClones.AbsolutePosition
            local targetUDim2 = UDim2.new(0, math.floor(targetRel.X), 0, math.floor(targetRel.Y))

            -- midpoint above for arc
            local midX = (startRel.X + targetRel.X) * 0.5 + math.random(-30,30)
            local lift = -80 + math.random(-20,20) -- upward lift (negative y)
            local midY = (startRel.Y + targetRel.Y) * 0.5 + lift
            local midUDim2 = UDim2.new(0, math.floor(midX), 0, math.floor(midY))

            -- tweens
            local t1 = TweenService:Create(clone, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = midUDim2, Rotation = clone.Rotation + ( (i%2==0) and 12 or -12 ), Size = clone.Size + UDim2.new(0, 6, 0, 6) })
            local t2 = TweenService:Create(clone, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Position = targetUDim2, Rotation = clone.Rotation + ( (i%2==0) and 28 or -28 ), Size = clone.Size + UDim2.new(0, 10, 0, 10) })

            -- when nearing end of t2, fade descendants ImageTransparency / TextTransparency
            t2:Play()
            -- play sequence
            t1:Play()
            t1.Completed:Wait()
            -- start fading inside slightly before arrival
            task.delay(0.32, function()
                for _, v in ipairs(clone:GetDescendants()) do
                    if v:IsA("ImageLabel") or v:IsA("ImageButton") then
                        pcall(function()
                            TweenService:Create(v, TweenInfo.new(0.18), { ImageTransparency = 1 }):Play()
                        end)
                    elseif v:IsA("TextLabel") or v:IsA("TextButton") then
                        pcall(function()
                            TweenService:Create(v, TweenInfo.new(0.18), { TextTransparency = 1 }):Play()
                        end)
                    end
                end
            end)
            t2.Completed:Wait()

            -- small effect on target (pulse) if target exists
            if EnergyIcon and EnergyIcon:IsA("GuiObject") then
                -- quick scale pulse on Value or icon
                pcall(function()
                    local orig = EnergyIcon.Size
                    local twUp = TweenService:Create(EnergyIcon, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = orig + UDim2.new(0,6,0,6) })
                    local twDown = TweenService:Create(EnergyIcon, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Size = orig })
                    twUp:Play(); twUp.Completed:Wait(); twDown:Play()
                end)
            end

            task.delay(0.06, function()
                if clone and clone.Parent then clone:Destroy() end
            end)
        end)
    end
end

-- initial energy UI fetch
task.spawn(function()
    local e = GetEnergy()
    if not e then
        updateEnergyUI(0)
    else
        updateEnergyUI(e)
    end
end)

-- CheckButton main logic: uses verifyKey + firebase logic from above, with rollback on AddEnergy fail
CheckButton.MouseButton1Click:Connect(function()
    local key = trim(CodeBox.Text or "")
    if key == "" then
        flashCodeBoxMessage("Vui lòng nhập key trước khi kiểm tra.", Color3.fromRGB(255,120,120), 2)
        statusLabel and pcall(function() statusLabel.Text = "Trạng thái: chưa nhập key" end)
        return
    end

    if type(verifyKey) ~= "function" then
        flashCodeBoxMessage("Hàm verifyKey không tồn tại.", Color3.fromRGB(255,180,60), 2)
        statusLabel and pcall(function() statusLabel.Text = "Trạng thái: verifyKey không khả dụng" end)
        return
    end

    statusLabel and pcall(function() statusLabel.Text = "Trạng thái: Đang kiểm tra key..." end)

    local okVerify, verifyRes = pcall(function() return verifyKey(key) end)
    if not okVerify then
        flashCodeBoxMessage("Lỗi khi gọi verifyKey.", Color3.fromRGB(255,120,120), 2)
        statusLabel and pcall(function() statusLabel.Text = "Trạng thái: Lỗi verify" end)
        return
    end

    if verifyRes ~= true then
        flashCodeBoxMessage("Key không hợp lệ.", Color3.fromRGB(255,120,120), 2)
        statusLabel and pcall(function() statusLabel.Text = "Trạng thái: Key không hợp lệ" end)
        return
    end

    -- Key valid remotely -> apply Firebase checks
    EnsureUser()
    pcall(CleanupExpiredKeys)

    -- refresh current energy
    local currentEnergy = tonumber(cachedEnergy)
    if currentEnergy == nil then
        currentEnergy = GetEnergy() or 0
        updateEnergyUI(currentEnergy)
    end

    -- compute allowed addition
    local allowedAdd = math.max(0, math.min(REWARD_ENERGY, MAX_ENERGY - currentEnergy))

    if allowedAdd <= 0 then
        flashCodeBoxMessage("Energy đã đầy (" .. tostring(MAX_ENERGY) .. "/" .. tostring(MAX_ENERGY) .. ").", Color3.fromRGB(255,180,60), 2)
        statusLabel and pcall(function() statusLabel.Text = "Trạng thái: Energy đã đầy" end)
        return
    end

    if IsKeyCurrentlyUsed(key) then
        flashCodeBoxMessage("Key đã được dùng trong vòng 1 giờ.", Color3.fromRGB(255,180,60), 2)
        statusLabel and pcall(function() statusLabel.Text = "Trạng thái: Key đã dùng (chưa đủ 1 giờ)" end)
        return
    end

    local markOk = MarkKeyUsed(key)
    if not markOk then
        flashCodeBoxMessage("Lỗi lưu thông tin key đã dùng.", Color3.fromRGB(255,120,120), 2)
        statusLabel and pcall(function() statusLabel.Text = "Trạng thái: Lỗi lưu key" end)
        return
    end

    local addOk, newEnergy = AddEnergy(allowedAdd)
    if addOk then
        newEnergy = tonumber(newEnergy) or (currentEnergy + allowedAdd)
        if newEnergy > MAX_ENERGY then newEnergy = MAX_ENERGY end
        updateEnergyUI(newEnergy)

        statusLabel and pcall(function() statusLabel.Text = "Trạng thái: Nhận +" .. tostring(allowedAdd) .. " Energy" end)
        flashCodeBoxMessage("Key hợp lệ! Bạn được +" .. tostring(allowedAdd) .. " Energy.", Color3.fromRGB(120,255,150), 2)

        -- spawn visual effects
        pcall(function() spawnEnergyEffects() end)
    else
        -- rollback mark
        pcall(function() RemoveUsedKey(key) end)
        flashCodeBoxMessage("Lỗi cập nhật Energy.", Color3.fromRGB(255,120,120), 2)
        statusLabel and pcall(function() statusLabel.Text = "Trạng thái: Lỗi cập nhật Energy" end)
    end
end)

-- Expose helper for debugging if needed
_G.EnergyUI = { updateEnergyUI = updateEnergyUI, spawnEnergyEffects = spawnEnergyEffects }
