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
    Version = "2.02",
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
    Orange = Color3.fromRGB(220,115,35),
    OrangeDark = Color3.fromRGB(145,68,20),
    Black = Color3.fromRGB(8,8,8),
    Dark = Color3.fromRGB(14,14,14),
    Darker = Color3.fromRGB(21,21,21),
    White = Color3.fromRGB(235,235,235),
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
    local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r); c.Parent=o; return c
end
local function Stroke(o,color,t,thick)
    local s=Instance.new("UIStroke"); s.Color=color; s.Transparency=t or 0; s.Thickness=thick or 1; s.Parent=o; return s
end
local function Tween(o,time,p)
    local ok,t=pcall(function() return TweenService:Create(o,TweenInfo.new(time,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),p) end)
    if ok then t:Play() end
end
local function IconValid(v) return typeof(v)=="string" and v~="" and v~="rbxassetid://0" end

-- LOADING
local Loading=Instance.new("Frame")
Loading.Size=UDim2.fromScale(1,1); Loading.BackgroundColor3=Config.Black; Loading.BackgroundTransparency=.08; Loading.BorderSizePixel=0; Loading.ZIndex=1000; Loading.Parent=Gui
local Tint=Instance.new("Frame")
Tint.Size=UDim2.fromScale(1,1); Tint.BackgroundColor3=Config.Orange; Tint.BackgroundTransparency=.96; Tint.BorderSizePixel=0; Tint.ZIndex=1001; Tint.Parent=Loading
local LoadingTitle=Instance.new("TextLabel")
LoadingTitle.Size=UDim2.new(1,0,0,50); LoadingTitle.Position=UDim2.new(0,0,.5,-35); LoadingTitle.BackgroundTransparency=1; LoadingTitle.Text="LOADING LANTERNVAPE.."; LoadingTitle.TextColor3=Config.Orange; LoadingTitle.TextSize=25; LoadingTitle.Font=Enum.Font.GothamBold; LoadingTitle.ZIndex=1002; LoadingTitle.Parent=Loading
local BarBG=Instance.new("Frame")
BarBG.Size=UDim2.fromOffset(240,4); BarBG.AnchorPoint=Vector2.new(.5,0); BarBG.Position=UDim2.new(.5,0,.5,25); BarBG.BackgroundColor3=Config.Darker; BarBG.BorderSizePixel=0; BarBG.ZIndex=1002; BarBG.Parent=Loading; Corner(BarBG,10)
local Bar=Instance.new("Frame")
Bar.Size=UDim2.new(0,0,1,0); Bar.BackgroundColor3=Config.Orange; Bar.BorderSizePixel=0; Bar.ZIndex=1003; Bar.Parent=BarBG; Corner(Bar,10)

-- MAIN
local Main=Instance.new("Frame")
Main.Name="Main"; Main.Size=UDim2.new(1,-30,1,-30); Main.Position=UDim2.fromOffset(15,15); Main.BackgroundTransparency=1; Main.Visible=false; Main.Parent=Gui
local Scale=Instance.new("UIScale"); Scale.Parent=Main

local Brand=Instance.new("TextLabel")
Brand.Size=UDim2.fromOffset(190,42); Brand.Position=UDim2.fromOffset(4,4); Brand.BackgroundColor3=Config.Black; Brand.BackgroundTransparency=.05; Brand.BorderSizePixel=0; Brand.Text=Config.Name; Brand.TextColor3=Config.White; Brand.TextSize=18; Brand.Font=Enum.Font.GothamBold; Brand.TextXAlignment=Enum.TextXAlignment.Left; Brand.Parent=Main; Corner(Brand,5)
local BP=Instance.new("UIPadding"); BP.PaddingLeft=UDim.new(0,14); BP.Parent=Brand
local BA=Instance.new("Frame"); BA.Size=UDim2.new(1,0,0,2); BA.Position=UDim2.new(0,0,1,-2); BA.BackgroundColor3=Config.Orange; BA.BorderSizePixel=0; BA.Parent=Brand

local MenuButton=Instance.new("ImageButton")
MenuButton.Size=UDim2.fromOffset(42,42); MenuButton.Position=UDim2.fromOffset(202,4); MenuButton.BackgroundColor3=Config.Black; MenuButton.BackgroundTransparency=.05; MenuButton.BorderSizePixel=0; MenuButton.AutoButtonColor=false; MenuButton.Parent=Main; Corner(MenuButton,5)
local MF=Instance.new("TextLabel"); MF.Size=UDim2.fromScale(1,1); MF.BackgroundTransparency=1; MF.Text="☰"; MF.TextColor3=Config.White; MF.TextSize=19; MF.Font=Enum.Font.GothamBold; MF.Parent=MenuButton
if IconValid(Config.MenuIcon) then MenuButton.Image=Config.MenuIcon; MF.Visible=false end

local Search=Instance.new("TextBox")
Search.Size=UDim2.fromOffset(230,34); Search.AnchorPoint=Vector2.new(.5,0); Search.Position=UDim2.new(.5,0,0,8); Search.BackgroundColor3=Config.Black; Search.BackgroundTransparency=.05; Search.BorderSizePixel=0; Search.PlaceholderText="Search.."; Search.PlaceholderColor3=Color3.fromRGB(110,110,110); Search.TextColor3=Config.White; Search.TextSize=13; Search.Font=Enum.Font.Gotham; Search.ClearTextOnFocus=false; Search.Parent=Main; Corner(Search,5); Stroke(Search,Config.Orange,.8,1)
local SP=Instance.new("UIPadding"); SP.PaddingLeft=UDim.new(0,38); SP.Parent=Search
local SF=Instance.new("TextLabel"); SF.Size=UDim2.fromOffset(20,20); SF.Position=UDim2.fromOffset(9,7); SF.BackgroundTransparency=1; SF.Text="⌕"; SF.TextColor3=Config.Gray; SF.TextSize=18; SF.Font=Enum.Font.Gotham; SF.Parent=Search

local Close=Instance.new("ImageButton")
Close.Size=UDim2.fromOffset(42,42); Close.Position=UDim2.new(1,-46,0,4); Close.BackgroundColor3=Config.Black; Close.BackgroundTransparency=.05; Close.BorderSizePixel=0; Close.AutoButtonColor=false; Close.Parent=Main; Corner(Close,5)
local CF=Instance.new("TextLabel"); CF.Size=UDim2.fromScale(1,1); CF.BackgroundTransparency=1; CF.Text="×"; CF.TextColor3=Config.White; CF.TextSize=25; CF.Font=Enum.Font.Gotham; CF.Parent=Close

-- VERSION + MESSAGE, MOVED TO BOTTOM
local Footer=Instance.new("Frame")
Footer.Name="Footer"; Footer.Size=UDim2.new(1,-8,0,28); Footer.Position=UDim2.new(0,4,1,-30); Footer.BackgroundTransparency=1; Footer.Parent=Main
local Version=Instance.new("TextLabel")
Version.Size=UDim2.fromOffset(65,24); Version.Position=UDim2.fromOffset(0,2); Version.BackgroundTransparency=1; Version.Text="v"..Config.Version; Version.TextColor3=Color3.new(1,1,1); Version.TextSize=12; Version.Font=Enum.Font.GothamBold; Version.TextXAlignment=Enum.TextXAlignment.Left; Version.Parent=Footer
Stroke(Version,Color3.new(0,0,0),0,1.5)
local Thanks=Instance.new("TextLabel")
Thanks.Size=UDim2.new(1,-75,0,24); Thanks.Position=UDim2.fromOffset(68,2); Thanks.BackgroundTransparency=1; Thanks.Text="Thank you for choosing LanternVape! Join the discord: https://discord.gg/Pa7aGyKjPR"; Thanks.TextColor3=Config.White; Thanks.TextSize=11; Thanks.Font=Enum.Font.Gotham; Thanks.TextXAlignment=Enum.TextXAlignment.Left; Thanks.TextTruncate=Enum.TextTruncate.AtEnd; Thanks.Parent=Footer
Stroke(Thanks,Color3.new(0,0,0),0,1.2)

-- CATEGORIES
local Content=Instance.new("ScrollingFrame")
Content.Name="Categories"; Content.Size=UDim2.new(1,-8,1,-94); Content.Position=UDim2.fromOffset(4,58); Content.BackgroundTransparency=1; Content.BorderSizePixel=0; Content.ScrollBarThickness=3; Content.ScrollBarImageColor3=Config.Orange; Content.CanvasSize=UDim2.new(); Content.Parent=Main
local Grid=Instance.new("UIGridLayout")
Grid.CellPadding=UDim2.fromOffset(7,7); Grid.CellSize=UDim2.new(.2,-7,0,115); Grid.FillDirection=Enum.FillDirection.Horizontal; Grid.FillDirectionMaxCells=5; Grid.SortOrder=Enum.SortOrder.LayoutOrder; Grid.Parent=Content
local Categories={"Combat","Blatant","External","Rendering","Extra"}
local Panels={}
local Enabled={Combat=true,Blatant=true,External=true,Rendering=true,Extra=true}
for i,name in ipairs(Categories) do
    local p=Instance.new("Frame"); p.Name=name; p.LayoutOrder=i; p.BackgroundColor3=Config.Black; p.BackgroundTransparency=.12; p.BorderSizePixel=0; p.Parent=Content; Corner(p,5); Stroke(p,Config.Orange,.88,1); Panels[name]=p
    local h=Instance.new("TextLabel"); h.Size=UDim2.new(1,0,0,42); h.BackgroundColor3=Config.Black; h.BackgroundTransparency=.02; h.BorderSizePixel=0; h.Text=name; h.TextColor3=Config.White; h.TextSize=16; h.Font=Enum.Font.GothamBold; h.TextXAlignment=Enum.TextXAlignment.Left; h.Parent=p; Corner(h,5)
    local pad=Instance.new("UIPadding"); pad.PaddingLeft=UDim.new(0,14); pad.Parent=h
    local a=Instance.new("Frame"); a.Size=UDim2.new(1,0,0,2); a.Position=UDim2.new(0,0,1,-2); a.BackgroundColor3=Config.Orange; a.BorderSizePixel=0; a.Parent=h
    local modules=Instance.new("Frame"); modules.Name="Modules"; modules.Size=UDim2.new(1,0,1,-42); modules.Position=UDim2.fromOffset(0,42); modules.BackgroundTransparency=1; modules.Parent=p
end

-- SIDE PANEL IS NOW ALWAYS VISIBLE
local SideMenu=Instance.new("Frame")
SideMenu.Name="SideMenu"; SideMenu.Size=UDim2.fromOffset(245,390); SideMenu.Position=UDim2.fromOffset(10,58); SideMenu.BackgroundColor3=Config.Black; SideMenu.BackgroundTransparency=.02; SideMenu.BorderSizePixel=0; SideMenu.Visible=true; SideMenu.ZIndex=50; SideMenu.Parent=Main; Corner(SideMenu,7); Stroke(SideMenu,Config.Orange,.55,1)
local SH=Instance.new("Frame"); SH.Size=UDim2.new(1,0,0,58); SH.BackgroundColor3=Config.Darker; SH.BorderSizePixel=0; SH.ZIndex=51; SH.Parent=SideMenu; Corner(SH,7)
local ST=Instance.new("TextLabel"); ST.Size=UDim2.new(1,-20,0,26); ST.Position=UDim2.fromOffset(14,8); ST.BackgroundTransparency=1; ST.Text="LanternVape"; ST.TextColor3=Config.White; ST.TextSize=17; ST.Font=Enum.Font.GothamBold; ST.TextXAlignment=Enum.TextXAlignment.Left; ST.ZIndex=52; ST.Parent=SH
local SS=Instance.new("TextLabel"); SS.Size=UDim2.new(1,-20,0,18); SS.Position=UDim2.fromOffset(14,33); SS.BackgroundTransparency=1; SS.Text="Control Panel"; SS.TextColor3=Config.Gray; SS.TextSize=11; SS.Font=Enum.Font.Gotham; SS.TextXAlignment=Enum.TextXAlignment.Left; SS.ZIndex=52; SS.Parent=SH
local SA=Instance.new("Frame"); SA.Size=UDim2.new(1,-20,0,2); SA.Position=UDim2.new(0,10,1,-2); SA.BackgroundColor3=Config.Orange; SA.BorderSizePixel=0; SA.ZIndex=53; SA.Parent=SH
local list=Instance.new("UIListLayout"); list.Padding=UDim.new(0,5); list.SortOrder=Enum.SortOrder.LayoutOrder; list.Parent=SideMenu
local mp=Instance.new("UIPadding"); mp.PaddingTop=UDim.new(0,67); mp.PaddingLeft=UDim.new(0,7); mp.PaddingRight=UDim.new(0,7); mp.Parent=SideMenu
local items={{"⚙","Settings"},{"♙","Profiles"},{"◎","Targets"},{"◆","Themes"},{"⌨","Keybinds"},{"?","About"}}
for i,data in ipairs(items) do
    local b=Instance.new("TextButton"); b.Name=data[2]; b.Size=UDim2.new(1,0,0,42); b.BackgroundColor3=Config.Darker; b.BorderSizePixel=0; b.Text=""; b.AutoButtonColor=false; b.LayoutOrder=i; b.ZIndex=51; b.Parent=SideMenu; Corner(b,5)
    local ic=Instance.new("TextLabel"); ic.Size=UDim2.fromOffset(25,25); ic.Position=UDim2.fromOffset(9,8); ic.BackgroundTransparency=1; ic.Text=data[1]; ic.TextColor3=Config.Orange; ic.TextSize=16; ic.Font=Enum.Font.GothamBold; ic.ZIndex=52; ic.Parent=b
    local tx=Instance.new("TextLabel"); tx.Size=UDim2.new(1,-55,1,0); tx.Position=UDim2.fromOffset(45,0); tx.BackgroundTransparency=1; tx.Text=data[2]; tx.TextColor3=Config.White; tx.TextSize=13; tx.Font=Enum.Font.GothamSemibold; tx.TextXAlignment=Enum.TextXAlignment.Left; tx.ZIndex=52; tx.Parent=b
    b.MouseEnter:Connect(function() Tween(b,.12,{BackgroundColor3=Config.OrangeDark}) end)
    b.MouseLeave:Connect(function() Tween(b,.12,{BackgroundColor3=Config.Darker}) end)
end

-- MOBILE BUTTON
local Mobile=Instance.new("ImageButton")
Mobile.Name="MobileToggle"; Mobile.Size=UDim2.fromOffset(52,52); Mobile.AnchorPoint=Vector2.new(1,0); Mobile.Position=UDim2.new(1,-16,0,16); Mobile.BackgroundColor3=Config.Black; Mobile.BackgroundTransparency=.08; Mobile.BorderSizePixel=0; Mobile.Visible=false; Mobile.ZIndex=200; Mobile.Parent=Gui; Corner(Mobile,12); Stroke(Mobile,Config.Orange,.15,2)
local ml=Instance.new("TextLabel"); ml.Size=UDim2.fromScale(1,1); ml.BackgroundTransparency=1; ml.Text="LV"; ml.TextColor3=Config.Orange; ml.TextSize=18; ml.Font=Enum.Font.GothamBold; ml.ZIndex=201; ml.Parent=Mobile

local function Toggle()
    Main.Visible=not Main.Visible
end
MenuButton.MouseButton1Click:Connect(Toggle)
Close.MouseButton1Click:Connect(function() Main.Visible=false end)
Mobile.MouseButton1Click:Connect(Toggle)
UIS.InputBegan:Connect(function(input,processed)
    if processed then return end
    if input.KeyCode==Enum.KeyCode.LeftShift or input.KeyCode==Enum.KeyCode.RightShift then Toggle() end
end)

Search:GetPropertyChangedSignal("Text"):Connect(function()
    local q=string.lower(Search.Text)
    for name,p in pairs(Panels) do
        p.Visible=Enabled[name] and (q=="" or string.find(string.lower(name),q,1,true)~=nil)
    end
end)

local function Layout()
    local cam=workspace.CurrentCamera
    if not cam then return end
    local w=cam.ViewportSize.X
    if w<500 then Scale.Scale=.55 elseif w<650 then Scale.Scale=.65 elseif w<800 then Scale.Scale=.75 elseif w<1000 then Scale.Scale=.85 else Scale.Scale=1 end
    Mobile.Visible=UIS.TouchEnabled
    local tl,br=GuiService:GetGuiInset()
    Main.Position=UDim2.fromOffset(15,15+tl.Y)
    Main.Size=UDim2.new(1,-30,1,-30-tl.Y-br.Y)
    Mobile.Position=UDim2.new(1,-16,0,16+tl.Y)
end
Layout()
local cam=workspace.CurrentCamera
if cam then cam:GetPropertyChangedSignal("ViewportSize"):Connect(Layout) end

-- Loading can never remain stuck: the UI is revealed by a single guarded completion.
local finished=false
local function Finish()
    if finished then return end
    finished=true
    Main.Visible=true
    Mobile.Visible=UIS.TouchEnabled
    SideMenu.Visible=true
    Tween(Loading,.3,{BackgroundTransparency=1})
    Tween(Tint,.3,{BackgroundTransparency=1})
    Tween(LoadingTitle,.3,{TextTransparency=1})
    Tween(BarBG,.3,{BackgroundTransparency=1})
    Tween(Bar,.3,{BackgroundTransparency=1})
    task.delay(.35,function() if Loading and Loading.Parent then Loading:Destroy() end end)
end
Tween(Bar,Config.LoadingTime,{Size=UDim2.new(1,0,1,0)})
task.delay(Config.LoadingTime,Finish)
task.delay(4,Finish)

print("["..Config.Name.."] Loaded "..Config.Version)