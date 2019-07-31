#!/usr/bin/bash
set -e

cat header.lua src/*.lua footer.lua > bin/war3map.lua
cp map.w3m bin/built.w3m
./MPQEditor.exe -console mopaq

echo 'Done editing MPQ'

cp bin/built.w3m /c/Users/Kevin/Documents/Warcraft\ III/Maps/Download/temp/built.w3m
/c/Program\ Files/Warcraft\ III/x86_64/Warcraft\ III.exe -loadfile /c/Users/Kevin/Documents/Warcraft\ III/Maps/Download/temp/built.w3m


