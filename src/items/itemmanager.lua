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

function getItemInfo(itemId)
    return ITEMS[itemId]
end

function getItemTooltip(itemId)
    return TOOLTIPS[itemId] and TOOLTIPS[itemId].text or ""
end

function getItemTooltipNumLines(itemId)
    return TOOLTIPS[itemId] and TOOLTIPS[itemId].numLines or 0
end

function init()
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
    ITEMS = ITEMS,
    init = init,
    getItemInfo = getItemInfo,
    getItemTooltip = getItemTooltip,
    getItemTooltipNumLines = getItemTooltipNumLines,
}
