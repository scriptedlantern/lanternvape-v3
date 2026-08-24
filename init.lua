-- LanternVape v3 loader
-- This file intentionally loads the current main.lua so the loadstring never gets stuck on an older build.
local HttpService = game:GetService("HttpService")
local source = game:HttpGet("https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/main.lua", true)
local chunk, err = loadstring(source, "LanternVape/main.lua")
if not chunk then
    error("[LanternVape] Failed to load current build: " .. tostring(err))
end
return chunk(...)
