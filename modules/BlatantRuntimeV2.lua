-- LanternVape V3 modular runtime
-- main.lua owns the GUI. This runtime only discovers modules and builds their controls.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
if not Player then return end

local PlayerGui = Player:WaitForChild("PlayerGui", 10)
local Gui = PlayerGui and PlayerGui:WaitForChild("LanternVape", 10)
local Main = Gui and Gui:WaitForChild("Main", 10)
local Categories = Main and Main:WaitForChild("Categories", 10)
if not Categories then
    warn("[LanternVape] Categories container was not found.")
    return
end

local BASE = "https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/"
local API = "https://api.github.com/repos/scriptedlantern/lanternvape-v3/contents/modules"

local C = {
    Orange = Color3.fromRGB(220,115,35),
    Dark = Color3.fromRGB(21,21,21),
    Black = Color3.fromRGB(8,8,8),
    White = Color3.fromRGB(245,245,245),
    Gray = Color3.fromRGB(145,145,145)
}

local function json(url)
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
        warn("[LanternVape] Could not download " .. path)
        return nil
    end

    local chunk, compileError = loadstring(source, "LanternVape/" .. path)
    if not chunk then
        warn("[LanternVape] Compile error in " .. path .. ": " .. tostring(compileError))
        return nil
    end

    local ran, module = pcall(chunk)
    if not ran then
        warn("[LanternVape] Error loading " .. path .. ": " .. tostring(module))
        return nil
    end

    if type(module) ~= "table" or type(module.Name) ~= "string" then
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

local function makeSlider(holder, module, minimum, maximum, labelText, setter, property, y)
    local panel = Instance.new("Frame")
    panel.Name = labelText:gsub("%s+", "") .. "Setting"
    panel.Size = UDim2.new(1, -10, 0, 58)
    panel.Position = UDim2.fromOffset(5, y)
    panel.BackgroundColor3 = C.Black
    panel.BorderSizePixel = 0
    panel.ZIndex = 90
    panel.Parent = holder
    corner(panel, 6)
    stroke(panel, C.Orange, .45)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.fromOffset(10, 4)
    label.BackgroundTransparency = 1
    label.TextColor3 = C.White
    label.TextSize = 10
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 91
    label.Parent = panel

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -20, 0, 6)
    bar.Position = UDim2.fromOffset(10, 34)
    bar.BackgroundColor3 = C.Dark
    bar.BorderSizePixel = 0
    bar.ZIndex = 91
    bar.Parent = panel
    corner(bar, 6)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = C.Orange
    fill.BorderSizePixel = 0
    fill.ZIndex = 92
    fill.Parent = bar
    corner(fill, 6)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(12, 12)
    knob.AnchorPoint = Vector2.new(.5, .5)
    knob.BackgroundColor3 = C.White
    knob.BorderSizePixel = 0
    knob.ZIndex = 93
    knob.Parent = bar
    corner(knob, 8)

    local dragging = false

    local function draw()
        local value = tonumber(module[property]) or minimum
        value = math.clamp(value, minimum, maximum)
        local alpha = (value - minimum) / (maximum - minimum)
        label.Text = labelText .. ": " .. math.floor(value + .5)
        fill.Size = UDim2.new(alpha, 0, 1, 0)
        knob.Position = UDim2.new(alpha, 0, .5, 0)
    end

    local function setFromX(x)
        local width = bar.AbsoluteSize.X
        if width <= 0 then return end

        local alpha = math.clamp((x - bar.AbsolutePosition.X) / width, 0, 1)
        local value = minimum + alpha * (maximum - minimum)

        if module[setter] then
            pcall(function()
                module[setter](module, value)
            end)
        end
        draw()
    end

    bar.Active = true
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            setFromX(input.Position.X)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            setFromX(input.Position.X)
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

local function makeModuleRow(container, module)
    local holder = Instance.new("Frame")
    holder.Name = "Module_" .. module.Name
    holder.Size = UDim2.new(1, -10, 0, 38)
    holder.BackgroundTransparency = 1
    holder.BorderSizePixel = 0
    holder.ClipsDescendants = false
    holder.ZIndex = 40
    holder.Parent = container

    local button = Instance.new("TextButton")
    button.Name = "Toggle"
    button.Size = UDim2.new(1, 0, 0, 34)
    button.BackgroundColor3 = C.Dark
    button.BorderSizePixel = 0
    button.Text = ""
    button.AutoButtonColor = false
    button.Active = true
    button.ZIndex = 50
    button.Parent = holder
    corner(button, 5)
    stroke(button, C.Orange, .82)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -115, 1, 0)
    title.Position = UDim2.fromOffset(10, 0)
    title.BackgroundTransparency = 1
    title.Text = module.Name
    title.TextColor3 = C.White
    title.TextSize = 12
    title.Font = Enum.Font.GothamSemibold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 51
    title.Parent = button

    local state = Instance.new("TextLabel")
    state.Size = UDim2.fromOffset(34, 34)
    state.Position = UDim2.new(1, -38, 0, 0)
    state.BackgroundTransparency = 1
    state.Text = "OFF"
    state.TextColor3 = C.Gray
    state.TextSize = 9
    state.Font = Enum.Font.GothamBold
    state.ZIndex = 51
    state.Parent = button

    local settings = {}

    if type(module.SetValue) == "function"
        and tonumber(module.Min)
        and tonumber(module.Max) then
        settings[#settings + 1] = makeSlider(
            holder,
            module,
            tonumber(module.Min),
            tonumber(module.Max),
            "Speed",
            "SetValue",
            "Value",
            38
        )
    end

    if type(module.SetVerticalValue) == "function" then
        settings[#settings + 1] = makeSlider(
            holder,
            module,
            tonumber(module.VerticalMin) or 1,
            tonumber(module.VerticalMax) or 23,
            "Vertical speed",
            "SetVerticalValue",
            "VerticalValue",
            38 + (#settings * 63)
        )
    end

    local options = Instance.new("TextButton")
    options.Name = "Options"
    options.Size = UDim2.fromOffset(36, 34)
    options.Position = UDim2.new(1, -72, 0, 0)
    options.BackgroundTransparency = 1
    options.BorderSizePixel = 0
    options.Text = "•••"
    options.TextColor3 = C.Gray
    options.TextSize = 14
    options.Font = Enum.Font.GothamBold
    options.AutoButtonColor = false
    options.Active = true
    options.ZIndex = 100
    options.Parent = holder

    for _, setting in ipairs(settings) do
        setting.Visible = false
    end

    if #settings == 0 then
        options.Visible = false
    end

    local function render()
        local enabled = module.Enabled == true
        button.BackgroundColor3 = enabled
            and C.Orange:Lerp(Color3.new(0, 0, 0), .35)
            or C.Dark
        state.Text = enabled and "ON" or "OFF"
        state.TextColor3 = enabled and C.White or C.Gray
    end

    local function toggle()
        if type(module.SetEnabled) == "function" then
            local ok, err = pcall(function()
                module:SetEnabled(not module.Enabled)
            end)
            if not ok then
                warn("[LanternVape] " .. module.Name .. ": " .. tostring(err))
            end
            render()
        end
    end

    button.MouseButton1Click:Connect(toggle)

    options.MouseButton1Click:Connect(function()
        if #settings == 0 then return end

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
    end)

    -- Touch fallback: makes the three-dot target reliable on mobile.
    options.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.Touch then return end
        if #settings == 0 then return end

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
    end)

    render()
end

local function removeLegacySpeed(frame)
    -- main.lua previously contained a built-in Speed implementation.
    -- Remove only that old module row/menu so the standalone Speed.lua is authoritative.
    local oldRow = frame:FindFirstChild("Speed")
    if oldRow then oldRow:Destroy() end

    local oldMenu = frame:FindFirstChild("SpeedMenu")
    if oldMenu then oldMenu:Destroy() end
end

local function resizeCategory(panel, modulesFrame, box)
    task.defer(function()
        if not panel.Parent or not modulesFrame.Parent or not box.Parent then return end

        local contentHeight = box.AbsoluteSize.Y
        local panelHeight = math.max(108, 38 + contentHeight + 8)

        panel.Size = UDim2.new(panel.Size.X.Scale, panel.Size.X.Offset, 0, panelHeight)
        modulesFrame.Size = UDim2.new(1, 0, 0, math.max(0, panelHeight - 38))
        modulesFrame.ClipsDescendants = false
        box.Size = UDim2.new(1, 0, 0, contentHeight)
    end)
end

local function refreshCanvas()
    task.defer(function()
        local highest = 0
        for _, panel in ipairs(Categories:GetChildren()) do
            if panel:IsA("Frame") then
                highest = math.max(highest, panel.Position.Y.Offset + panel.AbsoluteSize.Y)
            end
        end
        Categories.CanvasSize = UDim2.fromOffset(0, math.max(0, highest + 12))
    end)
end

local BLATANT_FALLBACK = {
    "Antifall.lua",
    "Fly.lua",
    "HighJump.lua",
    "InfiniteJump.lua",
    "Phase.lua",
    "Speed.lua",
    "Spider.lua"
}

local function getModuleFiles(category)
    local files = json(API .. "/" .. category)
    local result = {}

    if type(files) == "table" then
        for _, item in ipairs(files) do
            if item.type == "file"
                and type(item.name) == "string"
                and item.name:sub(-4):lower() == ".lua"
                and item.name:lower() ~= "init.lua"
                and item.name ~= "BlatantRuntime.lua"
                and item.name ~= "BlatantRuntimeV2.lua" then
                result[#result + 1] = item.name
            end
        end
    end

    if category == "Blatant" and #result < #BLATANT_FALLBACK then
        -- GitHub API can be rate-limited in some executors. Use the known module manifest.
        result = table.clone(BLATANT_FALLBACK)
    end

    table.sort(result, function(a, b)
        return a:lower() < b:lower()
    end)

    return result
end

local function attachCategory(categoryName)
    local panel = Categories:FindFirstChild(categoryName)
    local modulesFrame = panel and panel:FindFirstChild("Modules")
    if not panel or not modulesFrame then return end

    removeLegacySpeed(modulesFrame)

    local old = modulesFrame:FindFirstChild("LanternVapeRuntime")
    if old then old:Destroy() end

    local box = Instance.new("Frame")
    box.Name = "LanternVapeRuntime"
    box.Size = UDim2.new(1, 0, 0, 0)
    box.AutomaticSize = Enum.AutomaticSize.Y
    box.BackgroundTransparency = 1
    box.BorderSizePixel = 0
    box.ClipsDescendants = false
    box.ZIndex = 40
    box.Parent = modulesFrame

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 5)
    list.SortOrder = Enum.SortOrder.Name
    list.Parent = box

    local files = getModuleFiles(categoryName)
    local loaded = {}

    for _, filename in ipairs(files) do
        local module = loadModule("modules/" .. categoryName .. "/" .. filename)
        if module then
            makeModuleRow(box, module)
            loaded[#loaded + 1] = module.Name
        end
    end

    local function updateSize()
        resizeCategory(panel, modulesFrame, box)
        refreshCanvas()
    end

    box:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSize)
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)

    task.defer(updateSize)
    task.delay(.15, updateSize)

    print("[LanternVape] " .. categoryName .. ": " .. tostring(#loaded) .. " modules loaded")
end

local directories = json(API)
if type(directories) ~= "table" then
    warn("[LanternVape] Could not enumerate module folders.")
    return
end

for _, directory in ipairs(directories) do
    if directory.type == "dir" and type(directory.name) == "string" then
        attachCategory(directory.name)
    end
end

refreshCanvas()
print("[LanternVape] Modular runtime ready")
