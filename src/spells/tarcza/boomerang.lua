local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 5

local isStuck = function(unit)
    return IsUnitType(unit, UNIT_TYPE_STUNNED) or
        IsUnitType(unit, UNIT_TYPE_SNARED) or
        IsUnitType(unit, UNIT_TYPE_POLYMORPHED) or
        IsUnitPaused(unit)
end

local getSpellId = function()
    return 'boomerang'
end

local getSpellName = function()
    return 'Shield Boomerang'
end

local getSpellTooltip = function(playerId)
    return 'Tarcza throws a shield of lightning forward, dealing 50 damage to all enemies struck. It will then return to Tarcza, dealing 100 damage on the way back.'
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

    if isStuck(hero) then
        log.log(playerId, "You can't move right now", log.TYPE.ERROR)
        return false
    end

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 3, 1)

    local facingAngle = bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x)
    SetUnitFacing(hero, facingAngle)

    projectile.createProjectile{
        playerId = playerId,
        model = "LightningShield.mdl",
        pitch = -math.pi,
        roll = -math.pi / 2,
        z = 50,
        scale = 1.5,
        fromV = heroV,
        toV = mouseV,
        speed = 800,
        length = 650,
        removeInsteadOfKill = true,
        onCollide = function(collidedUnit)
            if IsUnitEnemy(collidedUnit, Player(playerId)) then
                damage.dealDamage(hero, collidedUnit, 50)
            end
            return false
        end,
        onDestroy = function(proj)
            projectile.createProjectile{
                playerId = playerId,
                model = "LightningShield.mdl",
                fromV = Vector:new{
                    x = proj.x,
                    y = proj.y,
                },
                pitch = math.pi,
                roll = math.pi / 2,
                z = 50,
                scale = 1.5,
                destUnit = hero,
                speed = 650,
                removeInsteadOfKill = true,
                onCollide = function(collidedUnit)
                    if IsUnitEnemy(collidedUnit, Player(playerId)) then
                        damage.dealDamage(hero, collidedUnit, 100)
                    end
                    return false
                end
            }
        end,
    }

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
    return "ReplaceableTextures\\CommandButtons\\BTNDefendStop.blp"
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
