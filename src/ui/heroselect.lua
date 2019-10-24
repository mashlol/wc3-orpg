local hero = require('src/hero.lua')
local spell = require('src/spell.lua')
local tooltip = require('src/ui/tooltip.lua')

local FULL_WIDTH_RELATIVE = 0.7
local BUTTON_WIDTH_PX = 300
local BUTTON_HEIGHT_PX = 450
local BUTTON_MARGIN_PX = 20
local NUM_CHOICES = 4
local FULL_WIDTH_PX = NUM_CHOICES * BUTTON_WIDTH_PX + (NUM_CHOICES - 1) * BUTTON_MARGIN_PX
local RATIO = FULL_WIDTH_PX / BUTTON_HEIGHT_PX
local FULL_HEIGHT_RELATIVE = FULL_WIDTH_RELATIVE / RATIO
local BUTTON_WIDTH_RELATIVE = BUTTON_WIDTH_PX / FULL_WIDTH_PX * FULL_WIDTH_RELATIVE
local BUTTON_MARGIN_RELATIVE = BUTTON_MARGIN_PX / FULL_WIDTH_PX * FULL_WIDTH_RELATIVE

local CONFIRM_WIDTH_PX = 1300
local CONFIRM_HEIGHT_PX = 700
local CONFIRM_WIDTH_RELATIVE = 0.6
local CONFIRM_HEIGHT_RELATIVE = CONFIRM_WIDTH_RELATIVE / (CONFIRM_WIDTH_PX / CONFIRM_HEIGHT_PX)
local BACK_BUTTON_SIZE_PX = 30
local BACK_BUTTON_SIZE_RELATIVE = BACK_BUTTON_SIZE_PX / CONFIRM_WIDTH_PX * CONFIRM_WIDTH_RELATIVE
local BACK_BUTTON_MARGIN_PX = 20
local BACK_BUTTON_MARGIN_RELATIVE = BACK_BUTTON_MARGIN_PX / CONFIRM_WIDTH_PX * CONFIRM_WIDTH_RELATIVE
local CONFIRM_BUTTON_WIDTH_PX = 206
local CONFIRM_BUTTON_HEIGHT_PX = 54
local CONFIRM_BUTTON_WIDTH_RELATIVE = CONFIRM_BUTTON_WIDTH_PX / CONFIRM_WIDTH_PX * CONFIRM_WIDTH_RELATIVE
local CONFIRM_BUTTON_HEIGHT_RELATIVE = CONFIRM_BUTTON_WIDTH_RELATIVE / (CONFIRM_BUTTON_WIDTH_PX / CONFIRM_BUTTON_HEIGHT_PX)
local CONFIRM_BUTTON_MARGIN_BOTTOM_PX = 40
local CONFIRM_BUTTON_MARGIN_BOTTOM_RELATIVE = CONFIRM_BUTTON_MARGIN_BOTTOM_PX / CONFIRM_HEIGHT_PX * CONFIRM_HEIGHT_RELATIVE
local HERO_INFO_WIDTH_PX = 450
local HERO_INFO_WIDTH_RELATIVE = HERO_INFO_WIDTH_PX / CONFIRM_WIDTH_PX * CONFIRM_WIDTH_RELATIVE
local HERO_INFO_MARGIN_PX = 20
local HERO_INFO_MARGIN_RELATIVE = HERO_INFO_MARGIN_PX / CONFIRM_HEIGHT_PX * CONFIRM_HEIGHT_RELATIVE

local SPELL_ICON_SIZE_PX = 128
local SPELL_ICON_SIZE_RELATIVE = SPELL_ICON_SIZE_PX / CONFIRM_WIDTH_PX * CONFIRM_WIDTH_RELATIVE

-- heroSelectToggles = {
--     [playerId] = [function or nil]
-- }
local heroSelectToggles = {}

-- heroHoverAnims = {
--     [playerId] = {
--         [idx] = timer,
--     },
-- }
local heroHoverAnims = {}

-- heroConfirms = {
--     [playerId] = idx or nil
-- }
local heroConfirms = {}

local HeroSelect = {
    show = function(playerId, info)
        heroSelectToggles[playerId] = info
    end,
    hide = function(playerId)
        heroSelectToggles[playerId] = nil
    end
}

function HeroSelect:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function HeroSelect:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local origin = BlzCreateFrameByType(
        "FRAME",
        "origin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        origin, FULL_WIDTH_RELATIVE, FULL_HEIGHT_RELATIVE)
    BlzFrameSetAbsPoint(
        origin,
        FRAMEPOINT_CENTER,
        FULL_WIDTH_RELATIVE / 2 + 0.05,
        0.3)

    local allHeroInfo = hero.ALL_HERO_INFO

    local buttons = {}
    local i = 0
    for heroUnitId, heroInfo in pairs(allHeroInfo) do
        local heroButton = BlzCreateFrameByType(
            "BACKDROP",
            "heroButton",
            origin,
            "",
            0)
        BlzFrameSetSize(
            heroButton, BUTTON_WIDTH_RELATIVE, FULL_HEIGHT_RELATIVE)
        BlzFrameSetPoint(
            heroButton,
            FRAMEPOINT_CENTER,
            origin,
            FRAMEPOINT_LEFT,
            i * (BUTTON_WIDTH_RELATIVE + BUTTON_MARGIN_RELATIVE) + BUTTON_WIDTH_RELATIVE / 2,
            0)
        BlzFrameSetTexture(heroButton, heroInfo.portrait, 0, true)

        local heroText = BlzCreateFrameByType(
            "TEXT",
            "heroText",
            heroButton,
            "",
            0)
        BlzFrameSetAllPoints(heroText, heroButton)
        BlzFrameSetTextAlignment(
            heroText, TEXT_JUSTIFY_BOTTOM, TEXT_JUSTIFY_CENTER)
        BlzFrameSetText(heroText, heroInfo.name)

        local hoverFrame = BlzCreateFrameByType(
            "GLUEBUTTON",
            "hoverFrame",
            heroButton,
            "",
            0)
        BlzFrameSetAllPoints(hoverFrame, heroButton)

        local idx = i
        local mouseEnterTrigger = CreateTrigger()
        BlzTriggerRegisterFrameEvent(
            mouseEnterTrigger, hoverFrame, FRAMEEVENT_MOUSE_ENTER)
        TriggerAddAction(mouseEnterTrigger, function()
            local playerId = GetPlayerId(GetTriggerPlayer())

            local animTimer = CreateTimer()
            heroHoverAnims[playerId] = {
                [idx] = animTimer,
            }
            TimerStart(animTimer, 0.05, false, nil)
        end)

        local mouseExitTrigger = CreateTrigger()
        BlzTriggerRegisterFrameEvent(
            mouseExitTrigger, hoverFrame, FRAMEEVENT_MOUSE_LEAVE)
        TriggerAddAction(mouseExitTrigger, function()
            local playerId = GetPlayerId(GetTriggerPlayer())

            heroHoverAnims[playerId] = nil
        end)

        local clickTrigger = CreateTrigger()
        BlzTriggerRegisterFrameEvent(
            clickTrigger, hoverFrame, FRAMEEVENT_CONTROL_CLICK)
        TriggerAddAction(clickTrigger, function()
            BlzFrameSetEnable(BlzGetTriggerFrame(), false)
            BlzFrameSetEnable(BlzGetTriggerFrame(), true)
            local playerId = GetPlayerId(GetTriggerPlayer())

            heroConfirms[playerId] = heroUnitId
        end)

        buttons[i] = {
            origin = heroButton,
        }

        i = i + 1
    end

    local confirmOrigin = BlzCreateFrameByType(
        "BACKDROP",
        "confirmOrigin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        confirmOrigin, CONFIRM_WIDTH_RELATIVE, CONFIRM_HEIGHT_RELATIVE)
    BlzFrameSetAbsPoint(
        confirmOrigin,
        FRAMEPOINT_CENTER,
        CONFIRM_WIDTH_RELATIVE / 2 + 0.1,
        0.3)

    local confirmBackButton = BlzCreateFrameByType(
        "BUTTON",
        "confirmBackButton",
        confirmOrigin,
        "",
        0)
    BlzFrameSetSize(
        confirmBackButton,
        BACK_BUTTON_SIZE_RELATIVE,
        BACK_BUTTON_SIZE_RELATIVE)
    BlzFrameSetPoint(
        confirmBackButton,
        FRAMEPOINT_TOPLEFT,
        confirmOrigin,
        FRAMEPOINT_TOPLEFT,
        BACK_BUTTON_MARGIN_RELATIVE,
        -BACK_BUTTON_MARGIN_RELATIVE)

    local heroInfoOrigin = BlzCreateFrameByType(
        "FRAME",
        "heroInfoOrigin",
        confirmOrigin,
        "",
        0)
    BlzFrameSetSize(
        heroInfoOrigin,
        HERO_INFO_WIDTH_RELATIVE,
        CONFIRM_HEIGHT_RELATIVE)
    BlzFrameSetPoint(
        heroInfoOrigin,
        FRAMEPOINT_RIGHT,
        confirmOrigin,
        FRAMEPOINT_RIGHT,
        0,
        0)

    local heroInfoTitle = BlzCreateFrameByType(
        "TEXT",
        "heroInfoTitle",
        heroInfoOrigin,
        "",
        0)
    BlzFrameSetSize(
        heroInfoTitle,
        HERO_INFO_WIDTH_RELATIVE,
        0.02)
    BlzFrameSetPoint(
        heroInfoTitle,
        FRAMEPOINT_TOP,
        heroInfoOrigin,
        FRAMEPOINT_TOP,
        0,
        -HERO_INFO_MARGIN_RELATIVE)
    BlzFrameSetTextAlignment(heroInfoTitle, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    BlzFrameSetText(heroInfoTitle, "Yuji")

    local heroInfoDesc = BlzCreateFrameByType(
        "TEXT",
        "heroInfoDesc",
        heroInfoOrigin,
        "",
        0)
    BlzFrameSetSize(
        heroInfoDesc,
        HERO_INFO_WIDTH_RELATIVE - HERO_INFO_MARGIN_RELATIVE * 2,
        HERO_INFO_WIDTH_RELATIVE)
    BlzFrameSetPoint(
        heroInfoDesc,
        FRAMEPOINT_TOP,
        heroInfoTitle,
        FRAMEPOINT_BOTTOM,
        0,
        -HERO_INFO_MARGIN_RELATIVE)
    BlzFrameSetTextAlignment(heroInfoDesc, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

    local heroInfoBorder = BlzCreateFrameByType(
        "BACKDROP",
        "heroInfoBorder",
        heroInfoOrigin,
        "",
        0)
    BlzFrameSetSize(
        heroInfoBorder,
        0.001,
        CONFIRM_HEIGHT_RELATIVE - HERO_INFO_MARGIN_RELATIVE * 2)
    BlzFrameSetPoint(
        heroInfoBorder,
        FRAMEPOINT_RIGHT,
        heroInfoOrigin,
        FRAMEPOINT_LEFT,
        0,
        0)
    BlzFrameSetTexture(
        heroInfoBorder,
        "Replaceabletextures\\Teamcolor\\Teamcolor21.blp",
        0,
        true)
    BlzFrameSetAlpha(heroInfoBorder, 50)

    local confirmButton = BlzCreateFrameByType(
        "BACKDROP",
        "confirmButton",
        heroInfoOrigin,
        "",
        0)
    BlzFrameSetSize(
        confirmButton,
        CONFIRM_BUTTON_WIDTH_RELATIVE,
        CONFIRM_BUTTON_HEIGHT_RELATIVE)
    BlzFrameSetPoint(
        confirmButton,
        FRAMEPOINT_BOTTOM,
        heroInfoOrigin,
        FRAMEPOINT_BOTTOM,
        0,
        CONFIRM_BUTTON_MARGIN_BOTTOM_RELATIVE)
    BlzFrameSetTexture(confirmButton, "war3mapImported\\btn_crop.blp", 0, true)

    local confirmButtonText = BlzCreateFrameByType(
        "TEXT",
        "confirmButtonText",
        heroInfoOrigin,
        "",
        0)
    BlzFrameSetAllPoints(confirmButtonText, confirmButton)
    BlzFrameSetText(confirmButtonText, "|cff000000CONFIRM|r")
    BlzFrameSetTextAlignment(
        confirmButtonText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)

    local backTrigger = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        backTrigger, confirmBackButton, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(backTrigger, function()
        BlzFrameSetEnable(BlzGetTriggerFrame(), false)
        BlzFrameSetEnable(BlzGetTriggerFrame(), true)
        local playerId = GetPlayerId(GetTriggerPlayer())

        heroConfirms[playerId] = nil
    end)

    local confirmTrigger = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        confirmTrigger, confirmButtonText, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(confirmTrigger, function()
        BlzFrameSetEnable(BlzGetTriggerFrame(), false)
        BlzFrameSetEnable(BlzGetTriggerFrame(), true)
        local playerId = GetPlayerId(GetTriggerPlayer())

        heroSelectToggles[playerId](heroConfirms[playerId])

        heroSelectToggles[playerId] = nil
        heroConfirms[playerId] = nil
    end)

    local spellIcons = {}
    for i=0,5,1 do
        local spellIcon = BlzCreateFrameByType(
            "BACKDROP",
            "spellIcon",
            confirmOrigin,
            "",
            0)
        BlzFrameSetSize(
            spellIcon, SPELL_ICON_SIZE_RELATIVE, SPELL_ICON_SIZE_RELATIVE)
        BlzFrameSetPoint(
            spellIcon,
            FRAMEPOINT_LEFT,
            confirmOrigin,
            FRAMEPOINT_LEFT,
            (i % 3) * (SPELL_ICON_SIZE_RELATIVE + 0.06) + 0.04,
            -R2I(i / 3) * (SPELL_ICON_SIZE_RELATIVE + 0.06) + 0.06)

        local tooltipFrame = tooltip.makeTooltipFrame(spellIcon, 0.24, 0.095)

        table.insert(spellIcons, {
            icon = spellIcon,
            tooltip = tooltipFrame,
        })
    end

    self.frames = {
        origin = origin,
        buttons = buttons,
        confirmOrigin = confirmOrigin,
        heroInfoDesc = heroInfoDesc,
        heroInfoTitle = heroInfoTitle,
        spellIcons = spellIcons,
    }

    return self
end

function HeroSelect:update(playerId)
    local frames = self.frames

    local shouldShowHeroSelect = heroSelectToggles[playerId] ~= nil
    BlzFrameSetVisible(frames.origin, shouldShowHeroSelect)
    BlzFrameSetVisible(frames.confirmOrigin, shouldShowHeroSelect)
    local miniMapFrame = BlzGetFrameByName("miniMapBackdrop", 0)
    BlzFrameSetVisible(miniMapFrame, not shouldShowHeroSelect)

    if not shouldShowHeroSelect then
        return
    end

    for idx, button in pairs(frames.buttons) do
        if
            heroHoverAnims[playerId] == nil or
            heroHoverAnims[playerId][idx] == nil
        then
            -- Reset to default size
            BlzFrameSetSize(
                button.origin, BUTTON_WIDTH_RELATIVE, FULL_HEIGHT_RELATIVE)
        else
            -- Scale up accordingly
            local timer = heroHoverAnims[playerId][idx]
            local elapsedPct = TimerGetElapsed(timer) / TimerGetTimeout(timer)
            local scale =  1 + 0.08 * elapsedPct
            BlzFrameSetSize(
                button.origin,
                BUTTON_WIDTH_RELATIVE * scale,
                FULL_HEIGHT_RELATIVE * scale)
        end
    end

    BlzFrameSetVisible(frames.origin, heroConfirms[playerId] == nil)
    BlzFrameSetVisible(frames.confirmOrigin, heroConfirms[playerId] ~= nil)
    if heroConfirms[playerId] ~= nil then
        local heroInfo = hero.ALL_HERO_INFO[heroConfirms[playerId]]
        BlzFrameSetTexture(
            frames.confirmOrigin,
            heroInfo.portraitFullBlurred,
            0,
            true)

        BlzFrameSetText(frames.heroInfoDesc, heroInfo.desc)
        BlzFrameSetText(frames.heroInfoTitle, heroInfo.name)

        for i=1,6,1 do
            local spellKey = heroInfo.spells[i]
            BlzFrameSetVisible(
                frames.spellIcons[i].icon,
                spellKey)

            if spellKey then
                BlzFrameSetTexture(
                    frames.spellIcons[i].icon,
                    spell.getIconBySpellKey(spellKey),
                    0,
                    true)
                BlzFrameSetText(
                    frames.spellIcons[i].tooltip.text,
                    spell.getSpellTooltipBySpellKey(spellKey))
            end
        end
    end
end

return HeroSelect
