local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")

local Player = Players.LocalPlayer
if not Player then return end
local PlayerGui = Player:WaitForChild("PlayerGui", 10)
if not PlayerGui then return end

local Config = {
    Name = "LanternVape",
    Version = "2.03",
    Icon = "rbxassetid://0",
    CloseIcon = "rbxassetid://0",
    SettingsIcon = "rbxassetid://3599164226",
    ProfilesIcon = "rbxassetid://7074334159",
    TargetsIcon = "rbxassetid://0",
    ThemesIcon = "rbxassetid://0",
    KeybindsIcon = "rbxassetid://0",
    AboutIcon = "rbxassetid://0",
    LoadingTime = 2.2,
    Orange = Color3.fromRGB(220,115,35),
    OrangeDark = Color3.fromRGB(145,68,20),
    Black = Color3.fromRGB(8,8,8),
    Dark = Color3.fromRGB(14,14,14),
    Darker = Color3.fromRGB(21,21,21),
    White = Color3.fromRGB(245,245,245),
    Gray = Color3.fromRGB(145,145,145)
}

local old = PlayerGui:FindFirstChild("LanternVape")
if old then old:Destroy() end

local Gui = Instance.new("ScreenGui")
Gui.Name = "LanternVape"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

local function Corner(o,r)
    local c=Instance.new("UICorner")
    c.CornerRadius=UDim.new(0,r)
    c.Parent=o
    return c
end

local function Stroke(o,color,t,thick)
    local s=Instance.new("UIStroke")
    s.Color=color
    s.Transparency=t or 0
    s.Thickness=thick or 1
    s.Parent=o
    return s
end

local function Tween(o,time,p)
    local ok,t=pcall(function()
        return TweenService:Create(o,TweenInfo.new(time,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),p)
    end)
    if ok and t then t:Play() end
end

local function ValidIcon(v)
    return typeof(v)=="string" and v~="" and v~="rbxassetid://0"
end

--==================================================
-- LOADING
--==================================================

local Loading=Instance.new("Frame")
Loading.Size=UDim2.fromScale(1,1)
Loading.BackgroundColor3=Config.Black
Loading.BackgroundTransparency=.08
Loading.BorderSizePixel=0
Loading.ZIndex=1000
Loading.Parent=Gui

local Tint=Instance.new("Frame")
Tint.Size=UDim2.fromScale(1,1)
Tint.BackgroundColor3=Config.Orange
Tint.BackgroundTransparency=.96
Tint.BorderSizePixel=0
Tint.ZIndex=1001
Tint.Parent=Loading

local LoadingTitle=Instance.new("TextLabel")
LoadingTitle.Size=UDim2.new(1,0,0,50)
LoadingTitle.Position=UDim2.new(0,0,.5,-35)
LoadingTitle.BackgroundTransparency=1
LoadingTitle.Text="LOADING LANTERNVAPE.."
LoadingTitle.TextColor3=Config.Orange
LoadingTitle.TextSize=25
LoadingTitle.Font=Enum.Font.GothamBold
LoadingTitle.ZIndex=1002
LoadingTitle.Parent=Loading

local BarBG=Instance.new("Frame")
BarBG.Size=UDim2.fromOffset(240,4)
BarBG.AnchorPoint=Vector2.new(.5,0)
BarBG.Position=UDim2.new(.5,0,.5,25)
BarBG.BackgroundColor3=Config.Darker
BarBG.BorderSizePixel=0
BarBG.ZIndex=1002
BarBG.Parent=Loading
Corner(BarBG,10)

local Bar=Instance.new("Frame")
Bar.Size=UDim2.new(0,0,1,0)
Bar.BackgroundColor3=Config.Orange
Bar.BorderSizePixel=0
Bar.ZIndex=1003
Bar.Parent=BarBG
Corner(Bar,10)

--==================================================
-- MAIN
--==================================================

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

-- Header: no menu button anymore
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

local Search=Instance.new("TextBox")
Search.Size=UDim2.fromOffset(230,34)
Search.AnchorPoint=Vector2.new(.5,0)
Search.Position=UDim2.new(.5,0,0,8)
Search.BackgroundColor3=Config.Black
Search.BackgroundTransparency=.05
Search.BorderSizePixel=0
Search.PlaceholderText="Search.."
Search.PlaceholderColor3=Color3.fromRGB(110,110,110)
Search.Text=""
Search.TextColor3=Config.White
Search.TextSize=13
Search.Font=Enum.Font.Gotham
Search.ClearTextOnFocus=false
Search.Parent=Main
Corner(Search,5)
Stroke(Search,Config.Orange,.8,1)

local SP=Instance.new("UIPadding")
SP.PaddingLeft=UDim.new(0,38)
SP.Parent=Search

local SearchFallback=Instance.new("TextLabel")
SearchFallback.Size=UDim2.fromOffset(20,20)
SearchFallback.Position=UDim2.fromOffset(9,7)
SearchFallback.BackgroundTransparency=1
SearchFallback.Text="⌕"
SearchFallback.TextColor3=Config.Gray
SearchFallback.TextSize=18
SearchFallback.Font=Enum.Font.Gotham
SearchFallback.Parent=Search

local Close=Instance.new("ImageButton")
Close.Size=UDim2.fromOffset(42,42)
Close.Position=UDim2.new(1,-46,0,4)
Close.BackgroundColor3=Config.Black
Close.BackgroundTransparency=.05
Close.BorderSizePixel=0
Close.AutoButtonColor=false
Close.Parent=Main
Corner(Close,5)

if ValidIcon(Config.CloseIcon) then
    Close.Image=Config.CloseIcon
else
    local CF=Instance.new("TextLabel")
    CF.Size=UDim2.fromScale(1,1)
    CF.BackgroundTransparency=1
    CF.Text="×"
    CF.TextColor3=Config.White
    CF.TextSize=25
    CF.Font=Enum.Font.Gotham
    CF.Parent=Close
end

--==================================================
-- FOOTER - CENTERED
--==================================================

local Footer=Instance.new("Frame")
Footer.Name="Footer"
Footer.Size=UDim2.new(1,-8,0,28)
Footer.AnchorPoint=Vector2.new(.5,1)
Footer.Position=UDim2.new(.5,0,1,-2)
Footer.BackgroundTransparency=1
Footer.Parent=Main

local FooterLayout=Instance.new("UIListLayout")
FooterLayout.FillDirection=Enum.FillDirection.Horizontal
FooterLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
FooterLayout.VerticalAlignment=Enum.VerticalAlignment.Center
FooterLayout.Padding=UDim.new(0,10)
FooterLayout.Parent=Footer

local Version=Instance.new("TextLabel")
Version.AutomaticSize=Enum.AutomaticSize.X
Version.Size=UDim2.fromOffset(0,24)
Version.BackgroundTransparency=1
Version.Text="v"..Config.Version
Version.TextColor3=Color3.new(1,1,1)
Version.TextSize=12
Version.Font=Enum.Font.GothamBold
Version.Parent=Footer
Stroke(Version,Color3.new(0,0,0),0,1.5)

local Thanks=Instance.new("TextLabel")
Thanks.AutomaticSize=Enum.AutomaticSize.X
Thanks.Size=UDim2.fromOffset(0,24)
Thanks.BackgroundTransparency=1
Thanks.Text="Thank you for choosing LanternVape! Join the discord: https://discord.gg/Pa7aGyKjPR"
Thanks.TextColor3=Color3.new(1,1,1)
Thanks.TextSize=11
Thanks.Font=Enum.Font.Gotham
Thanks.Parent=Footer
Stroke(Thanks,Color3.new(0,0,0),0,1.2)

--==================================================
-- LEFT SIDEBAR - ALWAYS VISIBLE
--==================================================

local SideMenu=Instance.new("Frame")
SideMenu.Name="SideMenu"
SideMenu.Size=UDim2.fromOffset(245,0)
SideMenu.Position=UDim2.fromOffset(4,58)
SideMenu.AnchorPoint=Vector2.new(0,0)
SideMenu.BackgroundColor3=Config.Black
SideMenu.BackgroundTransparency=.02
SideMenu.BorderSizePixel=0
SideMenu.Visible=true
SideMenu.ZIndex=20
SideMenu.Parent=Main
Corner(SideMenu,7)
Stroke(SideMenu,Config.Orange,.55,1)

local SideHeader=Instance.new("Frame")
SideHeader.Size=UDim2.new(1,0,0,58)
SideHeader.BackgroundColor3=Config.Darker
SideHeader.BorderSizePixel=0
SideHeader.ZIndex=21
SideHeader.Parent=SideMenu
Corner(SideHeader,7)

local SideTitle=Instance.new("TextLabel")
SideTitle.Size=UDim2.new(1,-20,0,26)
SideTitle.Position=UDim2.fromOffset(14,8)
SideTitle.BackgroundTransparency=1
SideTitle.Text="LanternVape"
SideTitle.TextColor3=Config.White
SideTitle.TextSize=17
SideTitle.Font=Enum.Font.GothamBold
SideTitle.TextXAlignment=Enum.TextXAlignment.Left
SideTitle.ZIndex=22
SideTitle.Parent=SideHeader

local SideSubtitle=Instance.new("TextLabel")
SideSubtitle.Size=UDim2.new(1,-20,0,18)
SideSubtitle.Position=UDim2.fromOffset(14,33)
SideSubtitle.BackgroundTransparency=1
SideSubtitle.Text="Control Panel"
SideSubtitle.TextColor3=Config.Gray
SideSubtitle.TextSize=11
SideSubtitle.Font=Enum.Font.Gotham
SideSubtitle.TextXAlignment=Enum.TextXAlignment.Left
SideSubtitle.ZIndex=22
SideSubtitle.Parent=SideHeader

local SideAccent=Instance.new("Frame")
SideAccent.Size=UDim2.new(1,-20,0,2)
SideAccent.Position=UDim2.new(0,10,1,-2)
SideAccent.BackgroundColor3=Config.Orange
SideAccent.BorderSizePixel=0
SideAccent.ZIndex=23
SideAccent.Parent=SideHeader

local MenuList=Instance.new("UIListLayout")
MenuList.Padding=UDim.new(0,5)
MenuList.SortOrder=Enum.SortOrder.LayoutOrder
MenuList.Parent=SideMenu

local MenuPadding=Instance.new("UIPadding")
MenuPadding.PaddingTop=UDim.new(0,67)
MenuPadding.PaddingLeft=UDim.new(0,7)
MenuPadding.PaddingRight=UDim.new(0,7)
MenuPadding.Parent=SideMenu

local MenuItems={
    {"⚙","Settings"},
    {"♙","Profiles"},
    {"◎","Targets"},
    {"◆","Themes"},
    {"⌨","Keybinds"},
    {"?","About"}
}

local MenuButtons={}

for i,data in ipairs(MenuItems) do
    local Button=Instance.new("TextButton")
    Button.Name=data[2]
    Button.Size=UDim2.new(1,0,0,42)
    Button.BackgroundColor3=Config.Darker
    Button.BorderSizePixel=0
    Button.Text=""
    Button.AutoButtonColor=false
    Button.LayoutOrder=i
    Button.ZIndex=21
    Button.Parent=SideMenu
    Corner(Button,5)

    local Icon=Instance.new("TextLabel")
    Icon.Size=UDim2.fromOffset(25,25)
    Icon.Position=UDim2.fromOffset(9,8)
    Icon.BackgroundTransparency=1
    Icon.Text=data[1]
    Icon.TextColor3=Config.Orange
    Icon.TextSize=16
    Icon.Font=Enum.Font.GothamBold
    Icon.ZIndex=22
    Icon.Parent=Button

    local Text=Instance.new("TextLabel")
    Text.Size=UDim2.new(1,-55,1,0)
    Text.Position=UDim2.fromOffset(45,0)
    Text.BackgroundTransparency=1
    Text.Text=data[2]
    Text.TextColor3=Config.White
    Text.TextSize=13
    Text.Font=Enum.Font.GothamSemibold
    Text.TextXAlignment=Enum.TextXAlignment.Left
    Text.ZIndex=22
    Text.Parent=Button

    MenuButtons[data[2]]=Button

    Button.MouseEnter:Connect(function()
        Tween(Button,.12,{BackgroundColor3=Config.OrangeDark})
    end)
    Button.MouseLeave:Connect(function()
        Tween(Button,.12,{BackgroundColor3=Config.Darker})
    end)
end

--==================================================
-- RIGHT CONTENT AREA - NEVER UNDER SIDEBAR
--==================================================

local Content=Instance.new("ScrollingFrame")
Content.Name="Categories"
Content.Position=UDim2.fromOffset(263,58)
Content.Size=UDim2.new(1,-267,1,-94)
Content.BackgroundTransparency=1
Content.BorderSizePixel=0
Content.ScrollBarThickness=3
Content.ScrollBarImageColor3=Config.Orange
Content.CanvasSize=UDim2.new(0,0,0,0)
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
local Panels={}
local Enabled={Combat=true,Blatant=true,External=true,Rendering=true,Extra=true}

for i,name in ipairs(Categories) do
    local Panel=Instance.new("Frame")
    Panel.Name=name
    Panel.LayoutOrder=i
    Panel.BackgroundColor3=Config.Black
    Panel.BackgroundTransparency=.12
    Panel.BorderSizePixel=0
    Panel.Parent=Content
    Corner(Panel,5)
    Stroke(Panel,Config.Orange,.88,1)
    Panels[name]=Panel

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

    local Pad=Instance.new("UIPadding")
    Pad.PaddingLeft=UDim.new(0,14)
    Pad.Parent=Header

    local Accent=Instance.new("Frame")
    Accent.Size=UDim2.new(1,0,0,2)
    Accent.Position=UDim2.new(0,0,1,-2)
    Accent.BackgroundColor3=Config.Orange
    Accent.BorderSizePixel=0
    Accent.Parent=Header

    local Modules=Instance.new("Frame")
    Modules.Name="Modules"
    Modules.Size=UDim2.new(1,0,1,-42)
    Modules.Position=UDim2.fromOffset(0,42)
    Modules.BackgroundTransparency=1
    Modules.Parent=Panel
end

--==================================================
-- PAGE PANELS - REPLACE CONTENT, NEVER OVERLAP
--==================================================

local PageHolder=Instance.new("Frame")
PageHolder.Name="PageHolder"
PageHolder.Position=Content.Position
PageHolder.Size=Content.Size
PageHolder.BackgroundTransparency=1
PageHolder.Visible=false
PageHolder.ZIndex=40
PageHolder.Parent=Main

local SettingsPage=Instance.new("Frame")
SettingsPage.Size=UDim2.fromScale(1,1)
SettingsPage.BackgroundColor3=Config.Black
SettingsPage.BackgroundTransparency=.02
SettingsPage.BorderSizePixel=0
SettingsPage.Visible=false
SettingsPage.Parent=PageHolder
Corner(SettingsPage,7)
Stroke(SettingsPage,Config.Orange,.55,1)

local ThemesPage=SettingsPage:Clone()
ThemesPage.Name="ThemesPage"
ThemesPage.Visible=false
ThemesPage.Parent=PageHolder

local function PageTitle(parent,title,subtitle)
    local T=Instance.new("TextLabel")
    T.Size=UDim2.new(1,-30,0,35)
    T.Position=UDim2.fromOffset(15,10)
    T.BackgroundTransparency=1
    T.Text=title
    T.TextColor3=Config.White
    T.TextSize=18
    T.Font=Enum.Font.GothamBold
    T.TextXAlignment=Enum.TextXAlignment.Left
    T.ZIndex=42
    T.Parent=parent

    local S=Instance.new("TextLabel")
    S.Size=UDim2.new(1,-30,0,22)
    S.Position=UDim2.fromOffset(15,40)
    S.BackgroundTransparency=1
    S.Text=subtitle
    S.TextColor3=Config.Gray
    S.TextSize=11
    S.Font=Enum.Font.Gotham
    S.TextXAlignment=Enum.TextXAlignment.Left
    S.ZIndex=42
    S.Parent=parent
end

PageTitle(SettingsPage,"Settings","Choose which categories are visible")
PageTitle(ThemesPage,"Themes","Choose an accent color")

local SettingsList=Instance.new("UIListLayout")
SettingsList.Padding=UDim.new(0,5)
SettingsList.SortOrder=Enum.SortOrder.LayoutOrder
SettingsList.Parent=SettingsPage
local SettingsPad=Instance.new("UIPadding")
SettingsPad.PaddingTop=UDim.new(0,72)
SettingsPad.PaddingLeft=UDim.new(0,12)
SettingsPad.PaddingRight=UDim.new(0,12)
SettingsPad.Parent=SettingsPage

local function ToggleButton(parent,text,order,state,callback)
    local B=Instance.new("TextButton")
    B.Size=UDim2.new(1,0,0,36)
    B.BackgroundColor3=Config.Darker
    B.BorderSizePixel=0
    B.Text=""
    B.AutoButtonColor=false
    B.LayoutOrder=order
    B.ZIndex=43
    B.Parent=parent
    Corner(B,5)

    local L=Instance.new("TextLabel")
    L.Size=UDim2.new(1,-65,1,0)
    L.Position=UDim2.fromOffset(12,0)
    L.BackgroundTransparency=1
    L.Text=text
    L.TextColor3=Config.White
    L.TextSize=12
    L.Font=Enum.Font.GothamSemibold
    L.TextXAlignment=Enum.TextXAlignment.Left
    L.ZIndex=44
    L.Parent=B

    local Switch=Instance.new("Frame")
    Switch.Size=UDim2.fromOffset(34,18)
    Switch.Position=UDim2.new(1,-47,.5,-9)
    Switch.BorderSizePixel=0
    Switch.ZIndex=44
    Switch.Parent=B
    Corner(Switch,20)

    local Knob=Instance.new("Frame")
    Knob.Size=UDim2.fromOffset(14,14)
    Knob.BorderSizePixel=0
    Knob.ZIndex=45
    Knob.Parent=Switch
    Corner(Knob,20)

    local function Render()
        Switch.BackgroundColor3=state and Config.Orange or Config.Darker
        Knob.BackgroundColor3=Config.White
        Knob.Position=state and UDim2.fromOffset(18,2) or UDim2.fromOffset(2,2)
    end
    Render()

    B.MouseButton1Click:Connect(function()
        state=not state
        Render()
        callback(state)
    end)
end

for i,name in ipairs(Categories) do
    ToggleButton(SettingsPage,"Show "..name,i,true,function(v)
        Enabled[name]=v
        Panels[name].Visible=v
    end)
end

local ThemeGrid=Instance.new("UIGridLayout")
ThemeGrid.CellSize=UDim2.fromOffset(105,38)
ThemeGrid.CellPadding=UDim2.fromOffset(7,7)
ThemeGrid.Parent=ThemesPage
local ThemePad=Instance.new("UIPadding")
ThemePad.PaddingTop=UDim.new(0,72)
ThemePad.PaddingLeft=UDim.new(0,12)
ThemePad.PaddingRight=UDim.new(0,12)
ThemePad.Parent=ThemesPage

local ThemeColors={
    Orange=Color3.fromRGB(220,115,35),
    Purple=Color3.fromRGB(150,85,220),
    Blue=Color3.fromRGB(70,135,235),
    Green=Color3.fromRGB(70,190,110),
    Red=Color3.fromRGB(220,65,65),
    Pink=Color3.fromRGB(220,85,155)
}

local ThemeObjects={}
for _,obj in ipairs(Gui:GetDescendants()) do
    if obj:IsA("UIStroke") then
        ThemeObjects[#ThemeObjects+1]=obj
    end
end

local function ApplyTheme(color)
    Config.Orange=color
    Config.OrangeDark=color:Lerp(Color3.new(0,0,0),.35)

    for _,obj in ipairs(Gui:GetDescendants()) do
        if obj:IsA("UIStroke") then
            local isBlack = obj.Color.R < .15 and obj.Color.G < .15 and obj.Color.B < .15
            if not isBlack then obj.Color=color end
        elseif obj:IsA("ScrollingFrame") then
            obj.ScrollBarImageColor3=color
        elseif obj:IsA("Frame") then
            if obj.Name=="SideAccent" or obj.Name=="BA" then obj.BackgroundColor3=color end
        elseif obj:IsA("TextLabel") or obj:IsA("TextButton") then
            if obj.TextColor3.R > .65 and obj.TextColor3.G < .65 then
                obj.TextColor3=color
            end
        end
    end
end

for name,color in pairs(ThemeColors) do
    local B=Instance.new("TextButton")
    B.Name=name
    B.BackgroundColor3=Config.Darker
    B.BorderSizePixel=0
    B.Text=name
    B.TextColor3=Config.White
    B.TextSize=12
    B.Font=Enum.Font.GothamSemibold
    B.AutoButtonColor=false
    B.ZIndex=43
    B.Parent=ThemesPage
    Corner(B,5)

    local Dot=Instance.new("Frame")
    Dot.Size=UDim2.fromOffset(10,10)
    Dot.Position=UDim2.fromOffset(9,14)
    Dot.BackgroundColor3=color
    Dot.BorderSizePixel=0
    Dot.ZIndex=44
    Dot.Parent=B
    Corner(Dot,20)

    B.TextXAlignment=Enum.TextXAlignment.Right
    local P=Instance.new("UIPadding")
    P.PaddingRight=UDim.new(0,9)
    P.Parent=B

    B.MouseButton1Click:Connect(function()
        ApplyTheme(color)
    end)
end

local function ShowCategories()
    Content.Visible=true
    PageHolder.Visible=false
    SettingsPage.Visible=false
    ThemesPage.Visible=false
end

local function ShowPage(page)
    Content.Visible=false
    PageHolder.Visible=true
    SettingsPage.Visible=(page==SettingsPage)
    ThemesPage.Visible=(page==ThemesPage)
end

MenuButtons.Settings.MouseButton1Click:Connect(function()
    ShowPage(SettingsPage)
end)

MenuButtons.Themes.MouseButton1Click:Connect(function()
    ShowPage(ThemesPage)
end)

for name,button in pairs(MenuButtons) do
    if name~="Settings" and name~="Themes" then
        button.MouseButton1Click:Connect(function()
            ShowCategories()
        end)
    end
end

--==================================================
-- SEARCH
--==================================================

Search:GetPropertyChangedSignal("Text"):Connect(function()
    local q=string.lower(Search.Text)
    for name,p in pairs(Panels) do
        p.Visible=Enabled[name] and (q=="" or string.find(string.lower(name),q,1,true)~=nil)
    end
end)

--==================================================
-- MOBILE TOGGLE
--==================================================

local Mobile=Instance.new("ImageButton")
Mobile.Name="MobileToggle"
Mobile.Size=UDim2.fromOffset(52,52)
Mobile.AnchorPoint=Vector2.new(1,0)
Mobile.Position=UDim2.new(1,-16,0,16)
Mobile.BackgroundColor3=Config.Black
Mobile.BackgroundTransparency=.08
Mobile.BorderSizePixel=0
Mobile.Visible=false
Mobile.ZIndex=200
Mobile.Parent=Gui
Corner(Mobile,12)
Stroke(Mobile,Config.Orange,.15,2)

if ValidIcon(Config.Icon) then
    Mobile.Image=Config.Icon
else
    local ML=Instance.new("TextLabel")
    ML.Size=UDim2.fromScale(1,1)
    ML.BackgroundTransparency=1
    ML.Text="LV"
    ML.TextColor3=Config.Orange
    ML.TextSize=18
    ML.Font=Enum.Font.GothamBold
    ML.ZIndex=201
    ML.Parent=Mobile
end

local function ToggleMain()
    Main.Visible=not Main.Visible
end

Close.MouseButton1Click:Connect(function()
    Main.Visible=false
end)
Mobile.MouseButton1Click:Connect(ToggleMain)

UIS.InputBegan:Connect(function(input,processed)
    if processed then return end
    if input.KeyCode==Enum.KeyCode.LeftShift or input.KeyCode==Enum.KeyCode.RightShift then
        ToggleMain()
    end
end)

--==================================================
-- RESPONSIVE LAYOUT
--==================================================

local Camera=workspace.CurrentCamera

local function UpdateLayout()
    Camera=workspace.CurrentCamera or Camera
    if not Camera then return end

    local w=Camera.ViewportSize.X
    if w<500 then
        Scale.Scale=.55
    elseif w<650 then
        Scale.Scale=.65
    elseif w<800 then
        Scale.Scale=.75
    elseif w<1000 then
        Scale.Scale=.85
    else
        Scale.Scale=1
    end

    if w<800 then
        Mobile.Size=UDim2.fromOffset(48,48)
    else
        Mobile.Size=UDim2.fromOffset(52,52)
    end

    local tl,br=GuiService:GetGuiInset()
    Main.Position=UDim2.fromOffset(15,15+tl.Y)
    Main.Size=UDim2.new(1,-30,1,-30-tl.Y-br.Y)

    local sideHeight=math.max(150,Main.AbsoluteSize.Y-66)
    SideMenu.Size=UDim2.fromOffset(245,sideHeight)

    if UIS.TouchEnabled then
        Mobile.Position=UDim2.new(1,-16,0,16+tl.Y)
    end
end

UpdateLayout()
if Camera then
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateLayout)
end

--==================================================
-- LOADING FINISH
--==================================================

local Finished=false
local function FinishLoading()
    if Finished then return end
    Finished=true
    Main.Visible=true
    Mobile.Visible=UIS.TouchEnabled

    Tween(Loading,.35,{BackgroundTransparency=1})
    Tween(Tint,.35,{BackgroundTransparency=1})
    Tween(LoadingTitle,.35,{TextTransparency=1})
    Tween(BarBG,.35,{BackgroundTransparency=1})
    Tween(Bar,.35,{BackgroundTransparency=1})

    task.delay(.4,function()
        if Loading and Loading.Parent then Loading:Destroy() end
    end)
end

Tween(Bar,Config.LoadingTime,{Size=UDim2.new(1,0,1,0)})
task.delay(Config.LoadingTime,FinishLoading)
task.delay(5,FinishLoading)

print("["..Config.Name.."] Loaded "..Config.Version)
