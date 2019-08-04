
local TYPE = {
    NORMAL = {
        duration = 5,
        color = "|cffffffff",
        x = 0,
        y = 0,
    },
    ERROR = {
        duration = 1,
        color = "|cffff0000",
        x = 0,
        y = 0,
    },
}

local log = function(playerId, text, type, duration)
    DisplayTimedTextToPlayer(
        Player(playerId), type.x, type.y, duration or type.duration, type.color..text.."|r")
end


return {
    TYPE = TYPE,
    log = log,
}
