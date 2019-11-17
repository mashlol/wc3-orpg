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
    local button = BlzCreateFrame("GrungeButton", originFrame, 0, 0)
    local buttonText = BlzGetFrameByName("GrungeButtonText", 0)
    BlzFrameSetParent(button, origin)
    BlzFrameSetSize(button, 0.16, 0.053)
    BlzFrameSetPoint(
        button,
        FRAMEPOINT_TOP,
        origin,
        FRAMEPOINT_TOP,
        0,
        yOffset)
    BlzFrameSetText(buttonText, "This is a quest name")
    BlzFrameSetScale(buttonText, 0.75)

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

    utils.createBorderFrame(origin, "QUEST LOG")

    local buttons = {}
    for i=1,12,1 do
        table.insert(buttons, createQuestButton(origin, originFrame, -(i - 1) * 0.053 - 0.025, i))
    end

    utils.createCloseButton(origin, function(playerId)
        questLogToggles[playerId] = nil
    end)

    self.frames = {
        origin = origin,
        buttons = buttons,
    }

    return self
end

function QuestLog:update(playerId)
    local frames = self.frames

    local isVisible = questLogToggles[playerId] == true and self.hero ~= nil
    BlzFrameSetVisible(frames.origin, isVisible)

    if not isVisible then
        return
    end

    local activeQuests = quests.getActiveQuests(playerId)

    for i=1,12,1 do
        local button = frames.buttons[i]

        BlzFrameSetVisible(button.button, activeQuests[i] ~= nil)

        local btnText = ""
        if activeQuests[i] ~= nil then
            btnText = quests.getQuestInfo(activeQuests[i]).name
            if quests.questObjectivesCompleted(playerId, activeQuests[i]) then
                btnText = btnText .. ' (Completed)'
            end
        end

        BlzFrameSetText(button.text, btnText)
    end
end

return QuestLog
