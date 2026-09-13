-- LanternVape V3 - Dynamic module runtime v3
-- main.lua is the GUI. Modules are separate files and are discovered automatically.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player and player:WaitForChild("PlayerGui", 10)
local gui = playerGui and playerGui:WaitForChild("LanternVape", 10)
local main = gui and gui:WaitForChild("Main", 10)
local categories = main and main:WaitForChild("Categories", 10)

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

local function json(url)
    local ok, body = pcall(function()
        return game:HttpGet(url, true)
    end)
    if not ok then return nil end

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

    local fn, err = loadstring(source, "LanternVape/" .. path)
    if not fn then
        warn("[LanternVape] Compile failed: " .. path .. " - " .. tostring(err))
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

local function createSlider(holder, module, minimum, maximum, property, setter, labelText, y)
    local panel = Instance.new("Frame")
    panel.Name = labelText:gsub("%s+", "") .. "Setting"
    panel.Size = UDim2.new(1, -10, 0, 58)
    panel.Position = UDim2.fromOffset(5, y)
    panel.BackgroundColor3 = BLACK
    panel.BorderSizePixel = 0
    panel.ZIndex = 90
    panel.Parent = holder
    corner(panel, 6)
    stroke(panel, ORANGE, .45)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.fromOffset(10, 4)
    label.BackgroundTransparency = 1
    label.TextColor3 = WHITE
    label.TextSize = 10
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 91
    label.Parent = panel

    local bar = Instance.new("TextButton")
    bar.Name = "Slider"
    bar.Size = UDim2.new(1, -20, 0, 12)
    bar.Position = UDim2.fromOffset(10, 31)
    bar.BackgroundColor3 = DARK
    bar.BorderSizePixel = 0
    bar.Text = ""
    bar.AutoButtonColor = false
    bar.Active = true
    bar.ZIndex = 92
    bar.Parent = panel
    corner(bar, 6)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = ORANGE
    fill.BorderSizePixel = 0
    fill.ZIndex = 93
    fill.Parent = bar
    corner(fill, 6)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(14, 14)
    knob.AnchorPoint = Vector2.new(.5, .5)
    knob.BackgroundColor3 = WHITE
    knob.BorderSizePixel = 0
    knob.ZIndex = 94
    knob.Parent = bar
    corner(knob, 8)

    local function draw()
        local value = math.clamp(tonumber(module[property]) or minimum, minimum, maximum)
        local alpha = maximum == minimum and 0 or (value - minimum) / (maximum - minimum)
        label.Text = string.format("%s: %d", labelText, math.floor(value + .5))
        fill.Size = UDim2.new(alpha, 0, 1, 0)
        knob.Position = UDim2.new(alpha, 0, .5, 0)
    end

    local dragging = false

    local function update(x)
        local width = bar.AbsoluteSize.X
        if width <= 0 then return end

        local alpha = math.clamp((x - bar.AbsolutePosition.X) / width, 0, 1)
        local value = minimum + alpha * (maximum - minimum)

        local ok, err = pcall(function()
            module[setter](module, value)
        end)
        if not ok then
            warn("[LanternVape] Slider error: " .. module.Name .. " - " .. tostring(err))
        end

        draw()
    end

    bar.MouseButton1Click:Connect(function(x)
        update(x)
    end)

    bar.InputBegan:Connect(function(input)
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

    draw()
    return panel
end

local function createRow(container, module, resize)
    local holder = Instance.new("Frame")
    holder.Name = "Module_" .. module.Name
    holder.Size = UDim2.new(1, -10, 0, 38)
    holder.BackgroundTransparency = 1
    holder.BorderSizePixel = 0
    holder.ClipsDescendants = false
    holder.ZIndex = 40
    holder.Parent = container

    local row = Instance.new("Frame")
    row.Name = "Row"
    row.Size = UDim2.new(1, 0, 0, 34)
    row.BackgroundColor3 = DARK
    row.BorderSizePixel = 0
    row.ZIndex = 50
    row.Parent = holder
    corner(row, 5)
    stroke(row, ORANGE, .82)

    local toggle = Instance.new("TextButton")
    toggle.Name = "Toggle"
    toggle.Size = UDim2.new(1, -76, 1, 0)
    toggle.BackgroundTransparency = 1
    toggle.Text = ""
    toggle.AutoButtonColor = false
    toggle.Active = true
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

    local settings = {}

    if type(module.SetValue) == "function"
        and tonumber(module.Min) ~= nil
        and tonumber(module.Max) ~= nil then
        settings[#settings + 1] = createSlider(
            holder, module, tonumber(module.Min), tonumber(module.Max),
            "Value", "SetValue", "Value", 39
        )
    end

    if type(module.SetVerticalValue) == "function"
        and tonumber(module.VerticalMin) ~= nil
        and tonumber(module.VerticalMax) ~= nil then
        settings[#settings + 1] = createSlider(
            holder, module, tonumber(module.VerticalMin), tonumber(module.VerticalMax),
            "VerticalValue", "SetVerticalValue", "Vertical speed",
            39 + (#settings * 63)
        )
    end

    local options
    if #settings > 0 then
        options = Instance.new("TextButton")
        options.Name = "Options"
        options.Size = UDim2.fromOffset(38, 34)
        options.Position = UDim2.new(1, -76, 0, 0)
        options.BackgroundTransparency = 1
        options.Text = "•••"
        options.TextColor3 = GRAY
        options.TextSize = 14
        options.Font = Enum.Font.GothamBold
        options.AutoButtonColor = false
        options.Active = true
        options.ZIndex = 100
        options.Parent = row

        for _, setting in ipairs(settings) do
            setting.Visible = false
        end

        options.MouseButton1Click:Connect(function()
            local open = not settings[1].Visible
            local height = 38

            for _, setting in ipairs(settings) do
                setting.Visible = open
                if open then
                    setting.Position = UDim2.fromOffset(5, height)
                    height = height + 63
                end
            end

            holder.Size = UDim2.new(1, -10, 0, open and height or 38)
            task.defer(resize)
        end)

        options.InputBegan:Connect(function(input)
            if input.UserInputType ~= Enum.UserInputType.Touch then return end

            local open = not settings[1].Visible
            local height = 38

            for _, setting in ipairs(settings) do
                setting.Visible = open
                if open then
                    setting.Position = UDim2.fromOffset(5, height)
                    height = height + 63
                end
            end

            holder.Size = UDim2.new(1, -10, 0, open and height or 38)
            task.defer(resize)
        end)
    end

    local function render()
        local enabled = module.Enabled == true
        row.BackgroundColor3 = enabled and ORANGE:Lerp(Color3.new(0,0,0), .35) or DARK
        state.Text = enabled and "ON" or "OFF"
        state.TextColor3 = enabled and WHITE or GRAY
    end

    toggle.MouseButton1Click:Connect(function()
        if type(module.SetEnabled) ~= "function" then return end

        local ok, err = pcall(function()
            module:SetEnabled(not module.Enabled)
        end)

        if not ok then
            warn("[LanternVape] Toggle error: " .. module.Name .. " - " .. tostring(err))
        end

        render()
    end)

    render()
end

local function removeLegacy(frame)
    for _, name in ipairs({"Speed", "SpeedMenu", "SpeedOptions"}) do
        local object = frame:FindFirstChild(name)
        if object then object:Destroy() end
    end
end

local categoryHeights = {}
local panels = {}

local function updateCanvas()
    task.defer(function()
        local bottom = 0
        for _, panel in pairs(panels) do
            bottom = math.max(bottom, panel.Position.Y.Offset + panel.AbsoluteSize.Y)
        end
        categories.CanvasSize = UDim2.fromOffset(0, bottom + 12)
    end)
end

local function resizeCategory(name, panel, modulesFrame, box, list)
    local height = math.max(108, 46 + list.AbsoluteContentSize.Y)
    categoryHeights[name] = height
    panel.Size = UDim2.new(panel.Size.X.Scale, panel.Size.X.Offset, 0, height)
    modulesFrame.Size = UDim2.new(1, 0, 0, math.max(0, height - 38))
    updateCanvas()
end

local function loadCategory(name)
    local panel = categories:FindFirstChild(name)
    local modulesFrame = panel and panel:FindFirstChild("Modules")
    if not panel or not modulesFrame then return end

    panels[name] = panel
    removeLegacy(modulesFrame)

    local old = modulesFrame:FindFirstChild("LanternVapeRuntime")
    if old then old:Destroy() end

    local box = Instance.new("Frame")
    box.Name = "LanternVapeRuntime"
    box.Size = UDim2.new(1, 0, 0, 0)
    box.AutomaticSize = Enum.AutomaticSize.Y
    box.BackgroundTransparency = 1
    box.BorderSizePixel = 0
    box.ClipsDescendants = false
    box.Parent = modulesFrame

    local list = Instance.new("UIListLayout")
    list.SortOrder = Enum.SortOrder.Name
    list.Padding = UDim.new(0, 5)
    list.Parent = box

    local function resize()
        resizeCategory(name, panel, modulesFrame, box, list)
    end

    local files = json(API .. "/" .. name) or {}
    local names = {}

    for _, item in ipairs(files) do
        if item.type == "file"
            and type(item.name) == "string"
            and item.name:sub(-4):lower() == ".lua"
            and item.name:lower() ~= "init.lua" then
            names[#names + 1] = item.name
        end
    end

    if name == "Blatant" and #names == 0 then
        names = {
            "Antifall.lua", "Fly.lua", "HighJump.lua",
            "InfiniteJump.lua", "Phase.lua", "Speed.lua", "Spider.lua"
        }
    end

    table.sort(names, function(a,b) return a:lower() < b:lower() end)

    for _, filename in ipairs(names) do
        local module = loadModule("modules/" .. name .. "/" .. filename)
        if module then
            createRow(box, module, resize)
        end
    end

    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resize)
    task.defer(resize)
    task.delay(.15, resize)
end

local directories = json(API)
if not directories then
    warn("[LanternVape] Could not enumerate module folders.")
    return
end

for _, directory in ipairs(directories) do
    if directory.type == "dir" and type(directory.name) == "string" then
        loadCategory(directory.name)
    end
end

-- Keep category widths/positions from main.lua, but make their heights dynamic.
local function normalizeLayout()
    local width = categories.AbsoluteSize.X
    if width <= 0 then return end

    local ordered = {"Combat", "Blatant", "External", "Rendering", "Extra"}
    local gap = 6
    local columns = 5
    local cellWidth = math.max(1, (width - gap * (columns - 1)) / columns)

    local rowHeights = {}
    for i, name in ipairs(ordered) do
        local row = math.floor((i - 1) / columns) + 1
        rowHeights[row] = math.max(rowHeights[row] or 108, categoryHeights[name] or 108)
    end

    local rowY = {}
    local y = 0
    for row = 1, math.ceil(#ordered / columns) do
        rowY[row] = y
        y = y + (rowHeights[row] or 108) + gap
    end

    for i, name in ipairs(ordered) do
        local panel = panels[name]
        if panel then
            local col = (i - 1) % columns
            local row = math.floor((i - 1) / columns) + 1
            panel.Size = UDim2.fromOffset(cellWidth, rowHeights[row] or 108)
            panel.Position = UDim2.fromOffset(col * (cellWidth + gap), rowY[row] or 0)
        end
    end

    categories.CanvasSize = UDim2.fromOffset(0, math.max(0, y - gap + 12))
end

categories:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    task.defer(normalizeLayout)
end)

task.defer(normalizeLayout)
task.delay(.1, normalizeLayout)
task.delay(.5, normalizeLayout)

print("[LanternVape] Modular runtime v3 ready")
