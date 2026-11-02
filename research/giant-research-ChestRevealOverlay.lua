-- Decompiled game.ReplicatedStorage.ReactUI.ChestRevealOverlay

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Workspace")
local v_u_3 = require(v1.Packages.react)
local v_u_4 = require(v1.ReactUI.ArenaTheme)
local v_u_5 = require(v1.ReactUI.UIConstants)
local v_u_6 = require(v1.ReactUI.StrokedText)
local v_u_7 = require(v1.ReactUI.EventIcon)
local v_u_8 = require(v1.ReactUI.FishingCandyButton)
local v_u_9 = require(v1.ReactUI.ChestRevealStage)
local v_u_10 = require(v1.ReactUI.useViewportScale)
local v11 = require(v1.ReactUI.ItemTemplate)
local v_u_12 = v_u_5.GetSpring()
local v_u_13 = v_u_3.createElement
local function v_u_30(p14)
    local v15 = p14 == 1 and 0.55 or 0.66
    local v16 = p14 == 1 and 0.62 or 0.58
    local v17 = math.min(p14, 5)
    local v18 = math.max(v17, 1)
    local v19 = p14 / 5
    local v20 = math.ceil(v19)
    local v21 = v15 / v18
    local v22 = v16 / v20
    local v23 = {}
    for v24 = 1, p14 do
        local v25 = (v24 - 1) / v18
        local v26 = math.floor(v25)
        local v27 = (v24 - 1) % v18
        local v28
        if v26 < v20 - 1 then
            v28 = v18
        else
            v28 = p14 - v18 * (v20 - 1)
        end
        local v29 = {
            ["cx"] = 0.5 - v28 * v21 / 2 + (v27 + 0.5) * v21,
            ["cy"] = 0.5 - v16 / 2 + (v26 + 0.5) * v22,
            ["cw"] = v21,
            ["ch"] = v22
        }
        table.insert(v23, v29)
    end
    return v23
end
local v_u_31 = v11.Resolve
local function v_u_58(p_u_32)
    -- upvalues: (copy) v_u_3, (copy) v_u_12, (copy) v_u_13
    local v33 = p_u_32.rect
    local v34, v_u_35 = v_u_3.useState(p_u_32.image or "")
    local v36, v_u_37 = v_u_12.useSpring(function()
        return {}
    end)
    v_u_3.useEffect(function()
        -- upvalues: (copy) p_u_32, (copy) v_u_37, (copy) v_u_35
        local v_u_38 = true
        local v_u_39 = {}
        local v40 = p_u_32.delay or 0
        local function v49()
            -- upvalues: (ref) v_u_38, (ref) v_u_37, (ref) p_u_32, (ref) v_u_35, (copy) v_u_39
            if v_u_38 then
                v_u_37.start({
                    ["config"] = {}
                })
                v_u_37.start({
                    ["config"] = {}
                })
                local function v_u_42(p_u_41)
                    -- upvalues: (ref) v_u_38, (ref) v_u_37, (copy) v_u_42
                    if v_u_38 then
                        v_u_37.start({
                            ["r"] = p_u_41,
                            ["config"] = {}
                        }):andThen(function()
                            -- upvalues: (ref) v_u_38, (ref) v_u_42, (copy) p_u_41
                            if v_u_38 then
                                v_u_42(p_u_41 > 0 and -5 or 5)
                            end
                        end)
                    end
                end
                v_u_42(5)
                local function v46()
                    -- upvalues: (ref) v_u_38, (ref) v_u_37, (ref) p_u_32, (ref) v_u_35, (ref) v_u_39
                    if v_u_38 then
                        v_u_37.start({
                            ["config"] = {}
                        })
                        if p_u_32.openImage and p_u_32.openImage ~= "" then
                            v_u_35(p_u_32.openImage)
                        end
                        local function v43()
                            -- upvalues: (ref) v_u_38, (ref) v_u_37
                            if v_u_38 then
                                v_u_37.start({
                                    ["config"] = {}
                                })
                            end
                        end
                        local v44 = v_u_39
                        local v45 = task.delay
                        table.insert(v44, v45(0.12, v43))
                    end
                end
                local v47 = v_u_39
                local v48 = task.delay
                table.insert(v47, v48(0.6, v46))
            end
        end
        local v50 = task.delay
        table.insert(v_u_39, v50(v40, v49))
        return function()
            -- upvalues: (ref) v_u_38, (copy) v_u_39, (ref) v_u_37
            v_u_38 = false
            for _, v51 in v_u_39 do
                task.cancel(v51)
            end
            v_u_37.stop()
        end
    end, {})
    local v52 = v_u_13
    local v54 = {
        ["AnchorPoint"] = Vector2.new(0.5, 0.5),
        ["Position"] = UDim2.fromScale(v33.cx, v33.cy),
        ["Size"] = UDim2.fromScale(v33.cw * 0.9, v33.ch * 0.62),
        ["Rotation"] = v36.r:map(function(p53)
            return p53
        end)
    }
    local v57 = {
        ["aspect"] = v_u_13("UIAspectRatioConstraint", {}),
        ["scaleC"] = v_u_13("UIScale", {
            ["Scale"] = v36.s:map(function(p55)
                return math.max(p55, 0.001)
            end)
        }),
        ["visual"] = v_u_13("ImageLabel", {
            ["AnchorPoint"] = Vector2.new(0.5, 0.5),
            ["Position"] = UDim2.fromScale(0.5, 0.5),
            ["Size"] = v36.squash:map(function(p56)
                return UDim2.fromScale(1, (math.max(p56, 0.001)))
            end),
            ["Image"] = v34,
            ["ScaleType"] = Enum.ScaleType.Stretch
        })
    }
    return v52("Frame", v54, v57)
end
local function v_u_84(p_u_59)
    -- upvalues: (copy) v_u_12, (copy) v_u_3, (copy) v_u_13, (copy) v_u_4, (copy) v_u_7, (copy) v_u_6
    local v60 = p_u_59.card
    local v61 = p_u_59.rect
    local v62 = p_u_59.big == true
    local v_u_63 = v60.kind ~= "model"
    local v64, v_u_65 = v_u_12.useSpring(function()
        return {}
    end)
    v_u_3.useEffect(function()
        -- upvalues: (copy) p_u_59, (copy) v_u_65
        local v_u_66 = task.delay(p_u_59.delay or 0, function()
            -- upvalues: (ref) v_u_65
            v_u_65.start({
                ["config"] = {}
            })
        end)
        return function()
            -- upvalues: (copy) v_u_66, (ref) v_u_65
            task.cancel(v_u_66)
            v_u_65.stop()
        end
    end, {})
    local v67, v_u_68 = v_u_3.useBinding(0)
    v_u_3.useEffect(function()
        -- upvalues: (copy) v_u_63, (copy) v_u_68
        if v_u_63 then
            local v69 = game:GetService("RunService")
            local v_u_70 = os.clock()
            local v_u_71 = v69.RenderStepped:Connect(function()
                -- upvalues: (ref) v_u_68, (copy) v_u_70
                v_u_68((os.clock() - v_u_70) * 25 % 360)
            end)
            return function()
                -- upvalues: (copy) v_u_71
                v_u_71:Disconnect()
            end
        end
    end, { v_u_63 })
    local v72 = v_u_13
    local v73 = "Frame"
    local v74 = {
        ["AnchorPoint"] = Vector2.new(0.5, 0.5),
        ["Position"] = UDim2.fromScale(v61.cx, v61.cy),
        ["Size"] = UDim2.fromScale(v61.cw, v61.ch)
    }
    local v76 = {
        ["scaleC"] = v_u_13("UIScale", {
            ["Scale"] = v64.s:map(function(p75)
                return math.max(p75, 0.001)
            end)
        })
    }
    local v77
    if v_u_63 then
        v77 = v_u_13("ImageLabel", {
            ["AnchorPoint"] = Vector2.new(0.5, 0.5),
            ["Position"] = UDim2.fromScale(0.5, 0.5),
            ["Size"] = UDim2.fromScale(0.95, 0.95),
            ["Image"] = v_u_4.ASSETS.STARBURST,
            ["ImageColor3"] = v60.color or v_u_4.GOLD,
            ["ScaleType"] = Enum.ScaleType.Fit,
            ["Rotation"] = v67
        }, {
            ["aspect"] = v_u_13("UIAspectRatioConstraint", {})
        }) or nil
    else
        v77 = nil
    end
    v76.burst = v77
    local v78
    if v_u_63 then
        v78 = v_u_13("ImageLabel", {
            ["AnchorPoint"] = Vector2.new(0.5, 0.5),
            ["Position"] = UDim2.fromScale(0.5, 0.5),
            ["Size"] = UDim2.fromScale(0.9, v62 and 0.66 or 0.6),
            ["Image"] = v60.icon or "",
            ["ScaleType"] = Enum.ScaleType.Fit
        }) or nil
    else
        v78 = nil
    end
    v76.art = v78
    local v79
    if v60.rarityText and v60.eventIcon then
        local v80 = v_u_13
        local v81 = {
            ["Size"] = UDim2.fromScale(0.95, 0.12),
            ["Position"] = UDim2.fromScale(0.5, 0.06),
            ["AnchorPoint"] = Vector2.new(0.5, 0.5)
        }
        local v82 = {
            ["layout"] = v_u_13("UIListLayout", {
                ["FillDirection"] = Enum.FillDirection.Horizontal,
                ["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
                ["VerticalAlignment"] = Enum.VerticalAlignment.Center,
                ["Padding"] = UDim.new(0, 6),
                ["SortOrder"] = Enum.SortOrder.LayoutOrder
            }),
            ["icon"] = v_u_13(v_u_7, {
                ["icon"] = v60.eventIcon,
                ["Size"] = UDim2.fromOffset(v62 and 40 or 28, v62 and 40 or 28)
            }),
            ["text"] = v_u_13(v_u_6, {
                ["text"] = string.upper(v60.rarityText),
                ["textColor"] = v60.color or v_u_4.GOLD,
                ["textSize"] = v62 and 34 or 22,
                ["automaticSize"] = Enum.AutomaticSize.X,
                ["strokeColor"] = v_u_4.OUTLINE,
                ["size"] = UDim2.fromScale(0, 1)
            })
        }
        v79 = v80("Frame", v81, v82) or nil
    else
        v79 = nil
    end
    v76.rarityRow = v79
    local v83
    if v60.rarityText and not v60.eventIcon then
        v83 = v_u_13(v_u_6, {
            ["text"] = string.upper(v60.rarityText),
            ["textColor"] = v60.color or v_u_4.GOLD,
            ["textSize"] = v62 and 34 or 22,
            ["strokeColor"] = v_u_4.OUTLINE,
            ["size"] = UDim2.fromScale(0.95, 0.12),
            ["position"] = UDim2.fromScale(0.5, 0.06),
            ["anchorPoint"] = Vector2.new(0.5, 0.5)
        }) or nil
    else
        v83 = nil
    end
    v76.rarity = v83
    v76.name = v_u_13(v_u_6, {
        ["text"] = v60.name or "",
        ["textColor"] = v60.color or v_u_4.WHITE,
        ["textSize"] = v62 and 48 or 38,
        ["strokeColor"] = v_u_4.OUTLINE,
        ["size"] = UDim2.fromScale(0.95, v62 and 0.14 or 0.18),
        ["position"] = UDim2.fromScale(0.5, v62 and 0.94 or 0.92),
        ["anchorPoint"] = Vector2.new(0.5, 0.5)
    })
    return v72(v73, v74, v76)
end
return function(p85)
    -- upvalues: (copy) v_u_10, (copy) v_u_5, (copy) v_u_3, (copy) v_u_2, (copy) v_u_9, (copy) v_u_30, (copy) v_u_31, (copy) v_u_4, (copy) v_u_13, (copy) v_u_58, (copy) v_u_6, (copy) v_u_84, (copy) v_u_8
    local v_u_86 = p85.Context
    local v_u_87 = v_u_86.ChestReveal
    local v_u_88 = v_u_87.sounds
    local v89 = v_u_10(0.7, v_u_5.HYBRID_SPLIT)
    local v91, v_u_92 = v_u_3.useState(function()
        -- upvalues: (ref) v_u_2
        local v90 = v_u_2.CurrentCamera
        if v90 then
            return v90.ViewportSize
        else
            return Vector2.new(1920, 1080)
        end
    end)
    v_u_3.useEffect(function()
        -- upvalues: (ref) v_u_2, (copy) v_u_92
        local v_u_93 = v_u_2.CurrentCamera
        if v_u_93 then
            local function v94()
                -- upvalues: (ref) v_u_92, (copy) v_u_93
                v_u_92(v_u_93.ViewportSize)
            end
            v_u_92(v_u_93.ViewportSize)
            local v_u_95 = v_u_93:GetPropertyChangedSignal("ViewportSize"):Connect(v94)
            return function()
                -- upvalues: (copy) v_u_95
                v_u_95:Disconnect()
            end
        end
    end, {})
    local v96 = v91.X * 0.94 / 1070
    local v97 = v91.Y * 0.15 / 100
    local v_u_98 = math.min(v89, v96, v97)
    local v_u_99, v_u_100 = v_u_3.useState(nil)
    local v_u_101, v_u_102 = v_u_3.useState("burst")
    local v_u_103, v_u_104 = v_u_3.useState(false)
    local v_u_105, v_u_106 = v_u_3.useState(false)
    local v_u_107, v_u_108 = v_u_3.useState(false)
    local v_u_109 = v_u_99 and (v_u_99.timeScale or 1) or 1
    local v_u_110 = v_u_3.useRef(0)
    v_u_3.useEffect(function()
        -- upvalues: (copy) v_u_99, (copy) v_u_110
        if v_u_99 then
            v_u_110.current = os.clock()
        end
    end, { v_u_99 })
    local v_u_111 = v_u_3.useRef(1)
    local v_u_112 = v_u_3.useRef(nil)
    local v_u_114 = v_u_3.useCallback(function()
        -- upvalues: (copy) v_u_100, (copy) v_u_102, (copy) v_u_104, (copy) v_u_106, (copy) v_u_108
        v_u_100(function(p113)
            if p113 and p113.onClosed then
                task.spawn(p113.onClosed)
            end
            return nil
        end)
        v_u_102("burst")
        v_u_104(false)
        v_u_106(false)
        v_u_108(false)
    end, {})
    v_u_3.useEffect(function()
        -- upvalues: (copy) v_u_86, (copy) v_u_100, (copy) v_u_102, (copy) v_u_104, (copy) v_u_106, (copy) v_u_108, (copy) v_u_111, (copy) v_u_114
        local v_u_119 = v_u_86.Commands.ShowChestReveal:Connect(function(p_u_115)
            -- upvalues: (ref) v_u_100, (ref) v_u_102, (ref) v_u_104, (ref) v_u_106, (ref) v_u_108, (ref) v_u_111, (ref) v_u_114
            if p_u_115 then
                v_u_100(function(p116)
                    -- upvalues: (copy) p_u_115
                    if p116 and (p116.onClosed and p116 ~= p_u_115) then
                        task.spawn(p116.onClosed)
                    end
                    return p_u_115
                end)
                v_u_102((p_u_115 == nil or not p_u_115.instant) and "burst" or "cards")
                v_u_104(false)
                v_u_106(false)
                v_u_108(false)
                if p_u_115.buy or p_u_115.remaining ~= nil then
                    local v117 = v_u_111
                    local v118 = #(p_u_115.results or {})
                    v117.current = math.max(v118, 1)
                    return
                end
            else
                v_u_114()
            end
        end)
        return function()
            -- upvalues: (copy) v_u_119
            v_u_119:Disconnect()
        end
    end, { v_u_114 })
    v_u_3.useEffect(function()
        -- upvalues: (copy) v_u_112
        return function()
            -- upvalues: (ref) v_u_112
            if v_u_112.current then
                v_u_112.current:Hide()
            end
        end
    end, {})
    local v_u_120 = v_u_99 ~= nil
    v_u_3.useEffect(function()
        -- upvalues: (copy) v_u_120, (copy) v_u_87
        if v_u_120 then
            v_u_87.setRevealVisible(true)
            return function()
                -- upvalues: (ref) v_u_87
                v_u_87.setRevealVisible(false)
            end
        end
    end, { v_u_120 })
    v_u_3.useEffect(function()
        -- upvalues: (copy) v_u_99, (copy) v_u_112, (copy) v_u_101, (ref) v_u_30, (ref) v_u_31, (copy) v_u_109, (ref) v_u_9, (copy) v_u_88, (copy) v_u_102
        if v_u_99 then
            if v_u_101 == "burst" then
                local v121 = v_u_99.results or {}
                local v122 = v_u_30(#v121)
                local v123 = {}
                for v124, v125 in v121 do
                    if v125.crateModelName then
                        local v126 = v_u_31(v125.crateModelFolder or "Chests", v125.crateModelName, nil)
                        if v126 then
                            local v127 = v122[v124]
                            local v128 = {
                                ["template"] = v126,
                                ["screenX"] = v127.cx,
                                ["screenY"] = v127.cy,
                                ["fillH"] = v127.ch * 0.55,
                                ["delay"] = (v124 - 1) * 0.07 * v_u_109
                            }
                            table.insert(v123, v128)
                        else
                            local v129 = warn
                            local v130 = v125.crateModelName
                            v129("[ChestRevealOverlay] missing chest template: " .. tostring(v130))
                        end
                    end
                end
                if not v_u_112.current then
                    v_u_112.current = v_u_9.new()
                end
                v_u_112.current:Show(v123)
                v_u_88.shake()
                local v_u_131 = task.delay(1.2 * v_u_109, function()
                    -- upvalues: (ref) v_u_102
                    v_u_102("cards")
                end)
                return function()
                    -- upvalues: (copy) v_u_131
                    task.cancel(v_u_131)
                end
            end
        elseif v_u_112.current then
            v_u_112.current:Hide()
        end
    end, { v_u_99, v_u_101 })
    v_u_3.useEffect(function()
        -- upvalues: (copy) v_u_99, (copy) v_u_105, (copy) v_u_101, (copy) v_u_103, (copy) v_u_107, (copy) v_u_106, (copy) v_u_104, (copy) v_u_111, (copy) v_u_87, (copy) v_u_100, (copy) v_u_102
        if v_u_99 and (v_u_105 and (v_u_101 == "cards" and (not v_u_103 and v_u_107))) then
            local v_u_132 = v_u_99.buy
            local v133
            if v_u_132 == nil then
                v133 = v_u_99.remaining ~= nil
            else
                v133 = false
            end
            if v_u_132 or v133 then
                local v_u_136 = task.delay(0.9, function()
                    -- upvalues: (copy) v_u_132, (ref) v_u_99, (ref) v_u_106, (ref) v_u_104, (ref) v_u_111, (ref) v_u_87, (ref) v_u_100, (ref) v_u_102
                    local v134
                    if v_u_132 then
                        v134 = v_u_132.canContinue()
                    else
                        v134 = (v_u_99.remaining or 0) > 0
                    end
                    if v134 then
                        v_u_104(true)
                        task.spawn(function()
                            -- upvalues: (ref) v_u_132, (ref) v_u_111, (ref) v_u_87, (ref) v_u_100, (ref) v_u_102, (ref) v_u_106, (ref) v_u_104
                            local v135
                            if v_u_132 then
                                v135 = v_u_132.more(v_u_111.current)
                            else
                                v135 = v_u_87.openMore(v_u_111.current)
                            end
                            if v135 then
                                v_u_100(v135)
                                v_u_102("burst")
                            else
                                v_u_106(false)
                            end
                            v_u_104(false)
                        end)
                    else
                        v_u_106(false)
                    end
                end)
                return function()
                    -- upvalues: (copy) v_u_136
                    task.cancel(v_u_136)
                end
            end
        end
    end, {
        v_u_99,
        v_u_101,
        v_u_105,
        v_u_103,
        v_u_107
    })
    v_u_3.useEffect(function()
        -- upvalues: (copy) v_u_99, (copy) v_u_101, (ref) v_u_30, (ref) v_u_31, (copy) v_u_109, (ref) v_u_4, (copy) v_u_112, (ref) v_u_9, (copy) v_u_88, (copy) v_u_108, (copy) v_u_114
        if v_u_99 and v_u_101 == "cards" then
            local v137 = v_u_99.results or {}
            local v138 = v_u_30(#v137)
            local v139 = {}
            for v140, v141 in v137 do
                if v141.kind == "model" and v141.modelName then
                    local v142 = v_u_31(v141.modelFolder, v141.modelName, v141.childName)
                    if v142 then
                        local v143 = v138[v140]
                        local v144 = {
                            ["template"] = v142,
                            ["screenX"] = v143.cx,
                            ["screenY"] = v143.cy,
                            ["fillH"] = v143.ch * 0.625,
                            ["delay"] = (v140 - 1) * 0.07 * v_u_109,
                            ["rotX"] = v141.rotX or 0,
                            ["rotY"] = v141.rotY or 25,
                            ["rotZ"] = v141.rotZ or 0,
                            ["burstImage"] = v_u_4.ASSETS.STARBURST,
                            ["burstColor"] = v141.color
                        }
                        table.insert(v139, v144)
                    else
                        local v145 = warn
                        local v146 = v141.modelName
                        v145("[ChestRevealOverlay] missing reward template: " .. tostring(v146))
                    end
                end
            end
            if not v_u_112.current then
                v_u_112.current = v_u_9.new()
            end
            v_u_112.current:Show(v139)
            v_u_88.open()
            local v_u_147 = task.delay(0.3 * v_u_109, function()
                -- upvalues: (ref) v_u_88
                v_u_88.reward()
            end)
            local v_u_148 = task.delay((#v137 * 0.07 + 0.5) * v_u_109, function()
                -- upvalues: (ref) v_u_108
                v_u_108(true)
            end)
            local v_u_149
            if v_u_99.auto then
                v_u_149 = task.delay((#v137 * 0.07 + 2.9) * v_u_109, v_u_114)
            else
                v_u_149 = nil
            end
            return function()
                -- upvalues: (copy) v_u_147, (copy) v_u_148, (ref) v_u_149
                task.cancel(v_u_147)
                task.cancel(v_u_148)
                if v_u_149 then
                    task.cancel(v_u_149)
                end
            end
        end
    end, { v_u_99, v_u_101 })
    if not v_u_99 then
        return nil
    end
    local v150 = v_u_99.results or {}
    local v151 = #v150
    local function v_u_154(p_u_152)
        -- upvalues: (copy) v_u_103, (copy) v_u_107, (copy) v_u_110, (copy) v_u_111, (copy) v_u_104, (copy) v_u_87, (copy) v_u_100, (copy) v_u_102
        if not v_u_103 and (v_u_107 and os.clock() - v_u_110.current >= 0.8) then
            v_u_111.current = p_u_152
            v_u_104(true)
            task.spawn(function()
                -- upvalues: (ref) v_u_87, (copy) p_u_152, (ref) v_u_100, (ref) v_u_102, (ref) v_u_104
                local v153 = v_u_87.openMore(p_u_152)
                if v153 then
                    v_u_100(v153)
                    v_u_102("burst")
                end
                v_u_104(false)
            end)
        end
    end
    local function v_u_157(p_u_155)
        -- upvalues: (copy) v_u_103, (copy) v_u_107, (copy) v_u_99, (copy) v_u_110, (copy) v_u_111, (copy) v_u_104, (copy) v_u_100, (copy) v_u_102, (copy) v_u_106
        if not v_u_103 and (v_u_107 and (v_u_99.buy and os.clock() - v_u_110.current >= 0.8)) then
            v_u_111.current = p_u_155
            v_u_104(true)
            task.spawn(function()
                -- upvalues: (ref) v_u_99, (copy) p_u_155, (ref) v_u_100, (ref) v_u_102, (ref) v_u_106, (ref) v_u_104
                local v156 = v_u_99.buy.more(p_u_155)
                if v156 then
                    v_u_100(v156)
                    v_u_102("burst")
                else
                    v_u_106(false)
                end
                v_u_104(false)
            end)
        end
    end
    local v158 = {}
    if v_u_101 == "burst" then
        if v_u_99.crate and v_u_99.crate.image then
            local v159 = v_u_30(v151)
            local v160 = {}
            for v161 = 1, v151 do
                v160["chest" .. v161] = v_u_13(v_u_58, {
                    ["image"] = v_u_99.crate.image,
                    ["openImage"] = v_u_99.crate.openImage,
                    ["rect"] = v159[v161],
                    ["delay"] = (v161 - 1) * 0.07 * v_u_109
                })
            end
            v158.burst = v_u_13("Frame", {
                ["Size"] = UDim2.fromScale(1, 1)
            }, v160)
        end
    else
        v158.title = v_u_13(v_u_6, {
            ["text"] = v_u_99.title or (v151 <= 1 and "TREASURE!" or v151 .. "x TREASURE!"),
            ["textColor"] = v_u_4.GOLD,
            ["strokeColor"] = v_u_4.OUTLINE,
            ["size"] = UDim2.fromScale(0.8, 0.12),
            ["position"] = UDim2.fromScale(0.5, 0.14),
            ["anchorPoint"] = Vector2.new(0.5, 0.5)
        })
        local v162 = v_u_30(v151)
        local v163 = {}
        for v164, v165 in v150 do
            v163["card" .. v164] = v_u_13(v_u_84, {
                ["card"] = v165,
                ["rect"] = v162[v164],
                ["big"] = v151 == 1,
                ["delay"] = (v164 - 1) * 0.07 * v_u_109
            })
        end
        v158.cards = v_u_13("Frame", {
            ["Size"] = UDim2.fromScale(1, 1)
        }, v163)
        if not v_u_99.auto then
            local v166 = v_u_99.remaining or 0
            local v167 = v166 > 0
            local v_u_168 = math.min(3, v166)
            local v_u_169 = v_u_103 or not v_u_107
            local v170 = {}
            local v171 = {}
            local function v183(p172, p173, p174, p175, p176, p177)
                -- upvalues: (ref) v_u_13, (ref) v_u_8, (ref) v_u_4, (copy) v_u_98, (copy) v_u_169
                local v178 = {
                    ["key"] = p173
                }
                local v179 = v_u_13
                local v180 = v_u_8
                local v181 = {
                    ["theme"] = v_u_4,
                    ["variant"] = p176 or "blue",
                    ["text"] = p174,
                    ["scale"] = v_u_98
                }
                local v182
                if p177 then
                    v182 = nil
                else
                    v182 = v_u_169
                end
                v181.disabled = v182
                v181.onClick = p175
                v181.Size = UDim2.fromScale(1, 1)
                v178.el = v179(v180, v181)
                table.insert(p172, v178)
            end
            if v167 then
                v183(v170, "open1", "OPEN 1", function()
                    -- upvalues: (copy) v_u_154
                    v_u_154(1)
                end)
                if v166 > 1 then
                    v183(v170, "openN", "OPEN x" .. v_u_168, function()
                        -- upvalues: (copy) v_u_154, (copy) v_u_168
                        v_u_154(v_u_168)
                    end)
                end
            elseif v_u_99.buy then
                v183(v170, "buy1", "BUY 1", function()
                    -- upvalues: (copy) v_u_157
                    v_u_157(1)
                end)
                v183(v170, "buyN", "BUY " .. 3, function()
                    -- upvalues: (copy) v_u_157
                    v_u_157(3)
                end)
            end
            if v_u_99.equip then
                v183(v171, "equip", "EQUIP", function()
                    -- upvalues: (copy) v_u_99, (copy) v_u_114
                    v_u_99.equip()
                    v_u_114()
                end)
            end
            if v167 or v_u_99.buy then
                v183(v171, "autoBtn", v_u_105 and "STOP" or "AUTO", function()
                    -- upvalues: (copy) v_u_106, (copy) v_u_105
                    v_u_106(not v_u_105)
                end, v_u_105 and "accent" or "blue", true)
            end
            local function v191(p184, p185, p186)
                -- upvalues: (copy) v_u_98, (ref) v_u_13, (ref) v_u_6, (ref) v_u_4
                if #p184 == 0 then
                    return nil
                end
                local v187 = (#p184 * 168 + (#p184 - 1) * 12) * v_u_98
                local v188 = {}
                for v189, v190 in p184 do
                    v188[v190.key] = v_u_13("Frame", {
                        ["Position"] = UDim2.fromOffset((v189 - 1) * 180 * v_u_98, 0),
                        ["Size"] = UDim2.fromOffset(v_u_98 * 168, v_u_98 * 60)
                    }, {
                        ["btn"] = v190.el
                    })
                end
                if p186 then
                    v188.count = v_u_13(v_u_6, {
                        ["text"] = p186,
                        ["font"] = v_u_4.FONT_DISPLAY_FAMILY,
                        ["textColor"] = v_u_4.CREAM,
                        ["textSize"] = v_u_98 * 32,
                        ["strokeColor"] = v_u_4.OUTLINE,
                        ["size"] = UDim2.fromOffset(v187, v_u_98 * 32),
                        ["position"] = UDim2.fromOffset(v187 / 2, v_u_98 * -2),
                        ["anchorPoint"] = Vector2.new(0.5, 1)
                    })
                end
                return v_u_13("Frame", {
                    ["AnchorPoint"] = Vector2.new(p185 < 0 and 1 or 0, 0.5),
                    ["Position"] = UDim2.new(0.5, p185 * 187 * v_u_98, 0.5, 0),
                    ["Size"] = UDim2.fromOffset(v187, v_u_98 * 60)
                }, v188)
            end
            local v192 = {}
            local v193 = -1
            local v194
            if v167 then
                v194 = v166 .. " left"
            else
                v194 = nil
            end
            v192.left = v191(v170, v193, v194)
            v192.right = v191(v171, 1, nil)
            v192.collect = v_u_13(v_u_8, {
                ["theme"] = v_u_4,
                ["scale"] = v_u_98,
                ["disabled"] = v_u_169,
                ["onClick"] = v_u_114,
                ["AnchorPoint"] = Vector2.new(0.5, 0.5),
                ["Position"] = UDim2.fromScale(0.5, 0.5),
                ["Size"] = UDim2.fromOffset(v_u_98 * 330, v_u_98 * 100)
            })
            v158.footer = v_u_13("Frame", {
                ["AnchorPoint"] = Vector2.new(0.5, 1),
                ["Position"] = UDim2.new(0.5, 0, 1, v_u_98 * -26),
                ["Size"] = UDim2.new(1, 0, 0, v_u_98 * 100)
            }, v192)
        end
    end
    return v_u_13("Frame", {
        ["Size"] = UDim2.fromScale(1, 1)
    }, v158)
end