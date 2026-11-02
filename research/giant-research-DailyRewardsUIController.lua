-- Decompiled game.Players.BoomerIsBigMan.PlayerScripts.Aero.Controllers.DailyRewardsUIController

local v1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = require(v_u_2.Packages.signal)
local v_u_5 = require(v_u_2.ReactUI.DailyRewardVisuals)
local v_u_6 = nil
local v_u_7 = nil
local v_u_8 = nil
local v_u_9 = nil
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = nil
local function v_u_23()
    -- upvalues: (ref) v_u_7, (ref) v_u_11, (ref) v_u_12
    local v16 = v_u_7:GetPlayerPetsData()
    local v17 = not v16 and 0 or v_u_11:GetTotalGoldBoost(v16)
    local v18 = v_u_7:GetPlayerArtifactsData()
    local v19, v20, v21
    if v18 then
        local v22 = v_u_12:GetEquippedArtifactsFromArtifactsData(v18)
        v19 = v_u_12:GetTotalGoldBoostFromArtifactsData(v22)
        v20 = v_u_12:GetTotalTokenBoostFromArtifactsData(v22)
        v21 = v_u_12:GetTotalQuestBoostFromArtifactsData(v22)
    else
        v19 = 0
        v20 = 0
        v21 = 0
    end
    return v17, v19, v20, v21
end
local function v_u_55()
    -- upvalues: (copy) v_u_23, (ref) v_u_14, (ref) v_u_10, (ref) v_u_15, (ref) v_u_13, (ref) v_u_9, (ref) v_u_8
    local v_u_24, v_u_25, v_u_26, v_u_27 = v_u_23()
    local v_u_28 = v_u_14:OwnsPass(v_u_10.Passes.PASSIVE_GOLD_2X_ID)
    local v_u_29 = v_u_14:OwnsPass(v_u_10.Passes.SOUL_GEMS_2X_ID)
    local v_u_30 = v_u_14:OwnsPass(v_u_10.Passes.DOUBLE_QUEST_POINTS)
    local v_u_31 = v_u_14:GetStat("gold_skill") or 0
    local v_u_32 = v_u_14:GetStat("xp_skill") or 0
    local v_u_33 = v_u_15:GetPotionMult(v_u_13.BoostTypes.GOLD)
    local v_u_34 = v_u_15:GetPotionMult(v_u_13.BoostTypes.TOKENS)
    local function v37(p35)
        -- upvalues: (ref) v_u_9, (ref) v_u_8, (copy) v_u_28, (copy) v_u_31, (copy) v_u_24, (copy) v_u_25, (copy) v_u_33
        local v36 = v_u_9:GetBoostedGold(v_u_8:NearestInt(p35), v_u_28, v_u_31, v_u_24, v_u_25) * v_u_33
        return math.ceil(v36)
    end
    local function v40(p38)
        -- upvalues: (ref) v_u_9, (ref) v_u_8, (copy) v_u_29, (copy) v_u_32, (copy) v_u_26, (copy) v_u_34
        local v39 = v_u_9:GetBoostedTokens(v_u_8:NearestInt(p38), v_u_29, v_u_32, v_u_26) * v_u_34
        return math.ceil(v39)
    end
    local function v42(p41)
        -- upvalues: (ref) v_u_9, (ref) v_u_8, (copy) v_u_30, (copy) v_u_27
        return v_u_9:GetBoostedQuestPoints(v_u_8:NearestInt(p41), v_u_30, v_u_27)
    end
    local v_u_43 = v_u_9.DailyRewardCurrency
    local v_u_44 = {
        [v_u_43.GOLD] = v_u_10.Data[v_u_10.Products.GOLD_PACK_1].Amount,
        [v_u_43.QUEST] = v_u_10.Data[v_u_10.Products.QUEST_PACK_1].Amount,
        [v_u_43.SOUL_GEMS] = v_u_10.Data[v_u_10.Products.SOUL_GEM_PACK_1].Amount
    }
    local v_u_45 = {
        [v_u_43.GOLD] = v37,
        [v_u_43.QUEST] = v42,
        [v_u_43.SOUL_GEMS] = v40
    }
    local function v49(p46)
        -- upvalues: (copy) v_u_45, (copy) v_u_44, (ref) v_u_8, (copy) v_u_43
        local v47 = p46.Kind or "currency"
        if v47 ~= "currency" then
            return v47 == "potion" and {
                ["potionId"] = p46.PotionId,
                ["count"] = p46.Amount or 1
            } or (v47 == "weapon" and {
                ["weaponId"] = p46.WeaponId
            } or (v47 == "pet" and {
                ["petId"] = p46.PetId
            } or {
                ["currency"] = v_u_43.GOLD
            }))
        end
        local v48 = v_u_45[p46.Currency](v_u_44[p46.Currency] * p46.Multiplier)
        return {
            ["currency"] = p46.Currency,
            ["amountText"] = v_u_8:ToSuffixString(v48)
        }
    end
    local v50 = {}
    for v51, v52 in ipairs(v_u_9.DailyRewardSchedule) do
        local v53 = {}
        for v54 = 2, #v52 do
            v53[v54 - 1] = v49(v52[v54])
        end
        v50[v51] = {
            ["kind"] = v52[1].Kind or "currency",
            ["reward"] = v49(v52[1]),
            ["extras"] = v53,
            ["bundle"] = #v52 > 1
        }
    end
    return v50
end
function v1._effectiveDay(_, p56, p57)
    -- upvalues: (ref) v_u_9, (ref) v_u_14
    if v_u_9:IsDailyStreakBroken(p57, p56) then
        return 1
    end
    local v58 = v_u_14:GetStat("daily_counter") or 1
    local v59 = math.floor(v58)
    local v60 = #v_u_9.DailyRewardSchedule
    return math.clamp(v59, 1, v60)
end
function v1.GetPanelState(p61)
    -- upvalues: (copy) v_u_55, (ref) v_u_9, (ref) v_u_6, (ref) v_u_14, (copy) v_u_5
    local v62 = v_u_55()
    local v63 = #v_u_9.DailyRewardSchedule
    local v64 = v_u_6:GetServerClockTime()
    local v65 = v_u_14:GetStat("daily_last_claim") or 0
    local v66 = v_u_9:SecondsUntilDailyReward(v65, v64)
    local v67
    if v66 <= 0 then
        v67 = not p61.Claiming
    else
        v67 = false
    end
    local v68 = v_u_9:IsDailyStreakBroken(v65, v64)
    local v69 = p61:_effectiveDay(v64, v65)
    local v70 = v_u_14:GetStat("daily_streak") or 0
    if v66 <= 0 then
        v70 = v68 and 1 or v70 + 1
    end
    local v71 = {}
    for v72, v73 in ipairs(v62) do
        local v74 = (p61.Claiming and v72 == p61.ClaimingDay or v72 < v69) and "claimed" or (v72 == v69 and (v67 and "claimable" or "current") or "locked")
        local v75 = {}
        for v76, v77 in ipairs(v73.extras) do
            v75[v76] = v_u_5.Resolve(p61.Shared, v77)
        end
        local v78 = {
            ["day"] = v72
        }
        local v79 = v72 / 8
        v78.week = math.ceil(v79)
        v78.dayInWeek = (v72 - 1) % 8 + 1
        v78.kind = v73.kind
        v78.bundle = v73.bundle
        v78.visual = v_u_5.Resolve(p61.Shared, v73.reward)
        v78.extras = v75
        v78.state = v74
        v71[v72] = v78
    end
    local v80 = {
        ["visible"] = p61.Visible == true,
        ["counter"] = v69,
        ["streak"] = v70
    }
    local v81 = v_u_14:GetStat("daily_best_streak") or 0
    v80.bestStreak = math.max(v70, v81)
    local v82 = v69 / 8
    v80.currentWeek = math.ceil(v82)
    local v83 = v63 / 8
    v80.totalWeeks = math.ceil(v83)
    v80.claimable = v67
    v80.claiming = p61.Claiming == true
    v80.nextClaimAt = p61:_getStableNextClaimAt(v66, v67)
    v80.days = v71
    return v80
end
function v1._getStableNextClaimAt(p84, p85, p86)
    if p86 or p84.Claiming then
        p84.NextClaimAt = nil
        return nil
    else
        if not p84.NextClaimAt then
            p84.NextClaimAt = os.time() + math.max(0, p85)
        end
        return p84.NextClaimAt
    end
end
function v1._fireChanged(p87)
    p87.StateChanged:Fire()
end
function v1.Show(p_u_88)
    -- upvalues: (ref) v_u_6, (ref) v_u_9, (ref) v_u_14
    p_u_88.Claiming = false
    p_u_88.ClaimingDay = nil
    p_u_88.Visible = true
    p_u_88.ListenerList:BindAction("DailyReward_Close", function(_, p89)
        -- upvalues: (copy) p_u_88
        if p89 == Enum.UserInputState.Begin then
            p_u_88:Hide()
        end
    end, false, Enum.KeyCode.ButtonB)
    local v90 = v_u_6:GetServerClockTime()
    local v91 = v_u_9:SecondsUntilDailyReward(v_u_14:GetStat("daily_last_claim") or 0, v90)
    if v91 > 0 then
        p_u_88:ScheduleAutoShow(v91)
    end
    p_u_88:_fireChanged()
    if p_u_88.TopbarIcon then
        p_u_88.TopbarIcon:select("DailyRewards")
    end
end
function v1.Hide(p92)
    p92.Visible = false
    if p92.TopbarIcon then
        p92.TopbarIcon:deselect("DailyRewards")
    end
    p92.ListenerList:DisconnectActions()
    p92:_fireChanged()
end
function v1.SetClaimableNotice(p93, p94)
    if p93.TopbarIcon then
        if p94 and not p93.NoticeShown then
            p93.NoticeShown = true
            p93.TopbarIcon:notify()
        elseif not p94 and p93.NoticeShown then
            p93.NoticeShown = false
            p93.TopbarIcon:clearNotices()
        end
    else
        return
    end
end
function v1.ScheduleAutoShow(p_u_95, p96)
    if p_u_95.AutoShowThread then
        task.cancel(p_u_95.AutoShowThread)
        p_u_95.AutoShowThread = nil
    end
    if p96 ~= nil then
        p_u_95.AutoShowThread = task.delay(math.max(0, p96), function()
            -- upvalues: (copy) p_u_95
            p_u_95.AutoShowThread = nil
            p_u_95:SetClaimableNotice(true)
            p_u_95:Show()
        end)
    end
end
function v1.OnClaim(p_u_97)
    -- upvalues: (ref) v_u_6, (ref) v_u_14, (ref) v_u_9
    if p_u_97.Claiming then
        return
    else
        local v98 = v_u_6:GetServerClockTime()
        local v99 = v_u_14:GetStat("daily_last_claim") or 0
        if v_u_9:SecondsUntilDailyReward(v99, v98) <= 0 then
            p_u_97.Claiming = true
            p_u_97.ClaimingDay = p_u_97:_effectiveDay(v98, v99)
            p_u_97:_fireChanged()
            if v_u_6:RequestDailyReward() then
                p_u_97:SetClaimableNotice(false)
                p_u_97:ScheduleAutoShow(v_u_9:SecondsUntilDailyReward(v98, v98))
            end
            p_u_97:_fireChanged()
            task.delay(1, function()
                -- upvalues: (copy) p_u_97
                p_u_97.Claiming = false
                p_u_97.ClaimingDay = nil
                p_u_97:Hide()
            end)
        end
    end
end
function v1.Init(p100)
    -- upvalues: (ref) v_u_6, (ref) v_u_7, (ref) v_u_8, (ref) v_u_9, (ref) v_u_10, (ref) v_u_11, (ref) v_u_12, (ref) v_u_13, (ref) v_u_14, (ref) v_u_15, (copy) v_u_4
    v_u_6 = p100.Services.GameService
    v_u_7 = p100.Services.GameDataService
    v_u_8 = p100.Shared.Utils
    v_u_9 = p100.Shared.SharedConstants
    v_u_10 = p100.Shared.IAPData
    v_u_11 = p100.Shared.Pets
    v_u_12 = p100.Shared.Artifacts
    v_u_13 = p100.Shared.Potions
    v_u_14 = p100.Controllers.ReplicaController
    v_u_15 = p100.Controllers.BoostController
    p100.ListenerList = p100.Shared.ListenerList.new()
    p100.StateChanged = v_u_4.new()
    p100.Visible = false
    p100.Claiming = false
    p100.ClaimingDay = nil
    p100.AutoShowThread = nil
    p100.NoticeShown = false
    p100.NextClaimAt = nil
end
function v1.Start(p_u_101)
    -- upvalues: (ref) v_u_9, (ref) v_u_15, (ref) v_u_14, (copy) v_u_2, (ref) v_u_6, (copy) v_u_3
    p_u_101.Services.GameService[v_u_9.RemoteEvents.SHOW_DAILY_REWARD]:Connect(function()
        -- upvalues: (copy) p_u_101
        p_u_101:Show()
    end)
    local function v102()
        -- upvalues: (copy) p_u_101
        if p_u_101.Visible then
            p_u_101:_fireChanged()
        end
    end
    v_u_15.StateChanged:Connect(v102)
    v_u_14.PassChanged:Connect(v102)
    v_u_14:ObserveSection("stats", v102)
    v_u_14:ObserveSection("inventory", v102)
    p_u_101.TopbarIcon = require(v_u_2:WaitForChild("Packages"):WaitForChild("topbarplus")).new()
    p_u_101.TopbarIcon:setCaption("Daily Rewards")
    p_u_101.TopbarIcon:setImage("rbxassetid://127663148539317")
    p_u_101.TopbarIcon:setImageScale(0.9)
    p_u_101.TopbarIcon.selected:Connect(function(p103)
        -- upvalues: (copy) p_u_101
        if p103 ~= "DailyRewards" then
            p_u_101:Show()
        end
    end)
    p_u_101.TopbarIcon.deselected:Connect(function(p104)
        -- upvalues: (copy) p_u_101
        if p104 ~= "DailyRewards" then
            p_u_101:Hide()
        end
    end)
    v_u_14:OnReady(function()
        -- upvalues: (ref) v_u_6, (ref) v_u_9, (ref) v_u_14, (copy) p_u_101, (ref) v_u_3
        local v105 = v_u_6:GetServerClockTime()
        local v106 = v_u_9:SecondsUntilDailyReward(v_u_14:GetStat("daily_last_claim") or 0, v105)
        p_u_101:SetClaimableNotice(v106 <= 0)
        if not v_u_3:IsStudio() and v106 <= 0 then
            p_u_101:Show()
        end
        if v106 > 0 then
            p_u_101:ScheduleAutoShow(v106)
        end
    end)
end
return v1