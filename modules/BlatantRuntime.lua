-- LanternVape V3 - Dynamic module runtime
-- The GUI stays in main.lua. This file only discovers and attaches modules.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
if not player then return end

local playerGui = player:FindFirstChildOfClass("PlayerGui") or player:WaitForChild("PlayerGui", 10)
if not playerGui then return end

local BASE = "https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/"
local API = "https://api.github.com/repos/scriptedlantern/lanternvape-v3/contents/modules"

local ORANGE = Color3.fromRGB(220,115,35)
local DARK = Color3.fromRGB(21,21,21)
local BLACK = Color3.fromRGB(8,8,8)
local WHITE = Color3.fromRGB(245,245,245)
local GRAY = Color3.fromRGB(145,145,145)

local function corner(o, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = o
end

local function stroke(o, c, t)
    local s = Instance.new("UIStroke")
    s.Color = c
    s.Transparency = t or 0
    s.Thickness = 1
    s.Parent = o
end

local function getJson(url)
    local ok, body = pcall(function()
        return game:HttpGet(url, true)
    end)
    if not ok or type(body) ~= "string" then
        return nil
    end

    local decodedOk, data = pcall(function()
        return HttpService:JSONDecode(body)
    end)
    if not decodedOk or type(data) ~= "table" then
        return nil
    end

    return data
end

local function loadModule(path)
    local ok, source = pcall(function()
        return game:HttpGet(BASE .. path, true)
    end)
    if not ok or type(source) ~= "string" then
        warn("[LanternVape] Failed to download module: " .. path)
        return nil
    end

    local fn, err = loadstring(source, "LanternVape/" .. path)
    if not fn then
        warn("[LanternVape] Failed to compile " .. path .. ": " .. tostring(err))
        return nil
    end

    local runOk, module = pcall(fn)
    if not runOk then
        warn("[LanternVape] Failed to initialize " .. path .. ": " .. tostring(module))
        return nil
    end

    if type(module) ~= "table" or type(module.Name) ~= "string" then
        warn("[LanternVape] Invalid module contract: " .. path)
        return nil
    end

    return module
end

local gui = playerGui:FindFirstChild("LanternVape")
local main = gui and gui:FindFirstChild("Main")
local categories = main and main:FindFirstChild("Categories")
if not categories then
    warn("[LanternVape] Categories container was not found.")
    return
end

local function makeSlider(parent, module, min, max)
    local panel = Instance.new("Frame")
    panel.Name = "Settings"
    panel.Size = UDim2.new(1,-10,0,62)
    panel.Position = UDim2.fromOffset(5,38)
    panel.BackgroundColor3 = BLACK
    panel.BorderSizePixel = 0
    panel.ZIndex = 90
    panel.Parent = parent
    corner(panel, 6)
    stroke(panel, ORANGE, .45)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,-20,0,20)
    label.Position = UDim2.fromOffset(10,5)
    label.BackgroundTransparency = 1
    label.TextColor3 = WHITE
    label.TextSize = 10
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 91
    label.Parent = panel

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1,-20,0,6)
    bg.Position = UDim2.fromOffset(10,35)
    bg.BackgroundColor3 = DARK
    bg.BorderSizePixel = 0
    bg.ZIndex = 91
    bg.Parent = panel
    corner(bg, 6)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0,0,1,0)
    fill.BackgroundColor3 = ORANGE
    fill.BorderSizePixel = 0
    fill.ZIndex = 92
    fill.Parent = bg
    corner(fill, 6)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(12,12)
    knob.AnchorPoint = Vector2.new(.5,.5)
    knob.BackgroundColor3 = WHITE
    knob.BorderSizePixel = 0
    knob.ZIndex = 93
    knob.Parent = bg
    corner(knob, 8)

    local function render()
        local value = math.clamp(tonumber(module.Value) or min, min, max)
        local alpha = max == min and 0 or (value-min)/(max-min)
        label.Text = string.format("Value: %d", math.floor(value + .5))
        fill.Size = UDim2.new(alpha,0,1,0)
        knob.Position = UDim2.new(alpha,0,.5,0)
    end

    local dragging = false
    local function update(x)
        local width = bg.AbsoluteSize.X
        if width <= 0 then return end
        local alpha = math.clamp((x-bg.AbsolutePosition.X)/width,0,1)
        local value = min + alpha*(max-min)
        if module.SetValue then
            module:SetValue(value)
        end
        render()
    end

    bg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(input.Position.X)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            update(input.Position.X)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    render()
    return panel
end

local function makeRow(modulesFrame, module)
    local holder = Instance.new("Frame")
    holder.Name = module.Name
    holder.Size = UDim2.new(1,-10,0,38)
    holder.BackgroundTransparency = 1
    holder.BorderSizePixel = 0
    holder.Parent = modulesFrame

    local row = Instance.new("TextButton")
    row.Name = "Toggle"
    row.Size = UDim2.new(1,0,0,34)
    row.BackgroundColor3 = DARK
    row.BorderSizePixel = 0
    row.Text = ""
    row.AutoButtonColor = false
    row.ZIndex = 50
    row.Parent = holder
    corner(row, 5)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,-52,1,0)
    title.Position = UDim2.fromOffset(10,0)
    title.BackgroundTransparency = 1
    title.Text = module.Name
    title.TextColor3 = WHITE
    title.TextSize = 12
    title.Font = Enum.Font.GothamSemibold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 51
    title.Parent = row

    local state = Instance.new("TextLabel")
    state.Size = UDim2.fromOffset(34,34)
    state.Position = UDim2.new(1,-38,0,0)
    state.BackgroundTransparency = 1
    state.Text = "OFF"
    state.TextColor3 = GRAY
    state.TextSize = 9
    state.Font = Enum.Font.GothamBold
    state.ZIndex = 51
    state.Parent = row

    local settingsButton
    local settingsPanel
    local hasSettings = type(module.SetValue) == "function"
        and tonumber(module.Min) ~= nil
        and tonumber(module.Max) ~= nil

    local function render()
        local on = module.Enabled == true
        row.BackgroundColor3 = on and ORANGE:Lerp(Color3.new(0,0,0), .35) or DARK
        state.Text = on and "ON" or "OFF"
        state.TextColor3 = on and WHITE or GRAY
    end

    row.MouseButton1Click:Connect(function()
        if module.SetEnabled then
            local ok = pcall(function()
                module:SetEnabled(not module.Enabled)
            end)
            if not ok then
                warn("[LanternVape] Module toggle failed: " .. module.Name)
            end
        end
        render()
    end)

    if hasSettings then
        settingsButton = Instance.new("TextButton")
        settingsButton.Name = "Options"
        settingsButton.Size = UDim2.fromOffset(36,34)
        settingsButton.Position = UDim2.new(1,-72,0,0)
        settingsButton.BackgroundTransparency = 1
        settingsButton.BorderSizePixel = 0
        settingsButton.Text = "•••"
        settingsButton.TextColor3 = GRAY
        settingsButton.TextSize = 13
        settingsButton.Font = Enum.Font.GothamBold
        settingsButton.AutoButtonColor = false
        settingsButton.ZIndex = 55
        settingsButton.Parent = holder

        local min = tonumber(module.Min)
        local max = tonumber(module.Max)
        settingsPanel = makeSlider(holder, module, min, max)
        settingsPanel.Visible = false

        settingsButton.MouseButton1Click:Connect(function()
            settingsPanel.Visible = not settingsPanel.Visible
            holder.Size = UDim2.new(1,-10,0, settingsPanel.Visible and 104 or 38)
        end)
    end

    render()
end

local function attachCategory(categoryName, files)
    local panel = categories:FindFirstChild(categoryName)
    local modulesFrame = panel and panel:FindFirstChild("Modules")
    if not modulesFrame then
        return
    end

    -- Remove only the runtime-owned container. The GUI itself remains untouched.
    local oldRuntime = modulesFrame:FindFirstChild("LanternVapeRuntime")
    if oldRuntime then
        oldRuntime:Destroy()
    end

    -- Speed used to be embedded in main.lua. Remove its old visual row so the
    -- standalone modules/Blatant/Speed.lua becomes the single source of truth.
    if categoryName == "Blatant" then
        local legacySpeed = modulesFrame:FindFirstChild("Speed")
        if legacySpeed then
            legacySpeed:Destroy()
        end
        local legacySpeedMenu = modulesFrame:FindFirstChild("SpeedOptions")
        if legacySpeedMenu then
            legacySpeedMenu:Destroy()
        end
    end

    local container = Instance.new("Frame")
    container.Name = "LanternVapeRuntime"
    container.Size = UDim2.new(1,0,0,0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.Parent = modulesFrame

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0,5)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = container

    for index, file in ipairs(files) do
        local module = loadModule(file.path)
        if module then
            module.Category = module.Category or categoryName
            local row = makeRow(container, module)
            row.LayoutOrder = index
        end
    end

    modulesFrame.AutomaticSize = Enum.AutomaticSize.Y
end

local root = getJson(API)
if not root then
    warn("[LanternVape] Could not query the module directory.")
    return
end

local categoryDirectories = {}
for _, item in ipairs(root) do
    if item.type == "dir" and type(item.name) == "string" then
        categoryDirectories[#categoryDirectories + 1] = item.name
    end
end
table.sort(categoryDirectories)

for _, categoryName in ipairs(categoryDirectories) do
    local files = getJson(API .. "/" .. HttpService:UrlEncode(categoryName))
    if files then
        local moduleFiles = {}
        for _, item in ipairs(files) do
            if item.type == "file"
                and type(item.name) == "string"
                and item.name:sub(-4):lower() == ".lua"
                and item.name:lower() ~= "init.lua" then
                moduleFiles[#moduleFiles + 1] = {
                    name = item.name,
                    path = item.path
                }
            end
        end

        table.sort(moduleFiles, function(a,b)
            return a.name:lower() < b.name:lower()
        end)

        attachCategory(categoryName, moduleFiles)
    end
end

print("[LanternVape] Dynamic modules loaded")
