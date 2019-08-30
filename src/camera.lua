local hero = require('src/hero.lua')

function onCameraTick()
    local playerId = GetPlayerId(GetLocalPlayer())
    local hero = hero.getHero(playerId)
    SetCameraQuickPosition(GetUnitX(hero), GetUnitY(hero))
end

function init()
    -- TimerStart(CreateTimer(), 1, true, onCameraTick)
end

return {
    init = init,
}
