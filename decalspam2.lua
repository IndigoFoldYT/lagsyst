-- SERVER DECAL SPAM (LOADSTRING READY)

local msg = Instance.new("Message", workspace)
msg.Text = "Made By Ael 😈"
task.wait(3)
msg:Destroy()

-- SKY
local s = Instance.new("Sky")
s.Name = "SKY"
s.SkyboxBk = "rbxassetid://74351927319131"
s.SkyboxDn = "rbxassetid://74351927319131"
s.SkyboxFt = "rbxassetid://74351927319131"
s.SkyboxLf = "rbxassetid://74351927319131"
s.SkyboxRt = "rbxassetid://743519273191319"
s.SkyboxUp = "rbxassetid://74351927319131"
s.Parent = game.Lighting

-- SOUND
local Spooky = Instance.new("Sound", game.Workspace)
Spooky.SoundId = "rbxassetid://1839246711"
Spooky.Volume = 100
Spooky.Looped = true
Spooky:Play()

-- DECAL SPAM
local ID = 358313209

local function spamDecal(v)
    if v:IsA("Part") then
        for i = 0,5 do
            local D = Instance.new("Decal")
            D.Name = "SPAM"
            D.Face = i
            D.Parent = v
            D.Texture = "rbxassetid://"..ID
        end
    elseif v:IsA("Model") then
        for _,b in pairs(v:GetChildren()) do
            spamDecal(b)
        end
    end
end

for _,v in pairs(game.Workspace:GetDescendants()) do
    spamDecal(v)
end

print("DECAL SPAM DONE 😈")