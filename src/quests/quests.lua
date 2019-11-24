

local TYPE = {
    KILL = {},
    ITEM = {},
    DISCOVER = {},
}

function getQuests() 
return {
[1] = {
    name = "Trouble in Turtle Town",
    getQuestFrom = gg_unit_nvil_0069,
    handQuestTo = gg_unit_nvil_0069,
    obtainText = "Hello traveller, my name is Fjorn. If you're looking to help out around here, we could really do with some help killing the snapping turtles invading the forest to the west.",
    incompleteText = "Have you completed the task?",
    completedText = "Thank you for defeating those turtles!",
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
    toKill = FourCC('hmbs'),
    name = "Snapping Turtles",
},
},
    prerequisites = {},
    levelRequirement = 0,
},
[2] = {
    name = "Fred's Quest",
    getQuestFrom = gg_unit_nvl2_0070,
    handQuestTo = gg_unit_nvil_0071,
    obtainText = "A neighbor of mine, Fred, has recently gone missing. I want you to go find him. Last time I saw him he was headed west into the forest.",
    incompleteText = "I don't think its possible to see this text.",
    completedText = "Fjorn sent you? Thank goodness you've arrived! I was hunting turtles for soup, when all of a sudden I was knocked out and thrown in a cage!",
    rewards = {
        exp = 20,
        gold = 5,
    },
    objectives = {
},
    prerequisites = {},
    levelRequirement = 0,
},
[3] = {
    name = "Fred's Soup",
    getQuestFrom = gg_unit_nvil_0071,
    handQuestTo = gg_unit_nvil_0071,
    obtainText = "I'm starving! I was out here collecting turtle meat so I could make my famous turtle soup. However, I'm feeling a little woozy...could you please collect five River Turtle Meat and bring it back to me?",
    incompleteText = "Have you completed the task?",
    completedText = "Thanks so much! I need to get back to the village so I can make my soup!",
    rewards = {
        exp = 100,
        gold = 5,
    },
    objectives = {
[0] = {
    type = TYPE.ITEM,
    amount = 5,
    itemId = 9,
},
},
    prerequisites = {2},
    levelRequirement = 0,
},
[4] = {
    name = "Return to Freydell Village",
    getQuestFrom = gg_unit_nvil_0071,
    handQuestTo = gg_unit_nvl2_0070,
    obtainText = "I appreciate all you've done for me, but I can take it from here. Return to Fjord and see what else he has for you.",
    incompleteText = "Impossible!",
    completedText = "Fred sent you back here? Well, good I have some more work for you.",
    objectives = {
},
    rewards = {
        exp = 30,
        gold = 3,
    },
    prerequisites = {3},
    levelRequirement = 0,
},
[5] = {
    name = "Giant Turtle",
    getQuestFrom = gg_unit_nvil_0069,
    handQuestTo = gg_unit_nvil_0069,
    obtainText = "There's a giant turtle just west of Freydell Village, We believe it's the leader of the turtles invading the forest. Slay it and I will reward you fairly.",
    incompleteText = "Have you slain the giant turtle",
    completedText = "You did it? I'm amazed!",
    objectives = {
[0] = {
    type = TYPE.KILL,
    amount = 1,
    toKill = FourCC('hbos'),
    name = "Giant Turtle",
},
},
    rewards = {
        exp = 150,
        gold = 25,
    },
    prerequisites = {4},
    levelRequirement = 0,
},
[6] = {
    name = "The Glacial Tundra",
    getQuestFrom = gg_unit_nvl2_0070,
    handQuestTo = gg_unit_nvil_0040,
    obtainText = "Travel to The Glacial Tundra, it's just west of here. You can find my friend Higram there, he might have some work for you.",
    incompleteText = "Have you traveled to The Glacial Tundra yet?",
    completedText = "Ah, old man Fjorn sent you? Good. I have a lot of work that needs to get done.",
    objectives = {
},
    rewards = {
        exp = 20,
        gold = 5,
    },
    prerequisites = {4},
    levelRequirement = 0,
},
[7] = {
    name = "A Cold Winter",
    getQuestFrom = gg_unit_nvil_0040,
    handQuestTo = gg_unit_nvil_0040,
    obtainText = "This winter is a brutal one... the trolls to the west raided our house and stole our furs, could you go hunt some mammoth so that we could use their fur?",
    incompleteText = "Have you completed the task?",
    completedText = "Thank the lords! We will survive another winter.",
    rewards = {
        exp = 50,
        gold = 5,
    },
    objectives = {
[0] = {
    type = TYPE.ITEM,
    amount = 10,
    itemId = 76,
},
[1] = {
    type = TYPE.ITEM,
    amount = 5,
    itemId = 77,
},
},
    prerequisites = {6},
    levelRequirement = 0,
},
[8] = {
    name = "Trolls to the West",
    getQuestFrom = gg_unit_nvil_0040,
    handQuestTo = gg_unit_nvil_0040,
    obtainText = "Those Trolls have been bothering us for too long! It's time we strike back! Go to their village, it's just west of here and slay them all!",
    incompleteText = "Have you killed those Trolls?",
    completedText = "Well done!",
    rewards = {
        exp = 50,
        gold = 5,
    },
    objectives = {
[0] = {
    type = TYPE.KILL,
    amount = 10,
    toKill = FourCC('trop'),
    name = "Troll Priests",
},
[1] = {
    type = TYPE.KILL,
    amount = 10,
    toKill = FourCC('trol'),
    name = "Troll Warriors",
},
},
    prerequisites = {7},
    levelRequirement = 0,
},
[9] = {
    name = "Your Move, Chief",
    getQuestFrom = gg_unit_nvlw_0178,
    handQuestTo = gg_unit_nvlw_0178,
    obtainText = "The leader of the Trolls in the village is a powerful man. Take him down and they will lose their morale!",
    incompleteText = "Have you killed the Troll Chieftan yet?",
    completedText = "Finally... we can live in peace.",
    rewards = {
        exp = 50,
        gold = 5,
    },
    objectives = {
[0] = {
    type = TYPE.KILL,
    amount = 1,
    toKill = FourCC('troc'),
    name = "Troll Chieftan",
},
},
    prerequisites = {7},
    levelRequirement = 0,
},
[10] = {
    name = "The Last of Them",
    getQuestFrom = gg_unit_nvlw_0178,
    handQuestTo = gg_unit_nvlw_0178,
    obtainText = "I have reason to believe that there are more Trolls in a cave just north of the village. Find them and slay them. I will reward you handsomely.",
    incompleteText = "Go find the cave and slay those Trolls!",
    completedText = "Well done! Here is your reward.",
    rewards = {
        exp = 50,
        gold = 5,
    },
    objectives = {
[0] = {
    type = TYPE.KILL,
    amount = 1,
    toKill = FourCC('mine'),
    name = "High Troll Priest",
},
[1] = {
    type = TYPE.KILL,
    amount = 1,
    toKill = FourCC('h002'),
    name = "Giant Yeti",
},
[2] = {
    type = TYPE.KILL,
    amount = 1,
    toKill = FourCC('over'),
    name = "Ice Troll Warlord",
},
},
    prerequisites = {9},
    levelRequirement = 0,
},
[11] = {
    name = "Stamping out the Fires",
    getQuestFrom = gg_unit_gens_0376,
    handQuestTo = gg_unit_gens_0376,
    obtainText = "The Cultists are rallying outside of our camp to the north west. They need to be slowed down. Find and destroy five Cultist Bonfires and return back to me.",
    incompleteText = "Have you extinguished the Cultist Bonfires?",
    completedText = "Nice work! I have another task for you. Talk to me again when you are ready.",
    objectives = {
[0] = {
    type = TYPE.KILL,
    amount = 1,
    toKill = FourCC('fire'),
    name = "Northwest Bonfire",
    verb = "Extinguish",
    verbPast = "extinguished",
},
[1] = {
    type = TYPE.KILL,
    amount = 1,
    toKill = FourCC('sfir'),
    name = "Southwest Bonfire",
    verb = "Extinguish",
    verbPast = "extinguished",
},
[2] = {
    type = TYPE.KILL,
    amount = 1,
    toKill = FourCC('cfir'),
    name = "Central Bonfire",
    verb = "Extinguish",
    verbPast = "extinguished",
},
[3] = {
    type = TYPE.KILL,
    amount = 1,
    toKill = FourCC('nefi'),
    name = "Northeast Bonfire",
    verb = "Extinguish",
    verbPast = "extinguished",
},
[4] = {
    type = TYPE.KILL,
    amount = 1,
    toKill = FourCC('sefi'),
    name = "Southeast Bonfire",
    verb = "Extinguish",
    verbPast = "extinguished",
},
},
    rewards = {
        exp = 200,
        gold = 25,
    },
    prerequisites = {15},
    levelRequirement = 0,
},
[12] = {
    name = "Full Momentum",
    getQuestFrom = gg_unit_hcth_0378,
    handQuestTo = gg_unit_hcth_0378,
    obtainText = "The Cultist Commanders are readying for their final assault. Take them out and let them know who they are messing with! You can find them in the encampments to the north west.",
    incompleteText = "Have you slain those Commanders yet?",
    completedText = "Nicely done.",
    objectives = {
[0] = {
    type = TYPE.KILL,
    amount = 1,
    toKill = FourCC('clea'),
    name = "Cultist Commander Siddel",
},
[1] = {
    type = TYPE.KILL,
    amount = 1,
    toKill = FourCC('cled'),
    name = "Cultist Commander Audric",
},
},
    rewards = {
        exp = 250,
        gold = 30,
    },
    prerequisites = {15},
    levelRequirement = 0,
},
[13] = {
    name = "Overrun with Wolves",
    getQuestFrom = gg_unit_ntks_0365,
    handQuestTo = gg_unit_ntks_0365,
    obtainText = "These once peaceful lands have been overrun with wolves. My tribes can no longer survive here. Could you help us out?",
    incompleteText = "Have you killed the wolves?",
    completedText = "I am very impressed with your skills. Talk to me if you need more work.",
    objectives = {
[0] = {
    type = TYPE.KILL,
    amount = 10,
    toKill = FourCC('wolf'),
    name = "Arctic Wolves",
},
},
    rewards = {
        exp = 50,
        gold = 5,
    },
    prerequisites = {},
    levelRequirement = 7,
},
[14] = {
    name = "Alpha Wolf",
    getQuestFrom = gg_unit_ntks_0365,
    handQuestTo = gg_unit_ntks_0365,
    obtainText = "There is a nook just north east of here where the Alpha Wolf resides, I need you to slay it. If you follow the road west you should be able to find him.",
    incompleteText = "Have you slain the Alpha Wolf?",
    completedText = "You did it? I'm amazed!",
    objectives = {
[0] = {
    type = TYPE.KILL,
    amount = 1,
    toKill = FourCC('hbld'),
    name = "The Alpha Wolf",
},
},
    rewards = {
        exp = 200,
        gold = 30,
    },
    prerequisites = {13},
    levelRequirement = 8,
},
[15] = {
    objectives = {
},
    name = "Ironwell Camp",
    getQuestFrom = gg_unit_nvil_0040,
    handQuestTo = gg_unit_gens_0376,
    levelRequirement = 0,
    obtainText = "Thank you for all of your help here. Without the trolls pestering us, we should be able to survive the winter. I think your help might be best used elsewhere. Last I heard, they have their hands full down in Ironwell City. Maybe if you go to the military camp just outside of the city they'll need some help. It's a bit of a trek south east of here.",
    incompleteText = "Impossibru!",
    completedText = "You'd like to help? Well, I suppose we need all the help we can get. Let me see if I can find something for you to do.",
    rewards = {
        exp = 25,
        gold = 5,
    },
    prerequisites = {9,8},
},
}
end
return {getQuests = getQuests, TYPE=TYPE}