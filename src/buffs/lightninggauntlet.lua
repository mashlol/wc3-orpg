local effect = require('src/effect.lua')
local Vector = require('src/vector.lua')
local collision = require('src/collision.lua')
local damage = require('src/damage.lua')
local buff = require('src/buff.lua')

return {
    effects = {},
    vfx = {
        model = "Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl",
        attach = "origin",
    },
    icon = "ReplaceableTextures\\CommandButtons\\BTNChainLightning.blp",
    onDamageDealt = function(source, target, amount)
        buff.removeBuff(source, 'lightninggauntlet')

        -- local sourceUnit = buffInstance.source
        local playerId = GetPlayerId(GetOwningPlayer(source))

        local posV = Vector:new{x = GetUnitX(target), y = GetUnitY(target)}

        effect.createEffect{
            model = "Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl",
            x = posV.x,
            y = posV.y,
            duration = 1,
        }

        local collidedUnits = collision.getAllCollisions(posV, 100)
        for _, unit in pairs(collidedUnits) do
            if IsUnitEnemy(unit, Player(playerId)) then
                damage.dealDamage(source, unit, 20, damage.TYPE.SPELL)
            end
        end
    end
}
