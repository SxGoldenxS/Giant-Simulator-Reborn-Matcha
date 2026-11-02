-- Decompiled game.ReplicatedStorage.Aero.Shared.HalloweenConfig

local v_u_30 = {
    ["ENDS_AT"] = 1794200399,
    ["EVENT_MODES"] = {},
    ["EventMode"] = function(p1)
        -- upvalues: (copy) v_u_30
        return (type(p1) ~= "string" or not v_u_30.EVENT_MODES[p1]) and "auto" or p1
    end,
    ["EventOn"] = function(p2, p3)
        -- upvalues: (copy) v_u_30
        local v4 = v_u_30.EventMode(p2)
        if v4 == "on" then
            return true
        elseif v4 == "off" then
            return false
        else
            return p3 < v_u_30.ENDS_AT
        end
    end,
    ["EventEndsAt"] = function(p5, p6)
        -- upvalues: (copy) v_u_30
        return (v_u_30.EventMode(p5) ~= "auto" or p6 >= v_u_30.ENDS_AT) and 0 or v_u_30.ENDS_AT
    end,
    ["ORB_PUMPKINS"] = 5,
    ["ORB_GOLD"] = 5,
    ["ORB_SPEED"] = 5,
    ["ORB_XP_FRACTION"] = 0.5,
    ["HOUSE_PUMPKINS"] = 11,
    ["HOUSE_COOLDOWN_SECS"] = 10,
    ["HOUSE_DOOR_OPEN_SECS"] = 5,
    ["HOUSE_KNOCK_MAX_DISTANCE"] = 18,
    ["HOUSE_PLAYER_COOLDOWN_SECS"] = 2,
    ["RING_PUMPKINS"] = 6,
    ["RING_CADENCE_SECS"] = 5,
    ["ZONE_CLOCK_TIME"] = 0,
    ["ZONE_SONG_ID"] = "rbxassetid://7775735321",
    ["TELEPORT"] = {},
    ["TeleportCooldownLeft"] = function(p7)
        -- upvalues: (copy) v_u_30
        if p7 == nil then
            return 0
        end
        local v8 = v_u_30.TELEPORT.COOLDOWN_SECS - p7
        return v8 <= 0 and 0 or math.ceil(v8)
    end,
    ["TeleportCheck"] = function(p9)
        -- upvalues: (copy) v_u_30
        if v_u_30.TELEPORT.ENABLED and p9.enabled then
            if p9.loaded and p9.alive then
                if p9.busy then
                    return false, "busy"
                elseif p9.inZone then
                    return false, "in_zone"
                elseif v_u_30.TeleportCooldownLeft(p9.sinceLast) > 0 then
                    return false, "cooldown"
                else
                    return true, nil
                end
            else
                return false, "not_ready"
            end
        else
            return false, "disabled"
        end
    end,
    ["PET_CRATE_COST"] = 2000,
    ["ARTIFACT_CRATE_COST"] = 5000,
    ["MEGA_FRANK_COSTS"] = { 250000, 500000, 1000000 },
    ["PUMPKIN_REAPER_COST"] = 1000000,
    ["MegaFrankCost"] = function(p10)
        -- upvalues: (copy) v_u_30
        local v11 = v_u_30.MEGA_FRANK_COSTS
        local v12 = ((type(p10) ~= "number" or (p10 ~= p10 or p10 <= 0)) and 0 or math.floor(p10)) + 1
        local v13 = #v11
        return v11[math.min(v12, v13)]
    end,
    ["PETS"] = {
        ["BLACK_CAT"] = {},
        ["RED_DEVIL"] = {},
        ["ZOMBIE"] = {},
        ["FRANKENSTEIN"] = {},
        ["DRACULA"] = {},
        ["PUMPKIN_WITCH"] = {},
        ["MEGA_FRANK"] = {},
        ["FROSTBIT"] = {},
        ["BLOOD_BOOLET"] = {},
        ["BLOOD_MOON_WEREWOLF"] = {},
        ["BLOOD_MOON_MEGA_FRANK"] = {},
        ["VAMPIRE_BAT"] = {}
    },
    ["FROSTBIT"] = {},
    ["FrostbitClaimCheck"] = function(p14, p15, p16, p17)
        if p14 then
            if p15 then
                return false, "claimed"
            elseif p17 <= p16 then
                return true, nil
            else
                return false, "too_early"
            end
        else
            return false, "disabled"
        end
    end,
    ["FrostbitSecondsLeft"] = function(p18, p19)
        local v20 = p19 - p18
        return v20 <= 0 and 0 or math.ceil(v20)
    end,
    ["ARTIFACTS"] = {
        [30] = {},
        [31] = {},
        [32] = {},
        [33] = {},
        [34] = {},
        [35] = {}
    },
    ["ARTIFACT_CRATE_ODDS"] = {
        {},
        {},
        {},
        {},
        {},
        {}
    },
    ["PUMPKIN_REAPER"] = {},
    ["ALPHA_WEREWOLF"] = {},
    ["KEPT_SKINS"] = {
        {},
        {}
    },
    ["KeptSkin"] = function(p21)
        -- upvalues: (copy) v_u_30
        for _, v22 in v_u_30.KEPT_SKINS do
            if v22.skin == p21 then
                return v22
            end
        end
        return nil
    end,
    ["PACK_AMOUNTS"] = {
        2500,
        15000,
        75000,
        250000,
        1500000
    },
    ["EVENT_CURRENCY_PASS_MULT"] = 2,
    ["BoostPumpkins"] = function(p23, p24, p25, p26, p27)
        -- upvalues: (copy) v_u_30
        local v28 = not p26 and 1 or v_u_30.EVENT_CURRENCY_PASS_MULT
        local v29 = p23 * p24 * (p27 or 1) * p25 * v28 - 1e-6
        return math.ceil(v29)
    end,
    ["GROWING_JACK"] = {
        ["STAGES"] = {
            {},
            {},
            {},
            {},
            {}
        },
        ["SIGN_IMAGES"] = {
            "rbxassetid://84864000028136",
            "rbxassetid://120419782727392",
            "rbxassetid://110633240057529",
            "rbxassetid://86971604917182",
            "rbxassetid://95323094690061"
        }
    },
    ["CODES"] = {},
    ["SHOP_HOLD_SECS"] = 1,
    ["SHOP_BUY_COOLDOWN_SECS"] = 1
}
local v31 = {
    ["WINDOWS"] = {
        {},
        {},
        {}
    },
    ["OUTLINE_COLORS"] = {
        ["red"] = { 237, 23, 39 },
        ["silver"] = { 205, 208, 217 }
    },
    ["GHOST_LOOK"] = {
        ["RED"] = { 255, 72, 72 },
        ["GLOW"] = { 255, 60, 50 },
        ["BURST_BRIGHT"] = { 255, 140, 120 },
        ["BURST"] = { 220, 30, 36 }
    }
}
local v32 = {
    ["ATMOSPHERE"] = {
        ["color"] = { 180, 40, 40 },
        ["decay"] = { 130, 18, 24 }
    },
    ["TINT"] = { 255, 205, 195 },
    ["COLOR_SHIFT_TOP"] = { 255, 50, 40 },
    ["AMBIENT"] = { 215, 130, 125 },
    ["OUTDOOR_AMBIENT"] = { 185, 90, 85 },
    ["LIGHTNING_GAP_SECS"] = { 14, 30 },
    ["THUNDER_DELAY_SECS"] = { 0.6, 1.8 },
    ["THUNDER_SOUND_IDS"] = { "rbxassetid://9120018216", "rbxassetid://9120017047" }
}
v31.LOOK = v32
v_u_30.BLOOD_MOON = v31
v_u_30.BLOOD_MOON_MODES = {}
function v_u_30.BloodMoonMode(p33)
    -- upvalues: (copy) v_u_30
    return (type(p33) ~= "string" or not v_u_30.BLOOD_MOON_MODES[p33]) and "auto" or p33
end
function v_u_30.BloodMoonWindowAt(p34)
    -- upvalues: (copy) v_u_30
    for _, v35 in v_u_30.BLOOD_MOON.WINDOWS do
        if v35.STARTS_AT <= p34 and p34 < v35.ENDS_AT then
            return v35
        end
    end
    return nil
end
function v_u_30.BloodMoonNextWindow(p36)
    -- upvalues: (copy) v_u_30
    for _, v37 in v_u_30.BLOOD_MOON.WINDOWS do
        if p36 < v37.STARTS_AT then
            return v37
        end
    end
    return nil
end
function v_u_30.BloodMoonActive(p38, p39, p40)
    -- upvalues: (copy) v_u_30
    if p38 then
        local v41 = v_u_30.BloodMoonMode(p39)
        if v41 == "on" then
            return true
        elseif v41 == "off" then
            return false
        else
            return v_u_30.BloodMoonWindowAt(p40) ~= nil
        end
    else
        return false
    end
end
function v_u_30.BloodMoonEndsAt(p42)
    -- upvalues: (copy) v_u_30
    local v43 = v_u_30.BloodMoonWindowAt(p42) or v_u_30.BloodMoonNextWindow(p42)
    return not v43 and 0 or v43.ENDS_AT
end
function v_u_30.BloodMoonStartsAt(p44, p45, p46)
    -- upvalues: (copy) v_u_30
    if not p44 or (v_u_30.BloodMoonMode(p45) ~= "auto" or v_u_30.BloodMoonWindowAt(p46)) then
        return 0
    end
    local v47 = v_u_30.BloodMoonNextWindow(p46)
    return not v47 and 0 or v47.STARTS_AT
end
function v_u_30.BloodMoonScheduleOver(p48)
    -- upvalues: (copy) v_u_30
    local v49
    if v_u_30.BloodMoonWindowAt(p48) == nil then
        v49 = v_u_30.BloodMoonNextWindow(p48) == nil
    else
        v49 = false
    end
    return v49
end
function v_u_30.BloodMoonBadge(p50, p51, p52, p53, p54)
    -- upvalues: (copy) v_u_30
    if p50 then
        return "live", p51
    elseif p52 > 0 then
        return "soon", p52
    elseif p53 and (p54 and (p54 < p53 and v_u_30.BloodMoonScheduleOver(p54))) then
        return "ends", p53
    else
        return nil, 0
    end
end
local function v_u_61(p55)
    local v56 = (p55 ~= p55 or p55 <= 0) and 0 or math.floor(p55)
    if v56 >= 86400 then
        local v57 = v56 / 86400 + 0.5
        local v58 = math.floor(v57)
        return v58 == 1 and "1 day" or ("%d days"):format(v58)
    else
        local v59 = v56 // 3600
        local v60 = v56 % 3600 // 60
        if v59 > 0 then
            return string.format("%dh %02dm", v59, v60)
        else
            return string.format("%dm %02ds", v60, v56 % 60)
        end
    end
end
function v_u_30.BloodMoonStartsIn(p62)
    -- upvalues: (copy) v_u_61
    return v_u_61(p62)
end
function v_u_30.EventEndsIn(p63)
    -- upvalues: (copy) v_u_61
    return v_u_61(p63)
end
function v_u_30.BloodMoonOutlineRGB(p64)
    -- upvalues: (copy) v_u_30
    local v65 = v_u_30.BLOOD_MOON
    return p64 and v65.OUTLINE_COLORS[p64] or (v65.OUTLINE_COLORS[v65.OUTLINE] or v65.OUTLINE_COLORS.red)
end
v_u_30.BLOOD_MOON_LINEUP = {
    {},
    {},
    {},
    {},
    {},
    {
        ["once"] = v_u_30.BLOOD_MOON.BLOODMOON_BELL_ONCE
    }
}
v_u_30.BLOOD_MOON_MOUNTS = {
    {},
    {}
}
v_u_30.BLOOD_MOON_MOUNT_SPOTS = {
    {},
    {}
}
function v_u_30.BloodMoonMountSpots()
    -- upvalues: (copy) v_u_30
    local v66 = {}
    for _, v67 in v_u_30.BLOOD_MOON_MOUNT_SPOTS do
        local v68 = CFrame.new(v67.X, 0, v67.Z)
        local v69 = CFrame.Angles
        local v70 = v67.YAW
        local v71 = v68 * v69(0, math.rad(v70), 0)
        table.insert(v66, v71)
    end
    return v66
end
function v_u_30.BloodMoonItem(p72)
    -- upvalues: (copy) v_u_30
    for _, v73 in { v_u_30.BLOOD_MOON_LINEUP, v_u_30.BLOOD_MOON_MOUNTS } do
        for _, v74 in v73 do
            if v74.item == p72 then
                return v74
            end
        end
    end
    return nil
end
v_u_30.BLOOD_MOON_LINEUP_ARC = {}
function v_u_30.BloodMoonLineupArc(p75)
    -- upvalues: (copy) v_u_30
    local v76 = v_u_30.BLOOD_MOON_LINEUP_ARC
    local v77 = p75 <= 1 and 0 or v76.GAP / 2 + (p75 // 2 - 1) * v76.SPACING
    local v78 = v76.RADIUS
    local v79 = v76.WRAP
    local v80 = v77 / math.rad(v79)
    local v81 = math.max(v78, v80)
    local v82 = (p75 + 1) / 2
    local v83 = {}
    for v84 = 1, p75 do
        local v85 = v82 - v84
        local v86
        if v85 == 0 then
            v86 = 0
        else
            local v87 = math.abs(v85) - (p75 % 2 == 0 and 0.5 or 1)
            v86 = math.sign(v85) * (v76.GAP / 2 + v87 * v76.SPACING)
        end
        local v88 = v86 / v81
        local v89 = v81 * math.sin(v88)
        local v90 = -v76.FORWARD - v81 * (1 - math.cos(v88))
        local v91 = CFrame.new(v89, 0, v90) * CFrame.Angles(0, v88, 0)
        table.insert(v83, v91)
    end
    return v83
end
function v_u_30.BloodMoonOffer(p92, p93, p94, p95)
    -- upvalues: (copy) v_u_30
    local v96 = v_u_30.BloodMoonItem(p92)
    if not (p93 and v96) then
        return "closed", 0
    end
    if v96.once and p94 then
        return "owned", 0
    end
    local v97 = v_u_30.BLOOD_MOON[v96.cost]
    local v98 = (type(p95) ~= "number" or p95 ~= p95) and 0 or math.max(p95, 0)
    if v97 <= v98 then
        return "buy", 0
    end
    local v99 = v97 - v98
    return "short", math.ceil(v99)
end
function v_u_30.PackForShortfall(p100, p101, p102)
    -- upvalues: (copy) v_u_30
    local v103 = 0
    local v104 = 0
    local v105 = nil
    local v106 = nil
    for v107 = 1, #v_u_30.PACK_AMOUNTS do
        local v108 = p101[v107]
        if type(v108) == "number" and v108 > 0 then
            if p102 then
                v108 = p102(v108)
            end
            if p100 <= v108 and (v105 == nil or v108 < v104) then
                v105 = v107
                v104 = v108
            end
            if v106 == nil or v103 < v108 then
                v106 = v107
                v103 = v108
            end
        end
    end
    if v105 then
        return v105, v104
    else
        return v106, v103
    end
end
function v_u_30.GhostSouls(p109)
    -- upvalues: (copy) v_u_30
    local v110
    if p109 then
        v110 = v_u_30.BLOOD_MOON
    else
        v110 = v_u_30.SOULS
    end
    return v110.SOULS_PER_HIT, v110.POP_BONUS
end
function v_u_30.SoulsPerGhost(p111)
    -- upvalues: (copy) v_u_30
    local v112, v113 = v_u_30.GhostSouls(p111)
    return v_u_30.GHOSTS.POP_HITS * v112 + v113
end
function v_u_30.BloodMoonSoulHint()
    -- upvalues: (copy) v_u_30
    local v114 = (v_u_30.SoulsPerGhost(true) / v_u_30.SoulsPerGhost(false) - 1) * 100 + 0.5
    return ("Blood Moon: red ghosts give +%d%% souls!"):format((math.floor(v114)))
end
function v_u_30.FormatCountdown(p115)
    local v116 = (p115 ~= p115 or p115 <= 0) and 0 or math.floor(p115)
    local v117 = v116 // 86400
    local v118 = v116 % 86400 // 3600
    local v119 = v116 % 3600 // 60
    if v117 > 0 then
        return string.format("%dd %02dh %02dm", v117, v118, v119)
    elseif v118 > 0 then
        return string.format("%dh %02dm %02ds", v118, v119, v116 % 60)
    else
        return string.format("%dm %02ds", v119, v116 % 60)
    end
end
v_u_30.GHOSTS = {
    ["CORNERS"] = {
        {},
        {},
        {},
        {}
    },
    ["HITBOX"] = {},
    ["SOUNDS"] = {},
    ["GRAVEYARD"] = {}
}
v_u_30.SOULS = {}
return v_u_30