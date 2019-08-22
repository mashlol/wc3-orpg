local buff = require('src/buff.lua')

return {
    effects = {},
    icon = "ReplaceableTextures\\CommandButtons\\BTNPotionOfVampirism.blp",
    maxStacks = 10,
    onMaxStacks = function(target, buffInstance)
        buff.removeBuff(target, 'corrosivedecay')
        buff.addBuff(buffInstance.source, target, 'corrosivedecaydot', 15)
        return true
    end
}
