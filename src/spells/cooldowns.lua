-- cooldowns = {
--   [playerId] = {
--     [spellId] = {timer},
--   },
-- }
local cooldowns = {}

function isOnCooldown(playerId, spellId)
    return cooldowns[playerId][spellId] ~= nil and
        TimerGetRemaining(cooldowns[playerId][spellId]) > 0
end

function startCooldown(playerId, spellId, duration)
    -- TODO check if there is an old timer to destroy

    local timer = CreateTimer()
    TimerStart(timer, duration, false, nil)
    cooldowns[playerId][spellId] = timer
end

function getRemainingCooldown(playerId, spellId)
    if cooldowns[playerId][spellId] ~= nil then
        return TimerGetRemaining(cooldowns[playerId][spellId])
    end
    return 0
end

function getTotalCooldown(playerId, spellId)
    if cooldowns[playerId][spellId] ~= nil then
        return TimerGetTimeout(cooldowns[playerId][spellId])
    end
    return 1
end

function init()
    print('inited')
    for i=0,bj_MAX_PLAYERS,1 do
        cooldowns[i] = {}
    end
end

return {
    init = init,
    isOnCooldown = isOnCooldown,
    startCooldown = startCooldown,
    getRemainingCooldown = getRemainingCooldown,
    getTotalCooldown = getTotalCooldown,
}
