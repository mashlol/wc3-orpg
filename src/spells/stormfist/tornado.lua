local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local collision = require('src/collision.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local log = require('src/log.lua')
local buff = require('src/buff.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local target = require('src/target.lua')
local casttime = require('src/casttime.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 15

local getSpellId = function()
    return 'tornado'
end

local getSpellName = function()
    return 'Divine Tornado'
end

local getSpellTooltip = function(playerId)
    return 'Summon a tornado from your hands as a beam of power, dealing massive damage and slowing any targets in its way'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.5
end

local getCollisionPoint = function(heroV, facingDeg, i, j)
    local perpendicularAngle = (facingDeg + 90) * bj_DEGTORAD
    local perpendicularVec = Vector:fromAngle(perpendicularAngle)
        :multiply(i * 50)
        :add(heroV)
    return Vector:fromAngle(facingDeg * bj_DEGTORAD)
        :multiply(j * 550)
        :add(perpendicularVec)
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

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 16, 3)

    SetUnitFacingTimed(
        hero,
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x),
        0.05)

    local success = casttime.cast(playerId, 0.5, true, false)
    if not success then
        return false
    end

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    animations.queueAnimation(hero, 7, 3)

    local sfx = effect.createEffect{
        x = GetUnitX(hero),
        y = GetUnitY(hero),
        model = "Abilities\\Spells\\Other\\Tornado\\TornadoElementalSmall.mdl",
        duration = 3,
        timeScale = 1.5,
        z = 50,
        pitchRad = math.pi / 2,
        facing = Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x),
    }

    local DPS = 100
    local timerSpeed = 0.01
    local dmgFrequency = 0.1

    local numTicks = 0

    local timer = CreateTimer()
    TimerStart(timer, timerSpeed, true, function()
        numTicks = numTicks + 1

        local newMouseV = Vector:new{
            x = mouse.getMouseX(playerId),
            y = mouse.getMouseY(playerId)
        }

        local facingRad = Atan2(newMouseV.y - heroV.y, newMouseV.x - heroV.x)
        local facingDeg = bj_RADTODEG * facingRad
        BlzSetSpecialEffectYaw(sfx, facingRad)
        SetUnitFacingTimed(hero, facingDeg, 0.05)

        if numTicks % (dmgFrequency / timerSpeed) == 0 then
            local shape = {
                getCollisionPoint(heroV, facingDeg, 1, 0),
                getCollisionPoint(heroV, facingDeg, -1, 0),
                getCollisionPoint(heroV, facingDeg, -1, 1),
                getCollisionPoint(heroV, facingDeg, 1, 1),
            }

            local collidedUnits = collision.getAllCollisions(shape)
            for _, unit in pairs(collidedUnits) do
                if IsUnitEnemy(unit, Player(playerId)) then
                    damage.dealDamage(hero, unit, DPS * dmgFrequency, damage.TYPE.SPELL)
                    buff.addBuff(hero, unit, 'tornado', dmgFrequency * 2)
                end
            end
        end
    end)

    casttime.cast(playerId, 3, false, false)

    DestroyTimer(timer)

    target.restoreOrder(playerId)

    return true
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNTornado.blp"
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
