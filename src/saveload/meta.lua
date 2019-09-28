local file = require('src/saveload/file.lua')

local MAX_NUM_CHARS = 7

function getUsedSlots()
    local slots = {}
    for i=1,MAX_NUM_CHARS,1 do
        local contents = file.readFile('tvtsave' .. i .. '.pld')
        if contents ~= nil then
            local pipeCharLoc = string.find(contents, '|', 0, true)
            local metaData
            if pipeCharLoc == nil then
                metaData = 'Unknown Character (#' .. i .. ')'
            else
                metaData = string.sub(contents, pipeCharLoc + 1)
            end
            slots[i] = metaData
        end
    end

    return slots
end

function getNextEmptySlot()
    local num = 1
    while true do
        if not file.exists('tvtsave' .. num .. '.pld') then
            return num
        end
        num = num + 1
    end
end

return {
    MAX_NUM_CHARS = MAX_NUM_CHARS,
    getUsedSlots = getUsedSlots,
    getNextEmptySlot = getNextEmptySlot,
}