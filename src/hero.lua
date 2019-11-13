local backpack = require('src/items/backpack.lua')
local quest = require('src/quests/main.lua')
local meta = require('src/saveload/meta.lua')
local save = require('src/saveload/save.lua')
local log = require('src/log.lua')
local zones = require('src/zones.lua')
local stats = require('src/stats.lua')
local equipment = require('src/items/equipment.lua')
local HeroSelect = require('src/ui/heroselect.lua')

local CREATE_SYNC_PREFIX = 'create-hero'

local heroes = {}
local pickedHeroes = {}
local saveSlot = nil
local usedSlots

local repickListeners = {}
local pickListeners = {}

local ALL_HERO_INFO = {
    [FourCC("Hyuj")] = {
        name = 'Yuji',
        desc = 'Yuji is an extremely mobile, fast paced hero. Yuji deals '..
            'very high amounts of damage but cannot sustain much damage '..
            'himself. Yuji excels at engaging and disengaging in combat '..
            'quickly, assassinating targets.',
        heroType = 'Assassin',
        storedId = 1,
        id = FourCC("Hyuj"),
        spells = {
            [1] = 'slash',
            [2] = 'throwingstar',
            [3] = 'dash',
            [4] = 'slashult',
            [5] = 'jab',
            [6] = 'focus',
        },
        model = "units\\demon\\HeroChaosBladeMaster\\HeroChaosBladeMaster.mdl",
        portrait = "war3mapImported\\yuji_crop.blp",
        portraitFullBlurred = "war3mapImported\\yuji_blur_crop.blp",
        baseHP = 600,
        attackSpeed = 1.5,
    },
    [FourCC("Hstm")] = {
        name = 'Stormfist',
        desc = 'Stormfist is a close quarters fighter, adept at controlling '..
            'the elements to deal massive amounts of burst damage to her '..
            'foes. While she can deal high burst damage, she must be careful'..
            'not to get stuck nearby too many opponents.',
        heroType = 'Fighter',
        storedId = 2,
        id = FourCC("Hstm"),
        spells = {
            [1] = 'punch',
            [2] = 'gauntlet',
            [3] = 'thunderclap',
            [4] = 'tornado',
            [5] = 'barrier',
            [6] = 'thunderlightning',
        },
        model = "Valkyrie.mdl",
        portrait = "war3mapImported\\stormfist_crop.blp",
        portraitFullBlurred = "war3mapImported\\stormfist_blur_crop.blp",
        baseHP = 700,
        attackSpeed = 2,
    },
    [FourCC("Hivn")] = {
        name = 'Ivanov',
        desc = 'Ivanov is a support healer, who uses his knowledge in '..
            'science to concoct various potions. Ivanov must be careful when '..
            'healing, as he can also cause damage if he stacks his dangerous '..
            'poisons too high on allies.',
        heroType = 'Support',
        storedId = 3,
        id = FourCC("Hivn"),
        spells = {
            [1] = 'rejuvpot',
            [2] = 'corrosiveblast',
            [3] = 'cleansingpot',
            [4] = 'molecregen',
            [5] = 'armorpot',
            [6] = 'accmist',
        },
        model = "Units\\Creeps\\HeroGoblinAlchemist\\HeroGoblinAlchemist.mdl",
        portrait = "war3mapImported\\ivanov_crop.blp",
        portraitFullBlurred = "war3mapImported\\ivanov_blur_crop.blp",
        baseHP = 600,
        attackSpeed = 2.2,
    },
    [FourCC("Hazr")] = {
        name = 'Azora',
        desc = 'Azora was donned the title "The Wildfire", for being adept '..
            'at controlling the fire elements to her will. She can deal '..
            'extraordinary amounts of damage, but is extremely succeptible '..
            'to death. She has average mobility, focusing more on '..
            'controlling her opponents.',
        heroType = 'Caster',
        storedId = 4,
        id = FourCC("Hazr"),
        spells = {
            [1] = 'fireball',
            [2] = 'frostnova',
            [3] = 'firelance',
            [4] = 'meteor',
            [5] = 'fireorbs',
            [6] = 'blink',
        },
        model = "Magna Aegwynn.mdl",
        portrait = "war3mapImported\\azora_crop.blp",
        portraitFullBlurred = "war3mapImported\\azora_blur_crop.blp",
        baseHP = 400,
        attackSpeed = 2.2,
    },
    [FourCC("Htar")] = {
        name = 'Tarcza',
        desc = 'Tarcza, the Shield of X, is a powerful tank, capable of '..
            'withstanding great amounts of damage. Tarcza focuses on holding '..
            'aggro, but has a high level of mobility in order to protect his '..
            'allies from threats. The longer Tarcza engages in a fight, the '..
            'stronger he becomes.',
        heroType = 'Tank',
        storedId = 5,
        id = FourCC("Htar"),
        spells = {
            [1] = 'whirlwind',
            [2] = 'boomerang',
            [3] = 'blitz',
            [4] = 'shieldcharge',
            [5] = 'stalwartshell',
            [6] = 'curshout',
        },
        model = "johanaulty.mdl",
        portrait = "war3mapImported\\tarcza_crop.blp",
        portraitFullBlurred = "war3mapImported\\tarcza_blur_crop.blp",
        baseHP = 1000,
        attackSpeed = 1.7,
    },
}

local respawn = function()
    local unit = GetDyingUnit()
    local playerId = GetPlayerId(GetOwningPlayer(unit))
    local exp = GetHeroXP(unit)

    local respawnPoint = zones.getSpawnPoint(playerId)

    TriggerSleepAction(5)
    RemoveUnit(unit)

    for i=0, bj_MAX_PLAYERS, 1 do
        if unit == heroes[i] then
            createHeroForPlayer(i, exp, respawnPoint.x, respawnPoint.y)
        end
    end
end

function createHeroForPlayer(playerId, exp, heroX, heroY)
    local hero = CreateUnit(
        Player(playerId),
        pickedHeroes[playerId].id,
        heroX or zones.DEFAULT_SPAWN_POINT.x,
        heroY or zones.DEFAULT_SPAWN_POINT.y,
        0)

    if playerId == GetPlayerId(GetLocalPlayer()) then
        ClearSelection()
        SelectUnit(hero, true)
        ResetToGameCamera(0)
        PanCameraToTimed(heroX or zones.DEFAULT_SPAWN_POINT.x, heroY or zones.DEFAULT_SPAWN_POINT.y, 0)
    end

    if exp ~= nil and exp ~= 0 then
        SetHeroXP(hero, exp, false)
    end

    heroes[playerId] = hero

    TimerStart(CreateTimer(), 0.2, false, function()
        local maxHP = BlzGetUnitMaxHP(hero)
        SetUnitState(hero, UNIT_STATE_LIFE, maxHP)
    end)

    quest.updateQuestMarks()
end

function getNextEmptySaveSlot()
    if usedSlots[1] == nil then
        return 1
    end

    for idx, _ in pairs(usedSlots) do
        if usedSlots[idx + 1] == nil then
            return idx + 1
        end
    end

    return 1
end

function hasACharacter()
    for _, _ in pairs(usedSlots) do
        return true
    end
    return false
end

function showPickHeroDialog(playerId)
    HeroSelect.show(playerId, function(unitType)
        if GetPlayerId(GetLocalPlayer()) == playerId then
            local slot = getNextEmptySaveSlot()
            BlzSendSyncData(
                CREATE_SYNC_PREFIX,
                unitType .. '|' .. slot)
        end
    end)

    if playerId == GetPlayerId(GetLocalPlayer()) then
        usedSlots = meta.getUsedSlots()
    end
end

function onRepick()
    local repickPlayerId = GetPlayerId(GetTriggerPlayer())

    if getHero(repickPlayerId) == nil then
        return
    end

    save.saveHero(repickPlayerId)

    SetPlayerState(Player(repickPlayerId), PLAYER_STATE_RESOURCE_GOLD, 0)
    equipment.clear(repickPlayerId)
    backpack.clear(repickPlayerId)
    RemoveUnit(heroes[repickPlayerId])
    heroes[repickPlayerId] = nil
    pickedHeroes[repickPlayerId] = nil
    if GetPlayerId(GetLocalPlayer()) == repickPlayerId then
        saveSlot = nil
    end

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

function getDialogTextForHero(heroInfo)
    local desc = "|cffe0b412Pick " .. heroInfo.name .. " ?|r|n|n"..heroInfo.desc

    desc = desc .. '|n|n|cffe0b412Hero Type: |r' .. heroInfo.heroType
    desc = desc .. '|n|cffe0b412Base HP: |r' .. heroInfo.baseHP

    return desc
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
            log.TYPE.PICK_HERO_ERROR)
        showPickHeroDialog(playerId)
        return
    end

    if GetPlayerId(GetLocalPlayer()) == playerId then
        saveSlot = slot
    end

    pickedHeroes[playerId] = ALL_HERO_INFO[unitType]
    createHeroForPlayer(playerId)

    backpack.addItemIdToBackpack(playerId, 48)

    for _, listener in pairs(pickListeners) do
        listener()
    end

    save.saveHero(playerId)
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
            type = stats.PERCENT_DAMAGE,
            amount = 1 + 0.1 * level,
        },
        {
            type = stats.PERCENT_SPELL_DAMAGE,
            amount = 1 + 0.1 * level,
        },
        {
            type = stats.PERCENT_HEALING,
            amount = 1 + 0.10 * level,
        },
        {
            type = stats.RAW_HIT_POINTS,
            amount = level * 20,
        }
    }
end

function getSlot()
    return saveSlot
end

function setSlot(newSlot)
    saveSlot = newSlot
end

function removeHero(playerId)
    RemoveUnit(heroes[playerId])
    heroes[playerId] = nil
    pickedHeroes[playerId] = nil
end

function addRepickedListener(repickedListenerFunc)
    table.insert(repickListeners, repickedListenerFunc)
end

function addHeroPickedListener(onPickedListenerFunc)
    table.insert(pickListeners, onPickedListenerFunc)
end

function getUsedSlots()
    return usedSlots
end

function refreshUsedSlots()
    usedSlots = meta.getUsedSlots()
end

return {
    ALL_HERO_INFO = ALL_HERO_INFO,
    init = init,
    getHero = getHero,
    isHero = isHero,
    getPickedHero = getPickedHero,
    restorePickedHero = restorePickedHero,
    addRepickedListener = addRepickedListener,
    addHeroPickedListener = addHeroPickedListener,
    getStatEffects = getStatEffects,
    getSlot = getSlot,
    setSlot = setSlot,
    removeHero = removeHero,
    getUsedSlots = getUsedSlots,
    refreshUsedSlots = refreshUsedSlots,
}
