-- LanternVape v2.12 startup-safe wrapper
-- Keeps the existing v2.11 UI/features while preventing remote PNG downloads
-- from blocking startup. The previous build is pinned by commit SHA.

local SOURCE_URL = "https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/bc621427d037db3816cdacfa3d9fbb38f1ba4eb4/main.lua"

local ok, source = pcall(function()
    return game:HttpGet(SOURCE_URL)
end)

if not ok or type(source) ~= "string" or source == "" then
    warn("[LanternVape] Failed to load UI source.")
    return
end

-- The previous build synchronously downloaded two PNGs before creating the UI.
-- Replace those calls with nil so the UI can initialize immediately.
source = source:gsub(
    'local MobileIconAsset = LoadRemoteAsset%(%s*"https://raw%.githubusercontent%.com/scriptedlantern/lanternvape%-v3/main/assets/mobile_icon%.png",%s*"mobile_icon%.png"%s*%)%s*local LanternVapeTextAsset = LoadRemoteAsset%(%s*"https://raw%.githubusercontent%.com/scriptedlantern/lanternvape%-v3/main/assets/lanternvape_text%.png",%s*"lanternvape_text%.png"%s*%)',
    'local MobileIconAsset = nil\nlocal LanternVapeTextAsset = nil',
    1
)

-- Fetch the images after the existing UI has initialized.
local patch = [[

task.spawn(function()
    local getter = getcustomasset or getsynasset
    if type(getter) ~= "function" or type(writefile) ~= "function" then
        return
    end

    local function fetchAsset(url, fileName)
        local okData, data = pcall(function()
            return game:HttpGet(url)
        end)
        if not okData or type(data) ~= "string" or data == "" then
            return nil
        end

        pcall(function()
            if type(isfile) ~= "function" or not isfile(fileName) then
                writefile(fileName, data)
            end
        end)

        local okAsset, asset = pcall(function()
            return getter(fileName)
        end)
        return okAsset and asset or nil
    end

    local mobileAsset = fetchAsset(
        "https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/assets/mobile_icon.png",
        "LanternVape_mobile_icon.png"
    )
    local logoAsset = fetchAsset(
        "https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/assets/lanternvape_text.png",
        "LanternVape_lanternvape_text.png"
    )

    if mobileAsset and typeof(Mobile) == "Instance" and Mobile.Parent then
        Mobile.Image = mobileAsset
    end

    if logoAsset and typeof(SideTitle) == "Instance" and SideTitle.Parent then
        SideTitle.Image = logoAsset
    end

    if logoAsset then
        LanternVapeTextAsset = logoAsset
    end
    if mobileAsset then
        MobileIconAsset = mobileAsset
    end
end)
]]

source = source .. patch

local chunk, err = loadstring(source, "@LanternVape-v2.12")
if not chunk then
    warn("[LanternVape] Compile error: " .. tostring(err))
    return
end

local ran, runErr = pcall(chunk)
if not ran then
    warn("[LanternVape] Runtime error: " .. tostring(runErr))
end
