--// LanternVape v2.03
--// Standalone main.lua
--// Safe-area responsive UI
--// Loading screen has a hard failsafe

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
if not Player then
	return
end

local PlayerGui = Player:WaitForChild("PlayerGui", 15)
if not PlayerGui then
	return
end

--==================================================
-- CONFIG
--==================================================

local Config = {
	Name = "LanternVape",
	Version = "2.03",

	-- Put Roblox image asset IDs here.
	Icons = {
		Lantern = "rbxassetid://0",
		Menu = "rbxassetid://0",
		Close = "rbxassetid://0",
		Search = "rbxassetid://0",
		Settings = "rbxassetid://0",
		Profiles = "rbxassetid://0",
		Targets = "rbxassetid://0",
		Themes = "rbxassetid://0",
		Keybinds = "rbxassetid://0",
		About = "rbxassetid://0",
	},

	LoadingTime = 2.2,
	LoadingFailsafe = 5,

	Orange = Color3.fromRGB(220, 115, 35),
	OrangeDark = Color3.fromRGB(145, 68, 20),

	Black = Color3.fromRGB(8, 8, 8),
	Dark = Color3.fromRGB(14, 14, 14),
	Darker = Color3.fromRGB(21, 21, 21),

	White = Color3.fromRGB(235, 235, 235),
	Gray = Color3.fromRGB(145, 145, 145),
}

--==================================================
-- CLEANUP
--==================================================

local OldGui = PlayerGui:FindFirstChild("LanternVape")

if OldGui then
	OldGui:Destroy()
end

--==================================================
-- SCREEN GUI
--==================================================

local Gui = Instance.new("ScreenGui")

Gui.Name = "LanternVape"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Gui.Parent = PlayerGui

--==================================================
-- HELPERS
--==================================================

local function MakeCorner(object, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = object
	return corner
end

local function MakeStroke(object, color, transparency, thickness)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color
	stroke.Transparency = transparency or 0
	stroke.Thickness = thickness or 1
	stroke.Parent = object
	return stroke
end

local function PlayTween(object, duration, properties)
	local success, tween = pcall(function()
		return TweenService:Create(
			object,
			TweenInfo.new(
				duration,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out
			),
			properties
		)
	end)

	if success and tween then
		tween:Play()
		return tween
	end
end

local function HasIcon(id)
	return typeof(id) == "string"
		and id ~= ""
		and id ~= "rbxassetid://0"
end

--==================================================
-- LOADING SCREEN
--==================================================

-- This deliberately ignores the safe area so the loading
-- screen covers the entire display.

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

LoadingTitle.Position = UDim2.new(
	0,
	0,
	0.5,
	-35
)

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

LoadingBarBackground.Position = UDim2.new(
	0.5,
	0,
	0.5,
	25
)

LoadingBarBackground.BackgroundColor3 = Config.Darker

LoadingBarBackground.BorderSizePixel = 0
LoadingBarBackground.ZIndex = 1002

LoadingBarBackground.Parent = Loading

MakeCorner(LoadingBarBackground, 10)

local LoadingBar = Instance.new("Frame")

LoadingBar.Size = UDim2.new(0, 0, 1, 0)

LoadingBar.BackgroundColor3 = Config.Orange

LoadingBar.BorderSizePixel = 0
LoadingBar.ZIndex = 1003

LoadingBar.Parent = Loading

MakeCorner(LoadingBar, 10)

--==================================================
-- SAFE AREA
--==================================================

local SafeArea = Instance.new("Frame")

SafeArea.Name = "SafeArea"

SafeArea.Size = UDim2.fromScale(1, 1)

SafeArea.BackgroundTransparency = 1
SafeArea.BorderSizePixel = 0

SafeArea.Parent = Gui

--==================================================
-- MAIN
--==================================================

local Main = Instance.new("Frame")

Main.Name = "Main"

Main.BackgroundTransparency = 1
Main.BorderSizePixel = 0

Main.Visible = false

Main.Parent = SafeArea

local Scale = Instance.new("UIScale")

Scale.Scale = 1

Scale.Parent = Main

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

MakeCorner(Brand, 5)

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

local MenuButton = Instance.new("ImageButton")

MenuButton.Name = "MenuButton"

MenuButton.Size = UDim2.fromOffset(42, 42)
MenuButton.Position = UDim2.fromOffset(202, 4)

MenuButton.BackgroundColor3 = Config.Black
MenuButton.BackgroundTransparency = 0.05

MenuButton.BorderSizePixel = 0

MenuButton.AutoButtonColor = false

MenuButton.Parent = Main

MakeCorner(MenuButton, 5)

local MenuFallback = Instance.new("TextLabel")

MenuFallback.Size = UDim2.fromScale(1, 1)

MenuFallback.BackgroundTransparency = 1

MenuFallback.Text = "☰"

MenuFallback.TextColor3 = Config.White
MenuFallback.TextSize = 19
MenuFallback.Font = Enum.Font.GothamBold

MenuFallback.Parent = MenuButton

if HasIcon(Config.Icons.Menu) then
	MenuButton.Image = Config.Icons.Menu
	MenuFallback.Visible = false
end

--==================================================
-- VERSION
--==================================================

local Version = Instance.new("TextLabel")

Version.Name = "Version"

Version.Size = UDim2.fromOffset(75, 42)

Version.Position = UDim2.new(
	1,
	-122,
	0,
	4
)

Version.BackgroundTransparency = 1

Version.Text = "v" .. Config.Version

Version.TextColor3 = Config.Gray

Version.TextSize = 12
Version.Font = Enum.Font.Gotham

Version.TextXAlignment = Enum.TextXAlignment.Right

Version.Parent = Main

--==================================================
-- CLOSE
--==================================================

local CloseButton = Instance.new("ImageButton")

CloseButton.Name = "Close"

CloseButton.Size = UDim2.fromOffset(42, 42)

CloseButton.Position = UDim2.new(
	1,
	-46,
	0,
	4
)

CloseButton.BackgroundColor3 = Config.Black
CloseButton.BackgroundTransparency = 0.05

CloseButton.BorderSizePixel = 0

CloseButton.AutoButtonColor = false

CloseButton.Parent = Main

MakeCorner(CloseButton, 5)

local CloseFallback = Instance.new("TextLabel")

CloseFallback.Size = UDim2.fromScale(1, 1)

CloseFallback.BackgroundTransparency = 1

CloseFallback.Text = "×"

CloseFallback.TextColor3 = Config.White
CloseFallback.TextSize = 25
CloseFallback.Font = Enum.Font.Gotham

CloseFallback.Parent = CloseButton

if HasIcon(Config.Icons.Close) then
	CloseButton.Image = Config.Icons.Close
	CloseFallback.Visible = false
end

--==================================================
-- SEARCH
--==================================================

local Search = Instance.new("TextBox")

Search.Name = "Search"

Search.Size = UDim2.fromOffset(230, 34)

Search.AnchorPoint = Vector2.new(0.5, 0)

Search.Position = UDim2.new(
	0.5,
	0,
	0,
	8
)

Search.BackgroundColor3 = Config.Black
Search.BackgroundTransparency = 0.05

Search.BorderSizePixel = 0

Search.PlaceholderText = "Search.."
Search.PlaceholderColor3 = Config.Gray

Search.Text = ""

Search.TextColor3 = Config.White

Search.TextSize = 13
Search.Font = Enum.Font.Gotham

Search.ClearTextOnFocus = false

Search.TextXAlignment = Enum.TextXAlignment.Left

Search.Parent = Main

MakeCorner(Search, 5)

MakeStroke(
	Search,
	Config.Orange,
	0.8,
	1
)

local SearchPadding = Instance.new("UIPadding")

SearchPadding.PaddingLeft = UDim.new(0, 38)

SearchPadding.Parent = Search

local SearchIcon = Instance.new("ImageLabel")

SearchIcon.Name = "SearchIcon"

SearchIcon.Size = UDim2.fromOffset(17, 17)

SearchIcon.Position = UDim2.fromOffset(11, 8)

SearchIcon.BackgroundTransparency = 1

SearchIcon.ImageColor3 = Config.Gray

SearchIcon.Parent = Search

local SearchFallback = Instance.new("TextLabel")

SearchFallback.Size = UDim2.fromScale(1, 1)

SearchFallback.BackgroundTransparency = 1

SearchFallback.Text = "⌕"

SearchFallback.TextColor3 = Config.Gray

SearchFallback.TextSize = 19
SearchFallback.Font = Enum.Font.Gotham

SearchFallback.Parent = Search

if HasIcon(Config.Icons.Search) then
	SearchIcon.Image = Config.Icons.Search
	SearchFallback.Visible = false
else
	SearchIcon.Visible = false
end

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("ScrollingFrame")

Content.Name = "Categories"

Content.Position = UDim2.fromOffset(4, 58)

Content.Size = UDim2.new(
	1,
	-8,
	1,
	-62
)

Content.BackgroundTransparency = 1

Content.BorderSizePixel = 0

Content.ScrollBarThickness = 3

Content.ScrollBarImageColor3 = Config.Orange

Content.ScrollingDirection =
	Enum.ScrollingDirection.Y

Content.CanvasSize =
	UDim2.new(0, 0, 0, 0)

Content.AutomaticCanvasSize =
	Enum.AutomaticSize.Y

Content.Parent = Main

--==================================================
-- GRID
--==================================================

local Grid = Instance.new("UIGridLayout")

Grid.CellPadding =
	UDim2.fromOffset(7, 7)

-- Keep module size/layout consistent.
Grid.CellSize =
	UDim2.new(
		0.2,
		-7,
		0,
		115
	)

Grid.FillDirection =
	Enum.FillDirection.Horizontal

Grid.FillDirectionMaxCells = 5

Grid.SortOrder =
	Enum.SortOrder.LayoutOrder

Grid.Parent = Content

--==================================================
-- CATEGORY DATA
--==================================================

local Categories = {
	"Combat",
	"Blatant",
	"External",
	"Rendering",
	"Extra",
}

local CategoryPanels = {}

local CategoryEnabled = {
	Combat = true,
	Blatant = true,
	External = true,
	Rendering = true,
	Extra = true,
}

--==================================================
-- CREATE CATEGORY
--==================================================

local function CreateCategory(name, order)

	local Panel = Instance.new("Frame")

	Panel.Name = name

	Panel.LayoutOrder = order

	Panel.BackgroundColor3 = Config.Black
	Panel.BackgroundTransparency = 0.12

	Panel.BorderSizePixel = 0

	Panel.Parent = Content

	MakeCorner(Panel, 5)

	MakeStroke(
		Panel,
		Config.Orange,
		0.88,
		1
	)

	local Header = Instance.new("TextLabel")

	Header.Name = "Header"

	Header.Size =
		UDim2.new(1, 0, 0, 42)

	Header.BackgroundColor3 =
		Config.Black

	Header.BackgroundTransparency =
		0.02

	Header.BorderSizePixel = 0

	Header.Text = name

	Header.TextColor3 =
		Config.White

	Header.TextSize = 16

	Header.Font =
		Enum.Font.GothamBold

	Header.TextXAlignment =
		Enum.TextXAlignment.Left

	Header.Parent = Panel

	MakeCorner(Header, 5)

	local HeaderPadding = Instance.new("UIPadding")

	HeaderPadding.PaddingLeft =
		UDim.new(0, 14)

	HeaderPadding.Parent = Header

	local Accent = Instance.new("Frame")

	Accent.Name = "Accent"

	Accent.Size =
		UDim2.new(1, 0, 0, 2)

	Accent.Position =
		UDim2.new(0, 0, 1, -2)

	Accent.BackgroundColor3 =
		Config.Orange

	Accent.BorderSizePixel = 0

	Accent.Parent = Header

	local Modules = Instance.new("Frame")

	Modules.Name = "Modules"

	Modules.Size =
		UDim2.new(1, 0, 1, -42)

	Modules.Position =
		UDim2.fromOffset(0, 42)

	Modules.BackgroundTransparency = 1

	Modules.Parent = Panel

	CategoryPanels[name] = Panel
end

for index, name in ipairs(Categories) do
	CreateCategory(name, index)
end

--==================================================
-- SIDE MENU
--==================================================

local SideMenu = Instance.new("Frame")

SideMenu.Name = "SideMenu"

SideMenu.Size =
	UDim2.fromOffset(245, 390)

SideMenu.Position =
	UDim2.fromOffset(4, 58)

SideMenu.BackgroundColor3 =
	Config.Black

SideMenu.BackgroundTransparency =
	0.02

SideMenu.BorderSizePixel = 0

SideMenu.Visible = false

SideMenu.ZIndex = 100

SideMenu.Parent = Main

MakeCorner(SideMenu, 8)

MakeStroke(
	SideMenu,
	Config.Orange,
	0.55,
	1
)

--==================================================
-- SIDE MENU HEADER
--==================================================

local SideHeader = Instance.new("Frame")

SideHeader.Size =
	UDim2.new(1, 0, 0, 58)

SideHeader.BackgroundColor3 =
	Config.Darker

SideHeader.BorderSizePixel = 0

SideHeader.ZIndex = 101

SideHeader.Parent = SideMenu

MakeCorner(SideHeader, 8)

local SideTitle = Instance.new("TextLabel")

SideTitle.Size =
	UDim2.new(1, -20, 0, 25)

SideTitle.Position =
	UDim2.fromOffset(15, 8)

SideTitle.BackgroundTransparency = 1

SideTitle.Text =
	"LanternVape"

SideTitle.TextColor3 =
	Config.White

SideTitle.TextSize = 17

SideTitle.Font =
	Enum.Font.GothamBold

SideTitle.TextXAlignment =
	Enum.TextXAlignment.Left

SideTitle.ZIndex = 102

SideTitle.Parent = SideHeader

local SideSubtitle = Instance.new("TextLabel")

SideSubtitle.Size =
	UDim2.new(1, -20, 0, 18)

SideSubtitle.Position =
	UDim2.fromOffset(15, 32)

SideSubtitle.BackgroundTransparency = 1

SideSubtitle.Text =
	"Control Panel"

SideSubtitle.TextColor3 =
	Config.Gray

SideSubtitle.TextSize = 11

SideSubtitle.Font =
	Enum.Font.Gotham

SideSubtitle.TextXAlignment =
	Enum.TextXAlignment.Left

SideSubtitle.ZIndex = 102

SideSubtitle.Parent = SideHeader

local SideAccent = Instance.new("Frame")

SideAccent.Size =
	UDim2.new(1, -20, 0, 2)

SideAccent.Position =
	UDim2.new(0, 10, 1, -2)

SideAccent.BackgroundColor3 =
	Config.Orange

SideAccent.BorderSizePixel = 0

SideAccent.ZIndex = 103

SideAccent.Parent = SideHeader

--==================================================
-- MENU LIST
--==================================================

local MenuList = Instance.new("UIListLayout")

MenuList.Padding =
	UDim.new(0, 6)

MenuList.SortOrder =
	Enum.SortOrder.LayoutOrder

MenuList.Parent = SideMenu

local MenuPadding = Instance.new("UIPadding")

MenuPadding.PaddingTop =
	UDim.new(0, 68)

MenuPadding.PaddingLeft =
	UDim.new(0, 8)

MenuPadding.PaddingRight =
	UDim.new(0, 8)

MenuPadding.Parent = SideMenu

local MenuItems = {
	{
		"Settings",
		"Settings",
		"⚙",
	},
	{
		"Profiles",
		"Profiles",
		"♙",
	},
	{
		"Targets",
		"Targets",
		"◎",
	},
	{
		"Themes",
		"Themes",
		"◆",
	},
	{
		"Keybinds",
		"Keybinds",
		"⌨",
	},
	{
		"About",
		"About",
		"?",
	},
}

local MenuButtons = {}

for index, data in ipairs(MenuItems) do

	local Button = Instance.new("TextButton")

	Button.Name = data[1]

	Button.Size =
		UDim2.new(1, 0, 0, 45)

	Button.BackgroundColor3 =
		Config.Darker

	Button.BorderSizePixel = 0

	Button.Text = ""

	Button.AutoButtonColor = false

	Button.LayoutOrder = index

	Button.ZIndex = 101

	Button.Parent = SideMenu

	MakeCorner(Button, 6)

	local Icon = Instance.new("ImageLabel")

	Icon.Name = "Icon"

	Icon.Size =
		UDim2.fromOffset(21, 21)

	Icon.Position =
		UDim2.fromOffset(13, 12)

	Icon.BackgroundTransparency = 1

	Icon.ImageColor3 =
		Config.Orange

	Icon.ZIndex = 102

	Icon.Parent = Button

	local Fallback = Instance.new("TextLabel")

	Fallback.Size =
		UDim2.fromOffset(21, 21)

	Fallback.Position =
		UDim2.fromOffset(13, 12)

	Fallback.BackgroundTransparency = 1

	Fallback.Text = data[3]

	Fallback.TextColor3 =
		Config.Orange

	Fallback.TextSize = 17

	Fallback.Font =
		Enum.Font.GothamBold

	Fallback.ZIndex = 103

	Fallback.Parent = Button

	local iconId = Config.Icons[data[2]]

	if HasIcon(iconId) then
		Icon.Image = iconId
		Fallback.Visible = false
	else
		Icon.Visible = false
	end

	local Label = Instance.new("TextLabel")

	Label.Size =
		UDim2.new(1, -55, 1, 0)

	Label.Position =
		UDim2.fromOffset(48, 0)

	Label.BackgroundTransparency = 1

	Label.Text = data[2]

	Label.TextColor3 =
		Config.White

	Label.TextSize = 13

	Label.Font =
		Enum.Font.GothamSemibold

	Label.TextXAlignment =
		Enum.TextXAlignment.Left

	Label.ZIndex = 102

	Label.Parent = Button

	MenuButtons[data[2]] = Button

	Button.MouseEnter:Connect(function()
		PlayTween(
			Button,
			0.12,
			{
				BackgroundColor3 =
					Config.OrangeDark
			}
		)
	end)

	Button.MouseLeave:Connect(function()
		PlayTween(
			Button,
			0.12,
			{
				BackgroundColor3 =
					Config.Darker
			}
		)
	end)
end

--==================================================
-- SETTINGS PANEL
--==================================================

local SettingsPanel = Instance.new("Frame")

SettingsPanel.Name = "SettingsPanel"

SettingsPanel.Size =
	UDim2.fromOffset(360, 390)

SettingsPanel.Position =
	UDim2.fromOffset(260, 58)

SettingsPanel.BackgroundColor3 =
	Config.Black

SettingsPanel.BackgroundTransparency =
	0.02

SettingsPanel.BorderSizePixel = 0

SettingsPanel.Visible = false

SettingsPanel.ZIndex = 200

SettingsPanel.Parent = Main

MakeCorner(SettingsPanel, 8)

MakeStroke(
	SettingsPanel,
	Config.Orange,
	0.55,
	1
)

local SettingsTitle = Instance.new("TextLabel")

SettingsTitle.Size =
	UDim2.new(1, -30, 0, 45)

SettingsTitle.Position =
	UDim2.fromOffset(15, 8)

SettingsTitle.BackgroundTransparency = 1

SettingsTitle.Text =
	"Settings"

SettingsTitle.TextColor3 =
	Config.White

SettingsTitle.TextSize = 18

SettingsTitle.Font =
	Enum.Font.GothamBold

SettingsTitle.TextXAlignment =
	Enum.TextXAlignment.Left

SettingsTitle.ZIndex = 201

SettingsTitle.Parent = SettingsPanel

local SettingsSub = Instance.new("TextLabel")

SettingsSub.Size =
	UDim2.new(1, -30, 0, 25)

SettingsSub.Position =
	UDim2.fromOffset(15, 43)

SettingsSub.BackgroundTransparency = 1

SettingsSub.Text =
	"Interface visibility"

SettingsSub.TextColor3 =
	Config.Gray

SettingsSub.TextSize = 11

SettingsSub.Font =
	Enum.Font.Gotham

SettingsSub.TextXAlignment =
	Enum.TextXAlignment.Left

SettingsSub.ZIndex = 201

SettingsSub.Parent = SettingsPanel

local SettingsList = Instance.new("UIListLayout")

SettingsList.Padding =
	UDim.new(0, 6)

SettingsList.SortOrder =
	Enum.SortOrder.LayoutOrder

SettingsList.Parent = SettingsPanel

local SettingsPadding = Instance.new("UIPadding")

SettingsPadding.PaddingTop =
	UDim.new(0, 78)

SettingsPadding.PaddingLeft =
	UDim.new(0, 12)

SettingsPadding.PaddingRight =
	UDim.new(0, 12)

SettingsPadding.Parent = SettingsPanel

local function CreateSetting(name, order, callback)

	local Button = Instance.new("TextButton")

	Button.Name = name

	Button.Size =
		UDim2.new(1, 0, 0, 38)

	Button.BackgroundColor3 =
		Config.Darker

	Button.BorderSizePixel = 0

	Button.Text = ""

	Button.AutoButtonColor = false

	Button.LayoutOrder = order

	Button.ZIndex = 202

	Button.Parent = SettingsPanel

	MakeCorner(Button, 5)

	local Label = Instance.new("TextLabel")

	Label.Size =
		UDim2.new(1, -65, 1, 0)

	Label.Position =
		UDim2.fromOffset(12, 0)

	Label.BackgroundTransparency = 1

	Label.Text = name

	Label.TextColor3 =
		Config.White

	Label.TextSize = 12

	Label.Font =
		Enum.Font.GothamSemibold

	Label.TextXAlignment =
		Enum.TextXAlignment.Left

	Label.ZIndex = 203

	Label.Parent = Button

	local Toggle = Instance.new("Frame")

	Toggle.Size =
		UDim2.fromOffset(34, 18)

	Toggle.Position =
		UDim2.new(1, -47, 0.5, -9)

	Toggle.BackgroundColor3 =
		Config.Orange

	Toggle.BorderSizePixel = 0

	Toggle.ZIndex = 203

	Toggle.Parent = Button

	MakeCorner(Toggle, 20)

	local Knob = Instance.new("Frame")

	Knob.Size =
		UDim2.fromOffset(14, 14)

	Knob.Position =
		UDim2.fromOffset(18, 2)

	Knob.BackgroundColor3 =
		Config.White

	Knob.BorderSizePixel = 0

	Knob.ZIndex = 204

	Knob.Parent = Toggle

	MakeCorner(Knob, 20)

	local state = true

	Button.MouseButton1Click:Connect(function()

		state = not state

		if state then
			Toggle.BackgroundColor3 =
				Config.Orange

			Knob.Position =
				UDim2.fromOffset(18, 2)
		else
			Toggle.BackgroundColor3 =
				Config.Darker

			Knob.Position =
				UDim2.fromOffset(2, 2)
		end

		if callback then
			callback(state)
		end
	end)

	return Button
end

for index, category in ipairs(Categories) do

	CreateSetting(
		"Show " .. category,
		index,
		function(enabled)
			CategoryEnabled[category] = enabled

			if CategoryPanels[category] then
				CategoryPanels[category].Visible =
					enabled
			end
		end
	)
end

local HideGuiButton = true

CreateSetting(
	"Show LanternVape button",
	#Categories + 1,
	function(enabled)
		HideGuiButton = enabled
	end
)

--==================================================
-- THEMES
--==================================================

local ThemesPanel = Instance.new("Frame")

ThemesPanel.Name = "ThemesPanel"

ThemesPanel.Size =
	UDim2.fromOffset(360, 390)

ThemesPanel.Position =
	UDim2.fromOffset(260, 58)

ThemesPanel.BackgroundColor3 =
	Config.Black

ThemesPanel.BackgroundTransparency =
	0.02

ThemesPanel.BorderSizePixel = 0

ThemesPanel.Visible = false

ThemesPanel.ZIndex = 200

ThemesPanel.Parent = Main

MakeCorner(ThemesPanel, 8)

MakeStroke(
	ThemesPanel,
	Config.Orange,
	0.55,
	1
)

local ThemesTitle = Instance.new("TextLabel")

ThemesTitle.Size =
	UDim2.new(1, -30, 0, 45)

ThemesTitle.Position =
	UDim2.fromOffset(15, 8)

ThemesTitle.BackgroundTransparency = 1

ThemesTitle.Text = "Themes"

ThemesTitle.TextColor3 =
	Config.White

ThemesTitle.TextSize = 18

ThemesTitle.Font =
	Enum.Font.GothamBold

ThemesTitle.TextXAlignment =
	Enum.TextXAlignment.Left

ThemesTitle.ZIndex = 201

ThemesTitle.Parent = ThemesPanel

local ThemesSub = Instance.new("TextLabel")

ThemesSub.Size =
	UDim2.new(1, -30, 0, 25)

ThemesSub.Position =
	UDim2.fromOffset(15, 43)

ThemesSub.BackgroundTransparency = 1

ThemesSub.Text =
	"Accent color"

ThemesSub.TextColor3 =
	Config.Gray

ThemesSub.TextSize = 11

ThemesSub.Font =
	Enum.Font.Gotham

ThemesSub.TextXAlignment =
	Enum.TextXAlignment.Left

ThemesSub.ZIndex = 201

ThemesSub.Parent = ThemesPanel

local ThemeList = Instance.new("UIGridLayout")

ThemeList.CellPadding =
	UDim2.fromOffset(8, 8)

ThemeList.CellSize =
	UDim2.fromOffset(105, 42)

ThemeList.Parent = ThemesPanel

local ThemePadding = Instance.new("UIPadding")

ThemePadding.PaddingTop =
	UDim.new(0, 80)

ThemePadding.PaddingLeft =
	UDim.new(0, 15)

ThemePadding.PaddingRight =
	UDim.new(0, 15)

ThemePadding.Parent = ThemesPanel

local ThemeColors = {
	Orange = Color3.fromRGB(220, 115, 35),
	Red = Color3.fromRGB(220, 55, 55),
	Purple = Color3.fromRGB(150, 85, 220),
	Blue = Color3.fromRGB(70, 135, 235),
	Green = Color3.fromRGB(70, 190, 110),
	Pink = Color3.fromRGB(220, 85, 155),
	White = Color3.fromRGB(220, 220, 220),
}

local AccentObjects = {
	BrandAccent,
	SideAccent,
}

for name, color in pairs(ThemeColors) do

	local Button = Instance.new("TextButton")

	Button.Name = name

	Button.BackgroundColor3 =
		Config.Darker

	Button.BorderSizePixel = 0

	Button.Text = name

	Button.TextColor3 =
		Config.White

	Button.TextSize = 12

	Button.Font =
		Enum.Font.GothamSemibold

	Button.AutoButtonColor = false

	Button.ZIndex = 202

	Button.Parent = ThemesPanel

	MakeCorner(Button, 6)

	local Dot = Instance.new("Frame")

	Dot.Size =
		UDim2.fromOffset(10, 10)

	Dot.Position =
		UDim2.fromOffset(10, 16)

	Dot.BackgroundColor3 =
		color

	Dot.BorderSizePixel = 0

	Dot.ZIndex = 203

	Dot.Parent = Button

	MakeCorner(Dot, 20)

	Button.TextXAlignment =
		Enum.TextXAlignment.Right

	local Padding = Instance.new("UIPadding")

	Padding.PaddingRight =
		UDim.new(0, 10)

	Padding.Parent = Button

	Button.MouseButton1Click:Connect(function()

		Config.Orange = color

		Config.OrangeDark =
			color:Lerp(
				Color3.new(0, 0, 0),
				0.35
			)

		for _, object in ipairs(
			AccentObjects
		) do

			if object and object.Parent then
				object.BackgroundColor3 =
					Config.Orange
			end

		end

		MakeStroke(
			Search,
			Config.Orange,
			0.8,
			1
		)

		if LoadingBar then
			LoadingBar.BackgroundColor3 =
				Config.Orange
		end

		if LoadingTitle then
			LoadingTitle.TextColor3 =
				Config.Orange
		end

		if SideMenu then
			local stroke =
				SideMenu:FindFirstChildOfClass(
					"UIStroke"
				)

			if stroke then
				stroke.Color =
					Config.Orange
			end
		end
	end)
end

--==================================================
-- PANEL MANAGEMENT
--==================================================

local function ClosePanels()
	SettingsPanel.Visible = false
	ThemesPanel.Visible = false
end

MenuButton.MouseButton1Click:Connect(function()

	SideMenu.Visible =
		not SideMenu.Visible

	if not SideMenu.Visible then
		ClosePanels()
	end
end)

local function OpenPanel(panel)

	SideMenu.Visible = true

	SettingsPanel.Visible = false
	ThemesPanel.Visible = false

	panel.Visible = true
end

MenuButtons.Settings.MouseButton1Click:Connect(function()
	OpenPanel(SettingsPanel)
end)

MenuButtons.Themes.MouseButton1Click:Connect(function()
	OpenPanel(ThemesPanel)
end)

for name, button in pairs(MenuButtons) do

	if name ~= "Settings"
		and name ~= "Themes" then

		button.MouseButton1Click:Connect(function()
			ClosePanels()
			SideMenu.Visible = false
		end)
	end
end

--==================================================
-- CLOSE BUTTON
--==================================================

CloseButton.MouseButton1Click:Connect(function()

	Main.Visible = false

	SideMenu.Visible = false

	ClosePanels()
end)

--==================================================
-- MOBILE TOGGLE
--==================================================

local MobileToggle = Instance.new("ImageButton")

MobileToggle.Name = "MobileToggle"

MobileToggle.Size =
	UDim2.fromOffset(52, 52)

-- Top-right, with safe-area margin.
MobileToggle.AnchorPoint =
	Vector2.new(1, 0)

MobileToggle.Position =
	UDim2.new(
		1,
		-18,
		0,
		18
	)

MobileToggle.BackgroundColor3 =
	Config.Black

MobileToggle.BackgroundTransparency =
	0.06

MobileToggle.BorderSizePixel = 0

MobileToggle.AutoButtonColor = false

MobileToggle.ZIndex = 500

MobileToggle.Parent = Gui

MakeCorner(MobileToggle, 12)

MakeStroke(
	MobileToggle,
	Config.Orange,
	0.15,
	2
)

local LanternFallback = Instance.new("TextLabel")

LanternFallback.Size =
	UDim2.fromScale(1, 1)

LanternFallback.BackgroundTransparency = 1

LanternFallback.Text = "LV"

LanternFallback.TextColor3 =
	Config.Orange

LanternFallback.TextSize = 17

LanternFallback.Font =
	Enum.Font.GothamBold

LanternFallback.ZIndex = 501

LanternFallback.Parent = MobileToggle

if HasIcon(Config.Icons.Lantern) then

	MobileToggle.Image =
		Config.Icons.Lantern

	LanternFallback.Visible = false
end

MobileToggle.Visible = false

MobileToggle.MouseButton1Click:Connect(function()

	Main.Visible =
		not Main.Visible

	if not Main.Visible then
		SideMenu.Visible = false
		ClosePanels()
	end
end)

--==================================================
-- SEARCH
--==================================================

Search:GetPropertyChangedSignal("Text"):Connect(function()

	local query =
		string.lower(Search.Text or "")

	for name, panel in pairs(
		CategoryPanels
	) do

		if not CategoryEnabled[name] then

			panel.Visible = false

		elseif query == "" then

			panel.Visible = true

		else

			panel.Visible =
				string.find(
					string.lower(name),
					query,
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
local DragStart = nil
local StartPosition = nil

Brand.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		Dragging = true

		DragStart = input.Position

		StartPosition =
			Main.Position
	end
end)

UserInputService.InputEnded:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		Dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)

	if not Dragging then
		return
	end

	if input.UserInputType ==
		Enum.UserInputType.MouseMovement
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		local delta =
			input.Position - DragStart

		Main.Position = UDim2.new(
			StartPosition.X.Scale,
			StartPosition.X.Offset + delta.X,

			StartPosition.Y.Scale,
			StartPosition.Y.Offset + delta.Y
		)
	end
end)

--==================================================
-- RESPONSIVE LAYOUT
--==================================================

local Camera = workspace.CurrentCamera

local function UpdateLayout()

	Camera =
		workspace.CurrentCamera
		or Camera

	if not Camera then
		return
	end

	-- Always five columns.
	Grid.FillDirectionMaxCells = 5

	Grid.CellSize =
		UDim2.new(
			0.2,
			-7,
			0,
			115
		)

	local width =
		Camera.ViewportSize.X

	if width < 500 then

		Scale.Scale = 0.55

	elseif width < 650 then

		Scale.Scale = 0.65

	elseif width < 800 then

		Scale.Scale = 0.75

	elseif width < 1000 then

		Scale.Scale = 0.87

	else

		Scale.Scale = 1
	end

	-- Keep the floating button safely inside
	-- the top-right corner.

	if width < 800 then

		MobileToggle.Size =
			UDim2.fromOffset(50, 50)

		MobileToggle.Position =
			UDim2.new(
				1,
				-14,
				0,
				14
			)

	else

		MobileToggle.Size =
			UDim2.fromOffset(52, 52)

		MobileToggle.Position =
			UDim2.new(
				1,
				-18,
				0,
				18
			)
	end
end

UpdateLayout()

if Camera then

	Camera:GetPropertyChangedSignal(
		"ViewportSize"
	):Connect(UpdateLayout)

end

--==================================================
-- LOADING FINISH
--==================================================

local LoadingFinished = false

local function FinishLoading()

	if LoadingFinished then
		return
	end

	LoadingFinished = true

	-- Main becomes visible first.
	Main.Visible = true

	if UserInputService.TouchEnabled then

		if HideGuiButton then
			MobileToggle.Visible = true
		end
	end

	-- Fade everything.
	if Loading and Loading.Parent then

		PlayTween(
			Loading,
			0.3,
			{
				BackgroundTransparency = 1
			}
		)

		PlayTween(
			LoadingTint,
			0.3,
			{
				BackgroundTransparency = 1
			}
		)

		PlayTween(
			LoadingTitle,
			0.3,
			{
				TextTransparency = 1
			}
		)

		PlayTween(
			LoadingBarBackground,
			0.3,
			{
				BackgroundTransparency = 1
			}
		)

		PlayTween(
			LoadingBar,
			0.3,
			{
				BackgroundTransparency = 1
			}
		)

		task.delay(0.35, function()

			if Loading and Loading.Parent then
				Loading:Destroy()
			end
		end)
	end
end

--==================================================
-- LOADING ANIMATION
--==================================================

task.spawn(function()

	local tween =
		PlayTween(
			LoadingBar,
			Config.LoadingTime,
			{
				Size =
					UDim2.new(
						1,
						0,
						1,
						0
					)
			}
		)

	task.wait(Config.LoadingTime)

	FinishLoading()
end)

--==================================================
-- LOADING FAILSAFE
--==================================================

-- Even if something goes wrong with the animation,
-- this guarantees the user gets into the GUI.

task.delay(
	Config.LoadingFailsafe,
	function()

		FinishLoading()
	end
)

--==================================================
-- SHIFT
--==================================================

UserInputService.InputBegan:Connect(function(
	input,
	processed
)

	if processed then
		return
	end

	if input.KeyCode ==
		Enum.KeyCode.LeftShift
		or input.KeyCode ==
		Enum.KeyCode.RightShift then

		Main.Visible =
			not Main.Visible

		if not Main.Visible then

			SideMenu.Visible = false

			ClosePanels()
		end
	end
end)

--==================================================
-- FINAL
--==================================================

print(
	"[" ..
		Config.Name ..
		"] Loaded v" ..
		Config.Version
)
