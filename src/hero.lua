local heroes = {}
local pickedHeroes = {}

local ALL_HERO_INFO = {
    [1] = {
        name = 'Yuji',
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
        },
    },
    [2] = {
        name = 'Stormfist',
        id = FourCC("Hstm"),
        spells = {
            [1] = 'punch',
            [5] = 'attack',
            [6] = 'stop',
        },
    },
    [3] = {
        name = 'Ivanov',
        id = FourCC("Hivn"),
        spells = {
            [1] = 'rejuvpot',
            [2] = 'armorpot',
            [4] = 'molecregen',
            [5] = 'attack',
            [6] = 'stop',
            [7] = 'corrosiveblast',
            [8] = 'accmist',
        },
    },
    [4] = {
        name = 'Azora',
        id = FourCC("Hazr"),
        spells = {
            [1] = 'fireball',
            [2] = 'frostnova',
            [3] = 'firelance',
            [4] = 'meteor',
            [5] = 'attack',
            [6] = 'stop',
            [8] = 'blink',
            [12] = 'frostorb',
        },
    },
}

local respawn = function()
    local unit = GetDyingUnit()

    TriggerSleepAction(5)

    for i=0, bj_MAX_PLAYERS, 1 do
        if unit == heroes[i] then
            createHeroForPlayer(i)
        end
    end
end

function createHeroForPlayer(playerId)
    heroes[playerId] = CreateUnit(
        Player(playerId), pickedHeroes[playerId].id, -150, -125, 0)
    BlzSetUnitIntegerField(heroes[playerId], UNIT_IF_STRENGTH, 0)
    BlzSetUnitIntegerField(heroes[playerId], UNIT_IF_INTELLIGENCE, 0)
    BlzSetUnitIntegerField(heroes[playerId], UNIT_IF_AGILITY, 0)
    SuspendHeroXP(heroes[playerId], true)

    if playerId == GetPlayerId(GetLocalPlayer()) then
        ClearSelection()
        SelectUnit(heroes[playerId], true)
    end
end

local showPickHeroDialog = function()
    -- TODO a better way to pick heroes
    local dialog = DialogCreate()

    for idx,hero in pairs(ALL_HERO_INFO) do
        local pickHeroButton = DialogAddButton(dialog, hero.name, 0)
        local pickHeroTrigger = CreateTrigger()
        TriggerRegisterDialogButtonEvent(pickHeroTrigger, pickHeroButton)
        TriggerAddAction(pickHeroTrigger, function()
            local playerId = GetPlayerId(GetTriggerPlayer())
            pickedHeroes[playerId] = hero
            createHeroForPlayer(playerId)
        end)
    end

    for i=0,bj_MAX_PLAYERS,1 do
        DialogDisplay(Player(i), dialog, true)
    end
end

function onRepick()
    local repickPlayerId = GetPlayerId(GetTriggerPlayer())
    RemoveUnit(heroes[repickPlayerId])
    showPickHeroDialog()
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

    showPickHeroDialog()
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
