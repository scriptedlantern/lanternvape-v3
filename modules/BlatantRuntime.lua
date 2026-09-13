-- LanternVape V3 - Dynamic module runtime
-- main.lua remains the GUI. This runtime only discovers and renders modules.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
if not player then return end

local playerGui = player:WaitForChild("PlayerGui", 10)
local gui = playerGui and playerGui:FindFirstChild("LanternVape")
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

    local decoded, data = pcall(function()
        return HttpService:JSONDecode(body)
    end)
    if not decoded or type(data) ~= "table" then return nil end
    return data
end

local function loadModule(path)
    local ok, source = pcall(function()
        return game:HttpGet(BASE .. path, true)
    end)
    if not ok or type(source) ~= "string" then
        warn("[LanternVape] Download failed: " .. path)
        return nil
    end

    local fn, compileError = loadstring(source, "LanternVape/" .. path)
    if not fn then
        warn("[LanternVape] Compile failed: " .. path .. " - " .. tostring(compileError))
        return nil
    end

    local ran, module = pcall(fn)
    if not ran or type(module) ~= "table" or type(module.Name) ~= "string" then
        warn("[LanternVape] Invalid module: " .. path)
        return nil
    end

    return module
end

local function corner(object, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = object
end

local function stroke(object, color, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Transparency = transparency or 0
    s.Thickness = 1
    s.Parent = object
end

local categoryHeights = {}
local relayout

local function makeSlider(parent, module, minValue, maxValue, labelName)
    local panel = Instance.new("Frame")
    panel.Name = labelName:gsub("%s+", "") .. "Settings"
    panel.Size = UDim2.new(1, -10, 0, 58)
    panel.Position = UDim2.fromOffset(5, 39)
    panel.BackgroundColor3 = BLACK
    panel.BorderSizePixel = 0
    panel.ZIndex = 80
    panel.Parent = parent
    corner(panel, 6)
    stroke(panel, ORANGE, .55)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.fromOffset(10, 4)
    label.BackgroundTransparency = 1
    label.TextColor3 = WHITE
    label.TextSize = 10
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 81
    label.Parent = panel

    local track = Instance.new("TextButton")
    track.Name = "Slider"
    track.Size = UDim2.new(1, -20, 0, 12)
    track.Position = UDim2.fromOffset(10, 31)
    track.BackgroundColor3 = DARK
    track.BorderSizePixel = 0
    track.Text = ""
    track.AutoButtonColor = false
    track.ZIndex = 81
    track.Parent = panel
    corner(track, 6)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = ORANGE
    fill.BorderSizePixel = 0
    fill.ZIndex = 82
    fill.Parent = track
    corner(fill, 6)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(14, 14)
    knob.AnchorPoint = Vector2.new(.5, .5)
    knob.BackgroundColor3 = WHITE
    knob.BorderSizePixel = 0
    knob.ZIndex = 83
    knob.Parent = track
    corner(knob, 8)

    local function currentValue()
        local value = tonumber(module[labelName == "Vertical speed" and "VerticalValue" or "Value"]) or minValue
        return math.clamp(value, minValue, maxValue)
    end

    local function render()
        local value = currentValue()
        local alpha = maxValue == minValue and 0 or (value - minValue) / (maxValue - minValue)
        label.Text = string.format("%s: %d", labelName, math.floor(value + .5))
        fill.Size = UDim2.new(alpha, 0, 1, 0)
        knob.Position = UDim2.new(alpha, 0, .5, 0)
    end

    local dragging = false

    local function setFromX(x)
        local width = track.AbsoluteSize.X
        if width <= 0 then return end

        local alpha = math.clamp((x - track.AbsolutePosition.X) / width, 0, 1)
        local value = minValue + alpha * (maxValue - minValue)

        local setter = labelName == "Vertical speed" and module.SetVerticalValue or module.SetValue
        if setter then
            pcall(function()
                setter(module, value)
            end)
        end

        render()
    end

    track.MouseButton1Down:Connect(function(x)
        dragging = true
        setFromX(x)
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            setFromX(input.Position.X)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            setFromX(input.Position.X)
        end
    end)

    render()
    return panel
end

local function makeRow(modulesFrame, module, onChanged)
    local holder = Instance.new("Frame")
    holder.Name = "Module_" .. module.Name
    holder.Size = UDim2.new(1, -10, 0, 38)
    holder.BackgroundTransparency = 1
    holder.BorderSizePixel = 0
    holder.Parent = modulesFrame

    local row = Instance.new("Frame")
    row.Name = "Row"
    row.Size = UDim2.new(1, 0, 0, 34)
    row.BackgroundColor3 = DARK
    row.BorderSizePixel = 0
    row.ZIndex = 50
    row.Parent = holder
    corner(row, 5)

    local toggle = Instance.new("TextButton")
    toggle.Name = "Toggle"
    toggle.Size = UDim2.new(1, -76, 1, 0)
    toggle.BackgroundTransparency = 1
    toggle.BorderSizePixel = 0
    toggle.Text = ""
    toggle.AutoButtonColor = false
    toggle.ZIndex = 55
    toggle.Parent = row

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -12, 1, 0)
    title.Position = UDim2.fromOffset(10, 0)
    title.BackgroundTransparency = 1
    title.Text = module.Name
    title.TextColor3 = WHITE
    title.TextSize = 12
    title.Font = Enum.Font.GothamSemibold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 56
    title.Parent = toggle

    local state = Instance.new("TextLabel")
    state.Size = UDim2.fromOffset(34, 34)
    state.Position = UDim2.new(1, -38, 0, 0)
    state.BackgroundTransparency = 1
    state.Text = "OFF"
    state.TextColor3 = GRAY
    state.TextSize = 9
    state.Font = Enum.Font.GothamBold
    state.ZIndex = 56
    state.Parent = row

    local hasHorizontal = type(module.SetValue) == "function"
        and tonumber(module.Min) ~= nil
        and tonumber(module.Max) ~= nil

    local hasVertical = type(module.SetVerticalValue) == "function"
        and tonumber(module.VerticalMin) ~= nil
        and tonumber(module.VerticalMax) ~= nil

    local options
    local panels = {}

    local function refresh()
        local enabled = module.Enabled == true
        row.BackgroundColor3 = enabled and ORANGE:Lerp(Color3.new(0,0,0), .35) or DARK
        state.Text = enabled and "ON" or "OFF"
        state.TextColor3 = enabled and WHITE or GRAY
        if onChanged then onChanged() end
    end

    toggle.MouseButton1Click:Connect(function()
        if module.SetEnabled then
            local ok, err = pcall(function()
                module:SetEnabled(not module.Enabled)
            end)
            if not ok then
                warn("[LanternVape] Toggle failed: " .. module.Name .. " - " .. tostring(err))
            end
        end
        refresh()
    end)

    if hasHorizontal or hasVertical then
        options = Instance.new("TextButton")
        options.Name = "Options"
        options.Size = UDim2.fromOffset(38, 34)
        options.Position = UDim2.new(1, -76, 0, 0)
        options.BackgroundTransparency = 1
        options.BorderSizePixel = 0
        options.Text = "•••"
        options.TextColor3 = GRAY
        options.TextSize = 13
        options.Font = Enum.Font.GothamBold
        options.AutoButtonColor = false
        options.ZIndex = 70
        options.Parent = row

        if hasHorizontal then
            panels[#panels + 1] = makeSlider(holder, module, tonumber(module.Min), tonumber(module.Max), "Value")
        end

        if hasVertical then
            local vertical = makeSlider(holder, module, tonumber(module.VerticalMin), tonumber(module.VerticalMax), "Vertical speed")
            vertical.Position = UDim2.fromOffset(5, 101)
            panels[#panels + 1] = vertical
        end

        for _, panel in ipairs(panels) do
            panel.Visible = false
        end

        options.MouseButton1Click:Connect(function()
            local open = not panels[1].Visible

            for index, panel in ipairs(panels) do
                panel.Visible = open
                if open then
                    panel.Position = UDim2.fromOffset(5, 39 + (index - 1) * 67)
                end
            end

            holder.Size = UDim2.new(1, -10, 0, open and (39 + #panels * 67) or 38)
            task.defer(function()
                if relayout then relayout() end
            end)
        end)
    end

    refresh()
end

local function attachCategory(categoryName)
    local panel = categories:FindFirstChild(categoryName)
    local modulesFrame = panel and panel:FindFirstChild("Modules")
    if not panel or not modulesFrame then
        return
    end

    local oldRuntime = modulesFrame:FindFirstChild("LanternVapeRuntime")
    if oldRuntime then oldRuntime:Destroy() end

    if categoryName == "Blatant" then
        for _, child in ipairs(modulesFrame:GetChildren()) do
            if child.Name == "Speed" or child.Name == "SpeedMenu" or child.Name == "SpeedOptions" then
                child:Destroy()
            end
        end
    end

    local container = Instance.new("Frame")
    container.Name = "LanternVapeRuntime"
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = modulesFrame

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 5)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = container

    local files = getJson(API .. "/" .. categoryName)
    if not files then
        categoryHeights[categoryName] = 108
        return
    end

    local moduleFiles = {}
    for _, item in ipairs(files) do
        if item.type == "file"
            and type(item.name) == "string"
            and item.name:sub(-4):lower() == ".lua"
            and item.name:lower() ~= "init.lua" then
            moduleFiles[#moduleFiles + 1] = item
        end
    end

    table.sort(moduleFiles, function(a, b)
        return a.name:lower() < b.name:lower()
    end)

    for _, item in ipairs(moduleFiles) do
        local module = loadModule(item.path)
        if module then
            module.Category = module.Category or categoryName
            makeRow(container, module, function()
                task.defer(function()
                    if relayout then relayout() end
                end)
            end)
        end
    end

    local function updateHeight()
        categoryHeights[categoryName] = math.max(108, 46 + list.AbsoluteContentSize.Y)
        if relayout then relayout() end
    end

    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateHeight)
    updateHeight()
end

local categoryNames = {"Combat", "Blatant", "External", "Rendering", "Extra"}
local categoryDirs = getJson(API) or {}
local existingDirs = {}

for _, item in ipairs(categoryDirs) do
    if item.type == "dir" and type(item.name) == "string" then
        existingDirs[item.name] = true
    end
end

for _, name in ipairs(categoryNames) do
    if existingDirs[name] then
        attachCategory(name)
    end
end

relayout = function()
    local width = categories.AbsoluteSize.X
    if width <= 0 then return end

    local gap = 6
    local columns = math.min(5, #categoryNames)
    local cellWidth = math.max(1, (width - gap * (columns - 1)) / columns)

    local rowHeights = {}
    for i, name in ipairs(categoryNames) do
        local row = math.floor((i - 1) / columns) + 1
        rowHeights[row] = math.max(rowHeights[row] or 108, categoryHeights[name] or 108)
    end

    local rowY = {}
    local y = 0
    for row = 1, math.ceil(#categoryNames / columns) do
        rowY[row] = y
        y = y + (rowHeights[row] or 108) + gap
    end

    for i, name in ipairs(categoryNames) do
        local panel = categories:FindFirstChild(name)
        if panel then
            local column = (i - 1) % columns
            local row = math.floor((i - 1) / columns) + 1
            panel.Size = UDim2.fromOffset(cellWidth, rowHeights[row] or 108)
            panel.Position = UDim2.fromOffset(column * (cellWidth + gap), rowY[row] or 0)
        end
    end

    categories.CanvasSize = UDim2.fromOffset(0, math.max(0, y - gap))
end

task.defer(relayout)
task.delay(.1, relayout)
task.delay(.5, relayout)

categories:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    task.defer(relayout)
end)

print("[LanternVape] Dynamic module system loaded")
