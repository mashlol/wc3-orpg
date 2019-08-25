#!/usr/bin/bash
set -e
shopt -s globstar

echo "Copying map.w3x to bin/built.w3x"
cp map.w3x bin/built.w3x

echo "Extracting war3map.lua"
./MPQEditor.exe -console mopaq_extract

echo "Generating bin/war3map_compiled.lua"

node build

sed -e '/local REPLACE_ME/r./bin/war3map_compiled.lua' ./bin/war3map.lua > bin/war3map_replaced.lua

echo 'Moving and cleaning up temp lua files'

mv bin/war3map_replaced.lua bin/war3map.lua
rm bin/war3map_compiled.lua

echo 'Adding war3map.lua to mpq archive'

./MPQEditor.exe -console mopaq

echo 'Deleting old versions'

rm /c/Users/Kevin/Documents/Warcraft\ III/Maps/Download/temp/built_*

echo 'Deleting build artifacts'

rm ./bin/*.lua

echo 'Launching map in wc3'

BUILD_NUM=$RANDOM
echo "Map: built_$BUILD_NUM.w3x"
cp bin/built.w3x /c/Users/Kevin/Documents/Warcraft\ III/Maps/Download/temp/built_$BUILD_NUM.w3x
/c/Program\ Files/Warcraft\ III/x86_64/Warcraft\ III.exe -loadfile /c/Users/Kevin/Documents/Warcraft\ III/Maps/Download/temp/built_$BUILD_NUM.w3x
