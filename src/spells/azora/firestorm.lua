local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local buff = require('src/buff.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local collision = require('src/collision.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 35

local getSpellId = function()
    return 'firestorm'
end

local getSpellName = function()
    return 'Firestorm'
end

local getSpellTooltip = function(playerId)
    return 'Azora summons a storm of fire to rain upon the land, dealing 80 damage to any unit struck in the area.'
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

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    casttime.cast(playerId, 1, false)

    animations.queueAnimation(hero, 18, 1)

    for i=0,40,1 do
        local randX = GetRandomReal(mouseV.x - 200, mouseV.x + 200)
        local randY = GetRandomReal(mouseV.y - 200, mouseV.y + 200)

        effect.createEffect{
            model = "erai",
            x = randX,
            y = randY,
            duration = 1,
        }
        local collidedUnits = collision.getAllCollisions(
            Vector:new{x = randX, y = randY}, 100)
        for idx, unit in pairs(collidedUnits) do
            if IsUnitEnemy(unit, Player(playerId)) then
                damage.dealDamage(hero, unit, 80)
                buff.addBuff(hero, unit, 'ignite', 8)
            end
        end
        TriggerSleepAction(0.01)
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
    return "ReplaceableTextures\\CommandButtons\\BTNFireRocks.blp"
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
