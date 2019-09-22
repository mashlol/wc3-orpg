local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local collision = require('src/collision.lua')
local log = require('src/log.lua')
local buff = require('src/buff.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 50

local getSpellId = function()
    return 'flag'
end

local getSpellName = function()
    return 'Flag'
end

local getSpellTooltip = function(playerId)
    return 'Tarcza throws a flag down on the target location, which '..
        'increases the damage dealt, reduces the damage taken, and increases '..
        'the move speed of nearby targets by 10% for 10 seconds.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.2
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

    animations.queueAnimation(hero, 9, 1)

    casttime.cast(playerId, 0.2, false)

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    effect.createEffect{
        model = "Objects\\InventoryItems\\OrcCaptureFlag\\OrcCaptureFlag.mdl",
        x = mouseV.x,
        y = mouseV.y,
        duration = 10,
        scale = 1.2,
    }

    for i=0,10,1 do
        local collidedUnits = collision.getAllCollisions(mouseV, 500)
        for idx, unit in pairs(collidedUnits) do
            if IsUnitAlly(unit, Player(playerId)) then
                buff.addBuff(hero, unit, 'flag', 1.5)
            end
        end
        TriggerSleepAction(1)
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
    return "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"
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

