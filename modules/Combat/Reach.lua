-- LanternVape V3 - Combat / Reach
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local player=Players.LocalPlayer
local Reach={Name="Reach",Category="Combat",Description="Extends the local tool reach.",Min=1,Max=20,Value=10,Enabled=false}
local connection
local original={}
function Reach:SetValue(v)self.Value=math.clamp(tonumber(v) or 10,self.Min,self.Max)end
local function apply()
 local ch=player.Character;if not ch then return end
 for _,tool in ipairs(ch:GetChildren()) do
  if tool:IsA("Tool") then
   local h=tool:FindFirstChild("Handle")
   if h and h:IsA("BasePart") then
    if not original[h] then original[h]={Size=h.Size,CanCollide=h.CanCollide,Massless=h.Massless} end
    local s=original[h].Size
    h.Size=Vector3.new(math.max(s.X,Reach.Value/3),math.max(s.Y,Reach.Value/3),math.max(s.Z,Reach.Value/3))
    h.CanCollide=false;h.Massless=true
   end
  end
 end
end
local function restore()
 for h,v in pairs(original) do if h and h.Parent then h.Size=v.Size;h.CanCollide=v.CanCollide;h.Massless=v.Massless end end
 original={}
end
function Reach:SetEnabled(v)
 self.Enabled=v;if connection then connection:Disconnect();connection=nil end
 if not v then restore();return end
 connection=RunService.Heartbeat:Connect(apply);apply()
end
return Reach