local sharedLocationObj = Location(0, 0)

local createEffect = function(options)
    local x = options.x
    local y = options.y
    if options.unit then
        x = GetUnitX(options.unit)
        y = GetUnitY(options.unit)
    end

    local effect = AddSpecialEffect(options.model, x, y)

    if options.scale then
        BlzSetSpecialEffectScale(effect, options.scale)
    end
    if options.timeScale then
        BlzSetSpecialEffectTimeScale(effect, options.timeScale)
    end
    if options.z then
        MoveLocation(sharedLocationObj, x, y)
        BlzSetSpecialEffectZ(
            effect, GetLocationZ(sharedLocationObj) + options.z)
    end
    if options.facing then
        BlzSetSpecialEffectYaw(effect, options.facing)
    end

    local effectTimer = CreateTimer()
    TimerStart(effectTimer, options.duration, false, function()
        if options.remove then
            BlzSetSpecialEffectPosition(effect, -10000, -10000, -10000)
        end
        DestroyEffect(effect)
        DestroyTimer(effectTimer)
    end)
end

return {
    createEffect = createEffect,
}
