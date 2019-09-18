local Code = {
    vals = {}
}

local ALLOWED_CHARS = {
    '2', 'U', '!', '1', 'Z', ')', 'o', 'j', 'n', 'a', 'm', '7', 'z', 'q', '(',
    'I', '#', 'p', 'y', 'C', '&', 'd', '0', 'J', 'H', 'X', 'A', 'G', 'u', '9',
    'k', 'O', '<', 's', 'f', '^', 'D', 'Q', 'i', '4', '6', 'h', 'R', 'B', '%',
    '>', 'P', 'l', 'K', 'L', '5', '=', '-', 'M', 'S', 'F', 'Y', 'N', 'g', 'c',
    't', 'x', 'W', '*', 'e', 'V', 'b', '3', 'r', '8', 'T', '$', 'w', 'v', 'E',
    '@'
};

local CHECKSUM_MAX = 72^3

function Code:new()
    o = {
        vals = {},
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

function Code:addInt(num, max)
    table.insert(self.vals, {num = num, max = max})
    return self
end

function Code:build()
    local numChars = #ALLOWED_CHARS
    local code = ""

    local checksum = 0
    for idx, val in pairs(self.vals) do
        checksum = checksum + val.num
    end
    checksum = checksum % CHECKSUM_MAX

    self:addInt(checksum, CHECKSUM_MAX)

    for idx, val in pairs(self.vals) do
        local num = val.num
        local max = val.max

        -- Get the number of digits we need to store max
        local numDigits = math.floor(math.log(max) / math.log(numChars) + 1)
        for i=numDigits-1,0,-1 do
            local divisor = math.floor(num / numChars^i)
            num = num - numChars^i * divisor
            code = code .. ALLOWED_CHARS[((divisor + idx) % numChars) + 1]
        end
    end

    return code
end

return Code
