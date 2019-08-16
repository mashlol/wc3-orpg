local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local collision = require('src/collision.lua')
local damage = require('src/damage.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 100

local getSpellId = function()
    return 'molecregen'
end

local getSpellName = function()
    return 'Molecular Regeneration'
end

local cast = function(playerId)
    if cooldowns.isOnCooldown(playerId, getSpellId()) then
        log.log(playerId, getSpellName().." is on cooldown!", log.TYPE.ERROR)
        return false
    end

    local hero = hero.getHero(playerId)

    local heroV = vector.create(GetUnitX(hero), GetUnitY(hero))
    local mouseV = vector.create(
        mouse.getMouseX(playerId),
        mouse.getMouseY(playerId))

    local dist = vector.subtract(heroV, mouseV)
    local mag = vector.magnitude(dist)
    if mag > 800 then
        log.log(playerId, "Out of range!", log.TYPE.ERROR)
        return false
    end

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 17, 2)

    local castSuccess = casttime.cast(playerId, 1)
    if not castSuccess then
        return false
    end

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    animations.queueAnimation(hero, 18, 2)

    projectile.createProjectile{
        playerId = playerId,
        model = "erej",
        fromV = heroV,
        toV = mouseV,
        speed = 500,
        destroyOnCollide = false,
        onDestroy = function()
            effect.createEffect{
                model = "ecld",
                duration = 10,
                x = mouseV.x,
                y = mouseV.y,
            }
        end
    }

    for i=1,10,1 do
        TriggerSleepAction(1)

        local collidedUnits = collision.getAllCollisions(mouseV, 550)
        for idx, unit in pairs(collidedUnits) do
            if IsUnitAlly(unit, Player(playerId)) then
                damage.heal(hero, unit, 100)

                effect.createEffect{
                    model = "ehet",
                    unit = unit,
                    duration = 0.1,
                }
            end
        end
    end

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNPlagueCloud.blp"
end

return {
    cast = cast,
    getCooldown = getCooldown,
    getTotalCooldown = getTotalCooldown,
    getIcon = getIcon,
}
