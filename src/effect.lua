local createEffect = function(options)
    local x = options.x
    local y = options.y
    if options.unit then
        x = GetUnitX(options.unit)
        y = GetUnitY(options.unit)
    end

    local dummy = CreateUnit(
        Player(24),
        FourCC(options.model),
        x,
        y,
        options.facing or 0)

    if options.scale then
        SetUnitScale(dummy, options.scale, options.scale, options.scale)
    end

    if options.timeScale then
        SetUnitTimeScale(dummy, options.timeScale)
    end

    local effectTimer = CreateTimer()
    TimerStart(effectTimer, options.duration, false, function()
        KillUnit(dummy)
        DestroyTimer(effectTimer)
    end)
end

return {
    createEffect = createEffect,
}
