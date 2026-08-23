local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Config = {
	Name = "LanternVape",
	Version = "3.0.0",
	Orange = Color3.fromRGB(220, 115, 35),
	OrangeDark = Color3.fromRGB(145, 68, 20),
	Black = Color3.fromRGB(10, 10, 10),
	Dark = Color3.fromRGB(17, 17, 17),
	Darker = Color3.fromRGB(22, 22, 22),
	White = Color3.fromRGB(235, 235, 235),
	Gray = Color3.fromRGB(145, 145, 145)
}

local Existing = PlayerGui:FindFirstChild("LanternVape")

if Existing then
	Existing:Destroy()
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "LanternVape"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(1, -24, 1, -24)
Main.Position = UDim2.fromOffset(12, 12)
Main.BackgroundTransparency = 1
Main.Parent = Gui

local Brand = Instance.new("TextLabel")
Brand.Name = "Brand"
Brand.Size = UDim2.fromOffset(190, 42)
Brand.Position = UDim2.fromOffset(4, 4)
Brand.BackgroundColor3 = Config.Black
Brand.BackgroundTransparency = 0.08
Brand.BorderSizePixel = 0
Brand.Text = Config.Name
Brand.TextColor3 = Config.White
Brand.TextSize = 18
Brand.Font = Enum.Font.GothamBold
Brand.TextXAlignment = Enum.TextXAlignment.Left
Brand.Parent = Main

local BrandPadding = Instance.new("UIPadding")
BrandPadding.PaddingLeft = UDim.new(0, 14)
BrandPadding.Parent = Brand

local BrandCorner = Instance.new("UICorner")
BrandCorner.CornerRadius = UDim.new(0, 5)
BrandCorner.Parent = Brand

local AccentLine = Instance.new("Frame")
AccentLine.Size = UDim2.new(1, 0, 0, 2)
AccentLine.Position = UDim2.new(0, 0, 1, -2)
AccentLine.BackgroundColor3 = Config.Orange
AccentLine.BorderSizePixel = 0
AccentLine.Parent = Brand

local MenuButton = Instance.new("TextButton")
MenuButton.Name = "MenuButton"
MenuButton.Size = UDim2.fromOffset(42, 42)
MenuButton.Position = UDim2.fromOffset(202, 4)
MenuButton.BackgroundColor3 = Config.Black
MenuButton.BackgroundTransparency = 0.08
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

MenuButton.MouseEnter:Connect(function()
	TweenService:Create(
		MenuButton,
		TweenInfo.new(0.12),
		{BackgroundColor3 = Config.OrangeDark}
	):Play()
end)

MenuButton.MouseLeave:Connect(function()
	TweenService:Create(
		MenuButton,
		TweenInfo.new(0.12),
		{BackgroundColor3 = Config.Black}
	):Play()
end)

local Search = Instance.new("TextBox")
Search.Name = "Search"
Search.Size = UDim2.fromOffset(230, 34)
Search.Position = UDim2.new(0.5, -115, 0, 8)
Search.BackgroundColor3 = Config.Black
Search.BackgroundTransparency = 0.08
Search.BorderSizePixel = 0
Search.PlaceholderText = "Search..."
Search.PlaceholderColor3 = Color3.fromRGB(115, 115, 115)
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
SearchPadding.PaddingRight = UDim.new(0, 12)
SearchPadding.Parent = Search

local Version = Instance.new("TextLabel")
Version.Name = "Version"
Version.Size = UDim2.fromOffset(80, 42)
Version.Position = UDim2.new(1, -84, 0, 4)
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
Content.ScrollBarImageTransparency = 0.35
Content.ScrollingDirection = Enum.ScrollingDirection.X
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.AutomaticCanvasSize = Enum.AutomaticSize.X
Content.Parent = Main

local ColumnLayout = Instance.new("UIListLayout")
ColumnLayout.FillDirection = Enum.FillDirection.Horizontal
ColumnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
ColumnLayout.VerticalAlignment = Enum.VerticalAlignment.Top
ColumnLayout.Padding = UDim.new(0, 7)
ColumnLayout.SortOrder = Enum.SortOrder.LayoutOrder
ColumnLayout.Parent = Content

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
	Panel.Size = UDim2.fromOffset(225, 100)
	Panel.BackgroundColor3 = Config.Black
	Panel.BackgroundTransparency = 0.18
	Panel.BorderSizePixel = 0
	Panel.LayoutOrder = Order
	Panel.Parent = Content

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 4)
	Corner.Parent = Panel

	local Header = Instance.new("TextLabel")
	Header.Name = "Header"
	Header.Size = UDim2.new(1, 0, 0, 42)
	Header.BackgroundColor3 = Config.Black
	Header.BackgroundTransparency = 0.05
	Header.BorderSizePixel = 0
	Header.Text = Name
	Header.TextColor3 = Config.White
	Header.TextSize = 16
	Header.Font = Enum.Font.GothamBold
	Header.TextXAlignment = Enum.TextXAlignment.Left
	Header.Parent = Panel

	local HeaderPadding = Instance.new("UIPadding")
	HeaderPadding.PaddingLeft = UDim.new(0, 16)
	HeaderPadding.Parent = Header

	local HeaderCorner = Instance.new("UICorner")
	HeaderCorner.CornerRadius = UDim.new(0, 4)
	HeaderCorner.Parent = Header

	local Line = Instance.new("Frame")
	Line.Name = "Accent"
	Line.Size = UDim2.new(1, 0, 0, 2)
	Line.Position = UDim2.new(0, 0, 1, -2)
	Line.BackgroundColor3 = Config.Orange
	Line.BackgroundTransparency = 0.25
	Line.BorderSizePixel = 0
	Line.Parent = Header

	local Chevron = Instance.new("TextLabel")
	Chevron.Size = UDim2.fromOffset(32, 42)
	Chevron.Position = UDim2.new(1, -38, 0, 0)
	Chevron.BackgroundTransparency = 1
	Chevron.Text = "⌄"
	Chevron.TextColor3 = Config.White
	Chevron.TextSize = 19
	Chevron.Font = Enum.Font.GothamBold
	Chevron.Parent = Header

	local Blank = Instance.new("Frame")
	Blank.Name = "Modules"
	Blank.Size = UDim2.new(1, 0, 0, 58)
	Blank.Position = UDim2.fromOffset(0, 42)
	Blank.BackgroundTransparency = 1
	Blank.BorderSizePixel = 0
	Blank.Parent = Panel

	CategoryPanels[Name] = Panel

	return Panel
end

for Index, Name in ipairs(Categories) do
	CreateCategory(Name, Index)
end

local Menu = Instance.new("Frame")
Menu.Name = "SideMenu"
Menu.Size = UDim2.fromOffset(190, 330)
Menu.Position = UDim2.fromOffset(12, 62)
Menu.BackgroundColor3 = Config.Black
Menu.BackgroundTransparency = 0.03
Menu.BorderSizePixel = 0
Menu.Visible = false
Menu.ZIndex = 50
Menu.Parent = Gui

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

local MenuItems = {
	{"⚙", "Settings"},
	{"♙", "Profiles"},
	{"◎", "Targets"},
	{"◆", "Themes"},
	{"⌨", "Keybinds"},
	{"?", "About"}
}

local MenuList = Instance.new("UIListLayout")
MenuList.Padding = UDim.new(0, 4)
MenuList.SortOrder = Enum.SortOrder.LayoutOrder
MenuList.Parent = Menu

local MenuPadding = Instance.new("UIPadding")
MenuPadding.PaddingTop = UDim.new(0, 55)
MenuPadding.PaddingLeft = UDim.new(0, 5)
MenuPadding.PaddingRight = UDim.new(0, 5)
MenuPadding.Parent = Menu

for Index, Data in ipairs(MenuItems) do
	local IconText = Data[1]
	local ItemName = Data[2]

	local Button = Instance.new("TextButton")
	Button.Name = ItemName
	Button.Size = UDim2.new(1, 0, 0, 38)
	Button.BackgroundColor3 = Config.Darker
	Button.BackgroundTransparency = 0.05
	Button.BorderSizePixel = 0
	Button.Text = ""
	Button.AutoButtonColor = false
	Button.LayoutOrder = Index
	Button.ZIndex = 51
	Button.Parent = Menu

	local ButtonCorner = Instance.new("UICorner")
	ButtonCorner.CornerRadius = UDim.new(0, 4)
	ButtonCorner.Parent = Button

	local Icon = Instance.new("TextLabel")
	Icon.Size = UDim2.fromOffset(38, 38)
	Icon.BackgroundTransparency = 1
	Icon.Text = IconText
	Icon.TextColor3 = Config.Orange
	Icon.TextSize = 16
	Icon.Font = Enum.Font.GothamBold
	Icon.ZIndex = 52
	Icon.Parent = Button

	local Text = Instance.new("TextLabel")
	Text.Size = UDim2.new(1, -45, 1, 0)
	Text.Position = UDim2.fromOffset(42, 0)
	Text.BackgroundTransparency = 1
	Text.Text = ItemName
	Text.TextColor3 = Config.White
	Text.TextSize = 13
	Text.Font = Enum.Font.GothamSemibold
	Text.TextXAlignment = Enum.TextXAlignment.Left
	Text.ZIndex = 52
	Text.Parent = Button

	Button.MouseEnter:Connect(function()
		TweenService:Create(
			Button,
			TweenInfo.new(0.12),
			{
				BackgroundColor3 = Config.OrangeDark,
				BackgroundTransparency = 0.1
			}
		):Play()
	end)

	Button.MouseLeave:Connect(function()
		TweenService:Create(
			Button,
			TweenInfo.new(0.12),
			{
				BackgroundColor3 = Config.Darker,
				BackgroundTransparency = 0.05
			}
		):Play()
	end)

	Button.MouseButton1Click:Connect(function()
		print("[LanternVape] Selected:", ItemName)
	end)
end

MenuButton.MouseButton1Click:Connect(function()
	Menu.Visible = not Menu.Visible

	if Menu.Visible then
		Menu.BackgroundTransparency = 1

		TweenService:Create(
			Menu,
			TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundTransparency = 0.03}
		):Play()
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

		Input.Changed:Connect(function()
			if Input.UserInputState == Enum.UserInputState.End then
				Dragging = false
			end
		end)
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

local function UpdateScale()
	if not Camera then
		return
	end

	local Size = Camera.ViewportSize

	if Size.X < 600 then
		UIScale.Scale = 0.65
	elseif Size.X < 850 then
		UIScale.Scale = 0.8
	elseif Size.X < 1100 then
		UIScale.Scale = 0.9
	else
		UIScale.Scale = 1
	end
end

UpdateScale()

if Camera then
	Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)
end

print("[" .. Config.Name .. "] Loaded " .. Config.Version)
