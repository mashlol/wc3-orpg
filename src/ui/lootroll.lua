local consts = require('src/ui/consts.lua')
local tooltip = require('src/ui/tooltip.lua')
local utils = require('src/ui/utils.lua')
local itemmanager = require('src/items/itemmanager.lua')
local drops = require('src/items/drops.lua')

local ITEM_ICON_PADDING = 0.0035
local BUTTONS = {
    "NEED", "GREED", "PASS"
}

-- playerRolls = {
--     [playerId] = {
--         1, 2, 3, -- rollIds (see src/items/drops.lua) in a list
--     }
-- }
local playerRolls = {}

local LootRoll = {
    startRoll = function(playerId, rollId)
        if playerRolls[playerId] == nil then
            playerRolls[playerId] = {}
        end
        table.insert(playerRolls[playerId], rollId)
    end,
    pruneRoll = function(rollId)
        -- When the roll ends, we'll ensure that no player still has the UI
        for i=0,bj_MAX_PLAYERS,1 do
            if playerRolls[i] ~= nil then
                local idxToPrune = nil
                for idx, rollIdB in pairs(playerRolls[i]) do
                    if rollIdB == rollId then
                        idxToPrune = idx
                    end
                end
                if idxToPrune ~= nil then
                    -- Force a pass
                    drops.onRollMade(i, playerRolls[i][idxToPrune], 2)
                    table.remove(playerRolls[i], idxToPrune)
                end
            end
        end
    end,
}

function LootRoll:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function LootRoll:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local origin = BlzCreateFrameByType("FRAME", "origin", originFrame, "", 0)
    BlzFrameSetSize(origin, consts.LOOT_ROLL_WIDTH, consts.LOOT_ROLL_HEIGHT)
    BlzFrameSetAbsPoint(origin, FRAMEPOINT_CENTER, 0.4, 0.2)

    utils.createBorderFrame(origin)

    local itemBackdropFrame = BlzCreateFrameByType(
        "BACKDROP", "itemBackdropFrame", origin, "", 0)
    BlzFrameSetSize(
        itemBackdropFrame,
        (consts.LOOT_ROLL_WIDTH - 0.02) * 3 / 4,
        consts.LOOT_ROLL_HEIGHT / 2)
    BlzFrameSetPoint(
        itemBackdropFrame,
        FRAMEPOINT_TOPLEFT,
        origin,
        FRAMEPOINT_TOPLEFT,
        0.01,
        -0.01)
    BlzFrameSetTexture(
        itemBackdropFrame,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)
    BlzFrameSetAlpha(itemBackdropFrame, 100)

    local itemIconBackdropFrame = BlzCreateFrameByType(
        "BACKDROP", "itemIconBackdropFrame", origin, "", 0)
    BlzFrameSetSize(
        itemIconBackdropFrame,
        consts.LOOT_ROLL_HEIGHT / 2 - ITEM_ICON_PADDING * 2,
        consts.LOOT_ROLL_HEIGHT / 2 - ITEM_ICON_PADDING * 2)
    BlzFrameSetPoint(
        itemIconBackdropFrame,
        FRAMEPOINT_TOPLEFT,
        itemBackdropFrame,
        FRAMEPOINT_TOPLEFT,
        ITEM_ICON_PADDING,
        -ITEM_ICON_PADDING)
    BlzFrameSetTexture(
        itemIconBackdropFrame,
        "ReplaceableTextures\\CommandButtons\\BTNBoots.blp",
        0,
        true)

    local hoverFrame = BlzCreateFrameByType(
        "GLUEBUTTON",
        "hoverFrame",
        itemIconBackdropFrame,
        "IconButtonTemplate",
        0)

    local tooltipFrame = tooltip.makeTooltipFrame(
        itemIconBackdropFrame, 0.16, 0.24, hoverFrame, false, false)

    local itemTextFrame = BlzCreateFrameByType(
        "TEXT", "itemTextFrame", origin, "", 0)
    BlzFrameSetSize(
        itemTextFrame,
        (consts.LOOT_ROLL_WIDTH - 0.02) * 3 / 4 - consts.LOOT_ROLL_HEIGHT / 2 - ITEM_ICON_PADDING * 2,
        consts.LOOT_ROLL_HEIGHT / 2 - ITEM_ICON_PADDING * 2)
    BlzFrameSetPoint(
        itemTextFrame,
        FRAMEPOINT_TOPLEFT,
        itemIconBackdropFrame,
        FRAMEPOINT_TOPRIGHT,
        ITEM_ICON_PADDING,
        0)
    BlzFrameSetText(itemTextFrame, "Some Item With A Huge Name Omg So Long")

    local progressBarBackdropFrame = BlzCreateFrameByType(
        "BACKDROP", "progressBarBackdropFrame", origin, "", 0)
    BlzFrameSetSize(
        progressBarBackdropFrame,
        (consts.LOOT_ROLL_WIDTH - 0.02) * 3 / 4,
        consts.LOOT_ROLL_HEIGHT * 1 / 6)
    BlzFrameSetPoint(
        progressBarBackdropFrame,
        FRAMEPOINT_BOTTOMLEFT,
        origin,
        FRAMEPOINT_BOTTOMLEFT,
        0.01,
        0.01)
    BlzFrameSetTexture(
        progressBarBackdropFrame,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)

    local progressBarFilledBackdropFrame = BlzCreateFrameByType(
        "BACKDROP", "progressBarFilledBackdropFrame", origin, "", 0)
    BlzFrameSetSize(
        progressBarFilledBackdropFrame,
        (consts.LOOT_ROLL_WIDTH - 0.02) * 3 / 4 * 0.5,
        consts.LOOT_ROLL_HEIGHT * 1 / 6)
    BlzFrameSetPoint(
        progressBarFilledBackdropFrame,
        FRAMEPOINT_LEFT,
        progressBarBackdropFrame,
        FRAMEPOINT_LEFT,
        0,
        0)
    BlzFrameSetTexture(
        progressBarFilledBackdropFrame,
        "Replaceabletextures\\Teamcolor\\Teamcolor05.blp",
        0,
        true)

    for i=0,2,1 do
        local rollButton = BlzCreateFrame("ScriptDialogButton", origin, 0, 0)
        local rollButtonText = BlzGetFrameByName("ScriptDialogButtonText", 0)
        BlzFrameSetSize(
            rollButton,
            (consts.LOOT_ROLL_WIDTH - 0.02) * 1 / 4,
            (consts.LOOT_ROLL_HEIGHT) / 3)
        BlzFrameSetPoint(
            rollButton,
            FRAMEPOINT_TOPRIGHT,
            origin,
            FRAMEPOINT_TOPRIGHT,
            -0.005,
            -0.005 - i * ((consts.LOOT_ROLL_HEIGHT) / 3 - 0.005))
        BlzFrameSetText(rollButtonText, BUTTONS[i+1])
        BlzFrameSetScale(rollButtonText, 0.6)

        local trig = CreateTrigger()
        BlzTriggerRegisterFrameEvent(
            trig, rollButton, FRAMEEVENT_CONTROL_CLICK)
        TriggerAddAction(trig, function()
            local playerId = GetPlayerId(GetTriggerPlayer())

            drops.onRollMade(playerId, playerRolls[playerId][1], i)
            table.remove(playerRolls[playerId], 1)

            BlzFrameSetEnable(BlzGetTriggerFrame(), false)
            BlzFrameSetEnable(BlzGetTriggerFrame(), true)
        end)
    end

    self.frames = {
        origin = origin,
        tooltipFrame = tooltipFrame,
        itemIcon = itemIconBackdropFrame,
        itemText = itemTextFrame,
        progressFilled = progressBarFilledBackdropFrame,
    }

    return self
end

function LootRoll:update(playerId)
    local frames = self.frames

    local frameVisible = playerRolls[playerId] ~= nil and #playerRolls[playerId] > 0

    BlzFrameSetVisible(frames.origin, frameVisible)

    if not frameVisible then
        return
    end

    local timer = drops.getTimerForRoll(playerRolls[playerId][1])
    local duration = TimerGetElapsed(timer) / TimerGetTimeout(timer)
    BlzFrameSetSize(
        frames.progressFilled,
        (consts.LOOT_ROLL_WIDTH - 0.02) * 3 / 4 * duration,
        consts.LOOT_ROLL_HEIGHT * 1 / 6)

    local itemId = drops.getItemIdForRoll(playerRolls[playerId][1])
    local itemInfo = itemmanager.getItemInfo(itemId)
    if itemId ~= nil and itemInfo ~= nil then
        BlzFrameSetText(frames.itemText, itemInfo.name)
        BlzFrameSetTexture(frames.itemIcon, itemInfo.icon, 0, true)

        local numTooltipLines = itemmanager.getItemTooltipNumLines(itemId)
        BlzFrameSetSize(
            frames.tooltipFrame.origin,
            0.16,
            0.012 * numTooltipLines)
        BlzFrameSetSize(
            frames.tooltipFrame.text,
            0.15,
            0.012 * numTooltipLines - 0.01)

        BlzFrameSetText(
            frames.tooltipFrame.text,
            itemmanager.getItemTooltip(itemId) or "")

        BlzFrameSetVisible(
            frames.tooltipFrame.backdrop, numTooltipLines ~= 0)
    else
        -- We're pretty boned now
        print('If youre seeing this the developer is sad.')
    end
end

return LootRoll
