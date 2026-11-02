-- Decompiled game.Players.BoomerIsBigMan.PlayerScripts.Aero.Internal.AeroClient

local v_u_1 = {
    ["Controllers"] = {},
    ["Modules"] = {},
    ["Shared"] = {},
    ["Services"] = {},
    ["Player"] = game:GetService("Players").LocalPlayer
}
local v_u_2 = {
    ["__index"] = v_u_1
}
local v_u_3 = script.Parent.Parent:WaitForChild("Controllers")
local v_u_4 = script.Parent.Parent:WaitForChild("Modules")
local v_u_5 = game:GetService("ReplicatedStorage"):WaitForChild("Aero"):WaitForChild("Shared")
local v6 = game:GetService("ReplicatedStorage").Aero:WaitForChild("Internal")
local v_u_7 = require(v6:WaitForChild("FastSpawn"))
function v_u_1.RegisterEvent(p8, p9)
    local v10 = p8.Shared.Event.new()
    p8._events[p9] = v10
    return v10
end
function v_u_1.FireEvent(p11, p12, ...)
    p11._events[p12]:Fire(...)
end
function v_u_1.ConnectEvent(p13, p14, p15)
    return p13._events[p14]:Connect(p15)
end
function v_u_1.WaitForEvent(p16, p17)
    return p16._events[p17]:Wait()
end
function v_u_1.WrapModule(_, p18)
    -- upvalues: (copy) v_u_2, (copy) v_u_7
    local v19 = type(p18) == "table"
    assert(v19, "Expected table for argument")
    p18._events = {}
    local v20 = v_u_2
    setmetatable(p18, v20)
    local v21 = p18.Init
    if type(v21) == "function" and not p18.__aeroPreventInit then
        p18:Init()
    end
    local v22 = p18.Start
    if type(v22) == "function" and not p18.__aeroPreventStart then
        v_u_7(p18.Start, p18)
    end
end
function LoadService(p23)
    -- upvalues: (copy) v_u_1
    local v24 = {}
    v_u_1.Services[p23.Name] = v24
    for _, v_u_25 in pairs(p23:GetChildren()) do
        if v_u_25:IsA("RemoteEvent") then
            local v_u_26 = v_u_1.Shared.Event.new()
            local v_u_27 = v_u_26.Fire
            function v_u_26.Fire(_, ...)
                -- upvalues: (copy) v_u_25
                v_u_25:FireServer(...)
            end
            v_u_25.OnClientEvent:Connect(function(...)
                -- upvalues: (copy) v_u_27, (copy) v_u_26
                v_u_27(v_u_26, ...)
            end)
            v24[v_u_25.Name] = v_u_26
        elseif v_u_25:IsA("RemoteFunction") then
            v24[v_u_25.Name] = function(_, ...)
                -- upvalues: (copy) v_u_25
                return v_u_25:InvokeServer(...)
            end
        end
    end
end
function LoadServices()
    local v28 = game:GetService("ReplicatedStorage"):WaitForChild("Aero"):WaitForChild("AeroRemoteServices")
    for _, v29 in pairs(v28:GetChildren()) do
        if v29:IsA("Folder") then
            LoadService(v29)
        end
    end
end
function LazyLoadSetup(p30, p_u_31)
    -- upvalues: (copy) v_u_1
    local v35 = {
        ["__index"] = function(p32, p33)
            -- upvalues: (copy) p_u_31, (ref) v_u_1
            local v34 = require(p_u_31[p33])
            if type(v34) == "table" then
                v_u_1:WrapModule(v34)
            end
            rawset(p32, p33, v34)
            return v34
        end
    }
    setmetatable(p30, v35)
end
function LoadController(p36)
    -- upvalues: (copy) v_u_1, (copy) v_u_2
    local v37 = require(p36)
    v_u_1.Controllers[p36.Name] = v37
    v37._events = {}
    local v38 = v_u_2
    setmetatable(v37, v38)
end
function InitController(p39)
    local v40 = p39.Init
    if type(v40) == "function" then
        p39:Init()
    end
end
function StartController(p41)
    -- upvalues: (copy) v_u_7
    local v42 = p41.Start
    if type(v42) == "function" then
        v_u_7(p41.Start, p41)
    end
end
function Init()
    -- upvalues: (copy) v_u_1, (copy) v_u_4, (copy) v_u_5, (copy) v_u_3
    LazyLoadSetup(v_u_1.Modules, v_u_4)
    LazyLoadSetup(v_u_1.Shared, v_u_5)
    LoadServices()
    for _, v43 in pairs(v_u_3:GetChildren()) do
        if v43:IsA("ModuleScript") then
            LoadController(v43)
        end
    end
    for _, v44 in pairs(v_u_1.Controllers) do
        InitController(v44)
    end
    for _, v45 in pairs(v_u_1.Controllers) do
        StartController(v45)
    end
    _G.Aero = v_u_1
end
Init()