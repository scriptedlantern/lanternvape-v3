-- LanternVape v2.12 startup-safe loader
-- Fixes the malformed literal \n tail that was accidentally committed to the v2.11 source.

local SOURCE_URL = "https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/bc621427d037db3816cdacfa3d9fbb38f1ba4eb4/main.lua"

local ok, source = pcall(function()
    return game:HttpGet(SOURCE_URL)
end)

if not ok or type(source) ~= "string" or source == "" then
    warn("[LanternVape] Failed to load UI source.")
    return
end

local badTail = "\\n\\n-- LanternVape asset-backed UI update v2.12\\n"
local tailStart = source:find(badTail, 1, true)
if tailStart then
    source = source:sub(1, tailStart - 1)
end

local chunk, err = loadstring(source, "@LanternVape-v2.12")
if not chunk then
    warn("[LanternVape] Compile error: " .. tostring(err))
    return
end

local ran, runErr = pcall(chunk)
if not ran then
    warn("[LanternVape] Runtime error: " .. tostring(runErr))
end
