local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local Config = {
    Name = "Lanternvape",
    Version = "3.2.0"
}

local function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Lanternvape"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)

if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(600, 400)
Main.Position = UDim2.new(0.5, -300, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = Main

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1, 0, 0, 50)
Top.BackgroundColor3 = Color3.fromRGB(24, 24, 29)
Top.BorderSizePixel = 0
Top.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = Top

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Position = UDim2.fromOffset(18, 0)
Title.BackgroundTransparency = 1
Title.Text = Config.Name
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

local Version = Instance.new("TextLabel")
Version.Size = UDim2.fromOffset(80, 50)
Version.Position = UDim2.new(1, -90, 0, 0)
Version.BackgroundTransparency = 1
Version.Text = "v" .. Config.Version
Version.TextColor3 = Color3.fromRGB(130, 130, 140)
Version.TextSize = 12
Version.Font = Enum.Font.Gotham
Version.Parent = Top

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 150, 1, -50)
Sidebar.Position = UDim2.fromOffset(0, 50)
Sidebar.BackgroundColor3 = Color3.fromRGB(21, 21, 26)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -150, 1, -50)
Content.Position = UDim2.fromOffset(150, 50)
Content.BackgroundTransparency = 1
Content.Parent = Main

local function clearContent()
    for _, object in ipairs(Content:GetChildren()) do
        object:Destroy()
    end
end

local function createButton(text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -20, 0, 38)
    Button.BackgroundColor3 = Color3.fromRGB(29, 29, 35)
    Button.BorderSizePixel = 0
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(220, 220, 225)
    Button.TextSize = 13
    Button.Font = Enum.Font.GothamMedium
    Button.AutoButtonColor = false

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 7)
    Corner.Parent = Button

    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(38, 38, 46)
    end)

    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(29, 29, 35)
    end)

    Button.MouseButton1Click:Connect(callback)

    return Button
end

local function addToggle(parent, name, default, callback)
    local Enabled = default

    local Holder = Instance.new("Frame")
    Holder.Size = UDim2.new(1, -30, 0, 45)
    Holder.BackgroundColor3 = Color3.fromRGB(27, 27, 33)
    Holder.BorderSizePixel = 0
    Holder.Parent = parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 7)
    Corner.Parent = Holder

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -80, 1, 0)
    Label.Position = UDim2.fromOffset(12, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(230, 230, 235)
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Holder

    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.fromOffset(44, 24)
    Toggle.Position = UDim2.new(1, -55, 0.5, -12)
    Toggle.BackgroundColor3 = Enabled
        and Color3.fromRGB(90, 170, 255)
        or Color3.fromRGB(55, 55, 63)
    Toggle.Text = ""
    Toggle.BorderSizePixel = 0
    Toggle.Parent = Holder

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = Toggle

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.fromOffset(18, 18)
    Dot.Position = Enabled
        and UDim2.new(1, -21, 0.5, -9)
        or UDim2.fromOffset(3, 3)
    Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Dot.BorderSizePixel = 0
    Dot.Parent = Toggle

    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = Dot

    Toggle.MouseButton1Click:Connect(function()
        Enabled = not Enabled

        Toggle.BackgroundColor3 = Enabled
            and Color3.fromRGB(90, 170, 255)
            or Color3.fromRGB(55, 55, 63)

        Dot.Position = Enabled
            and UDim2.new(1, -21, 0.5, -9)
            or UDim2.fromOffset(3, 3)

        callback(Enabled)
    end)

    return Holder
end

local function showHome()
    clearContent()

    local Header = Instance.new("TextLabel")
    Header.Size = UDim2.new(1, -30, 0, 40)
    Header.Position = UDim2.fromOffset(15, 15)
    Header.BackgroundTransparency = 1
    Header.Text = "Welcome"
    Header.TextColor3 = Color3.fromRGB(255, 255, 255)
    Header.TextSize = 22
    Header.Font = Enum.Font.GothamBold
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Parent = Content

    local Info = Instance.new("TextLabel")
    Info.Size = UDim2.new(1, -30, 0, 70)
    Info.Position = UDim2.fromOffset(15, 55)
    Info.BackgroundTransparency = 1
    Info.Text = "Welcome to " .. Config.Name .. ".\nChoose a category from the sidebar."
    Info.TextColor3 = Color3.fromRGB(155, 155, 165)
    Info.TextSize = 14
    Info.Font = Enum.Font.Gotham
    Info.TextWrapped = true
    Info.TextXAlignment = Enum.TextXAlignment.Left
    Info.TextYAlignment = Enum.TextYAlignment.Top
    Info.Parent = Content
end

local function showPlayer()
    clearContent()

    local Header = Instance.new("TextLabel")
    Header.Size = UDim2.new(1, -30, 0, 40)
    Header.Position = UDim2.fromOffset(15, 15)
    Header.BackgroundTransparency = 1
    Header.Text = "Player"
    Header.TextColor3 = Color3.fromRGB(255, 255, 255)
    Header.TextSize = 22
    Header.Font = Enum.Font.GothamBold
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Parent = Content

    local List = Instance.new("UIListLayout")
    List.Padding = UDim.new(0, 8)
    List.Parent = Content

    Header.LayoutOrder = 0

    local Spacer = Instance.new("Frame")
    Spacer.Size = UDim2.new(1, 0, 0, 50)
    Spacer.BackgroundTransparency = 1
    Spacer.LayoutOrder = 1
    Spacer.Parent = Content

    local Speed = addToggle(Content, "WalkSpeed", false, function(enabled)
        local Character = getCharacter()
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            Humanoid.WalkSpeed = enabled and 32 or 16
        end
    end)

    Speed.LayoutOrder = 2

    local Jump = addToggle(Content, "High Jump", false, function(enabled)
        local Character = getCharacter()
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            Humanoid.JumpPower = enabled and 75 or 50
        end
    end)

    Jump.LayoutOrder = 3
end

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 6)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideLayout.Parent = Sidebar

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 12)
SidePadding.Parent = Sidebar

local HomeButton = createButton("Home", showHome)
HomeButton.Parent = Sidebar

local PlayerButton = createButton("Player", showPlayer)
PlayerButton.Parent = Sidebar

local dragging = false
local dragStart
local startPosition

Top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

showHome()

print(Config.Name .. "Lanternvape " .. Config.Version .. " loaded.")
