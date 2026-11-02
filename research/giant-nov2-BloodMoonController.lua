-- Decompiled game.Players.BoomerIsBigMan.PlayerScripts.Aero.Controllers.BloodMoonController

local v_u_1 = game:GetService("Debris")
local v_u_2 = game:GetService("Lighting")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("SoundService")
local v_u_6 = game:GetService("TweenService")
local v_u_7 = require(v3.Packages.signal)
local v_u_8 = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
return {
    ["Init"] = function(p9)
        -- upvalues: (copy) v_u_7
        p9.Changed = v_u_7.new()
        p9._active = false
        p9._endsAt = 0
        p9._startsAt = 0
        p9._eventEndsAt = 0
        p9._clockOffset = 0
        p9._inZone = false
        p9._shown = false
        p9._saved = nil
        p9._rng = Random.new()
    end,
    ["Start"] = function(p_u_10)
        p_u_10._look = p_u_10.Shared.HalloweenConfig.BLOOD_MOON.LOOK
        p_u_10:_saveLighting()
        local function v20()
            -- upvalues: (copy) p_u_10
            local v11 = workspace:GetAttribute("BloodMoon") == true
            local v12 = workspace
            local v13 = tonumber(v12:GetAttribute("BloodMoonEndsAt")) or 0
            local v14 = workspace
            local v15 = tonumber(v14:GetAttribute("BloodMoonStartsAt")) or 0
            local v16 = workspace
            local v17 = tonumber(v16:GetAttribute("BloodMoonClockOffset")) or 0
            local v18 = p_u_10.Shared.HalloweenEvent.EndsAt()
            if v11 ~= p_u_10._active or (v13 ~= p_u_10._endsAt or (v15 ~= p_u_10._startsAt or (v17 ~= p_u_10._clockOffset or v18 ~= p_u_10._eventEndsAt))) then
                local v19 = v11 ~= p_u_10._active
                p_u_10._active = v11
                p_u_10._endsAt = v13
                p_u_10._startsAt = v15
                p_u_10._eventEndsAt = v18
                p_u_10._clockOffset = v17
                if v19 then
                    p_u_10:_setDoorCue(v11)
                    p_u_10:_update()
                end
                p_u_10.Changed:Fire()
            end
        end
        workspace:GetAttributeChangedSignal("BloodMoon"):Connect(v20)
        workspace:GetAttributeChangedSignal("BloodMoonEndsAt"):Connect(v20)
        workspace:GetAttributeChangedSignal("BloodMoonStartsAt"):Connect(v20)
        workspace:GetAttributeChangedSignal("BloodMoonClockOffset"):Connect(v20)
        workspace:GetAttributeChangedSignal(p_u_10.Shared.HalloweenEvent.ATTR_ENDS_AT):Connect(v20)
        v20()
    end,
    ["IsActive"] = function(p21)
        return p21._active
    end,
    ["GetEndsAt"] = function(p22)
        return p22._endsAt
    end,
    ["Now"] = function(p23)
        return workspace:GetServerTimeNow() + p23._clockOffset
    end,
    ["GetStartsAt"] = function(p24)
        return p24._startsAt
    end,
    ["GetEventEndsAt"] = function(p25)
        return p25._eventEndsAt
    end,
    ["SetInZone"] = function(p26, p27)
        p26._inZone = p27
        p26:_update()
    end,
    ["_update"] = function(p28)
        local v29 = p28._active
        if v29 then
            v29 = p28._inZone
        end
        if v29 == p28._shown then
            return
        else
            p28._shown = v29
            if v29 then
                p28:_showLook()
            else
                p28:_hideLook()
            end
        end
    end,
    ["_saveLighting"] = function(p30)
        -- upvalues: (copy) v_u_2
        local v31 = v_u_2:FindFirstChildOfClass("Atmosphere")
        local v32 = v_u_2:FindFirstChildOfClass("ColorCorrectionEffect")
        p30._atmosphere = v31
        p30._cc = v32
        p30._saved = {
            ["lighting"] = {
                ["Ambient"] = v_u_2.Ambient,
                ["OutdoorAmbient"] = v_u_2.OutdoorAmbient,
                ["ColorShift_Top"] = v_u_2.ColorShift_Top
            },
            ["atmosphere"] = v31 and {
                ["Density"] = v31.Density,
                ["Haze"] = v31.Haze,
                ["Glare"] = v31.Glare,
                ["Color"] = v31.Color,
                ["Decay"] = v31.Decay
            } or v31,
            ["cc"] = v32 and {
                ["TintColor"] = v32.TintColor,
                ["Brightness"] = v32.Brightness
            } or v32
        }
    end,
    ["_tweenAll"] = function(p33, p34)
        -- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_8
        local v35 = {}
        local v36 = v_u_6
        local v37 = v_u_2
        local v38 = v_u_8
        local v39 = p34.lighting
        table.insert(v35, v36:Create(v37, v38, v39))
        if p33._atmosphere and p34.atmosphere then
            local v40 = v_u_6
            local v41 = p33._atmosphere
            local v42 = v_u_8
            local v43 = p34.atmosphere
            table.insert(v35, v40:Create(v41, v42, v43))
        end
        if p33._cc and p34.cc then
            local v44 = v_u_6
            local v45 = p33._cc
            local v46 = v_u_8
            local v47 = p34.cc
            table.insert(v35, v44:Create(v45, v46, v47))
        end
        for _, v48 in v35 do
            v48:Play()
        end
    end,
    ["_showLook"] = function(p49)
        local v50 = p49._look
        local v51 = v50.ATMOSPHERE
        local v52 = {}
        local v53 = {}
        local v54 = v50.AMBIENT
        v53.Ambient = Color3.fromRGB(v54[1], v54[2], v54[3])
        local v55 = v50.OUTDOOR_AMBIENT
        v53.OutdoorAmbient = Color3.fromRGB(v55[1], v55[2], v55[3])
        local v56 = v50.COLOR_SHIFT_TOP
        v53.ColorShift_Top = Color3.fromRGB(v56[1], v56[2], v56[3])
        v52.lighting = v53
        local v57 = {
            ["Density"] = v51.density,
            ["Haze"] = v51.haze,
            ["Glare"] = v51.glare
        }
        local v58 = v51.color
        v57.Color = Color3.fromRGB(v58[1], v58[2], v58[3])
        local v59 = v51.decay
        v57.Decay = Color3.fromRGB(v59[1], v59[2], v59[3])
        v52.atmosphere = v57
        local v60 = {}
        local v61 = v50.TINT
        v60.TintColor = Color3.fromRGB(v61[1], v61[2], v61[3])
        v52.cc = v60
        p49:_tweenAll(v52)
        p49:_showMoon()
        p49:_preloadThunder()
        p49:_startLightning()
    end,
    ["_hideLook"] = function(p62)
        local v63 = p62._saved
        local v64 = {
            ["lighting"] = v63.lighting,
            ["atmosphere"] = v63.atmosphere
        }
        local v65 = v63.cc
        v64.cc = v65 and {
            ["TintColor"] = v63.cc.TintColor
        } or v65
        p62:_tweenAll(v64)
        p62:_hideMoon()
        p62:_stopLightning()
    end,
    ["_buildMoon"] = function(p66)
        local v67 = p66._look
        local v68 = Instance.new("Part")
        v68.Name = "BloodMoon"
        v68.Anchored = true
        v68.CanCollide = false
        v68.CanQuery = false
        v68.CanTouch = false
        v68.CastShadow = false
        v68.Transparency = 1
        v68.Size = Vector3.new(1, 1, 1)
        local v69 = v67.MOON_ANGULAR_SIZE
        local v70 = math.rad(v69) / 2
        local v71 = math.tan(v70) * 3600
        local v_u_72 = Instance.new("BillboardGui")
        v_u_72.Name = "Moon"
        v_u_72.LightInfluence = 0
        v_u_72.AlwaysOnTop = false
        v_u_72.MaxDistance = (1 / 0)
        v_u_72.Size = UDim2.new(v71 * 2, 0, v71 * 2, 0)
        v_u_72.Parent = v68
        local function v80(p73, p74, p75, p76, p77)
            -- upvalues: (copy) v_u_72
            local v78 = Instance.new("Frame")
            v78.Name = p73
            v78.AnchorPoint = Vector2.new(0.5, 0.5)
            v78.Position = UDim2.fromScale(0.5, 0.5)
            v78.Size = UDim2.fromScale(p74, p74)
            v78.BackgroundColor3 = p75
            v78.BackgroundTransparency = p76
            v78.BorderSizePixel = 0
            v78.ZIndex = p77
            local v79 = Instance.new("UICorner")
            v79.CornerRadius = UDim.new(0.5, 0)
            v79.Parent = v78
            v78.Parent = v_u_72
            return v78
        end
        for v81 = 1, 9 do
            v80("Halo" .. v81, 1 - (v81 - 1) * 0.05333333333333333, Color3.fromRGB(255, 50, 30), 0.965, v81)
        end
        local v82 = v80("Disc", 0.5, Color3.fromRGB(205, 34, 26), 0, 10)
        local v83 = Instance.new("UIGradient")
        v83.Rotation = 35
        v83.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 90)), ColorSequenceKeypoint.new(0.55, Color3.fromRGB(205, 34, 26)), ColorSequenceKeypoint.new(1, Color3.fromRGB(110, 8, 12)) })
        v83.Parent = v82
        for v84, v85 in {
            { 0.36, 0.42, 0.13 },
            { 0.6, 0.36, 0.09 },
            { 0.55, 0.62, 0.15 },
            { 0.38, 0.66, 0.07 }
        } do
            local v86 = Instance.new("Frame")
            v86.Name = "Mare" .. v84
            v86.AnchorPoint = Vector2.new(0.5, 0.5)
            v86.Position = UDim2.fromScale(v85[1], v85[2])
            v86.Size = UDim2.fromScale(v85[3] * 2, v85[3] * 2)
            v86.BackgroundColor3 = Color3.fromRGB(120, 12, 14)
            v86.BackgroundTransparency = 0.55
            v86.BorderSizePixel = 0
            v86.ZIndex = 11
            local v87 = Instance.new("UICorner")
            v87.CornerRadius = UDim.new(0.5, 0)
            v87.Parent = v86
            v86.Parent = v82
        end
        local v88 = v67.MOON_ELEVATION_DEG
        local v89 = math.rad(v88)
        local v90 = v67.MOON_AZIMUTH_DEG
        local v91 = math.rad(v90)
        local v92 = math.cos(v89) * math.cos(v91)
        local v93 = math.sin(v89)
        local v94 = math.cos(v89) * math.sin(v91)
        p66._moonDir = Vector3.new(v92, v93, v94)
        p66._moon = v68
    end,
    ["_showMoon"] = function(p_u_95)
        -- upvalues: (copy) v_u_4
        if not p_u_95._moon then
            p_u_95:_buildMoon()
        end
        local v_u_96 = p_u_95._moon
        local function v98()
            -- upvalues: (copy) v_u_96, (copy) p_u_95
            local v97 = workspace.CurrentCamera
            if v97 then
                v_u_96.CFrame = CFrame.new(v97.CFrame.Position + p_u_95._moonDir * 1800)
            end
        end
        local v99 = workspace.CurrentCamera
        if v99 then
            v_u_96.CFrame = CFrame.new(v99.CFrame.Position + p_u_95._moonDir * 1800)
        end
        v_u_96.Parent = workspace
        if p_u_95._moonConn then
            p_u_95._moonConn:Disconnect()
        end
        p_u_95._moonConn = v_u_4.RenderStepped:Connect(v98)
    end,
    ["_hideMoon"] = function(p100)
        if p100._moonConn then
            p100._moonConn:Disconnect()
            p100._moonConn = nil
        end
        if p100._moon then
            p100._moon.Parent = nil
        end
    end,
    ["_startLightning"] = function(p_u_101)
        p_u_101._lightningRun = (p_u_101._lightningRun or 0) + 1
        local v_u_102 = p_u_101._lightningRun
        local v_u_103 = p_u_101._look
        task.spawn(function()
            -- upvalues: (copy) p_u_101, (copy) v_u_102, (copy) v_u_103
            while p_u_101._lightningRun == v_u_102 do
                local v104 = v_u_103.LIGHTNING_GAP_SECS
                task.wait(p_u_101._rng:NextNumber(v104[1], v104[2]))
                if p_u_101._lightningRun ~= v_u_102 then
                    return
                end
                p_u_101:_flash()
                local v105 = v_u_103.THUNDER_DELAY_SECS
                task.delay(p_u_101._rng:NextNumber(v105[1], v105[2]), function()
                    -- upvalues: (ref) p_u_101, (ref) v_u_102
                    if p_u_101._lightningRun == v_u_102 then
                        p_u_101:_thunder()
                    end
                end)
            end
        end)
    end,
    ["_stopLightning"] = function(p106)
        p106._lightningRun = (p106._lightningRun or 0) + 1
    end,
    ["_flash"] = function(p107)
        -- upvalues: (copy) v_u_6
        local v_u_108 = p107._cc
        if v_u_108 and p107._saved.cc then
            local v_u_109 = p107._look
            local v_u_110 = p107._saved.cc.Brightness
            local v111 = v_u_6:Create(v_u_108, TweenInfo.new(v_u_109.FLASH_RISE_SECS, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Brightness"] = v_u_110 + v_u_109.FLASH_BRIGHTNESS
            })
            v111.Completed:Connect(function()
                -- upvalues: (ref) v_u_6, (copy) v_u_108, (copy) v_u_109, (copy) v_u_110
                local v112 = {
                    ["Brightness"] = v_u_110
                }
                v_u_6:Create(v_u_108, TweenInfo.new(v_u_109.FLASH_FALL_SECS, Enum.EasingStyle.Quad, Enum.EasingDirection.In), v112):Play()
            end)
            v111:Play()
        end
    end,
    ["_preloadThunder"] = function(p_u_113)
        if not p_u_113._thunderPreloaded then
            p_u_113._thunderPreloaded = true
            task.spawn(function()
                -- upvalues: (copy) p_u_113
                local function v114()
                    -- upvalues: (ref) p_u_113
                    game:GetService("ContentProvider"):PreloadAsync(p_u_113._look.THUNDER_SOUND_IDS)
                end
                pcall(v114)
            end)
        end
    end,
    ["_thunder"] = function(p115)
        -- upvalues: (copy) v_u_5, (copy) v_u_1
        local v116 = p115._look
        local v117 = v116.THUNDER_SOUND_IDS
        local v_u_118 = Instance.new("Sound")
        v_u_118.Name = "BloodMoonThunder"
        v_u_118.SoundId = v117[p115._rng:NextInteger(1, #v117)]
        v_u_118.Volume = v116.THUNDER_VOLUME * (p115.Controllers.SoundController.SfxVolume or 0.7)
        v_u_118.PlaybackSpeed = p115._rng:NextNumber(0.9, 1.05)
        v_u_118.Parent = v_u_5
        v_u_1:AddItem(v_u_118, 10)
        if v_u_118.IsLoaded then
            v_u_118:Play()
        else
            local v_u_119 = nil
            v_u_119 = v_u_118.Loaded:Connect(function()
                -- upvalues: (ref) v_u_119, (copy) v_u_118
                v_u_119:Disconnect()
                v_u_118:Play()
            end)
        end
    end,
    ["_setDoorCue"] = function(p120, p121)
        if p120._doorCue then
            p120._doorCue:Destroy()
            p120._doorCue = nil
        end
        if p121 then
            local v122 = workspace:FindFirstChild("Scene")
            if v122 then
                v122 = v122:FindFirstChild("Halloween_Open")
            end
            if v122 then
                v122 = v122:FindFirstChild("TpPart")
            end
            if v122 and v122:IsA("BasePart") then
                local v123 = p120._look
                local v124 = Instance.new("Attachment")
                v124.Name = "BloodMoonCue"
                local v125 = Instance.new("PointLight")
                v125.Color = Color3.fromRGB(255, 40, 30)
                v125.Range = v123.DOOR_GLOW_RANGE
                v125.Brightness = v123.DOOR_GLOW_BRIGHTNESS
                v125.Shadows = false
                v125.Parent = v124
                local v126 = Instance.new("ParticleEmitter")
                v126.Name = "Mist"
                v126.Color = ColorSequence.new(Color3.fromRGB(255, 70, 50), Color3.fromRGB(120, 0, 10))
                v126.LightEmission = 0.6
                v126.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.3, 0.6), NumberSequenceKeypoint.new(1, 1) })
                v126.Size = NumberSequence.new(3, 7)
                v126.Lifetime = NumberRange.new(3, 5)
                v126.Rate = 4
                v126.Speed = NumberRange.new(0.5, 1.5)
                v126.SpreadAngle = Vector2.new(180, 30)
                v126.Acceleration = Vector3.new(0, 0.6, 0)
                v126.Parent = v124
                v124.Parent = v122
                p120._doorCue = v124
            end
        else
            return
        end
    end
}