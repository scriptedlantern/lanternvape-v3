-- LanternVape V3 - Blatant / Fly
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local player=Players.LocalPlayer

local Fly={Name="Fly",Category="Blatant",Description="Adjustable horizontal and vertical flight.",Min=1,Max=23,Value=10,VerticalMin=1,VerticalMax=23,VerticalValue=10,Enabled=false}
local connection
local jumpConnection
local oldAutoRotate

local function getCharacter()
    local c=player.Character
    local root=c and c:FindFirstChild("HumanoidRootPart")
    local hum=c and c:FindFirstChildOfClass("Humanoid")
    return c,root,hum
end

function Fly:SetValue(v)
    self.Value=math.clamp(tonumber(v) or 10,self.Min,self.Max)
end

function Fly:SetVerticalValue(v)
    self.VerticalValue=math.clamp(tonumber(v) or 10,self.VerticalMin,self.VerticalMax)
end

function Fly:SetEnabled(v)
    self.Enabled=v
    if connection then connection:Disconnect(); connection=nil end
    if jumpConnection then jumpConnection:Disconnect(); jumpConnection=nil end

    local _,_,hum=getCharacter()
    if hum then
        if v then
            oldAutoRotate=hum.AutoRotate
            hum.AutoRotate=false
        elseif oldAutoRotate~=nil then
            hum.AutoRotate=oldAutoRotate
            oldAutoRotate=nil
        end
    end

    if not v then return end

    jumpConnection=UIS.JumpRequest:Connect(function()
        if not self.Enabled then return end
        local _,root= getCharacter()
        if root then
            local velocity=root.AssemblyLinearVelocity
            root.AssemblyLinearVelocity=Vector3.new(velocity.X,self.VerticalValue,velocity.Z)
        end
    end)

    connection=RunService.RenderStepped:Connect(function()
        local _,root,hum=getCharacter()
        if not root or not hum then return end

        local move=hum.MoveDirection
        local horizontal=move*self.Value
        local currentY=root.AssemblyLinearVelocity.Y
        local targetY=currentY

        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            targetY=self.VerticalValue
        elseif UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.C) then
            targetY=-math.max(1,self.VerticalValue*0.35)
        else
            -- Slow descent when not actively going upward.
            targetY=math.max(-math.max(2,self.VerticalValue*0.35), currentY)
        end

        root.AssemblyLinearVelocity=Vector3.new(horizontal.X,targetY,horizontal.Z)
    end)
end

return Fly
