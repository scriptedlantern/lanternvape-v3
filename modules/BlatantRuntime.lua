-- LanternVape V3 - Dynamic module runtime
-- main.lua remains the GUI. This file only discovers modules and attaches them.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
if not player then return end

local playerGui = player:FindFirstChildOfClass("PlayerGui") or player:WaitForChild("PlayerGui", 10)
if not playerGui then return end

local gui = playerGui:FindFirstChild("LanternVape")
local main = gui and gui:FindFirstChild("Main")
local categories = main and main:FindFirstChild("Categories")
if not categories then
    warn("[LanternVape] Categories container was not found.")
    return
end

local BASE = "https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/"
local API = "https://api.github.com/repos/scriptedlantern/lanternvape-v3/contents/modules"

local ORANGE = Color3.fromRGB(220,115,35)
local DARK = Color3.fromRGB(21,21,21)
local BLACK = Color3.fromRGB(8,8,8)
local WHITE = Color3.fromRGB(245,245,245)
local GRAY = Color3.fromRGB(145,145,145)

local function getJson(url)
    local ok, body = pcall(function()
        return game:HttpGet(url, true)
    end)
    if not ok or type(body) ~= "string" then return nil end

    local decodedOk, data = pcall(function()
        return HttpService:JSONDecode(body)
    end)
    if not decodedOk or type(data) ~= "table" then return nil end
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

    local fn, compileErr = loadstring(source, "LanternVape/" .. path)
    if not fn then
        warn("[LanternVape] Failed to compile " .. path .. ": " .. tostring(compileErr))
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
        if module.SetValue then module:SetValue(value) end
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
end

local function makeRow(modulesFrame, module)
    local holder = Instance.new("Frame")
    holder.Name = "Module_" .. module.Name
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

    local hasSettings = type(module.SetValue) == "function"
        and tonumber(module.Min) ~= nil
        and tonumber(module.Max) ~= nil

    local settingsPanel

    local function render()
        local on = module.Enabled == true
        row.BackgroundColor3 = on and ORANGE:Lerp(Color3.new(0,0,0), .35) or DARK
        state.Text = on and "ON" or "OFF"
        state.TextColor3 = on and WHITE or GRAY
    end

    row.MouseButton1Click:Connect(function()
        if module.SetEnabled then
            local ok, err = pcall(function()
                module:SetEnabled(not module.Enabled)
            end)
            if not ok then
                warn("[LanternVape] Module toggle failed: " .. module.Name .. ": " .. tostring(err))
            end
        end
        render()
    end)

    if hasSettings then
        local settingsButton = Instance.new("TextButton")
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

        settingsPanel = makeSlider(holder, module, tonumber(module.Min), tonumber(module.Max))
        settingsPanel.Visible = false

        settingsButton.MouseButton1Click:Connect(function()
            settingsPanel.Visible = not settingsPanel.Visible
            holder.Size = UDim2.new(1,-10,0, settingsPanel.Visible and 104 or 38)
        end)
    end

    render()
end

local function collectCategoryDirectories()
    local root = getJson(API)
    if not root then return {} end

    local result = {}
    for _, item in ipairs(root) do
        if item.type == "dir" and type(item.name) == "string" then
            result[item.name] = true
        end
    end
    return result
end

local categoryDirectories = collectCategoryDirectories()
local maxColumns = 5
local gap = 6
local minPanelHeight = 108

local function attachCategory(categoryName)
    local panel = categories:FindFirstChild(categoryName)
    local modulesFrame = panel and panel:FindFirstChild("Modules")
    if not panel or not modulesFrame then return 0 end

    local oldRuntime = modulesFrame:FindFirstChild("LanternVapeRuntime")
    if oldRuntime then oldRuntime:Destroy() end

    if categoryName == "Blatant" then
        local legacySpeed = modulesFrame:FindFirstChild("Speed")
        if legacySpeed then legacySpeed:Destroy() end
        local legacySpeedMenu = modulesFrame:FindFirstChild("SpeedMenu")
        if legacySpeedMenu then legacySpeedMenu:Destroy() end
        local legacySpeedOptions = modulesFrame:FindFirstChild("SpeedOptions")
        if legacySpeedOptions then legacySpeedOptions:Destroy() end
    end

    local container = Instance.new("Frame")
    container.Name = "LanternVapeRuntime"
    container.Size = UDim2.new(1,0,0,0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = modulesFrame

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0,5)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = container

    local files = getJson(API .. "/" .. categoryName)
    if not files then return 0 end

    local moduleFiles = {}
    for _, item in ipairs(files) do
        if item.type == "file"
            and type(item.name) == "string"
            and item.name:sub(-4):lower() == ".lua"
            and item.name:lower() ~= "init.lua" then
            moduleFiles[#moduleFiles + 1] = item
        end
    end

    table.sort(moduleFiles, function(a,b)
        return a.name:lower() < b.name:lower()
    end)

    for _, item in ipairs(moduleFiles) do
        local module = loadModule(item.path)
        if module then
            module.Category = module.Category or categoryName
            -- UIListLayout is already sorted by insertion order here.
            makeRow(container, module)
        end
    end

    modulesFrame.AutomaticSize = Enum.AutomaticSize.Y

    return math.max(minPanelHeight, 38 + list.AbsoluteContentSize.Y + 8)
end

local categoryHeights = {}
for _, categoryName in ipairs({"Combat", "Blatant", "External", "Rendering", "Extra"}) do
    if categoryDirectories[categoryName] then
        categoryHeights[categoryName] = attachCategory(categoryName)
    end
end

local function relayout()
    local width = categories.AbsoluteSize.X
    if width <= 0 then return end

    local cols = maxColumns
    local cellWidth = math.max(1, (width - gap*(cols-1))/cols)
    local ordered = {"Combat", "Blatant", "External", "Rendering", "Extra"}
    local rowMax = {}

    for i, name in ipairs(ordered) do
        local r = math.floor((i-1)/cols) + 1
        rowMax[r] = math.max(rowMax[r] or minPanelHeight, categoryHeights[name] or minPanelHeight)
    end

    local yByRow = {}
    local y = 0
    for r = 1, math.ceil(#ordered/cols) do
        yByRow[r] = y
        y = y + (rowMax[r] or minPanelHeight) + gap
    end

    for i, name in ipairs(ordered) do
        local panel = categories:FindFirstChild(name)
        if panel then
            local col = (i-1)%cols
            local r = math.floor((i-1)/cols) + 1
            panel.Size = UDim2.fromOffset(cellWidth, rowMax[r] or minPanelHeight)
            panel.Position = UDim2.fromOffset(col*(cellWidth+gap), yByRow[r] or 0)
        end
    end

    categories.CanvasSize = UDim2.fromOffset(0, math.max(0, y-gap))
end

task.defer(relayout)
task.delay(0.15, relayout)
task.delay(0.5, relayout)

categories:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    task.defer(relayout)
end)

print("[LanternVape] Dynamic modules loaded")
