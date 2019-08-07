heroes = {}

local respawn = function()
    local unit = GetDyingUnit()

    TriggerSleepAction(10)

    for i=0, bj_MAX_PLAYERS, 1 do
        if unit == heroes[i] then
            heroes[i] = CreateUnit(Player(i), FourCC("Hpal"), -150, -125, 0)
        end
    end
end

local init = function()
	for i=0, bj_MAX_PLAYERS, 1 do
		if GetPlayerController(Player(i)) == MAP_CONTROL_USER then
	    	heroes[i] = CreateUnit(Player(i), FourCC("Hpal"), -150, -125, 0)
    	end
	end

    local trigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trigger, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(trigger, respawn)
end

local getHero = function(playerId)
	return heroes[playerId]
end

local isHero = function(unit)
    for idx, hero in pairs(heroes) do
        if unit == hero then
            return true
        end
    end
    return false
end

return {
	init = init,
	getHero = getHero,
    isHero = isHero
}
