-- LanternVape V3 - Combat / Autoclicker
local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local RunService=game:GetService("RunService")
local VIM=game:GetService("VirtualInputManager")
local player=Players.LocalPlayer
local Auto={Name="Autoclicker",Category="Combat",Description="Rapidly clicks while the keybind is held.",Min=1,Max=30,Value=12,KeyCode=Enum.KeyCode.F,HoldMode=true,Enabled=false}
local connection
local held=false
local function click()
 if typeof(mouse1click)=="function" then pcall(mouse1click);return end
 if VIM then pcall(function()VIM:SendMouseButtonEvent(0,0,0,true,game,0);VIM:SendMouseButtonEvent(0,0,0,false,game,0)end) end
end
function Auto:SetValue(v)self.Value=math.clamp(tonumber(v) or 12,self.Min,self.Max)end
function Auto:BuildSettings(parent,resize)
 local box=Instance.new("Frame");box.Name="AutoclickerSettings";box.Size=UDim2.new(1,-10,0,86);box.BackgroundTransparency=1;box.BorderSizePixel=0;box.Visible=false;box.ZIndex=90;box.Parent=parent
 local key=Instance.new("TextButton");key.Size=UDim2.new(1,0,0,36);key.BackgroundColor3=Color3.fromRGB(8,8,8);key.BorderSizePixel=0;key.Text="Keybind: "..self.KeyCode.Name;key.TextColor3=Color3.fromRGB(245,245,245);key.TextSize=11;key.Font=Enum.Font.GothamSemibold;key.AutoButtonColor=false;key.ZIndex=91;key.Parent=box
 local cps=Instance.new("TextLabel");cps.Size=UDim2.new(1,0,0,42);cps.Position=UDim2.fromOffset(0,42);cps.BackgroundColor3=Color3.fromRGB(8,8,8);cps.BorderSizePixel=0;cps.Text="CPS: "..self.Value.."   •   Hold key to click";cps.TextColor3=Color3.fromRGB(220,115,35);cps.TextSize=10;cps.Font=Enum.Font.GothamSemibold;cps.ZIndex=91;cps.Parent=box
 local waiting=false
 key.MouseButton1Click:Connect(function()waiting=true;key.Text="Press a key...";end)
 UIS.InputBegan:Connect(function(input,gp)
  if waiting and input.UserInputType==Enum.UserInputType.Keyboard then self.KeyCode=input.KeyCode;waiting=false;key.Text="Keybind: "..self.KeyCode.Name end
 end)
 local oldSet=self.SetValue
 self.SetValue=function(me,v)oldSet(me,v);cps.Text="CPS: "..me.Value.."   •   Hold key to click" end
 return {box}
end
function Auto:SetEnabled(v)
 self.Enabled=v;held=false;if connection then connection:Disconnect();connection=nil end
 if not v then return end
 connection=RunService.RenderStepped:Connect(function()
  if not self.Enabled or not held then return end
  click()
  task.wait(1/math.max(self.Value,1))
 end)
end
UIS.InputBegan:Connect(function(input,gp)if not gp and input.UserInputType==Enum.UserInputType.Keyboard and input.KeyCode==Auto.KeyCode then held=true end end)
UIS.InputEnded:Connect(function(input)if input.UserInputType==Enum.UserInputType.Keyboard and input.KeyCode==Auto.KeyCode then held=false end end)
return Auto