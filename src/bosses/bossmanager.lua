local hero = require('src/hero.lua')
local threat = require('src/threat.lua')
local collision = require('src/collision.lua')

local Turtle = require('src/bosses/turtle.lua')
local Wolf = require('src/bosses/wolf.lua')

local TrollPriest = require('src/bosses/trollpriest.lua')
local Yeti = require('src/bosses/yeti.lua')
local TrollWarlord = require('src/bosses/trollwarlord.lua')

local Ratmaster = require('src/bosses/ratmaster.lua')
local Dreadsorrow = require('src/bosses/dreadsorrow.lua')

local ALL_BOSS_CLASSES = {
    -- WORLD BOSSES
    TURTLE = Turtle:new{
        bossUnitId = FourCC('hbos'),
        startX = -1135,
        startY = -7170,
        facing = 270,
        respawnable = false,
    },
    WOLF = Wolf:new{
        bossUnitId = FourCC('hbld'),
        startX = -8243,
        startY = 2033,
        facing = 165,
        respawnable = false,
    },

    -- ICY CAVERNS
    TROLL_PRIEST = TrollPriest:new{
        bossUnitId = FourCC('mine'),
        startX = 30371,
        startY = -24008,
        facing = 270,
        respawnable = false,
    },
    YETI = Yeti:new{
        bossUnitId = FourCC('h002'),
        startX = 30655,
        startY = -22214,
        facing = 180,
        respawnable = false,
    },
    TROLL_WARLORD = TrollWarlord:new{
        bossUnitId = FourCC('over'),
        startX = 28248,
        startY = -29136,
        facing = 128,
        respawnable = false,
    },

    -- IRONWELL SEWERS
    RATMASTER = Ratmaster:new{
        bossUnitId = FourCC('cubm'),
        startX = -26681,
        startY = 29305,
        facing = 6,
        respawnable = false,
    },
    DREADSORROW = Dreadsorrow:new{
        bossUnitId = FourCC('culb'),
        startX = -22875,
        startY = 27815,
        facing = 185,
        respawnable = false,
    },
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

function Phase:onStart(func)
    self.onStartCallback = func
end

function Phase:onFinish(func)
    self.onFinishCallback = func
end

function Phase:startPhase()
    print('starting a phase')
    if self.onStartCallback then
        self.onStartCallback()
    end
    for _, event in pairs(self.timedEvents) do
        local timer = CreateTimer()
        TimerStart(timer, event.interval, true, event.func)
        table.insert(self.timers, timer)
    end
end

function Phase:endPhase()
    if self.onFinishCallback then
        self.onFinishCallback()
    end
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
    if self.cls:getBounds() == false then
        -- Just get all heroes within 1500 yards
        local toReturn = {}
        for i=0,bj_MAX_PLAYERS,1 do
            local heroUnit = hero.getHero(i)
            if
                heroUnit ~= nil and
                IsUnitInRange(heroUnit, self.cls.bossUnit, 1500)
            then
                toReturn[GetHandleId(heroUnit)] = heroUnit
            end
        end
        return toReturn
    end

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

    if not threat.hasAnyThreat(self.cls.bossUnit) then
        print('You ran away')
        self.involvedHeroes = {}
        self:resetFight()
        return
    end

    if
        GetTriggerUnit() ~= nil and
        GetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE) <= 0
    then
        self.involvedHeroes[GetHandleId(GetTriggerUnit())] = nil
    end

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
    if self.cls:getBounds() == false then
        self:onFightEnded()
        return
    end

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

    self:onFightEnded()
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
    local unit = GetEventDamageSource() or GetEventTargetUnit()
    if GetUnitState(unit, UNIT_STATE_LIFE) <= 0 then
        return
    end

    print(self.cls:getName() .. " engaged...")
    DestroyTrigger(self.startFightTrigger)
    print('destroed engage trigger')

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
    self:respawnBoss()
end

function Context:respawnBoss()
    self.cls.bossUnit =  CreateUnit(
        Player(PLAYER_NEUTRAL_AGGRESSIVE),
        self.cls.bossUnitId,
        self.cls.startX,
        self.cls.startY,
        self.cls.facing)
    self:resetFight()
end

function Context:resetFight()
    print('resetfight called')
    self:cleanupFight()

    self.startFightTrigger = CreateTrigger()
    TriggerRegisterUnitEvent(
        self.startFightTrigger, self.cls.bossUnit, EVENT_UNIT_DAMAGED)
    TriggerRegisterUnitEvent(
        self.startFightTrigger, self.cls.bossUnit, EVENT_UNIT_ACQUIRED_TARGET)
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

    SetUnitPosition(self.cls.bossUnit, self.cls.startX, self.cls.startY)
    SetUnitFacing(self.cls.bossUnit, self.cls.facing)
end

function isBossAlive(boss)
    return GetUnitState(boss.bossUnit, UNIT_STATE_LIFE) > 0
end

function maybeRespawnBoss(boss)
    if not isBossAlive(boss) then
        boss.ctx:respawnBoss()
    end
end

function isBoss(unit)
    for _, cls in pairs(ALL_BOSS_CLASSES) do
        if cls.bossUnit == unit then
            return true
        end
    end
    return false
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
    ALL_BOSSES = ALL_BOSS_CLASSES,
    init = init,
    isBossAlive = isBossAlive,
    maybeRespawnBoss = maybeRespawnBoss,
    isBoss = isBoss,
}