local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local collision = require('src/collision.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local threat = require('src/threat.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 5

local getSpellId = function()
    return 'whirlwind'
end

local getSpellName = function()
    return 'Whirlwind'
end

local getSpellTooltip = function(playerId)
    return 'Deals 100 damage to all nearby units. Causes a high amount of threat.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.4
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

    animations.queueAnimation(hero, 17, 1)

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    for i=0.4,1,0.2 do
        effect.createEffect{
            model = "Culling Slash Red.mdl",
            x = heroV.x,
            y = heroV.y,
            duration = 0.5,
            scale = 0.6,
            timeScale = i,
            z = 60,
        }
    end

    local collidedUnits = collision.getAllCollisions(heroV, 200)
    for idx, unit in pairs(collidedUnits) do
        if IsUnitEnemy(unit, Player(playerId)) then
            damage.dealDamage(hero, unit, 75, damage.TYPE.PHYSICAL)
            threat.addThreat(hero, unit, 400)

            effect.createEffect{
                model = "Objects\\Spawnmodels\\Human\\HumanBlood\\HumanBloodPeasant.mdl",
                unit = unit,
                duration = 0.1,
                z = 35,
            }
        end
    end

    casttime.cast(playerId, 0.4, false)

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNWhirlwind.blp"
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
