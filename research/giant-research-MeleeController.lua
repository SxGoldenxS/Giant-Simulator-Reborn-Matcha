-- Decompiled game.Players.BoomerIsBigMan.PlayerScripts.Aero.Controllers.MeleeController

local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("RunService")
local v3 = {}
local v_u_4 = nil
local v_u_5 = nil
local v_u_6 = nil
local v_u_7 = Color3.fromRGB(0, 255, 0)
function v3.Init(p8)
    -- upvalues: (ref) v_u_4, (ref) v_u_5, (ref) v_u_6
    v_u_4 = p8.Shared.SharedConstants.RemoteEvents
    v_u_5 = p8.Shared.MeleeHitbox
    v_u_6 = p8.Shared.Utils
end
function v3.Start(p_u_9)
    -- upvalues: (copy) v_u_1, (ref) v_u_4, (copy) v_u_2
    p_u_9.Player = v_u_1.LocalPlayer
    p_u_9.PlayerController = p_u_9.Controllers.PlayerController
    p_u_9.Swinging = false
    p_u_9.HitThisSwing = {}
    p_u_9.SwingParams = OverlapParams.new()
    p_u_9.SwingParams.FilterType = Enum.RaycastFilterType.Include
    p_u_9.SwingParams.RespectCanCollide = false
    p_u_9.DebugEnabled = false
    p_u_9.DebugBoxes = {}
    p_u_9.Services.GameService[v_u_4.SWING_DEBUG_SET]:Connect(function(p10)
        -- upvalues: (copy) p_u_9
        p_u_9:SetDebug(p10)
    end)
    v_u_2.Heartbeat:Connect(function()
        -- upvalues: (copy) p_u_9
        p_u_9:OnHeartbeat()
    end)
end
function v3.OnSwingStart(p11)
    -- upvalues: (copy) v_u_1
    local v12 = {}
    for _, v13 in ipairs(v_u_1:GetPlayers()) do
        if v13 ~= p11.Player and v13.Character then
            v12[#v12 + 1] = v13.Character
        end
    end
    local v14 = workspace:FindFirstChild("NPC")
    if v14 then
        v12[#v12 + 1] = v14
    end
    p11.SwingParams.FilterDescendantsInstances = v12
    table.clear(p11.HitThisSwing)
    p11.Swinging = true
end
function v3.OnSwingEnd(p15)
    p15.Swinging = false
    table.clear(p15.HitThisSwing)
end
function v3.OnHeartbeat(p16)
    -- upvalues: (ref) v_u_5
    if p16.Swinging or p16.DebugEnabled then
        if p16.Player.Character then
            local v17 = {}
            local v18, v19 = v_u_5.ComputeWeaponBox(p16.PlayerController.Weapon)
            if v18 then
                v17[#v17 + 1] = {
                    ["cframe"] = v18,
                    ["size"] = v19
                }
            end
            local v20, v21 = v_u_5.ComputeWeaponBox(p16.PlayerController.Offhand)
            if v20 then
                v17[#v17 + 1] = {
                    ["cframe"] = v20,
                    ["size"] = v21
                }
            end
            if p16.Swinging then
                for _, v22 in ipairs(v17) do
                    for _, v23 in ipairs(workspace:GetPartBoundsInBox(v22.cframe, v22.size, p16.SwingParams)) do
                        p16:TryReport(v23)
                    end
                end
            end
            if p16.DebugEnabled then
                p16:UpdateDebugBoxes(v17)
            end
        end
    else
        return
    end
end
function v3.ResolveTarget(p24, p25)
    -- upvalues: (ref) v_u_6
    local v26 = v_u_6:GetPlayerFromPart(p25)
    if v26 then
        if v26 == p24.Player then
            return nil
        else
            return v26
        end
    else
        local v27 = workspace:FindFirstChild("NPC")
        if v27 then
            local v28 = p25:FindFirstAncestorOfClass("Model")
            if v28 and v28:IsDescendantOf(v27) then
                return v28
            end
        end
        return nil
    end
end
function v3.TryReport(p29, p30)
    -- upvalues: (ref) v_u_4
    local v31 = p29:ResolveTarget(p30)
    if v31 and not p29.HitThisSwing[v31] then
        p29.HitThisSwing[v31] = true
        p29.Services.GameService[v_u_4.MELEE_HIT]:Fire(p30)
    end
end
function v3.SetDebug(p32, p33)
    p32.DebugEnabled = p33 and true or false
    if not p32.DebugEnabled then
        p32:HideDebugBoxes()
    end
end
function v3.EnsureDebugBox(p34, p35)
    -- upvalues: (copy) v_u_7
    local v36 = p34.DebugBoxes[p35]
    if v36 and v36.Parent then
        return v36
    end
    local v37 = Instance.new("Part")
    v37.Name = "MeleeSwingHitbox" .. p35
    v37.Anchored = true
    v37.CanCollide = false
    v37.CanTouch = false
    v37.CanQuery = false
    v37.CastShadow = false
    v37.Material = Enum.Material.Neon
    v37.Color = v_u_7
    v37.Transparency = 0.65
    v37.Parent = workspace
    p34.DebugBoxes[p35] = v37
    return v37
end
function v3.UpdateDebugBoxes(p38, p39)
    for v40, v41 in ipairs(p39) do
        local v42 = p38:EnsureDebugBox(v40)
        v42.Size = v41.size
        v42.CFrame = v41.cframe
        v42.Transparency = 0.65
    end
    for v43 = #p39 + 1, #p38.DebugBoxes do
        if p38.DebugBoxes[v43] then
            p38.DebugBoxes[v43].Transparency = 1
        end
    end
end
function v3.HideDebugBoxes(p44)
    for _, v45 in ipairs(p44.DebugBoxes) do
        v45.Transparency = 1
    end
end
return v3