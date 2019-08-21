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

local cast = function(playerId)
    local hero = hero.getHero(playerId)

    IssueImmediateOrder(hero, "stop")
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
}
