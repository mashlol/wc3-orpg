local effect = require('src/effect.lua')
local Vector = require('src/vector.lua')
local collision = require('src/collision.lua')
local damage = require('src/damage.lua')
local buff = require('src/buff.lua')
local stats = require('src/stats.lua')

return {
    effects = {
        {
            type = stats.DAMAGE_OVER_TIME,
            amount = 5,
            tickrate = 1,
        }
    },
    vfx = {
        model = "Abilities\\Spells\\Other\\ImmolationRed\\ImmolationRedDamage.mdl",
        attach = "chest",
    },
    icon = "ReplaceableTextures\\CommandButtons\\BTNLiquidFire.blp",
    maxStacks = 5,
    onMaxStacks = function(target, buffInstance)
        buff.removeBuff(target, 'ignite')

        local sourceUnit = buffInstance.source
        local playerId = GetPlayerId(GetOwningPlayer(sourceUnit))

        local posV = Vector:new{x = GetUnitX(target), y = GetUnitY(target)}

        effect.createEffect{
            model = "Pillar of Flame Orange.mdl",
            x = posV.x,
            y = posV.y,
            duration = 1,
        }

        local collidedUnits = collision.getAllCollisions(posV, 100)
        for _, unit in pairs(collidedUnits) do
            if IsUnitEnemy(unit, Player(playerId)) then
                damage.dealDamage(sourceUnit, unit, 75, damage.TYPE.SPELL)
            end
        end
        return true
    end
}
