-- LanternVape V3 modular runtime v2
local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local HttpService=game:GetService("HttpService")
local p=Players.LocalPlayer
local pg=p and p:WaitForChild("PlayerGui",10)
local gui=pg and pg:WaitForChild("LanternVape",10)
local main=gui and gui:WaitForChild("Main",10)
local cats=main and main:WaitForChild("Categories",10)
if not cats then return end
local base="https://raw.githubusercontent.com/scriptedlantern/lanternvape-v3/main/"
local api="https://api.github.com/repos/scriptedlantern/lanternvape-v3/contents/modules"
local C={O=Color3.fromRGB(220,115,35),D=Color3.fromRGB(21,21,21),B=Color3.fromRGB(8,8,8),W=Color3.fromRGB(245,245,245),G=Color3.fromRGB(145,145,145)}
local function json(u)
 local ok,b=pcall(function() return game:HttpGet(u,true) end); if not ok then return nil end
 local good,d=pcall(function() return HttpService:JSONDecode(b) end); return good and d or nil
end
local function module(path)
 local ok,s=pcall(function() return game:HttpGet(base..path,true) end); if not ok then return nil end
 local f,e=loadstring(s,"LanternVape/"..path); if not f then warn(e); return nil end
 local ran,m=pcall(f); if not ran or type(m)~="table" or type(m.Name)~="string" then if not ran then warn(m) end return nil end
 return m
end
local function corner(o,r) local x=Instance.new("UICorner"); x.CornerRadius=UDim.new(0,r); x.Parent=o end
local function slider(holder,mn,mx,label,setter,prop,y)
 local f=Instance.new("Frame"); f.Size=UDim2.new(1,-10,0,58); f.Position=UDim2.fromOffset(5,y); f.BackgroundColor3=C.B; f.BorderSizePixel=0; f.ZIndex=80; f.Parent=holder; corner(f,6)
 local t=Instance.new("TextLabel"); t.Size=UDim2.new(1,-20,0,20); t.Position=UDim2.fromOffset(10,4); t.BackgroundTransparency=1; t.TextColor3=C.W; t.TextSize=10; t.Font=Enum.Font.GothamSemibold; t.TextXAlignment=Enum.TextXAlignment.Left; t.ZIndex=81; t.Parent=f
 local bar=Instance.new("Frame"); bar.Size=UDim2.new(1,-20,0,6); bar.Position=UDim2.fromOffset(10,34); bar.BackgroundColor3=C.D; bar.BorderSizePixel=0; bar.ZIndex=81; bar.Parent=f; corner(bar,6)
 local fill=Instance.new("Frame"); fill.Size=UDim2.new(0,0,1,0); fill.BackgroundColor3=C.O; fill.BorderSizePixel=0; fill.ZIndex=82; fill.Parent=bar; corner(fill,6)
 local function draw()
  local v=math.clamp(tonumber(m[prop]) or mn,mn,mx); local a=(v-mn)/(mx-mn); t.Text=label..": "..math.floor(v+.5); fill.Size=UDim2.new(a,0,1,0)
 end
 local drag=false
 local function set(x)
  local w=bar.AbsoluteSize.X; if w<=0 then return end; local v=mn+math.clamp((x-bar.AbsolutePosition.X)/w,0,1)*(mx-mn); if m[setter] then pcall(function() m[setter](m,v) end) end; draw()
 end
 bar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=true; set(i.Position.X) end end)
 UIS.InputChanged:Connect(function(i) if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then set(i.Position.X) end end)
 UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end end)
 draw(); return f
end
local function row(frame,m)
 local h=Instance.new("Frame"); h.Name="Module_"..m.Name; h.Size=UDim2.new(1,-10,0,38); h.BackgroundTransparency=1; h.BorderSizePixel=0; h.Parent=frame
 local b=Instance.new("TextButton"); b.Name="Toggle"; b.Size=UDim2.new(1,0,0,34); b.BackgroundColor3=C.D; b.BorderSizePixel=0; b.Text=""; b.AutoButtonColor=false; b.ZIndex=50; b.Parent=h; corner(b,5)
 local title=Instance.new("TextLabel"); title.Size=UDim2.new(1,-88,1,0); title.Position=UDim2.fromOffset(10,0); title.BackgroundTransparency=1; title.Text=m.Name; title.TextColor3=C.W; title.TextSize=12; title.Font=Enum.Font.GothamSemibold; title.TextXAlignment=Enum.TextXAlignment.Left; title.ZIndex=51; title.Parent=b
 local state=Instance.new("TextLabel"); state.Size=UDim2.fromOffset(34,34); state.Position=UDim2.new(1,-38,0,0); state.BackgroundTransparency=1; state.Text="OFF"; state.TextColor3=C.G; state.TextSize=9; state.Font=Enum.Font.GothamBold; state.ZIndex=51; state.Parent=b
 local panels={}
 if type(m.SetValue)=="function" and tonumber(m.Min) and tonumber(m.Max) then panels[#panels+1]=slider(h,tonumber(m.Min),tonumber(m.Max),"Speed","SetValue","Value",38) end
 if type(m.SetVerticalValue)=="function" then panels[#panels+1]=slider(h,tonumber(m.VerticalMin) or 1,tonumber(m.VerticalMax) or 23,"Vertical speed","SetVerticalValue","VerticalValue",38+#panels*63) end
 local opt=Instance.new("TextButton"); opt.Name="Options"; opt.Size=UDim2.fromOffset(36,34); opt.Position=UDim2.new(1,-72,0,0); opt.BackgroundTransparency=1; opt.BorderSizePixel=0; opt.Text="•••"; opt.TextColor3=C.G; opt.TextSize=13; opt.Font=Enum.Font.GothamBold; opt.AutoButtonColor=false; opt.ZIndex=100; opt.Parent=h
 for _,x in ipairs(panels) do x.Visible=false end
 opt.Visible=#panels>0
 local function render() local on=m.Enabled==true; b.BackgroundColor3=on and C.O:Lerp(Color3.new(),.35) or C.D; state.Text=on and "ON" or "OFF"; state.TextColor3=on and C.W or C.G end
 b.MouseButton1Click:Connect(function() if m.SetEnabled then pcall(function() m:SetEnabled(not m.Enabled) end) end; render() end)
 opt.MouseButton1Click:Connect(function() local open=#panels>0 and not panels[1].Visible; local height=38; for _,x in ipairs(panels) do x.Visible=open; if open then height+=63 end end; h.Size=UDim2.new(1,-10,0,open and height or 38) end)
 render()
end
local dirs=json(api); if not dirs then return end
for _,d in ipairs(dirs) do
 if d.type=="dir" then
  local panel=cats:FindFirstChild(d.name); local frame=panel and panel:FindFirstChild("Modules")
  if frame then
   local old=frame:FindFirstChild("LanternVapeRuntime"); if old then old:Destroy() end
   local box=Instance.new("Frame"); box.Name="LanternVapeRuntime"; box.Size=UDim2.new(1,0,0,0); box.AutomaticSize=Enum.AutomaticSize.Y; box.BackgroundTransparency=1; box.Parent=frame
   local list=Instance.new("UIListLayout"); list.Padding=UDim.new(0,5); list.SortOrder=Enum.SortOrder.LayoutOrder; list.Parent=box
   local fs=json(api.."/"..d.name) or {}; local files={}
   for _,x in ipairs(fs) do if x.type=="file" and x.name:sub(-4):lower()==".lua" and x.name:lower()~="init.lua" and x.name~="BlatantRuntime.lua" and x.name~="BlatantRuntimeV2.lua" then files[#files+1]=x end end
   table.sort(files,function(a,b) return a.name:lower()<b.name:lower() end)
   for _,x in ipairs(files) do local m=module(x.path); if m then row(box,m) end end
  end
 end
end
print("[LanternVape] All modules loaded")
