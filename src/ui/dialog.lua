local consts = require('src/ui/consts.lua')
local utils = require('src/ui/utils.lua')
local tooltip = require('src/ui/tooltip.lua')
local spell = require('src/spell.lua')

local MAX_NUM_SECTIONS = 5
local SECTION_PADDING = 0.002
local MAX_NUM_BULLETS = 8

-- dialogToggles = {
--     [playerId] = {
--         text = "text",
--         textalign = nil or TEXT_JUSTIFY_CENTER,
--         height = 0.4,
--         xPos = 0.4,
--         positiveButton = "Accept",
--         onPositiveButtonClicked = [function],
--         negativeButton = "Decline",
--         onNegativeButtonClicked = [function],
--         sections = {
--             [1] = {
--                 text = 'VILLAGER',
--                 type = 'red',
--                 textalign = TEXT_JUSTIFY_CENTER,
--                 textalignvert = TEXT_JUSTIFY_MIDDLE,
--                 height = 0.1, -- as wc3 relative amount
--                 width = 0.9, -- as a percentage
--                 bullets = {
--                     [1] = {
--                         text = "Kill 10 snapping turtles",
--                         icon = "sword.blp",
--                     },
--                     [2] = {
--                         text = "10 gold",
--                         icon = "gold.blp",
--                     },
--                 },
--             },
--         },
--     },
-- }
local dialogToggles = {}

local Dialog = {
    show = function(playerId, info)
        dialogToggles[playerId] = info
    end,
    hide = function(playerId)
        dialogToggles[playerId] = nil
    end
}

function Dialog:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function createButton(origin, xOffset, isNegative)
    local button = BlzCreateFrame("GrungeButton", origin, 0, 0)
    local buttonText = BlzGetFrameByName("GrungeButtonText", 0)
    BlzFrameSetSize(button, 0.12, 0.04)
    BlzFrameSetPoint(
        button,
        FRAMEPOINT_CENTER,
        origin,
        FRAMEPOINT_BOTTOM,
        xOffset,
        0.005)

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        trig, button, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        local playerId = GetPlayerId(GetTriggerPlayer())

        local callback
        if
            dialogToggles[playerId] ~= nil and
            isNegative == false and
            dialogToggles[playerId].onPositiveButtonClicked
        then
            callback = dialogToggles[playerId].onPositiveButtonClicked
        elseif
            dialogToggles[playerId] ~= nil and
            isNegative == true and
            dialogToggles[playerId].onNegativeButtonClicked
        then
            callback = dialogToggles[playerId].onNegativeButtonClicked
        end

        dialogToggles[playerId] = nil

        if callback ~= nil then
            callback()
        end

        BlzFrameSetEnable(BlzGetTriggerFrame(), false)
        BlzFrameSetEnable(BlzGetTriggerFrame(), true)
    end)

    return {
        button = button,
        text = buttonText,
    }
end

function Dialog:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local origin = BlzCreateFrameByType(
        "FRAME",
        "origin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        origin, consts.DIALOG_WIDTH, consts.DIALOG_HEIGHT)
    BlzFrameSetAbsPoint(
        origin,
        FRAMEPOINT_CENTER,
        0.4,
        0.375)

    utils.createBorderFrame(origin)

    local text = BlzCreateFrameByType(
        "TEXT",
        "text",
        origin,
        "",
        0)
    BlzFrameSetSize(text, consts.DIALOG_WIDTH - 0.02, consts.DIALOG_HEIGHT)
    BlzFrameSetPoint(
        text,
        FRAMEPOINT_TOPLEFT,
        origin,
        FRAMEPOINT_TOPLEFT,
        0.01,
        -0.01)

    -- Optionally sectioned off text
    local sections = {}
    for i=0,MAX_NUM_SECTIONS-1,1 do
        local section = BlzCreateFrameByType(
            "BACKDROP", "section", origin, "", 0)
        local sectionText = BlzCreateFrameByType(
            "TEXT", "sectionText", section, "", 0)

        local bullets = {}
        for j=0,MAX_NUM_BULLETS-1, 1 do
            local bulletIcon = BlzCreateFrameByType(
                "BACKDROP", "bulletIcon", section, "", 0)
            BlzFrameSetSize(bulletIcon, 0.012, 0.012)
            BlzFrameSetPoint(
                bulletIcon,
                FRAMEPOINT_TOPLEFT,
                section,
                FRAMEPOINT_TOPLEFT,
                0.018,
                -j * 0.014 - 0.03)
            local bulletText = BlzCreateFrameByType(
                "TEXT", "bulletText", section, "", 0)
            BlzFrameSetSize(bulletText, consts.DIALOG_WIDTH / 2, 0.012)
            BlzFrameSetPoint(
                bulletText,
                FRAMEPOINT_LEFT,
                bulletIcon,
                FRAMEPOINT_RIGHT,
                0.0075,
                0)
            BlzFrameSetTextAlignment(bulletText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_LEFT)

            table.insert(bullets, {
                icon = bulletIcon,
                text = bulletText,
            })
        end

        table.insert(sections, {
            origin = section,
            text = sectionText,
            bullets = bullets,
        })
    end

    local positiveButton = createButton(origin, 0.07, false)
    local negativeButton = createButton(origin, -0.07, true)

    self.frames = {
        origin = origin,
        text = text,
        positiveButton = positiveButton,
        negativeButton = negativeButton,
        sections = sections,
    }

    return self
end

function Dialog:update(playerId)
    local frames = self.frames

    BlzFrameSetVisible(frames.origin, dialogToggles[playerId] ~= nil)

    if dialogToggles[playerId] == nil then
        return
    end

    BlzFrameSetAbsPoint(
        frames.origin,
        FRAMEPOINT_CENTER,
        dialogToggles[playerId].xPos or 0.4,
        0.35)

    BlzFrameSetText(
        frames.text,
        dialogToggles[playerId].text or "")

    BlzFrameSetTextAlignment(
        frames.text,
        TEXT_JUSTIFY_TOP,
        dialogToggles[playerId].textalign or TEXT_JUSTIFY_LEFT)

    if
        dialogToggles[playerId].positiveButton and
        not dialogToggles[playerId].negativeButton
    then
        BlzFrameSetPoint(
            frames.positiveButton.button,
            FRAMEPOINT_CENTER,
            frames.origin,
            FRAMEPOINT_BOTTOM,
            0,
            0.005)
    else
        BlzFrameSetPoint(
            frames.positiveButton.button,
            FRAMEPOINT_CENTER,
            frames.origin,
            FRAMEPOINT_BOTTOM,
            0.07,
            0.005)
    end

    BlzFrameSetVisible(
        frames.positiveButton.button,
        dialogToggles[playerId].positiveButton)
    BlzFrameSetVisible(
        frames.negativeButton.button,
        dialogToggles[playerId].negativeButton)
    BlzFrameSetText(
        frames.positiveButton.text,
        string.upper(dialogToggles[playerId].positiveButton or ""))
    BlzFrameSetText(
        frames.negativeButton.text,
        string.upper(dialogToggles[playerId].negativeButton or ""))
    BlzFrameSetSize(
        frames.origin,
        consts.DIALOG_WIDTH,
        dialogToggles[playerId].height or consts.DIALOG_HEIGHT)

    -- Optional sections
    local totalHeight = 0.015
    for i=1,MAX_NUM_SECTIONS, 1 do
        local isVisible = dialogToggles[playerId].sections ~= nil and
            dialogToggles[playerId].sections[i] ~= nil

        BlzFrameSetVisible(frames.sections[i].origin, isVisible)

        if isVisible then
            local sectionInfo = dialogToggles[playerId].sections[i]
            BlzFrameSetText(frames.sections[i].text, sectionInfo.text)
            BlzFrameSetTextAlignment(
                frames.sections[i].text,
                sectionInfo.textalignvert or TEXT_JUSTIFY_TOP,
                sectionInfo.textalign or TEXT_JUSTIFY_LEFT)

            local sectionHeight = sectionInfo.height
            local width = sectionInfo.width or 1

            -- Adjust size/position of text and origin frames
            BlzFrameSetSize(
                frames.sections[i].origin,
                consts.DIALOG_WIDTH * width,
                sectionHeight)
            BlzFrameSetPoint(
                frames.sections[i].origin,
                FRAMEPOINT_TOP,
                frames.origin,
                FRAMEPOINT_TOP,
                0,
                -totalHeight)
            BlzFrameSetSize(
                frames.sections[i].text,
                consts.DIALOG_WIDTH * width - 0.04,
                sectionHeight - 0.02)
            BlzFrameSetPoint(
                frames.sections[i].text,
                FRAMEPOINT_CENTER,
                frames.sections[i].origin,
                FRAMEPOINT_CENTER,
                0,
                0)

            -- Set the backdrop depending on the type
            BlzFrameSetTexture(
                frames.sections[i].origin,
                sectionInfo.type == 'red' and
                    "war3mapImported\\ui\\inner_container_red_warning.blp" or
                    "war3mapImported\\ui\\inner_container_2_full.blp",
                0,
                true)

            -- Set the bullet texts/icons if it exists
            for j=1,MAX_NUM_BULLETS,1 do
                local bulletFrame = frames.sections[i].bullets[j]
                local isVisible = sectionInfo.bullets ~= nil and
                    sectionInfo.bullets[j] ~= nil
                BlzFrameSetVisible(bulletFrame.icon, isVisible)
                BlzFrameSetVisible(bulletFrame.text, isVisible)

                if isVisible then
                    BlzFrameSetTexture(
                        bulletFrame.icon, sectionInfo.bullets[j].icon, 0, true)
                    BlzFrameSetText(
                        bulletFrame.text, sectionInfo.bullets[j].text)
                end
            end

            totalHeight = totalHeight + sectionHeight + SECTION_PADDING
        end
    end
end

return Dialog
