local Code = {
    vals = {}
}

local ALLOWED_CHARS = {
    '2', 'U', '!', 'Z', ')', 'o', 'j', 'n', 'a', 'm', '7', 'z', 'q', '(',
    '#', 'p', 'y', 'C', '&', 'd', 'J', 'H', 'X', 'A', 'G', 'u', '9',
    'k', '<', 's', 'f', '^', 'D', 'Q', 'i', '4', '6', 'h', 'R', 'B', '%',
    '>', 'P', 'K', 'L', '5', '=', '-', 'M', 'S', 'F', 'Y', 'N', 'g', 'c',
    't', 'x', 'W', '*', 'e', 'V', 'b', '3', 'r', '8', 'T', '$', 'w', 'v', 'E',
    '@', '-', '[', ']', '?'
};
local REVERSE_LOOKUP = {
    ['2'] = 00, ['U'] = 01, ['!'] = 02, ['Z'] = 03, [')'] = 04, ['o'] = 05,
    ['j'] = 06, ['n'] = 07, ['a'] = 08, ['m'] = 09, ['7'] = 10, ['z'] = 11,
    ['q'] = 12, ['('] = 13, ['#'] = 14, ['p'] = 15, ['y'] = 16, ['C']= 17,
    ['&'] = 18, ['d'] = 19, ['J'] = 20, ['H'] = 21, ['X'] = 22, ['A'] = 23,
    ['G'] = 24, ['u'] = 25, ['9'] = 26, ['k'] = 27, ['<'] = 28, ['s'] = 29,
    ['f'] = 30, ['^'] = 31, ['D'] = 32, ['Q'] = 33, ['i'] = 34, ['4'] = 35,
    ['6'] = 36, ['h'] = 37, ['R'] = 38, ['B'] = 39, ['%'] = 40, ['>'] = 41,
    ['P'] = 42, ['K'] = 43, ['L'] = 44, ['5'] = 45, ['='] = 46, ['-'] = 47,
    ['M'] = 48, ['S'] = 49, ['F'] = 50, ['Y'] = 51, ['N'] = 52, ['g'] = 53,
    ['c'] = 54, ['t'] = 55, ['x'] = 56, ['W'] = 57, ['*'] = 58, ['e'] = 59,
    ['V'] = 60, ['b'] = 61, ['3'] = 62, ['r'] = 63, ['8'] = 64, ['T'] = 65,
    ['$'] = 66, ['w'] = 67, ['v'] = 68, ['E'] = 69, ['@'] = 70, ['-'] = 71,
    ['['] = 72, [']'] = 73, ['?'] = 74
}
local NUM_CHARS = #ALLOWED_CHARS

local CHECKSUM_MAX = 72^3

function Code:new()
    local o = {
        vals = {},
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

function Code:fromStr(codeStr)
    print("Decoding from string ", codeStr)

    local o = {
        codeStr = codeStr,
        numDecoded = 0,
        sum = 0,
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

function Code:getInt(max)
    -- Grabs x digits from the start of the code based on the max size
    -- Mutates the remaining code
    local numDigits = math.floor(math.log(max) / math.log(NUM_CHARS) + 1)
    local strToDecode = string.sub(self.codeStr, 0, numDigits)

    local res = 0
    for i=0,numDigits-1,1 do
        -- First digit value is:
        local val = (REVERSE_LOOKUP[string.sub(strToDecode, i+1, i+1)] - self.numDecoded) % NUM_CHARS
        print('val was ', val, 'for digit idx', i, string.sub(strToDecode, i+1, i+1))
        print('that adds ', val * NUM_CHARS ^ (numDigits - i - 1))
        res = res + val * NUM_CHARS ^ (numDigits - i - 1)
    end
    res = math.floor(res)

    self.numDecoded = self.numDecoded + 1
    self.codeStr = string.sub(self.codeStr, numDigits+1)
    self.sum = self.sum + res

    return res
end

function Code:verify()
    local expectedChecksum = self.sum
    local actualChecksum = self:getInt(CHECKSUM_MAX)
    return expectedChecksum == actualChecksum
end

function Code:addInt(num, max)
    table.insert(self.vals, {num = num, max = max})
    return self
end

function Code:build()
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
        local numDigits = math.floor(math.log(max) / math.log(NUM_CHARS) + 1)
        for i=numDigits-1,0,-1 do
            local divisor = math.floor(num / NUM_CHARS^i)
            num = num - NUM_CHARS^i * divisor
            code = code .. ALLOWED_CHARS[((divisor + idx - 1) % NUM_CHARS) + 1]
        end
    end

    return code
end

return Code
