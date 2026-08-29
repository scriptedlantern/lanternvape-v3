-- LanternVape V3 - Blatant / Phase
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local Phase = {Name="Phase", Category="Blatant", Description="Pass through collidable objects.", Enabled=false}
local connection
function Phase:SetEnabled(v)
    self.Enabled=v
    if connection then connection:Disconnect(); connection=nil end
    if v then
        connection=RunService.Stepped:Connect(function()
            local c=player.Character
            if not c then return end
            for _,p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then
                    p.CanCollide=false
                end
            end
        end)
    else
        local c=player.Character
        if c then
            for _,p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide=true end
            end
        end
    end
end
return Phase
