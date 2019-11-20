

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
    rewards = {
        exp = 50,
        gold = 5,
        items = {
            [6] = 5,
        },
    },
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
    itemId = 76,
},
[2] = {
    type = TYPE.KILL,
    amount = 15,
    verb = "Kill",
    verbPast = "killed",
},
},
    prerequisites = {1,2},
    levelRequirement = 5,
},
[2] = {
    name = "New Quest",
    levelRequirement = 5,
    obtainText = "Some new obtain text",
    incompleteText = "Did you do it tho?",
    rewards = {
        exp = 15,
        gold = 50,
    },
    getQuestFrom = gg_unit_nvl2_0008,
    handQuestTo = gg_unit_nvil_0069,
    completedText = "Nice job",
},
[3] = {
    name = "Sweet New Quest yo",
    levelRequirement = 1,
    obtainText = "Yo do something",
    incompleteText = "U didnt do something",
    completedText = "Nice u did osmething!",
    rewards = {
        exp = 500,
        gold = 12,
    },
    getQuestFrom = gg_unit_ntks_0365,
    handQuestTo = gg_unit_nvil_0040,
    objectives = {
[0] = {
    type = TYPE.ITEM,
    amount = 15,
    itemId = 2,
},
},
},
}
 return {QUESTS=QUESTS, TYPE=TYPE}
