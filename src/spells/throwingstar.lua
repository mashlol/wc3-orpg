local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local animations = require('src/animations.lua')
local buff = require('src/buff.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 3.5

local cooldowns = {}

local cast = function(playerId)
    if
        cooldowns[playerId] ~= nil and
        TimerGetRemaining(cooldowns[playerId]) > 0.05
    then
        log.log(playerId, "Throwing Star is on cooldown!", log.TYPE.ERROR)
        return false
    end

    if cooldowns[playerId] ~= nil then
        DestroyTimer(cooldowns[playerId])
        cooldowns[playerId] = nil
    end

    local hero = hero.getHero(playerId)
    local heroV = vector.create(GetUnitX(hero), GetUnitY(hero))
    local mouseV = vector.create(
        mouse.getMouseX(playerId),
        mouse.getMouseY(playerId))

    local timer = CreateTimer()
    TimerStart(timer, COOLDOWN_S, false, nil)
    cooldowns[playerId] = timer

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 8, 1)

    local facingDeg =
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x)

    SetUnitFacingTimed(hero, facingDeg, 0.05)

    for i=-1,1,1 do
        local toV = vector.fromAngle((facingDeg + i * 15) * bj_DEGTORAD)
        toV = vector.add(heroV, toV)
        projectile.createProjectile{
            playerId = playerId,
            model = "star",
            fromV = heroV,
            toV = toV,
            speed = 1400,
            length = 500,
            radius = 30,
            onCollide = function(collidedUnit)
                if IsUnitEnemy(collidedUnit, Player(playerId)) then
                    UnitDamageTargetBJ(
                        hero,
                        collidedUnit,
                        30 * buff.getDamageModifier(hero),
                        ATTACK_TYPE_PIERCE,
                        DAMAGE_TYPE_UNKNOWN)
                    return true
                end
                return false
            end
        }
    end

    return true
end

local getCooldown = function(playerId)
    if cooldowns[playerId] ~= nil then
        return TimerGetRemaining(cooldowns[playerId])
    end
    return 0
end

local getTotalCooldown = function()
    return COOLDOWN_S
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNUpgradeMoonGlaive.blp"
end

return {
    cast = cast,
    getCooldown = getCooldown,
    getTotalCooldown = getTotalCooldown,
    getIcon = getIcon,
}
