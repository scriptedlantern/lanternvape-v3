-- LanternVape V3 - Blatant / Phase
-- Disables local character collisions while enabled.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local Phase = {
    Name = "Phase",
    Category = "Blatant",
    Description = "Disables your character's collision.",
    Enabled = false
}

local connection
local original = {}

local function apply(character)
    if not character then return end

    for _, object in ipairs(character:GetDescendants()) do
        if object:IsA("BasePart") then
            if original[object] == nil then
                original[object] = object.CanCollide
            end
            object.CanCollide = false
        end
    end
end

local function restore()
    for object, canCollide in pairs(original) do
        if object and object.Parent then
            object.CanCollide = canCollide
        end
    end
    table.clear(original)
end

function Phase:SetEnabled(enabled)
    self.Enabled = enabled

    if connection then
        connection:Disconnect()
        connection = nil
    end

    if not enabled then
        restore()
        return
    end

    local character = player.Character
    if character then
        apply(character)
    end

    connection = RunService.Heartbeat:Connect(function()
        if not self.Enabled then return end

        local current = player.Character
        if current then
            apply(current)
        end
    end)
end

player.CharacterAdded:Connect(function(character)
    if Phase.Enabled then
        task.defer(function()
            apply(character)
        end)
    end
end)

return Phase
