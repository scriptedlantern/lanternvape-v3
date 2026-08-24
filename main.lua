local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local P=Players.LocalPlayer
if not P then return end
local PG=P:WaitForChild("PlayerGui",10)
if not PG then return end

local C={Name="LanternVape",Version="2.02",LoadingTime=2.2,Orange=Color3.fromRGB(220,115,35),OrangeDark=Color3.fromRGB(145,68,20),Black=Color3.fromRGB(8,8,8),Dark=Color3.fromRGB(14,14,14),Darker=Color3.fromRGB(21,21,21),White=Color3.fromRGB(235,235,235),Gray=Color3.fromRGB(145,145,145)}
local Icons={Lantern="rbxassetid://0",Close="rbxassetid://0",Menu="rbxassetid://0",Search="rbxassetid://0",Settings="rbxassetid://0",Profiles="rbxassetid://0",Targets="rbxassetid://0",Themes="rbxassetid://0",Keybinds="rbxassetid://0",About="rbxassetid://0"}

local old=PG:FindFirstChild("LanternVape")
if old then old:Destroy() end

local G=Instance.new("ScreenGui")
G.Name="LanternVape";G.ResetOnSpawn=false;G.IgnoreGuiInset=true;G.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;G.Parent=PG

local function tw(o,t,p)
 local ok,x=pcall(function()return TS:Create(o,TweenInfo.new(t,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),p)end)
 if ok and x then x:Play() end
end
local function cr(o,r)local x=Instance.new("UICorner");x.CornerRadius=UDim.new(0,r);x.Parent=o;return x end
local function st(o,c,t,n)local x=Instance.new("UIStroke");x.Color=c;x.Transparency=t or 0;x.Thickness=n or 1;x.Parent=o;return x end
local function iconButton(parent,name,size,pos,image,text,z)
 local b=Instance.new("ImageButton")
 b.Name=name;b.Size=size;b.Position=pos;b.BackgroundColor3=C.Black;b.BackgroundTransparency=.05;b.BorderSizePixel=0;b.AutoButtonColor=false;b.Image=image;b.ScaleType=Enum.ScaleType.Fit;b.ZIndex=z or 10;b.Parent=parent;cr(b,6)
 if image=="rbxassetid://0" then local l=Instance.new("TextLabel");l.Size=UDim2.fromScale(1,1);l.BackgroundTransparency=1;l.Text=text;l.TextColor3=C.White;l.TextSize=20;l.Font=Enum.Font.GothamBold;l.ZIndex=(z or 10)+1;l.Parent=b end
 return b
end

-- The loading layer is independent. It starts its own cleanup task immediately,
-- so a later UI error can never leave the user trapped on the loading screen.
local L=Instance.new("Frame")
L.Name="Loading";L.Size=UDim2.fromScale(1,1);L.Position=UDim2.fromScale(0,0);L.BackgroundColor3=C.Black;L.BackgroundTransparency=.08;L.BorderSizePixel=0;L.ZIndex=1000;L.Parent=G
local LT=Instance.new("Frame");LT.Size=UDim2.fromScale(1,1);LT.BackgroundColor3=C.Orange;LT.BackgroundTransparency=.96;LT.BorderSizePixel=0;LT.ZIndex=1001;LT.Parent=L
local title=Instance.new("TextLabel");title.Size=UDim2.new(1,0,0,50);title.Position=UDim2.new(0,0,.5,-35);title.BackgroundTransparency=1;title.Text="LOADING LANTERNVAPE..";title.TextColor3=C.Orange;title.TextSize=25;title.Font=Enum.Font.GothamBold;title.ZIndex=1002;title.Parent=L
local lb=Instance.new("Frame");lb.Size=UDim2.fromOffset(240,4);lb.AnchorPoint=Vector2.new(.5,0);lb.Position=UDim2.new(.5,0,.5,25);lb.BackgroundColor3=C.Darker;lb.BorderSizePixel=0;lb.ZIndex=1002;lb.Parent=L;cr(lb,10)
local bar=Instance.new("Frame");bar.Size=UDim2.new(0,0,1,0);bar.BackgroundColor3=C.Orange;bar.BorderSizePixel=0;bar.ZIndex=1003;bar.Parent=lb;cr(bar,10)

-- Main exists and is visible immediately. Loading is simply an overlay.
local Safe=Instance.new("Frame");Safe.Size=UDim2.new(1,0,1,-24);Safe.Position=UDim2.fromOffset(0,24);Safe.BackgroundTransparency=1;Safe.Parent=G
local Main=Instance.new("Frame");Main.Size=UDim2.new(1,-30,1,-30);Main.Position=UDim2.fromOffset(15,15);Main.BackgroundTransparency=1;Main.Visible=true;Main.Parent=Safe
local scale=Instance.new("UIScale");scale.Scale=1;scale.Parent=Main

local brand=Instance.new("TextLabel");brand.Size=UDim2.fromOffset(190,42);brand.Position=UDim2.fromOffset(4,4);brand.BackgroundColor3=C.Black;brand.BackgroundTransparency=.05;brand.BorderSizePixel=0;brand.Text=C.Name;brand.TextColor3=C.White;brand.TextSize=18;brand.Font=Enum.Font.GothamBold;brand.TextXAlignment=Enum.TextXAlignment.Left;brand.Parent=Main;cr(brand,5)
local bp=Instance.new("UIPadding");bp.PaddingLeft=UDim.new(0,14);bp.Parent=brand
local ba=Instance.new("Frame");ba.Size=UDim2.new(1,0,0,2);ba.Position=UDim2.new(0,0,1,-2);ba.BackgroundColor3=C.Orange;ba.BorderSizePixel=0;ba.Parent=brand

local menu=iconButton(Main,"Menu",UDim2.fromOffset(42,42),UDim2.fromOffset(202,4),Icons.Menu,"☰",10)
local close=iconButton(Main,"Close",UDim2.fromOffset(42,42),UDim2.new(1,-46,0,4),Icons.Close,"×",10)
local ver=Instance.new("TextLabel");ver.Size=UDim2.fromOffset(60,22);ver.AnchorPoint=Vector2.new(1,0);ver.Position=UDim2.new(1,-54,0,14);ver.BackgroundTransparency=1;ver.Text="v"..C.Version;ver.TextColor3=C.Gray;ver.TextSize=11;ver.Font=Enum.Font.Gotham;ver.TextXAlignment=Enum.TextXAlignment.Right;ver.Parent=Main

local searchFrame=Instance.new("Frame");searchFrame.Size=UDim2.fromOffset(230,34);searchFrame.AnchorPoint=Vector2.new(.5,0);searchFrame.Position=UDim2.new(.5,0,0,8);searchFrame.BackgroundColor3=C.Black;searchFrame.BackgroundTransparency=.05;searchFrame.BorderSizePixel=0;searchFrame.Parent=Main;cr(searchFrame,6);st(searchFrame,C.Orange,.8,1)
local searchIcon=iconButton(searchFrame,"SearchIcon",UDim2.fromOffset(28,28),UDim2.fromOffset(3,3),Icons.Search,"⌕",5);searchIcon.BackgroundTransparency=1
local search=Instance.new("TextBox");search.Size=UDim2.new(1,-36,1,0);search.Position=UDim2.fromOffset(34,0);search.BackgroundTransparency=1;search.BorderSizePixel=0;search.PlaceholderText="Search..";search.PlaceholderColor3=Color3.fromRGB(130,130,130);search.Text="";search.TextColor3=C.White;search.TextSize=13;search.Font=Enum.Font.Gotham;search.ClearTextOnFocus=false;search.TextXAlignment=Enum.TextXAlignment.Left;search.Parent=searchFrame

local content=Instance.new("ScrollingFrame");content.Size=UDim2.new(1,-8,1,-62);content.Position=UDim2.fromOffset(4,58);content.BackgroundTransparency=1;content.BorderSizePixel=0;content.ScrollBarThickness=3;content.ScrollBarImageColor3=C.Orange;content.AutomaticCanvasSize=Enum.AutomaticSize.Y;content.ScrollingDirection=Enum.ScrollingDirection.Y;content.Parent=Main
local grid=Instance.new("UIGridLayout");grid.CellPadding=UDim2.fromOffset(7,7);grid.CellSize=UDim2.new(.2,-7,0,115);grid.FillDirection=Enum.FillDirection.Horizontal;grid.FillDirectionMaxCells=5;grid.SortOrder=Enum.SortOrder.LayoutOrder;grid.Parent=content
local cats={"Combat","Blatant","External","Rendering","Extra"};local panels={}
for i,n in ipairs(cats) do
 local p=Instance.new("Frame");p.Name=n;p.LayoutOrder=i;p.BackgroundColor3=C.Black;p.BackgroundTransparency=.12;p.BorderSizePixel=0;p.Parent=content;cr(p,5);st(p,C.Orange,.88,1)
 local h=Instance.new("TextLabel");h.Size=UDim2.new(1,0,0,42);h.BackgroundColor3=C.Black;h.BackgroundTransparency=.02;h.BorderSizePixel=0;h.Text=n;h.TextColor3=C.White;h.TextSize=16;h.Font=Enum.Font.GothamBold;h.TextXAlignment=Enum.TextXAlignment.Left;h.Parent=p;cr(h,5)
 local pad=Instance.new("UIPadding");pad.PaddingLeft=UDim.new(0,14);pad.Parent=h
 local a=Instance.new("Frame");a.Size=UDim2.new(1,0,0,2);a.Position=UDim2.new(0,0,1,-2);a.BackgroundColor3=C.Orange;a.BorderSizePixel=0;a.Parent=h
 local m=Instance.new("Frame");m.Name="Modules";m.Size=UDim2.new(1,0,1,-42);m.Position=UDim2.fromOffset(0,42);m.BackgroundTransparency=1;m.Parent=p
 panels[n]=p
end

local side=Instance.new("Frame");side.Size=UDim2.fromOffset(235,385);side.Position=UDim2.fromOffset(8,58);side.BackgroundColor3=C.Black;side.BackgroundTransparency=.01;side.BorderSizePixel=0;side.Visible=false;side.ZIndex=50;side.Parent=Main;cr(side,10);st(side,C.Orange,.55,1)
local sh=Instance.new("TextLabel");sh.Size=UDim2.new(1,0,0,54);sh.BackgroundColor3=C.Darker;sh.BorderSizePixel=0;sh.Text="  LANTERNVAPE  •  MENU";sh.TextColor3=C.White;sh.TextSize=14;sh.Font=Enum.Font.GothamBold;sh.TextXAlignment=Enum.TextXAlignment.Left;sh.ZIndex=51;sh.Parent=side;cr(sh,10)
local sub=Instance.new("TextLabel");sub.Size=UDim2.new(1,-24,0,24);sub.Position=UDim2.fromOffset(12,58);sub.BackgroundTransparency=1;sub.Text="Customize your interface";sub.TextColor3=C.Gray;sub.TextSize=11;sub.Font=Enum.Font.Gotham;sub.TextXAlignment=Enum.TextXAlignment.Left;sub.ZIndex=51;sub.Parent=side
local list=Instance.new("UIListLayout");list.Padding=UDim.new(0,6);list.SortOrder=Enum.SortOrder.LayoutOrder;list.Parent=side
local sp=Instance.new("UIPadding");sp.PaddingTop=UDim.new(0,88);sp.PaddingLeft=UDim.new(0,10);sp.PaddingRight=UDim.new(0,10);sp.Parent=side
local items={{"Settings","Settings","⚙"},{"Profiles","Profiles","♙"},{"Targets","Targets","◎"},{"Themes","Themes","◆"},{"Keybinds","Keybinds","⌨"},{"About","About","?"}};local menuButtons={}
for i,d in ipairs(items) do
 local b=iconButton(side,d[1],UDim2.new(1,0,0,42),UDim2.new(),Icons[d[1]],d[3],51);b.LayoutOrder=i
 local t=Instance.new("TextLabel");t.Size=UDim2.new(1,-58,1,0);t.Position=UDim2.fromOffset(50,0);t.BackgroundTransparency=1;t.Text=d[2];t.TextColor3=C.White;t.TextSize=13;t.Font=Enum.Font.GothamSemibold;t.TextXAlignment=Enum.TextXAlignment.Left;t.ZIndex=52;t.Parent=b
 b.MouseEnter:Connect(function()tw(b,.12,{BackgroundColor3=C.OrangeDark})end);b.MouseLeave:Connect(function()tw(b,.12,{BackgroundColor3=C.Darker})end);menuButtons[d[1]]=b
end

local toggle=iconButton(G,"MobileToggle",UDim2.fromOffset(58,58),UDim2.new(1,-76,0,38),Icons.Lantern,"LV",200);st(toggle,C.Orange,.15,2);toggle.Visible=false
local function Toggle()Main.Visible=not Main.Visible;if not Main.Visible then side.Visible=false end end
menu.MouseButton1Click:Connect(function()side.Visible=not side.Visible end)
close.MouseButton1Click:Connect(function()Main.Visible=false;side.Visible=false end)
toggle.MouseButton1Click:Connect(Toggle)
UIS.InputBegan:Connect(function(i,p)if not p and(i.KeyCode==Enum.KeyCode.LeftShift or i.KeyCode==Enum.KeyCode.RightShift)then Toggle()end end)
search:GetPropertyChangedSignal("Text"):Connect(function()local q=search.Text:lower();for n,p in pairs(panels)do p.Visible=q=="" or n:lower():find(q,1,true)~=nil end end)

local settings=Instance.new("Frame");settings.Size=UDim2.fromOffset(420,390);settings.AnchorPoint=Vector2.new(.5,.5);settings.Position=UDim2.fromScale(.5,.5);settings.BackgroundColor3=C.Black;settings.BorderSizePixel=0;settings.Visible=false;settings.ZIndex=100;settings.Parent=Main;cr(settings,10);st(settings,C.Orange,.55,1)
local settingsTitle=Instance.new("TextLabel");settingsTitle.Size=UDim2.new(1,-60,0,50);settingsTitle.Position=UDim2.fromOffset(14,8);settingsTitle.BackgroundTransparency=1;settingsTitle.Text="SETTINGS";settingsTitle.TextColor3=C.White;settingsTitle.TextSize=18;settingsTitle.Font=Enum.Font.GothamBold;settingsTitle.TextXAlignment=Enum.TextXAlignment.Left;settingsTitle.ZIndex=101;settingsTitle.Parent=settings
local settingsClose=iconButton(settings,"CloseSettings",UDim2.fromOffset(36,36),UDim2.new(1,-48,0,12),Icons.Close,"×",102)
local function makeToggle(parent,text,y,initial,callback)
 local b=Instance.new("TextButton");b.Size=UDim2.new(1,-32,0,42);b.Position=UDim2.fromOffset(16,y);b.BackgroundColor3=C.Darker;b.BorderSizePixel=0;b.AutoButtonColor=false;b.Text="";b.ZIndex=101;b.Parent=parent;cr(b,7)
 local l=Instance.new("TextLabel");l.Size=UDim2.new(1,-70,1,0);l.Position=UDim2.fromOffset(14,0);l.BackgroundTransparency=1;l.Text=text;l.TextColor3=C.White;l.TextSize=13;l.Font=Enum.Font.GothamSemibold;l.TextXAlignment=Enum.TextXAlignment.Left;l.ZIndex=102;l.Parent=b
 local dot=Instance.new("Frame");dot.Size=UDim2.fromOffset(24,24);dot.Position=UDim2.new(1,-38,.5,-12);dot.BackgroundColor3=initial and C.Orange or C.Gray;dot.BorderSizePixel=0;dot.ZIndex=102;dot.Parent=b;cr(dot,12)
 local state=initial;b.MouseButton1Click:Connect(function()state=not state;dot.BackgroundColor3=state and C.Orange or C.Gray;callback(state)end);return b
end
local sy=70
for _,n in ipairs(cats) do makeToggle(settings,"Show "..n,sy,true,function(v)panels[n].Visible=v end);sy=sy+46 end
makeToggle(settings,"Show LanternVape button",sy,true,function(v)toggle.Visible=v and UIS.TouchEnabled end)
menuButtons.Settings.MouseButton1Click:Connect(function()side.Visible=false;settings.Visible=true end)
settingsClose.MouseButton1Click:Connect(function()settings.Visible=false end)

local themes=Instance.new("Frame");themes.Size=UDim2.fromOffset(420,300);themes.AnchorPoint=Vector2.new(.5,.5);themes.Position=UDim2.fromScale(.5,.5);themes.BackgroundColor3=C.Black;themes.BorderSizePixel=0;themes.Visible=false;themes.ZIndex=100;themes.Parent=Main;cr(themes,10);st(themes,C.Orange,.55,1)
local themeTitle=Instance.new("TextLabel");themeTitle.Size=UDim2.new(1,-60,0,50);themeTitle.Position=UDim2.fromOffset(14,8);themeTitle.BackgroundTransparency=1;themeTitle.Text="THEMES";themeTitle.TextColor3=C.White;themeTitle.TextSize=18;themeTitle.Font=Enum.Font.GothamBold;themeTitle.TextXAlignment=Enum.TextXAlignment.Left;themeTitle.ZIndex=101;themeTitle.Parent=themes
local themeClose=iconButton(themes,"CloseThemes",UDim2.fromOffset(36,36),UDim2.new(1,-48,0,12),Icons.Close,"×",102)
local accentObjects={ba}
for _,p in pairs(panels) do for _,o in ipairs(p:GetChildren()) do if o:IsA("Frame") and o.Size.Y.Offset==2 then table.insert(accentObjects,o) end end end
local themeColors={{"Orange",Color3.fromRGB(220,115,35)},{"Red",Color3.fromRGB(220,55,55)},{"Purple",Color3.fromRGB(150,85,220)},{"Blue",Color3.fromRGB(70,140,235)},{"Green",Color3.fromRGB(70,190,105)},{"Pink",Color3.fromRGB(225,90,165)},{"White",Color3.fromRGB(225,225,225)}}
local function setAccent(color)
 C.Orange=color
 for _,o in ipairs(accentObjects) do if o and o.Parent then o.BackgroundColor3=color end end
 for _,o in ipairs({menu,close,toggle,searchFrame,side,settings,themes}) do if o and o.Parent then local s=o:FindFirstChildOfClass("UIStroke");if s then s.Color=color end end end
 title.TextColor3=color;bar.BackgroundColor3=color;brand.TextColor3=C.White
end
for i,data in ipairs(themeColors) do local b=Instance.new("TextButton");b.Size=UDim2.fromOffset(112,42);b.Position=UDim2.fromOffset(18+((i-1)%3)*128,70+math.floor((i-1)/3)*52);b.BackgroundColor3=C.Darker;b.BorderSizePixel=0;b.Text=data[1];b.TextColor3=C.White;b.TextSize=12;b.Font=Enum.Font.GothamSemibold;b.AutoButtonColor=false;b.ZIndex=101;b.Parent=themes;cr(b,7);local dot=Instance.new("Frame");dot.Size=UDim2.fromOffset(18,18);dot.Position=UDim2.new(1,-28,.5,-9);dot.BackgroundColor3=data[2];dot.BorderSizePixel=0;dot.ZIndex=102;dot.Parent=b;cr(dot,9);b.MouseButton1Click:Connect(function()setAccent(data[2])end)end
menuButtons.Themes.MouseButton1Click:Connect(function()side.Visible=false;themes.Visible=true end)
themeClose.MouseButton1Click:Connect(function()themes.Visible=false end)
for _,name in ipairs({"Profiles","Targets","Keybinds","About"}) do menuButtons[name].MouseButton1Click:Connect(function()side.Visible=false end) end

local dragging=false;local ds;local ss
brand.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true;ds=i.Position;ss=Main.Position end end)
UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
UIS.InputChanged:Connect(function(i)if dragging and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then local d=i.Position-ds;Main.Position=UDim2.new(ss.X.Scale,ss.X.Offset+d.X,ss.Y.Scale,ss.Y.Offset+d.Y)end end)

local cam=workspace.CurrentCamera
local function layout()
 cam=workspace.CurrentCamera or cam
 if not cam then return end
 grid.FillDirectionMaxCells=5;grid.CellSize=UDim2.new(.2,-7,0,115)
 local w=cam.ViewportSize.X
 if w<500 then scale.Scale=.52 elseif w<650 then scale.Scale=.62 elseif w<800 then scale.Scale=.72 elseif w<1000 then scale.Scale=.84 else scale.Scale=1 end
end
layout()
if cam then cam:GetPropertyChangedSignal("ViewportSize"):Connect(layout) end

-- Start loading animation without blocking the script.
task.spawn(function()
 tw(bar,C.LoadingTime,{Size=UDim2.new(1,0,1,0)})
 task.wait(C.LoadingTime)
 if not G.Parent then return end
 tw(L,.3,{BackgroundTransparency=1});tw(LT,.3,{BackgroundTransparency=1});tw(title,.3,{TextTransparency=1});tw(lb,.3,{BackgroundTransparency=1});tw(bar,.3,{BackgroundTransparency=1})
 task.wait(.35)
 if L and L.Parent then L:Destroy() end
end)

-- Independent hard fallback: even if animation/tween behavior fails,
-- the overlay is removed after 5 seconds.
task.delay(5,function()
 if L and L.Parent then L:Destroy() end
end)

if UIS.TouchEnabled then toggle.Visible=true end
print("["..C.Name.."] Loaded "..C.Version)