-- Decompiled game.Players.BoomerIsBigMan.PlayerScripts.Aero.Controllers.NodeController

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("TweenService")
local v4 = {}
local v_u_5 = nil
local v_u_6 = nil
function v4.Init(p7)
    -- upvalues: (ref) v_u_5, (ref) v_u_6
    v_u_5 = p7.Shared.SharedConstants
    v_u_6 = v_u_5.RemoteEvents
end
function v4.Start(p_u_8)
    -- upvalues: (copy) v_u_1, (ref) v_u_5, (copy) v_u_2, (ref) v_u_6
    if workspace:GetAttribute("IsClanGrounds") ~= true then
        p_u_8.NodeList = {}
        p_u_8.NodeTweens = {}
        p_u_8.NodeIdx = 1
        p_u_8.Player = game.Players.LocalPlayer
        while not p_u_8.Player do
            game.Players.PlayerAdded:wait()
            p_u_8.Player = game.Players.LocalPlayer
        end
        local v9 = v_u_1:WaitForChild("Nodes")
        local v10 = v9:WaitForChild("Gold")
        local v11 = v9:WaitForChild("Speed")
        local v12 = v9:WaitForChild("Xp")
        p_u_8.Prefabs = {}
        p_u_8.Prefabs[v_u_5.NodeType.XP] = v12
        p_u_8.Prefabs[v_u_5.NodeType.GOLD] = v10
        p_u_8.Prefabs[v_u_5.NodeType.SPEED] = v11
        p_u_8.Prefabs[v_u_5.NodeType.PUMPKIN] = v9:FindFirstChild("Pumpkin")
        p_u_8.NodesFolder = game.Workspace:WaitForChild("Scene"):WaitForChild("ResourceNodes1")
        local v13 = p_u_8.NodesFolder:GetChildren()
        p_u_8.NodesFolder.ChildAdded:Connect(function(p14)
            -- upvalues: (copy) p_u_8
            p_u_8:OnNodeAdded(p14)
        end)
        for _, v15 in pairs(v13) do
            p_u_8:OnNodeAdded(v15)
        end
        v_u_2.RenderStepped:Connect(function(p16)
            -- upvalues: (copy) p_u_8
            p_u_8:OnRenderStepped(p16)
        end)
        p_u_8.Services.GameService[v_u_6.PLAYER_NODE_TOUCH]:Connect(function()
            -- upvalues: (copy) p_u_8
            p_u_8.Controllers.SoundController:PlayPickupSFX()
        end)
    end
end
function v4.OnNodeAdded(p_u_17, p_u_18)
    local v19 = p_u_18:WaitForChild("NodeType")
    v19.Changed:Connect(function(p20)
        -- upvalues: (copy) p_u_17, (copy) p_u_18
        p_u_17:OnNodeChanged(p_u_18, p20)
    end)
    p_u_17:OnNodeChanged(p_u_18, v19.Value)
    p_u_17.NodeList = p_u_17.NodesFolder:GetChildren()
end
function v4.OnNodeChanged(p21, p22, p23)
    local v24 = p22:FindFirstChild("Prefab")
    if v24 then
        v24:Destroy()
    end
    if p23 > 0 and p21.Prefabs[p23] then
        local v25 = p21.Prefabs[p23]:Clone()
        v25.Name = "Prefab"
        v25.Position = p22.Position
        v25.Parent = p22
    end
    p21:StopTween(p22)
end
function v4.OnRenderStepped(p26, _)
    local v27 = #p26.NodeList
    if v27 ~= 0 then
        if v27 < p26.NodeIdx then
            p26.NodeIdx = 1
        end
        local v28 = p26.NodeList[p26.NodeIdx]
        local v29
        if p26.Player and (p26.Player.Character and (p26.Player.Character.PrimaryPart and (p26.Player.Character.PrimaryPart.Position - v28.Position).Magnitude < 250)) then
            if p26.NodeTweens[v28] then
                v29 = false
            else
                p26:StartTween(v28)
                v29 = false
            end
        else
            v29 = true
        end
        if v29 then
            p26:StopTween(v28)
        end
        p26.NodeIdx = p26.NodeIdx + 1
    end
end
function v4.StartTween(p30, p31)
    -- upvalues: (copy) v_u_3
    local v32 = p31:FindFirstChild("Prefab")
    if v32 ~= nil then
        local v33 = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true, 0)
        local v34 = p31.Position + Vector3.new(0, 3, 0)
        local v35 = v_u_3:Create(v32, v33, {
            ["Position"] = v34
        })
        v35:Play()
        local v36 = v_u_3:Create(v32:WaitForChild("ForceField"), v33, {
            ["Position"] = v34
        })
        v36:Play()
        local v37 = v_u_3:Create(v32, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, 0), {
            ["Orientation"] = v32.Orientation + Vector3.new(0, 360, 0)
        })
        v37:Play()
        p30.NodeTweens[p31] = { v35, v37, v36 }
    end
end
function v4.StopTween(p38, p39)
    local v40 = p38.NodeTweens[p39]
    if v40 then
        v40[1]:Cancel()
        v40[2]:Cancel()
        v40[3]:Cancel()
        p38.NodeTweens[p39] = nil
        local v41 = p39:FindFirstChild("Prefab")
        if v41 then
            v41.Position = p39.Position
            v41:WaitForChild("ForceField").Position = p39.Position
        end
    end
end
return v4