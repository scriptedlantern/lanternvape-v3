-- LanternVape V3 - Blatant runtime GUI connector
-- v2.14

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player and player:FindFirstChildOfClass("PlayerGui")
if not playerGui then return end

local BASE = "https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/"
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

local function loadModule(file)
    local ok, source = pcall(function()
        return game:HttpGet(BASE .. "modules/Blatant/" .. file, true)
    end)
    if not ok or type(source) ~= "string" then return nil end

    local fn, err = loadstring(source, "LanternVape/" .. file)
    if not fn then
        warn("[LanternVape] Failed to load " .. file .. ": " .. tostring(err))
        return nil
    end

    local ok2, module = pcall(fn)
    if not ok2 then
        warn("[LanternVape] Failed to initialize " .. file .. ": " .. tostring(module))
        return nil
    end
    return module
end

local gui = playerGui:FindFirstChild("LanternVape")
local main = gui and gui:FindFirstChild("Main")
local categories = main and main:FindFirstChild("Categories")
local blatant = categories and categories:FindFirstChild("Blatant")
local modulesFrame = blatant and blatant:FindFirstChild("Modules")
if not modulesFrame then
    warn("[LanternVape] Blatant module container was not found.")
    return
end

local moduleFiles = {
    {name="Spider", file="Spider.lua", settings=true},
    {name="Phase", file="Phase.lua"},
    {name="Antifall", file="Antifall.lua"},
    {name="Fly", file="Fly.lua", settings=true},
    {name="HighJump", file="HighJump.lua"},
    {name="Infinite Jump", file="InfiniteJump.lua"},
}

local function makeSlider(parent, module, min, max)
    local panel = Instance.new("Frame")
    panel.Name = "Settings"
    panel.Size = UDim2.new(1,-10,0,62)
    panel.Position = UDim2.fromOffset(5,0)
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
        local alpha = (value-min)/(max-min)
        label.Text = string.format("Rate: %d", math.floor(value + .5))
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
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(input.Position.X)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input.Position.X)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    render()
    return panel
end

local function makeRow(module, hasSettings)
    local holder = Instance.new("Frame")
    holder.Name = module.Name
    holder.Size = UDim2.new(1,-10,0,34 + (hasSettings and 0 or 0))
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
    title.Size = UDim2.new(1,-50,1,0)
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

    local function render()
        local on = module.Enabled == true
        row.BackgroundColor3 = on and ORANGE:Lerp(Color3.new(0,0,0), .35) or DARK
        state.Text = on and "ON" or "OFF"
        state.TextColor3 = on and WHITE or GRAY
    end

    row.MouseButton1Click:Connect(function()
        if module.SetEnabled then
            module:SetEnabled(not module.Enabled)
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

        local min, max = module.Min or 1, module.Max or 50
        settingsPanel = makeSlider(holder, module, min, max)
        settingsPanel.Position = UDim2.fromOffset(5,38)
        settingsPanel.Visible = false
        holder.Size = UDim2.new(1,-10,0,38)

        settingsButton.MouseButton1Click:Connect(function()
            settingsPanel.Visible = not settingsPanel.Visible
            holder.Size = UDim2.new(1,-10,0, settingsPanel.Visible and 104 or 38)
        end)
    end

    render()
    return holder
end

-- Prevent duplicate runtime rows if the connector is loaded twice.
local existing = modulesFrame:FindFirstChild("LanternVapeRuntime")
if existing then existing:Destroy() end

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

for index, info in ipairs(moduleFiles) do
    local module = loadModule(info.file)
    if module then
        local row = makeRow(module, info.settings)
        row.LayoutOrder = index
        row.Parent = container
    end
end

modulesFrame.AutomaticSize = Enum.AutomaticSize.Y
