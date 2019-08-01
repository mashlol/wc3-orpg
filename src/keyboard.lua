local mouse = require("src/mouse.lua")
local hero = require("src/hero.lua")
local projectile = require("src/projectile.lua")
local vector = require('src/vector.lua')

local castFireball = function(playerId, hero, heroV, mouseV)
    SetUnitFacingTimed(
            hero,
            bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x),
            0.05)
    projectile.createProjectile(
            playerId,
            "ehip",
            heroV,
            mouseV,
            900,
            500)
end

local castFrostNova = function(playerId, hero, heroV, mouseV)
    for i=0,360,20 do
        local toV = vector.fromAngle(bj_DEGTORAD * i)

        projectile.createProjectile(
            playerId,
            "efnv",
            heroV,
            vector.add(heroV, toV),
            450,
            250)
    end
end

local keyPressed = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local hero = hero.getHero(playerId)

    local heroV = vector.create(GetUnitX(hero), GetUnitY(hero))
    local mouseV = vector.create(
        mouse.getMouseX(playerId),
        mouse.getMouseY(playerId))

    IssueImmediateOrder(hero, "stop")
    SetUnitAnimationByIndex(hero, 4)

    if BlzGetTriggerPlayerKey() == OSKEY_Q then
        castFireball(playerId, hero, heroV, mouseV)
    elseif BlzGetTriggerPlayerKey() == OSKEY_W then
        castFrostNova(playerId, hero, heroV, mouseV)
    end
end

local init = function()
    local trigger = CreateTrigger()

    -- TODO make for all players
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_Q, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(1), OSKEY_Q, 0, true)

    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_W, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(1), OSKEY_W, 0, true)

    TriggerAddAction(trigger, keyPressed)
end

return {
    init = init,
}
