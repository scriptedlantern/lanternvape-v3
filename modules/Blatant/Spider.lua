-- LanternVape V3 - Blatant / Spider
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local Spider = {Name="Spider", Category="Blatant", Description="Climb walls.", Min=1, Max=50, Value=16, Enabled=false}
local connection

local function getRoot()
    local c = player.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

function Spider:SetValue(v)
    self.Value = math.clamp(tonumber(v) or 16, self.Min, self.Max)
end

function Spider:SetEnabled(v)
    self.Enabled = v
    if connection then connection:Disconnect(); connection=nil end
    if v then
        connection = RunService.Heartbeat:Connect(function()
            local root = getRoot()
            if not root then return end
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Exclude
            params.FilterDescendantsInstances = {player.Character}
            local hit = workspace:Raycast(root.Position, root.CFrame.LookVector * 2.5, params)
            if hit and hit.Instance and hit.Instance.CanCollide then
                root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, self.Value, root.AssemblyLinearVelocity.Z)
            end
        end)
    end
end

return Spider
