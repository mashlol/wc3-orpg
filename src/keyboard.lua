local spell = require("src/spell.lua")
local hero = require("src/hero.lua")
local Backpack = require("src/ui/backpack.lua")
local Equipment = require("src/ui/equipment.lua")
local QuestLog = require("src/ui/questlog.lua")

-- TODO let people customize keybindings
local KEY_MAPPING = {
    [OSKEY_Q] = 1,
    [OSKEY_W] = 2,
    [OSKEY_E] = 3,
    [OSKEY_R] = 4,
    [OSKEY_A] = 5,
    [OSKEY_D] = 7,
    [OSKEY_F] = 8,
    [OSKEY_Z] = 9,
    [OSKEY_X] = 10,
    [OSKEY_C] = 11,
    [OSKEY_V] = 12,
}

local SUPPORTED_KEYS = {
    OSKEY_Q,
    OSKEY_W,
    OSKEY_E,
    OSKEY_R,
    OSKEY_A,
    OSKEY_D,
    OSKEY_F,
    OSKEY_Z,
    OSKEY_X,
    OSKEY_C,
    OSKEY_V,
    OSKEY_B,
    OSKEY_O,
    OSKEY_L,
}

local keyPressed = function()
    local pressedKey = BlzGetTriggerPlayerKey()
    local playerId = GetPlayerId(GetTriggerPlayer())
    if KEY_MAPPING[pressedKey] then
        spell.castSpell(
            playerId,
            KEY_MAPPING[pressedKey])
        return
    end

    -- TODO figure out key mappings
    if pressedKey == OSKEY_B then
        Backpack.toggle(playerId)
        Equipment.toggle(playerId)
    end

    if pressedKey == OSKEY_L then
        QuestLog.toggle(playerId)
    end
end

local spaceDown = function()
    SetCameraTargetControllerNoZForPlayer(
        GetTriggerPlayer(),
        hero.getHero(GetPlayerId(GetTriggerPlayer())),
        0,
        0,
        false)
end

local spaceUp = function()
    ResetToGameCameraForPlayer(GetTriggerPlayer(), 0)
end

local init = function()
    local trigger = CreateTrigger()

    -- TODO make for all players
    for i=0,bj_MAX_PLAYER_SLOTS-1,1 do
        for idx, key in pairs(SUPPORTED_KEYS) do
            BlzTriggerRegisterPlayerKeyEvent(trigger, Player(i), key, 0, true)
        end
    end

    TriggerAddAction(trigger, keyPressed)

    local spaceDownTrigger = CreateTrigger()

    for i=0,bj_MAX_PLAYER_SLOTS-1,1 do
        BlzTriggerRegisterPlayerKeyEvent(
            spaceDownTrigger, Player(i), OSKEY_SPACE, 0, true)
    end

    TriggerAddAction(spaceDownTrigger, spaceDown)

    local spaceUpTrigger = CreateTrigger()

    for i=0,bj_MAX_PLAYER_SLOTS-1,1 do
        BlzTriggerRegisterPlayerKeyEvent(
            spaceUpTrigger, Player(i), OSKEY_SPACE, 0, false)
    end

    TriggerAddAction(spaceUpTrigger, spaceUp)
end

return {
    init = init,
}
