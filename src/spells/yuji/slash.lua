local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local collision = require('src/collision.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local target = require('src/target.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 0.5
local COOLDOWN_S_LONG = 10

local storedData = {}

local getSpellId = function()
    return 'slash'
end

local getSpellName = function()
    return 'Slash'
end

local getSpellTooltip = function(playerId)
    return 'The 1st and 2nd activation have 0.5s cooldown and deal 50 damage to all units in front of Yuji. The 3rd activation deals 300 damage and has a 5 second cooldown.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.4
end

local getCollisionPoint = function(heroV, facingDeg, i, j)
    local perpendicularAngle = (facingDeg + 90) * bj_DEGTORAD
    local perpendicularVec = Vector:fromAngle(perpendicularAngle)
        :multiply(i * 50)
        :add(heroV)
    return Vector:fromAngle(facingDeg * bj_DEGTORAD)
        :multiply(j * 200)
        :add(perpendicularVec)
end

local cast = function(playerId)
    if cooldowns.isOnCooldown(playerId, getSpellId()) then
        log.log(playerId, getSpellName().." is on cooldown!", log.TYPE.ERROR)
        return false
    end

    if cooldowns[playerId] ~= nil then
        DestroyTimer(cooldowns[playerId])
        cooldowns[playerId] = nil
    end

    local hero = hero.getHero(playerId)
    local heroV = Vector:new{x = GetUnitX(hero), y = GetUnitY(hero)}
    local mouseV = Vector:new{
        x = mouse.getMouseX(playerId),
        y = mouse.getMouseY(playerId)
    }

    if storedData[playerId] == nil then
        storedData[playerId] = {
            attackCount = -1,
        }
    end

    storedData[playerId].attackCount =
        (storedData[playerId].attackCount + 1) % 3

    cooldowns.startCooldown(
        playerId,
        getSpellId(),
        storedData[playerId].attackCount == 2 and
            COOLDOWN_S_LONG or
            COOLDOWN_S)

    IssueImmediateOrder(hero, "stop")
    SetUnitTimeScale(hero, 2)
    animations.queueAnimation(
        hero,
        storedData[playerId].attackCount == 2 and
            3 or
            2,
        storedData[playerId].attackCount == 2 and
            1.5 or
            1)

    SetUnitFacing(
        hero,
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x))

    projectile.createProjectile{
        playerId = playerId,
        projectile = hero,
        fromV = heroV,
        toV = mouseV,
        speed = 1200,
        length = storedData[playerId].attackCount == 2 and
            500 or
            200,
        radius = 75,
        onCollide = function()
            -- Stop projecting if you collide with anything
            return true
        end,
        onDoodadCollide = function(doodad)
            -- Stop projecting if you collide with any doodads
            return true
        end,
        onDestroy = function()
            -- Finish up the stuff
            local dmgAmount = storedData[playerId].attackCount == 2 and 25 or 10

            -- Update heroV now that we've moved
            local heroV = Vector:new{x = GetUnitX(hero), y = GetUnitY(hero)}

            local facingDeg =
                bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x)

            local shape = {
                getCollisionPoint(heroV, facingDeg, 1, 0),
                getCollisionPoint(heroV, facingDeg, -1, 0),
                getCollisionPoint(heroV, facingDeg, -1, 1),
                getCollisionPoint(heroV, facingDeg, 1, 1),
            }

            local collidedUnits = collision.getAllCollisions(shape)
            for idx, unit in pairs(collidedUnits) do
                if IsUnitEnemy(unit, Player(playerId)) then
                    damage.dealDamage(hero, unit, dmgAmount, damage.TYPE.PHYSICAL)

                    effect.createEffect{
                        model = "Objects\\Spawnmodels\\Human\\HumanBlood\\HumanBloodPeasant.mdl",
                        unit = unit,
                        duration = 0.1,
                        z = 35,
                    }
                end
            end
        end
    }

    casttime.cast(
        playerId,
        storedData[playerId].attackCount == 2 and
            0.35 or
            0.1,
        false,
        false,
        true)

    SetUnitTimeScale(hero, 1)

    target.restoreOrder(playerId)

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNCleavingAttack.blp"
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
