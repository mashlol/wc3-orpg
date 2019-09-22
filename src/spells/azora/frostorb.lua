local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 160

local getSpellId = function()
    return 'frostorb'
end

local getSpellName = function()
    return 'Frost Orb'
end

local getSpellTooltip = function(playerId)
    return 'This is a temporary spell to be replaced.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 1
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

    local dist = Vector:new(heroV):subtract(mouseV)
    local mag = dist:magnitude()
    if mag > 800 then
        log.log(playerId, "Out of range!", log.TYPE.ERROR)
        return false
    end

    if not IsVisibleToPlayer(mouseV.x, mouseV.y, Player(playerId)) then
        log.log(playerId, "Target not in line of sight.", log.TYPE.ERROR)
        return false
    end

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 19, 2)

    local castSuccess = casttime.cast(playerId, 1)
    if not castSuccess then
        return false
    end

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    animations.queueAnimation(hero, 18, 1)

    for x=0,30,10 do
        for i=x,360+x,40 do
            local toV = Vector:fromAngle(bj_DEGTORAD * i):add(mouseV)

            projectile.createProjectile{
                playerId = playerId,
                model = "Abilities\\Spells\\Human\\SpellSteal\\SpellStealMissile.mdl",
                z = 35,
                scale = 2,
                fromV = mouseV,
                toV = toV,
                speed = 300,
                length = 350,
                onCollide = function(collidedUnit)
                    if IsUnitEnemy(collidedUnit, Player(playerId)) then
                        damage.dealDamage(hero, collidedUnit, 50)
                        return true
                    end
                    return false
                end
            }
        end
        TriggerSleepAction(0.03)
    end

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
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
