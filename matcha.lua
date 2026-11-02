-- Giant Simulator: REBORN / Matcha Hybrid. All automation starts OFF.
-- UI: SxGoldenxS/REM-UI, revision 4d39214d904a49bbb5dc3579eec290b91cde349a.
-- End: menu. Delete: unload. _G.GiantRebornMatcha.Stop(): emergency stop.
-- See RESEARCH.md for evidence and validation limits. Remote dispatch is not proof of a reward.
if game.PlaceId ~= 12645083079 then
    print("[Giant Reborn] Join place 12645083079 before loading.")
    return
end
local old = _G.GiantRebornMatcha
if old and type(old.Stop) == "function" then old.Stop() end
local player = game:GetService("Players").LocalPlayer
assert(player, "Wait for LocalPlayer to load")
local rs = game:GetService("ReplicatedStorage")
local aero = rs:FindFirstChild("Aero")
local services = aero and aero:FindFirstChild("AeroRemoteServices")
local service = services and services:FindFirstChild("GameService")
assert(service, "GameService is not ready")
local zap = rs:FindFirstChild("ZAP")
assert(zap and zap:FindFirstChild("ZAP_RELIABLE"), "Training transport is not ready")
-- Current ZapClient.TrainClick.Fire writes exactly one u8: 12. No instance arguments.
local trainPacket = buffer.fromstring(string.char(12))
local job = game.JobId
local app = { running = true, requests = 0, touches = 0, moves = 0, pickups = 0 }
local options = { swing = false, collect = false, walk = false, rebirth = false,
    daily = false, idle = false, rebirthLevel = 100, orbType = "All", trainRate = 5,
    chests = false, chestKind = 1, chestBatch = 3, halloween = "Off", ghostAttack = "Native auto" }
local toggles, labels, deadlines, busy = {}, {}, {}, {}
local ui, destroyUI, inputConnection
local message = "Ready. Enable only the features you want."
local nodes, scanAt, target, targetAt = {}, 0, nil, 0
local nodeCooldown = {}
local walkOwned = false
local orbStatus, pendingOrb = "Off", nil
local pendingRebirth
local chest = { nextAt = 0, confirmed = 0, status = "Off" }
local halloween = { scanAt = 0, ghosts = {}, houses = {}, houseCooldown = {}, nextAt = 0, status = "Off" }
local chestKinds = {
    { "Common weapon", "t1_wpn_crate", 3 }, { "Rare weapon", "t2_wpn_crate", 5 },
    { "Epic weapon", "t3_wpn_crate", 9 }, { "Common skin", "t1_skin_crate", 17 },
    { "Rare skin", "t2_skin_crate", 33 }, { "Epic skin", "t3_skin_crate", 65 },
}
local codes = {
    { "CLANS", "XP II, Coin II and Soul Gem II potions" },
    { "SUMMERGEM", "Soul Gem II potion" },
    { "LAVA", "500 embers" },
    { "EMBERS", "500 embers" },
}

local function say(text)
    message = tostring(text)
    print("[Giant Reborn] " .. message)
end
local function actor()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if root and hum and type(hum.Health) == "number" and hum.Health > 0 then
        return root, hum
    end
end
local function stat(suffix)
    local stats = player:FindFirstChild("leaderstats")
    if stats then
        for _, item in ipairs(stats:GetChildren()) do
            if string.sub(item.Name, -#suffix) == suffix then
                local value = item.Value
                if type(value) == "number" and value == value then return value end
            end
        end
    end
end
local function releaseWalk()
    walkOwned = false
end
local function active()
    if app.running and (game.PlaceId ~= 12645083079 or game.JobId ~= job) then app.Stop() end
    return app.running
end
local function event(folder, name, ...)
    if not active() then return end
    local remote = folder and folder:FindFirstChild(name)
    assert(remote and remote.ClassName == "RemoteEvent", name .. " is unavailable")
    remote:FireServer(...)
    app.requests = app.requests + 1
end
local function invoke(name)
    if not active() then return end
    local remote = service:FindFirstChild(name)
    assert(remote and remote.ClassName == "RemoteFunction", name .. " is unavailable")
    app.requests = app.requests + 1
    return remote:InvokeServer()
end
local function moveCharacter(root, position, face)
    face = face or (position + root.CFrame.LookVector)
    if (face-position).Magnitude < 0.001 then face = position + root.CFrame.LookVector end
    root.CFrame = CFrame.lookAt(position, face)
    app.moves = app.moves + 1
end
local function restoreChestPause()
    if options.chests or chest.pending or not app.running then return end
    for _, key in ipairs({ "swing", "rebirth" }) do
        local previous = chest[key]
        if previous ~= nil then
            options[key] = previous
            if toggles[key] then toggles[key]:SetValue(previous, true) end
            chest[key] = nil
        end
    end
end
local function setChests(enabled, once)
    if enabled and options.halloween ~= "Off" then
        if toggles.chests then toggles.chests:SetValue(false, true) end
        say("Turn Halloween auto off before opening chests")
        return
    end
    if enabled and not options.chests then
        for _, key in ipairs({ "swing", "rebirth" }) do
            if chest[key] == nil then chest[key] = options[key] end
            options[key] = false
            if toggles[key] then toggles[key]:SetValue(false, true) end
        end
    end
    options.chests = enabled
    chest.once = enabled and once == true
    if toggles.chests then toggles.chests:SetValue(enabled, true) end
    chest.status = enabled and "Waiting for owned chest counts" or "Off"
    restoreChestPause()
end
local function disable(key, err)
    if key == "chests" then setChests(false) end
    options[key] = false
    if toggles[key] then toggles[key]:SetValue(false, true) end
    if key == "walk" then releaseWalk() end
    say(key .. " stopped: " .. tostring(err))
end
local function attempt(key, fn)
    local ok, err = pcall(fn)
    if not ok and app.running then disable(key, err) end
end
local function request(key, name)
    if busy[key] or not active() then return end
    busy[key] = true
    task.spawn(function()
        -- Recheck after scheduling, so stop/unload cannot start a queued call.
        if active() and options[key] then
            local ok, result = pcall(invoke, name)
            if app.running then
                if ok then say(name .. " dispatched; check the game for the result.")
                else disable(key, result) end
            end
        end
        busy[key] = nil
    end)
end
local function clearGhostAttack()
    local attack = halloween.attack
    halloween.attack, halloween.follow, halloween.followAt = nil, nil, 0
    if attack and attack.started then pcall(event, service, "WeaponAnimComplete") end
end
local function stopFeatures()
    clearGhostAttack()
    chest.swing, chest.rebirth, chest.once = nil, nil, false
    for key, value in pairs(options) do
        if type(value) == "boolean" then
            options[key] = false
            if toggles[key] then toggles[key]:SetValue(false, true) end
        end
    end
    target, pendingRebirth, pendingOrb = nil, nil, nil
    orbStatus = "Off"
    options.halloween = "Off"
    halloween.saved, halloween.attack, halloween.house = nil, nil, nil
    halloween.status = "Off"
    if halloween.control then halloween.control:SetValue("Off", true) end
    releaseWalk()
end

local function setHalloween(mode)
    if mode ~= "Off" and mode ~= "Ghost souls" and mode ~= "Trick-or-treat" then return end
    if mode ~= "Off" and (options.chests or chest.pending) then
        say("Finish chest opening before starting Halloween auto")
        if halloween.control then halloween.control:SetValue(options.halloween, true) end
        return
    end
    clearGhostAttack()
    halloween.house = nil
    if mode ~= options.halloween then
        halloween.ghostTarget = nil
        halloween.souls = { gained = 0, attempts = 0, missed = 0 }
    end
    if options.halloween == "Off" and mode ~= "Off" then
        halloween.saved = {}
        for _, key in ipairs({ "collect", "walk", "rebirth" }) do
            halloween.saved[key] = options[key]
            options[key] = false
            if toggles[key] then toggles[key]:SetValue(false, true) end
        end
        target, pendingOrb = nil, nil
        releaseWalk()
    end
    options.halloween = mode
    halloween.status = mode == "Off" and "Off" or "Looking for nearby Halloween targets"
    if halloween.control then halloween.control:SetValue(mode, true) end
    if mode == "Off" and halloween.saved then
        for key, value in pairs(halloween.saved) do
            options[key] = value
            if toggles[key] then toggles[key]:SetValue(value, true) end
        end
        halloween.saved = nil
    end
end

local function child(object, name)
    return object and object:FindFirstChild(name)
end
local function chestCount(kind)
    local grid = child(player, "PlayerGui")
    for _, name in ipairs({ "InventoryGui", "Frame", "shift", "board", "parch", "content", "grid" }) do
        grid = child(grid, name)
    end
    if not grid then return nil end
    -- React creates multiple siblings called "1". A full dotted path is not unique.
    for _, row in ipairs(grid:GetChildren()) do
        local card = child(row, "chest_" .. chestKinds[kind][2])
        local label = child(child(card, "count"), "label")
        if label and label.ClassName == "TextLabel" then
            local text = label.Text
            local count = type(text) == "string" and tonumber(string.match(text, "^x(%d+)$"))
            if count and count >= 0 and count <= 10000000 then return count end
        end
    end
end
local function chestStop(reason)
    setChests(false)
    chest.status = reason
    say(reason)
end
local function openChests(now)
    if not options.chests and not chest.pending then return end
    local reveal = child(child(player, "PlayerGui"), "ChestRevealGui")
    if reveal and #reveal:GetChildren() > 0 and options.chests then
        chestStop("Chest opening stopped: close the game's reveal/Auto first")
    end
    local pending = chest.pending
    local kind = pending and pending.kind or options.chestKind
    local count = chestCount(kind)
    if pending then
        if count == pending.before - pending.batch then
            chest.confirmed = chest.confirmed + pending.batch
            chest.pending = nil
            if chest.once then setChests(false) end
            chest.status = "Confirmed " .. pending.batch .. " opened; " .. count .. " left"
            restoreChestPause()
        elseif count and count ~= pending.before then
            chest.pending = nil
            chestStop("Chest count changed unexpectedly; stopped without another batch")
        elseif now - pending.sentAt >= 4 then
            chest.pending = nil
            chestStop("No chest-count confirmation after 4s; stopped without retrying")
        end
        return
    end
    if not options.chests then restoreChestPause() return end
    if not count then chestStop("Open the game's Chests inventory tab, then try again") return end
    if count == 0 then chestStop("No owned " .. chestKinds[kind][1] .. " chests left") return end
    if not actor() then chestStop("Chest opening stopped: character is not ready") return end
    if now < chest.nextAt then return end
    local batch = math.min(options.chestBatch, count)
    chest.pending = { kind = kind, before = count, batch = batch, sentAt = now }
    chest.nextAt = now + 1
    chest.status = "Waiting for confirmation of " .. batch .. " chests"
    -- Current ZapClient.OpenChests: opcode, request ID, explicit crate flags, count.
    -- Native chest Auto must stay off: this VM cannot join its RPC callback table.
    event(zap, "ZAP_RELIABLE", buffer.fromstring(string.char(23, 240, chestKinds[kind][3], batch)), {})
end
function app.Stop()
    if not app.running then return end
    app.running = false
    stopFeatures()
    if inputConnection then inputConnection:Disconnect() end
    if ui and ui.Alive and destroyUI then destroyUI(ui) end
    if _G.GiantRebornMatcha == app then _G.GiantRebornMatcha = nil end
    print("[Giant Reborn] Unloaded. An already dispatched server request cannot be cancelled.")
end

local function soulCount()
    local label = child(child(child(child(player, "PlayerGui"), "SoulLanternGui"), "Frame"), "body")
    label = child(label, "count")
    local text = label and label.Text
    local digits = type(text) == "string" and string.match(text, "^([%d,]+)")
    return digits and tonumber((string.gsub(digits, ",", "")))
end
local function pumpkinText()
    local object = child(player, "PlayerGui")
    for _, name in ipairs({ "HudStatusGui", "Frame", "column", "pumpkins", "bar", "amount" }) do
        object = child(object, name)
    end
    return object and object.Text or "?"
end
local function ghostVisible(ghost)
    if not ghost or not ghost.hitbox.Parent then return false end
    local fade = ghost.body and ghost.body.Transparency
    return type(fade) ~= "number" or fade < 0.95
end
local function ghostStatus(name, now)
    local stats = halloween.souls
    if not stats then stats = { gained = 0, attempts = 0, missed = 0 } halloween.souls = stats end
    if now >= (stats.readAt or 0) then
        stats.readAt = now + 0.25
        local current = soulCount()
        if current then
            if stats.last and current > stats.last then stats.gained = stats.gained + current - stats.last end
            stats.last = current
            stats.startedAt = stats.startedAt or now
        end
    end
    local elapsed = stats.startedAt and (now-stats.startedAt) or 0
    local rate = elapsed >= 5 and (math.floor(stats.gained*60/elapsed) .. "/min") or "measuring"
    local source = options.ghostAttack == "Native auto" and " | Native swings"
        or (" | Attempts " .. stats.attempts .. " | Range skips " .. stats.missed)
    halloween.status = name .. " | Souls " .. tostring(stats.last or "?") .. " | +" .. stats.gained
        .. " observed | " .. rate .. source
end
local function faceGhost(root, point)
    local position = point + Vector3.new(0, 1.5, 2.5)
    moveCharacter(root, position, Vector3.new(point.X, position.Y, point.Z))
end
local function aimGhost(root, attack, now, lead)
    -- Track motion comes from CFrame animation, not native Velocity.
    local point = attack.hitbox.Position
    local elapsed = now - attack.sampleAt
    local speed = elapsed > 0 and math.min(20, (point-attack.samplePosition).Magnitude/elapsed) or 0
    faceGhost(root, point + attack.hitbox.CFrame.LookVector * (speed*lead))
    attack.samplePosition, attack.sampleAt = point, now
end
local function chooseGhost(root)
    local selected = halloween.ghostTarget
    if not ghostVisible(selected) or (selected.hitbox.Position-root.Position).Magnitude >= 500 then
        selected = nil
        local best = 500
        for _, ghost in ipairs(halloween.ghosts) do
            if ghostVisible(ghost) then
                local distance = (ghost.hitbox.Position-root.Position).Magnitude
                if distance < best then best, selected = distance, ghost end
            end
        end
    end
    halloween.ghostTarget = selected
    if not selected then halloween.status = "Go to the Halloween graveyard; no visible ghosts within 500 studs" end
    return selected
end
local function halloweenStep(now)
    local root = actor()
    if not root then
        clearGhostAttack()
        halloween.house = nil
        halloween.status = "Waiting for character"
        return
    end
    if now >= halloween.scanAt then
        halloween.scanAt = now + 3
        halloween.ghosts, halloween.houses = {}, {}
        local ghosts = child(child(workspace, "NPC"), "Ghosts")
        if ghosts then
            for _, model in ipairs(ghosts:GetChildren()) do
                local hitbox, body = child(model, "Hitbox"), child(model, "Body")
                if model.ClassName == "Model" and hitbox then
                    halloween.ghosts[#halloween.ghosts+1] = { hitbox = hitbox, body = body, name = model.Name }
                end
            end
        end
        local houses = child(child(child(workspace, "Scene"), "HalloweenZone"), "Houses")
        if houses then
            for _, model in ipairs(houses:GetChildren()) do
                local door = child(model, "Door")
                local prompt = child(door, "ProximityPrompt")
                if door and prompt and prompt.ClassName == "ProximityPrompt" then
                    halloween.houses[#halloween.houses+1] = { door = door, prompt = prompt }
                end
            end
        end
    end
    if options.halloween == "Ghost souls" then
        if options.ghostAttack == "Native auto" then
            if now < (halloween.followAt or 0) then return end
            local selected = chooseGhost(root)
            if not selected then halloween.follow = nil return end
            local follow = halloween.follow
            if not follow or follow.rootAddress ~= root.Address or follow.hitboxAddress ~= selected.hitbox.Address then
                follow = { hitbox = selected.hitbox, hitboxAddress = selected.hitbox.Address,
                    rootAddress = root.Address, samplePosition = selected.hitbox.Position, sampleAt = now }
            end
            aimGhost(root, follow, now, 0.2)
            halloween.follow, halloween.followAt = follow, now + 0.2
            ghostStatus(selected.name, now)
            return
        end
        local attack = halloween.attack
        if attack then
            ghostStatus(attack.ghost.name, now)
            if attack.rootAddress ~= root.Address then halloween.attack, halloween.ghostTarget = nil, nil return end
            if not ghostVisible(attack.ghost) then
                if attack.started then event(service, "WeaponAnimComplete") end
                halloween.attack, halloween.ghostTarget = nil, nil
                halloween.nextAt = now
                return
            end
            if not attack.started and now >= attack.startAt then
                aimGhost(root, attack, now, 0.2)
                event(service, "WeaponAttackStart")
                attack.started = true
                -- Base each phase on the actual previous dispatch; a delayed worker
                -- must never compress start, hit and completion into one tick.
                attack.hitAt = now + 0.2
                return
            end
            if attack.started and not attack.reported and now >= attack.hitAt then
                if not attack.aimedAt or now-attack.aimedAt > 0.3 then
                    if (attack.hitbox.Position-root.Position).Magnitude >= 500 then
                        halloween.souls.missed = halloween.souls.missed + 1
                        event(service, "WeaponAnimComplete")
                        halloween.attack, halloween.ghostTarget = nil, nil
                        halloween.nextAt = now + 0.25
                        return
                    end
                    -- Refresh the chase immediately before reporting a hit, then
                    -- allow position replication. Re-aim after a scheduler stall.
                    aimGhost(root, attack, now, 0.15)
                    attack.aimedAt, attack.hitAt = now, now + 0.15
                    return
                end
                if (attack.hitbox.Position-root.Position).Magnitude <= 10 then
                    event(service, "MeleeHit", attack.hitbox)
                    halloween.souls.attempts = halloween.souls.attempts + 1
                else
                    halloween.souls.missed = halloween.souls.missed + 1
                end
                attack.reported = true
                attack.endAt = now + 0.2
                return
            end
            if attack.reported and now >= attack.endAt then
                event(service, "WeaponAnimComplete")
                halloween.attack = nil
                halloween.nextAt = math.max(halloween.nextAt, now + 0.1)
            end
            return
        end
        if now < halloween.nextAt then return end
        local selected = chooseGhost(root)
        if not selected then return end
        local point = selected.hitbox.Position
        faceGhost(root, point)
        halloween.attack = { ghost = selected, hitbox = selected.hitbox, rootAddress = root.Address,
            samplePosition = point, sampleAt = now, startAt = now + 0.15 }
        halloween.nextAt = now + 0.8
        ghostStatus(selected.name, now)
    else
        local arriving = halloween.house
        if arriving then
            if now < arriving.readyAt then return end
            if not arriving.door.Parent or (arriving.door.Position-root.Position).Magnitude > 18 then
                if arriving.door.Parent and not arriving.alternateTried then
                    local alternate = arriving.door.Position - arriving.door.CFrame.LookVector * 8 + Vector3.new(0, 3, 0)
                    moveCharacter(root, alternate)
                    arriving.alternateTried = true
                    arriving.readyAt = now + 0.5
                    halloween.status = "Trying the other side of the house door"
                    return
                end
                halloween.houseCooldown[arriving.door.Address] = now + 30
                halloween.house = nil
                halloween.nextAt = now + 0.5
                halloween.status = "Blocked house skipped; continuing the cycle"
                return
            end
            assert(type(fireproximityprompt) == "function", "Hybrid proximity prompts are unavailable")
            fireproximityprompt(arriving.prompt)
            app.requests = app.requests + 1
            halloween.houseCooldown[arriving.door.Address] = now + 10.1
            halloween.nextAt = now + 2.1
            halloween.house = nil
            halloween.status = "House knocked | Pumpkins " .. tostring(pumpkinText())
            return
        end
        if now < halloween.nextAt then return end
        local selected, best = nil, 500
        for _, house in ipairs(halloween.houses) do
            if house.door.Parent and now >= (halloween.houseCooldown[house.door.Address] or 0) then
                local distance = (house.door.Position-root.Position).Magnitude
                if distance < best then best, selected = distance, house end
            end
        end
        if not selected then halloween.status = "No ready houses within 500 studs; waiting or go to Halloween houses" return end
        local point = selected.door.Position + selected.door.CFrame.LookVector * 8 + Vector3.new(0, 3, 0)
        moveCharacter(root, point)
        halloween.house = { door = selected.door, prompt = selected.prompt, readyAt = now + 0.5 }
        halloween.status = "Approaching next ready house | Pumpkins " .. tostring(pumpkinText())
    end
end
local function runHalloween(now)
    local success, problem = pcall(function() halloweenStep(now) end)
    if not success then setHalloween("Off") say("Halloween auto stopped: " .. tostring(problem)) end
end

local function orbContacts(root)
    local char = player.Character
    local contacts = {}
    for _, name in ipairs({ "LeftFoot", "RightFoot", "Left Leg", "Right Leg" }) do
        local part = char and char:FindFirstChild(name)
        if part then contacts[#contacts+1] = { part = part, position = part.Position, size = part.Size } end
    end
    if #contacts == 0 then contacts[1] = { part = root, position = root.Position, size = root.Size } end
    return contacts
end
local function orbDistance(node, contacts)
    local p, size = node.Position, node.Size
    if not p then return math.huge end
    local best, closest = math.huge, nil
    for _, contact in ipairs(contacts) do
        local q, s = contact.position, contact.size
        if q then
            local x = math.max(0, math.abs(p.X-q.X) - ((size and size.X or 0)+(s and s.X or 0))/2)
            local y = math.max(0, math.abs(p.Y-q.Y) - ((size and size.Y or 0)+(s and s.Y or 0))/2)
            local z = math.max(0, math.abs(p.Z-q.Z) - ((size and size.Z or 0)+(s and s.Z or 0))/2)
            local distance = math.sqrt(x*x+y*y+z*z)
            if distance < best then best, closest = distance, contact.part end
        end
    end
    return best, closest
end
local function farm(now)
    if not options.collect and not options.walk then orbStatus = "Off" releaseWalk() return end
    local root = actor()
    if not root then target, pendingOrb = nil, nil walkOwned = false orbStatus = "Waiting for character" return end
    if pendingOrb then
        local nodeType = pendingOrb.node:FindFirstChild("NodeType")
        if nodeType and nodeType.Value == 0 then
            app.pickups = app.pickups + 1
            orbStatus = "Pickup confirmed"
            pendingOrb = nil
        elseif now >= pendingOrb.untilTime then
            orbStatus = "Touch not confirmed; walk closer to the orb"
            pendingOrb = nil
        end
        return
    end
    local contacts = orbContacts(root)
    if now >= scanAt then
        local scene = workspace:FindFirstChild("Scene")
        local folder = scene and scene:FindFirstChild("ResourceNodes1")
        nodes = folder and folder:GetChildren() or {}
        scanAt = now + 3
        for address, untilTime in pairs(nodeCooldown) do
            if untilTime <= now then nodeCooldown[address] = nil end
        end
    end
    if not target or now >= targetAt then
        target = nil
        local best, nearest = 250, math.huge
        local kind = ({ XP = 1, Gold = 2, Speed = 3, Pumpkin = 5 })[options.orbType]
        for _, node in ipairs(nodes) do
            if node.ClassName == "Part" then
                local nodeType = node:FindFirstChild("NodeType")
                local value = nodeType and nodeType.Value
                if type(value) == "number" and value > 0 and (not kind or value == kind)
                    and (nodeCooldown[node.Address] or 0) <= now then
                    local distance = orbDistance(node, contacts)
                    nearest = math.min(nearest, distance)
                    if distance < best then best, target = distance, node end
                end
            end
        end
        targetAt = now + 4
        if not target then
            orbStatus = nearest < math.huge and ("No selected orbs within 250 studs; nearest " .. math.floor(nearest) .. " studs")
                or "No active orbs match the selected type"
        end
    end
    if not target then releaseWalk() return end
    local nodeType = target:FindFirstChild("NodeType")
    if not target.Parent or not nodeType or nodeType.Value <= 0 then target = nil return end
    local pos = target.Position
    local distance, contact = orbDistance(target, contacts)
    if distance > 250 then target = nil releaseWalk() return end
    if options.collect and distance <= 12 then
        assert(type(firetouchinterest) == "function", "Hybrid firetouchinterest is required")
        local node = target
        local ok, err = pcall(function() firetouchinterest(contact, node, 0) end)
        -- Always try to release the touch, including after a failed touch call.
        local released, releaseError = pcall(function() firetouchinterest(contact, node, 1) end)
        assert(ok and released, tostring(err or releaseError))
        app.touches = app.touches + 1
        nodeCooldown[node.Address] = now + 2
        pendingOrb = { node = node, untilTime = now + 1.5 }
        orbStatus = "Touch sent; waiting for pickup confirmation"
        target = nil
    elseif options.walk and now >= (deadlines.move or 0) then
        local delta = pos - contact.Position
        local height = contact.Size and contact.Size.Y / 2 or 0
        local destination = root.Position + Vector3.new(delta.X, delta.Y + height, delta.Z)
        moveCharacter(root, destination)
        walkOwned = true
        deadlines.move = now + 1
        orbStatus = "Moved to orb; waiting for pickup confirmation"
        pendingOrb = { node = target, untilTime = now + 1.5 }
        nodeCooldown[target.Address] = now + 2
        target = nil
    elseif not options.walk then
        orbStatus = "Nearest orb " .. math.floor(distance) .. " studs away; enable Move to orbs to approach"
    end
end

local function setupUI()
    local localUI = "giant-reborn-rem-ui.lua"
    local source
    if type(isfile) == "function" and isfile(localUI) then source = readfile(localUI)
    else
        assert(type(httpget) == "function", "Matcha httpget is unavailable")
        source = httpget("https://raw.githubusercontent.com/SxGoldenxS/Giant-Simulator-Reborn-Matcha/main/giant-reborn-rem-ui.lua")
    end
    assert(type(source) == "string" and #source > 1000, "REM UI source could not be loaded")
    loadstring(source)()
    ui = getfenv().Rem
    assert(ui and ui.Alive, "REM UI did not initialize")
    destroyUI = ui.Destroy
    function ui:Destroy() app.Stop() end
    ui:SetTitle("Giant Simulator Reborn")
    ui:SetSubtitle("Matcha / REM UI")
    ui:SetKeybind(0x23)
    labels.status = ui.Home:AddLabel({ Title = "Status", Description = message })
    labels.stats = ui.Home:AddLabel({ Title = "Progress", Description = "Loading..." })
    labels.activity = ui.Home:AddLabel({ Title = "Activity", Description = "No requests sent" })
    ui.Home:AddLabel({ Title = "Controls", Description = "End: menu. Delete: unload. Automation starts off." })
    ui.Home:AddLabel({ Title = "Verification", Description = "Requests sent are not confirmed rewards. Hybrid Mode required." })
    local farmTab = ui:AddTab({ Title = "Farming", Category = "Giant Reborn" })
    local function toggle(tab, key, title, description)
        toggles[key] = tab:AddToggle({ Title = title, Description = description, Default = false,
            Callback = function(value)
                if not active() then return end
                if value and options.halloween ~= "Off" and (key == "collect" or key == "walk" or key == "rebirth") then
                    say("Turn Halloween auto off to restore main farming controls")
                    toggles[key]:SetValue(false, true)
                    return
                end
                if value and (key == "swing" or key == "rebirth") and (options.chests or chest.pending) then
                    say("Finish or stop the pending chest batch before enabling training/rebirth")
                    toggles[key]:SetValue(false, true)
                    return
                end
                options[key] = value
                if key == "walk" and not value then releaseWalk() end
                if key == "collect" or key == "walk" then target, pendingOrb = nil, nil end
            end })
    end
    toggle(farmTab, "swing", "Auto train / swing XP", "Independent XP training. No local swing animation.")
    farmTab:AddSlider({ Title = "Training requests / second", Min = 1, Max = 5, Step = 1, Default = 5,
        Description = "5/s improved XP in short tests; 10/s gave no clear improvement. Anti-cheat safety is unverified.",
        Callback = function(value) options.trainRate = math.max(1, math.min(5, math.floor(tonumber(value) or 5))) end })
    toggle(farmTab, "collect", "Collect nearby orbs", "Collects within 12 studs of your feet, accounting for giant size. Enable Move to orbs to reach farther orbs.")
    toggle(farmTab, "walk", "Move to orbs", "Hops to an orb within 250 studs, at most once per second, then waits for pickup confirmation.")
    farmTab:AddDropdown({ Title = "Orb type", Options = { "All", "XP", "Gold", "Speed", "Pumpkin" }, Default = "All",
        Callback = function(value) options.orbType = value target = nil end })
    labels.orbs = farmTab:AddLabel({ Title = "Orb status", Description = orbStatus })
    local progress = ui:AddTab({ Title = "Progression", Category = "Giant Reborn" })
    toggle(progress, "rebirth", "Auto rebirth", "Resets progress at the selected level. Starts off.")
    progress:AddSlider({ Title = "Rebirth level", Min = 100, Max = 10000, Step = 100, Default = 100,
        Callback = function(value) options.rebirthLevel = value end })
    toggle(progress, "daily", "Request daily reward", "Attempts once per minute; the server checks eligibility.")
    toggle(progress, "idle", "Reset game idle timer", "Calls the game's idle service every 60s; platform disconnect prevention is unverified.")
    local chestTab = ui:AddTab({ Title = "Chests", Category = "Giant Reborn" })
    chestTab:AddLabel({ Title = "Owned chests only", Description = "Keep the game's Chests tab open and native Auto off. Hub training/rebirth pause while opening. No purchases or sales." })
    local chestNames = {}
    for i, item in ipairs(chestKinds) do chestNames[i] = item[1] end
    chestTab:AddDropdown({ Title = "Chest type", Options = chestNames, Default = chestNames[1], Callback = function(value)
        for i, name in ipairs(chestNames) do if value == name then options.chestKind = i end end
    end })
    chestTab:AddSlider({ Title = "Chests per batch", Min = 1, Max = 3, Step = 1, Default = 3, Callback = function(value)
        options.chestBatch = math.max(1, math.min(3, math.floor(tonumber(value) or 3)))
    end })
    toggles.chests = chestTab:AddToggle({ Title = "Fast open owned chests", Default = false,
        Description = "Skips the reveal. Up to one confirmed batch per second; stops if counts do not confirm.",
        Callback = function(value) if active() then setChests(value) end end })
    chestTab:AddButton({ Title = "Open one batch", ButtonText = "Open", Callback = function()
        if active() and not chest.pending then setChests(true, true) end
    end })
    labels.chests = chestTab:AddLabel({ Title = "Chest status", Description = chest.status })
    local eventTab = ui:AddTab({ Title = "Halloween", Category = "Giant Reborn" })
    eventTab:AddLabel({ Title = "Nearby event farming", Description = "Start in the Halloween area. Uses controlled hops. Auto-train can run alongside it; orb farming and rebirth pause until Off." })
    halloween.control = eventTab:AddDropdown({ Title = "Halloween auto", Options = { "Off", "Ghost souls", "Trick-or-treat" }, Default = "Off", Callback = function(mode)
        if active() then setHalloween(mode) end
    end })
    eventTab:AddDropdown({ Title = "Ghost attack source", Options = { "Native auto", "Scripted" }, Default = "Native auto",
        Description = "Native auto: enable the game's Auto; the hub only follows ghosts. Scripted: turn game Auto off to avoid overlapping swings.",
        Callback = function(value)
            if not active() or (value ~= "Native auto" and value ~= "Scripted") then return end
            if value ~= options.ghostAttack then
                clearGhostAttack()
                halloween.nextAt = 0
                options.ghostAttack = value
            end
        end })
    eventTab:AddLabel({ Title = "House cycling", Description = "Cycles ready houses with over 2s between knocks and over 10s per house. No instant cooldown bypass." })
    labels.halloween = eventTab:AddLabel({ Title = "Halloween status", Description = halloween.status })
    local codesTab = ui:AddTab({ Title = "Codes", Category = "Giant Reborn" })
    codesTab:AddLabel({ Title = "Checked 1 November 2026", Description = "Four currently listed codes. Not redeemed on your account. More > Codes in game." })
    for _, item in ipairs(codes) do
        local code, reward = item[1], item[2]
        codesTab:AddButton({ Title = code, Description = reward, ButtonText = "Copy",
            Callback = function()
                if type(setclipboard) == "function" then setclipboard(code) say("Copied " .. code)
                else say(code .. ": " .. reward) end
            end })
    end
    local controls = ui:AddTab({ Title = "Controls", Category = "Giant Reborn" })
    controls:AddButton({ Title = "Stop all automation", ButtonText = "Stop", Callback = function() stopFeatures() say("All automation off") end })
    controls:AddButton({ Title = "Unload hub", ButtonText = "Unload", Callback = app.Stop })
end

local ok, err = pcall(setupUI)
if not ok then app.Stop() error(err) end
_G.GiantRebornMatcha = app
inputConnection = game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == 0x2E then app.Stop() end
end)

-- Training has its own timer; farming and progression keep their existing 0.25s cadence.
task.spawn(function()
    while active() do
        if options.halloween == "Ghost souls" then runHalloween(tick()) end
        task.wait(options.halloween == "Ghost souls" and 0.1 or 0.25)
    end
end)

task.spawn(function()
    while active() do
        local now = tick()
        if options.swing and now >= (deadlines.swing or 0) then
            deadlines.swing = now + 1 / options.trainRate
            attempt("swing", function()
                if actor() then
                    event(zap, "ZAP_RELIABLE", trainPacket, {})
                end
            end)
        end
        -- No catch-up burst after a scheduler stall.
        local remaining = options.swing and deadlines.swing and (deadlines.swing - tick()) or (1 / options.trainRate)
        task.wait(math.max(0.01, remaining))
    end
end)

task.spawn(function()
    while active() do
        local now = tick()
        if options.collect or options.walk then
            local farmKey = options.collect and "collect" or "walk"
            attempt(farmKey, function() farm(now) end)
        end
        if options.idle and now >= (deadlines.idle or 0) then
            deadlines.idle = now + 60
            attempt("idle", function() event(services:FindFirstChild("IdleService"), "ResetIdleTimer") end)
        end
        if options.daily and now >= (deadlines.daily or 0) then
            deadlines.daily = now + 60
            request("daily", "RequestDailyReward")
        end
        if options.chests or chest.pending then attempt("chests", function() openChests(now) end) end
        if options.halloween == "Trick-or-treat" then runHalloween(now) end
        if now >= (deadlines.status or 0) then
            deadlines.status = now + 1
            attempt("rebirth", function()
                local level, rebirths = stat("Level"), stat("Rebirths")
                if pendingRebirth and rebirths and rebirths > pendingRebirth then
                    pendingRebirth = nil
                    say("Rebirth count increased")
                end
                if options.rebirth and level and rebirths and level >= options.rebirthLevel
                    and now >= (deadlines.rebirth or 0) and not busy.rebirth then
                    pendingRebirth = rebirths
                    deadlines.rebirth = now + 15
                    request("rebirth", "RebirthRequest")
                end
                labels.status:SetDescription(message)
                labels.stats:SetDescription("Level " .. tostring(level or "?") .. " | Rebirths " .. tostring(rebirths or "?"))
                labels.activity:SetDescription(string.format("Requests %d | Touch pairs %d | Walk updates %d", app.requests, app.touches, app.moves))
                labels.chests:SetDescription(chest.status .. " | Confirmed opened " .. chest.confirmed)
                labels.orbs:SetDescription(orbStatus .. " | Confirmed pickups " .. app.pickups)
                labels.halloween:SetDescription(halloween.status)
            end)
        end
        task.wait(0.25)
    end
end)
say("REM UI ready. End: menu. Delete: unload. All automation is off.")
