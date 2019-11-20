#!/usr/bin/bash
set -e
shopt -s globstar

mkdir -p bin

rm -rf bin/built.w3x

echo "Codegenning items & quests"
cd compile
node convert_items.js
node convert_quests.js
cd ..

echo "Copying map.w3x to bin/built.w3x"
cp -r map.w3x bin/built.w3x

echo "Extracting war3map.lua"
cp bin/built.w3x/war3map.lua bin/

echo "Generating bin/war3map_compiled.lua"

node ./compile/build $@

sed -e '/local REPLACE_ME/r./bin/war3map_compiled.lua' ./bin/war3map.lua > bin/war3map_replaced.lua

echo 'Moving and cleaning up temp lua files'

cp bin/war3map_replaced.lua bin/war3map.lua

echo 'Adding war3map.lua to mpq archive'

cp bin/war3map.lua bin/built.w3x/war3map.lua

echo 'Deleting old versions'

rm -rf /c/Users/Kevin/Documents/Warcraft\ III\ Beta/Maps/Download/temp/built_*

echo 'Deleting build artifacts'

mv ./bin/war3map.lua ./bin/script_stored_min

rm ./bin/*.lua

if [ "$1" == "--bump" ]; then
    echo "Bumping the version: $2"

    echo "Replacing string files in w3x folder with version: $2"
    sed -e "s/PLACEHOLDER_NAME_REPLACED/The Veiled Throne ORPG $2/g" -e "s/PLACEHOLDER_DESC_REPLACED/Pre alpha release of TVT ORPG. $2/g" -e "s/PLACEHOLDER_TITLE_REPLACED/The Veiled Throne ORPG $2/g" bin/built.w3x/war3map.wts > bin/temp_strings.wts
    awk 'sub("$", "\r")' bin/temp_strings.wts > bin/built.w3x/war3map.wts

    rm -f bin/compiled_map.w3x

    echo "Removing editor only files"
    rm -f bin/built.w3x/war3map.wtg
    rm -f bin/built.w3x/war3map.w3c
    rm -f bin/built.w3x/war3map.w3s
    rm -f bin/built.w3x/war3map.w3r
    rm -f bin/built.w3x/war3mapUnits.doo

    echo 'Converting folder back into an MPQ archive'
    cd compile
    ./MPQEditor.exe -console mopaq
    cd ..

    echo 'Copying MPQ archive to ../tvt-releases/tvt-orpg-$2.w3x'
    rm -f ../tvt-releases/*.w3x
    cp bin/compiled_map.w3x "../tvt-releases/tvt-orpg-$2.w3x"

    echo 'Committing and pushing'
    cd ../tvt-releases
    git add .
    git commit -m "Version bump: $2"
    git push

    cd ../map
else
    echo 'Launching map in wc3'

    BUILD_NUM=$RANDOM
    echo "Map: built_$BUILD_NUM.w3x"
    mkdir -p ~/Documents/Warcraft\ III\ Beta/Maps/Download/temp/
    cp -r bin/built.w3x ~/Documents/Warcraft\ III\ Beta/Maps/Download/temp/built_$BUILD_NUM.w3x

    WC=/c/Program\ Files\ \(x86\)/Warcraft\ III\ Beta/x86_64/Warcraft\ III.exe
    if [ -f "$WC" ]; then
        echo "Found wc3 in Program Files (x86), using $WC"
        "$WC" -launch -loadfile ~/Documents/Warcraft\ III\ Beta/Maps/Download/temp/built_$BUILD_NUM.w3x
        exit 0
    fi
fi