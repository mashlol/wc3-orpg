local unitmap = require('src/unitmap.lua')

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
            [8] = 'focus',
        },
    },
    [2] = {
        name = 'Stormfist',
        id = FourCC("Hstm"),
        spells = {
        }
    },
    [3] = {
        name = 'Ivanov',
        id = FourCC("Hivn"),
        spells = {
            [1] = 'rejuvpot',
            [2] = 'armorpot',
            [4] = 'molecregen',
            [5] = 'corrosiveblast',
            [8] = 'accmist',
        }
    },
    [4] = {
        name = 'Azora',
        id = FourCC("Hazr"),
        spells = {
            [1] = 'fireball',
            [2] = 'frostnova',
            [3] = 'heal',
            [4] = 'frostorb',
            [8] = 'blink',
        }
    },
}

local respawn = function()
    local unit = GetDyingUnit()

    TriggerSleepAction(5)

    for i=0, bj_MAX_PLAYERS, 1 do
        if unit == heroes[i] then
            heroes[i] = unitmap.createTargetableUnit(
                Player(i), pickedHeroes[i].id, -150, -125, 0)
            UnitRemoveAbility(heroes[i], FourCC('Aatk'))
        end
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
            heroes[playerId] = unitmap.createTargetableUnit(
                Player(playerId), hero.id, -150, -125, 0)
            UnitRemoveAbility(heroes[playerId], FourCC('Aatk'))
        end)
    end

    for i=0,bj_MAX_PLAYERS,1 do
        DialogDisplay(Player(i), dialog, true)
    end
end

local init = function()
    local trigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trigger, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(trigger, respawn)

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
