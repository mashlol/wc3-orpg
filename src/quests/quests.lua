

local TYPE = {
    KILL = {},
    ITEM = {},
    DISCOVER = {},
}

    local QUESTS = {
[1] = {
    name = "Trouble in Turtle Town",
    getQuestFrom = gg_unit_nvil_0069,
    handQuestTo = gg_unit_nvil_0069,
    obtainText = "Yo yo I got a quest for you",
    incompleteText = "Yo yo the quest is incomplet yo",
    completedText = "Yo yo nice job yo",
    objectives = {
[0] = {
    type = TYPE.KILL,
    amount = 10,
    name = "Snapping Turtles",
    verb = "Exterminate",
    verbPast = "exterminated",
},
[1] = {
    type = TYPE.ITEM,
    amount = 10,
    itemId = 77,
},
},
    prerequisites = {1,2},
    levelRequirement = 1,
},
}
 return {QUESTS=QUESTS, TYPE=TYPE}
