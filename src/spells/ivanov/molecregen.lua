local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local buff = require('src/buff.lua')
local collision = require('src/collision.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 100

local cooldowns = {}

local cast = function(playerId)
    if
        cooldowns[playerId] ~= nil and
        TimerGetRemaining(cooldowns[playerId]) > 0.05
    then
        log.log(playerId, "Molecular Regeneration is on cooldown!", log.TYPE.ERROR)
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

    local timer = CreateTimer()
    TimerStart(timer, COOLDOWN_S, false, nil)
    cooldowns[playerId] = timer

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
                local curHealth = BlzGetUnitRealField(unit, UNIT_RF_HP)
                BlzSetUnitRealField(
                    unit,
                    UNIT_RF_HP,
                    curHealth + 100 * buff.getHealingModifier(hero, unit))

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
    if cooldowns[playerId] ~= nil then
        return TimerGetRemaining(cooldowns[playerId])
    end
    return 0
end

local getTotalCooldown = function()
    return COOLDOWN_S
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
