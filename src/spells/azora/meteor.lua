local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local log = require('src/log.lua')
local buff = require('src/buff.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local target = require('src/target.lua')
local collision = require('src/collision.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 10

local getSpellId = function()
    return 'meteor'
end

local getSpellName = function()
    return 'Meteor'
end

local getSpellTooltip = function(playerId)
    return 'Azora calls upon the heavens to bring a meteor down to earth. The meteor will fall after 2 seconds, dealing 400 damage to all units in the area.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 1
end

function createTargetEffect(mouseV)
    effect.createEffect{
        model = "Abilities\\Spells\\Other\\Silence\\SilenceAreaBirth.mdl",
        x = mouseV.x,
        y = mouseV.y,
        timeScale = 0.5,
        duration = 0.5,
    }
end

local cast = function(playerId)
    if cooldowns.isOnCooldown(playerId, getSpellId()) then
        log.log(playerId, getSpellName().." is on cooldown!", log.TYPE.ERROR)
        return false
    end

    local hero = hero.getHero(playerId)
    local heroV = Vector:new{x = GetUnitX(hero), y = GetUnitY(hero)}
    local mouseV = Vector:new{
        x = mouse.getMouseX(playerId),
        y = mouse.getMouseY(playerId)
    }

    local dist = Vector:new(heroV):subtract(mouseV)
    local mag = dist:magnitude()
    if mag > 800 then
        log.log(playerId, "Out of range!", log.TYPE.ERROR)
        return false
    end

    if not IsVisibleToPlayer(mouseV.x, mouseV.y, Player(playerId)) then
        log.log(playerId, "Target not in line of sight.", log.TYPE.ERROR)
        return false
    end

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 19, 2)

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    casttime.cast(playerId, 1, false)

    animations.queueAnimation(hero, 18, 1)

    createTargetEffect(mouseV)

    TriggerSleepAction(0.5)

    createTargetEffect(mouseV)

    TriggerSleepAction(0.5)

    createTargetEffect(mouseV)

    effect.createEffect{
        model = "Abilities\\Spells\\Demon\\RainOfFire\\RainOfFireTarget.mdl",
        x = mouseV.x,
        y = mouseV.y,
        timeScale = 0.7,
        duration = 2,
        scale = 3.5,
    }

    TriggerSleepAction(0.5)

    createTargetEffect(mouseV)

    TriggerSleepAction(0.5)

    createTargetEffect(mouseV)
    effect.createEffect{
        model = "Pillar of Flame Orange.mdl",
        x = mouseV.x,
        y = mouseV.y,
        duration = 1,
    }

    local collidedUnits = collision.getAllCollisions(mouseV, 350)
    for idx, unit in pairs(collidedUnits) do
        if IsUnitEnemy(unit, Player(playerId)) then
            damage.dealDamage(hero, unit, 250, damage.TYPE.SPELL)
            buff.addBuff(hero, unit, 'ignite', 8)
            buff.addBuff(hero, unit, 'ignite', 8)
        end
    end

    target.restoreOrder(playerId)

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNOrbOfFire.blp"
end

return {
    cast = cast,
    getSpellId = getSpellId,
    getSpellName = getSpellName,
    getIcon = getIcon,
    getSpellTooltip = getSpellTooltip,
    getSpellCooldown = getSpellCooldown,
    getSpellCasttime = getSpellCasttime,
}
