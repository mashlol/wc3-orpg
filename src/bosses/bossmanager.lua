local Turtle = require('src/bosses/turtle.lua')
local Wolf = require('src/bosses/wolf.lua')
local backpack = require('src/items/backpack.lua')
local hero = require('src/hero.lua')
local collision = require('src/collision.lua')

local ALL_BOSS_CLASSES = {
    Turtle:new{
        bossUnitId = FourCC('hbos'),
        startX = 398,
        startY = 3416,
        facing = 280,
    },
    Wolf:new{
        bossUnitId = FourCC('hbld'),
        startX = -3077,
        startY = -8518,
        facing = 0,
    },
}

local Phase = {
    timers = {},
    timedEvents = {},
}

function Phase:new(o)
    o = o or {}
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
    for idx, event in pairs(self.timedEvents) do
        local timer = CreateTimer()
        TimerStart(timer, event.interval, true, event.func)
        table.insert(self.timers, timer)
    end
end

function Phase:endPhase()
    for idx, timer in pairs(self.timers) do
        DestroyTimer(timer)
    end

    self.timers = {}
end

local Context = {
    phases = {},
    involvedHeroes = {},
    doors = {},
}

function Context:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Context:registerDoor(door)
    table.insert(self.doors, door)
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
        print("You killed bandit captain.")
        -- TODO implement a loot system
        for i=0,bj_MAX_PLAYERS,1 do
            backpack.addItemIdToBackpack(i, 1)
        end
        self:cleanupFight()
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
    for idx, hero in pairs(self.involvedHeroes) do
        if hero ~= nil then
            table.insert(compactHeroes, hero)
        end
    end

    local randomHero = GetRandomInt(1, #compactHeroes)
    return compactHeroes[randomHero]
end

function Context:isAllInvolvedHeroesDead()
    for idx, hero in pairs(self.involvedHeroes) do
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
                SetUnitPosition(hero, 0, 0)
            end
        end
    end
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

    for idx, hero in pairs(self.involvedHeroes) do
        TriggerRegisterUnitEvent(self.endFightTrigger, hero, EVENT_UNIT_DEATH)
    end

    TriggerRegisterUnitEvent(
        self.endFightTrigger, self.cls.bossUnit, EVENT_UNIT_DEATH)

    TriggerAddAction(self.endFightTrigger, function()
        self:onFightEnded()
    end)

    -- TODO make proper phase detection
    for idx, phase in pairs(self.phases) do
        phase.phase:startPhase()
    end

    self.engageTimer = CreateTimer()
    TimerStart(self.engageTimer, 1, true, function()
        self:fixEngagement()
    end)

    for idx, door in pairs(self.doors) do
        ModifyGateBJ(bj_GATEOPERATION_CLOSE, door)
    end
end

function Context:cleanupFight()
    for idx, phase in pairs(self.phases) do
        phase.phase:endPhase()
    end
    DestroyTrigger(self.endFightTrigger)
    DestroyTimer(self.engageTimer)
end

function Context:resetFight()
    self:cleanupFight()

    self.startFightTrigger = CreateTrigger()
    TriggerRegisterUnitEvent(
        self.startFightTrigger, self.cls.bossUnit, EVENT_UNIT_DAMAGED)
    TriggerAddAction(self.startFightTrigger, function()
        self:onBossEngaged()
    end)

    for idx, door in pairs(self.doors) do
        ModifyGateBJ(bj_GATEOPERATION_OPEN, door)
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