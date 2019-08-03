local effects = {}

local clearEffects = function()
    local elapsedTime = TimerGetElapsed(timer)

    for idx, effect in pairs(effects) do
        if (TimerGetRemaining(effect.effectTimer) <= 0.1) then
           KillUnit(effect.unit)
            effect.toRemove = true
        end
    end

    local newEffects = {}
    for idx, effect in pairs(effects) do
        if effect.toRemove ~= true then
            table.insert(newEffects, effect)
        end
    end
    effects = newEffects
end

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
        0)

    local effectTimer = CreateTimer()
    TimerStart(effectTimer, options.duration, false, nil)
    table.insert(effects, {
        unit = dummy,
        effectTimer = effectTimer,
        options = options,
    })
end

local init = function()
    timer = CreateTimer()
    TimerStart(timer, 0.03125, true, clearEffects)
end

return {
    createEffect = createEffect,
    init = init,
}
