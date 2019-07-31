local mouse = require("src/mouse.lua")
local hero = require("src/hero.lua")
local projectile = require("src/projectile.lua")

local trigger = CreateTrigger()

local keyPressed = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local hero = hero.getHero(playerId)

    local startX = GetUnitX(hero)
    local startY = GetUnitY(hero)
    local endX = mouse.getMouseX(playerId)
    local endY = mouse.getMouseY(playerId)

    projectile.createProjectile(
        "ehip",
        startX,
        startY,
        endX,
        endY,
        700
    )

end

local init = function()
    -- TODO make for all players
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_1, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(1), OSKEY_1, 0, true)

    TriggerAddAction(trigger, keyPressed)
end

return {
    init = init,
}
