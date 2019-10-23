local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local collision = require('src/collision.lua')
local damage = require('src/damage.lua')

local MinerJoe = {}

function MinerJoe:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function MinerJoe:getName()
    return "Miner Joe"
end

-- Counter-clockwise coords
function MinerJoe:getBounds()
    return {
        {x = 24859, y = 28079},
        {x = 23746, y = 27803},
        {x = 23823, y = 26874},
        {x = 24132, y = 26628},
        {x = 25420, y = 26637},
        {x = 25450, y = 27775},
    }
end

function MinerJoe:throwBomb()
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
        scale = 3,
        remove = true,
    }

    local timer = CreateTimer()
    TimerStart(timer, 3, false, function()
        DestroyTimer(timer)
        effect.createEffect{
            model = 'Pillar of Flame Orange.mdl',
            x = bombV.x,
            y = bombV.y,
            duration = 0.5,
            scale = 1,
        }

        local collidedUnits = collision.getAllCollisions(bombV, 150)
        for _, unit in pairs(collidedUnits) do
            if IsUnitEnemy(unit, Player(PLAYER_NEUTRAL_AGGRESSIVE)) then
                damage.dealDamage(self.bossUnit, unit, 400, damage.TYPE.SPELL)
            end
        end
    end)
end

function MinerJoe:init()
    local phase1 = self.ctx:registerPhase{
        hp = 100,
    }

    phase1:addTimedEvent(10, function()
        self:throwBomb()
    end)

    self.ctx:registerDoor(gg_dest_DTg3_18751, false)
end

return MinerJoe
