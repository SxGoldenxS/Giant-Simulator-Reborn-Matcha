-- Decompiled game.Players.BoomerIsBigMan.PlayerScripts.Aero.Controllers.FrostbitQuestController

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.ZapClient)
local v_u_3 = require(v1.Packages.signal)
return {
    ["Init"] = function(p4)
        -- upvalues: (copy) v_u_3
        p4.StateChanged = v_u_3.new()
        p4._state = nil
        p4._deadline = 0
        p4._claiming = false
    end,
    ["Start"] = function(p_u_5)
        -- upvalues: (copy) v_u_2
        v_u_2.FrostbitQuestState.On(function(p6)
            -- upvalues: (copy) p_u_5
            p_u_5._state = p6
            p_u_5._deadline = os.clock() + p6.secondsLeft
            p_u_5.StateChanged:Fire()
            if p6.active and p6.secondsLeft > 0 then
                p_u_5:_syncAtDeadline(p_u_5._deadline)
            end
        end)
        task.spawn(function()
            -- upvalues: (copy) p_u_5, (ref) v_u_2
            local v7 = 0
            while p_u_5._state == nil and v7 < 15 do
                v_u_2.FrostbitQuestRequest.Fire()
                v7 = v7 + 1
                task.wait(2)
            end
        end)
    end,
    ["_syncAtDeadline"] = function(p_u_8, p_u_9)
        -- upvalues: (copy) v_u_2
        local v10 = task.delay
        local v11 = p_u_9 - os.clock()
        v10(math.max(0, v11) + 0.25, function()
            -- upvalues: (copy) p_u_8, (copy) p_u_9, (ref) v_u_2
            if p_u_8._deadline == p_u_9 and (p_u_8._state ~= nil and p_u_8._state.active) then
                v_u_2.FrostbitQuestRequest.Fire()
            end
        end)
    end,
    ["IsActive"] = function(p12)
        local v13
        if p12._state == nil then
            v13 = false
        else
            v13 = p12._state.active == true
        end
        return v13
    end,
    ["GetSecondsLeft"] = function(p14)
        if p14._state == nil then
            return 0
        end
        local v15 = p14._deadline - os.clock()
        local v16 = math.ceil(v15)
        return math.max(0, v16)
    end,
    ["IsClaiming"] = function(p17)
        return p17._claiming
    end,
    ["Claim"] = function(p18)
        -- upvalues: (copy) v_u_2
        if p18._claiming then
            return "err"
        end
        p18._claiming = true
        p18.StateChanged:Fire()
        local function v19()
            -- upvalues: (ref) v_u_2
            return v_u_2.FrostbitQuestClaim.Call()
        end
        local v20, v21 = pcall(v19)
        p18._claiming = false
        local v22
        if v20 and type(v21) == "table" then
            local v23 = v21.res
            v22 = type(v23) ~= "string" and "err" or v21.res
        else
            v22 = "err"
        end
        if v22 ~= "ok" then
            v_u_2.FrostbitQuestRequest.Fire()
        end
        p18.StateChanged:Fire()
        return v22
    end
}