GC = {}
GC.Table = {}
setmetatable(GC.Table, {__mode = "k"})
GC.Native = {}
GC.Type = {}
GC.Type.__index = GC.Type
GC.Debug = __DEBUG__

function GC.Type:new(name, remove, constructors)
    local type = {}
    setmetatable(type, self)

    type.name = name
    type.remove = remove
    type.constructors = constructors
    type:register()
    return type
end

function GC.Type:printstats()
    if self.stats then
        print("Statistics for " .. self.name .. ":")
        print("Automatically freed: " .. self.stats.autofree)
        print("Explicitly freed: " .. self.stats.explicitfree)
        print("Currently alive: " .. self.stats.alive)
        print("Bad free calls: " .. self.stats.badfree)
        print("Bad constructor calls: " .. self.stats.badconstruct)
        print("Free calls on untracked: " .. self.stats.unknownfree)
    end
end

function GC.Type:register()
    local debug = GC.Debug

    if not GC.Native[self.remove] then
        GC.Native[self.remove] = _ENV[self.remove]
    end

    local removefunc = GC.Native[self.remove]

    if debug then
        if not GC.FreedTable then
            GC.FreedTable = {}
            setmetatable(GC.FreedTable, {__mode = "k"})
        end

        self.stats = {
            autofree = 0,
            explicitfree = 0,
            alive = 0,
            badfree = 0,
            badconstruct = 0,
            unknownfree = 0
        }
    end

    local collectfunc
    if not debug then
        collectfunc = function(obj)
            removefunc(obj[1])
        end
    else
        collectfunc = function(obj)
            removefunc(obj[1])
            self.stats.autofree = self.stats.autofree + 1
            self.stats.alive = self.stats.alive - 1
        end
    end

    local collectmetatable = {
        __gc = collectfunc
    }

    if not debug then
        _ENV[self.remove] = function(obj)
            local table = GC.Table[obj]
            if table then
                removefunc(obj)
                setmetatable(table, nil)
                GC.Table[obj] = nil
            end
        end
    else
        _ENV[self.remove] = function(obj)
            local table = GC.Table[obj]
            if table then
                removefunc(obj)
                setmetatable(table, nil)
                GC.Table[obj] = nil
                GC.FreedTable[obj] = true
                self.stats.explicitfree = self.stats.explicitfree + 1
                self.stats.alive = self.stats.alive - 1
            else
                if not obj or GC.FreedTable[obj] then
                    if obj then
                        print("Tried to free an already freed object: " .. obj)
                    else
                        print("Tried to free nil of type: " .. self.name)
                    end

                    self.stats.badfree = self.stats.badfree + 1
                else
                    self.stats.unknownfree = self.stats.unknownfree + 1
                end

            end
        end
    end

    local registerfunc
    if not debug then
        registerfunc = function(obj)
            local table = {obj}
            setmetatable(table, collectmetatable)
            GC.Table[obj] = table
        end
    else
        registerfunc = function(obj)
            local table = {obj}
            setmetatable(table, collectmetatable)
            GC.Table[obj] = table
            self.stats.alive = self.stats.alive + 1
        end
    end

    for i, v in ipairs(self.constructors) do
        if not GC.Native[v] then
            GC.Native[v] = _ENV[v]
        end

        local constructorfunc = GC.Native[v]

        if not debug then
            _ENV[v] = function(...)
                local result = constructorfunc(...)
                if result then
                   registerfunc(result)
                end
                return result
            end
        else
            _ENV[v] = function(...)
                local result = constructorfunc(...)
                if result then
                   registerfunc(result)
                else
                    print("Constructor call returned nil: " .. v)
                    self.stats.badconstruct = self.stats.badconstruct + 1
                end
                return result
            end
        end
    end
end

GC.Location = GC.Type:new("location", "RemoveLocation", {
    "BlzGetTriggerPlayerMousePosition",
    "CameraSetupGetDestPositionLoc",
    "GetCameraEyePositionLoc",
    "GetCameraTargetPositionLoc",
    "GetOrderPointLoc",
    "GetSpellTargetLoc",
    "GetStartLocationLoc",
    "GetUnitLoc",
    "GetUnitRallyPoint",
    "Location"
})
GC.Group = GC.Type:new("group", "DestroyGroup", {"CreateGroup"})
GC.Force = GC.Type:new("force", "DestroyForce", {"CreateForce"})

local performGC = function()
    if __DEBUG__ then
        GC.Location:printstats()
        GC.Group:printstats()
        GC.Force:printstats()
    end
end

local init = function()
    TimerStart(CreateTimer(), 30, true, performGC)
end

return {
    init = init,
}
