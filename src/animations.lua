local queues = {}

function queueAnimation(unit, animNum, duration)
    local unitId = GetHandleId(unit)
    if queues[unitId] ~= nil then
        DestroyTimer(queues[unitId])
    end
    local timer = CreateTimer()
    queues[unitId] = timer
    TimerStart(timer, duration, false, function()
        -- Stop the anim
         DestroyTimer(timer)
         SetUnitAnimationByIndex(unit, 0)
    end)

    -- Start the anim
    SetUnitAnimationByIndex(unit, animNum)
end

function resetAnimation(unit)
    SetUnitAnimationByIndex(unit, 0)
end

return {
    queueAnimation = queueAnimation,
    resetAnimation = resetAnimation,
}
