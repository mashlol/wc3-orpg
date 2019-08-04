#!/usr/bin/bash
set -e
shopt -s globstar

echo "Copying map.w3x to bin/built.w3x"
cp map.w3x bin/built.w3x

echo "Extracting war3map.lua"
./MPQEditor.exe -console mopaq_extract

echo "Generating bin/war3map_compiled.lua"

cat header.lua > bin/war3map_compiled.lua

for FILENAME in src/**/*.lua; do
	if [ $FILENAME != 'src/main.lua' ]
	then
        echo "Compiling $FILENAME"
		printf "\n$FILENAME = function()\n" | sed -e 's/\//_/g' -e 's/\./_/g' >> bin/war3map_compiled.lua
	    cat $FILENAME >> bin/war3map_compiled.lua
	    printf "\nend\n" >> bin/war3map_compiled.lua
    fi
done

for FILENAME in src/**/*.lua; do
   printf "requireMap[\"$FILENAME\"] = $(echo $FILENAME | sed -e 's/\//_/g' -e 's/\./_/g')\n" >> bin/war3map_compiled.lua
done

printf "\n\n" >> bin/war3map_compiled.lua

cat src/main.lua >> bin/war3map_compiled.lua

printf "\n\n" >> bin/war3map_compiled.lua

sed -e '/local REPLACE_ME/r./bin/war3map_compiled.lua' ./bin/war3map.lua > bin/war3map_replaced.lua

mv bin/war3map_replaced.lua bin/war3map.lua
rm bin/war3map_compiled.lua

echo 'Adding war3map.lua to mpq archive'

./MPQEditor.exe -console mopaq

echo 'Launching map in wc3'

cp bin/built.w3x /c/Users/Kevin/Documents/Warcraft\ III/Maps/Download/temp/built_1.w3x
/c/Program\ Files/Warcraft\ III/x86_64/Warcraft\ III.exe -loadfile /c/Users/Kevin/Documents/Warcraft\ III/Maps/Download/temp/built_1.w3x
