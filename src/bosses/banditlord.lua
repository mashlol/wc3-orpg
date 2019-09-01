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
    return "Bandit Lord"
end

function BanditLord:getBounds()
    return {
        {x = 3317, y = 3082},
        {x = 1710, y = 1886},
        {x = 1650, y = 594},
        {x = 3099, y = -1069},
        {x = 4999, y = 1130},
    }
end

function BanditLord:spawnAdds()
    for i=0,2,1 do
        local bossV = Vector:new{
            x = GetUnitX(self.bossUnit),
            y = GetUnitY(self.bossUnit),
        }
        local spawnLocation = Vector:fromAngle(GetRandomReal(0, 2 * bj_PI))
            :multiply(BlzGetUnitCollisionSize(self.bossUnit) + 150)
            :add(bossV)
        local add = CreateUnit(
            Player(PLAYER_NEUTRAL_AGGRESSIVE),
            FourCC("nban"),
            spawnLocation.x,
            spawnLocation.y,
            GetRandomReal(0, 180))

        local targetHero = self.ctx.getRandomInvolvedHero()
        threat.addThreat(targetHero, add, 100)
    end
end

function BanditLord:castSlam()
    IssueImmediateOrder(self.bossUnit, "creepthunderclap")
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

    self.ctx:registerDoor(gg_dest_LTg2_2324)
end

return BanditLord