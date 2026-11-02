-- Decompiled game.Players.BoomerIsBigMan.PlayerScripts.Aero.Controllers.GhostTrackController

local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ContentProvider")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("SoundService")
local v_u_6 = game:GetService("TweenService")
local v_u_7 = game:GetService("Debris")
local v_u_8 = require(v_u_3:WaitForChild("ZapClient"))
local v_u_9 = require(v_u_3.Packages.signal)
local v_u_10 = require(v_u_3.ReactUI.InventoryTheme)
local v11 = {}
local v_u_12 = NumberRange.new(0, 1.4)
local v_u_13 = NumberRange.new(0.9, 1.3)
local v_u_14 = NumberRange.new(0.8, 3)
local v_u_15 = { "FlapL", "FlapR" }
function v11.Init(p_u_16)
    -- upvalues: (copy) v_u_9, (copy) v_u_8
    p_u_16.StateChanged = v_u_9.new()
    p_u_16.LanternPulse = v_u_9.new()
    p_u_16._ghosts = {}
    p_u_16._active = false
    p_u_16._inGraveyard = false
    p_u_16._anchor = nil
    p_u_16._streak = 0
    p_u_16._streakAt = 0
    p_u_16._reveals = {}
    p_u_16._revealing = false
    p_u_16._lastSouls = nil
    p_u_16._bloodMoon = false
    v_u_8.GhostHit.On(function(p17)
        -- upvalues: (copy) p_u_16
        p_u_16:_onHit(p17)
    end)
    v_u_8.LanternWeaponEarned.On(function(p_u_18)
        -- upvalues: (copy) p_u_16
        p_u_16:_queueReveal(function()
            -- upvalues: (ref) p_u_16, (copy) p_u_18
            return p_u_16:_weaponReveal(p_u_18)
        end)
    end)
end
function v11.Start(p_u_19)
    -- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_4
    if workspace:GetAttribute("IsClanGrounds") ~= true then
        local v20 = p_u_19.Shared.HalloweenConfig
        p_u_19._cfg = v20.GHOSTS
        p_u_19._track = p_u_19.Shared.GhostTrack.new(v20.GHOSTS)
        local v21 = v20.GHOSTS.GRAVEYARD
        local v22 = (v21.minX + v21.maxX) / 2
        local v23 = v20.GHOSTS.HOVER_Y
        local v24 = (v21.minZ + v21.maxZ) / 2
        p_u_19._centre = Vector3.new(v22, v23, v24)
        task.spawn(function()
            -- upvalues: (copy) p_u_19, (ref) v_u_2, (ref) v_u_1, (ref) v_u_4
            local v25 = workspace:WaitForChild("NPC", 60)
            if v25 then
                v25 = v25:WaitForChild("Ghosts", 60)
            end
            if v25 then
                p_u_19._active = true
                p_u_19._bloodMoon = workspace:GetAttribute("BloodMoon") == true
                workspace:GetAttributeChangedSignal("BloodMoon"):Connect(function()
                    -- upvalues: (ref) p_u_19
                    p_u_19:_setBloodMoon(workspace:GetAttribute("BloodMoon") == true)
                end)
                task.spawn(function()
                    -- upvalues: (ref) p_u_19, (ref) v_u_2
                    local v26 = {}
                    for v27 in pairs(p_u_19._cfg.SOUNDS) do
                        local v28 = p_u_19
                        table.insert(v26, v28:_voice(v27))
                    end
                    local v29 = v_u_2.PreloadAsync
                    local v30 = v_u_2
                    pcall(v29, v30, v26)
                end)
                p_u_19._pipGui = Instance.new("Folder")
                p_u_19._pipGui.Name = "GhostPips"
                p_u_19._pipGui.Parent = v_u_1.LocalPlayer:WaitForChild("PlayerGui")
                for _, v31 in ipairs(v25:GetChildren()) do
                    task.spawn(p_u_19._register, p_u_19, v31)
                end
                v25.ChildAdded:Connect(function(p32)
                    -- upvalues: (ref) p_u_19
                    p_u_19:_register(p32)
                end)
                v25.AncestryChanged:Connect(function(_, p33)
                    -- upvalues: (ref) p_u_19
                    if p33 == nil then
                        p_u_19._active = false
                        p_u_19._ghosts = {}
                        p_u_19.StateChanged:Fire()
                    end
                end)
                v_u_4.RenderStepped:Connect(function(p34)
                    -- upvalues: (ref) p_u_19
                    p_u_19:_step(p34)
                end)
                local v_u_35 = 0
                v_u_4.Heartbeat:Connect(function(p36)
                    -- upvalues: (ref) v_u_35, (ref) p_u_19
                    v_u_35 = v_u_35 + p36
                    if v_u_35 >= 0.25 then
                        v_u_35 = 0
                        p_u_19:_checkGraveyard()
                    end
                end)
                p_u_19.Controllers.ReplicaController:ObserveSection("stats", function()
                    -- upvalues: (ref) p_u_19
                    p_u_19:_onStats()
                end)
            end
        end)
    end
end
function v11._register(p37, p38)
    -- upvalues: (copy) v_u_15
    if p38:IsA("Model") then
        local v39 = p38:GetAttribute("GhostIndex")
        local v40 = p38:WaitForChild("Hitbox", 10)
        local v41 = p38:WaitForChild("Body", 10)
        if type(v39) == "number" and (v40 and (v40:IsA("BasePart") and (v41 and v41:IsA("BasePart")))) then
            local v42 = p37._cfg
            local v43 = {
                ["index"] = v39,
                ["model"] = p38,
                ["hitbox"] = v40,
                ["body"] = v41,
                ["rest"] = v40.CFrame:ToObjectSpace(v41.CFrame),
                ["parts"] = {},
                ["lights"] = {},
                ["flaps"] = {},
                ["phase"] = (v39 - 1) * 2.399963
            }
            for _, v44 in ipairs(p38:GetDescendants()) do
                if v44:IsA("BasePart") and v44 ~= v40 then
                    v43.parts[v44] = {
                        ["transparency"] = v44.Transparency,
                        ["material"] = v44.Material,
                        ["color"] = v44.Color
                    }
                elseif v44:IsA("Light") then
                    v43.lights[v44] = {
                        ["color"] = v44.Color,
                        ["brightness"] = v44.Brightness
                    }
                end
            end
            p37:_tint(v43)
            for _, v45 in ipairs(v_u_15) do
                local v46 = p37:_flap(p38, v41, v45)
                if v46 then
                    local v47 = v43.flaps
                    table.insert(v47, v46)
                end
            end
            if v39 % v42.MOAN_EVERY == 1 then
                local v_u_48 = p37:_voice("MOAN")
                v_u_48.Looped = true
                v_u_48.Volume = (p37.Controllers.SoundController.SfxVolume or 0.7) * 5
                v_u_48.RollOffMode = Enum.RollOffMode.InverseTapered
                v_u_48.RollOffMinDistance = 6
                v_u_48.RollOffMaxDistance = v42.MOAN_RANGE
                v_u_48.Parent = v41
                v_u_48:Play()
                local function v52()
                    -- upvalues: (copy) v_u_48
                    local v49 = v_u_48
                    local v50 = math.random()
                    local v51 = v_u_48.TimeLength - 1
                    v49.TimePosition = v50 * math.max(v51, 0)
                end
                if v_u_48.IsLoaded then
                    local v53 = math.random()
                    local v54 = v_u_48.TimeLength - 1
                    v_u_48.TimePosition = v53 * math.max(v54, 0)
                else
                    v_u_48.Loaded:Once(v52)
                end
            end
            v43.pips = p37:_buildPips(v43)
            p37._ghosts[v39] = v43
        end
    else
        return
    end
end
function v11._flap(_, p55, p56, p57)
    local v58 = p55:FindFirstChild(p57, true)
    if not (v58 and v58:IsA("BasePart")) then
        return nil
    end
    local v59 = p56.CFrame:ToObjectSpace(v58:GetPivot())
    local v60 = {
        ["part"] = v58,
        ["sign"] = v59.Position.X >= 0 and 1 or -1,
        ["phase"] = tonumber(v58:GetAttribute("FlapPhase")) or 0
    }
    for _, v61 in ipairs(p55:GetDescendants()) do
        if v61:IsA("Motor6D") and v61.Part1 == v58 then
            v60.motor = v61
            return v60
        end
    end
    for _, v62 in ipairs(p55:GetDescendants()) do
        if (v62:IsA("WeldConstraint") or v62:IsA("JointInstance")) and (v62.Part0 == v58 or v62.Part1 == v58) then
            v62.Enabled = false
        end
    end
    v58.Anchored = true
    v60.pivotRest = v59
    v60.partFromPivot = v58:GetPivot():ToObjectSpace(v58.CFrame)
    return v60
end
function v11._step(p63, p64)
    local v65 = workspace.CurrentCamera
    if not v65 or (v65.CFrame.Position - p63._centre).Magnitude <= p63._cfg.DRAW_RANGE then
        local v66 = p63._cfg
        local v67 = p63._track
        local v68 = workspace:GetServerTimeNow()
        local v69 = os.clock()
        local v70 = v66.LEAN_DEG
        local v71 = math.rad(v70)
        local v72 = v66.BANK_DEG
        local v73 = math.rad(v72)
        local v74 = p64 * 4
        local v75 = math.min(1, v74)
        local v76 = v66.FLAP_DEG
        local v77 = math.rad(v76)
        local v78 = {}
        local v79 = {}
        for v80, v81 in pairs(p63._ghosts) do
            local v82 = v67:arcLengthAt(v80, v68)
            local v83, v84, v85, v86 = v67:pointAt(v82)
            local v87 = v67.hoverY
            local v88 = Vector3.new(v83, v87, v84)
            local v89 = CFrame.lookAt(v88, v88 + Vector3.new(v85, 0, v86))
            local v90 = v67:curvatureAt(v82)
            local v91
            if v90 > 0 then
                v91 = -v73
            else
                v91 = v90 >= 0 and 0 or v73
            end
            v81.bank = v81.bank + (v91 - v81.bank) * v75
            local v92 = v66.BOB_AMPLITUDE
            local v93 = 6.283185307179586 * v68 / v66.BOB_PERIOD + v81.phase
            local v94 = v92 * math.sin(v93)
            if v81.hiddenUntil and v81.hiddenUntil <= v69 then
                p63:_beginReform(v81, v69)
            end
            local v95
            if v81.reformAt then
                local v96 = (v69 - v81.reformAt) / 0.4
                local v97 = math.clamp(v96, 0, 1)
                v95 = (1 - v97) ^ 2 * -4
                p63:_setFade(v81, v97)
                if v97 >= 1 then
                    v81.reformAt = nil
                end
            else
                v95 = 0
            end
            local v98 = CFrame.new
            local v99 = v81.rest.Position
            local v100 = v94 + v95
            local v101 = v89 * v98(v99 + Vector3.new(0, v100, 0)) * CFrame.Angles(-v71, 0, v81.bank) * v81.rest.Rotation
            local v102 = v81.hitbox
            table.insert(v79, v102)
            table.insert(v78, v89)
            local v103 = v81.body
            table.insert(v79, v103)
            table.insert(v78, v101)
            local v104 = 6.283185307179586 * v68 / v66.FLAP_PERIOD + v81.phase
            for _, v105 in ipairs(v81.flaps) do
                local v106 = CFrame.Angles
                local v107 = v105.sign * v77
                local v108 = v104 + v105.phase
                local v109 = v106(0, 0, v107 * math.sin(v108))
                if v105.motor then
                    v105.motor.Transform = v109
                else
                    local v110 = v105.part
                    table.insert(v79, v110)
                    local v111 = v101 * v105.pivotRest * v109 * v105.partFromPivot
                    table.insert(v78, v111)
                end
            end
        end
        if #v79 > 0 then
            workspace:BulkMoveTo(v79, v78, Enum.BulkMoveMode.FireCFrameChanged)
        end
    end
end
function v11._setFade(_, p112, p113)
    for v114, v115 in pairs(p112.parts) do
        v114.Transparency = v115.transparency + (1 - v115.transparency) * (1 - p113)
    end
end
function v11._hide(p116, p117)
    p117.hiddenUntil = os.clock() + p116._cfg.REFORM_SECS
    p117.reformAt = nil
    p116:_setFade(p117, 0)
    for v118 in pairs(p117.lights) do
        v118.Enabled = false
    end
    p117.hitbox.CanQuery = false
end
function v11._beginReform(_, p119, p120)
    p119.hiddenUntil = nil
    p119.reformAt = p120
    for v121 in pairs(p119.lights) do
        v121.Enabled = true
    end
    p119.hitbox.CanQuery = true
end
function v11._setBloodMoon(p122, p123)
    if p123 ~= p122._bloodMoon then
        p122._bloodMoon = p123
        for _, v124 in pairs(p122._ghosts) do
            p122:_tint(v124)
        end
        p122.StateChanged:Fire()
    end
end
function v11._tint(p125, p126)
    local v127 = p125.Shared.HalloweenConfig.BLOOD_MOON.GHOST_LOOK
    local v128 = p125._bloodMoon
    for v129, v130 in pairs(p126.parts) do
        local v131
        if v128 then
            local v132 = v127.RED
            v131 = Color3.fromRGB(v132[1], v132[2], v132[3])
        else
            v131 = v130.color
        end
        v129.Color = v131
    end
    for v133, v134 in pairs(p126.lights) do
        local v135
        if v128 then
            local v136 = v127.GLOW
            v135 = Color3.fromRGB(v136[1], v136[2], v136[3])
        else
            v135 = v134.color
        end
        v133.Color = v135
        local v137
        if v128 then
            v137 = v127.GLOW_BRIGHTNESS
        else
            v137 = v134.brightness
        end
        v133.Brightness = v137
    end
end
function v11._onHit(p138, p139)
    local v140 = p138._ghosts[p139.ghost]
    if v140 then
        v140.hits = p139.popped and 0 or p139.hits
        p138:_flash(v140)
        p138:_playAt("Swoosh", v140.body, 0.35, 1.5)
        p138:_ooh(v140)
        if p139.souls > 0 then
            p138:_popup(v140, "+" .. p139.souls, false)
            p138:_wisp(v140)
            p138:_chime()
        end
        if p139.popped then
            p138:_burst(v140)
            if p139.bonus > 0 then
                p138:_popup(v140, "+" .. p139.bonus, true)
            end
            if p139.pumpkins > 0 then
                p138:_pumpkinPopup(v140, p139.pumpkins, p139.bonus > 0)
            end
            p138:_hide(v140)
        end
        p138:_paintPips(v140, v140.hits)
    end
end
function v11._flash(_, p_u_141)
    local v_u_142 = (p_u_141.flashToken or 0) + 1
    p_u_141.flashToken = v_u_142
    for v143 in pairs(p_u_141.parts) do
        v143.Material = Enum.Material.Neon
    end
    task.delay(0.09, function()
        -- upvalues: (copy) p_u_141, (copy) v_u_142
        if p_u_141.flashToken == v_u_142 then
            for v144, v145 in pairs(p_u_141.parts) do
                v144.Material = v145.material
            end
        end
    end)
end
function v11._popup(p146, p147, p148, p149)
    -- upvalues: (copy) v_u_10, (copy) v_u_6, (copy) v_u_7
    local v150 = Instance.new("BillboardGui")
    v150.Name = "GhostSoulPopup"
    v150.Adornee = p147.hitbox
    v150.LightInfluence = 0
    local v151
    if p149 then
        v151 = UDim2.fromScale(7.2, 2.4)
    else
        v151 = UDim2.fromScale(4.8, 1.6)
    end
    v150.Size = v151
    local v152 = (math.random() - 0.5) * 1.6
    local v153 = p146._cfg.HITBOX.y / 2 + (p149 and 1.5 or 0.5)
    local v154 = Vector3.new(v152, v153, 0)
    v150.StudsOffset = v154
    local v155 = Instance.new("ImageLabel")
    v155.Name = "SoulIcon"
    v155.BackgroundTransparency = 1
    v155.Size = UDim2.fromScale(1, 1)
    v155.SizeConstraint = Enum.SizeConstraint.RelativeYY
    v155.Image = p146.Shared.SharedConstants.HALLOWEEN_SOUL_ICON
    v155.ScaleType = Enum.ScaleType.Fit
    v155.Parent = v150
    local v156 = Instance.new("TextLabel")
    v156.BackgroundTransparency = 1
    v156.Position = UDim2.fromScale(0.36, 0)
    v156.Size = UDim2.fromScale(0.64, 1)
    v156.TextXAlignment = Enum.TextXAlignment.Left
    v156.FontFace = v_u_10.FONT_DISPLAY
    v156.Text = p148
    v156.TextScaled = true
    local v157
    if p149 then
        v157 = v_u_10.GOLD_BRIGHT
    else
        v157 = v_u_10.SOUL_BRIGHT
    end
    v156.TextColor3 = v157
    local v158 = Instance.new("UIStroke")
    v158.Color = v_u_10.OUTLINE
    v158.Thickness = 2
    v158.Parent = v156
    v156.Parent = v150
    v150.Parent = p146._pipGui
    local v159 = p149 and 1.3 or 0.9
    v_u_6:Create(v150, TweenInfo.new(v159, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["StudsOffset"] = v154 + Vector3.new(0, 3, 0)
    }):Play()
    v_u_6:Create(v155, TweenInfo.new(v159, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {}):Play()
    v_u_6:Create(v156, TweenInfo.new(v159, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {}):Play()
    v_u_6:Create(v158, TweenInfo.new(v159, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {}):Play()
    v_u_7:AddItem(v150, v159 + 0.1)
end
function v11._pumpkinPopup(p160, p161, p162, p163)
    -- upvalues: (copy) v_u_10, (copy) v_u_6, (copy) v_u_7
    local v164 = p160.Shared.SharedConstants
    local v165 = Instance.new("BillboardGui")
    v165.Name = "GhostPumpkinPopup"
    v165.Adornee = p161.hitbox
    v165.LightInfluence = 0
    v165.Size = UDim2.fromScale(4.4, 1.6)
    local v166 = p160._cfg.HITBOX.y / 2 + 0.6
    local v167 = Vector3.new(p163 and 3.8 or 0, v166, 0)
    v165.StudsOffset = v167
    local v168 = Instance.new("UIListLayout")
    v168.FillDirection = Enum.FillDirection.Horizontal
    v168.HorizontalAlignment = Enum.HorizontalAlignment.Center
    v168.VerticalAlignment = Enum.VerticalAlignment.Center
    v168.SortOrder = Enum.SortOrder.LayoutOrder
    v168.Padding = UDim.new(0.03, 0)
    v168.Parent = v165
    local v169 = Instance.new("ImageLabel")
    v169.BackgroundTransparency = 1
    v169.Size = UDim2.fromScale(1, 1)
    v169.SizeConstraint = Enum.SizeConstraint.RelativeYY
    v169.Image = v164.PUMPKIN_CURRENCY_ICON
    v169.LayoutOrder = 1
    v169.Parent = v165
    local v170 = Instance.new("TextLabel")
    v170.BackgroundTransparency = 1
    v170.Size = UDim2.fromScale(0.6, 1)
    v170.FontFace = v_u_10.FONT_DISPLAY
    v170.Text = "+" .. p162
    v170.TextScaled = true
    v170.TextXAlignment = Enum.TextXAlignment.Left
    v170.TextColor3 = v164.PUMPKIN_CURRENCY_TEXT_COLOR
    v170.LayoutOrder = 2
    local v171 = Instance.new("UIStroke")
    v171.Color = v_u_10.OUTLINE
    v171.Thickness = 2
    v171.Parent = v170
    v170.Parent = v165
    v165.Parent = p160._pipGui
    local v172 = TweenInfo.new(1.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    v_u_6:Create(v165, TweenInfo.new(1.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["StudsOffset"] = v167 + Vector3.new(0, 3, 0)
    }):Play()
    v_u_6:Create(v169, v172, {}):Play()
    v_u_6:Create(v170, v172, {}):Play()
    v_u_6:Create(v171, v172, {}):Play()
    v_u_7:AddItem(v165, 1.4000000000000001)
end
function v11._wisp(p_u_173, p174)
    -- upvalues: (copy) v_u_1, (copy) v_u_10, (copy) v_u_6
    local v175 = workspace.CurrentCamera
    local v176 = p_u_173._anchor
    local v177
    if v176 then
        v177 = v176:FindFirstAncestorOfClass("ScreenGui")
    else
        v177 = v176
    end
    if v175 and (v177 and v177.Enabled) then
        local v178, v179 = v175:WorldToScreenPoint(p174.body.Position)
        if v179 then
            if not p_u_173._wispGui then
                local v180 = Instance.new("ScreenGui")
                v180.Name = "GhostWispGui"
                v180.ResetOnSpawn = false
                v180.DisplayOrder = 5
                v180.Parent = v_u_1.LocalPlayer:WaitForChild("PlayerGui")
                p_u_173._wispGui = v180
            end
            local v181 = v176.AbsolutePosition + v176.AbsoluteSize / 2
            local v_u_182 = Instance.new("Frame")
            v_u_182.AnchorPoint = Vector2.new(0.5, 0.5)
            v_u_182.Position = UDim2.fromOffset(v178.X, v178.Y)
            v_u_182.Size = UDim2.fromOffset(16, 16)
            v_u_182.BackgroundColor3 = v_u_10.SOUL_BRIGHT
            v_u_182.BorderSizePixel = 0
            local v183 = Instance.new("UICorner")
            v183.CornerRadius = UDim.new(0.5, 0)
            v183.Parent = v_u_182
            local v184 = Instance.new("UIStroke")
            v184.Color = v_u_10.SOUL
            v184.Thickness = 3
            v184.Transparency = 0.3
            v184.Parent = v_u_182
            v_u_182.Parent = p_u_173._wispGui
            local v185 = v_u_6:Create(v_u_182, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["Position"] = UDim2.fromOffset(v181.X, v181.Y),
                ["Size"] = UDim2.fromOffset(8, 8)
            })
            v185.Completed:Connect(function()
                -- upvalues: (copy) v_u_182, (copy) p_u_173
                v_u_182:Destroy()
                p_u_173.LanternPulse:Fire(0.45)
            end)
            v185:Play()
        end
    else
        return
    end
end
function v11._chime(p186)
    -- upvalues: (copy) v_u_5, (copy) v_u_7
    local v187 = os.clock()
    p186._streak = v187 - p186._streakAt > 1.5 and 0 or p186._streak + 1
    p186._streakAt = v187
    local v188 = p186:_sound("Pickup")
    if v188 then
        v188.Volume = (p186.Controllers.SoundController.SfxVolume or 0.7) * 0.5
        local v189 = p186._streak
        v188.PlaybackSpeed = math.min(v189, 10) * 0.04 + 1
        v188.Parent = v_u_5
        v_u_5:PlayLocalSound(v188)
        v_u_7:AddItem(v188, 2)
    end
end
function v11._burst(p190, p191)
    -- upvalues: (copy) v_u_10, (copy) v_u_6, (copy) v_u_7, (copy) v_u_14
    local v192 = p191.body.Position
    local v193 = p190.Shared.HalloweenConfig.BLOOD_MOON.GHOST_LOOK
    local v194
    if p190._bloodMoon then
        local v195 = v193.BURST_BRIGHT
        v194 = Color3.fromRGB(v195[1], v195[2], v195[3])
    else
        v194 = v_u_10.SOUL_BRIGHT
    end
    local v196
    if p190._bloodMoon then
        local v197 = v193.BURST
        v196 = Color3.fromRGB(v197[1], v197[2], v197[3])
    else
        v196 = v_u_10.SOUL
    end
    local v198 = Instance.new("Part")
    v198.Name = "GhostBurst"
    v198.Anchored = true
    v198.CanCollide = false
    v198.CanQuery = false
    v198.CanTouch = false
    v198.Transparency = 1
    v198.Size = Vector3.new(1, 1, 1)
    v198.CFrame = CFrame.new(v192)
    local v199 = Instance.new("ParticleEmitter")
    v199.Texture = "rbxassetid://4509687978"
    v199.Color = ColorSequence.new(v194, v196)
    v199.LightEmission = 1
    v199.LightInfluence = 0
    v199.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.6), NumberSequenceKeypoint.new(1, 0) })
    v199.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1) })
    v199.Lifetime = NumberRange.new(0.5, 0.9)
    v199.Speed = NumberRange.new(10, 18)
    v199.SpreadAngle = Vector2.new(180, 180)
    v199.Drag = 3
    v199.Rate = 0
    v199.Parent = v198
    v198.Parent = workspace
    local v200 = Instance.new("Part")
    v200.Name = "GhostPuff"
    v200.Shape = Enum.PartType.Ball
    v200.Material = Enum.Material.Neon
    v200.Color = v196
    v200.Anchored = true
    v200.CanCollide = false
    v200.CanQuery = false
    v200.CanTouch = false
    v200.CastShadow = false
    v200.Transparency = 0.3
    v200.Size = Vector3.new(2, 2, 2)
    v200.CFrame = CFrame.new(v192)
    v200.Parent = workspace
    v_u_6:Create(v200, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {}):Play()
    v199:Emit(36)
    v_u_7:AddItem(v198, 1.5)
    v_u_7:AddItem(v200, 0.5)
    local v201 = p190:_voice("WAIL")
    v201.PlaybackRegionsEnabled = true
    v201.PlaybackRegion = v_u_14
    v201.PlaybackSpeed = 1.15
    v201.Volume = (p190.Controllers.SoundController.SfxVolume or 0.7) * 0.6
    v201.RollOffMaxDistance = 60
    local v202 = v198:Clone()
    v202:ClearAllChildren()
    v202.Name = "GhostWail"
    v202.Parent = workspace
    v201.Parent = v202
    v201:Play()
    v_u_7:AddItem(v202, (v_u_14.Max - v_u_14.Min) / 1.15 + 0.5)
end
function v11._buildPips(p203, p204)
    -- upvalues: (copy) v_u_10
    local v205 = p203._cfg
    local v206 = Instance.new("BillboardGui")
    v206.Name = "GhostPips" .. p204.index
    v206.Adornee = p204.hitbox
    v206.LightInfluence = 0
    v206.MaxDistance = 90
    v206.Size = UDim2.fromScale(0.75 * v205.POP_HITS, 0.6)
    local v207 = v205.HITBOX.y / 2 + 1.4
    v206.StudsOffset = Vector3.new(0, v207, 0)
    v206.Enabled = false
    local v208 = Instance.new("UIListLayout")
    v208.FillDirection = Enum.FillDirection.Horizontal
    v208.HorizontalAlignment = Enum.HorizontalAlignment.Center
    v208.VerticalAlignment = Enum.VerticalAlignment.Center
    v208.Padding = UDim.new(0.04, 0)
    v208.Parent = v206
    local v209 = {}
    for v210 = 1, v205.POP_HITS do
        local v211 = Instance.new("Frame")
        v211.Name = "Pip" .. v210
        v211.LayoutOrder = v210
        v211.Size = UDim2.fromScale(1, 1)
        v211.SizeConstraint = Enum.SizeConstraint.RelativeYY
        v211.BorderSizePixel = 0
        local v212 = Instance.new("UICorner")
        v212.CornerRadius = UDim.new(0.5, 0)
        v212.Parent = v211
        local v213 = Instance.new("UIStroke")
        v213.Color = v_u_10.OUTLINE
        v213.Thickness = 1.5
        v213.Parent = v211
        v211.Parent = v206
        v209[v210] = v211
    end
    v206.Parent = p203._pipGui
    return {
        ["gui"] = v206,
        ["pips"] = v209
    }
end
function v11._paintPips(_, p214, p215)
    -- upvalues: (copy) v_u_10
    if p214.pips then
        p214.pips.gui.Enabled = p215 > 0
        for v216, v217 in ipairs(p214.pips.pips) do
            local v218 = v216 <= p215
            local v219
            if v218 then
                v219 = v_u_10.SOUL_BRIGHT
            else
                v219 = v_u_10.WOOD_DEEP
            end
            v217.BackgroundColor3 = v219
            v217.BackgroundTransparency = v218 and 0 or 0.25
        end
    end
end
function v11._sound(_, p220)
    -- upvalues: (copy) v_u_3
    local v221 = v_u_3:FindFirstChild("Sounds")
    if v221 then
        v221 = v221:FindFirstChild(p220)
    end
    if v221 and v221:IsA("Sound") then
        return v221:Clone()
    else
        return nil
    end
end
function v11._voice(p222, p223)
    local v224 = Instance.new("Sound")
    v224.Name = "Ghost" .. p223
    v224.SoundId = p222._cfg.SOUNDS[p223]
    return v224
end
function v11._ooh(p225, p226)
    -- upvalues: (copy) v_u_12, (copy) v_u_13, (copy) v_u_7
    local v227 = p225:_voice("OOH")
    v227.PlaybackRegionsEnabled = true
    v227.PlaybackRegion = v_u_12
    v227.PlaybackSpeed = v_u_13.Min + math.random() * (v_u_13.Max - v_u_13.Min)
    v227.Volume = (p225.Controllers.SoundController.SfxVolume or 0.7) * 1.6
    v227.RollOffMaxDistance = 60
    v227.Parent = p226.body
    v227:Play()
    v_u_7:AddItem(v227, v_u_12.Max / v_u_13.Min + 0.5)
end
function v11._playAt(p228, p229, p230, p231, p232)
    -- upvalues: (copy) v_u_7
    local v233 = p228:_sound(p229)
    if v233 then
        v233.Volume = p231 * (p228.Controllers.SoundController.SfxVolume or 0.7)
        v233.PlaybackSpeed = p232
        v233.RollOffMaxDistance = 60
        v233.Parent = p230
        v233:Play()
        v_u_7:AddItem(v233, 2)
    end
end
function v11._checkGraveyard(p234)
    -- upvalues: (copy) v_u_1
    local v235 = v_u_1.LocalPlayer.Character
    if v235 then
        v235 = v235:FindFirstChild("HumanoidRootPart")
    end
    local v236
    if v235 == nil then
        v236 = false
    else
        v236 = p234.Shared.GhostTrack.inGraveyard(p234._cfg.GRAVEYARD, v235.Position.X, v235.Position.Z)
    end
    if v236 ~= p234._inGraveyard then
        p234._inGraveyard = v236
        p234.StateChanged:Fire()
    end
end
function v11._onStats(p237)
    local v238 = p237.Controllers.ReplicaController
    local v239 = tonumber(v238:GetStat("hallow_souls")) or 0
    if p237._lastSouls then
        local v240 = v239 / 100
        local v241 = math.floor(v240)
        local v242 = p237._lastSouls / 100
        if math.floor(v242) < v241 then
            p237.LanternPulse:Fire(1)
        end
    end
    p237._lastSouls = v239
    p237.StateChanged:Fire()
end
function v11.GetMeterState(p243)
    local v244 = p243.Controllers.ReplicaController
    local v245 = p243.Shared.HalloweenConfig.SOULS
    local v246 = tonumber(v244:GetStat("hallow_lantern_stage")) == 2 and 2 or 1
    local v247 = p243.Shared.Weapons
    local v248 = v246 == 1
    local v249 = v247.Data
    local v250 = v247.Keys
    local v251
    if v248 then
        v251 = v247.Labels.WISP_HATCHET
    else
        v251 = v247.Labels.LANTERN_MAUL
    end
    local v252 = v249[v250[v251]]
    local v253 = {}
    local v254 = p243._active
    if v254 then
        v254 = p243._inGraveyard
    end
    v253.visible = v254
    v253.stage = v246
    v253.souls = tonumber(v244:GetStat("hallow_souls")) or 0
    v253.size = p243.Shared.GhostTrack.lanternSize(v245, v246)
    v253.weaponName = v248 and "Wisp Hatchet" or "Lantern Maul"
    v253.weaponModel = v252 and v252.Name or ""
    v253.earned = tonumber(v244:GetStat(v248 and "wisp_hatchets_earned" or "lantern_mauls_earned")) or 0
    local v255
    if p243._bloodMoon then
        v255 = p243.Shared.HalloweenConfig.BloodMoonSoulHint()
    else
        v255 = nil
    end
    v253.hint = v255
    return v253
end
function v11.SetLanternAnchor(p256, p257)
    p256._anchor = p257
end
function v11._queueReveal(p258, p259)
    local v260 = p258._reveals
    table.insert(v260, p259)
    p258:_nextReveal()
end
function v11._nextReveal(p_u_261)
    if p_u_261._revealing or #p_u_261._reveals == 0 then
        return
    else
        local v_u_262 = p_u_261.Controllers.CrateOpenUIController
        if v_u_262.CrateLock then
            task.delay(1, function()
                -- upvalues: (copy) p_u_261
                p_u_261:_nextReveal()
            end)
            return
        else
            local v263 = table.remove(p_u_261._reveals, 1)()
            if v263 then
                p_u_261._revealing = true
                v_u_262:SetCrateLock(true)
                local v_u_264 = v263.onClosed
                function v263.onClosed()
                    -- upvalues: (copy) v_u_262, (copy) p_u_261, (copy) v_u_264
                    v_u_262:SetCrateLock(false)
                    p_u_261._revealing = false
                    if v_u_264 then
                        v_u_264()
                    end
                    p_u_261:_nextReveal()
                end
                p_u_261.Controllers.UIController:ShowChestReveal(v263)
            else
                p_u_261:_nextReveal()
            end
        end
    end
end
function v11._weaponReveal(p265, p266)
    -- upvalues: (copy) v_u_8
    p265:_screenFlash()
    p265.Controllers.SoundController:PlayBossDefeat()
    local v267 = p265.Shared.Weapons
    local v268 = p265.Shared.Crates
    local v269 = p266.weapon == "hatchet"
    p265.Controllers.UIController:ShowToast({
        ["title"] = v269 and "Wisp Hatchet earned!" or "Lantern Maul earned!",
        ["message"] = ("Your Soul Lantern is empty again: fill it for a %s"):format(v269 and "Lantern Maul" or "Wisp Hatchet")
    })
    local v270
    if v269 then
        v270 = v267.Labels.WISP_HATCHET
    else
        v270 = v267.Labels.LANTERN_MAUL
    end
    local v271 = v267.Keys[v270]
    local v272
    if v271 then
        v272 = p265.Controllers.ChestInventoryController:BuildItemCard(v268.ItemType.WEAPON, v271, nil)
    else
        v272 = v271
    end
    if not v272 then
        return nil
    end
    v272.rotY = v267.Data[v271].ViewRotY or v272.rotY
    local v_u_273 = p266.key
    return {
        ["results"] = { v272 },
        ["title"] = v269 and "WISP HATCHET" or (p266.early and "FOUND EARLY!" or "LANTERN MAUL"),
        ["equip"] = v_u_273 ~= "" and function()
            -- upvalues: (ref) v_u_8, (copy) v_u_273
            task.spawn(function()
                -- upvalues: (ref) v_u_8, (ref) v_u_273
                local function v275()
                    -- upvalues: (ref) v_u_8, (ref) v_u_273
                    local v274 = {
                        ["key"] = v_u_273
                    }
                    v_u_8.InventoryOp.Call(v274)
                end
                pcall(v275)
            end)
        end or nil
    }
end
function v11._screenFlash(_)
    -- upvalues: (copy) v_u_10, (copy) v_u_1, (copy) v_u_6, (copy) v_u_7
    local v276 = Instance.new("ScreenGui")
    v276.Name = "LanternMaulFlash"
    v276.IgnoreGuiInset = true
    v276.DisplayOrder = 50
    v276.ResetOnSpawn = false
    local v277 = Instance.new("Frame")
    v277.Size = UDim2.fromScale(1, 1)
    v277.BackgroundColor3 = v_u_10.WHITE
    v277.BackgroundTransparency = 0.1
    v277.BorderSizePixel = 0
    v277.Parent = v276
    v276.Parent = v_u_1.LocalPlayer:WaitForChild("PlayerGui")
    v_u_6:Create(v277, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {}):Play()
    v_u_7:AddItem(v276, 0.9)
end
return v11