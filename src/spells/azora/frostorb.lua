local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 160

local getSpellId = function()
    return 'frostorb'
end

local getSpellName = function()
    return 'Frost Orb'
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
    animations.queueAnimation(hero, 16, 2)

    local castSuccess = casttime.cast(playerId, 1)
    if not castSuccess then
        return false
    end

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    animations.queueAnimation(hero, 8, 2)

    for x=0,30,10 do
        for i=x,360+x,40 do
            local toV = vector.fromAngle(bj_DEGTORAD * i)

            projectile.createProjectile{
                playerId = playerId,
                model = "efor",
                fromV = mouseV,
                toV = vector.add(mouseV, toV),
                speed = 300,
                length = 350,
                onCollide = function(collidedUnit)
                    if IsUnitEnemy(collidedUnit, Player(playerId)) then
                        damage.dealDamage(hero, collidedUnit, 50)
                        return true
                    end
                    return false
                end
            }
        end
        TriggerSleepAction(0.03)
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
    return "ReplaceableTextures\\CommandButtons\\BTNFrostBolt.blp"
end

return {
    cast = cast,
    getSpellId = getSpellId,
    getSpellName = getSpellName,
    getIcon = getIcon,
}
