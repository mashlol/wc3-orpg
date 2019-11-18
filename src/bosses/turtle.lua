local Turtle = {}

function Turtle:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Turtle:getName()
    return "Giant Turtle"
end

-- Counter-clockwise coords
function Turtle:getBounds()
    return false
end

function Turtle:init()
    self.ctx:registerDoor(gg_dest_YTcx_4753)
end

return Turtle
