local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local animations = require('src/animations.lua')
local buff = require('src/buff.lua')
local casttime = require('src/casttime.lua')
local collision = require('src/collision.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 20

local getSpellId = function()
    return 'accmist'
end

local getSpellName = function()
    return 'Accelerator Mist'
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

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    casttime.cast(playerId, 0.15, false)

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 8, 1)

    local facingDeg =
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x)

    SetUnitFacingTimed(hero, facingDeg, 0.05)

    local locations = {}
    for j=0,6,1 do
        for i=-1,1,1 do
            local perpendicularAngle = (facingDeg + 90) * bj_DEGTORAD
            local perpendicularVec = vector.fromAngle(perpendicularAngle)
            perpendicularVec = vector.multiply(perpendicularVec, i * 50)
            perpendicularVec = vector.add(perpendicularVec, heroV)
            local straightVec = vector.fromAngle(facingDeg * bj_DEGTORAD)
            straightVec = vector.multiply(straightVec, j * 100)
            local finalVec = vector.add(perpendicularVec, straightVec)
            effect.createEffect{
                model = "eacc",
                x = finalVec.x,
                y = finalVec.y,
                duration = 10,
                facing = facingDeg,
                timeScale = 10,
            }

            table.insert(locations, finalVec)
        end

        applySpeedBuff(playerId, locations, hero)
        TriggerSleepAction(0.1)
    end

    for i=1,15,1 do
        TriggerSleepAction(0.5)
        applySpeedBuff(playerId, locations, hero)
    end

    return true
end

function applySpeedBuff(playerId, locations, hero)
    for idx, loc in pairs(locations) do
        local collidedUnits = collision.getAllCollisions(loc, 50)
        for idx, unit in pairs(collidedUnits) do
            if IsUnitAlly(unit, Player(playerId)) then
                buff.addBuff(hero, unit, 'accpot', 3)
            end
        end
    end
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNAcidBomb.blp"
end

return {
    cast = cast,
    getCooldown = getCooldown,
    getTotalCooldown = getTotalCooldown,
    getIcon = getIcon,
}
