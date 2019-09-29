local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local collision = require('src/collision.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local target = require('src/target.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 25

local getSpellId = function()
    return 'slashult'
end

local getSpellName = function()
    return 'Spin'
end

local getSpellTooltip = function(playerId)
    return 'Deal 400 damage to all nearby enemies.'
end

local getSpellCooldown = function(playerId)
    return COOLDOWN_S
end

local getSpellCasttime = function(playerId)
    return 0.3
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

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 9, 1)
    SetUnitFacing(hero, 0)

    casttime.cast(playerId, 0.3, false)

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    effect.createEffect{
        model = "Culling Slash.mdl",
        x = heroV.x,
        y = heroV.y,
        duration = 0.5,
        z = 10,
    }

    SetUnitTimeScale(hero, 3)
    for i=0,320,40 do
        local facing = i * bj_DEGTORAD
        SetUnitFacing(hero, i)
        animations.queueAnimation(hero, 13, 0.4)
        local spawn = Vector:fromAngle(facing)
            :multiply(50)
            :add(heroV)
        effect.createEffect{
            model = "Piercing Thrust.mdl",
            x = spawn.x,
            y = spawn.y,
            duration = 0.3,
            facing = bj_DEGTORAD * i,
        }
    end

    local collidedUnits = collision.getAllCollisions(heroV, 200)
    for idx, unit in pairs(collidedUnits) do
        if IsUnitEnemy(unit, Player(playerId)) then
            damage.dealDamage(hero, unit, 400)

            effect.createEffect{
                model = "Objects\\Spawnmodels\\Human\\HumanBlood\\HumanBloodPeasant.mdl",
                unit = unit,
                duration = 0.1,
                z = 35,
            }
        end
    end

    SetUnitTimeScale(hero, 1)

    target.restoreOrder(playerId)

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
