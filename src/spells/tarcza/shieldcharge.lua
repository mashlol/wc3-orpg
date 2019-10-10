local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local buff = require('src/buff.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 60

local isStuck = function(unit)
    return IsUnitType(unit, UNIT_TYPE_STUNNED) or
        IsUnitType(unit, UNIT_TYPE_SNARED) or
        IsUnitType(unit, UNIT_TYPE_POLYMORPHED) or
        IsUnitPaused(unit)
end

local getSpellId = function()
    return 'shieldcharge'
end

local getSpellName = function()
    return 'Shield Charge'
end

local getSpellTooltip = function(playerId)
    return 'Tarcza charges forward with his shield, causing 400 damage to all impacted units, pushing them away and stunning them for 2 seconds.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.6
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
    animations.queueAnimation(hero, 12, 2)

    local facingAngle = bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x)
    SetUnitFacing(hero, facingAngle)

    projectile.createProjectile{
        playerId = playerId,
        model = "Valiant Charge Royal.mdl",
        scale = 1.3,
        height = 10,
        fromV = heroV,
        toV = mouseV,
        speed = 1250,
        length = 800,
    }

    projectile.createProjectile{
        playerId = playerId,
        projectile = hero,
        fromV = heroV,
        toV = mouseV,
        speed = 1200,
        length = 800,
        radius = 100,
        onCollide = function(collidedUnit)
            if IsUnitEnemy(collidedUnit, Player(playerId)) then
                damage.dealDamage(hero, collidedUnit, 400, damage.TYPE.PHYSICAL)

                buff.addBuff(hero, collidedUnit, 'stun', 2)

                local rand = GetRandomInt(0, 1)
                local dir = rand == 0 and 90 or -90

                local normalV = Vector:fromAngle((facingAngle + dir) * bj_DEGTORAD)
                    :normalize()
                    :multiply(100)
                    :add(Vector:new{x = GetUnitX(collidedUnit), y = GetUnitY(collidedUnit)})
                SetUnitPosition(collidedUnit, normalV.x, normalV.y)

                effect.createEffect{
                    unit = collidedUnit,
                    model = "Abilities\\Spells\\Orc\\Disenchant\\DisenchantSpecialArt.mdl",
                    duration = 1,
                }
            end
            return false
        end,
        onDestroy = function()
            effect.createEffect{
                unit = hero,
                model = "Abilities\\Spells\\Orc\\Disenchant\\DisenchantSpecialArt.mdl",
                duration = 1,
            }
            animations.queueAnimation(hero, 3, 0.6)
        end,
    }

    casttime.cast(playerId, 0.6, false)

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNDeathPact.blp"
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
