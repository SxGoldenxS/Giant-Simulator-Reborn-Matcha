-- Bounded live diagnostic. Run only with the hub and native auto paused.
-- Compares one report with two immediate or 0.12-second-spaced reports.
-- Soul gain is observed; sent reports are not claimed as accepted hits.
-- Matcha's loadstring bridge does not forward chunk arguments.
local late = _G.GhostDoubleLate == true
_G.GhostDoubleLate = nil
local variants = late and { "single", "late", "very-late", "single", "very-late", "late" }
    or { "single", "immediate", "spaced", "single", "spaced", "immediate" }
assert(not (_G.GhostDoubleProbe and _G.GhostDoubleProbe.running), "Probe already running")
local hub, ui = _G.GiantRebornMatcha, _G.Rem
assert(hub and hub.running and ui and ui.Alive, "Hub required for restoration")
local player = game:GetService("Players").LocalPlayer
local service = game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.GameService
local folder = workspace.NPC.Ghosts
local initialRoot = player.Character.HumanoidRootPart
local rootAddress, job = initialRoot.Address, game.JobId
local test = { running = true, rows = {}, startedAt = tick() }
function test.Stop() test.running = false end
_G.GhostDoubleProbe = test
local swingOpen = false
local function check()
    assert(test.running and hub.running and _G.GiantRebornMatcha == hub, "Probe stopped")
    assert(game.JobId == job and game.PlaceId == 12645083079, "Server changed")
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    assert(root and root.Address == rootAddress and hum and hum.Health > 0, "Character changed")
    assert(tick()-test.startedAt < 100, "Probe time limit")
    return root
end
local function pause(seconds) task.wait(seconds) check() end
local function souls()
    local text = player.PlayerGui.SoulLanternGui.Frame.body.count.Text
    local digits = string.match(text, "^([%d,]+)")
    assert(digits, "Soul meter unavailable")
    return tonumber((string.gsub(digits, ",", "")))
end
local function visible(g)
    return g and g.Parent and g.Hitbox and g.Body and g.Body.Transparency < 0.95
end
local selected
local function target(root)
    if visible(selected) and (selected.Hitbox.Position-root.Position).Magnitude < 500 then return selected end
    local best = 500
    selected = nil
    for _, ghost in ipairs(folder:GetChildren()) do
        if visible(ghost) then
            local d = (ghost.Hitbox.Position-root.Position).Magnitude
            if d < best then selected, best = ghost, d end
        end
    end
    assert(selected, "No nearby visible ghost")
    return selected
end
local function aim(root, ghost, previous, sampledAt, lead)
    local point = ghost.Hitbox.Position
    assert((point-root.Position).Magnitude < 500, "Ghost left event area")
    local dt = tick()-sampledAt
    local speed = previous and dt > 0 and math.min(20, (point-previous).Magnitude/dt) or 0
    local predicted = point + ghost.Hitbox.CFrame.LookVector * (speed*lead)
    local position = predicted + Vector3.new(0, 1.5, 2.5)
    root.CFrame = CFrame.lookAt(position, Vector3.new(predicted.X, position.Y, predicted.Z))
    return point, tick()
end
local function report(ghost, row)
    local root = check()
    if visible(ghost) and (ghost.Hitbox.Position-root.Position).Magnitude <= 10 then
        service.MeleeHit:FireServer(ghost.Hitbox)
        row.reports = row.reports + 1
    else row.skips = row.skips + 1 end
end
task.spawn(function()
    local ok, err = pcall(function()
        pause(1)
        local quiet = souls()
        pause(1.5)
        assert(souls() == quiet, "Soul gains during quiet control; isolate native auto and hub first")
        for block, kind in ipairs(variants) do
            local row = { kind = kind, before = souls(), reports = 0, skips = 0,
                bloodMoon = workspace:GetAttribute("BloodMoon"), startedAt = tick() }
            local spacing = kind == "late" and 0.3 or kind == "very-late" and 0.5 or 0.12
            local window = late and 0.65 or 0.35
            print("DOUBLE-BLOCK-START", block, kind, row.before)
            for swing = 1, 6 do
                local root = check()
                local ghost = target(root)
                local point, sampledAt = aim(root, ghost, nil, tick(), 0)
                pause(0.2)
                point, sampledAt = aim(root, ghost, point, sampledAt, 0.2)
                service.WeaponAttackStart:FireServer()
                swingOpen = true
                pause(0.2)
                point, sampledAt = aim(root, ghost, point, sampledAt, 0.15)
                pause(0.15)
                report(ghost, row)
                if kind == "immediate" then report(ghost, row) end
                pause(spacing)
                if kind == "spaced" or kind == "late" or kind == "very-late" then report(ghost, row) end
                pause(window-spacing)
                service.WeaponAnimComplete:FireServer()
                swingOpen = false
                pause(0.2)
                print("DOUBLE-SWING", block, swing, kind, souls(), row.reports, row.skips)
            end
            pause(0.75)
            row.after, row.seconds = souls(), tick()-row.startedAt
            row.endBloodMoon = workspace:GetAttribute("BloodMoon")
            row.gain = row.after-row.before
            test.rows[#test.rows+1] = row
            print("DOUBLE-BLOCK-RESULT", block, kind, row.gain, row.reports, row.skips)
        end
    end)
    if swingOpen then pcall(function() service.WeaponAnimComplete:FireServer() end) end
    test.running, test.ok, test.error = false, ok, ok and "" or tostring(err)
    pcall(function()
        writefile("giant-double-hit-results.json", game:GetService("HttpService"):JSONEncode({
            ok = test.ok, error = test.error, rows = test.rows, startedAt = test.startedAt,
        }))
    end)
    if hub.running and _G.GiantRebornMatcha == hub then
        for _, tab in ipairs(ui.Tabs) do for _, control in ipairs(tab.Controls or {}) do
            if control.Title == "Halloween auto" then control:SetValue("Ghost souls") end
        end end
        -- Restore the prior native-auto boolean. The UI can restart its animation.
        pcall(function() applygc(_G.GhostNativeAutoRows, "DoAutoClick", true) end)
    end
    print("DOUBLE-PROBE-DONE", ok, test.error, "Ghost souls restored; native auto flag restored")
end)
print("DOUBLE-PROBE-STARTED; _G.GhostDoubleProbe.Stop() cancels")
