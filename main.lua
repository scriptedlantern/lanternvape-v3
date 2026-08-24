local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
if not Player then return end
local PlayerGui = Player:WaitForChild("PlayerGui", 10)
if not PlayerGui then return end

local Config = {
    Name = "LanternVape",
    Version = "2.11",
    Icon = "rbxassetid://6031154871",
    SearchIcon = "rbxassetid://6031154871",
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

-- BACKGROUND BLUR
local BackgroundBlur = Instance.new("BlurEffect")
BackgroundBlur.Name = "LanternVapeBlur"
BackgroundBlur.Size = 0
BackgroundBlur.Enabled = true
BackgroundBlur.Parent = Lighting

local function SetBackgroundBlur(enabled)
    local target = enabled and 14 or 0
    TweenService:Create(BackgroundBlur, TweenInfo.new(.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = target}):Play()
end

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

local function Image(parent,asset,size,pos,z)
    local i = Instance.new("ImageLabel")
    i.Size = size
    i.Position = pos
    i.BackgroundTransparency = 1
    i.Image = asset
    i.ImageColor3 = Config.Orange
    i.ScaleType = Enum.ScaleType.Fit
    i.ZIndex = z or 1
    i.Parent = parent
    return i
end

local function LoadRemoteAsset(url,name)
    local getter = getcustomasset or getsynasset
    if type(getter) ~= "function" or type(writefile) ~= "function" then
        return nil
    end
    local okData, data = pcall(function()
        return game:HttpGet(url)
    end)
    if not okData or type(data) ~= "string" or data == "" then
        return nil
    end
    local fileName = "LanternVape_"..name
    pcall(function()
        if type(isfile) ~= "function" or not isfile(fileName) then
            writefile(fileName, data)
        end
    end)
    local okAsset, asset = pcall(function()
        return getter(fileName)
    end)
    return okAsset and asset or nil
end

local MobileIconAsset = LoadRemoteAsset(
    "https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/assets/%20mobile_icon.png",
    "mobile_icon.png"
)
local LanternVapeTextAsset = LoadRemoteAsset(
    "https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/assets/lanternvape_text.png",
    "lanternvape_text.png"
)

local function ButtonIcon(parent,asset,size,pos,z)
    local b = Instance.new("ImageButton")
    b.Size = size
    b.Position = pos
    b.BackgroundTransparency = 1
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Image = asset
    b.ImageColor3 = Config.Orange
    b.ScaleType = Enum.ScaleType.Fit
    b.ZIndex = z or 1
    b.Parent = parent
    return b
end

-- LOADING SCREEN
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

-- MAIN WINDOW
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

-- SEARCH WITH REAL IMAGE ASSET
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
SP.PaddingLeft = UDim.new(0,30)
Search.TextXAlignment = Enum.TextXAlignment.Left
SP.Parent = Search

local SearchIcon = Image(Search,Config.SearchIcon,UDim2.fromOffset(14,14),UDim2.fromOffset(8,10),5)
SearchIcon.ImageColor3 = Config.Gray
SearchIcon.ZIndex = 6

-- NO OLD TOP-RIGHT CLOSE BUTTON

-- FOOTER
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

-- SIDEBAR ROOT
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

local SideTitle = Instance.new("ImageLabel")
SideTitle.Name = "LanternVapeLogo"
SideTitle.Size = UDim2.new(1,-20,0,32)
SideTitle.Position = UDim2.fromOffset(10,7)
SideTitle.BackgroundTransparency = 1
SideTitle.Image = LanternVapeTextAsset or ""
SideTitle.ImageColor3 = Color3.new(1,1,1)
SideTitle.ScaleType = Enum.ScaleType.Fit
SideTitle.ZIndex = 22
SideTitle.Parent = SideHeader

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
    {"Settings",Config.SettingsIcon},
    {"Profiles",Config.ProfilesIcon},
    {"Targets",Config.TargetsIcon},
    {"Themes",Config.ThemesIcon},
    {"Keybinds",Config.KeybindsIcon},
    {"About",Config.AboutIcon}
}

local MenuButtons = {}
local NormalMenuItems = {}

local function ClearMenu()
    for _,child in ipairs(Menu:GetChildren()) do
        if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end
    MenuButtons = {}
    NormalMenuItems = {}
end

local function MakeMenuButton(name,asset,order,callback)
    local B = Instance.new("TextButton")
    B.Name = name
    B.Size = UDim2.new(1,0,0,40)
    B.BackgroundColor3 = Config.Darker
    B.BorderSizePixel = 0
    B.Text = ""
    B.AutoButtonColor = false
    B.LayoutOrder = order
    B.ZIndex = 21
    B.Parent = Menu
    Corner(B,5)

    local I = Image(B,asset,UDim2.fromOffset(19,19),UDim2.fromOffset(11,10),22)
    I.ImageColor3 = Config.Orange

    local T = Instance.new("TextLabel")
    T.Size = UDim2.new(1,-55,1,0)
    T.Position = UDim2.fromOffset(45,0)
    T.BackgroundTransparency = 1
    T.Text = name
    T.TextColor3 = Config.White
    T.TextSize = 13
    T.Font = Enum.Font.GothamSemibold
    T.TextXAlignment = Enum.TextXAlignment.Left
    T.ZIndex = 22
    T.Parent = B

    B.MouseEnter:Connect(function()
        Tween(B,.12,{BackgroundColor3=Config.OrangeDark})
    end)
    B.MouseLeave:Connect(function()
        Tween(B,.12,{BackgroundColor3=Config.Darker})
    end)
    if callback then B.MouseButton1Click:Connect(callback) end
    return B
end

-- CATEGORY CONTENT
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

for i,n in ipairs(Categories) do makePanel(n,i) end

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

-- SPEED MODULE
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

-- Proper three-dot UI, no unicode fallback
local SpeedDots = Instance.new("ImageButton")
SpeedDots.Name = "SpeedOptions"
SpeedDots.Size = UDim2.fromOffset(36,34)
SpeedDots.Position = UDim2.new(1,-36,0,0)
SpeedDots.BackgroundTransparency = 1
SpeedDots.BorderSizePixel = 0
SpeedDots.AutoButtonColor = false
SpeedDots.Parent = SpeedRow
for i=1,3 do
    local dot = Instance.new("Frame")
    dot.Size = UDim2.fromOffset(4,4)
    dot.AnchorPoint = Vector2.new(.5,.5)
    dot.Position = UDim2.new(.5,(i-2)*7,.5,0)
    dot.BackgroundColor3 = Config.Gray
    dot.BorderSizePixel = 0
    dot.Parent = SpeedDots
    Corner(dot,4)
end

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
    if hum and SpeedEnabled then hum.WalkSpeed = SpeedValue end
end

local function SetSpeedEnabled(v)
    SpeedEnabled = v
    SpeedRow.BackgroundColor3 = v and Config.OrangeDark or Config.Darker
    if SpeedConnection then SpeedConnection:Disconnect(); SpeedConnection=nil end
    if v then
        ApplySpeed()
        SpeedConnection = RunService.Heartbeat:Connect(ApplySpeed)
    else
        local char = Player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 16 end
    end
end

SpeedButton.MouseButton1Click:Connect(function() SetSpeedEnabled(not SpeedEnabled) end)
SpeedDots.MouseButton1Click:Connect(function() SpeedMenu.Visible = not SpeedMenu.Visible end)

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
        draggingSlider=true
        UpdateSlider(input.Position.X)
    end
end)
UIS.InputChanged:Connect(function(input)
    if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then UpdateSlider(input.Position.X) end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSlider=false end
end)
SetSpeedValue(16)
Player.CharacterAdded:Connect(function() task.wait(.25); ApplySpeed() end)

-- UTILITY CONTENT AREA USED BY SETTINGS/THEMES
local Utility = Instance.new("Frame")
Utility.Name = "Utility"
Utility.Position = UDim2.fromOffset(252,58)
Utility.Size = UDim2.new(1,-256,1,-94)
Utility.BackgroundColor3 = Config.Black
Utility.BackgroundTransparency = .02
Utility.BorderSizePixel = 0
Utility.Visible = false
Utility.ZIndex = 40
Utility.Parent = Main
Corner(Utility,8)
Stroke(Utility,Config.Orange,.45,1)

local UtilityTitle = Instance.new("TextLabel")
UtilityTitle.Size = UDim2.new(1,-60,0,28)
UtilityTitle.Position = UDim2.fromOffset(14,10)
UtilityTitle.BackgroundTransparency = 1
UtilityTitle.TextColor3 = Config.White
UtilityTitle.TextSize = 17
UtilityTitle.Font = Enum.Font.GothamBold
UtilityTitle.TextXAlignment = Enum.TextXAlignment.Left
UtilityTitle.ZIndex = 41
UtilityTitle.Parent = Utility

local UtilitySubtitle = Instance.new("TextLabel")
UtilitySubtitle.Size = UDim2.new(1,-60,0,18)
UtilitySubtitle.Position = UDim2.fromOffset(14,36)
UtilitySubtitle.BackgroundTransparency = 1
UtilitySubtitle.TextColor3 = Config.Gray
UtilitySubtitle.TextSize = 10
UtilitySubtitle.Font = Enum.Font.Gotham
UtilitySubtitle.TextXAlignment = Enum.TextXAlignment.Left
UtilitySubtitle.ZIndex = 41
UtilitySubtitle.Parent = Utility

local UtilityBack = Instance.new("TextButton")
UtilityBack.Size = UDim2.fromOffset(34,34)
UtilityBack.Position = UDim2.new(1,-44,0,8)
UtilityBack.BackgroundColor3 = Config.Orange
UtilityBack.BorderSizePixel = 0
UtilityBack.Text = "×"
UtilityBack.TextColor3 = Color3.new(1,1,1)
UtilityBack.TextSize = 23
UtilityBack.Font = Enum.Font.GothamBold
UtilityBack.AutoButtonColor = false
UtilityBack.ZIndex = 45
UtilityBack.Parent = Utility
Corner(UtilityBack,7)

local UtilityBody = Instance.new("ScrollingFrame")
UtilityBody.Size = UDim2.new(1,-20,1,-68)
UtilityBody.Position = UDim2.fromOffset(10,62)
UtilityBody.BackgroundTransparency = 1
UtilityBody.BorderSizePixel = 0
UtilityBody.ScrollBarThickness = 2
UtilityBody.ScrollBarImageColor3 = Config.Orange
UtilityBody.ZIndex = 41
UtilityBody.Parent = Utility

local BodyList = Instance.new("UIListLayout")
BodyList.Padding = UDim.new(0,5)
BodyList.Parent = UtilityBody

local function ClearUtility()
    for _,c in ipairs(UtilityBody:GetChildren()) do
        if c ~= BodyList then c:Destroy() end
    end
end

local function UtilityRow(text,sub,callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-4,0,44)
    b.BackgroundColor3 = Config.Darker
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.ZIndex = 42
    b.Parent = UtilityBody
    Corner(b,6)
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1,-20,0,20)
    t.Position = UDim2.fromOffset(10,5)
    t.BackgroundTransparency = 1
    t.Text = text
    t.TextColor3 = Config.White
    t.TextSize = 11
    t.Font = Enum.Font.GothamSemibold
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.ZIndex = 43
    t.Parent = b
    if sub then
        local s = Instance.new("TextLabel")
        s.Size = UDim2.new(1,-20,0,15)
        s.Position = UDim2.fromOffset(10,24)
        s.BackgroundTransparency = 1
        s.Text = sub
        s.TextColor3 = Config.Gray
        s.TextSize = 8
        s.Font = Enum.Font.Gotham
        s.TextXAlignment = Enum.TextXAlignment.Left
        s.ZIndex = 43
        s.Parent = b
    end
    if callback then b.MouseButton1Click:Connect(callback) end
    return b
end

local function MakeSwitch(parent,text,state,callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-4,0,38)
    b.BackgroundColor3 = Config.Darker
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.ZIndex = 42
    b.Parent = parent
    Corner(b,6)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-60,1,0)
    l.Position = UDim2.fromOffset(10,0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Config.White
    l.TextSize = 10
    l.Font = Enum.Font.GothamSemibold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 43
    l.Parent = b
    local sw = Instance.new("Frame")
    sw.Size = UDim2.fromOffset(28,16)
    sw.Position = UDim2.new(1,-38,.5,-8)
    sw.BorderSizePixel = 0
    sw.ZIndex = 43
    sw.Parent = b
    Corner(sw,20)
    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(12,12)
    knob.BackgroundColor3 = Config.White
    knob.BorderSizePixel = 0
    knob.ZIndex = 44
    knob.Parent = sw
    Corner(knob,20)
    local function render()
        sw.BackgroundColor3 = state and Config.Orange or Config.Black
        knob.Position = state and UDim2.fromOffset(14,2) or UDim2.fromOffset(2,2)
    end
    render()
    b.MouseButton1Click:Connect(function()
        state = not state
        render()
        if callback then callback(state) end
    end)
end

local SettingsState = {ShowSearch=true,ShowFooter=true,CompactMobile=true,HideGUI=false,BlurBackground=true}

-- SETTINGS SIDEBAR
local function BuildSettingsSidebar()
    ClearMenu()
    SideTitle.Image = LanternVapeTextAsset or ""
    local b1 = MakeMenuButton("GUI",Config.SettingsIcon,1,function()
        Utility.Visible=true; Content.Visible=false; UtilityTitle.Text="GUI"; UtilitySubtitle.Text="Interface options"; ClearUtility()
        MakeSwitch(UtilityBody,"Show Search",SettingsState.ShowSearch,function(v) SettingsState.ShowSearch=v; Search.Visible=v end)
        MakeSwitch(UtilityBody,"Show Footer",SettingsState.ShowFooter,function(v) SettingsState.ShowFooter=v; Footer.Visible=v end)
        MakeSwitch(UtilityBody,"Compact Mobile",SettingsState.CompactMobile,function(v) SettingsState.CompactMobile=v; Layout() end)
        MakeSwitch(UtilityBody,"Hide GUI",SettingsState.HideGUI,function(v)
            SettingsState.HideGUI=v
            Main.Visible=not v
            Utility.Visible=false
            if v then SetBackgroundBlur(false) end
        end)
        MakeSwitch(UtilityBody,"Blur Background",SettingsState.BlurBackground,function(v)
            SettingsState.BlurBackground=v
            if not Main.Visible then SetBackgroundBlur(false) else SetBackgroundBlur(v) end
        end)
    end)
    local b2 = MakeMenuButton("Modules",Config.ProfilesIcon,2,function()
        Utility.Visible=true; Content.Visible=false; UtilityTitle.Text="Modules"; UtilitySubtitle.Text="Choose visible categories"; ClearUtility()
        for _,n in ipairs(Categories) do
            MakeSwitch(UtilityBody,"Show "..n,Enabled[n],function(v) Enabled[n]=v; Panels[n].Visible=v end)
        end
    end)
    local b3 = MakeMenuButton("Credits",Config.AboutIcon,3,function()
        Utility.Visible=true; Content.Visible=false; UtilityTitle.Text="Credits"; UtilitySubtitle.Text="LanternVape v"..Config.Version; ClearUtility()
        UtilityRow("LanternVape","UI / development")
        UtilityRow("Community","Thank you for using LanternVape!")
        UtilityRow("Discord","discord.gg/Pa7aGyKjPR")
    end)
end

-- THEME SIDEBAR
local Themes = {
    Orange=Color3.fromRGB(220,115,35), Purple=Color3.fromRGB(150,85,220), Blue=Color3.fromRGB(70,135,235),
    Green=Color3.fromRGB(70,190,110), Red=Color3.fromRGB(220,65,65), Pink=Color3.fromRGB(220,85,155)
}

local function ApplyTheme(c)
    Config.Orange=c
    Config.OrangeDark=c:Lerp(Color3.new(0,0,0),.35)
    for _,o in ipairs(Gui:GetDescendants()) do
        if o:IsA("UIStroke") and o.Color ~= Color3.new(0,0,0) then o.Color=c end
        if o:IsA("ScrollingFrame") then o.ScrollBarImageColor3=c end
        if o:IsA("TextButton") and o == UtilityBack then o.BackgroundColor3=c end
        if o:IsA("Frame") and (o.Name=="BA" or o.Name=="SideAccent") then o.BackgroundColor3=c end
        if o:IsA("ImageLabel") or o:IsA("ImageButton") then
            if o.Name ~= "SearchIcon" then o.ImageColor3=c end
        end
    end
end

local function BuildThemeSidebar()
    ClearMenu()
    SideTitle.Image = LanternVapeTextAsset or ""
    MakeMenuButton("Colors",Config.ThemesIcon,1,function()
        Utility.Visible=true; Content.Visible=false; UtilityTitle.Text="Themes"; UtilitySubtitle.Text="Choose an accent color"; ClearUtility()
        local grid=Instance.new("UIGridLayout")
        grid.CellSize=UDim2.fromOffset(105,34)
        grid.CellPadding=UDim2.fromOffset(6,6)
        grid.Parent=UtilityBody
        for n,c in pairs(Themes) do
            local b=Instance.new("TextButton")
            b.BackgroundColor3=Config.Darker
            b.BorderSizePixel=0
            b.Text=n
            b.TextColor3=Config.White
            b.TextSize=10
            b.Font=Enum.Font.GothamSemibold
            b.AutoButtonColor=false
            b.ZIndex=42
            b.Parent=UtilityBody
            Corner(b,6)
            local d=Instance.new("Frame")
            d.Size=UDim2.fromOffset(8,8)
            d.Position=UDim2.fromOffset(8,13)
            d.BackgroundColor3=c
            d.BorderSizePixel=0
            d.ZIndex=43
            d.Parent=b
            Corner(d,8)
            b.TextXAlignment=Enum.TextXAlignment.Right
            local p=Instance.new("UIPadding")
            p.PaddingRight=UDim.new(0,9)
            p.Parent=b
            b.MouseButton1Click:Connect(function() ApplyTheme(c) end)
        end
    end)
    MakeMenuButton("Presets",Config.ProfilesIcon,2,function()
        Utility.Visible=true; Content.Visible=false; UtilityTitle.Text="Theme Presets"; UtilitySubtitle.Text="Quick accent presets"; ClearUtility()
        for n,c in pairs(Themes) do UtilityRow(n,"Apply the "..n.." accent",function() ApplyTheme(c) end) end
    end)
end

-- NORMAL SIDEBAR
local function BuildNormalSidebar()
    ClearMenu()
    SideTitle.Image = LanternVapeTextAsset or ""
    for i,d in ipairs(Items) do
        local b=MakeMenuButton(d[1],d[2],i)
        MenuButtons[d[1]]=b
        NormalMenuItems[d[1]]=b
    end
    MenuButtons.Settings.MouseButton1Click:Connect(function() Utility.Visible=false; Content.Visible=false; BuildSettingsSidebar(); SideMode="Settings"; SettingsBackState() end)
    MenuButtons.Themes.MouseButton1Click:Connect(function() Utility.Visible=false; Content.Visible=false; BuildThemeSidebar(); SideMode="Themes"; SettingsBackState() end)
    for _,n in ipairs({"Profiles","Targets","Keybinds","About"}) do
        MenuButtons[n].MouseButton1Click:Connect(function()
            Utility.Visible=true; Content.Visible=false; UtilityTitle.Text=n; UtilitySubtitle.Text="LanternVape"; ClearUtility()
            UtilityRow(n,"This section is ready for additional modules.")
        end)
    end
    MenuButtons.Profiles.MouseButton1Click:Connect(function()
        Utility.Visible=true; Content.Visible=false; UtilityTitle.Text="Profiles"; UtilitySubtitle.Text="Manage saved profiles"; ClearUtility();
        local q=ProfileSearch and ProfileSearch.Text:lower() or ""
        for _,name in ipairs(profileNames) do if q=="" or name:lower():find(q,1,true) then UtilityRow(name,"Saved profile") end end
    end)
end

local SideMode="Normal"
function SettingsBackState()
    UtilityBack.Visible=true
end
UtilityBack.MouseButton1Click:Connect(function()
    Utility.Visible=false
    Content.Visible=true
    SideMode="Normal"
    BuildNormalSidebar()
end)

-- PROFILE DATA
local profileNames={"Default"}
local ProfileSearch=Instance.new("TextBox")
ProfileSearch.Visible=false
ProfileSearch.Parent=Gui

BuildNormalSidebar()

-- SEARCH FILTER
Search:GetPropertyChangedSignal("Text"):Connect(function()
    local q=Search.Text:lower()
    for n,p in pairs(Panels) do
        p.Visible=Enabled[n] and (q=="" or n:lower():find(q,1,true)~=nil)
    end
end)

-- MOBILE TOGGLE
local Mobile = Instance.new("ImageButton")
Mobile.Name="MobileToggle"
Mobile.Size=UDim2.fromOffset(40,40)
Mobile.AnchorPoint=Vector2.new(1,0)
Mobile.Position=UDim2.new(1,-8,0,8)
Mobile.BackgroundColor3=Config.Black
Mobile.BackgroundTransparency=.08
Mobile.BorderSizePixel=0
Mobile.Visible=false
Mobile.ZIndex=200
Mobile.Parent=Gui
Corner(Mobile,10)
Stroke(Mobile,Config.Orange,.15,2)
Mobile.Image=MobileIconAsset or Config.Icon
Mobile.ImageColor3=Color3.new(1,1,1)
Mobile.ScaleType=Enum.ScaleType.Fit

local function toggleMain()
    Main.Visible=not Main.Visible
    if Main.Visible then
        if SettingsState.BlurBackground and not SettingsState.HideGUI then SetBackgroundBlur(true) end
    else
        SetBackgroundBlur(false)
    end
end
Mobile.MouseButton1Click:Connect(toggleMain)

UIS.InputBegan:Connect(function(i,p)
    if not p and (i.KeyCode==Enum.KeyCode.LeftShift or i.KeyCode==Enum.KeyCode.RightShift) then toggleMain() end
end)

-- RESPONSIVE
local Camera=workspace.CurrentCamera
local function Layout()
    Camera=workspace.CurrentCamera or Camera
    if not Camera then return end
    local w=Camera.ViewportSize.X
    if UIS.TouchEnabled and SettingsState.CompactMobile then
        Scale.Scale=(w<500 and .52) or (w<650 and .60) or (w<800 and .70) or .82
    else
        Scale.Scale=(w<800 and .70) or (w<1000 and .82) or .92
    end
    local tl,br=GuiService:GetGuiInset()
    Main.Position=UDim2.fromOffset(15,15+tl.Y)
    Main.Size=UDim2.new(1,-30,1,-30-tl.Y-br.Y)
    SideMenu.Size=UDim2.fromOffset(235,math.max(150,Main.AbsoluteSize.Y-66))
    if UIS.TouchEnabled then Mobile.Position=UDim2.new(1,-8,0,8+tl.Y) end
    LayoutCategories()
end
Layout()
if Camera then Camera:GetPropertyChangedSignal("ViewportSize"):Connect(Layout) end

-- LOADING FINISH
local Finished=false
local function FinishLoading()
    if Finished then return end
    Finished=true
    Main.Visible=not SettingsState.HideGUI
    Mobile.Visible=UIS.TouchEnabled
    if Main.Visible and SettingsState.BlurBackground then SetBackgroundBlur(true) end
    Tween(Loading,.35,{BackgroundTransparency=1})
    Tween(Tint,.35,{BackgroundTransparency=1})
    Tween(LoadingTitle,.35,{TextTransparency=1})
    Tween(BarBG,.35,{BackgroundTransparency=1})
    Tween(Bar,.35,{BackgroundTransparency=1})
    task.delay(.4,function() if Loading and Loading.Parent then Loading:Destroy() end end)
end

Tween(Bar,Config.LoadingTime,{Size=UDim2.new(1,0,1,0)})
task.delay(Config.LoadingTime,FinishLoading)
task.delay(5,FinishLoading)

print("["..Config.Name.."] Loaded "..Config.Version)\n\n-- LanternVape asset-backed UI update v2.12\n