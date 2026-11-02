-- Decompiled game.Players.BoomerIsBigMan.PlayerScripts.Aero.Controllers.RebirthController

local v1 = {}
local v_u_2 = game:GetService("TweenService")
game:GetService("Players")
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
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = nil
local v_u_23 = nil
function v1.Start(p_u_24)
    -- upvalues: (ref) v_u_3, (ref) v_u_11, (ref) v_u_14, (ref) v_u_19, (ref) v_u_4, (ref) v_u_5, (ref) v_u_6, (ref) v_u_7, (ref) v_u_8, (ref) v_u_12, (ref) v_u_13, (ref) v_u_9, (ref) v_u_10, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) v_u_20, (ref) v_u_21, (ref) v_u_22, (ref) v_u_23
    p_u_24.Player = game.Players.LocalPlayer
    while not p_u_24.Player do
        game.Players.PlayerAdded:wait()
        p_u_24.Player = game.Players.LocalPlayer
    end
    local v25 = p_u_24.Player:WaitForChild("PlayerGui")
    p_u_24.RC = p_u_24.Controllers.ReplicaController
    p_u_24.SoulGems2xPassId = p_u_24.Shared.IAPData.Passes.SOUL_GEMS_2X_ID
    local v26 = v25:WaitForChild("RebirthGui")
    v_u_3 = v26:WaitForChild("RebirthSkillMainPanel")
    v_u_11 = v_u_3:WaitForChild("ClipFrame"):WaitForChild("SlidingFrame")
    local v27 = v_u_11:WaitForChild("SkillsFrame")
    local v28 = v_u_11:WaitForChild("RebirthFrame"):WaitForChild("Rewards")
    v_u_14 = v28:WaitForChild("RebirthBtn")
    v_u_19 = v28:WaitForChild("CurrencySoul"):WaitForChild("Cost")
    local v29 = v27:WaitForChild("Purchase")
    local v30 = v27:WaitForChild("Inspection")
    local v31 = v27:WaitForChild("SkillTreePanel")
    local v32 = v29:WaitForChild("CurrencySoul")
    local v33 = v_u_3:WaitForChild("Close")
    local v34 = v27:WaitForChild("upgrade"):WaitForChild("MaxUpgrade")
    v_u_4 = v30:WaitForChild("Skill_Selected")
    v_u_5 = v30:WaitForChild("Skill_Req")
    v_u_6 = v30:WaitForChild("Skill_Title")
    v_u_7 = v30:WaitForChild("Skill_Desc")
    v_u_8 = v29:WaitForChild("UnlockButton")
    v_u_12 = v_u_8:WaitForChild("TitleText")
    v_u_13 = v_u_8:WaitForChild("TitleTextBG")
    v_u_9 = v32:WaitForChild("BuyCurrency")
    v_u_10 = v32:WaitForChild("Cost")
    local v35 = v31:WaitForChild("Skill_1")
    local v36 = v31:WaitForChild("Skill_2")
    local v37 = v31:WaitForChild("Skill_3")
    local v38 = v31:WaitForChild("Skill_4")
    local v39 = v31:WaitForChild("Skill_5")
    local v40 = v31:WaitForChild("Skill_6")
    v_u_15 = v26:WaitForChild("RebirthPrompt")
    local v41 = v_u_15:WaitForChild("ImageLabel")
    v_u_16 = v41:WaitForChild("ConfirmBtn")
    v_u_17 = v41:WaitForChild("CancelBtn")
    v_u_18 = v41:WaitForChild("reward"):WaitForChild("Amt")
    v_u_20 = v_u_3:WaitForChild("NavigationFrame"):WaitForChild("NavButton1")
    v_u_21 = v_u_3:WaitForChild("NavigationFrame"):WaitForChild("NavButton2")
    v_u_22 = v_u_3:WaitForChild("NextPageBG"):WaitForChild("NextPage")
    v_u_23 = v_u_3:WaitForChild("PrevPageBG"):WaitForChild("PrevPage")
    v_u_16.Activated:Connect(function()
        -- upvalues: (copy) p_u_24
        p_u_24:ShowRebirthPrompt(false)
        p_u_24:RebirthRequest()
    end)
    v_u_17.Activated:Connect(function()
        -- upvalues: (copy) p_u_24
        p_u_24:ShowRebirthPrompt(false)
    end)
    v34.Activated:Connect(function()
        -- upvalues: (copy) p_u_24
        local v42 = nil
        for v43, v44 in ipairs(p_u_24.SkillsData) do
            if v43 >= 5 then
                break
            end
            local v45 = p_u_24.Constants
            local v46 = v44.skill
            local v47 = v45:GetRequiredSkill(v46)
            v42 = v45:CanUpgradeSkill(v46, v44.rank, v47, p_u_24.SkillsData[v44.reqSkill].rank)
            if v42 and v45:GetSkillUpgradeCost(v44.skill, v44.rank) < (p_u_24.RC:GetStat("tokens") or 0) then
                p_u_24.Services.GameService:MassUpgradeSkills()
                break
            end
        end
        if v42 == false then
            p_u_24.Controllers.UIController:ShowToast({})
        end
        p_u_24.Controllers.SoundController:PlayPressActionButtonUI()
    end)
    v33.Activated:Connect(function()
        -- upvalues: (copy) p_u_24
        p_u_24:ShowUI(false)
        p_u_24.Controllers.SoundController:PlayPressActionButtonUI()
    end)
    v_u_14.Activated:Connect(function()
        -- upvalues: (copy) p_u_24
        p_u_24:ShowRebirthPrompt(true)
        p_u_24.Controllers.SoundController:PlayPressActionButtonUI()
    end)
    p_u_24.SkillsData = {}
    p_u_24:InitSkillsData({
        v35,
        v36,
        v37,
        v38,
        v39,
        v40
    })
    p_u_24.SelectedSkill = nil
    p_u_24.SelectedSkillBtn = p_u_24.SkillsData[1].btn
    p_u_24.SkillsData[1].btn.Activated:Connect(function()
        -- upvalues: (copy) p_u_24
        p_u_24:SetSkillFocus(1)
        p_u_24.Controllers.SoundController:PlayPressActionButtonUI()
    end)
    p_u_24.SkillsData[2].btn.Activated:Connect(function()
        -- upvalues: (copy) p_u_24
        p_u_24:SetSkillFocus(2)
        p_u_24.Controllers.SoundController:PlayPressActionButtonUI()
    end)
    p_u_24.SkillsData[3].btn.Activated:Connect(function()
        -- upvalues: (copy) p_u_24
        p_u_24:SetSkillFocus(3)
        p_u_24.Controllers.SoundController:PlayPressActionButtonUI()
    end)
    p_u_24.SkillsData[4].btn.Activated:Connect(function()
        -- upvalues: (copy) p_u_24
        p_u_24:SetSkillFocus(4)
        p_u_24.Controllers.SoundController:PlayPressActionButtonUI()
    end)
    p_u_24.SkillsData[5].btn.Activated:Connect(function()
        -- upvalues: (copy) p_u_24
        p_u_24:SetSkillFocus(5)
        p_u_24.Controllers.SoundController:PlayPressActionButtonUI()
    end)
    p_u_24.SkillsData[6].btn.Activated:Connect(function()
        -- upvalues: (copy) p_u_24
        p_u_24:SetSkillFocus(6)
        p_u_24.Controllers.SoundController:PlayPressActionButtonUI()
    end)
    p_u_24.CurrentSelection = v_u_20
    v_u_20.MouseButton1Down:Connect(function()
        -- upvalues: (copy) p_u_24, (ref) v_u_20
        p_u_24:SetActiveButton(v_u_20)
    end)
    v_u_21.MouseButton1Down:Connect(function()
        -- upvalues: (copy) p_u_24, (ref) v_u_21
        p_u_24:SetActiveButton(v_u_21)
    end)
    v_u_20.MouseButton1Up:Connect(function()
        -- upvalues: (copy) p_u_24
        p_u_24:TweenToView(p_u_24.RebirthView)
    end)
    v_u_21.MouseButton1Up:Connect(function()
        -- upvalues: (copy) p_u_24
        p_u_24:TweenToView(p_u_24.SkillsView)
    end)
    v_u_22.MouseButton1Down:Connect(function() end)
    v_u_23.MouseButton1Down:Connect(function() end)
    v_u_22.MouseButton1Up:Connect(function()
        -- upvalues: (copy) p_u_24, (ref) v_u_22
        p_u_24:TweenArrow(v_u_22)
        p_u_24:ChangePage(1)
    end)
    v_u_23.MouseButton1Up:Connect(function()
        -- upvalues: (copy) p_u_24, (ref) v_u_23
        p_u_24:TweenArrow(v_u_23)
        p_u_24:ChangePage(-1)
    end)
    p_u_24.RC:ObserveSection("stats", function()
        -- upvalues: (copy) p_u_24
        p_u_24:RefreshSkillStates()
        p_u_24:AllowRebirth()
    end)
    p_u_24.RC.PassChanged:Connect(function()
        -- upvalues: (copy) p_u_24
        p_u_24:AllowRebirth()
    end)
    p_u_24.Controllers.BoostController.StateChanged:Connect(function()
        -- upvalues: (copy) p_u_24
        p_u_24:AllowRebirth()
    end)
    v_u_8.Activated:Connect(function()
        -- upvalues: (copy) p_u_24
        if p_u_24.PurchaseButtonActive and (p_u_24.CanAfford and p_u_24.SelectedSkill) then
            local v48 = p_u_24.Services.GameService:UpgradeSkill(p_u_24.SelectedSkill)
            p_u_24.Controllers.SoundController:PlayPressActionButtonUI()
            if v48 == p_u_24.Constants.SkillUpgradeStatus.OK then
                p_u_24.Controllers.SoundController:PlayRewardedUI()
            end
        end
    end)
    p_u_24:RefreshSkillStates()
    v_u_9.Activated:Connect(function()
        -- upvalues: (copy) p_u_24
        p_u_24:ShowUI(false)
        p_u_24.Controllers.UIController:OpenShopPage("SoulGems")
    end)
end
function v1.Init(p49)
    p49.RebirthSkillMainPanelShown = UDim2.new(0.515, 0, 0.5, 0)
    p49.RebirthSkillMainPanelHidden = UDim2.new(0.53, 0, 2, 0)
    p49.RebirthPromptShown = UDim2.new(0.52, 0, 0.5, 0)
    p49.RebirthPromptHidden = UDim2.new(0.52, 0, 1.5, 0)
    p49.RebirthView = UDim2.new(0, 0, 0, 0)
    p49.SkillsView = UDim2.new(-1, 0, 0, 0)
    p49.PageButtonSize = UDim2.new(0.5, 0, 0.5, 0)
    p49.HUDController = p49.Controllers.HUDController
    p49.Constants = p49.Shared.SharedConstants
    p49.SelectedNavButtonImg = p49.Constants.Images.NAVIGATION_SELECTED
    p49.UnselectedNavButtonImg = p49.Constants.Images.NAVIGATION_UNSELECTED
    p49.DimColor = Color3.fromRGB(20, 20, 20)
    p49.LightColor = Color3.fromRGB(255, 255, 255)
    p49.BlueColor = Color3.fromRGB(49, 156, 255)
    p49.GreyColor = Color3.fromRGB(134, 147, 158)
    p49.FirstOpen = true
    p49.IsOpen = false
end
function v1.InitSkillsData(p50, p51)
    local v52 = p50.Constants
    p50.SkillsData[1] = {
        ["btn"] = p51[1],
        ["mod"] = v52.XP_SKILL_LEVEL_MOD,
        ["skill"] = v52.DataKeys.Skills.XP_SKILL
    }
    p50.SkillsData[2] = {
        ["btn"] = p51[2],
        ["mod"] = v52.SPEED_SKILL_LEVEL_MOD,
        ["skill"] = v52.DataKeys.Skills.SPEED_SKILL
    }
    p50.SkillsData[3] = {
        ["btn"] = p51[3],
        ["mod"] = v52.CRIT_SKILL_LEVEL_MOD,
        ["skill"] = v52.DataKeys.Skills.CRIT_SKILL
    }
    p50.SkillsData[4] = {
        ["btn"] = p51[4],
        ["mod"] = v52.GOLD_SKILL_LEVEL_MOD,
        ["skill"] = v52.DataKeys.Skills.GOLD_SKILL
    }
    p50.SkillsData[5] = {
        ["btn"] = p51[5],
        ["skill"] = v52.DataKeys.Skills.SHIELD_SKILL
    }
    p50.SkillsData[6] = {
        ["btn"] = p51[6],
        ["skill"] = v52.DataKeys.Skills.DUAL_SKILL
    }
end
function v1.RefreshSkillStates(p53)
    local v54 = p53.RC
    p53:SetSkillDataState(1, v54:GetStat("xp_skill") or 0)
    p53:SetSkillDataState(2, v54:GetStat("speed_skill") or 0)
    p53:SetSkillDataState(3, v54:GetStat("crit_skill") or 0)
    p53:SetSkillDataState(4, v54:GetStat("gold_skill") or 0)
    p53:SetSkillDataState(6, v54:GetStat("dual_skill") or 0)
end
function v1.ShowRebirthPrompt(p55, p_u_56)
    -- upvalues: (ref) v_u_15
    p55.Controllers.SoundController:PlayPressActionButtonUI()
    local v57
    if p_u_56 and p55.CanRebirth then
        v57 = p55.RebirthPromptShown
        v_u_15.Visible = true
    else
        v57 = p55.RebirthPromptHidden
    end
    if v_u_15.Position ~= v57 then
        v_u_15:TweenPosition(v57, Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.25, false, function(_)
            -- upvalues: (copy) p_u_56, (ref) v_u_15
            if not p_u_56 then
                v_u_15.Visible = false
            end
        end)
    end
end
function v1.AllowRebirth(p58)
    -- upvalues: (ref) v_u_18, (ref) v_u_19, (ref) v_u_14
    local v59 = p58.RC:GetStat("level") or 0
    local v60 = p58.Constants:TokensForRebirth(v59)
    local v61 = p58.Controllers.InventoryController
    local v62 = v61:GetArtifactBoosts().tokens
    local v63 = p58.Constants:GetBoostedTokens(v60, p58.RC:OwnsPass(p58.SoulGems2xPassId), 0, v62) * p58.Controllers.BoostController:GetPotionMult(p58.Shared.Potions.BoostTypes.TOKENS)
    local v64 = math.ceil(v63)
    local v65 = p58.Controllers.ClanController:GetState()
    local v66 = v65 and (v65.benefits and v65.benefits.gems) or 0
    if v66 > 0 then
        local v67 = v64 * (1 + v66)
        v64 = math.ceil(v67)
    end
    local v68 = v61:GetEnchantBoosts().tokens
    if v68 > 0 then
        local v69 = v64 * (1 + v68)
        v64 = math.ceil(v69)
    end
    v_u_18.Text = "+" .. p58.Shared.Utils:ToSuffixString(v64)
    v_u_19.Text = v_u_18.Text
    if v59 >= 100 then
        v_u_14.ImageColor3 = p58.BlueColor
        p58.CanRebirth = true
    else
        v_u_14.ImageColor3 = p58.GreyColor
        p58.CanRebirth = false
    end
end
function v1.RebirthRequest(p70)
    if p70.CanRebirth then
        local v71 = tick()
        if v71 - (p70._lastRebirthSubmit or 0) < 0.5 then
            return
        end
        p70._lastRebirthSubmit = v71
        p70.Controllers.SoundController:PlayRewardedSFX()
        p70:ChangePage(1)
        p70.Services.GameService:RebirthRequest()
        p70:SetSkillFocus(1)
        p70.Controllers.QuestController:ResetActiveQuest()
    end
end
function v1.CheckSkillRequirements(p72, p73)
    -- upvalues: (ref) v_u_8
    local v74 = p72.Constants
    local _ = v74.SkillUpgradeStatus
    local v75 = p72.SkillsData[p73].skill
    local v76 = v74:GetRequiredSkill(v75)
    if v74:CanUpgradeSkill(v75, p72.SkillsData[p73].rank, v76, p72.SkillsData[p72.SkillsData[p73].reqSkill].rank) then
        p72.PurchaseButtonActive = true
        v_u_8.ImageColor3 = p72.BlueColor
    else
        p72.PurchaseButtonActive = false
        v_u_8.ImageColor3 = p72.GreyColor
    end
end
function v1.SetSkillDataState(p77, p78, p79)
    p77.SkillsData[p78].rank = p79
    if p79 > 0 then
        p77.SkillsData[p78].btn.ImageColor3 = p77.LightColor
    else
        p77.SkillsData[p78].btn.ImageColor3 = p77.DimColor
    end
    if p77.SelectedSkill == p77.SkillsData[p78].skill then
        p77:SetSkillFocus(p78)
    end
end
function v1.AdjustBackgroundSliceScale(_)
    -- upvalues: (ref) v_u_3
    local v80 = v_u_3
    if v80.AbsoluteSize.Y < 1000 and v80.AbsoluteSize.Y > 200 then
        v80.SliceScale = v80.AbsoluteSize.Y / 800
    end
end
function v1.SetPurchaseCost(p81, p82)
    -- upvalues: (ref) v_u_10, (ref) v_u_8, (ref) v_u_12, (ref) v_u_13
    local v83 = p81.Constants:GetSkillUpgradeCost(p81.SkillsData[p82].skill, p81.SkillsData[p82].rank)
    local v84 = p81.RC:GetStat("tokens") or 0
    v_u_10.Text = p81.Shared.Utils:ToSuffixString(v83)
    if p82 == 6 and p81.SkillsData[p82].rank > 0 then
        v_u_10.Text = p81.Shared.Utils:ToSuffixString(0)
    end
    if v83 <= v84 and p81.PurchaseButtonActive then
        v_u_8.ImageColor3 = p81.BlueColor
        p81.CanAfford = true
    elseif v84 < v83 or p82 == 6 and p81.SkillsData[p82].rank > 0 then
        v_u_8.ImageColor3 = p81.GreyColor
        p81.CanAfford = false
    end
    if p81.SkillsData[p82].rank > 0 then
        v_u_12.Text = "Upgrade"
        v_u_13.Text = "Upgrade"
    else
        v_u_12.Text = "Unlock"
        v_u_13.Text = "Unlock"
    end
end
function v1.SetInspectionPanel(p85, p86)
    -- upvalues: (ref) v_u_4, (ref) v_u_6, (ref) v_u_7, (ref) v_u_5
    local v87
    if p85.SkillsData[p86].mod == nil then
        v87 = p85.SkillsData[p86].desc
    else
        local v88 = p85.SkillsData[p86].mod * (p85.SkillsData[p86].rank + 1) * 100
        v87 = p85.SkillsData[p86].desc .. v88 .. "%"
    end
    v_u_4.Image = p85.SkillsData[p86].btn.Image
    if p86 == 5 or p86 == 6 then
        v_u_6.Text = p85.SkillsData[p86].title .. " "
    else
        v_u_6.Text = p85.SkillsData[p86].title .. " " .. p85.SkillsData[p86].rank + 1
    end
    v_u_7.Text = v87
    local v89 = p85.SkillsData[p86].rank
    local v90
    if p86 == 1 and v89 < 1 then
        v90 = "Required: None"
    elseif p86 == 1 and v89 >= 1 then
        local v91 = p85.SkillsData[p86].requirment
        local v92 = p85.SkillsData[p86].rank
        v90 = "Required: " .. v91 .. "Rank " .. tostring(v92)
    elseif p86 == 6 and v89 == 1 then
        v90 = ""
    else
        local v93 = p85.SkillsData[p86].requirment
        local v94 = p85.SkillsData[p86].rank + 1
        v90 = "Required: " .. v93 .. tostring(v94)
    end
    v_u_5.Text = v90
end
function v1.SetSkillFocus(p95, p96)
    p95.SelectedSkill = p95.SkillsData[p96].skill
    p95.SelectedSkillBtn:WaitForChild("selected").Visible = false
    p95.SelectedSkillBtn = p95.SkillsData[p96].btn
    p95.SelectedSkillBtn:WaitForChild("selected").Visible = true
    p95:CheckSkillRequirements(p96)
    p95:SetInspectionPanel(p96)
    p95:SetPurchaseCost(p96)
end
function v1.ShowUI(p_u_97, p98)
    -- upvalues: (ref) v_u_3, (ref) v_u_22, (ref) v_u_23
    if v_u_3 then
        if p98 == nil then
            p98 = not p_u_97.IsOpen
        end
        if p98 and (p_u_97.FirstOpen and p_u_97.SkillsData) then
            p_u_97.FirstOpen = false
            p_u_97:SetSkillFocus(1)
            p_u_97:AllowRebirth()
        end
        if p98 ~= p_u_97.IsOpen then
            p_u_97.IsOpen = p98
            p_u_97:AdjustBackgroundSliceScale()
            local v99
            if p98 then
                v_u_3.Visible = true
                v99 = p_u_97.RebirthSkillMainPanelShown
                p_u_97:PulseButton(v_u_22, p_u_97.PageButtonSize)
                p_u_97:PulseButton(v_u_23, p_u_97.PageButtonSize)
            else
                v99 = p_u_97.RebirthSkillMainPanelHidden
            end
            v_u_3:TweenPosition(v99, Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.25, true, function(p100)
                -- upvalues: (copy) p_u_97, (ref) v_u_3
                if p100 == Enum.TweenStatus.Completed and not p_u_97.IsOpen then
                    v_u_3.Visible = false
                end
            end)
        end
    else
        return
    end
end
function v1.ChangePage(p101, p102)
    -- upvalues: (ref) v_u_20, (ref) v_u_21
    local v103 = {
        {
            ["button"] = v_u_20,
            ["view"] = p101.RebirthView
        },
        {
            ["button"] = v_u_21,
            ["view"] = p101.SkillsView
        }
    }
    local v104 = nil
    for v105, v106 in pairs(v103) do
        if v106.button == p101.CurrentSelection then
            v104 = v105
        end
    end
    local v107 = v104 + p102
    local v108
    if v107 < 1 then
        v108 = #v103
    else
        v108 = #v103 < v107 and 1 or v107
    end
    p101:SetActiveButton(v103[v108].button, v103[v108].view)
end
function v1.PulseButton(_, p_u_109, p_u_110)
    -- upvalues: (copy) v_u_2, (ref) v_u_3
    spawn(function()
        -- upvalues: (copy) p_u_109, (copy) p_u_110, (ref) v_u_2, (ref) v_u_3
        if p_u_109.Size ~= p_u_110 then
            p_u_109.Size = p_u_110
        end
        local v111 = {
            ["Size"] = UDim2.new(p_u_109.Size.X.Scale * 1.2, 0, p_u_109.Size.Y.Scale * 1.2, 0)
        }
        local v_u_112 = v_u_2:Create(p_u_109, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 100, true, 0), v111)
        local v113 = v_u_3.Changed:Connect(function()
            -- upvalues: (ref) v_u_3, (copy) v_u_112, (ref) p_u_109, (ref) p_u_110
            if not v_u_3.Visible then
                v_u_112:Cancel()
                p_u_109.Size = p_u_110
            end
        end)
        while v_u_3.Visible do
            v_u_112:Play()
            v_u_112.Completed:wait()
            p_u_109.Size = p_u_110
        end
        v113:Disconnect()
    end)
end
function v1.TweenArrow(_, p_u_114)
    -- upvalues: (ref) v_u_22, (ref) v_u_23, (copy) v_u_2
    spawn(function()
        -- upvalues: (copy) p_u_114, (ref) v_u_22, (ref) v_u_23, (ref) v_u_2
        local v115 = nil
        local v116 = nil
        local v117 = UDim2.new(0.67, 0, 0.43, 0)
        local v118 = UDim2.new(0.33, 0, 0.43, 0)
        local v119 = UDim2.new(0.78, 0, 0.43, 0)
        local v120 = UDim2.new(0.2, 0, 0.43, 0)
        if p_u_114 == v_u_22 then
            v118 = v117
            v120 = v119
        elseif p_u_114 ~= v_u_23 then
            v118 = v116
            v120 = v115
        end
        local v121 = v_u_2:Create(p_u_114, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, true, 0), {
            ["Position"] = v120
        })
        v121:Play()
        v121.Completed:wait()
        p_u_114.Position = v118
    end)
end
function v1.SetActiveButton(p122, p123, p124)
    -- upvalues: (ref) v_u_20, (ref) v_u_21
    p122.Controllers.SoundController:PlayButtonPressUI(1.2)
    v_u_20.Image = p122.UnselectedNavButtonImg
    v_u_21.Image = p122.UnselectedNavButtonImg
    p123.Image = p122.SelectedNavButtonImg
    p122.CurrentSelection = p123
    if p124 then
        p122:TweenToView(p124)
    end
end
function v1.TweenToView(p125, p126)
    -- upvalues: (ref) v_u_11
    if v_u_11.Position ~= p126 then
        p125.Controllers.SoundController:PlayPageTurnUI()
        v_u_11:TweenPosition(p126, Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.25, true, function(_) end)
    end
end
return v1