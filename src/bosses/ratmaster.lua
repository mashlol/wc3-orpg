local Vector = require('src/vector.lua')
local projectile = require('src/projectile.lua')
local damage = require('src/damage.lua')
local animations = require('src/animations.lua')

local Ratmaster = {}

function Ratmaster:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Ratmaster:getName()
    return "The Ratmaster"
end

-- Counter-clockwise coords
function Ratmaster:getBounds()
    return {
        {x = -25781, y = 30423},
        {x = -27295, y = 30582},
        {x = -27161, y = 28168},
        {x = -25795, y = 28583},
    }
end

function Ratmaster:ratRun()
    -- Create a rat projectile that does dmg
    PauseUnit(self.bossUnit, true)
    animations.queueAnimation(self.bossUnit, 7, 1)

    TimerStart(CreateTimer(), 1, false, function()
        DestroyTimer(GetExpiredTimer())
        PauseUnit(self.bossUnit, false)

        for _=0,2,1 do
            local randPoint = GetRandomReal(0, 1)
            local spawnPoint = Vector:new{x = -26954, y = 30053}
                :subtract(Vector:new{x = -25886, y = 30053})
                :multiply(randPoint)
                :add(Vector:new{x = -25886, y = 30053})

            local facingDeg = 270
            local facingRad = bj_DEGTORAD * facingDeg

            local destV = Vector:fromAngle(facingRad)
                :add(spawnPoint)

            projectile.createProjectile{
                playerId = PLAYER_NEUTRAL_AGGRESSIVE,
                model = "units\\critters\\Rat\\Rat.mdl",
                fromV = spawnPoint,
                toV = destV,
                speed = 800,
                length = 1600,
                radius = 50,
                onCollide = function(collidedUnit)
                    if
                        IsUnitEnemy(
                            collidedUnit, Player(PLAYER_NEUTRAL_AGGRESSIVE))
                    then
                        damage.dealDamage(
                            self.bossUnit,
                            collidedUnit,
                            1000,
                            damage.TYPE.PHYSICAL)
                    end

                    return false
                end,
            }
        end
    end)
end

function Ratmaster:init()
    local phase1 = self.ctx:registerPhase{
        hp = 100,
    }

    phase1:addTimedEvent(8, function()
        self:ratRun()
    end)

    self.ctx:registerDoor(gg_dest_DTg7_14262, true)
    self.ctx:registerDoor(gg_dest_DTg7_14263, true)
end

return Ratmaster
