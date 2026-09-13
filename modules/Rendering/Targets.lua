-- LanternVape V3 - Rendering / Targets
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local player=Players.LocalPlayer
local Target={Name="Targets",Category="Rendering",Description="Shows information about your current target.",Enabled=false}
local gui,card,avatar,displayName,username,healthText,healthFill,connection,lastUserId
local function corner(o,r)local c=Instance.new("UICorner");c.CornerRadius=UDim.new(0,r);c.Parent=o end
local function stroke(o,c,t)local s=Instance.new("UIStroke");s.Color=c;s.Transparency=t;s.Thickness=1;s.Parent=o end
local function create()
 if gui and gui.Parent then return end
 gui=Instance.new("ScreenGui");gui.Name="LanternVapeTargetHUD";gui.ResetOnSpawn=false;gui.IgnoreGuiInset=true;gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;gui.Parent=player:WaitForChild("PlayerGui")
 card=Instance.new("Frame");card.Name="TargetCard";card.AnchorPoint=Vector2.new(.5,0);card.Position=UDim2.new(.5,0,0,18);card.Size=UDim2.fromOffset(310,76);card.BackgroundColor3=Color3.fromRGB(8,8,8);card.BackgroundTransparency=.08;card.BorderSizePixel=0;card.Visible=false;card.ZIndex=10;card.Parent=gui;corner(card,8);stroke(card,Color3.fromRGB(220,115,35),.25)
 avatar=Instance.new("ImageLabel");avatar.Name="ProfileIcon";avatar.Size=UDim2.fromOffset(56,56);avatar.Position=UDim2.fromOffset(10,10);avatar.BackgroundColor3=Color3.fromRGB(21,21,21);avatar.BorderSizePixel=0;avatar.ZIndex=11;avatar.Parent=card;corner(avatar,28)
 displayName=Instance.new("TextLabel");displayName.Size=UDim2.new(1,-82,0,23);displayName.Position=UDim2.fromOffset(76,9);displayName.BackgroundTransparency=1;displayName.TextColor3=Color3.fromRGB(245,245,245);displayName.TextSize=14;displayName.Font=Enum.Font.GothamBold;displayName.TextXAlignment=Enum.TextXAlignment.Left;displayName.TextTruncate=Enum.TextTruncate.AtEnd;displayName.ZIndex=11;displayName.Parent=card
 username=Instance.new("TextLabel");username.Size=UDim2.new(1,-82,0,17);username.Position=UDim2.fromOffset(76,29);username.BackgroundTransparency=1;username.TextColor3=Color3.fromRGB(145,145,145);username.TextSize=10;username.Font=Enum.Font.Gotham;username.TextXAlignment=Enum.TextXAlignment.Left;username.ZIndex=11;username.Parent=card
 healthText=Instance.new("TextLabel");healthText.Size=UDim2.new(1,-82,0,16);healthText.Position=UDim2.fromOffset(76,47);healthText.BackgroundTransparency=1;healthText.TextColor3=Color3.fromRGB(220,115,35);healthText.TextSize=10;healthText.Font=Enum.Font.GothamSemibold;healthText.TextXAlignment=Enum.TextXAlignment.Left;healthText.ZIndex=11;healthText.Parent=card
 local bar=Instance.new("Frame");bar.Size=UDim2.fromOffset(120,5);bar.Position=UDim2.new(1,-130,1,-14);bar.BackgroundColor3=Color3.fromRGB(35,35,35);bar.BorderSizePixel=0;bar.ZIndex=11;bar.Parent=card;corner(bar,5)
 healthFill=Instance.new("Frame");healthFill.Size=UDim2.fromScale(1,1);healthFill.BackgroundColor3=Color3.fromRGB(220,115,35);healthFill.BorderSizePixel=0;healthFill.ZIndex=12;healthFill.Parent=bar;corner(healthFill,5)
end
local function target()local t=shared.LanternVapeAimTarget;if t and t.Parent==Players then return t end end
local function update(t)
 if not t then card.Visible=false;lastUserId=nil;return end
 local ch=t.Character;local hum=ch and ch:FindFirstChildOfClass("Humanoid");if not hum or hum.Health<=0 then card.Visible=false;return end
 if lastUserId~=t.UserId then lastUserId=t.UserId;local ok,img=pcall(function()return Players:GetUserThumbnailAsync(t.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)end);avatar.Image=ok and img or "" end
 displayName.Text=t.DisplayName;username.Text="@"..t.Name
 local max=math.max(hum.MaxHealth,1);local hp=math.max(hum.Health,0);healthText.Text=string.format("HP  %d / %d",math.floor(hp+.5),math.floor(max+.5));healthFill.Size=UDim2.fromScale(math.clamp(hp/max,0,1),1);card.Visible=true
end
function Target:SetEnabled(v)self.Enabled=v;if connection then connection:Disconnect();connection=nil end;create();if not v then card.Visible=false;return end;connection=RunService.RenderStepped:Connect(function()if self.Enabled then update(target())end end)end
return Target