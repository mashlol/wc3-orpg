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
local COOLDOWN_S = 30

-- storedData = {
--     [playerId] = {
--         balls = {[proj1], [proj2], etc},
--     }
-- }
local storedData = {}

local getSpellId = function()
    return 'frostball'
end

local getSpellName = function()
    return 'Fingers of Frost'
end

local getSpellTooltip = function(playerId)
    return 'TODO'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.4
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
    if existingBall ~= nil then
        SetUnitFacingTimed(
            hero,
            bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x),
            0.05)

        IssueImmediateOrder(hero, "stop")
        animations.queueAnimation(hero, 19, 1)

        casttime.cast(playerId, 0.2, false)

        animations.queueAnimation(hero, 18, 1)

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
            model = "Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl",
            fromV = oldLocation,
            toV = mouseV,
            speed = 900,
            length = 800,
            onCollide = function(collidedUnit)
                if IsUnitEnemy(collidedUnit, Player(playerId)) then
                    if buff.hasBuff(collidedUnit, 'frostnova') then
                        damage.dealDamage(hero, collidedUnit, 160)
                    else
                        damage.dealDamage(hero, collidedUnit, 40)
                    end
                    return true
                end
                return false
            end
        }

        target.restoreOrder(playerId)

        return true
    end

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 19, 1)

    SetUnitFacingTimed(
        hero,
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x),
        0.05)

    casttime.cast(playerId, 1, false)

    animations.queueAnimation(hero, 18, 1)

    buff.addBuff(hero, hero, 'frostball', 14400)

    local balls = {}

    for i=0,2,1 do
        local startRad = i * ((2 * math.pi) / 3)
        local ball = projectile.createProjectile{
            playerId = playerId,
            model = "Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl",
            fromUnit = hero,
            speed = 200,
            fromRadius = 80,
            toRadius = 80,
            fromAngle = startRad,
            toAngle = startRad + math.pi * 2,
            permanent = true,
            onCollide = function(collidedUnit)
                if IsUnitEnemy(collidedUnit, Player(playerId)) then
                    buff.addBuff(hero, collidedUnit, 'frostballslow', 8)
                    damage.dealDamage(hero, collidedUnit, 40)

                    return true
                end
                return false
            end,
            onDestroy = function()
                storedData[playerId].balls[i + 1] = nil

                if getBall(playerId) == nil then
                    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)
                    buff.removeBuff(hero, 'frostball')
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
    return "ReplaceableTextures\\CommandButtons\\BTNFrostBolt.blp"
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
