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
local casttime = require('src/casttime.lua')

local UnitFrame = {
    xLoc = 0,
    yLoc = 0,
    width = consts.BAR_WIDTH,
    height = consts.BAR_HEIGHT * 5,
    anchor = FRAMEPOINT_CENTER,
    forTarget = false,
    farParty = nil,
    showCastBar = true,
}

function UnitFrame:new(o)
    setmetatable(o, self)
    self.__index = self
    return o
end

function UnitFrame:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local unitFrameOrigin = BlzCreateFrameByType(
        "BUTTON",
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

    local unitFrameBackdrop = BlzCreateFrameByType(
        "BACKDROP",
        "unitFrameBackdrop",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(unitFrameBackdrop, self.width, self.height)
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
        self.showCastBar and consts.BAR_HEIGHT or 0)
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

    local castBarFrameBackground = BlzCreateFrameByType(
        "BACKDROP",
        "castBarFrameBackground",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(castBarFrameBackground, self.width, consts.BAR_HEIGHT)
    BlzFrameSetPoint(
        castBarFrameBackground,
        FRAMEPOINT_BOTTOMLEFT,
        unitFrameOrigin,
        FRAMEPOINT_BOTTOMLEFT,
        0,
        0)
    BlzFrameSetTexture(
        castBarFrameBackground,
        "Replaceabletextures\\Teamcolor\\Teamcolor20.blp",
        0,
        true)

    local castBarFrameFilled = BlzCreateFrameByType(
        "BACKDROP",
        "castBarFrameFilled",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(castBarFrameFilled, self.width, consts.BAR_HEIGHT)
    BlzFrameSetPoint(
        castBarFrameFilled,
        FRAMEPOINT_BOTTOMLEFT,
        castBarFrameBackground,
        FRAMEPOINT_BOTTOMLEFT,
        0,
        0)
    BlzFrameSetTexture(
        castBarFrameFilled,
        "Replaceabletextures\\Teamcolor\\Teamcolor04.blp",
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
        self.showCastBar and consts.BAR_HEIGHT * 2 or consts.BAR_HEIGHT)
    BlzFrameSetText(unitNameFrame, "There Is a Unit Name")

    local buffIcons = {}
    for i=0,9,1 do
        local buffIcon = BlzCreateFrameByType(
            "BACKDROP",
            "buffIcon",
            unitFrameOrigin,
            "",
            0)
        BlzFrameSetSize(buffIcon, self.buffSize, self.buffSize)
        BlzFrameSetPoint(
            buffIcon,
            FRAMEPOINT_BOTTOMLEFT,
            unitFrameOrigin,
            FRAMEPOINT_BOTTOMLEFT,
            i * self.buffSize,
            self.showCastBar and consts.BAR_HEIGHT * 3 or consts.BAR_HEIGHT * 2)

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
    BlzTriggerRegisterFrameEvent(trig, unitNameFrame, FRAMEEVENT_CONTROL_CLICK)

    TriggerAddAction(trig, function()
        self:onClick()
        BlzFrameSetEnable(BlzGetTriggerFrame(), false)
        BlzFrameSetEnable(BlzGetTriggerFrame(), true)
    end)

    self.frames = {
        castBarOrigin = castBarFrameBackground,
        healthBar = healthBarFrameFilled,
        castBar = castBarFrameFilled,
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

    if maxHp ~= 0 then
        if hp / maxHp < 0.2 then
            BlzFrameSetTexture(
                frames.healthBar,
                "Replaceabletextures\\Teamcolor\\Teamcolor00.blp",
                0,
                true)
        elseif hp / maxHp < .5 then
            BlzFrameSetTexture(
                frames.healthBar,
                "Replaceabletextures\\Teamcolor\\Teamcolor04.blp",
                0,
                true)
        else
            BlzFrameSetTexture(
                frames.healthBar,
                "Replaceabletextures\\Teamcolor\\Teamcolor06.blp",
                0,
                true)
        end
        BlzFrameSetSize(
            frames.healthBar,
            self.width * hp / maxHp,
            consts.BAR_HEIGHT)
    else
        BlzFrameSetSize(frames.healthBar, 0, consts.BAR_HEIGHT)
    end

    local playerIdOfUnitOwner = GetPlayerId(GetOwningPlayer(unit))
    local castRemainder = casttime.getCastDurationRemaining(playerIdOfUnitOwner)
    local castTotal = casttime.getCastDurationTotal(playerIdOfUnitOwner)
    BlzFrameSetVisible(frames.castBarOrigin, self.showCastBar)
    if castRemainder ~= nil and castTotal ~= nil then
        BlzFrameSetVisible(frames.castBar, self.showCastBar)
        BlzFrameSetSize(
            frames.castBar,
            self.width * (1 - castRemainder / castTotal),
            consts.BAR_HEIGHT)
    else
        BlzFrameSetVisible(frames.castBar, false)
        BlzFrameSetSize(
            frames.castBar,
            0,
            consts.BAR_HEIGHT)
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
