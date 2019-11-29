local hero = require('src/hero.lua')
local spell = require('src/spell.lua')
local load = require('src/saveload/load.lua')
local file = require('src/saveload/file.lua')
local tooltip = require('src/ui/tooltip.lua')

local FULL_WIDTH_RELATIVE = 0.6
local BUTTON_WIDTH_PX = 225
local BUTTON_MARGIN_PX = 20
local NUM_CHOICES = 8
local NUM_ROWS = 2
local NUM_PER_ROW = NUM_CHOICES / NUM_ROWS
local FULL_WIDTH_PX = NUM_PER_ROW * BUTTON_WIDTH_PX + (NUM_PER_ROW - 1) * BUTTON_MARGIN_PX
local BUTTON_WIDTH_RELATIVE = BUTTON_WIDTH_PX / FULL_WIDTH_PX * FULL_WIDTH_RELATIVE
local BUTTON_MARGIN_RELATIVE = BUTTON_MARGIN_PX / FULL_WIDTH_PX * FULL_WIDTH_RELATIVE
local FULL_HEIGHT_RELATIVE = BUTTON_WIDTH_RELATIVE * NUM_ROWS

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

local HERO_INFO_TABLE_WIDTH_PX = 230
local HERO_INFO_TABLE_HEIGHT_PX = 110
local HERO_INFO_TABLE_WIDTH_RELATIVE = HERO_INFO_TABLE_WIDTH_PX / CONFIRM_WIDTH_PX * CONFIRM_WIDTH_RELATIVE
local HERO_INFO_TABLE_HEIGHT_RELATIVE = HERO_INFO_TABLE_WIDTH_RELATIVE / (HERO_INFO_TABLE_WIDTH_PX / HERO_INFO_TABLE_HEIGHT_PX)
local HERO_INFO_TABLE_BOTTOM_MARGIN_PX = 100
local HERO_INFO_TABLE_BOTTOM_MARGIN_RELATIVE = HERO_INFO_TABLE_BOTTOM_MARGIN_PX / CONFIRM_WIDTH_PX * CONFIRM_WIDTH_RELATIVE

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

-- playerCreatingToggles = {
--     [playerId] = true/false or nil
-- }
local playerCreatingToggles = {}

-- playerLoadingToggles = {
--     [playerId] = true/false or nil
-- }
local playerLoadingToggles = {}

-- playerDeletingToggles = {
--     [playerId] = true/false or nil
-- }
local playerDeletingToggles = {}

-- heroConfirms = {
--     [playerId] = idx or nil
-- }
local heroConfirms = {}

local HERO_INFO_AS_LIST = {}

local HeroSelect = {
    show = function(playerId, info)
        heroSelectToggles[playerId] = info
        playerCreatingToggles[playerId] = nil
        playerLoadingToggles[playerId] = nil
        playerDeletingToggles[playerId] = nil
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

    -- Create HERO_INFO_AS_LIST
    for _, heroInfo in pairs(hero.ALL_HERO_INFO) do
        table.insert(HERO_INFO_AS_LIST, heroInfo)
    end

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
        0.4,
        0.3)

    local buttonContainer = BlzCreateFrameByType(
        "FRAME",
        "buttonContainer",
        origin,
        "",
        0)
    BlzFrameSetSize(
        buttonContainer, FULL_WIDTH_RELATIVE, FULL_HEIGHT_RELATIVE)
    BlzFrameSetAbsPoint(
        buttonContainer,
        FRAMEPOINT_CENTER,
        0.4,
        0.3)

    local buttons = {}
    for idx=1,NUM_CHOICES,1 do
        local x = (idx - 1) % NUM_PER_ROW
        local y = math.floor((idx - 1) / NUM_PER_ROW)

        local heroButton = BlzCreateFrameByType(
            "BACKDROP",
            "heroButton",
            buttonContainer,
            "",
            0)
        BlzFrameSetSize(
            heroButton, BUTTON_WIDTH_RELATIVE, BUTTON_WIDTH_RELATIVE)
        BlzFrameSetPoint(
            heroButton,
            FRAMEPOINT_CENTER,
            buttonContainer,
            FRAMEPOINT_LEFT,
            x * (BUTTON_WIDTH_RELATIVE + BUTTON_MARGIN_RELATIVE) + BUTTON_WIDTH_RELATIVE / 2,
            y * (BUTTON_WIDTH_RELATIVE + BUTTON_MARGIN_RELATIVE) - BUTTON_WIDTH_RELATIVE / 2)

        local heroText = BlzCreateFrameByType(
            "TEXT",
            "heroText",
            heroButton,
            "",
            0)
        BlzFrameSetAllPoints(heroText, heroButton)
        BlzFrameSetTextAlignment(
            heroText, TEXT_JUSTIFY_BOTTOM, TEXT_JUSTIFY_CENTER)

        local hoverFrame = BlzCreateFrameByType(
            "GLUEBUTTON",
            "hoverFrame",
            heroButton,
            "",
            0)
        BlzFrameSetAllPoints(hoverFrame, heroButton)

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

            if playerDeletingToggles[playerId] then
                if playerId == GetPlayerId(GetLocalPlayer()) then
                    local allSlots = hero.getUsedSlots()
                    local condensedSlots = {}
                    local i = 1
                    for slotIdx, _ in pairs(allSlots) do
                        condensedSlots[i] = slotIdx
                        i = i + 1
                    end

                    file.writeFile('tvtsave' .. condensedSlots[idx] .. '.pld', "")
                    hero.refreshUsedSlots()
                end
                playerDeletingToggles[playerId] = nil
            elseif playerLoadingToggles[playerId] then
                if playerId == GetPlayerId(GetLocalPlayer()) then
                    local allSlots = hero.getUsedSlots()
                    local condensedSlots = {}
                    local i = 1
                    for slotIdx, _ in pairs(allSlots) do
                        condensedSlots[i] = slotIdx
                        i = i + 1
                    end

                    local realIdx = condensedSlots[idx]

                    hero.setSlot(realIdx)
                    load.loadFromFile(playerId, realIdx)
                end
                HeroSelect.hide(playerId)
            else
                heroConfirms[playerId] = idx
            end
        end)

        buttons[idx] = {
            origin = heroButton,
            text = heroText,
        }
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

        heroSelectToggles[playerId](
            HERO_INFO_AS_LIST[heroConfirms[playerId]].id)

        heroSelectToggles[playerId] = nil
        heroConfirms[playerId] = nil
    end)

    local heroInfoRows = {}
    local rowHeight = HERO_INFO_TABLE_HEIGHT_RELATIVE / 5
    for i=0,4,1 do
        local heroInfoType = BlzCreateFrameByType(
            "TEXT",
            "heroInfoType",
            heroInfoOrigin,
            "",
            0)
        BlzFrameSetSize(
            heroInfoType,
            HERO_INFO_TABLE_WIDTH_RELATIVE,
            rowHeight)
        BlzFrameSetPoint(
            heroInfoType,
            FRAMEPOINT_BOTTOM,
            confirmButton,
            FRAMEPOINT_TOP,
            0,
            HERO_INFO_TABLE_BOTTOM_MARGIN_RELATIVE + i * rowHeight)
        BlzFrameSetTextAlignment(
            heroInfoType, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

        local heroInfoAmount = BlzCreateFrameByType(
            "TEXT",
            "heroInfoAmount",
            heroInfoOrigin,
            "",
            0)
        BlzFrameSetAllPoints(heroInfoAmount, heroInfoType)
        BlzFrameSetTextAlignment(
            heroInfoAmount, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_RIGHT)

        table.insert(heroInfoRows, {
            type = heroInfoType,
            amount = heroInfoAmount,
        })
    end

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

    local loadButton = BlzCreateFrameByType(
        "BACKDROP",
        "loadButton",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        loadButton,
        CONFIRM_BUTTON_WIDTH_RELATIVE,
        CONFIRM_BUTTON_HEIGHT_RELATIVE)
    BlzFrameSetPoint(
        loadButton,
        FRAMEPOINT_RIGHT,
        origin,
        FRAMEPOINT_CENTER,
        -CONFIRM_BUTTON_MARGIN_BOTTOM_RELATIVE,
        0)
    BlzFrameSetTexture(loadButton, "war3mapImported\\btn_crop.blp", 0, true)

    local loadButtonText = BlzCreateFrameByType(
        "TEXT",
        "loadButtonText",
        loadButton,
        "",
        0)
    BlzFrameSetAllPoints(loadButtonText, loadButton)
    BlzFrameSetText(loadButtonText, "|cff000000LOAD HERO|r")
    BlzFrameSetTextAlignment(
        loadButtonText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)

    local startLoadingTrigger = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        startLoadingTrigger, loadButtonText, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(startLoadingTrigger, function()
        BlzFrameSetEnable(BlzGetTriggerFrame(), false)
        BlzFrameSetEnable(BlzGetTriggerFrame(), true)
        local playerId = GetPlayerId(GetTriggerPlayer())

        playerLoadingToggles[playerId] = true
    end)

    local createButton = BlzCreateFrameByType(
        "BACKDROP",
        "createButton",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        createButton,
        CONFIRM_BUTTON_WIDTH_RELATIVE,
        CONFIRM_BUTTON_HEIGHT_RELATIVE)
    BlzFrameSetPoint(
        createButton,
        FRAMEPOINT_LEFT,
        origin,
        FRAMEPOINT_CENTER,
        CONFIRM_BUTTON_MARGIN_BOTTOM_RELATIVE,
        0)
    BlzFrameSetTexture(createButton, "war3mapImported\\btn_crop.blp", 0, true)

    local createButtonText = BlzCreateFrameByType(
        "TEXT",
        "createButtonText",
        createButton,
        "",
        0)
    BlzFrameSetAllPoints(createButtonText, createButton)
    BlzFrameSetText(createButtonText, "|cff000000CREATE HERO|r")
    BlzFrameSetTextAlignment(
        createButtonText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)

    local startCreatingTrigger = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        startCreatingTrigger, createButtonText, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(startCreatingTrigger, function()
        BlzFrameSetEnable(BlzGetTriggerFrame(), false)
        BlzFrameSetEnable(BlzGetTriggerFrame(), true)
        local playerId = GetPlayerId(GetTriggerPlayer())

        playerCreatingToggles[playerId] = true
    end)

    local backButton = BlzCreateFrameByType(
        "BACKDROP",
        "backButton",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        backButton,
        CONFIRM_BUTTON_WIDTH_RELATIVE,
        CONFIRM_BUTTON_HEIGHT_RELATIVE)
    BlzFrameSetPoint(
        backButton,
        FRAMEPOINT_TOPRIGHT,
        origin,
        FRAMEPOINT_BOTTOM,
        -CONFIRM_BUTTON_MARGIN_BOTTOM_RELATIVE,
        -CONFIRM_BUTTON_MARGIN_BOTTOM_RELATIVE)
    BlzFrameSetTexture(backButton, "war3mapImported\\btn_crop.blp", 0, true)

    local backButtonText = BlzCreateFrameByType(
        "TEXT",
        "backButtonText",
        backButton,
        "",
        0)
    BlzFrameSetAllPoints(backButtonText, backButton)
    BlzFrameSetText(backButtonText, "|cff000000BACK|r")
    BlzFrameSetTextAlignment(
        backButtonText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)

    local backButtonTrigger = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        backButtonTrigger, backButtonText, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(backButtonTrigger, function()
        BlzFrameSetEnable(BlzGetTriggerFrame(), false)
        BlzFrameSetEnable(BlzGetTriggerFrame(), true)
        local playerId = GetPlayerId(GetTriggerPlayer())

        if playerDeletingToggles[playerId] then
            playerDeletingToggles[playerId] = nil
        else
            playerLoadingToggles[playerId] = nil
            playerCreatingToggles[playerId] = nil
        end
    end)

    local deleteButton = BlzCreateFrameByType(
        "BACKDROP",
        "deleteButton",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        deleteButton,
        CONFIRM_BUTTON_WIDTH_RELATIVE,
        CONFIRM_BUTTON_HEIGHT_RELATIVE)
    BlzFrameSetPoint(
        deleteButton,
        FRAMEPOINT_TOPLEFT,
        origin,
        FRAMEPOINT_BOTTOM,
        CONFIRM_BUTTON_MARGIN_BOTTOM_RELATIVE,
        -CONFIRM_BUTTON_MARGIN_BOTTOM_RELATIVE)
    BlzFrameSetTexture(deleteButton, "war3mapImported\\btn_crop.blp", 0, true)

    local deleteButtonText = BlzCreateFrameByType(
        "TEXT",
        "deleteButtonText",
        deleteButton,
        "",
        0)
    BlzFrameSetAllPoints(deleteButtonText, deleteButton)
    BlzFrameSetText(deleteButtonText, "|cff000000DELETE A HERO|r")
    BlzFrameSetTextAlignment(
        deleteButtonText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)

    local deleteToggleTrigger = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        deleteToggleTrigger, deleteButtonText, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(deleteToggleTrigger, function()
        BlzFrameSetEnable(BlzGetTriggerFrame(), false)
        BlzFrameSetEnable(BlzGetTriggerFrame(), true)
        local playerId = GetPlayerId(GetTriggerPlayer())

        playerDeletingToggles[playerId] = true
    end)

    self.frames = {
        origin = origin,
        buttonContainer = buttonContainer,
        buttons = buttons,
        confirmOrigin = confirmOrigin,
        heroInfoDesc = heroInfoDesc,
        heroInfoTitle = heroInfoTitle,
        spellIcons = spellIcons,
        loadButton = loadButton,
        createButton = createButton,
        deleteButton = deleteButton,
        backButton = backButton,
        heroInfoRows = heroInfoRows,
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
        BlzFrameSetVisible(frames.deleteButton, false)
        BlzFrameSetVisible(frames.backButton, false)
        return
    end

    for idx, button in pairs(frames.buttons) do
        if
            heroHoverAnims[playerId] == nil or
            heroHoverAnims[playerId][idx] == nil
        then
            -- Reset to default size
            BlzFrameSetSize(
                button.origin, BUTTON_WIDTH_RELATIVE, BUTTON_WIDTH_RELATIVE)
        else
            -- Scale up accordingly
            local timer = heroHoverAnims[playerId][idx]
            local elapsedPct = TimerGetElapsed(timer) / TimerGetTimeout(timer)
            local scale =  1 + 0.08 * elapsedPct
            BlzFrameSetSize(
                button.origin,
                BUTTON_WIDTH_RELATIVE * scale,
                BUTTON_WIDTH_RELATIVE * scale)
        end
    end

    local isConfirming = heroConfirms[playerId] ~= nil
    local isCreating = playerCreatingToggles[playerId]
    local isLoading = playerLoadingToggles[playerId]
    local isDeleting = playerDeletingToggles[playerId]

    BlzFrameSetVisible(frames.origin, not isConfirming and (isCreating or isLoading or isDeleting))
    BlzFrameSetVisible(frames.confirmOrigin, isConfirming and isCreating)
    BlzFrameSetVisible(frames.loadButton, not isCreating and not isLoading and not isDeleting)
    BlzFrameSetVisible(frames.createButton, not isCreating and not isLoading and not isDeleting)
    BlzFrameSetVisible(frames.deleteButton, isLoading)
    BlzFrameSetVisible(frames.backButton, isLoading or isCreating and not isConfirming)

    if isLoading or isDeleting then
        BlzFrameSetPoint(
            frames.backButton,
            FRAMEPOINT_TOPRIGHT,
            frames.origin,
            FRAMEPOINT_BOTTOM,
            -CONFIRM_BUTTON_MARGIN_BOTTOM_RELATIVE,
            -CONFIRM_BUTTON_MARGIN_BOTTOM_RELATIVE)

        local slotMetadata = hero.getUsedSlots()

        local condensedSlotMetadata = {}
        for _, meta in pairs(slotMetadata) do
            if meta ~= nil then
                table.insert(condensedSlotMetadata, meta)
            end
        end

        local numButtons = 0
        for idx, button in pairs(frames.buttons) do
            if condensedSlotMetadata[idx] ~= nil then
                numButtons = numButtons + 1
                BlzFrameSetVisible(button.origin, true)
                if isDeleting then
                    BlzFrameSetText(
                        button.text, "|cffff0000Delete " .. condensedSlotMetadata[idx])
                else
                    BlzFrameSetText(button.text, condensedSlotMetadata[idx])
                end
                for _, heroInfo in pairs(HERO_INFO_AS_LIST) do
                    if string.match(condensedSlotMetadata[idx], heroInfo.name) then
                        BlzFrameSetTexture(
                            button.origin, heroInfo.portraitSquare, 0, true)
                        break
                    end
                end
            else
                BlzFrameSetVisible(button.origin, false)
            end
        end

        -- BlzFrameSetAbsPoint(
        --     frames.buttonContainer,
        --     FRAMEPOINT_CENTER,
        --     0.4,
        --     0.3)
    elseif isCreating then
        BlzFrameSetPoint(
            frames.backButton,
            FRAMEPOINT_TOPRIGHT,
            frames.origin,
            FRAMEPOINT_BOTTOM,
            CONFIRM_BUTTON_WIDTH_RELATIVE / 2,
            -CONFIRM_BUTTON_MARGIN_BOTTOM_RELATIVE)

        local numButtons = 0
        for idx, button in pairs(frames.buttons) do
            if HERO_INFO_AS_LIST[idx] ~= nil then
                numButtons = numButtons + 1
                BlzFrameSetVisible(button.origin, true)
                BlzFrameSetText(button.text, HERO_INFO_AS_LIST[idx].name)
                BlzFrameSetTexture(
                    button.origin, HERO_INFO_AS_LIST[idx].portraitSquare, 0, true)
            else
                BlzFrameSetVisible(button.origin, false)
            end
        end

        -- BlzFrameSetAbsPoint(
        --     frames.buttonContainer,
        --     FRAMEPOINT_CENTER,
        --     0.4,
        --     0.3)
    end

    if isConfirming then
        local heroInfo = HERO_INFO_AS_LIST[heroConfirms[playerId]]
        BlzFrameSetTexture(
            frames.confirmOrigin,
            heroInfo.portraitFullBlurred,
            0,
            true)

        BlzFrameSetText(frames.heroInfoDesc, heroInfo.desc)
        BlzFrameSetText(frames.heroInfoTitle, heroInfo.name)

        BlzFrameSetText(frames.heroInfoRows[5].type, '|cfffbc531Type|r')
        BlzFrameSetText(frames.heroInfoRows[5].amount, heroInfo.heroType)

        BlzFrameSetText(frames.heroInfoRows[4].type, '|cfffbc531Base Health|r')
        BlzFrameSetText(frames.heroInfoRows[4].amount, heroInfo.baseHP)

        BlzFrameSetText(frames.heroInfoRows[3].type, '|cfffbc531Attack Speed|r')
        BlzFrameSetText(frames.heroInfoRows[3].amount, heroInfo.attackSpeed)

        BlzFrameSetText(frames.heroInfoRows[2].type, '|cfffbc531Defense|r')
        BlzFrameSetText(frames.heroInfoRows[2].amount, heroInfo.defense)

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
