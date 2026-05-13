-- [[ PRADAXCA - PROTECTED BY VIRTUAL ENCRYPTION ]] --
-- [[ VERSION: 2.1.0 | ANTI-REVERSE ENGINEERING ]] --

local _0x4c6f6164 = {
    _0x5253 = game:GetService("\101\103\112\108\105\99\97\116\101\100\83\116\111\114\97\103\101"),
    _0x56494d = game:GetService("\86\105\114\116\117\97\108\73\110\112\117\116\77\97\110\97\103\101\114"),
    _0x504c59 = game:GetService("\80\108\97\121\101\114\115").LocalPlayer
}

local _0x524d54 = {
    ["\102\49"] = "\67\104\97\114\103\101\70\105\115\104\105\110\103\82\111\100",
    ["\102\50"] = "\82\101\113\117\101\115\116\70\105\115\104\105\110\103\77\105\110\105\103\97\109\101\83\116\97\114\116\101\100",
    ["\102\51"] = "\67\97\116\99\104\70\105\115\104\67\111\109\112\108\101\116\101\100"
}

local _0x474c42 = { _0x5331 = false, _0x5332 = false, _0x5333 = false }

local function _0x5858(_0x76616c)
    local _0x6e6574 = require(_0x4c6f6164._0x5253:WaitForChild("\80\97\99\107\97\103\101\115"):WaitForChild("\78\101\116"))
    return _0x6e6574:RemoteFunction(_0x76616c)
end

-- UI PROTECTION LAYER
local _0x475549 = Instance.new("\83\99\114\101\101\110\71\117\105", game:GetService("\67\111\114\101\71\117\105"))
local _0x4d61696e = Instance.new("\70\114\97\109\101", _0x475549)
_0x4d61696e.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_0x4d61696e.Position = UDim2.new(0.5, -65, 0.5, -90)
_0x4d61696e.Size = UDim2.new(0, 130, 0, 180)
_0x4d61696e.Active = true
_0x4d61696e.Draggable = true
Instance.new("\85\73\67\111\114\110\101\114", _0x4d61696e).CornerRadius = UDim.new(0, 8)

local _0x546974 = Instance.new("\84\101\120\116\76\97\98\101\108", _0x4d61696e)
_0x546974.Size = UDim2.new(1, 0, 0, 30)
_0x546974.Text = "\80\82\65\68\65\88\67\65"
_0x546974.TextColor3 = Color3.fromRGB(0, 170, 255)
_0x546974.BackgroundTransparency = 1

local function _0x42746e(_0x747874, _0x706f73, _0x6362)
    local b = Instance.new("\84\101\120\116\66\117\116\116\111\110", _0x4d61696e)
    b.Size = UDim2.new(0.9, 0, 0, 30)
    b.Position = UDim2.new(0.05, 0, 0, _0x706f73)
    b.Text = _0x747874
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("\85\73\67\111\114\110\101\114", b).CornerRadius = UDim.new(0, 5)
    b.MouseButton1Click:Connect(function() _0x6362(b) end)
end

-- OBFUSCATED LOGIC EXECUTION
_0x42746e("\226\154\161 INSTANT", 40, function(s)
    _0x474c42._0x5331 = not _0x474c42._0x5331
    s.BackgroundColor3 = _0x474c42._0x5331 and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(30, 30, 30)
    task.spawn(function()
        while _0x474c42._0x5331 do
            pcall(function()
                local t = workspace:GetServerTimeNow()
                _0x5858(_0x524d54.f1):InvokeServer(nil,nil,t,nil)
                _0x5858(_0x524d54.f2):InvokeServer(0,1,t)
                task.wait(0.05)
                _0x5858(_0x524d54.f3):InvokeServer()
            end)
            task.wait(0.01)
        end
    end)
end)

_0x42746e("\240\159\155\161 SAFE V2", 75, function(s)
    _0x474c42._0x5332 = not _0x474c42._0x5332
    s.BackgroundColor3 = _0x474c42._0x5332 and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(30, 30, 30)
    task.spawn(function()
        while _0x474c42._0x5332 do
            pcall(function()
                local t = workspace:GetServerTimeNow()
                _0x5858(_0x524d54.f1):InvokeServer(nil,nil,t,nil)
                _0x5858(_0x524d54.f2):InvokeServer(0,0.4,t)
                task.wait(math.random(25,35)/10)
                _0x5858(_0x524d54.f3):InvokeServer()
            end)
            task.wait(0.5)
        end
    end)
end)

_0x42746e("\240\159\142\175 LEGIT", 110, function(s)
    _0x474c42._0x5333 = not _0x474c42._0x5333
    s.BackgroundColor3 = _0x474c42._0x5333 and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(30, 30, 30)
    task.spawn(function()
        while _0x474c42._0x5333 do
            local vs = workspace.CurrentCamera.ViewportSize
            _0x4c6f6164._0x56494d:SendMouseButtonEvent(vs.X/2, vs.Y/2, 0, true, game, 1)
            task.wait(0.05)
            _0x4c6f6164._0x56494d:SendMouseButtonEvent(vs.X/2, vs.Y/2, 0, false, game, 1)
            task.wait(math.random(100,150)/1000)
        end
    end)
end)

_0x42746e("\226\157\140 CLOSE", 145, function() _0x475549:Destroy() end)
