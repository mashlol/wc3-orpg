local Vector = {x = 0, y = 0}

local abs = function(a)
  if a >= 0 then
    return a
  end
  return -a
end

function Vector:new(o)
    o = {
        x = o.x,
        y = o.y,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

function Vector:fromAngle(angle)
    return Vector:new{
        x = Cos(angle),
        y = Sin(angle),
    }
end

function Vector:add(v)
    self.x = self.x + v.x
    self.y = self.y + v.y
    return self
end

function Vector:subtract(v)
    self.x = self.x - v.x
    self.y = self.y - v.y
    return self
end

function Vector:multiply(s)
    self.x = self.x * s
    self.y = self.y * s
    return self
end

function Vector:divide(s)
    self.x = self.x / s
    self.y = self.y / s
    return self
end

function Vector:magnitude(s)
    return abs(SquareRoot(self.x^2 + self.y^2))
end

function Vector:angle()
    return Atan2(self.y, self.x)
end

function Vector:normalize()
    local mag = self:magnitude()
    return self:divide(mag)
end

return Vector
