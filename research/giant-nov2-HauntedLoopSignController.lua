-- Decompiled game.Players.BoomerIsBigMan.PlayerScripts.Aero.Controllers.HauntedLoopSignController

local v_u_1 = game:GetService("CollectionService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("TextService")
local v_u_5 = game:GetService("TweenService")
local v6 = {}
local v_u_7 = {
    {},
    {}
}
local function v_u_14(p8, p9)
    if not p8 or (not p8:IsA("TextLabel") or p8.Parent and p8.Parent.Name == "SoulLine") then
        return nil
    end
    local v10 = Instance.new("Frame")
    v10.Name = "SoulLine"
    v10.BackgroundTransparency = 1
    v10.BorderSizePixel = 0
    v10.Size = p8.Size
    v10.Position = p8.Position
    v10.AnchorPoint = p8.AnchorPoint
    v10.LayoutOrder = p8.LayoutOrder
    v10.ZIndex = p8.ZIndex
    local v11 = Instance.new("UIListLayout")
    v11.FillDirection = Enum.FillDirection.Horizontal
    v11.HorizontalAlignment = Enum.HorizontalAlignment.Center
    v11.VerticalAlignment = Enum.VerticalAlignment.Center
    v11.SortOrder = Enum.SortOrder.LayoutOrder
    v11.Padding = UDim.new(0, 6)
    v11.Parent = v10
    local v12 = Instance.new("ImageLabel")
    v12.Name = "SoulIcon"
    v12.BackgroundTransparency = 1
    v12.Size = UDim2.fromScale(0.8, 0.8)
    v12.ScaleType = Enum.ScaleType.Fit
    v12.Image = p9
    v12.ZIndex = p8.ZIndex + 3
    v12.LayoutOrder = 1
    local v13 = Instance.new("UIAspectRatioConstraint")
    v13.DominantAxis = Enum.DominantAxis.Height
    v13.Parent = v12
    v12.Parent = v10
    v10.Parent = p8.Parent
    p8.LayoutOrder = 2
    p8.Parent = v10
    return p8
end
local function v_u_21(p15, p16)
    -- upvalues: (copy) v_u_4
    local v_u_17 = Instance.new("GetTextBoundsParams")
    v_u_17.Text = p15.Text
    v_u_17.Font = p15.FontFace
    v_u_17.Size = p16
    v_u_17.Width = 100000
    local function v18()
        -- upvalues: (ref) v_u_4, (copy) v_u_17
        return v_u_4:GetTextBoundsAsync(v_u_17)
    end
    local v19, v20 = pcall(v18)
    return not v19 and 0 or v20.X
end
function v6._fitSoulLines(_, p_u_22)
    -- upvalues: (copy) v_u_21
    local v_u_23 = 0
    local function v_u_42()
        -- upvalues: (ref) v_u_23, (copy) p_u_22, (ref) v_u_21
        v_u_23 = v_u_23 + 1
        local v24 = v_u_23
        local v25 = p_u_22[1].Parent.AbsoluteSize
        if v25.X <= 0 or v25.Y <= 0 then
            return
        else
            local v26 = v25.X - v25.Y * 0.8 - 6 - 4
            local v27 = v25.Y * 0.7
            local v28 = math.floor(v27)
            local v29 = 0
            for _, v30 in p_u_22 do
                local v31 = v_u_21(v30, v28)
                v29 = math.max(v29, v31)
            end
            if v26 < v29 then
                local v32 = v28 * v26 / v29
                local v33 = math.floor(v32)
                v28 = math.max(8, v33)
                v29 = 0
                for _, v34 in p_u_22 do
                    local v35 = v_u_21(v34, v28)
                    v29 = math.max(v29, v35)
                end
                while v26 < v29 and v28 > 8 do
                    v28 = v28 - 1
                    v29 = 0
                    for _, v36 in p_u_22 do
                        local v37 = v_u_21(v36, v28)
                        v29 = math.max(v29, v37)
                    end
                end
            end
            if v24 == v_u_23 then
                for _, v38 in p_u_22 do
                    for _, v39 in { v38, v38:FindFirstChild("FG") } do
                        if v39 and v39:IsA("TextLabel") then
                            v39.TextScaled = false
                            v39.TextWrapped = v26 < v29
                            v39.TextSize = v28
                            v39.TextXAlignment = Enum.TextXAlignment.Left
                        end
                    end
                    local v40 = UDim2.new
                    local v41 = math.min(v29, v26)
                    v38.Size = v40(0, math.ceil(v41) + 4, 1, 0)
                end
            end
        end
    end
    for _, v43 in p_u_22 do
        v43:GetPropertyChangedSignal("Text"):Connect(function()
            -- upvalues: (copy) v_u_42
            task.spawn(v_u_42)
        end)
        v43.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            -- upvalues: (copy) v_u_42
            task.spawn(v_u_42)
        end)
    end
    task.spawn(v_u_42)
end
function v6.Start(p_u_44)
    -- upvalues: (copy) v_u_7
    if workspace:GetAttribute("IsClanGrounds") ~= true then
        task.spawn(function()
            -- upvalues: (copy) p_u_44, (ref) v_u_7
            local v_u_45 = workspace:WaitForChild("Scene", 60)
            if v_u_45 then
                v_u_45 = v_u_45:WaitForChild("HalloweenZone", 60)
            end
            if v_u_45 then
                task.spawn(function()
                    -- upvalues: (ref) p_u_44, (copy) v_u_45
                    p_u_44:_fillSign(v_u_45:WaitForChild("HauntedLoopSign", 10))
                end)
                for _, v_u_46 in v_u_7 do
                    task.spawn(function()
                        -- upvalues: (ref) p_u_44, (copy) v_u_45, (copy) v_u_46
                        p_u_44:_showWeapon(v_u_45:WaitForChild(v_u_46.plinth, 10), v_u_46.anchor, v_u_46.label)
                    end)
                end
            end
        end)
    end
end
function v6._fillSign(p47, p48)
    -- upvalues: (copy) v_u_14
    if p48 then
        p48 = p48:FindFirstChild("Board")
    end
    if p48 then
        p48 = p48:FindFirstChildOfClass("SurfaceGui")
    end
    if p48 then
        p48 = p48:FindFirstChild("Frame")
    end
    if p48 then
        local v49 = p47.Shared.HalloweenConfig
        local v50 = p47.Shared.GhostTrack
        local v51 = {}
        for v52, v53 in ipairs(v50.signLines(v49.SOULS, v49.GHOSTS.POP_HITS, v49.GHOSTS.POP_PUMPKINS)) do
            local v54 = p48:FindFirstChild("Rule" .. v52)
            if v54 then
                v54 = v54:FindFirstChild("Text", true)
            end
            if v54 and v54:IsA("TextLabel") then
                v54.Text = v53
                local v55 = v54:FindFirstChild("FG")
                if v55 and v55:IsA("TextLabel") then
                    v55.Text = v53
                end
            end
            local v56 = v_u_14(v54, p47.Shared.SharedConstants.HALLOWEEN_SOUL_ICON)
            if v56 then
                table.insert(v51, v56)
            end
        end
        if #v51 > 0 then
            p47:_fitSoulLines(v51)
        end
        p47:_bindMeter(p48:FindFirstChild("Meter"))
    end
end
function v6._bindMeter(p57, p_u_58)
    -- upvalues: (copy) v_u_14, (copy) v_u_5
    if p_u_58 then
        p_u_58 = p_u_58:FindFirstChild("Bar")
    end
    local v_u_59
    if p_u_58 then
        v_u_59 = p_u_58:FindFirstChild("Fill")
    else
        v_u_59 = p_u_58
    end
    if p_u_58 then
        p_u_58 = p_u_58:FindFirstChild("Count", true)
    end
    if v_u_59 and (v_u_59:IsA("Frame") and (p_u_58 and p_u_58:IsA("TextLabel"))) then
        local v60 = v_u_14(p_u_58, p57.Shared.SharedConstants.HALLOWEEN_SOUL_ICON)
        if v60 then
            p57:_fitSoulLines({ v60 })
        end
        local v_u_61 = p57.Controllers.ReplicaController
        local v_u_62 = p57.Shared.HalloweenConfig.SOULS
        local v_u_63 = p57.Shared.GhostTrack
        local v_u_64 = nil
        local function v75()
            -- upvalues: (copy) v_u_61, (copy) v_u_63, (copy) v_u_62, (copy) p_u_58, (ref) v_u_64, (copy) v_u_59, (ref) v_u_5
            local v65 = v_u_61
            local v66 = tonumber(v65:GetStat("hallow_lantern_stage")) == 2 and 2 or 1
            local v67 = v_u_63.lanternSize(v_u_62, v66)
            local v68 = v_u_61
            local v69 = tonumber(v68:GetStat("hallow_souls")) or 0
            local v70, v71 = v_u_63.lanternMeter(v69, v67)
            local v72 = p_u_58
            if v72 and v72:IsA("TextLabel") then
                v72.Text = v71
                local v73 = v72:FindFirstChild("FG")
                if v73 and v73:IsA("TextLabel") then
                    v73.Text = v71
                end
            end
            if v_u_64 then
                v_u_64:Cancel()
                v_u_64 = nil
            end
            local v74 = UDim2.new(v70, 0, 1, 0)
            if v_u_59.Size.X.Scale < v70 then
                v_u_64 = v_u_5:Create(v_u_59, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Size"] = v74
                })
                v_u_64:Play()
            else
                v_u_59.Size = v74
            end
        end
        v75()
        v_u_61:ObserveSection("stats", v75)
    end
end
local function v_u_82(p76)
    -- upvalues: (copy) v_u_1
    local v77 = Instance.new("Model")
    v77.Name = p76.Name .. "_display"
    for _, v78 in ipairs(p76:GetChildren()) do
        v78:Clone().Parent = v77
    end
    for _, v79 in ipairs(v77:GetDescendants()) do
        for _, v80 in ipairs(v_u_1:GetTags(v79)) do
            v_u_1:RemoveTag(v79, v80)
        end
        if v79:IsA("BasePart") then
            v79.Anchored = true
            v79.CanCollide = false
            v79.CanQuery = false
            v79.CanTouch = false
        elseif v79:IsA("Sound") or v79:IsA("Trail") then
            v79:Destroy()
        end
    end
    local v81 = v77:FindFirstChild("Handle")
    if v81 and v81:IsA("BasePart") then
        v77.PrimaryPart = v81
    end
    return v77
end
function v6._showWeapon(p83, p84, p85, p86)
    -- upvalues: (copy) v_u_2, (copy) v_u_82, (copy) v_u_3
    local v87
    if p84 then
        v87 = p84:FindFirstChild(p85)
    else
        v87 = p84
    end
    local v88 = v_u_2:FindFirstChild("Weapons")
    local v89 = p83.Shared.Weapons
    local v90 = v89.Labels[p86]
    if v88 then
        if v90 then
            v88 = v88:FindFirstChild(v90)
        else
            v88 = v90
        end
    end
    if v87 and (v87:IsA("BasePart") and v88) then
        local v_u_91 = v_u_82(v88)
        if v_u_91.PrimaryPart then
            local v92 = v89.Data[v89.Keys[v90]]
            local v93 = CFrame.Angles
            local v94 = v92 and v92.ViewRotY or 0
            local v_u_95 = v93(0, math.rad(v94), 0)
            local v_u_96 = v87.CFrame
            v_u_91:PivotTo(v_u_96 * v_u_95)
            v_u_91.Parent = p84
            local v_u_97 = v_u_96.Position
            v_u_3.RenderStepped:Connect(function()
                -- upvalues: (copy) v_u_97, (copy) v_u_91, (copy) v_u_96, (copy) v_u_95
                local v98 = workspace.CurrentCamera
                if not v98 or (v98.CFrame.Position - v_u_97).Magnitude <= 400 then
                    local v99 = os.clock()
                    local v100 = 6.283185307179586 * v99 / 3
                    local v101 = math.sin(v100) * 0.4
                    local v102 = 6.283185307179586 * (v99 / 8 % 1)
                    v_u_91:PivotTo(v_u_96 * CFrame.new(0, v101, 0) * CFrame.Angles(0, v102, 0) * v_u_95)
                end
            end)
        else
            v_u_91:Destroy()
        end
    else
        return
    end
end
return v6