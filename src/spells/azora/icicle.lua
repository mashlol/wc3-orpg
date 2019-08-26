local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local buff = require('src/buff.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local casttime = require('src/casttime.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 0.5

local getSpellId = function()
    return 'icicle'
end

local getSpellName = function()
    return 'Icicle'
end

local getSpellTooltip = function(playerId)
    return 'Azora fires a blast of frost energy from her, dealing 50 damage to the first enemy struck. If the enemy is frozen, the damage is increased five-fold.'
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

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 19, 1)

    SetUnitFacingTimed(
        hero,
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x),
        0.05)

    casttime.cast(playerId, 0.2, false)

    animations.queueAnimation(hero, 18, 1)

    projectile.createProjectile{
        playerId = playerId,
        model = "eici",
        fromV = heroV,
        toV = mouseV,
        speed = 2000,
        length = 800,
        radius = 30,
        onCollide = function(collidedUnit)
            if IsUnitEnemy(collidedUnit, Player(playerId)) then
                if buff.hasBuff(collidedUnit, 'frostnova') then
                    damage.dealDamage(hero, collidedUnit, 250)
                else
                    damage.dealDamage(hero, collidedUnit, 50)
                end
                return true
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
    return "ReplaceableTextures\\CommandButtons\\BTNBreathOfFrost.blp"
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
