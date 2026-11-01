local _0xC9DA ="1.7.0"local _0x108D = { _0xCBC4 = true, Background = true, NewCommands = true }local _0x8C6B ="malachiqx"local _0x180A = {
Discord ="https://discord.gg/mU7kUXnxbu",
NotifyStyles = {"Toast","Console","Toast + Console","Errors Only","Chime","Disabled"},
}local _0x0102 = game:GetService("Players")
local _0x6B8F = game:GetService("RunService")
local _0x22C9 = game:GetService("UserInputService")
local _0xB4AA = game:GetService("TweenService")
local _0x334A = game:GetService("Lighting")
local _0x0D1E = game:GetService("TeleportService")
local _0x92EE = game:GetService("HttpService")
local _0x5C9D = game:GetService("VirtualUser")
local _0x6AC8 = game:GetService("Stats")
local _0x8FFD = game:GetService("ContextActionService")
local _0x0F7F = _0x0102.LocalPlayer
local _0x1AC2 = _0x0F7F:WaitForChild("PlayerGui")if shared.MantleTerminate then
pcall(shared.MantleTerminate)
endlocal _0xB2A2 = {
writefile = writefile,
readfile = readfile,
isfile = isfile,
makefolder = makefolder,
isfolder = isfolder,
setclipboard = setclipboard or toclipboard,
request = request or http_request or (syn and syn.request),
gethui = gethui,
setfpscap = setfpscap,
}
local _0xCBD8 = typeof(_0xB2A2.writefile) =="function"and typeof(_0xB2A2.readfile) =="function"and typeof(_0xB2A2.isfile) =="function"local _0xA3E5 ="Mantle/config.json"local _0xEDE1 = os.clock()local _0x0625 = { Scripts = 0, Last = nil }local _0xDC63 = {}
local function _0x5951(signal, _0x3B2A)
local _0xED20 = signal:Connect(_0x3B2A)
table.insert(_0xDC63, _0xED20)
return _0xED20
end
local function _0x6A54(_0x8F94, _0x735B, props, _0x6CEC, dir)
local _0xD64B = _0xB4AA:Create(_0x8F94, TweenInfo.new(_0x735B, _0x6CEC or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out), props)
_0xD64B:Play()
return _0xD64B
end
local function _0xF0DD(_0x5C16, _0x2029, _0x3D2C)
return Color3.fromRGB(_0x5C16, _0x2029, _0x3D2C)
endlocal _0x110B = {
Reg = Enum.Font.SourceSans,
Med = Enum.Font.SourceSansSemibold,
Bold = Enum.Font.SourceSansBold,
Code = Enum.Font.Code,
}
local function _0x79E1(_0x1CA9)
return math.floor(_0x1CA9 * 1.12 + .5)
end
local function _0xE13E(_0x98DE)
_0x98DE = math.floor(_0x98DE)
return ("%d:%02d:%02d"):format(_0x98DE // 3600, (_0x98DE % 3600) // 60, _0x98DE % 60)
endlocal _0x1E9B, _0xFF7D = {}, Instance.new("BindableEvent")
local function _0x84A5(level, msg)
local _0xFE53 = { Time = os.date("%H:%M:%S"), Level = level, Msg = tostring(msg) }
table.insert(_0x1E9B, _0xFE53)
if #_0x1E9B > 400 then
table.remove(_0x1E9B, 1)
end
_0xFF7D:Fire(_0xFE53)
endlocal function _0xF51E()
local _0xED20 = _0x0F7F.Character
return _0xED20 and _0xED20:FindFirstChildOfClass("Humanoid")
end
local function _0x950D()
local _0xED20 = _0x0F7F.Character
return _0xED20 and _0xED20:FindFirstChild("HumanoidRootPart")
end
local function _0xA86D(_0xFB5A)
if not _0xFB5A or _0xFB5A ==""then
return nil
end
_0xFB5A = _0xFB5A:lower()
for _0x3AE9, _0xE0D1 in ipairs(_0x0102:GetPlayers()) do
if _0xE0D1.Name:lower() == _0xFB5A or _0xE0D1.DisplayName:lower() == _0xFB5A then
return _0xE0D1
end
end
for _0x3AE9, _0xE0D1 in ipairs(_0x0102:GetPlayers()) do
if _0xE0D1.Name:lower():sub(1, #_0xFB5A) == _0xFB5A or _0xE0D1.DisplayName:lower():sub(1, #_0xFB5A) == _0xFB5A then
return _0xE0D1
end
end
for _0x3AE9, _0xE0D1 in ipairs(_0x0102:GetPlayers()) do
if _0xE0D1.Name:lower():find(_0xFB5A, 1, true) or _0xE0D1.DisplayName:lower():find(_0xFB5A, 1, true) then
return _0xE0D1
end
end
return nil
end
local _0x112B
local function _0xEAAA()
if not _0x112B then
pcall(function()
_0x112B = _0x6AC8.Network.ServerStatsItem["Data Ping"]
end)
end
if _0x112B then
local _0xF74B, _0x97B0 = pcall(_0x112B.GetValue, _0x112B)
if _0xF74B and type(_0x97B0) =="number"and _0x97B0 > 0 then
return _0x97B0
end
if not _0xF74B then
_0x112B = nilend
end
local _0xF74B, _0xE0D1 = pcall(function()
return _0x0F7F:GetNetworkPing() * 2000
end)
return _0xF74B and _0xE0D1 or 0
endlocal _0x8F19 = {
["Dark"] = {
Bg = _0xF0DD(14, 14, 18), Surface = _0xF0DD(22, 22, 28), Surface2 = _0xF0DD(32, 32, 40), _0x1B3E = _0xF0DD(46, 46, 57),
Text = _0xF0DD(240, 240, 246), Sub = _0xF0DD(146, 146, 162), Accent = _0xF0DD(242, 124, 56), AccentText = _0xF0DD(255, 255, 255),
Good = _0xF0DD(84, 204, 126), Bad = _0xF0DD(238, 86, 86), Warn = _0xF0DD(240, 190, 70),
},
["Light"] = {
Bg = _0xF0DD(232, 234, 240), Surface = _0xF0DD(255, 255, 255), Surface2 = _0xF0DD(240, 242, 247), _0x1B3E = _0xF0DD(216, 220, 230),
Text = _0xF0DD(26, 28, 36), Sub = _0xF0DD(112, 116, 132), Accent = _0xF0DD(16, 124, 16), AccentText = _0xF0DD(255, 255, 255),
Good = _0xF0DD(40, 160, 90), Bad = _0xF0DD(212, 62, 62), Warn = _0xF0DD(206, 140, 20),
},
["Onyx"] = {
Bg = _0xF0DD(5, 5, 6), Surface = _0xF0DD(12, 12, 14), Surface2 = _0xF0DD(22, 22, 25), _0x1B3E = _0xF0DD(38, 38, 43),
Text = _0xF0DD(236, 236, 238), Sub = _0xF0DD(128, 128, 136), Accent = _0xF0DD(232, 232, 236), AccentText = _0xF0DD(8, 8, 10),
Good = _0xF0DD(96, 210, 130), Bad = _0xF0DD(240, 90, 90), Warn = _0xF0DD(240, 192, 80),
},
["Bone"] = {
Bg = _0xF0DD(226, 219, 204), Surface = _0xF0DD(240, 234, 221), Surface2 = _0xF0DD(229, 222, 207), _0x1B3E = _0xF0DD(206, 197, 178),
Text = _0xF0DD(56, 49, 40), Sub = _0xF0DD(128, 117, 100), Accent = _0xF0DD(150, 108, 66), AccentText = _0xF0DD(250, 245, 235),
Good = _0xF0DD(86, 130, 70), Bad = _0xF0DD(178, 70, 60), Warn = _0xF0DD(190, 140, 40),
},
["Catppuccin Frappe"] = {
Bg = _0xF0DD(41, 44, 60), Surface = _0xF0DD(48, 52, 70), Surface2 = _0xF0DD(65, 69, 89), _0x1B3E = _0xF0DD(81, 87, 109),
Text = _0xF0DD(198, 208, 245), Sub = _0xF0DD(165, 173, 206), Accent = _0xF0DD(202, 158, 230), AccentText = _0xF0DD(35, 38, 52),
Good = _0xF0DD(166, 209, 137), Bad = _0xF0DD(231, 130, 132), Warn = _0xF0DD(229, 200, 144),
},
["Catppuccin Mocha"] = {
Bg = _0xF0DD(30, 30, 46), Surface = _0xF0DD(36, 36, 54), Surface2 = _0xF0DD(49, 50, 68), _0x1B3E = _0xF0DD(69, 71, 90),
Text = _0xF0DD(205, 214, 244), Sub = _0xF0DD(166, 173, 200), Accent = _0xF0DD(203, 166, 247), AccentText = _0xF0DD(24, 24, 37),
Good = _0xF0DD(166, 227, 161), Bad = _0xF0DD(243, 139, 168), Warn = _0xF0DD(249, 226, 175),
},
["Catppuccin Latte"] = {
Bg = _0xF0DD(230, 233, 239), Surface = _0xF0DD(239, 241, 245), Surface2 = _0xF0DD(220, 224, 232), _0x1B3E = _0xF0DD(204, 208, 218),
Text = _0xF0DD(76, 79, 105), Sub = _0xF0DD(108, 111, 133), Accent = _0xF0DD(136, 57, 239), AccentText = _0xF0DD(255, 255, 255),
Good = _0xF0DD(64, 160, 43), Bad = _0xF0DD(210, 15, 57), Warn = _0xF0DD(223, 142, 29),
},
["Graphite"] = {
Bg = _0xF0DD(28, 30, 34), Surface = _0xF0DD(37, 40, 45), Surface2 = _0xF0DD(48, 52, 58), _0x1B3E = _0xF0DD(62, 66, 74),
Text = _0xF0DD(228, 231, 236), Sub = _0xF0DD(148, 154, 164), Accent = _0xF0DD(124, 164, 230), AccentText = _0xF0DD(14, 18, 26),
Good = _0xF0DD(120, 206, 150), Bad = _0xF0DD(236, 106, 106), Warn = _0xF0DD(232, 196, 100),
},
}
local _0x6F85 = {"Onyx","Dark","Light","Bone","Catppuccin Mocha","Catppuccin Frappe","Catppuccin Latte","Graphite"}
local _0x7870 = _0x8F19["Onyx"]local _0xE2B2 = {"Fly","Teleport Tool","Fullbright","Rejoin","Reset Character"}
local function _0x8484()
local _0x4240 = _0x22C9.TouchEnabled
return {
Performance = { Enabled = true, Pinned = not _0x4240 },
Keybinds = { Enabled = not _0x4240, Pinned = false },
_0xFA4B = { Enabled = false, Pinned = false },
_0x72F8 = { Enabled = false, Pinned = false },
_0x0102 = { Enabled = false, Pinned = false },
Misc = { Enabled = false, Pinned = false },
Credits = { Enabled = false, Pinned = false },
["Command Bar"] = { Enabled = true, Pinned = not _0x4240 },
["Command History"] = { Enabled = true, Pinned = false },
["Command List"] = { Enabled = false, Pinned = false },
}
end
local _0xA83C = 1local _0x8A1C = {
[0] = function(_0x5D96) return _0x5D96 end,}
local _0x7DB1 = {
_version = _0xA83C,
_0x7870 ="Onyx",
Keybind ="K",
NotifyStyle ="Toast",
Opacity = 1,
_0x0DFA = true,
_0x181D = _0x8484(),
MobileButton = _0x22C9.TouchEnabled,
QuickActions = table.clone(_0xE2B2),
_0xB400 ="",
BgOpacity = .4,
}local _0x3717 = {}
local function _0xE6AE(_0x8F94, prop, getter)
table.insert(_0x3717, { _0x8F94 = _0x8F94, prop = prop, get = getter })
_0x8F94[prop] = getter()
return function(_0x735B)
local _0x97B0 = getter()
if _0x735B and _0x735B > 0 then
_0x6A54(_0x8F94, _0x735B, { [prop] = _0x97B0 })
else
_0x8F94[prop] = _0x97B0
end
end
end
local function _0x8F68(_0x8F94, map)
local _0x9575 = {}
for prop, key in pairs(map) do
_0x9575[prop] = _0xE6AE(_0x8F94, prop, type(key) =="function"and key or function()
return _0x7870[key]
end)
end
return _0x9575
end
local function _0x7B63()
for _0x3A85 = #_0x3717, 1, -1 do
if not _0x3717[_0x3A85].inst.Parent then
table.remove(_0x3717, _0x3A85)
end
end
endlocal function _0xBBFC(class, props, children)
local _0x8F94 = Instance.new(class)
local _0x7824
for _0xB2C2, _0x97B0 in pairs(props or {}) do
if _0xB2C2 =="Parent"then
_0x7824 = _0x97B0
else
_0x8F94[_0xB2C2] = _0x97B0
end
end
for _0x3AE9, _0xED20 in ipairs(children or {}) do
_0xED20.Parent = _0x8F94
end
_0x8F94.Parent = _0x7824
return _0x8F94
end
local function _0xAC02(_0x8F94, _0x5C16)
return _0xBBFC("UICorner", { CornerRadius = UDim.new(0, _0x5C16), Parent = _0x8F94 })
end
local function _0xBB73(_0x8F94, _0x8372, _0x735B, _0x5C16, _0x3D2C)
return _0xBBFC("UIPadding", {
PaddingLeft = UDim.new(0, _0x8372 or 0), PaddingTop = UDim.new(0, _0x735B or 0),
PaddingRight = UDim.new(0, _0x5C16 or 0), PaddingBottom = UDim.new(0, _0x3D2C or 0), Parent = _0x8F94,
})
end
local function _0x126D(_0x8F94, pad, dir, ha, va)
return _0xBBFC("UIListLayout", {
Parent = _0x8F94, Padding = UDim.new(0, pad or 0),
FillDirection = dir or Enum.FillDirection.Vertical, SortOrder = Enum.SortOrder.LayoutOrder,
HorizontalAlignment = ha or Enum.HorizontalAlignment.Left,
VerticalAlignment = va or Enum.VerticalAlignment.Top,
})
end
local function _0x1B3E(_0x8F94, key, thickness)
local _0x98DE = _0xBBFC("UIStroke", { Parent = _0x8F94, Thickness = thickness or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
_0x8F68(_0x98DE, { Color = key or"Stroke"})
return _0x98DE
end
local function _0x8FFF(_0x7824, _0x6F81, bgKey, props)
local _0x2E83 = _0xBBFC("Frame", { Parent = _0x7824, Size = _0x6F81, BorderSizePixel = 0, BackgroundTransparency = bgKey and 0 or 1 })
for _0xB2C2, _0x97B0 in pairs(props or {}) do
_0x2E83[_0xB2C2] = _0x97B0
end
if bgKey then
_0x8F68(_0x2E83, { BackgroundColor3 = bgKey })
end
return _0x2E83
end
local function _0xA7CD(_0x7824, _0x1877, _0x6F81, font, colorKey, props)
local _0x8372 = _0xBBFC("TextLabel", {
Parent = _0x7824, BackgroundTransparency = 1, BorderSizePixel = 0, Text = _0x1877, TextSize = _0x79E1(_0x6F81),
Font = font, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, 0, 0, _0x6F81 + 4),
})
for _0xB2C2, _0x97B0 in pairs(props or {}) do
_0x8372[_0xB2C2] = _0x97B0
end
_0x8F68(_0x8372, { TextColor3 = colorKey })
return _0x8372
end
local function _0xBF78(_0x7824, _0x1877, _0x2802)
_0x2802 = _0x2802 or {}
local _0x0AAE = _0x2802.Variant or"Soft"local _0x3D2C = _0xBBFC("TextButton", {
Parent = _0x7824, Size = _0x2802.Size or UDim2.fromOffset(96, 32), Text = _0x1877, Font = _0x110B.Med,
TextSize = _0x79E1(_0x2802.TextSize or 13), AutoButtonColor = false, BorderSizePixel = 0,
TextTruncate = Enum.TextTruncate.AtEnd,
})
_0xAC02(_0x3D2C, 6)
if _0x2802.AutoX then
_0x3D2C.AutomaticSize = Enum.AutomaticSize.X
_0x3D2C.Size = UDim2.fromOffset(0, _0x2802.Height or 30)
_0xBB73(_0x3D2C, 14, 0, 14, 0)
end
local function _0x9B25()
return _0x0AAE =="Primary"or (_0x2802.Active and _0x2802.Active())
end
local function _0xF407()
if _0x9B25() then return _0x7870.Accent end
if _0x0AAE =="Danger"then return _0x7870.Bad end
return _0x7870.Surface2
end
local function _0xAC95()
if _0x9B25() then return _0x7870.AccentText end
if _0x0AAE =="Danger"then return Color3.new(1, 1, 1) end
return _0x7870.Text
end
local _0x9575 = _0x8F68(_0x3D2C, { BackgroundColor3 = _0xF407, TextColor3 = _0xAC95 })
_0x3D2C.MouseEnter:Connect(function()
_0x6A54(_0x3D2C, .12, { BackgroundColor3 = _0xF407():Lerp(_0x7870.Text, .10) })
end)
_0x3D2C.MouseLeave:Connect(function()
_0x6A54(_0x3D2C, .15, { BackgroundColor3 = _0xF407() })
end)
_0x3D2C.MouseButton1Down:Connect(function()
_0x6A54(_0x3D2C, .08, { BackgroundColor3 = _0xF407():Lerp(_0x7870.Text, .20) })
end)
_0x3D2C.MouseButton1Up:Connect(function()
_0x6A54(_0x3D2C, .12, { BackgroundColor3 = _0xF407():Lerp(_0x7870.Text, .10) })
end)
if _0x2802.OnClick then
_0x3D2C.MouseButton1Click:Connect(_0x2802.OnClick)
end
local function _0x920B()
_0x9575.BackgroundColor3(.18)
_0x9575.TextColor3(.18)
end
return _0x3D2C, _0x920B
end
local function _0x8776(_0x7824, default, onChange)
local _0xCA5B = default and true or false
local _0x4569 = _0xBBFC("TextButton", {
Parent = _0x7824, Size = UDim2.fromOffset(40, 22), Text ="", AutoButtonColor = false, BorderSizePixel = 0,
})
_0xAC02(_0x4569, 11)
local _0x8F3C = _0xBBFC("Frame", {
Parent = _0x4569, Size = UDim2.fromOffset(16, 16), BorderSizePixel = 0,
Position = _0xCA5B and UDim2.fromOffset(21, 3) or UDim2.fromOffset(3, 3),
})
_0xAC02(_0x8F3C, 8)
local _0x52C9 = _0x8F68(_0x4569, { BackgroundColor3 = function() return _0xCA5B and _0x7870.Accent or _0x7870.Stroke end }).BackgroundColor3
local _0xEC02 = _0x8F68(_0x8F3C, { BackgroundColor3 = function() return _0xCA5B and _0x7870.AccentText or _0x7870.Sub end }).BackgroundColor3
local function _0x8513(_0x97B0, silent)
_0xCA5B = _0x97B0 and true or false
_0x52C9(.18)
_0xEC02(.18)
_0x6A54(_0x8F3C, .18, { Position = _0xCA5B and UDim2.fromOffset(21, 3) or UDim2.fromOffset(3, 3) })
if not silent and onChange then
onChange(_0xCA5B)
end
end
_0x4569.MouseButton1Click:Connect(function()
_0x8513(not _0xCA5B)
end)
return _0x4569, _0x8513
end
local function _0xA73E(_0x7824, min, max, default, onChange, _0x02D0)
local _0x8DDA = _0x8FFF(_0x7824, UDim2.new(1, 0, 0, 20), nil)
local _0x4569 = _0xBBFC("Frame", {
Parent = _0x8DDA, Position = UDim2.new(0, 7, .5, -3), Size = UDim2.new(1, -14, 0, 6), BorderSizePixel = 0,
})
_0xAC02(_0x4569, 3)
local _0x9A78
if _0x02D0 then
_0x4569.BackgroundColor3 = Color3.new(1, 1, 1)
_0xBBFC("UIGradient", { Color = _0x02D0, Parent = _0x4569 })
else
_0x8F68(_0x4569, { BackgroundColor3 ="Stroke"})
_0x9A78 = _0x8FFF(_0x4569, UDim2.fromScale(0, 1),"Accent")
_0xAC02(_0x9A78, 3)
end
local _0x8F3C = _0xBBFC("Frame", {
Parent = _0x4569, AnchorPoint = Vector2.new(.5, .5), Size = UDim2.fromOffset(14, 14), BorderSizePixel = 0,
Position = UDim2.fromScale(0, .5),
})
_0xAC02(_0x8F3C, 7)
_0x8F68(_0x8F3C, { BackgroundColor3 ="Text"})
_0x1B3E(_0x8F3C,"Surface", 2)
local function _0x8513(_0x97B0, silent)
_0x97B0 = math.clamp(_0x97B0, min, max)
local _0xB7C5 = (_0x97B0 - min) / (max - min)
_0x8F3C.Position = UDim2.fromScale(_0xB7C5, .5)
if _0x9A78 then
_0x9A78.Size = UDim2.fromScale(_0xB7C5, 1)
end
if not silent and onChange then
onChange(_0x97B0)
end
end
_0x8513(default, true)
local _0x1E8A = false
local function _0x5A72(_0xC4BF)
local _0xB7C5 = math.clamp((_0xC4BF - _0x4569.AbsolutePosition.X) / math.max(_0x4569.AbsoluteSize.X, 1), 0, 1)
_0x8513(min + (max - min) * _0xB7C5)
end
_0x8DDA.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
_0x1E8A = true
_0x5A72(input.Position.X)
end
end)
_0x5951(_0x22C9.InputChanged, function(input)
if _0x1E8A and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
_0x5A72(input.Position.X)
end
end)
_0x5951(_0x22C9.InputEnded, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
_0x1E8A = false
end
end)
return _0x8DDA, _0x8513
end
local function _0x4C0A(_0x7824, placeholder, _0x6F81)
local _0x2E83 = _0x8FFF(_0x7824, _0x6F81 or UDim2.new(1, 0, 0, 34),"Surface2")
_0xAC02(_0x2E83, 6)
local _0x0A17 = _0x1B3E(_0x2E83,"Stroke")
local _0x5FEC = _0xBBFC("TextBox", {
Parent = _0x2E83, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.fromOffset(10, 0), Text ="", PlaceholderText = placeholder, Font = _0x110B.Reg, TextSize = _0x79E1(13),
TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false,
})
_0x8F68(_0x5FEC, { TextColor3 ="Text", PlaceholderColor3 ="Sub"})
_0x5FEC.Focused:Connect(function()
_0x6A54(_0x0A17, .15, { Color = _0x7870.Accent })
end)
_0x5FEC.FocusLost:Connect(function()
_0x6A54(_0x0A17, .15, { Color = _0x7870.Stroke })
end)
return _0x2E83, _0x5FEC
end
local function _0x50AA(_0x7824, _0x1877, solid)
local _0xE0D1 = _0x8FFF(_0x7824, UDim2.fromOffset(0, 22), solid and"Accent"or"Surface2", { AutomaticSize = Enum.AutomaticSize.X })
_0xAC02(_0xE0D1, 11)
_0xBB73(_0xE0D1, 10, 0, 10, 0)
_0xA7CD(_0xE0D1, _0x1877, 11, _0x110B.Med, solid and"AccentText"or"Sub", {
Size = UDim2.fromOffset(0, 22), AutomaticSize = Enum.AutomaticSize.X,
})
return _0xE0D1
end
local function _0x0012(_0x7824, title, order)
local _0x4D80 = _0x8FFF(_0x7824, UDim2.new(1, 0, 0, 0),"Surface", { AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = order or 0 })
_0xAC02(_0x4D80, 8)
_0x1B3E(_0x4D80)
_0xBB73(_0x4D80, 14, 12, 14, 14)
_0x126D(_0x4D80, 10)
if title then
_0xA7CD(_0x4D80, title, 14, _0x110B.Bold,"Text", { Size = UDim2.new(1, 0, 0, 18) })
end
return _0x4D80
end
local function _0x1937(_0x7824, order)
local _0xCCD3 = _0x8FFF(_0x7824, UDim2.new(1, 0, 0, 0), nil, { AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = order or 0 })
local _0x8372 = _0x126D(_0xCCD3, 8, Enum.FillDirection.Horizontal)
_0x8372.Wraps = true
return _0xCCD3
end
local function _0x253F(handle, _0xFCC2, onStart)
local _0x1E8A = false
local _0xE9E0, _0x2306
local _0x11AA, _0x6640, _0x9E9D, _0x4838 = 0, 0, 0, 0
local _0x2F1E
local function _0x7EED(dt)
if not _0xFCC2.Parent then
_0x2F1E:Disconnect()
_0x2F1E = nil
return
end
local _0xB7C5 = 1 - math.exp(-dt * 26)
_0x9E9D += (_0x11AA - _0x9E9D) * _0xB7C5
_0x4838 += (_0x6640 - _0x4838) * _0xB7C5
if not _0x1E8A and math.abs(_0x11AA - _0x9E9D) < .4 and math.abs(_0x6640 - _0x4838) < .4 then
_0x9E9D, _0x4838 = _0x11AA, _0x6640
_0x2F1E:Disconnect()
_0x2F1E = nil
end
_0xFCC2.Position = UDim2.new(_0xE9E0.X.Scale, _0x9E9D, _0xE9E0.Y.Scale, _0x4838)
end
handle.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
_0x1E8A, _0x2306, _0xE9E0 = true, input.Position, _0xFCC2.Position
_0x9E9D, _0x4838 = _0xE9E0.X.Offset, _0xE9E0.Y.Offset
_0x11AA, _0x6640 = _0x9E9D, _0x4838
if onStart then
onStart()
end
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
_0x1E8A = false
end
end)
end
end)
_0x5951(_0x22C9.InputChanged, function(input)
if _0x1E8A and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
local _0x5D96 = input.Position - _0x2306
_0x11AA, _0x6640 = _0xE9E0.X.Offset + _0x5D96.X, _0xE9E0.Y.Offset + _0x5D96.Y
if not _0x2F1E then
_0x2F1E = _0x6B8F.RenderStepped:Connect(_0x7EED)
end
end
end)
endlocal function _0xC6DD(_0x7824, _0x2A39, _0x6F81, _0x1CA9)
local _0x8DDA = _0x8FFF(_0x7824, _0x6F81,"Surface2", { Position = _0x2A39, ClipsDescendants = true })
_0xAC02(_0x8DDA, 4)
local _0x8E3C = {}
for _0x3A85 = 1, _0x1CA9 do
local _0x3D2C = _0xBBFC("Frame", {
Parent = _0x8DDA, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new((_0x3A85 - 1) / _0x1CA9, 0, 1, 0),
Size = UDim2.new(1 / _0x1CA9, -1, 0, 0), BorderSizePixel = 0,
})
_0x8F68(_0x3D2C, { BackgroundColor3 ="Accent"})
_0x8E3C[_0x3A85] = _0x3D2C
end
return function(hist, maxV)
local _0xE2B6 = _0x1CA9 - #hist
for _0x3A85 = 1, _0x1CA9 do
local _0x97B0 = hist[_0x3A85 - _0xE2B6]
_0x8E3C[_0x3A85].Size = UDim2.new(1 / _0x1CA9, -1, _0x97B0 and math.clamp(_0x97B0 / maxV, .04, 1) or 0, 0)
end
end
endlocal function _0xA3A4()
local _0xF74B, _0xCCD3 = pcall(function()
return _0xB2A2.gethui and _0xB2A2.gethui()
end)
if _0xF74B and _0xCCD3 then
return _0xCCD3
end
return _0x1AC2
end
local _0xC997 = _0xBBFC("ScreenGui", {
Name ="Mantle", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
IgnoreGuiInset = true, DisplayOrder = 999, Parent = _0xA3A4(),
})
local _0xAD00 = _0xBBFC("Frame", {
Name ="Toasts", Parent = _0xC997, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -18, 1, -18),
Size = UDim2.new(0, 290, 1, -36), BackgroundTransparency = 1, ZIndex = 100,
})
_0x126D(_0xAD00, 8, nil, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Bottom)
local _0x3FF0 = { _0x1CDB ="Accent", success ="Good", warn ="Warn", error ="Bad"}
local function _0x6DB0(title, msg, kind, force)
if not _0xC997.Parent then return endkind = kind or"info"local _0x6CEC = force and"Toast"or _0x7DB1.NotifyStyle or"Toast"if _0x6CEC =="Disabled"then return end
if _0x6CEC =="Console"or _0x6CEC =="Toast + Console"then
_0x84A5(kind, tostring(title) ..": ".. tostring(msg))
end
if _0x6CEC =="Console"then return end
if _0x6CEC =="Errors Only"and kind ~="warn"and kind ~="error"then return end
if _0x6CEC =="Chime"then
pcall(function()
local _0xF3A6 = Instance.new("Sound")
_0xF3A6.SoundId ="rbxasset://sounds/electronicpingshort.wav"_0xF3A6.Volume = .4
_0xF3A6.Parent = game:GetService("SoundService")
_0xF3A6:Play()
game:GetService("Debris"):AddItem(_0xF3A6, 3)
end)
end
_0x7B63()
local _0x1D10 = _0xBBFC("CanvasGroup", {
Parent = _0xAD00, Size = UDim2.fromOffset(290, 0), AutomaticSize = Enum.AutomaticSize.Y,
BorderSizePixel = 0, GroupTransparency = 1,
})
_0x8F68(_0x1D10, { BackgroundColor3 ="Surface"})
_0xAC02(_0x1D10, 8)
_0x1B3E(_0x1D10)
_0x8FFF(_0x1D10, UDim2.new(0, 3, 1, 0), _0x3FF0[kind] or"Accent")
local _0x8CE4 = _0x8FFF(_0x1D10, UDim2.new(1, 0, 0, 0), nil, { AutomaticSize = Enum.AutomaticSize.Y })
_0xBB73(_0x8CE4, 16, 9, 12, 10)
_0x126D(_0x8CE4, 2)
_0xA7CD(_0x8CE4, title, 13, _0x110B.Bold,"Text", { Size = UDim2.new(1, 0, 0, 16) })
_0xA7CD(_0x8CE4, tostring(msg), 12, _0x110B.Reg,"Sub", {
Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
})
local _0x6274 = _0xBBFC("UIScale", { Parent = _0x1D10, Scale = .92 })
_0x6A54(_0x1D10, .3, { GroupTransparency = 0 })
_0x6A54(_0x6274, .4, { Scale = 1 }, Enum.EasingStyle.Back)
task.delay(3.6, function()
if _0x1D10.Parent then
local _0xD64B = _0x6A54(_0x1D10, .35, { GroupTransparency = 1 })
_0xD64B.Completed:Connect(function()
_0x1D10:Destroy()
end)
end
end)
end
local function _0x08C4(_0x1877, what)
if _0xB2A2.setclipboard then
pcall(_0xB2A2.setclipboard, _0x1877)
_0x6DB0("Copied", what .." copied to clipboard","success")
else
_0x6DB0("Copy","Clipboard API unavailable in this environment","warn")
end
endlocal _0x72F8, _0xB283 = {}, {}
local _0xCE29 = {}local function _0x3714(_0x98DE)
return (_0x98DE:lower():gsub("%s+",""))
endlocal _0x5795, _0xBBAC = {}, Instance.new("BindableEvent")
local function _0xFD17(_0x1877, _0xF74B)
table.insert(_0x5795, { Time = os.date("%H:%M:%S"), Text = _0x1877, Ok = _0xF74B and true or false })
if #_0x5795 > 100 then
table.remove(_0x5795, 1)
end
_0xBBAC:Fire()
end
local function _0x79D4(def)
def.Values, def.Setters, def.Listeners, def.Enabled = {}, {}, {}, false
def.KeyListeners = {}
for _0x3AE9, inp in ipairs(def.Inputs or {}) do
def.Values[inp.Key] = inp.Default
end
table.insert(_0x72F8, def)
_0xB283[_0x3714(def.Name)] = def
for _0x3AE9, _0xB7C5 in ipairs(def.Aliases or {}) do
_0xB283[_0xB7C5] = def
end
end
local function _0xD9FD(_0x3CA5, state)
_0x3CA5.Enabled = state and true or false
for _0x3B2A in pairs(_0x3CA5.Listeners) do
_0x3B2A(_0x3CA5.Enabled)
end
end
local function _0xD168(_0x3CA5)
if _0x3CA5.Kind =="Toggle"then
local _0xFCC2 = not _0x3CA5.Enabled
local _0xF74B, _0x3D87 = pcall(_0x3CA5.Func, _0x3CA5, _0x3CA5.Values, _0xFCC2)
if _0xF74B then
_0xD9FD(_0x3CA5, _0xFCC2)
if _0xFCC2 then_0x0625.Scripts += 1
_0x0625.Last = _0x3CA5.Name
end
_0x84A5("success", _0x3CA5.Name .. (_0xFCC2 and" enabled"or" disabled"))
_0xFD17(_0x3CA5.Name .. (_0xFCC2 and"  ON"or"  OFF"), true)
_0x6DB0(_0x3CA5.Name, _0xFCC2 and"Enabled"or"Disabled", _0xFCC2 and"success"or"info")
else
_0x84A5("error", _0x3CA5.Name ..": ".. tostring(_0x3D87))
_0xFD17(_0x3CA5.Name .."  failed: ".. tostring(_0x3D87), false)
_0x6DB0(_0x3CA5.Name, tostring(_0x3D87),"error")
end
else
local _0xF74B, _0x3D87 = pcall(_0x3CA5.Func, _0x3CA5, _0x3CA5.Values)
if _0xF74B then
_0x0625.Scripts += 1
_0x0625.Last = _0x3CA5.Name
_0x84A5("success", _0x3CA5.Name .." executed")
_0xFD17(_0x3CA5.Name .."  run", true)
if not _0x3CA5.Silent then
_0x6DB0(_0x3CA5.Name,"Executed","success")
end
else
_0x84A5("error", _0x3CA5.Name ..": ".. tostring(_0x3D87))
_0xFD17(_0x3CA5.Name .."  failed: ".. tostring(_0x3D87), false)
_0x6DB0(_0x3CA5.Name, tostring(_0x3D87),"error")
end
end
end
local function _0x045B(_0x3CA5)
if _0x3CA5.Stop then
local _0xF74B, _0x3D87 = pcall(_0x3CA5.Stop, _0x3CA5, _0x3CA5.Values)
_0xD9FD(_0x3CA5, false)
if _0xF74B then
_0x84A5("info", _0x3CA5.Name .." stopped")
_0xFD17(_0x3CA5.Name .."  stopped", true)
_0x6DB0(_0x3CA5.Name,"Stopped","info")
else
_0x84A5("error", _0x3CA5.Name ..": ".. tostring(_0x3D87))
end
end
endlocal _0xA256, _0xC398 = {}, {}
local _0x08C9 = {
LeftShift ="LShift", RightShift ="RShift", LeftControl ="LCtrl", RightControl ="RCtrl",
LeftAlt ="LAlt", RightAlt ="RAlt", Return ="Enter", Backquote ="`", Minus ="-", Equals ="=",
LeftBracket ="[", RightBracket ="]", Semicolon =";", Slash ="/", Period =".",
Zero ="0", One ="1", Two ="2", Three ="3", Four ="4", Five ="5", Six ="6", Seven ="7", Eight ="8", Nine ="9",
}
local function _0x9AE5(_0x1CA9)
return _0x08C9[_0x1CA9] or _0x1CA9
end
local function _0xBEEE(_0x3CA5)
for _0x3B2A in pairs(_0x3CA5.KeyListeners) do
_0x3B2A(_0x3CA5.Key)
end
endlocal function _0x22C8(_0x3CA5, _0x6A18)
local _0xAF93
if _0x3CA5.Key then
_0xA256[_0x3CA5.Key] = nil
end
_0x3CA5.Key = nil
if _0x6A18 then
local _0x4A0F = _0xA256[_0x6A18]
if _0x4A0F and _0x4A0F ~= _0x3CA5 then
_0x4A0F.Key = nil
_0xA256[_0x6A18] = nil
_0xBEEE(_0x4A0F)
_0xAF93 = _0x4A0F
end
_0x3CA5.Key = _0x6A18
_0xA256[_0x6A18] = _0x3CA5
end
_0xBEEE(_0x3CA5)
for _0x3AE9, _0x3B2A in ipairs(_0xC398) do
pcall(_0x3B2A)
end
return _0xAF93
endlocal function _0x478A(_0x3CA5)
if _0x3CA5.Kind =="Run"and _0x3CA5.Stop and _0x3CA5.Enabled then
_0x045B(_0x3CA5)
else
_0xD168(_0x3CA5)
end
end
local _0x5075 = nil
local _0x2539 = _0xBBFC("TextLabel", {
Name ="BindHint", Parent = _0xC997, AnchorPoint = Vector2.new(.5, 1), Position = UDim2.new(.5, 0, 1, -120),
Size = UDim2.fromOffset(0, 34), AutomaticSize = Enum.AutomaticSize.X, Font = _0x110B.Med, TextSize = _0x79E1(14),
Text ="", Visible = false, BorderSizePixel = 0, ZIndex = 70,
})
_0x8F68(_0x2539, { BackgroundColor3 ="Surface", TextColor3 ="Text"})
_0xAC02(_0x2539, 8)
_0x1B3E(_0x2539,"Accent", 2)
_0xBB73(_0x2539, 14, 0, 14, 0)
local function _0x4602()
_0x5075 = nil
_0x2539.Visible = false
end
local function _0xB0B7(_0x3CA5)
_0x5075 = _0x3CA5
_0x2539.Text ="Press a key for ".. _0x3CA5.Name .."    ·    Esc cancel    ·    Backspace clear"_0x2539.Visible = true
end
local function _0xAB0C(kc)
local _0x3CA5 = _0x5075
if not _0x3CA5 then return end
if _0x7DB1.Keybind and kc.Name == _0x7DB1.Keybind then
_0x6DB0("Keybind","That key shows / hides Mantle","warn")
return
end
_0x4602()
if kc == Enum.KeyCode.Escape or kc == Enum.KeyCode.Unknown then return end
if kc == Enum.KeyCode.Backspace or kc == Enum.KeyCode.Delete then
_0x22C8(_0x3CA5, nil)
_0x6DB0(_0x3CA5.Name,"Keybind cleared","info")
return
end
local _0xAF93 = _0x22C8(_0x3CA5, kc.Name)
_0x84A5("info", _0x3CA5.Name .." bound to ".. kc.Name)
_0x6DB0(_0x3CA5.Name,"Bound to ".. _0x9AE5(kc.Name) .. (_0xAF93 and ("  (removed from ".. _0xAF93.Name ..")") or""),"success")
endlocal function _0x4590(prop, valueKey, extra)
local _0x5D46
local function _0x96C7()
if _0x5D46 then
_0x5D46:Disconnect()
_0x5D46 = nil
end
end
local function _0x3768(self, _0x97B0)
_0x96C7()
local _0x8303 = _0xF51E()
assert(_0x8303,"Humanoid not found")
if extra then
extra(_0x8303)
end
_0x5D46 = _0x6B8F.Heartbeat:Connect(function()
if not _0x8303.Parent or _0x8303.Health <= 0 then_0x96C7()
_0xD9FD(self, false)
_0x84A5("info", self.Name .." loop ended (character reset)")
return
end
_0x8303[prop] = _0x97B0[valueKey]
end)
_0xD9FD(self, true)
end
return _0x3768, _0x96C7
enddo
local _0x5D46, _0xC3F2, _0xF407
local function _0x96C7()
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
if _0xC3F2 then _0xC3F2:Destroy() _0xC3F2 = nil end
if _0xF407 then _0xF407:Destroy() _0xF407 = nil end
local _0xCCD3 = _0xF51E()
if _0xCCD3 then _0xCCD3.PlatformStand = false end
end
local function _0x4803(_0x97B0)
local _0x2E83 = Vector3.new(_0x97B0.X, 0, _0x97B0.Z)
if _0x2E83.Magnitude < 1e-3 then return nil end
return _0x2E83.Unit
end
_0x79D4({
Name ="Fly", Desc ="Free-fly. WASD / thumbstick to move, Space up, Ctrl down.", Kind ="Toggle", StopOnReset = true,
Inputs = { { _0x3714 ="Speed", _0xA7CD ="Fly speed", Type ="number", Default = 60, Min = 1, Max = 500 } },
Func = function(self, _0x97B0, state)
_0x96C7()
if not state then return end
local _0x10B0, _0x8303 = _0x950D(), _0xF51E()
assert(_0x10B0 and _0x8303,"Character not found")
_0xC3F2 = Instance.new("BodyVelocity")
_0xC3F2.MaxForce = Vector3.one * 1e9
_0xC3F2.Velocity = Vector3.zero
_0xC3F2.Parent = _0x10B0
_0xF407 = Instance.new("BodyGyro")
_0xF407.MaxTorque = Vector3.one * 1e9
_0xF407.P = 9e4
_0xF407.CFrame = _0x10B0.CFrame
_0xF407.Parent = _0x10B0
_0x8303.PlatformStand = true
local _0x46BB = Vector3.zero
_0x5D46 = _0x6B8F.RenderStepped:Connect(function(dt)
local _0x5C16, _0xCCD3, _0x0666 = _0x950D(), _0xF51E(), workspace.CurrentCamera
if not (_0x5C16 and _0xCCD3 and _0x0666 and _0xC3F2 and _0xC3F2.Parent) then_0x96C7()
_0xD9FD(self, false)
_0x84A5("info","Fly ended (character reset)")
return
end
local _0xC241 = _0x0666.CFrame
local _0xDB8C = _0xCCD3.MoveDirection
local _0x5961 = Vector3.zero
if _0xDB8C.Magnitude > 0 then
local _0x6F13 = _0x4803(_0xC241.LookVector) or _0x4803(_0xC241.UpVector)
local _0xBD6E = _0x4803(_0xC241.RightVector)
if _0x6F13 then _0x5961 += _0xC241.LookVector * _0xDB8C:Dot(_0x6F13) end
if _0xBD6E then _0x5961 += _0xC241.RightVector * _0xDB8C:Dot(_0xBD6E) end
end
if _0x22C9:IsKeyDown(Enum.KeyCode.Space) or _0x22C9:IsKeyDown(Enum.KeyCode.E) or _0xCCD3.Jump then
_0x5961 += Vector3.yAxis
end
if _0x22C9:IsKeyDown(Enum.KeyCode.LeftControl) or _0x22C9:IsKeyDown(Enum.KeyCode.Q) then
_0x5961 -= Vector3.yAxis
end
if _0x5961.Magnitude > 1 then _0x5961 = _0x5961.Unit end
_0x46BB = _0x46BB:Lerp(_0x5961 * _0x97B0.Speed, 1 - math.exp(-dt * 9))
_0xC3F2.Velocity = _0x46BB
_0xF407.CFrame = _0xF407.CFrame:Lerp(_0xC241, 1 - math.exp(-dt * 22))
end)
end,
Source =[==[
-- Fly (toggle)
local flySpeed = 60
local root = player.Character.HumanoidRootPart
local humanoid = player.Character:FindFirstChildOfClass("Humanoid")

local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.one * 1e9
bv.Parent = root

local bg = Instance.new("BodyGyro")
bg.MaxTorque = Vector3.one * 1e9
bg.P = 9e4
bg.Parent = root

humanoid.PlatformStand = true

RunService.RenderStepped:Connect(function()
    local cf = workspace.CurrentCamera.CFrame
    local move = humanoid.MoveDirection
    local vel = Vector3.zero

    if move.Magnitude > 0 then
        local fwd = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z).Unit
        local rgt = Vector3.new(cf.RightVector.X, 0, cf.RightVector.Z).Unit
        vel += cf.LookVector * move:Dot(fwd)
        vel += cf.RightVector * move:Dot(rgt)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) or humanoid.Jump then
        vel += Vector3.yAxis
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        vel -= Vector3.yAxis
    end

    if vel.Magnitude > 1 then vel = vel.Unit end
    bv.Velocity = vel * flySpeed
    bg.CFrame = cf
end)

-- To disable: disconnect the loop, destroy bv / bg,
-- and set humanoid.PlatformStand = false
]==],
})
enddo
local _0x3768, _0x96C7 = _0x4590("WalkSpeed","Speed")
_0x79D4({
Name ="Walkspeed", Desc ="Loops your WalkSpeed every frame. Ends on reset.", Kind ="Run", Aliases = {"ws","speed"},
Inputs = { { _0x3714 ="Speed", _0xA7CD ="Walkspeed", Type ="number", Default = 50, Min = 0, Max = 1000 } },
Silent = true,
Func = function(self, _0x97B0)
_0x3768(self, _0x97B0)
_0x6DB0("Walkspeed","Looping at ".. tostring(_0x97B0.Speed),"success")
end,
Stop = function(self)
_0x96C7()
local _0xCCD3 = _0xF51E()
if _0xCCD3 then _0xCCD3.WalkSpeed = 16 end
end,
Source =[==[
-- Walkspeed (loops until the character resets)
local speed = 50
local humanoid = player.Character:FindFirstChildOfClass("Humanoid")

local loop
loop = RunService.Heartbeat:Connect(function()
    -- stop once the character has reset
    if not humanoid.Parent or humanoid.Health <= 0 then
        loop:Disconnect()
        return
    end
    humanoid.WalkSpeed = speed
end)
]==],
})
enddo
local _0x3768, _0x96C7 = _0x4590("JumpPower","Power", function(_0xCCD3)
_0xCCD3.UseJumpPower = true
end)
_0x79D4({
Name ="Jumppower", Desc ="Loops your JumpPower every frame. Ends on reset.", Kind ="Run", Aliases = {"jp","jump"},
Inputs = { { _0x3714 ="Power", _0xA7CD ="Jump power", Type ="number", Default = 100, Min = 0, Max = 1000 } },
Silent = true,
Func = function(self, _0x97B0)
_0x3768(self, _0x97B0)
_0x6DB0("Jumppower","Looping at ".. tostring(_0x97B0.Power),"success")
end,
Stop = function(self)
_0x96C7()
local _0xCCD3 = _0xF51E()
if _0xCCD3 then _0xCCD3.JumpPower = 50 end
end,
Source =[==[
-- Jumppower (loops until the character resets)
local power = 100
local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
humanoid.UseJumpPower = true

local loop
loop = RunService.Heartbeat:Connect(function()
    if not humanoid.Parent or humanoid.Health <= 0 then
        loop:Disconnect()
        return
    end
    humanoid.JumpPower = power
end)
]==],
})
enddo
local _0x5D46
_0x79D4({
Name ="Infinite Jump", Desc ="Jump again while in mid-air.", Kind ="Toggle", Aliases = {"infjump","ij"},
Func = function(self, _0x97B0, state)
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
if state then
_0x5D46 = _0x22C9.JumpRequest:Connect(function()
local _0xCCD3 = _0xF51E()
if _0xCCD3 then _0xCCD3:ChangeState(Enum.HumanoidStateType.Jumping) end
end)
end
end,
Source =[==[
-- Infinite Jump (toggle)
local conn = UserInputService.JumpRequest:Connect(function()
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- To disable: conn:Disconnect()
]==],
})
end_0x79D4({
Name ="Teleport Tool", Desc ="Gives you a tool that teleports you where you click.", Kind ="Run", Aliases = {"tptool"},
Silent = true,
Func = function(self)
self.Cleanup(self)
local _0xC252 = Instance.new("Tool")
_0xC252.Name ="Teleport Tool"_0xC252.RequiresHandle = false
_0xC252.CanBeDropped = false
_0xC252.ToolTip ="Click to teleport"_0xC252.Activated:Connect(function()
local _0x5C16 = _0x950D()
if _0x5C16 then
local _0x2A39 = _0x0F7F:GetMouse().Hit.Position + Vector3.new(0, 3, 0)
_0x5C16.CFrame = CFrame.new(_0x2A39) * (_0x5C16.CFrame - _0x5C16.CFrame.Position)
end
end)
_0xC252.Parent = _0x0F7F:WaitForChild("Backpack")
_0x6DB0("Teleport Tool","Added to your backpack","success")
end,
Cleanup = function()
for _0x3AE9, _0xED20 in ipairs({ _0x0F7F:FindFirstChild("Backpack"), _0x0F7F.Character }) do
local _0x735B = _0xED20 and _0xED20:FindFirstChild("Teleport Tool")
if _0x735B then _0x735B:Destroy() end
end
end,
Source =[==[
-- Teleport Tool
local tool = Instance.new("Tool")
tool.Name = "Teleport Tool"
tool.RequiresHandle = false
tool.CanBeDropped = false

tool.Activated:Connect(function()
    local root = player.Character.HumanoidRootPart
    local target = player:GetMouse().Hit.Position + Vector3.new(0, 3, 0)
    root.CFrame = CFrame.new(target) * (root.CFrame - root.CFrame.Position)
end)

tool.Parent = player.Backpack
]==],
})_0x79D4({
Name ="Teleport To", Desc ="Teleport to a player you pick from the list.", Kind ="Run", Aliases = {"tpto","goto","tp"},
Inputs = { { _0x3714 ="Target", _0xA7CD ="Player", Type ="player"} },
Func = function(self, _0x97B0)
local _0xFCC2 = _0xA86D(_0x97B0.Target)
assert(_0xFCC2,"Select a player first")
local _0xB184 = _0xFCC2.Character and _0xFCC2.Character:FindFirstChild("HumanoidRootPart")
assert(_0xB184, _0xFCC2.Name .." has no character")
local _0x5C16 = _0x950D()
assert(_0x5C16,"Character not found")
_0x5C16.CFrame = _0xB184.CFrame * CFrame.new(0, 0, 3)
end,
Source =[==[
-- Teleport To
local target = Players:FindFirstChild("PlayerName")
local targetRoot = target.Character.HumanoidRootPart
local myRoot = player.Character.HumanoidRootPart

-- land just behind them
myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
]==],
})do
local _0x5D46
local function _0xA281()
if _0x5D46 then
_0x5D46:Disconnect()
_0x5D46 = nil
end
local _0xCCD3, _0x0666 = _0xF51E(), workspace.CurrentCamera
if _0xCCD3 and _0x0666 then
_0x0666.CameraSubject = _0xCCD3
end
end
_0x79D4({
Name ="Spectate", Desc ="Watch another player through your camera. Stop returns you.", Kind ="Run", Aliases = {"spec","view"},
Inputs = { { _0x3714 ="Target", _0xA7CD ="Player", Type ="player"} },
Silent = true,
Func = function(self, _0x97B0)
local _0xFCC2 = _0xA86D(_0x97B0.Target)
assert(_0xFCC2,"Select a player first")
assert(_0xFCC2.Character and _0xFCC2.Character:FindFirstChildOfClass("Humanoid"), _0xFCC2.Name .." has no character")
if _0x5D46 then
_0x5D46:Disconnect()
_0x5D46 = nil
end
local _0x6A18 = _0xFCC2.Name
_0x5D46 = _0x6B8F.RenderStepped:Connect(function()
local _0x0666 = workspace.CurrentCamera
local _0xE0D1 = _0x0102:FindFirstChild(_0x6A18)
if not _0xE0D1 then
_0xA281()
_0xD9FD(self, false)
_0x84A5("info","Spectate ended (".. _0x6A18 .." left)")
_0x6DB0("Spectate", _0x6A18 .." left the game","info")
return
end
local _0x7E14 = _0xE0D1.Character and _0xE0D1.Character:FindFirstChildOfClass("Humanoid")
if _0x7E14 and _0x0666 and _0x0666.CameraSubject ~= _0x7E14 then
_0x0666.CameraSubject = _0x7E14
end
end)
_0xD9FD(self, true)
_0x6DB0("Spectate","Watching ".. _0xFCC2.DisplayName,"success")
end,
Stop = function()
_0xA281()
end,
Source =[==[
-- Spectate
local target = Players:FindFirstChild("PlayerName")
local cam = workspace.CurrentCamera

-- keep the camera on their humanoid (it changes when they respawn)
local loop = RunService.RenderStepped:Connect(function()
    local humanoid = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
    if humanoid and cam.CameraSubject ~= humanoid then
        cam.CameraSubject = humanoid
    end
end)

-- To stop: loop:Disconnect(), then
-- cam.CameraSubject = player.Character.Humanoid
]==],
})
enddo
local _0x840E ="MantleFreecam"local _0xCE20, _0x16A1, _0x7A1C = nil, {}, false
local function _0x6F3D()
pcall(function() _0x6B8F:UnbindFromRenderStep(_0x840E) end)
pcall(function() _0x8FFD:UnbindAction(_0x840E) end)
for _0x3AE9, _0xED20 in ipairs(_0x16A1) do
_0xED20:Disconnect()
end
table.clear(_0x16A1)
_0x7A1C = false
_0x22C9.MouseBehavior = Enum.MouseBehavior.Default
if _0xCE20 then
local _0x0666 = workspace.CurrentCamera
if _0xCE20.Root and _0xCE20.Root.Parent then
_0xCE20.Root.Anchored = _0xCE20.Anchored
end
if _0x0666 thenlocal _0x36BF = _0xF51E()
if not _0x36BF and _0xCE20.Subject and _0xCE20.Subject.Parent then
_0x36BF = _0xCE20.Subject
end
if _0x36BF then _0x0666.CameraSubject = _0x36BF end
_0x0666.CameraType = (_0xCE20.Type == Enum.CameraType.Scriptable) and Enum.CameraType.Custom or _0xCE20.Type
end
_0xCE20 = nil
end
end
_0x79D4({
Name ="Freecam", Desc ="Detach the camera and fly it around. Hold right mouse to look, WASD + Q/E, Shift = fast.", Kind ="Toggle", StopOnReset = true,
Aliases = {"fc"},
Inputs = {
{ _0x3714 ="Speed", _0xA7CD ="Camera speed", Type ="number", Default = 40, Min = 1, Max = 500 },
{ _0x3714 ="Sensitivity", _0xA7CD ="Look sensitivity", Type ="number", Default = 1, Min = .1, Max = 10 },
},
Func = function(self, _0x97B0, state)
_0x6F3D()
if not state then return end
local _0x0666 = workspace.CurrentCamera
assert(_0x0666,"Camera not found")
local _0x10B0 = _0x950D()
_0xCE20 = { Type = _0x0666.CameraType, Subject = _0x0666.CameraSubject, _0x950D = _0x10B0, Anchored = _0x10B0 and _0x10B0.Anchored or false }
if _0x10B0 then
_0x10B0.Anchored = trueend
_0x0666.CameraType = Enum.CameraType.Scriptable
local _0x9B21, _0x6348 = _0x0666.CFrame:ToEulerAnglesYXZ()
local _0x010B, _0xA73F = _0x9B21, _0x6348
local _0x2A39 = _0x0666.CFrame.Position
local _0x5961 = Vector3.zero
local _0xD16E = Enum.KeyCode_0x8FFD:BindActionAtPriority(_0x840E, function()
return Enum.ContextActionResult.Sink
end, false, Enum.ContextActionPriority.High.Value,
_0xD16E.W, _0xD16E.A, _0xD16E.S, _0xD16E.D, _0xD16E.Q, _0xD16E.E, _0xD16E.Space, _0xD16E.Up, _0xD16E.Down, _0xD16E.Left, _0xD16E.Right)
table.insert(_0x16A1, _0x22C9.InputBegan:Connect(function(_0x3A85, gp)
if not gp and _0x3A85.UserInputType == Enum.UserInputType.MouseButton2 then
_0x7A1C = true
end
end))
table.insert(_0x16A1, _0x22C9.InputEnded:Connect(function(_0x3A85)
if _0x3A85.UserInputType == Enum.UserInputType.MouseButton2 then
_0x7A1C = false
end
end))
table.insert(_0x16A1, _0x22C9.TouchMoved:Connect(function(_0x3A85, gp)
if gp then return end
_0xA73F -= _0x3A85.Delta.X * .006 * _0x97B0.Sensitivity
_0x010B = math.clamp(_0x010B - _0x3A85.Delta.Y * .006 * _0x97B0.Sensitivity, -1.55, 1.55)
end))
local function _0x7855(_0xB2C2)
return _0x22C9:IsKeyDown(_0xB2C2)
end
_0x6B8F:BindToRenderStep(_0x840E, Enum.RenderPriority.Camera.Value + 1, function(dt)
local _0xED20 = workspace.CurrentCamera
if not _0xED20 then return end
if _0xCE20 and _0xCE20.Root and not _0xCE20.Root.Parent then_0x6F3D()
_0xD9FD(self, false)
_0x84A5("info","Freecam ended (character reset)")
return
end
if _0xED20.CameraType ~= Enum.CameraType.Scriptable then
_0xED20.CameraType = Enum.CameraType.Scriptable
end
if _0x7A1C then
_0x22C9.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
local _0x5D96 = _0x22C9:GetMouseDelta()
_0xA73F -= _0x5D96.X * .003 * _0x97B0.Sensitivity
_0x010B = math.clamp(_0x010B - _0x5D96.Y * .003 * _0x97B0.Sensitivity, -1.55, 1.55)
elseif _0x22C9.MouseBehavior ~= Enum.MouseBehavior.Default then
_0x22C9.MouseBehavior = Enum.MouseBehavior.Default
end
local _0xB7C5 = 1 - math.exp(-dt * 30)
_0x9B21 += (_0x010B - _0x9B21) * _0xB7C5
_0x6348 += (_0xA73F - _0x6348) * _0xB7C5
local _0xC241 = CFrame.new(_0x2A39) * CFrame.fromEulerAnglesYXZ(_0x9B21, _0x6348, 0)
local _0xDB8C = Vector3.zero
if _0x7855(_0xD16E.W) or _0x7855(_0xD16E.Up) then _0xDB8C += _0xC241.LookVector end
if _0x7855(_0xD16E.S) or _0x7855(_0xD16E.Down) then _0xDB8C -= _0xC241.LookVector end
if _0x7855(_0xD16E.D) or _0x7855(_0xD16E.Right) then _0xDB8C += _0xC241.RightVector end
if _0x7855(_0xD16E.A) or _0x7855(_0xD16E.Left) then _0xDB8C -= _0xC241.RightVector end
if _0x7855(_0xD16E.E) or _0x7855(_0xD16E.Space) then _0xDB8C += Vector3.yAxis end
if _0x7855(_0xD16E.Q) or _0x7855(_0xD16E.LeftControl) then _0xDB8C -= Vector3.yAxis end
local _0xCCD3 = _0xF51E()
if _0xCCD3 thenlocal _0x1052 = _0xCCD3.MoveDirection
if _0x1052.Magnitude > 0 then
local _0x107B = _0xC241:VectorToObjectSpace(_0x1052)
local _0x4803 = Vector3.new(_0x107B.X, 0, _0x107B.Z)
if _0x4803.Magnitude > 1e-3 then
_0xDB8C += _0xC241:VectorToWorldSpace(_0x4803.Unit * _0x1052.Magnitude)
end
end
if _0xCCD3.Jump then _0xDB8C += Vector3.yAxis end
end
if _0xDB8C.Magnitude > 1 then _0xDB8C = _0xDB8C.Unit end
local _0xB5DC = _0x97B0.Speed * (_0x7855(_0xD16E.LeftShift) and 3 or 1)
_0x5961 = _0x5961:Lerp(_0xDB8C * _0xB5DC, 1 - math.exp(-dt * 10))
_0x2A39 += _0x5961 * dt
_0xED20.CFrame = CFrame.new(_0x2A39) * CFrame.fromEulerAnglesYXZ(_0x9B21, _0x6348, 0)
end)
end,
Source =[==[
-- Freecam (toggle)
local cam = workspace.CurrentCamera
cam.CameraType = Enum.CameraType.Scriptable
player.Character.HumanoidRootPart.Anchored = true -- keep your character still

local pos = cam.CFrame.Position
local pitch, yaw = cam.CFrame:ToEulerAnglesYXZ()
local speed = 40

RunService:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value + 1, function(dt)
    -- hold right mouse to look around
    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
        local d = UserInputService:GetMouseDelta()
        yaw -= d.X * 0.003
        pitch = math.clamp(pitch - d.Y * 0.003, -1.55, 1.55)
    else
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end

    local cf = CFrame.new(pos) * CFrame.fromEulerAnglesYXZ(pitch, yaw, 0)
    local move = Vector3.zero
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cf.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cf.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cf.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cf.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.E) then move += Vector3.yAxis end
    if UserInputService:IsKeyDown(Enum.KeyCode.Q) then move -= Vector3.yAxis end

    pos += move * speed * dt
    cam.CFrame = CFrame.new(pos) * CFrame.fromEulerAnglesYXZ(pitch, yaw, 0)
end)

-- To disable: RunService:UnbindFromRenderStep("Freecam"), set
-- cam.CameraType back to Custom and unanchor the root part
]==],
})
enddo
local _0x5D46
_0x79D4({
Name ="FOV", Desc ="Sets your camera field of view. Stop restores 70.", Kind ="Run",
Inputs = { { _0x3714 ="Value", _0xA7CD ="Field of view", Type ="number", Default = 100, Min = 1, Max = 120 } },
Silent = true,
Func = function(self, _0x97B0)
if _0x5D46 then _0x5D46:Disconnect() end
_0x5D46 = _0x6B8F.RenderStepped:Connect(function()
local _0x0666 = workspace.CurrentCamera
if _0x0666 then _0x0666.FieldOfView = _0x97B0.Value end
end)
_0xD9FD(self, true)
_0x6DB0("FOV","Set to ".. tostring(_0x97B0.Value),"success")
end,
Stop = function()
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
if workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView = 70 end
end,
Source =[==[
-- FOV (loops so the game can't change it back)
local fov = 100
local conn = RunService.RenderStepped:Connect(function()
    workspace.CurrentCamera.FieldOfView = fov
end)

-- To stop: conn:Disconnect() and set FieldOfView back to 70
]==],
})
end_0x79D4({
Name ="Gravity", Desc ="Changes workspace gravity. Stop restores 196.2.", Kind ="Run", Aliases = {"grav"},
Inputs = { { _0x3714 ="Value", _0xA7CD ="Gravity", Type ="number", Default = 50, Min = 0, Max = 500 } },
Silent = true,
Func = function(self, _0x97B0)
workspace.Gravity = _0x97B0.Value
_0xD9FD(self, true)
_0x6DB0("Gravity","Set to ".. tostring(_0x97B0.Value),"success")
end,
Stop = function()
workspace.Gravity = 196.2
end,
Source =[==[
-- Gravity
workspace.Gravity = 50

-- To restore: workspace.Gravity = 196.2
]==],
})do
local _0x5D46, _0x0BC7
_0x79D4({
Name ="Fullbright", Desc ="Removes darkness and fog. Restores on disable.", Kind ="Toggle", Aliases = {"fb"},
Func = function(self, _0x97B0, state)
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
if state then
_0x0BC7 = _0x0BC7 or {
Brightness = _0x334A.Brightness, ClockTime = _0x334A.ClockTime, FogEnd = _0x334A.FogEnd,
GlobalShadows = _0x334A.GlobalShadows, Ambient = _0x334A.Ambient, OutdoorAmbient = _0x334A.OutdoorAmbient,
}
_0x5D46 = _0x6B8F.RenderStepped:Connect(function()
_0x334A.Brightness = 2
_0x334A.ClockTime = 14
_0x334A.FogEnd = 1e6
_0x334A.GlobalShadows = false
_0x334A.Ambient = Color3.new(1, 1, 1)
_0x334A.OutdoorAmbient = Color3.new(1, 1, 1)
end)
elseif _0x0BC7 then
for _0xB2C2, _0x53E0 in pairs(_0x0BC7) do
_0x334A[_0xB2C2] = _0x53E0
end
_0x0BC7 = nil
end
end,
Source =[==[
-- Fullbright (toggle)
local original = {
    Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd, GlobalShadows = Lighting.GlobalShadows,
    Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient,
}

local conn = RunService.RenderStepped:Connect(function()
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.FogEnd = 1e6
    Lighting.GlobalShadows = false
    Lighting.Ambient = Color3.new(1, 1, 1)
    Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
end)

-- To disable: conn:Disconnect() and copy `original` back onto Lighting
]==],
})
enddo
local _0x0405, _0x10D3, _0xD933 = nil, 0, nil
_0x79D4({
Name ="ESP", Desc ="Highlights every player through walls with name + distance. Optional tracers.", Kind ="Toggle",
Inputs = {
{ _0x3714 ="Color", _0xA7CD ="ESP color", Type ="color", Default = _0xF0DD(255, 70, 70) },
{ _0x3714 ="UseTeam", _0xA7CD ="Use team colors", Type ="bool", Default = false },
{ _0x3714 ="Tracers", _0xA7CD ="Tracers", Type ="bool", Default = false },
},
Func = function(self, _0x97B0, state)
_0x10D3 += 1
local _0x50FF = _0x10D3
if _0xD933 then _0xD933:Disconnect() _0xD933 = nil end
if _0x0405 then _0x0405:Destroy() _0x0405 = nil end
if not state then return end
_0x0405 = Instance.new("Folder")
_0x0405.Name ="MantleESP"_0x0405.Parent = _0xC997local _0x1CAA = {}
_0xD933 = _0x6B8F.RenderStepped:Connect(function()
local _0x0666 = workspace.CurrentCamera
if not (_0x0666 and _0x0405) then return end
local _0x2F1A = _0x0666.ViewportSize
local _0xCF3C = Vector2.new(_0x2F1A.X / 2, _0x2F1A.Y)
for _0x3AE9, _0xE0D1 in ipairs(_0x0102:GetPlayers()) do
if _0xE0D1 ~= _0x0F7F then
local _0x6CFA = _0xE0D1.Character and _0xE0D1.Character:FindFirstChild("HumanoidRootPart")
local _0x28D2 = _0x1CAA[_0xE0D1]
local _0x3718 = false
if _0x97B0.Tracers and _0x6CFA then
local _0x1F0D, _0xE44C = _0x0666:WorldToScreenPoint(_0x6CFA.Position)
if _0xE44C then
_0x3718 = true
if not _0x28D2 then
_0x28D2 = Instance.new("Frame")
_0x28D2.AnchorPoint = Vector2.new(.5, .5)
_0x28D2.BorderSizePixel = 0
_0x28D2.ZIndex = 5
_0x28D2.Parent = _0x0405
_0x1CAA[_0xE0D1] = _0x28D2
end
local _0xFCC2 = Vector2.new(_0x1F0D.X, _0x1F0D.Y)
local _0x5D96 = _0xFCC2 - _0xCF3C
_0x28D2.Size = UDim2.fromOffset(_0x5D96.Magnitude, 1.5)
_0x28D2.Position = UDim2.fromOffset((_0xCF3C.X + _0xFCC2.X) / 2, (_0xCF3C.Y + _0xFCC2.Y) / 2)
_0x28D2.Rotation = math.deg(math.atan2(_0x5D96.Y, _0x5D96.X))
_0x28D2.BackgroundColor3 = (_0x97B0.UseTeam and _0xE0D1.Team) and _0xE0D1.TeamColor.Color or _0x97B0.Color
end
end
if _0x28D2 then _0x28D2.Visible = _0x3718 end
end
end
for _0xE0D1, _0x8372 in pairs(_0x1CAA) do
if not _0xE0D1.Parent then
_0x8372:Destroy()
_0x1CAA[_0xE0D1] = nil
end
end
end)
local _0x4FC3 = {}
local function _0xA194(_0xE0D1)
local _0x2802 = _0x4FC3[_0xE0D1]
if _0x2802 then
_0x2802.hl:Destroy()
_0x2802.bb:Destroy()
_0x4FC3[_0xE0D1] = nil
end
end
task.spawn(function()
while _0x10D3 == _0x50FF do
local _0xF149 = _0x950D()
for _0x3AE9, _0xE0D1 in ipairs(_0x0102:GetPlayers()) do
if _0xE0D1 ~= _0x0F7F then
local _0x5498 = _0xE0D1.Character
local _0x6CFA = _0x5498 and _0x5498:FindFirstChild("HumanoidRootPart")
if _0x6CFA then
local _0x2802 = _0x4FC3[_0xE0D1]
if not _0x2802 or _0x2802.hl.Adornee ~= _0x5498 then
_0xA194(_0xE0D1)
local _0x3056 = Instance.new("Highlight")
_0x3056.FillTransparency = .65
_0x3056.OutlineTransparency = 0
_0x3056.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
_0x3056.Adornee = _0x5498
_0x3056.Parent = _0x0405
local _0x8B49 = Instance.new("BillboardGui")
_0x8B49.Size = UDim2.fromOffset(160, 20)
_0x8B49.StudsOffset = Vector3.new(0, 3.2, 0)
_0x8B49.AlwaysOnTop = true
_0x8B49.Adornee = _0x5498:FindFirstChild("Head") or _0x6CFA
_0x8B49.Parent = _0x0405
local _0xF367 = Instance.new("TextLabel")
_0xF367.BackgroundTransparency = 1
_0xF367.Size = UDim2.fromScale(1, 1)
_0xF367.Font = _0x110B.Bold
_0xF367.TextSize = 15
_0xF367.TextStrokeTransparency = .4
_0xF367.Parent = _0x8B49
_0x2802 = { _0x3056 = _0x3056, _0x8B49 = _0x8B49, _0xF367 = _0xF367 }
_0x4FC3[_0xE0D1] = _0x2802
end
local _0x6DE1 = (_0x97B0.UseTeam and _0xE0D1.Team) and _0xE0D1.TeamColor.Color or _0x97B0.Color
_0x2802.hl.FillColor = _0x6DE1
_0x2802.hl.OutlineColor = _0x6DE1
_0x2802.tl.TextColor3 = _0x6DE1
local _0x1FC3 = _0xF149 and math.floor((_0xF149.Position - _0x6CFA.Position).Magnitude) or 0
_0x2802.tl.Text = _0xE0D1.DisplayName .."  [".. _0x1FC3 .."]"else
_0xA194(_0xE0D1)
end
end
end
for _0xE0D1 in pairs(_0x4FC3) do
if not _0xE0D1.Parent then _0xA194(_0xE0D1) end
end
task.wait(.1)
end
end)
end,
Source =[==[
-- ESP (toggle)
local color = Color3.fromRGB(255, 70, 70)
local useTeamColors = false
local folder = Instance.new("Folder", gui)
local active = true

task.spawn(function()
    while active do
        for _, p in ipairs(Players:GetPlayers()) do
            local char = p.Character
            if p ~= player and char and char:FindFirstChild("HumanoidRootPart") then
                local hl = folder:FindFirstChild(p.Name) or Instance.new("Highlight")
                hl.Name = p.Name
                hl.Adornee = char
                hl.FillTransparency = 0.65
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

                local c = (useTeamColors and p.Team) and p.TeamColor.Color or color
                hl.FillColor, hl.OutlineColor = c, c
                hl.Parent = folder
            end
        end
        task.wait(0.1)
    end
    folder:Destroy()
end)

-- To disable: active = false
-- (Mantle also adds a name + distance billboard above each player,
-- and optional tracers: a Frame line from the bottom of the screen to each
-- player, positioned with workspace.CurrentCamera:WorldToScreenPoint)
]==],
})
end_0x79D4({
Name ="No Materials", Desc ="Strips the material from every part in the workspace.", Kind ="Run", Aliases = {"nomat","nomaterials"},
Silent = true,
Func = function(self)
local _0x1CA9 = 0
for _0x3A85, _0x5D96 in ipairs(workspace:GetDescendants()) do
if _0x5D96:IsA("BasePart") and not _0x5D96:IsA("Terrain") then
_0x5D96.Material = Enum.Material.Plastic
_0x5D96.MaterialVariant =""_0x1CA9 += 1
end
if _0x3A85 % 600 == 0 then task.wait() end
end
_0x6DB0("No Materials", _0x1CA9 .." parts set to Plastic","success")
end,
Source =[==[
-- No Materials
for _, part in ipairs(workspace:GetDescendants()) do
    if part:IsA("BasePart") and not part:IsA("Terrain") then
        part.Material = Enum.Material.Plastic
        part.MaterialVariant = ""
    end
end
]==],
})do
local _0x5D46, _0x49F1 = nil, {}
_0x79D4({
Name ="Noclip", Desc ="Walk through walls and objects.", Kind ="Toggle",
Func = function(self, _0x97B0, state)
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
if state then
_0x5D46 = _0x6B8F.Stepped:Connect(function()
local _0xED20 = _0x0F7F.Character
if not _0xED20 then return end
for _0xE0D1 in pairs(_0x49F1) do if not _0xE0D1.Parent then _0x49F1[_0xE0D1] = nil end end
for _0x3AE9, _0xE0D1 in ipairs(_0xED20:GetDescendants()) do
if _0xE0D1:IsA("BasePart") and _0xE0D1.CanCollide then
_0x49F1[_0xE0D1] = true
_0xE0D1.CanCollide = false
end
end
end)
else
for _0xE0D1 in pairs(_0x49F1) do
if _0xE0D1.Parent then _0xE0D1.CanCollide = true end
end
table.clear(_0x49F1)
end
end,
Source =[==[
-- Noclip (toggle)
local changed = {}

local conn = RunService.Stepped:Connect(function()
    for _, part in ipairs(player.Character:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            changed[part] = true
            part.CanCollide = false
        end
    end
end)

-- To disable: conn:Disconnect(), then set CanCollide = true
-- on every part stored in `changed`
]==],
})
end_0x79D4({
Name ="FPS Cap", Desc ="Sets the client frame rate cap (needs executor support). Stop restores 60.", Kind ="Run", Aliases = {"setfps"},
Inputs = { { _0x3714 ="Value", _0xA7CD ="FPS cap", Type ="number", Default = 240, Min = 5, Max = 1000 } },
Silent = true,
Func = function(self, _0x97B0)
assert(typeof(_0xB2A2.setfpscap) =="function","This environment doesn't support setfpscap")
_0xB2A2.setfpscap(_0x97B0.Value)
_0xD9FD(self, true)
_0x6DB0("FPS Cap","Set to ".. tostring(_0x97B0.Value),"success")
end,
Stop = function()
if typeof(_0xB2A2.setfpscap) =="function"then _0xB2A2.setfpscap(60) end
end,
Source =[==[
-- FPS Cap (needs setfpscap from your environment)
setfpscap(240)

-- To restore: setfpscap(60)
]==],
})_0x79D4({
Name ="Server Hop", Desc ="Join a different public server of this game.", Kind ="Run", Aliases = {"hop","serverhop"},
Silent = true,
Func = function(self)
if not _0xB2A2.request then
_0x84A5("warn","No HTTP request function available; using a standard teleport instead")
_0x6DB0("Server Hop","No HTTP access here, doing a standard teleport","warn")
_0x0D1E:Teleport(game.PlaceId, _0x0F7F)
return
end
local _0x28E3 = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true"):format(game.PlaceId)
local _0x0AC9 = _0xB2A2.request({ Url = _0x28E3, Method ="GET"})
assert(_0x0AC9 and _0x0AC9.Body,"Server list request failed")
local _0x72C8 = _0x92EE:JSONDecode(_0x0AC9.Body)
local _0x5BEF = {}
for _0x3AE9, _0x98DE in ipairs(_0x72C8.data or {}) do
if _0x98DE.id ~= game.JobId and _0x98DE.playing < _0x98DE.maxPlayers then
table.insert(_0x5BEF, _0x98DE)
end
end
assert(#_0x5BEF > 0,"No other servers found")
local _0xFF71 = _0x5BEF[math.random(#_0x5BEF)]
_0x6DB0("Server Hop","Joining a server with ".. _0xFF71.playing .." players...","info")
_0x0D1E:TeleportToPlaceInstance(game.PlaceId, _0xFF71.id, _0x0F7F)
end,
Source =[==[
-- Server Hop (needs an HTTP request function)
local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true")
    :format(game.PlaceId)

local response = request({ Url = url, Method = "GET" })
local data = HttpService:JSONDecode(response.Body)

local pool = {}
for _, server in ipairs(data.data) do
    if server.id ~= game.JobId and server.playing < server.maxPlayers then
        table.insert(pool, server)
    end
end

local pick = pool[math.random(#pool)]
TeleportService:TeleportToPlaceInstance(game.PlaceId, pick.id, player)
]==],
})_0x79D4({
Name ="Rejoin", Desc ="Rejoin this exact server.", Kind ="Run", Aliases = {"rj"}, Silent = true,
Func = function(self)
_0x6DB0("Rejoin","Rejoining...","info")
if #_0x0102:GetPlayers() <= 1 then
_0x0D1E:Teleport(game.PlaceId, _0x0F7F)
else
_0x0D1E:TeleportToPlaceInstance(game.PlaceId, game.JobId, _0x0F7F)
end
end,
Source =[==[
-- Rejoin
if #Players:GetPlayers() <= 1 then
    -- you're alone: a fresh server is the only option
    TeleportService:Teleport(game.PlaceId, player)
else
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end
]==],
})_0x79D4({
Name ="Reset Character", Desc ="Respawn your character.", Kind ="Run", Aliases = {"reset","re"}, Silent = true,
Func = function(self)
local _0xCCD3 = _0xF51E()
assert(_0xCCD3,"Humanoid not found")
_0xCCD3.Health = 0
end,
Source =[==[
-- Reset Character
local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
humanoid.Health = 0
]==],
})do
local _0x5D46
_0x79D4({
Name ="Anti-AFK", Desc ="Prevents the idle kick.", Kind ="Toggle", Aliases = {"antiafk","afk"},
Func = function(self, _0x97B0, state)
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
if state then
_0x5D46 = _0x0F7F.Idled:Connect(function()
_0x5C9D:CaptureController()
_0x5C9D:ClickButton2(Vector2.new())
end)
end
end,
Source =[==[
-- Anti-AFK (toggle)
local VirtualUser = game:GetService("VirtualUser")

local conn = player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- To disable: conn:Disconnect()
]==],
})
endlocal _0xFC21 = function() return false enddo
local _0x5D46, _0x0BC7
_0x79D4({
Name ="Max Zoom", Desc ="Lets the camera zoom out much further. Stop restores it.", Kind ="Run", Aliases = {"zoom","maxzoomdistance"},
Inputs = { { _0x3714 ="Distance", _0xA7CD ="Max distance", Type ="number", Default = 100000, Min = 10, Max = 1000000 } },
Silent = true,
Func = function(self, _0x97B0)
if _0x5D46 then _0x5D46:Disconnect() end
_0x0BC7 = _0x0BC7 or _0x0F7F.CameraMaxZoomDistance
_0x5D46 = _0x6B8F.Heartbeat:Connect(function()
_0x0F7F.CameraMaxZoomDistance = _0x97B0.Distance
end)
_0xD9FD(self, true)
_0x6DB0("Max Zoom","Max distance set to ".. tostring(_0x97B0.Distance),"success")
end,
Stop = function()
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
_0x0F7F.CameraMaxZoomDistance = _0x0BC7 or 128
_0x0BC7 = nil
end,
Source =[==[
-- Max Zoom (loops so the game can't change it back)
local distance = 100000
local original = player.CameraMaxZoomDistance

local conn = RunService.Heartbeat:Connect(function()
    player.CameraMaxZoomDistance = distance
end)

-- To stop: conn:Disconnect() and restore
-- player.CameraMaxZoomDistance = original
]==],
})
enddo
local _0x5D46, _0xCE20
local _0xF599, _0x2AF2
local function _0xB13A(self, _0x4A0F, _0x2F1E)
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
if _0x4A0F.Enabled then _0xD9FD(_0x4A0F, false) end_0xCE20 = _0xCE20 or { Min = _0x0F7F.CameraMinZoomDistance, Max = _0x0F7F.CameraMaxZoomDistance }
_0x2F1E()
_0x5D46 = _0x6B8F.Heartbeat:Connect(_0x2F1E)
_0xD9FD(self, true)
end
local function _0xD55E()
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
_0x0F7F.CameraMode = Enum.CameraMode.Classic
if _0xCE20 then
_0x0F7F.CameraMaxZoomDistance = _0xCE20.Max
_0x0F7F.CameraMinZoomDistance = _0xCE20.Min
_0xCE20 = nil
end
end
_0xF599 = {
Name ="Third Person", Desc ="Forces third person: you can't zoom into first person. Stop restores it.", Kind ="Run", Aliases = {"3p","thirdperson"},
Inputs = { { _0x3714 ="Distance", _0xA7CD ="Min distance", Type ="number", Default = 10, Min = 1, Max = 400 } },
Silent = true,
Func = function(self, _0x97B0)
_0xB13A(self, _0x2AF2, function()
_0x0F7F.CameraMode = Enum.CameraMode.Classic
if _0x0F7F.CameraMaxZoomDistance < _0x97B0.Distance then
_0x0F7F.CameraMaxZoomDistance = math.max(_0x97B0.Distance, 128)
end
_0x0F7F.CameraMinZoomDistance = _0x97B0.Distance
end)
_0x6DB0("Third Person","Forced","success")
end,
Stop = function() _0xD55E() end,
Source =[==[
-- Third Person (loops so the game can't change it back)
local minDistance = 10

local conn = RunService.Heartbeat:Connect(function()
    player.CameraMode = Enum.CameraMode.Classic
    if player.CameraMaxZoomDistance < minDistance then
        player.CameraMaxZoomDistance = math.max(minDistance, 128)
    end
    player.CameraMinZoomDistance = minDistance
end)

-- To stop: conn:Disconnect(), then restore
-- CameraMinZoomDistance = 0.5 and CameraMaxZoomDistance = 128
]==],
}
_0x2AF2 = {
Name ="First Person", Desc ="Locks your camera to first person. Stop restores it.", Kind ="Run", Aliases = {"1p","firstperson"},
Silent = true,
Func = function(self)
_0xB13A(self, _0xF599, function()
_0x0F7F.CameraMode = Enum.CameraMode.LockFirstPerson
end)
_0x6DB0("First Person","Locked","success")
end,
Stop = function() _0xD55E() end,
Source =[==[
-- First Person (loops so the game can't change it back)
local conn = RunService.Heartbeat:Connect(function()
    player.CameraMode = Enum.CameraMode.LockFirstPerson
end)

-- To stop: conn:Disconnect() and
-- player.CameraMode = Enum.CameraMode.Classic
]==],
}
_0x79D4(_0xF599)
_0x79D4(_0x2AF2)
enddo
local _0x5D46
local function _0xA281()
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
_0x22C9.MouseBehavior = Enum.MouseBehavior.Default
local _0xCCD3 = _0xF51E()
if _0xCCD3 then
_0xCCD3.AutoRotate = true
_0xCCD3.CameraOffset = Vector3.zero
end
end
_0x79D4({
Name ="Force Shiftlock", Desc ="Forces Shift Lock: mouse locked, character faces the camera. Hold Left Alt to free the mouse.", Kind ="Toggle",
Aliases = {"shiftlock","sl","forceshiftlock"},
Inputs = { { _0x3714 ="Offset", _0xA7CD ="Camera offset", Type ="number", Default = 1.75, Min = -6, Max = 6 } },
Func = function(self, _0x97B0, state)
_0xA281()
if not state then return end
_0x5D46 = _0x6B8F.RenderStepped:Connect(function()
local _0x0666, _0xCCD3, _0x5C16 = workspace.CurrentCamera, _0xF51E(), _0x950D()
if not (_0x0666 and _0xCCD3 and _0x5C16) then return end
local _0xC30D = _0xFC21()
or _0x22C9:GetFocusedTextBox() ~= nil
or _0x22C9:IsKeyDown(Enum.KeyCode.LeftAlt)
or _0x0666.CameraType == Enum.CameraType.Scriptable
if _0xC30D then
if _0x22C9.MouseBehavior == Enum.MouseBehavior.LockCenter then
_0x22C9.MouseBehavior = Enum.MouseBehavior.Default
end
_0xCCD3.AutoRotate = true
_0xCCD3.CameraOffset = Vector3.zero
return
end
_0x22C9.MouseBehavior = Enum.MouseBehavior.LockCenter
_0xCCD3.AutoRotate = false
_0xCCD3.CameraOffset = Vector3.new(_0x97B0.Offset, 0, 0)
if not (_0xCCD3.Sit or _0xCCD3.PlatformStand) then
local _0x7018 = _0x0666.CFrame.LookVector
local _0x4803 = Vector3.new(_0x7018.X, 0, _0x7018.Z)
if _0x4803.Magnitude > 1e-3 then
_0x5C16.CFrame = CFrame.lookAt(_0x5C16.Position, _0x5C16.Position + _0x4803)
end
end
end)
end,
Source =[==[
-- Force Shiftlock (toggle)
local offset = 1.75
local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
local root = player.Character.HumanoidRootPart

local conn = RunService.RenderStepped:Connect(function()
    local cam = workspace.CurrentCamera
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    humanoid.AutoRotate = false
    humanoid.CameraOffset = Vector3.new(offset, 0, 0)

    -- face the direction the camera looks (ignoring pitch)
    local look = cam.CFrame.LookVector
    local flat = Vector3.new(look.X, 0, look.Z)
    if flat.Magnitude > 0.001 then
        root.CFrame = CFrame.lookAt(root.Position, root.Position + flat)
    end
end)

-- To disable: conn:Disconnect(), MouseBehavior = Default,
-- humanoid.AutoRotate = true, humanoid.CameraOffset = Vector3.zero
]==],
})
end_0x79D4({
Name ="Sit", Desc ="Makes your character sit down. Jump to stand up.", Kind ="Run", Silent = true,
Func = function(self)
local _0xCCD3 = _0xF51E()
assert(_0xCCD3,"Humanoid not found")
_0xCCD3.Sit = true
end,
Source =[==[
-- Sit
local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
humanoid.Sit = true
]==],
})do
local _0x16A1, _0x49F1, _0x10D3 = {}, {}, 0
local function _0x65C7(part)
local _0xA3A3 = part:FindFirstAncestorOfClass("Model")
while _0xA3A3 do
if _0xA3A3:FindFirstChildOfClass("Humanoid") then return true end
_0xA3A3 = _0xA3A3:FindFirstAncestorOfClass("Model")
end
return false
end
local function _0x5FC9()
_0x10D3 += 1
for _0x3AE9, _0xED20 in ipairs(_0x16A1) do _0xED20:Disconnect() end
table.clear(_0x16A1)
for _0xE0D1 in pairs(_0x49F1) do
if _0xE0D1.Parent then _0xE0D1.LocalTransparencyModifier = 0 end
end
table.clear(_0x49F1)
end
_0x79D4({
Name ="XRAY", Desc ="Makes the map see-through (client only). Players stay solid.", Kind ="Toggle", Aliases = {"xray"},
Inputs = { { _0x3714 ="Amount", _0xA7CD ="Transparency", Type ="number", Default = .6, Min = .05, Max = .95 } },
Func = function(self, _0x97B0, state)
_0x5FC9()
if not state then return end
local _0x50FF = _0x10D3
local function _0x1461(_0x5D96)
if _0x5D96:IsA("BasePart") and not _0x5D96:IsA("Terrain") and not _0x65C7(_0x5D96) then
_0x49F1[_0x5D96] = true
_0x5D96.LocalTransparencyModifier = _0x97B0.Amount
end
end
table.insert(_0x16A1, workspace.DescendantAdded:Connect(_0x1461))
task.spawn(function()
for _0x3A85, _0x5D96 in ipairs(workspace:GetDescendants()) do
if _0x10D3 ~= _0x50FF then return end
_0x1461(_0x5D96)
if _0x3A85 % 500 == 0 then task.wait() end
end
local _0x56BB = _0x97B0.Amount
while _0x10D3 == _0x50FF dotask.wait(.5)
if _0x97B0.Amount ~= _0x56BB then
_0x56BB = _0x97B0.Amount
for _0xE0D1 in pairs(_0x49F1) do
if _0xE0D1.Parent then _0xE0D1.LocalTransparencyModifier = _0x56BB end
end
end
end
end)
end,
Source =[==[
-- XRAY (toggle) - LocalTransparencyModifier only changes what YOU see
local amount = 0.6
local touched = {}

local function isCharacterPart(part)
    local model = part:FindFirstAncestorOfClass("Model")
    while model do
        if model:FindFirstChildOfClass("Humanoid") then return true end
        model = model:FindFirstAncestorOfClass("Model")
    end
    return false
end

local function apply(d)
    if d:IsA("BasePart") and not d:IsA("Terrain") and not isCharacterPart(d) then
        touched[d] = true
        d.LocalTransparencyModifier = amount
    end
end

for _, d in ipairs(workspace:GetDescendants()) do apply(d) end
local conn = workspace.DescendantAdded:Connect(apply)

-- To disable: conn:Disconnect() and set LocalTransparencyModifier = 0
-- on every part stored in `touched`
]==],
})
enddo
local _0x0405, _0x10D3 = nil, 0
_0x79D4({
Name ="Hitbox Shower", Desc ="Draws every player's hitbox parts as see-through boxes.", Kind ="Toggle", Aliases = {"hitboxes","hitbox","showhitboxes"},
Inputs = {
{ _0x3714 ="Color", _0xA7CD ="Box color", Type ="color", Default = _0xF0DD(80, 170, 255) },
{ _0x3714 ="Transparency", _0xA7CD ="Transparency", Type ="number", Default = .6, Min = 0, Max = .95 },
{ _0x3714 ="RootOnly", _0xA7CD ="Root part only", Type ="bool", Default = false },
{ _0x3714 ="Self", _0xA7CD ="Include myself", Type ="bool", Default = false },
{ _0x3714 ="Walls", _0xA7CD ="Show through walls", Type ="bool", Default = true },
},
Func = function(self, _0x97B0, state)
_0x10D3 += 1
local _0x50FF = _0x10D3
if _0x0405 then _0x0405:Destroy() _0x0405 = nil end
if not state then return end
_0x0405 = Instance.new("Folder")
_0x0405.Name ="MantleHitboxes"_0x0405.Parent = _0xC997
local _0x6678 = {}
task.spawn(function()
while _0x10D3 == _0x50FF do
local _0xF242 = {}
for _0x3AE9, _0xE0D1 in ipairs(_0x0102:GetPlayers()) do
local _0x5498 = _0xE0D1.Character
if _0x5498 and (_0xE0D1 ~= _0x0F7F or _0x97B0.Self) then
local _0xC4DD = _0x97B0.RootOnly and { _0x5498:FindFirstChild("HumanoidRootPart") } or _0x5498:GetChildren()
for _0x3AE9, part in ipairs(_0xC4DD) do
if part:IsA("BasePart") then
_0xF242[part] = true
local _0x3D2C = _0x6678[part]
if not _0x3D2C then
_0x3D2C = Instance.new("BoxHandleAdornment")
_0x3D2C.Adornee = part
_0x3D2C.ZIndex = 1
_0x3D2C.Parent = _0x0405
_0x6678[part] = _0x3D2C
end
_0x3D2C.Size = part.Size + Vector3.one * .05
_0x3D2C.Color3 = _0x97B0.Color
_0x3D2C.Transparency = _0x97B0.Transparency
_0x3D2C.AlwaysOnTop = _0x97B0.Walls
end
end
end
end
for part, _0x3D2C in pairs(_0x6678) do
if not _0xF242[part] or not part.Parent then
_0x3D2C:Destroy()
_0x6678[part] = nil
end
end
task.wait(.1)
end
end)
end,
Source =[==[
-- Hitbox Shower (toggle)
local color = Color3.fromRGB(80, 170, 255)
local folder = Instance.new("Folder", gui)
local boxes = {}
local active = true

task.spawn(function()
    while active do
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                for _, part in ipairs(p.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        local box = boxes[part]
                        if not box then
                            box = Instance.new("BoxHandleAdornment")
                            box.Adornee = part
                            box.AlwaysOnTop = true
                            box.ZIndex = 1
                            box.Parent = folder
                            boxes[part] = box
                        end
                        box.Size = part.Size + Vector3.one * 0.05
                        box.Color3 = color
                        box.Transparency = 0.6
                    end
                end
            end
        end
        task.wait(0.1)
    end
    folder:Destroy()
end)

-- To disable: active = false
]==],
})
endif _0x108D.NewCommands then
local _0x5D46
local function _0x96C7()
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
local _0xCCD3 = _0xF51E()
if _0xCCD3 then _0xCCD3.AutoRotate = true end
end
_0x79D4({
Name ="Spin", Desc ="Spins your character. Speed is degrees per second (negative reverses).", Kind ="Toggle", Aliases = {"spinbot","rotate"},
Inputs = { { _0x3714 ="Speed", _0xA7CD ="Spin speed", Type ="number", Default = 720, Min = -5000, Max = 5000 } },
Func = function(self, _0x97B0, state)
_0x96C7()
if not state then return end
assert(_0x950D(),"Character not found")
_0x5D46 = _0x6B8F.Heartbeat:Connect(function(dt)
local _0x5C16, _0xCCD3 = _0x950D(), _0xF51E()
if not (_0x5C16 and _0xCCD3) then return endif _0xCCD3.AutoRotate then _0xCCD3.AutoRotate = false end_0x5C16.CFrame = _0x5C16.CFrame * CFrame.Angles(0, math.rad(_0x97B0.Speed) * dt, 0)
end)
end,
Source =[==[
-- Spin (toggle)
local speed = 720 -- degrees per second
local conn = RunService.Heartbeat:Connect(function(dt)
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if not (root and humanoid) then return end

    humanoid.AutoRotate = false
    root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(speed) * dt, 0)
end)

-- To disable: conn:Disconnect() and set humanoid.AutoRotate = true
]==],
})
endif _0x108D.NewCommands then
local _0x16A1, _0x49F1 = {}, {}
local function _0x3EDC()
for _0xE0D1 in pairs(_0x49F1) do
if _0xE0D1.Parent then _0xE0D1.CanCollide = true end
end
table.clear(_0x49F1)
end
local function _0x5FC9()
for _0x3AE9, _0xED20 in ipairs(_0x16A1) do _0xED20:Disconnect() end
table.clear(_0x16A1)
_0x3EDC()
end
_0x79D4({
Name ="Anti-Fling", Desc ="Stops other players pushing or flinging you: ignores their collisions and caps your velocity.", Kind ="Toggle",
Aliases = {"antifling","af"},
Inputs = {
{ _0x3714 ="MaxVelocity", _0xA7CD ="Max velocity", Type ="number", Default = 400, Min = 50, Max = 5000 },
{ _0x3714 ="Collide", _0xA7CD ="Ignore player collisions", Type ="bool", Default = true },
},
Func = function(self, _0x97B0, state)
_0x5FC9()
if not state then return endtable.insert(_0x16A1, _0x6B8F.Stepped:Connect(function()
if not _0x97B0.Collide then
if next(_0x49F1) then _0x3EDC() end
return
end
for part in pairs(_0x49F1) do if not part.Parent then _0x49F1[part] = nil end end
for _0x3AE9, _0xE0D1 in ipairs(_0x0102:GetPlayers()) do
if _0xE0D1 ~= _0x0F7F and _0xE0D1.Character then
for _0x3AE9, part in ipairs(_0xE0D1.Character:GetDescendants()) do
if part:IsA("BasePart") and part.CanCollide then
_0x49F1[part] = true
part.CanCollide = false
end
end
end
end
end))table.insert(_0x16A1, _0x6B8F.Heartbeat:Connect(function()
local _0x5C16 = _0x950D()
if not _0x5C16 then return end
if _0x5C16.AssemblyLinearVelocity.Magnitude > _0x97B0.MaxVelocity then
_0x5C16.AssemblyLinearVelocity = Vector3.zero
end
if _0x5C16.AssemblyAngularVelocity.Magnitude > 60 then
_0x5C16.AssemblyAngularVelocity = Vector3.zero
end
end))
end,
Source =[==[
-- Anti-Fling (toggle)
local maxVelocity = 400
local changed = {}

-- other players' parts stop colliding with you
local stepped = RunService.Stepped:Connect(function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            for _, part in ipairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    changed[part] = true
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- cancel any sudden launch
local heartbeat = RunService.Heartbeat:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    if root.AssemblyLinearVelocity.Magnitude > maxVelocity then
        root.AssemblyLinearVelocity = Vector3.zero
    end
    if root.AssemblyAngularVelocity.Magnitude > 60 then
        root.AssemblyAngularVelocity = Vector3.zero
    end
end)

-- To disable: disconnect both, then set CanCollide = true
-- on every part stored in `changed`
]==],
})
enddo
local _0x5D46, _0xCE20, _0x497B = nil, nil, 0
local function _0xA281(_0x3EDC)
_0x497B += 1
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
local _0xC241 = _0xCE20
_0xCE20 = nil
local _0x5C16 = _0x950D()
if not _0x5C16 then return end
_0x5C16.AssemblyLinearVelocity = Vector3.zero
_0x5C16.AssemblyAngularVelocity = Vector3.zero
if _0x3EDC and _0xC241 then
_0x5C16.CFrame = _0xC241
local _0x50FF = _0x497B
task.spawn(function()for _0x3AE9 = 1, 12 do
_0x6B8F.Heartbeat:Wait()
local _0xD16C = _0x950D()
if _0x497B ~= _0x50FF or not _0xD16C then return end
_0xD16C.AssemblyLinearVelocity = Vector3.zero
_0xD16C.AssemblyAngularVelocity = Vector3.zero
_0xD16C.CFrame = _0xC241
end
end)
end
end
_0x79D4({
Name ="Fling", Desc ="Spins into a player at high speed to launch them, then puts you back where you were.", Kind ="Run", Silent = true,
Aliases = {"yeet"},
Inputs = {
{ _0x3714 ="Target", _0xA7CD ="Player", Type ="player"},
{ _0x3714 ="Power", _0xA7CD ="Power", Type ="number", Default = 500000, Min = 1000, Max = 1000000 },
{ _0x3714 ="Duration", _0xA7CD ="Max seconds", Type ="number", Default = 3, Min = .5, Max = 15 },
},
Func = function(self, _0x97B0)
local _0xFCC2 = _0xA86D(_0x97B0.Target)
assert(_0xFCC2 and _0xFCC2 ~= _0x0F7F,"Select another player first")
local _0x5C16 = _0x950D()
assert(_0x5C16,"Character not found")
_0xA281(false)
_0xCE20 = _0x5C16.CFrame
local _0x50FF, _0x5FE7 = _0x497B, os.clock()
_0xD9FD(self, true)
_0x6DB0("Fling","Flinging ".. _0xFCC2.Name,"info")
_0x5D46 = _0x6B8F.Heartbeat:Connect(function()
if _0x497B ~= _0x50FF then return end
local _0x10B0 = _0x950D()
local _0xB184 = _0xFCC2.Parent and _0xFCC2.Character and _0xFCC2.Character:FindFirstChild("HumanoidRootPart")
local _0x7FD2 = os.clock() - _0x5FE7
local _0x35F0
if not _0x10B0 then _0x35F0 ="Your character is gone"elseif not _0xB184 then _0x35F0 = _0xFCC2.Name .." is gone"elseif _0x7FD2 > .3 and _0xB184.AssemblyLinearVelocity.Magnitude > 250 then _0x35F0 = _0xFCC2.Name .." was flung"elseif _0x7FD2 >= _0x97B0.Duration then _0x35F0 ="Timed out"end
if _0x35F0 then
_0xA281(true)
_0xD9FD(self, false)
_0x6DB0("Fling", _0x35F0,"info")
return
end
local _0xE0D1 = _0xB184.Position + _0xB184.AssemblyLinearVelocity * .12 + Vector3.new(0, math.random(-5, 5) / 10, 0)if _0xE0D1 ~= _0xE0D1 or _0xE0D1.Magnitude > 1e5 then
_0xA281(true)
_0xD9FD(self, false)
_0x6DB0("Fling", _0xFCC2.Name .." went out of range","warn")
return
end
local _0x12A3 = math.clamp(_0x97B0.Power, 1000, 1e6)
_0x10B0.CFrame = CFrame.new(_0xE0D1)
_0x10B0.AssemblyLinearVelocity = Vector3.new(_0x12A3, _0x12A3, _0x12A3)
_0x10B0.AssemblyAngularVelocity = Vector3.new(_0x12A3, _0x12A3, _0x12A3)
end)
end,
Stop = function() _0xA281(true) end,
Cleanup = function() _0xA281(false) end,
Source =[==[
-- Fling
local target = Players:FindFirstChild("PlayerName")
local root = player.Character.HumanoidRootPart
local home = root.CFrame
local power = 500000
local started = os.clock()

local conn
conn = RunService.Heartbeat:Connect(function()
    local tr = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not tr or tr.AssemblyLinearVelocity.Magnitude > 250 or os.clock() - started > 3 then
        conn:Disconnect()
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        root.CFrame = home
        return
    end
    root.CFrame = CFrame.new(tr.Position + tr.AssemblyLinearVelocity * 0.12)
    root.AssemblyLinearVelocity = Vector3.new(power, power, power)
    root.AssemblyAngularVelocity = Vector3.new(power, power, power)
end)
]==],
})
enddo
local _0x5D46
local function _0x96C7()
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
end
_0x79D4({
Name ="TPWalk", Desc ="Moves you faster by nudging your position as you walk. Not affected by WalkSpeed checks.", Kind ="Toggle",
Aliases = {"tpw"},
Inputs = { { _0x3714 ="Speed", _0xA7CD ="Extra studs / sec", Type ="number", Default = 40, Min = 1, Max = 1000 } },
Func = function(self, _0x97B0, state)
_0x96C7()
if not state then return end
_0x5D46 = _0x6B8F.Heartbeat:Connect(function(dt)
local _0xED20, _0xCCD3 = _0x0F7F.Character, _0xF51E()
if _0xED20 and _0xCCD3 and _0xCCD3.Health > 0 and not _0xCCD3.Sit and _0xCCD3.MoveDirection.Magnitude > 0 then
_0xED20:TranslateBy(_0xCCD3.MoveDirection * _0x97B0.Speed * dt)
end
end)
end,
Cleanup = _0x96C7,
Source =[==[
-- TPWalk (toggle)
local speed = 40 -- extra studs per second

local conn = RunService.Heartbeat:Connect(function(dt)
    local char = player.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.MoveDirection.Magnitude > 0 then
        char:TranslateBy(humanoid.MoveDirection * speed * dt)
    end
end)

-- To disable: conn:Disconnect()
]==],
})
enddo
local _0x5D46, _0x8DDA, _0xAF72, _0xF861
local function _0x788E()
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
if _0x8DDA then _0x8DDA:Destroy() _0x8DDA = nil end
if _0xF861 then _0xF861:Destroy() _0xF861 = nil end
if _0xAF72 ~= nil then
_0x22C9.MouseIconEnabled = _0xAF72
_0xAF72 = nil
end
end
_0x79D4({
Name ="Custom Crosshair", Desc ="Draws your own crosshair: color, size, gap, dot, outline. Can follow the mouse.", Kind ="Toggle",
Aliases = {"crosshair","xhair"},
Inputs = {
{ _0x3714 ="Color", _0xA7CD ="Color", Type ="color", Default = _0xF0DD(0, 255, 120) },
{ _0x3714 ="Length", _0xA7CD ="Line length", Type ="number", Default = 10, Min = 1, Max = 100 },
{ _0x3714 ="Thickness", _0xA7CD ="Thickness", Type ="number", Default = 2, Min = 1, Max = 12 },
{ _0x3714 ="Gap", _0xA7CD ="Center gap", Type ="number", Default = 5, Min = 0, Max = 60 },
{ _0x3714 ="Dot", _0xA7CD ="Center dot", Type ="bool", Default = false },
{ _0x3714 ="Outline", _0xA7CD ="Black outline", Type ="bool", Default = true },
{ _0x3714 ="FollowMouse", _0xA7CD ="Follow the mouse", Type ="bool", Default = false },
{ _0x3714 ="HideCursor", _0xA7CD ="Hide system cursor", Type ="bool", Default = true },
{ _0x3714 ="_cursorHeader", _0xA7CD ="CUSTOM CURSOR  ·  shapes: 1 Arrow, 2 Dot, 3 Ring, 4 Plus", Type ="header"},
{ _0x3714 ="CursorOn", _0xA7CD ="Custom cursor", Type ="bool", Default = false },
{ _0x3714 ="CursorStyle", _0xA7CD ="Shape (1-4)", Type ="number", Default = 1, Min = 1, Max = 4 },
{ _0x3714 ="CursorColor", _0xA7CD ="Cursor color", Type ="color", Default = _0xF0DD(255, 255, 255) },
{ _0x3714 ="CursorSize", _0xA7CD ="Cursor size", Type ="number", Default = 20, Min = 6, Max = 96 },
{ _0x3714 ="CursorImage", _0xA7CD ="Image ID (optional)", Type ="text", Placeholder ="Roblox image ID, replaces the shape"},
},
Func = function(self, _0x97B0, state)
_0x788E()
if not state then return end
_0x8DDA = Instance.new("Frame")
_0x8DDA.Name ="MantleCrosshair"_0x8DDA.AnchorPoint = Vector2.new(.5, .5)
_0x8DDA.Size = UDim2.fromOffset(0, 0)
_0x8DDA.BackgroundTransparency = 1
_0x8DDA.ZIndex = 90
_0x8DDA.Parent = _0xC997_0xF861 = Instance.new("Frame")
_0xF861.Name ="MantleCursor"_0xF861.BackgroundTransparency = 1
_0xF861.Size = UDim2.fromOffset(0, 0)
_0xF861.ZIndex = 95
_0xF861.Visible = false
_0xF861.Parent = _0xC997
local _0x46BB = {}
local function _0x1FD9(_0x6A18, class)
local _0x2802 = Instance.new(class)
_0x2802.Name = _0x6A18
_0x2802.BackgroundTransparency = 1
_0x2802.BorderSizePixel = 0
_0x2802.ZIndex = 95
_0x2802.Visible = false
_0x2802.Parent = _0xF861
_0x46BB[_0x6A18] = _0x2802
return _0x2802
end
_0x1FD9("Arrow","ImageLabel")
local _0xE296 = _0x1FD9("Dot","Frame")
_0xE296.AnchorPoint = Vector2.new(.5, .5)
_0xE296.BackgroundTransparency = 0
Instance.new("UICorner", _0xE296).CornerRadius = UDim.new(.5, 0)
local _0xC34A = _0x1FD9("Ring","Frame")
_0xC34A.AnchorPoint = Vector2.new(.5, .5)
Instance.new("UICorner", _0xC34A).CornerRadius = UDim.new(.5, 0)
local _0x317C = Instance.new("UIStroke")
_0x317C.Thickness = 2
_0x317C.Parent = _0xC34A
_0x46BB.RingStroke = _0x317C
for _0x3AE9, _0x1CA9 in ipairs({"PlusH","PlusV"}) do
local _0x3D2C = _0x1FD9(_0x1CA9,"Frame")
_0x3D2C.AnchorPoint = Vector2.new(.5, .5)
_0x3D2C.BackgroundTransparency = 0
end
local _0xC4BC = {}
for _0x3AE9, _0x1CA9 in ipairs({"Top","Bottom","Left","Right","Dot"}) do
local _0x2E83 = Instance.new("Frame")
_0x2E83.Name = _0x1CA9
_0x2E83.BorderSizePixel = 0
_0x2E83.ZIndex = 90
_0x2E83.Parent = _0x8DDA
local _0x98DE = Instance.new("UIStroke")
_0x98DE.Thickness = 1
_0x98DE.Color = Color3.new(0, 0, 0)
_0x98DE.Parent = _0x2E83
_0xC4BC[_0x1CA9] = { _0x8FFF = _0x2E83, _0x1B3E = _0x98DE }
end
_0x5D46 = _0x6B8F.RenderStepped:Connect(function()
local _0xA6DB, _0xAA1E, _0xF226 = _0x97B0.Length, _0x97B0.Thickness, _0x97B0.Gap
local _0x4622 = {
Top = { Vector2.new(-_0xAA1E / 2, -(_0xF226 + _0xA6DB)), Vector2.new(_0xAA1E, _0xA6DB) },
Bottom = { Vector2.new(-_0xAA1E / 2, _0xF226), Vector2.new(_0xAA1E, _0xA6DB) },
Left = { Vector2.new(-(_0xF226 + _0xA6DB), -_0xAA1E / 2), Vector2.new(_0xA6DB, _0xAA1E) },
Right = { Vector2.new(_0xF226, -_0xAA1E / 2), Vector2.new(_0xA6DB, _0xAA1E) },
Dot = { Vector2.new(-_0xAA1E / 2, -_0xAA1E / 2), Vector2.new(_0xAA1E, _0xAA1E) },
}
for _0x1CA9, _0xE0D1 in pairs(_0xC4BC) do
local _0x2A39, _0x6F81 = _0x4622[_0x1CA9][1], _0x4622[_0x1CA9][2]
_0xE0D1.Frame.Position = UDim2.fromOffset(_0x2A39.X, _0x2A39.Y)
_0xE0D1.Frame.Size = UDim2.fromOffset(_0x6F81.X, _0x6F81.Y)
_0xE0D1.Frame.BackgroundColor3 = _0x97B0.Color
_0xE0D1.Frame.Visible = _0x1CA9 ~="Dot"or _0x97B0.Dot
_0xE0D1.Stroke.Enabled = _0x97B0.Outline
end
if _0x97B0.FollowMouse then
local _0xA3A3 = _0x22C9:GetMouseLocation()
_0x8DDA.Position = UDim2.fromOffset(_0xA3A3.X, _0xA3A3.Y)
else
_0x8DDA.Position = UDim2.fromScale(.5, .5)
end
_0x8DDA.Visible = not _0xFC21()local _0x828B = _0x22C9.MouseBehavior == Enum.MouseBehavior.LockCenter
local _0x301F = _0x97B0.CursorOn and not _0x828B
_0xF861.Visible = _0x301F
if _0x301F then
local _0xAD8B = _0x22C9:GetMouseLocation()
_0xF861.Position = UDim2.fromOffset(_0xAD8B.X, _0xAD8B.Y)
local _0x5257, _0x6DE1 = _0x97B0.CursorSize, _0x97B0.CursorColor
local _0xD2CA = tostring(_0x97B0.CursorImage or""):match("%d+")
local _0x153D = math.floor(_0x97B0.CursorStyle + .5)
_0x46BB.Arrow.Visible = _0xD2CA ~= nil or _0x153D == 1
if _0x46BB.Arrow.Visible then
_0x46BB.Arrow.Image = _0xD2CA and ("rbxassetid://".. _0xD2CA) or"rbxasset://textures/Cursors/KeyboardMouse/ArrowCursor.png"_0x46BB.Arrow.ImageColor3 = _0xD2CA and Color3.new(1, 1, 1) or _0x6DE1
_0x46BB.Arrow.Size = UDim2.fromOffset(_0x5257, _0x5257)
end
local _0xD6FA = _0xD2CA == nil
_0x46BB.Dot.Visible = _0xD6FA and _0x153D == 2
_0x46BB.Ring.Visible = _0xD6FA and _0x153D == 3
_0x46BB.PlusH.Visible = _0xD6FA and _0x153D == 4
_0x46BB.PlusV.Visible = _0xD6FA and _0x153D == 4
_0x46BB.Dot.Size = UDim2.fromOffset(_0x5257 * .5, _0x5257 * .5)
_0x46BB.Dot.BackgroundColor3 = _0x6DE1
_0x46BB.Ring.Size = UDim2.fromOffset(_0x5257, _0x5257)
_0x46BB.RingStroke.Color = _0x6DE1
_0x46BB.PlusH.Size = UDim2.fromOffset(_0x5257, 2)
_0x46BB.PlusV.Size = UDim2.fromOffset(2, _0x5257)
_0x46BB.PlusH.BackgroundColor3 = _0x6DE1
_0x46BB.PlusV.BackgroundColor3 = _0x6DE1
end
if (_0x97B0.HideCursor and not _0xFC21()) or _0x97B0.CursorOn then
if _0xAF72 == nil then _0xAF72 = _0x22C9.MouseIconEnabled end
_0x22C9.MouseIconEnabled = false
elseif _0xAF72 ~= nil then
_0x22C9.MouseIconEnabled = _0xAF72
_0xAF72 = nil
end
end)
end,
Cleanup = _0x788E,
Source =[==[
-- Custom Crosshair (toggle)
local color, length, thickness, gap = Color3.fromRGB(0, 255, 120), 10, 2, 5

local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local function line(x, y, w, h)
    local f = Instance.new("Frame")
    f.AnchorPoint = Vector2.new(.5, .5)
    f.Position = UDim2.new(.5, x, .5, y)
    f.Size = UDim2.fromOffset(w, h)
    f.BackgroundColor3 = color
    f.BorderSizePixel = 0
    f.Parent = gui
    Instance.new("UIStroke", f).Thickness = 1
end

local o = gap + length / 2
line(0, -o, thickness, length)  -- top
line(0,  o, thickness, length)  -- bottom
line(-o, 0, length, thickness)  -- left
line( o, 0, length, thickness)  -- right

UserInputService.MouseIconEnabled = false
-- To remove: gui:Destroy() and MouseIconEnabled = true
]==],
})
enddo
local _0x5A2E = _0xF0DD(255, 196, 52)
local _0x0405 = Instance.new("Folder")
_0x0405.Name ="MantleOwnerTag"_0x0405.Parent = _0xC997
local _0x03F7 = {}
local function _0xF940(_0x2CB9)
local _0x7D78, _0x0BA9, _0x5B61 = _0xF0DD(255, 236, 150), _0xF0DD(255, 196, 52), _0xF0DD(150, 100, 14)
local _0x2029 = Instance.new("BillboardGui")
_0x2029.Name ="OwnerTag"_0x2029.Adornee = _0x2CB9
_0x2029.Size = UDim2.fromOffset(200, 52)
_0x2029.StudsOffsetWorldSpace = Vector3.new(0, 3.6, 0)
_0x2029.MaxDistance = 250
_0x2029.LightInfluence = 0
_0x2029.ResetOnSpawn = false
_0x2029.Parent = _0x0405
local function _0x02D0(_0x7824, seq, rot)
local _0x858B = Instance.new("UIGradient")
_0x858B.Color = seq
_0x858B.Rotation = rot or 0
_0x858B.Parent = _0x7824
return _0x858B
end
local function _0x1E6F(_0x8F94, _0x5C16)
local _0x5F40 = Instance.new("UICorner")
_0x5F40.CornerRadius = _0x5C16
_0x5F40.Parent = _0x8F94
end
local function _0x99D3(_0x7824, _0x6F81, _0xC4BF, _0xE997)
local _0x5D96 = Instance.new("Frame")
_0x5D96.AnchorPoint = Vector2.new(.5, .5)
_0x5D96.Position = _0xC4BF
_0x5D96.Size = UDim2.fromOffset(_0x6F81, _0x6F81)
_0x5D96.Rotation = 45
_0x5D96.BackgroundColor3 = Color3.new(1, 1, 1)
_0x5D96.BorderSizePixel = 0
_0x5D96.Parent = _0x7824
_0x02D0(_0x5D96, ColorSequence.new(_0x7D78, _0x5B61), 90)
return _0x5D96
endlocal _0x2209 = Instance.new("Frame")
_0x2209.AnchorPoint = Vector2.new(.5, .5)
_0x2209.Position = UDim2.new(.5, 0, 1, -18)
_0x2209.Size = UDim2.fromOffset(166, 40)
_0x2209.BackgroundColor3 = _0x0BA9
_0x2209.BackgroundTransparency = .8
_0x2209.BorderSizePixel = 0
_0x2209.Parent = _0x2029
_0x1E6F(_0x2209, UDim.new(.5, 0))local _0x4755 = Instance.new("Frame")
_0x4755.BackgroundTransparency = 1
_0x4755.Size = UDim2.fromScale(1, 1)
_0x4755.Parent = _0x2029
_0x99D3(_0x4755, 7, UDim2.new(.5, -22, 0, 11), 0)
_0x99D3(_0x4755, 11, UDim2.new(.5, 0, 0, 8), 0)
_0x99D3(_0x4755, 7, UDim2.new(.5, 22, 0, 11), 0)local _0xF99A = Instance.new("Frame")
_0xF99A.AnchorPoint = Vector2.new(.5, .5)
_0xF99A.Position = UDim2.new(.5, 0, 1, -18)
_0xF99A.Size = UDim2.fromOffset(152, 30)
_0xF99A.BackgroundColor3 = Color3.new(1, 1, 1)
_0xF99A.BorderSizePixel = 0
_0xF99A.Parent = _0x2029
_0x1E6F(_0xF99A, UDim.new(.5, 0))
_0x02D0(_0xF99A, ColorSequence.new(_0xF0DD(46, 34, 10), _0xF0DD(16, 12, 4)), 90)
local _0x2586 = Instance.new("UIStroke")
_0x2586.Thickness = 2
_0x2586.Color = Color3.new(1, 1, 1)
_0x2586.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
_0x2586.Parent = _0xF99A
local _0xC68A = _0x02D0(_0x2586, ColorSequence.new({
ColorSequenceKeypoint.new(0, _0x5B61),
ColorSequenceKeypoint.new(.5, _0x7D78),
ColorSequenceKeypoint.new(1, _0x5B61),
}))
_0x99D3(_0xF99A, 9, UDim2.new(0, 20, .5, 0), 0)
_0x99D3(_0xF99A, 9, UDim2.new(1, -20, .5, 0), 0)
local _0x8372 = Instance.new("TextLabel")
_0x8372.BackgroundTransparency = 1
_0x8372.Size = UDim2.fromScale(1, 1)
_0x8372.Font = Enum.Font.GothamBlack
_0x8372.TextSize = 15
_0x8372.RichText = false
_0x8372.Text ="O W N E R"_0x8372.TextColor3 = Color3.new(1, 1, 1)
_0x8372.TextStrokeTransparency = .6
_0x8372.TextStrokeColor3 = _0xF0DD(60, 38, 0)
_0x8372.Parent = _0xF99A
_0x02D0(_0x8372, ColorSequence.new(_0x7D78, _0x0BA9), 90)task.spawn(function()
local _0x1EED = os.clock()
while _0x2029.Parent do
local _0x735B = os.clock() - _0x1EED
_0xC68A.Rotation = (_0x735B * 110) % 360
_0x2209.BackgroundTransparency = .8 + math.sin(_0x735B * 2.4) * .08
task.wait()
end
end)
return _0x2029
end
local function _0x9B3A()
for _0x3AE9, _0xE0D1 in ipairs(_0x0102:GetPlayers()) do
local _0x919A = _0xE0D1.Name:lower() == _0x8C6B:lower()
local _0x2CB9 = _0x919A and _0xE0D1.Character and _0xE0D1.Character:FindFirstChild("Head")
local _0x2029 = _0x03F7[_0xE0D1]
if _0x2CB9 then
if not _0x2029 or _0x2029.Adornee ~= _0x2CB9 then
if _0x2029 then _0x2029:Destroy() end
_0x03F7[_0xE0D1] = _0xF940(_0x2CB9)
end
elseif _0x2029 then
_0x2029:Destroy()
_0x03F7[_0xE0D1] = nil
end
end
for _0xE0D1, _0x2029 in pairs(_0x03F7) do
if not _0xE0D1.Parent then
_0x2029:Destroy()
_0x03F7[_0xE0D1] = nil
end
end
endtask.spawn(function()
while _0x0405.Parent do
pcall(_0x9B3A)
task.wait(.5)
end
end)
enddo
local _0x16A1 = {}
local function _0x96C7()
for _0x3AE9, _0xED20 in ipairs(_0x16A1) do _0xED20:Disconnect() end
table.clear(_0x16A1)
endlocal function _0x6966()
local _0xCCD3 = _0xF51E()
if not _0xCCD3 or _0xCCD3.Health <= 0 or _0xCCD3.Sit or _0xCCD3.PlatformStand then return end
local _0x0A17 = _0xCCD3:GetState()
if _0x0A17 == Enum.HumanoidStateType.Jumping or _0x0A17 == Enum.HumanoidStateType.Freefall
or _0x0A17 == Enum.HumanoidStateType.Swimming or _0x0A17 == Enum.HumanoidStateType.Climbing
or _0x0A17 == Enum.HumanoidStateType.Dead or _0x0A17 == Enum.HumanoidStateType.Seated then
return
end
if _0xCCD3.FloorMaterial ~= Enum.Material.Air then
_0xCCD3.Jump = true_0xCCD3:ChangeState(Enum.HumanoidStateType.Jumping)end
end
_0x79D4({
Name ="Bunny Hop", Desc ="Automatically jumps the moment you land. Runs until you toggle it off.", Kind ="Toggle", Aliases = {"bhop"},
Func = function(self, _0x97B0, state)
_0x96C7()
if not state then return endtable.insert(_0x16A1, _0x6B8F.RenderStepped:Connect(_0x6966))
table.insert(_0x16A1, _0x6B8F.Heartbeat:Connect(_0x6966))
end,
Cleanup = _0x96C7,
Source =[==[
-- Bunny Hop (toggle): jumps automatically every time you touch the ground
local function hop()
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 or humanoid.Sit or humanoid.PlatformStand then return end

    local state = humanoid:GetState()
    if state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall
        or state == Enum.HumanoidStateType.Swimming or state == Enum.HumanoidStateType.Climbing
        or state == Enum.HumanoidStateType.Dead or state == Enum.HumanoidStateType.Seated then
        return
    end

    if humanoid.FloorMaterial ~= Enum.Material.Air then
        humanoid.Jump = true
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

local c1 = RunService.RenderStepped:Connect(hop)
local c2 = RunService.Heartbeat:Connect(hop)

-- To disable: c1:Disconnect() and c2:Disconnect()
]==],
})
enddo
local _0x5D46, _0xC3F2
local function _0x96C7()
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
if _0xC3F2 then _0xC3F2:Destroy() _0xC3F2 = nil end
end
_0x79D4({
Name ="Float", Desc ="Hover in place. Q to rise, E to lower. You can still walk around.", Kind ="Toggle", Aliases = {"hover"},
Inputs = { { _0x3714 ="Speed", _0xA7CD ="Rise / lower speed", Type ="number", Default = 30, Min = 1, Max = 500 } },
Func = function(self, _0x97B0, state)
_0x96C7()
if not state then return end
assert(_0x950D(),"Character not found")
_0x5D46 = _0x6B8F.Heartbeat:Connect(function()
local _0x5C16, _0xCCD3 = _0x950D(), _0xF51E()
if not (_0x5C16 and _0xCCD3) then return endif not _0xC3F2 or _0xC3F2.Parent ~= _0x5C16 then
if _0xC3F2 then _0xC3F2:Destroy() end
_0xC3F2 = Instance.new("BodyVelocity")
_0xC3F2.Name ="MantleFloat"_0xC3F2.MaxForce = Vector3.new(0, 1e9, 0)_0xC3F2.Velocity = Vector3.zero
_0xC3F2.Parent = _0x5C16
end
local _0xA4BC = 0
if not _0x22C9:GetFocusedTextBox() then
if _0x22C9:IsKeyDown(Enum.KeyCode.Q) then _0xA4BC += _0x97B0.Speed end
if _0x22C9:IsKeyDown(Enum.KeyCode.E) then _0xA4BC -= _0x97B0.Speed end
end
_0xC3F2.Velocity = Vector3.new(0, _0xA4BC, 0)
end)
end,
Cleanup = _0x96C7,
Source =[==[
-- Float (toggle): hover in place. Q rises, E lowers.
local speed = 30
local bv

local conn = RunService.Heartbeat:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if not bv or bv.Parent ~= root then
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(0, 1e9, 0) -- vertical only, so you can still walk
        bv.Velocity = Vector3.zero
        bv.Parent = root
    end

    local vy = 0
    if not UserInputService:GetFocusedTextBox() then
        if UserInputService:IsKeyDown(Enum.KeyCode.Q) then vy += speed end
        if UserInputService:IsKeyDown(Enum.KeyCode.E) then vy -= speed end
    end
    bv.Velocity = Vector3.new(0, vy, 0)
end)

-- To disable: conn:Disconnect() and bv:Destroy()
]==],
})
enddo
local _0x5D46, _0x43B5, _0x1B3F
local _0xFB63 = Enum.HumanoidStateTypelocal function _0x89B5(_0xCCD3, _0xE2B6)
for _0x3AE9, _0x0A17 in ipairs(_0xFB63:GetEnumItems()) do
if _0x0A17 ~= _0xFB63.None and _0x0A17 ~= _0xFB63.Swimming and _0x0A17 ~= _0xFB63.Dead then
pcall(_0xCCD3.SetStateEnabled, _0xCCD3, _0x0A17, not _0xE2B6)
end
end
pcall(_0xCCD3.SetStateEnabled, _0xCCD3, _0xFB63.Swimming, true)
end
local function _0x96C7()
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
if _0x43B5 then
workspace.Gravity = _0x43B5
_0x43B5 = nil
end
local _0xCCD3 = _0xF51E()
if _0xCCD3 then
_0x89B5(_0xCCD3, false)pcall(_0xCCD3.ChangeState, _0xCCD3, _0xFB63.Freefall)
end
_0x1B3F = nil
end
_0x79D4({
Name ="Swim", Desc ="Swim through the air like it's water. Walk in the direction you look; Space rises.", Kind ="Toggle",
Aliases = {"airswim","swimair"},
Func = function(self, _0x97B0, state)
_0x96C7()
if not state then return end
assert(_0xF51E(),"Humanoid not found")
_0x43B5 = workspace.Gravity
_0x5D46 = _0x6B8F.Heartbeat:Connect(function()
local _0xCCD3, _0x5C16 = _0xF51E(), _0x950D()
if not (_0xCCD3 and _0x5C16) or _0xCCD3.Health <= 0 then
_0x1B3F = nilreturn
end
if _0x1B3F ~= _0xCCD3 then
_0x1B3F = _0xCCD3
_0x89B5(_0xCCD3, true)
end
workspace.Gravity = 0
if _0xCCD3:GetState() ~= _0xFB63.Swimming then
_0xCCD3:ChangeState(_0xFB63.Swimming)
endlocal _0x3C86 = _0xCCD3.MoveDirection.Magnitude > 0
or (_0x22C9:IsKeyDown(Enum.KeyCode.Space) and not _0x22C9:GetFocusedTextBox())
if not _0x3C86 then
_0x5C16.AssemblyLinearVelocity = Vector3.zero
end
end)
end,
Cleanup = _0x96C7,
Source =[==[
-- Swim (toggle): swim through the air
local ST = Enum.HumanoidStateType
local originalGravity = workspace.Gravity
local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
local root = player.Character.HumanoidRootPart

-- switch every other humanoid state off so nothing pulls you out of swimming
for _, state in ipairs(ST:GetEnumItems()) do
    if state ~= ST.None and state ~= ST.Swimming and state ~= ST.Dead then
        humanoid:SetStateEnabled(state, false)
    end
end
humanoid:SetStateEnabled(ST.Swimming, true)

local conn = RunService.Heartbeat:Connect(function()
    workspace.Gravity = 0
    if humanoid:GetState() ~= ST.Swimming then
        humanoid:ChangeState(ST.Swimming)
    end
    local steering = humanoid.MoveDirection.Magnitude > 0
        or UserInputService:IsKeyDown(Enum.KeyCode.Space)
    if not steering then
        root.AssemblyLinearVelocity = Vector3.zero
    end
end)

-- To disable: conn:Disconnect(), workspace.Gravity = originalGravity,
-- enable every state again, then humanoid:ChangeState(ST.Freefall)
]==],
})
enddo
local _0x5D46, _0x0BC7
local function _0x96C7()
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
if _0x0BC7 ~= nil then
_0x334A.ClockTime = _0x0BC7
_0x0BC7 = nil
end
end
_0x79D4({
Name ="Time Of Day", Desc ="Locks the in-game clock to an hour (0-24). Stop restores it.", Kind ="Run", Silent = true,
Aliases = {"time","clocktime"},
Inputs = { { _0x3714 ="Hour", _0xA7CD ="Hour (0-24)", Type ="number", Default = 12, Min = 0, Max = 24 } },
Func = function(self, _0x97B0)
if _0x0BC7 == nil then _0x0BC7 = _0x334A.ClockTime end
if _0x5D46 then _0x5D46:Disconnect() end
_0x5D46 = _0x6B8F.Heartbeat:Connect(function()
_0x334A.ClockTime = _0x97B0.Hour
end)
_0xD9FD(self, true)
_0x6DB0("Time Of Day","Locked to hour ".. tostring(_0x97B0.Hour),"success")
end,
Stop = _0x96C7,
Cleanup = _0x96C7,
Source =[==[
-- Time Of Day
local original = Lighting.ClockTime
local conn = RunService.Heartbeat:Connect(function()
    Lighting.ClockTime = 12
end)

-- To restore: conn:Disconnect() and Lighting.ClockTime = original
]==],
})
enddo
local _0x5D46
local function _0x96C7()
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
local _0xCCD3 = _0xF51E()
if _0xCCD3 then _0xCCD3.Sit = false end
end
_0x79D4({
Name ="Head Sit", Desc ="Sit on a player's head and ride along. Press Space or Stop to get off.", Kind ="Run", Silent = true,
Aliases = {"headsit","hs"},
Inputs = { { _0x3714 ="Target", _0xA7CD ="Player", Type ="player"} },
Func = function(self, _0x97B0)
local _0xFCC2 = _0xA86D(_0x97B0.Target)
assert(_0xFCC2 and _0xFCC2 ~= _0x0F7F,"Select another player first")
assert(_0x950D() and _0xF51E(),"Character not found")
_0x96C7()
_0xD9FD(self, true)
_0x6DB0("Head Sit","Riding ".. _0xFCC2.Name,"info")
_0x5D46 = _0x6B8F.Heartbeat:Connect(function()
local _0x5C16, _0xCCD3 = _0x950D(), _0xF51E()
local _0x2CB9 = _0xFCC2.Parent and _0xFCC2.Character and _0xFCC2.Character:FindFirstChild("Head")
if not (_0x5C16 and _0xCCD3 and _0x2CB9) or (_0x22C9:IsKeyDown(Enum.KeyCode.Space) and not _0x22C9:GetFocusedTextBox()) then
_0x96C7()
_0xD9FD(self, false)
_0x6DB0("Head Sit","Stopped","info")
return
end
_0xCCD3.Sit = true
_0x5C16.CFrame = _0x2CB9.CFrame * CFrame.new(0, 1.6, 0)
_0x5C16.AssemblyLinearVelocity = Vector3.zero
end)
end,
Stop = _0x96C7,
Cleanup = _0x96C7,
Source =[==[
-- Head Sit
local target = Players:FindFirstChild("PlayerName")
local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
local root = player.Character.HumanoidRootPart

local conn = RunService.Heartbeat:Connect(function()
    local head = target.Character and target.Character:FindFirstChild("Head")
    if not head then return end
    humanoid.Sit = true
    root.CFrame = head.CFrame * CFrame.new(0, 1.6, 0)
    root.AssemblyLinearVelocity = Vector3.zero
end)

-- To stop: conn:Disconnect() and humanoid.Sit = false
]==],
})
enddo
local _0x5D46
local function _0x96C7()
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
end
_0x79D4({
Name ="Anti-Void", Desc ="Remembers where you last stood and puts you back if you fall toward the void.", Kind ="Toggle",
Aliases = {"antivoid","av"},
Inputs = { { _0x3714 ="Margin", _0xA7CD ="Rescue margin (studs)", Type ="number", Default = 60, Min = 10, Max = 500 } },
Func = function(self, _0x97B0, state)
_0x96C7()
if not state then return end
local _0xBD8E, _0xA965 = nil, 0
_0x5D46 = _0x6B8F.Heartbeat:Connect(function()
local _0x5C16, _0xCCD3 = _0x950D(), _0xF51E()
if not (_0x5C16 and _0xCCD3) then
_0xBD8E = nil
return
end
local _0xFCA7 = workspace.FallenPartsDestroyHeight + _0x97B0.Margin
if _0xCCD3.FloorMaterial ~= Enum.Material.Air and _0x5C16.Position.Y > _0xFCA7 + 20 then
_0xBD8E = _0x5C16.CFrame + Vector3.new(0, 3, 0)
elseif _0x5C16.Position.Y < _0xFCA7 and _0xBD8E then
_0x5C16.AssemblyLinearVelocity = Vector3.zero
_0x5C16.CFrame = _0xBD8E
if os.clock() - _0xA965 > 2 then
_0xA965 = os.clock()
_0x6DB0("Anti-Void","Pulled you back from the void","success")
end
end
end)
end,
Cleanup = _0x96C7,
Source =[==[
-- Anti-Void (toggle)
local margin = 60
local safe

local conn = RunService.Heartbeat:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if not (root and humanoid) then safe = nil return end

    local limit = workspace.FallenPartsDestroyHeight + margin
    if humanoid.FloorMaterial ~= Enum.Material.Air and root.Position.Y > limit + 20 then
        safe = root.CFrame + Vector3.new(0, 3, 0)
    elseif root.Position.Y < limit and safe then
        root.AssemblyLinearVelocity = Vector3.zero
        root.CFrame = safe
    end
end)

-- To disable: conn:Disconnect()
]==],
})
endif _0x108D.NewCommands then
local _0xD522 = {}
local function _0x4B43(_0x98DE)
return (tostring(_0x98DE or""):lower():gsub("^%s+",""):gsub("%s+$",""))
end
local function _0x0B0D()
local _0x735B = {}
for _0x3AE9, _0xE0D1 in pairs(_0xD522) do table.insert(_0x735B, _0xE0D1.Name) end
table.sort(_0x735B)
return #_0x735B > 0 and table.concat(_0x735B,", ") or"none yet"end
_0x79D4({
Name ="Set Waypoint", Desc ="Saves your current position under a name (kept until you leave the game).", Kind ="Run", Silent = true,
Aliases = {"setwp","swp","waypoint"},
Inputs = { { _0x3714 ="Name", _0xA7CD ="Waypoint name", Type ="text", Default ="home", Placeholder ="Name for this spot"} },
Func = function(self, _0x97B0)
local _0x5C16 = _0x950D()
assert(_0x5C16,"Character not found")
local _0x6A18 = tostring(_0x97B0.Name or""):match("^%s*(.-)%s*$")
assert(_0x6A18 ~="","Give the waypoint a name first")
local _0xC99A = _0xD522[_0x4B43(_0x6A18)] == nil
_0xD522[_0x4B43(_0x6A18)] = { Name = _0x6A18, CFrame = _0x5C16.CFrame }
_0x6DB0("Waypoint", (_0xC99A and"Saved '"or"Updated '") .. _0x6A18 .."'","success")
end,
Source =[==[
-- Set Waypoint
local saved = {}
saved["home"] = player.Character.HumanoidRootPart.CFrame
]==],
})
_0x79D4({
Name ="Goto Waypoint", Desc ="Teleports you back to a waypoint you saved with Set Waypoint.", Kind ="Run", Silent = true,
Aliases = {"gotowp","gwp","wp"},
Inputs = { { _0x3714 ="Name", _0xA7CD ="Waypoint name", Type ="text", Default ="home", Placeholder ="Name of a saved spot"} },
Func = function(self, _0x97B0)
local _0xE0D1 = _0xD522[_0x4B43(_0x97B0.Name)]
assert(_0xE0D1,"No waypoint named '".. tostring(_0x97B0.Name) .."'. Saved: ".. _0x0B0D())
local _0x5C16 = _0x950D()
assert(_0x5C16,"Character not found")
_0x5C16.AssemblyLinearVelocity = Vector3.zero
_0x5C16.CFrame = _0xE0D1.CFrame
_0x6DB0("Waypoint","Teleported to '".. _0xE0D1.Name .."'","success")
end,
Source =[==[
-- Goto Waypoint
player.Character.HumanoidRootPart.CFrame = saved["home"]
]==],
})
endif _0x108D.NewCommands then
local _0x5D46
local function _0x96C7()
if _0x5D46 then _0x5D46:Disconnect() _0x5D46 = nil end
end
_0x79D4({
Name ="Click Teleport", Desc ="Hold Left Ctrl and click to teleport to the spot under your cursor.", Kind ="Toggle",
Aliases = {"clicktp","ctrlclick"},
Inputs = { { _0x3714 ="Height", _0xA7CD ="Height offset (studs)", Type ="number", Default = 3, Min = 0, Max = 50 } },
Func = function(self, _0x97B0, state)
_0x96C7()
if not state then return end
_0x5D46 = _0x22C9.InputBegan:Connect(function(input, gp)
if gp or _0xFC21() then return end
if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
if not _0x22C9:IsKeyDown(Enum.KeyCode.LeftControl) then return end
local _0x5C16 = _0x950D()
local _0xA104 = _0x0F7F:GetMouse().Hit
if not (_0x5C16 and _0xA104) then return end
local _0x2A39 = _0xA104.Position + Vector3.new(0, _0x97B0.Height, 0)
if _0x2A39 ~= _0x2A39 or (_0x2A39 - _0x5C16.Position).Magnitude > 3000 then
_0x6DB0("Click Teleport","That spot is too far away","warn")
return
end
_0x5C16.AssemblyLinearVelocity = Vector3.zero
_0x5C16.CFrame = CFrame.new(_0x2A39) * (_0x5C16.CFrame - _0x5C16.CFrame.Position)
end)
end,
Cleanup = _0x96C7,
Source =[==[
-- Click Teleport (hold Left Ctrl + click)
UserInputService.InputBegan:Connect(function(input, gp)
    if gp or input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    if not UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then return end
    local root = player.Character.HumanoidRootPart
    root.CFrame = CFrame.new(player:GetMouse().Hit.Position + Vector3.new(0, 3, 0))
end)
]==],
})
endif _0x108D.NewCommands then
local _0x16A1 = {}
local function _0x96C7()
for _0x3AE9, _0xED20 in ipairs(_0x16A1) do _0xED20:Disconnect() end
table.clear(_0x16A1)
end
_0x79D4({
Name ="Join Alerts", Desc ="Pops up a notice whenever a player joins or leaves the server.", Kind ="Toggle",
Aliases = {"alerts","joinalerts","leavealerts"},
Inputs = {
{ _0x3714 ="Joins", _0xA7CD ="Alert on join", Type ="bool", Default = true },
{ _0x3714 ="Leaves", _0xA7CD ="Alert on leave", Type ="bool", Default = true },
},
Func = function(self, _0x97B0, state)
_0x96C7()
if not state then return end
table.insert(_0x16A1, _0x0102.PlayerAdded:Connect(function(_0xE0D1)
if _0x97B0.Joins then _0x6DB0("Player joined", _0xE0D1.DisplayName .."  (@".. _0xE0D1.Name ..")","info") end
end))
table.insert(_0x16A1, _0x0102.PlayerRemoving:Connect(function(_0xE0D1)
if _0x97B0.Leaves then _0x6DB0("Player left", _0xE0D1.DisplayName .."  (@".. _0xE0D1.Name ..")","warn") end
end))
end,
Cleanup = _0x96C7,
Source =[==[
-- Join Alerts
Players.PlayerAdded:Connect(function(p) print(p.Name .. " joined") end)
Players.PlayerRemoving:Connect(function(p) print(p.Name .. " left") end)
]==],
})
endif _0x108D.NewCommands then
local _0x16A1, _0xCE20, _0x0BC7, _0x80C4 = {}, {}, nil, 0
local _0x78D4 = {
ParticleEmitter = true, Trail = true, Beam = true, Smoke = true, Fire = true, Sparkles = true,
BloomEffect = true, BlurEffect = true, SunRaysEffect = true, DepthOfFieldEffect = true,
}
local function _0xA104(_0x5D96)
if _0x78D4[_0x5D96.ClassName] and _0x5D96.Enabled then
_0xCE20[_0x5D96] = true
_0x5D96.Enabled = false
end
end
local function _0x3EDC()
_0x80C4 += 1for _0x3AE9, _0xED20 in ipairs(_0x16A1) do _0xED20:Disconnect() end
table.clear(_0x16A1)
for _0x5D96 in pairs(_0xCE20) do
if _0x5D96.Parent then pcall(function() _0x5D96.Enabled = true end) end
end
table.clear(_0xCE20)
if _0x0BC7 then
pcall(function() _0x334A.GlobalShadows = _0x0BC7.Shadows end)
if _0x0BC7.Quality then pcall(function() settings().Rendering.QualityLevel = _0x0BC7.Quality end) end
_0x0BC7 = nil
end
end
_0x79D4({
Name ="FPS Boost", Desc ="Turns off shadows, particles, beams, trails and post effects. Disabling restores them.", Kind ="Toggle",
Aliases = {"fpsboost","boost","lowgfx"},
Inputs = { { _0x3714 ="LowQuality", _0xA7CD ="Lowest graphics quality", Type ="bool", Default = true } },
Func = function(self, _0x97B0, state)
_0x3EDC()
if not state then return end
local _0x50FF = _0x80C4
_0x0BC7 = { Shadows = _0x334A.GlobalShadows }
pcall(function() _0x0BC7.Quality = settings().Rendering.QualityLevel end)
_0x334A.GlobalShadows = false
if _0x97B0.LowQuality then
pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
end
table.insert(_0x16A1, workspace.DescendantAdded:Connect(_0xA104))
table.insert(_0x16A1, _0x334A.DescendantAdded:Connect(_0xA104))
task.spawn(function()for _0x3AE9, _0x10B0 in ipairs({ workspace, _0x334A }) do
for _0x3A85, _0x5D96 in ipairs(_0x10B0:GetDescendants()) do
if _0x80C4 ~= _0x50FF then return end
_0xA104(_0x5D96)
if _0x3A85 % 400 == 0 then task.wait() end
end
end
end)
end,
Cleanup = _0x3EDC,
Source =[==[
-- FPS Boost
Lighting.GlobalShadows = false
for _, d in ipairs(workspace:GetDescendants()) do
    if d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam")
        or d:IsA("Smoke") or d:IsA("Fire") or d:IsA("Sparkles") then
        d.Enabled = false
    end
end
]==],
})
end
local _0xFA40, _0xC94Alocal function _0x530A(_0x1877)
_0x1877 = (_0x1877 or""):match("^%s*(.-)%s*$")
if _0x1877 ==""then return end
_0x84A5("info","> ".. _0x1877)
local _0x2CB9, _0x6ADF = _0x1877:match("^(%S+)%s*(.*)$")
_0x2CB9 = _0x2CB9:lower()
if _0x2CB9 =="help"or _0x2CB9 =="cmds"then
local _0x92C7 = {}
for _0x3AE9, _0xED20 in ipairs(_0x72F8) do table.insert(_0x92C7, _0x3714(_0xED20.Name)) end
_0x84A5("info","Commands: ".. table.concat(_0x92C7,", ") .." | perf | keys | lua <code>")
_0x6DB0("Help","Command list printed to the console","info")
return
end
local _0x3454 = { perf ="Performance", keys ="Keybinds", binds ="Keybinds"}
if _0x3454[_0x2CB9] then
local _0x6A18 = _0x3454[_0x2CB9]
local _0xB148 = _0x7DB1.Widgets[_0x6A18]
if not _0xB148.Enabled then
_0xC94A(_0x6A18, true)
end
_0xFA40(_0x6A18, not _0xB148.Pinned)
_0x6DB0(_0x6A18, _0xB148.Pinned and"Widget pinned"or"Widget unpinned","info")
return
end
if _0x2CB9 =="lua"or _0x2CB9 =="exec"then
local _0xF74B, _0x2E83, _0x3D87 = pcall(loadstring, _0x6ADF)
if not _0xF74B or not _0x2E83 then
local _0xA3A3 = _0xF74B and tostring(_0x3D87) or"loadstring is not available in this environment"_0x84A5("error", _0xA3A3)
_0x6DB0("Custom command", _0xA3A3,"error")
return
end
local _0x01C6, _0x728D = pcall(_0x2E83)
if _0x01C6 then
_0x0625.Scripts += 1
_0x0625.Last ="Custom Lua"_0x6DB0("Custom command","Executed","success")
else
_0x84A5("error", tostring(_0x728D))
_0x6DB0("Custom command", tostring(_0x728D),"error")
end
return
end
local _0x3CA5 = _0xB283[_0x2CB9]
if not _0x3CA5 then
_0x84A5("error","Unknown command: ".. _0x2CB9)
_0x6DB0("Unknown command", _0x2CB9 .." (try 'help')","error")
return
end
local _0xEFAC, _0x1A4A = {}, nil
for _0x46EC in _0x6ADF:gmatch("%S+") do
local _0x8372 = _0x46EC:lower()
if _0x8372 =="on"or _0x8372 =="off"or _0x8372 =="stop"then
_0x1A4A = _0x8372
else
table.insert(_0xEFAC, _0x46EC)
end
end
local _0xB23C = 0
for _0x3AE9, inp in ipairs(_0x3CA5.Inputs or {}) do
if inp.Type =="text"then
local _0xD738 = {}
for _0x3A85 = _0xB23C + 1, #_0xEFAC do table.insert(_0xD738, _0xEFAC[_0x3A85]) end
if #_0xD738 > 0 then
local _0x53E0 = table.concat(_0xD738," ")
_0x3CA5.Values[inp.Key] = _0x53E0
if _0x3CA5.Setters[inp.Key] then _0x3CA5.Setters[inp.Key](_0x53E0) end
end
_0xB23C = #_0xEFAC
elseif inp.Type =="number"or inp.Type =="player"then
_0xB23C += 1
local _0xB7C5 = _0xEFAC[_0xB23C]
if _0xB7C5 then
local _0x53E0
if inp.Type =="number"then
_0x53E0 = tonumber(_0xB7C5)
if _0x53E0 == nil or _0x53E0 ~= _0x53E0 or _0x53E0 == math.huge or _0x53E0 == -math.huge then
_0x6DB0(_0x3CA5.Name,"'".. _0xB7C5 .."' is not a valid number","error")
return
end
_0x53E0 = math.clamp(_0x53E0, inp.Min or -1e9, inp.Max or 1e9)
else
local _0xE0D1 = _0xA86D(_0xB7C5)
if not _0xE0D1 then
_0x6DB0(_0x3CA5.Name,"No player matches '".. _0xB7C5 .."'","error")
return
end
_0x53E0 = _0xE0D1.Name
end
if _0x53E0 ~= nil then
_0x3CA5.Values[inp.Key] = _0x53E0
if _0x3CA5.Setters[inp.Key] then _0x3CA5.Setters[inp.Key](_0x53E0) end
end
end
end
end
if _0x3CA5.Kind =="Toggle"then
local _0x4D8A = nil
if _0x1A4A =="on"then _0x4D8A = true elseif _0x1A4A =="off"or _0x1A4A =="stop"then _0x4D8A = false end
if _0x4D8A == nil and _0x3CA5.Enabled and #_0xEFAC > 0 then
_0x6DB0(_0x3CA5.Name,"Settings updated","success")
return
end
if _0x4D8A ~= nil and _0x3CA5.Enabled == _0x4D8A then
_0x6DB0(_0x3CA5.Name, _0x4D8A and"Already enabled"or"Already disabled","info")
return
end
_0xD168(_0x3CA5)
else
if (_0x1A4A =="off"or _0x1A4A =="stop") and _0x3CA5.Stop then
_0x045B(_0x3CA5)
else
_0xD168(_0x3CA5)
end
end
end_0x5951(_0x0F7F.CharacterAdded, function()
for _0x3AE9, _0x3CA5 in ipairs(_0x72F8) do
if _0x3CA5.StopOnReset and _0x3CA5.Enabled then
pcall(_0x3CA5.Func, _0x3CA5, _0x3CA5.Values, false)
_0xD9FD(_0x3CA5, false)
_0x84A5("info", _0x3CA5.Name .." disabled after reset")
end
end
end)local _0x9860: { [string]: _0xEF28 } = {}
local _0xD03D = false
_0xFC21 = function() return _0xD03D end
local _0x1E3F, _0x54FFlocal _0x2916 = UDim2.new(.5, 0, 0, 14)
local _0x192F = 70local _0x0DFA = _0xBBFC("Frame", {
Name ="Dim", Parent = _0xC997, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0),
BackgroundTransparency = 1, BorderSizePixel = 0, Visible = false,
})local _0x90EB = _0xBBFC("CanvasGroup", {
Name ="Bar", Parent = _0xC997, AnchorPoint = Vector2.new(.5, 0), Position = _0x2916,
Size = UDim2.fromOffset(680, 46), BorderSizePixel = 0, GroupTransparency = 1, Visible = false,
})
_0x8F68(_0x90EB, { BackgroundColor3 ="Bg"})
_0xAC02(_0x90EB, 8)
_0x1B3E(_0x90EB)
_0xA7CD(_0x90EB,"Mantle", 18, _0x110B.Bold,"Text", { Position = UDim2.fromOffset(16, 0), Size = UDim2.fromOffset(70, 46) })
local _0x8359 = _0xBBFC("ScrollingFrame", {
Parent = _0x90EB, BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(88, 0),
Size = UDim2.new(1, -264, 1, 0), ScrollBarThickness = 0, CanvasSize = UDim2.new(),
AutomaticCanvasSize = Enum.AutomaticSize.X, ScrollingDirection = Enum.ScrollingDirection.X,
})
_0x126D(_0x8359, 2, Enum.FillDirection.Horizontal, nil, Enum.VerticalAlignment.Center)
local _0x55CC = _0xA7CD(_0x90EB,"", 14, _0x110B.Med,"Sub", {
Position = UDim2.new(1, -176, 0, 0), Size = UDim2.fromOffset(78, 46), TextXAlignment = Enum.TextXAlignment.Right,
})
local _0x7436 = _0xBF78(_0x90EB,">_", {
Size = UDim2.fromOffset(40, 30), TextSize = 14, OnClick = function() task.spawn(_0x54FF) end,
})
_0x7436.AnchorPoint = Vector2.new(1, .5)
_0x7436.Position = UDim2.new(1, -48, .5, 0)
local _0xF88B = _0xBF78(_0x90EB,"×", {
Size = UDim2.fromOffset(30, 30), TextSize = 18, OnClick = function() _0x1E3F(false) end,
})
_0xF88B.AnchorPoint = Vector2.new(1, .5)
_0xF88B.Position = UDim2.new(1, -10, .5, 0)local _0x51F1 = _0xBBFC("CanvasGroup", {
Name ="Window", Parent = _0xC997, AnchorPoint = Vector2.new(.5, 0), Position = UDim2.new(.5, 0, 0, _0x192F),
Size = UDim2.fromOffset(680, 400), BorderSizePixel = 0, GroupTransparency = 1, Visible = false,
})
_0x8F68(_0x51F1, { BackgroundColor3 ="Bg"})
_0xAC02(_0x51F1, 8)
_0x1B3E(_0x51F1)
local _0x9FCF = _0xBBFC("UIScale", { Parent = _0x51F1, Scale = .96 })local _0xB400
if _0x108D.Background then
_0xB400 = _0xBBFC("ImageLabel", {
Name ="Background", Parent = _0x51F1, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0,
ScaleType = Enum.ScaleType.Crop, Image ="", ImageTransparency = 1 - _0x7DB1.BgOpacity, Visible = false, ZIndex = 0,
})
_0xAC02(_0xB400, 8)
end
local _0xF422 = _0x8FFF(_0x51F1, UDim2.new(1, 0, 0, 38),"Surface")
_0x8FFF(_0xF422, UDim2.new(1, 0, 0, 1),"Stroke", { Position = UDim2.new(0, 0, 1, -1) })
local _0xF37B = _0xA7CD(_0xF422,"Home", 15, _0x110B.Bold,"Text", { Position = UDim2.fromOffset(16, 0), Size = UDim2.new(.35, 0, 1, 0) })
local _0xEA0A = _0xA7CD(_0xF422,"", 11, _0x110B.Reg,"Sub", {
Position = UDim2.new(.35, 0, 0, 0), Size = UDim2.new(.65, -16, 1, 0), TextXAlignment = Enum.TextXAlignment.Right,
TextTruncate = Enum.TextTruncate.AtEnd,
})
_0x253F(_0xF422, _0x51F1)
local _0xF73C = _0x8FFF(_0x51F1, UDim2.new(1, 0, 1, -38), nil, { Position = UDim2.fromOffset(0, 38), ClipsDescendants = true })
local function _0x2C56()
local _0x0666 = workspace.CurrentCamera
local _0x2F1A = _0x0666 and _0x0666.ViewportSize or Vector2.new(1280, 720)
local _0x46EC = math.clamp(_0x2F1A.X - 24, 320, 680)
_0x90EB.Size = UDim2.fromOffset(_0x46EC, 46)
_0x51F1.Size = UDim2.fromOffset(_0x46EC, math.clamp(_0x2F1A.Y - _0x192F - 20, 240, 420))
local _0xC28B = _0x2F1A.X >= 560
_0x55CC.Visible = _0xC28B
_0x8359.Size = UDim2.new(1, _0xC28B and -264 or -188, 1, 0)
if _0x9860.Clamp then _0x9860.Clamp() end
endlocal _0x9FE2, _0x62B8, _0xF5B8 = {}, {}, nil
local _0xAEF4 = {}
local function _0x604B(_0x6A18)
local _0x1775 = _0xBBFC("ScrollingFrame", {
Parent = _0xF73C, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0,
ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollingDirection = Enum.ScrollingDirection.Y, Visible = false, ElasticBehavior = Enum.ElasticBehavior.Never,
})
_0x8F68(_0x1775, { ScrollBarImageColor3 ="Sub"})
_0xBB73(_0x1775, 14, 10, 14, 16)
_0x126D(_0x1775, 10)
_0x9FE2[_0x6A18] = _0x1775
return _0x1775
end
local _0x2287 = {"Home","Commands","Players","Misc","Settings","Credits"}
local function _0xC8F9(_0x6A18)
local _0x46EC = _0x7DB1.Widgets[_0x6A18]
return not (_0x46EC and _0x46EC.Enabled)
end
local function _0x2D01(_0x6A18)
if not _0x9FE2[_0x6A18] or not _0xC8F9(_0x6A18) then return end
if _0xF5B8 == _0x6A18 then return end
_0xF5B8 = _0x6A18
for _0x1CA9, _0x9B13 in pairs(_0x9FE2) do
if _0xC8F9(_0x1CA9) then
if _0x1CA9 == _0x6A18 then
_0x9B13.Visible = true
_0x9B13.Position = UDim2.fromOffset(0, 12)
_0x6A54(_0x9B13, .35, { Position = UDim2.fromOffset(0, 0) })
else
_0x9B13.Visible = false
end
end
end
for _0x1CA9, _0x5FEC in pairs(_0x62B8) do
_0x5FEC(_0x1CA9 == _0x6A18)
end
_0xF37B.Text = _0x6A18
end
local function _0xF73A(_0x6A18)
local _0x67B3 = _0xBBFC("TextButton", {
Parent = _0x8359, Size = UDim2.fromOffset(0, 34), AutomaticSize = Enum.AutomaticSize.X, Text = _0x6A18,
Font = _0x110B.Med, TextSize = _0x79E1(14), AutoButtonColor = false, BorderSizePixel = 0, BackgroundTransparency = 1,
})
_0xAC02(_0x67B3, 6)
_0xBB73(_0x67B3, 12, 0, 12, 0)
_0x8F68(_0x67B3, { BackgroundColor3 ="Surface2"})
local _0x90C1 = false
local _0x3213 = _0x8FFF(_0x67B3, UDim2.new(0, 0, 0, 3),"Accent", {
AnchorPoint = Vector2.new(.5, 1), Position = UDim2.new(.5, 0, 1, -1),
})
_0xAC02(_0x3213, 2)
local _0xBAF3 = _0xE6AE(_0x67B3,"TextColor3", function() return _0x90C1 and _0x7870.Text or _0x7870.Sub end)
_0x67B3.MouseEnter:Connect(function()
if not _0x90C1 then _0x6A54(_0x67B3, .12, { BackgroundTransparency = .6 }) end
end)
_0x67B3.MouseLeave:Connect(function()
if not _0x90C1 then _0x6A54(_0x67B3, .12, { BackgroundTransparency = 1 }) end
end)
_0xAEF4[_0x6A18] = _0x67B3
_0x62B8[_0x6A18] = function(sel)
_0x90C1 = sel
_0x6A54(_0x67B3, .2, { BackgroundTransparency = sel and .35 or 1 })
_0x6A54(_0x3213, .25, { Size = UDim2.new(sel and .6 or 0, 0, 0, 3) })
_0xBAF3(.2)
end
_0x67B3.MouseButton1Click:Connect(function()
_0x2D01(_0x6A18)
end)
end
_0xF73A("Home")
_0xF73A("Commands")
_0xF73A("Players")
_0xF73A("Misc")
_0xF73A("Settings")
_0xF73A("Credits")local _0x124C = _0x8FFF(_0x51F1, UDim2.fromScale(1, 1),"Bg", { Visible = false, ZIndex = 20, Active = true })
local _0xB280 = _0x8FFF(_0x124C, UDim2.new(1, 0, 0, 46),"Surface")
local _0xA024 = _0xA7CD(_0xB280,"", 15, _0x110B.Bold,"Text", { Position = UDim2.fromOffset(18, 0), Size = UDim2.new(1, -200, 1, 0) })
local _0x44BD = _0xBF78(_0xB280,"Copy", { Size = UDim2.fromOffset(66, 28) })
_0x44BD.AnchorPoint = Vector2.new(1, .5)
_0x44BD.Position = UDim2.new(1, -92, .5, 0)
local _0x3C6A = _0xBF78(_0xB280,"Back", { Size = UDim2.fromOffset(66, 28), Variant ="Primary"})
_0x3C6A.AnchorPoint = Vector2.new(1, .5)
_0x3C6A.Position = UDim2.new(1, -16, .5, 0)
local _0x5FF9 = _0x8FFF(_0x124C, UDim2.new(1, -28, 1, -62),"Surface", { Position = UDim2.fromOffset(14, 54) })
_0xAC02(_0x5FF9, 8)
_0x1B3E(_0x5FF9)
local _0xFE99 = _0xBBFC("ScrollingFrame", {
Parent = _0x5FF9, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0,
ScrollBarThickness = 4, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.XY,
ScrollingDirection = Enum.ScrollingDirection.XY,
})
_0x8F68(_0xFE99, { ScrollBarImageColor3 ="Sub"})
_0xBB73(_0xFE99, 12, 10, 12, 10)
local _0x6359 = _0xBBFC("TextBox", {
Parent = _0xFE99, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(0, 0),
AutomaticSize = Enum.AutomaticSize.XY, Font = _0x110B.Code, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = false, ClearTextOnFocus = false, TextEditable = false,
MultiLine = true, Text ="",
})
_0x8F68(_0x6359, { TextColor3 ="Text"})
local function _0x342A(_0x3CA5)
if not _0xD03D then _0x1E3F(true) end
_0xA024.Text = _0x3CA5.Name .."  ·  Source"_0x6359.Text = _0x3CA5.Source or"-- no source available"_0xFE99.CanvasPosition = Vector2.zero
_0x124C.Visible = true
end
_0x3C6A.MouseButton1Click:Connect(function()
_0x124C.Visible = false
end)
_0x44BD.MouseButton1Click:Connect(function()
if _0xB2A2.setclipboard then
_0x08C4(_0x6359.Text,"Code")
else
_0x6359:CaptureFocus()
_0x6DB0("Inspect","Clipboard API unavailable. Select the text and press Ctrl+C.","warn")
end
end)local _0x181D = {}
local _0xF276 = {"Performance","Keybinds","Home","Commands","Players","Misc","Credits","Command Bar","Command History","Command List"}
local _0x2976
local function _0xAB02()
local _0x0666 = workspace.CurrentCamera
return _0x0666 and _0x0666.ViewportSize or Vector2.new(1280, 720)
end
local function _0xABC8(_0x6A18, _0x46EC, _0xCCD3)
local _0x2F1A = _0xAB02()
if _0x6A18 =="Performance"then
return _0x2F1A.X >= 700 and UDim2.fromOffset(18, 78) or UDim2.fromOffset(12, math.max(_0x2F1A.Y - _0xCCD3 - 12, 70))
elseif _0x6A18 =="Keybinds"then
if _0x2F1A.X >= 700 then
return UDim2.fromOffset(math.max(_0x2F1A.X - _0x46EC - 18, 12), 78)
end
return UDim2.fromOffset(math.max(_0x2F1A.X - _0x46EC - 12, 12), math.max(_0x2F1A.Y - _0xCCD3 - 12, 70))
elseif _0x6A18 =="Command Bar"then
return UDim2.fromOffset(math.max(math.floor((_0x2F1A.X - _0x46EC) / 2), 8), math.max(_0x2F1A.Y - _0xCCD3 - 24, 70))
elseif _0x6A18 =="Command History"then
if _0x2F1A.X >= 700 then
return UDim2.fromOffset(18, math.min(78 + 224 + 12, math.max(_0x2F1A.Y - _0xCCD3 - 12, 70)))
end
return UDim2.fromOffset(12, 90)
elseif _0x6A18 =="Command List"then
return UDim2.fromOffset(math.max(math.floor((_0x2F1A.X - _0x46EC) / 2) - 40, 8), 100)
end
local _0xE2B6 = ((table.find(_0xF276, _0x6A18) or 3) - 3) * 26
return UDim2.fromOffset(math.max(math.floor((_0x2F1A.X - _0x46EC) / 2) + _0xE2B6, 8), 90 + _0xE2B6)
end
local function _0x8104(_0x2E83)
local _0xC4DD = {}
for _0x3AE9, _0x46EC in pairs(_0x181D) do
table.insert(_0xC4DD, _0x46EC.Frame)
end
table.sort(_0xC4DD, function(_0xB7C5, _0x3D2C) return _0xB7C5.ZIndex < _0x3D2C.ZIndex end)
local _0x3A85 = 2
for _0x3AE9, _0xBD6E in ipairs(_0xC4DD) do
if _0xBD6E ~= _0x2E83 then
_0xBD6E.ZIndex = _0x3A85
_0x3A85 += 1
end
end
_0x2E83.ZIndex = _0x3A85
end
local function _0xDA8C()
local _0x2F1A = _0xAB02()
for _0x3AE9, _0x46EC in pairs(_0x181D) do
local _0x2E83 = _0x46EC.Frame
local _0xC4BF = math.clamp(_0x2E83.Position.X.Offset, 0, math.max(_0x2F1A.X - _0x2E83.Size.X.Offset, 0))
local _0xE997 = math.clamp(_0x2E83.Position.Y.Offset, 0, math.max(_0x2F1A.Y - _0x2E83.Size.Y.Offset, 0))
_0x2E83.Position = UDim2.fromOffset(_0xC4BF, _0xE997)
end
end
_0x9860.Clamp = _0xDA8C
_0x2976 = function(_0x6A18)
local _0x46EC, _0xB148 = _0x181D[_0x6A18], _0x7DB1.Widgets[_0x6A18]
if not (_0x46EC and _0xB148) then return end
local _0xEECE = _0xB148.Enabled and (_0xD03D or _0xB148.Pinned)
local _0x2E83 = _0x46EC.Frame
_0x46EC.Token += 1
local _0xBCC4 = _0x46EC.Token
if _0xEECE then
_0x2E83.Visible = true
_0x6A54(_0x2E83, .3, { GroupTransparency = _0xD03D and (1 - _0x7DB1.Opacity) or .12 })
_0x6A54(_0x46EC.Scale, .4, { Scale = 1 }, Enum.EasingStyle.Back)
else
_0x6A54(_0x46EC.Scale, .25, { Scale = .96 })
local _0xD64B = _0x6A54(_0x2E83, .22, { GroupTransparency = 1 })
_0xD64B.Completed:Connect(function()
if _0x46EC.Token == _0xBCC4 then
_0x2E83.Visible = false
end
end)
end
end
local function _0xA7E2()
for _0x3AE9, _0x6A18 in ipairs(_0xF276) do
_0x2976(_0x6A18)
end
end
_0xFA40 = function(_0x6A18, _0x97B0)
local _0xB148 = _0x7DB1.Widgets[_0x6A18]
if not _0xB148 then return end
_0xB148.Pinned = _0x97B0 and true or false
local _0x46EC = _0x181D[_0x6A18]
if _0x46EC then
_0x46EC.PinBtn.Text = _0xB148.Pinned and"Pinned"or"Pin"_0x46EC.PinRefresh()
end
_0x2976(_0x6A18)
local _0xF8D7 = _0x9860.WSync and _0x9860.WSync[_0x6A18]
if _0xF8D7 then _0xF8D7.Pin(_0xB148.Pinned) end
end
_0xC94A = function(_0x6A18, _0x97B0)
local _0xB148 = _0x7DB1.Widgets[_0x6A18]
if not _0xB148 then return end
_0x97B0 = _0x97B0 and true or false
_0xB148.Enabled = _0x97B0
local _0x46EC, _0x9B13 = _0x181D[_0x6A18], _0x9FE2[_0x6A18]
if _0x9B13 and _0x46EC then
if _0x97B0 then_0x9B13.Parent = _0x46EC.Body
_0x9B13.Visible = true
_0x9B13.Position = UDim2.new()
if _0xAEF4[_0x6A18] then _0xAEF4[_0x6A18].Visible = false end
if _0xF5B8 == _0x6A18 then
_0xF5B8 = nil
for _0x3AE9, _0x1CA9 in ipairs(_0x2287) do
if _0xC8F9(_0x1CA9) then
_0x2D01(_0x1CA9)
break
end
end
end
else_0x9B13.Parent = _0xF73C
_0x9B13.Visible = false
if _0xAEF4[_0x6A18] then _0xAEF4[_0x6A18].Visible = true end
_0x2D01(_0x6A18)
end
end
_0x2976(_0x6A18)
local _0xF8D7 = _0x9860.WSync and _0x9860.WSync[_0x6A18]
if _0xF8D7 then _0xF8D7.Show(_0x97B0) end
end
local function _0xF922(_0x6A18, _0x46EC, _0xCCD3, isTab)
local _0x2E83 = _0xBBFC("CanvasGroup", {
Name = _0x6A18 .."Widget", Parent = _0xC997, BorderSizePixel = 0, GroupTransparency = 1, Visible = false,
Size = UDim2.fromOffset(_0x46EC, _0xCCD3), Position = _0xABC8(_0x6A18, _0x46EC, _0xCCD3), ZIndex = 2,
})
_0x8F68(_0x2E83, { BackgroundColor3 ="Bg"})
_0xAC02(_0x2E83, 8)
_0x1B3E(_0x2E83)
local _0x80FC = _0xBBFC("UIScale", { Parent = _0x2E83, Scale = .96 })
local _0x2CB9 = _0x8FFF(_0x2E83, UDim2.new(1, 0, 0, 34),"Surface")
_0x8FFF(_0x2CB9, UDim2.new(1, 0, 0, 1),"Stroke", { Position = UDim2.new(0, 0, 1, -1) })
_0xA7CD(_0x2CB9, _0x6A18, 14, _0x110B.Bold,"Text", {
Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -130, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd,
})
local _0xB465: { [string]: _0xEF28 } = { _0x8FFF = _0x2E83, Scale = _0x80FC, Token = 0, Name = _0x6A18 }
local _0xF88B = _0xBF78(_0x2CB9, isTab and"Dock"or"Hide", {
Size = UDim2.fromOffset(46, 22), TextSize = 11,
OnClick = function() _0xC94A(_0x6A18, false) end,
})
_0xF88B.AnchorPoint = Vector2.new(1, .5)
_0xF88B.Position = UDim2.new(1, -8, .5, 0)
local _0xD6F1, _0xCA2C = _0xBF78(_0x2CB9,"Pin", {
Size = UDim2.fromOffset(62, 22), TextSize = 11,
Active = function() return _0x7DB1.Widgets[_0x6A18].Pinned end,
OnClick = function() _0xFA40(_0x6A18, not _0x7DB1.Widgets[_0x6A18].Pinned) end,
})
_0xD6F1.AnchorPoint = Vector2.new(1, .5)
_0xD6F1.Position = UDim2.new(1, -60, .5, 0)
_0xB465.PinBtn, _0xB465.PinRefresh = _0xD6F1, _0xCA2C
_0xB465.Body = _0x8FFF(_0x2E83, UDim2.new(1, 0, 1, -34), nil, { Position = UDim2.fromOffset(0, 34), ClipsDescendants = true })
_0x253F(_0x2CB9, _0x2E83, function() _0x8104(_0x2E83) end)
_0x2E83.InputBegan:Connect(function(_0x3A85)
if _0x3A85.UserInputType == Enum.UserInputType.MouseButton1 or _0x3A85.UserInputType == Enum.UserInputType.Touch then
_0x8104(_0x2E83)
end
end)
_0x181D[_0x6A18] = _0xB465
return _0xB465
endlocal _0x8E35, _0x9BD7 = 236, 224
local _0x98AB
do
local _0xB465 = _0xF922("Performance", _0x8E35, _0x9BD7)
local _0x42E8 = _0xB465.Body
_0xA7CD(_0x42E8,"FPS", 12, _0x110B.Med,"Sub", { Position = UDim2.fromOffset(12, 10), Size = UDim2.fromOffset(60, 16) })
local _0xCBDD = _0xA7CD(_0x42E8,"--", 20, _0x110B.Bold,"Text", {
Position = UDim2.new(1, -112, 0, 4), Size = UDim2.fromOffset(100, 24), TextXAlignment = Enum.TextXAlignment.Right,
})
local _0xA790 = _0xC6DD(_0x42E8, UDim2.fromOffset(12, 32), UDim2.new(1, -24, 0, 34), 30)
_0xA7CD(_0x42E8,"Ping", 12, _0x110B.Med,"Sub", { Position = UDim2.fromOffset(12, 76), Size = UDim2.fromOffset(60, 16) })
local _0x9058 = _0xA7CD(_0x42E8,"--", 20, _0x110B.Bold,"Text", {
Position = UDim2.new(1, -112, 0, 70), Size = UDim2.fromOffset(100, 24), TextXAlignment = Enum.TextXAlignment.Right,
})
local _0x5489 = _0xC6DD(_0x42E8, UDim2.fromOffset(12, 98), UDim2.new(1, -24, 0, 34), 30)
_0xA7CD(_0x42E8,"Memory", 12, _0x110B.Med,"Sub", { Position = UDim2.fromOffset(12, 142), Size = UDim2.fromOffset(80, 16) })
local _0x1731 = _0xA7CD(_0x42E8,"--", 13, _0x110B.Med,"Text", {
Position = UDim2.new(1, -112, 0, 141), Size = UDim2.fromOffset(100, 18), TextXAlignment = Enum.TextXAlignment.Right,
})
_0xA7CD(_0x42E8,"Players", 12, _0x110B.Med,"Sub", { Position = UDim2.fromOffset(12, 163), Size = UDim2.fromOffset(80, 16) })
local _0x04D8 = _0xA7CD(_0x42E8,"--", 13, _0x110B.Med,"Text", {
Position = UDim2.new(1, -112, 0, 162), Size = UDim2.fromOffset(100, 18), TextXAlignment = Enum.TextXAlignment.Right,
})
local _0xF111, _0x3CE3 = {}, {}
local function _0xA6CE(_0x735B, _0x97B0)
table.insert(_0x735B, _0x97B0)
if #_0x735B > 30 then table.remove(_0x735B, 1) end
end
_0x98AB = function(_0xBA80, _0x8762)
_0xA6CE(_0xF111, _0xBA80)
_0xA6CE(_0x3CE3, _0x8762)
if not _0xB465.Frame.Visible then return end
_0xCBDD.Text = tostring(_0xBA80)
_0xCBDD.TextColor3 = _0xBA80 >= 50 and _0x7870.Good or (_0xBA80 >= 30 and _0x7870.Warn or _0x7870.Bad)
_0x9058.Text = _0x8762 .." ms"_0x9058.TextColor3 = _0x8762 <= 100 and _0x7870.Good or (_0x8762 <= 200 and _0x7870.Warn or _0x7870.Bad)
local _0x6B1B = 150
for _0x3AE9, _0xE0D1 in ipairs(_0x3CE3) do _0x6B1B = math.max(_0x6B1B, _0xE0D1) end
_0xA790(_0xF111, math.max(120, table.unpack(_0xF111)))
_0x5489(_0x3CE3, _0x6B1B)
_0x1731.Text = math.floor(_0x6AC8:GetTotalMemoryUsageMb() + .5) .." MB"_0x04D8.Text = #_0x0102:GetPlayers() .." / ".. _0x0102.MaxPlayers
end
enddo
local _0xB465 = _0xF922("Keybinds", 236, 110)
local _0xC1D6 = _0xBBFC("ScrollingFrame", {
Parent = _0xB465.Body, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0,
ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollingDirection = Enum.ScrollingDirection.Y,
})
_0x8F68(_0xC1D6, { ScrollBarImageColor3 ="Sub"})
_0xBB73(_0xC1D6, 10, 8, 10, 8)
_0x126D(_0xC1D6, 4)
local function _0xFF36()
for _0x3AE9, _0xED20 in ipairs(_0xC1D6:GetChildren()) do
if _0xED20:IsA("Frame") or _0xED20:IsA("TextLabel") then
_0xED20:Destroy()
end
end
local _0x191C = {}
for _0x3AE9, _0x3CA5 in ipairs(_0x72F8) do
if _0x3CA5.Key then table.insert(_0x191C, _0x3CA5) end
end
table.sort(_0x191C, function(_0xB7C5, _0x3D2C) return _0xB7C5.Name < _0x3D2C.Name end)
if #_0x191C == 0 then
_0xA7CD(_0xC1D6,"No keybinds yet. Right-click a command in the Commands tab to set one.", 12, _0x110B.Reg,"Sub", {
Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
})
end
for _0x3A85, _0x3CA5 in ipairs(_0x191C) do
local _0x5C16 = _0x8FFF(_0xC1D6, UDim2.new(1, 0, 0, 24), nil, { LayoutOrder = _0x3A85 })
_0xA7CD(_0x5C16, _0x3CA5.Name, 13, _0x110B.Med,"Text", { Size = UDim2.new(1, -70, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd })
local _0x009D = _0x50AA(_0x5C16, _0x9AE5(_0x3CA5.Key), true)
_0x009D.AnchorPoint = Vector2.new(1, .5)
_0x009D.Position = UDim2.new(1, 0, .5, 0)
end
local _0xCCD3 = #_0x191C == 0 and 96 or (34 + 16 + #_0x191C * 28)
_0x6A54(_0xB465.Frame, .25, { Size = UDim2.fromOffset(236, math.clamp(_0xCCD3, 96, 300)) })
end
table.insert(_0xC398, _0xFF36)
_0xFF36()
end_0x1E3F = function(_0xF193)
if _0xF193 == _0xD03D then return end
_0xD03D = _0xF193
local _0x2802 = 1 - _0x7DB1.Opacity
if _0xF193 then
_0x0DFA.Visible = true
_0x6A54(_0x0DFA, .35, { BackgroundTransparency = _0x7DB1.Dim and .5 or 1 })
_0x90EB.Visible, _0x51F1.Visible = true, true
_0x90EB.Position = UDim2.new(.5, 0, 0, -10)
_0x6A54(_0x90EB, .45, { GroupTransparency = _0x2802, Position = _0x2916 })
_0x6A54(_0x51F1, .4, { GroupTransparency = _0x2802 })
_0x6A54(_0x9FCF, .5, { Scale = 1 }, Enum.EasingStyle.Back)
else
if _0x9860.HideContext then _0x9860.HideContext() end
_0x4602()
_0x6A54(_0x0DFA, .25, { BackgroundTransparency = 1 })
_0x6A54(_0x9FCF, .25, { Scale = .96 })
_0x6A54(_0x90EB, .25, { GroupTransparency = 1, Position = UDim2.new(.5, 0, 0, -10) })
local _0xD64B = _0x6A54(_0x51F1, .25, { GroupTransparency = 1 })
_0xD64B.Completed:Connect(function()
if not _0xD03D then
_0x51F1.Visible, _0x90EB.Visible, _0x0DFA.Visible = false, false, false
end
end)
end
_0xA7E2()
end
local function _0x241E(_0x2802)
_0x7DB1.Opacity = math.clamp(_0x2802, .4, 1)
if _0xD03D then
_0x6A54(_0x51F1, .2, { GroupTransparency = 1 - _0x7DB1.Opacity })
_0x6A54(_0x90EB, .2, { GroupTransparency = 1 - _0x7DB1.Opacity })
end
_0xA7E2()
end
local function _0x7E04(_0x97B0)
_0x7DB1.Dim = _0x97B0 and true or false
if _0xD03D then
_0x6A54(_0x0DFA, .25, { BackgroundTransparency = _0x7DB1.Dim and .5 or 1 })
end
if _0x9860.DimSet then _0x9860.DimSet(_0x7DB1.Dim) end
end
local _0x56CE = _0x8FFF(_0xC997, UDim2.fromOffset(68, 34),"Accent", {
Position = UDim2.new(1, -88, .5, -17), Active = true, ZIndex = 50, Visible = _0x7DB1.MobileButton,
})
_0xAC02(_0x56CE, 6)
_0xA7CD(_0x56CE,"Mantle", 14, _0x110B.Bold,"AccentText", {
Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, ZIndex = 51,
})
do
local _0x5556, _0x35D9, _0xE9E0, _0x2306 = false, false, nil, nil
_0x56CE.InputBegan:Connect(function(_0x3A85)
if _0x3A85.UserInputType == Enum.UserInputType.Touch or _0x3A85.UserInputType == Enum.UserInputType.MouseButton1 then
_0x5556, _0x35D9, _0x2306, _0xE9E0 = true, false, _0x3A85.Position, _0x56CE.Position
_0x3A85.Changed:Connect(function()
if _0x3A85.UserInputState == Enum.UserInputState.End then
_0x5556 = false
if not _0x35D9 then _0x1E3F(not _0xD03D) end
end
end)
end
end)
_0x5951(_0x22C9.InputChanged, function(_0x3A85)
if _0x5556 and (_0x3A85.UserInputType == Enum.UserInputType.Touch or _0x3A85.UserInputType == Enum.UserInputType.MouseMovement) then
local _0x5D96 = _0x3A85.Position - _0x2306
if _0x5D96.Magnitude > 6 then _0x35D9 = true end
if _0x35D9 then
_0x56CE.Position = UDim2.new(_0xE9E0.X.Scale, _0xE9E0.X.Offset + _0x5D96.X, _0xE9E0.Y.Scale, _0xE9E0.Y.Offset + _0x5D96.Y)
end
end
end)
end
local function _0x1863(_0x97B0)
_0x7DB1.MobileButton = _0x97B0 and true or false
_0x56CE.Visible = _0x7DB1.MobileButton
if _0x9860.MobileSet then _0x9860.MobileSet(_0x7DB1.MobileButton) end
endlocal _0xB324 = function() end
local function _0x78AC(_0x6A18, instant)
if not _0x8F19[_0x6A18] then return end
_0x7DB1.Theme = _0x6A18
_0x7870 = _0x8F19[_0x6A18]
_0x7B63()
for _0x3AE9, _0xEEC5 in ipairs(_0x3717) do
local _0x97B0 = _0xEEC5.get()
if instant then
_0xEEC5.inst[_0xEEC5.prop] = _0x97B0
else
_0x6A54(_0xEEC5.inst, .3, { [_0xEEC5.prop] = _0x97B0 })
end
end
_0xB324()
end
function _0x180A.SetNotifyStyle(_0x6A18, silent)
if not table.find(_0x180A.NotifyStyles, _0x6A18) then return end
_0x7DB1.NotifyStyle = _0x6A18
if _0x9860.NotifySet then _0x9860.NotifySet() end
if not silent then _0x6DB0("Notifications","Style set to ".. _0x6A18,"info") end
end
local function _0xA311(_0x1CA9)
local _0xF74B, _0x97B0 = pcall(function() return Enum.KeyCode[_0x1CA9] end)
return _0xF74B and _0x97B0 ~= nil
end
local function _0xCB0F(_0x6A18)
_0x7DB1.Keybind = _0x6A18
_0xEA0A.Text = _0x6A18 .." shows / hides Mantle   ·   use the Command Bar widget to run commands"if _0x9860.KeybindSet then _0x9860.KeybindSet(_0x6A18) end
endlocal _0xC261, _0xF5BB
do
local _0x152E = game:GetService("ContentProvider")
local _0x80C4 = 0
_0xC261 = function(_0x2802)
_0x7DB1.BgOpacity = math.clamp(_0x2802, 0, 1)
if _0xB400 then _0xB400.ImageTransparency = 1 - _0x7DB1.BgOpacity end
end_0xF5BB = function(raw)
local _0x50FF = raw and tostring(raw):match("%d+") or nil
_0x7DB1.BgImage = _0x50FF or""if not _0xB400 then return end
_0x80C4 += 1
local _0xBCC4 = _0x80C4
if _0x9860.BgSet then _0x9860.BgSet(_0x7DB1.BgImage) end
if not _0x50FF then
_0xB400.Image =""_0xB400.Visible = false
return
end
_0xB400.Image ="rbxassetid://".. _0x50FF
_0xB400.Visible = true
task.spawn(function()
local _0x6A0D = false
pcall(function()
_0x152E:PreloadAsync({ _0xB400 }, function(_0x3AE9, _0x167A)
if _0x167A ~= Enum.AssetFetchStatus.Success then _0x6A0D = true end
end)
end)if _0x6A0D and _0xBCC4 == _0x80C4 then
_0xB400.Image = ("rbxthumb://type=Asset&id=%s&w=420&h=420"):format(_0x50FF)
_0x84A5("info","Background ".. _0x50FF .." loaded through its thumbnail (looks like a Decal ID)")
end
end)
end
endlocal _0xC536 = _0xF922("Command Bar", 380, 118)
local _0xAE59, _0xC7C4 = _0x4C0A(_0xC536.Body,"Type a command and press Enter  (help for list)", UDim2.new(1, -20, 0, 34))
_0xAE59.Position = UDim2.fromOffset(10, 10)
_0xC7C4.TextSize = _0x79E1(15)
local _0x3308 ="Enter runs it  ·  Up / Down recalls earlier commands"local _0xFA1E = _0xA7CD(_0xC536.Body, _0x3308, 12, _0x110B.Med,"Sub", {
Position = UDim2.fromOffset(12, 52), Size = UDim2.new(1, -24, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
})
local function _0x3ACE(_0x1877)
local _0x2CB9 = (_0x1877:match("^%s*(%S*)") or""):lower()
if _0x2CB9 ==""then
_0xFA1E.Text = _0x3308
return
end
local _0x3CA5 = _0xB283[_0x2CB9]
if _0x3CA5 and _0x1877:find("^%s*%S+%s") then
local _0xC4BC = {}
for _0x3AE9, inp in ipairs(_0x3CA5.Inputs or {}) do
if inp.Type =="number"or inp.Type =="player"or inp.Type =="text"then
table.insert(_0xC4BC,"<".. inp.Label:lower() ..">")
end
end
if _0x3CA5.Kind =="Toggle"then table.insert(_0xC4BC,"[on|off]") end
if _0x3CA5.Stop then table.insert(_0xC4BC,"[off]") end
_0xFA1E.Text = _0x3714(_0x3CA5.Name) .." ".. table.concat(_0xC4BC," ")
return
end
local _0xEF9E = {}
for _0x3AE9, _0xED20 in ipairs(_0x72F8) do
local _0xE627 = _0x3714(_0xED20.Name):sub(1, #_0x2CB9) == _0x2CB9
if not _0xE627 then
for _0x3AE9, _0xB7C5 in ipairs(_0xED20.Aliases or {}) do
if _0xB7C5:sub(1, #_0x2CB9) == _0x2CB9 then _0xE627 = true break end
end
end
if _0xE627 then table.insert(_0xEF9E, _0x3714(_0xED20.Name)) end
end
for _0x3AE9, _0x1CA9 in ipairs({"help","perf","keys","lua"}) do
if _0x1CA9:sub(1, #_0x2CB9) == _0x2CB9 then table.insert(_0xEF9E, _0x1CA9) end
end
_0xFA1E.Text = #_0xEF9E > 0 and table.concat(_0xEF9E,"   ", 1, math.min(#_0xEF9E, 8)) or"No matching command"end
local _0x33AA, _0x21C8 = {}, 0
_0x54FF = function()
if not _0x7DB1.Widgets["Command Bar"].Enabled then
_0xC94A("Command Bar", true)
end
_0xC7C4:CaptureFocus()
end
_0xC7C4:GetPropertyChangedSignal("Text"):Connect(function()
_0x3ACE(_0xC7C4.Text)
end)
_0xC7C4.FocusLost:Connect(function(enter)
local _0x735B = _0xC7C4.Text
_0x21C8 = 0
if enter and _0x735B:match("%S") then
_0xC7C4.Text =""table.insert(_0x33AA, _0x735B)
if #_0x33AA > 50 then table.remove(_0x33AA, 1) end
_0x530A(_0x735B)
end
end)
_0x5951(_0x22C9.InputBegan, function(input)
if not _0xC7C4:IsFocused() then return end
if input.KeyCode == Enum.KeyCode.Up then
_0x21C8 = math.min(_0x21C8 + 1, #_0x33AA)
elseif input.KeyCode == Enum.KeyCode.Down then
_0x21C8 = math.max(_0x21C8 - 1, 0)
else
return
end
_0xC7C4.Text = _0x21C8 == 0 and""or _0x33AA[#_0x33AA - _0x21C8 + 1]
_0xC7C4.CursorPosition = #_0xC7C4.Text + 1
end)do
local _0xB465 = _0xF922("Command History", 260, 250)
local _0x5FC9 = _0xBF78(_0xB465.Body,"Clear history", {
Size = UDim2.new(1, -20, 0, 26), TextSize = 12,
OnClick = function()
table.clear(_0x5795)
_0xBBAC:Fire()
end,
})
_0x5FC9.Position = UDim2.fromOffset(10, 8)
local _0xC1D6 = _0xBBFC("ScrollingFrame", {
Parent = _0xB465.Body, Position = UDim2.fromOffset(0, 42), Size = UDim2.new(1, 0, 1, -42), BackgroundTransparency = 1,
BorderSizePixel = 0, ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollingDirection = Enum.ScrollingDirection.Y,
})
_0x8F68(_0xC1D6, { ScrollBarImageColor3 ="Sub"})
_0xBB73(_0xC1D6, 10, 2, 10, 8)
_0x126D(_0xC1D6, 2)
local function _0x9B3A()
_0x7B63()
for _0x3AE9, _0xED20 in ipairs(_0xC1D6:GetChildren()) do
if _0xED20:IsA("Frame") or _0xED20:IsA("TextLabel") then _0xED20:Destroy() end
end
if #_0x5795 == 0 then
_0xA7CD(_0xC1D6,"Nothing yet. Commands you run show up here.", 12, _0x110B.Reg,"Sub", {
Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
})
return
end
for _0x3A85 = #_0x5795, 1, -1 dolocal _0xEEC5 = _0x5795[_0x3A85]
local _0x228B = _0x8FFF(_0xC1D6, UDim2.new(1, 0, 0, 20), nil, { LayoutOrder = #_0x5795 - _0x3A85 })
_0xA7CD(_0x228B, _0xEEC5.Time, 11, _0x110B.Reg,"Sub", { Size = UDim2.fromOffset(58, 20) })
_0xA7CD(_0x228B, _0xEEC5.Text, 12, _0x110B.Med, _0xEEC5.Ok and"Text"or"Bad", {
Position = UDim2.fromOffset(60, 0), Size = UDim2.new(1, -60, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd,
})
end
end
_0x5951(_0xBBAC.Event, _0x9B3A)
_0x9B3A()
enddo
local _0xB465 = _0xF922("Command List", 320, 330)
local _0x1775, _0x9F69 = _0x4C0A(_0xB465.Body,"Search commands…", UDim2.new(1, -20, 0, 30))
_0x1775.Position = UDim2.fromOffset(10, 8)
local _0xC1D6 = _0xBBFC("ScrollingFrame", {
Parent = _0xB465.Body, Position = UDim2.fromOffset(0, 46), Size = UDim2.new(1, 0, 1, -46), BackgroundTransparency = 1,
BorderSizePixel = 0, ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollingDirection = Enum.ScrollingDirection.Y,
})
_0x8F68(_0xC1D6, { ScrollBarImageColor3 ="Sub"})
_0xBB73(_0xC1D6, 10, 2, 10, 10)
_0x126D(_0xC1D6, 6)
local _0xB569 = {}
for _0x3A85, _0x3CA5 in ipairs(_0x72F8) do
local _0x228B = _0x8FFF(_0xC1D6, UDim2.new(1, 0, 0, 46),"Surface", { LayoutOrder = _0x3A85 })
_0xAC02(_0x228B, 8)
_0x1B3E(_0x228B)
_0xA7CD(_0x228B, _0x3CA5.Name, 13, _0x110B.Med,"Text", { Position = UDim2.fromOffset(10, 6), Size = UDim2.new(1, -100, 0, 17), TextTruncate = Enum.TextTruncate.AtEnd })
local _0x9A20 = _0xA7CD(_0x228B, _0x3CA5.Desc, 11, _0x110B.Reg,"Sub", { Position = UDim2.fromOffset(10, 25), Size = UDim2.new(1, -100, 0, 14), TextTruncate = Enum.TextTruncate.AtEnd })
local function _0x1877()
if _0x3CA5.Kind =="Toggle"then return _0x3CA5.Enabled and"On"or"Off"end
return (_0x3CA5.Stop and _0x3CA5.Enabled) and"Stop"or"Run"end
local _0x67B3, _0x920B = _0xBF78(_0x228B, _0x1877(), {
Size = UDim2.fromOffset(62, 28), TextSize = 12,
Active = function() return _0x3CA5.Enabled end,
OnClick = function() _0x478A(_0x3CA5) end,
})
_0x67B3.AnchorPoint = Vector2.new(1, .5)
_0x67B3.Position = UDim2.new(1, -8, .5, 0)
_0x3CA5.Listeners[function()
_0x67B3.Text = _0x1877()
_0x920B()
end] = true
_0x3CA5.KeyListeners[function(_0xB2C2)
_0x9A20.Text = _0xB2C2 and ("[".. _0x9AE5(_0xB2C2) .."]  ".. _0x3CA5.Desc) or _0x3CA5.Desc
end] = true
table.insert(_0xB569, { frame = _0x228B, hay = (_0x3CA5.Name .." ".. _0x3CA5.Desc):lower() })
end
_0x9F69:GetPropertyChangedSignal("Text"):Connect(function()
local _0xFB5A = _0x9F69.Text:lower()
for _0x3AE9, _0x5C16 in ipairs(_0xB569) do
_0x5C16.frame.Visible = _0xFB5A ==""or _0x5C16.hay:find(_0xFB5A, 1, true) ~= nil
end
end)
endlocal _0x8358
do
_0x8358 = _0xBBFC("ScreenGui", {
Name ="MantleConsole", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
IgnoreGuiInset = true, DisplayOrder = 1001, Enabled = false, Parent = _0xC997.Parent,
})
local _0x5EC3 = _0xBBFC("CanvasGroup", {
Parent = _0x8358, AnchorPoint = Vector2.new(.5, .5), Position = UDim2.fromScale(.5, .5),
Size = UDim2.fromOffset(540, 320), BorderSizePixel = 0,
})
_0x8F68(_0x5EC3, { BackgroundColor3 ="Bg"})
_0xAC02(_0x5EC3, 8)
_0x1B3E(_0x5EC3)
local _0x2CB9 = _0x8FFF(_0x5EC3, UDim2.new(1, 0, 0, 40),"Surface")
_0x8FFF(_0x2CB9, UDim2.new(1, 0, 0, 1),"Stroke", { Position = UDim2.new(0, 0, 1, -1) })
_0xA7CD(_0x2CB9,"Console", 15, _0x110B.Bold,"Text", { Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -220, 1, 0) })
local _0xC1D6 = _0xBBFC("ScrollingFrame", {
Parent = _0x5EC3, Position = UDim2.fromOffset(0, 40), Size = UDim2.new(1, 0, 1, -40), BackgroundTransparency = 1,
BorderSizePixel = 0, ScrollBarThickness = 4, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollingDirection = Enum.ScrollingDirection.Y,
})
_0x8F68(_0xC1D6, { ScrollBarImageColor3 ="Sub"})
_0xBB73(_0xC1D6, 12, 8, 12, 8)
_0x126D(_0xC1D6, 3)
_0x253F(_0x2CB9, _0x5EC3)
local _0x1CAA, _0xF911 = {}, 0
local _0x99AF = { _0x1CDB ="Accent", success ="Good", warn ="Warn", error ="Bad"}
local _0x271C = { _0x1CDB ="INFO", success ="OK", warn ="WARN", error ="ERROR"}
local function _0xDCFB(_0x98DE)
return (_0x98DE:gsub("&","&amp;"):gsub("<","&lt;"):gsub(">","&gt;"))
end
local function _0xF503(_0xEEC5)
_0xF911 += 1
local _0x6DE1 = _0x7870[_0x99AF[_0xEEC5.Level] or"Accent"]
local _0x8372 = _0xBBFC("TextLabel", {
Parent = _0xC1D6, BackgroundTransparency = 1, BorderSizePixel = 0, RichText = true, LayoutOrder = _0xF911,
Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
TextXAlignment = Enum.TextXAlignment.Left, Font = _0x110B.Code, TextSize = 12,
Text = ('<font color="#%s">%s</font>  <font color="#%s"><b>%-5s</b></font>  %s'):format(
_0x7870.Sub:ToHex(), _0xEEC5.Time, _0x6DE1:ToHex(), _0x271C[_0xEEC5.Level] or"INFO", _0xDCFB(_0xEEC5.Msg)
),
})
_0x8F68(_0x8372, { TextColor3 ="Text"})
table.insert(_0x1CAA, _0x8372)
if #_0x1CAA > 250 then
table.remove(_0x1CAA, 1):Destroy()
end
task.defer(function()
_0xC1D6.CanvasPosition = Vector2.new(0, 1e6)
end)
end
_0xB324 = function()
for _0x3AE9, _0x8372 in ipairs(_0x1CAA) do _0x8372:Destroy() end
table.clear(_0x1CAA)
for _0x3AE9, _0xEEC5 in ipairs(_0x1E9B) do _0xF503(_0xEEC5) end
end
_0xFF7D.Event:Connect(_0xF503)
local _0x5FC9 = _0xBF78(_0x2CB9,"Clear", { Size = UDim2.fromOffset(60, 26) })
_0x5FC9.AnchorPoint = Vector2.new(1, .5)
_0x5FC9.Position = UDim2.new(1, -78, .5, 0)
_0x5FC9.MouseButton1Click:Connect(function()
table.clear(_0x1E9B)
_0xB324()
end)
local _0x5DA2 = _0xBF78(_0x2CB9,"Close", { Size = UDim2.fromOffset(58, 26), Variant ="Primary"})
_0x5DA2.AnchorPoint = Vector2.new(1, .5)
_0x5DA2.Position = UDim2.new(1, -12, .5, 0)
_0x5DA2.MouseButton1Click:Connect(function()
_0x8358.Enabled = false
end)
endlocal _0x3751, _0xC25C, _0x249F, _0x3FBD
local _0x08B7 = {}
local function _0xAC3A(img, userId)
if _0x08B7[userId] then
img.Image = _0x08B7[userId]
return
end
task.spawn(function()
local _0xF74B, _0x3919 = pcall(_0x0102.GetUserThumbnailAsync, _0x0102, userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
if _0xF74B and _0x3919 then
_0x08B7[userId] = _0x3919
if img.Parent then img.Image = _0x3919 end
end
end)
enddo
local _0xFA4B = _0x604B("Home")
_0xA7CD(_0xFA4B,"Welcome, ".. _0x0F7F.Name, 22, _0x110B.Bold,"Text", { Size = UDim2.new(1, 0, 0, 28), LayoutOrder = 1 })
_0xA7CD(_0xFA4B,"Your Mantle overview", 12, _0x110B.Reg,"Sub", { Size = UDim2.new(1, 0, 0, 14), LayoutOrder = 2 })local _0x8F22 = _0x8FFF(_0xFA4B, UDim2.new(1, 0, 0, 100),"Surface", { LayoutOrder = 3 })
_0xAC02(_0x8F22, 8)
_0x1B3E(_0x8F22)
local _0x0112 = _0xBBFC("ImageLabel", {
Parent = _0x8F22, Size = UDim2.fromOffset(72, 72), Position = UDim2.fromOffset(14, 14), BorderSizePixel = 0,
})
_0x8F68(_0x0112, { BackgroundColor3 ="Surface2"})
_0xAC02(_0x0112, 36)
_0x1B3E(_0x0112,"Accent", 2)
_0xAC3A(_0x0112, _0x0F7F.UserId)
_0xA7CD(_0x8F22, _0x0F7F.DisplayName, 18, _0x110B.Bold,"Text", { Position = UDim2.fromOffset(100, 14), Size = UDim2.new(1, -114, 0, 22) })
_0xA7CD(_0x8F22,"@".. _0x0F7F.Name, 12, _0x110B.Reg,"Sub", { Position = UDim2.fromOffset(100, 38), Size = UDim2.new(1, -114, 0, 16) })
local _0x9F48 = _0x8FFF(_0x8F22, UDim2.new(1, -114, 0, 22), nil, { Position = UDim2.fromOffset(100, 64) })
_0x126D(_0x9F48, 6, Enum.FillDirection.Horizontal)
_0x50AA(_0x9F48,"Mantle v".. _0xC9DA, true)
_0x50AA(_0x9F48,"Account age: ".. _0x0F7F.AccountAge .." days")local _0xDB8E = _0x0012(_0xFA4B,"Game Info", 4)
local _0x4A6E = _0x8FFF(_0xDB8E, UDim2.new(1, 0, 0, 64), nil)
local _0xB950 = _0xBBFC("ImageLabel", {
Parent = _0x4A6E, Size = UDim2.fromOffset(64, 64), BorderSizePixel = 0, ScaleType = Enum.ScaleType.Crop,
Image = game.GameId ~= 0 and ("rbxthumb://type=GameIcon&id=".. game.GameId .."&w=150&h=150") or"",
})
_0x8F68(_0xB950, { BackgroundColor3 ="Surface2"})
_0xAC02(_0xB950, 10)
_0x1B3E(_0xB950)
local _0x1E7E = _0xA7CD(_0x4A6E, game.Name ~=""and game.Name or"Unknown game", 16, _0x110B.Bold,"Text", {
Position = UDim2.fromOffset(76, 8), Size = UDim2.new(1, -76, 0, 24), TextTruncate = Enum.TextTruncate.AtEnd,
})
local _0x7A22 = _0xA7CD(_0x4A6E,"", 12, _0x110B.Reg,"Sub", {
Position = UDim2.fromOffset(76, 34), Size = UDim2.new(1, -76, 0, 16), TextTruncate = Enum.TextTruncate.AtEnd,
})
task.spawn(function()local _0xF74B, _0x1CDB = pcall(function()
return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
end)
if _0xF74B and type(_0x1CDB) =="table"then
if _0x1E7E.Parent and type(_0x1CDB.Name) =="string"and _0x1CDB.Name ~=""then _0x1E7E.Text = _0x1CDB.Name end
if _0x7A22.Parent and type(_0x1CDB.Creator) =="table"and _0x1CDB.Creator.Name then _0x7A22.Text ="by ".. tostring(_0x1CDB.Creator.Name) end
end
end)
local function _0x01A7(_0x7824, _0xB2C2)
local _0x5C16 = _0x8FFF(_0x7824, UDim2.new(1, 0, 0, 18), nil)
_0xA7CD(_0x5C16, _0xB2C2, 12, _0x110B.Reg,"Sub", { Size = UDim2.new(.35, 0, 1, 0) })
return _0xA7CD(_0x5C16,"", 12, _0x110B.Med,"Text", {
Position = UDim2.fromScale(.35, 0), Size = UDim2.fromScale(.65, 1), TextTruncate = Enum.TextTruncate.AtEnd,
})
end
local _0x1547, _0xDFB3 = _0x01A7(_0xDB8E,"Place ID"), _0x01A7(_0xDB8E,"Job ID")
local _0x32FD, _0x4405 = _0x01A7(_0xDB8E,"Players"), _0x01A7(_0xDB8E,"Server uptime")
_0x1547.Text = tostring(game.PlaceId)
_0xDFB3.Text = game.JobId ~=""and game.JobId or"Studio"local _0xD018 = _0x8FFF(_0xDB8E, UDim2.new(1, 0, 0, 30), nil)
_0x126D(_0xD018, 8, Enum.FillDirection.Horizontal)
_0xBF78(_0xD018,"Copy Place ID", { AutoX = true, Height = 28, TextSize = 12, OnClick = function() _0x08C4(tostring(game.PlaceId),"Place ID") end })
_0xBF78(_0xD018,"Copy Job ID", { AutoX = true, Height = 28, TextSize = 12, OnClick = function() _0x08C4(game.JobId,"Job ID") end })local _0x238C = _0x0012(_0xFA4B,"General Info", 5)
local _0xCD88, _0x4AF9 = _0x01A7(_0x238C,"Scripts ran"), _0x01A7(_0x238C,"Mantle open for")
local _0x6DF2, _0x0E37 = _0x01A7(_0x238C,"Last script"), _0x01A7(_0x238C,"Active toggles")
local _0x1F87, _0xFE80 = _0x01A7(_0x238C,"Commands loaded"), _0x01A7(_0x238C,"Keybinds set")
local _0x131F, _0xFE72 = _0x01A7(_0x238C,"Theme"), _0x01A7(_0x238C,"Local time")
function _0x9860.InfoUpdate()
_0x32FD.Text = #_0x0102:GetPlayers() .." / ".. _0x0102.MaxPlayers
_0x4405.Text = _0xE13E(workspace.DistributedGameTime)
_0xCD88.Text = tostring(_0x0625.Scripts)
_0x4AF9.Text = _0xE13E(os.clock() - _0xEDE1)
_0x6DF2.Text = _0x0625.Last or"None yet"local _0xE847, _0x191C = 0, 0
for _0x3AE9, _0x3CA5 in ipairs(_0x72F8) do
if _0x3CA5.Kind =="Toggle"and _0x3CA5.Enabled then _0xE847 += 1 end
if _0x3CA5.Key then _0x191C += 1 end
end
_0x0E37.Text = tostring(_0xE847)
_0x1F87.Text = tostring(#_0x72F8)
_0xFE80.Text = tostring(_0x191C)
_0x131F.Text = _0x7DB1.Theme
_0xFE72.Text = (os.date("%I:%M %p"):gsub("^0",""))
end
_0x9860.InfoUpdate()local _0x25CA = _0x0012(_0xFA4B,"Quick Actions", 6)
local _0x8FE7 = _0x1937(_0x25CA)
local _0x41C2 = {}
function _0x9860.RebuildQuick()
for _0x3AE9, _0x3D2C in ipairs(_0x41C2) do
_0x3D2C.cmd.Listeners[_0x3D2C.fn] = nil
end
_0x41C2 = {}
for _0x3AE9, _0xED20 in ipairs(_0x8FE7:GetChildren()) do
if not _0xED20:IsA("UIListLayout") then _0xED20:Destroy() end
end
local _0xEF28 = false
for _0x3AE9, _0x6A18 in ipairs(_0x7DB1.QuickActions) do
local _0x3CA5 = _0xB283[_0x3714(_0x6A18)]
if _0x3CA5 then
_0xEF28 = true
local _0x3AE9, _0x920B = _0xBF78(_0x8FE7, _0x3CA5.Name, {
AutoX = true, Height = 32,
Active = function() return _0x3CA5.Kind =="Toggle"and _0x3CA5.Enabled end,
OnClick = function() _0xD168(_0x3CA5) end,
})
local _0x3B2A = function() _0x920B() end
_0x3CA5.Listeners[_0x3B2A] = true
table.insert(_0x41C2, { _0x3CA5 = _0x3CA5, _0x3B2A = _0x3B2A })
end
end
if not _0xEF28 then
_0xA7CD(_0x8FE7,"No quick actions selected. Pick some in Settings.", 12, _0x110B.Reg,"Sub", { Size = UDim2.new(1, 0, 0, 18) })
end
end
_0x9860.RebuildQuick()
enddo
local _0x3D2F = _0x604B("Commands")local _0xF762 = _0xBBFC("TextButton", {
Name ="ContextCatcher", Parent = _0xC997, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text ="",
AutoButtonColor = false, Visible = false, ZIndex = 79, BorderSizePixel = 0,
})
local _0x4D6E = _0xBBFC("CanvasGroup", {
Name ="Context", Parent = _0xC997, Size = UDim2.fromOffset(176, 0), AutomaticSize = Enum.AutomaticSize.Y,
BorderSizePixel = 0, Visible = false, ZIndex = 80, GroupTransparency = 1,
})
_0x8F68(_0x4D6E, { BackgroundColor3 ="Surface"})
_0xAC02(_0x4D6E, 8)
_0x1B3E(_0x4D6E)
_0xBB73(_0x4D6E, 5, 5, 5, 5)
_0x126D(_0x4D6E, 3)
local function _0xE210()
_0xF762.Visible = false
_0x4D6E.Visible = false
end
_0x9860.HideContext = _0xE210
_0xF762.MouseButton1Click:Connect(_0xE210)
_0xF762.MouseButton2Click:Connect(_0xE210)
local function _0x142D(_0x3CA5)
for _0x3AE9, _0xED20 in ipairs(_0x4D6E:GetChildren()) do
if _0xED20:IsA("TextButton") then _0xED20:Destroy() end
end
local _0x1CA9 = 0
local function _0xA78F(_0x1877, _0x3B2A)
_0x1CA9 += 1
_0xBF78(_0x4D6E, _0x1877, {
Size = UDim2.new(1, 0, 0, 28), TextSize = 12,
OnClick = function()
_0xE210()
_0x3B2A()
end,
})
end
_0xA78F(_0x3CA5.Key and ("Change Keybind  (".. _0x9AE5(_0x3CA5.Key) ..")") or"Set Keybind", function() _0xB0B7(_0x3CA5) end)
if _0x3CA5.Key then
_0xA78F("Clear Keybind", function()
_0x22C8(_0x3CA5, nil)
_0x6DB0(_0x3CA5.Name,"Keybind cleared","info")
end)
end
_0xA78F("Inspect", function() _0x342A(_0x3CA5) end)
local _0x2F1A = _0xAB02()
local _0xA3A3 = _0x22C9:GetMouseLocation()
local _0xCCD3 = _0x1CA9 * 31 + 7
_0x4D6E.Position = UDim2.fromOffset(math.clamp(_0xA3A3.X, 4, math.max(_0x2F1A.X - 180, 4)), math.clamp(_0xA3A3.Y, 4, math.max(_0x2F1A.Y - _0xCCD3 - 4, 4)))
_0xF762.Visible = true
_0x4D6E.Visible = true
_0x4D6E.GroupTransparency = 1
_0x6A54(_0x4D6E, .14, { GroupTransparency = 0 })
end
local _0x1775, _0x9F69 = _0x4C0A(_0x3D2F,"Search commands…")
_0x1775.LayoutOrder = 1
_0xA7CD(_0x3D2F,"Tip: use the Command Bar widget (or the  >_  button) to run a command by typing it. Right-click any command to set a keybind.", 12, _0x110B.Reg,"Sub", {
Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true, LayoutOrder = 2,
})
local _0xB569 = {}
local function _0xEBBD(_0x7824, _0x3CA5, inp)
local _0x8DDA = _0x8FFF(_0x7824, UDim2.new(1, 0, 0, 0), nil, { AutomaticSize = Enum.AutomaticSize.Y })
_0x126D(_0x8DDA, 6)
local _0x2CB9 = _0x8FFF(_0x8DDA, UDim2.new(1, 0, 0, 28), nil)
local _0xFEE2 = _0xA7CD(_0x2CB9, inp.Label, 12, _0x110B.Med,"Sub", {
Size = UDim2.new(inp.Type =="header"and 1 or .45, 0, 1, 0),
})
if inp.Type =="header"then_0xFEE2.Font = _0x110B.Bold
_0xFEE2.TextTruncate = Enum.TextTruncate.AtEnd
_0x8FFF(_0x2CB9, UDim2.new(1, 0, 0, 1),"Stroke", { Position = UDim2.new(0, 0, 1, -3) })
return
end
local _0xB2C2 = inp.Key
if inp.Type =="number"then
local _0xA52E, _0x5FEC = _0x4C0A(_0x2CB9,"", UDim2.fromOffset(110, 28))
_0xA52E.Position = UDim2.new(1, -110, 0, 0)
_0x5FEC.Text = tostring(inp.Default)
_0x5FEC.FocusLost:Connect(function()
local _0x1CA9 = tonumber(_0x5FEC.Text)
if _0x1CA9 then
_0x3CA5.Values[_0xB2C2] = math.clamp(_0x1CA9, inp.Min or -1e9, inp.Max or 1e9)
end
_0x5FEC.Text = tostring(_0x3CA5.Values[_0xB2C2])
end)
_0x3CA5.Setters[_0xB2C2] = function(_0x97B0)
_0x3CA5.Values[_0xB2C2] = _0x97B0
_0x5FEC.Text = tostring(_0x97B0)
end
elseif inp.Type =="bool"then
local _0x649C, _0xA2A3 = _0x8776(_0x2CB9, _0x3CA5.Values[_0xB2C2], function(_0x97B0) _0x3CA5.Values[_0xB2C2] = _0x97B0 end)
_0x649C.Position = UDim2.new(1, -40, .5, -11)
_0x3CA5.Setters[_0xB2C2] = function(_0x97B0)
_0x3CA5.Values[_0xB2C2] = _0x97B0
_0xA2A3(_0x97B0, true)
end
elseif inp.Type =="color"then
local _0x227C = _0x8FFF(_0x2CB9, UDim2.fromOffset(32, 18), nil, {
Position = UDim2.new(1, -32, .5, -9), BackgroundTransparency = 0, BackgroundColor3 = _0x3CA5.Values[_0xB2C2],
})
_0xAC02(_0x227C, 6)
_0x1B3E(_0x227C)
local _0x1A30 = {}
for _0x3A85 = 0, 6 do
table.insert(_0x1A30, ColorSequenceKeypoint.new(_0x3A85 / 6, Color3.fromHSV(_0x3A85 / 6, 1, 1)))
end
local _0x0E0F, _0x3914
local function _0xFC90(_0xED20)
_0x3CA5.Values[_0xB2C2] = _0xED20
_0x227C.BackgroundColor3 = _0xED20
end
_0x0E0F, _0x3914 = _0xA73E(_0x8DDA, 0, 1, (_0x3CA5.Values[_0xB2C2]:ToHSV()), function(_0xCCD3)
_0xFC90(Color3.fromHSV(_0xCCD3, 1, 1))
end, ColorSequence.new(_0x1A30))
local _0x649C = _0x8FFF(_0x8DDA, UDim2.new(1, 0, 0, 24), nil)
_0x126D(_0x649C, 6, Enum.FillDirection.Horizontal)
for _0x3AE9, _0x6DE1 in ipairs({ _0xF0DD(255, 70, 70), _0xF0DD(255, 150, 50), _0xF0DD(255, 220, 60), _0xF0DD(90, 220, 110), _0xF0DD(70, 200, 255), _0xF0DD(90, 120, 255), _0xF0DD(190, 100, 255), _0xF0DD(255, 255, 255) }) do
local _0x3D2C = _0xBBFC("TextButton", { Parent = _0x649C, Size = UDim2.fromOffset(24, 24), Text ="", AutoButtonColor = false, BorderSizePixel = 0, BackgroundColor3 = _0x6DE1 })
_0xAC02(_0x3D2C, 12)
_0x1B3E(_0x3D2C)
_0x3D2C.MouseButton1Click:Connect(function()
_0xFC90(_0x6DE1)
_0x3914((_0x6DE1:ToHSV()), true)
end)
end
_0x3CA5.Setters[_0xB2C2] = function(_0xED20)
_0xFC90(_0xED20)
_0x3914((_0xED20:ToHSV()), true)
end
elseif inp.Type =="text"then
local _0x3AE9, _0x5FEC = _0x4C0A(_0x8DDA, inp.Placeholder or"", UDim2.new(1, 0, 0, 30))
_0x5FEC.Text = tostring(_0x3CA5.Values[_0xB2C2] or"")
_0x5FEC.FocusLost:Connect(function()
_0x3CA5.Values[_0xB2C2] = _0x5FEC.Text
end)
_0x3CA5.Setters[_0xB2C2] = function(_0x97B0)
_0x3CA5.Values[_0xB2C2] = _0x97B0
_0x5FEC.Text = tostring(_0x97B0)
end
elseif inp.Type =="player"then
local _0x67B3 = _0xBF78(_0x2CB9,"Select player…", { Size = UDim2.fromOffset(190, 28) })
_0x67B3.Position = UDim2.new(1, -190, 0, 0)
local _0xC4DD = _0xBBFC("ScrollingFrame", {
Parent = _0x8DDA, Size = UDim2.new(1, 0, 0, 112), Visible = false, BorderSizePixel = 0,
ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
})
_0x8F68(_0xC4DD, { BackgroundColor3 ="Surface2", ScrollBarImageColor3 ="Sub"})
_0xAC02(_0xC4DD, 6)
_0xBB73(_0xC4DD, 6, 6, 6, 6)
_0x126D(_0xC4DD, 4)
local function _0xC195(_0x6A18)
_0x3CA5.Values[_0xB2C2] = _0x6A18
_0x67B3.Text = _0x6A18 or"Select player…"end
local function _0xFF36()
for _0x3AE9, _0xED20 in ipairs(_0xC4DD:GetChildren()) do
if _0xED20:IsA("TextButton") then _0xED20:Destroy() end
end
local _0x1CA9 = 0
for _0x3AE9, _0xE0D1 in ipairs(_0x0102:GetPlayers()) do
if _0xE0D1 ~= _0x0F7F then
_0x1CA9 += 1
local _0x156F = _0xE0D1.DisplayName == _0xE0D1.Name and _0xE0D1.Name or (_0xE0D1.DisplayName .."  (@".. _0xE0D1.Name ..")")
_0xBF78(_0xC4DD, _0x156F, {
Size = UDim2.new(1, -4, 0, 26), TextSize = 12,
OnClick = function()
_0xC195(_0xE0D1.Name)
_0xC4DD.Visible = false
end,
})
end
end
if _0x1CA9 == 0 then
_0xA7CD(_0xC4DD,"No other players", 12, _0x110B.Reg,"Sub", { Size = UDim2.new(1, 0, 0, 20) }).Parent = _0xC4DD
end
end
_0x67B3.MouseButton1Click:Connect(function()
_0xC4DD.Visible = not _0xC4DD.Visible
if _0xC4DD.Visible then _0xFF36() end
end)
table.insert(_0xCE29, function()
if _0xC4DD.Visible then _0xFF36() end
end)
_0x3CA5.Setters[_0xB2C2] = _0xC195
end
end
local function _0xDEAD(_0x3CA5, order)
local _0x228B = _0x8FFF(_0x3D2F, UDim2.new(1, 0, 0, 0),"Surface", { AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = order })
_0xAC02(_0x228B, 8)
_0x1B3E(_0x228B)
_0x126D(_0x228B, 0)
local _0x8DA9 = _0xBBFC("TextButton", {
Parent = _0x228B, Size = UDim2.new(1, 0, 0, 50), BackgroundTransparency = 1, Text ="", AutoButtonColor = false,
})
_0xA7CD(_0x8DA9, _0x3CA5.Name, 14, _0x110B.Med,"Text", { Position = UDim2.fromOffset(14, 8), Size = UDim2.new(1, -170, 0, 18) })
_0xA7CD(_0x8DA9, _0x3CA5.Desc, 11, _0x110B.Reg,"Sub", {
Position = UDim2.fromOffset(14, 28), Size = UDim2.new(1, -170, 0, 14), TextTruncate = Enum.TextTruncate.AtEnd,
})
local _0xDBAB = _0xA7CD(_0x8DA9,"", 11, _0x110B.Bold,"Sub", {
Position = UDim2.new(1, -150, 0, 0), Size = UDim2.fromOffset(66, 50), TextXAlignment = Enum.TextXAlignment.Right,
})
local _0x167A = _0xA7CD(_0x8DA9,"", 11, _0x110B.Bold,"Good", {
Position = UDim2.new(1, -78, 0, 0), Size = UDim2.fromOffset(52, 50), TextXAlignment = Enum.TextXAlignment.Right,
})
local _0xC254 = _0xA7CD(_0x8DA9,"›", 22, _0x110B.Med,"Sub", {
Position = UDim2.new(1, -26, 0, 0), Size = UDim2.fromOffset(16, 50), TextXAlignment = Enum.TextXAlignment.Center,
})
_0x8DA9.MouseButton2Click:Connect(function()
_0x142D(_0x3CA5)
end)
local _0xFD8F = _0x8FFF(_0x228B, UDim2.new(1, 0, 0, 0), nil, { ClipsDescendants = true, Visible = false })
local _0xF8F4 = _0x8FFF(_0xFD8F, UDim2.new(1, 0, 0, 0), nil, { AutomaticSize = Enum.AutomaticSize.Y })
_0xBB73(_0xF8F4, 14, 2, 14, 14)
_0x126D(_0xF8F4, 10)
for _0x3AE9, inp in ipairs(_0x3CA5.Inputs or {}) do
_0xEBBD(_0xF8F4, _0x3CA5, inp)
end
local _0x6B9E = _0x1937(_0xF8F4)
_0xBF78(_0x6B9E, _0x3CA5.Kind =="Toggle"and"Toggle"or"Run", {
Variant ="Primary", OnClick = function() _0xD168(_0x3CA5) end,
})
if _0x3CA5.Stop then
_0xBF78(_0x6B9E,"Stop", { OnClick = function() _0x045B(_0x3CA5) end })
end
_0xBF78(_0x6B9E,"Inspect", { OnClick = function() _0x342A(_0x3CA5) end })
local _0x5352 = _0xBF78(_0x6B9E,"Set Keybind", { AutoX = true, Height = 32, OnClick = function() _0xB0B7(_0x3CA5) end })
_0x3CA5.KeyListeners[function(_0xB2C2)
_0xDBAB.Text = _0xB2C2 and ("[".. _0x9AE5(_0xB2C2) .."]") or""_0x5352.Text = _0xB2C2 and ("Key: ".. _0x9AE5(_0xB2C2)) or"Set Keybind"end] = true
local _0xF193, _0x80C4 = false, 0
_0x8DA9.MouseButton1Click:Connect(function()
_0xF193 = not _0xF193
_0x80C4 += 1
local _0x42C8 = _0x80C4
_0x6A54(_0xC254, .25, { Rotation = _0xF193 and 90 or 0 })
if _0xF193 then
_0xFD8F.AutomaticSize = Enum.AutomaticSize.None
_0xFD8F.Size = UDim2.new(1, 0, 0, 0)
_0xFD8F.Visible = true
task.spawn(function()
_0x6B8F.RenderStepped:Wait()if _0x42C8 ~= _0x80C4 then return end
local _0xD64B = _0x6A54(_0xFD8F, .3, { Size = UDim2.new(1, 0, 0, _0xF8F4.AbsoluteSize.Y) })
_0xD64B.Completed:Connect(function()
if _0x42C8 == _0x80C4 and _0xF193 then
_0xFD8F.Size = UDim2.new(1, 0, 0, 0)
_0xFD8F.AutomaticSize = Enum.AutomaticSize.Y
end
end)
end)
else
local _0xCCD3 = _0xFD8F.AbsoluteSize.Y
_0xFD8F.AutomaticSize = Enum.AutomaticSize.None
_0xFD8F.Size = UDim2.new(1, 0, 0, _0xCCD3)
local _0xD64B = _0x6A54(_0xFD8F, .22, { Size = UDim2.new(1, 0, 0, 0) })
_0xD64B.Completed:Connect(function()
if _0x42C8 == _0x80C4 and not _0xF193 then
_0xFD8F.Visible = false
end
end)
end
end)
_0x3CA5.Listeners[function(_0xCA5B)
_0x167A.Text = _0xCA5B and (_0x3CA5.Kind =="Toggle"and"ON"or"ACTIVE") or""end] = true
table.insert(_0xB569, { frame = _0x228B, hay = (_0x3CA5.Name .." ".. _0x3CA5.Desc):lower() })
end
for _0x3A85, _0x3CA5 in ipairs(_0x72F8) do
_0xDEAD(_0x3CA5, _0x3A85 + 10)
end
_0x9F69:GetPropertyChangedSignal("Text"):Connect(function()
local _0xFB5A = _0x9F69.Text:lower()
for _0x3AE9, _0x5C16 in ipairs(_0xB569) do
_0x5C16.frame.Visible = _0xFB5A ==""or _0x5C16.hay:find(_0xFB5A, 1, true) ~= nil
end
end)
endlocal _0x411E
do
local _0x3D2F = _0x604B("Players")
local _0x8DA9 = _0xA7CD(_0x3D2F,"", 16, _0x110B.Bold,"Text", { Size = UDim2.new(1, 0, 0, 20), LayoutOrder = 1 })
local _0x1775, _0x9F69 = _0x4C0A(_0x3D2F,"Search players…")
_0x1775.LayoutOrder = 2
local _0xEA29 = _0x8FFF(_0x3D2F, UDim2.new(1, 0, 0, 0), nil, { AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 3 })
_0x126D(_0xEA29, 8)
local function _0xE339(_0xE0D1)
local _0xB184 = _0xE0D1.Character and _0xE0D1.Character:FindFirstChild("HumanoidRootPart")
local _0x5C16 = _0x950D()
if _0xB184 and _0x5C16 then
_0x5C16.CFrame = _0xB184.CFrame * CFrame.new(0, 0, 3)
_0x84A5("success","Teleported to ".. _0xE0D1.Name)
_0x6DB0("Teleport","Teleported to ".. _0xE0D1.DisplayName,"success")
else
_0x84A5("error","Could not teleport to ".. _0xE0D1.Name)
_0x6DB0("Teleport", _0xE0D1.DisplayName .." has no character","error")
end
end
local _0x84F4 = _0xB283["spectate"]
local function _0xBF24(_0xE0D1)
return _0x84F4.Enabled and _0x84F4.Values.Target == _0xE0D1.Name
end
local function _0x97DA(_0xE0D1)
if _0xBF24(_0xE0D1) then
_0x045B(_0x84F4)return
end
_0x84F4.Values.Target = _0xE0D1.Name
if _0x84F4.Setters.Target then _0x84F4.Setters.Target(_0xE0D1.Name) end
_0xD168(_0x84F4)
end
_0x411E = function()
for _0x3AE9, _0xED20 in ipairs(_0xEA29:GetChildren()) do
if _0xED20:IsA("Frame") then _0xED20:Destroy() end
end
local _0xC4DD = _0x0102:GetPlayers()
table.sort(_0xC4DD, function(_0xB7C5, _0x3D2C) return _0xB7C5.DisplayName:lower() < _0x3D2C.DisplayName:lower() end)
_0x8DA9.Text = ("In this server  ·  %d"):format(#_0xC4DD)
local _0xFB5A = _0x9F69.Text:lower()
for _0x3AE9, _0xE0D1 in ipairs(_0xC4DD) do
if _0xFB5A ==""or _0xE0D1.Name:lower():find(_0xFB5A, 1, true) or _0xE0D1.DisplayName:lower():find(_0xFB5A, 1, true) then
local _0x228B = _0x8FFF(_0xEA29, UDim2.new(1, 0, 0, 56),"Surface")
_0xAC02(_0x228B, 8)
_0x1B3E(_0x228B)
local _0x0112 = _0xBBFC("ImageLabel", {
Parent = _0x228B, Size = UDim2.fromOffset(38, 38), Position = UDim2.fromOffset(10, 9), BorderSizePixel = 0,
})
_0x8F68(_0x0112, { BackgroundColor3 ="Surface2"})
_0xAC02(_0x0112, 19)
_0xAC3A(_0x0112, _0xE0D1.UserId)
_0xA7CD(_0x228B, _0xE0D1.DisplayName, 13, _0x110B.Bold,"Text", {
Position = UDim2.fromOffset(58, 10), Size = UDim2.new(1, -250, 0, 18), TextTruncate = Enum.TextTruncate.AtEnd,
})
_0xA7CD(_0x228B,"@".. _0xE0D1.Name, 11, _0x110B.Reg,"Sub", {
Position = UDim2.fromOffset(58, 29), Size = UDim2.new(1, -250, 0, 14), TextTruncate = Enum.TextTruncate.AtEnd,
})
if _0xE0D1 == _0x0F7F then
local _0x877E = _0x50AA(_0x228B,"You", true)
_0x877E.AnchorPoint = Vector2.new(1, .5)
_0x877E.Position = UDim2.new(1, -12, .5, 0)
else
local _0x2C29 = _0xBF24(_0xE0D1)
local _0x1F0D = _0xBF78(_0x228B, _0x2C29 and"Stop"or"Spectate", {
Size = UDim2.fromOffset(78, 30), Active = function() return _0x2C29 end,
OnClick = function() _0x97DA(_0xE0D1) end,
})
_0x1F0D.AnchorPoint = Vector2.new(1, .5)
_0x1F0D.Position = UDim2.new(1, -12, .5, 0)
local _0x3D2C = _0xBF78(_0x228B,"Teleport To", { Size = UDim2.fromOffset(96, 30), Variant ="Primary", OnClick = function() _0xE339(_0xE0D1) end })
_0x3D2C.AnchorPoint = Vector2.new(1, .5)
_0x3D2C.Position = UDim2.new(1, -96, .5, 0)
end
end
end
end
_0x9F69:GetPropertyChangedSignal("Text"):Connect(_0x411E)
_0xB283["spectate"].Listeners[function() _0x411E() end] = true
_0x411E()
end
local function _0xB34C()
task.defer(function()
_0x411E()
for _0x3AE9, _0x3B2A in ipairs(_0xCE29) do pcall(_0x3B2A) end
end)
end
_0x5951(_0x0102.PlayerAdded, function(_0xE0D1)
_0x84A5("info", _0xE0D1.Name .." joined")
_0xB34C()
end)
_0x5951(_0x0102.PlayerRemoving, function(_0xE0D1)
_0x84A5("info", _0xE0D1.Name .." left")
_0xB34C()
end)local _0xCBC4: { [string]: _0xEF28 } = {
Sound = _0x108D.Music and _0xBBFC("Sound", { Name ="MantleMusic", Volume = .5, Parent = game:GetService("SoundService") }) or nil,
Playlist = {}, Index = nil, CurrentId = nil, LastId = nil, CurrentName = nil, Loading = false,
Token = 0, LastManual = 0, Listeners = {},
}
local _0x7891 = _0xCBC4.Sound
if not _0x108D.Music then
_0xCBC4.Collect = function() return nil end
_0xCBC4.Apply = function() end
end
if _0x108D.Music then (function()local _0xB3E3 = game:GetService("MarketplaceService")
local function _0x2EF8()
for _0x3B2A in pairs(_0xCBC4.Listeners) do pcall(_0x3B2A) end
end
_0xCBC4.Changed = _0x2EF8
local function _0xE192(_0x98DE)
return _0x98DE and tostring(_0x98DE):match("%d+") or nil
end
local function _0x07D0(_0x50FF, _0x674F)
task.spawn(function()
local _0xF74B, _0x1CDB = pcall(function()
return _0xB3E3:GetProductInfo(tonumber(_0x50FF), Enum.InfoType.Asset)
end)
if _0xF74B and type(_0x1CDB) =="table"and type(_0x1CDB.Name) =="string"and _0x1CDB.Name ~=""then
_0x674F(_0x1CDB.Name)
end
end)
end
function _0xCBC4.Play(raw, index)
local _0x50FF = _0xE192(raw)
if not _0x50FF then
_0x6DB0("Music","Enter a valid sound ID","warn")
return
end
_0xCBC4.Token += 1
local _0xBCC4 = _0xCBC4.Token
_0xCBC4.LastManual = os.clock()_0x7891:Stop()
_0x7891.SoundId ="rbxassetid://".. _0x50FF
_0x7891.TimePosition = 0
local _0xFE53 = index and _0xCBC4.Playlist[index] or nil
local _0x81C4 ="Sound ".. _0x50FF
_0xCBC4.CurrentId, _0xCBC4.LastId, _0xCBC4.Index, _0xCBC4.Loading = _0x50FF, _0x50FF, index, true
_0xCBC4.CurrentName = _0xFE53 and _0xFE53.Name or _0x81C4
_0x2EF8()
_0x7891:Play()
if _0xCBC4.CurrentName == _0x81C4 then
_0x07D0(_0x50FF, function(_0x6A18)
if _0xFE53 then _0xFE53.Name = _0x6A18 end
if _0xBCC4 == _0xCBC4.Token then
_0xCBC4.CurrentName = _0x6A18
end
_0x2EF8()
end)
end
task.spawn(function()
local _0x1EED = os.clock()
while _0xBCC4 == _0xCBC4.Token and not _0x7891.IsLoaded and os.clock() - _0x1EED < 10 do
task.wait(.1)
end
if _0xBCC4 ~= _0xCBC4.Token then return end
_0xCBC4.Loading = false
if not _0x7891.IsLoaded or _0x7891.TimeLength <= 0 then
_0xCBC4.LastManual = os.clock()
_0x7891:Stop()
_0xCBC4.CurrentId, _0xCBC4.Index = nil, nil
_0x84A5("error","Music: could not load ".. _0x50FF)
_0x6DB0("Music","Couldn't load that ID. It may be private, removed, or not an audio asset.","error")
else
_0x84A5("success","Music: playing ".. _0x50FF)
end
_0x2EF8()
end)
end
function _0xCBC4.Stop()
_0xCBC4.Token += 1
_0xCBC4.LastManual = os.clock()
_0x7891:Stop()
_0xCBC4.CurrentId, _0xCBC4.CurrentName, _0xCBC4.Index, _0xCBC4.Loading = nil, nil, nil, false
_0x2EF8()
end
function _0xCBC4.Toggle()
if not _0xCBC4.CurrentId then
if _0xCBC4.LastId then
_0xCBC4.Play(_0xCBC4.LastId)
elseif _0xCBC4.Playlist[1] then
_0xCBC4.Play(_0xCBC4.Playlist[1].Id, 1)
else
_0x6DB0("Music","Enter a sound ID first","warn")
end
return
end
if _0x7891.IsPlaying then
_0x7891:Pause()
elseif _0x7891.IsPaused then
_0x7891:Resume()
else
_0x7891:Play()
end
_0x2EF8()
endfunction _0xCBC4.Step(dir, auto)
local _0x1CA9 = #_0xCBC4.Playlist
if _0x1CA9 == 0 then
if auto then _0xCBC4.Stop() end
return
end
local _0x3A85 = _0xCBC4.Index or (dir > 0 and 0 or _0x1CA9 + 1)
_0x3A85 += dir
if _0x3A85 > _0x1CA9 then
if auto then
_0xCBC4.Stop()
return
end
_0x3A85 = 1
elseif _0x3A85 < 1 then
_0x3A85 = _0x1CA9
end
_0xCBC4.Play(_0xCBC4.Playlist[_0x3A85].Id, _0x3A85)
end
function _0xCBC4.Add(raw)
local _0x50FF = _0xE192(raw)
if not _0x50FF then
_0x6DB0("Music","Enter a valid sound ID","warn")
return
end
for _0x3AE9, _0xEEC5 in ipairs(_0xCBC4.Playlist) do
if _0xEEC5.Id == _0x50FF then
_0x6DB0("Music","Already in your playlist","info")
return
end
end
local _0xFE53 = { Id = _0x50FF, Name ="Sound ".. _0x50FF }
table.insert(_0xCBC4.Playlist, _0xFE53)
_0x2EF8()
_0x07D0(_0x50FF, function(_0x6A18)
_0xFE53.Name = _0x6A18
_0x2EF8()
end)
_0x6DB0("Music","Added to playlist","success")
end
function _0xCBC4.Remove(_0x3A85)
if not _0xCBC4.Playlist[_0x3A85] then return end
table.remove(_0xCBC4.Playlist, _0x3A85)
if _0xCBC4.Index then
if _0xCBC4.Index == _0x3A85 then
_0xCBC4.Index = nilelseif _0xCBC4.Index > _0x3A85 then
_0xCBC4.Index -= 1
end
end
_0x2EF8()
end
function _0xCBC4.Collect()
local _0xC4DD = {}
for _0x3AE9, _0xEEC5 in ipairs(_0xCBC4.Playlist) do
table.insert(_0xC4DD, { Id = _0xEEC5.Id, Name = _0xEEC5.Name })
end
return { Volume = _0x7891.Volume, Speed = _0x7891.PlaybackSpeed, Loop = _0x7891.Looped, Playlist = _0xC4DD }
end
function _0xCBC4.Apply(_0x5D96)
if type(_0x5D96) ~="table"then return end
if type(_0x5D96.Volume) =="number"then
_0x7891.Volume = math.clamp(_0x5D96.Volume, 0, 1)
if _0x9860.MusicVol then _0x9860.MusicVol(_0x7891.Volume) end
end
if type(_0x5D96.Speed) =="number"then
_0x7891.PlaybackSpeed = math.clamp(_0x5D96.Speed, .25, 2)
if _0x9860.MusicSpeed then _0x9860.MusicSpeed(_0x7891.PlaybackSpeed) end
end
if type(_0x5D96.Loop) =="boolean"then _0x7891.Looped = _0x5D96.Loop end
if type(_0x5D96.Playlist) =="table"then
table.clear(_0xCBC4.Playlist)
_0xCBC4.Index = nil
for _0x3AE9, _0xEEC5 in ipairs(_0x5D96.Playlist) do
local _0x50FF = type(_0xEEC5) =="table"and _0xE192(_0xEEC5.Id) or nil
if _0x50FF then
table.insert(_0xCBC4.Playlist, { Id = _0x50FF, Name = type(_0xEEC5.Name) =="string"and _0xEEC5.Name or ("Sound ".. _0x50FF) })
end
end
end
_0x2EF8()
end
_0x7891.Ended:Connect(function()
if os.clock() - _0xCBC4.LastManual < .4 then return endif _0x7891.Looped then return end
if _0xCBC4.Index then
_0xCBC4.Step(1, true)
else
_0xCBC4.Stop()
end
end)
_0x7891.Paused:Connect(_0x2EF8)
_0x7891.Resumed:Connect(_0x2EF8)
_0x7891.Played:Connect(_0x2EF8)
end)() endlocal _0xDA02 = false
do (function()local _0x3D2F = _0x604B("Settings")
local function _0xD1D1(_0x7824, title, _0x9A20)
local _0x228B = _0x8FFF(_0x7824, UDim2.new(1, 0, 0, 40), nil)
_0xA7CD(_0x228B, title, 13, _0x110B.Med,"Text", { Size = UDim2.new(1, -170, 0, 18), Position = UDim2.fromOffset(0, _0x9A20 and 2 or 11) })
if _0x9A20 then
_0xA7CD(_0x228B, _0x9A20, 11, _0x110B.Reg,"Sub", {
Size = UDim2.new(1, -170, 0, 14), Position = UDim2.fromOffset(0, 21), TextTruncate = Enum.TextTruncate.AtEnd,
})
end
return _0x228B
endlocal _0xA95A = _0x0012(_0x3D2F,"Appearance", 1)
_0xA7CD(_0xA95A,"Theme", 13, _0x110B.Med,"Text", { Size = UDim2.new(1, 0, 0, 16) })
local _0x567D = _0x1937(_0xA95A)
for _0x3AE9, _0x6A18 in ipairs(_0x6F85) do
_0xBF78(_0x567D, _0x6A18, {
AutoX = true, Height = 30, TextSize = 12,
Active = function() return _0x7DB1.Theme == _0x6A18 end,
OnClick = function() _0x78AC(_0x6A18) end,
})
end
local _0x2D7F = _0x8FFF(_0xA95A, UDim2.new(1, 0, 0, 46), nil)
_0xA7CD(_0x2D7F,"UI Opacity", 13, _0x110B.Med,"Text", { Size = UDim2.new(.5, 0, 0, 18) })
local _0x5650 = _0xA7CD(_0x2D7F,"100%", 12, _0x110B.Med,"Sub", {
Size = UDim2.new(.5, 0, 0, 18), Position = UDim2.fromScale(.5, 0), TextXAlignment = Enum.TextXAlignment.Right,
})
local _0x5BF0, _0xAEF6 = _0xA73E(_0x2D7F, .4, 1, _0x7DB1.Opacity, function(_0x97B0)
_0x5650.Text = math.floor(_0x97B0 * 100 + .5) .."%"_0x241E(_0x97B0)
end)
_0x5BF0.Position = UDim2.fromOffset(0, 24)
function _0x9860.OpacitySet(_0x97B0)
_0xAEF6(_0x97B0, true)
_0x5650.Text = math.floor(_0x97B0 * 100 + .5) .."%"end
local _0x346C = _0xD1D1(_0xA95A,"Dim background","Darkens the game while Mantle is open")
local _0x9719, _0xE4C4 = _0x8776(_0x346C, _0x7DB1.Dim, function(_0x97B0) _0x7E04(_0x97B0) end)
_0x9719.AnchorPoint = Vector2.new(1, .5)
_0x9719.Position = UDim2.new(1, 0, .5, 0)
function _0x9860.DimSet(_0x97B0) _0xE4C4(_0x97B0, true) endif _0x108D.Background then (function()
_0xA7CD(_0xA95A,"Background image", 13, _0x110B.Med,"Text", { Size = UDim2.new(1, 0, 0, 16) })
_0xA7CD(_0xA95A,"Paste a Roblox image or decal ID. It shows behind the Mantle panel.", 11, _0x110B.Reg,"Sub", {
Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
})
local _0xBC43 = _0x8FFF(_0xA95A, UDim2.new(1, 0, 0, 34), nil)
_0x126D(_0xBC43, 8, Enum.FillDirection.Horizontal)
local _0x3AE9, _0xD36A = _0x4C0A(_0xBC43,"Image ID  (e.g. 1234567890)", UDim2.new(1, -150, 0, 34))
_0xBF78(_0xBC43,"Apply", {
Size = UDim2.fromOffset(70, 34), Variant ="Primary",
OnClick = function()
_0xF5BB(_0xD36A.Text)
_0x6DB0("Background", _0x7DB1.BgImage ~=""and"Image applied"or"Background cleared","success")
end,
})
_0xBF78(_0xBC43,"Clear", {
Size = UDim2.fromOffset(64, 34),
OnClick = function()
_0xF5BB(nil)
_0x6DB0("Background","Background cleared","info")
end,
})
_0xD36A.FocusLost:Connect(function(enter)
if enter then _0xF5BB(_0xD36A.Text) end
end)
function _0x9860.BgSet(_0x50FF)
_0xD36A.Text = _0x50FF
end
local _0xCDC0 = _0x8FFF(_0xA95A, UDim2.new(1, 0, 0, 46), nil)
_0xA7CD(_0xCDC0,"Image visibility", 13, _0x110B.Med,"Text", { Size = UDim2.new(.5, 0, 0, 18) })
local _0x39C3 = _0xA7CD(_0xCDC0,"40%", 12, _0x110B.Med,"Sub", {
Size = UDim2.new(.5, 0, 0, 18), Position = UDim2.fromScale(.5, 0), TextXAlignment = Enum.TextXAlignment.Right,
})
local _0x5705, _0x6EC7 = _0xA73E(_0xCDC0, 0, 1, _0x7DB1.BgOpacity, function(_0x97B0)
_0x39C3.Text = math.floor(_0x97B0 * 100 + .5) .."%"_0xC261(_0x97B0)
end)
_0x5705.Position = UDim2.fromOffset(0, 24)
function _0x9860.BgOpacitySet(_0x97B0)
_0x6EC7(_0x97B0, true)
_0x39C3.Text = math.floor(_0x97B0 * 100 + .5) .."%"end
end)() endlocal _0x0428 = _0x0012(_0x3D2F,"Notifications", 2)
_0xA7CD(_0x0428,"How Mantle tells you what just happened.", 11, _0x110B.Reg,"Sub", { Size = UDim2.new(1, 0, 0, 14) })
local _0x4F7A = _0x1937(_0x0428)
local _0xC0A6 = {}
for _0x3AE9, _0x6A18 in ipairs(_0x180A.NotifyStyles) do
local _0x3AE9, _0x920B = _0xBF78(_0x4F7A, _0x6A18, {
AutoX = true, Height = 30, TextSize = 12,
Active = function() return _0x7DB1.NotifyStyle == _0x6A18 end,
OnClick = function() _0x180A.SetNotifyStyle(_0x6A18) end,
})
_0xC0A6[_0x6A18] = _0x920B
end
function _0x9860.NotifySet()
for _0x3AE9, _0x5C16 in pairs(_0xC0A6) do _0x5C16() end
end
_0xA7CD(_0x0428,"Toast: popups   ·   Console: log only   ·   Toast + Console: both   ·   Errors Only: popups for warnings and errors   ·   Chime: popup with a sound   ·   Disabled: silent", 11, _0x110B.Reg,"Sub", {
Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
})local _0x3E48 = _0x0012(_0x3D2F,"Widgets & Tabs", 3)
_0xA7CD(_0x3E48,"Turn tabs into floating widgets. Pinned widgets stay on screen when Mantle is closed.", 11, _0x110B.Reg,"Sub", {
Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
})
_0x9860.WSync = {}
local function _0x8AC9(_0x6A18, _0x9A20, showLabel)
local _0x228B = _0x8FFF(_0x3E48, UDim2.new(1, 0, 0, 46), nil)
_0xA7CD(_0x228B, _0x6A18, 13, _0x110B.Med,"Text", { Size = UDim2.new(1, -110, 0, 18), Position = UDim2.fromOffset(0, 6) })
_0xA7CD(_0x228B, _0x9A20, 11, _0x110B.Reg,"Sub", {
Size = UDim2.new(1, -110, 0, 14), Position = UDim2.fromOffset(0, 25), TextTruncate = Enum.TextTruncate.AtEnd,
})
_0xA7CD(_0x228B, showLabel, 10, _0x110B.Med,"Sub", {
Position = UDim2.new(1, -96, 0, 0), Size = UDim2.fromOffset(40, 12), TextXAlignment = Enum.TextXAlignment.Center,
})
_0xA7CD(_0x228B,"Pin", 10, _0x110B.Med,"Sub", {
Position = UDim2.new(1, -40, 0, 0), Size = UDim2.fromOffset(40, 12), TextXAlignment = Enum.TextXAlignment.Center,
})
local _0xB148 = _0x7DB1.Widgets[_0x6A18]
local _0x9F5B, _0x30D2 = _0x8776(_0x228B, _0xB148.Enabled, function(_0x97B0) _0xC94A(_0x6A18, _0x97B0) end)
_0x9F5B.Position = UDim2.new(1, -96, 0, 16)
local _0x6E64, _0x9915 = _0x8776(_0x228B, _0xB148.Pinned, function(_0x97B0) _0xFA40(_0x6A18, _0x97B0) end)
_0x6E64.Position = UDim2.new(1, -40, 0, 16)
_0x9860.WSync[_0x6A18] = {
Show = function(_0x97B0) _0x30D2(_0x97B0, true) end,
Pin = function(_0x97B0) _0x9915(_0x97B0, true) end,
}
end
_0x8AC9("Performance","FPS, ping, memory and player count","Show")
_0x8AC9("Keybinds","Every command keybind you have set","Show")
_0x8AC9("Command Bar","Type a command and press Enter","Show")
_0x8AC9("Command History","Commands you ran, newest first","Show")
_0x8AC9("Command List","Every command with a run / toggle button","Show")
_0x8AC9("Home","Show the Home tab as a widget","Widget")
_0x8AC9("Commands","Show the Commands tab as a widget","Widget")
_0x8AC9("Players","Show the Players tab as a widget","Widget")
_0x8AC9("Misc","Show the Misc tab as a widget","Widget")
_0x8AC9("Credits","Show the Credits tab as a widget","Widget")local _0xBEBE = _0x0012(_0x3D2F,"Controls", 4)
local _0xF989 = _0xD1D1(_0xBEBE,"UI toggle keybind","Show or hide the Mantle bar and panel")
local _0x5352 = _0xBF78(_0xF989, _0x7DB1.Keybind, { Size = UDim2.fromOffset(130, 30) })
_0x5352.AnchorPoint = Vector2.new(1, .5)
_0x5352.Position = UDim2.new(1, 0, .5, 0)
_0x5352.MouseButton1Click:Connect(function()
_0xDA02 = true
_0x5352.Text ="Press a key…"end)
function _0x9860.KeybindSet(_0x1CA9)
_0x5352.Text = _0x1CA9
end
_0x5951(_0x22C9.InputBegan, function(input, gp)
if _0x5075 then
if input.UserInputType == Enum.UserInputType.Keyboard then
_0xAB0C(input.KeyCode)
end
return
end
if _0xDA02 then
if input.UserInputType == Enum.UserInputType.Keyboard then
_0xDA02 = false
if input.KeyCode ~= Enum.KeyCode.Escape then
local _0x47D8 = _0xA256[input.KeyCode.Name]
if _0x47D8 then _0x22C8(_0x47D8, nil) end_0xCB0F(input.KeyCode.Name)
_0x6DB0("Keybind","UI toggle set to ".. input.KeyCode.Name,"success")
else
_0x5352.Text = _0x7DB1.Keybind
end
end
return
end
if gp then return end
if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
if input.KeyCode.Name == _0x7DB1.Keybind then
_0x1E3F(not _0xD03D)
else
local _0x191C = _0xA256[input.KeyCode.Name]
if _0x191C then task.spawn(_0x478A, _0x191C) end
end
end)
local _0xD807 = _0xD1D1(_0xBEBE,"Mobile button","Floating button to open Mantle on touch devices")
local _0xDD50, _0xFAD6 = _0x8776(_0xD807, _0x7DB1.MobileButton, function(_0x97B0) _0x1863(_0x97B0) end)
_0xDD50.AnchorPoint = Vector2.new(1, .5)
_0xDD50.Position = UDim2.new(1, 0, .5, 0)
function _0x9860.MobileSet(_0x97B0) _0xFAD6(_0x97B0, true) endlocal _0x25CA = _0x0012(_0x3D2F,"Home Quick Actions", 5)
_0xA7CD(_0x25CA,"Choose which commands appear on the Home tab.", 11, _0x110B.Reg,"Sub", { Size = UDim2.new(1, 0, 0, 14) })
local _0xC39C = _0x1937(_0x25CA)
_0x9860.QuickChips = {}
for _0x3AE9, _0x3CA5 in ipairs(_0x72F8) do
local function _0xE6E8()
return table.find(_0x7DB1.QuickActions, _0x3CA5.Name) ~= nil
end
local _0x3AE9, _0x920B = _0xBF78(_0xC39C, _0x3CA5.Name, {
AutoX = true, Height = 28, TextSize = 12, Active = _0xE6E8,
OnClick = function()
local _0x3A85 = table.find(_0x7DB1.QuickActions, _0x3CA5.Name)
if _0x3A85 then table.remove(_0x7DB1.QuickActions, _0x3A85) else table.insert(_0x7DB1.QuickActions, _0x3CA5.Name) end
_0x9860.QuickChips[_0x3CA5.Name]()
_0x9860.RebuildQuick()
end,
})
_0x9860.QuickChips[_0x3CA5.Name] = _0x920B
endlocal _0xB148 = _0x0012(_0x3D2F,"Configuration", 6)
_0xA7CD(_0xB148, _0xCBD8 and"Saved to your workspace folder (Mantle/config.json) and auto-loaded on start."or"No file system available — configs are kept for this session only.", 11, _0x110B.Reg,"Sub", {
Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
})
local _0x674F = _0x8FFF(_0xB148, UDim2.new(1, 0, 0, 32), nil)
_0x126D(_0x674F, 8, Enum.FillDirection.Horizontal)
_0xBF78(_0x674F,"Save", { Variant ="Primary", OnClick = function() _0x3751() end })
_0xBF78(_0x674F,"Load", { OnClick = function() _0xC25C() end })
_0xBF78(_0x674F,"Reset", { OnClick = function() _0x249F() end })local _0xC283 = _0x0012(_0x3D2F,"Advanced", 7)
local _0x5F40 = _0xD1D1(_0xC283,"Console","Opens the Mantle console in its own window")
local _0xDE19 = _0xBF78(_0x5F40,"Open", { Size = UDim2.fromOffset(100, 30) })
_0xDE19.AnchorPoint = Vector2.new(1, .5)
_0xDE19.Position = UDim2.new(1, 0, .5, 0)
_0xDE19.MouseButton1Click:Connect(function()
_0x8358.Enabled = not _0x8358.Enabled
_0xB324()
end)
local _0xB184 = _0xD1D1(_0xC283,"Terminate UI","Stops every command and removes Mantle completely")
local _0x88FD = _0xBF78(_0xB184,"Terminate", { Size = UDim2.fromOffset(100, 30), Variant ="Danger"})
_0x88FD.AnchorPoint = Vector2.new(1, .5)
_0x88FD.Position = UDim2.new(1, 0, .5, 0)
local _0xE2F6 = false
_0x88FD.MouseButton1Click:Connect(function()
if _0xE2F6 then
_0x3FBD()
return
end
_0xE2F6 = true
_0x88FD.Text ="Confirm?"task.delay(3, function()
_0xE2F6 = false
if _0x88FD.Parent then _0x88FD.Text ="Terminate"end
end)
end)
end)() enddo
local _0x3D2F = _0x604B("Misc")if _0x108D.Music then (function()
local _0x30DC = _0x0012(_0x3D2F,"Music Player", 1)
local function _0x0C6C(_0x98DE)
_0x98DE = math.max(0, math.floor(_0x98DE))
return ("%d:%02d"):format(_0x98DE // 60, _0x98DE % 60)
end
local _0x5A01 = _0xA7CD(_0x30DC,"Nothing playing", 14, _0x110B.Bold,"Text", {
Size = UDim2.new(1, 0, 0, 18), TextTruncate = Enum.TextTruncate.AtEnd,
})
local _0x0A54 = _0xA7CD(_0x30DC,"Enter a Roblox audio ID below", 11, _0x110B.Reg,"Sub", { Size = UDim2.new(1, 0, 0, 14) })
local _0xCBC7 = 0
local _0x3AE9, _0xFA3E = _0xA73E(_0x30DC, 0, 1, 0, function(_0xB7C5)
_0xCBC7 = os.clock()
if _0xCBC4.CurrentId and _0x7891.TimeLength > 0 then
_0x7891.TimePosition = _0xB7C5 * _0x7891.TimeLength
end
end)
local _0xB1F7 = _0xA7CD(_0x30DC,"0:00 / 0:00", 11, _0x110B.Med,"Sub", { Size = UDim2.new(1, 0, 0, 14) })
local _0x181B = _0x8FFF(_0x30DC, UDim2.new(1, 0, 0, 34), nil)
_0x126D(_0x181B, 8, Enum.FillDirection.Horizontal)
local _0x3AE9, _0x350F = _0x4C0A(_0x181B,"Roblox audio ID", UDim2.new(1, -150, 0, 34))
_0xBF78(_0x181B,"Play", {
Size = UDim2.fromOffset(64, 34), Variant ="Primary", OnClick = function() _0xCBC4.Play(_0x350F.Text) end,
})
_0xBF78(_0x181B,"+ Add", {
Size = UDim2.fromOffset(70, 34), OnClick = function() _0xCBC4.Add(_0x350F.Text) end,
})
_0x350F.FocusLost:Connect(function(enter)
if enter and _0x350F.Text:match("%d") then _0xCBC4.Play(_0x350F.Text) end
end)
local _0xB587 = _0x1937(_0x30DC)
_0xBF78(_0xB587,"Prev", { AutoX = true, Height = 32, OnClick = function() _0xCBC4.Step(-1) end })
local _0xC231 = _0xBF78(_0xB587,"Play", { AutoX = true, Height = 32, Variant ="Primary", OnClick = _0xCBC4.Toggle })
_0xBF78(_0xB587,"Stop", { AutoX = true, Height = 32, OnClick = _0xCBC4.Stop })
_0xBF78(_0xB587,"Next", { AutoX = true, Height = 32, OnClick = function() _0xCBC4.Step(1) end })
local _0x3AE9, _0xF6A4 = _0xBF78(_0xB587,"Loop", {
AutoX = true, Height = 32, Active = function() return _0x7891.Looped end,
OnClick = function()
_0x7891.Looped = not _0x7891.Looped
_0xCBC4.Changed()
end,
})
local _0xAD7E = _0x8FFF(_0x30DC, UDim2.new(1, 0, 0, 46), nil)
_0xA7CD(_0xAD7E,"Volume", 13, _0x110B.Med,"Text", { Size = UDim2.new(.5, 0, 0, 18) })
local _0x837F = _0xA7CD(_0xAD7E,"50%", 12, _0x110B.Med,"Sub", {
Size = UDim2.new(.5, 0, 0, 18), Position = UDim2.fromScale(.5, 0), TextXAlignment = Enum.TextXAlignment.Right,
})
local _0xE2F3, _0x50B7 = _0xA73E(_0xAD7E, 0, 1, _0x7891.Volume, function(_0x97B0)
_0x7891.Volume = _0x97B0
_0x837F.Text = math.floor(_0x97B0 * 100 + .5) .."%"end)
_0xE2F3.Position = UDim2.fromOffset(0, 24)
function _0x9860.MusicVol(_0x97B0)
_0x50B7(_0x97B0, true)
_0x837F.Text = math.floor(_0x97B0 * 100 + .5) .."%"end
_0x9860.MusicVol(_0x7891.Volume)
local _0xBBFD = _0x8FFF(_0x30DC, UDim2.new(1, 0, 0, 46), nil)
_0xA7CD(_0xBBFD,"Playback speed", 13, _0x110B.Med,"Text", { Size = UDim2.new(.5, 0, 0, 18) })
local _0x4FBE = _0xA7CD(_0xBBFD,"1.00x", 12, _0x110B.Med,"Sub", {
Size = UDim2.new(.5, 0, 0, 18), Position = UDim2.fromScale(.5, 0), TextXAlignment = Enum.TextXAlignment.Right,
})
local _0x519A, _0x1765 = _0xA73E(_0xBBFD, .25, 2, _0x7891.PlaybackSpeed, function(_0x97B0)
_0x7891.PlaybackSpeed = _0x97B0
_0x4FBE.Text = ("%.2fx"):format(_0x97B0)
end)
_0x519A.Position = UDim2.fromOffset(0, 24)
function _0x9860.MusicSpeed(_0x97B0)
_0x1765(_0x97B0, true)
_0x4FBE.Text = ("%.2fx"):format(_0x97B0)
end
_0x9860.MusicSpeed(_0x7891.PlaybackSpeed)
_0xA7CD(_0x30DC,"Playlist", 13, _0x110B.Med,"Text", { Size = UDim2.new(1, 0, 0, 16) })
local _0xA307 = _0x8FFF(_0x30DC, UDim2.new(1, 0, 0, 0), nil, { AutomaticSize = Enum.AutomaticSize.Y })
_0x126D(_0xA307, 6)
local _0x4F04
local function _0xF430()
local _0xC4BC = { tostring(_0xCBC4.Index) }
for _0x3AE9, _0xEEC5 in ipairs(_0xCBC4.Playlist) do table.insert(_0xC4BC, _0xEEC5.Id ..":".. _0xEEC5.Name) end
local _0xD1A9 = table.concat(_0xC4BC,"|")
if _0xD1A9 == _0x4F04 then return end
_0x4F04 = _0xD1A9
for _0x3AE9, _0xED20 in ipairs(_0xA307:GetChildren()) do
if _0xED20:IsA("Frame") or _0xED20:IsA("TextLabel") then _0xED20:Destroy() end
end
_0x7B63()
if #_0xCBC4.Playlist == 0 then
_0xA7CD(_0xA307,"Empty. Type an ID above and press + Add.", 12, _0x110B.Reg,"Sub", { Size = UDim2.new(1, 0, 0, 16) })
return
end
for _0x3A85, _0xEEC5 in ipairs(_0xCBC4.Playlist) do
local _0x228B = _0x8FFF(_0xA307, UDim2.new(1, 0, 0, 40),"Surface2", { LayoutOrder = _0x3A85 })
_0xAC02(_0x228B, 6)
local _0x5406 = _0xCBC4.Index == _0x3A85
_0xA7CD(_0x228B, _0xEEC5.Name, 12, _0x5406 and _0x110B.Bold or _0x110B.Med, _0x5406 and"Accent"or"Text", {
Position = UDim2.fromOffset(10, 4), Size = UDim2.new(1, -150, 0, 16), TextTruncate = Enum.TextTruncate.AtEnd,
})
_0xA7CD(_0x228B, _0xEEC5.Id, 10, _0x110B.Reg,"Sub", { Position = UDim2.fromOffset(10, 22), Size = UDim2.new(1, -150, 0, 13) })
local _0xDD99 = _0xBF78(_0x228B,"Remove", { Size = UDim2.fromOffset(64, 26), TextSize = 11, OnClick = function() _0xCBC4.Remove(_0x3A85) end })
_0xDD99.AnchorPoint = Vector2.new(1, .5)
_0xDD99.Position = UDim2.new(1, -8, .5, 0)
local _0x40AA = _0xBF78(_0x228B,"Play", {
Size = UDim2.fromOffset(52, 26), TextSize = 11, Variant ="Primary", OnClick = function() _0xCBC4.Play(_0xEEC5.Id, _0x3A85) end,
})
_0x40AA.AnchorPoint = Vector2.new(1, .5)
_0x40AA.Position = UDim2.new(1, -78, .5, 0)
end
end
local function _0x8D74()
local _0xEC79 = _0x7891.IsPlaying
if _0xCBC4.CurrentId then
_0x5A01.Text = _0xCBC4.CurrentName or ("Sound ".. _0xCBC4.CurrentId)
_0x0A54.Text = _0xCBC4.Loading and"Loading…"or (_0xEC79 and"Playing"or (_0x7891.IsPaused and"Paused"or"Stopped"))
else
_0x5A01.Text ="Nothing playing"_0x0A54.Text ="Enter a Roblox audio ID below"_0xB1F7.Text ="0:00 / 0:00"_0xFA3E(0, true)
end
_0xC231.Text = _0xEC79 and"Pause"or ((_0xCBC4.CurrentId and _0x7891.IsPaused) and"Resume"or"Play")
_0xF6A4()
_0xF430()
end
_0xCBC4.Listeners[_0x8D74] = true
_0x8D74()
local _0xC9B9 = 0
_0x5951(_0x6B8F.Heartbeat, function(dt)
_0xC9B9 += dt
if _0xC9B9 < .25 then return end
_0xC9B9 = 0
if not (_0xD03D and (_0xF5B8 =="Misc"or _0x7DB1.Widgets.Misc.Enabled) and _0xCBC4.CurrentId) then return end
local _0x7D7C, _0x2A39 = _0x7891.TimeLength, _0x7891.TimePosition
_0xB1F7.Text = _0x0C6C(_0x2A39) .." / ".. _0x0C6C(_0x7D7C)
if os.clock() - _0xCBC7 > .6 then
_0xFA3E(_0x7D7C > 0 and _0x2A39 / _0x7D7C or 0, true)
end
end)
end)() endlocal _0x8AFA = _0x0012(_0x3D2F,"Infinite Yield", 2)
_0xA7CD(_0x8AFA,"Loads the Infinite Yield admin script from ScriptBlox. It runs separately from Mantle and needs an executor with HTTP access.", 11, _0x110B.Reg,"Sub", {
Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
})
local _0x9A40 = _0x8FFF(_0x8AFA, UDim2.new(1, 0, 0, 34), nil)
local _0xDA71 = false
_0xBF78(_0x9A40,"Launch Infinite Yield", {
Size = UDim2.fromOffset(170, 34), Variant ="Primary",
OnClick = function()
if _0xDA71 then return end
_0xDA71 = true
task.spawn(function()
local _0xF74B, _0x3D87 = pcall(function()
loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Infinite-Yield-230564"))()
end)
_0xDA71 = false
if _0xF74B then
_0x0625.Scripts += 1
_0x0625.Last ="Infinite Yield"_0x84A5("success","Infinite Yield launched")
_0xFD17("Infinite Yield  run", true)
_0x6DB0("Infinite Yield","Launched","success")
else
_0x84A5("error","Infinite Yield: ".. tostring(_0x3D87))
_0xFD17("Infinite Yield  failed: ".. tostring(_0x3D87), false)
_0x6DB0("Infinite Yield", tostring(_0x3D87),"error")
end
end)
end,
})
enddo
local _0x3D2F = _0x604B("Credits")
local _0xD23F = _0x8FFF(_0x3D2F, UDim2.new(1, 0, 0, 70), nil, { LayoutOrder = 1 })
_0xA7CD(_0xD23F,"Mantle", 28, _0x110B.Bold,"Text", {
Position = UDim2.new(0, 0, 0, 8), Size = UDim2.new(1, 0, 0, 34), TextXAlignment = Enum.TextXAlignment.Center,
})
_0xA7CD(_0xD23F,"Admin utility  ·  Game Bar edition  ·  v".. _0xC9DA, 12, _0x110B.Reg,"Sub", {
Position = UDim2.new(0, 0, 0, 44), Size = UDim2.new(1, 0, 0, 16), TextXAlignment = Enum.TextXAlignment.Center,
})
local _0x4D80 = _0x0012(_0x3D2F,"Credits", 2)
local function _0xAB0D(role, who)
local _0x5C16 = _0x8FFF(_0x4D80, UDim2.new(1, 0, 0, 24), nil)
_0xA7CD(_0x5C16, role, 13, _0x110B.Reg,"Sub", { Size = UDim2.new(.4, 0, 1, 0) })
_0xA7CD(_0x5C16, who, 13, _0x110B.Bold,"Text", { Position = UDim2.fromScale(.4, 0), Size = UDim2.fromScale(.6, 1) })
end
_0xAB0D("Idea","malachiqx")
_0xAB0D("Source","Not Open Source")
_0xAB0D("Version", _0xC9DA)
local _0xF402 = _0x0012(_0x3D2F, nil, 3)
_0xA7CD(_0xF402,"Mantle is a private admin script made for friends to use together. Thanks for using it!", 12, _0x110B.Reg,"Sub", {
Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
})
local _0x0278 = _0x0012(_0x3D2F,"Community", 4)
_0xA7CD(_0x0278,"Join the Mantle Discord for updates, support and new releases.", 12, _0x110B.Reg,"Sub", {
Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
})
_0xA7CD(_0x0278, _0x180A.Discord, 12, _0x110B.Med,"Accent", { Size = UDim2.new(1, 0, 0, 16) })
local _0x11C0 = _0x8FFF(_0x0278, UDim2.new(1, 0, 0, 34), nil)
_0xBF78(_0x11C0,"Discord", {
Size = UDim2.fromOffset(120, 34), Variant ="Primary",
OnClick = function()
if _0xB2A2.setclipboard then
_0x08C4(_0x180A.Discord,"Discord link")
else
_0x6DB0("Discord", _0x180A.Discord,"info")
end
end,
})
enddo
local _0x2F1A = _0xAB02()
local _0xB49A = math.clamp(_0x2F1A.X - 24, 300, 380)
local _0xD2B0 = math.clamp(_0x2F1A.Y - 120, 240, 380)
for _0x3AE9, _0x6A18 in ipairs({"Home","Commands","Players","Misc","Credits"}) do
_0xF922(_0x6A18, _0xB49A, _0xD2B0, true)
end
endlocal function _0xD313(_0xED20) return { _0xED20.R, _0xED20.G, _0xED20.B } end
local function _0xF629(defaults)
local _0xEF9E = {}
for _0x3AE9, _0x3CA5 in ipairs(_0x72F8) do
for _0x3AE9, inp in ipairs(_0x3CA5.Inputs or {}) do
if inp.Type ~="player"then
local _0x97B0 = defaults and inp.Default or _0x3CA5.Values[inp.Key]
if typeof(_0x97B0) =="Color3"then _0x97B0 = _0xD313(_0x97B0) end
_0xEF9E[_0x3CA5.Name] = _0xEF9E[_0x3CA5.Name] or {}
_0xEF9E[_0x3CA5.Name][inp.Key] = _0x97B0
end
end
end
return _0xEF9E
end
local function _0x64F3()
local _0xEF9E, _0x2A39 = {}, {}
for _0x6A18, _0xB148 in pairs(_0x7DB1.Widgets) do
_0xEF9E[_0x6A18] = { Enabled = _0xB148.Enabled, Pinned = _0xB148.Pinned }
local _0x46EC = _0x181D[_0x6A18]
if _0x46EC then
_0x2A39[_0x6A18] = { _0x46EC.Frame.Position.X.Offset, _0x46EC.Frame.Position.Y.Offset }
end
end
return _0xEF9E, _0x2A39
end
local function _0xF179()
local _0xEF9E = {}
for _0x3AE9, _0x3CA5 in ipairs(_0x72F8) do
if _0x3CA5.Key then _0xEF9E[_0x3CA5.Name] = _0x3CA5.Key end
end
return _0xEF9E
end
local function _0xC5BA()
local _0xF283, _0x2A39 = _0x64F3()
return {
_version = _0xA83C,
_0x7870 = _0x7DB1.Theme, Keybind = _0x7DB1.Keybind, NotifyStyle = _0x7DB1.NotifyStyle, Opacity = _0x7DB1.Opacity, _0x0DFA = _0x7DB1.Dim,
MobileButton = _0x7DB1.MobileButton, QuickActions = table.clone(_0x7DB1.QuickActions), Values = _0xF629(false),
_0x181D = _0xF283, WidgetPos = _0x2A39, Keybinds = _0xF179(),
_0xB400 = _0x7DB1.BgImage, BgOpacity = _0x7DB1.BgOpacity, _0xCBC4 = _0xCBC4.Collect(),
}
end
local function _0x24A3(_0x5D96)
if type(_0x5D96) ~="table"then return end
if type(_0x5D96.Theme) =="string"then _0x78AC(_0x5D96.Theme) end
if type(_0x5D96.NotifyStyle) =="string"then _0x180A.SetNotifyStyle(_0x5D96.NotifyStyle, true) end
if type(_0x5D96.Opacity) =="number"then
_0x241E(_0x5D96.Opacity)
_0x9860.OpacitySet(_0x7DB1.Opacity)
end
if type(_0x5D96.Dim) =="boolean"then _0x7E04(_0x5D96.Dim) end
if type(_0x5D96.BgOpacity) =="number"then
_0xC261(_0x5D96.BgOpacity)
if _0x9860.BgOpacitySet then _0x9860.BgOpacitySet(_0x7DB1.BgOpacity) end
end
if type(_0x5D96.BgImage) =="string"then _0xF5BB(_0x5D96.BgImage) end
if type(_0x5D96.Music) =="table"then _0xCBC4.Apply(_0x5D96.Music) end
if type(_0x5D96.PerfPinned) =="boolean"then _0xFA40("Performance", _0x5D96.PerfPinned) endif type(_0x5D96.Widgets) =="table"then
for _0x6A18, _0x0A17 in pairs(_0x5D96.Widgets) do
local _0xB148 = _0x7DB1.Widgets[_0x6A18]
if _0xB148 and type(_0x0A17) =="table"then
if type(_0x0A17.Enabled) =="boolean"and _0x0A17.Enabled ~= _0xB148.Enabled then _0xC94A(_0x6A18, _0x0A17.Enabled) end
if type(_0x0A17.Pinned) =="boolean"then _0xFA40(_0x6A18, _0x0A17.Pinned) end
end
end
end
if type(_0x5D96.WidgetPos) =="table"then
for _0x6A18, _0xE0D1 in pairs(_0x5D96.WidgetPos) do
local _0x46EC = _0x181D[_0x6A18]
if _0x46EC and type(_0xE0D1) =="table"and type(_0xE0D1[1]) =="number"and type(_0xE0D1[2]) =="number"then
_0x46EC.Frame.Position = UDim2.fromOffset(_0xE0D1[1], _0xE0D1[2])
end
end
_0xDA8C()
end
if type(_0x5D96.Keybinds) =="table"then
for _0x3AE9, _0x3CA5 in ipairs(_0x72F8) do
if _0x3CA5.Key then _0x22C8(_0x3CA5, nil) end
end
for _0x6A18, _0xB2C2 in pairs(_0x5D96.Keybinds) do
local _0x3CA5 = _0xB283[_0x3714(tostring(_0x6A18))]
if _0x3CA5 and type(_0xB2C2) =="string"and _0xA311(_0xB2C2) then _0x22C8(_0x3CA5, _0xB2C2) end
end
end
if type(_0x5D96.Keybind) =="string"and _0xA311(_0x5D96.Keybind) then _0xCB0F(_0x5D96.Keybind) end
if type(_0x5D96.MobileButton) =="boolean"then _0x1863(_0x5D96.MobileButton) end
if type(_0x5D96.QuickActions) =="table"then
local _0xC4DD = {}
for _0x3AE9, _0x1CA9 in ipairs(_0x5D96.QuickActions) do
if type(_0x1CA9) =="string"and _0xB283[_0x3714(_0x1CA9)] then table.insert(_0xC4DD, _0xB283[_0x3714(_0x1CA9)].Name) end
end
_0x7DB1.QuickActions = _0xC4DD
for _0x3AE9, _0x920B in pairs(_0x9860.QuickChips) do _0x920B() end
_0x9860.RebuildQuick()
end
if type(_0x5D96.Values) =="table"then
for _0x6A18, vals in pairs(_0x5D96.Values) do
local _0x3CA5 = _0xB283[_0x3714(tostring(_0x6A18))]
if _0x3CA5 and type(vals) =="table"then
for _0xB2C2, _0x97B0 in pairs(vals) do
local _0x5D26 = _0x3CA5.Setters[_0xB2C2]
if _0x5D26 then
if type(_0x97B0) =="table"and #_0x97B0 == 3 then _0x97B0 = Color3.new(_0x97B0[1], _0x97B0[2], _0x97B0[3]) end
if type(_0x97B0) =="number"thenfor _0x3AE9, inp in ipairs(_0x3CA5.Inputs or {}) do
if inp.Key == _0xB2C2 then
if _0x97B0 ~= _0x97B0 or _0x97B0 == math.huge or _0x97B0 == -math.huge then _0x97B0 = inp.Default
else _0x97B0 = math.clamp(_0x97B0, inp.Min or -1e9, inp.Max or 1e9) end
break
end
end
end
if typeof(_0x97B0) == typeof(_0x3CA5.Values[_0xB2C2]) or (_0x3CA5.Values[_0xB2C2] == nil and type(_0x97B0) =="string") then _0x5D26(_0x97B0) end
end
end
end
end
end
end
_0x3751 = function()
local _0x72C8 = _0xC5BA()
shared.MantleConfig = _0x72C8
if _0xCBD8 then
local _0xF74B, _0x3D87 = pcall(function()
if _0xB2A2.makefolder and _0xB2A2.isfolder and not _0xB2A2.isfolder("Mantle") then _0xB2A2.makefolder("Mantle") end
_0xB2A2.writefile(_0xA3E5, _0x92EE:JSONEncode(_0x72C8))
end)
if _0xF74B then
_0x84A5("success","Config saved to ".. _0xA3E5)
_0x6DB0("Config","Saved to ".. _0xA3E5,"success")
else
_0x84A5("error","Config save failed: ".. tostring(_0x3D87))
_0x6DB0("Config","Save failed: ".. tostring(_0x3D87),"error")
end
else
_0x84A5("warn","No file system; config kept for this session only")
_0x6DB0("Config","No file system here. Saved for this session only.","warn")
end
end
_0xC25C = function(silent)
local _0x72C8
if _0xCBD8 then
pcall(function()
if _0xB2A2.isfile(_0xA3E5) then
_0x72C8 = _0x92EE:JSONDecode(_0xB2A2.readfile(_0xA3E5))
end
end)
end
_0x72C8 = _0x72C8 or shared.MantleConfig
if not _0x72C8 then
if not silent then _0x6DB0("Config","No saved config found","warn") end
return false
end
local _0xC58C = type(_0x72C8._version) =="number"and _0x72C8._version or 0
if _0xC58C > _0xA83C then_0x84A5("warn","Config is from a newer Mantle (v".. _0xC58C .."); ignoring it")
if not silent then _0x6DB0("Config","Saved config is from a newer version; ignored","warn") end
return false
end
while _0xC58C < _0xA83C do
local _0x7EED = _0x8A1C[_0xC58C]
if not _0x7EED then
_0x84A5("warn","No migration from config v".. _0xC58C .."; ignoring saved config")
if not silent then _0x6DB0("Config","Saved config is outdated and was ignored","warn") end
return false
end
local _0xF74B, _0x0AC9 = pcall(_0x7EED, _0x72C8)
if not _0xF74B or type(_0x0AC9) ~="table"then
_0x84A5("error","Config migration failed: ".. tostring(_0x0AC9))
return false
end
_0x72C8, _0xC58C = _0x0AC9, _0xC58C + 1
end
_0x24A3(_0x72C8)
_0x84A5("success","Config loaded")
if not silent then _0x6DB0("Config","Config loaded","success") end
return true
end
_0x249F = function()
_0x24A3({
_0x7870 ="Onyx", Keybind ="K", NotifyStyle ="Toast", Opacity = 1, _0x0DFA = true,
MobileButton = _0x22C9.TouchEnabled, _0x181D = _0x8484(), Keybinds = { Fly ="F"},
QuickActions = table.clone(_0xE2B2), Values = _0xF629(true),
_0xB400 ="", BgOpacity = .4, _0xCBC4 = { Volume = .5, Speed = 1, Loop = false },})
_0x84A5("info","Config reset to defaults")
_0x6DB0("Config","Reset to defaults","info")
enddo
local function _0x8851()
local _0x735B = os.date("%I:%M %p")
_0x55CC.Text = (_0x735B:gsub("^0",""))
if _0x9860.InfoUpdate then _0x9860.InfoUpdate() end
end
_0x8851()local _0xCA2B, _0xB6C6 = 0, os.clock()
local _0xEE8E
_0x5951(_0x6B8F.RenderStepped, function()
_0xCA2B += 1
local _0x7A4E = os.clock()
local _0x7FD2 = _0x7A4E - _0xB6C6
if _0x7FD2 >= .5 then
local _0xBA80 = _0xCA2B / _0x7FD2
_0xCA2B, _0xB6C6 = 0, _0x7A4E
local _0x8762 = _0xEAAA()
_0xEE8E = _0xEE8E and (_0xEE8E + (_0x8762 - _0xEE8E) * .5) or _0x8762
_0x98AB(math.floor(_0xBA80 + .5), math.floor(_0xEE8E + .5))
_0x8851()
end
end)
end_0x3FBD = function()
for _0x3AE9, _0x3CA5 in ipairs(_0x72F8) do
pcall(function()
if _0x3CA5.Kind =="Toggle"and _0x3CA5.Enabled then
_0x3CA5.Func(_0x3CA5, _0x3CA5.Values, false)
elseif _0x3CA5.Stop and _0x3CA5.Enabled then
_0x3CA5.Stop(_0x3CA5, _0x3CA5.Values)
end
if _0x3CA5.Cleanup then _0x3CA5.Cleanup(_0x3CA5) end
end)
end
for _0x3AE9, _0xED20 in ipairs(_0xDC63) do
pcall(function() _0xED20:Disconnect() end)
end
pcall(function() _0xFF7D:Destroy() end)
pcall(function() _0xBBAC:Destroy() end)
pcall(function() _0xCBC4.Sound:Destroy() end)
pcall(function() _0x8358:Destroy() end)
pcall(function() _0xC997:Destroy() end)
shared.MantleTerminate = nil
end
shared.MantleTerminate = _0x3FBD_0x2C56()
if workspace.CurrentCamera then
_0x5951(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), _0x2C56)
end
_0xCB0F(_0x7DB1.Keybind)
_0x78AC("Onyx", true)
for _0x3AE9, _0x6A18 in ipairs(_0xF276) do
local _0xB148 = _0x7DB1.Widgets[_0x6A18]
if _0xB148.Enabled then _0xC94A(_0x6A18, true) end
_0xFA40(_0x6A18, _0xB148.Pinned)
end
_0x22C8(_0xB283["fly"],"F")_0xC25C(true)_0xF5B8 = nil
for _0x3AE9, _0x1CA9 in ipairs(_0x2287) do
if _0xC8F9(_0x1CA9) then
_0x2D01(_0x1CA9)
break
end
end_0x84A5("success", ("Mantle v%s loaded for %s"):format(_0xC9DA, _0x0F7F.Name))
_0x6DB0("Mantle","Loaded. ".. _0x7DB1.Keybind .." shows / hides Mantle. Use the Command Bar widget to run commands.","success")if _0xB2A2.setclipboard then
local _0xEE3D = pcall(_0xB2A2.setclipboard, _0x180A.Discord)
if _0xEE3D then
_0x6DB0("Copied Discord Link","discord.gg/mU7kUXnxbu","success", true)
end
end
