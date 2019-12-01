local hero = require('src/hero.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local collision = require('src/collision.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 5

local getSpellId = function()
    return 'thunderclap'
end

local getSpellName = function()
    return 'Thunder Slam'
end

local getSpellTooltip = function()
    return 'Slam the ground, dealing 75 damage to all nearby units.'
end

local getSpellCooldown = function()
    return COOLDOWN_S
end

local getSpellCasttime = function()
    return 0
end

local cast = function(playerId)
    if cooldowns.isOnCooldown(playerId, getSpellId()) then
        log.log(playerId, getSpellName().." is on cooldown!", log.TYPE.ERROR)
        return false
    end

    local hero = hero.getHero(playerId)

    local heroV = Vector:new{x = GetUnitX(hero), y = GetUnitY(hero)}

    animations.queueAnimation(hero, 9, 1)

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    for i=0.4,1,0.2 do
        effect.createEffect{
            model = "Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl",
            x = heroV.x,
            y = heroV.y,
            duration = 0.5,
            scale = 0.6,
            timeScale = i,
            z = 60,
        }
    end

    local collidedUnits = collision.getAllCollisions(heroV, 300)
    for _, unit in pairs(collidedUnits) do
        if IsUnitEnemy(unit, Player(playerId)) then
            damage.dealDamage(hero, unit, 25, damage.TYPE.SPELL)
        end
    end

    casttime.cast(playerId, 0.4, false)

    return true
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNGolemThunderclap.blp"
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
