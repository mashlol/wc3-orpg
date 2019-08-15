local spell = require("src/spell.lua")
local hero = require("src/hero.lua")

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

local keyPressed = function()
    spell.castSpell(
        GetPlayerId(GetTriggerPlayer()),
        KEY_MAPPING[BlzGetTriggerPlayerKey()])
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
        BlzTriggerRegisterPlayerKeyEvent(trigger, Player(i), OSKEY_Q, 0, true)
        BlzTriggerRegisterPlayerKeyEvent(trigger, Player(i), OSKEY_W, 0, true)
        BlzTriggerRegisterPlayerKeyEvent(trigger, Player(i), OSKEY_E, 0, true)
        BlzTriggerRegisterPlayerKeyEvent(trigger, Player(i), OSKEY_R, 0, true)
        BlzTriggerRegisterPlayerKeyEvent(trigger, Player(i), OSKEY_A, 0, true)
        BlzTriggerRegisterPlayerKeyEvent(trigger, Player(i), OSKEY_D, 0, true)
        BlzTriggerRegisterPlayerKeyEvent(trigger, Player(i), OSKEY_F, 0, true)
        BlzTriggerRegisterPlayerKeyEvent(trigger, Player(i), OSKEY_Z, 0, true)
        BlzTriggerRegisterPlayerKeyEvent(trigger, Player(i), OSKEY_X, 0, true)
        BlzTriggerRegisterPlayerKeyEvent(trigger, Player(i), OSKEY_C, 0, true)
        BlzTriggerRegisterPlayerKeyEvent(trigger, Player(i), OSKEY_V, 0, true)
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
