local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local buff = require('src/buff.lua')
local animations = require('src/animations.lua')
local cooldowns = require('src/spells/cooldowns.lua')
local target = require('src/target.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 25

local getSpellId = function()
    return 'frostnova'
end

local getSpellName = function()
    return 'Frost Nova'
end

local getSpellTooltip = function(playerId)
    return 'Using the power of frost, Azora freezes all targets in an area in place, preventing them from moving for 4 seconds.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0
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

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 38, 1)

    for i=0,2*math.pi, 1.57 do
        projectile.createProjectile{
            playerId = playerId,
            model = "Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl",
            z = 35,
            fromV = mouseV,
            fromAngle = i,
            toAngle = 8 * math.pi + i,
            speed = 1000,
            fromRadius = 30,
            toRadius = 200,
            onCollide = function(collidedUnit)
                if IsUnitEnemy(collidedUnit, Player(playerId)) then
                    effect.createEffect{
                        model = "efir",
                        unit = collidedUnit,
                        duration = 0.5,
                    }
                    buff.addBuff(hero, collidedUnit, 'frostnova', 4)
                end
                return false
            end,
        }
    end

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
    return "ReplaceableTextures\\CommandButtons\\BTNFrostArmor.blp"
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
