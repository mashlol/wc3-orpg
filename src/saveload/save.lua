local Code = require('src/saveload/code.lua')
local file = require('src/saveload/file.lua')
local backpack = require('src/items/backpack.lua')
local equipment = require('src/items/equipment.lua')
local hero = require('src/hero.lua')
local log = require('src/log.lua')
local quests = require('src/quests/main.lua')

function saveHero(playerId)
    local heroUnit = hero.getHero(playerId)
    local pickedHeroId = hero.getPickedHero(playerId).storedId

    local code = Code:new()
        :addInt(GetHeroXP(heroUnit), 200000)
        :addInt(pickedHeroId, 73)
        :addInt(GetPlayerState(Player(playerId), PLAYER_STATE_RESOURCE_GOLD), 200000)
        :addInt(math.floor(GetUnitX(heroUnit) + 32000), 64000)
        :addInt(math.floor(GetUnitY(heroUnit) + 32000), 64000)

    -- Encode quest progress. 6 quests per int, 2^6 max since thats the
    -- Biggest we can fit in a single char in the code.
    -- We only store completed or not completed.
    local numQuests = quests.getNumQuests()
    code:addInt(numQuests, 5000)
    local progress = quests.getProgress(playerId)
    for j=0, math.floor(numQuests / 6), 1 do
        local progInt = 0
        for i=1,6,1 do
            progInt = progInt << 1
            if
                progress[i + j * 6] and
                progress[i + j * 6].completed
            then
                progInt = progInt + 1
            end
        end
        code:addInt(progInt, 65)
    end

    for i=1,36,1 do
        code:addInt(backpack.getItemIdAtPosition(playerId, i) or 0, 5000)
        code:addInt(backpack.getItemCountAtPosition(playerId, i) or 0, 73)
    end

    code:addInt(string.byte(GetPlayerName(Player(playerId))) % 2500, 2500)

    for i=1,12,1 do
        code:addInt(equipment.getItemInSlot(playerId, i) or 0, 5000)
    end

    code = code:build()

    if playerId == GetPlayerId(GetLocalPlayer()) then
        local slot = hero.getSlot(playerId)
        file.writeFile(
            "tvtsave" .. slot .. ".pld",
            code ..
                '|' ..
                GetUnitName(heroUnit) ..
                ' (Lv ' ..
                GetHeroLevel(heroUnit) ..
                ')')
    end
    log.log(playerId, "Your hero has been saved.", log.TYPE.NORMAL)
end

function onSave()
    local playerId = GetPlayerId(GetTriggerPlayer())
    saveHero(playerId)
end

function onAutoSave()
    -- Go through all players, check if they have a hero and save it if they do
    for i=0,bj_MAX_PLAYERS,1 do
        if hero.getHero(i) ~= nil then
            saveHero(i)
        end
    end
end

function init()
    local saveTrigger = CreateTrigger()
    for i=0,bj_MAX_PLAYERS,1 do
        TriggerRegisterPlayerChatEvent(saveTrigger, Player(i), "-save", true)
    end
    TriggerAddAction(saveTrigger, onSave)

    TimerStart(CreateTimer(), 58, true, onAutoSave)
end

return {
    init = init,
    saveHero = saveHero,
}