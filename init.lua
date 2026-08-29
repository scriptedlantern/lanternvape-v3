-- LanternVape v3 loader
-- v2.14: load the current main build, then attach the Blatant runtime modules.
local source = game:HttpGet("https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/main.lua", true)
local chunk, err = loadstring(source, "LanternVape/main.lua")
if not chunk then
    error("[LanternVape] Failed to load current build: " .. tostring(err))
end

local result = chunk(...)

task.defer(function()
    task.wait(0.15)
    local ok, runtimeSource = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/modules/BlatantRuntime.lua", true)
    end)

    if ok and type(runtimeSource) == "string" then
        local runtimeChunk, runtimeErr = loadstring(runtimeSource, "LanternVape/BlatantRuntime.lua")
        if runtimeChunk then
            pcall(runtimeChunk)
        else
            warn("[LanternVape] Blatant runtime failed: " .. tostring(runtimeErr))
        end
    end
end)

return result
