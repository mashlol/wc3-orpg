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

local cast = function(playerId)
    local hero = hero.getHero(playerId)
    local target = target.getTarget(playerId)

    if target == nil then
        log.log(playerId, "You don't have a target!", log.TYPE.ERROR)
        return false
    end

    if IsUnitAlly(target, Player(playerId)) then
        log.log(playerId, "The target is friendly.", log.TYPE.ERROR)
        return false
    end

    IssueTargetOrder(hero, "attack", target)
    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
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
}
