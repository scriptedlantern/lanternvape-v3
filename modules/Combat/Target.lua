-- LanternVape V3 - Combat / Target
-- Displays the player currently selected by AimAssist.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

local Target = {
    Name = "Target",
    Category = "Combat",
    Description = "Shows information about your current target.",
    Enabled = false
}

local connection
local gui
local card
local avatar
local displayName
local username
local healthText
local healthFill
local lastUserId

local function corner(o, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = o
end

local function stroke(o, color, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Transparency = transparency
    s.Thickness = 1
    s.Parent = o
end

local function createHud()
    if gui and gui.Parent then return end

    gui = Instance.new("ScreenGui")
    gui.Name = "LanternVapeTargetHUD"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = player:WaitForChild("PlayerGui")

    card = Instance.new("Frame")
    card.Name = "TargetCard"
    card.AnchorPoint = Vector2.new(0.5, 0)
    card.Position = UDim2.new(0.5, 0, 0, 18)
    card.Size = UDim2.fromOffset(310, 76)
    card.BackgroundColor3 = Color3.fromRGB(8,8,8)
    card.BackgroundTransparency = .08
    card.BorderSizePixel = 0
    card.Visible = false
    card.ZIndex = 10
    card.Parent = gui
    corner(card, 8)
    stroke(card, Color3.fromRGB(220,115,35), .25)

    avatar = Instance.new("ImageLabel")
    avatar.Name = "ProfileIcon"
    avatar.Size = UDim2.fromOffset(56,56)
    avatar.Position = UDim2.fromOffset(10,10)
    avatar.BackgroundColor3 = Color3.fromRGB(21,21,21)
    avatar.BorderSizePixel = 0
    avatar.ZIndex = 11
    avatar.Parent = card
    corner(avatar, 28)

    displayName = Instance.new("TextLabel")
    displayName.Size = UDim2.new(1,-82,0,23)
    displayName.Position = UDim2.fromOffset(76,9)
    displayName.BackgroundTransparency = 1
    displayName.TextColor3 = Color3.fromRGB(245,245,245)
    displayName.TextSize = 14
    displayName.Font = Enum.Font.GothamBold
    displayName.TextXAlignment = Enum.TextXAlignment.Left
    displayName.TextTruncate = Enum.TextTruncate.AtEnd
    displayName.ZIndex = 11
    displayName.Parent = card

    username = Instance.new("TextLabel")
    username.Size = UDim2.new(1,-82,0,17)
    username.Position = UDim2.fromOffset(76,29)
    username.BackgroundTransparency = 1
    username.TextColor3 = Color3.fromRGB(145,145,145)
    username.TextSize = 10
    username.Font = Enum.Font.Gotham
    username.TextXAlignment = Enum.TextXAlignment.Left
    username.TextTruncate = Enum.TextTruncate.AtEnd
    username.ZIndex = 11
    username.Parent = card

    healthText = Instance.new("TextLabel")
    healthText.Size = UDim2.new(1,-82,0,16)
    healthText.Position = UDim2.fromOffset(76,47)
    healthText.BackgroundTransparency = 1
    healthText.TextColor3 = Color3.fromRGB(220,115,35)
    healthText.TextSize = 10
    healthText.Font = Enum.Font.GothamSemibold
    healthText.TextXAlignment = Enum.TextXAlignment.Left
    healthText.ZIndex = 11
    healthText.Parent = card

    local bar = Instance.new("Frame")
    bar.Size = UDim2.fromOffset(120,5)
    bar.Position = UDim2.new(1,-130,1,-14)
    bar.BackgroundColor3 = Color3.fromRGB(35,35,35)
    bar.BorderSizePixel = 0
    bar.ZIndex = 11
    bar.Parent = card
    corner(bar, 5)

    healthFill = Instance.new("Frame")
    healthFill.Size = UDim2.fromScale(1,1)
    healthFill.BackgroundColor3 = Color3.fromRGB(220,115,35)
    healthFill.BorderSizePixel = 0
    healthFill.ZIndex = 12
    healthFill.Parent = bar
    corner(healthFill, 5)
end

local function getTarget()
    local target = shared.LanternVapeAimTarget
    if target and target.Parent == Players then
        return target
    end

    return nil
end

local function update(target)
    if not target then
        card.Visible = false
        lastUserId = nil
        return
    end

    local character = target.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        card.Visible = false
        return
    end

    if lastUserId ~= target.UserId then
        lastUserId = target.UserId
        local ok, content = pcall(function()
            return Players:GetUserThumbnailAsync(
                target.UserId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size100x100
            )
        end)

        if ok and content then
            avatar.Image = content
        else
            avatar.Image = ""
        end
    end

    displayName.Text = target.DisplayName
    username.Text = "@" .. target.Name

    local maxHealth = math.max(humanoid.MaxHealth, 1)
    local health = math.max(humanoid.Health, 0)
    local ratio = math.clamp(health / maxHealth, 0, 1)

    healthText.Text = string.format("HP  %d / %d", math.floor(health + .5), math.floor(maxHealth + .5))
    healthFill.Size = UDim2.fromScale(ratio, 1)
    card.Visible = true
end

function Target:SetEnabled(enabled)
    self.Enabled = enabled

    if connection then
        connection:Disconnect()
        connection = nil
    end

    createHud()

    if not enabled then
        card.Visible = false
        return
    end

    connection = RunService.RenderStepped:Connect(function()
        if self.Enabled then
            update(getTarget())
        end
    end)
end

return Target
