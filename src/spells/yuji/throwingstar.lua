local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local target = require('src/target.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 3.5

local getSpellId = function()
    return 'throwingstar'
end

local getSpellName = function()
    return 'Throwing Star'
end

local getSpellTooltip = function(playerId)
    return 'Throw 3 stars in front of you, dealing 30 damage each. Multiple stars can collide with a single unit.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0
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
    animations.queueAnimation(hero, 8, 1)

    local facingDeg =
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x)

    SetUnitFacingTimed(hero, facingDeg, 0.05)

    for i=-1,1,1 do
        local toV = Vector:fromAngle((facingDeg + i * 15) * bj_DEGTORAD)
            :add(heroV)
        projectile.createProjectile{
            playerId = playerId,
            model = "Abilities\\Weapons\\GlaiveMissile\\GlaiveMissile.mdl",
            scale = 0.3,
            height = 10,
            fromV = heroV,
            toV = toV,
            speed = 1400,
            length = 500,
            radius = 30,
            onCollide = function(collidedUnit)
                if IsUnitEnemy(collidedUnit, Player(playerId)) then
                    damage.dealDamage(hero, collidedUnit, 30, damage.TYPE.PHYSICAL)
                    return true
                end
                return false
            end
        }
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
    return "ReplaceableTextures\\CommandButtons\\BTNUpgradeMoonGlaive.blp"
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
