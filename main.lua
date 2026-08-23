local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local P=Players.LocalPlayer
if not P then return end
local PG=P:WaitForChild("PlayerGui",10)
if not PG then return end
local C={Name="LanternVape",Version="1.0.3",LoadingTime=2.2,Orange=Color3.fromRGB(220,115,35),OrangeDark=Color3.fromRGB(145,68,20),Black=Color3.fromRGB(8,8,8),Darker=Color3.fromRGB(21,21,21),White=Color3.fromRGB(235,235,235),Gray=Color3.fromRGB(145,145,145)}
-- Replace these with Roblox asset IDs. Leave as rbxassetid://0 for text fallback.
local Icons={Lantern="rbxassetid://0",Close="rbxassetid://0",Menu="rbxassetid://0",Search="rbxassetid://0",Settings="rbxassetid://0",Profiles="rbxassetid://0",Targets="rbxassetid://0",Themes="rbxassetid://0",Keybinds="rbxassetid://0",About="rbxassetid://0"}
local old=PG:FindFirstChild("LanternVape")
if old then old:Destroy() end
local G=Instance.new("ScreenGui")
G.Name="LanternVape";G.ResetOnSpawn=false;G.IgnoreGuiInset=true;G.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;G.Parent=PG
local function tw(o,t,p) local ok,x=pcall(function() return TS:Create(o,TweenInfo.new(t,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),p) end) if ok then x:Play() end end
local function cr(o,r) local x=Instance.new("UICorner");x.CornerRadius=UDim.new(0,r);x.Parent=o end
local function st(o,c,t,n) local x=Instance.new("UIStroke");x.Color=c;x.Transparency=t or 0;x.Thickness=n or 1;x.Parent=o end
local function iconButton(parent,name,size,pos,image,text,z)
 local b=Instance.new("ImageButton");b.Name=name;b.Size=size;b.Position=pos;b.BackgroundColor3=C.Black;b.BackgroundTransparency=.05;b.BorderSizePixel=0;b.AutoButtonColor=false;b.Image=image;b.ScaleType=Enum.ScaleType.Fit;b.ZIndex=z or 10;b.Parent=parent;cr(b,5)
 if image=="rbxassetid://0" then local l=Instance.new("TextLabel");l.Size=UDim2.fromScale(1,1);l.BackgroundTransparency=1;l.Text=text;l.TextColor3=C.White;l.TextSize=20;l.Font=Enum.Font.GothamBold;l.ZIndex=(z or 10)+1;l.Parent=b end
 return b
end
-- Full display loading screen
local L=Instance.new("Frame");L.Size=UDim2.fromScale(1,1);L.BackgroundColor3=C.Black;L.BackgroundTransparency=.08;L.BorderSizePixel=0;L.ZIndex=1000;L.Parent=G
local LT=Instance.new("Frame");LT.Size=UDim2.fromScale(1,1);LT.BackgroundColor3=C.Orange;LT.BackgroundTransparency=.96;LT.BorderSizePixel=0;LT.ZIndex=1001;LT.Parent=L
local title=Instance.new("TextLabel");title.Size=UDim2.new(1,0,0,50);title.Position=UDim2.new(0,0,.5,-35);title.BackgroundTransparency=1;title.Text="LOADING LANTERNVAPE..";title.TextColor3=C.Orange;title.TextSize=25;title.Font=Enum.Font.GothamBold;title.ZIndex=1002;title.Parent=L
local lb=Instance.new("Frame");lb.Size=UDim2.fromOffset(240,4);lb.AnchorPoint=Vector2.new(.5,0);lb.Position=UDim2.new(.5,0,.5,25);lb.BackgroundColor3=C.Darker;lb.BorderSizePixel=0;lb.ZIndex=1002;lb.Parent=L;cr(lb,10)
local bar=Instance.new("Frame");bar.Size=UDim2.new(0,0,1,0);bar.BackgroundColor3=C.Orange;bar.BorderSizePixel=0;bar.ZIndex=1003;bar.Parent=lb;cr(bar,10)
-- Main safe-area container. IgnoreGuiInset remains true for loading; main is manually kept below top bar.
local Safe=Instance.new("Frame");Safe.Size=UDim2.new(1,0,1,-24);Safe.Position=UDim2.fromOffset(0,24);Safe.BackgroundTransparency=1;Safe.Parent=G
local Main=Instance.new("Frame");Main.Size=UDim2.new(1,-30,1,-30);Main.Position=UDim2.fromOffset(15,15);Main.BackgroundTransparency=1;Main.Visible=false;Main.Parent=Safe
local scale=Instance.new("UIScale");scale.Parent=Main
local brand=Instance.new("TextLabel");brand.Size=UDim2.fromOffset(190,42);brand.Position=UDim2.fromOffset(4,4);brand.BackgroundColor3=C.Black;brand.BackgroundTransparency=.05;brand.BorderSizePixel=0;brand.Text=C.Name;brand.TextColor3=C.White;brand.TextSize=18;brand.Font=Enum.Font.GothamBold;brand.TextXAlignment=Enum.TextXAlignment.Left;brand.Parent=Main;cr(brand,5)
local bp=Instance.new("UIPadding");bp.PaddingLeft=UDim.new(0,14);bp.Parent=brand
local ba=Instance.new("Frame");ba.Size=UDim2.new(1,0,0,2);ba.Position=UDim2.new(0,0,1,-2);ba.BackgroundColor3=C.Orange;ba.BorderSizePixel=0;ba.Parent=brand
local menu=iconButton(Main,"Menu",UDim2.fromOffset(42,42),UDim2.fromOffset(202,4),Icons.Menu,"☰",10)
local search=Instance.new("TextBox");search.Size=UDim2.fromOffset(230,34);search.AnchorPoint=Vector2.new(.5,0);search.Position=UDim2.new(.5,0,0,8);search.BackgroundColor3=C.Black;search.BackgroundTransparency=.05;search.BorderSizePixel=0;search.PlaceholderText="Search...";search.PlaceholderColor3=Color3.fromRGB(110,110,110);search.TextColor3=C.White;search.TextSize=13;search.Font=Enum.Font.Gotham;search.ClearTextOnFocus=false;search.Parent=Main;cr(search,5);st(search,C.Orange,.8,1)
local sp=Instance.new("UIPadding");sp.PaddingLeft=UDim.new(0,12);sp.Parent=search
local ver=Instance.new("TextLabel");ver.Size=UDim2.fromOffset(90,42);ver.Position=UDim2.new(1,-142,0,4);ver.BackgroundTransparency=1;ver.Text="v"..C.Version;ver.TextColor3=C.Gray;ver.TextSize=12;ver.Font=Enum.Font.Gotham;ver.TextXAlignment=Enum.TextXAlignment.Right;ver.Parent=Main
local close=iconButton(Main,"Close",UDim2.fromOffset(42,42),UDim2.new(1,-46,0,4),Icons.Close,"×",10)
local content=Instance.new("ScrollingFrame");content.Size=UDim2.new(1,-8,1,-62);content.Position=UDim2.fromOffset(4,58);content.BackgroundTransparency=1;content.BorderSizePixel=0;content.ScrollBarThickness=3;content.ScrollBarImageColor3=C.Orange;content.AutomaticCanvasSize=Enum.AutomaticSize.Y;content.ScrollingDirection=Enum.ScrollingDirection.Y;content.Parent=Main
local grid=Instance.new("UIGridLayout");grid.CellPadding=UDim2.fromOffset(7,7);grid.CellSize=UDim2.new(.2,-7,0,115);grid.FillDirection=Enum.FillDirection.Horizontal;grid.FillDirectionMaxCells=5;grid.SortOrder=Enum.SortOrder.LayoutOrder;grid.Parent=content
local cats={"Combat","Blatant","External","Rendering","Extra"};local panels={}
for i,n in ipairs(cats) do local p=Instance.new("Frame");p.Name=n;p.LayoutOrder=i;p.BackgroundColor3=C.Black;p.BackgroundTransparency=.12;p.BorderSizePixel=0;p.Parent=content;cr(p,5);st(p,C.Orange,.88,1);local h=Instance.new("TextLabel");h.Size=UDim2.new(1,0,0,42);h.BackgroundColor3=C.Black;h.BackgroundTransparency=.02;h.BorderSizePixel=0;h.Text=n;h.TextColor3=C.White;h.TextSize=16;h.Font=Enum.Font.GothamBold;h.TextXAlignment=Enum.TextXAlignment.Left;h.Parent=p;cr(h,5);local pad=Instance.new("UIPadding");pad.PaddingLeft=UDim.new(0,14);pad.Parent=h;local a=Instance.new("Frame");a.Size=UDim2.new(1,0,0,2);a.Position=UDim2.new(0,0,1,-2);a.BackgroundColor3=C.Orange;a.BorderSizePixel=0;a.Parent=h;local m=Instance.new("Frame");m.Name="Modules";m.Size=UDim2.new(1,0,1,-42);m.Position=UDim2.fromOffset(0,42);m.BackgroundTransparency=1;m.Parent=p;panels[n]=p end
local side=Instance.new("Frame");side.Size=UDim2.fromOffset(190,330);side.Position=UDim2.fromOffset(10,58);side.BackgroundColor3=C.Black;side.BackgroundTransparency=.02;side.BorderSizePixel=0;side.Visible=false;side.ZIndex=50;side.Parent=Main;cr(side,6);st(side,C.Orange,.65,1)
local sh=Instance.new("TextLabel");sh.Size=UDim2.new(1,0,0,50);sh.BackgroundColor3=C.Darker;sh.BorderSizePixel=0;sh.Text="LanternVape";sh.TextColor3=C.White;sh.TextSize=17;sh.Font=Enum.Font.GothamBold;sh.ZIndex=51;sh.Parent=side;cr(sh,6)
local list=Instance.new("UIListLayout");list.Padding=UDim.new(0,4);list.SortOrder=Enum.SortOrder.LayoutOrder;list.Parent=side
local pad=Instance.new("UIPadding");pad.PaddingTop=UDim.new(0,55);pad.PaddingLeft=UDim.new(0,5);pad.PaddingRight=UDim.new(0,5);pad.Parent=side
local items={{"Settings","⚙"},{"Profiles","♙"},{"Targets","◎"},{"Themes","◆"},{"Keybinds","⌨"},{"About","?"}}
for i,d in ipairs(items) do local b=iconButton(side,d[1],UDim2.new(1,0,0,38),UDim2.new(),Icons[d[1]],d[2],51);b.LayoutOrder=i;local t=Instance.new("TextLabel");t.Size=UDim2.new(1,-45,1,0);t.Position=UDim2.fromOffset(42,0);t.BackgroundTransparency=1;t.Text=d[1];t.TextColor3=C.White;t.TextSize=13;t.Font=Enum.Font.GothamSemibold;t.TextXAlignment=Enum.TextXAlignment.Left;t.ZIndex=52;t.Parent=b;b.MouseEnter:Connect(function()tw(b,.12,{BackgroundColor3=C.OrangeDark})end);b.MouseLeave:Connect(function()tw(b,.12,{BackgroundColor3=C.Darker})end) end
-- Top-right mobile toggle, safely below Roblox top bar.
local toggle=iconButton(G,"MobileToggle",UDim2.fromOffset(58,58),UDim2.new(1,-76,0,38),Icons.Lantern,"LV",200);toggle.AnchorPoint=Vector2.new(0,0);st(toggle,C.Orange,.15,2);toggle.Visible=false
local function Toggle() Main.Visible=not Main.Visible;if not Main.Visible then side.Visible=false end end
menu.MouseButton1Click:Connect(function()side.Visible=not side.Visible end)
close.MouseButton1Click:Connect(function()Main.Visible=false;side.Visible=false end)
toggle.MouseButton1Click:Connect(Toggle)
UIS.InputBegan:Connect(function(i,p)if not p and(i.KeyCode==Enum.KeyCode.LeftShift or i.KeyCode==Enum.KeyCode.RightShift)then Toggle()end end)
search:GetPropertyChangedSignal("Text"):Connect(function()local q=search.Text:lower()for n,p in pairs(panels)do p.Visible=q=="" or n:lower():find(q,1,true)~=nil end end)
local dragging=false;local ds;local ss
brand.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true;ds=i.Position;ss=Main.Position end end)
UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
UIS.InputChanged:Connect(function(i)if dragging and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then local d=i.Position-ds;Main.Position=UDim2.new(ss.X.Scale,ss.X.Offset+d.X,ss.Y.Scale,ss.Y.Offset+d.Y)end end)
local cam=workspace.CurrentCamera
local function layout()cam=workspace.CurrentCamera or cam;if not cam then return end;grid.FillDirectionMaxCells=5;grid.CellSize=UDim2.new(.2,-7,0,115);local w=cam.ViewportSize.X;if w<500 then scale.Scale=.52 elseif w<650 then scale.Scale=.62 elseif w<800 then scale.Scale=.72 elseif w<1000 then scale.Scale=.84 else scale.Scale=1 end end
layout();if cam then cam:GetPropertyChangedSignal("ViewportSize"):Connect(layout)end
-- Loading animation starts after all objects exist.
tw(bar,C.LoadingTime,{Size=UDim2.new(1,0,1,0)});task.wait(C.LoadingTime);Main.Visible=true;if UIS.TouchEnabled then toggle.Visible=true end;tw(L,.35,{BackgroundTransparency=1});tw(LT,.35,{BackgroundTransparency=1});tw(title,.35,{TextTransparency=1});tw(lb,.35,{BackgroundTransparency=1});tw(bar,.35,{BackgroundTransparency=1});task.wait(.4);if L.Parent then L:Destroy()end
print("["..C.Name.."] Loaded "..C.Version)