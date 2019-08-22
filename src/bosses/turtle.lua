local Vector = require('src/vector.lua')
local hero = require('src/hero.lua')
local collision = require('src/collision.lua')

local boss

local startFightTrigger
local endFightTrigger
local slamTimer
local addTimer

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
            table.insert(toReturn, hero)
        end
    end
    return toReturn
end

local castSlam = function()
    IssueImmediateOrder(boss, "creepthunderclap")
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
        cleanupFight()
        return
    end

    for idx, unit in pairs(involvedHeroes) do
        if unit == GetTriggerUnit() then
            involvedHeroes[idx] = nil
        end
    end

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
