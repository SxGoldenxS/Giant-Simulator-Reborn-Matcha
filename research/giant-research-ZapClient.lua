-- Decompiled game.ReplicatedStorage.ZapClient

local v1 = game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
if v1:IsServer() then
    error("Cannot use the client module on the server!")
end
if _G.__ZAP then
    if _G.__ZAP.ZAP then
        if _G.__ZAP.ZAP.ZAP ~= nil then
            error((("There is already an instance of Zap with the same remote_scope of ZAP, remote_folder of ZAP and the version of %*. Change the remote_scope or remote_folder option of both Zap instances"):format(_G.__ZAP.ZAP.ZAP)))
        end
    else
        _G.__ZAP.ZAP = {}
    end
else
    _G.__ZAP = {
        ["ZAP"] = {}
    }
end
_G.__ZAP.ZAP.ZAP = "0.6.28"
local v_u_3 = nil
local v_u_4 = nil
local v_u_5 = nil
local v_u_6 = nil
local v_u_7 = nil
local v_u_8 = nil
local v_u_9 = nil
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = nil
local _ = {
    CFrame.Angles(0, 0, 0),
    CFrame.Angles(1.5707963267948966, 0, 0),
    CFrame.Angles(0, 3.141592653589793, 3.141592653589793),
    CFrame.Angles(-1.5707963267948966, 0, 0),
    CFrame.Angles(0, 3.141592653589793, 1.5707963267948966),
    CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966),
    CFrame.Angles(0, 0, 1.5707963267948966),
    CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966),
    CFrame.Angles(-1.5707963267948966, -1.5707963267948966, 0),
    CFrame.Angles(0, -1.5707963267948966, 0),
    CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0),
    CFrame.Angles(0, 1.5707963267948966, 3.141592653589793),
    CFrame.Angles(0, -1.5707963267948966, 3.141592653589793),
    CFrame.Angles(0, 3.141592653589793, 0),
    CFrame.Angles(-1.5707963267948966, -3.141592653589793, 0),
    CFrame.Angles(0, 0, 3.141592653589793),
    CFrame.Angles(1.5707963267948966, 3.141592653589793, 0),
    CFrame.Angles(0, 0, -1.5707963267948966),
    CFrame.Angles(0, -1.5707963267948966, -1.5707963267948966),
    CFrame.Angles(0, -3.141592653589793, -1.5707963267948966),
    CFrame.Angles(0, 1.5707963267948966, -1.5707963267948966),
    CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0),
    CFrame.Angles(0, 1.5707963267948966, 0),
    CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)
}
local function v_u_16(p14)
    -- upvalues: (ref) v_u_4, (ref) v_u_5, (ref) v_u_3, (ref) v_u_7
    if v_u_5 < v_u_4 + p14 then
        while v_u_5 < v_u_4 + p14 do
            v_u_5 = v_u_5 * 2
        end
        local v15 = buffer.create(v_u_5)
        buffer.copy(v15, 0, v_u_3, 0, v_u_4)
        v_u_3 = v15
    end
    v_u_7 = v_u_4
    v_u_4 = v_u_4 + p14
    return v_u_7
end
local function v_u_17()
    -- upvalues: (ref) v_u_3, (ref) v_u_4, (ref) v_u_5, (ref) v_u_6, (ref) v_u_8, (ref) v_u_13
    v_u_3 = buffer.create(64)
    v_u_4 = 0
    v_u_5 = 64
    v_u_6 = {}
    v_u_8 = {}
    v_u_13 = {}
end
v_u_17()
local v18 = {}
local v19 = {}
if not v1:IsRunning() then
    local function v20() end
    local v21 = table.freeze
    local v22 = {
        ["SendEvents"] = v20,
        ["VotePoll"] = table.freeze({
            ["Call"] = v20
        }),
        ["UpdateNotesChanged"] = table.freeze({
            ["On"] = v20
        }),
        ["TrainClick"] = table.freeze({
            ["Fire"] = v20
        }),
        ["SwarmBite"] = table.freeze({
            ["On"] = v20
        }),
        ["ShowToast"] = table.freeze({
            ["On"] = v20
        }),
        ["SetWingsEquipped"] = table.freeze({
            ["Fire"] = v20
        }),
        ["SetMountRiding"] = table.freeze({
            ["Call"] = v20
        }),
        ["SetHideGainPopups"] = table.freeze({
            ["Fire"] = v20
        }),
        ["SetHideChestButton"] = table.freeze({
            ["Fire"] = v20
        }),
        ["SetAutoRebirth"] = table.freeze({
            ["Fire"] = v20
        }),
        ["SetAdminPrefs"] = table.freeze({
            ["Fire"] = v20
        }),
        ["RedeemCode"] = table.freeze({
            ["Call"] = v20
        }),
        ["QuestLineState"] = table.freeze({
            ["On"] = v20
        }),
        ["QuestLineRequest"] = table.freeze({
            ["Fire"] = v20
        }),
        ["PollsChanged"] = table.freeze({
            ["On"] = v20
        }),
        ["PlayerPitchToServer"] = table.freeze({
            ["Fire"] = v20
        }),
        ["PlayerPitchToClient"] = table.freeze({
            ["On"] = v20
        }),
        ["PetAttackPreview"] = table.freeze({
            ["On"] = v20
        }),
        ["OpenCrates"] = table.freeze({
            ["Call"] = v20
        }),
        ["OpenChests"] = table.freeze({
            ["Call"] = v20
        }),
        ["OfflineRewardPending"] = table.freeze({
            ["On"] = v20
        }),
        ["MarkNotesSeen"] = table.freeze({
            ["Fire"] = v20
        }),
        ["LocalMotionCmd"] = table.freeze({
            ["On"] = v20
        }),
        ["LoadTiming"] = table.freeze({
            ["Fire"] = v20
        }),
        ["LanternWeaponEarned"] = table.freeze({
            ["On"] = v20
        }),
        ["InventoryWeapons"] = table.freeze({
            ["On"] = v20
        }),
        ["InventoryUsePotion"] = table.freeze({
            ["Call"] = v20
        }),
        ["InventorySkins"] = table.freeze({
            ["On"] = v20
        }),
        ["InventorySetAutoSellRule"] = table.freeze({
            ["Call"] = v20
        }),
        ["InventorySellBatch"] = table.freeze({
            ["Call"] = v20
        }),
        ["InventoryPotions"] = table.freeze({
            ["On"] = v20
        }),
        ["InventoryPets"] = table.freeze({
            ["On"] = v20
        }),
        ["InventoryOp"] = table.freeze({
            ["Call"] = v20
        }),
        ["InventoryChests"] = table.freeze({
            ["On"] = v20
        }),
        ["InventoryAutoSell"] = table.freeze({
            ["On"] = v20
        }),
        ["InventoryArtifacts"] = table.freeze({
            ["On"] = v20
        }),
        ["HalloweenTeleport"] = table.freeze({
            ["Call"] = v20
        }),
        ["HalloweenShopBuy"] = table.freeze({
            ["Call"] = v20
        }),
        ["HalloweenDoorOpened"] = table.freeze({
            ["On"] = v20
        }),
        ["HalloweenArrived"] = table.freeze({
            ["On"] = v20
        }),
        ["GiantRollSpin"] = table.freeze({
            ["On"] = v20
        }),
        ["GhostHit"] = table.freeze({
            ["On"] = v20
        }),
        ["GetUpdateNotes"] = table.freeze({
            ["Call"] = v20
        }),
        ["GetPolls"] = table.freeze({
            ["Call"] = v20
        }),
        ["GetPollResults"] = table.freeze({
            ["Call"] = v20
        }),
        ["GetCodesInfo"] = table.freeze({
            ["Call"] = v20
        }),
        ["GetAdminPrefs"] = table.freeze({
            ["Call"] = v20
        }),
        ["GainPopup"] = table.freeze({
            ["On"] = v20
        }),
        ["FrostbitQuestState"] = table.freeze({
            ["On"] = v20
        }),
        ["FrostbitQuestRequest"] = table.freeze({
            ["Fire"] = v20
        }),
        ["FrostbitQuestClaim"] = table.freeze({
            ["Call"] = v20
        }),
        ["ForgeEnchant"] = table.freeze({
            ["Call"] = v20
        }),
        ["ForgeCraft"] = table.freeze({
            ["Call"] = v20
        }),
        ["FishingStop"] = table.freeze({
            ["Fire"] = v20
        }),
        ["FishingState"] = table.freeze({
            ["On"] = v20
        }),
        ["FishingStart"] = table.freeze({
            ["Fire"] = v20
        }),
        ["FishingSetKeepArtifact"] = table.freeze({
            ["Fire"] = v20
        }),
        ["FishingSetKeep"] = table.freeze({
            ["Fire"] = v20
        }),
        ["FishingSelectBait"] = table.freeze({
            ["Fire"] = v20
        }),
        ["FishingResult"] = table.freeze({
            ["On"] = v20
        }),
        ["FishingPhase"] = table.freeze({
            ["On"] = v20
        }),
        ["FishingNotice"] = table.freeze({
            ["On"] = v20
        }),
        ["FishingLineShow"] = table.freeze({
            ["On"] = v20
        }),
        ["FishingLineOut"] = table.freeze({
            ["Fire"] = v20
        }),
        ["FishingLineHide"] = table.freeze({
            ["On"] = v20
        }),
        ["FishingGoToArrived"] = table.freeze({
            ["On"] = v20
        }),
        ["FishingGoTo"] = table.freeze({
            ["Fire"] = v20
        }),
        ["FishingEquipRod"] = table.freeze({
            ["Fire"] = v20
        }),
        ["FishingBuyRod"] = table.freeze({
            ["Fire"] = v20
        }),
        ["FirstSessionStep"] = table.freeze({
            ["Fire"] = v20
        }),
        ["FireNpcDeath"] = table.freeze({
            ["On"] = v20
        }),
        ["FireNpcAttack"] = table.freeze({
            ["On"] = v20
        }),
        ["FireBossSummon"] = table.freeze({
            ["On"] = v20
        }),
        ["FireBossRewards"] = table.freeze({
            ["SetCallback"] = v20
        }),
        ["FireBossPhase"] = table.freeze({
            ["On"] = v20
        }),
        ["FireBossImpact"] = table.freeze({
            ["On"] = v20
        }),
        ["FireBossDespawn"] = table.freeze({
            ["On"] = v20
        }),
        ["FireBossCast"] = table.freeze({
            ["On"] = v20
        }),
        ["DirectCrateBuy"] = table.freeze({
            ["Call"] = v20
        }),
        ["CurrencyPackGranted"] = table.freeze({
            ["On"] = v20
        }),
        ["CurrencyPackBurst"] = table.freeze({
            ["On"] = v20
        }),
        ["CompanionClaim"] = table.freeze({
            ["Call"] = v20
        }),
        ["ClanOp"] = table.freeze({
            ["Call"] = v20
        }),
        ["ClanInfo"] = table.freeze({
            ["Call"] = v20
        }),
        ["ClanChatToClient"] = table.freeze({
            ["On"] = v20
        }),
        ["ClanChatSend"] = table.freeze({
            ["Fire"] = v20
        }),
        ["ClanBrowse"] = table.freeze({
            ["Call"] = v20
        }),
        ["ClaimOfflineReward"] = table.freeze({
            ["Call"] = v20
        }),
        ["BloodMoonPopupShow"] = table.freeze({
            ["SetCallback"] = v20
        }),
        ["BloodMoonPopupSeen"] = table.freeze({
            ["Fire"] = v20
        }),
        ["BloodMoonGiftTargets"] = table.freeze({
            ["Call"] = v20
        }),
        ["BloodMoonGiftReceived"] = table.freeze({
            ["SetCallback"] = v20
        }),
        ["BloodMoonGift"] = table.freeze({
            ["Call"] = v20
        }),
        ["BatHome"] = table.freeze({
            ["On"] = v20
        }),
        ["BatBite"] = table.freeze({
            ["On"] = v20
        }),
        ["ActiveBoostsUpdate"] = table.freeze({
            ["On"] = v20
        }),
        ["AcStaffNotice"] = table.freeze({
            ["On"] = v20
        }),
        ["AbilityUse"] = table.freeze({
            ["Fire"] = v20
        }),
        ["AbilityState"] = table.freeze({
            ["SetCallback"] = v20
        }),
        ["AbilityCast"] = table.freeze({
            ["On"] = v20
        })
    }
    return v21(v22)
end
local v23 = v2:WaitForChild("ZAP")
local v_u_24 = v23:WaitForChild("ZAP_RELIABLE")
local v25 = v_u_24:IsA("RemoteEvent")
assert(v25, "Expected ZAP_RELIABLE to be a RemoteEvent")
local v_u_26 = {
    v23:WaitForChild("ZAP_UNRELIABLE_0"),
    v23:WaitForChild("ZAP_UNRELIABLE_1"),
    v23:WaitForChild("ZAP_UNRELIABLE_2"),
    v23:WaitForChild("ZAP_UNRELIABLE_3"),
    v23:WaitForChild("ZAP_UNRELIABLE_4")
}
local v27 = v_u_26[1]:IsA("UnreliableRemoteEvent")
assert(v27, "Expected ZAP_UNRELIABLE_0 to be an UnreliableRemoteEvent")
local v28 = v_u_26[2]:IsA("UnreliableRemoteEvent")
assert(v28, "Expected ZAP_UNRELIABLE_1 to be an UnreliableRemoteEvent")
local v29 = v_u_26[3]:IsA("UnreliableRemoteEvent")
assert(v29, "Expected ZAP_UNRELIABLE_2 to be an UnreliableRemoteEvent")
local v30 = v_u_26[4]:IsA("UnreliableRemoteEvent")
assert(v30, "Expected ZAP_UNRELIABLE_3 to be an UnreliableRemoteEvent")
local v31 = v_u_26[5]:IsA("UnreliableRemoteEvent")
assert(v31, "Expected ZAP_UNRELIABLE_4 to be an UnreliableRemoteEvent")
local function v33()
    -- upvalues: (ref) v_u_4, (ref) v_u_3, (copy) v_u_24, (ref) v_u_6, (ref) v_u_5
    if v_u_4 ~= 0 then
        local v32 = buffer.create(v_u_4)
        buffer.copy(v32, 0, v_u_3, 0, v_u_4)
        v_u_24:FireServer(v32, v_u_6)
        v_u_3 = buffer.create(64)
        v_u_4 = 0
        v_u_5 = 64
        table.clear(v_u_6)
    end
end
v1.Heartbeat:Connect(v33)
local v_u_34 = table.create(71)
local v_u_35 = table.create(71)
local v_u_36 = table.create(5)
local v_u_37 = table.create(5)
local v_u_38 = 0
v_u_34[12] = {}
v_u_35[12] = {}
v_u_36[3] = {}
v_u_37[3] = {}
v_u_34[9] = {}
v_u_35[9] = {}
v_u_34[5] = {}
v_u_35[5] = {}
v_u_34[13] = {}
v_u_35[13] = {}
v_u_36[0] = {}
v_u_37[0] = {}
v_u_34[39] = {}
v_u_35[39] = {}
v_u_34[22] = {}
v_u_35[22] = {}
v_u_34[10] = {}
v_u_35[10] = {}
v_u_34[37] = {}
v_u_35[37] = {}
v_u_34[15] = {}
v_u_35[15] = {}
v_u_34[16] = {}
v_u_35[16] = {}
v_u_34[19] = {}
v_u_35[19] = {}
v_u_34[14] = {}
v_u_35[14] = {}
v_u_34[18] = {}
v_u_35[18] = {}
v_u_34[20] = {}
v_u_35[20] = {}
v_u_34[17] = {}
v_u_35[17] = {}
v_u_36[1] = {}
v_u_37[1] = {}
v_u_34[34] = {}
v_u_35[34] = {}
v_u_34[24] = {}
v_u_35[24] = {}
v_u_34[36] = {}
v_u_35[36] = {}
v_u_34[21] = {}
v_u_35[21] = {}
v_u_34[38] = {}
v_u_35[38] = {}
v_u_34[3] = {}
v_u_35[3] = {}
v_u_34[2] = {}
v_u_35[2] = {}
v_u_34[1] = {}
v_u_35[1] = {}
v_u_34[4] = {}
v_u_35[4] = {}
v_u_34[6] = {}
v_u_35[6] = {}
v_u_34[7] = {}
v_u_35[7] = {}
v_u_34[0] = {}
v_u_35[0] = {}
v_u_34[26] = {}
v_u_35[26] = {}
v_u_34[25] = {}
v_u_35[25] = {}
v_u_34[27] = {}
v_u_35[27] = {}
v_u_35[32] = {}
v_u_34[30] = {}
v_u_35[30] = {}
v_u_34[29] = {}
v_u_35[29] = {}
v_u_34[31] = {}
v_u_35[31] = {}
v_u_34[28] = {}
v_u_35[28] = {}
v_u_34[43] = {}
v_u_35[43] = {}
v_u_36[4] = {}
v_u_37[4] = {}
v_u_34[23] = {}
v_u_35[23] = {}
v_u_35[35] = 0
v_u_35[33] = {}
v_u_34[40] = {}
v_u_35[40] = {}
v_u_36[2] = {}
v_u_37[2] = {}
v_u_34[8] = {}
v_u_35[8] = {}
v_u_34[11] = {}
v_u_35[11] = {}
v_u_35[41] = {}
v_u_34[42] = {}
v_u_35[42] = {}
v_u_35[52] = table.create(255)
v_u_35[70] = table.create(255)
v_u_35[47] = table.create(255)
v_u_35[45] = table.create(255)
v_u_35[44] = table.create(255)
v_u_35[56] = table.create(255)
v_u_35[54] = table.create(255)
v_u_35[55] = table.create(255)
v_u_35[53] = table.create(255)
v_u_35[68] = table.create(255)
v_u_35[64] = table.create(255)
v_u_35[49] = table.create(255)
v_u_35[50] = table.create(255)
v_u_35[51] = table.create(255)
v_u_35[48] = table.create(255)
v_u_35[60] = table.create(255)
v_u_35[69] = table.create(255)
v_u_35[58] = table.create(255)
v_u_35[57] = table.create(255)
v_u_35[46] = table.create(255)
v_u_35[67] = table.create(255)
v_u_35[61] = table.create(255)
v_u_35[62] = table.create(255)
v_u_35[63] = table.create(255)
v_u_35[59] = table.create(255)
v_u_35[66] = table.create(255)
v_u_35[65] = table.create(255)
v_u_24.OnClientEvent:Connect(function(p39, p40)
    -- upvalues: (ref) v_u_9, (ref) v_u_11, (ref) v_u_10, (ref) v_u_12, (copy) v_u_34, (copy) v_u_35
    v_u_9 = p39
    v_u_11 = p40
    v_u_10 = 0
    v_u_12 = 0
    local v41 = buffer.len(p39)
    while v_u_10 < v41 do
        local v42 = v_u_10
        v_u_10 = v_u_10 + 1
        local v43 = buffer.readu8(p39, v42)
        if v43 == 12 then
            local v44 = v_u_9
            local v45 = v_u_10
            v_u_10 = v_u_10 + 4
            local v46 = buffer.readu32(v44, v45)
            if v_u_34[12][1] then
                for _, v47 in v_u_34[12] do
                    task.spawn(v47, v46)
                end
            else
                local v48 = v_u_35[12]
                table.insert(v48, v46)
                if #v_u_35[12] > 64 then
                    warn((("[ZAP] %* events in queue for UpdateNotesChanged. Did you forget to attach a listener?"):format(#v_u_35[12])))
                end
            end
        elseif v43 == 9 then
            local v49 = v_u_9
            local v50 = v_u_10
            v_u_10 = v_u_10 + 1
            local v51 = buffer.readu8(v49, v50)
            local v52 = {}
            local v53 = v_u_9
            local v54 = v_u_10
            v_u_10 = v_u_10 + 2
            local v55 = buffer.readu16(v53, v54) + 1
            local v56 = v55 >= 1
            assert(v56, "value is less than 1!")
            local v57 = v55 <= 400
            assert(v57, "value is more than 400!")
            local v58 = buffer.readstring
            local v59 = v_u_9
            local v60 = v_u_10
            v_u_10 = v_u_10 + v55
            v52.title = v58(v59, v60, v55)
            local v61 = utf8.len(v52.title) ~= nil
            assert(v61, "value is not valid utf-8")
            local v62 = v_u_9
            local v63 = v_u_10
            v_u_10 = v_u_10 + 2
            local v64 = buffer.readu16(v62, v63)
            local v65 = v64 >= 0
            assert(v65, "value is less than 0!")
            local v66 = v64 <= 800
            assert(v66, "value is more than 800!")
            local v67 = buffer.readstring
            local v68 = v_u_9
            local v69 = v_u_10
            v_u_10 = v_u_10 + v64
            v52.message = v67(v68, v69, v64)
            local v70 = utf8.len(v52.message) ~= nil
            assert(v70, "value is not valid utf-8")
            if bit32.btest(v51, 1) then
                local v71 = v_u_9
                local v72 = v_u_10
                v_u_10 = v_u_10 + 1
                local v73 = buffer.readu8(v71, v72) + 1
                local v74 = v73 >= 1
                assert(v74, "value is less than 1!")
                local v75 = v73 <= 64
                assert(v75, "value is more than 64!")
                local v76 = buffer.readstring
                local v77 = v_u_9
                local v78 = v_u_10
                v_u_10 = v_u_10 + v73
                v52.emoji = v76(v77, v78, v73)
                local v79 = utf8.len(v52.emoji) ~= nil
                assert(v79, "value is not valid utf-8")
            else
                v52.emoji = nil
            end
            if bit32.btest(v51, 2) then
                local v80 = v_u_9
                local v81 = v_u_10
                v_u_10 = v_u_10 + 2
                local v82 = buffer.readu16(v80, v81) + 1
                local v83 = v82 >= 1
                assert(v83, "value is less than 1!")
                local v84 = v82 <= 400
                assert(v84, "value is more than 400!")
                local v85 = buffer.readstring
                local v86 = v_u_9
                local v87 = v_u_10
                v_u_10 = v_u_10 + v82
                v52.image = v85(v86, v87, v82)
                local v88 = utf8.len(v52.image) ~= nil
                assert(v88, "value is not valid utf-8")
            else
                v52.image = nil
            end
            if bit32.btest(v51, 4) then
                local v89 = v_u_9
                local v90 = v_u_10
                v_u_10 = v_u_10 + 4
                v52.duration = buffer.readf32(v89, v90)
            else
                v52.duration = nil
            end
            if bit32.btest(v51, 8) then
                if bit32.btest(v51, 16) then
                    v52.sound = "chime"
                elseif bit32.btest(v51, 32) then
                    v52.sound = "error"
                elseif bit32.btest(v51, 64) then
                    v52.sound = "silent"
                end
            else
                v52.sound = nil
            end
            if v_u_34[9][1] then
                for _, v91 in v_u_34[9] do
                    task.spawn(v91, v52)
                end
            else
                local v92 = v_u_35[9]
                table.insert(v92, v52)
                if #v_u_35[9] > 64 then
                    warn((("[ZAP] %* events in queue for ShowToast. Did you forget to attach a listener?"):format(#v_u_35[9])))
                end
            end
        elseif v43 == 5 then
            local v93 = {}
            local v94 = v_u_9
            local v95 = v_u_10
            v_u_10 = v_u_10 + 1
            v93.stage = buffer.readu8(v94, v95)
            local v96 = v_u_9
            local v97 = v_u_10
            v_u_10 = v_u_10 + 2
            local v98 = buffer.readu16(v96, v97)
            v93.progress = table.create(v98)
            for v99 = 1, v98 do
                local v100 = v_u_9
                local v101 = v_u_10
                v_u_10 = v_u_10 + 4
                local v102 = buffer.readu32(v100, v101)
                v93.progress[v99] = v102
            end
            if v_u_34[5][1] then
                for _, v103 in v_u_34[5] do
                    task.spawn(v103, v93)
                end
            else
                local v104 = v_u_35[5]
                table.insert(v104, v93)
                if #v_u_35[5] > 64 then
                    warn((("[ZAP] %* events in queue for QuestLineState. Did you forget to attach a listener?"):format(#v_u_35[5])))
                end
            end
        elseif v43 == 13 then
            local v105 = {}
            local v106 = v_u_9
            local v107 = v_u_10
            v_u_10 = v_u_10 + 4
            v105.version = buffer.readu32(v106, v107)
            local v108 = v_u_9
            local v109 = v_u_10
            v_u_10 = v_u_10 + 1
            v105.count = buffer.readu8(v108, v109)
            if v_u_34[13][1] then
                for _, v110 in v_u_34[13] do
                    task.spawn(v110, v105)
                end
            else
                local v111 = v_u_35[13]
                table.insert(v111, v105)
                if #v_u_35[13] > 64 then
                    warn((("[ZAP] %* events in queue for PollsChanged. Did you forget to attach a listener?"):format(#v_u_35[13])))
                end
            end
        elseif v43 == 39 then
            local v112 = {}
            v_u_12 = v_u_12 + 1
            v112.player = v_u_11[v_u_12]
            local v113 = v112.player ~= nil
            assert(v113, "received instance is nil!")
            local v114 = v112.player:IsA("Player")
            assert(v114, "received instance is not of the Player class!")
            local v115 = v_u_9
            local v116 = v_u_10
            v_u_10 = v_u_10 + 4
            local v117 = buffer.readf32(v115, v116)
            local v118 = v_u_9
            local v119 = v_u_10
            v_u_10 = v_u_10 + 4
            local v120 = buffer.readf32(v118, v119)
            local v121 = v_u_9
            local v122 = v_u_10
            v_u_10 = v_u_10 + 4
            local v123 = buffer.readf32(v121, v122)
            v112.target = Vector3.new(v117, v120, v123)
            if v_u_34[39][1] then
                for _, v124 in v_u_34[39] do
                    task.spawn(v124, v112)
                end
            else
                local v125 = v_u_35[39]
                table.insert(v125, v112)
                if #v_u_35[39] > 64 then
                    warn((("[ZAP] %* events in queue for PetAttackPreview. Did you forget to attach a listener?"):format(#v_u_35[39])))
                end
            end
        elseif v43 == 22 then
            local v126 = {}
            local v127 = v_u_9
            local v128 = v_u_10
            v_u_10 = v_u_10 + 4
            v126.secondsAway = buffer.readu32(v127, v128)
            local v129 = v_u_9
            local v130 = v_u_10
            v_u_10 = v_u_10 + 8
            v126.levelsGained = buffer.readf64(v129, v130)
            local v131 = v_u_9
            local v132 = v_u_10
            v_u_10 = v_u_10 + 1
            local v133 = buffer.readu8(v131, v132) + 1
            local v134 = v133 >= 1
            assert(v134, "value is less than 1!")
            local v135 = v133 <= 96
            assert(v135, "value is more than 96!")
            local v136 = buffer.readstring
            local v137 = v_u_9
            local v138 = v_u_10
            v_u_10 = v_u_10 + v133
            v126.xp = v136(v137, v138, v133)
            local v139 = utf8.len(v126.xp) ~= nil
            assert(v139, "value is not valid utf-8")
            local v140 = v_u_9
            local v141 = v_u_10
            v_u_10 = v_u_10 + 1
            local v142 = buffer.readu8(v140, v141) + 1
            local v143 = v142 >= 1
            assert(v143, "value is less than 1!")
            local v144 = v142 <= 96
            assert(v144, "value is more than 96!")
            local v145 = buffer.readstring
            local v146 = v_u_9
            local v147 = v_u_10
            v_u_10 = v_u_10 + v142
            v126.gold = v145(v146, v147, v142)
            local v148 = utf8.len(v126.gold) ~= nil
            assert(v148, "value is not valid utf-8")
            if v_u_34[22][1] then
                for _, v149 in v_u_34[22] do
                    task.spawn(v149, v126)
                end
            else
                local v150 = v_u_35[22]
                table.insert(v150, v126)
                if #v_u_35[22] > 64 then
                    warn((("[ZAP] %* events in queue for OfflineRewardPending. Did you forget to attach a listener?"):format(#v_u_35[22])))
                end
            end
        elseif v43 == 10 then
            local v151 = v_u_9
            local v152 = v_u_10
            v_u_10 = v_u_10 + 1
            local v153 = buffer.readu8(v151, v152)
            local v154 = {}
            if bit32.btest(v153, 1) then
                v154.mode = "fly"
            elseif bit32.btest(v153, 2) then
                v154.mode = "hover"
            elseif bit32.btest(v153, 4) then
                v154.mode = "teleport"
            elseif bit32.btest(v153, 8) then
                v154.mode = "orbwarp"
            elseif bit32.btest(v153, 16) then
                v154.mode = "anchor"
            elseif bit32.btest(v153, 32) then
                v154.mode = "speed"
            elseif bit32.btest(v153, 64) then
                v154.mode = "combattp"
            elseif bit32.btest(v153, 128) then
                v154.mode = "off"
            end
            local v155 = v_u_9
            local v156 = v_u_10
            v_u_10 = v_u_10 + 8
            v154.value = buffer.readf64(v155, v156)
            if v_u_34[10][1] then
                for _, v157 in v_u_34[10] do
                    task.spawn(v157, v154)
                end
            else
                local v158 = v_u_35[10]
                table.insert(v158, v154)
                if #v_u_35[10] > 64 then
                    warn((("[ZAP] %* events in queue for LocalMotionCmd. Did you forget to attach a listener?"):format(#v_u_35[10])))
                end
            end
        elseif v43 == 37 then
            local v159 = v_u_9
            local v160 = v_u_10
            v_u_10 = v_u_10 + 1
            local v161 = buffer.readu8(v159, v160)
            local v162 = {}
            if bit32.btest(v161, 1) then
                v162.weapon = "hatchet"
            else
                v162.weapon = "maul"
            end
            v162.early = bit32.btest(v161, 2)
            local v163 = v_u_9
            local v164 = v_u_10
            v_u_10 = v_u_10 + 1
            local v165 = buffer.readu8(v163, v164)
            local v166 = v165 >= 0
            assert(v166, "value is less than 0!")
            local v167 = v165 <= 64
            assert(v167, "value is more than 64!")
            local v168 = buffer.readstring
            local v169 = v_u_9
            local v170 = v_u_10
            v_u_10 = v_u_10 + v165
            v162.key = v168(v169, v170, v165)
            local v171 = utf8.len(v162.key) ~= nil
            assert(v171, "value is not valid utf-8")
            if v_u_34[37][1] then
                for _, v172 in v_u_34[37] do
                    task.spawn(v172, v162)
                end
            else
                local v173 = v_u_35[37]
                table.insert(v173, v162)
                if #v_u_35[37] > 64 then
                    warn((("[ZAP] %* events in queue for LanternWeaponEarned. Did you forget to attach a listener?"):format(#v_u_35[37])))
                end
            end
        elseif v43 == 15 then
            local v174 = v_u_9
            local v175 = v_u_10
            v_u_10 = v_u_10 + 1
            local v176 = buffer.readu8(v174, v175)
            local v177 = {}
            local v178 = v_u_9
            local v179 = v_u_10
            v_u_10 = v_u_10 + 1
            local v180 = buffer.readu8(v178, v179)
            local v181 = v180 >= 0
            assert(v181, "value is less than 0!")
            local v182 = v180 <= 64
            assert(v182, "value is more than 64!")
            local v183 = buffer.readstring
            local v184 = v_u_9
            local v185 = v_u_10
            v_u_10 = v_u_10 + v180
            v177.equippedKey = v183(v184, v185, v180)
            local v186 = utf8.len(v177.equippedKey) ~= nil
            assert(v186, "value is not valid utf-8")
            local v187 = v_u_9
            local v188 = v_u_10
            v_u_10 = v_u_10 + 1
            local v189 = buffer.readu8(v187, v188)
            local v190 = v189 >= 0
            assert(v190, "value is less than 0!")
            local v191 = v189 <= 64
            assert(v191, "value is more than 64!")
            local v192 = buffer.readstring
            local v193 = v_u_9
            local v194 = v_u_10
            v_u_10 = v_u_10 + v189
            v177.offhandKey = v192(v193, v194, v189)
            local v195 = utf8.len(v177.offhandKey) ~= nil
            assert(v195, "value is not valid utf-8")
            v177.dualSkill = bit32.btest(v176, 1)
            local v196 = v_u_9
            local v197 = v_u_10
            v_u_10 = v_u_10 + 2
            local v198 = buffer.readu16(v196, v197)
            local v199 = v198 >= 0
            assert(v199, "value is less than 0!")
            local v200 = v198 <= 500
            assert(v200, "value is more than 500!")
            v177.items = table.create(v198)
            for v201 = 1, v198 do
                local v202 = {}
                local v203 = v_u_9
                local v204 = v_u_10
                v_u_10 = v_u_10 + 1
                local v205 = buffer.readu8(v203, v204) + 1
                local v206 = v205 >= 1
                assert(v206, "value is less than 1!")
                local v207 = v205 <= 64
                assert(v207, "value is more than 64!")
                local v208 = buffer.readstring
                local v209 = v_u_9
                local v210 = v_u_10
                v_u_10 = v_u_10 + v205
                v202.key = v208(v209, v210, v205)
                local v211 = utf8.len(v202.key) ~= nil
                assert(v211, "value is not valid utf-8")
                local v212 = v_u_9
                local v213 = v_u_10
                v_u_10 = v_u_10 + 2
                v202.id = buffer.readu16(v212, v213)
                local v214 = v_u_9
                local v215 = v_u_10
                v_u_10 = v_u_10 + 8
                v202.level = buffer.readf64(v214, v215)
                local v216 = v_u_9
                local v217 = v_u_10
                v_u_10 = v_u_10 + 8
                v202.upgrades = buffer.readf64(v216, v217)
                local v218 = v_u_9
                local v219 = v_u_10
                v_u_10 = v_u_10 + 1
                v202.ench = buffer.readu8(v218, v219)
                local v220 = v_u_9
                local v221 = v_u_10
                v_u_10 = v_u_10 + 1
                v202.enchTier = buffer.readu8(v220, v221)
                v177.items[v201] = v202
            end
            if v_u_34[15][1] then
                for _, v222 in v_u_34[15] do
                    task.spawn(v222, v177)
                end
            else
                local v223 = v_u_35[15]
                table.insert(v223, v177)
                if #v_u_35[15] > 64 then
                    warn((("[ZAP] %* events in queue for InventoryWeapons. Did you forget to attach a listener?"):format(#v_u_35[15])))
                end
            end
        elseif v43 == 16 then
            local v224 = {}
            local v225 = v_u_9
            local v226 = v_u_10
            v_u_10 = v_u_10 + 1
            local v227 = buffer.readu8(v225, v226)
            local v228 = v227 >= 0
            assert(v228, "value is less than 0!")
            local v229 = v227 <= 64
            assert(v229, "value is more than 64!")
            local v230 = buffer.readstring
            local v231 = v_u_9
            local v232 = v_u_10
            v_u_10 = v_u_10 + v227
            v224.equippedKey = v230(v231, v232, v227)
            local v233 = utf8.len(v224.equippedKey) ~= nil
            assert(v233, "value is not valid utf-8")
            local v234 = v_u_9
            local v235 = v_u_10
            v_u_10 = v_u_10 + 2
            local v236 = buffer.readu16(v234, v235)
            local v237 = v236 >= 0
            assert(v237, "value is less than 0!")
            local v238 = v236 <= 500
            assert(v238, "value is more than 500!")
            v224.items = table.create(v236)
            for v239 = 1, v236 do
                local v240 = {}
                local v241 = v_u_9
                local v242 = v_u_10
                v_u_10 = v_u_10 + 1
                local v243 = buffer.readu8(v241, v242) + 1
                local v244 = v243 >= 1
                assert(v244, "value is less than 1!")
                local v245 = v243 <= 64
                assert(v245, "value is more than 64!")
                local v246 = buffer.readstring
                local v247 = v_u_9
                local v248 = v_u_10
                v_u_10 = v_u_10 + v243
                v240.key = v246(v247, v248, v243)
                local v249 = utf8.len(v240.key) ~= nil
                assert(v249, "value is not valid utf-8")
                local v250 = v_u_9
                local v251 = v_u_10
                v_u_10 = v_u_10 + 2
                v240.id = buffer.readu16(v250, v251)
                local v252 = v_u_9
                local v253 = v_u_10
                v_u_10 = v_u_10 + 8
                v240.level = buffer.readf64(v252, v253)
                local v254 = v_u_9
                local v255 = v_u_10
                v_u_10 = v_u_10 + 8
                v240.upgrades = buffer.readf64(v254, v255)
                local v256 = v_u_9
                local v257 = v_u_10
                v_u_10 = v_u_10 + 1
                v240.ench = buffer.readu8(v256, v257)
                local v258 = v_u_9
                local v259 = v_u_10
                v_u_10 = v_u_10 + 1
                v240.enchTier = buffer.readu8(v258, v259)
                v224.items[v239] = v240
            end
            if v_u_34[16][1] then
                for _, v260 in v_u_34[16] do
                    task.spawn(v260, v224)
                end
            else
                local v261 = v_u_35[16]
                table.insert(v261, v224)
                if #v_u_35[16] > 64 then
                    warn((("[ZAP] %* events in queue for InventorySkins. Did you forget to attach a listener?"):format(#v_u_35[16])))
                end
            end
        elseif v43 == 19 then
            local v262 = v_u_9
            local v263 = v_u_10
            v_u_10 = v_u_10 + 1
            local v264 = buffer.readu8(v262, v263)
            local v265 = {
                ["counts"] = {}
            }
            if not bit32.btest(v264, 1) then
                local v266 = v_u_9
                local v267 = v_u_10
                v_u_10 = v_u_10 + 2
                for _ = 1, buffer.readu16(v266, v267) + 1 do
                    local v268 = v_u_9
                    local v269 = v_u_10
                    v_u_10 = v_u_10 + 1
                    local v270 = buffer.readu8(v268, v269) + 1
                    local v271 = v270 >= 1
                    assert(v271, "value is less than 1!")
                    local v272 = v270 <= 80
                    assert(v272, "value is more than 80!")
                    local v273 = buffer.readstring
                    local v274 = v_u_9
                    local v275 = v_u_10
                    v_u_10 = v_u_10 + v270
                    local v276 = v273(v274, v275, v270)
                    local v277 = utf8.len(v276) ~= nil
                    assert(v277, "value is not valid utf-8")
                    local v278 = v_u_9
                    local v279 = v_u_10
                    v_u_10 = v_u_10 + 4
                    local v280 = buffer.readu32(v278, v279)
                    v265.counts[v276] = v280
                end
            end
            if v_u_34[19][1] then
                for _, v281 in v_u_34[19] do
                    task.spawn(v281, v265)
                end
            else
                local v282 = v_u_35[19]
                table.insert(v282, v265)
                if #v_u_35[19] > 64 then
                    warn((("[ZAP] %* events in queue for InventoryPotions. Did you forget to attach a listener?"):format(#v_u_35[19])))
                end
            end
        elseif v43 == 14 then
            local v283 = {}
            local v284 = v_u_9
            local v285 = v_u_10
            v_u_10 = v_u_10 + 1
            v283.maxEquipped = buffer.readu8(v284, v285)
            local v286 = v_u_9
            local v287 = v_u_10
            v_u_10 = v_u_10 + 1
            v283.passSlots = buffer.readu8(v286, v287)
            local v288 = v_u_9
            local v289 = v_u_10
            v_u_10 = v_u_10 + 2
            local v290 = buffer.readu16(v288, v289)
            local v291 = v290 >= 0
            assert(v291, "value is less than 0!")
            local v292 = v290 <= 500
            assert(v292, "value is more than 500!")
            v283.items = table.create(v290)
            for v293 = 1, v290 do
                local v294 = v_u_9
                local v295 = v_u_10
                v_u_10 = v_u_10 + 1
                local v296 = buffer.readu8(v294, v295)
                local v297 = {}
                local v298 = v_u_9
                local v299 = v_u_10
                v_u_10 = v_u_10 + 1
                local v300 = buffer.readu8(v298, v299) + 1
                local v301 = v300 >= 1
                assert(v301, "value is less than 1!")
                local v302 = v300 <= 64
                assert(v302, "value is more than 64!")
                local v303 = buffer.readstring
                local v304 = v_u_9
                local v305 = v_u_10
                v_u_10 = v_u_10 + v300
                v297.key = v303(v304, v305, v300)
                local v306 = utf8.len(v297.key) ~= nil
                assert(v306, "value is not valid utf-8")
                local v307 = v_u_9
                local v308 = v_u_10
                v_u_10 = v_u_10 + 2
                v297.id = buffer.readu16(v307, v308)
                local v309 = v_u_9
                local v310 = v_u_10
                v_u_10 = v_u_10 + 8
                v297.level = buffer.readf64(v309, v310)
                local v311 = v_u_9
                local v312 = v_u_10
                v_u_10 = v_u_10 + 8
                v297.xp = buffer.readf64(v311, v312)
                local v313 = v_u_9
                local v314 = v_u_10
                v_u_10 = v_u_10 + 1
                v297.evo = buffer.readu8(v313, v314)
                v297.equipped = bit32.btest(v296, 1)
                v297.locked = bit32.btest(v296, 2)
                v283.items[v293] = v297
            end
            if v_u_34[14][1] then
                for _, v315 in v_u_34[14] do
                    task.spawn(v315, v283)
                end
            else
                local v316 = v_u_35[14]
                table.insert(v316, v283)
                if #v_u_35[14] > 64 then
                    warn((("[ZAP] %* events in queue for InventoryPets. Did you forget to attach a listener?"):format(#v_u_35[14])))
                end
            end
        elseif v43 == 18 then
            local v317 = v_u_9
            local v318 = v_u_10
            v_u_10 = v_u_10 + 1
            local v319 = buffer.readu8(v317, v318)
            local v320 = {
                ["counts"] = {}
            }
            if not bit32.btest(v319, 1) then
                local v321 = v_u_9
                local v322 = v_u_10
                v_u_10 = v_u_10 + 2
                for _ = 1, buffer.readu16(v321, v322) + 1 do
                    local v323 = v_u_9
                    local v324 = v_u_10
                    v_u_10 = v_u_10 + 1
                    local v325 = buffer.readu8(v323, v324) + 1
                    local v326 = v325 >= 1
                    assert(v326, "value is less than 1!")
                    local v327 = v325 <= 80
                    assert(v327, "value is more than 80!")
                    local v328 = buffer.readstring
                    local v329 = v_u_9
                    local v330 = v_u_10
                    v_u_10 = v_u_10 + v325
                    local v331 = v328(v329, v330, v325)
                    local v332 = utf8.len(v331) ~= nil
                    assert(v332, "value is not valid utf-8")
                    local v333 = v_u_9
                    local v334 = v_u_10
                    v_u_10 = v_u_10 + 8
                    local v335 = buffer.readf64(v333, v334)
                    v320.counts[v331] = v335
                end
            end
            if v_u_34[18][1] then
                for _, v336 in v_u_34[18] do
                    task.spawn(v336, v320)
                end
            else
                local v337 = v_u_35[18]
                table.insert(v337, v320)
                if #v_u_35[18] > 64 then
                    warn((("[ZAP] %* events in queue for InventoryChests. Did you forget to attach a listener?"):format(#v_u_35[18])))
                end
            end
        elseif v43 == 20 then
            local v338 = {}
            local v339 = v_u_9
            local v340 = v_u_10
            v_u_10 = v_u_10 + 1
            local v341 = buffer.readu8(v339, v340)
            local v342 = v341 >= 0
            assert(v342, "value is less than 0!")
            local v343 = v341 <= 4
            assert(v343, "value is more than 4!")
            v338.rules = table.create(v341)
            for v344 = 1, v341 do
                local v345 = v_u_9
                local v346 = v_u_10
                v_u_10 = v_u_10 + 1
                local v347 = buffer.readu8(v345, v346)
                local v348 = {}
                if bit32.btest(v347, 1) then
                    v348.typeId = "weapons"
                elseif bit32.btest(v347, 2) then
                    v348.typeId = "skins"
                elseif bit32.btest(v347, 4) then
                    v348.typeId = "pets"
                elseif bit32.btest(v347, 8) then
                    v348.typeId = "artifacts"
                end
                v348.enabled = bit32.btest(v347, 16)
                local v349 = v_u_9
                local v350 = v_u_10
                v_u_10 = v_u_10 + 1
                v348.cutTier = buffer.readu8(v349, v350)
                v348.keepEvent = bit32.btest(v347, 32)
                v348.keepEvolveFuel = bit32.btest(v347, 64)
                v338.rules[v344] = v348
            end
            if v_u_34[20][1] then
                for _, v351 in v_u_34[20] do
                    task.spawn(v351, v338)
                end
            else
                local v352 = v_u_35[20]
                table.insert(v352, v338)
                if #v_u_35[20] > 64 then
                    warn((("[ZAP] %* events in queue for InventoryAutoSell. Did you forget to attach a listener?"):format(#v_u_35[20])))
                end
            end
        elseif v43 == 17 then
            local v353 = {}
            local v354 = v_u_9
            local v355 = v_u_10
            v_u_10 = v_u_10 + 1
            v353.maxEquipped = buffer.readu8(v354, v355)
            local v356 = v_u_9
            local v357 = v_u_10
            v_u_10 = v_u_10 + 1
            v353.passSlots = buffer.readu8(v356, v357)
            local v358 = v_u_9
            local v359 = v_u_10
            v_u_10 = v_u_10 + 2
            local v360 = buffer.readu16(v358, v359)
            local v361 = v360 >= 0
            assert(v361, "value is less than 0!")
            local v362 = v360 <= 500
            assert(v362, "value is more than 500!")
            v353.items = table.create(v360)
            for v363 = 1, v360 do
                local v364 = v_u_9
                local v365 = v_u_10
                v_u_10 = v_u_10 + 1
                local v366 = buffer.readu8(v364, v365)
                local v367 = {}
                local v368 = v_u_9
                local v369 = v_u_10
                v_u_10 = v_u_10 + 1
                local v370 = buffer.readu8(v368, v369) + 1
                local v371 = v370 >= 1
                assert(v371, "value is less than 1!")
                local v372 = v370 <= 64
                assert(v372, "value is more than 64!")
                local v373 = buffer.readstring
                local v374 = v_u_9
                local v375 = v_u_10
                v_u_10 = v_u_10 + v370
                v367.key = v373(v374, v375, v370)
                local v376 = utf8.len(v367.key) ~= nil
                assert(v376, "value is not valid utf-8")
                local v377 = v_u_9
                local v378 = v_u_10
                v_u_10 = v_u_10 + 2
                v367.id = buffer.readu16(v377, v378)
                local v379 = v_u_9
                local v380 = v_u_10
                v_u_10 = v_u_10 + 1
                v367.evo = buffer.readu8(v379, v380)
                v367.equipped = bit32.btest(v366, 1)
                v367.locked = bit32.btest(v366, 2)
                v353.items[v363] = v367
            end
            if v_u_34[17][1] then
                for _, v381 in v_u_34[17] do
                    task.spawn(v381, v353)
                end
            else
                local v382 = v_u_35[17]
                table.insert(v382, v353)
                if #v_u_35[17] > 64 then
                    warn((("[ZAP] %* events in queue for InventoryArtifacts. Did you forget to attach a listener?"):format(#v_u_35[17])))
                end
            end
        elseif v43 == 34 then
            local v383 = v_u_9
            local v384 = v_u_10
            v_u_10 = v_u_10 + 4
            local v385 = buffer.readf32(v383, v384)
            local v386 = v_u_9
            local v387 = v_u_10
            v_u_10 = v_u_10 + 4
            local v388 = buffer.readf32(v386, v387)
            local v389 = v_u_9
            local v390 = v_u_10
            v_u_10 = v_u_10 + 4
            local v391 = buffer.readf32(v389, v390)
            local v392 = Vector3.new(v385, v388, v391)
            if v_u_34[34][1] then
                for _, v393 in v_u_34[34] do
                    task.spawn(v393, v392)
                end
            else
                local v394 = v_u_35[34]
                table.insert(v394, v392)
                if #v_u_35[34] > 64 then
                    warn((("[ZAP] %* events in queue for HalloweenArrived. Did you forget to attach a listener?"):format(#v_u_35[34])))
                end
            end
        elseif v43 == 24 then
            local v395 = v_u_9
            local v396 = v_u_10
            v_u_10 = v_u_10 + 1
            local v397 = buffer.readu8(v395, v396)
            local v398 = {}
            local v399 = v_u_9
            local v400 = v_u_10
            v_u_10 = v_u_10 + 1
            local v401 = buffer.readu8(v399, v400) + 1
            local v402 = v401 >= 1
            assert(v402, "value is less than 1!")
            local v403 = v401 <= 96
            assert(v403, "value is more than 96!")
            local v404 = buffer.readstring
            local v405 = v_u_9
            local v406 = v_u_10
            v_u_10 = v_u_10 + v401
            v398.race = v404(v405, v406, v401)
            local v407 = utf8.len(v398.race) ~= nil
            assert(v407, "value is not valid utf-8")
            local v408 = v_u_9
            local v409 = v_u_10
            v_u_10 = v_u_10 + 4
            v398.duration = buffer.readf32(v408, v409)
            v398.unlocked = bit32.btest(v397, 1)
            local v410 = v_u_9
            local v411 = v_u_10
            v_u_10 = v_u_10 + 4
            v398.refund = buffer.readu32(v410, v411)
            if v_u_34[24][1] then
                for _, v412 in v_u_34[24] do
                    task.spawn(v412, v398)
                end
            else
                local v413 = v_u_35[24]
                table.insert(v413, v398)
                if #v_u_35[24] > 64 then
                    warn((("[ZAP] %* events in queue for GiantRollSpin. Did you forget to attach a listener?"):format(#v_u_35[24])))
                end
            end
        elseif v43 == 36 then
            local v414 = v_u_9
            local v415 = v_u_10
            v_u_10 = v_u_10 + 1
            local v416 = buffer.readu8(v414, v415)
            local v417 = {}
            local v418 = v_u_9
            local v419 = v_u_10
            v_u_10 = v_u_10 + 1
            v417.ghost = buffer.readu8(v418, v419)
            local v420 = v_u_9
            local v421 = v_u_10
            v_u_10 = v_u_10 + 1
            v417.hits = buffer.readu8(v420, v421)
            v417.popped = bit32.btest(v416, 1)
            local v422 = v_u_9
            local v423 = v_u_10
            v_u_10 = v_u_10 + 1
            v417.souls = buffer.readu8(v422, v423)
            local v424 = v_u_9
            local v425 = v_u_10
            v_u_10 = v_u_10 + 1
            v417.bonus = buffer.readu8(v424, v425)
            local v426 = v_u_9
            local v427 = v_u_10
            v_u_10 = v_u_10 + 2
            v417.pumpkins = buffer.readu16(v426, v427)
            if v_u_34[36][1] then
                for _, v428 in v_u_34[36] do
                    task.spawn(v428, v417)
                end
            else
                local v429 = v_u_35[36]
                table.insert(v429, v417)
                if #v_u_35[36] > 64 then
                    warn((("[ZAP] %* events in queue for GhostHit. Did you forget to attach a listener?"):format(#v_u_35[36])))
                end
            end
        elseif v43 == 21 then
            local v430 = v_u_9
            local v431 = v_u_10
            v_u_10 = v_u_10 + 1
            local v432 = buffer.readu8(v430, v431)
            local v433 = {}
            if bit32.btest(v432, 1) then
                v433.kind = "gold"
            elseif bit32.btest(v432, 2) then
                v433.kind = "xp"
            elseif bit32.btest(v432, 4) then
                v433.kind = "tokens"
            elseif bit32.btest(v432, 8) then
                v433.kind = "speed"
            elseif bit32.btest(v432, 16) then
                v433.kind = "embers"
            elseif bit32.btest(v432, 32) then
                v433.kind = "pumpkins"
            end
            local v434 = v_u_9
            local v435 = v_u_10
            v_u_10 = v_u_10 + 1
            local v436 = buffer.readu8(v434, v435) + 1
            local v437 = v436 >= 1
            assert(v437, "value is less than 1!")
            local v438 = v436 <= 96
            assert(v438, "value is more than 96!")
            local v439 = buffer.readstring
            local v440 = v_u_9
            local v441 = v_u_10
            v_u_10 = v_u_10 + v436
            v433.amount = v439(v440, v441, v436)
            local v442 = utf8.len(v433.amount) ~= nil
            assert(v442, "value is not valid utf-8")
            if v_u_34[21][1] then
                for _, v443 in v_u_34[21] do
                    task.spawn(v443, v433)
                end
            else
                local v444 = v_u_35[21]
                table.insert(v444, v433)
                if #v_u_35[21] > 64 then
                    warn((("[ZAP] %* events in queue for GainPopup. Did you forget to attach a listener?"):format(#v_u_35[21])))
                end
            end
        elseif v43 == 38 then
            local v445 = v_u_9
            local v446 = v_u_10
            v_u_10 = v_u_10 + 1
            local v447 = buffer.readu8(v445, v446)
            local v448 = {
                ["active"] = bit32.btest(v447, 1)
            }
            local v449 = v_u_9
            local v450 = v_u_10
            v_u_10 = v_u_10 + 2
            v448.secondsLeft = buffer.readu16(v449, v450)
            if v_u_34[38][1] then
                for _, v451 in v_u_34[38] do
                    task.spawn(v451, v448)
                end
            else
                local v452 = v_u_35[38]
                table.insert(v452, v448)
                if #v_u_35[38] > 64 then
                    warn((("[ZAP] %* events in queue for FrostbitQuestState. Did you forget to attach a listener?"):format(#v_u_35[38])))
                end
            end
        elseif v43 == 3 then
            local v453 = v_u_9
            local v454 = v_u_10
            v_u_10 = v_u_10 + 1
            local v455 = buffer.readu8(v453, v454)
            local v456 = {}
            local v457 = v_u_9
            local v458 = v_u_10
            v_u_10 = v_u_10 + 2
            v456.equippedRod = buffer.readu16(v457, v458)
            local v459 = v_u_9
            local v460 = v_u_10
            v_u_10 = v_u_10 + 2
            v456.selectedBait = buffer.readu16(v459, v460)
            local v461 = v_u_9
            local v462 = v_u_10
            v_u_10 = v_u_10 + 2
            v456.keepMinPet = buffer.readu16(v461, v462)
            local v463 = v_u_9
            local v464 = v_u_10
            v_u_10 = v_u_10 + 2
            v456.keepMinArtifact = buffer.readu16(v463, v464)
            local v465 = v_u_9
            local v466 = v_u_10
            v_u_10 = v_u_10 + 2
            local v467 = buffer.readu16(v465, v466)
            v456.rods = table.create(v467)
            for v468 = 1, v467 do
                local v469 = {}
                local v470 = v_u_9
                local v471 = v_u_10
                v_u_10 = v_u_10 + 2
                v469.id = buffer.readu16(v470, v471)
                local v472 = v_u_9
                local v473 = v_u_10
                v_u_10 = v_u_10 + 4
                v469.caught = buffer.readu32(v472, v473)
                v456.rods[v468] = v469
            end
            v456.baitCharges = {}
            if not bit32.btest(v455, 1) then
                local v474 = v_u_9
                local v475 = v_u_10
                v_u_10 = v_u_10 + 2
                for _ = 1, buffer.readu16(v474, v475) + 1 do
                    local v476 = v_u_9
                    local v477 = v_u_10
                    v_u_10 = v_u_10 + 2
                    local v478 = buffer.readu16(v476, v477)
                    local v479 = v_u_9
                    local v480 = v_u_10
                    v_u_10 = v_u_10 + 4
                    local v481 = buffer.readu32(v479, v480)
                    v456.baitCharges[v478] = v481
                end
            end
            if v_u_34[3][1] then
                for _, v482 in v_u_34[3] do
                    task.spawn(v482, v456)
                end
            else
                local v483 = v_u_35[3]
                table.insert(v483, v456)
                if #v_u_35[3] > 64 then
                    warn((("[ZAP] %* events in queue for FishingState. Did you forget to attach a listener?"):format(#v_u_35[3])))
                end
            end
        elseif v43 == 2 then
            local v484 = v_u_9
            local v485 = v_u_10
            v_u_10 = v_u_10 + 1
            local v486 = buffer.readu8(v484, v485)
            local v487 = {
                ["success"] = bit32.btest(v486, 1)
            }
            local v488 = v_u_9
            local v489 = v_u_10
            v_u_10 = v_u_10 + 1
            v487.rewardType = buffer.readu8(v488, v489)
            local v490 = v_u_9
            local v491 = v_u_10
            v_u_10 = v_u_10 + 8
            v487.amount = buffer.readf64(v490, v491)
            local v492 = v_u_9
            local v493 = v_u_10
            v_u_10 = v_u_10 + 2
            v487.petId = buffer.readu16(v492, v493)
            local v494 = v_u_9
            local v495 = v_u_10
            v_u_10 = v_u_10 + 2
            v487.artifactId = buffer.readu16(v494, v495)
            local v496 = v_u_9
            local v497 = v_u_10
            v_u_10 = v_u_10 + 1
            v487.rarity = buffer.readu8(v496, v497)
            local v498 = v_u_9
            local v499 = v_u_10
            v_u_10 = v_u_10 + 4
            v487.speed = buffer.readf32(v498, v499)
            if v_u_34[2][1] then
                for _, v500 in v_u_34[2] do
                    task.spawn(v500, v487)
                end
            else
                local v501 = v_u_35[2]
                table.insert(v501, v487)
                if #v_u_35[2] > 64 then
                    warn((("[ZAP] %* events in queue for FishingResult. Did you forget to attach a listener?"):format(#v_u_35[2])))
                end
            end
        elseif v43 == 1 then
            local v502 = {}
            local v503 = v_u_9
            local v504 = v_u_10
            v_u_10 = v_u_10 + 1
            v502.phase = buffer.readu8(v503, v504)
            local v505 = v_u_9
            local v506 = v_u_10
            v_u_10 = v_u_10 + 4
            v502.duration = buffer.readf32(v505, v506)
            local v507 = v_u_9
            local v508 = v_u_10
            v_u_10 = v_u_10 + 4
            v502.speed = buffer.readf32(v507, v508)
            if v_u_34[1][1] then
                for _, v509 in v_u_34[1] do
                    task.spawn(v509, v502)
                end
            else
                local v510 = v_u_35[1]
                table.insert(v510, v502)
                if #v_u_35[1] > 64 then
                    warn((("[ZAP] %* events in queue for FishingPhase. Did you forget to attach a listener?"):format(#v_u_35[1])))
                end
            end
        elseif v43 == 4 then
            local v511 = v_u_9
            local v512 = v_u_10
            v_u_10 = v_u_10 + 1
            local v513 = buffer.readu8(v511, v512)
            if v_u_34[4][1] then
                for _, v514 in v_u_34[4] do
                    task.spawn(v514, v513)
                end
            else
                local v515 = v_u_35[4]
                table.insert(v515, v513)
                if #v_u_35[4] > 64 then
                    warn((("[ZAP] %* events in queue for FishingNotice. Did you forget to attach a listener?"):format(#v_u_35[4])))
                end
            end
        elseif v43 == 6 then
            local v516 = {}
            local v517 = v_u_9
            local v518 = v_u_10
            v_u_10 = v_u_10 + 8
            v516.userId = buffer.readf64(v517, v518)
            local v519 = v_u_9
            local v520 = v_u_10
            v_u_10 = v_u_10 + 4
            local v521 = buffer.readf32(v519, v520)
            local v522 = v_u_9
            local v523 = v_u_10
            v_u_10 = v_u_10 + 4
            local v524 = buffer.readf32(v522, v523)
            local v525 = v_u_9
            local v526 = v_u_10
            v_u_10 = v_u_10 + 4
            local v527 = buffer.readf32(v525, v526)
            v516.landing = Vector3.new(v521, v524, v527)
            if v_u_34[6][1] then
                for _, v528 in v_u_34[6] do
                    task.spawn(v528, v516)
                end
            else
                local v529 = v_u_35[6]
                table.insert(v529, v516)
                if #v_u_35[6] > 64 then
                    warn((("[ZAP] %* events in queue for FishingLineShow. Did you forget to attach a listener?"):format(#v_u_35[6])))
                end
            end
        elseif v43 == 7 then
            local v530 = v_u_9
            local v531 = v_u_10
            v_u_10 = v_u_10 + 8
            local v532 = buffer.readf64(v530, v531)
            if v_u_34[7][1] then
                for _, v533 in v_u_34[7] do
                    task.spawn(v533, v532)
                end
            else
                local v534 = v_u_35[7]
                table.insert(v534, v532)
                if #v_u_35[7] > 64 then
                    warn((("[ZAP] %* events in queue for FishingLineHide. Did you forget to attach a listener?"):format(#v_u_35[7])))
                end
            end
        elseif v43 == 0 then
            local v535 = v_u_9
            local v536 = v_u_10
            v_u_10 = v_u_10 + 4
            local v537 = buffer.readf32(v535, v536)
            local v538 = v_u_9
            local v539 = v_u_10
            v_u_10 = v_u_10 + 4
            local v540 = buffer.readf32(v538, v539)
            local v541 = v_u_9
            local v542 = v_u_10
            v_u_10 = v_u_10 + 4
            local v543 = buffer.readf32(v541, v542)
            local v544 = Vector3.new(v537, v540, v543)
            if v_u_34[0][1] then
                for _, v545 in v_u_34[0] do
                    task.spawn(v545, v544)
                end
            else
                local v546 = v_u_35[0]
                table.insert(v546, v544)
                if #v_u_35[0] > 64 then
                    warn((("[ZAP] %* events in queue for FishingGoToArrived. Did you forget to attach a listener?"):format(#v_u_35[0])))
                end
            end
        elseif v43 == 26 then
            local v547 = v_u_9
            local v548 = v_u_10
            v_u_10 = v_u_10 + 1
            local v549 = buffer.readu8(v547, v548)
            local v550
            if bit32.btest(v549, 1) then
                v_u_12 = v_u_12 + 1
                v550 = v_u_11[v_u_12]
            else
                v550 = nil
            end
            if v_u_34[26][1] then
                for _, v551 in v_u_34[26] do
                    task.spawn(v551, v550)
                end
            else
                local v552 = v_u_35[26]
                table.insert(v552, v550)
                if #v_u_35[26] > 64 then
                    warn((("[ZAP] %* events in queue for FireNpcDeath. Did you forget to attach a listener?"):format(#v_u_35[26])))
                end
            end
        elseif v43 == 25 then
            local v553 = v_u_9
            local v554 = v_u_10
            v_u_10 = v_u_10 + 1
            local v555 = buffer.readu8(v553, v554)
            local v556
            if bit32.btest(v555, 1) then
                v_u_12 = v_u_12 + 1
                v556 = v_u_11[v_u_12]
            else
                v556 = nil
            end
            if v_u_34[25][1] then
                for _, v557 in v_u_34[25] do
                    task.spawn(v557, v556)
                end
            else
                local v558 = v_u_35[25]
                table.insert(v558, v556)
                if #v_u_35[25] > 64 then
                    warn((("[ZAP] %* events in queue for FireNpcAttack. Did you forget to attach a listener?"):format(#v_u_35[25])))
                end
            end
        elseif v43 == 27 then
            local v559 = v_u_9
            local v560 = v_u_10
            v_u_10 = v_u_10 + 4
            local v561 = buffer.readf32(v559, v560)
            local v562 = v_u_9
            local v563 = v_u_10
            v_u_10 = v_u_10 + 4
            local v564 = buffer.readf32(v562, v563)
            local v565 = v_u_9
            local v566 = v_u_10
            v_u_10 = v_u_10 + 4
            local v567 = buffer.readf32(v565, v566)
            local v568 = Vector3.new(v561, v564, v567)
            if v_u_34[27][1] then
                for _, v569 in v_u_34[27] do
                    task.spawn(v569, v568)
                end
            else
                local v570 = v_u_35[27]
                table.insert(v570, v568)
                if #v_u_35[27] > 64 then
                    warn((("[ZAP] %* events in queue for FireBossSummon. Did you forget to attach a listener?"):format(#v_u_35[27])))
                end
            end
        elseif v43 == 32 then
            local v571 = v_u_9
            local v572 = v_u_10
            v_u_10 = v_u_10 + 1
            local v573 = buffer.readu8(v571, v572)
            local v574 = {}
            local v575 = v_u_9
            local v576 = v_u_10
            v_u_10 = v_u_10 + 4
            v574.embers = buffer.readu32(v575, v576)
            local v577 = v_u_9
            local v578 = v_u_10
            v_u_10 = v_u_10 + 8
            v574.gold = buffer.readf64(v577, v578)
            local v579 = v_u_9
            local v580 = v_u_10
            v_u_10 = v_u_10 + 8
            v574.xp = buffer.readf64(v579, v580)
            v574.killer = bit32.btest(v573, 1)
            if bit32.btest(v573, 2) then
                local v581 = v_u_9
                local v582 = v_u_10
                v_u_10 = v_u_10 + 2
                v574.petId = buffer.readu16(v581, v582)
            else
                v574.petId = nil
            end
            if bit32.btest(v573, 4) then
                local v583 = v_u_9
                local v584 = v_u_10
                v_u_10 = v_u_10 + 2
                v574.artifactId = buffer.readu16(v583, v584)
            else
                v574.artifactId = nil
            end
            if v_u_34[32] then
                task.spawn(v_u_34[32], v574)
            else
                local v585 = v_u_35[32]
                table.insert(v585, v574)
                if #v_u_35[32] > 64 then
                    warn((("[ZAP] %* events in queue for FireBossRewards. Did you forget to attach a listener?"):format(#v_u_35[32])))
                end
            end
        elseif v43 == 30 then
            local v586 = v_u_9
            local v587 = v_u_10
            v_u_10 = v_u_10 + 1
            local v588 = buffer.readu8(v586, v587)
            if v_u_34[30][1] then
                for _, v589 in v_u_34[30] do
                    task.spawn(v589, v588)
                end
            else
                local v590 = v_u_35[30]
                table.insert(v590, v588)
                if #v_u_35[30] > 64 then
                    warn((("[ZAP] %* events in queue for FireBossPhase. Did you forget to attach a listener?"):format(#v_u_35[30])))
                end
            end
        elseif v43 == 29 then
            local v591 = {}
            local v592 = v_u_9
            local v593 = v_u_10
            v_u_10 = v_u_10 + 1
            v591.kind = buffer.readu8(v592, v593)
            local v594 = v_u_9
            local v595 = v_u_10
            v_u_10 = v_u_10 + 4
            local v596 = buffer.readf32(v594, v595)
            local v597 = v_u_9
            local v598 = v_u_10
            v_u_10 = v_u_10 + 4
            local v599 = buffer.readf32(v597, v598)
            local v600 = v_u_9
            local v601 = v_u_10
            v_u_10 = v_u_10 + 4
            local v602 = buffer.readf32(v600, v601)
            v591.pos = Vector3.new(v596, v599, v602)
            if v_u_34[29][1] then
                for _, v603 in v_u_34[29] do
                    task.spawn(v603, v591)
                end
            else
                local v604 = v_u_35[29]
                table.insert(v604, v591)
                if #v_u_35[29] > 64 then
                    warn((("[ZAP] %* events in queue for FireBossImpact. Did you forget to attach a listener?"):format(#v_u_35[29])))
                end
            end
        elseif v43 == 31 then
            local v605 = v_u_9
            local v606 = v_u_10
            v_u_10 = v_u_10 + 1
            local v607 = buffer.readu8(v605, v606)
            local v608
            if bit32.btest(v607, 1) then
                v_u_12 = v_u_12 + 1
                v608 = v_u_11[v_u_12]
            else
                v608 = nil
            end
            if v_u_34[31][1] then
                for _, v609 in v_u_34[31] do
                    task.spawn(v609, v608)
                end
            else
                local v610 = v_u_35[31]
                table.insert(v610, v608)
                if #v_u_35[31] > 64 then
                    warn((("[ZAP] %* events in queue for FireBossDespawn. Did you forget to attach a listener?"):format(#v_u_35[31])))
                end
            end
        elseif v43 == 28 then
            local v611 = v_u_9
            local v612 = v_u_10
            v_u_10 = v_u_10 + 1
            local v613 = buffer.readu8(v611, v612)
            local v614 = {}
            local v615 = v_u_9
            local v616 = v_u_10
            v_u_10 = v_u_10 + 1
            v614.kind = buffer.readu8(v615, v616)
            local v617 = v_u_9
            local v618 = v_u_10
            v_u_10 = v_u_10 + 4
            local v619 = buffer.readf32(v617, v618)
            local v620 = v_u_9
            local v621 = v_u_10
            v_u_10 = v_u_10 + 4
            local v622 = buffer.readf32(v620, v621)
            local v623 = v_u_9
            local v624 = v_u_10
            v_u_10 = v_u_10 + 4
            local v625 = buffer.readf32(v623, v624)
            v614.pos = Vector3.new(v619, v622, v625)
            if bit32.btest(v613, 1) then
                local v626 = v_u_9
                local v627 = v_u_10
                v_u_10 = v_u_10 + 4
                local v628 = buffer.readf32(v626, v627)
                local v629 = v_u_9
                local v630 = v_u_10
                v_u_10 = v_u_10 + 4
                local v631 = buffer.readf32(v629, v630)
                local v632 = v_u_9
                local v633 = v_u_10
                v_u_10 = v_u_10 + 4
                local v634 = buffer.readf32(v632, v633)
                v614.pos2 = Vector3.new(v628, v631, v634)
            else
                v614.pos2 = nil
            end
            local v635 = v_u_9
            local v636 = v_u_10
            v_u_10 = v_u_10 + 4
            v614.duration = buffer.readf32(v635, v636)
            if v_u_34[28][1] then
                for _, v637 in v_u_34[28] do
                    task.spawn(v637, v614)
                end
            else
                local v638 = v_u_35[28]
                table.insert(v638, v614)
                if #v_u_35[28] > 64 then
                    warn((("[ZAP] %* events in queue for FireBossCast. Did you forget to attach a listener?"):format(#v_u_35[28])))
                end
            end
        elseif v43 == 43 then
            local v639 = v_u_9
            local v640 = v_u_10
            v_u_10 = v_u_10 + 1
            local v641 = buffer.readu8(v639, v640)
            local v642 = {}
            if bit32.btest(v641, 1) then
                v642.currency = "gold"
            elseif bit32.btest(v641, 2) then
                v642.currency = "tokens"
            elseif bit32.btest(v641, 4) then
                v642.currency = "quest"
            elseif bit32.btest(v641, 8) then
                v642.currency = "embers"
            elseif bit32.btest(v641, 16) then
                v642.currency = "pumpkins"
            end
            local v643 = v_u_9
            local v644 = v_u_10
            v_u_10 = v_u_10 + 1
            v642.pack = buffer.readu8(v643, v644)
            local v645 = v_u_9
            local v646 = v_u_10
            v_u_10 = v_u_10 + 8
            v642.amount = buffer.readf64(v645, v646)
            if v_u_34[43][1] then
                for _, v647 in v_u_34[43] do
                    task.spawn(v647, v642)
                end
            else
                local v648 = v_u_35[43]
                table.insert(v648, v642)
                if #v_u_35[43] > 64 then
                    warn((("[ZAP] %* events in queue for CurrencyPackGranted. Did you forget to attach a listener?"):format(#v_u_35[43])))
                end
            end
        elseif v43 == 23 then
            local v649 = v_u_9
            local v650 = v_u_10
            v_u_10 = v_u_10 + 1
            local v651 = buffer.readu8(v649, v650)
            local v652 = {}
            local v653 = v_u_9
            local v654 = v_u_10
            v_u_10 = v_u_10 + 8
            v652.userId = buffer.readf64(v653, v654)
            local v655 = v_u_9
            local v656 = v_u_10
            v_u_10 = v_u_10 + 2
            local v657 = buffer.readu16(v655, v656) + 1
            local v658 = v657 >= 1
            assert(v658, "value is less than 1!")
            local v659 = v657 <= 400
            assert(v659, "value is more than 400!")
            local v660 = buffer.readstring
            local v661 = v_u_9
            local v662 = v_u_10
            v_u_10 = v_u_10 + v657
            v652.name = v660(v661, v662, v657)
            local v663 = utf8.len(v652.name) ~= nil
            assert(v663, "value is not valid utf-8")
            local v664 = v_u_9
            local v665 = v_u_10
            v_u_10 = v_u_10 + 2
            local v666 = buffer.readu16(v664, v665) + 1
            local v667 = v666 >= 1
            assert(v667, "value is less than 1!")
            local v668 = v666 <= 400
            assert(v668, "value is more than 400!")
            local v669 = buffer.readstring
            local v670 = v_u_9
            local v671 = v_u_10
            v_u_10 = v_u_10 + v666
            v652.userName = v669(v670, v671, v666)
            local v672 = utf8.len(v652.userName) ~= nil
            assert(v672, "value is not valid utf-8")
            local v673 = v_u_9
            local v674 = v_u_10
            v_u_10 = v_u_10 + 2
            local v675 = buffer.readu16(v673, v674) + 1
            local v676 = v675 >= 1
            assert(v676, "value is less than 1!")
            local v677 = v675 <= 4000
            assert(v677, "value is more than 4000!")
            local v678 = buffer.readstring
            local v679 = v_u_9
            local v680 = v_u_10
            v_u_10 = v_u_10 + v675
            v652.text = v678(v679, v680, v675)
            local v681 = utf8.len(v652.text) ~= nil
            assert(v681, "value is not valid utf-8")
            v652.history = bit32.btest(v651, 1)
            if v_u_34[23][1] then
                for _, v682 in v_u_34[23] do
                    task.spawn(v682, v652)
                end
            else
                local v683 = v_u_35[23]
                table.insert(v683, v652)
                if #v_u_35[23] > 64 then
                    warn((("[ZAP] %* events in queue for ClanChatToClient. Did you forget to attach a listener?"):format(#v_u_35[23])))
                end
            end
        elseif v43 == 35 then
            if v_u_34[35] then
                task.spawn(v_u_34[35], nil)
            else
                local v684 = v_u_35
                v684[35] = v684[35] + 1
                if v_u_35[35] > 16 then
                    warn((("[ZAP] %* events in queue for BloodMoonPopupShow. Did you forget to attach a listener?"):format(v_u_35[35])))
                end
            end
        elseif v43 == 33 then
            local v685 = v_u_9
            local v686 = v_u_10
            v_u_10 = v_u_10 + 1
            local v687 = buffer.readu8(v685, v686)
            local v688 = {}
            if bit32.btest(v687, 1) then
                v688.item = "vampire_bat"
            elseif bit32.btest(v687, 2) then
                v688.item = "blood_moon_werewolf"
            elseif bit32.btest(v687, 4) then
                v688.item = "crimson_mantle"
            elseif bit32.btest(v687, 8) then
                v688.item = "crescent_reaver"
            elseif bit32.btest(v687, 16) then
                v688.item = "alpha_werewolf"
            elseif bit32.btest(v687, 32) then
                v688.item = "bloodmoon_bell"
            end
            local v689 = v_u_9
            local v690 = v_u_10
            v_u_10 = v_u_10 + 1
            local v691 = buffer.readu8(v689, v690) + 1
            local v692 = v691 >= 1
            assert(v692, "value is less than 1!")
            local v693 = v691 <= 256
            assert(v693, "value is more than 256!")
            local v694 = buffer.readstring
            local v695 = v_u_9
            local v696 = v_u_10
            v_u_10 = v_u_10 + v691
            v688.from = v694(v695, v696, v691)
            local v697 = utf8.len(v688.from) ~= nil
            assert(v697, "value is not valid utf-8")
            if v_u_34[33] then
                task.spawn(v_u_34[33], v688)
            else
                local v698 = v_u_35[33]
                table.insert(v698, v688)
                if #v_u_35[33] > 64 then
                    warn((("[ZAP] %* events in queue for BloodMoonGiftReceived. Did you forget to attach a listener?"):format(#v_u_35[33])))
                end
            end
        elseif v43 == 40 then
            local v699 = {}
            v_u_12 = v_u_12 + 1
            v699.owner = v_u_11[v_u_12]
            local v700 = v699.owner ~= nil
            assert(v700, "received instance is nil!")
            local v701 = v699.owner:IsA("Player")
            assert(v701, "received instance is not of the Player class!")
            if v_u_34[40][1] then
                for _, v702 in v_u_34[40] do
                    task.spawn(v702, v699)
                end
            else
                local v703 = v_u_35[40]
                table.insert(v703, v699)
                if #v_u_35[40] > 64 then
                    warn((("[ZAP] %* events in queue for BatHome. Did you forget to attach a listener?"):format(#v_u_35[40])))
                end
            end
        elseif v43 == 8 then
            local v704 = {}
            local v705 = v_u_9
            local v706 = v_u_10
            v_u_10 = v_u_10 + 1
            local v707 = buffer.readu8(v705, v706)
            local v708 = v707 <= 4
            assert(v708, "value is more than 4!")
            v704.xp = table.create(v707)
            for v709 = 1, v707 do
                local v710 = {}
                local v711 = v_u_9
                local v712 = v_u_10
                v_u_10 = v_u_10 + 1
                v710.tier = buffer.readu8(v711, v712)
                local v713 = v_u_9
                local v714 = v_u_10
                v_u_10 = v_u_10 + 4
                v710.remainingSeconds = buffer.readu32(v713, v714)
                v704.xp[v709] = v710
            end
            local v715 = v_u_9
            local v716 = v_u_10
            v_u_10 = v_u_10 + 1
            local v717 = buffer.readu8(v715, v716)
            local v718 = v717 <= 4
            assert(v718, "value is more than 4!")
            v704.gold = table.create(v717)
            for v719 = 1, v717 do
                local v720 = {}
                local v721 = v_u_9
                local v722 = v_u_10
                v_u_10 = v_u_10 + 1
                v720.tier = buffer.readu8(v721, v722)
                local v723 = v_u_9
                local v724 = v_u_10
                v_u_10 = v_u_10 + 4
                v720.remainingSeconds = buffer.readu32(v723, v724)
                v704.gold[v719] = v720
            end
            local v725 = v_u_9
            local v726 = v_u_10
            v_u_10 = v_u_10 + 1
            local v727 = buffer.readu8(v725, v726)
            local v728 = v727 <= 4
            assert(v728, "value is more than 4!")
            v704.event = table.create(v727)
            for v729 = 1, v727 do
                local v730 = {}
                local v731 = v_u_9
                local v732 = v_u_10
                v_u_10 = v_u_10 + 1
                v730.tier = buffer.readu8(v731, v732)
                local v733 = v_u_9
                local v734 = v_u_10
                v_u_10 = v_u_10 + 4
                v730.remainingSeconds = buffer.readu32(v733, v734)
                v704.event[v729] = v730
            end
            local v735 = v_u_9
            local v736 = v_u_10
            v_u_10 = v_u_10 + 1
            local v737 = buffer.readu8(v735, v736)
            local v738 = v737 <= 4
            assert(v738, "value is more than 4!")
            v704.tokens = table.create(v737)
            for v739 = 1, v737 do
                local v740 = {}
                local v741 = v_u_9
                local v742 = v_u_10
                v_u_10 = v_u_10 + 1
                v740.tier = buffer.readu8(v741, v742)
                local v743 = v_u_9
                local v744 = v_u_10
                v_u_10 = v_u_10 + 4
                v740.remainingSeconds = buffer.readu32(v743, v744)
                v704.tokens[v739] = v740
            end
            if v_u_34[8][1] then
                for _, v745 in v_u_34[8] do
                    task.spawn(v745, v704)
                end
            else
                local v746 = v_u_35[8]
                table.insert(v746, v704)
                if #v_u_35[8] > 64 then
                    warn((("[ZAP] %* events in queue for ActiveBoostsUpdate. Did you forget to attach a listener?"):format(#v_u_35[8])))
                end
            end
        elseif v43 == 11 then
            local v747 = {}
            local v748 = v_u_9
            local v749 = v_u_10
            v_u_10 = v_u_10 + 2
            local v750 = buffer.readu16(v748, v749)
            local v751 = buffer.readstring
            local v752 = v_u_9
            local v753 = v_u_10
            v_u_10 = v_u_10 + v750
            v747.userName = v751(v752, v753, v750)
            local v754 = utf8.len(v747.userName) ~= nil
            assert(v754, "value is not valid utf-8")
            local v755 = v_u_9
            local v756 = v_u_10
            v_u_10 = v_u_10 + 8
            v747.userId = buffer.readf64(v755, v756)
            local v757 = v_u_9
            local v758 = v_u_10
            v_u_10 = v_u_10 + 2
            local v759 = buffer.readu16(v757, v758)
            local v760 = buffer.readstring
            local v761 = v_u_9
            local v762 = v_u_10
            v_u_10 = v_u_10 + v759
            v747.vectorName = v760(v761, v762, v759)
            local v763 = utf8.len(v747.vectorName) ~= nil
            assert(v763, "value is not valid utf-8")
            local v764 = v_u_9
            local v765 = v_u_10
            v_u_10 = v_u_10 + 4
            v747.flags = buffer.readu32(v764, v765)
            local v766 = v_u_9
            local v767 = v_u_10
            v_u_10 = v_u_10 + 4
            v747.total = buffer.readu32(v766, v767)
            local v768 = v_u_9
            local v769 = v_u_10
            v_u_10 = v_u_10 + 2
            local v770 = buffer.readu16(v768, v769)
            local v771 = buffer.readstring
            local v772 = v_u_9
            local v773 = v_u_10
            v_u_10 = v_u_10 + v770
            v747.detail = v771(v772, v773, v770)
            local v774 = utf8.len(v747.detail) ~= nil
            assert(v774, "value is not valid utf-8")
            local v775 = v_u_9
            local v776 = v_u_10
            v_u_10 = v_u_10 + 2
            v747.pingMs = buffer.readu16(v775, v776)
            if v_u_34[11][1] then
                for _, v777 in v_u_34[11] do
                    task.spawn(v777, v747)
                end
            else
                local v778 = v_u_35[11]
                table.insert(v778, v747)
                if #v_u_35[11] > 64 then
                    warn((("[ZAP] %* events in queue for AcStaffNotice. Did you forget to attach a listener?"):format(#v_u_35[11])))
                end
            end
        elseif v43 == 41 then
            local v779 = v_u_9
            local v780 = v_u_10
            v_u_10 = v_u_10 + 1
            local v781 = buffer.readu8(v779, v780)
            local v782 = {}
            if bit32.btest(v781, 1) then
                v782.ability = "swarm"
            else
                v782.ability = nil
            end
            local v783 = v_u_9
            local v784 = v_u_10
            v_u_10 = v_u_10 + 4
            v782.cooldown = buffer.readf32(v783, v784)
            local v785 = v_u_9
            local v786 = v_u_10
            v_u_10 = v_u_10 + 4
            v782.total = buffer.readf32(v785, v786)
            local v787 = v_u_9
            local v788 = v_u_10
            v_u_10 = v_u_10 + 4
            v782.active = buffer.readf32(v787, v788)
            if bit32.btest(v781, 2) then
                if bit32.btest(v781, 4) then
                    v782.refused = "dead"
                elseif bit32.btest(v781, 8) then
                    v782.refused = "arena"
                elseif bit32.btest(v781, 16) then
                    v782.refused = "none"
                elseif bit32.btest(v781, 32) then
                    v782.refused = "cooldown"
                elseif bit32.btest(v781, 64) then
                    v782.refused = "blocked"
                end
            else
                v782.refused = nil
            end
            if v_u_34[41] then
                task.spawn(v_u_34[41], v782)
            else
                local v789 = v_u_35[41]
                table.insert(v789, v782)
                if #v_u_35[41] > 64 then
                    warn((("[ZAP] %* events in queue for AbilityState. Did you forget to attach a listener?"):format(#v_u_35[41])))
                end
            end
        elseif v43 == 42 then
            local v790 = v_u_9
            local v791 = v_u_10
            v_u_10 = v_u_10 + 1
            local v792 = buffer.readu8(v790, v791)
            local v793 = {}
            v_u_12 = v_u_12 + 1
            v793.owner = v_u_11[v_u_12]
            local v794 = v793.owner ~= nil
            assert(v794, "received instance is nil!")
            local v795 = v793.owner:IsA("Player")
            assert(v795, "received instance is not of the Player class!")
            v793.ability = "swarm"
            if bit32.btest(v792, 1) then
                v793.phase = "start"
            else
                v793.phase = "stop"
            end
            local v796 = v_u_9
            local v797 = v_u_10
            v_u_10 = v_u_10 + 4
            local v798 = buffer.readf32(v796, v797)
            local v799 = v_u_9
            local v800 = v_u_10
            v_u_10 = v_u_10 + 4
            local v801 = buffer.readf32(v799, v800)
            local v802 = v_u_9
            local v803 = v_u_10
            v_u_10 = v_u_10 + 4
            local v804 = buffer.readf32(v802, v803)
            v793.at = Vector3.new(v798, v801, v804)
            local v805 = v_u_9
            local v806 = v_u_10
            v_u_10 = v_u_10 + 4
            v793.duration = buffer.readf32(v805, v806)
            if v_u_34[42][1] then
                for _, v807 in v_u_34[42] do
                    task.spawn(v807, v793)
                end
            else
                local v808 = v_u_35[42]
                table.insert(v808, v793)
                if #v_u_35[42] > 64 then
                    warn((("[ZAP] %* events in queue for AbilityCast. Did you forget to attach a listener?"):format(#v_u_35[42])))
                end
            end
        elseif v43 == 52 then
            local v809 = v_u_9
            local v810 = v_u_10
            v_u_10 = v_u_10 + 1
            local v811 = buffer.readu8(v809, v810)
            local v812 = v_u_9
            local v813 = v_u_10
            v_u_10 = v_u_10 + 1
            local v814 = buffer.readu8(v812, v813)
            local v815 = {
                ["ok"] = bit32.btest(v814, 1)
            }
            local v816 = v_u_35[52][v811]
            if v816 then
                task.spawn(v816, v815)
            end
            v_u_35[52][v811] = nil
        elseif v43 == 70 then
            local v817 = v_u_9
            local v818 = v_u_10
            v_u_10 = v_u_10 + 1
            local v819 = buffer.readu8(v817, v818)
            local v820 = v_u_9
            local v821 = v_u_10
            v_u_10 = v_u_10 + 1
            local v822 = buffer.readu8(v820, v821)
            local v823 = {}
            if bit32.btest(v822, 1) then
                v823.res = "ok"
            elseif bit32.btest(v822, 2) then
                v823.res = "off"
            elseif bit32.btest(v822, 4) then
                v823.res = "no_mount"
            elseif bit32.btest(v822, 8) then
                v823.res = "arena"
            elseif bit32.btest(v822, 16) then
                v823.res = "not_ready"
            elseif bit32.btest(v822, 32) then
                v823.res = "busy"
            end
            local v824 = v_u_35[70][v819]
            if v824 then
                task.spawn(v824, v823)
            end
            v_u_35[70][v819] = nil
        elseif v43 == 47 then
            local v825 = v_u_9
            local v826 = v_u_10
            v_u_10 = v_u_10 + 1
            local v827 = buffer.readu8(v825, v826)
            local v828 = v_u_9
            local v829 = v_u_10
            v_u_10 = v_u_10 + 1
            local v830 = buffer.readu8(v828, v829)
            local v831 = {}
            if bit32.btest(v830, 1) then
                v831.status = "ok"
            elseif bit32.btest(v830, 2) then
                v831.status = "invalid"
            elseif bit32.btest(v830, 4) then
                v831.status = "expired"
            elseif bit32.btest(v830, 8) then
                v831.status = "used"
            elseif bit32.btest(v830, 16) then
                v831.status = "limit"
            elseif bit32.btest(v830, 32) then
                v831.status = "rate"
            elseif bit32.btest(v830, 64) then
                v831.status = "err"
            end
            local v832 = v_u_9
            local v833 = v_u_10
            v_u_10 = v_u_10 + 1
            local v834 = buffer.readu8(v832, v833)
            local v835 = v834 >= 0
            assert(v835, "value is less than 0!")
            local v836 = v834 <= 8
            assert(v836, "value is more than 8!")
            v831.rewards = table.create(v834)
            for v837 = 1, v834 do
                local v838 = v_u_9
                local v839 = v_u_10
                v_u_10 = v_u_10 + 1
                local v840 = buffer.readu8(v838, v839)
                local v841 = {}
                if bit32.btest(v840, 1) then
                    v841.kind = "currency"
                elseif bit32.btest(v840, 2) then
                    v841.kind = "pet"
                elseif bit32.btest(v840, 4) then
                    v841.kind = "weapon"
                elseif bit32.btest(v840, 8) then
                    v841.kind = "skin"
                elseif bit32.btest(v840, 16) then
                    v841.kind = "potion"
                end
                local v842 = v_u_9
                local v843 = v_u_10
                v_u_10 = v_u_10 + 1
                local v844 = buffer.readu8(v842, v843)
                local v845 = v844 >= 0
                assert(v845, "value is less than 0!")
                local v846 = v844 <= 160
                assert(v846, "value is more than 160!")
                local v847 = buffer.readstring
                local v848 = v_u_9
                local v849 = v_u_10
                v_u_10 = v_u_10 + v844
                v841.id = v847(v848, v849, v844)
                local v850 = utf8.len(v841.id) ~= nil
                assert(v850, "value is not valid utf-8")
                local v851 = v_u_9
                local v852 = v_u_10
                v_u_10 = v_u_10 + 4
                v841.amount = buffer.readu32(v851, v852)
                v831.rewards[v837] = v841
            end
            local v853 = v_u_35[47][v827]
            if v853 then
                task.spawn(v853, v831)
            end
            v_u_35[47][v827] = nil
        elseif v43 == 45 then
            local v854 = v_u_9
            local v855 = v_u_10
            v_u_10 = v_u_10 + 1
            local v856 = buffer.readu8(v854, v855)
            local v857 = {}
            local v858 = v_u_9
            local v859 = v_u_10
            v_u_10 = v_u_10 + 1
            v857.res = buffer.readu8(v858, v859)
            local v860 = v_u_9
            local v861 = v_u_10
            v_u_10 = v_u_10 + 1
            local v862 = buffer.readu8(v860, v861)
            local v863 = v862 >= 0
            assert(v863, "value is less than 0!")
            local v864 = v862 <= 3
            assert(v864, "value is more than 3!")
            v857.results = table.create(v862)
            for v865 = 1, v862 do
                local v866 = v_u_9
                local v867 = v_u_10
                v_u_10 = v_u_10 + 2
                local v868 = buffer.readu16(v866, v867)
                v857.results[v865] = v868
            end
            local v869 = v_u_35[45][v856]
            if v869 then
                task.spawn(v869, v857)
            end
            v_u_35[45][v856] = nil
        elseif v43 == 44 then
            local v870 = v_u_9
            local v871 = v_u_10
            v_u_10 = v_u_10 + 1
            local v872 = buffer.readu8(v870, v871)
            local v873 = v_u_9
            local v874 = v_u_10
            v_u_10 = v_u_10 + 1
            local v875 = buffer.readu8(v873, v874)
            local v876 = {}
            if bit32.btest(v875, 1) then
                v876.status = "ok"
            elseif bit32.btest(v875, 2) then
                v876.status = "none_owned"
            elseif bit32.btest(v875, 4) then
                v876.status = "no_space"
            elseif bit32.btest(v875, 8) then
                v876.status = "err"
            end
            local v877 = v_u_9
            local v878 = v_u_10
            v_u_10 = v_u_10 + 8
            v876.remaining = buffer.readf64(v877, v878)
            local v879 = v_u_9
            local v880 = v_u_10
            v_u_10 = v_u_10 + 1
            local v881 = buffer.readu8(v879, v880)
            local v882 = v881 >= 0
            assert(v882, "value is less than 0!")
            local v883 = v881 <= 10
            assert(v883, "value is more than 10!")
            v876.results = table.create(v881)
            for v884 = 1, v881 do
                local v885 = v_u_9
                local v886 = v_u_10
                v_u_10 = v_u_10 + 1
                local v887 = buffer.readu8(v885, v886)
                local v888 = {}
                if bit32.btest(v887, 1) then
                    v888.crate = "t1_wpn_crate"
                elseif bit32.btest(v887, 2) then
                    v888.crate = "t2_wpn_crate"
                elseif bit32.btest(v887, 4) then
                    v888.crate = "t3_wpn_crate"
                elseif bit32.btest(v887, 8) then
                    v888.crate = "t1_skin_crate"
                elseif bit32.btest(v887, 16) then
                    v888.crate = "t2_skin_crate"
                elseif bit32.btest(v887, 32) then
                    v888.crate = "t3_skin_crate"
                end
                if bit32.btest(v887, 64) then
                    v888.itemType = "weapon"
                else
                    v888.itemType = "skin"
                end
                local v889 = v_u_9
                local v890 = v_u_10
                v_u_10 = v_u_10 + 2
                v888.itemId = buffer.readu16(v889, v890)
                v876.results[v884] = v888
            end
            local v891 = v_u_35[44][v872]
            if v891 then
                task.spawn(v891, v876)
            end
            v_u_35[44][v872] = nil
        elseif v43 == 56 then
            local v892 = v_u_9
            local v893 = v_u_10
            v_u_10 = v_u_10 + 1
            local v894 = buffer.readu8(v892, v893)
            local v895 = {}
            local v896 = v_u_9
            local v897 = v_u_10
            v_u_10 = v_u_10 + 1
            v895.res = buffer.readu8(v896, v897)
            local v898 = v_u_35[56][v894]
            if v898 then
                task.spawn(v898, v895)
            end
            v_u_35[56][v894] = nil
        elseif v43 == 54 then
            local v899 = v_u_9
            local v900 = v_u_10
            v_u_10 = v_u_10 + 1
            local v901 = buffer.readu8(v899, v900)
            local v902 = {}
            local v903 = v_u_9
            local v904 = v_u_10
            v_u_10 = v_u_10 + 1
            v902.res = buffer.readu8(v903, v904)
            local v905 = v_u_35[54][v901]
            if v905 then
                task.spawn(v905, v902)
            end
            v_u_35[54][v901] = nil
        elseif v43 == 55 then
            local v906 = v_u_9
            local v907 = v_u_10
            v_u_10 = v_u_10 + 1
            local v908 = buffer.readu8(v906, v907)
            local v909 = {}
            local v910 = v_u_9
            local v911 = v_u_10
            v_u_10 = v_u_10 + 1
            v909.res = buffer.readu8(v910, v911)
            local v912 = v_u_9
            local v913 = v_u_10
            v_u_10 = v_u_10 + 2
            v909.sold = buffer.readu16(v912, v913)
            local v914 = v_u_9
            local v915 = v_u_10
            v_u_10 = v_u_10 + 8
            v909.amount = buffer.readf64(v914, v915)
            local v916 = v_u_35[55][v908]
            if v916 then
                task.spawn(v916, v909)
            end
            v_u_35[55][v908] = nil
        elseif v43 == 53 then
            local v917 = v_u_9
            local v918 = v_u_10
            v_u_10 = v_u_10 + 1
            local v919 = buffer.readu8(v917, v918)
            local v920 = {}
            local v921 = v_u_9
            local v922 = v_u_10
            v_u_10 = v_u_10 + 1
            v920.res = buffer.readu8(v921, v922)
            local v923 = v_u_9
            local v924 = v_u_10
            v_u_10 = v_u_10 + 8
            v920.amount = buffer.readf64(v923, v924)
            local v925 = v_u_35[53][v919]
            if v925 then
                task.spawn(v925, v920)
            end
            v_u_35[53][v919] = nil
        elseif v43 == 68 then
            local v926 = v_u_9
            local v927 = v_u_10
            v_u_10 = v_u_10 + 1
            local v928 = buffer.readu8(v926, v927)
            local v929 = v_u_9
            local v930 = v_u_10
            v_u_10 = v_u_10 + 1
            local v931 = buffer.readu8(v929, v930)
            local v932 = {}
            if bit32.btest(v931, 1) then
                v932.res = "ok"
            elseif bit32.btest(v931, 2) then
                v932.res = "disabled"
            elseif bit32.btest(v931, 4) then
                v932.res = "not_ready"
            elseif bit32.btest(v931, 8) then
                v932.res = "busy"
            elseif bit32.btest(v931, 16) then
                v932.res = "in_zone"
            elseif bit32.btest(v931, 32) then
                v932.res = "cooldown"
            elseif bit32.btest(v931, 64) then
                v932.res = "err"
            end
            local v933 = v_u_9
            local v934 = v_u_10
            v_u_10 = v_u_10 + 1
            v932.wait = buffer.readu8(v933, v934)
            local v935 = v_u_35[68][v928]
            if v935 then
                task.spawn(v935, v932)
            end
            v_u_35[68][v928] = nil
        elseif v43 == 64 then
            local v936 = v_u_9
            local v937 = v_u_10
            v_u_10 = v_u_10 + 1
            local v938 = buffer.readu8(v936, v937)
            local v939 = {}
            local v940 = v_u_9
            local v941 = v_u_10
            v_u_10 = v_u_10 + 1
            v939.res = buffer.readu8(v940, v941)
            local v942 = v_u_35[64][v938]
            if v942 then
                task.spawn(v942, v939)
            end
            v_u_35[64][v938] = nil
        elseif v43 == 49 then
            local v943 = v_u_9
            local v944 = v_u_10
            v_u_10 = v_u_10 + 1
            local v945 = buffer.readu8(v943, v944)
            local v946 = {}
            local v947 = v_u_9
            local v948 = v_u_10
            v_u_10 = v_u_10 + 4
            v946.version = buffer.readu32(v947, v948)
            local v949 = v_u_9
            local v950 = v_u_10
            v_u_10 = v_u_10 + 4
            local v951 = buffer.readu32(v949, v950)
            local v952 = v951 >= 0
            assert(v952, "value is less than 0!")
            local v953 = v951 <= 262140
            assert(v953, "value is more than 262140!")
            local v954 = buffer.readstring
            local v955 = v_u_9
            local v956 = v_u_10
            v_u_10 = v_u_10 + v951
            v946.payload = v954(v955, v956, v951)
            local v957 = utf8.len(v946.payload) ~= nil
            assert(v957, "value is not valid utf-8")
            local v958 = v_u_35[49][v945]
            if v958 then
                task.spawn(v958, v946)
            end
            v_u_35[49][v945] = nil
        elseif v43 == 50 then
            local v959 = v_u_9
            local v960 = v_u_10
            v_u_10 = v_u_10 + 1
            local v961 = buffer.readu8(v959, v960)
            local v962 = {}
            local v963 = v_u_9
            local v964 = v_u_10
            v_u_10 = v_u_10 + 4
            v962.version = buffer.readu32(v963, v964)
            local v965 = v_u_9
            local v966 = v_u_10
            v_u_10 = v_u_10 + 4
            local v967 = buffer.readu32(v965, v966)
            local v968 = v967 >= 0
            assert(v968, "value is less than 0!")
            local v969 = v967 <= 262140
            assert(v969, "value is more than 262140!")
            local v970 = buffer.readstring
            local v971 = v_u_9
            local v972 = v_u_10
            v_u_10 = v_u_10 + v967
            v962.payload = v970(v971, v972, v967)
            local v973 = utf8.len(v962.payload) ~= nil
            assert(v973, "value is not valid utf-8")
            local v974 = v_u_35[50][v961]
            if v974 then
                task.spawn(v974, v962)
            end
            v_u_35[50][v961] = nil
        elseif v43 == 51 then
            local v975 = v_u_9
            local v976 = v_u_10
            v_u_10 = v_u_10 + 1
            local v977 = buffer.readu8(v975, v976)
            local v978 = {}
            local v979 = v_u_9
            local v980 = v_u_10
            v_u_10 = v_u_10 + 2
            local v981 = buffer.readu16(v979, v980)
            local v982 = v981 >= 0
            assert(v982, "value is less than 0!")
            local v983 = v981 <= 32768
            assert(v983, "value is more than 32768!")
            local v984 = buffer.readstring
            local v985 = v_u_9
            local v986 = v_u_10
            v_u_10 = v_u_10 + v981
            v978.payload = v984(v985, v986, v981)
            local v987 = utf8.len(v978.payload) ~= nil
            assert(v987, "value is not valid utf-8")
            local v988 = v_u_35[51][v977]
            if v988 then
                task.spawn(v988, v978)
            end
            v_u_35[51][v977] = nil
        elseif v43 == 48 then
            local v989 = v_u_9
            local v990 = v_u_10
            v_u_10 = v_u_10 + 1
            local v991 = buffer.readu8(v989, v990)
            local v992 = {}
            local v993 = v_u_9
            local v994 = v_u_10
            v_u_10 = v_u_10 + 2
            local v995 = buffer.readu16(v993, v994)
            local v996 = v995 >= 0
            assert(v996, "value is less than 0!")
            local v997 = v995 <= 480
            assert(v997, "value is more than 480!")
            local v998 = buffer.readstring
            local v999 = v_u_9
            local v1000 = v_u_10
            v_u_10 = v_u_10 + v995
            v992.footer = v998(v999, v1000, v995)
            local v1001 = utf8.len(v992.footer) ~= nil
            assert(v1001, "value is not valid utf-8")
            local v1002 = v_u_35[48][v991]
            if v1002 then
                task.spawn(v1002, v992)
            end
            v_u_35[48][v991] = nil
        elseif v43 == 60 then
            local v1003 = v_u_9
            local v1004 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1005 = buffer.readu8(v1003, v1004)
            local v1006 = v_u_9
            local v1007 = v_u_10
            v_u_10 = v_u_10 + 2
            local v1008 = buffer.readu16(v1006, v1007)
            local v1009 = v1008 >= 0
            assert(v1009, "value is less than 0!")
            local v1010 = v1008 <= 32768
            assert(v1010, "value is more than 32768!")
            local v1011 = buffer.readstring
            local v1012 = v_u_9
            local v1013 = v_u_10
            v_u_10 = v_u_10 + v1008
            local v1014 = v1011(v1012, v1013, v1008)
            local v1015 = utf8.len(v1014) ~= nil
            assert(v1015, "value is not valid utf-8")
            local v1016 = v_u_35[60][v1005]
            if v1016 then
                task.spawn(v1016, v1014)
            end
            v_u_35[60][v1005] = nil
        elseif v43 == 69 then
            local v1017 = v_u_9
            local v1018 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1019 = buffer.readu8(v1017, v1018)
            local v1020 = v_u_9
            local v1021 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1022 = buffer.readu8(v1020, v1021)
            local v1023 = {}
            if bit32.btest(v1022, 1) then
                v1023.res = "ok"
            elseif bit32.btest(v1022, 2) then
                v1023.res = "too_early"
            elseif bit32.btest(v1022, 4) then
                v1023.res = "claimed"
            elseif bit32.btest(v1022, 8) then
                v1023.res = "disabled"
            elseif bit32.btest(v1022, 16) then
                v1023.res = "full"
            elseif bit32.btest(v1022, 32) then
                v1023.res = "err"
            end
            local v1024 = v_u_35[69][v1019]
            if v1024 then
                task.spawn(v1024, v1023)
            end
            v_u_35[69][v1019] = nil
        elseif v43 == 58 then
            local v1025 = v_u_9
            local v1026 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1027 = buffer.readu8(v1025, v1026)
            local v1028 = {}
            local v1029 = v_u_9
            local v1030 = v_u_10
            v_u_10 = v_u_10 + 1
            v1028.res = buffer.readu8(v1029, v1030)
            local v1031 = v_u_9
            local v1032 = v_u_10
            v_u_10 = v_u_10 + 1
            v1028.stat = buffer.readu8(v1031, v1032)
            local v1033 = v_u_9
            local v1034 = v_u_10
            v_u_10 = v_u_10 + 1
            v1028.tier = buffer.readu8(v1033, v1034)
            local v1035 = v_u_9
            local v1036 = v_u_10
            v_u_10 = v_u_10 + 8
            v1028.embers = buffer.readf64(v1035, v1036)
            local v1037 = v_u_35[58][v1027]
            if v1037 then
                task.spawn(v1037, v1028)
            end
            v_u_35[58][v1027] = nil
        elseif v43 == 57 then
            local v1038 = v_u_9
            local v1039 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1040 = buffer.readu8(v1038, v1039)
            local v1041 = {}
            local v1042 = v_u_9
            local v1043 = v_u_10
            v_u_10 = v_u_10 + 1
            v1041.res = buffer.readu8(v1042, v1043)
            local v1044 = v_u_9
            local v1045 = v_u_10
            v_u_10 = v_u_10 + 2
            v1041.itemId = buffer.readu16(v1044, v1045)
            local v1046 = v_u_9
            local v1047 = v_u_10
            v_u_10 = v_u_10 + 8
            v1041.embers = buffer.readf64(v1046, v1047)
            local v1048 = v_u_35[57][v1040]
            if v1048 then
                task.spawn(v1048, v1041)
            end
            v_u_35[57][v1040] = nil
        elseif v43 == 46 then
            local v1049 = v_u_9
            local v1050 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1051 = buffer.readu8(v1049, v1050)
            local v1052 = {}
            local v1053 = v_u_9
            local v1054 = v_u_10
            v_u_10 = v_u_10 + 1
            v1052.res = buffer.readu8(v1053, v1054)
            local v1055 = v_u_35[46][v1051]
            if v1055 then
                task.spawn(v1055, v1052)
            end
            v_u_35[46][v1051] = nil
        elseif v43 == 67 then
            local v1056 = v_u_9
            local v1057 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1058 = buffer.readu8(v1056, v1057)
            local v1059 = {}
            local v1060 = v_u_9
            local v1061 = v_u_10
            v_u_10 = v_u_10 + 1
            v1059.res = buffer.readu8(v1060, v1061)
            local v1062 = v_u_35[67][v1058]
            if v1062 then
                task.spawn(v1062, v1059)
            end
            v_u_35[67][v1058] = nil
        elseif v43 == 61 then
            local v1063 = v_u_9
            local v1064 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1065 = buffer.readu8(v1063, v1064)
            local v1066 = {}
            local v1067 = v_u_9
            local v1068 = v_u_10
            v_u_10 = v_u_10 + 1
            v1066.res = buffer.readu8(v1067, v1068)
            local v1069 = v_u_35[61][v1065]
            if v1069 then
                task.spawn(v1069, v1066)
            end
            v_u_35[61][v1065] = nil
        elseif v43 == 62 then
            local v1070 = v_u_9
            local v1071 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1072 = buffer.readu8(v1070, v1071)
            local v1073 = v_u_9
            local v1074 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1075 = buffer.readu8(v1073, v1074)
            local v1076 = {
                ["ok"] = bit32.btest(v1075, 1)
            }
            local v1077 = v_u_9
            local v1078 = v_u_10
            v_u_10 = v_u_10 + 2
            local v1079 = buffer.readu16(v1077, v1078)
            local v1080 = v1079 >= 0
            assert(v1080, "value is less than 0!")
            local v1081 = v1079 <= 32768
            assert(v1081, "value is more than 32768!")
            local v1082 = buffer.readstring
            local v1083 = v_u_9
            local v1084 = v_u_10
            v_u_10 = v_u_10 + v1079
            v1076.payload = v1082(v1083, v1084, v1079)
            local v1085 = utf8.len(v1076.payload) ~= nil
            assert(v1085, "value is not valid utf-8")
            local v1086 = v_u_35[62][v1072]
            if v1086 then
                task.spawn(v1086, v1076)
            end
            v_u_35[62][v1072] = nil
        elseif v43 == 63 then
            local v1087 = v_u_9
            local v1088 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1089 = buffer.readu8(v1087, v1088)
            local v1090 = {}
            local v1091 = v_u_9
            local v1092 = v_u_10
            v_u_10 = v_u_10 + 4
            local v1093 = buffer.readu32(v1091, v1092)
            local v1094 = v1093 >= 0
            assert(v1094, "value is less than 0!")
            local v1095 = v1093 <= 65536
            assert(v1095, "value is more than 65536!")
            local v1096 = buffer.readstring
            local v1097 = v_u_9
            local v1098 = v_u_10
            v_u_10 = v_u_10 + v1093
            v1090.payload = v1096(v1097, v1098, v1093)
            local v1099 = utf8.len(v1090.payload) ~= nil
            assert(v1099, "value is not valid utf-8")
            local v1100 = v_u_35[63][v1089]
            if v1100 then
                task.spawn(v1100, v1090)
            end
            v_u_35[63][v1089] = nil
        elseif v43 == 59 then
            local v1101 = v_u_9
            local v1102 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1103 = buffer.readu8(v1101, v1102)
            local v1104 = v_u_9
            local v1105 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1106 = buffer.readu8(v1104, v1105)
            local v1107 = {}
            if bit32.btest(v1106, 1) then
                v1107.status = "ok"
            elseif bit32.btest(v1106, 2) then
                v1107.status = "none"
            elseif bit32.btest(v1106, 4) then
                v1107.status = "err"
            end
            local v1108 = v_u_9
            local v1109 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1110 = buffer.readu8(v1108, v1109) + 1
            local v1111 = v1110 >= 1
            assert(v1111, "value is less than 1!")
            local v1112 = v1110 <= 96
            assert(v1112, "value is more than 96!")
            local v1113 = buffer.readstring
            local v1114 = v_u_9
            local v1115 = v_u_10
            v_u_10 = v_u_10 + v1110
            v1107.xp = v1113(v1114, v1115, v1110)
            local v1116 = utf8.len(v1107.xp) ~= nil
            assert(v1116, "value is not valid utf-8")
            local v1117 = v_u_9
            local v1118 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1119 = buffer.readu8(v1117, v1118) + 1
            local v1120 = v1119 >= 1
            assert(v1120, "value is less than 1!")
            local v1121 = v1119 <= 96
            assert(v1121, "value is more than 96!")
            local v1122 = buffer.readstring
            local v1123 = v_u_9
            local v1124 = v_u_10
            v_u_10 = v_u_10 + v1119
            v1107.gold = v1122(v1123, v1124, v1119)
            local v1125 = utf8.len(v1107.gold) ~= nil
            assert(v1125, "value is not valid utf-8")
            local v1126 = v_u_35[59][v1103]
            if v1126 then
                task.spawn(v1126, v1107)
            end
            v_u_35[59][v1103] = nil
        elseif v43 == 66 then
            local v1127 = v_u_9
            local v1128 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1129 = buffer.readu8(v1127, v1128)
            local v1130 = {}
            local v1131 = v_u_9
            local v1132 = v_u_10
            v_u_10 = v_u_10 + 2
            local v1133 = buffer.readu16(v1131, v1132)
            v1130.targets = table.create(v1133)
            for v1134 = 1, v1133 do
                local v1135 = {}
                local v1136 = v_u_9
                local v1137 = v_u_10
                v_u_10 = v_u_10 + 8
                v1135.id = buffer.readf64(v1136, v1137)
                local v1138 = v_u_9
                local v1139 = v_u_10
                v_u_10 = v_u_10 + 1
                v1135.res = buffer.readu8(v1138, v1139)
                v1130.targets[v1134] = v1135
            end
            local v1140 = v_u_35[66][v1129]
            if v1140 then
                task.spawn(v1140, v1130)
            end
            v_u_35[66][v1129] = nil
        elseif v43 == 65 then
            local v1141 = v_u_9
            local v1142 = v_u_10
            v_u_10 = v_u_10 + 1
            local v1143 = buffer.readu8(v1141, v1142)
            local v1144 = {}
            local v1145 = v_u_9
            local v1146 = v_u_10
            v_u_10 = v_u_10 + 1
            v1144.res = buffer.readu8(v1145, v1146)
            local v1147 = v_u_35[65][v1143]
            if v1147 then
                task.spawn(v1147, v1144)
            end
            v_u_35[65][v1143] = nil
        else
            error("Unknown event id")
        end
    end
end)
v_u_26[4].OnClientEvent:Connect(function(p1148, p1149)
    -- upvalues: (ref) v_u_9, (ref) v_u_11, (ref) v_u_10, (ref) v_u_12, (copy) v_u_36, (copy) v_u_37
    v_u_9 = p1148
    v_u_11 = p1149
    v_u_10 = 0
    v_u_12 = 0
    local v1150 = v_u_9
    local v1151 = v_u_10
    v_u_10 = v_u_10 + 1
    local v1152 = buffer.readu8(v1150, v1151)
    local v1153 = {}
    v_u_12 = v_u_12 + 1
    v1153.owner = v_u_11[v_u_12]
    local v1154 = v1153.owner ~= nil
    assert(v1154, "received instance is nil!")
    local v1155 = v1153.owner:IsA("Player")
    assert(v1155, "received instance is not of the Player class!")
    local v1156 = v_u_9
    local v1157 = v_u_10
    v_u_10 = v_u_10 + 1
    v1153.bat = buffer.readu8(v1156, v1157)
    if bit32.btest(v1152, 1) then
        v_u_12 = v_u_12 + 1
        v1153.target = v_u_11[v_u_12]
    else
        v1153.target = nil
    end
    local v1158 = v_u_9
    local v1159 = v_u_10
    v_u_10 = v_u_10 + 4
    local v1160 = buffer.readf32(v1158, v1159)
    local v1161 = v_u_9
    local v1162 = v_u_10
    v_u_10 = v_u_10 + 4
    local v1163 = buffer.readf32(v1161, v1162)
    local v1164 = v_u_9
    local v1165 = v_u_10
    v_u_10 = v_u_10 + 4
    local v1166 = buffer.readf32(v1164, v1165)
    v1153.at = Vector3.new(v1160, v1163, v1166)
    local v1167 = v_u_9
    local v1168 = v_u_10
    v_u_10 = v_u_10 + 4
    v1153.fly = buffer.readf32(v1167, v1168)
    if v_u_36[3][1] then
        for _, v1169 in v_u_36[3] do
            task.spawn(v1169, v1153)
        end
    else
        local v1170 = v_u_37[3]
        table.insert(v1170, v1153)
        if #v_u_37[3] > 64 then
            warn((("[ZAP] %* events in queue for SwarmBite. Did you forget to attach a listener?"):format(#v_u_37[3])))
        end
    end
end)
v_u_26[1].OnClientEvent:Connect(function(p1171, p1172)
    -- upvalues: (ref) v_u_9, (ref) v_u_11, (ref) v_u_10, (ref) v_u_12, (copy) v_u_36, (copy) v_u_37
    v_u_9 = p1171
    v_u_11 = p1172
    v_u_10 = 0
    v_u_12 = 0
    local v1173 = {}
    v_u_12 = v_u_12 + 1
    v1173.player = v_u_11[v_u_12]
    local v1174 = v1173.player ~= nil
    assert(v1174, "received instance is nil!")
    local v1175 = v1173.player:IsA("Player")
    assert(v1175, "received instance is not of the Player class!")
    local v1176 = v_u_9
    local v1177 = v_u_10
    v_u_10 = v_u_10 + 8
    v1173.pitch = buffer.readf64(v1176, v1177)
    if v_u_36[0][1] then
        for _, v1178 in v_u_36[0] do
            task.spawn(v1178, v1173)
        end
    else
        local v1179 = v_u_37[0]
        table.insert(v1179, v1173)
        if #v_u_37[0] > 64 then
            warn((("[ZAP] %* events in queue for PlayerPitchToClient. Did you forget to attach a listener?"):format(#v_u_37[0])))
        end
    end
end)
v_u_26[2].OnClientEvent:Connect(function(p1180, p1181)
    -- upvalues: (ref) v_u_9, (ref) v_u_11, (ref) v_u_10, (ref) v_u_12, (copy) v_u_36, (copy) v_u_37
    v_u_9 = p1180
    v_u_11 = p1181
    v_u_10 = 0
    v_u_12 = 0
    local v1182 = v_u_9
    local v1183 = v_u_10
    v_u_10 = v_u_10 + 1
    local v1184 = buffer.readu8(v1182, v1183)
    local v1185
    if bit32.btest(v1184, 1) then
        v_u_12 = v_u_12 + 1
        v1185 = v_u_11[v_u_12]
    else
        v1185 = nil
    end
    if v_u_36[1][1] then
        for _, v1186 in v_u_36[1] do
            task.spawn(v1186, v1185)
        end
    else
        local v1187 = v_u_37[1]
        table.insert(v1187, v1185)
        if #v_u_37[1] > 64 then
            warn((("[ZAP] %* events in queue for HalloweenDoorOpened. Did you forget to attach a listener?"):format(#v_u_37[1])))
        end
    end
end)
v_u_26[5].OnClientEvent:Connect(function(p1188, p1189)
    -- upvalues: (ref) v_u_9, (ref) v_u_11, (ref) v_u_10, (ref) v_u_12, (copy) v_u_36, (copy) v_u_37
    v_u_9 = p1188
    v_u_11 = p1189
    v_u_10 = 0
    v_u_12 = 0
    local v1190 = v_u_9
    local v1191 = v_u_10
    v_u_10 = v_u_10 + 1
    local v1192 = buffer.readu8(v1190, v1191)
    local v1193 = {}
    v_u_12 = v_u_12 + 1
    v1193.player = v_u_11[v_u_12]
    local v1194 = v1193.player ~= nil
    assert(v1194, "received instance is nil!")
    local v1195 = v1193.player:IsA("Player")
    assert(v1195, "received instance is not of the Player class!")
    if bit32.btest(v1192, 1) then
        v1193.currency = "gold"
    elseif bit32.btest(v1192, 2) then
        v1193.currency = "tokens"
    elseif bit32.btest(v1192, 4) then
        v1193.currency = "quest"
    elseif bit32.btest(v1192, 8) then
        v1193.currency = "embers"
    elseif bit32.btest(v1192, 16) then
        v1193.currency = "pumpkins"
    end
    local v1196 = v_u_9
    local v1197 = v_u_10
    v_u_10 = v_u_10 + 1
    v1193.pack = buffer.readu8(v1196, v1197)
    if v_u_36[4][1] then
        for _, v1198 in v_u_36[4] do
            task.spawn(v1198, v1193)
        end
    else
        local v1199 = v_u_37[4]
        table.insert(v1199, v1193)
        if #v_u_37[4] > 64 then
            warn((("[ZAP] %* events in queue for CurrencyPackBurst. Did you forget to attach a listener?"):format(#v_u_37[4])))
        end
    end
end)
v_u_26[3].OnClientEvent:Connect(function(p1200, p1201)
    -- upvalues: (ref) v_u_9, (ref) v_u_11, (ref) v_u_10, (ref) v_u_12, (copy) v_u_36, (copy) v_u_37
    v_u_9 = p1200
    v_u_11 = p1201
    v_u_10 = 0
    v_u_12 = 0
    local v1202 = v_u_9
    local v1203 = v_u_10
    v_u_10 = v_u_10 + 1
    local v1204 = buffer.readu8(v1202, v1203)
    local v1205 = {}
    v_u_12 = v_u_12 + 1
    v1205.owner = v_u_11[v_u_12]
    local v1206 = v1205.owner ~= nil
    assert(v1206, "received instance is nil!")
    local v1207 = v1205.owner:IsA("Player")
    assert(v1207, "received instance is not of the Player class!")
    if bit32.btest(v1204, 1) then
        v_u_12 = v_u_12 + 1
        v1205.target = v_u_11[v_u_12]
    else
        v1205.target = nil
    end
    local v1208 = v_u_9
    local v1209 = v_u_10
    v_u_10 = v_u_10 + 4
    local v1210 = buffer.readf32(v1208, v1209)
    local v1211 = v_u_9
    local v1212 = v_u_10
    v_u_10 = v_u_10 + 4
    local v1213 = buffer.readf32(v1211, v1212)
    local v1214 = v_u_9
    local v1215 = v_u_10
    v_u_10 = v_u_10 + 4
    local v1216 = buffer.readf32(v1214, v1215)
    v1205.at = Vector3.new(v1210, v1213, v1216)
    v1205.quick = bit32.btest(v1204, 2)
    local v1217 = v_u_9
    local v1218 = v_u_10
    v_u_10 = v_u_10 + 4
    v1205.fly = buffer.readf32(v1217, v1218)
    if v_u_36[2][1] then
        for _, v1219 in v_u_36[2] do
            task.spawn(v1219, v1205)
        end
    else
        local v1220 = v_u_37[2]
        table.insert(v1220, v1205)
        if #v_u_37[2] > 64 then
            warn((("[ZAP] %* events in queue for BatBite. Did you forget to attach a listener?"):format(#v_u_37[2])))
        end
    end
end)
table.freeze(v18)
table.freeze(v19)
local v1891 = {
    ["SendEvents"] = v33,
    ["VotePoll"] = {
        ["Call"] = function(p1221)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[52][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1222 = v_u_3
            local v1223 = v_u_7
            buffer.writeu8(v1222, v1223, 31)
            v_u_16(1)
            local v1224 = v_u_3
            local v1225 = v_u_7
            local v1226 = v_u_38
            buffer.writeu8(v1224, v1225, v1226)
            local v1227 = #p1221.pollId
            local v1228 = v1227 >= 1
            assert(v1228, "value is less than 1!")
            local v1229 = v1227 <= 96
            assert(v1229, "value is more than 96!")
            local v1230 = utf8.len(p1221.pollId) ~= nil
            assert(v1230, "value is not valid utf-8")
            v_u_16(1)
            local v1231 = v_u_3
            local v1232 = v_u_7
            local v1233 = v1227 - 1
            buffer.writeu8(v1231, v1232, v1233)
            v_u_16(v1227)
            buffer.writestring(v_u_3, v_u_7, p1221.pollId, v1227)
            local v1234 = #p1221.options
            local v1235 = v1234 >= 0
            assert(v1235, "value is less than 0!")
            local v1236 = v1234 <= 8
            assert(v1236, "value is more than 8!")
            v_u_16(1)
            local v1237 = v_u_3
            local v1238 = v_u_7
            buffer.writeu8(v1237, v1238, v1234)
            for v1239 = 1, v1234 do
                local v1240 = p1221.options[v1239]
                v_u_16(1)
                local v1241 = v_u_3
                local v1242 = v_u_7
                buffer.writeu8(v1241, v1242, v1240)
            end
            v_u_35[52][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["UpdateNotesChanged"] = {
        ["On"] = function(p_u_1243)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1244 = v_u_34[12]
            table.insert(v1244, p_u_1243)
            for _, v1245 in v_u_35[12] do
                task.spawn(p_u_1243, v1245)
            end
            v_u_35[12] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1243
                table.remove(v_u_34[12], table.find(v_u_34[12], p_u_1243))
            end
        end
    },
    ["TrainClick"] = {
        ["Fire"] = function()
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1246 = v_u_3
            local v1247 = v_u_7
            buffer.writeu8(v1246, v1247, 12)
        end
    },
    ["SwarmBite"] = {
        ["On"] = function(p_u_1248)
            -- upvalues: (copy) v_u_36, (copy) v_u_37
            local v1249 = v_u_36[3]
            table.insert(v1249, p_u_1248)
            for _, v1250 in v_u_37[3] do
                task.spawn(p_u_1248, v1250)
            end
            v_u_37[3] = {}
            return function()
                -- upvalues: (ref) v_u_36, (copy) p_u_1248
                table.remove(v_u_36[3], table.find(v_u_36[3], p_u_1248))
            end
        end
    },
    ["ShowToast"] = {
        ["On"] = function(p_u_1251)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1252 = v_u_34[9]
            table.insert(v1252, p_u_1251)
            for _, v1253 in v_u_35[9] do
                task.spawn(p_u_1251, v1253)
            end
            v_u_35[9] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1251
                table.remove(v_u_34[9], table.find(v_u_34[9], p_u_1251))
            end
        end
    },
    ["SetWingsEquipped"] = {
        ["Fire"] = function(p1254)
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1255 = v_u_3
            local v1256 = v_u_7
            buffer.writeu8(v1255, v1256, 21)
            local v1257 = 0
            local v1258 = v_u_16(1)
            local v1259 = #p1254.key
            local v1260 = v1259 >= 1
            assert(v1260, "value is less than 1!")
            local v1261 = v1259 <= 128
            assert(v1261, "value is more than 128!")
            local v1262 = utf8.len(p1254.key) ~= nil
            assert(v1262, "value is not valid utf-8")
            v_u_16(1)
            local v1263 = v_u_3
            local v1264 = v_u_7
            local v1265 = v1259 - 1
            buffer.writeu8(v1263, v1264, v1265)
            v_u_16(v1259)
            buffer.writestring(v_u_3, v_u_7, p1254.key, v1259)
            if p1254.equip then
                v1257 = bit32.bor(v1257, 1)
            end
            local v1266 = v_u_3
            buffer.writeu8(v1266, v1258, v1257)
        end
    },
    ["SetMountRiding"] = {
        ["Call"] = function(p1267)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[70][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1268 = v_u_3
            local v1269 = v_u_7
            buffer.writeu8(v1268, v1269, 49)
            v_u_16(1)
            local v1270 = v_u_3
            local v1271 = v_u_7
            local v1272 = v_u_38
            buffer.writeu8(v1270, v1271, v1272)
            local v1273 = 0
            local v1274 = v_u_16(1)
            if p1267.ride then
                v1273 = bit32.bor(v1273, 1)
            end
            local v1275 = v_u_3
            buffer.writeu8(v1275, v1274, v1273)
            v_u_35[70][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["SetHideGainPopups"] = {
        ["Fire"] = function(p1276)
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1277 = v_u_3
            local v1278 = v_u_7
            buffer.writeu8(v1277, v1278, 1)
            local v1279 = 0
            local v1280 = v_u_16(1)
            if p1276 then
                v1279 = bit32.bor(v1279, 1)
            end
            local v1281 = v_u_3
            buffer.writeu8(v1281, v1280, v1279)
        end
    },
    ["SetHideChestButton"] = {
        ["Fire"] = function(p1282)
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1283 = v_u_3
            local v1284 = v_u_7
            buffer.writeu8(v1283, v1284, 0)
            local v1285 = 0
            local v1286 = v_u_16(1)
            if p1282 then
                v1285 = bit32.bor(v1285, 1)
            end
            local v1287 = v_u_3
            buffer.writeu8(v1287, v1286, v1285)
        end
    },
    ["SetAutoRebirth"] = {
        ["Fire"] = function(p1288)
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1289 = v_u_3
            local v1290 = v_u_7
            buffer.writeu8(v1289, v1290, 2)
            local v1291 = 0
            local v1292 = v_u_16(1)
            if p1288 then
                v1291 = bit32.bor(v1291, 1)
            end
            local v1293 = v_u_3
            buffer.writeu8(v1293, v1292, v1291)
        end
    },
    ["SetAdminPrefs"] = {
        ["Fire"] = function(p1294)
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1295 = v_u_3
            local v1296 = v_u_7
            buffer.writeu8(v1295, v1296, 17)
            local v1297 = #p1294
            local v1298 = v1297 >= 0
            assert(v1298, "value is less than 0!")
            local v1299 = v1297 <= 32768
            assert(v1299, "value is more than 32768!")
            local v1300 = utf8.len(p1294) ~= nil
            assert(v1300, "value is not valid utf-8")
            v_u_16(2)
            local v1301 = v_u_3
            local v1302 = v_u_7
            buffer.writeu16(v1301, v1302, v1297)
            v_u_16(v1297)
            buffer.writestring(v_u_3, v_u_7, p1294, v1297)
        end
    },
    ["RedeemCode"] = {
        ["Call"] = function(p1303)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[47][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1304 = v_u_3
            local v1305 = v_u_7
            buffer.writeu8(v1304, v1305, 26)
            v_u_16(1)
            local v1306 = v_u_3
            local v1307 = v_u_7
            local v1308 = v_u_38
            buffer.writeu8(v1306, v1307, v1308)
            local v1309 = #p1303.code
            local v1310 = v1309 >= 1
            assert(v1310, "value is less than 1!")
            local v1311 = v1309 <= 160
            assert(v1311, "value is more than 160!")
            local v1312 = utf8.len(p1303.code) ~= nil
            assert(v1312, "value is not valid utf-8")
            v_u_16(1)
            local v1313 = v_u_3
            local v1314 = v_u_7
            local v1315 = v1309 - 1
            buffer.writeu8(v1313, v1314, v1315)
            v_u_16(v1309)
            buffer.writestring(v_u_3, v_u_7, p1303.code, v1309)
            v_u_35[47][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["QuestLineState"] = {
        ["On"] = function(p_u_1316)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1317 = v_u_34[5]
            table.insert(v1317, p_u_1316)
            for _, v1318 in v_u_35[5] do
                task.spawn(p_u_1316, v1318)
            end
            v_u_35[5] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1316
                table.remove(v_u_34[5], table.find(v_u_34[5], p_u_1316))
            end
        end
    },
    ["QuestLineRequest"] = {
        ["Fire"] = function()
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1319 = v_u_3
            local v1320 = v_u_7
            buffer.writeu8(v1319, v1320, 15)
        end
    },
    ["PollsChanged"] = {
        ["On"] = function(p_u_1321)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1322 = v_u_34[13]
            table.insert(v1322, p_u_1321)
            for _, v1323 in v_u_35[13] do
                task.spawn(p_u_1321, v1323)
            end
            v_u_35[13] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1321
                table.remove(v_u_34[13], table.find(v_u_34[13], p_u_1321))
            end
        end
    },
    ["PlayerPitchToServer"] = {
        ["Fire"] = function(p1324)
            -- upvalues: (ref) v_u_3, (ref) v_u_4, (ref) v_u_5, (ref) v_u_6, (ref) v_u_8, (ref) v_u_13, (copy) v_u_17, (copy) v_u_16, (ref) v_u_7, (copy) v_u_26
            local v1325 = {
                ["buff"] = v_u_3,
                ["used"] = v_u_4,
                ["size"] = v_u_5,
                ["inst"] = v_u_6,
                ["outgoing_ids"] = v_u_8,
                ["incoming_ids"] = v_u_13
            }
            v_u_17()
            v_u_16(8)
            local v1326 = v_u_3
            local v1327 = v_u_7
            buffer.writef64(v1326, v1327, p1324)
            local v1328 = buffer.create(v_u_4)
            buffer.copy(v1328, 0, v_u_3, 0, v_u_4)
            v_u_26[1]:FireServer(v1328, v_u_6)
            v_u_3 = v1325.buff
            v_u_4 = v1325.used
            v_u_5 = v1325.size
            v_u_6 = v1325.inst
            v_u_8 = v1325.outgoing_ids
            v_u_13 = v1325.incoming_ids
        end
    },
    ["PlayerPitchToClient"] = {
        ["On"] = function(p_u_1329)
            -- upvalues: (copy) v_u_36, (copy) v_u_37
            local v1330 = v_u_36[0]
            table.insert(v1330, p_u_1329)
            for _, v1331 in v_u_37[0] do
                task.spawn(p_u_1329, v1331)
            end
            v_u_37[0] = {}
            return function()
                -- upvalues: (ref) v_u_36, (copy) p_u_1329
                table.remove(v_u_36[0], table.find(v_u_36[0], p_u_1329))
            end
        end
    },
    ["PetAttackPreview"] = {
        ["On"] = function(p_u_1332)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1333 = v_u_34[39]
            table.insert(v1333, p_u_1332)
            for _, v1334 in v_u_35[39] do
                task.spawn(p_u_1332, v1334)
            end
            v_u_35[39] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1332
                table.remove(v_u_34[39], table.find(v_u_34[39], p_u_1332))
            end
        end
    },
    ["OpenCrates"] = {
        ["Call"] = function(p1335)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[45][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1336 = v_u_3
            local v1337 = v_u_7
            buffer.writeu8(v1336, v1337, 24)
            v_u_16(1)
            local v1338 = v_u_3
            local v1339 = v_u_7
            local v1340 = v_u_38
            buffer.writeu8(v1338, v1339, v1340)
            local v1341 = 0
            local v1342 = v_u_16(1)
            if p1335.kind == "wpn_legendary" then
                v1341 = bit32.bor(v1341, 1)
            elseif p1335.kind == "wpn_mythic" then
                v1341 = bit32.bor(v1341, 2)
            elseif p1335.kind == "skin_legendary" then
                v1341 = bit32.bor(v1341, 4)
            elseif p1335.kind == "skin_mythic" then
                v1341 = bit32.bor(v1341, 8)
            elseif p1335.kind == "pet" then
                v1341 = bit32.bor(v1341, 16)
            elseif p1335.kind == "artifact" then
                v1341 = bit32.bor(v1341, 32)
            else
                error("Invalid enumerator")
            end
            v_u_16(2)
            local v1343 = v_u_3
            local v1344 = v_u_7
            local v1345 = p1335.id
            buffer.writeu16(v1343, v1344, v1345)
            v_u_16(1)
            local v1346 = v_u_3
            local v1347 = v_u_7
            local v1348 = p1335.count
            buffer.writeu8(v1346, v1347, v1348)
            v_u_16(1)
            local v1349 = v_u_3
            local v1350 = v_u_7
            local v1351 = p1335.autosellIdx
            buffer.writeu8(v1349, v1350, v1351)
            local v1352 = v_u_3
            buffer.writeu8(v1352, v1342, v1341)
            v_u_35[45][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["OpenChests"] = {
        ["Call"] = function(p1353)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[44][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1354 = v_u_3
            local v1355 = v_u_7
            buffer.writeu8(v1354, v1355, 23)
            v_u_16(1)
            local v1356 = v_u_3
            local v1357 = v_u_7
            local v1358 = v_u_38
            buffer.writeu8(v1356, v1357, v1358)
            local v1359 = 0
            local v1360 = v_u_16(1)
            if p1353.crate ~= nil then
                v1359 = bit32.bor(v1359, 1)
                if p1353.crate == "t1_wpn_crate" then
                    v1359 = bit32.bor(v1359, 2)
                elseif p1353.crate == "t2_wpn_crate" then
                    v1359 = bit32.bor(v1359, 4)
                elseif p1353.crate == "t3_wpn_crate" then
                    v1359 = bit32.bor(v1359, 8)
                elseif p1353.crate == "t1_skin_crate" then
                    v1359 = bit32.bor(v1359, 16)
                elseif p1353.crate == "t2_skin_crate" then
                    v1359 = bit32.bor(v1359, 32)
                elseif p1353.crate == "t3_skin_crate" then
                    v1359 = bit32.bor(v1359, 64)
                else
                    error("Invalid enumerator")
                end
            end
            v_u_16(1)
            local v1361 = v_u_3
            local v1362 = v_u_7
            local v1363 = p1353.count
            buffer.writeu8(v1361, v1362, v1363)
            local v1364 = v_u_3
            buffer.writeu8(v1364, v1360, v1359)
            v_u_35[44][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["OfflineRewardPending"] = {
        ["On"] = function(p_u_1365)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1366 = v_u_34[22]
            table.insert(v1366, p_u_1365)
            for _, v1367 in v_u_35[22] do
                task.spawn(p_u_1365, v1367)
            end
            v_u_35[22] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1365
                table.remove(v_u_34[22], table.find(v_u_34[22], p_u_1365))
            end
        end
    },
    ["MarkNotesSeen"] = {
        ["Fire"] = function(p1368)
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1369 = v_u_3
            local v1370 = v_u_7
            buffer.writeu8(v1369, v1370, 16)
            v_u_16(4)
            local v1371 = v_u_3
            local v1372 = v_u_7
            buffer.writeu32(v1371, v1372, p1368)
        end
    },
    ["LocalMotionCmd"] = {
        ["On"] = function(p_u_1373)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1374 = v_u_34[10]
            table.insert(v1374, p_u_1373)
            for _, v1375 in v_u_35[10] do
                task.spawn(p_u_1373, v1375)
            end
            v_u_35[10] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1373
                table.remove(v_u_34[10], table.find(v_u_34[10], p_u_1373))
            end
        end
    },
    ["LoadTiming"] = {
        ["Fire"] = function(p1376)
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1377 = v_u_3
            local v1378 = v_u_7
            buffer.writeu8(v1377, v1378, 14)
            v_u_16(1)
            local v1379 = v_u_3
            local v1380 = v_u_7
            local v1381 = p1376.metric
            buffer.writeu8(v1379, v1380, v1381)
            v_u_16(4)
            local v1382 = v_u_3
            local v1383 = v_u_7
            local v1384 = p1376.seconds
            buffer.writef32(v1382, v1383, v1384)
            v_u_16(1)
            local v1385 = v_u_3
            local v1386 = v_u_7
            local v1387 = p1376.device
            buffer.writeu8(v1385, v1386, v1387)
        end
    },
    ["LanternWeaponEarned"] = {
        ["On"] = function(p_u_1388)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1389 = v_u_34[37]
            table.insert(v1389, p_u_1388)
            for _, v1390 in v_u_35[37] do
                task.spawn(p_u_1388, v1390)
            end
            v_u_35[37] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1388
                table.remove(v_u_34[37], table.find(v_u_34[37], p_u_1388))
            end
        end
    },
    ["InventoryWeapons"] = {
        ["On"] = function(p_u_1391)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1392 = v_u_34[15]
            table.insert(v1392, p_u_1391)
            for _, v1393 in v_u_35[15] do
                task.spawn(p_u_1391, v1393)
            end
            v_u_35[15] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1391
                table.remove(v_u_34[15], table.find(v_u_34[15], p_u_1391))
            end
        end
    },
    ["InventoryUsePotion"] = {
        ["Call"] = function(p1394)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[56][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1395 = v_u_3
            local v1396 = v_u_7
            buffer.writeu8(v1395, v1396, 35)
            v_u_16(1)
            local v1397 = v_u_3
            local v1398 = v_u_7
            local v1399 = v_u_38
            buffer.writeu8(v1397, v1398, v1399)
            local v1400 = #p1394.potionId
            local v1401 = v1400 >= 1
            assert(v1401, "value is less than 1!")
            local v1402 = v1400 <= 80
            assert(v1402, "value is more than 80!")
            local v1403 = utf8.len(p1394.potionId) ~= nil
            assert(v1403, "value is not valid utf-8")
            v_u_16(1)
            local v1404 = v_u_3
            local v1405 = v_u_7
            local v1406 = v1400 - 1
            buffer.writeu8(v1404, v1405, v1406)
            v_u_16(v1400)
            buffer.writestring(v_u_3, v_u_7, p1394.potionId, v1400)
            v_u_35[56][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["InventorySkins"] = {
        ["On"] = function(p_u_1407)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1408 = v_u_34[16]
            table.insert(v1408, p_u_1407)
            for _, v1409 in v_u_35[16] do
                task.spawn(p_u_1407, v1409)
            end
            v_u_35[16] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1407
                table.remove(v_u_34[16], table.find(v_u_34[16], p_u_1407))
            end
        end
    },
    ["InventorySetAutoSellRule"] = {
        ["Call"] = function(p1410)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[54][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1411 = v_u_3
            local v1412 = v_u_7
            buffer.writeu8(v1411, v1412, 33)
            v_u_16(1)
            local v1413 = v_u_3
            local v1414 = v_u_7
            local v1415 = v_u_38
            buffer.writeu8(v1413, v1414, v1415)
            local v1416 = 0
            local v1417 = v_u_16(1)
            if p1410.typeId == "weapons" then
                v1416 = bit32.bor(v1416, 1)
            elseif p1410.typeId == "skins" then
                v1416 = bit32.bor(v1416, 2)
            elseif p1410.typeId == "pets" then
                v1416 = bit32.bor(v1416, 4)
            elseif p1410.typeId == "artifacts" then
                v1416 = bit32.bor(v1416, 8)
            else
                error("Invalid enumerator")
            end
            if p1410.enabled then
                v1416 = bit32.bor(v1416, 16)
            end
            v_u_16(1)
            local v1418 = v_u_3
            local v1419 = v_u_7
            local v1420 = p1410.cutTier
            buffer.writeu8(v1418, v1419, v1420)
            if p1410.keepEvent then
                v1416 = bit32.bor(v1416, 32)
            end
            if p1410.keepEvolveFuel then
                v1416 = bit32.bor(v1416, 64)
            end
            local v1421 = v_u_3
            buffer.writeu8(v1421, v1417, v1416)
            v_u_35[54][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["InventorySellBatch"] = {
        ["Call"] = function(p1422)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[55][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1423 = v_u_3
            local v1424 = v_u_7
            buffer.writeu8(v1423, v1424, 34)
            v_u_16(1)
            local v1425 = v_u_3
            local v1426 = v_u_7
            local v1427 = v_u_38
            buffer.writeu8(v1425, v1426, v1427)
            local v1428 = 0
            local v1429 = v_u_16(1)
            if p1422.itemType == "weapon" then
                v1428 = bit32.bor(v1428, 1)
            elseif p1422.itemType == "skin" then
                v1428 = bit32.bor(v1428, 2)
            elseif p1422.itemType == "pet" then
                v1428 = bit32.bor(v1428, 4)
            elseif p1422.itemType == "artifact" then
                v1428 = bit32.bor(v1428, 8)
            else
                error("Invalid enumerator")
            end
            local v1430 = #p1422.keys
            local v1431 = v1430 >= 1
            assert(v1431, "value is less than 1!")
            local v1432 = v1430 <= 500
            assert(v1432, "value is more than 500!")
            v_u_16(2)
            local v1433 = v_u_3
            local v1434 = v_u_7
            local v1435 = v1430 - 1
            buffer.writeu16(v1433, v1434, v1435)
            for v1436 = 1, v1430 do
                local v1437 = p1422.keys[v1436]
                local v1438 = #v1437
                local v1439 = v1438 >= 1
                assert(v1439, "value is less than 1!")
                local v1440 = v1438 <= 64
                assert(v1440, "value is more than 64!")
                local v1441 = utf8.len(v1437) ~= nil
                assert(v1441, "value is not valid utf-8")
                v_u_16(1)
                local v1442 = v_u_3
                local v1443 = v_u_7
                local v1444 = v1438 - 1
                buffer.writeu8(v1442, v1443, v1444)
                v_u_16(v1438)
                buffer.writestring(v_u_3, v_u_7, v1437, v1438)
            end
            local v1445 = v_u_3
            buffer.writeu8(v1445, v1429, v1428)
            v_u_35[55][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["InventoryPotions"] = {
        ["On"] = function(p_u_1446)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1447 = v_u_34[19]
            table.insert(v1447, p_u_1446)
            for _, v1448 in v_u_35[19] do
                task.spawn(p_u_1446, v1448)
            end
            v_u_35[19] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1446
                table.remove(v_u_34[19], table.find(v_u_34[19], p_u_1446))
            end
        end
    },
    ["InventoryPets"] = {
        ["On"] = function(p_u_1449)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1450 = v_u_34[14]
            table.insert(v1450, p_u_1449)
            for _, v1451 in v_u_35[14] do
                task.spawn(p_u_1449, v1451)
            end
            v_u_35[14] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1449
                table.remove(v_u_34[14], table.find(v_u_34[14], p_u_1449))
            end
        end
    },
    ["InventoryOp"] = {
        ["Call"] = function(p1452)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[53][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1453 = v_u_3
            local v1454 = v_u_7
            buffer.writeu8(v1453, v1454, 32)
            v_u_16(1)
            local v1455 = v_u_3
            local v1456 = v_u_7
            local v1457 = v_u_38
            buffer.writeu8(v1455, v1456, v1457)
            local v1458 = 0
            local v1459 = v_u_16(2)
            local v1460 = 0
            local v1461 = v_u_16(1)
            if p1452.itemType == "weapon" then
                v1458 = bit32.bor(v1458, 1)
            elseif p1452.itemType == "skin" then
                v1458 = bit32.bor(v1458, 2)
            elseif p1452.itemType == "pet" then
                v1458 = bit32.bor(v1458, 4)
            elseif p1452.itemType == "artifact" then
                v1458 = bit32.bor(v1458, 8)
            elseif p1452.itemType == "mount" then
                v1458 = bit32.bor(v1458, 16)
            elseif p1452.itemType == "cosmetic" then
                v1458 = bit32.bor(v1458, 32)
            else
                error("Invalid enumerator")
            end
            if p1452.action == "equip" then
                v1458 = bit32.bor(v1458, 64)
            elseif p1452.action == "offhand" then
                v1458 = bit32.bor(v1458, 128)
            elseif p1452.action == "unequip" then
                v1458 = bit32.bor(v1458, 256)
            elseif p1452.action == "sell" then
                v1458 = bit32.bor(v1458, 512)
            elseif p1452.action == "lock" then
                v1458 = bit32.bor(v1458, 1024)
            elseif p1452.action == "unlock" then
                v1458 = bit32.bor(v1458, 2048)
            elseif p1452.action == "evolve" then
                v1458 = bit32.bor(v1458, 4096)
            elseif p1452.action == "upgrade" then
                v1458 = bit32.bor(v1458, 8192)
            elseif p1452.action == "max_upgrade" then
                v1458 = bit32.bor(v1458, 16384)
            elseif p1452.action == "equip_best" then
                v1458 = bit32.bor(v1458, 32768)
            else
                error("Invalid enumerator")
            end
            local v1462 = #p1452.key
            local v1463 = v1462 >= 1
            assert(v1463, "value is less than 1!")
            local v1464 = v1462 <= 64
            assert(v1464, "value is more than 64!")
            local v1465 = utf8.len(p1452.key) ~= nil
            assert(v1465, "value is not valid utf-8")
            v_u_16(1)
            local v1466 = v_u_3
            local v1467 = v_u_7
            local v1468 = v1462 - 1
            buffer.writeu8(v1466, v1467, v1468)
            v_u_16(v1462)
            buffer.writestring(v_u_3, v_u_7, p1452.key, v1462)
            if p1452.count ~= nil then
                v1460 = bit32.bor(v1460, 1)
                v_u_16(2)
                local v1469 = v_u_3
                local v1470 = v_u_7
                local v1471 = p1452.count
                buffer.writeu16(v1469, v1470, v1471)
            end
            local v1472 = v_u_3
            buffer.writeu16(v1472, v1459, v1458)
            local v1473 = v_u_3
            buffer.writeu8(v1473, v1461, v1460)
            v_u_35[53][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["InventoryChests"] = {
        ["On"] = function(p_u_1474)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1475 = v_u_34[18]
            table.insert(v1475, p_u_1474)
            for _, v1476 in v_u_35[18] do
                task.spawn(p_u_1474, v1476)
            end
            v_u_35[18] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1474
                table.remove(v_u_34[18], table.find(v_u_34[18], p_u_1474))
            end
        end
    },
    ["InventoryAutoSell"] = {
        ["On"] = function(p_u_1477)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1478 = v_u_34[20]
            table.insert(v1478, p_u_1477)
            for _, v1479 in v_u_35[20] do
                task.spawn(p_u_1477, v1479)
            end
            v_u_35[20] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1477
                table.remove(v_u_34[20], table.find(v_u_34[20], p_u_1477))
            end
        end
    },
    ["InventoryArtifacts"] = {
        ["On"] = function(p_u_1480)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1481 = v_u_34[17]
            table.insert(v1481, p_u_1480)
            for _, v1482 in v_u_35[17] do
                task.spawn(p_u_1480, v1482)
            end
            v_u_35[17] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1480
                table.remove(v_u_34[17], table.find(v_u_34[17], p_u_1480))
            end
        end
    },
    ["HalloweenTeleport"] = {
        ["Call"] = function()
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[68][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1483 = v_u_3
            local v1484 = v_u_7
            buffer.writeu8(v1483, v1484, 47)
            v_u_16(1)
            local v1485 = v_u_3
            local v1486 = v_u_7
            local v1487 = v_u_38
            buffer.writeu8(v1485, v1486, v1487)
            v_u_35[68][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["HalloweenShopBuy"] = {
        ["Call"] = function(p1488)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[64][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1489 = v_u_3
            local v1490 = v_u_7
            buffer.writeu8(v1489, v1490, 43)
            v_u_16(1)
            local v1491 = v_u_3
            local v1492 = v_u_7
            local v1493 = v_u_38
            buffer.writeu8(v1491, v1492, v1493)
            local v1494 = 0
            local v1495 = v_u_16(2)
            if p1488.item == "mega_frank" then
                v1494 = bit32.bor(v1494, 1)
            elseif p1488.item == "pumpkin_reaper" then
                v1494 = bit32.bor(v1494, 2)
            elseif p1488.item == "vampire_bat" then
                v1494 = bit32.bor(v1494, 4)
            elseif p1488.item == "blood_moon_werewolf" then
                v1494 = bit32.bor(v1494, 8)
            elseif p1488.item == "crimson_mantle" then
                v1494 = bit32.bor(v1494, 16)
            elseif p1488.item == "crescent_reaver" then
                v1494 = bit32.bor(v1494, 32)
            elseif p1488.item == "alpha_werewolf" then
                v1494 = bit32.bor(v1494, 64)
            elseif p1488.item == "bloodmoon_bell" then
                v1494 = bit32.bor(v1494, 128)
            elseif p1488.item == "hearthwing" then
                v1494 = bit32.bor(v1494, 256)
            elseif p1488.item == "sporeback" then
                v1494 = bit32.bor(v1494, 512)
            else
                error("Invalid enumerator")
            end
            local v1496 = v_u_3
            buffer.writeu16(v1496, v1495, v1494)
            v_u_35[64][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["HalloweenDoorOpened"] = {
        ["On"] = function(p_u_1497)
            -- upvalues: (copy) v_u_36, (copy) v_u_37
            local v1498 = v_u_36[1]
            table.insert(v1498, p_u_1497)
            for _, v1499 in v_u_37[1] do
                task.spawn(p_u_1497, v1499)
            end
            v_u_37[1] = {}
            return function()
                -- upvalues: (ref) v_u_36, (copy) p_u_1497
                table.remove(v_u_36[1], table.find(v_u_36[1], p_u_1497))
            end
        end
    },
    ["HalloweenArrived"] = {
        ["On"] = function(p_u_1500)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1501 = v_u_34[34]
            table.insert(v1501, p_u_1500)
            for _, v1502 in v_u_35[34] do
                task.spawn(p_u_1500, v1502)
            end
            v_u_35[34] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1500
                table.remove(v_u_34[34], table.find(v_u_34[34], p_u_1500))
            end
        end
    },
    ["GiantRollSpin"] = {
        ["On"] = function(p_u_1503)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1504 = v_u_34[24]
            table.insert(v1504, p_u_1503)
            for _, v1505 in v_u_35[24] do
                task.spawn(p_u_1503, v1505)
            end
            v_u_35[24] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1503
                table.remove(v_u_34[24], table.find(v_u_34[24], p_u_1503))
            end
        end
    },
    ["GhostHit"] = {
        ["On"] = function(p_u_1506)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1507 = v_u_34[36]
            table.insert(v1507, p_u_1506)
            for _, v1508 in v_u_35[36] do
                task.spawn(p_u_1506, v1508)
            end
            v_u_35[36] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1506
                table.remove(v_u_34[36], table.find(v_u_34[36], p_u_1506))
            end
        end
    },
    ["GetUpdateNotes"] = {
        ["Call"] = function()
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[49][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1509 = v_u_3
            local v1510 = v_u_7
            buffer.writeu8(v1509, v1510, 28)
            v_u_16(1)
            local v1511 = v_u_3
            local v1512 = v_u_7
            local v1513 = v_u_38
            buffer.writeu8(v1511, v1512, v1513)
            v_u_35[49][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["GetPolls"] = {
        ["Call"] = function()
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[50][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1514 = v_u_3
            local v1515 = v_u_7
            buffer.writeu8(v1514, v1515, 29)
            v_u_16(1)
            local v1516 = v_u_3
            local v1517 = v_u_7
            local v1518 = v_u_38
            buffer.writeu8(v1516, v1517, v1518)
            v_u_35[50][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["GetPollResults"] = {
        ["Call"] = function()
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[51][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1519 = v_u_3
            local v1520 = v_u_7
            buffer.writeu8(v1519, v1520, 30)
            v_u_16(1)
            local v1521 = v_u_3
            local v1522 = v_u_7
            local v1523 = v_u_38
            buffer.writeu8(v1521, v1522, v1523)
            v_u_35[51][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["GetCodesInfo"] = {
        ["Call"] = function()
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[48][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1524 = v_u_3
            local v1525 = v_u_7
            buffer.writeu8(v1524, v1525, 27)
            v_u_16(1)
            local v1526 = v_u_3
            local v1527 = v_u_7
            local v1528 = v_u_38
            buffer.writeu8(v1526, v1527, v1528)
            v_u_35[48][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["GetAdminPrefs"] = {
        ["Call"] = function()
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[60][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1529 = v_u_3
            local v1530 = v_u_7
            buffer.writeu8(v1529, v1530, 39)
            v_u_16(1)
            local v1531 = v_u_3
            local v1532 = v_u_7
            local v1533 = v_u_38
            buffer.writeu8(v1531, v1532, v1533)
            v_u_35[60][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["GainPopup"] = {
        ["On"] = function(p_u_1534)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1535 = v_u_34[21]
            table.insert(v1535, p_u_1534)
            for _, v1536 in v_u_35[21] do
                task.spawn(p_u_1534, v1536)
            end
            v_u_35[21] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1534
                table.remove(v_u_34[21], table.find(v_u_34[21], p_u_1534))
            end
        end
    },
    ["FrostbitQuestState"] = {
        ["On"] = function(p_u_1537)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1538 = v_u_34[38]
            table.insert(v1538, p_u_1537)
            for _, v1539 in v_u_35[38] do
                task.spawn(p_u_1537, v1539)
            end
            v_u_35[38] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1537
                table.remove(v_u_34[38], table.find(v_u_34[38], p_u_1537))
            end
        end
    },
    ["FrostbitQuestRequest"] = {
        ["Fire"] = function()
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1540 = v_u_3
            local v1541 = v_u_7
            buffer.writeu8(v1540, v1541, 20)
        end
    },
    ["FrostbitQuestClaim"] = {
        ["Call"] = function()
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[69][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1542 = v_u_3
            local v1543 = v_u_7
            buffer.writeu8(v1542, v1543, 48)
            v_u_16(1)
            local v1544 = v_u_3
            local v1545 = v_u_7
            local v1546 = v_u_38
            buffer.writeu8(v1544, v1545, v1546)
            v_u_35[69][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["ForgeEnchant"] = {
        ["Call"] = function(p1547)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[58][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1548 = v_u_3
            local v1549 = v_u_7
            buffer.writeu8(v1548, v1549, 37)
            v_u_16(1)
            local v1550 = v_u_3
            local v1551 = v_u_7
            local v1552 = v_u_38
            buffer.writeu8(v1550, v1551, v1552)
            local v1553 = 0
            local v1554 = v_u_16(1)
            if p1547.itemType == "weapon" then
                v1553 = bit32.bor(v1553, 1)
            elseif p1547.itemType ~= "skin" then
                error("Invalid enumerator")
            end
            local v1555 = #p1547.key
            local v1556 = v1555 >= 1
            assert(v1556, "value is less than 1!")
            local v1557 = v1555 <= 64
            assert(v1557, "value is more than 64!")
            local v1558 = utf8.len(p1547.key) ~= nil
            assert(v1558, "value is not valid utf-8")
            v_u_16(1)
            local v1559 = v_u_3
            local v1560 = v_u_7
            local v1561 = v1555 - 1
            buffer.writeu8(v1559, v1560, v1561)
            v_u_16(v1555)
            buffer.writestring(v_u_3, v_u_7, p1547.key, v1555)
            local v1562 = v_u_3
            buffer.writeu8(v1562, v1554, v1553)
            v_u_35[58][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["ForgeCraft"] = {
        ["Call"] = function(p1563)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[57][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1564 = v_u_3
            local v1565 = v_u_7
            buffer.writeu8(v1564, v1565, 36)
            v_u_16(1)
            local v1566 = v_u_3
            local v1567 = v_u_7
            local v1568 = v_u_38
            buffer.writeu8(v1566, v1567, v1568)
            local v1569 = 0
            local v1570 = v_u_16(1)
            if p1563.tab == "weapon" then
                v1569 = bit32.bor(v1569, 1)
            elseif p1563.tab ~= "skin" then
                error("Invalid enumerator")
            end
            local v1571 = #p1563.items
            local v1572 = v1571 >= 1
            assert(v1572, "value is less than 1!")
            local v1573 = v1571 <= 4
            assert(v1573, "value is more than 4!")
            v_u_16(1)
            local v1574 = v_u_3
            local v1575 = v_u_7
            local v1576 = v1571 - 1
            buffer.writeu8(v1574, v1575, v1576)
            for v1577 = 1, v1571 do
                local v1578 = 0
                local v1579 = v_u_16(1)
                local v1580 = p1563.items[v1577]
                if v1580.itemType == "weapon" then
                    v1578 = bit32.bor(v1578, 1)
                elseif v1580.itemType ~= "skin" then
                    error("Invalid enumerator")
                end
                local v1581 = #v1580.key
                local v1582 = v1581 >= 1
                assert(v1582, "value is less than 1!")
                local v1583 = v1581 <= 64
                assert(v1583, "value is more than 64!")
                local v1584 = utf8.len(v1580.key) ~= nil
                assert(v1584, "value is not valid utf-8")
                v_u_16(1)
                local v1585 = v_u_3
                local v1586 = v_u_7
                local v1587 = v1581 - 1
                buffer.writeu8(v1585, v1586, v1587)
                v_u_16(v1581)
                buffer.writestring(v_u_3, v_u_7, v1580.key, v1581)
                local v1588 = v_u_3
                buffer.writeu8(v1588, v1579, v1578)
            end
            local v1589 = v_u_3
            buffer.writeu8(v1589, v1570, v1569)
            v_u_35[57][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["FishingStop"] = {
        ["Fire"] = function()
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1590 = v_u_3
            local v1591 = v_u_7
            buffer.writeu8(v1590, v1591, 4)
        end
    },
    ["FishingState"] = {
        ["On"] = function(p_u_1592)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1593 = v_u_34[3]
            table.insert(v1593, p_u_1592)
            for _, v1594 in v_u_35[3] do
                task.spawn(p_u_1592, v1594)
            end
            v_u_35[3] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1592
                table.remove(v_u_34[3], table.find(v_u_34[3], p_u_1592))
            end
        end
    },
    ["FishingStart"] = {
        ["Fire"] = function()
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1595 = v_u_3
            local v1596 = v_u_7
            buffer.writeu8(v1595, v1596, 3)
        end
    },
    ["FishingSetKeepArtifact"] = {
        ["Fire"] = function(p1597)
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1598 = v_u_3
            local v1599 = v_u_7
            buffer.writeu8(v1598, v1599, 9)
            v_u_16(2)
            local v1600 = v_u_3
            local v1601 = v_u_7
            buffer.writeu16(v1600, v1601, p1597)
        end
    },
    ["FishingSetKeep"] = {
        ["Fire"] = function(p1602)
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1603 = v_u_3
            local v1604 = v_u_7
            buffer.writeu8(v1603, v1604, 8)
            v_u_16(2)
            local v1605 = v_u_3
            local v1606 = v_u_7
            buffer.writeu16(v1605, v1606, p1602)
        end
    },
    ["FishingSelectBait"] = {
        ["Fire"] = function(p1607)
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1608 = v_u_3
            local v1609 = v_u_7
            buffer.writeu8(v1608, v1609, 7)
            v_u_16(2)
            local v1610 = v_u_3
            local v1611 = v_u_7
            buffer.writeu16(v1610, v1611, p1607)
        end
    },
    ["FishingResult"] = {
        ["On"] = function(p_u_1612)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1613 = v_u_34[2]
            table.insert(v1613, p_u_1612)
            for _, v1614 in v_u_35[2] do
                task.spawn(p_u_1612, v1614)
            end
            v_u_35[2] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1612
                table.remove(v_u_34[2], table.find(v_u_34[2], p_u_1612))
            end
        end
    },
    ["FishingPhase"] = {
        ["On"] = function(p_u_1615)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1616 = v_u_34[1]
            table.insert(v1616, p_u_1615)
            for _, v1617 in v_u_35[1] do
                task.spawn(p_u_1615, v1617)
            end
            v_u_35[1] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1615
                table.remove(v_u_34[1], table.find(v_u_34[1], p_u_1615))
            end
        end
    },
    ["FishingNotice"] = {
        ["On"] = function(p_u_1618)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1619 = v_u_34[4]
            table.insert(v1619, p_u_1618)
            for _, v1620 in v_u_35[4] do
                task.spawn(p_u_1618, v1620)
            end
            v_u_35[4] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1618
                table.remove(v_u_34[4], table.find(v_u_34[4], p_u_1618))
            end
        end
    },
    ["FishingLineShow"] = {
        ["On"] = function(p_u_1621)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1622 = v_u_34[6]
            table.insert(v1622, p_u_1621)
            for _, v1623 in v_u_35[6] do
                task.spawn(p_u_1621, v1623)
            end
            v_u_35[6] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1621
                table.remove(v_u_34[6], table.find(v_u_34[6], p_u_1621))
            end
        end
    },
    ["FishingLineOut"] = {
        ["Fire"] = function(p1624)
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1625 = v_u_3
            local v1626 = v_u_7
            buffer.writeu8(v1625, v1626, 11)
            v_u_16(4)
            local v1627 = v_u_3
            local v1628 = v_u_7
            local v1629 = p1624.X
            buffer.writef32(v1627, v1628, v1629)
            v_u_16(4)
            local v1630 = v_u_3
            local v1631 = v_u_7
            local v1632 = p1624.Y
            buffer.writef32(v1630, v1631, v1632)
            v_u_16(4)
            local v1633 = v_u_3
            local v1634 = v_u_7
            local v1635 = p1624.Z
            buffer.writef32(v1633, v1634, v1635)
        end
    },
    ["FishingLineHide"] = {
        ["On"] = function(p_u_1636)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1637 = v_u_34[7]
            table.insert(v1637, p_u_1636)
            for _, v1638 in v_u_35[7] do
                task.spawn(p_u_1636, v1638)
            end
            v_u_35[7] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1636
                table.remove(v_u_34[7], table.find(v_u_34[7], p_u_1636))
            end
        end
    },
    ["FishingGoToArrived"] = {
        ["On"] = function(p_u_1639)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1640 = v_u_34[0]
            table.insert(v1640, p_u_1639)
            for _, v1641 in v_u_35[0] do
                task.spawn(p_u_1639, v1641)
            end
            v_u_35[0] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1639
                table.remove(v_u_34[0], table.find(v_u_34[0], p_u_1639))
            end
        end
    },
    ["FishingGoTo"] = {
        ["Fire"] = function()
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1642 = v_u_3
            local v1643 = v_u_7
            buffer.writeu8(v1642, v1643, 5)
        end
    },
    ["FishingEquipRod"] = {
        ["Fire"] = function(p1644)
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1645 = v_u_3
            local v1646 = v_u_7
            buffer.writeu8(v1645, v1646, 6)
            v_u_16(2)
            local v1647 = v_u_3
            local v1648 = v_u_7
            buffer.writeu16(v1647, v1648, p1644)
        end
    },
    ["FishingBuyRod"] = {
        ["Fire"] = function(p1649)
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1650 = v_u_3
            local v1651 = v_u_7
            buffer.writeu8(v1650, v1651, 10)
            v_u_16(2)
            local v1652 = v_u_3
            local v1653 = v_u_7
            buffer.writeu16(v1652, v1653, p1649)
        end
    },
    ["FirstSessionStep"] = {
        ["Fire"] = function(p1654)
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1655 = v_u_3
            local v1656 = v_u_7
            buffer.writeu8(v1655, v1656, 13)
            v_u_16(1)
            local v1657 = v_u_3
            local v1658 = v_u_7
            buffer.writeu8(v1657, v1658, p1654)
        end
    },
    ["FireNpcDeath"] = {
        ["On"] = function(p_u_1659)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1660 = v_u_34[26]
            table.insert(v1660, p_u_1659)
            for _, v1661 in v_u_35[26] do
                task.spawn(p_u_1659, v1661)
            end
            v_u_35[26] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1659
                table.remove(v_u_34[26], table.find(v_u_34[26], p_u_1659))
            end
        end
    },
    ["FireNpcAttack"] = {
        ["On"] = function(p_u_1662)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1663 = v_u_34[25]
            table.insert(v1663, p_u_1662)
            for _, v1664 in v_u_35[25] do
                task.spawn(p_u_1662, v1664)
            end
            v_u_35[25] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1662
                table.remove(v_u_34[25], table.find(v_u_34[25], p_u_1662))
            end
        end
    },
    ["FireBossSummon"] = {
        ["On"] = function(p_u_1665)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1666 = v_u_34[27]
            table.insert(v1666, p_u_1665)
            for _, v1667 in v_u_35[27] do
                task.spawn(p_u_1665, v1667)
            end
            v_u_35[27] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1665
                table.remove(v_u_34[27], table.find(v_u_34[27], p_u_1665))
            end
        end
    },
    ["FireBossRewards"] = {
        ["SetCallback"] = function(p1668)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            v_u_34[32] = p1668
            for _, v1669 in v_u_35[32] do
                task.spawn(p1668, v1669)
            end
            v_u_35[32] = {}
            return function()
                -- upvalues: (ref) v_u_34
                v_u_34[32] = nil
            end
        end
    },
    ["FireBossPhase"] = {
        ["On"] = function(p_u_1670)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1671 = v_u_34[30]
            table.insert(v1671, p_u_1670)
            for _, v1672 in v_u_35[30] do
                task.spawn(p_u_1670, v1672)
            end
            v_u_35[30] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1670
                table.remove(v_u_34[30], table.find(v_u_34[30], p_u_1670))
            end
        end
    },
    ["FireBossImpact"] = {
        ["On"] = function(p_u_1673)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1674 = v_u_34[29]
            table.insert(v1674, p_u_1673)
            for _, v1675 in v_u_35[29] do
                task.spawn(p_u_1673, v1675)
            end
            v_u_35[29] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1673
                table.remove(v_u_34[29], table.find(v_u_34[29], p_u_1673))
            end
        end
    },
    ["FireBossDespawn"] = {
        ["On"] = function(p_u_1676)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1677 = v_u_34[31]
            table.insert(v1677, p_u_1676)
            for _, v1678 in v_u_35[31] do
                task.spawn(p_u_1676, v1678)
            end
            v_u_35[31] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1676
                table.remove(v_u_34[31], table.find(v_u_34[31], p_u_1676))
            end
        end
    },
    ["FireBossCast"] = {
        ["On"] = function(p_u_1679)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1680 = v_u_34[28]
            table.insert(v1680, p_u_1679)
            for _, v1681 in v_u_35[28] do
                task.spawn(p_u_1679, v1681)
            end
            v_u_35[28] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1679
                table.remove(v_u_34[28], table.find(v_u_34[28], p_u_1679))
            end
        end
    },
    ["DirectCrateBuy"] = {
        ["Call"] = function(p1682)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[46][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1683 = v_u_3
            local v1684 = v_u_7
            buffer.writeu8(v1683, v1684, 25)
            v_u_16(1)
            local v1685 = v_u_3
            local v1686 = v_u_7
            local v1687 = v_u_38
            buffer.writeu8(v1685, v1686, v1687)
            local v1688 = 0
            local v1689 = v_u_16(1)
            if p1682.kind == "wpn_legendary" then
                v1688 = bit32.bor(v1688, 1)
            elseif p1682.kind == "wpn_mythic" then
                v1688 = bit32.bor(v1688, 2)
            elseif p1682.kind == "skin_legendary" then
                v1688 = bit32.bor(v1688, 4)
            elseif p1682.kind == "skin_mythic" then
                v1688 = bit32.bor(v1688, 8)
            elseif p1682.kind == "pet" then
                v1688 = bit32.bor(v1688, 16)
            elseif p1682.kind == "artifact" then
                v1688 = bit32.bor(v1688, 32)
            else
                error("Invalid enumerator")
            end
            v_u_16(2)
            local v1690 = v_u_3
            local v1691 = v_u_7
            local v1692 = p1682.id
            buffer.writeu16(v1690, v1691, v1692)
            v_u_16(2)
            local v1693 = v_u_3
            local v1694 = v_u_7
            local v1695 = p1682.itemId
            buffer.writeu16(v1693, v1694, v1695)
            local v1696 = v_u_3
            buffer.writeu8(v1696, v1689, v1688)
            v_u_35[46][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["CurrencyPackGranted"] = {
        ["On"] = function(p_u_1697)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1698 = v_u_34[43]
            table.insert(v1698, p_u_1697)
            for _, v1699 in v_u_35[43] do
                task.spawn(p_u_1697, v1699)
            end
            v_u_35[43] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1697
                table.remove(v_u_34[43], table.find(v_u_34[43], p_u_1697))
            end
        end
    },
    ["CurrencyPackBurst"] = {
        ["On"] = function(p_u_1700)
            -- upvalues: (copy) v_u_36, (copy) v_u_37
            local v1701 = v_u_36[4]
            table.insert(v1701, p_u_1700)
            for _, v1702 in v_u_37[4] do
                task.spawn(p_u_1700, v1702)
            end
            v_u_37[4] = {}
            return function()
                -- upvalues: (ref) v_u_36, (copy) p_u_1700
                table.remove(v_u_36[4], table.find(v_u_36[4], p_u_1700))
            end
        end
    },
    ["CompanionClaim"] = {
        ["Call"] = function(p1703)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[67][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1704 = v_u_3
            local v1705 = v_u_7
            buffer.writeu8(v1704, v1705, 46)
            v_u_16(1)
            local v1706 = v_u_3
            local v1707 = v_u_7
            local v1708 = v_u_38
            buffer.writeu8(v1706, v1707, v1708)
            if p1703.companion ~= "growing_jack" then
                error("Invalid enumerator")
            end
            v_u_35[67][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["ClanOp"] = {
        ["Call"] = function(p1709)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[61][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1710 = v_u_3
            local v1711 = v_u_7
            buffer.writeu8(v1710, v1711, 40)
            v_u_16(1)
            local v1712 = v_u_3
            local v1713 = v_u_7
            local v1714 = v_u_38
            buffer.writeu8(v1712, v1713, v1714)
            local v1715 = 0
            local v1716 = v_u_16(1)
            if p1709.op == "create" then
                v_u_16(1)
                local v1717 = v_u_3
                local v1718 = v_u_7
                buffer.writeu8(v1717, v1718, 0)
            elseif p1709.op == "join" then
                v_u_16(1)
                local v1719 = v_u_3
                local v1720 = v_u_7
                buffer.writeu8(v1719, v1720, 1)
            elseif p1709.op == "leave" then
                v_u_16(1)
                local v1721 = v_u_3
                local v1722 = v_u_7
                buffer.writeu8(v1721, v1722, 2)
            elseif p1709.op == "kick" then
                v_u_16(1)
                local v1723 = v_u_3
                local v1724 = v_u_7
                buffer.writeu8(v1723, v1724, 3)
            elseif p1709.op == "promote" then
                v_u_16(1)
                local v1725 = v_u_3
                local v1726 = v_u_7
                buffer.writeu8(v1725, v1726, 4)
            elseif p1709.op == "demote" then
                v_u_16(1)
                local v1727 = v_u_3
                local v1728 = v_u_7
                buffer.writeu8(v1727, v1728, 5)
            elseif p1709.op == "invite" then
                v_u_16(1)
                local v1729 = v_u_3
                local v1730 = v_u_7
                buffer.writeu8(v1729, v1730, 6)
            elseif p1709.op == "accept_invite" then
                v_u_16(1)
                local v1731 = v_u_3
                local v1732 = v_u_7
                buffer.writeu8(v1731, v1732, 7)
            elseif p1709.op == "decline_invite" then
                v_u_16(1)
                local v1733 = v_u_3
                local v1734 = v_u_7
                buffer.writeu8(v1733, v1734, 8)
            elseif p1709.op == "request" then
                v_u_16(1)
                local v1735 = v_u_3
                local v1736 = v_u_7
                buffer.writeu8(v1735, v1736, 9)
            elseif p1709.op == "cancel_request" then
                v_u_16(1)
                local v1737 = v_u_3
                local v1738 = v_u_7
                buffer.writeu8(v1737, v1738, 10)
            elseif p1709.op == "approve" then
                v_u_16(1)
                local v1739 = v_u_3
                local v1740 = v_u_7
                buffer.writeu8(v1739, v1740, 11)
            elseif p1709.op == "deny" then
                v_u_16(1)
                local v1741 = v_u_3
                local v1742 = v_u_7
                buffer.writeu8(v1741, v1742, 12)
            elseif p1709.op == "set_privacy" then
                v_u_16(1)
                local v1743 = v_u_3
                local v1744 = v_u_7
                buffer.writeu8(v1743, v1744, 13)
            elseif p1709.op == "set_desc" then
                v_u_16(1)
                local v1745 = v_u_3
                local v1746 = v_u_7
                buffer.writeu8(v1745, v1746, 14)
            elseif p1709.op == "set_color" then
                v_u_16(1)
                local v1747 = v_u_3
                local v1748 = v_u_7
                buffer.writeu8(v1747, v1748, 15)
            elseif p1709.op == "transfer" then
                v_u_16(1)
                local v1749 = v_u_3
                local v1750 = v_u_7
                buffer.writeu8(v1749, v1750, 16)
            elseif p1709.op == "disband" then
                v_u_16(1)
                local v1751 = v_u_3
                local v1752 = v_u_7
                buffer.writeu8(v1751, v1752, 17)
            elseif p1709.op == "refresh" then
                v_u_16(1)
                local v1753 = v_u_3
                local v1754 = v_u_7
                buffer.writeu8(v1753, v1754, 18)
            elseif p1709.op == "visit" then
                v_u_16(1)
                local v1755 = v_u_3
                local v1756 = v_u_7
                buffer.writeu8(v1755, v1756, 19)
            elseif p1709.op == "equip_race" then
                v_u_16(1)
                local v1757 = v_u_3
                local v1758 = v_u_7
                buffer.writeu8(v1757, v1758, 20)
            elseif p1709.op == "buy_gear" then
                v_u_16(1)
                local v1759 = v_u_3
                local v1760 = v_u_7
                buffer.writeu8(v1759, v1760, 21)
            elseif p1709.op == "equip_gear" then
                v_u_16(1)
                local v1761 = v_u_3
                local v1762 = v_u_7
                buffer.writeu8(v1761, v1762, 22)
            elseif p1709.op == "unequip_gear" then
                v_u_16(1)
                local v1763 = v_u_3
                local v1764 = v_u_7
                buffer.writeu8(v1763, v1764, 23)
            else
                error("Invalid enumerator")
            end
            if p1709.target ~= nil then
                v1715 = bit32.bor(v1715, 1)
                v_u_16(8)
                local v1765 = v_u_3
                local v1766 = v_u_7
                local v1767 = p1709.target
                buffer.writef64(v1765, v1766, v1767)
            end
            if p1709.clanId ~= nil then
                v1715 = bit32.bor(v1715, 2)
                local v1768 = #p1709.clanId
                local v1769 = v1768 >= 0
                assert(v1769, "value is less than 0!")
                local v1770 = v1768 <= 192
                assert(v1770, "value is more than 192!")
                local v1771 = utf8.len(p1709.clanId) ~= nil
                assert(v1771, "value is not valid utf-8")
                v_u_16(1)
                local v1772 = v_u_3
                local v1773 = v_u_7
                buffer.writeu8(v1772, v1773, v1768)
                v_u_16(v1768)
                buffer.writestring(v_u_3, v_u_7, p1709.clanId, v1768)
            end
            if p1709.text ~= nil then
                v1715 = bit32.bor(v1715, 4)
                local v1774 = #p1709.text
                local v1775 = v1774 >= 0
                assert(v1775, "value is less than 0!")
                local v1776 = v1774 <= 128
                assert(v1776, "value is more than 128!")
                local v1777 = utf8.len(p1709.text) ~= nil
                assert(v1777, "value is not valid utf-8")
                v_u_16(1)
                local v1778 = v_u_3
                local v1779 = v_u_7
                buffer.writeu8(v1778, v1779, v1774)
                v_u_16(v1774)
                buffer.writestring(v_u_3, v_u_7, p1709.text, v1774)
            end
            if p1709.desc ~= nil then
                v1715 = bit32.bor(v1715, 8)
                local v1780 = #p1709.desc
                local v1781 = v1780 >= 0
                assert(v1781, "value is less than 0!")
                local v1782 = v1780 <= 640
                assert(v1782, "value is more than 640!")
                local v1783 = utf8.len(p1709.desc) ~= nil
                assert(v1783, "value is not valid utf-8")
                v_u_16(2)
                local v1784 = v_u_3
                local v1785 = v_u_7
                buffer.writeu16(v1784, v1785, v1780)
                v_u_16(v1780)
                buffer.writestring(v_u_3, v_u_7, p1709.desc, v1780)
            end
            if p1709.privacy ~= nil then
                v1715 = bit32.bor(v1715, 16)
                v_u_16(1)
                local v1786 = v_u_3
                local v1787 = v_u_7
                local v1788 = p1709.privacy
                buffer.writeu8(v1786, v1787, v1788)
            end
            if p1709.color ~= nil then
                v1715 = bit32.bor(v1715, 32)
                v_u_16(4)
                local v1789 = v_u_3
                local v1790 = v_u_7
                local v1791 = p1709.color
                buffer.writeu32(v1789, v1790, v1791)
            end
            local v1792 = v_u_3
            buffer.writeu8(v1792, v1716, v1715)
            v_u_35[61][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["ClanInfo"] = {
        ["Call"] = function(p1793)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[62][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1794 = v_u_3
            local v1795 = v_u_7
            buffer.writeu8(v1794, v1795, 41)
            v_u_16(1)
            local v1796 = v_u_3
            local v1797 = v_u_7
            local v1798 = v_u_38
            buffer.writeu8(v1796, v1797, v1798)
            local v1799 = #p1793.clanId
            local v1800 = v1799 >= 1
            assert(v1800, "value is less than 1!")
            local v1801 = v1799 <= 192
            assert(v1801, "value is more than 192!")
            local v1802 = utf8.len(p1793.clanId) ~= nil
            assert(v1802, "value is not valid utf-8")
            v_u_16(1)
            local v1803 = v_u_3
            local v1804 = v_u_7
            local v1805 = v1799 - 1
            buffer.writeu8(v1803, v1804, v1805)
            v_u_16(v1799)
            buffer.writestring(v_u_3, v_u_7, p1793.clanId, v1799)
            v_u_35[62][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["ClanChatToClient"] = {
        ["On"] = function(p_u_1806)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1807 = v_u_34[23]
            table.insert(v1807, p_u_1806)
            for _, v1808 in v_u_35[23] do
                task.spawn(p_u_1806, v1808)
            end
            v_u_35[23] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1806
                table.remove(v_u_34[23], table.find(v_u_34[23], p_u_1806))
            end
        end
    },
    ["ClanChatSend"] = {
        ["Fire"] = function(p1809)
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1810 = v_u_3
            local v1811 = v_u_7
            buffer.writeu8(v1810, v1811, 18)
            local v1812 = #p1809
            local v1813 = v1812 >= 1
            assert(v1813, "value is less than 1!")
            local v1814 = v1812 <= 4000
            assert(v1814, "value is more than 4000!")
            local v1815 = utf8.len(p1809) ~= nil
            assert(v1815, "value is not valid utf-8")
            v_u_16(2)
            local v1816 = v_u_3
            local v1817 = v_u_7
            local v1818 = v1812 - 1
            buffer.writeu16(v1816, v1817, v1818)
            v_u_16(v1812)
            buffer.writestring(v_u_3, v_u_7, p1809, v1812)
        end
    },
    ["ClanBrowse"] = {
        ["Call"] = function(p1819)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[63][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1820 = v_u_3
            local v1821 = v_u_7
            buffer.writeu8(v1820, v1821, 42)
            v_u_16(1)
            local v1822 = v_u_3
            local v1823 = v_u_7
            local v1824 = v_u_38
            buffer.writeu8(v1822, v1823, v1824)
            local v1825 = 0
            local v1826 = v_u_16(1)
            if p1819.mode == "top" then
                v1825 = bit32.bor(v1825, 1)
            elseif p1819.mode ~= "search" then
                error("Invalid enumerator")
            end
            if p1819.query ~= nil then
                v1825 = bit32.bor(v1825, 2)
                local v1827 = #p1819.query
                local v1828 = v1827 >= 0
                assert(v1828, "value is less than 0!")
                local v1829 = v1827 <= 128
                assert(v1829, "value is more than 128!")
                local v1830 = utf8.len(p1819.query) ~= nil
                assert(v1830, "value is not valid utf-8")
                v_u_16(1)
                local v1831 = v_u_3
                local v1832 = v_u_7
                buffer.writeu8(v1831, v1832, v1827)
                v_u_16(v1827)
                buffer.writestring(v_u_3, v_u_7, p1819.query, v1827)
            end
            local v1833 = v_u_3
            buffer.writeu8(v1833, v1826, v1825)
            v_u_35[63][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["ClaimOfflineReward"] = {
        ["Call"] = function()
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[59][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1834 = v_u_3
            local v1835 = v_u_7
            buffer.writeu8(v1834, v1835, 38)
            v_u_16(1)
            local v1836 = v_u_3
            local v1837 = v_u_7
            local v1838 = v_u_38
            buffer.writeu8(v1836, v1837, v1838)
            v_u_35[59][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["BloodMoonPopupShow"] = {
        ["SetCallback"] = function(p1839)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            v_u_34[35] = p1839
            for _ = 1, v_u_35[35] do
                task.spawn(p1839)
            end
            v_u_35[35] = 0
            return function()
                -- upvalues: (ref) v_u_34
                v_u_34[35] = nil
            end
        end
    },
    ["BloodMoonPopupSeen"] = {
        ["Fire"] = function()
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1840 = v_u_3
            local v1841 = v_u_7
            buffer.writeu8(v1840, v1841, 19)
        end
    },
    ["BloodMoonGiftTargets"] = {
        ["Call"] = function(p1842)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[66][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1843 = v_u_3
            local v1844 = v_u_7
            buffer.writeu8(v1843, v1844, 45)
            v_u_16(1)
            local v1845 = v_u_3
            local v1846 = v_u_7
            local v1847 = v_u_38
            buffer.writeu8(v1845, v1846, v1847)
            local v1848 = 0
            local v1849 = v_u_16(1)
            if p1842.item == "vampire_bat" then
                v1848 = bit32.bor(v1848, 1)
            elseif p1842.item == "blood_moon_werewolf" then
                v1848 = bit32.bor(v1848, 2)
            elseif p1842.item == "crimson_mantle" then
                v1848 = bit32.bor(v1848, 4)
            elseif p1842.item == "crescent_reaver" then
                v1848 = bit32.bor(v1848, 8)
            elseif p1842.item == "alpha_werewolf" then
                v1848 = bit32.bor(v1848, 16)
            elseif p1842.item == "bloodmoon_bell" then
                v1848 = bit32.bor(v1848, 32)
            else
                error("Invalid enumerator")
            end
            local v1850 = v_u_3
            buffer.writeu8(v1850, v1849, v1848)
            v_u_35[66][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["BloodMoonGiftReceived"] = {
        ["SetCallback"] = function(p1851)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            v_u_34[33] = p1851
            for _, v1852 in v_u_35[33] do
                task.spawn(p1851, v1852)
            end
            v_u_35[33] = {}
            return function()
                -- upvalues: (ref) v_u_34
                v_u_34[33] = nil
            end
        end
    },
    ["BloodMoonGift"] = {
        ["Call"] = function(p1853)
            -- upvalues: (ref) v_u_38, (copy) v_u_35, (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_38 = v_u_38 + 1
            v_u_38 = v_u_38 % 256
            if v_u_35[65][v_u_38] then
                v_u_38 = v_u_38 - 1
                error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
            end
            v_u_16(1)
            local v1854 = v_u_3
            local v1855 = v_u_7
            buffer.writeu8(v1854, v1855, 44)
            v_u_16(1)
            local v1856 = v_u_3
            local v1857 = v_u_7
            local v1858 = v_u_38
            buffer.writeu8(v1856, v1857, v1858)
            local v1859 = 0
            local v1860 = v_u_16(1)
            if p1853.item == "vampire_bat" then
                v1859 = bit32.bor(v1859, 1)
            elseif p1853.item == "blood_moon_werewolf" then
                v1859 = bit32.bor(v1859, 2)
            elseif p1853.item == "crimson_mantle" then
                v1859 = bit32.bor(v1859, 4)
            elseif p1853.item == "crescent_reaver" then
                v1859 = bit32.bor(v1859, 8)
            elseif p1853.item == "alpha_werewolf" then
                v1859 = bit32.bor(v1859, 16)
            elseif p1853.item == "bloodmoon_bell" then
                v1859 = bit32.bor(v1859, 32)
            else
                error("Invalid enumerator")
            end
            v_u_16(8)
            local v1861 = v_u_3
            local v1862 = v_u_7
            local v1863 = p1853.to
            buffer.writef64(v1861, v1862, v1863)
            local v1864 = #p1853.rid
            local v1865 = v1864 >= 8
            assert(v1865, "value is less than 8!")
            local v1866 = v1864 <= 256
            assert(v1866, "value is more than 256!")
            local v1867 = utf8.len(p1853.rid) ~= nil
            assert(v1867, "value is not valid utf-8")
            v_u_16(1)
            local v1868 = v_u_3
            local v1869 = v_u_7
            local v1870 = v1864 - 8
            buffer.writeu8(v1868, v1869, v1870)
            v_u_16(v1864)
            buffer.writestring(v_u_3, v_u_7, p1853.rid, v1864)
            local v1871 = v_u_3
            buffer.writeu8(v1871, v1860, v1859)
            v_u_35[65][v_u_38] = coroutine.running()
            return coroutine.yield()
        end
    },
    ["BatHome"] = {
        ["On"] = function(p_u_1872)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1873 = v_u_34[40]
            table.insert(v1873, p_u_1872)
            for _, v1874 in v_u_35[40] do
                task.spawn(p_u_1872, v1874)
            end
            v_u_35[40] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1872
                table.remove(v_u_34[40], table.find(v_u_34[40], p_u_1872))
            end
        end
    },
    ["BatBite"] = {
        ["On"] = function(p_u_1875)
            -- upvalues: (copy) v_u_36, (copy) v_u_37
            local v1876 = v_u_36[2]
            table.insert(v1876, p_u_1875)
            for _, v1877 in v_u_37[2] do
                task.spawn(p_u_1875, v1877)
            end
            v_u_37[2] = {}
            return function()
                -- upvalues: (ref) v_u_36, (copy) p_u_1875
                table.remove(v_u_36[2], table.find(v_u_36[2], p_u_1875))
            end
        end
    },
    ["ActiveBoostsUpdate"] = {
        ["On"] = function(p_u_1878)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1879 = v_u_34[8]
            table.insert(v1879, p_u_1878)
            for _, v1880 in v_u_35[8] do
                task.spawn(p_u_1878, v1880)
            end
            v_u_35[8] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1878
                table.remove(v_u_34[8], table.find(v_u_34[8], p_u_1878))
            end
        end
    },
    ["AcStaffNotice"] = {
        ["On"] = function(p_u_1881)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1882 = v_u_34[11]
            table.insert(v1882, p_u_1881)
            for _, v1883 in v_u_35[11] do
                task.spawn(p_u_1881, v1883)
            end
            v_u_35[11] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1881
                table.remove(v_u_34[11], table.find(v_u_34[11], p_u_1881))
            end
        end
    },
    ["AbilityUse"] = {
        ["Fire"] = function()
            -- upvalues: (copy) v_u_16, (ref) v_u_3, (ref) v_u_7
            v_u_16(1)
            local v1884 = v_u_3
            local v1885 = v_u_7
            buffer.writeu8(v1884, v1885, 22)
        end
    },
    ["AbilityState"] = {
        ["SetCallback"] = function(p1886)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            v_u_34[41] = p1886
            for _, v1887 in v_u_35[41] do
                task.spawn(p1886, v1887)
            end
            v_u_35[41] = {}
            return function()
                -- upvalues: (ref) v_u_34
                v_u_34[41] = nil
            end
        end
    },
    ["AbilityCast"] = {
        ["On"] = function(p_u_1888)
            -- upvalues: (copy) v_u_34, (copy) v_u_35
            local v1889 = v_u_34[42]
            table.insert(v1889, p_u_1888)
            for _, v1890 in v_u_35[42] do
                task.spawn(p_u_1888, v1890)
            end
            v_u_35[42] = {}
            return function()
                -- upvalues: (ref) v_u_34, (copy) p_u_1888
                table.remove(v_u_34[42], table.find(v_u_34[42], p_u_1888))
            end
        end
    }
}
return v1891