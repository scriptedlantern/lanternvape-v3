local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Config = {
	Name = "LanternVape",
	Version = "1.0.0",
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

local OldGui = PlayerGui:FindFirstChild("LanternVape")

if OldGui then
	OldGui:Destroy()
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "LanternVape"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

local function Tween(Object, Time, Properties)
	return TweenService:Create(
		Object,
		TweenInfo.new(Time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		Properties
	)
end

local Loading = Instance.new("Frame")
Loading.Name = "Loading"
Loading.Size = UDim2.fromScale(1, 1)
Loading.BackgroundColor3 = Config.Black
Loading.BackgroundTransparency = 0.12
Loading.BorderSizePixel = 0
Loading.ZIndex = 100
Loading.Parent = Gui

local LoadingTint = Instance.new("Frame")
LoadingTint.Size = UDim2.fromScale(1, 1)
LoadingTint.BackgroundColor3 = Config.Orange
LoadingTint.BackgroundTransparency = 0.96
LoadingTint.BorderSizePixel = 0
LoadingTint.ZIndex = 101
LoadingTint.Parent = Loading

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Size = UDim2.new(1, 0, 0, 50)
LoadingTitle.Position = UDim2.new(0, 0, 0.5, -35)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "LOADING LANTERNVAPE.."
LoadingTitle.TextColor3 = Config.Orange
LoadingTitle.TextSize = 25
LoadingTitle.Font = Enum.Font.GothamBold
LoadingTitle.ZIndex = 102
LoadingTitle.Parent = Loading

local LoadingBarBackground = Instance.new("Frame")
LoadingBarBackground.Size = UDim2.fromOffset(240, 4)
LoadingBarBackground.Position = UDim2.new(0.5, -120, 0.5, 25)
LoadingBarBackground.BackgroundColor3 = Config.Darker
LoadingBarBackground.BorderSizePixel = 0
LoadingBarBackground.ZIndex = 102
LoadingBarBackground.Parent = Loading

local LoadingBarCorner = Instance.new("UICorner")
LoadingBarCorner.CornerRadius = UDim.new(1, 0)
LoadingBarCorner.Parent = LoadingBarBackground

local LoadingBar = Instance.new("Frame")
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = Config.Orange
LoadingBar.BorderSizePixel = 0
LoadingBar.ZIndex = 103
LoadingBar.Parent = LoadingBarBackground

local LoadingBarCorner2 = Instance.new("UICorner")
LoadingBarCorner2.CornerRadius = UDim.new(1, 0)
LoadingBarCorner2.Parent = LoadingBar

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(1, -30, 1, -30)
Main.Position = UDim2.new(0, 15, 0, 15)
Main.BackgroundTransparency = 1
Main.Visible = false
Main.Parent = Gui

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

local BrandPadding = Instance.new("UIPadding")
BrandPadding.PaddingLeft = UDim.new(0, 14)
Brand.Parent = Brand

local BrandCorner = Instance.new("UICorner")
BrandCorner.CornerRadius = UDim.new(0, 5)
BrandCorner.Parent = Brand

local BrandAccent = Instance.new("Frame")
BrandAccent.Size = UDim2.new(1, 0, 0, 2)
BrandAccent.Position = UDim2.new(0, 0, 1, -2)
BrandAccent.BackgroundColor3 = Config.Orange
BrandAccent.BorderSizePixel = 0
BrandAccent.Parent = Brand

local MenuButton = Instance.new("TextButton")
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

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 5)
MenuCorner.Parent = MenuButton

local CloseButton = Instance.new("TextButton")
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

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseButton

local Search = Instance.new("TextBox")
Search.Size = UDim2.fromOffset(230, 34)
Search.Position = UDim2.new(0.5, -115, 0, 8)
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

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 5)
SearchCorner.Parent = Search

local SearchStroke = Instance.new("UIStroke")
SearchStroke.Color = Config.Orange
SearchStroke.Transparency = 0.8
SearchStroke.Thickness = 1
SearchStroke.Parent = Search

local SearchPadding = Instance.new("UIPadding")
SearchPadding.PaddingLeft = UDim.new(0, 12)
SearchPadding.Parent = Search

local Version = Instance.new("TextLabel")
Version.Size = UDim2.fromOffset(75, 42)
Version.Position = UDim2.new(1, -92, 0, 4)
Version.BackgroundTransparency = 1
Version.Text = "v" .. Config.Version
Version.TextColor3 = Config.Gray
Version.TextSize = 12
Version.Font = Enum.Font.Gotham
Version.TextXAlignment = Enum.TextXAlignment.Right
Version.Parent = Main

local Content = Instance.new("ScrollingFrame")
Content.Name = "Categories"
Content.Size = UDim2.new(1, -8, 1, -62)
Content.Position = UDim2.fromOffset(4, 58)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = Config.Orange
Content.ScrollingDirection = Enum.ScrollingDirection.Y
Content.CanvasSize = UDim2.new()
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.Parent = Main

local Grid = Instance.new("UIGridLayout")
Grid.CellPadding = UDim2.fromOffset(7, 7)
Grid.CellSize = UDim2.new(0.2, -7, 0, 100)
Grid.FillDirection = Enum.FillDirection.Horizontal
Grid.FillDirectionMaxCells = 5
Grid.SortOrder = Enum.SortOrder.LayoutOrder
Grid.Parent = Content

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
	Panel.BackgroundColor3 = Config.Black
	Panel.BackgroundTransparency = 0.12
	Panel.BorderSizePixel = 0
	Panel.LayoutOrder = Order
	Panel.Parent = Content

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 5)
	Corner.Parent = Panel

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Config.Orange
	Stroke.Transparency = 0.88
	Stroke.Thickness = 1
	Stroke.Parent = Panel

	local Header = Instance.new("TextLabel")
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

	local Padding = Instance.new("UIPadding")
	Padding.PaddingLeft = UDim.new(0, 14)
	Padding.Parent = Header

	local HeaderCorner = Instance.new("UICorner")
	HeaderCorner.CornerRadius = UDim.new(0, 5)
	HeaderCorner.Parent = Header

	local Accent = Instance.new("Frame")
	Accent.Size = UDim2.new(1, 0, 0, 2)
	Accent.Position = UDim2.new(0, 0, 1, -2)
	Accent.BackgroundColor3 = Config.Orange
	Accent.BackgroundTransparency = 0.15
	Accent.BorderSizePixel = 0
	Accent.Parent = Header

	local Chevron = Instance.new("TextLabel")
	Chevron.Size = UDim2.fromOffset(30, 42)
	Chevron.Position = UDim2.new(1, -35, 0, 0)
	Chevron.BackgroundTransparency = 1
	Chevron.Text = "⌄"
	Chevron.TextColor3 = Config.Gray
	Chevron.TextSize = 18
	Chevron.Font = Enum.Font.GothamBold
	Chevron.Parent = Header

	local Blank = Instance.new("Frame")
	Blank.Name = "Modules"
	Blank.Size = UDim2.new(1, 0, 1, -42)
	Blank.Position = UDim2.fromOffset(0, 42)
	Blank.BackgroundTransparency = 1
	Blank.Parent = Panel

	CategoryPanels[Name] = Panel
end

for Index, Name in ipairs(Categories) do
	CreateCategory(Name, Index)
end

local Menu = Instance.new("Frame")
Menu.Name = "SideMenu"
Menu.Size = UDim2.fromOffset(190, 330)
Menu.Position = UDim2.fromOffset(10, 58)
Menu.BackgroundColor3 = Config.Black
Menu.BackgroundTransparency = 0.02
Menu.BorderSizePixel = 0
Menu.Visible = false
Menu.ZIndex = 50
Menu.Parent = Main

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 6)
MenuCorner.Parent = Menu

local MenuStroke = Instance.new("UIStroke")
MenuStroke.Color = Config.Orange
MenuStroke.Transparency = 0.65
MenuStroke.Thickness = 1
MenuStroke.Parent = Menu

local MenuHeader = Instance.new("TextLabel")
MenuHeader.Size = UDim2.new(1, 0, 0, 50)
MenuHeader.BackgroundColor3 = Config.Darker
MenuHeader.BorderSizePixel = 0
MenuHeader.Text = "LanternVape"
MenuHeader.TextColor3 = Config.White
MenuHeader.TextSize = 17
MenuHeader.Font = Enum.Font.GothamBold
MenuHeader.Parent = Menu

local MenuHeaderCorner = Instance.new("UICorner")
MenuHeaderCorner.CornerRadius = UDim.new(0, 6)
MenuHeaderCorner.Parent = MenuHeader

local MenuAccent = Instance.new("Frame")
MenuAccent.Size = UDim2.new(1, 0, 0, 2)
MenuAccent.Position = UDim2.new(0, 0, 1, -2)
MenuAccent.BackgroundColor3 = Config.Orange
MenuAccent.BorderSizePixel = 0
MenuAccent.Parent = MenuHeader

local MenuList = Instance.new("UIListLayout")
MenuList.Padding = UDim.new(0, 4)
MenuList.SortOrder = Enum.SortOrder.LayoutOrder
MenuList.Parent = Menu

local MenuPadding = Instance.new("UIPadding")
MenuPadding.PaddingTop = UDim.new(0, 55)
MenuPadding.PaddingLeft = UDim.new(0, 5)
MenuPadding.PaddingRight = UDim.new(0, 5)
MenuPadding.Parent = Menu

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
	Button.Parent = Menu

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 4)
	Corner.Parent = Button

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
			{BackgroundColor3 = Config.OrangeDark}
		):Play()
	end)

	Button.MouseLeave:Connect(function()
		Tween(
			Button,
			0.12,
			{BackgroundColor3 = Config.Darker}
		):Play()
	end)
end

MenuButton.MouseButton1Click:Connect(function()
	Menu.Visible = not Menu.Visible
end)

CloseButton.MouseButton1Click:Connect(function()
	Main.Visible = false
	Menu.Visible = false
end)

local ToggleButton = Instance.new("ImageButton")
ToggleButton.Name = "MobileToggle"
ToggleButton.Size = UDim2.fromOffset(58, 58)
ToggleButton.Position = UDim2.new(0, 18, 0.5, -29)
ToggleButton.BackgroundColor3 = Config.Black
ToggleButton.BackgroundTransparency = 0.08
ToggleButton.BorderSizePixel = 0
ToggleButton.Image = Config.Icon
ToggleButton.ScaleType = Enum.ScaleType.Fit
ToggleButton.Visible = false
ToggleButton.ZIndex = 200
ToggleButton.Parent = Gui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 12)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Config.Orange
ToggleStroke.Thickness = 2
ToggleStroke.Transparency = 0.15
ToggleStroke.Parent = ToggleButton

local ToggleFallback = Instance.new("TextLabel")
ToggleFallback.Size = UDim2.fromScale(1, 1)
ToggleFallback.BackgroundTransparency = 1
ToggleFallback.Text = "LV"
ToggleFallback.TextColor3 = Config.Orange
ToggleFallback.TextSize = 18
ToggleFallback.Font = Enum.Font.GothamBold
ToggleFallback.ZIndex = 201
ToggleFallback.Parent = ToggleButton

if Config.Icon ~= "rbxassetid://0" then
	ToggleFallback.Visible = false
end

ToggleButton.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible

	if not Main.Visible then
		Menu.Visible = false
	end
end)

UserInputService.InputBegan:Connect(function(Input, Processed)
	if Processed then
		return
	end

	if Input.KeyCode == Enum.KeyCode.LeftShift
		or Input.KeyCode == Enum.KeyCode.RightShift then

		Main.Visible = not Main.Visible

		if not Main.Visible then
			Menu.Visible = false
		end
	end
end)

Search:GetPropertyChangedSignal("Text"):Connect(function()
	local Query = string.lower(Search.Text)

	for Name, Panel in pairs(CategoryPanels) do
		if Query == "" then
			Panel.Visible = true
		else
			Panel.Visible = string.find(
				string.lower(Name),
				Query,
				1,
				true
			) ~= nil
		end
	end
end)

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

local UIScale = Instance.new("UIScale")
UIScale.Scale = 1
UIScale.Parent = Main

local Camera = workspace.CurrentCamera

local function UpdateLayout()
	if not Camera then
		return
	end

	local Width = Camera.ViewportSize.X

	if Width < 600 then
		UIScale.Scale = 0.72
		Grid.FillDirectionMaxCells = 2
		Grid.CellSize = UDim2.new(0.5, -7, 0, 100)
	elseif Width < 900 then
		UIScale.Scale = 0.82
		Grid.FillDirectionMaxCells = 3
		Grid.CellSize = UDim2.new(0.333333, -7, 0, 100)
	elseif Width < 1200 then
		UIScale.Scale = 0.92
		Grid.FillDirectionMaxCells = 4
		Grid.CellSize = UDim2.new(0.25, -7, 0, 100)
	else
		UIScale.Scale = 1
		Grid.FillDirectionMaxCells = 5
		Grid.CellSize = UDim2.new(0.2, -7, 0, 100)
	end
end

UpdateLayout()

if Camera then
	Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateLayout)
end

Tween(
	LoadingBar,
	Config.LoadingTime,
	{Size = UDim2.new(1, 0, 1, 0)}
):Play()

task.wait(Config.LoadingTime)

Main.Visible = true

Tween(
	Loading,
	0.35,
	{BackgroundTransparency = 1}
):Play()

Tween(
	LoadingTitle,
	0.35,
	{TextTransparency = 1}
):Play()

Tween(
	LoadingBarBackground,
	0.35,
	{BackgroundTransparency = 1}
):Play()

Tween(
	LoadingTint,
	0.35,
	{BackgroundTransparency = 1}
):Play()

task.wait(0.4)

Loading:Destroy()

local CameraSize = Camera and Camera.ViewportSize.X or 1000

if CameraSize < 900 then
	ToggleButton.Visible = true
end

print("[" .. Config.Name .. "] Loaded " .. Config.Version)
