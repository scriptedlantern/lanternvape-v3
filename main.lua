-- LanternVape V3 bootstrap
-- Keeps the existing UI/core unchanged and only replaces the mobile toggle image.

local CORE_URL = "https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/core.lua"
local ICON_URL = "https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/assets/mobile_toggle.jpg"
local ICON_FILE = "LanternVape_mobile_toggle.jpg"

local ok, err = pcall(function()
    local source = game:HttpGet(CORE_URL, true)
    local fn = loadstring(source)
    if not fn then error("Failed to compile LanternVape core") end
    fn()
end)

if not ok then
    warn("[LanternVape] Core failed to load: " .. tostring(err))
    return
end

task.spawn(function()
    if not writefile or not getcustomasset then return end

    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    if not player then return end

    local playerGui = player:WaitForChild("PlayerGui", 10)
    if not playerGui then return end

    local gui = playerGui:WaitForChild("LanternVape", 10)
    if not gui then return end

    local mobile = gui:WaitForChild("MobileToggle", 10)
    if not mobile then return end

    local success, imageData = pcall(function()
        return game:HttpGet(ICON_URL, true)
    end)
    if not success or not imageData then return end

    local saved = pcall(function()
        writefile(ICON_FILE, imageData)
    end)
    if not saved then return end

    local assetSuccess, asset = pcall(function()
        return getcustomasset(ICON_FILE)
    end)
    if assetSuccess and asset then
        mobile.Image = asset
    end
end)