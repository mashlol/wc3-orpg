local hero = require('src/hero.lua')

function onTick()
    local playerId = GetPlayerId(GetLocalPlayer())
    local hero = hero.getHero(playerId)
    SetCameraQuickPosition(GetUnitX(hero), GetUnitY(hero))
end

function init()
    TimerStart(CreateTimer(), 1, true, onTick)
end

return {
    init = init,
}
