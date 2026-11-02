-- Native auto must be on; hub Halloween mode must be off.
-- Two bounded 20-second blocks: normal ghost hitboxes, then 12-stud boxes.
local player = game:GetService("Players").LocalPlayer
local hub = _G.GiantRebornMatcha
local job = game.JobId
local rootAddress = player.Character.HumanoidRootPart.Address
local ghosts = {}
for _, model in ipairs(workspace.NPC.Ghosts:GetChildren()) do
    if model.Hitbox and model.Body then
        ghosts[#ghosts+1] = { name = model.Name, hitbox = model.Hitbox, body = model.Body, size = model.Hitbox.Size }
    end
end
local state = { running = true, rows = {} }
function state.Stop() state.running = false end
_G.NativeGhostProbe = state
local function count()
    local text = player.PlayerGui.SoulLanternGui.Frame.body.count.Text
    return tonumber((string.gsub(string.match(text, "^([%d,]+)"), ",", "")))
end
local function visible(g) return g and g.hitbox.Parent and g.body.Transparency < 0.95 end
task.spawn(function()
    local ok, err = pcall(function()
        local selected, previous, sampledAt
        for phase = 1, 2 do
            if phase == 2 then
                for _, ghost in ipairs(ghosts) do ghost.hitbox.Size = Vector3.new(12, 12, 12) end
            end
            local row = { kind = phase == 1 and "native-normal" or "native-expanded", before = count(),
                bloodMoon = workspace:GetAttribute("BloodMoon"), moves = 0 }
            local started, printAt = tick(), tick()+5
            print("NATIVE-START", row.kind, row.before)
            while tick()-started < 20 do
                assert(state.running and hub.running and _G.GiantRebornMatcha == hub, "Stopped")
                assert(game.JobId == job, "Server changed")
                local char = player.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChild("Humanoid")
                assert(root and root.Address == rootAddress and hum and hum.Health > 0, "Character changed")
                if not visible(selected) or (selected.hitbox.Position-root.Position).Magnitude >= 500 then
                    selected, previous = nil, nil
                    local best = 500
                    for _, ghost in ipairs(ghosts) do
                        if visible(ghost) then
                            local distance = (ghost.hitbox.Position-root.Position).Magnitude
                            if distance < best then selected, best = ghost, distance end
                        end
                    end
                end
                assert(selected, "No nearby ghosts")
                local point, now = selected.hitbox.Position, tick()
                local speed = previous and math.min(20, (point-previous).Magnitude/(now-sampledAt)) or 0
                local predicted = point + selected.hitbox.CFrame.LookVector * (speed*0.2)
                local position = predicted + Vector3.new(0, 1.5, 2.5)
                root.CFrame = CFrame.lookAt(position, Vector3.new(predicted.X, position.Y, predicted.Z))
                row.moves = row.moves + 1
                previous, sampledAt = point, now
                if now >= printAt then print("NATIVE-PROGRESS", row.kind, count()) printAt = now+5 end
                task.wait(0.2)
            end
            row.after, row.seconds = count(), tick()-started
            row.gain, row.endBloodMoon = row.after-row.before, workspace:GetAttribute("BloodMoon")
            state.rows[#state.rows+1] = row
            print("NATIVE-RESULT", row.kind, row.gain, row.seconds)
        end
    end)
    for _, ghost in ipairs(ghosts) do
        if ghost.hitbox.Parent then pcall(function() ghost.hitbox.Size = ghost.size end) end
    end
    state.running, state.ok, state.error = false, ok, ok and "" or tostring(err)
    writefile("giant-native-ghost-results.json", game:GetService("HttpService"):JSONEncode({
        ok = state.ok, error = state.error, rows = state.rows,
    }))
    if hub.running and _G.GiantRebornMatcha == hub then
        for _, tab in ipairs(_G.Rem.Tabs) do for _, control in ipairs(tab.Controls or {}) do
            if control.Title == "Halloween auto" then control:SetValue("Ghost souls") end
        end end
    end
    print("NATIVE-PROBE-DONE", ok, state.error)
end)
print("NATIVE-PROBE-SETUP; _G.NativeGhostProbe.Stop() cancels")
