local ABILITY_LIST = {
    FourCC('Amls'),
    FourCC('Aroc'),
    FourCC('Amic'),
    FourCC('Amil'),
    FourCC('Aclf'),
    FourCC('Acmg'),
    FourCC('Adef'),
    FourCC('Adis'),
    FourCC('Afbt'),
    FourCC('Afbk'),
}

function writeFile(file, contents)
    local name = GetPlayerName(GetLocalPlayer())
    name = string.gsub(name, "|", "")
    file = 'tvt/' .. name .. '/' .. file

    local c = 0
    local len = StringLength(contents)
    local chunk

    PreloadGenClear()
    PreloadGenStart()
    for i=0,len-1,200 do
        chunk = SubString(contents, i, i + 200)
        Preload(
            "\" )\ncall BlzSetAbilityActivatedIcon(" ..
            I2S(ABILITY_LIST[c + 1]) ..
            ", \"" ..
            chunk ..
            "\")\n//")
        c = c + 1
    end
    Preload("\" )\nendfunction\nfunction a takes nothing returns nothing\n //")
    PreloadGenEnd(file)
end

function exists(file)
    return readFile(file) ~= nil
end

function readFile(file)
    local name = GetPlayerName(GetLocalPlayer())
    name = string.gsub(name, "|", "")
    file = 'tvt/' .. name .. '/' .. file

    local original = {}
    local output = ""

    for i=0,#ABILITY_LIST-1,1 do
        original[i + 1] = BlzGetAbilityActivatedIcon(ABILITY_LIST[i + 1])
    end

    Preloader(file)

    for i=0,#ABILITY_LIST-1,1 do
        chunk = BlzGetAbilityActivatedIcon(ABILITY_LIST[i + 1])
        if chunk == original[i + 1] then
            return output ~= "" and output or nil
        end

        output = output .. chunk

        BlzSetAbilityActivatedIcon(ABILITY_LIST[i + 1], original[i + 1])
    end

    return output ~= "" and output or nil
end


return {
    writeFile = writeFile,
    readFile = readFile,
    exists = exists,
}
