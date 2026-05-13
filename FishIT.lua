local _0x1 = "ChargeFishingRod"
local _0x2 = "RequestFishingMinigameStarted"
local _0x3 = "CatchFishCompleted"

local function _0xSAFE_WAIT(min, max)
    task.wait(math.random(min * 100, max * 100) / 100)
end

-- الواجهة (GUI)
local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")
if CoreGui:FindFirstChild("PRADAXCA_V3") then CoreGui.PRADAXCA_V3:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PRADAXCA_V3"
ScreenGui.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 200, 0, 220)
Main.Position = UDim2.new(0.5, -100, 0.5, -110) -- في منتصف الشاشة
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true -- يعمل في معظم المحاكيات
Main.Parent = ScreenGui

-- إضافة انحناء للزوايا
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 15)
Corner.Parent = Main

-- نظام السحب بالإصبع (Manual Dragging) للجوال
local UIS = game:GetService("UserInputService")
local dragStart, startPos, dragging
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = Main.Position
    end
end)
Main.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "PRADAXCA V3 🛡️"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.Font = Enum.Font.GothamBlack
Title.BackgroundTransparency = 1
Title.TextSize = 16
Title.Parent = Main

-- متغيرات التحكم
getgenv().Config = { [1] = false, [2] = false, [3] = false }

local function CreateToggle(id, name, y)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.85, 0, 0, 40)
    btn.Position = UDim2.new(0.075, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = Main
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    btn.MouseButton1Click:Connect(function()
        for i=1,3 do if i ~= id then getgenv().Config[i] = false end end -- إيقاف البقية
        getgenv().Config[id] = not getgenv().Config[id]
        
        -- تحديث شكل الأزرار
        for i, v in pairs(Main:GetChildren()) do
            if v:IsA("TextButton") then
                v.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                v.Text = v.Text:gsub(": ON", ": OFF")
            end
        end
        
        if getgenv().Config[id] then
            btn.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
            btn.Text = name .. ": ON"
        end
    end)
end

CreateToggle(1, "INSTANT (RISKY)", 50)
CreateToggle(2, "SAFE MODE (V2)", 100)
CreateToggle(3, "LEGIT AUTO-TAP", 150)

-- المحرك الخلفي (Logic) المشفّر جزئياً
task.spawn(function()
    local Net = require(game:GetService("ReplicatedStorage").Packages.Net)
    while task.wait(0.1) do
        pcall(function()
            if getgenv().Config[1] then -- السريع
                local T = workspace:GetServerTimeNow()
                Net:RemoteFunction(_0x1):InvokeServer(nil, nil, T, nil)
                Net:RemoteFunction(_0x2):InvokeServer(0, 1, T)
                task.wait(0.05)
                Net:RemoteFunction(_0x3):InvokeServer()
            elseif getgenv().Config[2] then -- الآمن
                local T = workspace:GetServerTimeNow()
                Net:RemoteFunction(_0x1):InvokeServer(nil, nil, T, nil)
                Net:RemoteFunction(_0x2):InvokeServer(0, 0.5 + (math.random()*0.2), T)
                _0xSAFE_WAIT(2.5, 4.5) -- تأخير عشوائي بشري
                Net:RemoteFunction(_0x3):InvokeServer()
                _0xSAFE_WAIT(1, 2)
            elseif getgenv().Config[3] then -- ضغط تلقائي
                local x, y = math.random(300, 600), math.random(300, 600)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(x, y, 0, true, game, 1)
                task.wait(0.05)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(x, y, 0, false, game, 1)
                task.wait(math.random(1, 3) / 10)
            end
        end)
    end
end)
