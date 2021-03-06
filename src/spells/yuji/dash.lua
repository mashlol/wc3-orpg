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
local COOLDOWN_S = 1
local COOLDOWN_S_LONG = 15

local storedData = {}

local isStuck = function(unit)
    return IsUnitType(unit, UNIT_TYPE_STUNNED) or
        IsUnitType(unit, UNIT_TYPE_SNARED) or
        IsUnitType(unit, UNIT_TYPE_POLYMORPHED) or
        IsUnitPaused(unit)
end

local getSpellId = function()
    return 'dash'
end

local getSpellName = function()
    return 'Dash'
end

local getSpellTooltip = function(playerId)
    return 'Dash forward, dealing 10 damage to all units struck. Can be recast quickly after the first activation.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.15
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

    if storedData[playerId] == nil then
        storedData[playerId] = {
            attackCount = -1,
        }
    end

    storedData[playerId].attackCount =
        (storedData[playerId].attackCount + 1) % 2

    cooldowns.startCooldown(
        playerId,
        getSpellId(),
        storedData[playerId].attackCount == 1 and
            COOLDOWN_S_LONG or
            COOLDOWN_S)

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 8, 1)

    SetUnitFacing(
        hero,
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x))

    projectile.createProjectile{
        playerId = playerId,
        model = "Valiant Charge.mdl",
        height = 35,
        fromV = heroV,
        toV = mouseV,
        speed = 4000,
        length = 500,
        onCollide = function(collidedUnit)
            if IsUnitEnemy(collidedUnit, Player(playerId)) then
                damage.dealDamage(hero, collidedUnit, 10, damage.TYPE.PHYSICAL)
            end
            return false
        end,
        onDoodadCollide = function(doodad)
            return true
        end,
    }

    projectile.createProjectile{
        playerId = playerId,
        projectile = hero,
        fromV = heroV,
        toV = mouseV,
        speed = 4000,
        length = 500,
        onDoodadCollide = function(doodad)
            return true
        end,
    }

    casttime.cast(playerId, 0.15, false, false, true)

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNDizzy.blp"
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
