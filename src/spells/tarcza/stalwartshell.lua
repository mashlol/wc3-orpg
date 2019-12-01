local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local log = require('src/log.lua')
local buff = require('src/buff.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local target = require('src/target.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 10

local getSpellId = function()
    return 'stalwartshell'
end

local getSpellName = function()
    return 'Stalwart Shell'
end

local getSpellTooltip = function(playerId)
    return 'Tarcza holds his shield high, preventing all incoming damage for 1.5 seconds, and blocking all incoming projectiles.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 1.5
end

local cast = function(playerId)
    if cooldowns.isOnCooldown(playerId, getSpellId()) then
        log.log(playerId, getSpellName().." is on cooldown!", log.TYPE.ERROR)
        return false
    end

    local hero = hero.getHero(playerId)

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 10, 1.5)

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    buff.addBuff(hero, hero, 'stalwartshell', 1.5)

    casttime.cast(playerId, 1.5, false)

    target.restoreOrder(playerId)

    return true
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNDefend.blp"
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
