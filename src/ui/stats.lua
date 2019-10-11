-- local log = require('src/log.lua')
local consts = require('src/ui/consts.lua')
local utils = require('src/ui/utils.lua')
local buffloop = require('src/buffloop.lua')
local hero = require('src/hero.lua')

local STATS_TO_SHOW = {
    {
        prefix = 'Move Speed: ',
        getAmount = function(unitInfo, unit)
            local pct = unitInfo.baseSpeed / GetUnitDefaultMoveSpeed(unit)
            return '+' .. round(pct * 100, 0) .. '%'
        end,
    },
    {
        prefix = 'Hit Points: ',
        getAmount = function(unitInfo)
            return unitInfo.baseHP
        end,
    },
    {
        prefix = 'Attack Speed: ',
        getAmount = function(unitInfo, heroUnit, ownerHeroInfo)
            local pct =  unitInfo.attackSpeed / ownerHeroInfo.attackSpeed
            return '+' .. round((pct - 1) * 100, 0) .. '%'
        end,
    },
    {
        prefix = 'Cooldown Reduction: ',
        getAmount = function(unitInfo)
            return '+' .. round((1 - unitInfo.pctIncomingSpellDamage) * 100, 1) .. '%'
        end,
    },
    {
        prefix = 'Cast Speed: ',
        getAmount = function(unitInfo)
            return round((1 / unitInfo.pctIncomingSpellDamage) * 100, 1) .. '%'
        end,
    },
    {
        prefix = 'Physical Damage: ',
        getAmount = function(unitInfo)
            return round(unitInfo.pctDamage * 100, 1) .. '% + ' .. unitInfo.rawDamage
        end
    },
    {
        prefix = 'Spell Damage: ',
        getAmount = function(unitInfo)
            return round(unitInfo.pctSpellDamage * 100, 1) .. '% + ' .. unitInfo.rawSpellDamage
        end
    },
    {
        prefix = 'Healing Power: ',
        getAmount = function(unitInfo)
            return round(unitInfo.pctHealing * 100, 1) .. '% + ' .. unitInfo.rawHealing
        end
    },
    {
        prefix = 'Physical Defense: ',
        getAmount = function(unitInfo)
            return round((1 - unitInfo.pctIncomingDamage) * 100, 1) .. '% + ' .. (-1 * unitInfo.rawIncomingDamage)
        end
    },
    {
        prefix = 'Spell Defense: ',
        getAmount = function(unitInfo)
            return round((1 - unitInfo.pctIncomingSpellDamage) * 100, 1) .. '% + ' .. (-1 * unitInfo.rawIncomingSpellDamage)
        end
    },
    {
        prefix = 'Crit Chance: ',
        getAmount = function(unitInfo)
            return unitInfo.critChance .. '%'
        end
    },
    {
        prefix = 'Crit Damage: ',
        getAmount = function(unitInfo)
            return round((unitInfo.pctCritDamage) * 100, 1) .. '% + ' .. (unitInfo.rawCritDamage)
        end
    },
}

-- statsToggles = {
--     [playerId] = true or nil
-- }
local statsToggles = {}

local Stats = {
    toggle = function(playerId)
        statsToggles[playerId] = not statsToggles[playerId]
    end
}

function Stats:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Stats:init()
    local originFrame = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)

    local statsOrigin = BlzCreateFrameByType(
        "FRAME",
        "statsOrigin",
        originFrame,
        "",
        0)
    BlzFrameSetSize(
        statsOrigin,
        consts.STATS_WIDTH,
        consts.STATS_HEIGHT)
    BlzFrameSetAbsPoint(
        statsOrigin,
        FRAMEPOINT_CENTER,
        0.265,
        0.35)

    utils.createBorderFrame(statsOrigin)

    local textFrames = {}
    for i=0,17,1 do
        local infoText = BlzCreateFrameByType(
            "TEXT", "infoText", statsOrigin, "", 0)
        BlzFrameSetSize(infoText, consts.STATS_WIDTH * 2, 0.02)
        BlzFrameSetPoint(
            infoText,
            FRAMEPOINT_TOP,
            statsOrigin,
            FRAMEPOINT_TOP,
            consts.STATS_WIDTH / 2 - 0.01,
            i * (-0.016) - 0.01)
        BlzFrameSetScale(infoText, 0.75)

        table.insert(textFrames, {
            text = infoText,
        })
    end

    self.frames = {
        origin = statsOrigin,
        textFrames = textFrames,
    }

    return self
end

function Stats:update(playerId)
    local frames = self.frames

    local heroUnit = hero.getHero(playerId)
    local unitInfo = buffloop.getUnitInfo(heroUnit)
    local ownerHeroInfo = hero.getPickedHero(playerId)

    local showFrame = statsToggles[playerId] == true and  heroUnit ~= nil
    BlzFrameSetVisible(frames.origin, showFrame)

    if not showFrame then
        return
    end

    for idx, statToShow in pairs(STATS_TO_SHOW) do
        local amt = statToShow.getAmount(unitInfo, heroUnit, ownerHeroInfo)
        BlzFrameSetText(
            frames.textFrames[idx].text,
            '|cffd6a511' .. statToShow.prefix .. '|r' .. amt)
    end
end

return Stats
