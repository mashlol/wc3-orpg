local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 0.1

local cooldowns = {}

local isStuck = function(unit)
    return IsUnitType(unit, UNIT_TYPE_STUNNED) or
        IsUnitType(unit, UNIT_TYPE_SNARED) or
        IsUnitType(unit, UNIT_TYPE_POLYMORPHED)
end

local cast = function(playerId)
    if
        cooldowns[playerId] ~= nil and
        TimerGetRemaining(cooldowns[playerId]) > 0.05
    then
        log.log(playerId, "Blink is on cooldown!", log.TYPE.ERROR)
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

    if isStuck(hero) then
        log.log(playerId, "You can't move right now", log.TYPE.ERROR)
        return false
    end

    local dist = vector.subtract(heroV, mouseV)
    local mag = vector.magnitude(dist)
    if mag > 800 then
        log.log(playerId, "Out of range!", log.TYPE.ERROR)
        return false
    end

    local timer = CreateTimer()
    TimerStart(timer, COOLDOWN_S, false, nil)
    cooldowns[playerId] = timer

    IssueImmediateOrder(hero, "stop")
    SetUnitAnimationByIndex(hero, 11)

    effect.createEffect{
        model = "eblk",
        unit = hero,
        duration = 0.5,
    }

    casttime.cast(playerId, 0.3, false)

    SetUnitX(hero, mouseV.x)
    SetUnitY(hero, mouseV.y)
    SetUnitFacing(
        hero,
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x))

    effect.createEffect{
        model = "eblk",
        unit = hero,
        duration = 0.5,
    }

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

return {
    cast = cast,
    getCooldown = getCooldown,
    getTotalCooldown = getTotalCooldown,
}
