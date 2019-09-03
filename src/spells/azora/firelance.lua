local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local buff = require('src/buff.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local casttime = require('src/casttime.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 10

local getSpellId = function()
    return 'firelance'
end

local getSpellName = function()
    return 'Firelance'
end

local getSpellTooltip = function(playerId)
    return 'Azora throws a lance of fire, peircing targets, dealing 200 damage and stunning all targets hit for 2 seconds.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.4
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

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 4, 1)

    SetUnitFacingTimed(
        hero,
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x),
        0.05)

    casttime.cast(playerId, 0.4, false)

    animations.queueAnimation(hero, 3, 1)

    projectile.createProjectile{
        playerId = playerId,
        model = "elan",
        fromV = heroV,
        toV = mouseV,
        speed = 2000,
        length = 800,
        radius = 30,
        onCollide = function(collidedUnit)
            if IsUnitEnemy(collidedUnit, Player(playerId)) then
                damage.dealDamage(hero, collidedUnit, 200)
                buff.addBuff(hero, collidedUnit, 'firelance', 2)
                buff.addBuff(hero, collidedUnit, 'ignite', 8)
            end
            return false
        end
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
    return "ReplaceableTextures\\CommandButtons\\BTNFire.blp"
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
