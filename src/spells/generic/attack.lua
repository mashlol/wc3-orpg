local hero = require('src/hero.lua')
local log = require('src/log.lua')
local target = require('src/target.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 1

local getSpellId = function()
    return 'attack'
end

local getSpellName = function()
    return 'Attack'
end

local getSpellTooltip = function(playerId)
    return 'Just a simple auto attack.'
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
    return 0
end

local getTotalCooldown = function(playerId)
    return 1
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNAttack.blp"
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
