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
    return false
end

function Wolf:spawnAdds()
    for i=0,2,1 do
        local bossV = Vector:new{
            x = GetUnitX(self.bossUnit),
            y = GetUnitY(self.bossUnit),
        }
        local spawnLocation = Vector:fromAngle(GetRandomReal(0, 2 * bj_PI))
            :multiply(150)
            :add(bossV)
        local add = CreateUnit(
            Player(PLAYER_NEUTRAL_AGGRESSIVE),
            FourCC("hwol"),
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
