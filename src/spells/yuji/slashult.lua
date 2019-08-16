local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local collision = require('src/collision.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 25

local getSpellId = function()
    return 'slashult'
end

local getSpellName = function()
    return 'Spin'
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

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 9, 1)
    SetUnitFacing(hero, 0)

    casttime.cast(playerId, 0.3, false)

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    effect.createEffect{
        model = "grns",
        x = heroV.x,
        y = heroV.y,
        duration = 0.5,
    }

    SetUnitTimeScale(hero, 3)
    for i=0,320,40 do
        local facing = i * bj_DEGTORAD
        SetUnitFacing(hero, i)
        animations.queueAnimation(hero, 8, 1)
        local spawn = vector.fromAngle(facing)
        spawn = vector.multiply(spawn, 50)
        spawn = vector.add(heroV, spawn)
        effect.createEffect{
            model = "slsh",
            x = spawn.x,
            y = spawn.y,
            duration = 0.3,
            facing = i,
        }
    end

    local collidedUnits = collision.getAllCollisions(heroV, 350)
    for idx, unit in pairs(collidedUnits) do
        if IsUnitEnemy(unit, Player(playerId)) then
            damage.dealDamage(hero, unit, 400)

            effect.createEffect{
                model = "ebld",
                unit = unit,
                duration = 0.1,
            }
        end
    end

    SetUnitTimeScale(hero, 1)

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNWhirlwind.blp"
end

return {
    cast = cast,
    getCooldown = getCooldown,
    getTotalCooldown = getTotalCooldown,
    getIcon = getIcon,
}
