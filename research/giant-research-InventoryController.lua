-- Decompiled game.Players.BoomerIsBigMan.PlayerScripts.Aero.Controllers.InventoryController

local v1 = {}
local v_u_2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = require(v3:WaitForChild("ZapClient"))
local v_u_5 = require(v3.Packages.signal)
local v_u_6 = {}
local v_u_7 = {
    "pets",
    "weapons",
    "skins",
    "artifacts",
    "mounts"
}
function v1.Init(p8)
    -- upvalues: (copy) v_u_5, (copy) v_u_7
    p8.Changed = v_u_5.new()
    p8._state = {}
    p8._autoSell = {}
    p8._chestCounts = {}
    p8._potionCounts = {}
    p8._seenKeys = {}
    p8._newKeys = {}
    p8._baselined = {}
    p8._petBoosts = nil
    p8._artifactBoosts = nil
    p8._enchantBoosts = nil
    p8._source = "zap"
    p8._replica = nil
    p8._replicaDirty = {}
    p8._replicaFlushScheduled = false
    for _, v9 in v_u_7 do
        p8._seenKeys[v9] = {}
        p8._newKeys[v9] = {}
    end
end
function v1.Start(p_u_10)
    -- upvalues: (copy) v_u_6, (copy) v_u_4, (copy) v_u_2
    for v_u_11, v12 in pairs(v_u_6) do
        v_u_4[v12].On(function(p13)
            -- upvalues: (copy) p_u_10, (copy) v_u_11
            if p_u_10._source ~= "replica" then
                p_u_10:_onPush(v_u_11, p13)
            end
        end)
    end
    v_u_4.InventoryChests.On(function(p14)
        -- upvalues: (copy) p_u_10
        if p_u_10._source ~= "replica" then
            p_u_10._chestCounts = p14.counts
            p_u_10.Changed:Fire("chests")
        end
    end)
    v_u_4.InventoryPotions.On(function(p15)
        -- upvalues: (copy) p_u_10
        if p_u_10._source ~= "replica" then
            p_u_10._potionCounts = p15.counts
            p_u_10.Changed:Fire("potions")
        end
    end)
    v_u_4.InventoryAutoSell.On(function(p16)
        -- upvalues: (copy) p_u_10
        if p_u_10._source ~= "replica" then
            p_u_10:_applyAutoSell(p16)
        end
    end)
    local v17 = p_u_10.Shared.Mounts
    for _, v18 in { v17.ATTR_OWNED, v17.ATTR_EQUIPPED } do
        v_u_2.LocalPlayer:GetAttributeChangedSignal(v18):Connect(function()
            -- upvalues: (copy) p_u_10
            p_u_10:_applyMounts()
        end)
    end
    p_u_10:_applyMounts()
    local v19 = p_u_10.Shared.Companions
    for _, v20 in { v19.ATTR_ID, v19.ATTR_STAGE } do
        v_u_2.LocalPlayer:GetAttributeChangedSignal(v20):Connect(function()
            -- upvalues: (copy) p_u_10
            p_u_10.Changed:Fire("companions")
        end)
    end
    p_u_10._cosmeticsScheduled = false
    p_u_10.Controllers.ReplicaController:ObserveSection(p_u_10.Shared.CosmeticSkins.SECTION, function()
        -- upvalues: (copy) p_u_10
        p_u_10:_scheduleCosmetics()
    end)
    p_u_10.Controllers.ReplicaController:OnReady(function(p21)
        -- upvalues: (copy) p_u_10, (ref) v_u_6
        if p21.Data.inventory ~= nil then
            p_u_10._replica = p21
            p_u_10._source = "replica"
            for v22 in pairs(v_u_6) do
                p_u_10:_applyReplicaType(v22)
            end
            p_u_10:_applyReplicaType("chests")
            p_u_10:_applyReplicaType("potions")
            p_u_10:_applyReplicaType("autosell")
            p21:OnChange(function(_, p23)
                -- upvalues: (ref) p_u_10
                if p23[1] == "inventory" and p23[2] ~= nil then
                    p_u_10._replicaDirty[p23[2]] = true
                    if not p_u_10._replicaFlushScheduled then
                        p_u_10._replicaFlushScheduled = true
                        task.defer(function()
                            -- upvalues: (ref) p_u_10
                            p_u_10._replicaFlushScheduled = false
                            local v24 = p_u_10._replicaDirty
                            p_u_10._replicaDirty = {}
                            for v25 in pairs(v24) do
                                p_u_10:_applyReplicaType(v25)
                            end
                        end)
                    end
                else
                    return
                end
            end)
        end
    end)
end
function v1._applyReplicaType(p26, p27)
    -- upvalues: (copy) v_u_6
    local v28 = p26._replica
    if v28 then
        v28 = v28.Data.inventory
    end
    if v28 then
        v28 = v28[p27]
    end
    if v28 == nil then
        return
    elseif v_u_6[p27] == nil then
        if p27 == "chests" then
            p26._chestCounts = table.clone(v28.counts)
            p26.Changed:Fire("chests")
            return
        elseif p27 == "potions" then
            p26._potionCounts = table.clone(v28.counts)
            p26.Changed:Fire("potions")
        elseif p27 == "autosell" then
            p26:_applyAutoSell(v28)
        end
    else
        p26:_onPush(p27, table.clone(v28))
        return
    end
end
function v1._applyAutoSell(p29, p30)
    local v31 = {}
    for _, v32 in ipairs(p30.rules) do
        v31[v32.typeId] = v32
    end
    p29._autoSell = v31
    p29.Changed:Fire("autosell")
end
function v1._applyMounts(p33)
    -- upvalues: (copy) v_u_2
    local v34 = p33.Shared.Mounts
    local v35 = v_u_2.LocalPlayer
    local v36 = v35:GetAttribute(v34.ATTR_OWNED)
    if v36 ~= nil then
        local v37 = v34.ParseOwned(v36)
        local v38 = {}
        for _, v39 in v34.Order do
            if v37[v39] then
                v38[#v38 + 1] = {
                    ["key"] = v39,
                    ["id"] = v39
                }
            end
        end
        local v40 = v35:GetAttribute(v34.ATTR_EQUIPPED)
        p33:_onPush("mounts", {
            ["equippedKey"] = not (v34.IsValidKey(v40) and v37[v40]) and "" or v40,
            ["items"] = v38
        })
    end
end
function v1._scheduleCosmetics(p_u_41)
    if not p_u_41._cosmeticsScheduled then
        p_u_41._cosmeticsScheduled = true
        task.defer(function()
            -- upvalues: (copy) p_u_41
            p_u_41._cosmeticsScheduled = false
            p_u_41:_applyCosmetics()
        end)
    end
end
function v1._applyCosmetics(p42)
    local v43 = p42.Shared.CosmeticSkins
    local v44 = p42.Shared.Skins
    local v45 = p42.Controllers.ReplicaController:CopyOf({ v43.SECTION })
    if v45 ~= nil then
        local v46 = p42._state.skins
        local v47
        if v46 == nil then
            v47 = nil
        else
            local v48 = v46.byKey
            if v48 then
                v48 = v46.byKey[v46.equippedKey]
            end
            v47 = v48 and v48.id or nil
        end
        local v49 = {}
        for v50 in pairs(v45.unlocked or {}) do
            local v51 = v43.IdOf(v50)
            if v51 ~= nil and v44.Data[v51] ~= nil then
                v49[#v49 + 1] = {
                    ["key"] = v43.Key(v51),
                    ["id"] = v51
                }
            end
        end
        table.sort(v49, function(p52, p53)
            return p52.id < p53.id
        end)
        local v54 = {}
        for _, v55 in ipairs(v49) do
            v54[v55.key] = v55
        end
        local v56 = v45.worn
        local v57 = tonumber(v56) or 0
        local v58 = v57 == 0 and "" or v43.Key(v57)
        p42._state.cosmetics = {
            ["equippedKey"] = v54[v58] == nil and "" or v58,
            ["baseKey"] = v47 == nil and "" or v43.Key(v47),
            ["items"] = v49,
            ["byKey"] = v54
        }
        p42.Changed:Fire("cosmetics")
    end
end
function v1._toastPetLevelUps(p59, p60)
    local v61 = p59._state.pets
    if v61 ~= nil and v61.byKey ~= nil then
        local v62 = p59.Shared.Pets
        for v63, v64 in pairs(p60) do
            local v65 = v61.byKey[v63]
            if v65 ~= nil and v64.level > v65.level then
                local v66 = v62.Data[v64.id]
                if v66 then
                    p59.Controllers.UIController:ShowToast({
                        ["title"] = string.format("Pet Level %d!", v64.level),
                        ["message"] = v66.Name,
                        ["image"] = v66.Icon
                    })
                end
            end
        end
    end
end
function v1._onPush(p67, p68, p69)
    local v70 = {}
    for _, v71 in ipairs(p69.items) do
        v70[v71.key] = v71
    end
    if p68 == "pets" then
        p67:_toastPetLevelUps(v70)
    end
    p69.byKey = v70
    p67._state[p68] = p69
    local v72 = p67._seenKeys[p68]
    local v73 = p67._newKeys[p68]
    if p67._baselined[p68] then
        for _, v74 in ipairs(p69.items) do
            if not v72[v74.key] then
                v73[v74.key] = true
            end
        end
    end
    for _, v75 in ipairs(p69.items) do
        v72[v75.key] = true
    end
    for v76 in pairs(v73) do
        if v70[v76] == nil then
            v73[v76] = nil
        end
    end
    p67._baselined[p68] = true
    if p68 == "pets" then
        p67._petBoosts = nil
    elseif p68 == "artifacts" then
        p67._artifactBoosts = nil
    elseif p68 == "weapons" or p68 == "skins" then
        p67._enchantBoosts = nil
    end
    p67.Changed:Fire(p68)
    if p68 == "skins" then
        p67:_scheduleCosmetics()
    end
end
function v1.GetState(p77, p78)
    return p77._state[p78]
end
function v1.GetPetBoosts(p79)
    if p79._petBoosts then
        return p79._petBoosts
    end
    local v80 = p79.Shared.Pets
    local v81 = p79._state.pets
    local v82
    if v81 == nil then
        v82 = {}
    else
        local v83 = {}
        for _, v84 in ipairs(v81.items) do
            v83[#v83 + 1] = {
                ["ptype"] = v84.id,
                ["level"] = v84.level,
                ["evo"] = v84.evo,
                ["equipped"] = v84.equipped
            }
        end
        v82 = {
            ["xp"] = v80:GetTotalXpBoost(v83),
            ["gold"] = v80:GetTotalGoldBoost(v83),
            ["speed"] = v80:GetTotalSpeedBoost(v83),
            ["embers"] = v80:GetTotalEmberBoost(v83),
            ["pumpkins"] = v80:GetTotalPumpkinBoost(v83)
        }
    end
    p79._petBoosts = v82
    return v82
end
function v1.GetArtifactBoosts(p85)
    if p85._artifactBoosts then
        return p85._artifactBoosts
    end
    local v86 = p85.Shared.Artifacts
    local v87 = p85._state.artifacts
    local v88
    if v87 == nil then
        v88 = {}
    else
        local v89 = {}
        for _, v90 in ipairs(v87.items) do
            if v90.equipped then
                v89[#v89 + 1] = {
                    ["ID"] = v90.id,
                    ["evolutionlevel"] = v90.evo
                }
            end
        end
        v88 = {
            ["gold"] = v86:GetTotalGoldBoostFromArtifactsData(v89),
            ["tokens"] = v86:GetTotalTokenBoostFromArtifactsData(v89),
            ["quest"] = v86:GetTotalQuestBoostFromArtifactsData(v89),
            ["pumpkins"] = v86:GetTotalPumpkinBoostFromArtifactsData(v89)
        }
    end
    p85._artifactBoosts = v88
    return v88
end
function v1.GetPumpkinBoost(p91)
    return p91:GetPetBoosts().pumpkins + p91:GetArtifactBoosts().pumpkins
end
function v1.GetEquippedCompanion(p92)
    -- upvalues: (copy) v_u_2
    local v93 = p92.Shared.Companions
    local v94 = v_u_2.LocalPlayer
    local v95 = v94:GetAttribute(v93.ATTR_ID)
    return type(v95) == "number" and v93:IsValidId(v95) and {
        ["id"] = v95,
        ["stage"] = v93:ClampStage(v95, v94:GetAttribute(v93.ATTR_STAGE))
    } or nil
end
function v1.GetCompanionMultiplier(p96, p97)
    local v98 = p96:GetEquippedCompanion()
    return v98 == nil and 1 or p96.Shared.Companions:GetMultiplier(v98.id, v98.stage, p97)
end
function v1.GetEnchantBoosts(p99)
    if p99._enchantBoosts then
        return p99._enchantBoosts
    end
    local v_u_100 = p99.Shared.EnchantConfig
    local v_u_101 = {}
    local function v105(p102)
        -- upvalues: (copy) v_u_100, (copy) v_u_101
        if p102 ~= nil and (p102.ench or 0) > 0 then
            local v103 = v_u_100.StatKey[p102.ench]
            if v103 ~= nil and v_u_101[v103] ~= nil then
                local v104 = v_u_101
                v104[v103] = v104[v103] + v_u_100.BoostOf({
                    ["stat"] = p102.ench,
                    ["tier"] = p102.enchTier
                })
            end
        end
    end
    local v106 = p99._state.weapons
    local v107 = v106 and v106.byKey
    if v107 then
        v107 = v106.equippedKey
    end
    local v108
    if v107 then
        v108 = v106.byKey[v107] or nil
    else
        v108 = nil
    end
    v105(v108)
    local v109 = v106 and v106.byKey
    if v109 then
        v109 = v106.offhandKey
    end
    v105(v109 and v106.byKey[v109] or nil)
    local v110 = p99._state.skins
    local v111 = v110 and v110.byKey
    if v111 then
        v111 = v110.equippedKey
    end
    v105(v111 and v110.byKey[v111] or nil)
    p99._enchantBoosts = v_u_101
    return v_u_101
end
function v1.IsNew(p112, p113, p114)
    local v115 = p112._newKeys[p113]
    local v116
    if v115 == nil then
        v116 = false
    else
        v116 = v115[p114] == true
    end
    return v116
end
function v1.GetNewCount(p117, p118)
    local v119 = p117._newKeys[p118]
    if v119 == nil then
        return 0
    end
    local v120 = 0
    for _ in pairs(v119) do
        v120 = v120 + 1
    end
    return v120
end
function v1.GetTotalNewCount(p121)
    -- upvalues: (copy) v_u_7
    local v122 = 0
    for _, v123 in v_u_7 do
        v122 = v122 + p121:GetNewCount(v123)
    end
    return v122
end
function v1.MarkSeen(p124, p125)
    local v126 = p124._newKeys[p125]
    if v126 ~= nil and next(v126) ~= nil then
        p124._newKeys[p125] = {}
        p124.Changed:Fire(p125)
    end
end
function v1.SendOp(_, p_u_127, p_u_128, p_u_129, p_u_130)
    -- upvalues: (copy) v_u_4
    local function v132()
        -- upvalues: (ref) v_u_4, (copy) p_u_127, (copy) p_u_128, (copy) p_u_129, (copy) p_u_130
        local v131 = {
            ["itemType"] = p_u_127,
            ["action"] = p_u_128,
            ["key"] = p_u_129,
            ["count"] = p_u_130
        }
        return v_u_4.InventoryOp.Call(v131)
    end
    local v133, v134 = pcall(v132)
    if v133 and v134 ~= nil then
        return v134.res, v134.amount
    end
    warn("[InventoryController] InventoryOp failed: " .. tostring(v134))
    return nil, 0
end
function v1.GetChestCounts(p135)
    return p135._chestCounts
end
function v1.GetPotionCounts(p136)
    return p136._potionCounts
end
function v1.UsePotion(_, p_u_137)
    -- upvalues: (copy) v_u_4
    local function v139()
        -- upvalues: (ref) v_u_4, (copy) p_u_137
        local v138 = {
            ["potionId"] = p_u_137
        }
        return v_u_4.InventoryUsePotion.Call(v138)
    end
    local v140, v141 = pcall(v139)
    if v140 and v141 ~= nil then
        return v141.res
    end
    warn("[InventoryController] InventoryUsePotion failed: " .. tostring(v141))
    return nil
end
function v1.GetAutoSellRule(p142, p143)
    return p142._autoSell[p143]
end
function v1.SetAutoSellRule(_, p_u_144, p_u_145)
    -- upvalues: (copy) v_u_4
    local function v151()
        -- upvalues: (ref) v_u_4, (copy) p_u_144, (copy) p_u_145
        local v146 = v_u_4.InventorySetAutoSellRule.Call
        local v147 = {
            ["typeId"] = p_u_144,
            ["enabled"] = p_u_145.enabled == true
        }
        local v148 = p_u_145.cutTier
        local v149 = tonumber(v148) or 0
        local v150 = math.floor(v149)
        v147.cutTier = math.clamp(v150, 0, 4)
        v147.keepEvent = p_u_145.keepEvent ~= false
        v147.keepEvolveFuel = p_u_145.keepEvolveFuel ~= false
        return v146(v147)
    end
    local v152, v153 = pcall(v151)
    if v152 and v153 ~= nil then
        return v153.res
    end
    warn("[InventoryController] InventorySetAutoSellRule failed: " .. tostring(v153))
    return nil
end
function v1.SellBatch(_, p_u_154, p_u_155)
    -- upvalues: (copy) v_u_4
    if #p_u_155 == 0 then
        return nil, 0, 0
    end
    local function v157()
        -- upvalues: (ref) v_u_4, (copy) p_u_154, (copy) p_u_155
        local v156 = {
            ["itemType"] = p_u_154,
            ["keys"] = p_u_155
        }
        return v_u_4.InventorySellBatch.Call(v156)
    end
    local v158, v159 = pcall(v157)
    if v158 and v159 ~= nil then
        return v159.res, v159.sold, v159.amount
    end
    warn("[InventoryController] InventorySellBatch failed: " .. tostring(v159))
    return nil, 0, 0
end
return v1