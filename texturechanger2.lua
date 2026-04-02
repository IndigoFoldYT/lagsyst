-- LOAD SAFE
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- SERVICES
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")

-- REMOVE OLD
if CoreGui:FindFirstChild("ChaosUI") then
    CoreGui.ChaosUI:Destroy()
end

-- UI
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "ChaosUI"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 260, 0, 180)
main.Position = UDim2.new(0.05, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.BackgroundTransparency = 0.2
main.Active = true
Instance.new("UICorner", main)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(255,0,0)
stroke.Thickness = 2

-- TITLE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,35)
title.Text = "CHAOS PANEL 😈"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 14

-- BUTTON MAKER
local function makeBtn(text, y, color)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(1,-20,0,40)
    b.Position = UDim2.new(0,10,0,y)
    b.Text = text
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b)
    return b
end

-- BUTTONS
local textureBtn = makeBtn("CHANGE TEXTURE",45,Color3.fromRGB(120,0,150))
local jumpBtn = makeBtn("JUMPSCARE",95,Color3.fromRGB(200,0,0))
local closeBtn = makeBtn("CLOSE",145,Color3.fromRGB(60,60,60))

-- TEXTURE
textureBtn.MouseButton1Click:Connect(function()
    local tex = "rbxassetid://98021102720473"

    for _,v in pairs(game:GetDescendants()) do
        if v:IsA("Texture") or v:IsA("Decal") then
            v.Texture = tex
        elseif v:IsA("MeshPart") then
            v.TextureID = tex
        elseif v:IsA("Part") then
            v.Material = Enum.Material.ForceField
            v.Color = Color3.fromRGB(255,0,0)
        end
    end

    Lighting.Ambient = Color3.new(1,0,0)
    Lighting.FogEnd = 60

    print("CHAOS TEXTURE 😈")
end)

-- JUMPSCARE
jumpBtn.MouseButton1Click:Connect(function()
    local jgui = Instance.new("ScreenGui", CoreGui)

    local img = Instance.new("ImageLabel", jgui)
    img.Size = UDim2.new(1,0,1,0)
    img.BackgroundTransparency = 1
    img.Image = "rbxassetid://98021102720473"

    local sound = Instance.new("Sound", SoundService)
    sound.SoundId = "rbxassetid://9118828560"
    sound.Volume = 10
    sound:Play()

    for i = 1,5 do
        img.ImageTransparency = math.random()
        task.wait(0.05)
    end

    task.wait(1)
    jgui:Destroy()
end)

-- CLOSE
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- DRAG
local drag, start, pos
title.InputBegan:Connect(function(i)
    if i.UserInputType.Name == "MouseButton1" then
        drag = true
        start = i.Position
        pos = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if drag then
        local delta = i.Position - start
        main.Position = UDim2.new(pos.X.Scale, pos.X.Offset + delta.X, pos.Y.Scale, pos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType.Name == "MouseButton1" then
        drag = false
    end
end)