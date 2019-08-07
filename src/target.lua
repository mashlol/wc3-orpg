local hero = require('src/hero.lua')

targets = {}

local getTarget = function(playerId)
    return targets[playerId]
end

local hasTarget = function(playerId)
    return targets[playerId] ~= nil
end

local setTarget = function(playerId, unit)
    if targets[playerId] ~= unit then
        -- local sound = CreateSound(
        --     "Sound\\Interface\\SubGroupSelectionChange1.wav",
        --     false,
        --     false,
        --     false,
        --     0,
        --     0,
        --     "DefaultEAXON")
        -- if playerId == GetPlayerId(GetLocalPlayer()) then
        --     StartSound(sound)
        -- end
        -- KillSoundWhenDone(sound)
    end

    targets[playerId] = unit
end

return {
    getTarget = getTarget,
    setTarget = setTarget,
}
