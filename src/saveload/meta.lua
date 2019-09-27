local file = require('src/saveload/file.lua')

function getNumCharacters()
    local contents = file.readFile('tvt/numchars.pld')
    return contents ~= nil and S2I(contents) or 0
end

function setNumCharacters(numCharacters)
    file.writeFile('tvt/numchars.pld', R2I(numCharacters))
end

return {
    getNumCharacters = getNumCharacters,
    setNumCharacters = setNumCharacters,
}