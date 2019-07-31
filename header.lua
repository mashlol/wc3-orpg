function InitGlobals()
end

requireMap = {}
requireCache = {}

function require(path)
    if requireCache[path] == nil then
        requireCache[path] = requireMap[path]()
    end
    return requireCache[path]
end
