local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local animations = require('src/animations.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 25

local getSpellId = function()
    return 'frostnova'
end

local getSpellName = function()
    return 'Frost Nova'
end

local cast = function(playerId)
    if cooldowns.isOnCooldown(playerId, getSpellId()) then
        log.log(playerId, getSpellName().." is on cooldown!", log.TYPE.ERROR)
        return false
    end

    local hero = hero.getHero(playerId)

    local heroV = vector.create(GetUnitX(hero), GetUnitY(hero))
    local mouseV = vector.create(
        mouse.getMouseX(playerId),
        mouse.getMouseY(playerId))

    local dist = vector.subtract(heroV, mouseV)
    local mag = vector.magnitude(dist)
    if mag > 800 then
        log.log(playerId, "Out of range!", log.TYPE.ERROR)
        return false
    end

    cooldowns.startCooldown(playerId, getSpellId(), COOLDOWN_S)

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(hero, 6, 1)

    for i=0,360,20 do
        local toV = vector.fromAngle(bj_DEGTORAD * i)

        projectile.createProjectile{
            playerId = playerId,
            model = "efnv",
            fromV = mouseV,
            toV = vector.add(mouseV, toV),
            speed = 450,
            length = 250,
            onCollide = function(collidedUnit)
                if IsUnitEnemy(collidedUnit, Player(playerId)) then
                    local dummy = CreateUnit(
                        Player(playerId),
                        FourCC("hdum"),
                        GetUnitX(collidedUnit),
                        GetUnitY(collidedUnit), 0)

                    effect.createEffect{
                        model = "efir",
                        unit = collidedUnit,
                        duration = 0.5,
                    }

                    ShowUnit(dummy, false)

                    UnitRemoveAbility(dummy, FourCC('Aatk'))
                    UnitAddAbility(dummy, FourCC('Aenr'))

                    IssueTargetOrder(dummy, "entanglingroots", collidedUnit)

                    UnitApplyTimedLifeBJ(2, FourCC('BTLF'), dummy)
                end

                return false
            end
        }
    end

    return true
end

local getCooldown = function(playerId)
    return cooldowns.getRemainingCooldown(playerId, getSpellId())
end

local getTotalCooldown = function(playerId)
    return cooldowns.getTotalCooldown(playerId, getSpellId())
end

local getIcon = function()
    return "ReplaceableTextures\\CommandButtons\\BTNFrostArmor.blp"
end

return {
    cast = cast,
    getCooldown = getCooldown,
    getTotalCooldown = getTotalCooldown,
    getIcon = getIcon,
}
