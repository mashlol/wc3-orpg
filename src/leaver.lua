local hero = require('src/hero.lua')

local onLeave = function()
    DisplayTextToForce(
        GetPlayersAll(),
        GetPlayerName(GetTriggerPlayer()).." has left the game.")

    hero.removeHero(GetPlayerId(GetTriggerPlayer()))
end

local init = function()
    local trigger = CreateTrigger()
    for i=0,bj_MAX_PLAYER_SLOTS-1,1 do
        TriggerRegisterPlayerEventLeave(trigger, Player(i))
    end
    TriggerAddAction(trigger, onLeave)
end

return {
    init = init,
}
