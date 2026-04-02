-- // MODERN REMOTE DEBUGGER PRO (FULL SPAM ALL EDITION) // --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local setclipboard = setclipboard or print 

if CoreGui:FindFirstChild("RemoteProUI") then
    CoreGui.RemoteProUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RemoteProUI"
ScreenGui.Parent = CoreGui

-- // MAIN FRAME // --
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 500) -- Ukuran diperbesar sedikit untuk tombol baru
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BackgroundTransparency = 0.25
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Transparency = 0.4
UIStroke.Parent = MainFrame

-- // HEADER // --
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Header.BackgroundTransparency = 0.3
Header.BorderSizePixel = 0
Header.Parent = MainFrame
Instance.new("UICorner", Header)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "REMOTE DEBUGGER PRO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.BackgroundTransparency = 1
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.TextSize = 30
CloseBtn.BackgroundTransparency = 1
CloseBtn.Parent = Header

-- // SCROLLING LIST // --
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 0, 150)
ScrollFrame.Position = UDim2.new(0, 10, 0, 50)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ScrollFrame.BackgroundTransparency = 0.6
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 170, 255)
ScrollFrame.Parent = MainFrame
Instance.new("UICorner", ScrollFrame)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = ScrollFrame

-- // INPUT FIELDS // --
local function CreateInput(name, pos, placeholder, defaultText)
    local box = Instance.new("TextBox")
    box.Name = name
    box.Size = UDim2.new(1, -20, 0, 35)
    box.Position = pos
    box.PlaceholderText = placeholder
    box.Text = defaultText or ""
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    box.BackgroundTransparency = 0.4
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.Gotham
    box.TextSize = 13
    box.Parent = MainFrame
    Instance.new("UICorner", box)
    return box
end

local TargetInput = CreateInput("Target", UDim2.new(0, 10, 0, 210), "Nickname...", "VanceTamara9313")
local ArgsInput = CreateInput("Args", UDim2.new(0, 10, 0, 250), "Extra Args...", "")

-- // BUTTONS // --
local function CreateBtn(name, pos, size, color, text)
    local btn = Instance.new("TextButton")
    btn.Size = size
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.2
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Parent = MainFrame
    Instance.new("UICorner", btn)
    return btn
end

local TestBtn = CreateBtn("Test", UDim2.new(0, 10, 0, 300), UDim2.new(0, 145, 0, 35), Color3.fromRGB(60, 60, 60), "FIRE ONCE")
local CopyBtn = CreateBtn("Copy", UDim2.new(0, 165, 0, 300), UDim2.new(0, 145, 0, 35), Color3.fromRGB(0, 100, 200), "COPY CODE")
local SpamBtn = CreateBtn("Spam", UDim2.new(0, 10, 0, 345), UDim2.new(1, -20, 0, 40), Color3.fromRGB(0, 150, 80), "START SPAM SELECTED")
local SpamAllBtn = CreateBtn("SpamAll", UDim2.new(0, 10, 0, 395), UDim2.new(1, -20, 0, 45), Color3.fromRGB(120, 40, 0), "🔥 SPAM ALL REMOTES 🔥")

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 1, -20)
StatusLabel.Text = "Status: Idle"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextSize = 11
StatusLabel.Parent = MainFrame

-- // LOGIC // --
local selectedRemote = nil
local isSpamming = false
local isSpammingAll = false
local allRemotes = {}

local function fire(remote)
    if remote then
        local target = TargetInput.Text
        local extra = ArgsInput.Text
        local processedExtra = tonumber(extra) or extra
        
        if target ~= "" and extra ~= "" then
            remote:FireServer(target, processedExtra)
        elseif target ~= "" then
            remote:FireServer(target)
        else
            remote:FireServer()
        end
    end
end

local function refreshList()
    table.clear(allRemotes)
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            table.insert(allRemotes, v)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 45)
            btn.Text = "  " .. v.Name
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            btn.BackgroundTransparency = 0.5
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.Font = Enum.Font.SourceSansBold
            btn.TextSize = 18
            btn.Parent = ScrollFrame
            Instance.new("UICorner", btn)
            
            btn.MouseButton1Click:Connect(function()
                selectedRemote = v
                Title.Text = "SELECTED: " .. v.Name:upper()
                for _, other in pairs(ScrollFrame:GetChildren()) do
                    if other:IsA("TextButton") then other.BackgroundColor3 = Color3.fromRGB(45, 45, 45) end
                end
                btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            end)
        end
    end
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
end

-- // BUTTON EVENTS // --
TestBtn.MouseButton1Click:Connect(function()
    if selectedRemote then fire(selectedRemote) StatusLabel.Text = "Status: Fired Selected!" end
end)

SpamBtn.MouseButton1Click:Connect(function()
    if not selectedRemote then return end
    isSpamming = not isSpamming
    SpamBtn.Text = isSpamming and "STOP SPAM SELECTED" or "START SPAM SELECTED"
    SpamBtn.BackgroundColor3 = isSpamming and Color3.fromRGB(180, 50, 50) or Color3.fromRGB(0, 150, 80)
    
    task.spawn(function()
        while isSpamming and selectedRemote do
            fire(selectedRemote)
            task.wait(0.1)
        end
    end)
end)

SpamAllBtn.MouseButton1Click:Connect(function()
    isSpammingAll = not isSpammingAll
    SpamAllBtn.Text = isSpammingAll and "🛑 STOP SPAM ALL" or "🔥 SPAM ALL REMOTES 🔥"
    SpamAllBtn.BackgroundColor3 = isSpammingAll and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(120, 40, 0)
    
    if isSpammingAll then
        StatusLabel.Text = "Status: SPAMMING EVERYTHING!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        task.spawn(function()
            while isSpammingAll do
                for _, remote in pairs(allRemotes) do
                    if not isSpammingAll then break end
                    fire(remote)
                end
                task.wait(0.1)
            end
        end)
    else
        StatusLabel.Text = "Status: Idle"
        StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

CopyBtn.MouseButton1Click:Connect(function()
    if selectedRemote then
        local code = string.format('game:GetService("ReplicatedStorage").%s:FireServer("%s")', selectedRemote:GetFullName():gsub("ReplicatedStorage.", ""), TargetInput.Text)
        setclipboard(code)
        StatusLabel.Text = "Status: Code Copied!"
    end
end)

-- Dragging & Close
local dragStart, startPos, dragging
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true dragStart = input.Position startPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
CloseBtn.MouseButton1Click:Connect(function() isSpamming = false isSpammingAll = false ScreenGui:Destroy() end)

refreshList()