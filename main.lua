local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")

local Player = Players.LocalPlayer
if not Player then return end

local PlayerGui = Player:WaitForChild("PlayerGui", 10)
if not PlayerGui then return end

--==================================================
-- CONFIG
--==================================================

local Config = {
    Name = "LanternVape",
    Version = "2.00",

    -- Put your image asset IDs here.
    Icon = "rbxassetid://0",
    MenuIcon = "rbxassetid://0",
    CloseIcon = "rbxassetid://0",
    SearchIcon = "rbxassetid://0",
    SettingsIcon = "rbxassetid://0",
    ProfilesIcon = "rbxassetid://0",
    TargetsIcon = "rbxassetid://0",
    ThemesIcon = "rbxassetid://0",
    KeybindsIcon = "rbxassetid://0",
    AboutIcon = "rbxassetid://0",

    LoadingTime = 2.2,

    Orange = Color3.fromRGB(220, 115, 35),
    OrangeDark = Color3.fromRGB(145, 68, 20),
    Black = Color3.fromRGB(8, 8, 8),
    Dark = Color3.fromRGB(14, 14, 14),
    Darker = Color3.fromRGB(21, 21, 21),
    White = Color3.fromRGB(235, 235, 235),
    Gray = Color3.fromRGB(145, 145, 145)
}

local OldGui = PlayerGui:FindFirstChild("LanternVape")
if OldGui then OldGui:Destroy() end

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
        return TweenService:Create(Object, TweenInfo.new(Time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), Properties)
    end)
    if Success and Result then Result:Play() end
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

local function HasIcon(Value)
    return typeof(Value) == "string" and Value ~= "" and Value ~= "rbxassetid://0"
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

local LoadingTint = Instance.new("Frame")
LoadingTint.Size = UDim2.fromScale(1, 1)
LoadingTint.BackgroundColor3 = Config.Orange
LoadingTint.BackgroundTransparency = 0.96
LoadingTint.BorderSizePixel = 0
LoadingTint.ZIndex = 1001
LoadingTint.Parent = Loading

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

local LoadingBarBackground = Instance.new("Frame")
LoadingBarBackground.Size = UDim2.fromOffset(240, 4)
LoadingBarBackground.AnchorPoint = Vector2.new(0.5, 0)
LoadingBarBackground.Position = UDim2.new(0.5, 0, 0.5, 25)
LoadingBarBackground.BackgroundColor3 = Config.Darker
LoadingBarBackground.BorderSizePixel = 0
LoadingBarBackground.ZIndex = 1002
LoadingBarBackground.Parent = Loading
Corner(LoadingBarBackground, 10)

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

local UIScale = Instance.new("UIScale")
UIScale.Scale = 1
UIScale.Parent = Main

--==================================================
-- HEADER
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

local MenuButton = Instance.new("ImageButton")
MenuButton.Name = "MenuButton"
MenuButton.Size = UDim2.fromOffset(42, 42)
MenuButton.Position = UDim2.fromOffset(202, 4)
MenuButton.BackgroundColor3 = Config.Black
MenuButton.BackgroundTransparency = 0.05
MenuButton.BorderSizePixel = 0
MenuButton.AutoButtonColor = false
MenuButton.Parent = Main
Corner(MenuButton, 5)

local MenuFallback = Instance.new("TextLabel")
MenuFallback.Size = UDim2.fromScale(1, 1)
MenuFallback.BackgroundTransparency = 1
MenuFallback.Text = "☰"
MenuFallback.TextColor3 = Config.White
MenuFallback.TextSize = 19
MenuFallback.Font = Enum.Font.GothamBold
MenuFallback.Parent = MenuButton
if HasIcon(Config.MenuIcon) then
    MenuButton.Image = Config.MenuIcon
    MenuFallback.Visible = false
end

local Search = Instance.new("TextBox")
Search.Name = "Search"
Search.Size = UDim2.fromOffset(230, 34)
Search.AnchorPoint = Vector2.new(0.5, 0)
Search.Position = UDim2.new(0.5, 0, 0, 8)
Search.BackgroundColor3 = Config.Black
Search.BackgroundTransparency = 0.05
Search.BorderSizePixel = 0
Search.PlaceholderText = "Search.."
Search.PlaceholderColor3 = Color3.fromRGB(110, 110, 110)
Search.Text = ""
Search.TextColor3 = Config.White
Search.TextSize = 13
Search.Font = Enum.Font.Gotham
Search.ClearTextOnFocus = false
Search.Parent = Main
Corner(Search, 5)
Stroke(Search, Config.Orange, 0.8, 1)

local SearchPadding = Instance.new("UIPadding")
SearchPadding.PaddingLeft = UDim.new(0, 38)
SearchPadding.Parent = Search

local SearchIcon = Instance.new("ImageLabel")
SearchIcon.Size = UDim2.fromOffset(17, 17)
SearchIcon.Position = UDim2.fromOffset(11, 8)
SearchIcon.BackgroundTransparency = 1
SearchIcon.ImageColor3 = Config.Gray
SearchIcon.Parent = Search

local SearchFallback = Instance.new("TextLabel")
SearchFallback.Size = UDim2.fromOffset(20, 20)
SearchFallback.Position = UDim2.fromOffset(9, 7)
SearchFallback.BackgroundTransparency = 1
SearchFallback.Text = "⌕"
SearchFallback.TextColor3 = Config.Gray
SearchFallback.TextSize = 18
SearchFallback.Font = Enum.Font.Gotham
SearchFallback.Parent = Search
if HasIcon(Config.SearchIcon) then
    SearchIcon.Image = Config.SearchIcon
    SearchFallback.Visible = false
else
    SearchIcon.Visible = false
end

local CloseButton = Instance.new("ImageButton")
CloseButton.Name = "Close"
CloseButton.Size = UDim2.fromOffset(42, 42)
CloseButton.Position = UDim2.new(1, -46, 0, 4)
CloseButton.BackgroundColor3 = Config.Black
CloseButton.BackgroundTransparency = 0.05
CloseButton.BorderSizePixel = 0
CloseButton.AutoButtonColor = false
CloseButton.Parent = Main
Corner(CloseButton, 5)

local CloseFallback = Instance.new("TextLabel")
CloseFallback.Size = UDim2.fromScale(1, 1)
CloseFallback.BackgroundTransparency = 1
CloseFallback.Text = "×"
CloseFallback.TextColor3 = Config.White
CloseFallback.TextSize = 25
CloseFallback.Font = Enum.Font.Gotham
CloseFallback.Parent = CloseButton
if HasIcon(Config.CloseIcon) then
    CloseButton.Image = Config.CloseIcon
    CloseFallback.Visible = false
end

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
-- CONTENT / FIVE COLUMNS
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
Content.AutomaticCanvasSize = Enum.AutomaticSize.None
Content.ScrollingDirection = Enum.ScrollingDirection.Y
Content.Parent = Main

local Grid = Instance.new("UIGridLayout")
Grid.CellPadding = UDim2.fromOffset(7, 7)
Grid.CellSize = UDim2.new(0.2, -7, 0, 115)
Grid.FillDirection = Enum.FillDirection.Horizontal
Grid.FillDirectionMaxCells = 5
Grid.SortOrder = Enum.SortOrder.LayoutOrder
Grid.Parent = Content
Grid.Enabled = false

local Categories = {"Combat", "Blatant", "External", "Rendering", "Extra"}
local CategoryPanels = {}
local CategoryAccents = {}
local CategoryMoved = {}

local function CreateCategory(Name, Order)
    local Panel = Instance.new("Frame")
    Panel.Name = Name
    Panel.LayoutOrder = Order
    Panel.BackgroundColor3 = Config.Black
    Panel.BackgroundTransparency = 0.12
    Panel.BorderSizePixel = 0
    Panel.Parent = Content
    Corner(Panel, 5)
    Stroke(Panel, Config.Orange, 0.88, 1)

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

    local Accent = Instance.new("Frame")
    Accent.Size = UDim2.new(1, 0, 0, 2)
    Accent.Position = UDim2.new(0, 0, 1, -2)
    Accent.BackgroundColor3 = Config.Orange
    Accent.BackgroundTransparency = 0.15
    Accent.BorderSizePixel = 0
    Accent.Parent = Header
    CategoryAccents[Name] = Accent

    local Modules = Instance.new("Frame")
    Modules.Name = "Modules"
    Modules.Size = UDim2.new(1, 0, 1, -42)
    Modules.Position = UDim2.fromOffset(0, 42)
    Modules.BackgroundTransparency = 1
    Modules.Parent = Panel

    CategoryPanels[Name] = Panel

    Header.Active = true
    local DraggingCategory = false
    local DragStart = nil
    local StartPosition = nil

    Header.InputBegan:Connect(function(Input)
        if Input.UserInputType ~= Enum.UserInputType.MouseButton1
            and Input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        DraggingCategory = true
        DragStart = Input.Position
        StartPosition = Panel.Position
        Panel.ZIndex = 20
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if not DraggingCategory then return end
        if Input.UserInputType ~= Enum.UserInputType.MouseMovement
            and Input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        local Delta = Input.Position - DragStart
        Panel.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
        CategoryMoved[Name] = true
    end)

    UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1
            or Input.UserInputType == Enum.UserInputType.Touch then
            DraggingCategory = false
            Panel.ZIndex = 1
        end
    end)
end

for Index, Name in ipairs(Categories) do
    CreateCategory(Name, Index)
end

--==================================================
-- SIDE MENU
--==================================================

local SideMenu = Instance.new("Frame")
SideMenu.Name = "SideMenu"
SideMenu.Size = UDim2.fromOffset(245, 390)
SideMenu.Position = UDim2.fromOffset(10, 58)
SideMenu.BackgroundColor3 = Config.Black
SideMenu.BackgroundTransparency = 0.02
SideMenu.BorderSizePixel = 0
SideMenu.Visible = false
SideMenu.ZIndex = 50
SideMenu.Parent = Main
Corner(SideMenu, 7)
local SideMenuStroke = Stroke(SideMenu, Config.Orange, 0.55, 1)

local SideHeader = Instance.new("Frame")
SideHeader.Size = UDim2.new(1, 0, 0, 58)
SideHeader.BackgroundColor3 = Config.Darker
SideHeader.BorderSizePixel = 0
SideHeader.ZIndex = 51
SideHeader.Parent = SideMenu
Corner(SideHeader, 7)

local SideTitle = Instance.new("TextLabel")
SideTitle.Size = UDim2.new(1, -20, 0, 26)
SideTitle.Position = UDim2.fromOffset(14, 8)
SideTitle.BackgroundTransparency = 1
SideTitle.Text = "LanternVape"
SideTitle.TextColor3 = Config.White
SideTitle.TextSize = 17
SideTitle.Font = Enum.Font.GothamBold
SideTitle.TextXAlignment = Enum.TextXAlignment.Left
SideTitle.ZIndex = 52
SideTitle.Parent = SideHeader

local SideSubtitle = Instance.new("TextLabel")
SideSubtitle.Size = UDim2.new(1, -20, 0, 18)
SideSubtitle.Position = UDim2.fromOffset(14, 33)
SideSubtitle.BackgroundTransparency = 1
SideSubtitle.Text = "Control Panel"
SideSubtitle.TextColor3 = Config.Gray
SideSubtitle.TextSize = 11
SideSubtitle.Font = Enum.Font.Gotham
SideSubtitle.TextXAlignment = Enum.TextXAlignment.Left
SideSubtitle.ZIndex = 52
SideSubtitle.Parent = SideHeader

local SideAccent = Instance.new("Frame")
SideAccent.Size = UDim2.new(1, -20, 0, 2)
SideAccent.Position = UDim2.new(0, 10, 1, -2)
SideAccent.BackgroundColor3 = Config.Orange
SideAccent.BorderSizePixel = 0
SideAccent.ZIndex = 53
SideAccent.Parent = SideHeader

local MenuList = Instance.new("UIListLayout")
MenuList.Padding = UDim.new(0, 5)
MenuList.SortOrder = Enum.SortOrder.LayoutOrder
MenuList.Parent = SideMenu

local MenuPadding = Instance.new("UIPadding")
MenuPadding.PaddingTop = UDim.new(0, 67)
MenuPadding.PaddingLeft = UDim.new(0, 7)
MenuPadding.PaddingRight = UDim.new(0, 7)
MenuPadding.Parent = SideMenu

local MenuItems = {
    {"⚙", "Settings", Config.SettingsIcon},
    {"♙", "Profiles", Config.ProfilesIcon},
    {"◎", "Targets", Config.TargetsIcon},
    {"◆", "Themes", Config.ThemesIcon},
    {"⌨", "Keybinds", Config.KeybindsIcon},
    {"?", "About", Config.AboutIcon}
}

local MenuButtons = {}

for Index, Data in ipairs(MenuItems) do
    local Button = Instance.new("TextButton")
    Button.Name = Data[2]
    Button.Size = UDim2.new(1, 0, 0, 42)
    Button.BackgroundColor3 = Config.Darker
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.LayoutOrder = Index
    Button.ZIndex = 51
    Button.Parent = SideMenu
    Corner(Button, 5)

    local Icon = Instance.new("ImageLabel")
    Icon.Size = UDim2.fromOffset(19, 19)
    Icon.Position = UDim2.fromOffset(12, 11)
    Icon.BackgroundTransparency = 1
    Icon.ImageColor3 = Config.Orange
    Icon.ZIndex = 52
    Icon.Parent = Button

    local IconFallback = Instance.new("TextLabel")
    IconFallback.Size = UDim2.fromOffset(22, 22)
    IconFallback.Position = UDim2.fromOffset(10, 10)
    IconFallback.BackgroundTransparency = 1
    IconFallback.Text = Data[1]
    IconFallback.TextColor3 = Config.Orange
    IconFallback.TextSize = 16
    IconFallback.Font = Enum.Font.GothamBold
    IconFallback.ZIndex = 52
    IconFallback.Parent = Button

    if HasIcon(Data[3]) then
        Icon.Image = Data[3]
        IconFallback.Visible = false
    else
        Icon.Visible = false
    end

    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(1, -55, 1, 0)
    Text.Position = UDim2.fromOffset(45, 0)
    Text.BackgroundTransparency = 1
    Text.Text = Data[2]
    Text.TextColor3 = Config.White
    Text.TextSize = 13
    Text.Font = Enum.Font.GothamSemibold
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.ZIndex = 52
    Text.Parent = Button

    MenuButtons[Data[2]] = Button

    Button.MouseEnter:Connect(function()
        Tween(Button, 0.12, {BackgroundColor3 = Config.OrangeDark})
    end)
    Button.MouseLeave:Connect(function()
        Tween(Button, 0.12, {BackgroundColor3 = Config.Darker})
    end)
end

--==================================================
-- SETTINGS / THEMES
--==================================================

local CategoryEnabled = {
    Combat = true,
    Blatant = true,
    External = true,
    Rendering = true,
    Extra = true
}

local SettingsPanel = Instance.new("Frame")
SettingsPanel.Name = "SettingsPanel"
SettingsPanel.Size = UDim2.fromOffset(360, 390)
SettingsPanel.Position = UDim2.fromOffset(263, 58)
SettingsPanel.BackgroundColor3 = Config.Black
SettingsPanel.BackgroundTransparency = 0.02
SettingsPanel.BorderSizePixel = 0
SettingsPanel.Visible = false
SettingsPanel.ZIndex = 80
SettingsPanel.Parent = Main
Corner(SettingsPanel, 7)
Stroke(SettingsPanel, Config.Orange, 0.55, 1)

local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Size = UDim2.new(1, -30, 0, 35)
SettingsTitle.Position = UDim2.fromOffset(15, 10)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Text = "Settings"
SettingsTitle.TextColor3 = Config.White
SettingsTitle.TextSize = 18
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
SettingsTitle.ZIndex = 81
SettingsTitle.Parent = SettingsPanel

local SettingsSub = Instance.new("TextLabel")
SettingsSub.Size = UDim2.new(1, -30, 0, 22)
SettingsSub.Position = UDim2.fromOffset(15, 40)
SettingsSub.BackgroundTransparency = 1
SettingsSub.Text = "Choose which categories are visible"
SettingsSub.TextColor3 = Config.Gray
SettingsSub.TextSize = 11
SettingsSub.Font = Enum.Font.Gotham
SettingsSub.TextXAlignment = Enum.TextXAlignment.Left
SettingsSub.ZIndex = 81
SettingsSub.Parent = SettingsPanel

local SettingsList = Instance.new("UIListLayout")
SettingsList.Padding = UDim.new(0, 5)
SettingsList.SortOrder = Enum.SortOrder.LayoutOrder
SettingsList.Parent = SettingsPanel

local SettingsPadding = Instance.new("UIPadding")
SettingsPadding.PaddingTop = UDim.new(0, 70)
SettingsPadding.PaddingLeft = UDim.new(0, 12)
SettingsPadding.PaddingRight = UDim.new(0, 12)
SettingsPadding.Parent = SettingsPanel

local function CreateToggle(parent, TextValue, order, initial, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 36)
    Button.BackgroundColor3 = Config.Darker
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.LayoutOrder = order
    Button.ZIndex = 82
    Button.Parent = parent
    Corner(Button, 5)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -65, 1, 0)
    Label.Position = UDim2.fromOffset(12, 0)
    Label.BackgroundTransparency = 1
    Label.Text = TextValue
    Label.TextColor3 = Config.White
    Label.TextSize = 12
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 83
    Label.Parent = Button

    local Switch = Instance.new("Frame")
    Switch.Size = UDim2.fromOffset(34, 18)
    Switch.Position = UDim2.new(1, -47, 0.5, -9)
    Switch.BorderSizePixel = 0
    Switch.ZIndex = 83
    Switch.Parent = Button
    Corner(Switch, 20)

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.fromOffset(14, 14)
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 84
    Knob.Parent = Switch
    Corner(Knob, 20)

    local state = initial
    local function render()
        Switch.BackgroundColor3 = state and Config.Orange or Config.Darker
        Knob.BackgroundColor3 = Config.White
        Knob.Position = state and UDim2.fromOffset(18, 2) or UDim2.fromOffset(2, 2)
    end
    render()

    Button.MouseButton1Click:Connect(function()
        state = not state
        render()
        callback(state)
    end)
end

for Index, Name in ipairs(Categories) do
    CreateToggle(SettingsPanel, "Show " .. Name, Index, true, function(enabled)
        CategoryEnabled[Name] = enabled
        CategoryPanels[Name].Visible = enabled
    end)
end

CreateToggle(SettingsPanel, "Show LanternVape button", #Categories + 1, true, function(enabled)
    MobileToggle.Visible = enabled and UserInputService.TouchEnabled
end)

local ThemesPanel = Instance.new("Frame")
ThemesPanel.Name = "ThemesPanel"
ThemesPanel.Size = UDim2.fromOffset(360, 250)
ThemesPanel.Position = UDim2.fromOffset(263, 58)
ThemesPanel.BackgroundColor3 = Config.Black
ThemesPanel.BackgroundTransparency = 0.02
ThemesPanel.BorderSizePixel = 0
ThemesPanel.Visible = false
ThemesPanel.ZIndex = 80
ThemesPanel.Parent = Main
Corner(ThemesPanel, 7)
Stroke(ThemesPanel, Config.Orange, 0.55, 1)

local ThemesTitle = Instance.new("TextLabel")
ThemesTitle.Size = UDim2.new(1, -30, 0, 35)
ThemesTitle.Position = UDim2.fromOffset(15, 10)
ThemesTitle.BackgroundTransparency = 1
ThemesTitle.Text = "Themes"
ThemesTitle.TextColor3 = Config.White
ThemesTitle.TextSize = 18
ThemesTitle.Font = Enum.Font.GothamBold
ThemesTitle.TextXAlignment = Enum.TextXAlignment.Left
ThemesTitle.ZIndex = 81
ThemesTitle.Parent = ThemesPanel

local ThemesSub = Instance.new("TextLabel")
ThemesSub.Size = UDim2.new(1, -30, 0, 22)
ThemesSub.Position = UDim2.fromOffset(15, 40)
ThemesSub.BackgroundTransparency = 1
ThemesSub.Text = "Choose an accent color"
ThemesSub.TextColor3 = Config.Gray
ThemesSub.TextSize = 11
ThemesSub.Font = Enum.Font.Gotham
ThemesSub.TextXAlignment = Enum.TextXAlignment.Left
ThemesSub.ZIndex = 81
ThemesSub.Parent = ThemesPanel

local ThemeGrid = Instance.new("UIGridLayout")
ThemeGrid.CellSize = UDim2.fromOffset(105, 38)
ThemeGrid.CellPadding = UDim2.fromOffset(7, 7)
ThemeGrid.Parent = ThemesPanel

local ThemePadding = Instance.new("UIPadding")
ThemePadding.PaddingTop = UDim.new(0, 72)
ThemePadding.PaddingLeft = UDim.new(0, 12)
ThemePadding.PaddingRight = UDim.new(0, 12)
ThemePadding.Parent = ThemesPanel

local ThemeColors = {
    Orange = Color3.fromRGB(220, 115, 35),
    Purple = Color3.fromRGB(150, 85, 220),
    Blue = Color3.fromRGB(70, 135, 235),
    Green = Color3.fromRGB(70, 190, 110),
    Red = Color3.fromRGB(220, 65, 65),
    Pink = Color3.fromRGB(220, 85, 155)
}

local function ApplyTheme(Color)
    local OldAccent = Config.Orange
    local OldDark = Config.OrangeDark

    Config.Orange = Color
    Config.OrangeDark = Color:Lerp(Color3.new(0, 0, 0), 0.35)

    local function Recolor(Object)
        if not Object or not Object.Parent then return end

        pcall(function()
            if Object:IsA("GuiObject") then
                if Object.BackgroundColor3 == OldAccent or Object.BackgroundColor3 == OldDark then
                    Object.BackgroundColor3 = Color
                end
                if Object:IsA("TextLabel") or Object:IsA("TextButton") or Object:IsA("TextBox") then
                    if Object.TextColor3 == OldAccent or Object.TextColor3 == OldDark then
                        Object.TextColor3 = Color
                    end
                end
                if Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
                    if Object.ImageColor3 == OldAccent or Object.ImageColor3 == OldDark then
                        Object.ImageColor3 = Color
                    end
                end
            end
            if Object:IsA("UIStroke") and (Object.Color == OldAccent or Object.Color == OldDark) then
                Object.Color = Color
            end
            if Object:IsA("ScrollingFrame") and Object.ScrollBarImageColor3 == OldAccent then
                Object.ScrollBarImageColor3 = Color
            end
        end)

        for _, Child in ipairs(Object:GetChildren()) do
            Recolor(Child)
        end
    end

    Recolor(Main)
    Recolor(MobileToggle)
end

for Name, Color in pairs(ThemeColors) do
    local Button = Instance.new("TextButton")
    Button.Name = Name
    Button.BackgroundColor3 = Config.Darker
    Button.BorderSizePixel = 0
    Button.Text = Name
    Button.TextColor3 = Config.White
    Button.TextSize = 12
    Button.Font = Enum.Font.GothamSemibold
    Button.AutoButtonColor = false
    Button.ZIndex = 82
    Button.Parent = ThemesPanel
    Corner(Button, 5)

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.fromOffset(10, 10)
    Dot.Position = UDim2.fromOffset(9, 14)
    Dot.BackgroundColor3 = Color
    Dot.BorderSizePixel = 0
    Dot.ZIndex = 83
    Dot.Parent = Button
    Corner(Dot, 20)

    local Pad = Instance.new("UIPadding")
    Pad.PaddingRight = UDim.new(0, 9)
    Pad.Parent = Button
    Button.TextXAlignment = Enum.TextXAlignment.Right

    Button.MouseButton1Click:Connect(function()
        ApplyTheme(Color)
    end)
end

local function CloseExtraPanels()
    SettingsPanel.Visible = false
    ThemesPanel.Visible = false
end

MenuButtons.Settings.MouseButton1Click:Connect(function()
    SettingsPanel.Visible = not SettingsPanel.Visible
    ThemesPanel.Visible = false
end)

MenuButtons.Themes.MouseButton1Click:Connect(function()
    ThemesPanel.Visible = not ThemesPanel.Visible
    SettingsPanel.Visible = false
end)

for Name, Button in pairs(MenuButtons) do
    if Name ~= "Settings" and Name ~= "Themes" then
        Button.MouseButton1Click:Connect(function()
            CloseExtraPanels()
            SideMenu.Visible = false
        end)
    end
end

--==================================================
-- MOBILE TOGGLE
--==================================================

local MobileToggle = Instance.new("ImageButton")
MobileToggle.Name = "MobileToggle"
MobileToggle.Size = UDim2.fromOffset(52, 52)
MobileToggle.AnchorPoint = Vector2.new(1, 0)
MobileToggle.Position = UDim2.new(1, -16, 0, 16)
MobileToggle.BackgroundColor3 = Config.Black
MobileToggle.BackgroundTransparency = 0.08
MobileToggle.BorderSizePixel = 0
MobileToggle.ScaleType = Enum.ScaleType.Fit
MobileToggle.Visible = false
MobileToggle.ZIndex = 200
MobileToggle.Parent = Gui
Corner(MobileToggle, 12)
local MobileStroke = Stroke(MobileToggle, Config.Orange, 0.15, 2)

if HasIcon(Config.Icon) then
    MobileToggle.Image = Config.Icon
else
    local ToggleFallback = Instance.new("TextLabel")
    ToggleFallback.Size = UDim2.fromScale(1, 1)
    ToggleFallback.BackgroundTransparency = 1
    ToggleFallback.Text = "LV"
    ToggleFallback.TextColor3 = Config.Orange
    ToggleFallback.TextSize = 18
    ToggleFallback.Font = Enum.Font.GothamBold
    ToggleFallback.ZIndex = 201
    ToggleFallback.Parent = MobileToggle
end

--==================================================
-- TOGGLE / SEARCH / DRAG
--==================================================

local function ToggleMain()
    Main.Visible = not Main.Visible
    if not Main.Visible then
        SideMenu.Visible = false
        CloseExtraPanels()
    end
end

MenuButton.MouseButton1Click:Connect(function()
    SideMenu.Visible = not SideMenu.Visible
    if not SideMenu.Visible then CloseExtraPanels() end
end)

CloseButton.MouseButton1Click:Connect(function()
    Main.Visible = false
    SideMenu.Visible = false
    CloseExtraPanels()
end)

MobileToggle.MouseButton1Click:Connect(ToggleMain)

UserInputService.InputBegan:Connect(function(Input, Processed)
    if Processed then return end
    if Input.KeyCode == Enum.KeyCode.LeftShift or Input.KeyCode == Enum.KeyCode.RightShift then
        ToggleMain()
    end
end)

Search:GetPropertyChangedSignal("Text"):Connect(function()
    local Query = string.lower(Search.Text)
    for Name, Panel in pairs(CategoryPanels) do
        if not CategoryEnabled[Name] then
            Panel.Visible = false
        elseif Query == "" then
            Panel.Visible = true
        else
            Panel.Visible = string.find(string.lower(Name), Query, 1, true) ~= nil
        end
    end
end)

--==================================================
-- MANUAL CATEGORY LAYOUT / SAFE AREA
--==================================================

local function UpdateSafeArea()
    local TopLeft, BottomRight = GuiService:GetGuiInset()
    local Top = TopLeft.Y
    local Bottom = BottomRight.Y

    Main.Position = UDim2.fromOffset(15, 15 + Top)
    Main.Size = UDim2.new(1, -30, 1, -30 - Top - Bottom)

    if UserInputService.TouchEnabled then
        MobileToggle.Position = UDim2.new(1, -16, 0, 16 + Top)
    end
end

local function LayoutCategories()
    local Width = Content.AbsoluteSize.X
    if Width <= 0 then return end

    local Gap = 7
    local Columns = 5
    local CellWidth = math.max(1, (Width - Gap * (Columns - 1)) / Columns)
    local CellHeight = 115

    for Index, Name in ipairs(Categories) do
        local Panel = CategoryPanels[Name]
        if Panel and not CategoryMoved[Name] then
            local Column = (Index - 1) % Columns
            local Row = math.floor((Index - 1) / Columns)
            Panel.Size = UDim2.fromOffset(CellWidth, CellHeight)
            Panel.Position = UDim2.fromOffset(
                Column * (CellWidth + Gap),
                Row * (CellHeight + Gap)
            )
        end
    end

    local Rows = math.ceil(#Categories / Columns)
    Content.CanvasSize = UDim2.fromOffset(0, math.max(0, Rows * (CellHeight + Gap) - Gap))
end

Content:GetPropertyChangedSignal("AbsoluteSize"):Connect(LayoutCategories)

--==================================================
-- RESPONSIVE - FIVE COLUMNS ALWAYS
--==================================================

local Camera = workspace.CurrentCamera

local function UpdateLayout()
    Camera = workspace.CurrentCamera or Camera
    if not Camera then return end

    Grid.FillDirectionMaxCells = 5

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

    if Width < 800 then
        MobileToggle.Size = UDim2.fromOffset(48, 48)
    else
        MobileToggle.Size = UDim2.fromOffset(52, 52)
    end

    UpdateSafeArea()
    LayoutCategories()
end

UpdateLayout()
if Camera then
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateLayout)
end

--==================================================
-- LOADING
--==================================================

local LoadingFinished = false

local function FinishLoading()
    if LoadingFinished then return end
    LoadingFinished = true

    Main.Visible = true
    MobileToggle.Visible = UserInputService.TouchEnabled

    Tween(Loading, 0.35, {BackgroundTransparency = 1})
    Tween(LoadingTint, 0.35, {BackgroundTransparency = 1})
    Tween(LoadingTitle, 0.35, {TextTransparency = 1})
    Tween(LoadingBarBackground, 0.35, {BackgroundTransparency = 1})
    Tween(LoadingBar, 0.35, {BackgroundTransparency = 1})

    task.delay(0.4, function()
        if Loading and Loading.Parent then Loading:Destroy() end
    end)
end

Tween(LoadingBar, Config.LoadingTime, {Size = UDim2.new(1, 0, 1, 0)})
task.delay(Config.LoadingTime, FinishLoading)
task.delay(5, FinishLoading)

print("[" .. Config.Name .. "] Loaded " .. Config.Version)
