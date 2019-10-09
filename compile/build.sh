#!/usr/bin/bash
set -e
shopt -s globstar

mkdir -p bin

echo "Copying map.w3x to bin/built.w3x"
cp map.w3x bin/built.w3x

cd compile

echo "Extracting war3map.lua"
./MPQEditor.exe -console mopaq_extract

cd ..

echo "Generating bin/war3map_compiled.lua"

node ./compile/build

sed -e '/local REPLACE_ME/r./bin/war3map_compiled.lua' ./bin/war3map.lua > bin/war3map_replaced.lua

echo 'Moving and cleaning up temp lua files'

cp bin/war3map_replaced.lua bin/war3map.lua

echo 'Adding war3map.lua to mpq archive'

cd compile

./MPQEditor.exe -console mopaq

cd ..

echo 'Deleting old versions'

rm -f /c/Users/Kevin/Documents/Warcraft\ III/Maps/Download/temp/built_*

echo 'Deleting build artifacts'

mv ./bin/war3map.lua ./bin/script_stored_min

rm ./bin/*.lua

echo 'Launching map in wc3'

BUILD_NUM=$RANDOM
echo "Map: built_$BUILD_NUM.w3x"
cp bin/built.w3x /c/Users/Kevin/Documents/Warcraft\ III/Maps/Download/temp/built_$BUILD_NUM.w3x
/c/Program\ Files/Warcraft\ III/x86_64/Warcraft\ III.exe -loadfile /c/Users/Kevin/Documents/Warcraft\ III/Maps/Download/temp/built_$BUILD_NUM.w3x
