local backpack = require('src/items/backpack.lua')
local equipment = require('src/items/equipment.lua')

local START_X = -2554
local START_Y = 71

local heroes = {}
local pickedHeroes = {}

local repickListeners = {}
local pickListeners = {}

local ALL_HERO_INFO = {
    [FourCC("Hyuj")] = {
        name = 'Yuji',
        storedId = 1,
        id = FourCC("Hyuj"),
        spells = {
            [1] = 'slash',
            [2] = 'throwingstar',
            [3] = 'dash',
            [4] = 'slashult',
            [5] = 'attack',
            [6] = 'stop',
            [7] = 'jab',
            [8] = 'focus',
            [9] = 'stun',
            [10] = 'blind',
        },
        baseHP = 600,
    },
    [FourCC("Hstm")] = {
        name = 'Stormfist',
        storedId = 2,
        id = FourCC("Hstm"),
        spells = {
            [1] = 'punch',
            [5] = 'attack',
            [6] = 'stop',
        },
        baseHP = 600,
    },
    [FourCC("Hivn")] = {
        name = 'Ivanov',
        storedId = 3,
        id = FourCC("Hivn"),
        spells = {
            [1] = 'rejuvpot',
            [2] = 'armorpot',
            [3] = 'cleansingpot',
            [4] = 'molecregen',
            [5] = 'attack',
            [6] = 'stop',
            [7] = 'corrosiveblast',
            [8] = 'accmist',
            [9] = 'hulkingpot',
            [10] = 'dampenpot',
            [11] = 'pocketgoo',
        },
        baseHP = 600,
    },
    [FourCC("Hazr")] = {
        name = 'Azora',
        storedId = 4,
        id = FourCC("Hazr"),
        spells = {
            [1] = 'fireball',
            [2] = 'frostnova',
            [3] = 'firelance',
            [4] = 'meteor',
            [5] = 'attack',
            [6] = 'stop',
            [7] = 'firestorm',
            [8] = 'blink',
            [9] = 'icicle',
            [10] = 'phoenix',
            [11] = 'fireshell',
            [12] = 'frostballs',
        },
        baseHP = 400,
    },
    [FourCC("Htar")] = {
        name = 'Tarcza',
        storedId = 5,
        id = FourCC("Htar"),
        spells = {
            [1] = 'whirlwind',
            [2] = 'boomerang',
            [3] = 'blitz',
            [4] = 'shieldcharge',
            [5] = 'attack',
            [6] = 'stop',
            [7] = 'stalwartshell',
            [8] = 'curshout',
            [9] = 'bulwark',
            [10] = 'flag',
            [11] = 'challenge',
        },
        baseHP = 1000,
    },
}

local respawn = function()
    local unit = GetDyingUnit()
    local exp = GetHeroXP(unit)

    TriggerSleepAction(5)

    for i=0, bj_MAX_PLAYERS, 1 do
        if unit == heroes[i] then
            createHeroForPlayer(i, exp)
        end
    end
end

local forceCameraTriggers = {}
local selectHeroTriggers = {}

function createHeroForPlayer(playerId, exp, heroX, heroY)
    DestroyTrigger(forceCameraTriggers[playerId])
    DestroyTrigger(selectHeroTriggers[playerId])

    local hero = CreateUnit(
        Player(playerId),
        pickedHeroes[playerId].id,
        heroX or START_X,
        heroY or START_Y,
        0)

    if playerId == GetPlayerId(GetLocalPlayer()) then
        ClearSelection()
        SelectUnit(hero, true)
        ResetToGameCamera(0)
        PanCameraToTimed(heroX or START_X, heroY or START_Y, 0)
    end

    if exp ~= nil and exp ~= 0 then
        SetHeroXP(hero, exp, false)
    end

    heroes[playerId] = hero

    TimerStart(CreateTimer(), 0.2, false, function()
        local maxHP = BlzGetUnitMaxHP(hero)
        SetUnitState(hero, UNIT_STATE_LIFE, maxHP)
    end)
end

local forceCameraLocation = function(playerId, camera)
    CameraSetupApplyForPlayer(true, camera, Player(playerId), 0)
end

local onHeroPicked = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local selectedUnit = GetTriggerUnit()

    pickedHeroes[playerId] = ALL_HERO_INFO[GetUnitTypeId(selectedUnit)]
    createHeroForPlayer(playerId)

    for _, listener in pairs(pickListeners) do
        listener()
    end
end

local showPickHeroDialog = function(playerId)
    -- TODO a better way to pick heroes

    -- Apply camera
    -- Make zone visible
    -- Add trigger, when hero is clicked, move to special zone for that hero
    -- If clicked again, you picked that hero

    CreateFogModifierRectBJ(
        true, Player(playerId), FOG_OF_WAR_VISIBLE, gg_rct_Region_000)

    local trig = CreateTrigger()
    TriggerRegisterTimerEvent(trig, 0.1, true)
    TriggerAddAction(trig, function()
        forceCameraLocation(playerId, gg_cam_Camera_002)
    end)
    forceCameraTriggers[playerId] = trig

    local selectTrig = CreateTrigger()
    TriggerRegisterPlayerUnitEvent(
        selectTrig, Player(playerId), EVENT_PLAYER_UNIT_SELECTED, nil)
    TriggerAddAction(selectTrig, onHeroPicked)
    selectHeroTriggers[playerId] = selectTrig
end

function onRepick()
    local repickPlayerId = GetPlayerId(GetTriggerPlayer())

    if getHero(repickPlayerId) == nil then
        return
    end

    equipment.clear(repickPlayerId)
    backpack.clear(repickPlayerId)
    RemoveUnit(heroes[repickPlayerId])
    heroes[repickPlayerId] = nil
    pickedHeroes[repickPlayerId] = nil
    showPickHeroDialog(repickPlayerId)

    for _, listener in pairs(repickListeners) do
        listener(repickPlayerId)
    end
end

function onLevel()
    local hero = GetLevelingUnit()
    TimerStart(CreateTimer(), 0.2, false, function()
        local maxHP = BlzGetUnitMaxHP(hero)
        SetUnitState(hero, UNIT_STATE_LIFE, maxHP)
    end)
end

local init = function()
    local trigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trigger, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(trigger, respawn)

    local levelTrigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(levelTrigger, EVENT_PLAYER_HERO_LEVEL)
    TriggerAddAction(levelTrigger, onLevel)

    local repickTrig = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerChatEvent(repickTrig, Player(i), "-repick", true)
    end
    TriggerAddAction(repickTrig, onRepick)

    for i=0,bj_MAX_PLAYERS,1 do
        showPickHeroDialog(i)
    end
end

function getHero(playerId)
    return heroes[playerId]
end

local isHero = function(unit)
    for _, hero in pairs(heroes) do
        if unit == hero then
            return true
        end
    end
    return false
end

local getPickedHero = function(playerId)
    return pickedHeroes[playerId]
end

function restorePickedHero(playerId, storedHeroId, exp, heroX, heroY)
    for _, info in pairs(ALL_HERO_INFO) do
        if info.storedId == storedHeroId then
            pickedHeroes[playerId] = info
            createHeroForPlayer(playerId, exp, heroX, heroY)
            return
        end
    end
end

function getStatEffects(playerId)
    local pickedHero = getPickedHero(playerId)
    local hero = getHero(playerId)
    if pickedHero == nil or hero == nil then
        return {}
    end
    local level = GetHeroLevel(hero) - 1
    return {
        {
            type = 'multiplyDamage',
            amount = 1 + 0.08 * level,
        },
        {
            type = 'multiplyHealing',
            amount = 1 + 0.08 * level,
        },
        {
            type = 'rawHp',
            amount = level * 10,
        }
    }
end

function addRepickedListener(repickedListenerFunc)
    table.insert(repickListeners, repickedListenerFunc)
end

function addHeroPickedListener(onPickedListenerFunc)
    table.insert(pickListeners, onPickedListenerFunc)
end

return {
    init = init,
    getHero = getHero,
    isHero = isHero,
    getPickedHero = getPickedHero,
    restorePickedHero = restorePickedHero,
    addRepickedListener = addRepickedListener,
    addHeroPickedListener = addHeroPickedListener,
    getStatEffects = getStatEffects,
}
