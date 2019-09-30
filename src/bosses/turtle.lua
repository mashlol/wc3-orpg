local Vector = require('src/vector.lua')
local threat = require('src/threat.lua')

local BanditLord = {}

function BanditLord:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function BanditLord:getName()
    return "Huge Turtle"
end

function BanditLord:getBounds()
    return {
        {x = 1195, y = 2575},
        {x = 1073, y = 3334},
        {x = 337, y = 3799},
        {x = -327, y = 3264},
        {x = -128, y = 2457},
    }
end

function BanditLord:spawnAdds()
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
            FourCC("hmbs"),
            spawnLocation.x,
            spawnLocation.y,
            GetRandomReal(0, 180))

        local targetHero = self.ctx:getRandomInvolvedHero()
        threat.addThreat(targetHero, add, 100)
    end
end

function BanditLord:castSlam()
    IssueImmediateOrder(self.bossUnit, "thunderclap")
end

function BanditLord:init()
    local phase1 = self.ctx:registerPhase{
        hp = 100,
    }

    phase1:addTimedEvent(25, function()
        self:spawnAdds()
    end)
    phase1:addTimedEvent(10, function()
        self:castSlam()
    end)

    self.ctx:registerDoor(gg_dest_YTcx_4753)
end

return BanditLord
