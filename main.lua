local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
if not Player then return end

local PlayerGui = Player:WaitForChild("PlayerGui", 10)
if not PlayerGui then return end

local Config = {
    Name = "LanternVape",
    Version = "1.0.2",
    Icon = "rbxassetid://0",
    LoadingTime = 2.2,
    Orange = Color3.fromRGB(220,115,35),
    OrangeDark = Color3.fromRGB(145,68,20),
    Black = Color3.fromRGB(8,8,8),
    Dark = Color3.fromRGB(14,14,14),
    Darker = Color3.fromRGB(21,21,21),
    White = Color3.fromRGB(235,235,235),
    Gray = Color3.fromRGB(145,145,145)
}

local Old = PlayerGui:FindFirstChild("LanternVape")
if Old then Old:Destroy() end

local Gui = Instance.new("ScreenGui")
Gui.Name = "LanternVape"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

local function Tween(obj,time,props)
    local ok,t = pcall(function()
        return TweenService:Create(obj,TweenInfo.new(time,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),props)
    end)
    if ok and t then t:Play() end
end

local function Corner(obj,r)
    local c=Instance.new("UICorner")
    c.CornerRadius=UDim.new(0,r)
    c.Parent=obj
    return c
end

local function AddStroke(obj,color,transparency,thickness)
    local s=Instance.new("UIStroke")
    s.Color=color
    s.Transparency=transparency or 0
    s.Thickness=thickness or 1
    s.Parent=obj
    return s
end

-- Loading screen
local Loading=Instance.new("Frame")
Loading.Name="Loading"
Loading.Size=UDim2.fromScale(1,1)
Loading.BackgroundColor3=Config.Black
Loading.BackgroundTransparency=0.08
Loading.BorderSizePixel=0
Loading.ZIndex=1000
Loading.Parent=Gui

local LoadingTint=Instance.new("Frame")
LoadingTint.Size=UDim2.fromScale(1,1)
LoadingTint.BackgroundColor3=Config.Orange
LoadingTint.BackgroundTransparency=0.96
LoadingTint.BorderSizePixel=0
LoadingTint.ZIndex=1001
LoadingTint.Parent=Loading

local LoadingTitle=Instance.new("TextLabel")
LoadingTitle.Size=UDim2.new(1,0,0,50)
LoadingTitle.Position=UDim2.new(0,0,0.5,-35)
LoadingTitle.BackgroundTransparency=1
LoadingTitle.Text="LOADING LANTERNVAPE.."
LoadingTitle.TextColor3=Config.Orange
LoadingTitle.TextSize=25
LoadingTitle.Font=Enum.Font.GothamBold
LoadingTitle.ZIndex=1002
LoadingTitle.Parent=Loading

local LoadingBack=Instance.new("Frame")
LoadingBack.Size=UDim2.fromOffset(240,4)
LoadingBack.AnchorPoint=Vector2.new(0.5,0)
LoadingBack.Position=UDim2.new(0.5,0,0.5,25)
LoadingBack.BackgroundColor3=Config.Darker
LoadingBack.BorderSizePixel=0
LoadingBack.ZIndex=1002
LoadingBack.Parent=Loading
Corner(LoadingBack,10)

local LoadingBar=Instance.new("Frame")
LoadingBar.Size=UDim2.new(0,0,1,0)
LoadingBar.BackgroundColor3=Config.Orange
LoadingBar.BorderSizePixel=0
LoadingBar.ZIndex=1003
LoadingBar.Parent=LoadingBack
Corner(LoadingBar,10)

-- Main GUI respects Roblox's safe area.
local Main=Instance.new("Frame")
Main.Name="Main"
Main.Size=UDim2.new(1,-30,1,-30)
Main.Position=UDim2.fromOffset(15,15)
Main.BackgroundTransparency=1
Main.Visible=false
Main.Parent=Gui

local Scale=Instance.new("UIScale")
Scale.Scale=1
Scale.Parent=Main

-- Header
local Brand=Instance.new("TextLabel")
Brand.Size=UDim2.fromOffset(190,42)
Brand.Position=UDim2.fromOffset(4,4)
Brand.BackgroundColor3=Config.Black
Brand.BackgroundTransparency=.05
Brand.BorderSizePixel=0
Brand.Text=Config.Name
Brand.TextColor3=Config.White
Brand.TextSize=18
Brand.Font=Enum.Font.GothamBold
Brand.TextXAlignment=Enum.TextXAlignment.Left
Brand.Parent=Main
Corner(Brand,5)
local BP=Instance.new("UIPadding")
BP.PaddingLeft=UDim.new(0,14)
BP.Parent=Brand
local BA=Instance.new("Frame")
BA.Size=UDim2.new(1,0,0,2)
BA.Position=UDim2.new(0,0,1,-2)
BA.BackgroundColor3=Config.Orange
BA.BorderSizePixel=0
BA.Parent=Brand

local MenuButton=Instance.new("TextButton")
MenuButton.Size=UDim2.fromOffset(42,42)
MenuButton.Position=UDim2.fromOffset(202,4)
MenuButton.BackgroundColor3=Config.Black
MenuButton.BackgroundTransparency=.05
MenuButton.BorderSizePixel=0
MenuButton.Text="☰"
MenuButton.TextColor3=Config.White
MenuButton.TextSize=19
MenuButton.Font=Enum.Font.GothamBold
MenuButton.AutoButtonColor=false
MenuButton.Parent=Main
Corner(MenuButton,5)

local Search=Instance.new("TextBox")
Search.Size=UDim2.fromOffset(230,34)
Search.AnchorPoint=Vector2.new(.5,0)
Search.Position=UDim2.new(.5,0,0,8)
Search.BackgroundColor3=Config.Black
Search.BackgroundTransparency=.05
Search.BorderSizePixel=0
Search.PlaceholderText="Search..."
Search.PlaceholderColor3=Color3.fromRGB(110,110,110)
Search.Text=""
Search.TextColor3=Config.White
Search.TextSize=13
Search.Font=Enum.Font.Gotham
Search.ClearTextOnFocus=false
Search.Parent=Main
Corner(Search,5)
AddStroke(Search,Config.Orange,.8,1)
local SP=Instance.new("UIPadding")
SP.PaddingLeft=UDim.new(0,12)
SP.Parent=Search

local Version=Instance.new("TextLabel")
Version.Size=UDim2.fromOffset(90,42)
Version.Position=UDim2.new(1,-142,0,4)
Version.BackgroundTransparency=1
Version.Text="v"..Config.Version
Version.TextColor3=Config.Gray
Version.TextSize=12
Version.Font=Enum.Font.Gotham
Version.TextXAlignment=Enum.TextXAlignment.Right
Version.Parent=Main

local Close=Instance.new("TextButton")
Close.Size=UDim2.fromOffset(42,42)
Close.Position=UDim2.new(1,-46,0,4)
Close.BackgroundColor3=Config.Black
Close.BackgroundTransparency=.05
Close.BorderSizePixel=0
Close.Text="×"
Close.TextColor3=Config.White
Close.TextSize=25
Close.Font=Enum.Font.Gotham
Close.AutoButtonColor=false
Close.Parent=Main
Corner(Close,5)

-- Content
local Content=Instance.new("ScrollingFrame")
Content.Name="Categories"
Content.Size=UDim2.new(1,-8,1,-62)
Content.Position=UDim2.fromOffset(4,58)
Content.BackgroundTransparency=1
Content.BorderSizePixel=0
Content.ScrollBarThickness=3
Content.ScrollBarImageColor3=Config.Orange
Content.CanvasSize=UDim2.new(0,0,0,0)
Content.AutomaticCanvasSize=Enum.AutomaticSize.Y
Content.ScrollingDirection=Enum.ScrollingDirection.Y
Content.Parent=Main

local Grid=Instance.new("UIGridLayout")
Grid.CellPadding=UDim2.fromOffset(7,7)
Grid.CellSize=UDim2.new(.2,-7,0,115)
Grid.FillDirection=Enum.FillDirection.Horizontal
Grid.FillDirectionMaxCells=5
Grid.SortOrder=Enum.SortOrder.LayoutOrder
Grid.Parent=Content

local Categories={"Combat","Blatant","External","Rendering","Extra"}
local CategoryPanels={}

for i,name in ipairs(Categories) do
    local Panel=Instance.new("Frame")
    Panel.Name=name
    Panel.LayoutOrder=i
    Panel.BackgroundColor3=Config.Black
    Panel.BackgroundTransparency=.12
    Panel.BorderSizePixel=0
    Panel.Parent=Content
    Corner(Panel,5)
    AddStroke(Panel,Config.Orange,.88,1)

    local Header=Instance.new("TextLabel")
    Header.Size=UDim2.new(1,0,0,42)
    Header.BackgroundColor3=Config.Black
    Header.BackgroundTransparency=.02
    Header.BorderSizePixel=0
    Header.Text=name
    Header.TextColor3=Config.White
    Header.TextSize=16
    Header.Font=Enum.Font.GothamBold
    Header.TextXAlignment=Enum.TextXAlignment.Left
    Header.Parent=Panel
    Corner(Header,5)
    local P=Instance.new("UIPadding")
    P.PaddingLeft=UDim.new(0,14)
    P.Parent=Header
    local A=Instance.new("Frame")
    A.Size=UDim2.new(1,0,0,2)
    A.Position=UDim2.new(0,0,1,-2)
    A.BackgroundColor3=Config.Orange
    A.BackgroundTransparency=.15
    A.BorderSizePixel=0
    A.Parent=Header

    local Modules=Instance.new("Frame")
    Modules.Name="Modules"
    Modules.Size=UDim2.new(1,0,1,-42)
    Modules.Position=UDim2.fromOffset(0,42)
    Modules.BackgroundTransparency=1
    Modules.Parent=Panel
    CategoryPanels[name]=Panel
end

-- Side menu
local SideMenu=Instance.new("Frame")
SideMenu.Name="SideMenu"
SideMenu.Size=UDim2.fromOffset(190,330)
SideMenu.Position=UDim2.fromOffset(10,58)
SideMenu.BackgroundColor3=Config.Black
SideMenu.BackgroundTransparency=.02
SideMenu.BorderSizePixel=0
SideMenu.Visible=false
SideMenu.ZIndex=50
SideMenu.Parent=Main
Corner(SideMenu,6)
AddStroke(SideMenu,Config.Orange,.65,1)

local SideHeader=Instance.new("TextLabel")
SideHeader.Size=UDim2.new(1,0,0,50)
SideHeader.BackgroundColor3=Config.Darker
SideHeader.BorderSizePixel=0
SideHeader.Text="LanternVape"
SideHeader.TextColor3=Config.White
SideHeader.TextSize=17
SideHeader.Font=Enum.Font.GothamBold
SideHeader.ZIndex=51
SideHeader.Parent=SideMenu
Corner(SideHeader,6)
local SA=Instance.new("Frame")
SA.Size=UDim2.new(1,0,0,2)
SA.Position=UDim2.new(0,0,1,-2)
SA.BackgroundColor3=Config.Orange
SA.BorderSizePixel=0
SA.ZIndex=52
SA.Parent=SideHeader

local List=Instance.new("UIListLayout")
List.Padding=UDim.new(0,4)
List.SortOrder=Enum.SortOrder.LayoutOrder
List.Parent=SideMenu
local MP=Instance.new("UIPadding")
MP.PaddingTop=UDim.new(0,55)
MP.PaddingLeft=UDim.new(0,5)
MP.PaddingRight=UDim.new(0,5)
MP.Parent=SideMenu

local Items={{"⚙","Settings"},{"♙","Profiles"},{"◎","Targets"},{"◆","Themes"},{"⌨","Keybinds"},{"?","About"}}
for i,data in ipairs(Items) do
    local Button=Instance.new("TextButton")
    Button.Name=data[2]
    Button.Size=UDim2.new(1,0,0,38)
    Button.BackgroundColor3=Config.Darker
    Button.BorderSizePixel=0
    Button.Text=""
    Button.AutoButtonColor=false
    Button.LayoutOrder=i
    Button.ZIndex=51
    Button.Parent=SideMenu
    Corner(Button,4)

    local I=Instance.new("TextLabel")
    I.Size=UDim2.fromOffset(38,38)
    I.BackgroundTransparency=1
    I.Text=data[1]
    I.TextColor3=Config.Orange
    I.TextSize=16
    I.Font=Enum.Font.GothamBold
    I.ZIndex=52
    I.Parent=Button

    local T=Instance.new("TextLabel")
    T.Size=UDim2.new(1,-45,1,0)
    T.Position=UDim2.fromOffset(42,0)
    T.BackgroundTransparency=1
    T.Text=data[2]
    T.TextColor3=Config.White
    T.TextSize=13
    T.Font=Enum.Font.GothamSemibold
    T.TextXAlignment=Enum.TextXAlignment.Left
    T.ZIndex=52
    T.Parent=Button

    Button.MouseEnter:Connect(function() Tween(Button,.12,{BackgroundColor3=Config.OrangeDark}) end)
    Button.MouseLeave:Connect(function() Tween(Button,.12,{BackgroundColor3=Config.Darker}) end)
end

-- Mobile toggle
local MobileToggle=Instance.new("ImageButton")
MobileToggle.Name="MobileToggle"
MobileToggle.Size=UDim2.fromOffset(58,58)
MobileToggle.Position=UDim2.new(0,18,.5,-29)
MobileToggle.BackgroundColor3=Config.Black
MobileToggle.BackgroundTransparency=.08
MobileToggle.BorderSizePixel=0
MobileToggle.Image=Config.Icon
MobileToggle.ScaleType=Enum.ScaleType.Fit
MobileToggle.Visible=false
MobileToggle.ZIndex=200
MobileToggle.Parent=Gui
Corner(MobileToggle,12)
AddStroke(MobileToggle,Config.Orange,.15,2)
local Fallback=Instance.new("TextLabel")
Fallback.Size=UDim2.fromScale(1,1)
Fallback.BackgroundTransparency=1
Fallback.Text="LV"
Fallback.TextColor3=Config.Orange
Fallback.TextSize=18
Fallback.Font=Enum.Font.GothamBold
Fallback.ZIndex=201
Fallback.Parent=MobileToggle
if Config.Icon~="rbxassetid://0" then Fallback.Visible=false end

local function Toggle()
    Main.Visible=not Main.Visible
    if not Main.Visible then SideMenu.Visible=false end
end

MenuButton.MouseButton1Click:Connect(function() SideMenu.Visible=not SideMenu.Visible end)
Close.MouseButton1Click:Connect(function() Main.Visible=false SideMenu.Visible=false end)
MobileToggle.MouseButton1Click:Connect(Toggle)

UserInputService.InputBegan:Connect(function(input,processed)
    if processed then return end
    if input.KeyCode==Enum.KeyCode.LeftShift or input.KeyCode==Enum.KeyCode.RightShift then Toggle() end
end)

Search:GetPropertyChangedSignal("Text"):Connect(function()
    local q=string.lower(Search.Text)
    for name,panel in pairs(CategoryPanels) do
        panel.Visible=(q=="") or (string.find(string.lower(name),q,1,true)~=nil)
    end
end)

-- Dragging
local dragging=false
local dragStart
local startPos
Brand.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        dragging=true
        dragStart=input.Position
        startPos=Main.Position
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end
end)
UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
        local d=input.Position-dragStart
        Main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
    end
end)

-- Same five columns everywhere; only the overall scale changes.
local Camera=workspace.CurrentCamera
local function UpdateLayout()
    Camera=workspace.CurrentCamera or Camera
    if not Camera then return end

    Grid.FillDirectionMaxCells=5
    Grid.CellSize=UDim2.new(.2,-7,0,115)

    local width=Camera.ViewportSize.X
    if width<500 then
        Scale.Scale=.52
    elseif width<650 then
        Scale.Scale=.62
    elseif width<800 then
        Scale.Scale=.72
    elseif width<1000 then
        Scale.Scale=.84
    else
        Scale.Scale=1
    end
end
UpdateLayout()
if Camera then Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateLayout) end

-- Everything is constructed before the loading wait.
Tween(LoadingBar,Config.LoadingTime,{Size=UDim2.new(1,0,1,0)})
task.wait(Config.LoadingTime)

Main.Visible=true
if UserInputService.TouchEnabled then MobileToggle.Visible=true end

Tween(Loading,.35,{BackgroundTransparency=1})
Tween(LoadingTint,.35,{BackgroundTransparency=1})
Tween(LoadingTitle,.35,{TextTransparency=1})
Tween(LoadingBack,.35,{BackgroundTransparency=1})
Tween(LoadingBar,.35,{BackgroundTransparency=1})

task.wait(.4)
if Loading and Loading.Parent then Loading:Destroy() end

print("["..Config.Name.."] Loaded "..Config.Version)