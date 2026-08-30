-- LanternVape V3 - dynamic module loader
-- Modules live in /modules and can be added without editing main.lua or core.lua.

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
if not Player then return end

local ROOT = "https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/"
local API = "https://api.github.com/repos/scriptedlantern/lanternvape-v3/contents/modules"

local PlayerGui = Player:WaitForChild("PlayerGui", 10)
local Gui = PlayerGui and PlayerGui:WaitForChild("LanternVape", 10)
local Main = Gui and Gui:WaitForChild("Main", 10)
local Content = Main and Main:WaitForChild("Categories", 10)
if not Content then return end

local Categories = {
    Combat = true,
    Blatant = true,
    External = true,
    Rendering = true,
    Extra = true,
}

local function request(url)
    local ok, result = pcall(function()
        return game:HttpGet(url, true)
    end)
    if ok and type(result) == "string" then
        return result
    end
end

local function getJson(url)
    local raw = request(url)
    if not raw then return nil end
    local ok, data = pcall(function()
        return HttpService:JSONDecode(raw)
    end)
    return ok and data or nil
end

local function loadModule(path, category)
    local source = request(ROOT .. path)
    if not source then
        warn("[LanternVape] Failed to download module: " .. path)
        return
    end

    local compileOk, module = pcall(function()
        local fn, err = loadstring(source)
        if not fn then error(err) end
        return fn()
    end)

    if not compileOk then
        warn("[LanternVape] Failed to compile module " .. path .. ": " .. tostring(module))
        return
    end

    if type(module) ~= "function" then
        warn("[LanternVape] Module must return a function: " .. path)
        return
    end

    local panel = Content:FindFirstChild(category)
    if not panel then
        warn("[LanternVape] Category panel not found: " .. category)
        return
    end

    local modulesContainer = panel:FindFirstChild("Modules")
    if not modulesContainer then
        warn("[LanternVape] Modules container not found: " .. category)
        return
    end

    local context = {
        Player = Player,
        PlayerGui = PlayerGui,
        Gui = Gui,
        Main = Main,
        Content = Content,
        Panel = panel,
        Modules = modulesContainer,
        Services = {
            Players = Players,
            HttpService = HttpService,
            RunService = game:GetService("RunService"),
            UserInputService = game:GetService("UserInputService"),
            TweenService = game:GetService("TweenService"),
            Lighting = game:GetService("Lighting"),
        },
    }

    local runOk, err = pcall(module, context)
    if not runOk then
        warn("[LanternVape] Module error " .. path .. ": " .. tostring(err))
    end
end

local function loadCategory(category)
    local entries = getJson(API .. "/" .. category)
    if type(entries) ~= "table" then return end

    for _, entry in ipairs(entries) do
        if entry.type == "file" and entry.name:sub(-4) == ".lua" then
            loadModule("modules/" .. category .. "/" .. entry.name, category)
        end
    end
end

for category in pairs(Categories) do
    loadCategory(category)
end

print("[LanternVape] Dynamic modules loaded")