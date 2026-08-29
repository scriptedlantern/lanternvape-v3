-- LanternVape V3 - Blatant / Speed
-- Module definition for the LanternVape module system.

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Speed = {
    Name = "Speed",
    Category = "Blatant",
    Description = "Change your humanoid movement speed.",
    Min = 16,
    Max = 50,
    Value = 16,
    Enabled = false,
}

local function getHumanoid()
    local character = player.Character
    return character and character:FindFirstChildOfClass("Humanoid")
end

function Speed:SetEnabled(enabled)
    self.Enabled = enabled
    local humanoid = getHumanoid()
    if not humanoid then return end

    if enabled then
        humanoid.WalkSpeed = math.clamp(self.Value, self.Min, self.Max)
    else
        humanoid.WalkSpeed = 16
    end
end

function Speed:SetValue(value)
    self.Value = math.clamp(tonumber(value) or self.Min, self.Min, self.Max)
    if self.Enabled then
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = self.Value
        end
    end
end

player.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if humanoid and Speed.Enabled then
        humanoid.WalkSpeed = Speed.Value
    end
end)

return Speed
