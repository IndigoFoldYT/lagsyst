-- LOAD SAFE
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- // SERVICES
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local setclipboard = setclipboard or print 

-- CLEAN UI
if CoreGui:FindFirstChild("RemoteProUI") then
    CoreGui.RemoteProUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "RemoteProUI"

-- MAIN FRAME
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 550)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -275)
MainFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)
MainFrame.BackgroundTransparency = 0.25
MainFrame.Active = true

Instance.new("UICorner", MainFrame)
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(0,170,255)
stroke.Transparency = 0.4

-- HEADER
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1,0,0,40)
Header.BackgroundTransparency = 0.3
Instance.new("UICorner", Header)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1,-40,1,0)
Title.Position = UDim2.new(0,15,0,0)
Title.Text = "REMOTE DEBUGGER PRO"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0,30,0,30)
CloseBtn.Position = UDim2.new(1,-35,0,5)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255,100,100)
CloseBtn.BackgroundTransparency = 1

-- SCROLL
local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1,-20,0,150)
Scroll.Position = UDim2.new(0,10,0,50)
Scroll.BackgroundTransparency = 0.6
Scroll.CanvasSize = UDim2.new()

local layout = Instance.new("UIListLayout", Scroll)
layout.Padding = UDim.new(0,5)

-- INPUT
local function input(name, y, placeholder)
    local box = Instance.new("TextBox", MainFrame)
    box.Size = UDim2.new(1,-20,0,35)
    box.Position = UDim2.new(0,10,0,y)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.BackgroundTransparency = 0.4
    box.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", box)
    return box
end

local Target = input("Target",210,"Nickname...")
local Args = input("Args",250,"Args...")

-- BUTTON
local function btn(text,y,color)
    local b = Instance.new("TextButton", MainFrame)
    b.Size = UDim2.new(1,-20,0,40)
    b.Position = UDim2.new(0,10,0,y)
    b.Text = text
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    return b
end

local FireBtn = btn("FIRE SELECTED",300,Color3.fromRGB(60,60,60))
local SpamBtn = btn("SPAM SELECTED",345,Color3.fromRGB(0,150,80))
local TextureBtn = btn("CHANGE TEXTURE",390,Color3.fromRGB(120,0,150))
local JumpscareBtn = btn("JUMPSCARE",435,Color3.fromRGB(200,0,0))

-- LOGIC
local selected
local remotes = {}

for _,v in pairs(game:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        table.insert(remotes,v)
        local b = Instance.new("TextButton", Scroll)
        b.Size = UDim2.new(1,0,0,40)
        b.Text = v.Name
        b.MouseButton1Click:Connect(function()
            selected = v
            Title.Text = "SELECTED: "..v.Name
        end)
    end
end

local function fire(r)
    if not r then return end
    pcall(function()
        r:FireServer(Target.Text, Args.Text)
    end)
end

FireBtn.MouseButton1Click:Connect(function()
    fire(selected)
end)

local spamming = false
SpamBtn.MouseButton1Click:Connect(function()
    spamming = not spamming
    while spamming do
        fire(selected)
        task.wait(0.1)
    end
end)

-- TEXTURE CHANGER
TextureBtn.MouseButton1Click:Connect(function()
    local tex = "rbxassetid://8210809484"
    for _,v in pairs(game:GetDescendants()) do
        if v:IsA("Texture") or v:IsA("Decal") then
            v.Texture = tex
        elseif v:IsA("MeshPart") then
            v.TextureID = tex
        end
    end
end)

-- JUMPSCARE
JumpscareBtn.MouseButton1Click:Connect(function()
    local gui = Instance.new("ScreenGui", CoreGui)
    local img = Instance.new("ImageLabel", gui)
    img.Size = UDim2.new(1,0,1,0)
    img.BackgroundTransparency = 1
    img.Image = "rbxassetid://8210809484"

    local sound = Instance.new("Sound", SoundService)
    sound.SoundId = "rbxassetid://9118828560"
    sound.Volume = 10
    sound:Play()

    task.wait(1)
    gui:Destroy()
end)

-- DRAG
local drag, pos, start
Header.InputBegan:Connect(function(i)
    if i.UserInputType.Name=="MouseButton1" then
        drag=true start=i.Position pos=MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if drag then
        local d=i.Position-start
        MainFrame.Position=UDim2.new(pos.X.Scale,pos.X.Offset+d.X,pos.Y.Scale,pos.Y.Offset+d.Y)
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType.Name=="MouseButton1" then drag=false end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)