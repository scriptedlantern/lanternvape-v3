-- LanternVape v2.10 UI patch
-- Loaded after the main UI so the full main.lua remains intact.
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local gui = player and player:FindFirstChild("PlayerGui")
local root = gui and gui:FindFirstChild("LanternVape")
if not root then return end

local orange = Color3.fromRGB(220,115,35)
local dark = Color3.fromRGB(21,21,21)
local black = Color3.fromRGB(8,8,8)
local white = Color3.fromRGB(245,245,245)
local gray = Color3.fromRGB(145,145,145)

local function corner(o,r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,r)
    c.Parent = o
end

local function stroke(o,c,t,w)
    local s = Instance.new("UIStroke")
    s.Color = c
    s.Transparency = t or 0
    s.Thickness = w or 1
    s.Parent = o
end

-- Replace the text fallback next to Search with a real image icon.
local main = root:FindFirstChild("Main")
local search = main and main:FindFirstChild("Search")
if search then
    local old = search:FindFirstChild("SearchFallback")
    if old then old:Destroy() end
    local icon = Instance.new("ImageLabel")
    icon.Name = "SearchIcon"
    icon.Size = UDim2.fromOffset(18,18)
    icon.Position = UDim2.fromOffset(10,8)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://6031154871"
    icon.ImageColor3 = gray
    icon.ScaleType = Enum.ScaleType.Fit
    icon.ZIndex = search.ZIndex + 1
    icon.Parent = search
end

-- Replace square/unrendered fallback glyphs with the actual sidebar icon assets.
local side = main and main:FindFirstChild("SideMenu")
local menu = side and side:FindFirstChild("Menu")
if menu then
    local ids = {
        Settings = "rbxassetid://6031280882",
        Profiles = "rbxassetid://6031075930",
        Targets = "rbxassetid://6031763426",
        Themes = "rbxassetid://6031094678",
        Keybinds = "rbxassetid://129697930",
        About = "rbxassetid://6031075930"
    }
    for name,id in pairs(ids) do
        local b = menu:FindFirstChild(name)
        if b then
            local f = b:FindFirstChildWhichIsA("TextLabel")
            if f and (f.Text == "⚙" or f.Text == "♙" or f.Text == "◎" or f.Text == "◆" or f.Text == "⌨") then
                f.Visible = false
            end
            local img = b:FindFirstChildWhichIsA("ImageLabel")
            if img then
                img.Image = id
                img.Visible = true
                img.ImageColor3 = orange
            end
        end
    end
end

-- Speed: guarantee a clean three-dot button instead of any missing glyph.
if main then
    local speedDots = main:FindFirstChild("SpeedDots", true)
    if speedDots and speedDots:IsA("TextButton") then
        speedDots.Text = "..."
        speedDots.TextSize = 15
        speedDots.TextColor3 = gray
        speedDots.Font = Enum.Font.GothamBold
    end
end

-- Replace Settings/Themes pages with an in-sidebar view.
if side then
    local oldView = side:FindFirstChild("V210SidebarView")
    if oldView then oldView:Destroy() end

    local regularChildren = {}
    for _,child in ipairs(side:GetChildren()) do
        if child.Name ~= "V210SidebarView" then
            regularChildren[child] = child.Visible
        end
    end

    local view = Instance.new("Frame")
    view.Name = "V210SidebarView"
    view.Size = UDim2.fromScale(1,1)
    view.BackgroundTransparency = 1
    view.Visible = false
    view.ZIndex = 100
    view.Parent = side

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1,0,0,58)
    header.BackgroundColor3 = black
    header.BackgroundTransparency = .02
    header.BorderSizePixel = 0
    header.ZIndex = 101
    header.Parent = view
    corner(header,7)
    stroke(header,orange,.45,1)

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1,-58,0,26)
    title.Position = UDim2.fromOffset(14,8)
    title.BackgroundTransparency = 1
    title.TextColor3 = white
    title.TextSize = 16
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 102
    title.Parent = header

    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1,-58,0,18)
    subtitle.Position = UDim2.fromOffset(14,33)
    subtitle.BackgroundTransparency = 1
    subtitle.TextColor3 = gray
    subtitle.TextSize = 10
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.ZIndex = 102
    subtitle.Parent = header

    local close = Instance.new("TextButton")
    close.Name = "Close"
    close.Size = UDim2.fromOffset(34,34)
    close.Position = UDim2.new(1,-42,0,12)
    close.BackgroundColor3 = Color3.fromRGB(150,60,20)
    close.BorderSizePixel = 0
    close.Text = "X"
    close.TextColor3 = white
    close.TextSize = 14
    close.Font = Enum.Font.GothamBold
    close.AutoButtonColor = false
    close.ZIndex = 103
    close.Parent = header
    corner(close,7)
    stroke(close,orange,.15,1)

    local body = Instance.new("ScrollingFrame")
    body.Name = "Body"
    body.Size = UDim2.new(1,0,1,-63)
    body.Position = UDim2.fromOffset(0,63)
    body.BackgroundTransparency = 1
    body.BorderSizePixel = 0
    body.ScrollBarThickness = 2
    body.ScrollBarImageColor3 = orange
    body.CanvasSize = UDim2.fromOffset(0,0)
    body.ZIndex = 101
    body.Parent = view

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0,5)
    layout.Parent = body

    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0,7)
    padding.PaddingRight = UDim.new(0,7)
    padding.PaddingTop = UDim.new(0,5)
    padding.Parent = body

    local function clearBody()
        for _,c in ipairs(body:GetChildren()) do
            if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end
        end
    end

    local function row(text,desc,order,callback)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1,0,0,50)
        b.BackgroundColor3 = dark
        b.BorderSizePixel = 0
        b.Text = ""
        b.LayoutOrder = order
        b.AutoButtonColor = false
        b.ZIndex = 102
        b.Parent = body
        corner(b,6)
        stroke(b,orange,.9,1)

        local t = Instance.new("TextLabel")
        t.Size = UDim2.new(1,-18,0,21)
        t.Position = UDim2.fromOffset(9,5)
        t.BackgroundTransparency = 1
        t.Text = text
        t.TextColor3 = white
        t.TextSize = 12
        t.Font = Enum.Font.GothamSemibold
        t.TextXAlignment = Enum.TextXAlignment.Left
        t.ZIndex = 103
        t.Parent = b

        local d = Instance.new("TextLabel")
        d.Size = UDim2.new(1,-18,0,17)
        d.Position = UDim2.fromOffset(9,27)
        d.BackgroundTransparency = 1
        d.Text = desc
        d.TextColor3 = gray
        d.TextSize = 9
        d.Font = Enum.Font.Gotham
        d.TextXAlignment = Enum.TextXAlignment.Left
        d.ZIndex = 103
        d.Parent = b

        b.MouseEnter:Connect(function() b.BackgroundColor3 = Color3.fromRGB(45,25,15) end)
        b.MouseLeave:Connect(function() b.BackgroundColor3 = dark end)
        if callback then b.MouseButton1Click:Connect(callback) end
        return b
    end

    local function showRegular()
        view.Visible = false
        for child,wasVisible in pairs(regularChildren) do
            if child and child.Parent == side then child.Visible = wasVisible end
        end
    end

    close.MouseButton1Click:Connect(showRegular)

    local function showView(name,sub,contentBuilder)
        for child in pairs(regularChildren) do
            if child and child.Parent == side then child.Visible = false end
        end
        view.Visible = true
        title.Text = name
        subtitle.Text = sub
        clearBody()
        contentBuilder()
        task.defer(function()
            body.CanvasSize = UDim2.fromOffset(0,layout.AbsoluteContentSize.Y + 10)
        end)
    end

    local function showSettings()
        showView("Settings","LanternVape configuration",function()
            row("GUI","Interface, scale and display options",1)
            row("Modules","Control which modules are visible",2)
            row("Credits","LanternVape contributors and acknowledgements",3)
        end)
    end

    local function showThemes()
        showView("Themes","Choose an accent color",function()
            local themes = {
                {"Orange",Color3.fromRGB(220,115,35)},
                {"Purple",Color3.fromRGB(150,85,220)},
                {"Blue",Color3.fromRGB(70,135,235)},
                {"Green",Color3.fromRGB(70,190,110)},
                {"Red",Color3.fromRGB(220,65,65)},
                {"Pink",Color3.fromRGB(220,85,155)}
            }
            for i,data in ipairs(themes) do
                local b = Instance.new("TextButton")
                b.Size = UDim2.new(1,0,0,38)
                b.BackgroundColor3 = dark
                b.BorderSizePixel = 0
                b.Text = ""
                b.LayoutOrder = i
                b.AutoButtonColor = false
                b.ZIndex = 102
                b.Parent = body
                corner(b,6)
                stroke(b,data[2],.7,1)

                local dot = Instance.new("Frame")
                dot.Size = UDim2.fromOffset(10,10)
                dot.Position = UDim2.fromOffset(10,14)
                dot.BackgroundColor3 = data[2]
                dot.BorderSizePixel = 0
                dot.ZIndex = 103
                dot.Parent = b
                corner(dot,10)

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1,-35,1,0)
                label.Position = UDim2.fromOffset(30,0)
                label.BackgroundTransparency = 1
                label.Text = data[1]
                label.TextColor3 = white
                label.TextSize = 11
                label.Font = Enum.Font.GothamSemibold
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.ZIndex = 103
                label.Parent = b

                b.MouseButton1Click:Connect(function()
                    local newOrange = data[2]
                    local newDark = newOrange:Lerp(Color3.new(0,0,0),.35)
                    for _,o in ipairs(root:GetDescendants()) do
                        if o:IsA("UIStroke") and o.Color ~= Color3.new(0,0,0) then o.Color = newOrange end
                        if o:IsA("ScrollingFrame") then o.ScrollBarImageColor3 = newOrange end
                        if o:IsA("Frame") and (o.Name == "BA" or o.Name == "SideAccent") then o.BackgroundColor3 = newOrange end
                    end
                    for _,o in ipairs(menu and menu:GetChildren() or {}) do
                        if o:IsA("TextButton") then o.BackgroundColor3 = dark end
                    end
                end)
            end
        end)
    end

    local settingsButton = menu and menu:FindFirstChild("Settings")
    local themesButton = menu and menu:FindFirstChild("Themes")
    if settingsButton then settingsButton.MouseButton1Click:Connect(showSettings) end
    if themesButton then themesButton.MouseButton1Click:Connect(showThemes) end
end

-- Mark the current UI version so the loader visibly reports the update.
local version = main and main:FindFirstChild("Footer",true) and main.Footer:FindFirstChild("Version")
if version and version:IsA("TextLabel") then version.Text = "v2.10" end
print("[LanternVape] UI update v2.10 applied")
