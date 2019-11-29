local hero = require('src/hero.lua')

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
    WARNING = {
        duration = 5,
        color = "|cffffee00",
        x = 0,
        y = 0,
    },
    SUCCESS = {
        duration = 3,
        color = "|cff00ff00",
        x = 0,
        y = 0,
    },
    INFO = {
        duration = 5,
        color = "|cff00cccc",
        x = 0,
        y = 0,
        floatingText = true,
    },
    QUEST = {
        duration = 5,
        color = "|cffcccc00",
        x = 0,
        y = 0,
    },
    DROP = {
        duration = 5,
        color = "|cff0fd156",
        x = 0,
        y = 0,
        floatingText = true,
    },
    ROLL = {
        duration = 5,
        color = "|cffd1800f",
        x = 0,
        y = 0,
    },
    EQUIPMENT_ERROR = {
        duration = 2,
        color = "|cffff0000",
        x = 1,
        y = 1,
    },
    VENDOR_ERROR = {
        duration = 1,
        color = "|cffff0000",
        x = 1,
        y = 1,
    },
    PICK_HERO_ERROR = {
        duration = 2,
        color = "|cffff0000",
        x = 0.4,
        y = 1,
    },
}

-- local curMsgTimer = {
--     [playerId] = timer
-- }
local curMsgTimer = {}

function logFloatingText(playerId, text, type, duration)
    local heroUnit = hero.getHero(playerId)

    if heroUnit == nil or not type.floatingText then
        return
    end

    if curMsgTimer[playerId] ~= nil then
        -- Some msg already playing, wait for that one to be done
        TimerStart(
            CreateTimer(),
            TimerGetRemaining(curMsgTimer[playerId]),
            false,
            function()
                logFloatingText(playerId, text, type, duration)
            end)
        return
    end

    if GetPlayerId(GetLocalPlayer()) ~= playerId then
        text = ""
    end

    local tag = CreateTextTag()
    SetTextTagText(
        tag,
        text,
        TextTagSize2Height(11))
    SetTextTagPosUnit(tag, heroUnit, 7)
    SetTextTagVelocity(
        tag,
        TextTagSpeed2Velocity(0),
        TextTagSpeed2Velocity(70))
    SetTextTagPermanent(tag, false)
    SetTextTagLifespan(tag, duration)
    SetTextTagFadepoint(tag, 0.01)

    curMsgTimer[playerId] = CreateTimer()
    TimerStart(curMsgTimer[playerId], 1.2, false, function()
        DestroyTimer(curMsgTimer[playerId])
        curMsgTimer[playerId] = nil
    end)

    TimerStart(CreateTimer(), duration, false, function()
        DestroyTextTag(tag)
        DestroyTimer(GetExpiredTimer())
    end)
end

local log = function(playerId, text, type, duration)
    text = type.color..text.."|r"
    duration = duration or type.duration

    DisplayTimedTextToPlayer(
        Player(playerId), type.x, type.y, duration, text)

    logFloatingText(playerId, text, type, duration)
end

return {
    TYPE = TYPE,
    log = log,
}
