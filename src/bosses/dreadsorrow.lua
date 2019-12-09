local animations = require('src/animations.lua')
local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local collision = require('src/collision.lua')
local damage = require('src/damage.lua')

local Dreadsorrow = {}

function Dreadsorrow:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Dreadsorrow:getName()
    return "Zarimus Dreadsorrow"
end

-- Counter-clockwise coords
function Dreadsorrow:getBounds()
    return {
        {x = -22417, y = 28724},
        {x = -24305, y = 28386},
        {x = -24304, y = 26156},
        {x = -22126, y = 26149},
    }
end

function Dreadsorrow:rockFall(target)
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

    TimerStart(CreateTimer(), 3, false, function()
        DestroyTimer(GetExpiredTimer())
        effect.createEffect{
            model = 'Abilities\\Spells\\Orc\\EarthQuake\\EarthQuakeTarget.mdl',
            x = bombV.x,
            y = bombV.y,
            duration = 1,
            scale = 0.3,
            timeScale = 1,
        }

        local collidedUnits = collision.getAllCollisions(bombV, 150)
        for _, unit in pairs(collidedUnits) do
            if IsUnitEnemy(unit, Player(PLAYER_NEUTRAL_AGGRESSIVE)) then
                damage.dealDamage(self.bossUnit, unit, 400, damage.TYPE.SPELL)
            end
        end
    end)
end

function Dreadsorrow:makeRocksFall()
    -- Create a rat projectile that does dmg
    for _, hero in pairs(self.ctx.involvedHeroes) do
        self:rockFall(hero)
    end
end

function Dreadsorrow:pauseAndCast()
    print('pause and cast')
    PauseUnit(self.bossUnit, true)
    animations.queueAnimation(self.bossUnit, 5, 1000)
    self.effect = AddSpecialEffectTarget(
        "Abilities\\Spells\\Orc\\Voodoo\\VoodooAura.mdl",
        self.bossUnit,
        "origin")
end

function Dreadsorrow:unpause()
    PauseUnit(self.bossUnit, false)
    animations.maybeResetAnimation(self.bossUnit)
    DestroyEffect(self.effect)
end

function Dreadsorrow:init()
    local phase1 = self.ctx:registerPhase{
        hp = 100,
    }

    phase1:onStart(function()
        self:pauseAndCast()
    end)

    phase1:onFinish(function()
        self:unpause()
    end)

    phase1:addTimedEvent(1, function()
        self:makeRocksFall()
    end)

    self.ctx:registerDoor(gg_dest_DTg7_14264, true)
    self.ctx:registerDoor(gg_dest_DTg7_14265, true)
end

return Dreadsorrow
