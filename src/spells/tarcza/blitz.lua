local hero = require('src/hero.lua')
local Vector = require('src/vector.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local buff = require('src/buff.lua')
local mouse = require('src/mouse.lua')
local casttime = require('src/casttime.lua')
local target = require('src/target.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 1
local COOLDOWN_S_LONG = 3

local storedData = {}

local isStuck = function(unit)
    return IsUnitType(unit, UNIT_TYPE_STUNNED) or
        IsUnitType(unit, UNIT_TYPE_SNARED) or
        IsUnitType(unit, UNIT_TYPE_POLYMORPHED) or
        IsUnitPaused(unit)
end

local getSpellId = function()
    return 'blitz'
end

local getSpellName = function()
    return 'Blitz / Assist'
end

local getSpellTooltip = function(playerId)
    return 'Charge towards the target. To enemies, deal 40 damage and stun them for 2 seconds. To allies, reduce their incoming damage by 40% for 2 seconds. Can be recast quickly after the first cast.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.5
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
        log.log(playerId, "You can't move right now.", log.TYPE.ERROR)
        return false
    end

    if storedData[playerId] == nil then
        storedData[playerId] = {
            attackCount = -1,
        }
    end

    storedData[playerId].attackCount =
        (storedData[playerId].attackCount + 1) % 2

    cooldowns.startCooldown(
        playerId,
        getSpellId(),
        storedData[playerId].attackCount == 1 and
            COOLDOWN_S_LONG or
            COOLDOWN_S)

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 12, 2)

    projectile.createProjectile{
        playerId = playerId,
        model = "Valiant Charge.mdl",
        scale = 1.3,
        height = 10,
        fromV = heroV,
        toV = mouseV,
        speed = 1010,
        length = 650,
        onDoodadCollide = function(doodad)
            -- Stop projecting if you collide with any doodads
            return true
        end,
    }

    projectile.createProjectile{
        playerId = playerId,
        projectile = hero,
        fromV = heroV,
        toV = mouseV,
        speed = 1000,
        length = 650,
        onDoodadCollide = function(doodad)
            -- Stop projecting if you collide with any doodads
            return true
        end,
        onCollide = function(target)
            -- Stop projecting if you collide with any units
            if IsUnitAlly(target, Player(playerId)) then
                buff.addBuff(hero, target, 'assist', 2)
            else
                damage.dealDamage(hero, target, 50, damage.TYPE.PHYSICAL)
                buff.addBuff(hero, target, 'stun', 1)
            end
            return false
        end,
        onDestroy = function()
            animations.queueAnimation(hero, 3, 0.6)
        end,
    }

    casttime.cast(playerId, 0.5, false, false, true)

    return true
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNCleavingAttack.blp"
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
