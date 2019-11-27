-- Unit frame showing:
--  - Unit HP
--  - Unit Energy
--  - Buffs
--  - Unit name
local consts = require('src/ui/consts.lua')
local buff = require('src/buff.lua')
local party = require('src/party.lua')
local arena = require('src/arena.lua')
local hero = require('src/hero.lua')
local uieventhandler = require('src/ui/uieventhandler.lua')
local ContextMenu = require('src/ui/contextmenu.lua')
local Equipment = require('src/ui/equipment.lua')
local Stats = require('src/ui/stats.lua')

local UnitFrame = {
    xLoc = 0,
    yLoc = 0,
    width = consts.BAR_WIDTH,
    anchor = FRAMEPOINT_CENTER,
    forTarget = false,
    farParty = nil,
}

function UnitFrame:new(o)
    setmetatable(o, self)
    self.__index = self
    return o
end

function UnitFrame:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local isInverted = self.forParty == nil and not self.forTarget

    self.height = self.width / (692 / 199)
    local unitFrameOrigin = BlzCreateFrameByType(
        "FRAME",
        "unitFrameOrigin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(unitFrameOrigin, self.width, self.height)
    BlzFrameSetAbsPoint(
        unitFrameOrigin,
        self.anchor,
        self.xLoc,
        self.yLoc)

    local barsWidth = self.width * 516 / 692
    local unitFrameBarsBackdrop = BlzCreateFrameByType(
        "BACKDROP",
        "unitFrameBarsBackdrop",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(unitFrameBarsBackdrop, barsWidth, barsWidth / (516 / 114))
    BlzFrameSetPoint(
        unitFrameBarsBackdrop,
        isInverted and FRAMEPOINT_TOPLEFT or FRAMEPOINT_TOPRIGHT,
        unitFrameOrigin,
        isInverted and FRAMEPOINT_TOPLEFT or FRAMEPOINT_TOPRIGHT,
        0,
        -self.height * 0.1)
    BlzFrameSetTexture(
        unitFrameBarsBackdrop,
        isInverted and "war3mapImported\\ui\\main_bars_flip.blp" or "war3mapImported\\ui\\main_bars.blp",
        0,
        true)

    self.healthBarWidth = self.width * 504 / 692
    self.healthBarHeight = self.healthBarWidth / (504 / 46)
    local healthBarFrameFilled = BlzCreateFrameByType(
        "BACKDROP",
        "healthBarFrameFilled",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(
        healthBarFrameFilled, self.healthBarWidth, self.healthBarHeight)
    BlzFrameSetPoint(
        healthBarFrameFilled,
        isInverted and FRAMEPOINT_TOPRIGHT or FRAMEPOINT_TOPLEFT,
        unitFrameOrigin,
        isInverted and FRAMEPOINT_TOPRIGHT or FRAMEPOINT_TOPLEFT,
        (isInverted and -1 or 1) * (self.width - self.width * 0.02 - self.healthBarWidth),
        -self.height * 0.18)
    BlzFrameSetTexture(
        healthBarFrameFilled,
        isInverted and "war3mapImported\\ui\\fill_1_flip.blp" or "war3mapImported\\ui\\fill_1.blp",
        0,
        true)

    local iconBackdropWidth = self.height * 1.1
    local unitIconBackdrop = BlzCreateFrameByType(
        "BACKDROP",
        "unitIconBackdrop",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(unitIconBackdrop, iconBackdropWidth, iconBackdropWidth)
    BlzFrameSetPoint(
        unitIconBackdrop,
        isInverted and FRAMEPOINT_RIGHT or FRAMEPOINT_LEFT,
        unitFrameOrigin,
        isInverted and FRAMEPOINT_RIGHT or FRAMEPOINT_LEFT,
        0,
        0)
    BlzFrameSetTexture(
        unitIconBackdrop, "war3mapImported\\ui\\ab_spell_frame_clean.blp", 0, true)

    local iconWidth = iconBackdropWidth * 0.75
    local unitIconFrame = BlzCreateFrameByType(
        "BACKDROP",
        "unitIconFrame",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(unitIconFrame, iconWidth, iconWidth)
    BlzFrameSetPoint(
        unitIconFrame,
        FRAMEPOINT_CENTER,
        unitIconBackdrop,
        FRAMEPOINT_CENTER,
        0,
        0)

    local levelFrameWidth = iconBackdropWidth * 0.3
    local levelFrameBackdrop = BlzCreateFrameByType(
        "BACKDROP",
        "levelFrameBackdrop",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(levelFrameBackdrop, levelFrameWidth, levelFrameWidth)
    BlzFrameSetPoint(
        levelFrameBackdrop,
        isInverted and FRAMEPOINT_TOPLEFT or FRAMEPOINT_TOPRIGHT,
        unitIconBackdrop,
        isInverted and FRAMEPOINT_TOPLEFT or FRAMEPOINT_TOPRIGHT,
        0,
        0)
    BlzFrameSetTexture(
        levelFrameBackdrop, "war3mapImported\\ui\\level_frame.blp", 0, true)

    local levelText = BlzCreateFrameByType(
        "TEXT",
        "levelText",
        levelFrameBackdrop,
        "",
        0)
    BlzFrameSetSize(
        levelText, levelFrameWidth, levelFrameWidth)
    BlzFrameSetPoint(
        levelText,
        FRAMEPOINT_CENTER,
        levelFrameBackdrop,
        FRAMEPOINT_CENTER,
        0,
        0)
    BlzFrameSetTextAlignment(
        levelText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)
    BlzFrameSetText(levelText, "12")
    BlzFrameSetScale(levelText, 0.8)

    local healthBarStatusText = BlzCreateFrameByType(
        "TEXT",
        "healthBarStatusText",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(
        healthBarStatusText, self.healthBarWidth, self.healthBarHeight)
    BlzFrameSetPoint(
        healthBarStatusText,
        isInverted and FRAMEPOINT_TOPRIGHT or FRAMEPOINT_TOPLEFT,
        unitFrameOrigin,
        isInverted and FRAMEPOINT_TOPRIGHT or FRAMEPOINT_TOPLEFT,
        (isInverted and -1 or 1) * (self.width - self.width * 0.08 - self.healthBarWidth),
        -self.height * 0.18)
    BlzFrameSetTextAlignment(
        healthBarStatusText, TEXT_JUSTIFY_MIDDLE, isInverted and TEXT_JUSTIFY_LEFT or TEXT_JUSTIFY_RIGHT)
    BlzFrameSetText(healthBarStatusText, "600 / 600")

    local buffIcons = {}
    local buffSize = self.healthBarWidth / 10
    for i=0,9,1 do
        local buffIcon = BlzCreateFrameByType(
            "BACKDROP",
            "buffIcon",
            unitFrameOrigin,
            "",
            0)
        BlzFrameSetSize(buffIcon, buffSize, buffSize)
        BlzFrameSetPoint(
            buffIcon,
            isInverted and FRAMEPOINT_BOTTOMRIGHT or FRAMEPOINT_BOTTOMLEFT,
            unitFrameOrigin,
            isInverted and FRAMEPOINT_BOTTOMRIGHT or FRAMEPOINT_BOTTOMLEFT,
            (isInverted and -1 or 1) * (iconBackdropWidth + i * buffSize),
            self.height * 0.06)

        local buffStackCount = BlzCreateFrameByType(
            "TEXT",
            "buffStackCount",
            buffIcon,
            "",
            0)
        BlzFrameSetSize(buffStackCount, 0.01, 0.01)
        BlzFrameSetText(buffStackCount, "1")
        BlzFrameSetPoint(
            buffStackCount,
            FRAMEPOINT_BOTTOMLEFT,
            buffIcon,
            FRAMEPOINT_BOTTOMLEFT,
            0.002,
            -0.002)

        table.insert(buffIcons, {
            buffIcon = buffIcon,
            buffStackCount = buffStackCount,
        })
    end

    local hoverFrame = BlzCreateFrameByType(
        "BUTTON",
        "hoverFrame",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetAllPoints(hoverFrame, unitFrameOrigin)

    uieventhandler.registerClickEvent(hoverFrame, function(playerId, button)
        self:onClick(playerId, button)
    end)

    self.frames = {
        healthBar = healthBarFrameFilled,
        healthBarStatusText = healthBarStatusText,
        origin = unitFrameOrigin,
        icon = unitIconFrame,
        buffIcons = buffIcons,
        levelText = levelText,
        levelFrameBackdrop = levelFrameBackdrop,
    }

    return self
end

function UnitFrame:onClick(playerId, button)
    if playerId == self.playerId and button == MOUSE_BUTTON_TYPE_LEFT then
        ClearSelection()
        SelectUnit(self:getUnit(), true)
    elseif button == MOUSE_BUTTON_TYPE_RIGHT then
        ContextMenu.show(playerId, {
            attachFrame = self.frames.origin,
            relative = FRAMEPOINT_TOPLEFT,
            buttons = {
                {
                    text = "Invite to party",
                    onClick = function()
                        local invitedPlayerId = GetPlayerId(
                            GetOwningPlayer(self:getUnit()))
                        party.sendInvite(playerId, invitedPlayerId)
                    end,
                },
                {
                    text = "Challenge to duel",
                    onClick = function()
                        local challengedPlayerId = GetPlayerId(
                            GetOwningPlayer(self:getUnit()))
                        arena.sendChallenge(playerId, challengedPlayerId)
                    end,
                },
                {
                    text = "Inspect",
                    onClick = function()
                        local inspectedPlayer = GetPlayerId(
                            GetOwningPlayer(self:getUnit()))
                        Equipment.show(playerId, inspectedPlayer)
                        Stats.show(playerId, inspectedPlayer)
                    end,
                },
                {},
                {
                    text = "Cancel",
                },
            },
        })
    end
end

function UnitFrame:getUnit()
    if self.forTarget then
        return self.target
    end
    if self.forParty ~= nil then
        local partyMembers = party.getPlayersInParty(
            party.getPlayerParty(self.playerId))
        local framePartyMember = partyMembers[self.forParty + 1]
        return hero.getHero(framePartyMember)
    end
    return self.hero
end

function UnitFrame:update(playerId)
    local frames = self.frames
    local unit = self:getUnit()

    BlzFrameSetVisible(
        frames.origin,
        unit ~= nil and GetUnitState(unit, UNIT_STATE_LIFE) > 0)

    if unit == nil or GetUnitState(unit, UNIT_STATE_LIFE) <= 0 then
        return
    end

    local unitIcon = BlzGetAbilityIcon(GetUnitTypeId(unit))
    BlzFrameSetTexture(frames.icon, unitIcon, 0, true)

    local unitLevel = GetHeroLevel(unit) ~= 0 and GetHeroLevel(unit) or GetUnitLevel(unit)
    BlzFrameSetText(frames.levelText, unitLevel)

    BlzFrameSetVisible(frames.levelFrameBackdrop, self.forParty == nil)

    local hp = BlzGetUnitRealField(unit, UNIT_RF_HP)
    local maxHp = BlzGetUnitMaxHP(unit)

    BlzFrameSetText(frames.healthBarStatusText, R2I(hp) .. "/" .. maxHp)

    if maxHp ~= 0 then
        BlzFrameSetSize(
            frames.healthBar,
            self.healthBarWidth * 0.06 + self.healthBarWidth * 0.94 * hp / maxHp,
            self.healthBarHeight)
    else
        BlzFrameSetSize(frames.healthBar, 0, consts.BAR_HEIGHT)
    end

    local buffs = buff.getBuffs(unit)
    local buffArr = {}

    for buffName, buffInfo in pairs(buffs) do
        if buff.BUFF_INFO[buffName].icon then
            table.insert(buffArr, {buffName = buffName, buffInfo = buffInfo})
        end
    end

    for i=1,10,1 do
        local frame = frames.buffIcons[i]
        local buffName = buffArr[i] and buffArr[i].buffName
        local buffInfo = buffArr[i] and buffArr[i].buffInfo

        BlzFrameSetVisible(frame.buffIcon, buffName ~= nil)
        BlzFrameSetTexture(
            frame.buffIcon,
            buff.BUFF_INFO[buffName] and buff.BUFF_INFO[buffName].icon or "",
            0,
            true)
        BlzFrameSetVisible(
            frame.buffStackCount,
            buffInfo ~= nil and buff.BUFF_INFO[buffName].maxStacks ~= nil)
        BlzFrameSetText(
            frame.buffStackCount,
            buffInfo and buffInfo.stacks or "")
    end
end

return UnitFrame
