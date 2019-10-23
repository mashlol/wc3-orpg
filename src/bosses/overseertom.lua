local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local collision = require('src/collision.lua')
local damage = require('src/damage.lua')
local buff = require('src/buff.lua')
local animations = require('src/animations.lua')

local OverseerTom = {}

function OverseerTom:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function OverseerTom:getName()
    return "The Overseer"
end

-- Counter-clockwise coords
function OverseerTom:getBounds()
    return {
        {x = 24409, y = 30890},
        {x = 22824, y = 31008},
        {x = 22831, y = 30254},
        {x = 22606, y = 30235},
        {x = 22641, y = 29757},
        {x = 24429, y = 29744},
    }
end

function OverseerTom:pullCenter()
    buff.addBuff(self.bossUnit, self.bossUnit, 'stunnoeffect', 5)
    PauseUnit(self.bossUnit, true)
    animations.queueAnimation(self.bossUnit, 15, 5)

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
        timeScale = 0.3,
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

    animations.queueAnimation(self.bossUnit, 15, 5)
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
    self.ctx:registerDoor(gg_dest_YTcx_17815, true)
    self.ctx:registerDoor(gg_dest_YTcx_17816, true)
end

return OverseerTom
