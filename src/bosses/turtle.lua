local boss

local startFightTrigger
local endFightTrigger
local timer

local resetFight
local onFightStarted
local onFightEnded
local castSlam
local isAllInvolvedHeroesDead
local cleanupFight

local door

local involvedHeroes = {}

isAllInvolvedHeroesDead = function()
    for idx, hero in pairs(involvedHeroes) do
        if GetUnitState(hero, UNIT_STATE_LIFE) > 0 then
            return false
        end
    end
    return true
end

castSlam = function()
    print(IssueImmediateOrder(boss, "creepthunderclap"))
end

cleanupFight = function()
    DestroyTrigger(endFightTrigger)
    DestroyTimer(timer)
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
    print("Turtle engaged...")
    DestroyTrigger(startFightTrigger)

    endFightTrigger = CreateTrigger()

    local grp = GetUnitsInRangeOfLocAll(3000, GetUnitLoc(boss))
    ForGroupBJ(grp, function()
        local unit = GetEnumUnit()
        -- TODO what about pets and stuff?
        if unit ~= boss then
            table.insert(involvedHeroes, unit)
            TriggerRegisterUnitEvent(
                endFightTrigger, unit, EVENT_UNIT_DEATH)
        end
    end)

    TriggerRegisterUnitEvent(
        endFightTrigger, boss, EVENT_UNIT_DEATH)

    TriggerAddAction(endFightTrigger, onFightEnded)

    timer = CreateTimer()
    TimerStart(timer, 10, true, castSlam)

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
