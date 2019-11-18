local Yeti = {}

function Yeti:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end


function Yeti:getName()
    return "Giant Yeti"
end

-- Counter-clockwise coords
function Yeti:getBounds()
    return {
        {x = 31102, y = -21298},
        {x = 29259, y = -21275},
        {x = 29520, y = -23482},
        {x = 31204, y = -23478},
    }
end

function Yeti:init()
    self.ctx:registerDoor(gg_dest_YTcx_4753)
end

return Yeti
