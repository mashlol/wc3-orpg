function InitGlobals()
end

requireMap = {}
requireCache = {}

function require(path)
    if requireCache[path] == nil then
        requireCache[path] = requireMap[path]()
    end
    return requireCache[path]
end

src_hero_lua = function()
heroes = {}

local init = function()
	for i=0, bj_MAX_PLAYERS, 1 do
		if GetPlayerController(Player(i)) == MAP_CONTROL_USER then
	    	heroes[i] = CreateUnit(Player(i), FourCC("Hpal"), -150, -125, 0)
    	end
	end
end

local getHero = function(playerId)
	return heroes[playerId]
end

return {
	init = init,
	getHero = getHero,
}

end

src_keyboard_lua = function()
local mouse = require("src/mouse.lua")
local hero = require("src/hero.lua")
local projectile = require("src/projectile.lua")

local trigger = CreateTrigger()

local projectiles = {"ehip", "ewsp"}

local keyPressed = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local hero = hero.getHero(playerId)

    local startX = GetUnitX(hero)
    local startY = GetUnitY(hero)
    local endX = mouse.getMouseX(playerId)
    local endY = mouse.getMouseY(playerId)

    local projectileModel = projectiles[GetRandomInt(1, 2)]

    projectile.createProjectile(
        "ehip",
        startX,
        startY,
        endX,
        endY,
        900,
        200
    )

end

local init = function()
    -- TODO make for all players
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_1, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(1), OSKEY_1, 0, true)

    TriggerAddAction(trigger, keyPressed)
end

return {
    init = init,
}

end

src_mouse_lua = function()
local trigger = CreateTrigger()

local mousePositions = {}

for i=0, bj_MAX_PLAYERS, 1 do
    mousePositions[i] = {x = 0, y = 0}
end

local getMouseX = function(playerId)
    return mousePositions[playerId].x
end

local getMouseY = function(playerId)
    return mousePositions[playerId].y
end

local mouseMoved = function()
    local pos = BlzGetTriggerPlayerMousePosition()
    local playerId = GetPlayerId(GetTriggerPlayer())
    mousePositions[playerId].x = GetLocationX(pos)
    mousePositions[playerId].y = GetLocationY(pos)
end

local init = function()
    -- TODO make for all players
    TriggerRegisterPlayerEvent(trigger, Player(0), EVENT_PLAYER_MOUSE_MOVE)
    TriggerRegisterPlayerEvent(trigger, Player(1), EVENT_PLAYER_MOUSE_MOVE)

    TriggerAddAction(trigger, mouseMoved)
end

return {
    getMouseX = getMouseX,
    getMouseY = getMouseY,
    init = init,
}

end

src_projectile_lua = function()
local vector = require('src/vector.lua')

local projectiles = {}
local timer

local isCloseTo = function(val, expected)
    return val + 15 >= expected and val - 15 <= expected
end

local clearProjectiles = function()
    local elapsedTime = TimerGetElapsed(timer)

    local toRemove = {}
    for idx, projectile in pairs(projectiles) do
        local curProjectileX = GetUnitX(projectile.unit)
        local curProjectileY = GetUnitY(projectile.unit)

        if
            isCloseTo(curProjectileX, projectile.toX) and
            isCloseTo(curProjectileY, projectile.toY)
        then
            -- Already at destination, can finish
            RemoveUnit(projectile.unit)
            projectile.toRemove = true
        else
            -- Move toward destination at speed
            local totalDistX = projectile.toX - curProjectileX
            local totalDistY = projectile.toY - curProjectileY

            local distVector = vector.create(totalDistX, totalDistY)

            local v1 = vector.normalize(distVector)
            v1 = vector.multiply(v1, projectile.speed * elapsedTime)

            if vector.magnitude(v1) >= vector.magnitude(distVector) then
                v1 = distVector
            end

            v1 = vector.add(
                v1,
                vector.create(curProjectileX, curProjectileY))

            SetUnitX(projectile.unit, v1.x)
            SetUnitY(projectile.unit, v1.y)
        end
    end
    for idx, projectile in pairs(projectiles) do
        if projectile.toRemove then
            tables.remove(projectiles, idx)
        end
    end
end

local init = function()
    timer = CreateTimer()
    TimerStart(timer, 0.03125, true, clearProjectiles)
end

local createProjectile = function(model, fromX, fromY, toX, toY, speed, length)
    if length ~= nil then
        local fromVector = vector.create(fromX, fromY)
        local toVector = vector.create(toX, toY)
        local totalVector = vector.subtract(toVector, fromVector)
        totalVector = vector.normalize(totalVector)
        totalVector = vector.multiply(totalVector, length)
        totalVector = vector.add(fromVector, totalVector)
        toX = totalVector.x
        toY = totalVector.y
    end

    local projectile = CreateUnit(
        Player(0),
        FourCC(model),
        fromX,
        fromY,
        bj_RADTODEG * Atan2(toY - fromY, toX - fromX))

    table.insert(projectiles, {
        unit = projectile,
        toX = toX,
        toY = toY,
        speed = speed,
    })

    return projectile
end

return {
    init = init,
    createProjectile = createProjectile,
}

end

src_setMoney_lua = function()
-- local setMoney = function()
--     SetPlayerState(Player(0), PLAYER_STATE_RESOURCE_GOLD, 15000)
--     print("Test setMoney New")
-- end

-- TimerStart(CreateTimer(), 0.0, false, setMoney)
end

src_ui_lua = function()
-- local initUI = function()
--     print("INited UI")
--     local face = BlzCreateFrameByType("BACKDROP", "Face", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)--Create a new frame of Type BACKDROP
--     local faceHover = BlzCreateFrameByType("FRAME", "FaceFrame", face,"", 0) --face is a BACKDROP it can not have events nor a tooltip, thats why one creates an empty frame managing that.
--     local tooltip = BlzCreateFrameByType("TEXT", "FaceFrameTooltip", face,"", 0)--Create a new frame of Type TEXT
--     --faceHover would be unneeded if face would support events/tooltip

--     BlzFrameSetAllPoints(faceHover, face) --faceHover copies the size and position of face.
--     BlzFrameSetTooltip(faceHover, tooltip) --when faceHover is hovered with the mouse frame tooltip becomes visible.

--     BlzFrameSetSize(face, 0.04, 0.04)
--     BlzFrameSetAbsPoint(face, FRAMEPOINT_CENTER, 0.4, 0.3)
--     BlzFrameSetAbsPoint(tooltip, FRAMEPOINT_CENTER, 0.2, 0.3)
--     BlzFrameSetText(tooltip, "Human Paladin Face")

--     if GetPlayerId(GetLocalPlayer()) == 0 then
--        BlzFrameSetTexture(face, "ReplaceableTextures\\CommandButtons\\BTNAbomination",0, true)--face uses paladin blp as texture.
--     else
--         BlzFrameSetTexture(face, "UI\\Glues\\ScoreScreen\\scorescreen-player-bloodelf",0, true)--face uses paladin blp as texture.
--     end
-- end

-- TimerStart(CreateTimer(), 0.0, false, initUI)
end

src_vector_lua = function()
local abs = function(a)
  if a >= 0 then
    return a
  end
  return -a
end

local create = function(x, y)
  return {
    x = x,
    y = y,
  }
end

local add = function(a, b)
  return {
    x = a.x + b.x,
    y = a.y + b.y,
  }
end

local subtract = function(a, b)
  return {
    x = a.x - b.x,
    y = a.y - b.y,
  }
end

local multiply = function(a, b)
  return {
    x = a.x * b,
    y = a.y * b
  }
end

local magnitude = function(a)
  return SquareRoot(a.x^2 + a.y^2)
end

local normalize = function(a)
  local mag = magnitude(a)
  return {
    x = a.x / mag,
    y = a.y / mag,
  }
end

return {
  create = create,
  add = add,
  subtract = subtract,
  multiply = multiply,
  magnitude = magnitude,
  normalize = normalize,
}

end
requireMap["src/hero.lua"] = src_hero_lua
requireMap["src/keyboard.lua"] = src_keyboard_lua
requireMap["src/main.lua"] = src_main_lua
requireMap["src/mouse.lua"] = src_mouse_lua
requireMap["src/projectile.lua"] = src_projectile_lua
requireMap["src/setMoney.lua"] = src_setMoney_lua
requireMap["src/ui.lua"] = src_ui_lua
requireMap["src/vector.lua"] = src_vector_lua


local hero = require('src/hero.lua')
local keyboard = require('src/keyboard.lua')
local mouse = require('src/mouse.lua')
local projectile = require('src/projectile.lua')

local mainInit = function()
    hero.init()
    keyboard.init()
    mouse.init()
    projectile.init()
end

TimerStart(CreateTimer(), 0.0, false, mainInit)





function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(1), 1)
    SetPlayerColor(Player(1), ConvertPlayerColor(1))
    SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(1), true)
    SetPlayerController(Player(1), MAP_CONTROL_USER)
end

function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
    SetPlayerTeam(Player(1), 0)
end

function InitAllyPriorities()
    SetStartLocPrioCount(0, 1)
    SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(1, 1)
    SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
end

function main()
    SetCameraBounds(-3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("LordaeronSummerDay")
    SetAmbientNightSound("LordaeronSummerNight")
    SetMapMusic("Music", true, 0)
    InitBlizzard()
    InitGlobals()
end

function config()
    SetMapName("TRIGSTR_001")
    SetMapDescription("TRIGSTR_003")
    SetPlayers(2)
    SetTeams(2)
    SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    DefineStartLocation(0, 256.0, 2368.0)
    DefineStartLocation(1, 2368.0, 1856.0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    SetPlayerSlotAvailable(Player(1), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
    InitAllyPriorities()
end

