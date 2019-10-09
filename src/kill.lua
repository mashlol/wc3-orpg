local hero = require('src/hero.lua')

function onKillCommand()
    local playerId = GetPlayerId(GetTriggerPlayer())

    local heroUnit = hero.getHero(playerId)
    KillUnit(heroUnit)
end

function init()
    local inviteTrig = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerChatEvent(inviteTrig, Player(i), "-kill", true)
    end
    TriggerAddAction(inviteTrig, onKillCommand)
end


return {
    init = init,
}
