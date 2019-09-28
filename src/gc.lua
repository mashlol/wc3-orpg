local performGC = function()
    -- collectgarbage("collect")
    -- collectgarbage("stop")
end

local init = function()
    -- TimerStart(CreateTimer(), 30, true, performGC)
end

return {
    init = init,
}
