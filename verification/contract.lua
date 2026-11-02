local originalLoad = load
local vecMeta = {}
local function vec(x, y, z) return setmetatable({ X=x, Y=y, Z=z, Magnitude=math.sqrt(x*x+y*y+z*z) }, vecMeta) end
function vecMeta.__sub(a,b) return vec(a.X-b.X,a.Y-b.Y,a.Z-b.Z) end
function vecMeta.__add(a,b) return vec(a.X+b.X,a.Y+b.Y,a.Z+b.Z) end
function vecMeta.__mul(a,b) if type(a)=='number' then a,b=b,a end return vec(a.X*b,a.Y*b,a.Z*b) end
local function instance(name, class, children)
    local obj = { Name = name, ClassName = class, children = children or {} }
    function obj:FindFirstChild(key) return self.children[key] end
    function obj:GetChildren()
        local out = {}
        for _, v in pairs(self.children) do out[#out+1] = v end
        return out
    end
    for _, child in pairs(obj.children) do child.Parent = obj end
    return obj
end
local function boot(place, native)
    local e, queue, rpc, calls, now = {}, {}, {}, {}, 0
    setmetatable(e, { __index = _G })
    e._G = e
    e.print = function() end
    e.getfenv = function() return e end
    e.tick = function() return now end
    e.buffer = { fromstring = function(value) return value end }
    e.Vector3 = { new = vec }
    e.CFrame = { lookAt = function(position) return { Position=position, LookVector=vec(0,0,-1) } end }
    e.isfile = function() return true end
    e.readfile = function() return string.rep(' ', 1100) end
    local ui = { Alive = true, Tabs = {} }
    function ui:Destroy() self.Alive = false end
    function ui:SetTitle() end
    function ui:SetSubtitle() end
    function ui:SetKeybind(value) self.Keybind = value end
    function ui:AddTab(o)
        local tab = { Title = o.Title, Controls = {} }
        for _, method in ipairs({ 'AddLabel', 'AddToggle', 'AddButton', 'AddDropdown', 'AddSlider' }) do
            tab[method] = function(self, args)
                args.Value = args.Default
                function args:SetValue(value, silent)
                    self.Value = value
                    if not silent and self.Callback then self.Callback(value) end
                end
                function args:SetDescription(value) self.Description = value end
                self.Controls[#self.Controls+1] = args
                return args
            end
        end
        self.Tabs[#self.Tabs+1] = tab
        return tab
    end
    ui.Home = ui:AddTab({ Title = 'Home' })
    e.loadstring = function() return function() e.Rem = ui end end
    e.task = {
        spawn = function(fn) queue[#queue+1] = coroutine.create(fn) end,
        wait = function() coroutine.yield('wait') end,
    }
    local service = instance('GameService', 'Folder')
    local hitTargets={}
    for _, name in ipairs({ 'WeaponAttackStart', 'WeaponAnimComplete', 'ResetIdleTimer', 'MeleeHit' }) do
        service.children[name] = instance(name, 'RemoteEvent')
        service.children[name].FireServer = function(_, target)
            calls[#calls+1] = name
            if name=='MeleeHit' then hitTargets[#hitTargets+1]=target end
        end
    end
    for _, name in ipairs({ 'RebirthRequest', 'RequestDailyReward' }) do
        service.children[name] = instance(name, 'RemoteFunction')
        service.children[name].InvokeServer = function()
            calls[#calls+1] = name
            rpc[#rpc+1] = coroutine.running()
            coroutine.yield('rpc')
            return true
        end
    end
    local level = instance('⚡Level', 'NumberValue') level.Value = 99
    local rebirths = instance('⭕Rebirths', 'NumberValue') rebirths.Value = 0
    local humanoid = instance('Humanoid', 'Humanoid') humanoid.Health = 100
    local root = instance('HumanoidRootPart', 'Part')
    root.Position = vec(0, 0, 0)
    root.Address = 1000
    root._cframe = { Position=root.Position, LookVector=vec(0,0,-1) }
    setmetatable(root, {
        __index = function(self,key) if key=='CFrame' then return self._cframe end end,
        __newindex = function(self,key,value)
            if key=='CFrame' then rawset(self,'_cframe',value) rawset(self,'Position',value.Position)
            else rawset(self,key,value) end
        end,
    })
    local node = instance('ResourceNode', 'Part', { NodeType = instance('NodeType', 'IntValue') })
    node.Address = 123 node.Position = vec(5, 0, 0) node.children.NodeType.Value = 1
    local character = instance('Character', 'Model', { Humanoid = humanoid, HumanoidRootPart = root })
    local player = instance('Player', 'Player', { leaderstats = instance('leaderstats', 'Folder', { level = level, rebirths = rebirths }) })
    player.Character = character
    local chestLabels, rows, chestPackets = {}, {}, {}
    for i, key in ipairs({ 't1_wpn_crate', 't2_wpn_crate', 't3_wpn_crate', 't1_skin_crate', 't2_skin_crate', 't3_skin_crate' }) do
        local label = instance('label', 'TextLabel') label.Text = 'x9'
        chestLabels[key] = label
        rows['row' .. i] = instance('1', 'Frame', { ['chest_' .. key] = instance('chest_' .. key, 'Frame', {
            count = instance('count', 'Frame', { label = label })
        }) })
    end
    local inventory = instance('grid', 'Frame', rows)
    for _, name in ipairs({ 'content', 'parch', 'board', 'shift', 'Frame', 'InventoryGui' }) do
        inventory = instance(name, 'Frame', { [inventory.Name] = inventory })
    end
    local reveal = instance('ChestRevealGui', 'ScreenGui')
    local playerGui = instance('PlayerGui', 'PlayerGui', { InventoryGui = inventory, ChestRevealGui = reveal })
    local soulLabel=instance('count','TextLabel') soulLabel.Text='100 / 15,000 · Wisp Hatchet'
    playerGui.children.SoulLanternGui=instance('SoulLanternGui','ScreenGui',{
        Frame=instance('Frame','Frame',{body=instance('body','Frame',{count=soulLabel})})
    })
    player.children.PlayerGui = playerGui
    local data = {
        Players = { LocalPlayer = player },
        ReplicatedStorage = instance('ReplicatedStorage', 'Folder', {
            ZAP = instance('ZAP', 'Folder', { ZAP_RELIABLE = {
                Name = 'ZAP_RELIABLE', ClassName = 'RemoteEvent', FireServer = function(_, payload, instances)
                    assert(type(instances) == 'table' and next(instances) == nil)
                    if payload == string.char(12) then calls[#calls+1] = 'TrainClick'
                    else
                        assert(#payload == 4 and payload:byte(1) == 23 and payload:byte(2) == 240)
                        assert(payload:byte(4) >= 1 and payload:byte(4) <= 3)
                        chestPackets[#chestPackets+1] = payload
                        calls[#calls+1] = 'OpenChests'
                    end
                end,
            } }),
            Aero = instance('Aero', 'Folder', { AeroRemoteServices = instance('AeroRemoteServices', 'Folder', {
                GameService = service, IdleService = service,
            }) }),
        }),
        UserInputService = { InputBegan = { Connect = function(_, fn)
            e.inputHandler = fn
            return { Disconnect = function() e.disconnected = true end }
        end } },
    }
    e.game = { PlaceId = place or 12645083079, JobId = 'job1', GetService = function(_, name) return data[name] end }
    local ghostHitbox=instance('Hitbox','Part') ghostHitbox.Position=vec(20,0,0)
    ghostHitbox.Address=3000
    ghostHitbox.CFrame={LookVector=vec(1,0,0)}
    local ghostBody=instance('Body','Part') ghostBody.Transparency=0
    local doors, houseModels, knocks = {}, {}, {}
    for i=1,2 do
        local prompt=instance('ProximityPrompt','ProximityPrompt')
        local door=instance('Door','Part',{ProximityPrompt=prompt})
        door.Address=2000+i door.Position=vec(i*30,0,0)
        door.CFrame={Position=door.Position,LookVector=vec(0,0,-1)}
        doors[i]=door houseModels[i]=instance('House','Model',{Door=door})
    end
    e.fireproximityprompt=function(prompt) knocks[#knocks+1]={prompt=prompt,time=now} end
    e.workspace = instance('Workspace', 'Workspace', {
        NPC=instance('NPC','Folder',{Ghosts=instance('Ghosts','Folder',{
            Ghost1=instance('Ghost1','Model',{Hitbox=ghostHitbox,Body=ghostBody})
        })}),
        Scene = instance('Scene', 'Folder', {
            ResourceNodes1 = instance('ResourceNodes1', 'Folder', { node = node }),
            HalloweenZone=instance('HalloweenZone','Folder',{Houses=instance('Houses','Folder',houseModels)})
        }),
    })
    local touches = {}
    e.firetouchinterest = function(_, _, state)
        touches[#touches+1] = state
        if state == 0 and e.failTouch then error('touch unavailable') end
    end
    assert(originalLoad(PORT_SOURCE, '@port', 't', e))()
    -- Preserve the scripted-attack fixtures; native fixtures test the real UI default.
    if not native then for _,tab in ipairs(ui.Tabs) do for _,c in ipairs(tab.Controls) do
        if c.Title=='Ghost attack source' then c:SetValue('Scripted') end
    end end end
    local t = { e = e, ui = ui, calls = calls, level = level, rebirths = rebirths, rpc = rpc,
        node = node, root = root, hum = humanoid, touches = touches,
        chestLabels = chestLabels, chestPackets = chestPackets, reveal = reveal, playerGui = playerGui }
    t.character = character
    t.doors,t.knocks,t.ghostHitbox,t.ghostBody=doors,knocks,ghostHitbox,ghostBody
    t.hitTargets,t.soulLabel=hitTargets,soulLabel
    function t:step(time)
        now = time
        local todo = queue queue = {}
        for _, co in ipairs(todo) do
            if coroutine.status(co) ~= 'dead' then
                local ok, why = coroutine.resume(co)
                assert(ok, why)
                if why == 'wait' then queue[#queue+1] = co end
            end
        end
    end
    function t:toggle(title, value)
        for _, tab in ipairs(ui.Tabs) do
            for _, control in ipairs(tab.Controls) do
                if control.Title == title then control:SetValue(value) return end
            end
        end
        error('Unknown control ' .. title)
    end
    function t:button(title)
        for _, tab in ipairs(ui.Tabs) do
            for _, control in ipairs(tab.Controls) do
                if control.Title == title then control.Callback() return end
            end
        end
        error('Unknown button ' .. title)
    end
    return t
end
local t = boot(1)
assert(t.e.GiantRebornMatcha == nil)
print('PASS wrong place exits before initialization')
t = boot()
t:step(0) t:step(100)
assert(#t.calls == 0 and t.ui.Alive)
print('PASS startup performs no gameplay requests')
t:toggle('Auto train / swing XP', true)
t:step(101) t:step(101.1) t:step(101.2)
assert(#t.calls == 2 and t.calls[1] == 'TrainClick' and t.calls[2] == 'TrainClick')
print('PASS training uses verified ZAP payload and a 0.2s minimum interval')
t.e.GiantRebornMatcha.Stop()
t:step(200)
assert(#t.calls == 2 and not t.ui.Alive and t.e.disconnected and t.e.GiantRebornMatcha == nil)
print('PASS unload removes UI, disconnects input and halts dispatch')
t = boot()
t:toggle('Request daily reward', true) t:step(0)
t:button('Stop all automation') t:step(1)
assert(#t.calls == 0)
print('PASS stopping before a queued RPC starts cancels dispatch')
t = boot()
t:toggle('Request daily reward', true) t:step(0) t:step(1) t:step(61) t:step(62)
assert(#t.calls == 1 and #t.rpc == 1)
t.e.GiantRebornMatcha.Stop()
assert(coroutine.resume(t.rpc[1]))
t:step(200)
assert(#t.calls == 1)
print('PASS slow RPC cannot overlap or restart work after unload')
t = boot()
t:toggle('Auto rebirth', true) t:step(0) t:step(1)
assert(#t.calls == 0)
t.level.Value = 100 t:step(2) t:step(3)
assert(#t.calls == 1 and t.calls[1] == 'RebirthRequest')
assert(coroutine.resume(t.rpc[1]))
t:step(4) t:step(5)
assert(#t.calls == 1)
print('PASS rebirth observes level 100 minimum and retry cooldown')
t = boot()
t:toggle('Auto train / swing XP', true)
t.e.game.JobId = 'job2' t:step(0)
assert(#t.calls == 0 and not t.ui.Alive)
print('PASS server change stops old session before dispatch')
t = boot()
t:toggle('Collect nearby orbs', true) t:step(0) t:step(0.25) t:step(1)
assert(#t.touches == 2 and t.touches[1] == 0 and t.touches[2] == 1)
print('PASS collection pairs touch/release and respects node cooldown')
t = boot() t.e.failTouch = true
t:toggle('Collect nearby orbs', true) t:step(0) t:step(1)
assert(#t.touches == 2 and t.touches[2] == 1)
print('PASS touch failure still attempts release and disables collection')
t = boot() t.node.Position = vec(50, 0, 0)
t:toggle('Move to orbs', true) t:step(0)
assert(t.root.Position.X == t.node.Position.X)
local stoppedAt = t.root.Position
t.e.GiantRebornMatcha.Stop()
assert(t.root.Position == stoppedAt)
print('PASS controlled movement reaches nearby node and unload prevents further movement')
t = boot() t.node.Position = vec(300, 0, 0)
t:toggle('Move to orbs', true) t:step(0)
assert(t.root.Position.X == 0 and t.e.GiantRebornMatcha.moves == 0)
print('PASS movement ignores resource nodes beyond 250 studs')
t = boot()
t:toggle('Auto train / swing XP', true)
t:toggle('Training requests / second', 1)
t:step(0) t:step(0.2) t:step(0.8) t:step(1)
assert(#t.calls == 2)
print('PASS selected slower training rate is respected')
t = boot()
t:toggle('Auto train / swing XP', true)
t:toggle('Training requests / second', 1000)
t:step(0) t:step(0.1) t:step(0.2) t:step(100)
assert(#t.calls == 3)
print('PASS training caps at 5/s and never catches up with a burst after a stall')
t = boot()
t:button('Open one batch') t:step(0) t:step(0.25) t:step(0.5)
assert(#t.chestPackets == 1 and t.chestPackets[1] == string.char(23,240,3,3))
t.chestLabels.t1_wpn_crate.Text = 'x6' t:step(0.75) t:step(1) t:step(2)
assert(#t.chestPackets == 1)
print('PASS one-batch opener uses exact packet and waits for inventory confirmation')
t = boot()
t:toggle('Fast open owned chests', true) t:step(0)
t.chestLabels.t1_wpn_crate.Text = 'x6' t:step(0.25) t:step(0.5)
assert(#t.chestPackets == 1)
t:step(1)
assert(#t.chestPackets == 2)
t:toggle('Fast open owned chests', false) t:step(1.25)
t.chestLabels.t1_wpn_crate.Text = 'x3' t:step(1.5) t:step(2)
assert(#t.chestPackets == 2)
print('PASS auto opener rate limit and cancelling a pending batch prevent later dispatch')
t = boot()
t:toggle('Fast open owned chests', true) t:step(0) t:step(1) t:step(4) t:step(8)
assert(#t.chestPackets == 1)
print('PASS unconfirmed/refused chest batch times out without retrying')
t = boot()
t:toggle('Fast open owned chests', true) t:step(0)
t.chestLabels.t1_wpn_crate.Text = 'x8' t:step(0.25) t:step(2)
assert(#t.chestPackets == 1)
print('PASS unexpected count changes stop further opening')
t = boot() t.reveal.children.Frame = instance('Frame','Frame')
t:toggle('Fast open owned chests', true) t:step(0)
assert(#t.chestPackets == 0)
print('PASS native reveal blocks scripted chest opening')
t = boot() t.playerGui.children.InventoryGui = nil
t:toggle('Fast open owned chests', true) t:step(0) t:step(10)
assert(#t.chestPackets == 0)
print('PASS missing Chests UI fails closed without requests')
t = boot()
t:toggle('Chest type', 'Common skin') t:toggle('Chests per batch', 1000)
t.chestLabels.t1_skin_crate.Text = 'x2'
t:toggle('Fast open owned chests', true) t:step(0)
assert(t.chestPackets[1] == string.char(23,240,17,2))
t.chestLabels.t1_skin_crate.Text = 'x0' t:step(0.25) t:step(1) t:step(5)
assert(#t.chestPackets == 1)
print('PASS selected chest type, final partial batch and empty-inventory stop')
t = boot()
t:toggle('Auto train / swing XP', true) t:toggle('Auto rebirth', true)
t:button('Open one batch') t:step(0) t:step(0.25)
assert(#t.calls == 1 and t.calls[1] == 'OpenChests')
t.chestLabels.t1_wpn_crate.Text = 'x6' t:step(0.5) t:step(1)
assert(t.calls[2] == 'TrainClick')
print('PASS training pauses for chest confirmation and resumes after one batch')
t = boot()
t:toggle('Auto train / swing XP', true) t:button('Open one batch') t:step(0)
t:button('Stop all automation') t.chestLabels.t1_wpn_crate.Text = 'x6' t:step(0.25) t:step(2)
assert(#t.calls == 1)
print('PASS stop-all also prevents paused training from restarting')
t = boot() t.chestLabels.t1_wpn_crate.Text = 'x?'
t:toggle('Fast open owned chests', true) t:step(0) t:step(4)
assert(#t.chestPackets == 0)
print('PASS malformed inventory count prevents dispatch')
t = boot()
assert(t.ui.Keybind == 0x23)
t.e.inputHandler({ KeyCode = 0x23 })
assert(t.e.GiantRebornMatcha and t.ui.Alive)
t.e.inputHandler({ KeyCode = 0x2E })
assert(t.e.GiantRebornMatcha == nil and not t.ui.Alive)
print('PASS End is the menu key and only Delete unloads')
t = boot()
t.root.Position = vec(0, 120, 0) t.root.Size = vec(20, 40, 10)
local foot = instance('RightFoot','MeshPart') foot.Position = vec(0, 5, 0) foot.Size = vec(10, 10, 10)
t.character.children.RightFoot = foot
t.node.Position = vec(10, 2, 0) t.node.Size = vec(5, 5, 5)
local touchedPart
t.e.firetouchinterest = function(part) touchedPart = part end
t:toggle('Collect nearby orbs', true) t:step(0)
assert(touchedPart == foot)
t.node.children.NodeType.Value = 0 t:step(0.25)
assert(t.e.GiantRebornMatcha.pickups == 1)
print('PASS giant-sized characters collect using foot bounds and confirm the node transition')
t = boot()
t:toggle('Collect nearby orbs', true) t:step(0) t:step(0.25) t:step(1) t:step(1.5)
assert(t.e.GiantRebornMatcha.pickups == 0 and #t.touches == 2)
print('PASS sending a touch does not count as a confirmed pickup')
t = boot()
t:toggle('Auto rebirth', true)
t:toggle('Halloween auto', 'Ghost souls') t:step(0) t:step(0.1)
assert(#t.calls==0 and t.e.GiantRebornMatcha.moves==1)
t:step(0.2) t:step(0.4) t:step(0.6) t:step(0.8)
assert(#t.calls==3 and t.calls[1]=='WeaponAttackStart' and t.calls[2]=='MeleeHit' and t.calls[3]=='WeaponAnimComplete')
t:toggle('Halloween auto', 'Off') t:toggle('Auto train / swing XP',true) t:step(0.9)
assert(t.calls[4]=='TrainClick')
print('PASS ghost attack windup/report/end sequence without overlapping swings')
t = boot() t.ghostBody.Transparency=1
t:toggle('Halloween auto','Ghost souls') t:step(0)
assert(#t.calls==0 and t.e.GiantRebornMatcha.moves==0)
print('PASS hidden/reforming ghosts are ignored')
t = boot() t.ghostHitbox.Position=vec(600,0,0)
t:toggle('Halloween auto','Ghost souls') t:step(0)
assert(#t.calls==0 and t.e.GiantRebornMatcha.moves==0)
print('PASS Halloween auto stays within the nearby event area')
t = boot()
t:toggle('Halloween auto','Trick-or-treat') t:step(0) t:step(0.25)
assert(#t.knocks==0)
t:step(0.5) t:step(2.5)
assert(#t.knocks==1)
t:step(2.6) t:step(3.2) t:step(5.4)
assert(#t.knocks==2 and t.knocks[1].prompt~=t.knocks[2].prompt)
t:step(10.7) t:step(11.3)
assert(#t.knocks==3 and t.knocks[3].prompt==t.knocks[1].prompt)
assert(t.knocks[2].time-t.knocks[1].time>=2.1 and t.knocks[3].time-t.knocks[1].time>=10.1)
print('PASS house cycling observes replication delay, global cooldown and per-door cooldown')
t = boot()
t:toggle('Halloween auto','Trick-or-treat') t:step(0)
t:toggle('Halloween auto','Off') t:step(0.5) t:step(4)
assert(#t.knocks==0)
print('PASS switching off cancels an untriggered house prompt')
t = boot()
t:toggle('Fast open owned chests',true) t:step(0)
t:toggle('Halloween auto','Ghost souls') t:step(0.5)
assert(#t.calls==1 and t.calls[1]=='OpenChests' and t.e.GiantRebornMatcha.moves==0)
print('PASS Halloween cannot overlap a pending chest operation')
t = boot()
t:toggle('Halloween auto','Ghost souls') t:step(0) t:step(0.2)
t:button('Stop all automation') t:step(3)
assert(#t.calls==2 and t.calls[2]=='WeaponAnimComplete')
print('PASS stop-all closes the active ghost swing and stops farming')
t = boot()
t:toggle('Halloween auto','Ghost souls') t:step(0) t:step(0.2)
t.root.Address=1001 t:step(0.4)
assert(#t.calls==1)
print('PASS character replacement cancels a pending ghost hit')
t = boot()
t:toggle('Halloween auto','Trick-or-treat') t:toggle('Fast open owned chests',true) t:step(0)
assert(#t.chestPackets==0)
for _,tab in ipairs(t.ui.Tabs) do for _,control in ipairs(tab.Controls) do
    if control.Title=='Fast open owned chests' then assert(control.Value==false) end
end end
print('PASS chest opening is visibly rejected while Halloween movement owns the character')
for _,mode in ipairs({'Ghost souls','Trick-or-treat'}) do
    t=boot() t:toggle('Halloween auto',mode) t:toggle('Auto train / swing XP',true) t:step(0)
    assert(t.calls[1]=='TrainClick')
end
print('PASS auto-train remains available alongside both Halloween modes')
t=boot()
t:toggle('Halloween auto','Trick-or-treat') t:step(0)
t.root.Position=vec(-100,0,0) t:step(0.5) t:step(1)
assert(#t.knocks==1 and t.e.GiantRebornMatcha.moves==2)
print('PASS a blocked door approach tries the opposite side once')
t=boot()
t:toggle('Halloween auto','Trick-or-treat') t:step(0)
t.root.Position=vec(-100,0,0) t:step(0.5)
t.root.Position=vec(-100,0,0) t:step(1) t:step(1.5) t:step(2)
assert(#t.knocks==1 and t.knocks[1].prompt==t.doors[2].children.ProximityPrompt)
print('PASS an unreachable house is skipped while the rest of the cycle continues')
t=boot()
t:toggle('Halloween auto','Ghost souls') t:step(0)
t.ghostHitbox.Position=vec(21.6,0,0) t:step(0.2)
assert(t.root.Position.X>21.6 and t.e.GiantRebornMatcha.moves==2)
t.ghostHitbox.Position=vec(23.2,0,0) t:step(0.4)
assert(#t.hitTargets==0 and t.e.GiantRebornMatcha.moves==3 and t.root.Position.X>23.2)
t.ghostHitbox.Position=vec(24.8,0,0) t:step(0.5)
assert(#t.hitTargets==0)
t:step(0.6)
assert(t.hitTargets[1]==t.ghostHitbox)
print('PASS pre-hit tracking leads a moving ghost and waits for position replication')
t=boot()
t:toggle('Halloween auto','Ghost souls') t:step(0) t:step(0.2)
t:step(0.4) t.root.Position=vec(-100,0,0) t:step(0.6) t:step(0.8)
assert(#t.hitTargets==0 and t.calls[#t.calls]=='WeaponAnimComplete')
print('PASS an out-of-reach ghost is not reported as hit, and the swing still closes')
t=boot()
t:toggle('Halloween auto','Ghost souls') t:step(0) t:step(0.2) t:step(0.4) t:step(0.6) t:step(0.8)
local extraHit=instance('Hitbox','Part') extraHit.Position=t.root.Position extraHit.CFrame={LookVector=vec(1,0,0)}
local extraBody=instance('Body','Part') extraBody.Transparency=0
t.e.workspace.children.NPC.children.Ghosts.children.Ghost2=instance('Ghost2','Model',{Hitbox=extraHit,Body=extraBody})
t:step(0.9) t:step(1.1) t:step(1.3) t:step(1.5)
assert(t.hitTargets[1]==t.ghostHitbox and t.hitTargets[2]==t.ghostHitbox)
print('PASS ghost focus persists across swings rather than switching to a closer target')
t=boot()
t:toggle('Halloween auto','Ghost souls') t:step(0)
t.soulLabel.Text='104 / 15,000 · Wisp Hatchet' t:step(0.3) t:step(5)
local status
for _,tab in ipairs(t.ui.Tabs) do for _,c in ipairs(tab.Controls) do if c.Title=='Halloween status' then status=c.Description end end end
assert(string.find(status,'+4 observed',1,true) and string.find(status,'Attempts',1,true))
print('PASS the displayed soul gain comes from the real meter rather than dispatch count')
t=boot()
t:toggle('Halloween auto','Ghost souls') t:step(0) t:step(2)
assert(#t.calls==1 and t.calls[1]=='WeaponAttackStart')
t:step(2.1) assert(#t.calls==1)
t:step(2.3) assert(#t.hitTargets==0)
t:step(2.5) assert(#t.calls==2 and t.calls[2]=='MeleeHit')
t:step(2.6) assert(#t.calls==2)
t:step(2.8) assert(t.calls[3]=='WeaponAnimComplete')
print('PASS scheduler stalls do not collapse attack start, position replication, hit and completion')

t=boot()
t:toggle('Halloween auto','Ghost souls') t:step(0) t:step(0.2) t:step(0.4)
t.ghostHitbox.Position=vec(40,0,0) t:step(1)
assert(#t.hitTargets==0 and t.e.GiantRebornMatcha.moves==4 and t.root.Position.X>=40)
t:step(1.1) assert(#t.hitTargets==0)
t:step(1.2) assert(#t.hitTargets==1)
print('PASS stale pre-hit positioning is refreshed after a delayed worker tick')

t=boot()
t:toggle('Halloween auto','Ghost souls') t:step(0) t:step(0.2) t:step(0.4)
t:button('Stop all automation') t:step(1)
assert(#t.hitTargets==0 and t.calls[#t.calls]=='WeaponAnimComplete' and t.e.GiantRebornMatcha.moves==3)
print('PASS stopping during the final replication wait cancels the hit and further movement')

t=boot()
t:toggle('Halloween auto','Ghost souls') t:step(0) t:step(0.2)
t.ghostHitbox.Position=vec(1000,0,0) t:step(0.4)
assert(#t.hitTargets==0 and t.e.GiantRebornMatcha.moves==2 and t.calls[#t.calls]=='WeaponAnimComplete')
print('PASS final tracking cannot chase a target outside the nearby event area')
t=boot(nil,true)
t:toggle('Halloween auto','Ghost souls') t:step(0) t:step(0.1)
assert(#t.calls==0 and t.e.GiantRebornMatcha.moves==1)
t.ghostHitbox.Position=vec(21.6,0,0) t:step(0.2) t:step(0.3)
assert(#t.calls==0 and t.e.GiantRebornMatcha.moves==2 and t.root.Position.X>21.6)
t:step(0.4) assert(t.e.GiantRebornMatcha.moves==3)
print('PASS native attacks are the default and following predicts motion at most five times per second without combat dispatch')

t=boot(nil,true)
t:toggle('Halloween auto','Ghost souls') t:step(0)
t:button('Stop all automation') t:step(1)
assert(t.e.GiantRebornMatcha.moves==1 and #t.calls==0)
print('PASS stopping native follow halts movement without changing game-owned swings')

t=boot()
t:toggle('Halloween auto','Ghost souls') t:step(0) t:step(0.2)
t:toggle('Ghost attack source','Native auto') t:step(0.3) t:step(0.6) t:step(1)
assert(#t.calls==2 and t.calls[2]=='WeaponAnimComplete' and #t.hitTargets==0)
print('PASS switching to native auto closes a scripted window and cancels its queued hit')

t=boot(nil,true)
t:toggle('Halloween auto','Ghost souls') t:step(0)
t:toggle('Ghost attack source','Scripted') t:step(0.2) t:step(0.4) t:step(0.6) t:step(0.8) t:step(1) t:step(1.2)
assert(t.calls[1]=='WeaponAttackStart' and #t.hitTargets==1 and t.calls[3]=='WeaponAnimComplete')
print('PASS switching from native following to scripted attacks starts a fresh serialized swing')

t=boot(nil,true)
t:toggle('Halloween auto','Ghost souls') t:step(0)
t.root.Address=1001 t.ghostHitbox.Position=vec(30,0,0) t:step(0.2)
assert(#t.calls==0 and t.root.Position.X==30)
t.ghostBody.Transparency=1 t:step(0.4)
assert(t.e.GiantRebornMatcha.moves==2)
print('PASS native following refreshes character samples and ignores hidden ghosts')

t=boot(nil,true)
t.ghostHitbox.Position=vec(600,0,0)
t:toggle('Halloween auto','Ghost souls') t:step(0)
assert(#t.calls==0 and t.e.GiantRebornMatcha.moves==0)
print('PASS native following retains the nearby event-area movement limit')
print('53 contract checks passed; hub and REM syntax passed')
