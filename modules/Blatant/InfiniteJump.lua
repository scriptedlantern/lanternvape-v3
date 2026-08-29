-- LanternVape V3 - Blatant / Infinite Jump
local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local player=Players.LocalPlayer
local InfiniteJump={Name="Infinite Jump",Category="Blatant",Description="Jump repeatedly without a cooldown.",Enabled=false}
local connection
function InfiniteJump:SetEnabled(v)
    self.Enabled=v
    if connection then connection:Disconnect(); connection=nil end
    if v then
        connection=UIS.JumpRequest:Connect(function()
            local c=player.Character
            local h=c and c:FindFirstChildOfClass("Humanoid")
            if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    end
end
return InfiniteJump
