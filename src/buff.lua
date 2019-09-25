local hero = require('src/hero.lua')
local equipment = require('src/items/equipment.lua')
local itemmanager = require('src/items/itemmanager.lua')

local BUFF_INFO = {
    focus = {
        effects = {
            {
                type = 'multiplyDamage',
                amount = 1.2,
            },
            {
                type = 'modifyMoveSpeed',
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
                type = 'multiplyDamage',
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
                type = 'multiplyIncomingDamage',
                amount = 0.6,
            },
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNCleavingAttack.blp",
    },
    stalwartshell = {
        effects = {
            {
                type = 'multiplyIncomingDamage',
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
                type = 'multiplyIncomingDamage',
                amount = 0.9,
            },
            {
                type = 'multiplyDamage',
                amount = 1.1,
            },
            {
                type = 'modifyMoveSpeed',
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
                type = 'multiplyIncomingDamage',
                amount = 0.7,
            },
            {
                type = 'multiplyIncomingHealing',
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
                type = 'multiplyDamage',
                amount = 1.2,
            },
            {
                type = 'modifySize',
                amount = 1.3,
            },
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNPotionRed.blp",
    },
    dampenpot = {
        effects = {
            {
                type = 'multiplyDamage',
                amount = 0.8,
            },
            {
                type = 'modifySize',
                amount = 0.8,
            },
        },
        icon = "ReplaceableTextures\\CommandButtons\\BTNLesserInvulneralbility.blp",
    },
    accpot = {
        effects = {
            {
                type = 'modifyMoveSpeed',
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
                type = 'heal',
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
                type = 'damage',
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
                type = 'stun',
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
                type = 'stun',
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
                type = 'stun',
            },
            {
                type = 'multiplyIncomingDamage',
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
                type = 'multiplyIncomingDamage',
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
                type = 'modifyMoveSpeed',
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
                type = 'root',
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
                type = 'modifyMoveSpeed',
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
                type = 'stun',
            },
        },
        vfx = {
            model = "Abilities\\Spells\\Other\\HowlOfTerror\\HowlTarget.mdl",
            attach = "overhead",
        },
        removeOnDamage = true,
        icon = "ReplaceableTextures\\CommandButtons\\BTNSentryWard.blp",
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

-- Iterate over all a units buffs and get the final damage modifier
function getModifiedDamage(unit, target, amount)
    local buffs = getBuffs(unit)
    local modifier = 1
    for buffName,val in pairs(buffs) do
        local effects = BUFF_INFO[buffName].effects
        for _, info in pairs(effects) do
            if info.type == 'multiplyDamage' then
                modifier = modifier * info.amount * val.stacks
            end
        end
    end
    local buffs = getBuffs(target)
    for buffName,val in pairs(buffs) do
        local effects = BUFF_INFO[buffName].effects
        for _, info in pairs(effects) do
            if info.type == 'multiplyIncomingDamage' then
                modifier = modifier * info.amount * val.stacks
            end
        end
    end
    -- Repeat for items
    local ownerPlayerId = GetPlayerId(GetOwningPlayer(unit))
    if hero.getHero(ownerPlayerId) == unit then
        local items = equipment.getEquippedItems(ownerPlayerId)
        for _, itemId in pairs(items) do
            for _, info in pairs(itemmanager.ITEMS[itemId].stats) do
                if info.type == 'multiplyDamage' then
                    modifier = modifier * info.amount
                end
            end
        end
        local stats = hero.getStatEffects(ownerPlayerId)
        for _, statInfo in pairs(stats) do
            if statInfo.type == 'multiplyDamage' then
                modifier = modifier * statInfo.amount
            end
        end
    end
    local targetPlayerId = GetPlayerId(GetOwningPlayer(target))
    if hero.getHero(targetPlayerId) == target then
        local items = equipment.getEquippedItems(targetPlayerId)
        for _, itemId in pairs(items) do
            for _, info in pairs(itemmanager.ITEMS[itemId].stats) do
                if info.type == 'multiplyIncomingDamage' then
                    modifier = modifier * info.amount
                end
            end
        end
        local stats = hero.getStatEffects(targetPlayerId)
        for _, statInfo in pairs(stats) do
            if statInfo.type == 'multiplyIncomingDamage' then
                modifier = modifier * statInfo.amount
            end
        end
    end
    return amount * modifier
end

function getModifiedHealing(unit, target, amount)
    local buffs = getBuffs(unit)
    local modifier = 1
    for buffName,val in pairs(buffs) do
        local effects = BUFF_INFO[buffName].effects
        for idx,info in pairs(effects) do
            if info.type == 'multiplyHealing' then
                modifier = modifier * info.amount * val.stacks
            end
        end
    end
    local buffs = getBuffs(target)
    for buffName,val in pairs(buffs) do
        local effects = BUFF_INFO[buffName].effects
        for idx,info in pairs(effects) do
            if info.type == 'multiplyIncomingHealing' then
                modifier = modifier * info.amount * val.stacks
            end
        end
    end
    -- Repeat for items
    local ownerPlayerId = GetPlayerId(GetOwningPlayer(unit))
    if hero.getHero(ownerPlayerId) == unit then
        local items = equipment.getEquippedItems(ownerPlayerId)
        for _, itemId in pairs(items) do
            for _, info in pairs(itemmanager.ITEMS[itemId].stats) do
                if info.type == 'multiplyHealing' then
                    modifier = modifier * info.amount
                end
            end
        end
        local stats = hero.getStatEffects(ownerPlayerId)
        for _, statInfo in pairs(stats) do
            if statInfo.type == 'multiplyHealing' then
                modifier = modifier * statInfo.amount
            end
        end
    end
    local targetPlayerId = GetPlayerId(GetOwningPlayer(target))
    if hero.getHero(targetPlayerId) == target then
        local items = equipment.getEquippedItems(targetPlayerId)
        for _, itemId in pairs(items) do
            for _, info in pairs(itemmanager.ITEMS[itemId].stats) do
                if info.type == 'multiplyIncomingHealing' then
                    modifier = modifier * info.amount
                end
            end
        end
        local stats = hero.getStatEffects(targetPlayerId)
        for _, statInfo in pairs(stats) do
            if statInfo.type == 'multiplyIncomingHealing' then
                modifier = modifier * statInfo.amount
            end
        end
    end
    return amount * modifier
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
}
