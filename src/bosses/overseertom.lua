local Vector = require('src/vector.lua')
local threat = require('src/threat.lua')
local effect = require('src/effect.lua')
local collision = require('src/collision.lua')
local damage = require('src/damage.lua')
local buff = require('src/buff.lua')

local OverseerTom = {}

function OverseerTom:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function OverseerTom:getName()
    return "Overseer Tom"
end

-- Counter-clockwise coords
function OverseerTom:getBounds()
    return {
        {x = 24002, y = 30978},
        {x = 22933, y = 30785},
        {x = 22611, y = 29791},
        {x = 24360, y = 29845},
    }
end

function OverseerTom:pullCenter()
    local bombV = Vector:new{
        x = GetUnitX(self.bossUnit),
        y = GetUnitY(self.bossUnit),
    }

    local allHeroes = self.ctx.involvedHeroes

    for _, hero in pairs(allHeroes) do
        SetUnitPosition(hero, bombV.x, bombV.y)
        buff.addBuff(self.bossUnit, hero, 'tomslow', 5)
    end

    effect.createEffect{
        model = 'Divine Edict.mdx',
        x = bombV.x,
        y = bombV.y,
        duration = 0.5,
    }

    effect.createEffect{
        model = 'ui\\feedback\\selectioncircleenemy\\selectioncircleenemy.mdx',
        x = bombV.x,
        y = bombV.y,
        z = 0,
        duration = 5,
        scale = 6,
        remove = true,
    }

    local timer = CreateTimer()
    TimerStart(timer, 5, false, function()
        DestroyTimer(timer)
        effect.createEffect{
            model = 'Pillar of Flame Orange.mdl',
            x = bombV.x,
            y = bombV.y,
            duration = 0.5,
            scale = 2,
        }

        local collidedUnits = collision.getAllCollisions(bombV, 200)
        for _, unit in pairs(collidedUnits) do
            if IsUnitEnemy(unit, Player(PLAYER_NEUTRAL_AGGRESSIVE)) then
                damage.dealDamage(self.bossUnit, unit, 1000, damage.TYPE.SPELL)
            end
        end
    end)
end

function OverseerTom:init()
    local phase1 = self.ctx:registerPhase{
        hp = 100,
    }

    phase1:addTimedEvent(15, function()
        self:pullCenter()
    end)

    self.ctx:registerDoor(gg_dest_DTg3_18339, false)
end

return OverseerTom
