-- LanternVape V3 - Public entrypoint
-- main.lua is the GUI; the runtime loads modules independently.
local BASE="https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/"
local function load(path)
 local s=game:HttpGet(BASE..path,true)
 local f,e=loadstring(s,"LanternVape/"..path)
 if not f then error(e) end
 return f
end
local result=load("main.lua")(...)
task.defer(function()
 local ok,e=pcall(function() load("modules/BlatantRuntimeV2.lua")() end)
 if not ok then warn("[LanternVape] Module runtime failed: "..tostring(e)) end
end)
return result
