local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 15

local getSpellId = function()
    return 'blink'
end

local getSpellName = function()
    return 'Blink'
end

local getSpellTooltip = function(playerId)
    return 'Azora channels her inner fire to displace her position in the world by up to 800 yards.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.15
end

local isStuck = function(unit)
    return IsUnitType(unit, UNIT_TYPE_STUNNED) or
        IsUnitType(unit, UNIT_TYPE_SNARED) or
        IsUnitType(unit, UNIT_TYPE_POLYMORPHED) or
        IsUnitPaused(unit)
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

    if isStuck(hero) then
        log.log(playerId, "You can't move right now", log.TYPE.ERROR)
        return false
    end

    local finalV = Vector:new(mouseV)
        :subtract(heroV)

    if finalV:magnitude() > 800 then
        finalV:normalize()
            :multiply(800)
    end

    finalV:add(heroV)

    if not IsVisibleToPlayer(finalV.x, finalV.y, Player(playerId)) then
        log.log(playerId, "Target not in line of sight.", log.TYPE.ERROR)
        return false
    end

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 14, 1)

    effect.createEffect{
        model = "Pillar of Flame Blue.mdl",
        unit = hero,
        duration = 0.5,
    }

    casttime.cast(playerId, 0.15, false)

    SetUnitX(hero, finalV.x)
    SetUnitY(hero, finalV.y)
    SetUnitFacing(
        hero,
        bj_RADTODEG * Atan2(finalV.y - heroV.y, finalV.x - heroV.x))

    effect.createEffect{
        model = "Pillar of Flame Blue.mdl",
        unit = hero,
        duration = 0.5,
    }

    return true
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNBlink.blp"
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
