local Vector = require('src/vector.lua')
local effect = require('src/effect.lua')
local damage = require('src/damage.lua')
local projectile = require('src/projectile.lua')
local animations = require('src/animations.lua')

local Yeti = {}

function Yeti:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end


function Yeti:getName()
    return "Giant Yeti"
end

-- Counter-clockwise coords
function Yeti:getBounds()
    return {
        {x = 31102, y = -21298},
        {x = 29259, y = -21275},
        {x = 29520, y = -23482},
        {x = 31204, y = -23478},
    }
end

function Yeti:charge()
    local bossV = Vector:new{
        x = GetUnitX(self.bossUnit),
        y = GetUnitY(self.bossUnit),
    }

    -- Pick random direction? Or maybe towards players?
    local facingRad = GetRandomReal(0, 2 * bj_PI)
    local facingDeg = bj_RADTODEG * facingRad

    PauseUnit(self.bossUnit, true)
    SetUnitFacingTimed(self.bossUnit, facingDeg, 0.05)
    animations.queueAnimation(self.bossUnit, 8, 3)

    effect.createEffect{
        model = 'Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl',
        x = bossV.x,
        y = bossV.y,
        duration = 1,
        scale = 2,
    }

    local hasCollided = false
    TimerStart(CreateTimer(), 3, false, function()
        DestroyTimer(GetExpiredTimer())
        animations.queueAnimation(self.bossUnit, 10, 3)

        local destV = Vector:fromAngle(facingRad)
            :multiply(150)
            :add(bossV)

        projectile.createProjectile{
            playerId = PLAYER_NEUTRAL_AGGRESSIVE,
            projectile = self.bossUnit,
            fromV = bossV,
            toV = destV,
            speed = 1000,
            length = 800,
            radius = 150,
            onCollide = function(collidedUnit)
                if IsUnitEnemy(collidedUnit, Player(PLAYER_NEUTRAL_AGGRESSIVE)) then
                    damage.dealDamage(
                        self.bossUnit, collidedUnit, 1000, damage.TYPE.PHYSICAL)
                end

                return false
            end,
            onDoodadCollide = function()
                hasCollided = true
                PauseUnit(self.bossUnit, true)
                TimerStart(CreateTimer(), 3, false, function()
                    DestroyTimer(GetExpiredTimer())
                    PauseUnit(self.bossUnit, false)
                end)

                return true
            end,
            onDestroy = function()
                if not hasCollided then
                    PauseUnit(self.bossUnit, false)
                end
                animations.maybeResetAnimation(self.bossUnit)
            end,
        }
    end)
end

function Yeti:init()
    local phase1 = self.ctx:registerPhase{
        hp = 100,
    }

    phase1:addTimedEvent(16, function()
        self:charge()
    end)

    self.ctx:registerDoor(gg_dest_YTcx_4753)
end

return Yeti
