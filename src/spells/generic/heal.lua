local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 0.5

local getSpellId = function()
    return 'heal'
end

local getSpellName = function()
    return 'Heal'
end

local getSpellTooltip = function(playerId)
    return 'Heal'
end

local getSpellCooldown = function(playerId)
    return 0
end

local getSpellCasttime = function(playerId)
    return 0
end

local cast = function(playerId)
    if cooldowns.isOnCooldown(playerId, getSpellId()) then
        log.log(playerId, getSpellName().." is on cooldown!", log.TYPE.ERROR)
        return false
    end

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    local hero = hero.getHero(playerId)
    local heroV = Vector:new{x = GetUnitX(hero), y = GetUnitY(hero)}
    local mouseV = Vector:new{
        x = mouse.getMouseX(playerId),
        y = mouse.getMouseY(playerId)
    }

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 9, 1)

    SetUnitFacingTimed(
        hero,
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x),
        0.05)

    projectile.createProjectile{
        playerId = playerId,
        model = "ehea",
        fromV = heroV,
        toV = mouseV,
        speed = 1000,
        length = 1000,
        destroyOnCollide = false,
        onCollide = function(collidedUnit)
            if IsUnitAlly(collidedUnit, Player(playerId)) then
                damage.heal(hero, collidedUnit, 50)

                effect.createEffect{
                    model = "Abilities\\Spells\\Human\\Heal\\HealTarget.mdl",
                    unit = collidedUnit,
                    duration = 0.5,
                    z = 35,
                }

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
    return "ReplaceableTextures\\CommandButtons\\BTNHealingWave.blp"
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
