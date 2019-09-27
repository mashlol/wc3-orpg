local hero = require('src/hero.lua')

function onCameraTick()
    local playerId = GetPlayerId(GetLocalPlayer())
    local hero = hero.getHero(playerId)
    if hero == nil then
        return
    end
    SetCameraQuickPosition(GetUnitX(hero), GetUnitY(hero))
    CameraSetupApplyForceDuration(gg_cam_Camera_001, false, 0)
end

function init()
    TimerStart(CreateTimer(), 1, true, onCameraTick)
end

return {
    init = init,
}
