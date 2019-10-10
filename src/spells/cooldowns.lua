local buffloop = require('src/buffloop.lua')
local hero = require('src/hero.lua')

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
    if cooldowns[playerId][spellId] ~= nil then
        DestroyTimer(cooldowns[playerId][spellId])
    end

    local heroUnit = hero.getHero(playerId)
    duration = buffloop.getUnitInfo(heroUnit).cooldownReduction * duration

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
