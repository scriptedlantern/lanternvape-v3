-- LanternVape V3 - Rendering / Text UI
local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local RunService=game:GetService("RunService")
local player=Players.LocalPlayer
local TextUI={Name="Text UI",Category="Rendering",Description="Shows enabled modules on screen.",Enabled=false,Text="",TextColor=Color3.fromRGB(245,245,245),TextSize=14,Position=UDim2.new(0,18,0.5,-60),ShowBackground=true}
local gui,label,bg,dragging,dragStart,startPos
local function corner(o,r)local c=Instance.new("UICorner");c.CornerRadius=UDim.new(0,r);c.Parent=o end
local function build()
 if gui and gui.Parent then return end
 gui=Instance.new("ScreenGui");gui.Name="LanternVapeTextUI";gui.ResetOnSpawn=false;gui.IgnoreGuiInset=true;gui.Parent=player:WaitForChild("PlayerGui")
 bg=Instance.new("Frame");bg.Name="Background";bg.Size=UDim2.fromOffset(190,100);bg.Position=TextUI.Position;bg.BackgroundColor3=Color3.fromRGB(8,8,8);bg.BackgroundTransparency=.25;bg.BorderSizePixel=0;bg.Visible=false;bg.Parent=gui;corner(bg,7)
 label=Instance.new("TextLabel");label.Name="EnabledModules";label.Size=UDim2.new(1,-16,1,-12);label.Position=UDim2.fromOffset(8,6);label.BackgroundTransparency=1;label.TextColor3=TextUI.TextColor;label.TextSize=TextUI.TextSize;label.Font=Enum.Font.GothamBold;label.TextXAlignment=Enum.TextXAlignment.Left;label.TextYAlignment=Enum.TextYAlignment.Top;label.TextWrapped=false;label.Parent=bg
 bg.InputBegan:Connect(function(input)if not TextUI.Enabled then return end;if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=true;dragStart=input.Position;startPos=bg.Position end end)
 UIS.InputChanged:Connect(function(input)if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then local d=input.Position-dragStart;bg.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y);TextUI.Position=bg.Position end end)
 UIS.InputEnded:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
end
local function refresh()
 if not label then return end
 label.TextColor3=TextUI.TextColor;label.TextSize=TextUI.TextSize
 local lines={}
 local prefix=TextUI.Text~="" and (TextUI.Text.." ") or ""
 for _,m in ipairs(shared.LanternVapeModules or {}) do if m~=TextUI and m.Enabled then lines[#lines+1]=prefix..m.Name end end
 label.Text=table.concat(lines,"\n")
 label.Visible=#lines>0
 bg.Visible=TextUI.Enabled and #lines>0
 bg.BackgroundTransparency=TextUI.ShowBackground and .25 or 1
 bg.Size=UDim2.fromOffset(math.max(170,label.TextBounds.X+18),math.max(35,#lines*(TextUI.TextSize+3)+12))
end
function TextUI:BuildSettings(parent,resize)
 build()
 local box=Instance.new("Frame");box.Name="TextUISettings";box.Size=UDim2.new(1,-10,0,190);box.BackgroundTransparency=1;box.Visible=false;box.ZIndex=90;box.Parent=parent
 local function tb(name,y,placeholder,value,callback)
  local b=Instance.new("TextBox");b.Name=name;b.Size=UDim2.new(1,0,0,34);b.Position=UDim2.fromOffset(0,y);b.BackgroundColor3=Color3.fromRGB(8,8,8);b.BorderSizePixel=0;b.Text=value or "";b.PlaceholderText=placeholder;b.TextColor3=Color3.fromRGB(245,245,245);b.TextSize=10;b.Font=Enum.Font.Gotham;b.ClearTextOnFocus=false;b.ZIndex=91;b.Parent=box;b.FocusLost:Connect(function()callback(b.Text)end);return b end
 tb("CustomText",0,"Custom text (optional)",self.Text,function(v)self.Text=v;refresh()end)
 tb("TextColor",40,"Color: R,G,B","255,255,255",function(v)local r,g,b=v:match("(%d+)%s*,%s*(%d+)%s*,%s*(%d+)");if r then self.TextColor=Color3.fromRGB(math.clamp(tonumber(r),0,255),math.clamp(tonumber(g),0,255),math.clamp(tonumber(b),0,255));refresh()end end)
 tb("TextSize",80,"Text size",""..self.TextSize,function(v)self.TextSize=math.clamp(tonumber(v) or 14,8,30);refresh()end)
 local bgBtn=Instance.new("TextButton");bgBtn.Size=UDim2.new(1,0,0,34);bgBtn.Position=UDim2.fromOffset(0,120);bgBtn.BackgroundColor3=Color3.fromRGB(8,8,8);bgBtn.BorderSizePixel=0;bgBtn.TextColor3=Color3.fromRGB(245,245,245);bgBtn.TextSize=10;bgBtn.Font=Enum.Font.GothamSemibold;bgBtn.Text="Background: ON";bgBtn.ZIndex=91;bgBtn.Parent=box;bgBtn.MouseButton1Click:Connect(function()self.ShowBackground=not self.ShowBackground;bgBtn.Text="Background: "..(self.ShowBackground and "ON" or "OFF");refresh()end)
 return {box}
end
function TextUI:SetEnabled(v)self.Enabled=v;build();if not v then bg.Visible=false;dragging=false else refresh()end end
return TextUI