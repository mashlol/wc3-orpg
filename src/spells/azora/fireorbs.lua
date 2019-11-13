local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local buff = require('src/buff.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local casttime = require('src/casttime.lua')
local cooldowns = require('src/spells/cooldowns.lua')
local target = require('src/target.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 7

-- storedData = {
--     [playerId] = {
--         balls = {[proj1], [proj2], etc},
--     }
-- }
local storedData = {}

local getSpellId = function()
    return 'fireorbs'
end

local getSpellName = function()
    return 'Fire Orbs'
end

local getSpellTooltip = function(playerId)
    return 'Summon 5 orbs of fire that surround you. Re cast to throw the orbs toward the target direction.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 1.5
end

local getBall = function(playerId)
    if storedData[playerId] ~= nil then
        for _, val in pairs(storedData[playerId].balls) do
            return val
        end
    end
    return nil
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

    local existingBall = getBall(playerId)
    local hadBalls = false
    if existingBall ~= nil then
        SetUnitFacingTimed(
            hero,
            bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x),
            0.05)

        IssueImmediateOrder(hero, "stop")
        animations.queueAnimation(hero, 3, 1)

        casttime.cast(playerId, 0.3, false)
    end

    local finalV = Vector:new(mouseV)
        :subtract(heroV)

    if finalV:magnitude() > 800 then
        finalV:normalize()
            :multiply(800)
    end

    finalV:add(heroV)
    while existingBall ~= nil do
        local oldLocation = Vector:new{
            x = existingBall.x,
            y = existingBall.y,
        }

        -- Remove old ball from projectile system
        existingBall.removeInsteadOfKill = true
        projectile.destroyProjectile(existingBall)

        -- Project a new ball
        projectile.createProjectile{
            playerId = playerId,
            model = "Abilities\\Weapons\\LordofFlameMissile\\LordofFlameMissile.mdl",
            scale = 0.4,
            z = 50,
            fromV = oldLocation,
            toV = finalV,
            speed = 1400,
            onCollide = function(collidedUnit)
                if IsUnitEnemy(collidedUnit, Player(playerId)) then
                    damage.dealDamage(hero, collidedUnit, 50, damage.TYPE.SPELL)
                    return true
                end
                return false
            end
        }

        hadBalls = true
        existingBall = getBall(playerId)
    end

    if hadBalls then
        target.restoreOrder(playerId)
        return true
    end

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 4, 2)

    casttime.cast(playerId, 1.5, false)

    animations.queueAnimation(hero, 3, 1)

    buff.addBuff(hero, hero, 'frostball', 14400)

    local balls = {}

    for i=0,4,1 do
        local startRad = i * ((2 * math.pi) / 5)
        local ball = projectile.createProjectile{
            playerId = playerId,
            model = "Abilities\\Weapons\\LordofFlameMissile\\LordofFlameMissile.mdl",
            scale = 0.4,
            z = 50,
            fromUnit = hero,
            speed = 200,
            fromRadius = 80,
            toRadius = 80,
            fromAngle = startRad,
            toAngle = startRad + math.pi * 2,
            permanent = true,
            onCollide = function(collidedUnit)
                if IsUnitEnemy(collidedUnit, Player(playerId)) then
                    damage.dealDamage(hero, collidedUnit, 40, damage.TYPE.SPELL)

                    return true
                end
                return false
            end,
            onDestroy = function()
                storedData[playerId].balls[i + 1] = nil

                if getBall(playerId) == nil then
                    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)
                end
            end
        }
        table.insert(balls, ball)
    end

    if storedData[playerId] == nil then
        storedData[playerId] = {}
    end
    storedData[playerId].balls = balls

    target.restoreOrder(playerId)

    return true
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNSoulBurn.blp"
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
