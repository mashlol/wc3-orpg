local hero = require('src/hero.lua')
local keyboard = require('src/keyboard.lua')
local mouse = require('src/mouse.lua')
local projectile = require('src/projectile.lua')
local cleanup = require('src/cleanup.lua')
local effect = require('src/effect.lua')
local ui = require('src/ui.lua')
local leaver = require('src/leaver.lua')
local casttime = require('src/casttime.lua')
local buff = require('src/buff.lua')

-- TODO create a boss manager
local turtle = require('src/bosses/turtle.lua')

local debug = require('src/debug.lua')

local mainInit = function()
    BlzEnableTargetIndicator(true)
    BlzEnableSelections(false, false)

    hero.init()
    keyboard.init()
    mouse.init()
    projectile.init()
    cleanup.init()
    effect.init()
    ui.init()
    leaver.init()
    casttime.init()
    buff.init()

    turtle.init()

    -- TODO remove for release
    debug.init()
end

TimerStart(CreateTimer(), 0.0, false, mainInit)
