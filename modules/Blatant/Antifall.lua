-- LanternVape V3 - Blatant / Antifall
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local player=Players.LocalPlayer
local Antifall={Name="Antifall",Category="Blatant",Description="Prevent falling into the void.",Enabled=false}
local connection
function Antifall:SetEnabled(v)
    self.Enabled=v
    if connection then connection:Disconnect(); connection=nil end
    if v then
        connection=RunService.Heartbeat:Connect(function()
            local c=player.Character
            local root=c and c:FindFirstChild("HumanoidRootPart")
            if root and root.Position.Y < -50 then
                root.CFrame=CFrame.new(root.Position.X,10,root.Position.Z)
                root.AssemblyLinearVelocity=Vector3.zero
            end
        end)
    end
end
return Antifall
