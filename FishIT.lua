-- [[ PRADAXCA CUSTOM PROTECTED EDITION ]] --
-- Hidden strings to bypass simple keyword scanners
local _0x1 = "ChargeFishingRod"
local _0x2 = "RequestFishingMinigameStarted"
local _0x3 = "CatchFishCompleted"

local S = game:GetService("ReplicatedStorage")
local N = require(S.Packages.Net)
local V = game:GetService("VirtualInputManager")
local P = game:GetService("Players").LocalPlayer

-- UI Construction (Custom & Draggable)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Holder = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "PX_" .. math.random(100,999)
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -60, 0.5, -80) -- منتصف الشاشة
MainFrame.Size = UDim2.new(0, 130, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true -- تفعيل السحب

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(60, 60, 60)
UIStroke.Thickness = 2

Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "PRADAXCA"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14

Holder.Parent = MainFrame
Holder.BackgroundTransparency = 1
Holder.Position = UDim2.new(0, 5, 0, 35)
Holder.Size = UDim2.new(1, -10, 1, -40)
Holder.CanvasSize = UDim2.new(0, 0, 1.2, 0)
Holder.ScrollBarThickness = 0

UIListLayout.Parent = Holder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Fishing Logic States
_G.S1 = false -- Instant
_G.S2 = false -- Safe
_G.S3 = false -- Legit

local function CreateButton(txt, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Font = Enum.Font.Gotham
    btn.Text = txt
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 12
    btn.AutoButtonColor = true
    btn.Parent = Holder
    
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        callback(btn)
    end)
    return btn
end

-- Function Logic with obfuscated calls
local function run_1() -- Instant
    task.spawn(function()
        while _G.S1 do
            pcall(function()
                local t = workspace:GetServerTimeNow()
                N:RemoteFunction(_0x1):InvokeServer(nil, nil, t, nil)
                N:RemoteFunction(_0x2):InvokeServer(0, 1, t)
                task.wait(0.05)
                if _G.S1 then N:RemoteFunction(_0x3):InvokeServer() end
            end)
            task.wait(0.01)
        end
    end)
end

local function run_2() -- Safe
    task.spawn(function()
        while _G.S2 do
            pcall(function()
                local t = workspace:GetServerTimeNow()
                N:RemoteFunction(_0x1):InvokeServer(nil, nil, t, nil)
                N:RemoteFunction(_0x2):InvokeServer(0, 0.3 + (math.random()*0.2), t)
                task.wait(math.random(20, 40) / 10)
                if _G.S2 then N:RemoteFunction(_0x3):InvokeServer() end
            end)
            task.wait(0.5)
        end
    end)
end

local function run_3() -- Legit
    task.spawn(function()
        local cam = workspace.CurrentCamera
        while _G.S3 do
            pcall(function()
                local vs = cam.ViewportSize
                local rx, ry = (vs.X/2)+math.random(-40,40), (vs.Y/2)+math.random(-40,40)
                V:SendMouseButtonEvent(rx, ry, 0, true, game, 1)
                task.wait(math.random(20,70)/1000)
                V:SendMouseButtonEvent(rx, ry, 0, false, game, 1)
            end)
            task.wait(math.random(80,150)/1000)
        end
    end)
end

-- Buttons Setup
CreateButton("⚡ INSTANT", function(self)
    _G.S1 = not _G.S1
    _G.S2, _G.S3 = false, false
    if _G.S1 then
        self.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        run_1()
    else
        self.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

CreateButton("🛡️ SAFE V2", function(self)
    _G.S2 = not _G.S2
    _G.S1, _G.S3 = false, false
    if _G.S2 then
        self.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        run_2()
    else
        self.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

CreateButton("🎯 LEGIT", function(self)
    _G.S3 = not _G.S3
    _G.S1, _G.S2 = false, false
    if _G.S3 then
        self.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        run_3()
    else
        self.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

CreateButton("❌ CLOSE", function()
    _G.S1, _G.S2, _G.S3 = false, false, false
    ScreenGui:Destroy()
end)

-- Notification
print("PRADAXCA Loaded Successfully")
