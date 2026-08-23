local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
if not Player then
    return
end

local PlayerGui = Player:WaitForChild("PlayerGui", 10)
if not PlayerGui then
    return
end

--==================================================
-- CONFIG
--==================================================

local Config = {
    Name = "LanternVape",
    Version = "1.0.1",

    -- Put your icon asset ID here
    Icon = "rbxassetid://0",

    LoadingTime = 2.2,

    Orange = Color3.fromRGB(220, 115, 35),
    OrangeDark = Color3.fromRGB(145, 68, 20),

    Black = Color3.fromRGB(8, 8, 8),
    Dark = Color3.fromRGB(14, 14, 14),
    Darker = Color3.fromRGB(21, 21, 21),

    White = Color3.fromRGB(235, 235, 235),
    Gray = Color3.fromRGB(145, 145, 145)
}

--==================================================
-- CLEAN OLD GUI
--==================================================

local OldGui = PlayerGui:FindFirstChild("LanternVape")

if OldGui then
    OldGui:Destroy()
end

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")

Gui.Name = "LanternVape"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Gui.Parent = PlayerGui

--==================================================
-- HELPERS
--==================================================

local function Tween(Object, Time, Properties)
    local Success, Result = pcall(function()
        return TweenService:Create(
            Object,
            TweenInfo.new(
                Time,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),
            Properties
        )
    end)

    if Success and Result then
        Result:Play()
    end
end

local function Corner(Object, Radius)
    local C = Instance.new("UICorner")

    C.CornerRadius = UDim.new(0, Radius)
    C.Parent = Object

    return C
end

local function Stroke(Object, Color, Transparency, Thickness)
    local S = Instance.new("UIStroke")

    S.Color = Color
    S.Transparency = Transparency or 0
    S.Thickness = Thickness or 1

    S.Parent = Object

    return S
end

--==================================================
-- LOADING SCREEN
--==================================================

local Loading = Instance.new("Frame")

Loading.Name = "Loading"
Loading.Size = UDim2.fromScale(1, 1)
Loading.Position = UDim2.fromScale(0, 0)

Loading.BackgroundColor3 = Config.Black
Loading.BackgroundTransparency = 0.08

Loading.BorderSizePixel = 0
Loading.ZIndex = 1000

Loading.Parent = Gui

-- Orange tint

local LoadingTint = Instance.new("Frame")

LoadingTint.Size = UDim2.fromScale(1, 1)

LoadingTint.BackgroundColor3 = Config.Orange
LoadingTint.BackgroundTransparency = 0.96

LoadingTint.BorderSizePixel = 0
LoadingTint.ZIndex = 1001

LoadingTint.Parent = Loading

-- Loading title

local LoadingTitle = Instance.new("TextLabel")

LoadingTitle.Size = UDim2.new(1, 0, 0, 50)
LoadingTitle.Position = UDim2.new(0, 0, 0.5, -35)

LoadingTitle.BackgroundTransparency = 1

LoadingTitle.Text = "LOADING LANTERNVAPE.."

LoadingTitle.TextColor3 = Config.Orange
LoadingTitle.TextSize = 25
LoadingTitle.Font = Enum.Font.GothamBold

LoadingTitle.ZIndex = 1002

LoadingTitle.Parent = Loading

-- Loading bar background

local LoadingBarBackground = Instance.new("Frame")

LoadingBarBackground.Size = UDim2.fromOffset(240, 4)

LoadingBarBackground.AnchorPoint = Vector2.new(0.5, 0)
LoadingBarBackground.Position = UDim2.new(0.5, 0, 0.5, 25)

LoadingBarBackground.BackgroundColor3 = Config.Darker
LoadingBarBackground.BorderSizePixel = 0

LoadingBarBackground.ZIndex = 1002

LoadingBarBackground.Parent = Loading

Corner(LoadingBarBackground, 10)

-- Loading bar

local LoadingBar = Instance.new("Frame")

LoadingBar.Size = UDim2.new(0, 0, 1, 0)

LoadingBar.BackgroundColor3 = Config.Orange
LoadingBar.BorderSizePixel = 0

LoadingBar.ZIndex = 1003

LoadingBar.Parent = Loading

Corner(LoadingBar, 10)

--==================================================
-- MAIN
--==================================================

local Main = Instance.new("Frame")

Main.Name = "Main"

Main.Size = UDim2.new(1, -30, 1, -30)
Main.Position = UDim2.fromOffset(15, 15)

Main.BackgroundTransparency = 1

Main.Visible = false

Main.Parent = Gui

-- Scale is used instead of changing column count

local UIScale = Instance.new("UIScale")

UIScale.Scale = 1

UIScale.Parent = Main

--==================================================
-- BRAND
--==================================================

local Brand = Instance.new("TextLabel")

Brand.Name = "Brand"

Brand.Size = UDim2.fromOffset(190, 42)
Brand.Position = UDim2.fromOffset(4, 4)

Brand.BackgroundColor3 = Config.Black
Brand.BackgroundTransparency = 0.05

Brand.BorderSizePixel = 0

Brand.Text = Config.Name

Brand.TextColor3 = Config.White
Brand.TextSize = 18
Brand.Font = Enum.Font.GothamBold

Brand.TextXAlignment = Enum.TextXAlignment.Left

Brand.Parent = Main

Corner(Brand, 5)

local BrandPadding = Instance.new("UIPadding")

BrandPadding.PaddingLeft = UDim.new(0, 14)

BrandPadding.Parent = Brand

local BrandAccent = Instance.new("Frame")

BrandAccent.Size = UDim2.new(1, 0, 0, 2)
BrandAccent.Position = UDim2.new(0, 0, 1, -2)

BrandAccent.BackgroundColor3 = Config.Orange
BrandAccent.BorderSizePixel = 0

BrandAccent.Parent = Brand

--==================================================
-- MENU BUTTON
--==================================================

local MenuButton = Instance.new("TextButton")

MenuButton.Name = "MenuButton"

MenuButton.Size = UDim2.fromOffset(42, 42)
MenuButton.Position = UDim2.fromOffset(202, 4)

MenuButton.BackgroundColor3 = Config.Black
MenuButton.BackgroundTransparency = 0.05

MenuButton.BorderSizePixel = 0

MenuButton.Text = "☰"

MenuButton.TextColor3 = Config.White
MenuButton.TextSize = 19
MenuButton.Font = Enum.Font.GothamBold

MenuButton.AutoButtonColor = false

MenuButton.Parent = Main

Corner(MenuButton, 5)

--==================================================
-- SEARCH
--==================================================

local Search = Instance.new("TextBox")

Search.Name = "Search"

Search.Size = UDim2.fromOffset(230, 34)

Search.AnchorPoint = Vector2.new(0.5, 0)

Search.Position = UDim2.new(0.5, 0, 0, 8)

Search.BackgroundColor3 = Config.Black
Search.BackgroundTransparency = 0.05

Search.BorderSizePixel = 0

Search.PlaceholderText = "Search..."
Search.PlaceholderColor3 = Color3.fromRGB(110, 110, 110)

Search.Text = ""

Search.TextColor3 = Config.White
Search.TextSize = 13
Search.Font = Enum.Font.Gotham

Search.ClearTextOnFocus = false

Search.Parent = Main

Corner(Search, 5)

Stroke(
    Search,
    Config.Orange,
    0.8,
    1
)

local SearchPadding = Instance.new("UIPadding")

SearchPadding.PaddingLeft = UDim.new(0, 12)

SearchPadding.Parent = Search

--==================================================
-- CLOSE
--==================================================

local CloseButton = Instance.new("TextButton")

CloseButton.Name = "Close"

CloseButton.Size = UDim2.fromOffset(42, 42)

CloseButton.Position = UDim2.new(1, -46, 0, 4)

CloseButton.BackgroundColor3 = Config.Black
CloseButton.BackgroundTransparency = 0.05

CloseButton.BorderSizePixel = 0

CloseButton.Text = "×"

CloseButton.TextColor3 = Config.White
CloseButton.TextSize = 25
CloseButton.Font = Enum.Font.Gotham

CloseButton.AutoButtonColor = false

CloseButton.Parent = Main

Corner(CloseButton, 5)

--==================================================
-- VERSION
--==================================================

local Version = Instance.new("TextLabel")

Version.Size = UDim2.fromOffset(90, 42)

Version.Position = UDim2.new(1, -142, 0, 4)

Version.BackgroundTransparency = 1

Version.Text = "v" .. Config.Version

Version.TextColor3 = Config.Gray
Version.TextSize = 12
Version.Font = Enum.Font.Gotham

Version.TextXAlignment = Enum.TextXAlignment.Right

Version.Parent = Main

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("ScrollingFrame")

Content.Name = "Categories"

Content.Size = UDim2.new(1, -8, 1, -62)

Content.Position = UDim2.fromOffset(4, 58)

Content.BackgroundTransparency = 1

Content.BorderSizePixel = 0

Content.ScrollBarThickness = 3

Content.ScrollBarImageColor3 = Config.Orange

Content.CanvasSize = UDim2.new(0, 0, 0, 0)

Content.AutomaticCanvasSize = Enum.AutomaticSize.Y

Content.ScrollingDirection = Enum.ScrollingDirection.Y

Content.Parent = Main

--==================================================
-- GRID
--==================================================

local Grid = Instance.new("UIGridLayout")

Grid.CellPadding = UDim2.fromOffset(7, 7)

-- ALWAYS FIVE COLUMNS

Grid.CellSize = UDim2.new(0.2, -7, 0, 115)

Grid.FillDirection = Enum.FillDirection.Horizontal

Grid.FillDirectionMaxCells = 5

Grid.SortOrder = Enum.SortOrder.LayoutOrder

Grid.Parent = Content

--==================================================
-- CATEGORIES
--==================================================

local Categories = {
    "Combat",
    "Blatant",
    "External",
    "Rendering",
    "Extra"
}

local CategoryPanels = {}

local function CreateCategory(Name, Order)

    local Panel = Instance.new("Frame")

    Panel.Name = Name

    Panel.LayoutOrder = Order

    Panel.BackgroundColor3 = Config.Black
    Panel.BackgroundTransparency = 0.12

    Panel.BorderSizePixel = 0

    Panel.Parent = Content

    Corner(Panel, 5)

    Stroke(
        Panel,
        Config.Orange,
        0.88,
        1
    )

    -- Header

    local Header = Instance.new("TextLabel")

    Header.Name = "Header"

    Header.Size = UDim2.new(1, 0, 0, 42)

    Header.BackgroundColor3 = Config.Black
    Header.BackgroundTransparency = 0.02

    Header.BorderSizePixel = 0

    Header.Text = Name

    Header.TextColor3 = Config.White

    Header.TextSize = 16

    Header.Font = Enum.Font.GothamBold

    Header.TextXAlignment = Enum.TextXAlignment.Left

    Header.Parent = Panel

    Corner(Header, 5)

    local Padding = Instance.new("UIPadding")

    Padding.PaddingLeft = UDim.new(0, 14)

    Padding.Parent = Header

    -- Accent

    local Accent = Instance.new("Frame")

    Accent.Size = UDim2.new(1, 0, 0, 2)

    Accent.Position = UDim2.new(0, 0, 1, -2)

    Accent.BackgroundColor3 = Config.Orange

    Accent.BackgroundTransparency = 0.15

    Accent.BorderSizePixel = 0

    Accent.Parent = Header

    -- Module area

    local Modules = Instance.new("Frame")

    Modules.Name = "Modules"

    Modules.Size = UDim2.new(1, 0, 1, -42)

    Modules.Position = UDim2.fromOffset(0, 42)

    Modules.BackgroundTransparency = 1

    Modules.Parent = Panel

    CategoryPanels[Name] = Panel

end

for Index, Name in ipairs(Categories) do
    CreateCategory(Name, Index)
end

--==================================================
-- SIDE MENU
--==================================================

local SideMenu = Instance.new("Frame")

SideMenu.Name = "SideMenu"

SideMenu.Size = UDim2.fromOffset(190, 330)

SideMenu.Position = UDim2.fromOffset(10, 58)

SideMenu.BackgroundColor3 = Config.Black
SideMenu.BackgroundTransparency = 0.02

SideMenu.BorderSizePixel = 0

SideMenu.Visible = false

SideMenu.ZIndex = 50

SideMenu.Parent = Main

Corner(SideMenu, 6)

Stroke(
    SideMenu,
    Config.Orange,
    0.65,
    1
)

-- Header

local SideHeader = Instance.new("TextLabel")

SideHeader.Size = UDim2.new(1, 0, 0, 50)

SideHeader.BackgroundColor3 = Config.Darker

SideHeader.BorderSizePixel = 0

SideHeader.Text = "LanternVape"

SideHeader.TextColor3 = Config.White

SideHeader.TextSize = 17

SideHeader.Font = Enum.Font.GothamBold

SideHeader.ZIndex = 51

SideHeader.Parent = SideMenu

Corner(SideHeader, 6)

-- Accent

local SideAccent = Instance.new("Frame")

SideAccent.Size = UDim2.new(1, 0, 0, 2)

SideAccent.Position = UDim2.new(0, 0, 1, -2)

SideAccent.BackgroundColor3 = Config.Orange

SideAccent.BorderSizePixel = 0

SideAccent.ZIndex = 52

SideAccent.Parent = SideHeader

-- List

local MenuList = Instance.new("UIListLayout")

MenuList.Padding = UDim.new(0, 4)

MenuList.SortOrder = Enum.SortOrder.LayoutOrder

MenuList.Parent = SideMenu

local MenuPadding = Instance.new("UIPadding")

MenuPadding.PaddingTop = UDim.new(0, 55)

MenuPadding.PaddingLeft = UDim.new(0, 5)

MenuPadding.PaddingRight = UDim.new(0, 5)

MenuPadding.Parent = SideMenu

local MenuItems = {
    {"⚙", "Settings"},
    {"♙", "Profiles"},
    {"◎", "Targets"},
    {"◆", "Themes"},
    {"⌨", "Keybinds"},
    {"?", "About"}
}

for Index, Data in ipairs(MenuItems) do

    local Button = Instance.new("TextButton")

    Button.Name = Data[2]

    Button.Size = UDim2.new(1, 0, 0, 38)

    Button.BackgroundColor3 = Config.Darker

    Button.BorderSizePixel = 0

    Button.Text = ""

    Button.AutoButtonColor = false

    Button.LayoutOrder = Index

    Button.ZIndex = 51

    Button.Parent = SideMenu

    Corner(Button, 4)

    local Icon = Instance.new("TextLabel")

    Icon.Size = UDim2.fromOffset(38, 38)

    Icon.BackgroundTransparency = 1

    Icon.Text = Data[1]

    Icon.TextColor3 = Config.Orange

    Icon.TextSize = 16

    Icon.Font = Enum.Font.GothamBold

    Icon.ZIndex = 52

    Icon.Parent = Button

    local Text = Instance.new("TextLabel")

    Text.Size = UDim2.new(1, -45, 1, 0)

    Text.Position = UDim2.fromOffset(42, 0)

    Text.BackgroundTransparency = 1

    Text.Text = Data[2]

    Text.TextColor3 = Config.White

    Text.TextSize = 13

    Text.Font = Enum.Font.GothamSemibold

    Text.TextXAlignment = Enum.TextXAlignment.Left

    Text.ZIndex = 52

    Text.Parent = Button

    Button.MouseEnter:Connect(function()

        Tween(
            Button,
            0.12,
            {
                BackgroundColor3 = Config.OrangeDark
            }
        )

    end)

    Button.MouseLeave:Connect(function()

        Tween(
            Button,
            0.12,
            {
                BackgroundColor3 = Config.Darker
            }
        )

    end)

end

--==================================================
-- MOBILE TOGGLE
--==================================================

local MobileToggle = Instance.new("ImageButton")

MobileToggle.Name = "MobileToggle"

MobileToggle.Size = UDim2.fromOffset(58, 58)

MobileToggle.Position = UDim2.new(0, 18, 0.5, -29)

MobileToggle.BackgroundColor3 = Config.Black
MobileToggle.BackgroundTransparency = 0.08

MobileToggle.BorderSizePixel = 0

MobileToggle.Image = Config.Icon

MobileToggle.ScaleType = Enum.ScaleType.Fit

MobileToggle.Visible = false

MobileToggle.ZIndex = 200

MobileToggle.Parent = Gui

Corner(MobileToggle, 12)

Stroke(
    MobileToggle,
    Config.Orange,
    0.15,
    2
)

local ToggleFallback = Instance.new("TextLabel")

ToggleFallback.Size = UDim2.fromScale(1, 1)

ToggleFallback.BackgroundTransparency = 1

ToggleFallback.Text = "LV"

ToggleFallback.TextColor3 = Config.Orange

ToggleFallback.TextSize = 18

ToggleFallback.Font = Enum.Font.GothamBold

ToggleFallback.ZIndex = 201

ToggleFallback.Parent = MobileToggle

if Config.Icon ~= "rbxassetid://0" then
    ToggleFallback.Visible = false
end

--==================================================
-- TOGGLE
--==================================================

local function ToggleMain()

    Main.Visible = not Main.Visible

    if not Main.Visible then
        SideMenu.Visible = false
    end

end

MenuButton.MouseButton1Click:Connect(function()

    SideMenu.Visible = not SideMenu.Visible

end)

CloseButton.MouseButton1Click:Connect(function()

    Main.Visible = false
    SideMenu.Visible = false

end)

MobileToggle.MouseButton1Click:Connect(function()

    ToggleMain()

end)

--==================================================
-- SHIFT
--==================================================

UserInputService.InputBegan:Connect(function(Input, Processed)

    if Processed then
        return
    end

    if Input.KeyCode == Enum.KeyCode.LeftShift
        or Input.KeyCode == Enum.KeyCode.RightShift then

        ToggleMain()

    end

end)

--==================================================
-- SEARCH
--==================================================

Search:GetPropertyChangedSignal("Text"):Connect(function()

    local Query = string.lower(Search.Text)

    for Name, Panel in pairs(CategoryPanels) do

        if Query == "" then

            Panel.Visible = true

        else

            Panel.Visible =
                string.find(
                    string.lower(Name),
                    Query,
                    1,
                    true
                ) ~= nil

        end

    end

end)

--==================================================
-- DRAGGING
--==================================================

local Dragging = false
local DragStart
local StartPosition

Brand.InputBegan:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true

        DragStart = Input.Position

        StartPosition = Main.Position

    end

end)

UserInputService.InputEnded:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false

    end

end)

UserInputService.InputChanged:Connect(function(Input)

    if not Dragging then
        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch then

        local Delta = Input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,

            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )

    end

end)

--==================================================
-- RESPONSIVE
-- FIVE COLUMNS EVERYWHERE
--==================================================

local Camera = workspace.CurrentCamera

local function UpdateLayout()

    Camera = workspace.CurrentCamera or Camera

    if not Camera then
        return
    end

    -- NEVER change this on mobile

    Grid.FillDirectionMaxCells = 5

    Grid.CellSize = UDim2.new(
        0.2,
        -7,
        0,
        115
    )

    local Width = Camera.ViewportSize.X

    if Width < 500 then

        UIScale.Scale = 0.55

    elseif Width < 650 then

        UIScale.Scale = 0.65

    elseif Width < 800 then

        UIScale.Scale = 0.75

    elseif Width < 1000 then

        UIScale.Scale = 0.85

    else

        UIScale.Scale = 1

    end

end

UpdateLayout()

if Camera then

    Camera:GetPropertyChangedSignal(
        "ViewportSize"
    ):Connect(UpdateLayout)

end

--==================================================
-- LOADING
-- IMPORTANT:
-- MAIN GUI HAS ALREADY BEEN CREATED
-- BEFORE ANY WAIT.
--==================================================

Tween(
    LoadingBar,
    Config.LoadingTime,
    {
        Size = UDim2.new(1, 0, 1, 0)
    }
)

task.wait(Config.LoadingTime)

-- Show GUI

Main.Visible = true

-- Mobile toggle

if UserInputService.TouchEnabled then
    MobileToggle.Visible = true
end

-- Fade loading screen

Tween(
    Loading,
    0.35,
    {
        BackgroundTransparency = 1
    }
)

Tween(
    LoadingTint,
    0.35,
    {
        BackgroundTransparency = 1
    }
)

Tween(
    LoadingTitle,
    0.35,
    {
        TextTransparency = 1
    }
)

Tween(
    LoadingBarBackground,
    0.35,
    {
        BackgroundTransparency = 1
    }
)

Tween(
    LoadingBar,
    0.35,
    {
        BackgroundTransparency = 1
    }
)

task.wait(0.4)

if Loading and Loading.Parent then
    Loading:Destroy()
end

print(
    "[" .. Config.Name .. "] Loaded " .. Config.Version
)
