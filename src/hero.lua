heroes = {}

local init = function()
	for i=0, bj_MAX_PLAYERS, 1 do
		if GetPlayerController(Player(i)) == MAP_CONTROL_USER then
	    	heroes[i] = CreateUnit(Player(i), FourCC("Hpal"), -150, -125, 0)
    	end
	end
end

local getHero = function(playerId)
	return heroes[playerId]
end

return {
	init = init,
	getHero = getHero,
}
