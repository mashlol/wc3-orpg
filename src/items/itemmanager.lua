local hero = require('src/hero.lua')
local equipment = require('src/items/equipment.lua')

local RARITY = {
    COMMON = {
        color = "|cffffffff",
        text = "Common",
    },
    LEGENDARY = {
        color = "|cffc4ab1a",
        text = "Legendary",
    },
}

local ITEMS = {
    [1] = {
        name = 'The Sword of a Thousand Truths',
        icon = "ReplaceableTextures\\CommandButtons\\BTNDaggerOfEscape.tga",
        itemLevel = 999,
        requiredLevel = 5,
        rarity = RARITY.LEGENDARY,
        stats = {
            {
                type = 'rawHp',
                amount = 200,
            },
        },
        slot = equipment.SLOT.WEAPON,
    },
}

-- Precompute tooltips at initialization time or you get desyncs
local TOOLTIPS = {}

-- Takes a list of items, and returns a
-- list of total stats as if it were a single item
-- so the same format as ITEMS above.
function computeTotalStats(itemlist)
    return {}
end

function getItemInfo(itemId)
    return ITEMS[itemId]
end

function getItemTooltip(itemId)
    return TOOLTIPS[itemId] and TOOLTIPS[itemId].text or ""
end

function getItemTooltipNumLines(itemId)
    return TOOLTIPS[itemId] and TOOLTIPS[itemId].numLines or 0.0001
end

function applyEquippedItemBuffs()
    for playerId=0,bj_MAX_PLAYERS,1 do
        local heroInfo = hero.getPickedHero(playerId)
        local hero = hero.getHero(playerId)
        if heroInfo and hero then
            local baseHP = heroInfo.baseHP

            local equippedItems = equipment.getEquippedItems(playerId)
            for idx, itemId in pairs(equippedItems) do
                local itemStats = ITEMS[itemId].stats
                for idx, statInfo in pairs(itemStats) do
                    if statInfo.type == 'rawHp' then
                        baseHP = baseHP + statInfo.amount
                    end
                end
            end

            BlzSetUnitMaxHP(hero, baseHP)
        end
    end
end

function init()
    TimerStart(CreateTimer(), 0.1, true, applyEquippedItemBuffs)

    for itemId, itemInfo in pairs(ITEMS) do
        local itemStats = ""

        local numLines = 0
        for idx, statInfo in pairs(itemInfo.stats) do
            if statInfo.type == 'rawHp' then
                itemStats = itemStats .. '+' .. statInfo.amount .. ' HP|n'
                numLines = numLines + 1
            end
        end

        TOOLTIPS[itemId] = {
            text =
                itemInfo.rarity.color ..
                itemInfo.name ..
                "|r|n" ..
                "|cffe3e312Item level " ..
                itemInfo.itemLevel ..
                "|r|n"..
                "Requires level " ..
                itemInfo.requiredLevel ..
                "|n|n|cff00ff00" ..
                itemStats,
            numLines = numLines + 4,
        }
    end
end

return {
    init = init,
    getItemInfo = getItemInfo,
    computeTotalStats = computeTotalStats,
    getItemTooltip = getItemTooltip,
    getItemTooltipNumLines = getItemTooltipNumLines,
}
