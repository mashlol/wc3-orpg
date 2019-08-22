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
local COOLDOWN_S = 10

local isStuck = function(unit)
    return IsUnitType(unit, UNIT_TYPE_STUNNED) or
        IsUnitType(unit, UNIT_TYPE_SNARED) or
        IsUnitType(unit, UNIT_TYPE_POLYMORPHED) or
        IsUnitPaused(unit)
end

local getSpellId = function()
    return 'punch'
end

local getSpellName = function()
    return 'Thunderfist'
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
    animations.queueAnimation(hero, 8, 1)

    SetUnitFacing(
        hero,
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x))

    local blueTrail = AddSpecialEffectTarget(
        "Abilities\\Weapons\\DragonHawkMissile\\DragonHawkMissile.mdl",
        hero,
        "chest")
    local punchTrail = AddSpecialEffectTarget(
        "Abilities\\Weapons\\WingedSerpentMissile\\WingedSerpentMissile.mdl",
        hero,
        "chest")
    local lightningTrail = AddSpecialEffectTarget(
        "Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl",
        hero,
        "origin")
    BlzPlaySpecialEffect(lightningTrail, ANIM_TYPE_WALK)

    projectile.createProjectile{
        playerId = playerId,
        projectile = hero,
        fromV = heroV,
        toV = mouseV,
        speed = 1500,
        length = 400,
        radius = 100,
        onCollide = function(collidedUnit)
            if IsUnitEnemy(collidedUnit, Player(playerId)) then
                damage.dealDamage(hero, collidedUnit, 350)
                effect.createEffect{
                    unit = collidedUnit,
                    model = "epui",
                    duration = 1,
                }
                return true
            end
            return false
        end,
        onDestroy = function()
            effect.createEffect{
                unit = hero,
                model = "epui",
                duration = 1,
            }
            casttime.stopCast(playerId)
            DestroyEffect(punchTrail)
            DestroyEffect(lightningTrail)
            DestroyEffect(blueTrail)
        end,
    }

    casttime.cast(playerId, 0.5, false)

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
}
