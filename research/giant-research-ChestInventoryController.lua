-- Decompiled game.Players.BoomerIsBigMan.PlayerScripts.Aero.Controllers.ChestInventoryController

local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Packages.signal)
local v_u_4 = require(v2.ZapClient)
local v_u_5 = nil
local v_u_6 = nil
local v_u_7 = nil
function v1.Init(p8)
    -- upvalues: (ref) v_u_6, (ref) v_u_7, (ref) v_u_5, (copy) v_u_3
    v_u_6 = p8.Shared.SharedConstants
    v_u_7 = p8.Shared.Crates
    v_u_5 = p8.Controllers.HUDController
    p8.ChestsChanged = v_u_3.new()
    p8._revealActive = false
    p8._lastChestType = v_u_7.ItemType.SKIN
    p8.TierKeyOrder = {
        {
            ["weapon"] = v_u_7.Keys.T3W,
            ["skin"] = v_u_7.Keys.T3S
        },
        {
            ["weapon"] = v_u_7.Keys.T2W,
            ["skin"] = v_u_7.Keys.T2S
        },
        {
            ["weapon"] = v_u_7.Keys.T1W,
            ["skin"] = v_u_7.Keys.T1S
        }
    }
end
function v1.Start(p_u_9)
    p_u_9.Player = game.Players.LocalPlayer
    while not p_u_9.Player do
        game.Players.PlayerAdded:wait()
        p_u_9.Player = game.Players.LocalPlayer
    end
    p_u_9.Controllers.InventoryController.Changed:Connect(function(p10)
        -- upvalues: (copy) p_u_9
        if p10 == "chests" then
            p_u_9.ChestsChanged:Fire()
        end
    end)
    p_u_9.ChestsChanged:Fire()
end
function v1.BuyChest(p11, p12)
    -- upvalues: (ref) v_u_7, (ref) v_u_5
    local v13 = p11.Shared.SharedConstants
    if p11.Controllers.ReplicaController:GetSession("priRestricted") == true then
        p11.Controllers.UIController:ShowToast({
            ["title"] = v13.ServerResponseMessage[v13.ServerResponse.ERR_PRI_RESTRICTED]
        })
        return
    else
        local v14 = p12 and v_u_7.Costs
        if v14 then
            v14 = v_u_7.Costs[p12]
        end
        if p12 and (v14 and v14 <= v_u_5:GetGoldAmt()) then
            if p11.Services.GameService:BuyCrate(p12) then
                p11.Controllers.SoundController:PlayRewardedUI()
            else
                warn("Failed to purchase chest")
                p11.Controllers.SoundController:PlayErrorUI()
            end
        elseif p12 == nil then
            p11.Controllers.UIController:ShowToast({})
        else
            p11.Controllers.UIController:ShowToast({})
        end
    end
end
function v1.SellChests(p15, p16)
    p15.Controllers.SoundController:PlayPressActionButtonUI()
    if p16 then
        if p15.Services.GameService:SellAllCratesRequest(p16) then
            p15.Controllers.SoundController:PlayRewardedUI()
        else
            warn("Failed to sell chests")
            p15.Controllers.SoundController:PlayErrorUI()
        end
    else
        p15.Controllers.UIController:ShowToast({})
        return
    end
end
function v1.GetChestCount(p17, p18)
    local v19 = p17.Controllers.InventoryController:GetChestCounts()
    return v19 and v19[p18] or 0
end
function v1.GetTotalChestCount(p20)
    -- upvalues: (ref) v_u_7
    local v21 = 0
    for _, v22 in pairs(v_u_7.Keys) do
        v21 = v21 + p20:GetChestCount(v22)
    end
    return v21
end
function v1.GetNextChestKey(p23)
    -- upvalues: (ref) v_u_7
    local v24 = p23.TierKeyOrder
    if not v24 then
        return nil
    end
    for _, v25 in ipairs(v24) do
        local v26 = p23:GetChestCount(v25.weapon)
        local v27 = p23:GetChestCount(v25.skin)
        if v26 + v27 > 0 then
            if p23._lastChestType ~= v_u_7.ItemType.WEAPON then
                return v26 > 0 and v25.weapon or v25.skin
            else
                return v27 > 0 and v25.skin or v25.weapon
            end
        end
    end
    return nil
end
function v1.BuildItemCard(p28, p29, p30, p31)
    -- upvalues: (ref) v_u_7
    if p29 == v_u_7.ItemType.WEAPON then
        local v32 = p28.Shared.Weapons.Data[p30]
        if not v32 then
            return nil
        end
        local v33 = p28.Shared.ItemRarity
        local v34 = v32.Tier
        local v35 = v33.Color(p29, p30, v34)
        local v36 = v33.Name(p29, p30, v34)
        local v37 = v33.Icon(p29, p30)
        return {
            ["modelName"] = v32.Name,
            ["crateModelName"] = p31,
            ["name"] = v32.DisplayName,
            ["color"] = v35,
            ["rarityText"] = v36,
            ["eventIcon"] = v37
        }
    end
    if p29 ~= v_u_7.ItemType.SKIN then
        return nil
    end
    local v38 = p28.Shared.Skins.Data[p30]
    if not v38 then
        return nil
    end
    local v39 = p28.Shared.ItemRarity
    local v40 = v38.Tier
    local v41 = v39.Color(p29, p30, v40)
    local v42 = v39.Name(p29, p30, v40)
    local v43 = v39.Icon(p29, p30)
    return v38.Icon and v38.Icon ~= "" and {
        ["icon"] = v38.Icon,
        ["crateModelName"] = p31,
        ["name"] = v38.DisplayName or v38.Name,
        ["color"] = v41,
        ["rarityText"] = v42,
        ["eventIcon"] = v43
    } or {
        ["modelName"] = v38.Name,
        ["rotY"] = v38.CustomBody and 180 or 0,
        ["crateModelName"] = p31,
        ["name"] = v38.DisplayName or v38.Name,
        ["color"] = v41,
        ["rarityText"] = v42,
        ["eventIcon"] = v43
    }
end
function v1.OpenChestsPayload(p_u_44, p_u_45, p_u_46)
    -- upvalues: (ref) v_u_7, (copy) v_u_4
    if p_u_45 == nil or v_u_7.Data[p_u_45] ~= nil then
        local v47
        if p_u_45 then
            v47 = p_u_44:GetChestCount(p_u_45)
        else
            v47 = p_u_44:GetTotalChestCount()
        end
        local v48 = p_u_44.Controllers.InventoryController
        if v48 then
            v48 = p_u_44.Controllers.InventoryController:GetChestCounts()
        end
        if v48 then
            if p_u_45 then
                local v49 = v48[p_u_45] or 0
                v47 = math.max(v47, v49)
            else
                local v50 = 0
                for _, v51 in pairs(v48) do
                    v50 = v50 + v51
                end
                v47 = math.max(v47, v50)
            end
        end
        if v47 <= 0 then
            p_u_44.Controllers.UIController:ShowToast({})
            return nil
        else
            local function v53()
                -- upvalues: (ref) v_u_4, (copy) p_u_45, (copy) p_u_46
                local v52 = {
                    ["crate"] = p_u_45,
                    ["count"] = p_u_46
                }
                return v_u_4.OpenChests.Call(v52)
            end
            local v54, v55 = pcall(v53)
            if v54 and v55 ~= nil then
                if v55.status == "ok" and #v55.results ~= 0 then
                    local v56 = {}
                    for _, v57 in ipairs(v55.results) do
                        local v58 = v_u_7.Data[v57.crate]
                        local v59 = v57.itemType
                        local v60 = v57.itemId
                        if v58 then
                            v58 = v58.Mesh
                        end
                        local v61 = p_u_44:BuildItemCard(v59, v60, v58)
                        if v61 then
                            table.insert(v56, v61)
                        end
                    end
                    if #v56 == 0 then
                        warn("OpenChests returned no displayable rewards")
                        return nil
                    else
                        p_u_44._lastChestType = v55.results[#v55.results].itemType
                        return {
                            ["results"] = v56,
                            ["remaining"] = v55.remaining,
                            ["onClosed"] = function()
                                -- upvalues: (copy) p_u_44
                                p_u_44._revealActive = false
                            end
                        }
                    end
                else
                    local v62 = v55.status == "no_space" and "Not enough room in inventory, sell some items to make room!" or (v55.status == "none_owned" and "You must have a chest to open! Buy one first" or "Something went wrong opening that chest!")
                    p_u_44.Controllers.UIController:ShowToast({
                        ["title"] = v62
                    })
                    return nil
                end
            else
                warn("OpenChests request failed: " .. tostring(v55))
                return nil
            end
        end
    else
        warn("Invalid chest selection!")
        return nil
    end
end
function v1.OpenChests(p63, p64, p65)
    if p63._revealActive then
        return
    else
        p63._revealActive = true
        local v66 = p63:OpenChestsPayload(p64, p65 or 1)
        if v66 then
            p63.Controllers.UIController:ShowChestReveal(v66)
        else
            p63._revealActive = false
        end
    end
end
function v1.OpenNextChest(p67)
    if p67:GetTotalChestCount() > 0 then
        p67:OpenChests(nil, 1)
    end
end
return v1