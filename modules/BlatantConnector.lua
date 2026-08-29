-- LanternVape V3 - Blatant GUI connector
-- Connects the Blatant module definitions to a supplied GUI module factory.

local Connector = {}

local MODULE_PATH = "modules/Blatant/"
local MODULES = {
    Speed = "Speed.lua",
    Spider = "Spider.lua",
    Phase = "Phase.lua",
    Antifall = "Antifall.lua",
    Fly = "Fly.lua",
    HighJump = "HighJump.lua",
    ["Infinite Jump"] = "InfiniteJump.lua",
}

function Connector.GetModulePath(name)
    return MODULE_PATH .. (MODULES[name] or "")
end

function Connector.GetModuleNames()
    local names = {}
    for name in pairs(MODULES) do
        names[#names + 1] = name
    end
    table.sort(names)
    return names
end

function Connector.Attach(makeModule, loader)
    assert(type(makeModule) == "function", "BlatantConnector.Attach requires makeModule")
    assert(type(loader) == "function", "BlatantConnector.Attach requires loader")

    local handles = {}
    for _, name in ipairs(Connector.GetModuleNames()) do
        local module = loader(Connector.GetModulePath(name))
        if module then
            handles[name] = makeModule(module)
        end
    end
    return handles
end

return Connector
