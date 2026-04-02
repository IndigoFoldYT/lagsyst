-- GLOBAL CHAOS PANEL (SERVER SIDE)

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local texture = "rbxassetid://8210809484"

-- APPLY TEXTURE KE MAP
for _,v in pairs(game:GetDescendants()) do
    if v:IsA("Texture") or v:IsA("Decal") then
        v.Texture = texture

    elseif v:IsA("MeshPart") then
        v.TextureID = texture

    elseif v:IsA("Part") then
        v.Material = Enum.Material.ForceField
        v.Color = Color3.fromRGB(255,0,0)
    end
end

-- LIGHTING CHAOS
Lighting.Ambient = Color3.new(1,0,0)
Lighting.FogEnd = 60

-- JUMPSCARE KE SEMUA PLAYER
for _,player in pairs(Players:GetPlayers()) do
    local gui = Instance.new("ScreenGui")
    gui.Name = "Jumpscare"
    gui.Parent = player:WaitForChild("PlayerGui")

    local img = Instance.new("ImageLabel", gui)
    img.Size = UDim2.new(1,0,1,0)
    img.BackgroundTransparency = 1
    img.Image = texture

    task.delay(1, function()
        gui:Destroy()
    end)
end

print("GLOBAL CHAOS ACTIVE 😈")
