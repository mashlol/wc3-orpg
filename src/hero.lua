local heroes = {}
local pickedHeroes = {}

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
    local level = GetHeroLevel(unit)

    TriggerSleepAction(5)

    for i=0, bj_MAX_PLAYERS, 1 do
        if unit == heroes[i] then
            createHeroForPlayer(i, level)
        end
    end
end

function createHeroForPlayer(playerId, level)
    heroes[playerId] = CreateUnit(
        Player(playerId), pickedHeroes[playerId].id, -150, -125, 0)

    if playerId == GetPlayerId(GetLocalPlayer()) then
        ClearSelection()
        SelectUnit(heroes[playerId], true)
        ResetToGameCamera(0)
        PanCameraToTimed(-150, -125, 0)
    end

    if level ~= nil then
        SetHeroLevel(heroes[playerId], level, false)
    end
end

local forceCameraTriggers = {}
local selectHeroTriggers = {}

local forceCameraLocation = function(playerId, camera)
    CameraSetupApplyForPlayer(true, camera, Player(playerId), 0)
end

local onHeroPicked = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local selectedUnit = GetTriggerUnit()

    pickedHeroes[playerId] = ALL_HERO_INFO[GetUnitTypeId(selectedUnit)]
    createHeroForPlayer(playerId)

    DestroyTrigger(forceCameraTriggers[playerId])
    DestroyTrigger(selectHeroTriggers[playerId])
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
    RemoveUnit(heroes[repickPlayerId])
    showPickHeroDialog(repickPlayerId)
end

local init = function()
    local trigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trigger, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(trigger, respawn)

    local repickTrig = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerChatEvent(repickTrig, Player(i), "-repick", false)
    end
    TriggerAddAction(repickTrig, onRepick)

    for i=0,bj_MAX_PLAYERS,1 do
        showPickHeroDialog(i)
    end
end

local getHero = function(playerId)
    return heroes[playerId]
end

local isHero = function(unit)
    for idx, hero in pairs(heroes) do
        if unit == hero then
            return true
        end
    end
    return false
end

local getPickedHero = function(playerId)
    return pickedHeroes[playerId]
end

return {
    init = init,
    getHero = getHero,
    isHero = isHero,
    getPickedHero = getPickedHero,
}
