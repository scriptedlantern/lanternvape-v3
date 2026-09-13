-- LanternVape V3 - Combat / AimAssist
-- Smoothly turns the local camera toward the nearest visible player.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local AimAssist = {
    Name = "AimAssist",
    Category = "Combat",
    Description = "Camera tracks the nearest player.",
    Enabled = false,
    Smoothness = 0.22,
    MaxDistance = 250
}

local connection

local function getRoot(character)
    return character and character:FindFirstChild("HumanoidRootPart")
end

local function getNearest()
    local character = player.Character
    local localRoot = getRoot(character)
    local camera = Workspace.CurrentCamera
    if not localRoot or not camera then return nil end

    local nearest
    local nearestDistance = AimAssist.MaxDistance

    for _, target in ipairs(Players:GetPlayers()) do
        if target ~= player then
            local targetCharacter = target.Character
            local humanoid = targetCharacter and targetCharacter:FindFirstChildOfClass("Humanoid")
            local targetRoot = getRoot(targetCharacter)

            if humanoid and humanoid.Health > 0 and targetRoot then
                local distance = (targetRoot.Position - localRoot.Position).Magnitude
                if distance < nearestDistance then
                    nearest = targetRoot
                    nearestDistance = distance
                end
            end
        end
    end

    return nearest
end

function AimAssist:SetEnabled(enabled)
    self.Enabled = enabled

    if connection then
        connection:Disconnect()
        connection = nil
    end

    if not enabled then return end

    connection = RunService.RenderStepped:Connect(function()
        if not self.Enabled then return end

        local camera = Workspace.CurrentCamera
        local targetRoot = getNearest()

        if not camera or not targetRoot then return end

        local targetPosition = targetRoot.Position + Vector3.new(0, 1.5, 0)
        local desired = CFrame.lookAt(camera.CFrame.Position, targetPosition)

        camera.CFrame = camera.CFrame:Lerp(desired, self.Smoothness)
    end)
end

return AimAssist
