local Vector = require('src/vector.lua')
local hero = require('src/hero.lua')
local collision = require('src/collision.lua')
local backpack = require('src/items/backpack.lua')

local boss

local startFightTrigger
local endFightTrigger
local slamTimer
local addTimer
local engageTimer

local resetFight
local onFightStarted
local onFightEnded
local cleanupFight

local door

local TURTLE_AREA_BOUNDS = {
    {x = -549, y = -3255},
    {x = 1723, y = -3647},
    {x = 2206, y = -2984},
    {x = 2260, y = -1558},
    {x = 1733, y = -322},
    {x = 618, y = -866},
    {x = -430, y = -1754},
    {x = -991, y = -2655},
}

local involvedHeroes = {}

local getNumInvolvedHeroes = function()
    local i = 0
    for idx, hero in pairs(involvedHeroes) do
        i = i + 1
    end
    return i
end

local isAllInvolvedHeroesDead = function()
    for idx, hero in pairs(involvedHeroes) do
        if hero ~= nil then
            return false
        end
    end
    return true
end

local getHeroesInPoly = function()
    local toReturn = {}
    for i=0,bj_MAX_PLAYERS,1 do
        local hero = hero.getHero(i)
        if
            hero ~= nil and
            collision.isCollidedWithPolygon(hero, TURTLE_AREA_BOUNDS)
        then
            toReturn[GetHandleId(hero)] = hero
        end
    end
    return toReturn
end

local castSlam = function()
    IssueImmediateOrder(boss, "creepthunderclap")
end

local fixEngagement = function()
    for i=0,bj_MAX_PLAYERS,1 do
        local hero = hero.getHero(i)
        if hero ~= nil then
            local inPoly = collision.isCollidedWithPolygon(hero, TURTLE_AREA_BOUNDS)
            if involvedHeroes[GetHandleId(hero)] ~= nil and not inPoly then
                -- Move inside poly
                SetUnitPosition(hero, 450, -1650)
            elseif involvedHeroes[GetHandleId(hero)] == nil and inPoly then
                -- Move out of poly
                SetUnitPosition(hero, 0, 0)
            end
        end
    end
end

local spawnAdds = function()
    for i=0,2,1 do
        local bossV = Vector:new{x = GetUnitX(boss), y = GetUnitY(boss)}
        local spawnLocation = Vector:fromAngle(GetRandomReal(0, 2 * bj_PI))
            :multiply(BlzGetUnitCollisionSize(boss) + 150)
            :add(bossV)
        local add = CreateUnit(
            Player(PLAYER_NEUTRAL_AGGRESSIVE),
            FourCC("hmbs"),
            spawnLocation.x,
            spawnLocation.y,
            135.939)
        IssueTargetOrder(
            add,
            "attack",
            involvedHeroes[GetRandomInt(1, getNumInvolvedHeroes())])
    end
end

cleanupFight = function()
    DestroyTrigger(endFightTrigger)
    DestroyTimer(slamTimer)
    DestroyTimer(addTimer)
    DestroyTimer(engageTimer)
end

resetFight = function()
    cleanupFight()

    startFightTrigger = CreateTrigger()
    TriggerRegisterUnitEvent(
        startFightTrigger, boss, EVENT_UNIT_DAMAGED)
    TriggerAddAction(startFightTrigger, onFightStarted)

    involvedHeroes = {}

    ModifyGateBJ(bj_GATEOPERATION_OPEN, door)

    local maxHp = BlzGetUnitMaxHP(boss)
    BlzSetUnitRealField(boss, UNIT_RF_HP, maxHp)

    IssuePointOrder(boss, "move", 1268.7, -2846.7)
end

onFightEnded = function()
    if GetUnitState(boss, UNIT_STATE_LIFE) <= 0 then
        print("You killed turtle.")
        -- TODO implement a loot system
        for i=0,bj_MAX_PLAYERS,1 do
            backpack.addItemIdToBackpack(i, 1)
        end
        cleanupFight()
        return
    end

    involvedHeroes[GetHandleId(GetTriggerUnit())] = nil

    if isAllInvolvedHeroesDead() then
        print("You lost.")
        resetFight()
        return
    end
end

onFightStarted = function()
    local unit = GetEventDamageSource()
    if GetUnitState(unit, UNIT_STATE_LIFE) <= 0 then
        return
    end

    print("Turtle engaged...")
    DestroyTrigger(startFightTrigger)

    endFightTrigger = CreateTrigger()

    involvedHeroes = getHeroesInPoly()

    for idx, hero in pairs(involvedHeroes) do
        TriggerRegisterUnitEvent(endFightTrigger, hero, EVENT_UNIT_DEATH)
    end

    TriggerRegisterUnitEvent(
        endFightTrigger, boss, EVENT_UNIT_DEATH)

    TriggerAddAction(endFightTrigger, onFightEnded)

    slamTimer = CreateTimer()
    TimerStart(slamTimer, 10, true, castSlam)

    addTimer = CreateTimer()
    TimerStart(addTimer, 25, true, spawnAdds)

    engageTimer = CreateTimer()
    TimerStart(engageTimer, 3, true, fixEngagement)

    ModifyGateBJ(bj_GATEOPERATION_CLOSE, door)
end

local init = function()
    door = gg_dest_DTg6_0369
    boss = CreateUnit(
        Player(PLAYER_NEUTRAL_AGGRESSIVE), FourCC("hbos"), 1268.7, -2846.7, 135.939)

    resetFight()
end

return {
    init = init,
}
