-- Decompiled game.Players.BoomerIsBigMan.PlayerScripts.Aero.Controllers.PlayerController

local v_u_1 = game:GetService("UserInputService")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("MarketplaceService")
local v_u_5 = game:GetService("ContextActionService")
local v_u_6 = game:GetService("GamepadService")
local v_u_7 = require(v3:WaitForChild("ZapClient"))
local v_u_8 = require(v3.Packages.signal)
local v9 = {}
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = nil
local _ = Enum.UserInputType.MouseButton1
local _ = Enum.UserInputType.Touch
local v_u_13 = {
    ["WPN_IDLE"] = {},
    ["WPN_SLASH_1"] = {},
    ["WPN_SLASH_2"] = {},
    ["DUAL_IDLE"] = {},
    ["DUAL_SLASH_1"] = {},
    ["DUAL_SLASH_2"] = {},
    ["DEATH"] = {},
    ["DANCE_1"] = {}
}
function v9.Start(p_u_14)
    -- upvalues: (ref) v_u_12, (copy) v_u_2, (copy) v_u_1, (copy) v_u_5, (copy) v_u_6
    p_u_14.Dead = false
    p_u_14.Services.GameService[v_u_12.INIT_DEATH]:Connect(function()
        -- upvalues: (copy) p_u_14
        p_u_14:OnInitDeath()
    end)
    p_u_14.Services.GameService[v_u_12.RESPAWN]:Connect(function()
        -- upvalues: (copy) p_u_14
        p_u_14:OnRespawn()
    end)
    p_u_14.Services.GameService[v_u_12.REPLICATE_CLIENT_ATTACK]:Connect(function(p15, p16)
        -- upvalues: (copy) p_u_14
        if p_u_14.Player ~= p15 then
            p_u_14:PlayWeaponSound(p16)
        end
    end)
    p_u_14.Services.GameService[v_u_12.DISCO_COMMAND]:Connect(function(p17)
        -- upvalues: (copy) p_u_14
        p_u_14:OnDiscoCommand(p17)
    end)
    p_u_14.Services.GameService[v_u_12.SKELLY_COMMAND]:Connect(function(p18)
        -- upvalues: (copy) p_u_14
        p_u_14:OnSkellyCommand(p18)
    end)
    p_u_14.Player = game.Players.LocalPlayer
    while not p_u_14.Player do
        game.Players.PlayerAdded:wait()
        p_u_14.Player = game.Players.LocalPlayer
    end
    local v19 = p_u_14.LoadAnimations
    pcall(v19, p_u_14)
    p_u_14.ToolAnimTracks = {}
    if p_u_14.Player.Character then
        p_u_14:OnCharacterAdded(p_u_14.Player.Character)
    end
    p_u_14.Player.CharacterAdded:Connect(function(p20)
        -- upvalues: (copy) p_u_14
        p_u_14:OnCharacterAdded(p20)
    end)
    p_u_14.Player.CharacterRemoving:Connect(function(p21)
        -- upvalues: (copy) p_u_14
        p_u_14:OnCharacterRemoving(p21)
    end)
    v_u_2.Stepped:Connect(function(_, p22)
        -- upvalues: (copy) p_u_14
        p_u_14:OnStepped(p22)
    end)
    if v_u_1.TouchEnabled and v_u_1.MouseEnabled == false then
        v_u_1.TouchTapInWorld:Connect(function(_, p23)
            -- upvalues: (copy) p_u_14
            if not p23 then
                p_u_14:OnWeaponActivated(true)
            end
        end)
    else
        v_u_1.InputBegan:Connect(function(p24, p25)
            -- upvalues: (copy) p_u_14
            if not p25 and (p24.UserInputType == Enum.UserInputType.MouseButton1 or p24.UserInputType == Enum.UserInputType.Touch) then
                p_u_14:OnWeaponActivated(true)
            end
        end)
    end
    v_u_5:BindActionAtPriority("GiantSimGamepadSwing", function(_, p26, _)
        -- upvalues: (ref) v_u_6, (copy) p_u_14
        if p26 ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass
        end
        if v_u_6.GamepadCursorEnabled then
            return Enum.ContextActionResult.Pass
        end
        p_u_14:OnWeaponActivated(true)
        return Enum.ContextActionResult.Sink
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonR2)
    local v_u_27 = p_u_14.Controllers.ReplicaController
    local v_u_28 = p_u_14.Shared.IAPData.Passes.AUTOCLICKER
    v_u_27.PassChanged:Connect(function(p29)
        -- upvalues: (copy) v_u_28, (copy) v_u_27, (copy) p_u_14
        if p29 == 0 or p29 == v_u_28 then
            local v30 = v_u_27:OwnsPass(v_u_28)
            if v30 ~= p_u_14.CanAutoClick then
                p_u_14.CanAutoClick = v30
                p_u_14.Controllers.UIController:RefreshAutoAttack()
            end
        end
    end)
    v_u_27:OnReady(function()
        -- upvalues: (copy) v_u_27, (copy) v_u_28, (copy) p_u_14
        local v31 = v_u_27:OwnsPass(v_u_28)
        if v31 ~= p_u_14.CanAutoClick then
            p_u_14.CanAutoClick = v31
            p_u_14.Controllers.UIController:RefreshAutoAttack()
        end
    end)
    v_u_27:OnReady(function()
        -- upvalues: (copy) v_u_27, (copy) p_u_14
        if v_u_27:GetSetting("autoSwing") == true then
            p_u_14:SetAutoClick(true, false)
        end
    end)
    spawn(function()
        -- upvalues: (copy) p_u_14, (ref) v_u_12
        local v_u_32 = false
        local v33 = false
        while not v_u_32 do
            local function v34()
                -- upvalues: (ref) v_u_32, (ref) p_u_14
                v_u_32 = p_u_14.Player:IsInGroup(3497226)
            end
            pcall(v34)
            if v_u_32 then
                p_u_14.Services.GameService[v_u_12.PLAYER_IN_GROUP]:Fire()
            end
            wait(30)
            if v33 or v_u_32 then
                if v_u_32 then
                    p_u_14.Controllers.HUDController:TweenGroupStatusMsg(v_u_32)
                end
            else
                p_u_14.Controllers.HUDController:TweenGroupStatusMsg(v_u_32)
                v33 = true
            end
        end
    end)
end
function v9.Init(p_u_35)
    -- upvalues: (ref) v_u_10, (ref) v_u_12, (ref) v_u_11, (copy) v_u_8, (copy) v_u_7
    v_u_10 = p_u_35.Shared.SharedConstants
    v_u_12 = v_u_10.RemoteEvents
    v_u_11 = p_u_35.Shared.Weapons
    p_u_35.CanAutoClick = false
    p_u_35.DoAutoClick = false
    p_u_35.LastAltSwing = 0
    p_u_35.RemotePitch = {}
    p_u_35.SwingStarted = v_u_8.new()
    v_u_7.PlayerPitchToClient.On(function(p36)
        -- upvalues: (copy) p_u_35
        if p36.player ~= game.Players.LocalPlayer then
            p_u_35.RemotePitch[p36.player] = p36.pitch
        end
    end)
    game.Players.PlayerRemoving:Connect(function(p37)
        -- upvalues: (copy) p_u_35
        p_u_35.RemotePitch[p37] = nil
    end)
end
function v9.OnInitDeath(p38)
    p38.Dead = true
    p38:Pitch(0, false)
end
function v9.OnRespawn(p39)
    p39.Dead = false
end
function v9.LoadAnimations(p40)
    -- upvalues: (copy) v_u_13
    p40.Animations = {}
    for v41, v42 in pairs(v_u_13) do
        local v43 = Instance.new("Animation")
        v43.Name = v41
        v43.AnimationId = v42.asset
        p40.Animations[v41] = v43
    end
end
function v9.OnCharacterAdded(p_u_44, p45)
    p_u_44.Character = p45
    p_u_44.Character:WaitForChild("Humanoid").Died:Connect(function()
        -- upvalues: (copy) p_u_44
        p_u_44:OnDied()
    end)
    p45.ChildAdded:Connect(function(p46)
        -- upvalues: (copy) p_u_44
        local v47 = p46:GetAttribute("EquipSlot")
        if v47 == "main" and p46 ~= p_u_44.Weapon then
            p_u_44:OnWeaponRefUpdate(p46)
        elseif v47 == "offhand" and p46 ~= p_u_44.Offhand then
            p_u_44:OnOffhandRefUpdate(p46)
        end
    end)
    p45.ChildRemoved:Connect(function(p48)
        -- upvalues: (copy) p_u_44
        if p48 == p_u_44.Weapon then
            p_u_44.Weapon = nil
        elseif p48 == p_u_44.Offhand then
            p_u_44.Offhand = nil
        end
    end)
    for _, v49 in ipairs(p45:GetChildren()) do
        local v50 = v49:GetAttribute("EquipSlot")
        if v50 == "main" and v49 ~= p_u_44.Weapon then
            p_u_44:OnWeaponRefUpdate(v49)
        elseif v50 == "offhand" and v49 ~= p_u_44.Offhand then
            p_u_44:OnOffhandRefUpdate(v49)
        end
    end
end
function v9.EquipWeapon(p51, p52)
    p51.Weapon = p52
    if p51.Character ~= nil and p52 ~= nil then
        p51.Weapon.Parent = p51.Character
        p51:StartIdling()
        if p51.DoAutoClick then
            wait()
            p51:OnWeaponActivated()
        end
    end
end
function v9.UnequipWeapon(p53)
    if p53.Character ~= nil and p53.Weapon ~= nil then
        local v54 = p53.Player:WaitForChild("Backpack")
        p53.Weapon.Parent = v54
        p53:StopIdling()
    end
end
function v9.OnWeaponRefUpdate(p55, p56)
    p55.Weapon = p56
    p55:SetWeaponEquipped(true)
end
function v9.OnOffhandRefUpdate(p57, p58)
    p57.Offhand = p58
    p57:SetOffhandEquipped(true)
end
function v9.IsDualWielding(p59)
    return p59.Character and (p59.Weapon and (p59.Offhand and (p59.Weapon.Parent == p59.Character and p59.Offhand.Parent == p59.Character))) and true or false
end
function v9.IsIdlePlaying(p60)
    singleIdleTrack = p60:LoadAnimTrack("WPN_IDLE", p60.ToolAnimTracks)
    dualIdleTrack = p60:LoadAnimTrack("DUAL_IDLE", p60.ToolAnimTracks)
    return singleIdleTrack.IsPlaying or dualIdleTrack.IsPlaying
end
function v9.StopIdling(p61)
    singleIdleTrack = p61:LoadAnimTrack("WPN_IDLE", p61.ToolAnimTracks)
    dualIdleTrack = p61:LoadAnimTrack("DUAL_IDLE", p61.ToolAnimTracks)
    if singleIdleTrack.IsPlaying then
        singleIdleTrack:Stop()
    end
    if dualIdleTrack.IsPlaying then
        dualIdleTrack:Stop()
    end
end
function v9.StartIdling(p62)
    local v63 = p62:LoadAnimTrack(p62:IsDualWielding() and "DUAL_IDLE" or "WPN_IDLE", p62.ToolAnimTracks)
    if v63 then
        v63:Play()
    end
end
function v9.RestoreAfterRagdoll(p64)
    if p64.Character then
        p64.Controllers.MeleeController:OnSwingEnd()
        if p64:IsWeaponEquipped() and not p64:IsIdlePlaying() then
            p64:StartIdling()
        end
        if p64.DoAutoClick and p64:IsWeaponEquipped() then
            p64:OnWeaponActivated()
        end
    end
end
function v9.GetLoadoutAPS(p65)
    -- upvalues: (ref) v_u_11
    local v66 = v_u_11.Keys[p65.Weapon.Name]
    local v67
    if p65:IsDualWielding() then
        v67 = v_u_11.Keys[p65.Offhand.Name]
    else
        v67 = nil
    end
    return v_u_11:GetLoadoutAPS(v66, v67)
end
function v9.StartPrimaryAttack(p68)
    -- upvalues: (copy) v_u_13
    local v69 = p68:IsDualWielding() and "DUAL_SLASH_1" or "WPN_SLASH_1"
    local v70 = p68:LoadAnimTrack(v69, p68.ToolAnimTracks)
    if v70 then
        v70:Play(v_u_13[v69].transTime, 1, p68:GetLoadoutAPS())
    end
end
function v9.StartSecondaryAttack(p71)
    -- upvalues: (copy) v_u_13
    local v72 = p71:IsDualWielding() and "DUAL_SLASH_2" or "WPN_SLASH_2"
    local v73 = p71:LoadAnimTrack(v72, p71.ToolAnimTracks)
    if v73 then
        v73:Play(v_u_13[v72].transTime, 1, p71:GetLoadoutAPS())
    end
end
function v9.OnWeaponActivated(p74, p75)
    -- upvalues: (copy) v_u_7
    local v76 = p74.Controllers.FishingController
    if v76 and v76:HandleActivation() then
        if p74.DoAutoClick then
            p74:SetAutoClick(false)
        end
        return
    elseif p74.Weapon == nil then
        warn("OnWeaponActivated called with nil weapon!")
        return
    elseif p74:IsWeaponEquipped() == false then
        return
    else
        if p75 then
            v_u_7.TrainClick.Fire()
        end
        local v77 = p74:LoadAnimTrack(p74:IsDualWielding() and "DUAL_SLASH_1" or "WPN_SLASH_1", p74.ToolAnimTracks)
        if p74:IsIdlePlaying() then
            p74:StopIdling()
            p74:StartPrimaryAttack()
            return
        elseif v77.IsPlaying then
            p74.LastAltSwing = elapsedTime()
        end
    end
end
function v9.IsWeaponEquipped(p78)
    if p78.Weapon and p78.Character then
        return p78.Weapon.Parent == p78.Character
    else
        return false
    end
end
function v9.SetWeaponEquipped(p79, p80)
    if p79.Character then
        if p79.Weapon then
            if p80 then
                p79:EquipWeapon(p79.Weapon)
            else
                p79:UnequipWeapon()
            end
        else
            return
        end
    else
        return
    end
end
function v9.SetOffhandEquipped(p81, p82)
    if p81.Character then
        if p81.Offhand then
            if p82 then
                p81:EquipOffhand(p81.Offhand)
            else
                p81:UnequipOffhand()
            end
        else
            return
        end
    else
        return
    end
end
function v9.EquipOffhand(p83, p84)
    p83.Offhand = p84
    if p83.Character ~= nil and p84 ~= nil then
        p83.Offhand.Parent = p83.Character
        p83:StopIdling()
        p83:StartIdling()
    end
end
function v9.UnequipOffhand(p85)
    if p85.Character ~= nil and p85.Offhand ~= nil then
        local v86 = p85.Player:WaitForChild("Backpack")
        p85.Offhand.Parent = v86
    end
end
function v9.ToggleWeaponEquipped(p87)
    p87:SetWeaponEquipped(not p87:IsWeaponEquipped())
end
function v9.OnDied(p88)
    p88.Character = nil
    p88.Weapon = nil
end
function v9.OnCharacterRemoving(p89, _)
    p89:ResetToolAnimations()
end
function v9.PlayWeaponSound(p90, p91)
    if p91 == nil then
        warn("Nil PlayWeaponSound argument found!")
    else
        local v92 = p91:FindFirstChild("Blade")
        if v92 then
            local v93 = v92:FindFirstChild("Swoosh")
            p90.Controllers.SoundController:PlaySoundEffect(v93)
        end
    end
end
function v9.EnableTrail(p94, p95)
    local v96 = p95 and p94.Weapon:FindFirstChild("Handle")
    if v96 then
        local v97 = v96:FindFirstChild("TrailAt0")
        local v98 = v97 and v97:FindFirstChild("Trail")
        if v98 then
            v98.Enabled = true
        end
    end
end
function v9.AnimKeyframeReached(p99, p100, p101)
    -- upvalues: (ref) v_u_12
    if p101 == "BeamStart" then
        p99.Services.GameService[v_u_12.WEAPON_ATTACK_START]:Fire()
        p99.Controllers.MeleeController:OnSwingStart()
        p99.Controllers.SoundController:PlayLocalSwingSound()
        p99:EnableTrail(p99.Weapon)
        p99:EnableTrail(p99.Offhand)
        p99.SwingStarted:Fire()
    end
    if p101 == "End" then
        local v102 = p99.Controllers.FishingController
        if p99.DoAutoClick and (v102 and v102:IsInZone()) then
            p99:SetAutoClick(false)
        end
        local v103 = p100 == "WPN_SLASH_1" and true or p100 == "DUAL_SLASH_1"
        local v104 = p100 == "WPN_SLASH_2" and true or p100 == "DUAL_SLASH_2"
        if v103 then
            local v105 = elapsedTime()
            if p99.DoAutoClick then
                wait()
                p99:StartSecondaryAttack()
            elseif v105 - p99.LastAltSwing < 0.5 then
                p99:StartSecondaryAttack()
            else
                p99:StartIdling()
            end
        elseif v104 then
            if p99.DoAutoClick then
                wait()
                p99:StartPrimaryAttack()
            else
                p99:StartIdling()
            end
        end
        p99.Controllers.MeleeController:OnSwingEnd()
        p99.Services.GameService[v_u_12.WEAPON_ANIM_COMPLETE]:Fire()
    end
end
function v9.LoadAnimTrack(p_u_106, p_u_107, p108)
    -- upvalues: (copy) v_u_13
    if not p_u_106.Character then
        warn("Attempt to LoadAnimTrack with nil Character!")
        return nil
    end
    local v109 = p_u_106.Character:WaitForChild("Humanoid")
    local v110 = p108[p_u_107]
    if v110 == nil then
        p108[p_u_107] = v109:LoadAnimation(p_u_106.Animations[p_u_107])
        v110 = p108[p_u_107]
        if v_u_13[p_u_107].keyframeCallback == true then
            v110.KeyframeReached:Connect(function(p111)
                -- upvalues: (copy) p_u_106, (copy) p_u_107
                p_u_106:AnimKeyframeReached(p_u_107, p111)
            end)
        end
    end
    return v110
end
function v9.ResetToolAnimations(p112)
    for _, v113 in pairs(p112.ToolAnimTracks) do
        v113:Stop()
        v113:Destroy()
    end
    p112.ToolAnimTracks = {}
end
function v9.ToggleAutoClick(p114)
    p114:SetAutoClick(not p114.DoAutoClick, true)
end
function v9.PromptAutoUpgrade(p115)
    -- upvalues: (copy) v_u_4
    v_u_4:PromptGamePassPurchase(p115.Player, p115.Shared.IAPData.Passes.AUTOCLICKER)
end
function v9.SetAutoClick(p116, p117, p118)
    -- upvalues: (ref) v_u_12
    p116.DoAutoClick = p117
    if p117 then
        wait()
        p116:OnWeaponActivated()
    end
    if p118 ~= false then
        p116.Services.GameService[v_u_12.SET_AUTO_SWING]:Fire(p117)
    end
    p116.Controllers.UIController:RefreshAutoAttack()
end
function v9.IsAutoClicking(p119)
    return p119.DoAutoClick
end
local function v_u_124(p120)
    if p120 then
        local v121 = p120:FindFirstChild("LowerTorso")
        if v121 then
            v121 = v121:FindFirstChild("Root")
        end
        if v121 then
            local v122 = v121.Transform
            local v123 = v122.Position
            if v123.Y ~= 0 then
                v121.Transform = CFrame.new(v123.X, 0, v123.Z) * v122.Rotation
            end
        end
    else
        return
    end
end
function v9._ApplyWaistPitch(_, p125, p126)
    local v127 = p125:FindFirstAncestorOfClass("Model")
    if v127 then
        v127 = v127:FindFirstChildOfClass("Humanoid")
    end
    if v127 then
        v127 = v127:FindFirstChildOfClass("Animator")
    end
    if not (v127 and v127.EvaluationThrottled) then
        p125.Transform = CFrame.fromAxisAngle(Vector3.new(1, 0, 0), p126 * 3.141592653589793 / 2) * p125.Transform
    end
end
function v9.Pitch(p128, p129, p130)
    -- upvalues: (copy) v_u_7
    local v131 = p128.Character
    local v132
    if v131 then
        local v133 = v131:FindFirstChild("UpperTorso")
        if v133 then
            v132 = v133:FindFirstChild("Waist")
        else
            v132 = nil
        end
    else
        v132 = nil
    end
    if v132 then
        p128:_ApplyWaistPitch(v132, p129)
        if p130 == true then
            v_u_7.PlayerPitchToServer.Fire(p129)
        end
    end
end
function v9.ApplyRemotePitch(p134)
    for v135, v136 in pairs(p134.RemotePitch) do
        if v135.Parent == nil then
            p134.RemotePitch[v135] = nil
        else
            local v137 = v135.Character
            local v138
            if v137 then
                local v139 = v137:FindFirstChild("UpperTorso")
                if v139 then
                    v138 = v139:FindFirstChild("Waist")
                else
                    v138 = nil
                end
            else
                v138 = nil
            end
            if v138 then
                p134:_ApplyWaistPitch(v138, v136)
            end
        end
    end
end
function v9.OnStepped(p140, _)
    -- upvalues: (copy) v_u_124
    if not p140.Dead then
        p140:Pitch(game.Workspace.Camera.CFrame.LookVector.Y, true)
    end
    p140:ApplyRemotePitch()
    if not p140.Controllers.MountController:IsRiding(p140.Player) then
        v_u_124(p140.Character)
    end
end
function v9.OnDiscoCommand(p141, p142)
    local v143 = p141.Character and p141.Character:FindFirstChild("Humanoid") and p141:LoadAnimTrack("DANCE_1", p141.ToolAnimTracks)
    if v143 then
        if p142 then
            v143.Priority = Enum.AnimationPriority.Action
            v143:Play()
        else
            v143:Stop()
        end
    end
    p141.Controllers.SoundController:PlayEventSong("Disco", p142)
end
function v9.OnSkellyCommand(p144, p145)
    p144.Controllers.SoundController:PlayEventSong("Spooky", p145)
    p144.Controllers.ArenaController:PlayerInArena(p145)
end
return v9