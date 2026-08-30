-- LanternVape V3 - Public entrypoint
-- main.lua is the GUI. This entrypoint loads the GUI first, then the dynamic module runtime.

local BASE = "https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/"

local function loadSource(path)
    local source = game:HttpGet(BASE .. path, true)
    local chunk, err = loadstring(source, "LanternVape/" .. path)

    if not chunk then
        error("[LanternVape] Failed to compile " .. path .. ": " .. tostring(err))
    end

    return chunk
end

local mainChunk = loadSource("main.lua")
local result = mainChunk(...)

task.defer(function()
    local player = game:GetService("Players").LocalPlayer
    if not player then return end

    local playerGui = player:WaitForChild("PlayerGui", 10)
    if not playerGui then return end

    -- Wait until main.lua has created the GUI before attaching modules.
    local gui = playerGui:WaitForChild("LanternVape", 10)
    if not gui then return end

    local runtimeChunk
    local ok, err = pcall(function()
        runtimeChunk = loadSource("modules/BlatantRuntime.lua")
    end)

    if not ok or not runtimeChunk then
        warn("[LanternVape] Module runtime failed to load: " .. tostring(err))
        return
    end

    local runtimeOk, runtimeErr = pcall(runtimeChunk)
    if not runtimeOk then
        warn("[LanternVape] Module runtime failed: " .. tostring(runtimeErr))
    end
end)

return result
