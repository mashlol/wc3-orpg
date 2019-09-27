local backpack = require('src/items/backpack.lua')
local load = require('src/saveload/load.lua')
local equipment = require('src/items/equipment.lua')
local Dialog = require('src/ui/dialog.lua')
local SimpleButton = require('src/ui/simplebutton.lua')

local START_X = -2554
local START_Y = 71

local heroes = {}
local pickedHeroes = {}
local saveSlots = {}

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
        model = "units\\demon\\HeroChaosBladeMaster\\HeroChaosBladeMaster.mdl",
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
        model = "Valkyrie.mdl",
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
        model = "Units\\Creeps\\HeroGoblinAlchemist\\HeroGoblinAlchemist.mdl",
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
        model = "Magna Aegwynn.mdl",
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
        model = "johanaulty.mdl",
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

    SimpleButton.hide(playerId)

    DestroyTrigger(forceCameraTriggers[playerId])
    DestroyTrigger(selectHeroTriggers[playerId])

    local trig = CreateTrigger()
    TriggerRegisterTimerEvent(trig, 0.1, true)
    TriggerAddAction(trig, function()
        forceCameraLocation(playerId, gg_cam_Camera_003)
    end)
    forceCameraTriggers[playerId] = trig

    local heroInfo = ALL_HERO_INFO[GetUnitTypeId(selectedUnit)]
    local model = playerId == GetPlayerId(GetLocalPlayer()) and heroInfo.model or ""
    local effect = AddSpecialEffect(model, 27463, -30197)
    BlzSetSpecialEffectYaw(effect, 5.32325)
    BlzSetSpecialEffectScale(
        effect, GetUnitPointValueByType(GetUnitTypeId(selectedUnit)) / 100)

    Dialog.show(playerId, {
        text = "Pick " .. heroInfo.name .. "?",
        xPos = 0.5,
        positiveButton = "Confirm",
        negativeButton = "Back",
        onNegativeButtonClicked = function()
            DestroyTrigger(forceCameraTriggers[playerId])
            BlzSetSpecialEffectPosition(effect, 30000, 30000, -30000)
            DestroyEffect(effect)

            showPickHeroDialog(playerId)
        end,
        onPositiveButtonClicked = function()
            DestroyTrigger(forceCameraTriggers[playerId])
            BlzSetSpecialEffectPosition(effect, 30000, 30000, -30000)
            DestroyEffect(effect)

            pickedHeroes[playerId] = ALL_HERO_INFO[GetUnitTypeId(selectedUnit)]
            createHeroForPlayer(playerId)

            for _, listener in pairs(pickListeners) do
                listener()
            end
        end,
    })
end

function showLoadHeroDialog(playerId)
    local dialog = DialogCreate()

    DialogSetMessage(dialog, "Choose hero to load")
    for i=1,5,1 do
        local btn = DialogAddButton(dialog, "Load Hero in Slot #" .. i, 0)

        local trig = CreateTrigger()
        TriggerRegisterDialogButtonEvent(trig, btn)
        TriggerAddAction(trig, function()
            DestroyTrigger(trig)
            DestroyTrigger(forceCameraTriggers[playerId])
            DestroyTrigger(selectHeroTriggers[playerId])

            load.loadFromFile(playerId, i)
        end)
    end

    local btn = DialogAddButton(dialog, "Back", 0)

    local trig = CreateTrigger()
    TriggerRegisterDialogButtonEvent(trig, btn)
    TriggerAddAction(trig, function()
        DestroyTrigger(trig)

        showLoadButton(playerId)
    end)

    DialogDisplay(Player(playerId), dialog, true)
end

function showLoadButton(playerId)
    SimpleButton.show(playerId, {
        text = "Load Existing Hero",
        onClick = function()
            showLoadHeroDialog(playerId)
        end
    })
end

function showPickHeroDialog(playerId)
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

    -- Show load button, if they have any heroes to load
    -- TODO only show if they have something to load
    showLoadButton(playerId)
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
    saveSlots[repickPlayerId] = nil

    for _, listener in pairs(repickListeners) do
        listener(repickPlayerId)
    end

    showPickHeroDialog(repickPlayerId)
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
