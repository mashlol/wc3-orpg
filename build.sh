#!/usr/bin/bash
set -e

cat header.lua > bin/war3map.lua

for FILENAME in src/*.lua; do
	if [ $FILENAME != 'src/main.lua' ]
	then
		printf "\n$FILENAME = function()\n" | sed -e 's/\//_/g' -e 's/\./_/g' >> bin/war3map.lua
	    cat $FILENAME >> bin/war3map.lua
	    printf "\nend\n" >> bin/war3map.lua
    fi
done

for FILENAME in src/*.lua; do
	printf "requireMap[\"$FILENAME\"] = $(echo $FILENAME | sed -e 's/\//_/g' -e 's/\./_/g')\n" >> bin/war3map.lua
done

printf "\n\n" >> bin/war3map.lua

cat src/main.lua >> bin/war3map.lua

printf "\n\n" >> bin/war3map.lua

cat footer.lua >> bin/war3map.lua


cp map.w3x bin/built.w3x
./MPQEditor.exe -console mopaq

echo 'Done editing MPQ'

cp bin/built.w3x /c/Users/Kevin/Documents/Warcraft\ III/Maps/Download/temp/built.w3x
/c/Program\ Files/Warcraft\ III/x86_64/Warcraft\ III.exe -loadfile /c/Users/Kevin/Documents/Warcraft\ III/Maps/Download/temp/built.w3x
