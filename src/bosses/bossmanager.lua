local Turtle = require('src/bosses/turtle.lua')
local Wolf = require('src/bosses/wolf.lua')
local MinerJoe = require('src/bosses/minerjoe.lua')
local OverseerTom = require('src/bosses/overseertom.lua')
local hero = require('src/hero.lua')
local collision = require('src/collision.lua')

local ALL_BOSS_CLASSES = {
    Turtle:new{
        bossUnitId = FourCC('hbos'),
        startX = -651,
        startY = -1480,
        facing = 280,
        respawnable = true,
    },
    Wolf:new{
        bossUnitId = FourCC('hbld'),
        startX = 15195,
        startY = 7531,
        facing = 280,
        respawnable = true,
    },
    MinerJoe:new{
        bossUnitId = FourCC('mine'),
        startX = 24237,
        startY = 27062,
        facing = 37,
        respawnable = true,
    },
    OverseerTom:new{
        bossUnitId = FourCC('over'),
        startX = 23428,
        startY = 30510,
        facing = 270,
        respawnable = true,
    }
}

local Phase = {}

function Phase:new(o)
    o = {
        timers = {},
        timedEvents = {},
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

function Phase:addTimedEvent(interval, func)
    table.insert(self.timedEvents, {
        interval = interval,
        func = func,
    })
end

function Phase:startPhase()
    for _, event in pairs(self.timedEvents) do
        local timer = CreateTimer()
        TimerStart(timer, event.interval, true, event.func)
        table.insert(self.timers, timer)
    end
end

function Phase:endPhase()
    for _, timer in pairs(self.timers) do
        DestroyTimer(timer)
    end

    self.timers = {}
end

local Context = {}

function Context:new(o)
    o = {
        phases = o.phases or {},
        involvedHeroes = o.involvedHeroes or {},
        doors = o.doors or {},
        cls = o.cls,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

function Context:registerDoor(door, openByDefault)
    table.insert(self.doors, {
        door = door,
        openByDefault = openByDefault,
    })
end

function Context:registerPhase(options)
    local newPhase = Phase:new()
    table.insert(self.phases, {
        options = options,
        phase = newPhase,
    })

    return newPhase
end

function Context:getHeroesInPoly()
    local toReturn = {}
    for i=0,bj_MAX_PLAYERS,1 do
        local heroUnit = hero.getHero(i)
        if
            heroUnit ~= nil and
            collision.isCollidedWithPolygon(
                heroUnit,
                self.cls:getBounds())
        then
            toReturn[GetHandleId(heroUnit)] = heroUnit
        end
    end
    return toReturn
end

function Context:onFightEnded()
    if GetUnitState(self.cls.bossUnit, UNIT_STATE_LIFE) <= 0 then
        print("You killed " .. self.cls:getName() .. '!')
        for _, door in pairs(self.doors) do
            ModifyGateBJ(bj_GATEOPERATION_OPEN, door.door)
        end

        self:cleanupFight()

        if self.cls.respawnable then
            self:startRespawn()
        end
        return
    end

    self.involvedHeroes[GetHandleId(GetTriggerUnit())] = nil

    if self:isAllInvolvedHeroesDead() then
        print("You lost.")
        self:resetFight()
        return
    end
end

function Context:getRandomInvolvedHero()
    local compactHeroes = {}
    for _, hero in pairs(self.involvedHeroes) do
        if hero ~= nil then
            table.insert(compactHeroes, hero)
        end
    end

    local randomHero = GetRandomInt(1, #compactHeroes)
    return compactHeroes[randomHero]
end

function Context:isAllInvolvedHeroesDead()
    for _, hero in pairs(self.involvedHeroes) do
        if hero ~= nil then
            return false
        end
    end
    return true
end

function Context:fixEngagement()
    for i=0,bj_MAX_PLAYERS,1 do
        local hero = hero.getHero(i)
        if hero ~= nil then
            local inPoly = collision.isCollidedWithPolygon(hero, self.cls:getBounds())
            if self.involvedHeroes[GetHandleId(hero)] ~= nil and not inPoly then
                -- Move inside poly
                SetUnitPosition(hero, self.cls.startX, self.cls.startY)
            elseif self.involvedHeroes[GetHandleId(hero)] == nil and inPoly then
                -- Move out of poly
                SetUnitPosition(hero, 4100, 3000)
            end
        end
    end
end

function Context:ensureEngagingUnitInvolved(engagingUnit)
    for _, hero in pairs(self.involvedHeroes) do
        if hero == engagingUnit then
            return
        end
    end
    self.involvedHeroes[GetHandleId(engagingUnit)] = engagingUnit
end

function Context:onBossEngaged()
    local unit = GetEventDamageSource()
    if GetUnitState(unit, UNIT_STATE_LIFE) <= 0 then
        return
    end

    print(self.cls:getName() .. " engaged...")
    DestroyTrigger(self.startFightTrigger)

    self.endFightTrigger = CreateTrigger()

    self.involvedHeroes = self:getHeroesInPoly()

    self:ensureEngagingUnitInvolved(unit)

    for _, hero in pairs(self.involvedHeroes) do
        TriggerRegisterUnitEvent(self.endFightTrigger, hero, EVENT_UNIT_DEATH)
    end

    TriggerRegisterUnitEvent(
        self.endFightTrigger, self.cls.bossUnit, EVENT_UNIT_DEATH)

    TriggerAddAction(self.endFightTrigger, function()
        self:onFightEnded()
    end)

    -- TODO make proper phase detection
    for _, phase in pairs(self.phases) do
        phase.phase:startPhase()
    end

    self.engageTimer = CreateTimer()
    TimerStart(self.engageTimer, 1, true, function()
        self:fixEngagement()
    end)

    for _, door in pairs(self.doors) do
        ModifyGateBJ(bj_GATEOPERATION_CLOSE, door.door)
    end
end

function Context:cleanupFight()
    for _, phase in pairs(self.phases) do
        phase.phase:endPhase()
    end
    DestroyTrigger(self.endFightTrigger)
    DestroyTimer(self.engageTimer)
end

function Context:startRespawn()
    TriggerSleepAction(60)
    self.cls.bossUnit =  CreateUnit(
        Player(PLAYER_NEUTRAL_AGGRESSIVE),
        self.cls.bossUnitId,
        self.cls.startX,
        self.cls.startY,
        self.cls.facing)
    self:resetFight()
end

function Context:resetFight()
    self:cleanupFight()

    self.startFightTrigger = CreateTrigger()
    TriggerRegisterUnitEvent(
        self.startFightTrigger, self.cls.bossUnit, EVENT_UNIT_DAMAGED)
    TriggerAddAction(self.startFightTrigger, function()
        self:onBossEngaged()
    end)

    for _, door in pairs(self.doors) do
        if door.openByDefault then
            ModifyGateBJ(bj_GATEOPERATION_OPEN, door.door)
        end
    end

    local maxHp = BlzGetUnitMaxHP(self.cls.bossUnit)
    BlzSetUnitRealField(self.cls.bossUnit, UNIT_RF_HP, maxHp)

    IssuePointOrder(self.cls.bossUnit, "move", self.cls.startX, self.cls.startY)
end

function init()
    for idx, cls in pairs(ALL_BOSS_CLASSES) do
        cls.bossUnit = CreateUnit(
            Player(PLAYER_NEUTRAL_AGGRESSIVE),
            cls.bossUnitId,
            cls.startX,
            cls.startY,
            cls.facing)

        cls.ctx = Context:new{idx = idx, cls = cls}
        cls:init()

        cls.ctx:resetFight()
    end
end

return {
    init = init,
}