-- LanternVape V3 - Blatant / Antifall
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local player=Players.LocalPlayer

local Antifall={Name="Antifall",Category="Blatant",Description="Prevent falling by holding you at the height where you left the ground.",Enabled=false}
local connection
local savedY=nil

function Antifall:SetEnabled(v)
    self.Enabled=v
    if connection then connection:Disconnect(); connection=nil end
    savedY=nil
    if not v then return end

    connection=RunService.Heartbeat:Connect(function()
        local c=player.Character
        local root=c and c:FindFirstChild("HumanoidRootPart")
        local hum=c and c:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end

        local state=hum:GetState()
        local grounded=state==Enum.HumanoidStateType.Running
            or state==Enum.HumanoidStateType.RunningNoPhysics
            or state==Enum.HumanoidStateType.Landed

        if grounded then
            savedY=root.Position.Y
        elseif savedY then
            local velocity=root.AssemblyLinearVelocity
            if root.Position.Y < savedY then
                root.CFrame=CFrame.new(root.Position.X,savedY,root.Position.Z)*CFrame.Angles(0,root.Orientation.Y*math.pi/180,0)
                root.AssemblyLinearVelocity=Vector3.new(velocity.X,0,velocity.Z)
            end
        end
    end)
end

return Antifall
