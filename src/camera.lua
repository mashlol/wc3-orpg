local hero = require('src/hero.lua')
local log = require('src/log.lua')

local cameraToggles = {}

function onCameraTick()
    local playerId = GetPlayerId(GetLocalPlayer())
    local hero = hero.getHero(playerId)
    if hero == nil then
        return
    end
    SetCameraQuickPosition(GetUnitX(hero), GetUnitY(hero))
    if cameraToggles[playerId] then
        CameraSetupApplyForceDuration(gg_cam_Camera_001, false, 0)
    end
end

function isCustomCameraOn(playerId)
    return cameraToggles[playerId]
end

function toggleCam()
    local playerId = GetPlayerId(GetTriggerPlayer())
    cameraToggles[playerId] = not cameraToggles[playerId]
    if cameraToggles[playerId] then
        log.log(playerId, "You're now using the custom camera.", log.TYPE.INFO)
    else
        log.log(playerId, "You're back to the default wc3 camera.", log.TYPE.INFO)
        if playerId == GetPlayerId(GetLocalPlayer()) then
            ResetToGameCamera(0)
        end
    end
end

function init()
    TimerStart(CreateTimer(), 1, true, onCameraTick)

    for i=0,bj_MAX_PLAYERS-1,1 do
        cameraToggles[i] = true
    end

    local tipsTrigger = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerChatEvent(tipsTrigger, Player(i), "-cam", true)
    end
    TriggerAddAction(tipsTrigger, toggleCam)
end

return {
    init = init,
    isCustomCameraOn = isCustomCameraOn,
}
