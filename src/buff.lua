local hero = require('src/hero.lua')
local stats = require('src/stats.lua')
local buffloop = require('src/buffloop.lua')
local equipment = require('src/items/equipment.lua')
local casttime = require('src/casttime.lua')
local itemmanager = require('src/items/itemmanager.lua')

local BUFF_INFO = {
    focus = {
        effects = {
            {
                type = stats.PERCENT_DAMAGE,
                amount = 1.2,
            },
            {
                type = stats.PERCENT_MOVE_SPEED,
                amount = 1.5,
            },
        },
        vfx = {
            model = "Liberty.mdl",
            attach = "chest",
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNMarkOfFire.blp",
    },
    curshout = {
        effects = {
            {
                type = stats.PERCENT_MOVE_SPEED,
                amount = 0.6,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Human\\slow\\slowtarget.mdl",
            attach = "origin",
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNBattleRoar.blp",
    },
    assist = {
        effects = {
            {
                type = stats.PERCENT_INCOMING_DAMAGE,
                amount = 0.6,
            },
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNCleavingAttack.blp",
    },
    stalwartshell = {
        effects = {
            {
                type = stats.PERCENT_INCOMING_DAMAGE,
                amount = 0,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl",
            attach = "chest",
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNDefend.blp",
    },
    flag = {
        effects = {
            {
                type = stats.PERCENT_INCOMING_DAMAGE,
                amount = 0.9,
            },
            {
                type = stats.PERCENT_DAMAGE,
                amount = 1.1,
            },
            {
                type = stats.PERCENT_MOVE_SPEED,
                amount = 1.1,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Other\\GeneralAuraTarget\\GeneralAuraTarget.mdl",
            attach = "origin",
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp",
    },
    armorpot = {
        effects = {
            {
                type = stats.PERCENT_INCOMING_DAMAGE,
                amount = 0.7,
            },
            {
                type = stats.PERCENT_INCOMING_HEALING,
                amount = 1.3,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Other\\AcidBomb\\BottleImpact.mdl",
            attach = "chest",
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNPotionOfRestoration.blp",
    },
    hulkingpot = {
        effects = {
            {
                type = stats.PERCENT_DAMAGE,
                amount = 1.2,
            },
            {
                type = stats.PERCENT_SCALE,
                amount = 1.3,
            },
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNPotionRed.blp",
    },
    dampenpot = {
        effects = {
            {
                type = stats.PERCENT_DAMAGE,
                amount = 0.8,
            },
            {
                type = stats.PERCENT_SCALE,
                amount = 0.8,
            },
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNLesserInvulneralbility.blp",
    },
    accpot = {
        effects = {
            {
                type = stats.PERCENT_MOVE_SPEED,
                amount = 2,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Other\\AcidBomb\\BottleImpact.mdl",
            attach = "chest",
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNAcidBomb.blp",
    },
    rejuvpot = {
        effects = {
            {
                type = stats.HEALTH_REGEN,
                amount = 30,
                tickrate = 1,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Other\\AcidBomb\\BottleImpact.mdl",
            attach = "chest",
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNPotionOfClarity.blp",
        maxStacks = 3,
    },
    corrosivedecaydot = {
        effects = {
            {
                type = stats.DAMAGE_OVER_TIME,
                amount = 160,
                tickrate = 1,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Human\\Banish\\BanishTarget.mdl",
            attach = "chest",
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNPotionOfOmniscience.blp",
    },
    stun = {
        effects = {
            {
                type = stats.STUN,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Orc\\StasisTrap\\StasisTotemTarget.mdl",
            attach = "overhead",
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNGauntletsOfOgrePower.blp",
    },
    firelance = {
        effects = {
            {
                type = stats.STUN,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Orc\\StasisTrap\\StasisTotemTarget.mdl",
            attach = "overhead",
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNFire.blp",
    },
    fireshell = {
        effects = {
            {
                type = stats.STUN,
            },
            {
                type = stats.PERCENT_INCOMING_DAMAGE,
                amount = 0,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Other\\ImmolationRed\\ImmolationRedTarget.mdl",
            attach = "chest",
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNCloakOfFlames.blp",
    },
    frostball = {
        effects = {
            {
                type = stats.PERCENT_INCOMING_DAMAGE,
                amount = 0.9,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Undead\\FrostArmor\\FrostArmorTarget.mdl",
            attach = "chest",
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNFrostBolt.blp",
    },
    frostballslow = {
        effects = {
            {
                type = stats.PERCENT_MOVE_SPEED,
                amount = 0.6,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Items\\AIob\\AIobTarget.mdl",
            attach = "chest",
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNFrostBolt.blp",
    },
    frostnova = {
        effects = {
            {
                type = stats.ROOT,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Undead\\FreezingBreath\\FreezingBreathTargetArt.mdl",
            attach = "origin",
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNFrostArmor.blp",
    },
    icicle = {
        effects = {
            {
                type = stats.PERCENT_MOVE_SPEED,
                amount = 0.7,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Items\\AIob\\AIobTarget.mdl",
            attach = "chest",
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNBreathOfFrost.blp",
    },
    blind = {
        effects = {
            {
                type = stats.STUN,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Other\\HowlOfTerror\\HowlTarget.mdl",
            attach = "overhead",
        },
        removeOnDamage = true,
        icon = "ReplaceableTextures\\CommandButtons\\BTNSentryWard.blp",
    },
    food1 = {
        effects = {
            {
                type = stats.HEALTH_REGEN,
                amount = 60,
                tickrate = 3,
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Items\\HealingSalve\\HealingSalveTarget.mdl",
            attach = "origin",
        },
        removeOnDamage = true,
        icon = "ReplaceableTextures\\CommandButtons\\BTNCheese.blp",
    },
}

-- BuffInstances:
-- {
--   [unitHandleID] = {
--     buffs = {
--       [buffName] = {
--         timer = CreateTimer(),
--         effect = effect handle or nil,
--         source = source unit who gave the buff,
--         stacks = {num stacks},
--       },
--     },
--     unit = unit,
--   },
-- }
local buffInstances = {}

function registerBuff(buffName, buffInfo)
    BUFF_INFO[buffName] = buffInfo
end

function addBuff(source, target, buffName, duration)
    local unitId = GetHandleId(target)
    if buffInstances[unitId] == nil then
        buffInstances[unitId] = {
            unit = target,
            buffs = {},
        }
    end


    local curNumStacks = 0
    if buffInstances[unitId].buffs[buffName] ~= nil then
        curNumStacks = buffInstances[unitId].buffs[buffName].stacks
        DestroyTimer(buffInstances[unitId].buffs[buffName].timer)
        removeBuff(target, buffName)
    end

    buffInstances[unitId].buffs[buffName] = {
        source = source,
        stacks = math.min(curNumStacks + 1, BUFF_INFO[buffName].maxStacks or 1),
    }

    if
        buffInstances[unitId].buffs[buffName].stacks ==
            BUFF_INFO[buffName].maxStacks and
        BUFF_INFO[buffName].onMaxStacks ~= nil
    then
        local result = BUFF_INFO[buffName].onMaxStacks(
            target, buffInstances[unitId].buffs[buffName])
        if result then
            return
        end
    end

    if BUFF_INFO[buffName].vfx ~= nil then
        buffInstances[unitId].buffs[buffName].effect = AddSpecialEffectTarget(
            BUFF_INFO[buffName].vfx.model,
            target,
            BUFF_INFO[buffName].vfx.attach)
    end

    buffInstances[unitId].buffs[buffName].timer = CreateTimer()
    TimerStart(
        buffInstances[unitId].buffs[buffName].timer,
        duration,
        false,
        function()
            DestroyTimer(buffInstances[unitId].buffs[buffName].timer)
            removeBuff(target, buffName)
        end)
end

function removeBuff(target, buffName)
    local unitId = GetHandleId(target)
    if buffInstances[unitId] == nil or buffInstances[unitId].buffs == nil then
        return
    end

    if buffInstances[unitId].buffs[buffName].effect ~= nil then
        DestroyEffect(buffInstances[unitId].buffs[buffName].effect)
    end
    buffInstances[unitId].buffs[buffName] = nil
end

function maybeRemoveBuffsOnDamage(source, target, amount)
    local targetBuffs = getBuffs(target)
    for buffName, buffInfo in pairs(targetBuffs) do
        if BUFF_INFO[buffName].removeOnDamage then
            removeBuff(target, buffName)
        end
    end
end

function hasBuff(unit, buffName)
    local unitId = GetHandleId(unit)
    return buffInstances[unitId] ~= nil and
        buffInstances[unitId].buffs ~= nil and
        buffInstances[unitId].buffs[buffName]
end

function getBuffStacks(unit, buffName)
    local unitId = GetHandleId(unit)
    if hasBuff(unit, buffName) then
        return buffInstances[unitId].buffs[buffName].stacks
    end
    return 0
end

function getBuffs(unit)
    local unitId = GetHandleId(unit)
    return buffInstances[unitId] and buffInstances[unitId].buffs or {}
end

function applyEffectList(obj, effectList)
    for _,info in pairs(effectList) do
        info.type.effect(info, obj)
    end

    return obj
end

function maybeAddEffectToList(effectsByUnitId, unit, effect)
    local unitId = GetHandleId(unit)
    if effectsByUnitId[unitId] == nil then
        effectsByUnitId[unitId] = {
            unit = unit,
            effects = {},
        }
    end
    if effect ~= nil then
        table.insert(effectsByUnitId[unitId].effects, effect)
    end
end

function getModifiedDamage(unit, target, amount)
    local unitInfo = buffloop.getUnitInfo(unit)
    local targetInfo = buffloop.getUnitInfo(target)
    return amount *
        unitInfo.pctDamage *
        targetInfo.pctIncomingDamage +
        unitInfo.rawDamage
end

function getModifiedHealing(unit, target, amount)
    local unitInfo = buffloop.getUnitInfo(unit)
    local targetInfo = buffloop.getUnitInfo(target)
    return amount *
        unitInfo.pctHealing *
        targetInfo.pctIncomingHealing +
        unitInfo.rawHealing
end

function getBaseObjForUnit(unit)
    local ownerPlayerId = GetPlayerId(GetOwningPlayer(unit))
    local ownerHero = hero.getHero(ownerPlayerId)
    local ownerHeroInfo = hero.getPickedHero(ownerPlayerId)
    local baseSpeed = GetUnitDefaultMoveSpeed(unit)
    local scale = GetUnitPointValue(unit) / 100
    local isStunned = unit == ownerHero and casttime.isCasting(ownerPlayerId)
    local isRooted = false

    return {
        baseSpeed = baseSpeed,
        scale = scale,
        isStunned = isStunned,
        isRooted = isRooted,
        baseHP = ownerHeroInfo and ownerHeroInfo.baseHP,
        dmgToDeal = 0,
        hpToHeal = 0,
        pctDamage = 1,
        pctHealing = 1,
        rawDamage = 0,
        rawHealing = 0,
        pctIncomingDamage = 1,
        pctIncomingHealing = 1,
    }
end

function getBuffInstances()
    return buffInstances
end

return {
    BUFF_INFO = BUFF_INFO,
    registerBuff = registerBuff,
    addBuff = addBuff,
    removeBuff = removeBuff,
    hasBuff = hasBuff,
    getBuffStacks = getBuffStacks,
    getBuffs = getBuffs,
    getBuffInstances = getBuffInstances,
    getModifiedDamage = getModifiedDamage,
    getModifiedHealing = getModifiedHealing,
    maybeRemoveBuffsOnDamage = maybeRemoveBuffsOnDamage,
    applyEffectList = applyEffectList,
    maybeAddEffectToList = maybeAddEffectToList,
    getBaseObjForUnit = getBaseObjForUnit,
}
