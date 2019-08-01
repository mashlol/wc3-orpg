local abs = function(a)
  if a >= 0 then
    return a
  end
  return -a
end

local create = function(x, y)
  return {
    x = x,
    y = y,
  }
end

local fromAngle = function(angle)
  return {
    x = Cos(angle),
    y = Sin(angle),
  }
end

local add = function(a, b)
  return {
    x = a.x + b.x,
    y = a.y + b.y,
  }
end

local subtract = function(a, b)
  return {
    x = a.x - b.x,
    y = a.y - b.y,
  }
end

local multiply = function(a, b)
  return {
    x = a.x * b,
    y = a.y * b
  }
end

local magnitude = function(a)
  return SquareRoot(a.x^2 + a.y^2)
end

local normalize = function(a)
  local mag = magnitude(a)
  return {
    x = a.x / mag,
    y = a.y / mag,
  }
end

return {
  create = create,
  fromAngle = fromAngle,
  add = add,
  subtract = subtract,
  multiply = multiply,
  magnitude = magnitude,
  normalize = normalize,
}
