local hero = require('src/hero.lua')
local log = require('src/log.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 1

local getSpellId = function()
    return 'stop'
end

local getSpellName = function()
    return 'Stop'
end

local getSpellTooltip = function(playerId)
    return 'Press to stop your hero from moving'
end

local getSpellCooldown = function(playerId)
    return 0
end

local getSpellCasttime = function(playerId)
    return 0
end

local cast = function(playerId)
    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return 1
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNStop.blp"
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
