local mouse = require("src/mouse.lua")
local hero = require("src/hero.lua")
local projectile = require("src/projectile.lua")
local vector = require('src/vector.lua')
local effect = require('src/effect.lua')

local castFireball = function(playerId, hero, heroV, mouseV)
    IssueImmediateOrder(hero, "stop")
    SetUnitAnimationByIndex(hero, 4)

    SetUnitFacingTimed(
            hero,
            bj_RADTODEG * Atan2(mouseV.y - heroV.y, mouseV.x - heroV.x),
            0.05)

    projectile.createProjectile{
        playerId = playerId,
        model = "eoil",
        fromV = heroV,
        toV = mouseV,
        speed = 900,
        length = 500,
        destroyOnCollide = true,
        onCollide = function(collidedUnit)
            UnitDamageTargetBJ(
                hero,
                collidedUnit,
                100,
                ATTACK_TYPE_PIERCE,
                DAMAGE_TYPE_UNKNOWN)
        end
    }
end

local castFrostOrb = function(playerId, hero, heroV, mouseV)
    IssueImmediateOrder(hero, "stop")
    SetUnitAnimationByIndex(hero, 10)

    for x=0,30,10 do
        for i=x,360+x,40 do
            local toV = vector.fromAngle(bj_DEGTORAD * i)

            projectile.createProjectile{
                playerId = playerId,
                model = "efor",
                fromV = heroV,
                toV = vector.add(heroV, toV),
                speed = 300,
                length = 350,
                destroyOnCollide = true,
                onCollide = function(collidedUnit)
                    UnitDamageTargetBJ(
                        hero,
                        collidedUnit,
                        300,
                        ATTACK_TYPE_PIERCE,
                        DAMAGE_TYPE_UNKNOWN)
                end
            }
        end
        TriggerSleepAction(0.03)
    end
end

local castFrostNova = function(playerId, hero, heroV, mouseV)
    IssueImmediateOrder(hero, "stop")
    SetUnitAnimationByIndex(hero, 5)

    for i=0,360,20 do
        local toV = vector.fromAngle(bj_DEGTORAD * i)

        projectile.createProjectile{
            playerId = playerId,
            model = "efnv",
            fromV = mouseV,
            toV = vector.add(mouseV, toV),
            speed = 450,
            length = 250,
            onCollide = function(collidedUnit)
                local dummy = CreateUnit(
                    Player(playerId),
                    FourCC("hfoo"),
                    GetUnitX(collidedUnit),
                    GetUnitY(collidedUnit), 0)

                effect.createEffect{
                    model = "efir",
                    unit = collidedUnit,
                    duration = 0.5,
                }

                ShowUnit(dummy, false)

                UnitRemoveAbility(dummy, FourCC('Aatk'))
                UnitAddAbility(dummy, FourCC('Aenr'))

                IssueTargetOrder(dummy, "entanglingroots", collidedUnit)

                UnitApplyTimedLifeBJ(2, FourCC('BTLF'), dummy)
            end
        }
    end
end

local keyPressed = function()
    local playerId = GetPlayerId(GetTriggerPlayer())
    local hero = hero.getHero(playerId)

    local heroV = vector.create(GetUnitX(hero), GetUnitY(hero))
    local mouseV = vector.create(
        mouse.getMouseX(playerId),
        mouse.getMouseY(playerId))

    if BlzGetTriggerPlayerKey() == OSKEY_Q then
        castFireball(playerId, hero, heroV, mouseV)
    elseif BlzGetTriggerPlayerKey() == OSKEY_W then
        castFrostNova(playerId, hero, heroV, mouseV)
    elseif BlzGetTriggerPlayerKey() == OSKEY_E then
        castFrostOrb(playerId, hero, heroV, mouseV)
    end
end

local init = function()
    local trigger = CreateTrigger()

    -- TODO make for all players
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_Q, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(1), OSKEY_Q, 0, true)

    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_W, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(1), OSKEY_W, 0, true)

    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(0), OSKEY_E, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(trigger, Player(1), OSKEY_E, 0, true)

    TriggerAddAction(trigger, keyPressed)
end

return {
    init = init,
}
