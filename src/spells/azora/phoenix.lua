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
local COOLDOWN_S = 120

local getSpellId = function()
    return 'phoenix'
end

local getSpellName = function()
    return 'Phoenix'
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
    animations.queueAnimation(hero, 19, 3)

    SetUnitFacingTimed(
        hero,
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x),
        0.05)

    casttime.cast(playerId, 2, false)

    animations.queueAnimation(hero, 18, 1)

    projectile.createProjectile{
        playerId = playerId,
        model = "epht",
        fromV = heroV,
        toV = mouseV,
        speed = 800,
        length = 600,
        radius = 100,
    }

    local tickNum = 0
    projectile.createProjectile{
        playerId = playerId,
        model = "epho",
        fromV = heroV,
        toV = mouseV,
        speed = 800,
        length = 600,
        radius = 100,
        onMove = function(x, y)
            if tickNum % 20 == 0 then
                effect.createEffect{
                    model = "ephr",
                    x = x,
                    y = y,
                    duration = 4,
                }
            end
            tickNum = tickNum + 1
        end,
        onCollide = function(collidedUnit)
            if IsUnitEnemy(collidedUnit, Player(playerId)) then
                damage.dealDamage(hero, collidedUnit, 400)
                buff.addBuff(hero, collidedUnit, 'ignite', 8)
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
    return "ReplaceableTextures\\CommandButtons\\BTNPhoenixEgg.blp"
end

return {
    cast = cast,
    getSpellId = getSpellId,
    getSpellName = getSpellName,
    getIcon = getIcon,
}
