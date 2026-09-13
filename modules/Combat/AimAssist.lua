-- LanternVape V3 - Combat / AimAssist
-- Smooth camera assistance toward the nearest alive player.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local AimAssist = {
    Name = "AimAssist",
    Category = "Combat",
    Description = "Camera tracks the nearest player.",
    Enabled = false,
    Smoothness = 0.20,
    MaxDistance = 250
}

local connection
local currentTarget

local function rootOf(character)
    return character and character:FindFirstChild("HumanoidRootPart")
end

local function nearestPlayer()
    local character = player.Character
    local localRoot = rootOf(character)
    if not localRoot then return nil end

    local nearest
    local nearestDistance = AimAssist.MaxDistance

    for _, target in ipairs(Players:GetPlayers()) do
        if target ~= player then
            local targetCharacter = target.Character
            local humanoid = targetCharacter and targetCharacter:FindFirstChildOfClass("Humanoid")
            local targetRoot = rootOf(targetCharacter)

            if humanoid and humanoid.Health > 0 and targetRoot then
                local distance = (targetRoot.Position - localRoot.Position).Magnitude
                if distance < nearestDistance then
                    nearest = target
                    nearestDistance = distance
                end
            end
        end
    end

    return nearest
end

function AimAssist:GetTarget()
    return currentTarget
end

function AimAssist:SetEnabled(enabled)
    self.Enabled = enabled

    if connection then
        connection:Disconnect()
        connection = nil
    end

    currentTarget = nil
    shared.LanternVapeAimTarget = nil

    if not enabled then
        return
    end

    connection = RunService.RenderStepped:Connect(function()
        if not self.Enabled then return end

        local camera = Workspace.CurrentCamera
        if not camera then return end

        local target = nearestPlayer()
        currentTarget = target
        shared.LanternVapeAimTarget = target

        if not target then return end

        local targetRoot = rootOf(target.Character)
        local humanoid = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
        if not targetRoot or not humanoid or humanoid.Health <= 0 then return end

        local targetPosition = targetRoot.Position + Vector3.new(0, 1.5, 0)
        local desired = CFrame.lookAt(camera.CFrame.Position, targetPosition)

        camera.CFrame = camera.CFrame:Lerp(desired, self.Smoothness)
    end)
end

return AimAssist
