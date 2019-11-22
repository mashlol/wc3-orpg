local animTimers = {}

function queueAnimation(unit, animNum, duration)
    local unitId = GetHandleId(unit)
    if animTimers[unitId] ~= nil then
        DestroyTimer(animTimers[unitId])
    end
    local timer = CreateTimer()
    animTimers[unitId] = timer
    TimerStart(timer, duration + 0.01, false, function()
        -- Stop the anim
        maybeResetAnimation(unit)
    end)

    -- Start the anim
    SetUnitAnimationByIndex(unit, animNum)
end

function maybeResetAnimation(unit)
    local unitId = GetHandleId(unit)
    local animTimer = animTimers[unitId]
    if animTimer ~= nil then
        DestroyTimer(animTimer)
        SetUnitAnimationByIndex(unit, 0)
        animTimers[unitId] = nil
    end
end

return {
    queueAnimation = queueAnimation,
    maybeResetAnimation = maybeResetAnimation,
}
