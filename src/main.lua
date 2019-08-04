local hero = require('src/hero.lua')
local keyboard = require('src/keyboard.lua')
local mouse = require('src/mouse.lua')
local projectile = require('src/projectile.lua')
local cleanup = require('src/cleanup.lua')
local effect = require('src/effect.lua')
local ui = require('src/ui.lua')
local target = require('src/target.lua')
local leaver = require('src/leaver.lua')

local debug = require('src/debug.lua')

local mainInit = function()
    hero.init()
    keyboard.init()
    mouse.init()
    projectile.init()
    cleanup.init()
    effect.init()
    ui.init()
    target.init()
    leaver.init()

    -- TODO remove for release
    debug.init()
end

TimerStart(CreateTimer(), 0.0, false, mainInit)
