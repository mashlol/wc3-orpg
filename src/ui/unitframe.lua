-- Unit frame showing:
--  - Unit HP
--  - Unit Energy
--  - Buffs
--  - Unit name
local consts = require('src/ui/consts.lua')
local buff = require('src/buff.lua')
local target = require('src/target.lua')
local party = require('src/party.lua')
local hero = require('src/hero.lua')

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

    local unitFrameOrigin = BlzCreateFrameByType(
        "TEXTBUTTON",
        "unitFrameOrigin",
        originFrame,
        "",
        0)

    BlzFrameSetSize(unitFrameOrigin, self.width, consts.BAR_HEIGHT * 5)
    BlzFrameSetAbsPoint(
        unitFrameOrigin,
        self.anchor,
        self.xLoc,
        self.yLoc)

    local unitFrameBackdrop = BlzCreateFrameByType(
        "BACKDROP",
        "unitFrameBackdrop",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(unitFrameBackdrop, self.width, consts.BAR_HEIGHT * 5)
    BlzFrameSetPoint(
        unitFrameBackdrop,
        FRAMEPOINT_BOTTOMLEFT,
        unitFrameOrigin,
        FRAMEPOINT_BOTTOMLEFT,
        0,
        0)
    BlzFrameSetTexture(
        unitFrameBackdrop,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)
    BlzFrameSetAlpha(unitFrameBackdrop, 155)

    local healthBarFrameBackground = BlzCreateFrameByType(
        "BACKDROP",
        "healthBarFrameBackground",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(healthBarFrameBackground, self.width, consts.BAR_HEIGHT)
    BlzFrameSetPoint(
        healthBarFrameBackground,
        FRAMEPOINT_BOTTOMLEFT,
        unitFrameOrigin,
        FRAMEPOINT_BOTTOMLEFT,
        0,
        consts.BAR_HEIGHT)
    BlzFrameSetTexture(
        healthBarFrameBackground,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)

    local healthBarFrameFilled = BlzCreateFrameByType(
        "BACKDROP",
        "healthBarFrameFilled",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(healthBarFrameFilled, self.width, consts.BAR_HEIGHT)
    BlzFrameSetPoint(
        healthBarFrameFilled,
        FRAMEPOINT_BOTTOMLEFT,
        healthBarFrameBackground,
        FRAMEPOINT_BOTTOMLEFT,
        0,
        0)
    BlzFrameSetTexture(
        healthBarFrameFilled,
        "Replaceabletextures\\Teamcolor\\Teamcolor06.blp",
        0,
        true)

    local energyBarFrameBackground = BlzCreateFrameByType(
        "BACKDROP",
        "energyBarFrameBackground",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(energyBarFrameBackground, self.width, consts.BAR_HEIGHT)
    BlzFrameSetPoint(
        energyBarFrameBackground,
        FRAMEPOINT_BOTTOMLEFT,
        unitFrameOrigin,
        FRAMEPOINT_BOTTOMLEFT,
        0,
        0)
    BlzFrameSetTexture(
        energyBarFrameBackground,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)

    local energyBarFrameFilled = BlzCreateFrameByType(
        "BACKDROP",
        "energyBarFrameFilled",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(energyBarFrameFilled, self.width, consts.BAR_HEIGHT)
    BlzFrameSetPoint(
        energyBarFrameFilled,
        FRAMEPOINT_BOTTOMLEFT,
        energyBarFrameBackground,
        FRAMEPOINT_BOTTOMLEFT,
        0,
        0)
    BlzFrameSetTexture(
        energyBarFrameFilled,
        "Replaceabletextures\\Teamcolor\\Teamcolor01.blp",
        0,
        true)

    local unitNameFrame = BlzCreateFrameByType(
        "TEXT",
        "unitNameFrame",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(unitNameFrame, self.width, consts.BAR_HEIGHT)
    BlzFrameSetPoint(
        unitNameFrame,
        FRAMEPOINT_BOTTOMLEFT,
        unitFrameOrigin,
        FRAMEPOINT_BOTTOMLEFT,
        0,
        consts.BAR_HEIGHT * 2)
    BlzFrameSetText(unitNameFrame, "There Is a Unit Name")

    local buffIcons = {}
    for i=0,9,1 do
        local buffIcon = BlzCreateFrameByType(
            "BACKDROP",
            "buffIcon",
            unitFrameOrigin,
            "",
            0)
        BlzFrameSetSize(buffIcon, consts.BUFF_ICON_SIZE, consts.BUFF_ICON_SIZE)
        BlzFrameSetPoint(
            buffIcon,
            FRAMEPOINT_BOTTOMLEFT,
            unitFrameOrigin,
            FRAMEPOINT_BOTTOMLEFT,
            i * consts.BUFF_ICON_SIZE,
            consts.BAR_HEIGHT * 3)

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

    local trig = CreateTrigger()
    BlzTriggerRegisterFrameEvent(
        trig, unitFrameOrigin, FRAMEEVENT_CONTROL_CLICK)
    TriggerAddAction(trig, function()
        self:onClick()
        BlzFrameSetEnable(BlzGetTriggerFrame(), false)
        BlzFrameSetEnable(BlzGetTriggerFrame(), true)
    end)

    self.frames = {
        healthBar = healthBarFrameFilled,
        energyBar = energyBarFrameFilled,
        origin = unitFrameOrigin,
        name = unitNameFrame,
        buffIcons = buffIcons,
    }

    return self
end

function UnitFrame:onClick()
    if GetPlayerId(GetTriggerPlayer()) == self.playerId then
        ClearSelection()
        SelectUnit(self:getUnit(), true)
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

    local name = GetUnitName(unit)
    BlzFrameSetText(frames.name, name)

    local hp = BlzGetUnitRealField(unit, UNIT_RF_HP)
    local maxHp = BlzGetUnitMaxHP(unit)
    local mana = BlzGetUnitRealField(unit, UNIT_RF_MANA)
    local maxMana = BlzGetUnitMaxMana(unit)

    if maxHp ~= 0 then
        BlzFrameSetSize(
            frames.healthBar,
            self.width * hp / maxHp,
            consts.BAR_HEIGHT)
    else
        BlzFrameSetSize(frames.healthBar, 0, consts.BAR_HEIGHT)
    end
    if maxMana ~= 0 then
        BlzFrameSetSize(
            frames.energyBar,
            self.width * mana / maxMana,
            consts.BAR_HEIGHT)
    else
        BlzFrameSetSize(frames.energyBar, 0, consts.BAR_HEIGHT)
    end

    local buffs = buff.getBuffs(unit)
    local buffArr = {}

    for buffName, buffInfo in pairs(buffs) do
        table.insert(buffArr, {buffName = buffName, buffInfo = buffInfo})
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
