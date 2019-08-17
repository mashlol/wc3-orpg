local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 35

local getSpellId = function()
    return 'meteor'
end

local getSpellName = function()
    return 'Meteor'
end

function createTargetEffect(mouseV)
    effect.createEffect{
        model = "etst",
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

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 19, 2)

    local castSuccess = casttime.cast(playerId, 1)
    if not castSuccess then
        return false
    end

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)
    animations.queueAnimation(hero, 18, 1)

    createTargetEffect(mouseV)

    TriggerSleepAction(0.5)

    createTargetEffect(mouseV)

    TriggerSleepAction(0.5)

    createTargetEffect(mouseV)

    effect.createEffect{
        model = "emet",
        x = mouseV.x,
        y = mouseV.y,
        timeScale = 0.6,
        duration = 2,
    }

    TriggerSleepAction(0.5)

    createTargetEffect(mouseV)

    TriggerSleepAction(0.5)

    createTargetEffect(mouseV)
    effect.createEffect{
        model = "emei",
        x = mouseV.x,
        y = mouseV.y,
        duration = 1,
    }

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
}
