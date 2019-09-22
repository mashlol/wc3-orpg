local consts = require('src/ui/consts.lua')
local utils = require('src/ui/utils.lua')
local quests = require('src/quests/main.lua')

-- questLogToggles = {
--     [playerId] = true or nil
-- }
local questLogToggles = {}

local QuestLog = {
    toggle = function(playerId)
        questLogToggles[playerId] = not questLogToggles[playerId]
    end,
}

function QuestLog:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function createQuestButton(origin, originFrame, yOffset, index)
    local button = BlzCreateFrame("ScriptDialogButton", originFrame, 0, 0)
    local buttonText = BlzGetFrameByName("ScriptDialogButtonText", 0)
    BlzFrameSetParent(button, origin)
    BlzFrameSetSize(button, 0.16, 0.028)
    BlzFrameSetPoint(
        button,
        FRAMEPOINT_TOP,
        origin,
        FRAMEPOINT_TOP,
        0,
        yOffset)
    BlzFrameSetText(buttonText, "This is a quest name")

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        trig, button, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        local playerId = GetPlayerId(GetTriggerPlayer())
        quests.showDialogForActiveQuest(playerId, index)


        BlzFrameSetEnable(BlzGetTriggerFrame(), false)
        BlzFrameSetEnable(BlzGetTriggerFrame(), true)
    end)

    return {
        button = button,
        text = buttonText,
    }
end

function QuestLog:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local origin = BlzCreateFrameByType(
        "FRAME",
        "origin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        origin, consts.QUEST_LOG_WIDTH, consts.QUEST_LOG_HEIGHT)
    BlzFrameSetAbsPoint(
        origin,
        FRAMEPOINT_LEFT,
        0,
        0.35)

    utils.createBorderFrame(origin)

    local text = BlzCreateFrameByType(
        "TEXT",
        "text",
        origin,
        "",
        0)
    BlzFrameSetSize(text, consts.QUEST_LOG_WIDTH - 0.02, consts.QUEST_LOG_HEIGHT)
    BlzFrameSetPoint(
        text,
        FRAMEPOINT_TOPLEFT,
        origin,
        FRAMEPOINT_TOPLEFT,
        0.01,
        -0.01)
    BlzFrameSetText(text, "Quest Log")

    local buttons = {}
    for i=1,12,1 do
        table.insert(buttons, createQuestButton(origin, originFrame, i * -0.03, i))
    end

    self.frames = {
        origin = origin,
        text = text,
        buttons = buttons,
    }

    return self
end

function QuestLog:update(playerId)
    local frames = self.frames

    BlzFrameSetVisible(frames.origin, questLogToggles[playerId] == true)

    local activeQuests = quests.getActiveQuests(playerId)

    for i=1,12,1 do
        local button = frames.buttons[i]

        BlzFrameSetVisible(button.button, activeQuests[i] ~= nil)
        BlzFrameSetText(
            button.text,
            activeQuests[i] ~= nil and
                quests.getQuestInfo(activeQuests[i]).name or
                "")
    end
end

return QuestLog
