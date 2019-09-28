local backpack = require('src/items/backpack.lua')
local load = require('src/saveload/load.lua')
local meta = require('src/saveload/meta.lua')
local save = require('src/saveload/save.lua')
local log = require('src/log.lua')
local equipment = require('src/items/equipment.lua')
local Dialog = require('src/ui/dialog.lua')
local SimpleButton = require('src/ui/simplebutton.lua')

local CREATE_SYNC_PREFIX = 'create-hero'

local START_X = -2554
local START_Y = 71

local heroes = {}
local pickedHeroes = {}
local saveSlot = nil
local usedSlots

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

function getNextEmptySaveSlot()
    for idx, _ in pairs(usedSlots) do
        if usedSlots[idx + 1] == nil then
            return idx + 1
        end
    end

    return 1
end

local onHeroPicked = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local selectedUnit = GetTriggerUnit()

    if GetPlayerId(GetLocalPlayer()) == playerId then
        local slot = getNextEmptySaveSlot()
        BlzSendSyncData(
            CREATE_SYNC_PREFIX,
            GetUnitTypeId(selectedUnit) .. '|' .. slot)
    end
end

function showLoadHeroDialog(playerId)
    if GetPlayerId(GetLocalPlayer()) == playerId then
        local buttons = {}

        for slot, metaData in pairs(usedSlots) do
            table.insert(buttons, {
                text = "Load " .. metaData,
                onClick = function()
                    saveSlot = slot
                    load.loadFromFile(playerId, slot)
                end
            })
        end

        Dialog.show(playerId, {
            text = "Load?",
            positiveButton = 'Back',
            onPositiveButtonClicked = function()
                showLoadButton(playerId)
            end,
            buttons = buttons,
        })
    end
end

function hasACharacter()
    for _, _ in pairs(usedSlots) do
        return true
    end
    return false
end

function showLoadButton(playerId)
    if GetPlayerId(GetLocalPlayer()) == playerId then
        if not hasACharacter() then
            return
        end
        SimpleButton.show(playerId, {
            text = "Load Existing Hero",
            onClick = function()
                showLoadHeroDialog(playerId)
            end
        })
    end
end

function showPickHeroDialog(playerId)
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

    if playerId == GetPlayerId(GetLocalPlayer()) then
        usedSlots = meta.getUsedSlots()
        showLoadButton(playerId)
    end
end

function onRepick()
    local repickPlayerId = GetPlayerId(GetTriggerPlayer())

    if getHero(repickPlayerId) == nil then
        return
    end

    save.saveHero(repickPlayerId)

    equipment.clear(repickPlayerId)
    backpack.clear(repickPlayerId)
    RemoveUnit(heroes[repickPlayerId])
    heroes[repickPlayerId] = nil
    pickedHeroes[repickPlayerId] = nil
    saveSlot = nil

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

function onCreateSynced()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local data = BlzGetTriggerSyncData()

    local pipeLoc = string.find(data, '|', 0, true)
    local unitType = S2I(string.sub(data, 1, pipeLoc - 1))
    local slot = S2I(string.sub(data, pipeLoc + 1))

    if slot > meta.MAX_NUM_CHARS then
        log.log(
            playerId,
            'You have too many characters. Try deleting one first.',
            log.TYPE.ERROR)
        return
    end

    SimpleButton.hide(playerId)

    DestroyTrigger(forceCameraTriggers[playerId])
    DestroyTrigger(selectHeroTriggers[playerId])

    local trig = CreateTrigger()
    TriggerRegisterTimerEvent(trig, 0.1, true)
    TriggerAddAction(trig, function()
        forceCameraLocation(playerId, gg_cam_Camera_003)
    end)
    forceCameraTriggers[playerId] = trig

    local heroInfo = ALL_HERO_INFO[unitType]
    local model = playerId == GetPlayerId(GetLocalPlayer()) and heroInfo.model or ""
    local effect = AddSpecialEffect(model, 27463, -30197)
    BlzSetSpecialEffectYaw(effect, 5.32325)
    BlzSetSpecialEffectScale(
        effect, GetUnitPointValueByType(unitType) / 100)

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

            saveSlot = slot

            pickedHeroes[playerId] = ALL_HERO_INFO[unitType]
            createHeroForPlayer(playerId)

            for _, listener in pairs(pickListeners) do
                listener()
            end

            save.saveHero(playerId)
        end,
    })
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

    local syncCreateTrigger = CreateTrigger()
    for i=0,bj_MAX_PLAYERS-1, 1 do
        BlzTriggerRegisterPlayerSyncEvent(
            syncCreateTrigger, Player(i), CREATE_SYNC_PREFIX, false)
    end
    TriggerAddAction(syncCreateTrigger, onCreateSynced)

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
    DestroyTrigger(forceCameraTriggers[playerId])
    DestroyTrigger(selectHeroTriggers[playerId])
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

function getSlot()
    return saveSlot
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
    getSlot = getSlot,
}
