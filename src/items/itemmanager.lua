local hero = require('src/hero.lua')
local equipment = require('src/items/equipment.lua')

local ITEMS = {
    [1] = {
        name = 'The Sword of a Thousand Truths',
        icon = "ReplaceableTextures\\CommandButtons\\BTNDaggerOfEscape.tga",
        stats = {
            {
                type = 'rawHp',
                amount = 200,
            },
        },
        slot = equipment.SLOT.WEAPON,
    },
}

-- Takes a list of items, and returns a
-- list of total stats as if it were a single item
-- so the same format as ITEMS above.
function computeTotalStats(itemlist)
    return {}
end

function getItemInfo(itemId)
    return ITEMS[itemId]
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
end

return {
    init = init,
    getItemInfo = getItemInfo,
    computeTotalStats = computeTotalStats,
}
