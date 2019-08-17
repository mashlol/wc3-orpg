-- Unit frame showing:
--  - Unit HP
--  - Unit Energy
--  - Buffs
--  - Unit name
local consts = require('src/ui/consts.lua')
local buff = require('src/buff.lua')

function init(xLoc, yLoc)
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local unitFrameOrigin = BlzCreateFrameByType(
        "FRAME",
        "unitFrameOrigin",
        originFrame,
        "",
        0)

    BlzFrameSetSize(unitFrameOrigin, consts.BAR_WIDTH, consts.BAR_HEIGHT * 5)
    BlzFrameSetAbsPoint(
        unitFrameOrigin,
        FRAMEPOINT_CENTER,
        xLoc,
        consts.ACTION_ITEM_SIZE + consts.BAR_HEIGHT * 5)

    local unitFrameBackdrop = BlzCreateFrameByType(
        "BACKDROP",
        "unitFrameBackdrop",
        unitFrameOrigin,
        "",
        0)
    BlzFrameSetSize(unitFrameBackdrop, consts.BAR_WIDTH, consts.BAR_HEIGHT * 5)
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
    BlzFrameSetSize(healthBarFrameBackground, consts.BAR_WIDTH, consts.BAR_HEIGHT)
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
    BlzFrameSetSize(healthBarFrameFilled, consts.BAR_WIDTH, consts.BAR_HEIGHT)
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
    BlzFrameSetSize(energyBarFrameBackground, consts.BAR_WIDTH, consts.BAR_HEIGHT)
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
    BlzFrameSetSize(energyBarFrameFilled, consts.BAR_WIDTH, consts.BAR_HEIGHT)
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
    BlzFrameSetSize(unitNameFrame, consts.BAR_WIDTH, consts.BAR_HEIGHT)
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
        table.insert(buffIcons, buffIcon)
    end

    return {
        healthBar = healthBarFrameFilled,
        energyBar = energyBarFrameFilled,
        origin = unitFrameOrigin,
        name = unitNameFrame,
        buffIcons = buffIcons,
    }
end

function update(frames, playerId, unit)
    if unit == nil or GetUnitState(unit, UNIT_STATE_LIFE) <= 0 then
        BlzFrameSetVisible(frames.origin, false)
    else
        BlzFrameSetVisible(frames.origin, true)

        local name = GetUnitName(unit)
        BlzFrameSetText(frames.name, name)

        local hp = BlzGetUnitRealField(unit, UNIT_RF_HP)
        local maxHp = BlzGetUnitMaxHP(unit)
        local mana = BlzGetUnitRealField(unit, UNIT_RF_MANA)
        local maxMana = BlzGetUnitMaxMana(unit)

        if maxHp ~= 0 then
            BlzFrameSetSize(
                frames.healthBar,
                consts.BAR_WIDTH * hp / maxHp,
                consts.BAR_HEIGHT)
        else
            BlzFrameSetSize(frames.healthBar, 0, consts.BAR_HEIGHT)
        end
        if maxMana ~= 0 then
            BlzFrameSetSize(
                frames.energyBar,
                consts.BAR_WIDTH * mana / maxMana,
                consts.BAR_HEIGHT)
        else
            BlzFrameSetSize(frames.energyBar, 0, consts.BAR_HEIGHT)
        end

        local buffs = buff.getBuffs(unit)
        local i = 1
        for buffName, buffInfo in pairs(buffs) do
            local buffIcon = frames.buffIcons[i]
            local buffInfo = buff.BUFF_INFO[buffName]

            BlzFrameSetVisible(buffIcon, true)
            BlzFrameSetTexture(
                buffIcon,
                buffInfo.icon,
                0,
                true)

            i = i + 1

            if i > 10 then
                break
            end
        end
        for j=i,10,1 do
            BlzFrameSetVisible(frames.buffIcons[j], false)
        end
    end
end

return {
    init = init,
    update = update,
}


