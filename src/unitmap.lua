local unitMap = {}

function getUnitByHandleId(handleId)
    print('getting unit by handle:', handleId)
    for handle,unit in pairs(unitMap) do
        print(handle, unit)
    end
    return unitMap[handleId]
end

function createTargetableUnit(player, unitid, x, y, facing)
    local unit = CreateUnit(player, unitid, x, y, facing)
    unitMap[GetHandleId(unit)] = unit
    return unit
end

return {
    getUnitByHandleId = getUnitByHandleId,
    createTargetableUnit = createTargetableUnit,
}
