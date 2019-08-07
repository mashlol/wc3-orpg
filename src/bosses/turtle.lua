local vector = require('src/vector.lua')
local hero = require('src/hero.lua')

local boss

local startFightTrigger
local endFightTrigger
local slamTimer
local addTimer

local resetFight
local onFightStarted
local onFightEnded
local castSlam
local spawnAdds
local isAllInvolvedHeroesDead
local cleanupFight

local door

local involvedHeroes = {}

local getNumInvolvedHeroes = function()
    local i = 0
    for idx, hero in pairs(involvedHeroes) do
        i = i + 1
    end
    return i
end

isAllInvolvedHeroesDead = function()
    for idx, hero in pairs(involvedHeroes) do
        if GetUnitState(hero, UNIT_STATE_LIFE) > 0 then
            return false
        end
    end
    return true
end

castSlam = function()
    IssueImmediateOrder(boss, "creepthunderclap")
end

spawnAdds = function()
    for i=0,2,1 do
        local spawnLocation = vector.fromAngle(GetRandomReal(0, bj_PI))
        spawnLocation = vector.multiply(
            spawnLocation, BlzGetUnitCollisionSize(boss) + 150)
        spawnLocation = vector.add(
            spawnLocation, vector.create(GetUnitX(boss), GetUnitY(boss)))
        local add = CreateUnit(
            Player(24),
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

    local grp = GetUnitsInRangeOfLocAll(3000, GetUnitLoc(boss))
    ForGroupBJ(grp, function()
        local unit = GetEnumUnit()
        -- TODO what about pets and stuff?
        if hero.isHero(unit) then
            table.insert(involvedHeroes, unit)
            TriggerRegisterUnitEvent(
                endFightTrigger, unit, EVENT_UNIT_DEATH)
        end
    end)

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
    boss = CreateUnit(Player(24), FourCC("hbos"), 1268.7, -2846.7, 135.939)

    resetFight()
end

return {
    init = init,
}
