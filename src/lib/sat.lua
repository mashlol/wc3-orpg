--[[

  Version 0.4.1 - Copyright 2014 -  Jim Riecken <jimr@jimr.ca>

  Released under the MIT License - https://github.com/jriecken/sat-js

  A simple library for determining intersections of circles and
  polygons using the Separating Axis Theorem.
  @preserve SAT.js - Version 0.4.1 - Copyright 2014 - Jim Riecken <jimr@jimr.ca> - released under the MIT License. https://github.com/jriecken/sat-js */

  global define: false, module: false*/
  jshint shadow:true, sub:true, forin:true, noarg:true, noempty:true,
  eqeqeq:true, bitwise:true, strict:true, undef:true,
  curly:true, browser:true */

  Create a UMD wrapper for SAT. Works in:

  - Plain browser via global SAT variable
  - AMD loader (like require.js)
  - Node.js

  The quoted properties all over the place are used so that the Closure Compiler
  does not mangle the exposed API in advanced mode.

  @param {*} root - The global scope
  @param {Function} factory - Factory that creates SAT module

--]]

 local table_remove = table.remove
 local table_insert = table.insert


  local SAT = {}

  --[[

    ## Vector

    Represents a vector in two dimensions with `x` and `y` properties.


    Create a new Vector, optionally passing in the `x` and `y` coordinates. If
    a coordinate is not specified, it will be set to `0`

    @param {?number=} x The x position.
    @param {?number=} y The y position.
    @constructor

  --]]
  local Vector = {}
  Vector.prototype = {}
  Vector.metatable = {__index = Vector.prototype}


  function Vector:new(x, y) -- Vector
    local v = {}
    setmetatable(v, Vector.metatable)
    v.x = x or 0
    v.y = y or 0
    return v
  end

    -- Copy the values of another Vector into this one.

    -- @param {Vector} other The other Vector.
    -- @return {Vector} This for chaining.

    function Vector.prototype:copy(other)
      self.x = other.x
      self.y = other.y
      return self
    end

    -- Create a new vector with the same coordinates as this on.

    -- @return {Vector} The new cloned vector

    function Vector.prototype:clone()
      return Vector:new(self.x, self.y)
    end

    --Change this vector to be perpendicular to what it was before. (Effectively
    --roatates it 90 degrees in a clockwise direction)

    --@return {Vector} This for chaining.

    function Vector.prototype:perp()
      local x = self.x
      self.x = self.y
      self.y = -x
      return self
    end

    -- Rotate this vector (counter-clockwise) by the specified angle (in radians).

    -- @param {number} angle The angle to rotate (in radians)
    -- @return {Vector} This for chaining.

    function Vector.prototype:rotate(angle)
      local x = self.x
      local y = self.y
      self.x = x * math.cos(angle) - y * math.sin(angle)
      self.y = x * math.sin(angle) + y * math.cos(angle)
      return self
    end


    -- Reverse this vector.

    -- @return {Vector} This for chaining.

    function Vector.prototype:reverse()
      self.x = -self.x
      self.y = -self.y
      return self
    end


    -- Normalize this vector.  (make it have length of `1`)

    --@return {Vector} This for chaining.

    function Vector.prototype:normalize()
      local d = self:len()
      if d > 0 then
        self.x = self.x / d
        self.y = self.y / d
      end
      return self
    end


    -- Add another vector to this one.

    -- @param {Vector} other The other Vector.
    -- @return {Vector} This for chaining.

    function Vector.prototype:add(other)
      self.x = self.x + other.x
      self.y = self.y + other.y
      return self
    end


    -- Subtract another vector from this one.

    -- @param {Vector} other The other Vector.
    -- @return {Vector} This for chaiing.

    function Vector.prototype:sub(other)
      self.x = self.x - other.x
      self.y = self.y - other.y
      return self
    end


    -- Scale this vector. An independant scaling factor can be provided
    -- for each axis, or a single scaling factor that will scale both `x` and `y`.

    -- @param {number} x The scaling factor in the x direction.
    -- @param {?number=} y The scaling factor in the y direction.  If this
    --   is not specified, the x scaling factor will be used.
    -- @return {Vector} This for chaining.

    function Vector.prototype:scale(x, y)
      self.x = self.x * x
      self.y = self.y * y or x
      return self
    end


    -- Project this vector on to another vector.
    -- @param {Vector} other The vector to project onto.
    -- @return {Vector} This for chaining.

    function Vector.prototype:project(other)
      local amt = self:dot(other) / self:len2(other)
      self.x = amt * other.x
      self.y = amt * other.y
      return self
    end


    -- Project this vector onto a vector of unit length. This is slightly more efficient
    -- than `project` when dealing with unit vectors.

    -- @param {Vector} other The unit vector to project onto.
    -- @return {Vector} This for chaining.

    function Vector.prototype:projectN(other)
      local amt = self:dot(other)
      self.x = amt * other.x
      self.y = amt * other.y
      return self
    end


    -- Reflect this vector on an arbitrary axis.

    -- @param {Vector} axis The vector representing the axis.
    -- @return {Vector} This for chaining.

    function Vector.prototype:reflect(axis)
      local x = self.x
      local y = self.y
      self:project(axis):scale(2,2)
      self.x = self.x - x
      self.y = self.y - y
      return self
    end


    -- Reflect this vector on an arbitrary axis (represented by a unit vector). This is
    -- slightly more efficient than `reflect` when dealing with an axis that is a unit vector.

    -- @param {Vector} axis The unit vector representing the axis.
    -- @return {Vector} This for chaining.

    function Vector.prototype:reflectN(axis)
      local x = self.x
      local y = self.y
      self:projectN(axis):scale(2,2)
      self.x = self.x - x
      self.y = self.y - y
      return self
    end


    -- Get the dot product of this vector and another.

    -- @param {Vector}  other The vector to dot this one against.
    -- @return {number} The dot product.

    function Vector.prototype:dot(other)
      return self.x * other.x + self.y * other.y
    end


    -- Get the squared length of this vector.

    -- @return {number} The length^2 of this vector.

    function Vector.prototype:len2()
      return self:dot(self)
    end


    -- Get the length of this vector.

    -- @return {number} The length of this vector.

    function Vector.prototype:len()
      return math.sqrt(self:len2())
    end


  SAT.Vector = function(x,y)
    return Vector:new(x,y)
  end


  --[[

    ## Circle

    Represents a circle with a position and a radius.

    Create a new circle, optionally passing in a position and/or radius. If no position
    is given, the circle will be at `(0,0)`. If no radius is provided, the circle will
    have a radius of `0`.

    @param {Vector=} pos A vector representing the position of the center of the circle
    @param {?number=} r The radius of the circle
    @constructor
  --]]
  local Circle = {}
  Circle.prototype = {}
  Circle.metatable = {__index = Circle.prototype}

  function Circle:new(pos, r)
    local c = {}
    setmetatable(c, Circle.metatable)
    c.pos = pos or Vector:new()
    c.r = r or 0
    return c
  end


  SAT.Circle = function(pos, r)
    return Circle:new(pos, r)
  end



  --[[
    ## Polygon

    Represents a *convex* polygon with any number of points (specified in counter-clockwise order)

    Note: If you manually change the `points`, `angle`, or `offset` properties, you **must** call `recalc`
    afterwards so that the changes get applied correctly.

    Create a new polygon, passing in a position vector, and an array of points (represented
    by vectors relative to the position vector). If no position is passed in, the position
    of the polygon will be `(0,0)`.

    @param {Vector=} pos A vector representing the origin of the polygon. (all other
      points are relative to this one)
    @param {Array.<Vector>=} points An array of vectors representing the points in the polygon,
      in counter-clockwise order.
    @constructor
  --]]

  local Polygon = {}
  Polygon.prototype = {}
  Polygon.metatable = {__index = Polygon.prototype}


  function Polygon:new(pos, points)
    local p = {}
    setmetatable(p, Polygon.metatable)
    p.pos = pos or Vector:new()
    p.points = points or {}
    p.angle = 0
    p.offset = Vector:new()
    p:recalc()
    return p
  end
    --[[
      Set the points of the polygon.
      Note: This calls `recalc` for you.
      @param {Array.<Vector>=} points An array of vectors representing the points in the polygon,
        in counter-clockwise order.
      @return {Polygon} This for chaining.
    --]]

    function Polygon.prototype:setPoints(points)
      self.points = points
      self:recalc()
      return self
    end

    --[[
      Set the current rotation angle of the polygon.

      Note: This calls `recalc` for you.

      @param {number} angle The current rotation angle (in radians).
      @return {Polygon} This for chaining.
    --]]

    function Polygon.prototype:setAngle(angle)
      self.angle = angle
      self:recalc()
      return self
    end


    -- Set the current offset to apply to the `points` before applying the `angle` rotation.

    -- Note: This calls `recalc` for you.
    -- @param {Vector} offset The new offset vector.

    -- @return {Polygon} This for chaining.

    function Polygon.prototype:setOffset(offset)
      self.offset = offset
      self:recalc()
      return self
    end


    -- Rotates this polygon counter-clockwise around the origin of *its local coordinate system* (i.e. `pos`).

    -- Note: This changes the **original** points (so any `angle` will be applied on top of this rotation)
    -- Note: This calls `recalc` for you.

    -- @param {number} angle The angle to rotate (in radians)
    -- @return {Polygon} This for chaining.

    function Polygon.prototype:rotate(angle)
      local points = self.points
      local len = #points
      for i=1,len do
        points[i]:rotate(angle)
      end
      self:recalc()
      return self
    end


    --[[
      Translates the points of this polygon by a specified amount relative to the origin of *its own coordinate
      system* (i.e. `pos`).

      This is most useful to change the "center point" of a polygon. If you just want to move the whole polygon, change
      the coordinates of `pos`.

      Note: This changes the **original** points (so any `offset` will be applied on top of this translation)
      Note: This calls `recalc` for you.

      @param {number} x The horizontal amount to translate.
      @param {number} y The vertical amount to translate.
      @return {Polygon} This for chaining.
    --]]

    function Polygon.prototype:translate(x, y)
      local points = self.points
      local len = #points
      for i=1,len do
        points[i].x = points[i].x + x
        points[i].y = points[i].y + y
      end
      self:recalc()
      return self
    end


    -- Computes the calculated collision polygon. Applies the `angle` and `offset` to the original points then recalculates the
    -- edges and normals of the collision polygon.

    -- This **must** be called if the `points` array, `angle`, or `offset` is modified manualy.

    -- @return {Polygon} This for chaining.

    function Polygon.prototype:recalc() --self:recalc()
      --local i
     -- Calculated points - this is what is used for underlying collisions and takes into account
     -- the angle/offset set on the polygon.
      self.calcPoints = {}
      local calcPoints = self.calcPoints
    -- The edges here are the direction of the `n`th edge of the polygon, relative to
    -- the `n`th point. If you want to draw a given edge from the edge value, you must
    -- first translate to the position of the starting point.
      self.edges = {}
      local edges = self.edges
    -- The normals here are the direction of the normal for the `n`th edge of the polygon, relative
    -- to the position of the `n`th point. If you want to draw an edge normal, you must first
    -- translate to the position of the starting point.
      self.normals = {}
      local normals = self.normals
    -- Copy the original points array and apply the offset/angle
      local points = self.points
      local offset = self.offset
      local angle = self.angle
      local len = #points
      for i=1,len do
        local calcPoint = points[i]:clone()
        calcPoints[i] = calcPoint
        calcPoint.x = calcPoint.x + offset.x
        calcPoint.y = calcPoint.y + offset.y
        if angle ~= 0 then
            calcPoint:rotate(angle)
        end
      end
    --Calculate the edges/normals
      for i=1, len do
        local p1 = calcPoints[i]
        local p2 = i < len and calcPoints[i + 1] or calcPoints[1]
        local e = Vector:new():copy(p2):sub(p1)
        local n = Vector:new():copy(e):perp():normalize()
        edges[i] = e
        normals[i] = n
      end
      return self
    end

  SAT.Polygon = function(pos, points)
    return Polygon:new(pos, points)
  end

  --[[
    ## Box

    Represents an axis-aligned box, with a width and height.


    Create a new box, with the specified position, width, and height. If no position
    is given, the position will be `(0,0)`. If no width or height are given, they will
    be set to `0`.

    @param {Vector=} pos A vector representing the top-left of the box.
    @param {?number=} w The width of the box.
    @param {?number=} h The height of the box.
    @constructor
  --]]

  local Box = {}
  Box.prototype = {}
  Box.metatable = {__index = Box.prototype}


  function Box:new(pos, w, h)
    local b = {}
    setmetatable(b, Box.metatable)
    b.pos = pos or Vector:new()
    b.w = w or 0
    b.h = h or 0
    return b
  end
    ----------METODS-----------

    -- Returns a polygon whose edges are the same as this box.

    -- @return {Polygon} A new Polygon that represents this box.

    function Box.prototype:toPolygon()
      local pos = self.pos
      local w = self.w
      local h = self.h

      return Polygon:new( Vector:new(pos.x, pos.y), {
        Vector:new(),
        Vector:new(w, 0),
        Vector:new(w, h),
        Vector:new(0, h)
        })
    end

    ----------------------------
  SAT.Box = function(pos, w, h)
    return Box:new(pos, w, h)
  end

  -- ## Response
  -- An object representing the result of an intersection. Contains:
  --  - The two objects participating in the intersection
  --  - The vector representing the minimum change necessary to extract the first object
  --    from the second one (as well as a unit vector in that direction and the magnitude
  --    of the overlap)
  --  - Whether the first object is entirely inside the second, and vice versa.

  -- @constructor

  --local Response = {}

  local Response = {}
  Response.prototype = {}
  Response.metatable = {__index = Response.prototype}

  function Response:new()
    local r = {}
    setmetatable(r, Response.metatable)
    r.a = nil
    r.b = nil
    r.overlapN = Vector:new()
    r.overlapV = Vector:new()
    r.ppos = {}
    r:clear()
    return r
  end
    -- Set some values of the response back to their defaults.  Call this between tests if
    -- you are going to reuse a single Response object for multiple intersection tests (recommented
    -- as it will avoid allcating extra memory)

    -- @return {Response} This for chaining

    function Response.prototype:clear()
      self.aInB = true
      self.bInA = true
      self.overlap = math.huge
      return self
    end


  SAT.Response = function()
    return Response:new()
  end

  -- ## Object Pools

  -- A pool of `Vector` objects that are used in calculations to avoid
  -- allocating memory.

  -- @type {Array.<Vector>}

  local T_VECTORS = {}
  --for i=1,10 do table.insert( T_VECTORS, Vector:new()) end
  for i=1,10 do T_VECTORS[i] = Vector:new() end


  -- A pool of arrays of numbers used in calculations to avoid allocating
  -- memory.

  -- @type {Array.<Array.<number>>}

  local T_ARRAYS = {}
  --for i=1,5 do table.insert(T_ARRAYS, {}) end
  for i=1,5 do T_ARRAYS[i] = {} end


  -- Temporary response used for polygon hit detection.

  -- @type {Response}

  local T_RESPONSE = Response:new()

  -- Unit square polygon used for polygon hit detection.

  -- @type {Polygon}

  local UNIT_SQUARE = Box:new(Vector:new(), 1, 1):toPolygon()


  -- ## Helper Functions

  -- Flattens the specified array of points onto a unit vector axis,
  -- resulting in a one dimensional range of the minimum and
  -- maximum value on that axis.

  -- @param {Array.<Vector>} points The points to flatten.
  -- @param {Vector} normal The unit vector axis to flatten on.
  -- @param {Array.<number>} result An array.  After calling this function,
  --   result[0] will be the minimum value,
  --   result[1] will be the maximum value.

  function flattenPointsOn(points, normal, result)
    local min = math.huge
    local max = -math.huge
    local len = #points
    for i=1,len do
      -- The magnitude of the projection of the point onto the normal
      local dot = points[i]:dot(normal)
      if dot < min then
        min = dot
      end
      if dot > max then
        max = dot
      end
    end
    result[1] = min; result[2] = max

  end



  -- Check whether two convex polygons are separated by the specified
  -- axis (must be a unit vector).
  --[[
    @param {Vector} aPos The position of the first polygon.
    @param {Vector} bPos The position of the second polygon.
    @param {Array.<Vector>} aPoints The points in the first polygon.
    @param {Array.<Vector>} bPoints The points in the second polygon.
    @param {Vector} axis The axis (unit sized) to test against.  The points of both pol
      will be projected onto this axis.
    @param {Response=} response A Response object (optional) which will be populated
      if the axis is not a separating axis.
    @return {boolean} true if it is a separating axis, false otherwise.  If false,
      and a response is passed in, information about how much overlap and
      the direction of the overlap will be populated.
  --]]

  function isSeparatingAxis(aPos, bPos, aPoints, bPoints, axis, response)
    local rangeA = table_remove(T_ARRAYS)
    local rangeB = table_remove(T_ARRAYS)
    -- The magnitude of the offset between the two polygons
    local offsetV = table_remove(T_VECTORS):copy(bPos):sub(aPos)
    local projectedOffset = offsetV:dot(axis)
    -- Project the polygons onto the axis.
    flattenPointsOn(aPoints, axis, rangeA)
    flattenPointsOn(bPoints, axis, rangeB)
    -- Move B's range to its position relative to A.
    rangeB[1] = rangeB[1] + projectedOffset
    rangeB[2] = rangeB[2] + projectedOffset
    -- Check if there is a gap. If there is, this is a separating axis and we can stop
    if rangeA[1] > rangeB[2] or rangeB[1] > rangeA[2] then
      T_VECTORS[#T_VECTORS+1] = offsetV
      T_ARRAYS[#T_ARRAYS+1] = rangeA
      T_ARRAYS[#T_ARRAYS+1] = rangeB
      return true
    end
    --This is not a separating axis. If we're calculating a response, calculate the overlap.
    if response then
      local overlap = 0
      -- A starts further left than B
      if rangeA[1] < rangeB[1] then
        response.aInB = false
        -- A ends before B does. We have to pull A out of B
        if rangeA[2] < rangeB[2] then
          overlap = rangeA[2] - rangeB[1]
          response.bInA = false
          -- B is fully inside A.  Pick the shortest way out.
        else
          local option1 = rangeA[2] - rangeB[1]
          local option2 = rangeB[2] - rangeA[1]
          overlap = option1 < option2 and option1 or -option2
        end
      -- B starts further left than A
      else
        response.bInA = false
        -- B ends before A ends. We have to push A out of B
        if rangeA[2] > rangeB[2] then
          overlap = rangeA[1] - rangeB[2]
          response.aInB = false
          -- A is fully inside B.  Pick the shortest way out.
        else
          local option1 = rangeA[2] - rangeB[1]
          local option2 = rangeB[2] - rangeA[1]
          overlap = option1 < option2 and option1 or -option2
        end
      end
      local absOverlap = math.abs(overlap)
      if absOverlap < response.overlap then
        response.overlap = absOverlap
        response.overlapN:copy(axis)
        if overlap < 0 then
          response.overlapN:reverse()
        end
      end
    end
      T_VECTORS[#T_VECTORS+1] = offsetV
      T_ARRAYS[#T_ARRAYS+1] = rangeA
      T_ARRAYS[#T_ARRAYS+1] = rangeB
-----------------------------for jp -----------------------

------------------------------------------------------------
    return false
  end

  -- Constants for Vornoi regions

  -- @const

  local LEFT_VORNOI_REGION = -1

  -- @const

  local MIDDLE_VORNOI_REGION = 0

  -- @const

  local RIGHT_VORNOI_REGION = 1


    -- Calculates which Vornoi region a point is on a line segment.
    -- It is assumed that both the line and the point are relative to `(0,0)`

    --            |       (0)      |
    --     (-1)  [S]--------------[E]  (1)
    --            |       (0)      |

  --[[
    @param {Vector} line The line segment.
    @param {Vector} point The point.
    @return  {number} LEFT_VORNOI_REGION (-1) if it is the left region,
             MIDDLE_VORNOI_REGION (0) if it is the middle region,
             RIGHT_VORNOI_REGION (1) if it is the right region.

  --]]

  function vornoiRegion(line, point)
    local len2 = line:len2()
    local dp = point:dot(line)
    -- If the point is beyond the start of the line, it is in the
    -- left vornoi region.
    if dp < 0 then return LEFT_VORNOI_REGION
    -- If the point is beyond the end of the line, it is in the
    -- right vornoi region.
    elseif dp > len2 then return RIGHT_VORNOI_REGION
    -- Otherwise, it's in the middle one.
    else return MIDDLE_VORNOI_REGION end
  end


  -- ## Collision Tests

  -- Check if a point is inside a circle.

  -- @param {Vector} p The point to test.
  -- @param {Circle} c The circle to test.
  -- @return {boolean} true if the point is inside the circle, false if it is not.


  function pointInCircle(p, c)
    local differenceV = table_remove(T_VECTORS):copy(p):sub(c.pos)
    local radiusSq = c.r * c.r
    local distanceSq = differenceV:len2()
    table_insert(T_VECTORS, differenceV)
    -- If the distance between is smaller than the radius then the point is inside the circle.
    return distanceSq <= radiusSq
  end

  SAT.pointInCircle = function(p, c)
    return pointInCircle(p, c)
  end


  -- Check if a point is inside a convex polygon.

  -- @param {Vector} p The point to test.
  -- @param {Polygon} poly The polygon to test.
  -- @return {boolean} true if the point is inside the polygon, false if it is not.

  function pointInPolygon(p, poly)
    UNIT_SQUARE.pos:copy(p)
    T_RESPONSE:clear()
    local result = testPolygonPolygon(UNIT_SQUARE, poly, T_RESPONSE)
    if result then
      result = T_RESPONSE.aInB
    end
    return result
  end

  SAT.pointInPolygon = function(p, poly)
    return pointInPolygon(p, poly)
  end

  -- Check if two circles collide.

  -- @param {Circle} a The first circle.
  -- @param {Circle} b The second circle.
  -- @param {Response=} response Response object (optional) that will be populated if
  --   the circles intersect.
  -- @return {boolean} true if the circles intersect, false if they don't.

  function testCircleCircle(a, b, response)
    local differenceV = table_remove(T_VECTORS):copy(b.pos):sub(a.pos)
    local totalRadius = a.r + b.r
    local totalRadiusSq = totalRadius * totalRadius
    local distanceSq = differenceV:len2()
    -- If the distance is bigger than the combined radius, they don't intersect.
    if distanceSq > totalRadiusSq then
      table_insert(T_VECTORS, differenceV)
      return false
    end
    -- They intersect.  If we're calculating a response, calculate the overlap.
    if response then
      local dist = math.sqrt(distanceSq)
      response.a = a
      response.b = b
      response.overlap = totalRadius - dist
      response.overlapN:copy(differenceV:normalize())
      response.overlapV:copy(differenceV):scale(response.overlap,response.overlap)
      response.aInB = (a.r <= b.r and dist <= b.r - a.r)
      response.bInA = (b.r <= a.r and dist <= a.r - b.r)
    end
    table_insert(T_VECTORS, differenceV)
    return true
  end

  SAT.testCircleCircle = function(a, b, response)
    return testCircleCircle(a, b, response)
  end

  -- Check if a polygon and a circle collide.

  -- @param {Polygon} polygon The polygon.
  -- @param {Circle} circle The circle.
  -- @param {Response=} response Response object (optional) that will be populated if
  --   they interset.
  -- @return {boolean} true if they intersect, false if they don't.

  function testPolygonCircle(polygon, circle, response)
    -- Get the position of the circle relative to the polygon.
    local circlePos = table_remove(T_VECTORS):copy(circle.pos):sub(polygon.pos)
    local radius = circle.r
    local radius2 = radius * radius
    local points = polygon.calcPoints
    local len = #points
    local edge = table_remove(T_VECTORS)
    local point = table_remove(T_VECTORS)

    -- For each edge in the polygon:
    for i=1,len do
      local next = i == len and 0 or i + 1
      local prev = i == 0 and len or i - 1
      local overlap = 0
      local overlapN = nil
      -- Get the edge.
      edge:copy(polygon.edges[i])
      -- Calculate the center of the circle relative to the starting point of the edge.
      point:copy(circlePos):sub(points[i])

      -- If the distance between the center of the circle and the point
      -- is bigger than the radius, the polygon is definitely not fully in
      -- the circle.
      if response and point:len2() > radius2 then
          response.aInB = false
      end
      -- Calculate which Vornoi region the center of the circle is in.
      local region = vornoiRegion(edge, point)
      -- If it's the left region:
      if region == LEFT_VORNOI_REGION then
        -- We need to make sure we're in the RIGHT_VORNOI_REGION of the previous edge.
        edge.copy(polygon.edges[prev])
        -- Calculate the center of the circle relative the starting point of the previous edge
        local point2 = table_remove(T_VECTORS):copy(circlePos):sub(points[prev])
        region = vornoiRegion(edge, point2)
        if region == RIGHT_VORNOI_REGION then
          -- It's in the region we want.  Check if the circle intersects the point.
          local dist = point:len()
          if dist > radius then
            -- No intersection
            T_VECTORS[#T_VECTORS+1] = circlePos
            T_VECTORS[#T_VECTORS+1] = edge
            T_VECTORS[#T_VECTORS+1] = point
            T_VECTORS[#T_VECTORS+1] = point2
            return false
          elseif response then
            -- It intersects, calculate the overlap.
            response.bInA = false
            overlapN = point:normalize()
            overlap = radius - dist
          end
        end
        T_VECTORS[#T_VECTORS+1] = point2        --table.insert(T_VECTORS, point2)
      -- If it's the right region:
      elseif region == RIGHT_VORNOI_REGION then
        -- We need to make sure we're in the left region on the next edge
        edge:copy(polygon.edges[next])
        -- Calculate the center of the circle relative to the starting point of the next edge.
        point:copy(circlePos):sub(points[next])
        region = vornoiRegion(edge, point)
        if region == LEFT_VORNOI_REGION then
          -- It's in the region we want.  Check if the circle intersects the point.
          local dist = point:len()
          if dist > radius then
            -- No intersection
            T_VECTORS[#T_VECTORS+1] = circlePos
            T_VECTORS[#T_VECTORS+1] = edge
            T_VECTORS[#T_VECTORS+1] = point
            return false
          elseif response then
            -- It intersects, calculate the overlap.
            response.bInA = false
            overlapN = point:normalize()
            overlap = radius - dist
          end
        end
      -- Otherwise, it's the middle region:
      else
        -- Need to check if the circle is intersecting the edge,
        -- Change the edge into its "edge normal".
        local normal = edge:perp():normalize()
        -- Find the perpendicular distance between the center of the
        -- circle and the edge.
        local dist = point:dot(normal)
        local distAbs = math.abs(dist)
        -- If the circle is on the outside of the edge, there is no intersection.
        if dist > 0 and distAbs > radius then
          -- No intersection
          T_VECTORS[#T_VECTORS+1] = circlePos
          T_VECTORS[#T_VECTORS+1] = normal
          T_VECTORS[#T_VECTORS+1] = point
          return false
        elseif response then
          -- It intersects, calculate the overlap.
          overlapN = normal
          overlap = radius - dist
          -- If the center of the circle is on the outside of the edge, or part of the
          -- circle is on the outside, the circle is not fully inside the polygon.
          if dist >= 0 or overlap < 2 * radius then
            response.bInA = false
          end
        end
      end
      --  If this is the smallest overlap we've seen, keep it.
      -- (overlapN may be null if the circle was in the wrong Vornoi region).
      if overlapN and response and math.abs(overlap) < math.abs(response.overlap) then
        response.overlap = overlap
        response.overlapN:copy(overlapN)
      end
    end -- end loop

    -- Calculate the final overlap vector - based on the smallest overlap.
    if response then
        response.a = polygon
        response.b = circle
        response.overlapV:copy(response.overlapN):scale(response.overlap, response.overlap)
    end
    T_VECTORS[#T_VECTORS+1] = circlePos
    T_VECTORS[#T_VECTORS+1] = edge
    T_VECTORS[#T_VECTORS+1] = point
    return true
  end

  SAT.testPolygonCircle = function(polygon, circle, response)
    return testPolygonCircle(polygon, circle, response)
  end

  -- Check if a circle and a polygon collide.

  -- **NOTE:** This is slightly less efficient than polygonCircle as it just
  -- runs polygonCircle and reverses everything at the end.

  -- @param {Circle} circle The circle.
  -- @param {Polygon} polygon The polygon.
  -- @param {Response=} response Response object (optional) that will be populated if
  --   they interset.
  -- @return {boolean} true if they intersect, false if they don't.
  function testCirclePolygon(circle, polygon, response)
    -- Test the polygon against the circle.
    local result = testPolygonCircle(polygon, circle, response)
    if result and response then
        -- Swap A and B in the response.
        local a = response.a
        local aInB = response.aInB
        response.overlapN:reverse()
        response.overlapV:reverse()
        response.a = response.b
        response.b = a
        response.aInB = response.bInA
        response.bInA = aInB
    end
    return result
  end

  SAT.testCirclePolygon = function(circle, polygon, response)
    return testCirclePolygon(circle, polygon, response)
  end



  -- Checks whether polygons collide.

  -- @param {Polygon} a The first polygon.
  -- @param {Polygon} b The second polygon.
  -- @param {Response=} response Response object (optional) that will be populated if
  --   they interset.
  -- @return {boolean} true if they intersect, false if they don't.

  function testPolygonPolygon(a, b, response)
    local aPoints = a.calcPoints
    local aLen = #aPoints
    local bPoints = b.calcPoints
    local bLen = #bPoints

    -- If any of the edge normals of A is a separating axis, no intersection.
    for i=1, aLen do
      if isSeparatingAxis(a.pos, b.pos, aPoints, bPoints, a.normals[i], response) then
        return false
      end
    end
    -- If any of the edge normals of B is a separating axis, no intersection.
    for i=1, bLen do
      if isSeparatingAxis(a.pos, b.pos, aPoints, bPoints, b.normals[i], response) then
        return false
      end
    end
    -- Since none of the edge normals of A or B are a separating axis, there is an intersection
    -- and we've already calculated the smallest overlap (in isSeparatingAxis).  Calculate the
    -- final overlap vector.
    if response then
      response.a = a
      response.b = b
      response.overlapV:copy(response.overlapN):scale(response.overlap, response.overlap)
    end
    return true
  end

  SAT.testPolygonPolygon = function(a, b, response)
    return testPolygonPolygon(a, b, response)
  end



return SAT