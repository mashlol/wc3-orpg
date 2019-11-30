local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local collision = require('src/collision.lua')
local damage = require('src/damage.lua')

local TrollPriest = {}

function TrollPriest:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function TrollPriest:getName()
    return "High Troll Priest"
end

-- Counter-clockwise coords
function TrollPriest:getBounds()
    return {
        {x = 29273, y = -23300},
        {x = 29466, y = -25392},
        {x = 31203, y = -25801},
        {x = 31223, y = -23551},
    }
end

function TrollPriest:throwBomb()
    local target = self.ctx:getRandomInvolvedHero()

    local bombV = Vector:new{
        x = GetUnitX(target),
        y = GetUnitY(target),
    }

    effect.createEffect{
        model = 'ui\\feedback\\selectioncircleenemy\\selectioncircleenemy.mdx',
        x = bombV.x,
        y = bombV.y,
        z = 0,
        duration = 3,
        scale = 2.5,
        remove = true,
    }

    TimerStart(CreateTimer(), 2.4, false, function()
        DestroyTimer(GetExpiredTimer())
        effect.createEffect{
            model = 'Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl',
            x = bombV.x,
            y = bombV.y,
            duration = 2,
            scale = 2,
            timeScale = 2,
        }

        TimerStart(CreateTimer(), 0.6, false, function()
            print('doing damage now')
            DestroyTimer(GetExpiredTimer())
            local collidedUnits = collision.getAllCollisions(bombV, 150)
            for _, unit in pairs(collidedUnits) do
                if IsUnitEnemy(unit, Player(PLAYER_NEUTRAL_AGGRESSIVE)) then
                    damage.dealDamage(self.bossUnit, unit, 400, damage.TYPE.SPELL)
                end
            end
        end)
    end)
end

function TrollPriest:init()
    local phase1 = self.ctx:registerPhase{
        hp = 100,
    }

    phase1:addTimedEvent(10, function()
        self:throwBomb()
    end)

    self.ctx:registerDoor(gg_dest_DTg3_18751, false)
end

return TrollPriest
