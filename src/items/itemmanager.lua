local ITEMS = {
    {
        name = 'The Sword of a Thousand Truths',
        icon = "ReplaceableTextures\\CommandButtons\\BTNClawsOfAttack.tga",
        stats = {
            {
                type = 'rawHp',
                amount = 200,
            },
        },
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

return {
    init = init,
    getItemInfo = getItemInfo,
    computeTotalStats = computeTotalStats,
}
