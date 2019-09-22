local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local collision = require('src/collision.lua')
local log = require('src/log.lua')
local buff = require('src/buff.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 15

local getSpellId = function()
    return 'curshout'
end

local getSpellName = function()
    return 'Courageous Shout'
end

local getSpellTooltip = function(playerId)
    return 'Tarcza shouts courageously, reducing the movement speed of nearby enemies by 40% for 5 seconds.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.2
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

    animations.queueAnimation(hero, 9, 1)

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    effect.createEffect{
        model = "Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl",
        unit = hero,
        duration = 1,
        scale = 0.7,
    }

    local collidedUnits = collision.getAllCollisions(heroV, 400)
    for idx, unit in pairs(collidedUnits) do
        if IsUnitEnemy(unit, Player(playerId)) then
            buff.addBuff(hero, unit, 'curshout', 5)
        end
    end

    casttime.cast(playerId, 0.2, false)

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNBattleRoar.blp"
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

