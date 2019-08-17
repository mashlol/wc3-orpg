local hero = require('src/hero.lua')
local mouse = require('src/mouse.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local projectile = require('src/projectile.lua')
local log = require('src/log.lua')
local casttime = require('src/casttime.lua')
local collision = require('src/collision.lua')
local animations = require('src/animations.lua')
local damage = require('src/damage.lua')
local cooldowns = require('src/spells/cooldowns.lua')

-- TODO create some sort of helper or "DB" for getting cooldowns
local COOLDOWN_S = 0.5
local COOLDOWN_S_LONG = 1.2

local storedData = {}

local getSpellId = function()
    return 'slash'
end

local getSpellName = function()
    return 'Slash'
end

local cast = function(playerId)
    if cooldowns.isOnCooldown(playerId, getSpellId()) then
        log.log(playerId, getSpellName().." is on cooldown!", log.TYPE.ERROR)
        return false
    end

    if cooldowns[playerId] ~= nil then
        DestroyTimer(cooldowns[playerId])
        cooldowns[playerId] = nil
    end

    local hero = hero.getHero(playerId)
    local heroV = Vector:new{x = GetUnitX(hero), y = GetUnitY(hero)}
    local mouseV = Vector:new{
        x = mouse.getMouseX(playerId),
        y = mouse.getMouseY(playerId)
    }

    if storedData[playerId] == nil then
        storedData[playerId] = {
            attackCount = -1,
        }
    end

    storedData[playerId].attackCount =
        (storedData[playerId].attackCount + 1) % 3

    cooldowns.startCooldown(
        playerId,
        getSpellId(),
        storedData[playerId].attackCount == 2 and
            COOLDOWN_S_LONG or
            COOLDOWN_S)

    IssueImmediateOrder(hero, "stop")
    animations.queueAnimation(
        hero,
        storedData[playerId].attackCount == 2 and
            3 or
            2,
        storedData[playerId].attackCount == 2 and
            1.5 or
            1)

    SetUnitFacing(
        hero,
        bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x))

    casttime.cast(
        playerId,
        storedData[playerId].attackCount == 2 and
            0.7 or
            0.2,
        false)

    local dmgAmount = storedData[playerId].attackCount == 2 and 300 or 50

    local facingVec = Vector:new(mouseV)
        :subtract(heroV)
        :normalize()
        :multiply(50)
        :add(heroV)

    local collidedUnits = collision.getAllCollisions(facingVec, 100)
    for idx, unit in pairs(collidedUnits) do
        if IsUnitEnemy(unit, Player(playerId)) then
            damage.dealDamage(hero, unit, dmgAmount)

            effect.createEffect{
                model = "ebld",
                x = facingVec.x,
                y = facingVec.y,
                duration = 0.1,
            }
        end
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
    return "ReplaceableTextures\\CommandButtons\\BTNCleavingAttack.blp"
end

return {
    cast = cast,
    getSpellId = getSpellId,
    getSpellName = getSpellName,
    getIcon = getIcon,
}
