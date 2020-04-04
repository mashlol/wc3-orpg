# WC3 ORPG "TEMPLATE"

## Info

This is a wc3 project a few people were working on for a few months, but then Blizzard released 1.32 and caused issues with lua. We have since lost interest (and patience in Blizzard) in trying to fix it, so we've decided to open source the project in the hopes that someone might find it useful. There is probably something here that might be useful to someone, however the map itself will desync in multiplayer after a while.

It's not really a template, hence the quotes, but with a little coding you could easily turn it into your own project. Making spells is fairly easy (check `src/spells/` and `src/spell.lua`). Making new heroes should be fairly easy (check out `src/hero.lua`), and making items/quests/vendors/drops is all done in a UI and doesn't require any coding.

## Setup

Repo: [https://github.com/mashlol/wc3map](https://github.com/mashlol/wc3map)

**Requirements:** Git, Node.js & MinGW

Git & MinGW: [https://git-scm.com/download/win](https://git-scm.com/download/win)

Node.js: [https://nodejs.org/en/download/](https://nodejs.org/en/download/)

Make sure node & npm (in C:\Program Files\nodejs) are in your `$PATH` . [https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/)

You might also have to modify your wc3 executable path in `compile/build.sh`, since it only checks a couple of places.

Open the “git bash” file which you downloaded from the git website (Mines in `C:\Program Files\Git\git-bash.exe`). Run the following:

```
cd ~
git clone https://github.com/mashlol/wc3map.git
cd ~/wc3map/compile
npm install
cd ~/wc3map
./build.sh --no-min
```

Thats it! The map should start. If you make changes, rerun the ./build.sh part and it will re-compile and run the map with your changes.


## Adding a house you can enter

First, add the house interior terrain in a corner of the map. Once you're done with the terrain and know which house it's supposed to be for, you just need to add some regions:


1. Add a region called house{#}enter{#}.
    1. This region goes at the outside door of the house.
    2. The first # should be incremental, find whichever the highest house is and increase it by one. For example, if the highest one is 2, yours should be 3.
    3. The second number is incremental for the house itself. If your house has multiple entrances, you can increase it, starting at 1.
    4. So a valid region would be: house3enter1
2. Add a region called house{#}entrance{#}
    5. This region is where the unit will appear after they enter the house. Don't overlap it with any exits or they'll immediately leave!
    6. The first number matches the first number above.
    7. The second number matches the second number above. If you have multiple entrances, you'll need multiple of these regions as well
3. Add a region called house{#}leave{#}
    8. This region is the interior door where they will leave from.
    9. Numbers match from above
4. Add a region called house{#}exit{#}
    10. This is where the unit will appear outside of the house after leaving.
    11. Don't overlap it with any entrances or they'll just pop back in!
5. That's it, it's all in the editor, no code changes required. Build and test it out :). You can add multiple "enter" or "leave" regions for a single house, but they will need a corresponding entrance/exit region!


## Using the UI to make changes to quests/items/drops/vendors

To use the UI for the first time, run the following:

```
cd ~/wc3map/web
npm install
npm start &
cd ..
./build.sh --no-min
```

Be patient with it, it may take some time for each of the steps. If things don't work, try running git bash in admin mode. For subsequent runs you can omit the `npm install` command.


## Object Editor Information

We've done a few weird hacks to make things work.

*   Point value is actually the scale of the unit (* 100). So if their scale is 1.5, their point value must be 150.
*   The field **Combat - Death Type** actually means something different
    *   Can raise - the unit is respawnable by normal measures, will respawn after 30 sec
    *   Can't raise - the unit is either not respawnable, or in a dungeon so respawned as part of the dungeon
    *   Does not decay - Means the unit is elite
    *   Does decay - Means the unit is not elite.
*   The field **Art - Use Extended Line of Sight** actually means whether the unit will give EXP or not.
    *   If it is marked as True, then the unit will NOT give exp!
