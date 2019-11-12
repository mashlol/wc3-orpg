function init()
    for key, val in pairs(_G) do
        if
            string.match(key, "house") and
            (string.match(key, "enter") or string.match(key, "leave"))
        then
            local enterRectTrigger = CreateTrigger()
            TriggerRegisterEnterRectSimple(enterRectTrigger, val)
            TriggerAddAction(enterRectTrigger, function()
                local digitIdx = string.find(key, "%d")
                local digitEnd = string.find(key, "[^%d]", digitIdx)

                local houseIdx = string.sub(key, digitIdx, S2I(digitEnd) - 1)

                local digitIdx = string.find(key, "%d", digitEnd)
                local digitEnd = string.len(key)

                local regionIdx = string.sub(key, digitIdx, S2I(digitEnd))

                local dest = string.match(key, "enter") and "entrance" or "exit"
                local destRegionName = "gg_rct_house"..houseIdx..dest..regionIdx

                local destRect = _G[destRegionName]
                local enteredUnit = GetTriggerUnit()
                local x = GetRectCenterX(destRect)
                local y = GetRectCenterY(destRect)
                SetUnitPosition(enteredUnit, x, y)

                if GetOwningPlayer(enteredUnit) == GetLocalPlayer() then
                    PanCameraToTimed(x, y, 0)
                end
            end)
        end
    end
end

return {
    init = init,
}