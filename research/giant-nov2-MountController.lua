-- Decompiled game.Players.BoomerIsBigMan.PlayerScripts.Aero.Controllers.MountController

local v_u_1 = game:GetService("ContextActionService")
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("SoundService")
local v_u_4 = game:GetService("ReplicatedStorage")
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("UserInputService")
local v_u_7 = require(v_u_4:WaitForChild("ZapClient"))
local v_u_8 = nil
local v_u_9 = nil
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = { "Running", "Landing", "Climbing" }
local v_u_13 = {}
local v_u_14 = {}
local v_u_15 = {}
local v162 = {
    ["Init"] = function(p16)
        -- upvalues: (ref) v_u_8, (ref) v_u_9, (ref) v_u_10, (ref) v_u_11
        v_u_8 = p16.Shared.Mounts
        v_u_9 = p16.Shared.MountAnimator
        v_u_10 = p16.Shared.HopAnimator
        v_u_11 = p16.Shared.PlayerWings
        p16.Changed = p16.Shared.Event.new()
        p16.Riders = {}
        p16._refusedAt = (-1 / 0)
        p16._refusal = nil
        p16._bound = false
        p16._requesting = false
        p16._localRiding = false
    end,
    ["Start"] = function(p_u_17)
        -- upvalues: (copy) v_u_2, (ref) v_u_8, (copy) v_u_5, (ref) v_u_9
        p_u_17.Player = v_u_2.LocalPlayer
        p_u_17.Enabled = v_u_8.IsEnabled(v_u_5:IsStudio())
        p_u_17.Folder = Instance.new("Folder")
        p_u_17.Folder.Name = "MountsLocal"
        p_u_17.Folder.Parent = workspace
        v_u_9.Start()
        v_u_2.PlayerRemoving:Connect(function(p18)
            -- upvalues: (copy) p_u_17
            p_u_17:_Clear(p18)
        end)
        v_u_5.RenderStepped:Connect(function(p19)
            -- upvalues: (ref) v_u_2, (copy) p_u_17
            for _, v20 in v_u_2:GetPlayers() do
                local v21 = p_u_17._Update
                local v22 = p_u_17
                local v23, v24 = pcall(v21, v22, v20, p19)
                if not v23 then
                    warn("[MountController] " .. v20.Name .. ": " .. tostring(v24))
                    p_u_17:_Clear(v20)
                end
            end
            for v25, v26 in p_u_17.Riders do
                if v26.leaving and v25.Parent == nil then
                    p_u_17:_Clear(v25)
                end
            end
        end)
        v_u_5.Stepped:Connect(function(_, p27)
            -- upvalues: (copy) p_u_17
            local v28 = p_u_17._Glide
            local v29 = p_u_17
            local v30, v31 = pcall(v28, v29, p27)
            if not v30 then
                warn("[MountController] glide: " .. tostring(v31))
            end
            for v32, v33 in p_u_17.Riders do
                local v34 = p_u_17._Seat
                local v35 = p_u_17
                local v36, v37 = pcall(v34, v35, v33)
                if not v36 then
                    warn("[MountController] seat " .. v32.Name .. ": " .. tostring(v37))
                end
            end
        end)
        local function v38()
            -- upvalues: (copy) p_u_17
            p_u_17:_bind(p_u_17:Get() ~= nil)
            p_u_17.Changed:Fire()
        end
        p_u_17.Player:GetAttributeChangedSignal(v_u_8.ATTR_EQUIPPED):Connect(v38)
        p_u_17.Player:GetAttributeChangedSignal(v_u_8.ATTR_RIDING):Connect(function()
            -- upvalues: (copy) p_u_17
            local v39 = p_u_17:IsRiding(p_u_17.Player)
            if v39 ~= p_u_17._localRiding then
                p_u_17._localRiding = v39
                p_u_17.Controllers.CameraController:SetRiding(v39)
                p_u_17:_SetAnimate(v39)
            end
            p_u_17.Changed:Fire()
        end)
        local v40 = p_u_17.Controllers.PlatformController
        v40.InputTypeChanged:Connect(v38)
        v40.GamepadTypeChanged:Connect(v38)
        p_u_17:_bind(p_u_17:Get() ~= nil)
        p_u_17.Changed:Fire()
        local function v44(p41)
            -- upvalues: (copy) p_u_17
            local v42 = p41:WaitForChild("Humanoid", 10)
            if v42 then
                v42.StateChanged:Connect(function(_, p43)
                    -- upvalues: (ref) p_u_17
                    if p43 == Enum.HumanoidStateType.Swimming and p_u_17:IsRiding(p_u_17.Player) then
                        p_u_17:Toggle()
                    end
                end)
            end
        end
        p_u_17.Player.CharacterAdded:Connect(v44)
        if p_u_17.Player.Character then
            task.spawn(v44, p_u_17.Player.Character)
        end
    end,
    ["IsRiding"] = function(_, p45)
        -- upvalues: (ref) v_u_8
        return v_u_8.IsValidKey(p45:GetAttribute(v_u_8.ATTR_RIDING))
    end,
    ["Get"] = function(p46)
        -- upvalues: (ref) v_u_8
        if not (p46.Enabled and p46.Player) then
            return nil
        end
        local v47 = p46.Player:GetAttribute(v_u_8.ATTR_EQUIPPED)
        if not v_u_8.IsValidKey(v47) then
            return nil
        end
        local v48 = v_u_8.Data[v47]
        local v49, v50 = p46:KeyHint()
        return {
            ["name"] = v48.Name,
            ["icon"] = v48.Icon,
            ["riding"] = p46:IsRiding(p46.Player),
            ["key"] = v49,
            ["keyImage"] = v50,
            ["refusedAt"] = p46._refusedAt,
            ["refusal"] = p46._refusal
        }
    end,
    ["Toggle"] = function(p_u_51)
        -- upvalues: (copy) v_u_7, (copy) v_u_15
        if not p_u_51._requesting and p_u_51:Get() ~= nil then
            p_u_51._requesting = true
            local v_u_52 = not p_u_51:IsRiding(p_u_51.Player)
            task.spawn(function()
                -- upvalues: (ref) v_u_7, (copy) v_u_52, (copy) p_u_51, (ref) v_u_15
                local function v54()
                    -- upvalues: (ref) v_u_7, (ref) v_u_52
                    local v53 = {
                        ["ride"] = v_u_52
                    }
                    return v_u_7.SetMountRiding.Call(v53)
                end
                local v55, v56 = pcall(v54)
                p_u_51._requesting = false
                local v57 = v55 and (v56 and v56.res) or "not_ready"
                if v57 ~= "ok" then
                    p_u_51._refusedAt = os.clock()
                    p_u_51._refusal = v_u_15[v57] or "WAIT"
                    p_u_51.Changed:Fire()
                end
            end)
        end
    end,
    ["_bind"] = function(p_u_58, p59)
        -- upvalues: (copy) v_u_1, (ref) v_u_8
        if p59 == p_u_58._bound then
            return
        else
            p_u_58._bound = p59
            if p59 then
                v_u_1:BindAction("GiantSimRideMount", function(_, p60)
                    -- upvalues: (copy) p_u_58
                    if p60 == Enum.UserInputState.Begin then
                        p_u_58:Toggle()
                    end
                    return Enum.ContextActionResult.Sink
                end, false, Enum.KeyCode[v_u_8.KEY], Enum.KeyCode[v_u_8.GAMEPAD_BUTTON])
            else
                v_u_1:UnbindAction("GiantSimRideMount")
            end
        end
    end,
    ["KeyHint"] = function(p61)
        -- upvalues: (ref) v_u_8, (copy) v_u_6
        local v62 = p61.Controllers.PlatformController:GetInputType()
        if v62 == "touch" then
            return nil, nil
        elseif v62 == "gamepad" then
            local v_u_63 = Enum.KeyCode[v_u_8.GAMEPAD_BUTTON]
            local function v64()
                -- upvalues: (ref) v_u_6, (copy) v_u_63
                return v_u_6:GetImageForKeyCode(v_u_63)
            end
            local v65, v66 = pcall(v64)
            if v65 and (type(v66) == "string" and v66 ~= "") then
                return nil, v66
            else
                return string.gsub(v_u_8.GAMEPAD_BUTTON, "^Button", ""), nil
            end
        else
            return v_u_8.KEY, nil
        end
    end,
    ["_SetAnimate"] = function(p67, p68)
        -- upvalues: (copy) v_u_14
        local v69 = p67.Player.Character
        local v70
        if v69 then
            v70 = v69:FindFirstChild("Animate")
        else
            v70 = v69
        end
        if v70 and v70:IsA("LocalScript") then
            v70.Enabled = not p68
            if p68 then
                local v71 = v69:FindFirstChildOfClass("Humanoid")
                if v71 then
                    v71 = v71:FindFirstChildOfClass("Animator")
                end
                if v71 then
                    for _, v72 in v71:GetPlayingAnimationTracks() do
                        local v73 = v72.Animation
                        local v74
                        if v73 then
                            v74 = v73.Parent
                        else
                            v74 = v73
                        end
                        local v75
                        if v74 then
                            if v74.Parent == v70 then
                                v75 = v74.Name ~= "mood"
                            else
                                v75 = false
                            end
                        elseif v73 == nil then
                            v75 = false
                        else
                            v75 = v_u_14[v73.Name] == true
                        end
                        if v75 then
                            v72:Stop(0.2)
                        end
                    end
                end
            else
                return
            end
        else
            return
        end
    end,
    ["_Glide"] = function(p76, p77)
        -- upvalues: (ref) v_u_8, (ref) v_u_11
        local v78 = p76.Riders[p76.Player]
        if v78 and (not v78.leaving and v_u_8.Glides(v78.key)) then
            local v79 = v78.character
            local v80
            if v79 then
                v80 = v79:FindFirstChildOfClass("Humanoid")
            else
                v80 = v79
            end
            local v81
            if v79 then
                v81 = v79:FindFirstChild("HumanoidRootPart")
            else
                v81 = v79
            end
            if v80 and (v81 and v79:GetAttribute("IsRagdolled") ~= true) then
                if v80:GetState() == Enum.HumanoidStateType.Freefall then
                    local v82 = v81.AssemblyLinearVelocity
                    local v83 = v_u_11.GlideVelocity
                    local v84 = v82.Y
                    if v80 then
                        v80 = v80:FindFirstChild("BodyHeightScale")
                    end
                    local v85 = v83(v84, (not v80 or (not v80:IsA("NumberValue") or v80.Value <= 0)) and 1 or v80.Value, p77, workspace.Gravity)
                    if v85 ~= v82.Y then
                        local v86 = v82.X
                        local v87 = v82.Z
                        v81.AssemblyLinearVelocity = Vector3.new(v86, v85, v87)
                    end
                end
            end
        else
            return
        end
    end,
    ["_Airborne"] = function(p88, p89, p90, p91, p92, p93)
        if p89 == p88.Player then
            local v94 = p92:GetState()
            return v94 == Enum.HumanoidStateType.Jumping and true or v94 == Enum.HumanoidStateType.Freefall
        end
        local v95 = p88._airParams
        if not v95 then
            v95 = RaycastParams.new()
            v95.FilterType = Enum.RaycastFilterType.Exclude
            v95.RespectCanCollide = true
            p88._airParams = v95
        end
        v95.FilterDescendantsInstances = { p90, p88.Folder }
        local v96 = p91.Position.Y - p91.Size.Y / 2 - p92.HipHeight
        local v97 = workspace
        local v98 = p91.Position
        local v99 = -(p91.Position.Y - v96 + 60 * p93)
        local v100 = v97:Raycast(v98, Vector3.new(0, v99, 0), v95)
        return v100 == nil and true or v96 - v100.Position.Y > 1.5 + 0.15 * p93
    end,
    ["_Slope"] = function(p101, p102, p103, p104)
        -- upvalues: (ref) v_u_8
        if p104 then
            return 0
        end
        local v105 = p101._slopeParams
        if not v105 then
            v105 = RaycastParams.new()
            v105.FilterType = Enum.RaycastFilterType.Exclude
            v105.RespectCanCollide = true
            p101._slopeParams = v105
        end
        v105.FilterDescendantsInstances = { p103, p101.Folder }
        local v106 = v_u_8.Hop
        local v107 = p102.mscale
        local v108 = (p102.geo.standHeight + 12) * v107
        local v109 = -v106.FEEL_AHEAD
        local v110 = p102.root.CFrame
        local v111 = 6 * v107
        local v112 = v109 * v107
        local v113 = v110 * Vector3.new(0, v111, v112)
        local v114 = workspace
        local v115 = -v108 - 6 * v107
        local v116 = v114:Raycast(v113, Vector3.new(0, v115, 0), v105)
        if v116 then
            v116 = v116.Position.Y
        end
        local v117 = v106.FEEL_BEHIND
        local v118 = p102.root.CFrame
        local v119 = 6 * v107
        local v120 = v117 * v107
        local v121 = v118 * Vector3.new(0, v119, v120)
        local v122 = workspace
        local v123 = -v108 - 6 * v107
        local v124 = v122:Raycast(v121, Vector3.new(0, v123, 0), v105)
        if v124 then
            v124 = v124.Position.Y
        end
        return not (v116 and v124) and 0 or v_u_8.HopSlope(v116, v124, (v106.FEEL_AHEAD + v106.FEEL_BEHIND) * v107)
    end,
    ["_Headroom"] = function(p125, p126, p127)
        -- upvalues: (ref) v_u_10
        local v128 = p125._slopeParams
        if not v128 then
            return (1 / 0)
        end
        v128.FilterDescendantsInstances = { p127, p125.Folder }
        local v129 = p126.mscale
        local v130 = v_u_10.Config
        local v131 = (v130.LEAP_HEIGHT + v130.HEADROOM_CLEARANCE + 2) * v129
        local v132 = Vector3.new(0, v131, 0)
        local v133 = (1 / 0)
        for _, v134 in { 0, 8 } do
            local v135 = p126.root.CFrame
            local v136 = -v134 * v129
            local v137 = v135 * Vector3.new(0, 0, v136)
            local v138 = workspace:Raycast(v137, v132, v128)
            if v138 then
                local v139 = (v138.Position.Y - v137.Y) / v129
                v133 = math.min(v133, v139)
            end
        end
        return v133
    end,
    ["_MuteFeet"] = function(p140, p141, p142, p143)
        -- upvalues: (copy) v_u_3, (copy) v_u_12
        local v144 = p140._silent
        if not v144 then
            v144 = Instance.new("SoundGroup")
            v144.Name = "MountSilentFeet"
            v144.Volume = 0
            v144.Parent = v_u_3
            p140._silent = v144
        end
        for _, v145 in v_u_12 do
            local v146
            if p142 then
                v146 = p142:FindFirstChild(v145)
            else
                v146 = p142
            end
            if v146 and v146:IsA("Sound") then
                if p143 then
                    if v146.SoundGroup ~= v144 then
                        p141.feet[v146] = v146.SoundGroup or false
                        v146.SoundGroup = v144
                    end
                elseif p141.feet[v146] ~= nil then
                    v146.SoundGroup = p141.feet[v146] or nil
                    p141.feet[v146] = nil
                end
            end
        end
    end,
    ["_Clear"] = function(p147, p148)
        local v149 = p147.Riders[p148]
        if v149 then
            p147.Riders[p148] = nil
            local v150 = v149.character
            if v150 then
                v150 = v149.character:FindFirstChild("HumanoidRootPart")
            end
            p147:_MuteFeet(v149, v150, false)
            v149.anim:Destroy()
            v149.model:Destroy()
        end
    end,
    ["_Build"] = function(p151, p152, p153)
        -- upvalues: (ref) v_u_8, (copy) v_u_4, (ref) v_u_10, (ref) v_u_9
        local v154 = v_u_8.Data[p153]
        local v155 = v_u_4:FindFirstChild("Mounts")
        if v155 then
            v155 = v155:FindFirstChild(v154.Model)
        end
        local v156
        if v155 then
            v156 = v_u_8.RestGeometry(v155)
        else
            v156 = v155
        end
        if not v156 then
            return nil
        end
        local v157 = v155:Clone()
        v157.Name = p152.Name .. "_" .. v154.Model
        local v158 = v157.PrimaryPart
        local v159 = {}
        for _, v160 in v157:GetDescendants() do
            if v160:IsA("BasePart") then
                v160.Anchored = v160 == v158
                v160.Massless = true
                v160.CanCollide = false
                v160.CanTouch = false
                v160.CanQuery = false
                table.insert(v159, v160)
            end
        end
        v157.Parent = p151.Folder
        local v161
        if v154.Gait == "hop" then
            v161 = v_u_10.new(v157, p151.Shared[v155:GetAttribute("Poses")])
            v_u_9.Track(v161)
        else
            v161 = v_u_9.new(v157)
        end
        return {
            ["key"] = p153,
            ["model"] = v157,
            ["root"] = v158,
            ["torso"] = v157:FindFirstChild("_Torso_", true),
            ["parts"] = v159,
            ["geo"] = v156,
            ["anim"] = v161,
            ["joints"] = {},
            ["flight"] = v_u_8.StartState(p153),
            ["feet"] = {}
        }
    end
}
local function v_u_169(p163, p164)
    -- upvalues: (copy) v_u_13
    for v165, v166 in v_u_13 do
        local v167 = p163.joints[v165]
        local v168 = p164:FindFirstChild(v166)
        if v168 then
            v168 = v168:FindFirstChild(v165)
        end
        if not (v168 and (v168:IsA("Motor6D") or v168:IsA("AnimationConstraint"))) then
            v168 = nil
        end
        if v167 ~= v168 then
            return false
        end
    end
    return true
end
function v162._ReadRider(_, p170, p171, p172)
    -- upvalues: (copy) v_u_169, (ref) v_u_8, (copy) v_u_13
    local v173 = p171:FindFirstChild("LowerTorso")
    if p170.character ~= p171 or (p170.lower ~= v173 or (p170.rig == nil or (p170.rigScale ~= p172 or not v_u_169(p170, p171)))) then
        p170.character = p171
        p170.lower = v173
        p170.rigScale = p172
        p170.rig = v_u_8.ReadRig(p171) or v_u_8.ScaledRig(v_u_8.DEFAULT_RIG, p172)
        local v174 = {}
        for v175, v176 in v_u_13 do
            local v177 = p171:FindFirstChild(v176)
            if v177 then
                v177 = v177:FindFirstChild(v175)
            end
            if not (v177 and (v177:IsA("Motor6D") or v177:IsA("AnimationConstraint"))) then
                v177 = nil
            end
            v174[v175] = v177
        end
        p170.joints = v174
    end
end
function v162._Update(p178, p179, p180)
    -- upvalues: (ref) v_u_8
    local v181 = p179:GetAttribute(v_u_8.ATTR_RIDING)
    local v182 = p178.Riders[p179]
    local v183 = p179.Character
    local v184
    if v183 then
        v184 = v183:FindFirstChild("HumanoidRootPart")
    else
        v184 = v183
    end
    local v185
    if v183 then
        v185 = v183:FindFirstChildOfClass("Humanoid")
    else
        v185 = v183
    end
    local v186 = v_u_8.IsValidKey(v181)
    if v186 then
        if v184 == nil or v185 == nil then
            v186 = false
        else
            v186 = v185.Health > 0
        end
    end
    if v182 and v182.leaving then
        if not v186 then
            p178:_StepLeaving(p179, v182, p180)
            return
        end
        p178:_Clear(p179)
        v182 = nil
    end
    if v186 then
        if v182 and v182.key ~= v181 then
            p178:_Clear(p179)
            v182 = nil
        end
        if not v182 then
            v182 = p178:_Build(p179, v181)
            if not v182 then
                return
            end
            p178.Riders[p179] = v182
        end
        local v187
        if v185 then
            v187 = v185:FindFirstChild("BodyHeightScale")
        else
            v187 = v185
        end
        local v188 = (not v187 or (not v187:IsA("NumberValue") or v187.Value <= 0)) and 1 or v187.Value
        local v189 = v_u_8.ModelScale(v188, v182.geo.modelledBodyScale)
        local v190 = v189 - v182.mscale
        if math.abs(v190) > 0.002 then
            v182.model:ScaleTo(v189)
            v182.mscale = v189
        end
        p178:_ReadRider(v182, v183, v188)
        local v191 = v184.CFrame
        v182.root.CFrame = v191 * CFrame.new(v_u_8.MountOffset(v182.rig, v182.geo, v182.mscale))
        local v192 = v_u_8.Flight
        local v193 = -p180 / v192.SMOOTH
        local v194 = 1 - math.exp(v193)
        local v195 = v184.AssemblyLinearVelocity
        local v196 = v195.X
        local v197 = v195.Z
        local v198 = Vector3.new(v196, 0, v197).Magnitude
        local v199 = v182.speed + (v198 - v182.speed) * v194
        if p180 > 0 then
            v182.accel = v182.accel + ((v199 - v182.speed) / p180 - v182.accel) * v194
        end
        v182.speed = v199
        v182.climb = v182.climb + (v195.Y - v182.climb) * v194
        local v200 = v191.LookVector
        if v182.look then
            local v201 = v_u_8.TurnRate(v182.look, v200, p180)
            local v202 = v182.turn
            local v203 = v201 - v182.turn
            local v204 = -p180 / 0.1
            v182.turn = v202 + v203 * (1 - math.exp(v204))
        end
        v182.look = v200
        v182.held = v182.held + p180
        local v205 = p178:_Airborne(p179, v183, v184, v185, v188)
        local v206, v207 = v_u_8.GaitState(v182.key, {
            ["state"] = v182.flight,
            ["held"] = v182.held,
            ["pending"] = v182.pending,
            ["speed"] = v182.speed,
            ["accel"] = v182.accel,
            ["climb"] = v182.climb,
            ["walkSpeed"] = v185.WalkSpeed,
            ["scale"] = v188,
            ["dt"] = p180,
            ["airborne"] = v205
        })
        v182.pending = v207
        if v206 ~= v182.flight then
            v182.flight = v206
            v182.held = 0
        end
        v182.anim:SetState(v182.flight)
        v182.anim:SetTurnRate(v182.turn)
        if v182.anim.SetPace then
            v182.anim:SetPace(v_u_8.HopRate(v182.speed, v188))
            local v208 = v182.slope
            local v209 = p178:_Slope(v182, v183, v205) - v182.slope
            local v210 = -p180 / v_u_8.Hop.SLOPE_SMOOTH
            v182.slope = v208 + v209 * (1 - math.exp(v210))
            v182.anim:SetSlope(v182.slope)
            if v182.anim.SetHeadroom then
                v182.anim:SetHeadroom(p178:_Headroom(v182, v183))
            end
        end
        p178:_MuteFeet(v182, v184, true)
        local v211 = v182.lower
        local v212 = not (v211 and v211:IsA("BasePart")) and 0 or v211.LocalTransparencyModifier
        if v212 ~= v182.hide then
            v182.hide = v212
            for _, v213 in v182.parts do
                v213.LocalTransparencyModifier = v212
            end
        end
    elseif v182 then
        p178:_Leave(v182)
    end
end
function v162._Seat(_, p214)
    -- upvalues: (ref) v_u_8
    if p214.leaving or (p214.rig == nil or p214.torso == nil) then
        return
    else
        local v215 = p214.character
        if v215 then
            v215 = v215:FindFirstChildOfClass("Humanoid")
        end
        if v215 ~= nil and (v215.Health > 0 and v215:GetState() ~= Enum.HumanoidStateType.Physics) then
            local v216
            if p214.anim.SeatTransform then
                v216 = p214.anim:SeatTransform()
            else
                v216 = p214.torso.Transform
            end
            for v217, v218 in v_u_8.RiderPose(p214.rig, p214.geo, p214.mscale, v216) do
                local v219 = p214.joints[v217]
                if v219 and v219.Parent then
                    v219.Transform = v218
                end
            end
        end
    end
end
function v162._Leave(p220, p221)
    local v222 = p221.root.CFrame
    local v223 = v222.Position + v222.RightVector * 3.5 * p221.mscale
    local v224 = RaycastParams.new()
    v224.FilterType = Enum.RaycastFilterType.Exclude
    v224.FilterDescendantsInstances = { p220.Folder, p221.character }
    local v225 = workspace
    local v226 = -80 * p221.mscale
    local v227 = v225:Raycast(v223, Vector3.new(0, v226, 0), v224)
    local v228
    if v227 then
        local v229 = v227.Position.Y + p221.geo.standHeight * p221.mscale
        local v230 = v222.Rotation
        local v231 = v223.X
        local v232 = v222.Y
        local v233 = math.min(v229, v232)
        local v234 = v223.Z
        v228 = v230 + Vector3.new(v231, v233, v234)
    else
        v228 = v222
    end
    p221.leaving = {
        ["from"] = v222,
        ["to"] = v228
    }
    local v235 = p221.character
    if v235 then
        v235 = p221.character:FindFirstChild("HumanoidRootPart")
    end
    p220:_MuteFeet(p221, v235, false)
    p221.anim:SetState("Rest")
    p221.anim:SetTurnRate(0)
end
function v162._StepLeaving(p236, p237, p238, p239)
    -- upvalues: (ref) v_u_9
    local v240 = p238.leaving
    v240.t = v240.t + p239
    local v241 = v_u_9.Config.FOLD_TIME
    local v242 = p238.root
    local v243 = v240.from
    local v244 = v240.to
    local v245 = v240.t / v241
    local v246 = math.clamp(v245, 0, 1)
    v242.CFrame = v243:Lerp(v244, v246 * v246 * (3 - 2 * v246))
    local v247 = (v240.t - v241 - 0.3) / 0.4
    if v247 >= 1 then
        p236:_Clear(p237)
    elseif v247 > 0 then
        for _, v248 in p238.parts do
            local v249 = p238.hide or 0
            v248.LocalTransparencyModifier = math.max(v247, v249)
        end
    end
end
return v162