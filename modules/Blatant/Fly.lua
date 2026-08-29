-- LanternVape V3 - Blatant / Fly
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local player=Players.LocalPlayer
local Fly={Name="Fly",Category="Blatant",Description="Fly with adjustable vertical rate.",Min=1,Max=50,Value=10,Enabled=false}
local connection
function Fly:SetValue(v) self.Value=math.clamp(tonumber(v) or 10,self.Min,self.Max) end
function Fly:SetEnabled(v)
    self.Enabled=v
    if connection then connection:Disconnect(); connection=nil end
    if v then
        connection=RunService.RenderStepped:Connect(function()
            local c=player.Character
            local root=c and c:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local hum=c:FindFirstChildOfClass("Humanoid")
            local move=hum and hum.MoveDirection or Vector3.zero
            local vertical=0
            if UIS:IsKeyDown(Enum.KeyCode.Space) then vertical=self.Value end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then vertical=-self.Value end
            root.AssemblyLinearVelocity=Vector3.new(move.X*self.Value,vertical,move.Z*self.Value)
        end)
    end
end
return Fly
