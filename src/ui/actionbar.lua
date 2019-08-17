local consts = require('src/ui/consts.lua')
local spell = require('src/spell.lua')

local DEFAULT_HOTKEYS = {
    "Q", "W", "E", "R",
    "A", "S", "D", "F",
    "Z", "X", "C", "V"
}

local ActionBar = {}

function ActionBar:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function ActionBar:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    local actionBar = BlzCreateFrameByType(
        "FRAME",
        "actionBar",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        actionBar, consts.ACTION_ITEM_SIZE * 12, consts.ACTION_ITEM_SIZE)
    BlzFrameSetAbsPoint(
        actionBar, FRAMEPOINT_CENTER, 0.4, consts.ACTION_ITEM_SIZE)

    local actionItems = {}
    for i=0,11,1 do
        local actionItem = BlzCreateFrameByType(
            "BACKDROP",
            "actionItem",
            BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),
            "",
            0)
        BlzFrameSetSize(
            actionItem, consts.ACTION_ITEM_SIZE, consts.ACTION_ITEM_SIZE)
        BlzFrameSetPoint(
            actionItem,
            FRAMEPOINT_LEFT,
            actionBar,
            FRAMEPOINT_LEFT,
            i * consts.ACTION_ITEM_SIZE,
            0)

        if i == 4 then
            BlzFrameSetTexture(
                actionItem,
                "ReplaceableTextures\\CommandButtons\\BTNAttack.blp",
                0,
                true)
        end

        if i == 5 then
            BlzFrameSetTexture(
                actionItem,
                "ReplaceableTextures\\CommandButtons\\BTNStop.blp",
                0,
                true)
        end

        local actionCooldownBackdrop = BlzCreateFrameByType(
            "BACKDROP",
            "actionCooldownBackdrop",
            actionItem,
            "",
            0)
        BlzFrameSetSize(
            actionCooldownBackdrop,
            consts.ACTION_ITEM_SIZE,
            0)
        BlzFrameSetPoint(
            actionCooldownBackdrop,
            FRAMEPOINT_BOTTOM,
            actionItem,
            FRAMEPOINT_BOTTOM,
            0,
            0)
        BlzFrameSetTexture(
            actionCooldownBackdrop,
            "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
            0,
            true)
        BlzFrameSetAlpha(actionCooldownBackdrop, 200)

        local actionTintBackdrop = BlzCreateFrameByType(
            "BACKDROP",
            "actionTintBackdrop",
            actionItem,
            "",
            0)
        BlzFrameSetSize(
            actionTintBackdrop,
            consts.ACTION_ITEM_SIZE,
            consts.ACTION_ITEM_SIZE)
        BlzFrameSetPoint(
            actionTintBackdrop,
            FRAMEPOINT_BOTTOM,
            actionItem,
            FRAMEPOINT_BOTTOM,
            0,
            0)
        BlzFrameSetTexture(
            actionTintBackdrop,
            "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
            0,
            true)
        BlzFrameSetAlpha(actionTintBackdrop, 60)

        local actionHotkey = BlzCreateFrameByType(
            "TEXT",
            "actionItemHotkey",
            actionItem,
            "",
            0)
        BlzFrameSetSize(actionHotkey, 0.01, 0.01)
        BlzFrameSetText(actionHotkey, DEFAULT_HOTKEYS[i+1])
        BlzFrameSetPoint(
            actionHotkey,
            FRAMEPOINT_TOP_LEFT,
            actionItem,
            FRAMEPOINT_TOP_LEFT,
            0.002,
            -0.002)

         local actionCooldownText = BlzCreateFrameByType(
            "TEXT",
            "actionCooldownText",
            actionItem,
            "",
            0)
        BlzFrameSetSize(
            actionCooldownText,
            consts.ACTION_ITEM_SIZE,
            consts.ACTION_ITEM_SIZE)
        BlzFrameSetText(actionCooldownText, "")
        BlzFrameSetPoint(
            actionCooldownText,
            FRAMEPOINT_CENTER,
            actionItem,
            FRAMEPOINT_CENTER,
            0,
            0)
        BlzFrameSetTextAlignment(
            actionCooldownText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)

        table.insert(actionItems, {
            actionItemBackground = actionItem,
            actionCooldownBackdrop = actionCooldownBackdrop,
            actionCooldownText = actionCooldownText,
        })
    end

    self.frames = {
        actionItems = actionItems,
    }

    return self
end

function ActionBar:update(playerId)
    local frame = self.frames

    for idx,actionItem in pairs(frame.actionItems) do
        if idx ~= 5 and idx ~= 6 then
            local cdSec = spell.getCooldown(playerId, idx)
            local cdPct = spell.getCooldownPct(playerId, idx)
            local spellIcon = spell.getIcon(playerId, idx)

            if cdPct == 0 then
                cdPct = 0.0001
            end

            cdSec = cdSec * 100
            local cd = (cdSec - cdSec % 100) / 100

            BlzFrameSetText(
                actionItem.actionCooldownText,
                cd == 0 and "" or cd)

            BlzFrameSetSize(
                actionItem.actionCooldownBackdrop,
                consts.ACTION_ITEM_SIZE,
                consts.ACTION_ITEM_SIZE * cdPct)

            BlzFrameSetTexture(
                actionItem.actionItemBackground,
                spellIcon,
                0,
                true)
        end
    end
end

return ActionBar
