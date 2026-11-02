-- Decompiled game.Players.BoomerIsBigMan.PlayerScripts.Aero.Controllers.EventDoorSignController

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = require(v1.ReactUI.InventoryTheme)
local v4 = {}
local v_u_5 = UDim2.new(11, 60, 3.6, 20)
function v4.Start(p_u_6)
    if workspace:GetAttribute("IsClanGrounds") == true then
        return
    elseif p_u_6.Shared.HalloweenEvent.IsOn() then
        task.spawn(function()
            -- upvalues: (copy) p_u_6
            local v7 = workspace:WaitForChild("Scene", 60)
            if v7 then
                v7 = v7:WaitForChild("Halloween_Open", 60)
            end
            if v7 then
                v7 = v7:WaitForChild("TpPart", 60)
            end
            if v7 and v7:IsA("BasePart") then
                p_u_6:_build(v7)
            end
        end)
    end
end
function v4._build(p8, p9)
    -- upvalues: (copy) v_u_5, (copy) v_u_3, (copy) v_u_2
    local v_u_10 = Instance.new("BillboardGui")
    v_u_10.Name = "EventSign"
    v_u_10.Adornee = p9
    v_u_10.Size = v_u_5
    v_u_10.StudsOffsetWorldSpace = Vector3.new(0, 12, 0)
    v_u_10.LightInfluence = 0
    v_u_10.MaxDistance = 600
    v_u_10.ResetOnSpawn = false
    local v11 = Instance.new("Frame")
    v11.Name = "Body"
    v11.BackgroundTransparency = 1
    v11.AnchorPoint = Vector2.new(0.5, 0.5)
    v11.Position = UDim2.fromScale(0.5, 0.5)
    v11.Size = UDim2.fromScale(1, 1)
    v11.Parent = v_u_10
    local v_u_12 = Instance.new("UIScale")
    v_u_12.Parent = v11
    local v13 = Instance.new("UIListLayout")
    v13.FillDirection = Enum.FillDirection.Horizontal
    v13.HorizontalAlignment = Enum.HorizontalAlignment.Center
    v13.VerticalAlignment = Enum.VerticalAlignment.Center
    v13.SortOrder = Enum.SortOrder.LayoutOrder
    v13.Padding = UDim.new(0.02, 0)
    v13.Parent = v11
    local v14 = Instance.new("ImageLabel")
    v14.Name = "PumpkinIcon"
    v14.BackgroundTransparency = 1
    v14.Size = UDim2.fromScale(1, 1)
    v14.SizeConstraint = Enum.SizeConstraint.RelativeYY
    v14.ScaleType = Enum.ScaleType.Fit
    v14.Image = p8.Shared.SharedConstants.PUMPKIN_CURRENCY_ICON
    v14.LayoutOrder = 1
    v14.Parent = v11
    local v15 = Instance.new("TextLabel")
    v15.Name = "Text"
    v15.BackgroundTransparency = 1
    v15.Size = UDim2.fromScale(0.68, 0.9)
    v15.FontFace = v_u_3.FONT_DISPLAY
    v15.Text = "EVENT!"
    v15.TextScaled = true
    v15.TextColor3 = Color3.new(1, 1, 1)
    v15.LayoutOrder = 2
    local v16 = Instance.new("UIGradient")
    v16.Rotation = 90
    v16.Color = ColorSequence.new(v_u_3.GOLD_BRIGHT, p8.Shared.SharedConstants.PUMPKIN_CURRENCY_TEXT_COLOR)
    v16.Parent = v15
    local v_u_17 = Instance.new("UIStroke")
    v_u_17.Color = v_u_3.OUTLINE
    v_u_17.Thickness = 1.5
    v_u_17.Parent = v15
    v15.Parent = v11
    v_u_10.Parent = p9
    local v_u_18 = p9.Position
    local v_u_19 = nil
    v_u_19 = v_u_2.RenderStepped:Connect(function()
        -- upvalues: (copy) v_u_10, (ref) v_u_19, (copy) v_u_18, (copy) v_u_12, (copy) v_u_17
        if v_u_10.Parent then
            local v20 = workspace.CurrentCamera
            if not v20 or (v20.CFrame.Position - v_u_18).Magnitude <= 300 then
                local v21 = 6.283185307179586 * os.clock() / 3.2
                local v22 = v_u_10
                local v23 = math.sin(v21) * 0.35 + 12
                v22.StudsOffsetWorldSpace = Vector3.new(0, v23, 0)
                local v24 = v_u_12
                local v25 = v21 * 0.5
                v24.Scale = math.sin(v25) * 0.04 + 1
                local v26 = v_u_17
                local v27 = v_u_10.AbsoluteSize.Y * 0.07
                v26.Thickness = math.clamp(v27, 1.5, 6)
            end
        else
            v_u_19:Disconnect()
            return
        end
    end)
end
return v4