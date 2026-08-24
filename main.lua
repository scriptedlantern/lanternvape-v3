local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
if not Player then return end
local PlayerGui = Player:WaitForChild("PlayerGui", 10)
if not PlayerGui then return end

local Config = {
    Name = "LanternVape",
    Version = "2.09",
    Icon = "rbxassetid://0",
    CloseIcon = "rbxassetid://0",
    SettingsIcon = "rbxassetid://6031280882",
    ProfilesIcon = "rbxassetid://6031075930",
    TargetsIcon = "rbxassetid://6031763426",
    ThemesIcon = "rbxassetid://6031094678",
    KeybindsIcon = "rbxassetid://129697930",
    AboutIcon = "rbxassetid://6031075930",
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
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,r)
    c.Parent = o
    return c
end

local function Stroke(o,c,t,w)
    local s = Instance.new("UIStroke")
    s.Color = c
    s.Transparency = t or 0
    s.Thickness = w or 1
    s.Parent = o
    return s
end

local function Tween(o,t,p)
    local ok,x = pcall(function()
        return TweenService:Create(o,TweenInfo.new(t,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),p)
    end)
    if ok and x then x:Play() end
end

local function Valid(v)
    return typeof(v) == "string" and v ~= "" and v ~= "rbxassetid://0"
end

local Loading = Instance.new("Frame")
Loading.Size = UDim2.fromScale(1,1)
Loading.BackgroundColor3 = Config.Black
Loading.BackgroundTransparency = .08
Loading.BorderSizePixel = 0
Loading.ZIndex = 1000
Loading.Parent = Gui

local Tint = Instance.new("Frame")
Tint.Size = UDim2.fromScale(1,1)
Tint.BackgroundColor3 = Config.Orange
Tint.BackgroundTransparency = .96
Tint.BorderSizePixel = 0
Tint.ZIndex = 1001
Tint.Parent = Loading

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Size = UDim2.new(1,0,0,50)
LoadingTitle.Position = UDim2.new(0,0,.5,-35)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "LOADING LANTERNVAPE.."
LoadingTitle.TextColor3 = Config.Orange
LoadingTitle.TextSize = 25
LoadingTitle.Font = Enum.Font.GothamBold
LoadingTitle.ZIndex = 1002
LoadingTitle.Parent = Loading

local BarBG = Instance.new("Frame")
BarBG.Size = UDim2.fromOffset(240,4)
BarBG.AnchorPoint = Vector2.new(.5,0)
BarBG.Position = UDim2.new(.5,0,.5,25)
BarBG.BackgroundColor3 = Config.Darker
BarBG.BorderSizePixel = 0
BarBG.ZIndex = 1002
BarBG.Parent = Loading
Corner(BarBG,10)

local Bar = Instance.new("Frame")
Bar.Size = UDim2.new(0,0,1,0)
Bar.BackgroundColor3 = Config.Orange
Bar.BorderSizePixel = 0
Bar.ZIndex = 1003
Bar.Parent = BarBG
Corner(Bar,10)

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(1,-30,1,-30)
Main.Position = UDim2.fromOffset(15,15)
Main.BackgroundTransparency = 1
Main.Visible = false
Main.Parent = Gui

local Scale = Instance.new("UIScale")
Scale.Scale = .92
Scale.Parent = Main

local Brand = Instance.new("TextLabel")
Brand.Size = UDim2.fromOffset(190,42)
Brand.Position = UDim2.fromOffset(4,4)
Brand.BackgroundColor3 = Config.Black
Brand.BackgroundTransparency = .05
Brand.BorderSizePixel = 0
Brand.Text = Config.Name
Brand.TextColor3 = Config.White
Brand.TextSize = 18
Brand.Font = Enum.Font.GothamBold
Brand.TextXAlignment = Enum.TextXAlignment.Left
Brand.Parent = Main
Corner(Brand,5)

local BP = Instance.new("UIPadding")
BP.PaddingLeft = UDim.new(0,14)
BP.Parent = Brand

local BA = Instance.new("Frame")
BA.Size = UDim2.new(1,0,0,2)
BA.Position = UDim2.new(0,0,1,-2)
BA.BackgroundColor3 = Config.Orange
BA.BorderSizePixel = 0
BA.Parent = Brand

local Search = Instance.new("TextBox")
Search.Size = UDim2.fromOffset(230,34)
Search.AnchorPoint = Vector2.new(.5,0)
Search.Position = UDim2.new(.5,0,0,8)
Search.BackgroundColor3 = Config.Black
Search.BackgroundTransparency = .05
Search.BorderSizePixel = 0
Search.PlaceholderText = "Search.."
Search.PlaceholderColor3 = Color3.fromRGB(110,110,110)
Search.Text = ""
Search.TextColor3 = Config.White
Search.TextSize = 13
Search.Font = Enum.Font.Gotham
Search.ClearTextOnFocus = false
Search.Parent = Main
Corner(Search,5)
Stroke(Search,Config.Orange,.8,1)

local SP = Instance.new("UIPadding")
SP.PaddingLeft = UDim.new(0,38)
SP.Parent = Search

local SearchFallback = Instance.new("TextLabel")
SearchFallback.Size = UDim2.fromOffset(20,20)
SearchFallback.Position = UDim2.fromOffset(9,7)
SearchFallback.BackgroundTransparency = 1
SearchFallback.Text = "⌕"
SearchFallback.TextColor3 = Config.Gray
SearchFallback.TextSize = 18
SearchFallback.Parent = Search

local Close = Instance.new("ImageButton")
Close.Size = UDim2.fromOffset(42,42)
Close.Position = UDim2.new(1,-46,0,4)
Close.BackgroundColor3 = Config.Black
Close.BackgroundTransparency = .05
Close.BorderSizePixel = 0
Close.AutoButtonColor = false
Close.Parent = Main
Corner(Close,5)

if Valid(Config.CloseIcon) then
    Close.Image = Config.CloseIcon
else
    local x = Instance.new("TextLabel")
    x.Size = UDim2.fromScale(1,1)
    x.BackgroundTransparency = 1
    x.Text = "×"
    x.TextColor3 = Config.White
    x.TextSize = 25
    x.Font = Enum.Font.Gotham
    x.Parent = Close
end

local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(1,-8,0,28)
Footer.AnchorPoint = Vector2.new(.5,1)
Footer.Position = UDim2.new(.5,0,1,-2)
Footer.BackgroundTransparency = 1
Footer.Parent = Main

local FL = Instance.new("UIListLayout")
FL.FillDirection = Enum.FillDirection.Horizontal
FL.HorizontalAlignment = Enum.HorizontalAlignment.Center
FL.VerticalAlignment = Enum.VerticalAlignment.Center
FL.Padding = UDim.new(0,10)
FL.Parent = Footer

local Version = Instance.new("TextLabel")
Version.AutomaticSize = Enum.AutomaticSize.X
Version.Size = UDim2.fromOffset(0,24)
Version.BackgroundTransparency = 1
Version.Text = "v"..Config.Version
Version.TextColor3 = Color3.new(1,1,1)
Version.TextSize = 12
Version.Font = Enum.Font.GothamBold
Version.Parent = Footer
Stroke(Version,Color3.new(0,0,0),0,1.5)

local Thanks = Instance.new("TextLabel")
Thanks.AutomaticSize = Enum.AutomaticSize.X
Thanks.Size = UDim2.fromOffset(0,24)
Thanks.BackgroundTransparency = 1
Thanks.Text = "Thank you for choosing LanternVape! Join the discord: https://discord.gg/Pa7aGyKjPR"
Thanks.TextColor3 = Color3.new(1,1,1)
Thanks.TextSize = 11
Thanks.Font = Enum.Font.Gotham
Thanks.Parent = Footer
Stroke(Thanks,Color3.new(0,0,0),0,1.2)

local SideMenu = Instance.new("Frame")
SideMenu.Name = "SideMenu"
SideMenu.Size = UDim2.fromOffset(235,0)
SideMenu.Position = UDim2.fromOffset(4,58)
SideMenu.BackgroundTransparency = 1
SideMenu.BorderSizePixel = 0
SideMenu.Visible = true
SideMenu.ZIndex = 20
SideMenu.Parent = Main

local SideHeader = Instance.new("Frame")
SideHeader.Size = UDim2.new(1,0,0,58)
SideHeader.BackgroundColor3 = Config.Black
SideHeader.BackgroundTransparency = .02
SideHeader.BorderSizePixel = 0
SideHeader.ZIndex = 21
SideHeader.Parent = SideMenu
Corner(SideHeader,7)
Stroke(SideHeader,Config.Orange,.55,1)

local SideTitle = Instance.new("TextLabel")
SideTitle.Size = UDim2.new(1,-20,0,26)
SideTitle.Position = UDim2.fromOffset(14,8)
SideTitle.BackgroundTransparency = 1
SideTitle.Text = "LanternVape"
SideTitle.TextColor3 = Config.White
SideTitle.TextSize = 17
SideTitle.Font = Enum.Font.GothamBold
SideTitle.TextXAlignment = Enum.TextXAlignment.Left
SideTitle.ZIndex = 22
SideTitle.Parent = SideHeader

local SideSubtitle = Instance.new("TextLabel")
SideSubtitle.Size = UDim2.new(1,-20,0,18)
SideSubtitle.Position = UDim2.fromOffset(14,33)
SideSubtitle.BackgroundTransparency = 1
SideSubtitle.Text = "Control Panel"
SideSubtitle.TextColor3 = Config.Gray
SideSubtitle.TextSize = 11
SideSubtitle.Font = Enum.Font.Gotham
SideSubtitle.ZIndex = 22
SideSubtitle.Parent = SideHeader

local SideAccent = Instance.new("Frame")
SideAccent.Size = UDim2.new(1,-20,0,2)
SideAccent.Position = UDim2.new(0,10,1,-2)
SideAccent.BackgroundColor3 = Config.Orange
SideAccent.BorderSizePixel = 0
SideAccent.ZIndex = 23
SideAccent.Parent = SideHeader

local Menu = Instance.new("Frame")
Menu.Size = UDim2.new(1,0,1,-63)
Menu.Position = UDim2.fromOffset(0,63)
Menu.BackgroundTransparency = 1
Menu.Parent = SideMenu

local ML = Instance.new("UIListLayout")
ML.Padding = UDim.new(0,5)
ML.SortOrder = Enum.SortOrder.LayoutOrder
ML.Parent = Menu

local MP = Instance.new("UIPadding")
MP.PaddingLeft = UDim.new(0,7)
MP.PaddingRight = UDim.new(0,7)
MP.Parent = Menu

local Items = {
    {"Settings",Config.SettingsIcon,"⚙"},
    {"Profiles",Config.ProfilesIcon,"♙"},
    {"Targets",Config.TargetsIcon,"◎"},
    {"Themes",Config.ThemesIcon,"◆"},
    {"Keybinds",Config.KeybindsIcon,"⌨"},
    {"About",Config.AboutIcon,"?"}
}

local MenuButtons = {}
for i,d in ipairs(Items) do
    local B = Instance.new("TextButton")
    B.Name = d[1]
    B.Size = UDim2.new(1,0,0,40)
    B.BackgroundColor3 = Config.Darker
    B.BorderSizePixel = 0
    B.Text = ""
    B.AutoButtonColor = false
    B.LayoutOrder = i
    B.ZIndex = 21
    B.Parent = Menu
    Corner(B,5)

    local I = Instance.new("ImageLabel")
    I.Size = UDim2.fromOffset(19,19)
    I.Position = UDim2.fromOffset(11,10)
    I.BackgroundTransparency = 1
    I.ImageColor3 = Config.Orange
    I.ZIndex = 22
    I.Parent = B

    local F = Instance.new("TextLabel")
    F.Size = UDim2.fromOffset(22,22)
    F.Position = UDim2.fromOffset(10,9)
    F.BackgroundTransparency = 1
    F.Text = d[3]
    F.TextColor3 = Config.Orange
    F.TextSize = 16
    F.Font = Enum.Font.GothamBold
    F.ZIndex = 22
    F.Parent = B

    if Valid(d[2]) then
        I.Image = d[2]
        F.Visible = false
    else
        I.Visible = false
    end

    local T = Instance.new("TextLabel")
    T.Size = UDim2.new(1,-55,1,0)
    T.Position = UDim2.fromOffset(45,0)
    T.BackgroundTransparency = 1
    T.Text = d[1]
    T.TextColor3 = Config.White
    T.TextSize = 13
    T.Font = Enum.Font.GothamSemibold
    T.TextXAlignment = Enum.TextXAlignment.Left
    T.ZIndex = 22
    T.Parent = B

    MenuButtons[d[1]] = B

    B.MouseEnter:Connect(function()
        Tween(B,.12,{BackgroundColor3=Config.OrangeDark})
    end)
    B.MouseLeave:Connect(function()
        Tween(B,.12,{BackgroundColor3=Config.Darker})
    end)
end

local Content = Instance.new("ScrollingFrame")
Content.Name = "Categories"
Content.Position = UDim2.fromOffset(252,58)
Content.Size = UDim2.new(1,-256,1,-94)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = Config.Orange
Content.CanvasSize = UDim2.fromOffset(0,0)
Content.ScrollingDirection = Enum.ScrollingDirection.Y
Content.Parent = Main

local Categories = {"Combat","Blatant","External","Rendering","Extra"}
local Panels = {}
local Enabled = {Combat=true,Blatant=true,External=true,Rendering=true,Extra=true}
local Moved = {}

local function makePanel(name,index)
    local P = Instance.new("Frame")
    P.Name = name
    P.BackgroundColor3 = Config.Black
    P.BackgroundTransparency = .12
    P.BorderSizePixel = 0
    P.ZIndex = 5
    P.Parent = Content
    Corner(P,5)
    Stroke(P,Config.Orange,.88,1)
    Panels[name] = P

    local H = Instance.new("TextLabel")
    H.Name = "Header"
    H.Size = UDim2.new(1,0,0,38)
    H.BackgroundColor3 = Config.Black
    H.BackgroundTransparency = .02
    H.BorderSizePixel = 0
    H.Text = name
    H.TextColor3 = Config.White
    H.TextSize = 15
    H.Font = Enum.Font.GothamBold
    H.TextXAlignment = Enum.TextXAlignment.Left
    H.ZIndex = 6
    H.Parent = P
    Corner(H,5)

    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0,12)
    pad.Parent = H

    local A = Instance.new("Frame")
    A.Size = UDim2.new(1,0,0,2)
    A.Position = UDim2.new(0,0,1,-2)
    A.BackgroundColor3 = Config.Orange
    A.BorderSizePixel = 0
    A.ZIndex = 7
    A.Parent = H

    local Modules = Instance.new("Frame")
    Modules.Name = "Modules"
    Modules.Size = UDim2.new(1,0,1,-38)
    Modules.Position = UDim2.fromOffset(0,38)
    Modules.BackgroundTransparency = 1
    Modules.Parent = P

    H.Active = true
    local dragging = false
    local startPos
    local startInput

    H.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startInput = input.Position
            startPos = P.Position
            P.ZIndex = 50
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
        local delta = input.Position - startInput
        P.Position = UDim2.fromOffset(startPos.X.Offset + delta.X,startPos.Y.Offset + delta.Y)
        Moved[name] = true
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            P.ZIndex = 5
        end
    end)

    return Modules
end

for i,n in ipairs(Categories) do
    makePanel(n,i)
end

local function LayoutCategories()
    local w = Content.AbsoluteSize.X
    if w <= 0 then return end
    local gap = 6
    local cols = 5
    local cw = math.max(1,(w-gap*(cols-1))/cols)
    local ch = 108
    for i,n in ipairs(Categories) do
        if not Moved[n] then
            local col = (i-1)%cols
            local row = math.floor((i-1)/cols)
            Panels[n].Size = UDim2.fromOffset(cw,ch)
            Panels[n].Position = UDim2.fromOffset(col*(cw+gap),row*(ch+gap))
        end
    end
    Content.CanvasSize = UDim2.fromOffset(0,math.max(0,math.ceil(#Categories/cols)*(ch+gap)-gap))
end
Content:GetPropertyChangedSignal("AbsoluteSize"):Connect(LayoutCategories)

local BlatantModules = Panels.Blatant:FindFirstChild("Modules")
local SpeedEnabled = false
local SpeedValue = 16
local SpeedConnection

local SpeedRow = Instance.new("Frame")
SpeedRow.Name = "Speed"
SpeedRow.Size = UDim2.new(1,-10,0,34)
SpeedRow.Position = UDim2.fromOffset(5,5)
SpeedRow.BackgroundColor3 = Config.Darker
SpeedRow.BorderSizePixel = 0
SpeedRow.Parent = BlatantModules
Corner(SpeedRow,5)
Stroke(SpeedRow,Config.Orange,.82,1)

local SpeedButton = Instance.new("TextButton")
SpeedButton.Size = UDim2.new(1,-42,1,0)
SpeedButton.BackgroundTransparency = 1
SpeedButton.Text = ""
SpeedButton.AutoButtonColor = false
SpeedButton.Parent = SpeedRow

local SpeedName = Instance.new("TextLabel")
SpeedName.Size = UDim2.new(1,-12,1,0)
SpeedName.Position = UDim2.fromOffset(10,0)
SpeedName.BackgroundTransparency = 1
SpeedName.Text = "Speed"
SpeedName.TextColor3 = Config.White
SpeedName.TextSize = 12
SpeedName.Font = Enum.Font.GothamSemibold
SpeedName.TextXAlignment = Enum.TextXAlignment.Left
SpeedName.Parent = SpeedButton

local SpeedDots = Instance.new("TextButton")
SpeedDots.Size = UDim2.fromOffset(36,34)
SpeedDots.Position = UDim2.new(1,-36,0,0)
SpeedDots.BackgroundTransparency = 1
SpeedDots.Text = "⋮"
SpeedDots.TextColor3 = Config.Gray
SpeedDots.TextSize = 19
SpeedDots.Font = Enum.Font.GothamBold
SpeedDots.AutoButtonColor = false
SpeedDots.Parent = SpeedRow

local SpeedMenu = Instance.new("Frame")
SpeedMenu.Size = UDim2.new(1,-10,0,72)
SpeedMenu.Position = UDim2.fromOffset(5,43)
SpeedMenu.BackgroundColor3 = Config.Black
SpeedMenu.BorderSizePixel = 0
SpeedMenu.Visible = false
SpeedMenu.ZIndex = 80
SpeedMenu.Parent = BlatantModules
Corner(SpeedMenu,6)
Stroke(SpeedMenu,Config.Orange,.45,1)

local SpeedValueLabel = Instance.new("TextLabel")
SpeedValueLabel.Size = UDim2.new(1,-20,0,20)
SpeedValueLabel.Position = UDim2.fromOffset(10,5)
SpeedValueLabel.BackgroundTransparency = 1
SpeedValueLabel.TextColor3 = Config.White
SpeedValueLabel.TextSize = 11
SpeedValueLabel.Font = Enum.Font.GothamSemibold
SpeedValueLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedValueLabel.ZIndex = 81
SpeedValueLabel.Parent = SpeedMenu

local SliderBG = Instance.new("Frame")
SliderBG.Size = UDim2.new(1,-20,0,6)
SliderBG.Position = UDim2.fromOffset(10,34)
SliderBG.BackgroundColor3 = Config.Darker
SliderBG.BorderSizePixel = 0
SliderBG.ZIndex = 81
SliderBG.Parent = SpeedMenu
Corner(SliderBG,6)

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0,0,1,0)
SliderFill.BackgroundColor3 = Config.Orange
SliderFill.BorderSizePixel = 0
SliderFill.ZIndex = 82
SliderFill.Parent = SliderBG
Corner(SliderFill,6)

local SliderKnob = Instance.new("Frame")
SliderKnob.Size = UDim2.fromOffset(12,12)
SliderKnob.AnchorPoint = Vector2.new(.5,.5)
SliderKnob.BackgroundColor3 = Config.White
SliderKnob.BorderSizePixel = 0
SliderKnob.ZIndex = 83
SliderKnob.Parent = SliderBG
Corner(SliderKnob,8)

local function SetSpeedValue(v)
    SpeedValue = math.clamp(math.floor(v + .5),16,26)
    SpeedValueLabel.Text = "WalkSpeed: "..SpeedValue
    local alpha = (SpeedValue-16)/10
    SliderFill.Size = UDim2.new(alpha,0,1,0)
    SliderKnob.Position = UDim2.new(alpha,0,.5,0)
end

local function ApplySpeed()
    local char = Player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        if SpeedEnabled then
            hum.WalkSpeed = SpeedValue
        end
    end
end

local function SetSpeedEnabled(v)
    SpeedEnabled = v
    SpeedRow.BackgroundColor3 = v and Config.OrangeDark or Config.Darker
    if SpeedConnection then
        SpeedConnection:Disconnect()
        SpeedConnection = nil
    end
    if v then
        ApplySpeed()
        SpeedConnection = RunService.Heartbeat:Connect(function()
            ApplySpeed()
        end)
    else
        local char = Player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 16 end
    end
end

SpeedButton.MouseButton1Click:Connect(function()
    SetSpeedEnabled(not SpeedEnabled)
end)

SpeedDots.MouseButton1Click:Connect(function()
    SpeedMenu.Visible = not SpeedMenu.Visible
end)

local draggingSlider = false
local function UpdateSlider(x)
    local left = SliderBG.AbsolutePosition.X
    local width = SliderBG.AbsoluteSize.X
    if width <= 0 then return end
    local alpha = math.clamp((x-left)/width,0,1)
    SetSpeedValue(16 + alpha*10)
    if SpeedEnabled then ApplySpeed() end
end

SliderBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = true
        UpdateSlider(input.Position.X)
    end
end)

UIS.InputChanged:Connect(function(input)
    if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        UpdateSlider(input.Position.X)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = false
    end
end)

SetSpeedValue(16)
Player.CharacterAdded:Connect(function()
    task.wait(.25)
    ApplySpeed()
end)

local PageHolder = Instance.new("Frame")
PageHolder.Position = Content.Position
PageHolder.Size = Content.Size
PageHolder.BackgroundTransparency = 1
PageHolder.Visible = false
PageHolder.ZIndex = 40
PageHolder.Parent = Main

local Pages = {}

local function NewPage(name,titleText,subtitleText,width,height)
    local p = Instance.new("Frame")
    p.Name = name
    p.Size = UDim2.fromScale(width,height)
    p.AnchorPoint = Vector2.new(.5,.5)
    p.Position = UDim2.fromScale(.5,.5)
    p.BackgroundColor3 = Config.Black
    p.BackgroundTransparency = .02
    p.BorderSizePixel = 0
    p.Visible = false
    p.ZIndex = 41
    p.Parent = PageHolder
    Corner(p,8)
    Stroke(p,Config.Orange,.45,1)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,-20,0,22)
    title.Position = UDim2.fromOffset(10,7)
    title.BackgroundTransparency = 1
    title.Text = titleText
    title.TextColor3 = Config.White
    title.TextSize = 13
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 42
    title.Parent = p

    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1,-20,0,15)
    sub.Position = UDim2.fromOffset(10,27)
    sub.BackgroundTransparency = 1
    sub.Text = subtitleText
    sub.TextColor3 = Config.Gray
    sub.TextSize = 8
    sub.Font = Enum.Font.Gotham
    sub.TextXAlignment = Enum.TextXAlignment.Left
    sub.ZIndex = 42
    sub.Parent = p

    Pages[name] = p
    return p
end

local SettingsPage = NewPage("SettingsPage","Settings","Choose which categories are visible",.32,.42)
local ThemesPage = NewPage("ThemesPage","Themes","Choose an accent color",.32,.34)
local ProfilesPage = NewPage("ProfilesPage","Profiles","Manage your saved profiles",.52,.34)

local function MakeToggle(parent,text,order,state,callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-14,0,24)
    b.Position = UDim2.fromOffset(7,0)
    b.BackgroundColor3 = Config.Darker
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.LayoutOrder = order
    b.ZIndex = 43
    b.Parent = parent
    Corner(b,5)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-45,1,0)
    l.Position = UDim2.fromOffset(7,0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Config.White
    l.TextSize = 9
    l.Font = Enum.Font.GothamSemibold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 44
    l.Parent = b

    local sw = Instance.new("Frame")
    sw.Size = UDim2.fromOffset(25,14)
    sw.Position = UDim2.new(1,-32,.5,-7)
    sw.ZIndex = 44
    sw.Parent = b
    Corner(sw,20)

    local k = Instance.new("Frame")
    k.Size = UDim2.fromOffset(10,10)
    k.BackgroundColor3 = Config.White
    k.ZIndex = 45
    k.Parent = sw
    Corner(k,20)

    local function render()
        sw.BackgroundColor3 = state and Config.Orange or Config.Darker
        k.Position = state and UDim2.fromOffset(13,2) or UDim2.fromOffset(2,2)
    end
    render()

    b.MouseButton1Click:Connect(function()
        state = not state
        render()
        callback(state)
    end)
end

local SL = Instance.new("UIListLayout")
SL.Padding = UDim.new(0,3)
SL.Parent = SettingsPage
local SPad = Instance.new("UIPadding")
SPad.PaddingTop = UDim.new(0,48)
SPad.PaddingLeft = UDim.new(0,7)
SPad.PaddingRight = UDim.new(0,7)
SPad.Parent = SettingsPage

for i,n in ipairs(Categories) do
    MakeToggle(SettingsPage,"Show "..n,i,true,function(v)
        Enabled[n] = v
        Panels[n].Visible = v
    end)
end

local Themes = {
    Orange=Color3.fromRGB(220,115,35),
    Purple=Color3.fromRGB(150,85,220),
    Blue=Color3.fromRGB(70,135,235),
    Green=Color3.fromRGB(70,190,110),
    Red=Color3.fromRGB(220,65,65),
    Pink=Color3.fromRGB(220,85,155)
}

local TG = Instance.new("UIGridLayout")
TG.CellSize = UDim2.fromOffset(70,24)
TG.CellPadding = UDim2.fromOffset(4,4)
TG.Parent = ThemesPage
local TP = Instance.new("UIPadding")
TP.PaddingTop = UDim.new(0,48)
TP.PaddingLeft = UDim.new(0,7)
TP.PaddingRight = UDim.new(0,7)
TP.Parent = ThemesPage

for n,c in pairs(Themes) do
    local b = Instance.new("TextButton")
    b.Name = n
    b.BackgroundColor3 = Config.Darker
    b.BorderSizePixel = 0
    b.Text = n
    b.TextColor3 = Config.White
    b.TextSize = 8
    b.Font = Enum.Font.GothamSemibold
    b.AutoButtonColor = false
    b.ZIndex = 43
    b.Parent = ThemesPage
    Corner(b,5)

    local d = Instance.new("Frame")
    d.Size = UDim2.fromOffset(7,7)
    d.Position = UDim2.fromOffset(6,9)
    d.BackgroundColor3 = c
    d.BorderSizePixel = 0
    d.Parent = b
    Corner(d,20)

    b.TextXAlignment = Enum.TextXAlignment.Right
    local pp = Instance.new("UIPadding")
    pp.PaddingRight = UDim.new(0,6)
    pp.Parent = b

    b.MouseButton1Click:Connect(function()
        Config.Orange = c
        Config.OrangeDark = c:Lerp(Color3.new(0,0,0),.35)
        for _,o in ipairs(Gui:GetDescendants()) do
            if o:IsA("UIStroke") and not(o.Color == Color3.new(0,0,0)) then
                o.Color = c
            elseif o:IsA("ScrollingFrame") then
                o.ScrollBarImageColor3 = c
            elseif o:IsA("Frame") and (o.Name == "BA" or o.Name == "SideAccent") then
                o.BackgroundColor3 = c
            end
        end
    end)
end

local ProfileSearch = Instance.new("TextBox")
ProfileSearch.Size = UDim2.new(1,-18,0,22)
ProfileSearch.Position = UDim2.fromOffset(9,47)
ProfileSearch.BackgroundColor3 = Config.Darker
ProfileSearch.BorderSizePixel = 0
ProfileSearch.PlaceholderText = "Search profiles..."
ProfileSearch.PlaceholderColor3 = Config.Gray
ProfileSearch.TextColor3 = Config.White
ProfileSearch.TextSize = 8
ProfileSearch.Font = Enum.Font.Gotham
ProfileSearch.ZIndex = 43
ProfileSearch.Parent = ProfilesPage
Corner(ProfileSearch,5)
Stroke(ProfileSearch,Config.Orange,.75,1)

local NewProfileName = Instance.new("TextBox")
NewProfileName.Size = UDim2.new(1,-50,0,22)
NewProfileName.Position = UDim2.fromOffset(9,75)
NewProfileName.BackgroundColor3 = Config.Darker
NewProfileName.BorderSizePixel = 0
NewProfileName.PlaceholderText = "New profile name..."
NewProfileName.PlaceholderColor3 = Config.Gray
NewProfileName.TextColor3 = Config.White
NewProfileName.TextSize = 8
NewProfileName.Font = Enum.Font.Gotham
NewProfileName.ZIndex = 43
NewProfileName.Parent = ProfilesPage
Corner(NewProfileName,5)

local AddProfile = Instance.new("TextButton")
AddProfile.Size = UDim2.fromOffset(28,22)
AddProfile.Position = UDim2.new(1,-37,0,75)
AddProfile.BackgroundColor3 = Config.Orange
AddProfile.BorderSizePixel = 0
AddProfile.Text = "+"
AddProfile.TextColor3 = Color3.new(1,1,1)
AddProfile.TextSize = 16
AddProfile.Font = Enum.Font.GothamBold
AddProfile.ZIndex = 43
AddProfile.Parent = ProfilesPage
Corner(AddProfile,5)

local ProfileList = Instance.new("ScrollingFrame")
ProfileList.Size = UDim2.new(1,-18,1,-105)
ProfileList.Position = UDim2.fromOffset(9,103)
ProfileList.BackgroundTransparency = 1
ProfileList.BorderSizePixel = 0
ProfileList.ScrollBarThickness = 2
ProfileList.ScrollBarImageColor3 = Config.Orange
ProfileList.ZIndex = 43
ProfileList.Parent = ProfilesPage

local PL = Instance.new("UIListLayout")
PL.Padding = UDim.new(0,4)
PL.Parent = ProfileList

local profileNames = {"Default"}

local function RenderProfiles()
    for _,c in ipairs(ProfileList:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    local q = ProfileSearch.Text:lower()
    local shown = 0
    for _,name in ipairs(profileNames) do
        if q == "" or name:lower():find(q,1,true) then
            shown += 1
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1,0,0,28)
            b.BackgroundColor3 = Config.Darker
            b.BorderSizePixel = 0
            b.Text = name
            b.TextColor3 = Config.White
            b.TextSize = 9
            b.Font = Enum.Font.GothamSemibold
            b.Parent = ProfileList
            Corner(b,5)
        end
    end
    ProfileList.CanvasSize = UDim2.fromOffset(0,shown*32)
end

RenderProfiles()
ProfileSearch:GetPropertyChangedSignal("Text"):Connect(RenderProfiles)
AddProfile.MouseButton1Click:Connect(function()
    local n = NewProfileName.Text:gsub("^%s+",""):gsub("%s+$","")
    if n == "" then return end
    for _,e in ipairs(profileNames) do
        if e:lower() == n:lower() then return end
    end
    table.insert(profileNames,n)
    NewProfileName.Text = ""
    RenderProfiles()
end)

local function ShowCategories()
    Content.Visible = true
    PageHolder.Visible = false
    for _,p in pairs(Pages) do p.Visible = false end
end

local function ShowPage(page)
    Content.Visible = false
    PageHolder.Visible = true
    for _,p in pairs(Pages) do p.Visible = (p == page) end
end

MenuButtons.Settings.MouseButton1Click:Connect(function() ShowPage(SettingsPage) end)
MenuButtons.Profiles.MouseButton1Click:Connect(function() ShowPage(ProfilesPage) end)
MenuButtons.Themes.MouseButton1Click:Connect(function() ShowPage(ThemesPage) end)

for n,b in pairs(MenuButtons) do
    if n ~= "Settings" and n ~= "Profiles" and n ~= "Themes" then
        b.MouseButton1Click:Connect(ShowCategories)
    end
end

Search:GetPropertyChangedSignal("Text"):Connect(function()
    local q = Search.Text:lower()
    for n,p in pairs(Panels) do
        p.Visible = Enabled[n] and (q == "" or n:lower():find(q,1,true) ~= nil)
    end
end)

local Mobile = Instance.new("ImageButton")
Mobile.Name = "MobileToggle"
Mobile.Size = UDim2.fromOffset(40,40)
Mobile.AnchorPoint = Vector2.new(1,0)
Mobile.Position = UDim2.new(1,-8,0,8)
Mobile.BackgroundColor3 = Config.Black
Mobile.BackgroundTransparency = .08
Mobile.BorderSizePixel = 0
Mobile.Visible = false
Mobile.ZIndex = 200
Mobile.Parent = Gui
Corner(Mobile,10)
Stroke(Mobile,Config.Orange,.15,2)

if Valid(Config.Icon) then
    Mobile.Image = Config.Icon
else
    local m = Instance.new("TextLabel")
    m.Size = UDim2.fromScale(1,1)
    m.BackgroundTransparency = 1
    m.Text = "LV"
    m.TextColor3 = Config.Orange
    m.TextSize = 15
    m.Font = Enum.Font.GothamBold
    m.Parent = Mobile
end

local function toggleMain()
    Main.Visible = not Main.Visible
end

Close.MouseButton1Click:Connect(function() Main.Visible = false end)
Mobile.MouseButton1Click:Connect(toggleMain)

UIS.InputBegan:Connect(function(i,p)
    if not p and (i.KeyCode == Enum.KeyCode.LeftShift or i.KeyCode == Enum.KeyCode.RightShift) then
        toggleMain()
    end
end)

local Camera = workspace.CurrentCamera
local function Layout()
    Camera = workspace.CurrentCamera or Camera
    if not Camera then return end
    local w = Camera.ViewportSize.X
    Scale.Scale = (w < 500 and .52) or (w < 650 and .60) or (w < 800 and .70) or (w < 1000 and .82) or .92
    local tl,br = GuiService:GetGuiInset()
    Main.Position = UDim2.fromOffset(15,15+tl.Y)
    Main.Size = UDim2.new(1,-30,1,-30-tl.Y-br.Y)
    SideMenu.Size = UDim2.fromOffset(235,math.max(150,Main.AbsoluteSize.Y-66))
    if UIS.TouchEnabled then
        Mobile.Position = UDim2.new(1,-8,0,8+tl.Y)
    end
    LayoutCategories()
end

Layout()
if Camera then Camera:GetPropertyChangedSignal("ViewportSize"):Connect(Layout) end

local Finished = false
local function FinishLoading()
    if Finished then return end
    Finished = true
    Main.Visible = true
    Mobile.Visible = UIS.TouchEnabled
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