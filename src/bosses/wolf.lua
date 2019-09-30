local Vector = require('src/vector.lua')
local threat = require('src/threat.lua')

local Wolf = {}

function Wolf:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Wolf:getName()
    return "Alpha Wolf"
end

-- Counter-clockwise coords
function Wolf:getBounds()
    return {
        {x = -2572, y = -7250},
        {x = -3695, y = -8242},
        {x = -3091, y = -9084},
        {x = -2035, y = -9056},
        {x = -1254, y = -8577},
    }
end

function Wolf:spawnAdds()
    for i=0,2,1 do
        local bossV = Vector:new{
            x = GetUnitX(self.bossUnit),
            y = GetUnitY(self.bossUnit),
        }
        local spawnLocation = Vector:fromAngle(GetRandomReal(0, 2 * bj_PI))
            :multiply(50)
            :add(bossV)
        local add = CreateUnit(
            Player(PLAYER_NEUTRAL_AGGRESSIVE),
            FourCC("nban"),
            spawnLocation.x,
            spawnLocation.y,
            GetRandomReal(0, 180))

        local targetHero = self.ctx:getRandomInvolvedHero()
        threat.addThreat(targetHero, add, 100)
    end
end

function Wolf:castHowl()
    IssueImmediateOrder(self.bossUnit, "howlofterror")
end

function Wolf:init()
    local phase1 = self.ctx:registerPhase{
        hp = 100,
    }

    phase1:addTimedEvent(25, function()
        self:spawnAdds()
    end)
    phase1:addTimedEvent(10, function()
        self:castHowl()
    end)

    self.ctx:registerDoor(gg_dest_DTg4_4763)
    self.ctx:registerDoor(gg_dest_DTg4_4764)
end

return Wolf
