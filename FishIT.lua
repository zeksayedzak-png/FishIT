-- ================================================
-- 🎣 PRADAXCA - RAYFIELD EDITION
-- ⚡ INSTANT FISH + SAFE + LEGIT
-- 🔘 CIRCLE TOGGLE BUTTON
-- ================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local VIM = game:GetService("VirtualInputManager")

local ChargeFishingRod = Net:RemoteFunction('ChargeFishingRod')
local RequestFishingMinigame = Net:RemoteFunction('RequestFishingMinigameStarted')
local CatchFishCompleted = Net:RemoteFunction('CatchFishCompleted')

local getgenv = getgenv or function() return _G end

-- ================================================
-- 📊 المتغيرات
-- ================================================
getgenv().InstantEnabled = false
getgenv().InstantV2Enabled = false
getgenv().LegitEnabled = false

-- ================================================
-- 🎣 أنظمة الصيد الثلاثة (ORIGINAL - UNTOUCHED)
-- ================================================

local function startInstant()
    task.spawn(function()
        while getgenv().InstantEnabled do
            pcall(function()
                local Time = workspace:GetServerTimeNow()
                ChargeFishingRod:InvokeServer(nil, nil, Time, nil)
                RequestFishingMinigame:InvokeServer(0, 1, Time)
                task.wait(0.05)
                if getgenv().InstantEnabled then
                    CatchFishCompleted:InvokeServer()
                end
            end)
            task.wait(0.01)
        end
    end)
end

local function startInstantV2()
    task.spawn(function()
        while getgenv().InstantV2Enabled do
            pcall(function()
                local Time = workspace:GetServerTimeNow()
                ChargeFishingRod:InvokeServer(nil, nil, Time, nil)
                local safeLuck = 0.3 + (math.random() * 0.2)
                RequestFishingMinigame:InvokeServer(0, safeLuck, Time)
                local normalDelay = math.random(20, 40) / 10
                task.wait(normalDelay)
                if getgenv().InstantV2Enabled then
                    CatchFishCompleted:InvokeServer()
                end
            end)
            task.wait(0.5)
        end
    end)
end

local function startLegit()
    task.spawn(function()
        local camera = workspace.CurrentCamera
        while getgenv().LegitEnabled do
            pcall(function()
                local viewportSize = camera.ViewportSize
                local randomX = (viewportSize.X / 2) + math.random(-40, 40)
                local randomY = (viewportSize.Y / 2) + math.random(-40, 40)
                local holdTime = math.random(20, 70) / 1000
                VIM:SendMouseButtonEvent(randomX, randomY, 0, true, game, 1)
                task.wait(holdTime)
                VIM:SendMouseButtonEvent(randomX, randomY, 0, false, game, 1)
            end)
            local tapDelay = math.random(80, 150) / 1000
            task.wait(tapDelay)
        end
    end)
end

-- ================================================
-- 🔘 الدائرة البيضاء (Overlay Circle)
-- ================================================
local CircleOverlay = nil

local function CreateCircleOverlay()
    if CircleOverlay then return end
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "FishingCircle"
    gui.ResetOnSpawn = false
    gui.Parent = game:GetService("CoreGui")
    
    -- الدائرة البيضاء
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 80, 0, 80)
    circle.Position = UDim2.new(0.5, -40, 0.5, -40)
    circle.BackgroundTransparency = 1
    circle.BorderSizePixel = 0
    circle.Parent = gui
    
    local uiStroke = Instance.new("UIStroke", circle)
    uiStroke.Color = Color3.fromRGB(255, 255, 255)
    uiStroke.Thickness = 3
    
    local uiCorner = Instance.new("UICorner", circle)
    uiCorner.CornerRadius = UDim.new(1, 0)
    
    -- نقطة حمراء في المنتصف
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 6, 0, 6)
    dot.Position = UDim2.new(0.5, -3, 0.5, -3)
    dot.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    dot.BorderSizePixel = 0
    dot.Parent = circle
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    
    CircleOverlay = gui
end

local function RemoveCircleOverlay()
    if CircleOverlay then
        CircleOverlay:Destroy()
        CircleOverlay = nil
    end
end

local function ToggleCircle()
    if CircleOverlay then
        RemoveCircleOverlay()
    else
        CreateCircleOverlay()
    end
end

-- ================================================
-- 🎨 RAYFIELD UI
-- ================================================
local Window = Rayfield:CreateWindow({
    Name = "pradaxca",
    LoadingTitle = "pradaxca - Fishing Hub",
    LoadingSubtitle = "Instant | Safe | Legit",
    ConfigurationSaving = { Enabled = false },
    Discord = { Enabled = false },
    KeySystem = false
})

local MainTab = Window:CreateTab("Fishing", 4483362458)

MainTab:CreateParagraph({ Title = "Fishing Modes", Content = "Choose your fishing mode:" })

-- زر Instant
MainTab:CreateButton({
    Name = "⚡ Instant Fish",
    Callback = function()
        if getgenv().InstantEnabled then
            -- إيقاف
            getgenv().InstantEnabled = false
            Rayfield:Notify({ Title = "Instant Fish", Content = "OFF", Duration = 2, Image = 4483362458 })
        else
            -- تشغيل
            getgenv().InstantEnabled = true
            getgenv().InstantV2Enabled = false
            getgenv().LegitEnabled = false
            startInstant()
            Rayfield:Notify({ Title = "Instant Fish", Content = "ON - Fast mode!", Duration = 2, Image = 4483362458 })
        end
    end,
})

-- زر Safe
MainTab:CreateButton({
    Name = "🛡️ Instant v2 (Safe)",
    Callback = function()
        if getgenv().InstantV2Enabled then
            getgenv().InstantV2Enabled = false
            Rayfield:Notify({ Title = "Instant v2", Content = "OFF", Duration = 2, Image = 4483362458 })
        else
            getgenv().InstantV2Enabled = true
            getgenv().InstantEnabled = false
            getgenv().LegitEnabled = false
            startInstantV2()
            Rayfield:Notify({ Title = "Instant v2", Content = "ON - Safe mode!", Duration = 2, Image = 4483362458 })
        end
    end,
})

-- زر Legit
MainTab:CreateButton({
    Name = "🎯 Legit Fishing",
    Callback = function()
        if getgenv().LegitEnabled then
            getgenv().LegitEnabled = false
            Rayfield:Notify({ Title = "Legit Fishing", Content = "OFF", Duration = 2, Image = 4483362458 })
        else
            getgenv().LegitEnabled = true
            getgenv().InstantEnabled = false
            getgenv().InstantV2Enabled = false
            startLegit()
            Rayfield:Notify({ Title = "Legit Fishing", Content = "ON - Human mode!", Duration = 2, Image = 4483362458 })
        end
    end,
})

-- زر الدائرة
MainTab:CreateParagraph({ Title = "━━━━━━━━━━━━━━━━━━━━", Content = "" })

MainTab:CreateButton({
    Name = "🔘 Toggle Circle",
    Callback = function()
        ToggleCircle()
        if CircleOverlay then
            Rayfield:Notify({ Title = "Circle", Content = "Shown (White circle)", Duration = 2, Image = 4483362458 })
        else
            Rayfield:Notify({ Title = "Circle", Content = "Hidden", Duration = 2, Image = 4483362458 })
        end
    end,
})

MainTab:CreateParagraph({
    Title = "Info",
    Content = "⚡ Instant: 0.05s (Risky)\n🛡️ Safe: 2-4s (Undetected)\n🎯 Legit: Human-like (Safest)\n🔘 Circle: Toggle overlay"
})

print("\n" .. string.rep("🎣", 40))
print("🔥 PRADAXCA - RAYFIELD EDITION")
print("⚡ Instant | 🛡️ Safe | 🎯 Legit")
print("🔘 Circle Toggle Active")
print(string.rep("🎣", 40))
