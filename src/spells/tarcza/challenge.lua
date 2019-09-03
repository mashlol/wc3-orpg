local hero = require('src/hero.lua')
local Vector = require('src/vector.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local target = require('src/target.lua')
local animations = require('src/animations.lua')
local cooldowns = require('src/spells/cooldowns.lua')
local threat = require('src/threat.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 5

local getSpellId = function()
    return 'challenge'
end

local getSpellName = function()
    return 'Challenge'
end

local getSpellTooltip = function(playerId)
    return 'Tarcza challenges the opponent, causing a high amount of threat.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.1
end

local cast = function(playerId)
    if cooldowns.isOnCooldown(playerId, getSpellId()) then
        log.log(playerId, getSpellName().." is on cooldown!", log.TYPE.ERROR)
        return false
    end

    local hero = hero.getHero(playerId)
    local target = target.getTarget(playerId)
    local heroV = Vector:new{x = GetUnitX(hero), y = GetUnitY(hero)}
    local targetV = Vector:new{x = GetUnitX(target), y = GetUnitY(target)}

    if target == nil then
        log.log(playerId, "You have no target", log.TYPE.ERROR)
        return false
    end

    if IsUnitAlly(target, Player(playerId)) then
        log.log(playerId, "The target is friendly.", log.TYPE.ERROR)
        return
    end

    local dist = Vector:new(heroV):subtract(targetV)
    local mag = dist:magnitude()
    if mag > 800 then
        log.log(playerId, "Out of range!", log.TYPE.ERROR)
        return false
    end

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 9, 1)

    local facingAngle = bj_RADTODEG * Atan2(targetV.y - heroV.y, targetV.x - heroV.x)
    SetUnitFacing(hero, facingAngle)

    threat.addThreat(hero, target, 40000)

    casttime.cast(playerId, 0.1, false)

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNDevourMagic.blp"
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
