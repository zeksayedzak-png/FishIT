-- سكريبت صيد Pradaxca المطور للجوال (Delta Executor)
repeat task.wait() until game:IsLoaded()

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Net = require(ReplicatedStorage.Packages.Net)
local VIM = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")

local ChargeFishingRod = Net:RemoteFunction('ChargeFishingRod')
local RequestFishingMinigame = Net:RemoteFunction('RequestFishingMinigameStarted')
local CatchFishCompleted = Net:RemoteFunction('CatchFishCompleted')

-- القيم الافتراضية (كلهم طافيين في البداية)
getgenv().InstantEnabled = false 
getgenv().InstantV2Enabled = false
getgenv().LegitEnabled = false

-- تنظيف الواجهة القديمة إذا وجدت
local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")
if CoreGui:FindFirstChild("PradaxcaMobile") then
    CoreGui.PradaxcaMobile:Destroy()
end

-- إنشاء الواجهة الأساسية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PradaxcaMobile"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 160, 0, 170) -- حجم صغير ومناسب للجوال
MainFrame.Position = UDim2.new(0.5, -80, 0.5, -85) -- في منتصف الشاشة
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- [نظام السحب بالإصبع للجوال]
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "PRADAXCA HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.Parent = MainFrame

-- دالة لإنشاء الأزرار الثلاثة
local function CreateBtn(name, text, yPos)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0.8, 0, 0, 35)
    btn.Position = UDim2.new(0.1, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- أحمر (مطفأ)
    btn.Text = text .. "\n[OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.Parent = MainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local Btn1 = CreateBtn("BtnInstant", "INSTANT FISH", 40)
local Btn2 = CreateBtn("BtnV2", "INSTANT V2", 80)
local Btn3 = CreateBtn("BtnLegit", "LEGIT TAP", 120)

-- وظيفة تحديث شكل الأزرار
local function UpdateUI()
    Btn1.BackgroundColor3 = getgenv().InstantEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    Btn1.Text = "INSTANT FISH\n" .. (getgenv().InstantEnabled and "[ON]" or "[OFF]")

    Btn2.BackgroundColor3 = getgenv().InstantV2Enabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    Btn2.Text = "INSTANT V2\n" .. (getgenv().InstantV2Enabled and "[ON]" or "[OFF]")

    Btn3.BackgroundColor3 = getgenv().LegitEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    Btn3.Text = "LEGIT TAP\n" .. (getgenv().LegitEnabled and "[ON]" or "[OFF]")
end

-- منطق العمليات (السكربت البرمجي)
local function runInstant()
    task.spawn(function()
        while getgenv().InstantEnabled do
            pcall(function()
                local T = workspace:GetServerTimeNow()
                ChargeFishingRod:InvokeServer(nil, nil, T, nil)
                RequestFishingMinigame:InvokeServer(0, 1, T)
                task.wait(0.1)
                CatchFishCompleted:InvokeServer()
            end)
            task.wait(0.2)
        end
    end)
end

local function runV2()
    task.spawn(function()
        while getgenv().InstantV2Enabled do
            pcall(function()
                local T = workspace:GetServerTimeNow()
                ChargeFishingRod:InvokeServer(nil, nil, T, nil)
                RequestFishingMinigame:InvokeServer(0, 0.4, T)
                task.wait(math.random(2, 4))
                CatchFishCompleted:InvokeServer()
            end)
            task.wait(0.5)
        end
    end)
end

local function runLegit()
    task.spawn(function()
        while getgenv().LegitEnabled do
            pcall(function()
                local x = math.random(200, 500)
                local y = math.random(200, 500)
                VIM:SendMouseButtonEvent(x, y, 0, true, game, 1)
                task.wait(0.05)
                VIM:SendMouseButtonEvent(x, y, 0, false, game, 1)
            end)
            task.wait(0.1)
        end
    end)
end

-- برمجة الضغط على الأزرار
Btn1.MouseButton1Click:Connect(function()
    getgenv().InstantEnabled = not getgenv().InstantEnabled
    if getgenv().InstantEnabled then
        getgenv().InstantV2Enabled = false
        getgenv().LegitEnabled = false
        runInstant()
    end
    UpdateUI()
end)

Btn2.MouseButton1Click:Connect(function()
    getgenv().InstantV2Enabled = not getgenv().InstantV2Enabled
    if getgenv().InstantV2Enabled then
        getgenv().InstantEnabled = false
        getgenv().LegitEnabled = false
        runV2()
    end
    UpdateUI()
end)

Btn3.MouseButton1Click:Connect(function()
    getgenv().LegitEnabled = not getgenv().LegitEnabled
    if getgenv().LegitEnabled then
        getgenv().InstantEnabled = false
        getgenv().InstantV2Enabled = false
        runLegit()
    end
    UpdateUI()
end)

UpdateUI()
