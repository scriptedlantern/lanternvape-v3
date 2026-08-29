-- LanternVape V3 - Blatant / HighJump
local Players=game:GetService("Players")
local player=Players.LocalPlayer
local HighJump={Name="HighJump",Category="Blatant",Description="Increase jump height.",Min=50,Max=200,Value=100,Enabled=false}
function HighJump:SetValue(v) self.Value=math.clamp(tonumber(v) or 100,self.Min,self.Max) end
function HighJump:SetEnabled(v)
    self.Enabled=v
    local c=player.Character
    local h=c and c:FindFirstChildOfClass("Humanoid")
    if h then h.UseJumpPower=true; h.JumpPower=v and self.Value or 50 end
end
player.CharacterAdded:Connect(function(c)
    local h=c:WaitForChild("Humanoid",5)
    if h then h.UseJumpPower=true; h.JumpPower=HighJump.Enabled and HighJump.Value or 50 end
end)
return HighJump
