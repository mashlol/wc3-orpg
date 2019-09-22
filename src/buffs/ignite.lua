local effect = require('src/effect.lua')
local Vector = require('src/vector.lua')
local collision = require('src/collision.lua')
local damage = require('src/damage.lua')
local buff = require('src/buff.lua')

return {
    effects = {
        {
            type = 'damage',
            amount = 10,
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
        for idx, unit in pairs(collidedUnits) do
            if IsUnitEnemy(unit, Player(playerId)) then
                damage.dealDamage(sourceUnit, unit, 100)
            end
        end
        return true
    end
}
