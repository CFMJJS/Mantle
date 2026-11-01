--[[
	Mantle - Game Bar edition
	A clean admin utility for you and your friends.
	Idea: malachiqx  |  Code: Claude Sonnet 5.5

	Usage: put this in a LocalScript (StarterPlayerScripts / StarterGui),
	or run it from your own tooling. Everything lives in this one file.

	Quick keys
	  RightShift  show / hide the Mantle bar   (rebindable in Settings)
	  Command Bar widget   type a command and press Enter (pin it to keep it on screen)
]]

local VERSION = "1.5.1"

-- Troubleshooting: set any of these to false to skip that feature while Mantle loads.
local FEATURES = { Music = true, Background = true, NewCommands = true }

-- Owner tag --------------------------------------------------------------------------
-- Anyone with this username automatically gets a gold "Owner" tag (seen only by Mantle users).
local OWNER_USERNAME = "malachiqx"

--==================================================================================--
--  SERVICES
--==================================================================================--
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local Stats = game:GetService("Stats")
local ContextActionService = game:GetService("ContextActionService")

local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

-- Replace any previous instance
if shared.MantleTerminate then
	pcall(shared.MantleTerminate)
end

--==================================================================================--
--  ENVIRONMENT (optional extras - everything degrades gracefully without them)
--==================================================================================--
local Env = {
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
local HasFS = typeof(Env.writefile) == "function" and typeof(Env.readfile) == "function" and typeof(Env.isfile) == "function"
local CONFIG_FILE = "Mantle/config.json"
local StartClock = os.clock()
-- Session statistics shown in Home > General Info
local SessionStats = { Scripts = 0, Last = nil }

--==================================================================================--
--  CORE UTILITIES
--==================================================================================--
local Connections = {}
local function Connect(signal, fn)
	local c = signal:Connect(fn)
	table.insert(Connections, c)
	return c
end

local function Tween(inst, t, props, style, dir)
	local tw = TweenService:Create(inst, TweenInfo.new(t, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end

local function C(r, g, b)
	return Color3.fromRGB(r, g, b)
end

-- Source Sans is the closest built-in match to Segoe UI (the Game Bar font).
local F = {
	Reg = Enum.Font.SourceSans,
	Med = Enum.Font.SourceSansSemibold,
	Bold = Enum.Font.SourceSansBold,
	Code = Enum.Font.Code,
}
local function TS(n)
	return math.floor(n * 1.12 + .5)
end

local function FmtTime(s)
	s = math.floor(s)
	return ("%d:%02d:%02d"):format(s // 3600, (s % 3600) // 60, s % 60)
end

-- Logging ----------------------------------------------------------------------------
local Logs, LogEvent = {}, Instance.new("BindableEvent")
local function Log(level, msg)
	local entry = { Time = os.date("%H:%M:%S"), Level = level, Msg = tostring(msg) }
	table.insert(Logs, entry)
	if #Logs > 400 then
		table.remove(Logs, 1)
	end
	LogEvent:Fire(entry)
end

-- Helpers ----------------------------------------------------------------------------
local function Hum()
	local c = LP.Character
	return c and c:FindFirstChildOfClass("Humanoid")
end
local function Root()
	local c = LP.Character
	return c and c:FindFirstChild("HumanoidRootPart")
end

local function FindPlayer(q)
	if not q or q == "" then
		return nil
	end
	q = q:lower()
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Name:lower() == q or p.DisplayName:lower() == q then
			return p
		end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Name:lower():sub(1, #q) == q or p.DisplayName:lower():sub(1, #q) == q then
			return p
		end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Name:lower():find(q, 1, true) or p.DisplayName:lower():find(q, 1, true) then
			return p
		end
	end
	return nil
end

local PingItem
local function GetPing()
	if not PingItem then
		pcall(function()
			PingItem = Stats.Network.ServerStatsItem["Data Ping"]
		end)
	end
	if PingItem then
		local ok, v = pcall(PingItem.GetValue, PingItem)
		if ok and type(v) == "number" and v > 0 then
			return v
		end
		if not ok then
			PingItem = nil -- stale reference (e.g. server migration): re-fetch next call
		end
	end
	local ok, p = pcall(function()
		return LP:GetNetworkPing() * 2000
	end)
	return ok and p or 0
end

--==================================================================================--
--  THEMES
--==================================================================================--
local Themes = {
	["Dark"] = {
		Bg = C(14, 14, 18), Surface = C(22, 22, 28), Surface2 = C(32, 32, 40), Stroke = C(46, 46, 57),
		Text = C(240, 240, 246), Sub = C(146, 146, 162), Accent = C(242, 124, 56), AccentText = C(255, 255, 255),
		Good = C(84, 204, 126), Bad = C(238, 86, 86), Warn = C(240, 190, 70),
	},
	["Light"] = {
		Bg = C(232, 234, 240), Surface = C(255, 255, 255), Surface2 = C(240, 242, 247), Stroke = C(216, 220, 230),
		Text = C(26, 28, 36), Sub = C(112, 116, 132), Accent = C(16, 124, 16), AccentText = C(255, 255, 255),
		Good = C(40, 160, 90), Bad = C(212, 62, 62), Warn = C(206, 140, 20),
	},
	["Onyx"] = {
		Bg = C(5, 5, 6), Surface = C(12, 12, 14), Surface2 = C(22, 22, 25), Stroke = C(38, 38, 43),
		Text = C(236, 236, 238), Sub = C(128, 128, 136), Accent = C(232, 232, 236), AccentText = C(8, 8, 10),
		Good = C(96, 210, 130), Bad = C(240, 90, 90), Warn = C(240, 192, 80),
	},
	["Bone"] = {
		Bg = C(226, 219, 204), Surface = C(240, 234, 221), Surface2 = C(229, 222, 207), Stroke = C(206, 197, 178),
		Text = C(56, 49, 40), Sub = C(128, 117, 100), Accent = C(150, 108, 66), AccentText = C(250, 245, 235),
		Good = C(86, 130, 70), Bad = C(178, 70, 60), Warn = C(190, 140, 40),
	},
	["Catppuccin Frappe"] = {
		Bg = C(41, 44, 60), Surface = C(48, 52, 70), Surface2 = C(65, 69, 89), Stroke = C(81, 87, 109),
		Text = C(198, 208, 245), Sub = C(165, 173, 206), Accent = C(202, 158, 230), AccentText = C(35, 38, 52),
		Good = C(166, 209, 137), Bad = C(231, 130, 132), Warn = C(229, 200, 144),
	},
	["Catppuccin Mocha"] = {
		Bg = C(30, 30, 46), Surface = C(36, 36, 54), Surface2 = C(49, 50, 68), Stroke = C(69, 71, 90),
		Text = C(205, 214, 244), Sub = C(166, 173, 200), Accent = C(203, 166, 247), AccentText = C(24, 24, 37),
		Good = C(166, 227, 161), Bad = C(243, 139, 168), Warn = C(249, 226, 175),
	},
	["Catppuccin Latte"] = {
		Bg = C(230, 233, 239), Surface = C(239, 241, 245), Surface2 = C(220, 224, 232), Stroke = C(204, 208, 218),
		Text = C(76, 79, 105), Sub = C(108, 111, 133), Accent = C(136, 57, 239), AccentText = C(255, 255, 255),
		Good = C(64, 160, 43), Bad = C(210, 15, 57), Warn = C(223, 142, 29),
	},
	["Graphite"] = {
		Bg = C(28, 30, 34), Surface = C(37, 40, 45), Surface2 = C(48, 52, 58), Stroke = C(62, 66, 74),
		Text = C(228, 231, 236), Sub = C(148, 154, 164), Accent = C(124, 164, 230), AccentText = C(14, 18, 26),
		Good = C(120, 206, 150), Bad = C(236, 106, 106), Warn = C(232, 196, 100),
	},
}
local ThemeOrder = { "Onyx", "Dark", "Light", "Bone", "Catppuccin Mocha", "Catppuccin Frappe", "Catppuccin Latte", "Graphite" }
local Theme = Themes["Onyx"]

-- Settings state ---------------------------------------------------------------------
local DEFAULT_QUICK = { "Fly", "Teleport Tool", "Fullbright", "Rejoin", "Reset Character" }
local function DefaultWidgetConfig()
	local touch = UserInputService.TouchEnabled
	return {
		Performance = { Enabled = true, Pinned = not touch },
		Keybinds = { Enabled = not touch, Pinned = false },
		Home = { Enabled = false, Pinned = false },
		Commands = { Enabled = false, Pinned = false },
		Players = { Enabled = false, Pinned = false },
		Misc = { Enabled = false, Pinned = false },
		Credits = { Enabled = false, Pinned = false },
		["Command Bar"] = { Enabled = true, Pinned = not touch },
		["Command History"] = { Enabled = true, Pinned = false },
		["Command List"] = { Enabled = false, Pinned = false },
	}
end

local CONFIG_VERSION = 1
-- Migrations: Migrations[n] upgrades a saved table from version n to n + 1.
-- Add an entry here whenever a config key is renamed, moved or removed.
local Migrations = {
	[0] = function(d) return d end, -- pre-versioning files: same keys, just stamp the version
}

local Config = {
	_version = CONFIG_VERSION,
	Theme = "Onyx",
	Keybind = "RightShift",
	Opacity = 1,
	Dim = true,
	Widgets = DefaultWidgetConfig(),
	MobileButton = UserInputService.TouchEnabled,
	QuickActions = table.clone(DEFAULT_QUICK),
	BgImage = "",
	BgOpacity = .4,
}

-- Theme binding ----------------------------------------------------------------------
local ThemeEntries = {}

local function Bind(inst, prop, getter)
	table.insert(ThemeEntries, { inst = inst, prop = prop, get = getter })
	inst[prop] = getter()
	return function(t)
		local v = getter()
		if t and t > 0 then
			Tween(inst, t, { [prop] = v })
		else
			inst[prop] = v
		end
	end
end

local function Style(inst, map)
	local ups = {}
	for prop, key in pairs(map) do
		ups[prop] = Bind(inst, prop, type(key) == "function" and key or function()
			return Theme[key]
		end)
	end
	return ups
end

local function Prune()
	for i = #ThemeEntries, 1, -1 do
		if not ThemeEntries[i].inst.Parent then
			table.remove(ThemeEntries, i)
		end
	end
end

--==================================================================================--
--  UI BUILDING BLOCKS
--==================================================================================--
local function New(class, props, children)
	local inst = Instance.new(class)
	local parent
	for k, v in pairs(props or {}) do
		if k == "Parent" then
			parent = v
		else
			inst[k] = v
		end
	end
	for _, c in ipairs(children or {}) do
		c.Parent = inst
	end
	inst.Parent = parent
	return inst
end

local function Corner(inst, r)
	return New("UICorner", { CornerRadius = UDim.new(0, r), Parent = inst })
end

local function Pad(inst, l, t, r, b)
	return New("UIPadding", {
		PaddingLeft = UDim.new(0, l or 0), PaddingTop = UDim.new(0, t or 0),
		PaddingRight = UDim.new(0, r or 0), PaddingBottom = UDim.new(0, b or 0), Parent = inst,
	})
end

local function List(inst, pad, dir, ha, va)
	return New("UIListLayout", {
		Parent = inst, Padding = UDim.new(0, pad or 0),
		FillDirection = dir or Enum.FillDirection.Vertical, SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = ha or Enum.HorizontalAlignment.Left,
		VerticalAlignment = va or Enum.VerticalAlignment.Top,
	})
end

local function Stroke(inst, key, thickness)
	local s = New("UIStroke", { Parent = inst, Thickness = thickness or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
	Style(s, { Color = key or "Stroke" })
	return s
end

local function Frame(parent, size, bgKey, props)
	local f = New("Frame", { Parent = parent, Size = size, BorderSizePixel = 0, BackgroundTransparency = bgKey and 0 or 1 })
	for k, v in pairs(props or {}) do
		f[k] = v
	end
	if bgKey then
		Style(f, { BackgroundColor3 = bgKey })
	end
	return f
end

local function Label(parent, text, size, font, colorKey, props)
	local l = New("TextLabel", {
		Parent = parent, BackgroundTransparency = 1, BorderSizePixel = 0, Text = text, TextSize = TS(size),
		Font = font, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, 0, 0, size + 4),
	})
	for k, v in pairs(props or {}) do
		l[k] = v
	end
	Style(l, { TextColor3 = colorKey })
	return l
end

local function MakeButton(parent, text, o)
	o = o or {}
	local variant = o.Variant or "Soft"
	local b = New("TextButton", {
		Parent = parent, Size = o.Size or UDim2.fromOffset(96, 32), Text = text, Font = F.Med,
		TextSize = TS(o.TextSize or 13), AutoButtonColor = false, BorderSizePixel = 0,
		TextTruncate = Enum.TextTruncate.AtEnd,
	})
	Corner(b, 6)
	if o.AutoX then
		b.AutomaticSize = Enum.AutomaticSize.X
		b.Size = UDim2.fromOffset(0, o.Height or 30)
		Pad(b, 14, 0, 14, 0)
	end
	local function isPrimary()
		return variant == "Primary" or (o.Active and o.Active())
	end
	local function bg()
		if isPrimary() then return Theme.Accent end
		if variant == "Danger" then return Theme.Bad end
		return Theme.Surface2
	end
	local function fg()
		if isPrimary() then return Theme.AccentText end
		if variant == "Danger" then return Color3.new(1, 1, 1) end
		return Theme.Text
	end
	local ups = Style(b, { BackgroundColor3 = bg, TextColor3 = fg })
	b.MouseEnter:Connect(function()
		Tween(b, .12, { BackgroundColor3 = bg():Lerp(Theme.Text, .10) })
	end)
	b.MouseLeave:Connect(function()
		Tween(b, .15, { BackgroundColor3 = bg() })
	end)
	b.MouseButton1Down:Connect(function()
		Tween(b, .08, { BackgroundColor3 = bg():Lerp(Theme.Text, .20) })
	end)
	b.MouseButton1Up:Connect(function()
		Tween(b, .12, { BackgroundColor3 = bg():Lerp(Theme.Text, .10) })
	end)
	if o.OnClick then
		b.MouseButton1Click:Connect(o.OnClick)
	end
	local function refresh()
		ups.BackgroundColor3(.18)
		ups.TextColor3(.18)
	end
	return b, refresh
end

local function Switch(parent, default, onChange)
	local on = default and true or false
	local track = New("TextButton", {
		Parent = parent, Size = UDim2.fromOffset(40, 22), Text = "", AutoButtonColor = false, BorderSizePixel = 0,
	})
	Corner(track, 11)
	local knob = New("Frame", {
		Parent = track, Size = UDim2.fromOffset(16, 16), BorderSizePixel = 0,
		Position = on and UDim2.fromOffset(21, 3) or UDim2.fromOffset(3, 3),
	})
	Corner(knob, 8)
	local upT = Style(track, { BackgroundColor3 = function() return on and Theme.Accent or Theme.Stroke end }).BackgroundColor3
	local upK = Style(knob, { BackgroundColor3 = function() return on and Theme.AccentText or Theme.Sub end }).BackgroundColor3
	local function set(v, silent)
		on = v and true or false
		upT(.18)
		upK(.18)
		Tween(knob, .18, { Position = on and UDim2.fromOffset(21, 3) or UDim2.fromOffset(3, 3) })
		if not silent and onChange then
			onChange(on)
		end
	end
	track.MouseButton1Click:Connect(function()
		set(not on)
	end)
	return track, set
end

local function Slider(parent, min, max, default, onChange, gradient)
	local holder = Frame(parent, UDim2.new(1, 0, 0, 20), nil)
	local track = New("Frame", {
		Parent = holder, Position = UDim2.new(0, 7, .5, -3), Size = UDim2.new(1, -14, 0, 6), BorderSizePixel = 0,
	})
	Corner(track, 3)
	local fill
	if gradient then
		track.BackgroundColor3 = Color3.new(1, 1, 1)
		New("UIGradient", { Color = gradient, Parent = track })
	else
		Style(track, { BackgroundColor3 = "Stroke" })
		fill = Frame(track, UDim2.fromScale(0, 1), "Accent")
		Corner(fill, 3)
	end
	local knob = New("Frame", {
		Parent = track, AnchorPoint = Vector2.new(.5, .5), Size = UDim2.fromOffset(14, 14), BorderSizePixel = 0,
		Position = UDim2.fromScale(0, .5),
	})
	Corner(knob, 7)
	Style(knob, { BackgroundColor3 = "Text" })
	Stroke(knob, "Surface", 2)

	local function set(v, silent)
		v = math.clamp(v, min, max)
		local a = (v - min) / (max - min)
		knob.Position = UDim2.fromScale(a, .5)
		if fill then
			fill.Size = UDim2.fromScale(a, 1)
		end
		if not silent and onChange then
			onChange(v)
		end
	end
	set(default, true)

	local dragging = false
	local function fromX(x)
		local a = math.clamp((x - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
		set(min + (max - min) * a)
	end
	holder.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			fromX(input.Position.X)
		end
	end)
	Connect(UserInputService.InputChanged, function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			fromX(input.Position.X)
		end
	end)
	Connect(UserInputService.InputEnded, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
	return holder, set
end

local function Field(parent, placeholder, size)
	local f = Frame(parent, size or UDim2.new(1, 0, 0, 34), "Surface2")
	Corner(f, 6)
	local st = Stroke(f, "Stroke")
	local tb = New("TextBox", {
		Parent = f, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, -20, 1, 0),
		Position = UDim2.fromOffset(10, 0), Text = "", PlaceholderText = placeholder, Font = F.Reg, TextSize = TS(13),
		TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false,
	})
	Style(tb, { TextColor3 = "Text", PlaceholderColor3 = "Sub" })
	tb.Focused:Connect(function()
		Tween(st, .15, { Color = Theme.Accent })
	end)
	tb.FocusLost:Connect(function()
		Tween(st, .15, { Color = Theme.Stroke })
	end)
	return f, tb
end

local function Pill(parent, text, solid)
	local p = Frame(parent, UDim2.fromOffset(0, 22), solid and "Accent" or "Surface2", { AutomaticSize = Enum.AutomaticSize.X })
	Corner(p, 11)
	Pad(p, 10, 0, 10, 0)
	Label(p, text, 11, F.Med, solid and "AccentText" or "Sub", {
		Size = UDim2.fromOffset(0, 22), AutomaticSize = Enum.AutomaticSize.X,
	})
	return p
end

local function Card(parent, title, order)
	local card = Frame(parent, UDim2.new(1, 0, 0, 0), "Surface", { AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = order or 0 })
	Corner(card, 8)
	Stroke(card)
	Pad(card, 14, 12, 14, 14)
	List(card, 10)
	if title then
		Label(card, title, 14, F.Bold, "Text", { Size = UDim2.new(1, 0, 0, 18) })
	end
	return card
end

local function WrapHolder(parent, order)
	local h = Frame(parent, UDim2.new(1, 0, 0, 0), nil, { AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = order or 0 })
	local l = List(h, 8, Enum.FillDirection.Horizontal)
	l.Wraps = true
	return h
end

local function MakeDraggable(handle, target, onStart)
	local dragging = false
	local startPos, startMouse
	local goalX, goalY, curX, curY = 0, 0, 0, 0
	local loop
	local function step(dt)
		if not target.Parent then
			loop:Disconnect()
			loop = nil
			return
		end
		local a = 1 - math.exp(-dt * 26)
		curX += (goalX - curX) * a
		curY += (goalY - curY) * a
		if not dragging and math.abs(goalX - curX) < .4 and math.abs(goalY - curY) < .4 then
			curX, curY = goalX, goalY
			loop:Disconnect()
			loop = nil
		end
		target.Position = UDim2.new(startPos.X.Scale, curX, startPos.Y.Scale, curY)
	end
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging, startMouse, startPos = true, input.Position, target.Position
			curX, curY = startPos.X.Offset, startPos.Y.Offset
			goalX, goalY = curX, curY
			if onStart then
				onStart()
			end
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	Connect(UserInputService.InputChanged, function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local d = input.Position - startMouse
			goalX, goalY = startPos.X.Offset + d.X, startPos.Y.Offset + d.Y
			if not loop then
				loop = RunService.RenderStepped:Connect(step)
			end
		end
	end)
end

-- Tiny bar graph (used by the Performance widget) -------------------------------------
local function Graph(parent, pos, size, n)
	local holder = Frame(parent, size, "Surface2", { Position = pos, ClipsDescendants = true })
	Corner(holder, 4)
	local bars = {}
	for i = 1, n do
		local b = New("Frame", {
			Parent = holder, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new((i - 1) / n, 0, 1, 0),
			Size = UDim2.new(1 / n, -1, 0, 0), BorderSizePixel = 0,
		})
		Style(b, { BackgroundColor3 = "Accent" })
		bars[i] = b
	end
	return function(hist, maxV)
		local off = n - #hist
		for i = 1, n do
			local v = hist[i - off]
			bars[i].Size = UDim2.new(1 / n, -1, v and math.clamp(v / maxV, .04, 1) or 0, 0)
		end
	end
end

--==================================================================================--
--  ROOT GUI + TOASTS
--==================================================================================--
local function GuiParent()
	local ok, h = pcall(function()
		return Env.gethui and Env.gethui()
	end)
	if ok and h then
		return h
	end
	return PlayerGui
end

local Gui = New("ScreenGui", {
	Name = "Mantle", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	IgnoreGuiInset = true, DisplayOrder = 999, Parent = GuiParent(),
})

local ToastHolder = New("Frame", {
	Name = "Toasts", Parent = Gui, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -18, 1, -18),
	Size = UDim2.new(0, 290, 1, -36), BackgroundTransparency = 1, ZIndex = 100,
})
List(ToastHolder, 8, nil, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Bottom)

local KindColor = { info = "Accent", success = "Good", warn = "Warn", error = "Bad" }
local function Notify(title, msg, kind)
	kind = kind or "info"
	Prune()
	local toast = New("CanvasGroup", {
		Parent = ToastHolder, Size = UDim2.fromOffset(290, 0), AutomaticSize = Enum.AutomaticSize.Y,
		BorderSizePixel = 0, GroupTransparency = 1,
	})
	Style(toast, { BackgroundColor3 = "Surface" })
	Corner(toast, 8)
	Stroke(toast)
	Frame(toast, UDim2.new(0, 3, 1, 0), KindColor[kind] or "Accent")
	local body = Frame(toast, UDim2.new(1, 0, 0, 0), nil, { AutomaticSize = Enum.AutomaticSize.Y })
	Pad(body, 16, 9, 12, 10)
	List(body, 2)
	Label(body, title, 13, F.Bold, "Text", { Size = UDim2.new(1, 0, 0, 16) })
	Label(body, tostring(msg), 12, F.Reg, "Sub", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
	})
	local toastScale = New("UIScale", { Parent = toast, Scale = .92 })
	Tween(toast, .3, { GroupTransparency = 0 })
	Tween(toastScale, .4, { Scale = 1 }, Enum.EasingStyle.Back)
	task.delay(3.6, function()
		if toast.Parent then
			local tw = Tween(toast, .35, { GroupTransparency = 1 })
			tw.Completed:Connect(function()
				toast:Destroy()
			end)
		end
	end)
end

local function CopyText(text, what)
	if Env.setclipboard then
		pcall(Env.setclipboard, text)
		Notify("Copied", what .. " copied to clipboard", "success")
	else
		Notify("Copy", "Clipboard API unavailable in this environment", "warn")
	end
end

--==================================================================================--
--  COMMAND SYSTEM
--==================================================================================--
local Commands, CommandByKey = {}, {}
local PlayerListeners = {} -- functions fired when the player list changes

local function Key(s)
	return (s:lower():gsub("%s+", ""))
end

-- Command history (shown by the Command History widget) -----------------------------
local History, HistoryEvent = {}, Instance.new("BindableEvent")
local function Record(text, ok)
	table.insert(History, { Time = os.date("%H:%M:%S"), Text = text, Ok = ok and true or false })
	if #History > 100 then
		table.remove(History, 1)
	end
	HistoryEvent:Fire()
end

local function AddCommand(def)
	def.Values, def.Setters, def.Listeners, def.Enabled = {}, {}, {}, false
	def.KeyListeners = {}
	for _, inp in ipairs(def.Inputs or {}) do
		def.Values[inp.Key] = inp.Default
	end
	table.insert(Commands, def)
	CommandByKey[Key(def.Name)] = def
	for _, a in ipairs(def.Aliases or {}) do
		CommandByKey[a] = def
	end
end

local function SetState(cmd, state)
	cmd.Enabled = state and true or false
	for fn in pairs(cmd.Listeners) do
		fn(cmd.Enabled)
	end
end

local function Execute(cmd)
	if cmd.Kind == "Toggle" then
		local target = not cmd.Enabled
		local ok, err = pcall(cmd.Func, cmd, cmd.Values, target)
		if ok then
			SetState(cmd, target)
			if target then -- turning a script OFF doesn't count as running one
				SessionStats.Scripts += 1
				SessionStats.Last = cmd.Name
			end
			Log("success", cmd.Name .. (target and " enabled" or " disabled"))
			Record(cmd.Name .. (target and "  ON" or "  OFF"), true)
			Notify(cmd.Name, target and "Enabled" or "Disabled", target and "success" or "info")
		else
			Log("error", cmd.Name .. ": " .. tostring(err))
			Record(cmd.Name .. "  failed: " .. tostring(err), false)
			Notify(cmd.Name, tostring(err), "error")
		end
	else
		local ok, err = pcall(cmd.Func, cmd, cmd.Values)
		if ok then
			SessionStats.Scripts += 1
			SessionStats.Last = cmd.Name
			Log("success", cmd.Name .. " executed")
			Record(cmd.Name .. "  run", true)
			if not cmd.Silent then
				Notify(cmd.Name, "Executed", "success")
			end
		else
			Log("error", cmd.Name .. ": " .. tostring(err))
			Record(cmd.Name .. "  failed: " .. tostring(err), false)
			Notify(cmd.Name, tostring(err), "error")
		end
	end
end

local function StopCommand(cmd)
	if cmd.Stop then
		local ok, err = pcall(cmd.Stop, cmd, cmd.Values)
		SetState(cmd, false)
		if ok then
			Log("info", cmd.Name .. " stopped")
			Record(cmd.Name .. "  stopped", true)
			Notify(cmd.Name, "Stopped", "info")
		else
			Log("error", cmd.Name .. ": " .. tostring(err))
		end
	end
end

-- Keybinds -----------------------------------------------------------------------------
local KeyMap, KeyHooks = {}, {}
local KeyShort = {
	LeftShift = "LShift", RightShift = "RShift", LeftControl = "LCtrl", RightControl = "RCtrl",
	LeftAlt = "LAlt", RightAlt = "RAlt", Return = "Enter", Backquote = "`", Minus = "-", Equals = "=",
	LeftBracket = "[", RightBracket = "]", Semicolon = ";", Slash = "/", Period = ".",
	Zero = "0", One = "1", Two = "2", Three = "3", Four = "4", Five = "5", Six = "6", Seven = "7", Eight = "8", Nine = "9",
}
local function KeyLabel(n)
	return KeyShort[n] or n
end

local function FireKeyChange(cmd)
	for fn in pairs(cmd.KeyListeners) do
		fn(cmd.Key)
	end
end

-- Binds `name` (a KeyCode name) to cmd, or clears it when name is nil.
-- Returns the command that lost the key, if there was one.
local function SetCommandKey(cmd, name)
	local lost
	if cmd.Key then
		KeyMap[cmd.Key] = nil
	end
	cmd.Key = nil
	if name then
		local other = KeyMap[name]
		if other and other ~= cmd then
			other.Key = nil
			KeyMap[name] = nil
			FireKeyChange(other)
			lost = other
		end
		cmd.Key = name
		KeyMap[name] = cmd
	end
	FireKeyChange(cmd)
	for _, fn in ipairs(KeyHooks) do
		pcall(fn)
	end
	return lost
end

-- What a keybind does: Run commands with a Stop act as a toggle, everything else just executes.
local function Trigger(cmd)
	if cmd.Kind == "Run" and cmd.Stop and cmd.Enabled then
		StopCommand(cmd)
	else
		Execute(cmd)
	end
end

local BindTarget = nil
local BindHint = New("TextLabel", {
	Name = "BindHint", Parent = Gui, AnchorPoint = Vector2.new(.5, 1), Position = UDim2.new(.5, 0, 1, -120),
	Size = UDim2.fromOffset(0, 34), AutomaticSize = Enum.AutomaticSize.X, Font = F.Med, TextSize = TS(14),
	Text = "", Visible = false, BorderSizePixel = 0, ZIndex = 70,
})
Style(BindHint, { BackgroundColor3 = "Surface", TextColor3 = "Text" })
Corner(BindHint, 8)
Stroke(BindHint, "Accent", 2)
Pad(BindHint, 14, 0, 14, 0)

local function CancelBind()
	BindTarget = nil
	BindHint.Visible = false
end

local function StartBinding(cmd)
	BindTarget = cmd
	BindHint.Text = "Press a key for " .. cmd.Name .. "    ·    Esc cancel    ·    Backspace clear"
	BindHint.Visible = true
end

local function FinishBind(kc)
	local cmd = BindTarget
	if not cmd then return end
	if Config.Keybind and kc.Name == Config.Keybind then
		Notify("Keybind", "That key shows / hides Mantle", "warn")
		return
	end
	CancelBind()
	if kc == Enum.KeyCode.Escape or kc == Enum.KeyCode.Unknown then return end
	if kc == Enum.KeyCode.Backspace or kc == Enum.KeyCode.Delete then
		SetCommandKey(cmd, nil)
		Notify(cmd.Name, "Keybind cleared", "info")
		return
	end
	local lost = SetCommandKey(cmd, kc.Name)
	Log("info", cmd.Name .. " bound to " .. kc.Name)
	Notify(cmd.Name, "Bound to " .. KeyLabel(kc.Name) .. (lost and ("  (removed from " .. lost.Name .. ")") or ""), "success")
end

-- Generic "keep a humanoid property pinned" loop (Walkspeed / Jumppower) -------------
local function MakeStatLoop(prop, valueKey, extra)
	local conn
	local function stop()
		if conn then
			conn:Disconnect()
			conn = nil
		end
	end
	local function start(self, v)
		stop()
		local hum = Hum()
		assert(hum, "Humanoid not found")
		if extra then
			extra(hum)
		end
		conn = RunService.Heartbeat:Connect(function()
			if not hum.Parent or hum.Health <= 0 then -- the character reset: stop
				stop()
				SetState(self, false)
				Log("info", self.Name .. " loop ended (character reset)")
				return
			end
			hum[prop] = v[valueKey]
		end)
		SetState(self, true)
	end
	return start, stop
end

-- ---------------------------------------------------------------- FLY
do
	local conn, bv, bg
	local function stop()
		if conn then conn:Disconnect() conn = nil end
		if bv then bv:Destroy() bv = nil end
		if bg then bg:Destroy() bg = nil end
		local h = Hum()
		if h then h.PlatformStand = false end
	end
	local function flat(v)
		local f = Vector3.new(v.X, 0, v.Z)
		if f.Magnitude < 1e-3 then return nil end
		return f.Unit
	end
	AddCommand({
		Name = "Fly", Desc = "Free-fly. WASD / thumbstick to move, Space up, Ctrl down.", Kind = "Toggle", StopOnReset = true,
		Inputs = { { Key = "Speed", Label = "Fly speed", Type = "number", Default = 60, Min = 1, Max = 500 } },
		Func = function(self, v, state)
			stop()
			if not state then return end
			local root, hum = Root(), Hum()
			assert(root and hum, "Character not found")
			bv = Instance.new("BodyVelocity")
			bv.MaxForce = Vector3.one * 1e9
			bv.Velocity = Vector3.zero
			bv.Parent = root
			bg = Instance.new("BodyGyro")
			bg.MaxTorque = Vector3.one * 1e9
			bg.P = 9e4
			bg.CFrame = root.CFrame
			bg.Parent = root
			hum.PlatformStand = true
			local cur = Vector3.zero
			conn = RunService.RenderStepped:Connect(function(dt)
				local r, h, cam = Root(), Hum(), workspace.CurrentCamera
				if not (r and h and cam and bv and bv.Parent) then
					-- character reset / removed: release PlatformStand and mark Fly off
					stop()
					SetState(self, false)
					Log("info", "Fly ended (character reset)")
					return
				end
				local cf = cam.CFrame
				local move = h.MoveDirection
				local vel = Vector3.zero
				if move.Magnitude > 0 then
					local fl = flat(cf.LookVector) or flat(cf.UpVector)
					local fr = flat(cf.RightVector)
					if fl then vel += cf.LookVector * move:Dot(fl) end
					if fr then vel += cf.RightVector * move:Dot(fr) end
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.Space) or UserInputService:IsKeyDown(Enum.KeyCode.E) or h.Jump then
					vel += Vector3.yAxis
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.Q) then
					vel -= Vector3.yAxis
				end
				if vel.Magnitude > 1 then vel = vel.Unit end
				cur = cur:Lerp(vel * v.Speed, 1 - math.exp(-dt * 9))
				bv.Velocity = cur
				bg.CFrame = bg.CFrame:Lerp(cf, 1 - math.exp(-dt * 22))
			end)
		end,
		Source = [==[
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
end

-- ---------------------------------------------------------------- WALKSPEED
do
	local start, stop = MakeStatLoop("WalkSpeed", "Speed")
	AddCommand({
		Name = "Walkspeed", Desc = "Loops your WalkSpeed every frame. Ends on reset.", Kind = "Run", Aliases = { "ws", "speed" },
		Inputs = { { Key = "Speed", Label = "Walkspeed", Type = "number", Default = 50, Min = 0, Max = 1000 } },
		Silent = true,
		Func = function(self, v)
			start(self, v)
			Notify("Walkspeed", "Looping at " .. tostring(v.Speed), "success")
		end,
		Stop = function(self)
			stop()
			local h = Hum()
			if h then h.WalkSpeed = 16 end
		end,
		Source = [==[
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
end

-- ---------------------------------------------------------------- JUMPPOWER
do
	local start, stop = MakeStatLoop("JumpPower", "Power", function(h)
		h.UseJumpPower = true
	end)
	AddCommand({
		Name = "Jumppower", Desc = "Loops your JumpPower every frame. Ends on reset.", Kind = "Run", Aliases = { "jp", "jump" },
		Inputs = { { Key = "Power", Label = "Jump power", Type = "number", Default = 100, Min = 0, Max = 1000 } },
		Silent = true,
		Func = function(self, v)
			start(self, v)
			Notify("Jumppower", "Looping at " .. tostring(v.Power), "success")
		end,
		Stop = function(self)
			stop()
			local h = Hum()
			if h then h.JumpPower = 50 end
		end,
		Source = [==[
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
end

-- ---------------------------------------------------------------- INFINITE JUMP
do
	local conn
	AddCommand({
		Name = "Infinite Jump", Desc = "Jump again while in mid-air.", Kind = "Toggle", Aliases = { "infjump", "ij" },
		Func = function(self, v, state)
			if conn then conn:Disconnect() conn = nil end
			if state then
				conn = UserInputService.JumpRequest:Connect(function()
					local h = Hum()
					if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
				end)
			end
		end,
		Source = [==[
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
end

-- ---------------------------------------------------------------- TELEPORT TOOL
AddCommand({
	Name = "Teleport Tool", Desc = "Gives you a tool that teleports you where you click.", Kind = "Run", Aliases = { "tptool" },
	Silent = true,
	Func = function(self)
		self.Cleanup(self)
		local tool = Instance.new("Tool")
		tool.Name = "Teleport Tool"
		tool.RequiresHandle = false
		tool.CanBeDropped = false
		tool.ToolTip = "Click to teleport"
		tool.Activated:Connect(function()
			local r = Root()
			if r then
				local pos = LP:GetMouse().Hit.Position + Vector3.new(0, 3, 0)
				r.CFrame = CFrame.new(pos) * (r.CFrame - r.CFrame.Position)
			end
		end)
		tool.Parent = LP:WaitForChild("Backpack")
		Notify("Teleport Tool", "Added to your backpack", "success")
	end,
	Cleanup = function()
		for _, c in ipairs({ LP:FindFirstChild("Backpack"), LP.Character }) do
			local t = c and c:FindFirstChild("Teleport Tool")
			if t then t:Destroy() end
		end
	end,
	Source = [==[
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
})

-- ---------------------------------------------------------------- TELEPORT TO
AddCommand({
	Name = "Teleport To", Desc = "Teleport to a player you pick from the list.", Kind = "Run", Aliases = { "tpto", "goto", "tp" },
	Inputs = { { Key = "Target", Label = "Player", Type = "player" } },
	Func = function(self, v)
		local target = FindPlayer(v.Target)
		assert(target, "Select a player first")
		local tr = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
		assert(tr, target.Name .. " has no character")
		local r = Root()
		assert(r, "Character not found")
		r.CFrame = tr.CFrame * CFrame.new(0, 0, 3)
	end,
	Source = [==[
-- Teleport To
local target = Players:FindFirstChild("PlayerName")
local targetRoot = target.Character.HumanoidRootPart
local myRoot = player.Character.HumanoidRootPart

-- land just behind them
myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
]==],
})

-- ---------------------------------------------------------------- SPECTATE
do
	local conn
	local function release()
		if conn then
			conn:Disconnect()
			conn = nil
		end
		local h, cam = Hum(), workspace.CurrentCamera
		if h and cam then
			cam.CameraSubject = h
		end
	end
	AddCommand({
		Name = "Spectate", Desc = "Watch another player through your camera. Stop returns you.", Kind = "Run", Aliases = { "spec", "view" },
		Inputs = { { Key = "Target", Label = "Player", Type = "player" } },
		Silent = true,
		Func = function(self, v)
			local target = FindPlayer(v.Target)
			assert(target, "Select a player first")
			assert(target.Character and target.Character:FindFirstChildOfClass("Humanoid"), target.Name .. " has no character")
			if conn then
				conn:Disconnect()
				conn = nil
			end
			local name = target.Name
			conn = RunService.RenderStepped:Connect(function()
				local cam = workspace.CurrentCamera
				local p = Players:FindFirstChild(name)
				if not p then
					release()
					SetState(self, false)
					Log("info", "Spectate ended (" .. name .. " left)")
					Notify("Spectate", name .. " left the game", "info")
					return
				end
				local th = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
				if th and cam and cam.CameraSubject ~= th then
					cam.CameraSubject = th
				end
			end)
			SetState(self, true)
			Notify("Spectate", "Watching " .. target.DisplayName, "success")
		end,
		Stop = function()
			release()
		end,
		Source = [==[
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
end

-- ---------------------------------------------------------------- FREECAM
do
	local bindName = "MantleFreecam"
	local saved, conns, rmb = nil, {}, false
	local function cleanup()
		pcall(function() RunService:UnbindFromRenderStep(bindName) end)
		pcall(function() ContextActionService:UnbindAction(bindName) end)
		for _, c in ipairs(conns) do
			c:Disconnect()
		end
		table.clear(conns)
		rmb = false
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		if saved then
			local cam = workspace.CurrentCamera
			if saved.Root and saved.Root.Parent then
				saved.Root.Anchored = saved.Anchored
			end
			if cam then
				-- never fall back to a subject that was destroyed by a reset
				local subj = Hum()
				if not subj and saved.Subject and saved.Subject.Parent then
					subj = saved.Subject
				end
				if subj then cam.CameraSubject = subj end
				cam.CameraType = (saved.Type == Enum.CameraType.Scriptable) and Enum.CameraType.Custom or saved.Type
			end
			saved = nil
		end
	end
	AddCommand({
		Name = "Freecam", Desc = "Detach the camera and fly it around. Hold right mouse to look, WASD + Q/E, Shift = fast.", Kind = "Toggle", StopOnReset = true,
		Aliases = { "fc" },
		Inputs = {
			{ Key = "Speed", Label = "Camera speed", Type = "number", Default = 40, Min = 1, Max = 500 },
			{ Key = "Sensitivity", Label = "Look sensitivity", Type = "number", Default = 1, Min = .1, Max = 10 },
		},
		Func = function(self, v, state)
			cleanup()
			if not state then return end
			local cam = workspace.CurrentCamera
			assert(cam, "Camera not found")
			local root = Root()
			saved = { Type = cam.CameraType, Subject = cam.CameraSubject, Root = root, Anchored = root and root.Anchored or false }
			if root then
				root.Anchored = true -- keep your character still while the camera moves
			end
			cam.CameraType = Enum.CameraType.Scriptable

			local pitch, yaw = cam.CFrame:ToEulerAnglesYXZ()
			local tPitch, tYaw = pitch, yaw
			local pos = cam.CFrame.Position
			local vel = Vector3.zero
			local K = Enum.KeyCode

			-- stop WASD etc. from also moving your character
			ContextActionService:BindActionAtPriority(bindName, function()
				return Enum.ContextActionResult.Sink
			end, false, Enum.ContextActionPriority.High.Value,
				K.W, K.A, K.S, K.D, K.Q, K.E, K.Space, K.Up, K.Down, K.Left, K.Right)

			table.insert(conns, UserInputService.InputBegan:Connect(function(i, gp)
				if not gp and i.UserInputType == Enum.UserInputType.MouseButton2 then
					rmb = true
				end
			end))
			table.insert(conns, UserInputService.InputEnded:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton2 then
					rmb = false
				end
			end))
			table.insert(conns, UserInputService.TouchMoved:Connect(function(i, gp)
				if gp then return end
				tYaw -= i.Delta.X * .006 * v.Sensitivity
				tPitch = math.clamp(tPitch - i.Delta.Y * .006 * v.Sensitivity, -1.55, 1.55)
			end))

			local function down(k)
				return UserInputService:IsKeyDown(k)
			end
			RunService:BindToRenderStep(bindName, Enum.RenderPriority.Camera.Value + 1, function(dt)
				local c = workspace.CurrentCamera
				if not c then return end
				if saved and saved.Root and not saved.Root.Parent then
					-- character was removed (reset): restore camera, mouse and key sink
					cleanup()
					SetState(self, false)
					Log("info", "Freecam ended (character reset)")
					return
				end
				if c.CameraType ~= Enum.CameraType.Scriptable then
					c.CameraType = Enum.CameraType.Scriptable
				end
				if rmb then
					UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
					local d = UserInputService:GetMouseDelta()
					tYaw -= d.X * .003 * v.Sensitivity
					tPitch = math.clamp(tPitch - d.Y * .003 * v.Sensitivity, -1.55, 1.55)
				elseif UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
					UserInputService.MouseBehavior = Enum.MouseBehavior.Default
				end
				local a = 1 - math.exp(-dt * 30)
				pitch += (tPitch - pitch) * a
				yaw += (tYaw - yaw) * a
				local cf = CFrame.new(pos) * CFrame.fromEulerAnglesYXZ(pitch, yaw, 0)

				local move = Vector3.zero
				if down(K.W) or down(K.Up) then move += cf.LookVector end
				if down(K.S) or down(K.Down) then move -= cf.LookVector end
				if down(K.D) or down(K.Right) then move += cf.RightVector end
				if down(K.A) or down(K.Left) then move -= cf.RightVector end
				if down(K.E) or down(K.Space) then move += Vector3.yAxis end
				if down(K.Q) or down(K.LeftControl) then move -= Vector3.yAxis end
				local h = Hum()
				if h then -- thumbstick / touch movement
					local md = h.MoveDirection
					if md.Magnitude > 0 then
						local rel = cf:VectorToObjectSpace(md)
						local flat = Vector3.new(rel.X, 0, rel.Z)
						if flat.Magnitude > 1e-3 then
							move += cf:VectorToWorldSpace(flat.Unit * md.Magnitude)
						end
					end
					if h.Jump then move += Vector3.yAxis end
				end
				if move.Magnitude > 1 then move = move.Unit end
				local speed = v.Speed * (down(K.LeftShift) and 3 or 1)
				vel = vel:Lerp(move * speed, 1 - math.exp(-dt * 10))
				pos += vel * dt
				c.CFrame = CFrame.new(pos) * CFrame.fromEulerAnglesYXZ(pitch, yaw, 0)
			end)
		end,
		Source = [==[
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
end

-- ---------------------------------------------------------------- FOV
do
	local conn
	AddCommand({
		Name = "FOV", Desc = "Sets your camera field of view. Stop restores 70.", Kind = "Run",
		Inputs = { { Key = "Value", Label = "Field of view", Type = "number", Default = 100, Min = 1, Max = 120 } },
		Silent = true,
		Func = function(self, v)
			if conn then conn:Disconnect() end
			conn = RunService.RenderStepped:Connect(function()
				local cam = workspace.CurrentCamera
				if cam then cam.FieldOfView = v.Value end
			end)
			SetState(self, true)
			Notify("FOV", "Set to " .. tostring(v.Value), "success")
		end,
		Stop = function()
			if conn then conn:Disconnect() conn = nil end
			workspace.CurrentCamera.FieldOfView = 70
		end,
		Source = [==[
-- FOV (loops so the game can't change it back)
local fov = 100
local conn = RunService.RenderStepped:Connect(function()
    workspace.CurrentCamera.FieldOfView = fov
end)

-- To stop: conn:Disconnect() and set FieldOfView back to 70
]==],
	})
end

-- ---------------------------------------------------------------- GRAVITY
AddCommand({
	Name = "Gravity", Desc = "Changes workspace gravity. Stop restores 196.2.", Kind = "Run", Aliases = { "grav" },
	Inputs = { { Key = "Value", Label = "Gravity", Type = "number", Default = 50, Min = 0, Max = 500 } },
	Silent = true,
	Func = function(self, v)
		workspace.Gravity = v.Value
		SetState(self, true)
		Notify("Gravity", "Set to " .. tostring(v.Value), "success")
	end,
	Stop = function()
		workspace.Gravity = 196.2
	end,
	Source = [==[
-- Gravity
workspace.Gravity = 50

-- To restore: workspace.Gravity = 196.2
]==],
})

-- ---------------------------------------------------------------- FULLBRIGHT
do
	local conn, orig
	AddCommand({
		Name = "Fullbright", Desc = "Removes darkness and fog. Restores on disable.", Kind = "Toggle", Aliases = { "fb" },
		Func = function(self, v, state)
			if conn then conn:Disconnect() conn = nil end
			if state then
				orig = orig or {
					Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime, FogEnd = Lighting.FogEnd,
					GlobalShadows = Lighting.GlobalShadows, Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient,
				}
				conn = RunService.RenderStepped:Connect(function()
					Lighting.Brightness = 2
					Lighting.ClockTime = 14
					Lighting.FogEnd = 1e6
					Lighting.GlobalShadows = false
					Lighting.Ambient = Color3.new(1, 1, 1)
					Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
				end)
			elseif orig then
				for k, val in pairs(orig) do
					Lighting[k] = val
				end
				orig = nil
			end
		end,
		Source = [==[
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
end

-- ---------------------------------------------------------------- ESP
do
	local folder, loopId, traceConn = nil, 0, nil
	AddCommand({
		Name = "ESP", Desc = "Highlights every player through walls with name + distance. Optional tracers.", Kind = "Toggle",
		Inputs = {
			{ Key = "Color", Label = "ESP color", Type = "color", Default = C(255, 70, 70) },
			{ Key = "UseTeam", Label = "Use team colors", Type = "bool", Default = false },
			{ Key = "Tracers", Label = "Tracers", Type = "bool", Default = false },
		},
		Func = function(self, v, state)
			loopId += 1
			local id = loopId
			if traceConn then traceConn:Disconnect() traceConn = nil end
			if folder then folder:Destroy() folder = nil end
			if not state then return end
			folder = Instance.new("Folder")
			folder.Name = "MantleESP"
			folder.Parent = Gui

			-- Tracers: a line from the bottom centre of the screen to every player (can be toggled live)
			local lines = {}
			traceConn = RunService.RenderStepped:Connect(function()
				local cam = workspace.CurrentCamera
				if not (cam and folder) then return end
				local vp = cam.ViewportSize
				local origin = Vector2.new(vp.X / 2, vp.Y)
				for _, p in ipairs(Players:GetPlayers()) do
					if p ~= LP then
						local hrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
						local line = lines[p]
						local shown = false
						if v.Tracers and hrp then
							local sp, onScreen = cam:WorldToScreenPoint(hrp.Position)
							if onScreen then
								shown = true
								if not line then
									line = Instance.new("Frame")
									line.AnchorPoint = Vector2.new(.5, .5)
									line.BorderSizePixel = 0
									line.ZIndex = 5
									line.Parent = folder
									lines[p] = line
								end
								local target = Vector2.new(sp.X, sp.Y)
								local d = target - origin
								line.Size = UDim2.fromOffset(d.Magnitude, 1.5)
								line.Position = UDim2.fromOffset((origin.X + target.X) / 2, (origin.Y + target.Y) / 2)
								line.Rotation = math.deg(math.atan2(d.Y, d.X))
								line.BackgroundColor3 = (v.UseTeam and p.Team) and p.TeamColor.Color or v.Color
							end
						end
						if line then line.Visible = shown end
					end
				end
				for p, l in pairs(lines) do
					if not p.Parent then
						l:Destroy()
						lines[p] = nil
					end
				end
			end)

			local objs = {}
			local function drop(p)
				local o = objs[p]
				if o then
					o.hl:Destroy()
					o.bb:Destroy()
					objs[p] = nil
				end
			end
			task.spawn(function()
				while loopId == id do
					local myRoot = Root()
					for _, p in ipairs(Players:GetPlayers()) do
						if p ~= LP then
							local ch = p.Character
							local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
							if hrp then
								local o = objs[p]
								if not o or o.hl.Adornee ~= ch then
									drop(p)
									local hl = Instance.new("Highlight")
									hl.FillTransparency = .65
									hl.OutlineTransparency = 0
									hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
									hl.Adornee = ch
									hl.Parent = folder
									local bb = Instance.new("BillboardGui")
									bb.Size = UDim2.fromOffset(160, 20)
									bb.StudsOffset = Vector3.new(0, 3.2, 0)
									bb.AlwaysOnTop = true
									bb.Adornee = ch:FindFirstChild("Head") or hrp
									bb.Parent = folder
									local tl = Instance.new("TextLabel")
									tl.BackgroundTransparency = 1
									tl.Size = UDim2.fromScale(1, 1)
									tl.Font = F.Bold
									tl.TextSize = 15
									tl.TextStrokeTransparency = .4
									tl.Parent = bb
									o = { hl = hl, bb = bb, tl = tl }
									objs[p] = o
								end
								local col = (v.UseTeam and p.Team) and p.TeamColor.Color or v.Color
								o.hl.FillColor = col
								o.hl.OutlineColor = col
								o.tl.TextColor3 = col
								local dist = myRoot and math.floor((myRoot.Position - hrp.Position).Magnitude) or 0
								o.tl.Text = p.DisplayName .. "  [" .. dist .. "]"
							else
								drop(p)
							end
						end
					end
					for p in pairs(objs) do
						if not p.Parent then drop(p) end
					end
					task.wait(.1)
				end
			end)
		end,
		Source = [==[
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
end

-- ---------------------------------------------------------------- NO MATERIALS
AddCommand({
	Name = "No Materials", Desc = "Strips the material from every part in the workspace.", Kind = "Run", Aliases = { "nomat", "nomaterials" },
	Silent = true,
	Func = function(self)
		local n = 0
		for i, d in ipairs(workspace:GetDescendants()) do
			if d:IsA("BasePart") and not d:IsA("Terrain") then
				d.Material = Enum.Material.Plastic
				d.MaterialVariant = ""
				n += 1
			end
			if i % 600 == 0 then task.wait() end
		end
		Notify("No Materials", n .. " parts set to Plastic", "success")
	end,
	Source = [==[
-- No Materials
for _, part in ipairs(workspace:GetDescendants()) do
    if part:IsA("BasePart") and not part:IsA("Terrain") then
        part.Material = Enum.Material.Plastic
        part.MaterialVariant = ""
    end
end
]==],
})

-- ---------------------------------------------------------------- NOCLIP
do
	local conn, touched = nil, {}
	AddCommand({
		Name = "Noclip", Desc = "Walk through walls and objects.", Kind = "Toggle",
		Func = function(self, v, state)
			if conn then conn:Disconnect() conn = nil end
			if state then
				conn = RunService.Stepped:Connect(function()
					local c = LP.Character
					if not c then return end
					for _, p in ipairs(c:GetDescendants()) do
						if p:IsA("BasePart") and p.CanCollide then
							touched[p] = true
							p.CanCollide = false
						end
					end
				end)
			else
				for p in pairs(touched) do
					if p.Parent then p.CanCollide = true end
				end
				table.clear(touched)
			end
		end,
		Source = [==[
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
end

-- ---------------------------------------------------------------- FPS CAP
AddCommand({
	Name = "FPS Cap", Desc = "Sets the client frame rate cap (needs executor support). Stop restores 60.", Kind = "Run", Aliases = { "setfps" },
	Inputs = { { Key = "Value", Label = "FPS cap", Type = "number", Default = 240, Min = 5, Max = 1000 } },
	Silent = true,
	Func = function(self, v)
		assert(typeof(Env.setfpscap) == "function", "This environment doesn't support setfpscap")
		Env.setfpscap(v.Value)
		SetState(self, true)
		Notify("FPS Cap", "Set to " .. tostring(v.Value), "success")
	end,
	Stop = function()
		if typeof(Env.setfpscap) == "function" then Env.setfpscap(60) end
	end,
	Source = [==[
-- FPS Cap (needs setfpscap from your environment)
setfpscap(240)

-- To restore: setfpscap(60)
]==],
})

-- ---------------------------------------------------------------- SERVER HOP
AddCommand({
	Name = "Server Hop", Desc = "Join a different public server of this game.", Kind = "Run", Aliases = { "hop", "serverhop" },
	Silent = true,
	Func = function(self)
		if not Env.request then
			Log("warn", "No HTTP request function available; using a standard teleport instead")
			Notify("Server Hop", "No HTTP access here, doing a standard teleport", "warn")
			TeleportService:Teleport(game.PlaceId, LP)
			return
		end
		local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true"):format(game.PlaceId)
		local res = Env.request({ Url = url, Method = "GET" })
		assert(res and res.Body, "Server list request failed")
		local data = HttpService:JSONDecode(res.Body)
		local pool = {}
		for _, s in ipairs(data.data or {}) do
			if s.id ~= game.JobId and s.playing < s.maxPlayers then
				table.insert(pool, s)
			end
		end
		assert(#pool > 0, "No other servers found")
		local pick = pool[math.random(#pool)]
		Notify("Server Hop", "Joining a server with " .. pick.playing .. " players...", "info")
		TeleportService:TeleportToPlaceInstance(game.PlaceId, pick.id, LP)
	end,
	Source = [==[
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
})

-- ---------------------------------------------------------------- REJOIN
AddCommand({
	Name = "Rejoin", Desc = "Rejoin this exact server.", Kind = "Run", Aliases = { "rj" }, Silent = true,
	Func = function(self)
		Notify("Rejoin", "Rejoining...", "info")
		if #Players:GetPlayers() <= 1 then
			TeleportService:Teleport(game.PlaceId, LP)
		else
			TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP)
		end
	end,
	Source = [==[
-- Rejoin
if #Players:GetPlayers() <= 1 then
    -- you're alone: a fresh server is the only option
    TeleportService:Teleport(game.PlaceId, player)
else
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end
]==],
})

-- ---------------------------------------------------------------- RESET CHARACTER
AddCommand({
	Name = "Reset Character", Desc = "Respawn your character.", Kind = "Run", Aliases = { "reset", "re" }, Silent = true,
	Func = function(self)
		local h = Hum()
		assert(h, "Humanoid not found")
		h.Health = 0
	end,
	Source = [==[
-- Reset Character
local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
humanoid.Health = 0
]==],
})

-- ---------------------------------------------------------------- ANTI-AFK
do
	local conn
	AddCommand({
		Name = "Anti-AFK", Desc = "Prevents the idle kick.", Kind = "Toggle", Aliases = { "antiafk", "afk" },
		Func = function(self, v, state)
			if conn then conn:Disconnect() conn = nil end
			if state then
				conn = LP.Idled:Connect(function()
					VirtualUser:CaptureController()
					VirtualUser:ClickButton2(Vector2.new())
				end)
			end
		end,
		Source = [==[
-- Anti-AFK (toggle)
local VirtualUser = game:GetService("VirtualUser")

local conn = player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- To disable: conn:Disconnect()
]==],
	})
end

-- Command line (used by the Command Bar widget) ------------------------------------------
local IsUIOpen = function() return false end -- replaced once the window exists

-- ---------------------------------------------------------------- MAX ZOOM
do
	local conn, orig
	AddCommand({
		Name = "Max Zoom", Desc = "Lets the camera zoom out much further. Stop restores it.", Kind = "Run", Aliases = { "zoom", "maxzoomdistance" },
		Inputs = { { Key = "Distance", Label = "Max distance", Type = "number", Default = 100000, Min = 10, Max = 1000000 } },
		Silent = true,
		Func = function(self, v)
			if conn then conn:Disconnect() end
			orig = orig or LP.CameraMaxZoomDistance
			conn = RunService.Heartbeat:Connect(function()
				LP.CameraMaxZoomDistance = v.Distance
			end)
			SetState(self, true)
			Notify("Max Zoom", "Max distance set to " .. tostring(v.Distance), "success")
		end,
		Stop = function()
			if conn then conn:Disconnect() conn = nil end
			LP.CameraMaxZoomDistance = orig or 128
			orig = nil
		end,
		Source = [==[
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
end

-- ---------------------------------------------------------------- THIRD / FIRST PERSON
do
	local conn, saved
	local thirdDef, firstDef

	local function startMode(self, other, loop)
		if conn then conn:Disconnect() conn = nil end
		if other.Enabled then SetState(other, false) end -- the two modes replace each other
		saved = saved or { Min = LP.CameraMinZoomDistance, Max = LP.CameraMaxZoomDistance }
		loop()
		conn = RunService.Heartbeat:Connect(loop)
		SetState(self, true)
	end
	local function finish()
		if conn then conn:Disconnect() conn = nil end
		LP.CameraMode = Enum.CameraMode.Classic
		if saved then
			LP.CameraMaxZoomDistance = saved.Max
			LP.CameraMinZoomDistance = saved.Min
			saved = nil
		end
	end

	thirdDef = {
		Name = "Third Person", Desc = "Forces third person: you can't zoom into first person. Stop restores it.", Kind = "Run", Aliases = { "3p", "thirdperson" },
		Inputs = { { Key = "Distance", Label = "Min distance", Type = "number", Default = 10, Min = 1, Max = 400 } },
		Silent = true,
		Func = function(self, v)
			startMode(self, firstDef, function()
				LP.CameraMode = Enum.CameraMode.Classic
				if LP.CameraMaxZoomDistance < v.Distance then
					LP.CameraMaxZoomDistance = math.max(v.Distance, 128)
				end
				LP.CameraMinZoomDistance = v.Distance
			end)
			Notify("Third Person", "Forced", "success")
		end,
		Stop = function() finish() end,
		Source = [==[
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
	firstDef = {
		Name = "First Person", Desc = "Locks your camera to first person. Stop restores it.", Kind = "Run", Aliases = { "1p", "firstperson" },
		Silent = true,
		Func = function(self)
			startMode(self, thirdDef, function()
				LP.CameraMode = Enum.CameraMode.LockFirstPerson
			end)
			Notify("First Person", "Locked", "success")
		end,
		Stop = function() finish() end,
		Source = [==[
-- First Person (loops so the game can't change it back)
local conn = RunService.Heartbeat:Connect(function()
    player.CameraMode = Enum.CameraMode.LockFirstPerson
end)

-- To stop: conn:Disconnect() and
-- player.CameraMode = Enum.CameraMode.Classic
]==],
	}
	AddCommand(thirdDef)
	AddCommand(firstDef)
end

-- ---------------------------------------------------------------- FORCE SHIFTLOCK
do
	local conn
	local function release()
		if conn then conn:Disconnect() conn = nil end
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		local h = Hum()
		if h then
			h.AutoRotate = true
			h.CameraOffset = Vector3.zero
		end
	end
	AddCommand({
		Name = "Force Shiftlock", Desc = "Forces Shift Lock: mouse locked, character faces the camera. Hold Left Alt to free the mouse.", Kind = "Toggle",
		Aliases = { "shiftlock", "sl", "forceshiftlock" },
		Inputs = { { Key = "Offset", Label = "Camera offset", Type = "number", Default = 1.75, Min = -6, Max = 6 } },
		Func = function(self, v, state)
			release()
			if not state then return end
			conn = RunService.RenderStepped:Connect(function()
				local cam, h, r = workspace.CurrentCamera, Hum(), Root()
				if not (cam and h and r) then return end
				local paused = IsUIOpen()
					or UserInputService:GetFocusedTextBox() ~= nil
					or UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt)
					or cam.CameraType == Enum.CameraType.Scriptable
				if paused then
					if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
						UserInputService.MouseBehavior = Enum.MouseBehavior.Default
					end
					h.AutoRotate = true
					h.CameraOffset = Vector3.zero
					return
				end
				UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
				h.AutoRotate = false
				h.CameraOffset = Vector3.new(v.Offset, 0, 0)
				if not (h.Sit or h.PlatformStand) then
					local look = cam.CFrame.LookVector
					local flat = Vector3.new(look.X, 0, look.Z)
					if flat.Magnitude > 1e-3 then
						r.CFrame = CFrame.lookAt(r.Position, r.Position + flat)
					end
				end
			end)
		end,
		Source = [==[
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
end

-- ---------------------------------------------------------------- SIT
AddCommand({
	Name = "Sit", Desc = "Makes your character sit down. Jump to stand up.", Kind = "Run", Silent = true,
	Func = function(self)
		local h = Hum()
		assert(h, "Humanoid not found")
		h.Sit = true
	end,
	Source = [==[
-- Sit
local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
humanoid.Sit = true
]==],
})

-- ---------------------------------------------------------------- XRAY
do
	local conns, touched, loopId = {}, {}, 0
	local function isCharacterPart(part)
		local m = part:FindFirstAncestorOfClass("Model")
		while m do
			if m:FindFirstChildOfClass("Humanoid") then return true end
			m = m:FindFirstAncestorOfClass("Model")
		end
		return false
	end
	local function clear()
		loopId += 1
		for _, c in ipairs(conns) do c:Disconnect() end
		table.clear(conns)
		for p in pairs(touched) do
			if p.Parent then p.LocalTransparencyModifier = 0 end
		end
		table.clear(touched)
	end
	AddCommand({
		Name = "XRAY", Desc = "Makes the map see-through (client only). Players stay solid.", Kind = "Toggle", Aliases = { "xray" },
		Inputs = { { Key = "Amount", Label = "Transparency", Type = "number", Default = .6, Min = .05, Max = .95 } },
		Func = function(self, v, state)
			clear()
			if not state then return end
			local id = loopId
			local function apply(d)
				if d:IsA("BasePart") and not d:IsA("Terrain") and not isCharacterPart(d) then
					touched[d] = true
					d.LocalTransparencyModifier = v.Amount
				end
			end
			table.insert(conns, workspace.DescendantAdded:Connect(apply))
			task.spawn(function()
				for i, d in ipairs(workspace:GetDescendants()) do
					if loopId ~= id then return end
					apply(d)
					if i % 500 == 0 then task.wait() end
				end
				local applied = v.Amount
				while loopId == id do -- picks up a changed Transparency value while enabled
					task.wait(.5)
					if v.Amount ~= applied then
						applied = v.Amount
						for p in pairs(touched) do
							if p.Parent then p.LocalTransparencyModifier = applied end
						end
					end
				end
			end)
		end,
		Source = [==[
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
end

-- ---------------------------------------------------------------- NO SHADOWS
do
	local conns, changed, saved, loopId = {}, {}, nil, 0
	local function clear()
		loopId += 1
		for _, c in ipairs(conns) do c:Disconnect() end
		table.clear(conns)
		for p, was in pairs(changed) do
			if p.Parent then p.CastShadow = was end
		end
		table.clear(changed)
		if saved then
			Lighting.GlobalShadows = saved.Shadows
			saved = nil
		end
	end
	AddCommand({
		Name = "No Shadows", Desc = "Turns off global shadows and stops every part casting one. Restores on disable.", Kind = "Toggle", Aliases = { "noshadows", "shadows" },
		Func = function(self, v, state)
			clear()
			if not state then return end
			local id = loopId
			saved = { Shadows = Lighting.GlobalShadows }
			table.insert(conns, RunService.Heartbeat:Connect(function()
				Lighting.GlobalShadows = false
			end))
			local function apply(d)
				if d:IsA("BasePart") and changed[d] == nil then
					changed[d] = d.CastShadow
					d.CastShadow = false
				end
			end
			table.insert(conns, workspace.DescendantAdded:Connect(apply))
			task.spawn(function()
				for i, d in ipairs(workspace:GetDescendants()) do
					if loopId ~= id then return end
					apply(d)
					if i % 500 == 0 then task.wait() end
				end
			end)
		end,
		Source = [==[
-- No Shadows (toggle)
local original = Lighting.GlobalShadows
local changed = {}

local conn = RunService.Heartbeat:Connect(function()
    Lighting.GlobalShadows = false
end)

local function apply(d)
    if d:IsA("BasePart") and changed[d] == nil then
        changed[d] = d.CastShadow
        d.CastShadow = false
    end
end
for _, d in ipairs(workspace:GetDescendants()) do apply(d) end
local added = workspace.DescendantAdded:Connect(apply)

-- To disable: disconnect both, set Lighting.GlobalShadows = original
-- and copy `changed` back onto each part's CastShadow
]==],
	})
end

-- ---------------------------------------------------------------- HITBOX SHOWER
do
	local folder, loopId = nil, 0
	AddCommand({
		Name = "Hitbox Shower", Desc = "Draws every player's hitbox parts as see-through boxes.", Kind = "Toggle", Aliases = { "hitboxes", "hitbox", "showhitboxes" },
		Inputs = {
			{ Key = "Color", Label = "Box color", Type = "color", Default = C(80, 170, 255) },
			{ Key = "Transparency", Label = "Transparency", Type = "number", Default = .6, Min = 0, Max = .95 },
			{ Key = "RootOnly", Label = "Root part only", Type = "bool", Default = false },
			{ Key = "Self", Label = "Include myself", Type = "bool", Default = false },
			{ Key = "Walls", Label = "Show through walls", Type = "bool", Default = true },
		},
		Func = function(self, v, state)
			loopId += 1
			local id = loopId
			if folder then folder:Destroy() folder = nil end
			if not state then return end
			folder = Instance.new("Folder")
			folder.Name = "MantleHitboxes"
			folder.Parent = Gui
			local boxes = {}
			task.spawn(function()
				while loopId == id do
					local seen = {}
					for _, p in ipairs(Players:GetPlayers()) do
						local ch = p.Character
						if ch and (p ~= LP or v.Self) then
							local list = v.RootOnly and { ch:FindFirstChild("HumanoidRootPart") } or ch:GetChildren()
							for _, part in ipairs(list) do
								if part:IsA("BasePart") then
									seen[part] = true
									local b = boxes[part]
									if not b then
										b = Instance.new("BoxHandleAdornment")
										b.Adornee = part
										b.ZIndex = 1
										b.Parent = folder
										boxes[part] = b
									end
									b.Size = part.Size + Vector3.one * .05
									b.Color3 = v.Color
									b.Transparency = v.Transparency
									b.AlwaysOnTop = v.Walls
								end
							end
						end
					end
					for part, b in pairs(boxes) do
						if not seen[part] or not part.Parent then
							b:Destroy()
							boxes[part] = nil
						end
					end
					task.wait(.1)
				end
			end)
		end,
		Source = [==[
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
end

-- ---------------------------------------------------------------- SPIN
if FEATURES.NewCommands then
	local conn
	local function stop()
		if conn then conn:Disconnect() conn = nil end
		local h = Hum()
		if h then h.AutoRotate = true end
	end
	AddCommand({
		Name = "Spin", Desc = "Spins your character. Speed is degrees per second (negative reverses).", Kind = "Toggle", Aliases = { "spinbot", "rotate" },
		Inputs = { { Key = "Speed", Label = "Spin speed", Type = "number", Default = 720, Min = -5000, Max = 5000 } },
		Func = function(self, v, state)
			stop()
			if not state then return end
			assert(Root(), "Character not found")
			conn = RunService.Heartbeat:Connect(function(dt)
				local r, h = Root(), Hum()
				if not (r and h) then return end -- between respawns: keep waiting
				if h.AutoRotate then h.AutoRotate = false end -- stops the humanoid fighting the spin
				r.CFrame = r.CFrame * CFrame.Angles(0, math.rad(v.Speed) * dt, 0)
			end)
		end,
		Source = [==[
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
end

-- ---------------------------------------------------------------- ANTI-FLING
if FEATURES.NewCommands then
	local conns, touched = {}, {}
	local function restore()
		for p in pairs(touched) do
			if p.Parent then p.CanCollide = true end
		end
		table.clear(touched)
	end
	local function clear()
		for _, c in ipairs(conns) do c:Disconnect() end
		table.clear(conns)
		restore()
	end
	AddCommand({
		Name = "Anti-Fling", Desc = "Stops other players pushing or flinging you: ignores their collisions and caps your velocity.", Kind = "Toggle",
		Aliases = { "antifling", "af" },
		Inputs = {
			{ Key = "MaxVelocity", Label = "Max velocity", Type = "number", Default = 400, Min = 50, Max = 5000 },
			{ Key = "Collide", Label = "Ignore player collisions", Type = "bool", Default = true },
		},
		Func = function(self, v, state)
			clear()
			if not state then return end
			-- other players' parts stop colliding with you (this only changes what your client simulates)
			table.insert(conns, RunService.Stepped:Connect(function()
				if not v.Collide then
					if next(touched) then restore() end
					return
				end
				for _, p in ipairs(Players:GetPlayers()) do
					if p ~= LP and p.Character then
						for _, part in ipairs(p.Character:GetDescendants()) do
							if part:IsA("BasePart") and part.CanCollide then
								touched[part] = true
								part.CanCollide = false
							end
						end
					end
				end
			end))
			-- anything that launches you past the limit gets cancelled
			table.insert(conns, RunService.Heartbeat:Connect(function()
				local r = Root()
				if not r then return end
				if r.AssemblyLinearVelocity.Magnitude > v.MaxVelocity then
					r.AssemblyLinearVelocity = Vector3.zero
				end
				if r.AssemblyAngularVelocity.Magnitude > 60 then
					r.AssemblyAngularVelocity = Vector3.zero
				end
			end))
		end,
		Source = [==[
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
end

--==================================================================================--
--  v1.5 COMMANDS: Fling, TPWalk, Custom Crosshair, Bunny Hop, Time Of Day,
--  Head Sit, Anti-Void
--==================================================================================--

-- ---------------------------------------------------------------- FLING
do
	local conn, saved, session = nil, nil, 0
	local function release(restore)
		session += 1
		if conn then conn:Disconnect() conn = nil end
		local cf = saved
		saved = nil
		local r = Root()
		if not r then return end
		r.AssemblyLinearVelocity = Vector3.zero
		r.AssemblyAngularVelocity = Vector3.zero
		if restore and cf then
			r.CFrame = cf
			local id = session
			task.spawn(function() -- hold still for a few frames so the spin can't carry you off
				for _ = 1, 12 do
					RunService.Heartbeat:Wait()
					local rr = Root()
					if session ~= id or not rr then return end
					rr.AssemblyLinearVelocity = Vector3.zero
					rr.AssemblyAngularVelocity = Vector3.zero
					rr.CFrame = cf
				end
			end)
		end
	end
	AddCommand({
		Name = "Fling", Desc = "Spins into a player at high speed to launch them, then puts you back where you were.", Kind = "Run", Silent = true,
		Aliases = { "yeet" },
		Inputs = {
			{ Key = "Target", Label = "Player", Type = "player" },
			{ Key = "Power", Label = "Power", Type = "number", Default = 500000, Min = 1000, Max = 100000000 },
			{ Key = "Duration", Label = "Max seconds", Type = "number", Default = 3, Min = .5, Max = 15 },
		},
		Func = function(self, v)
			local target = FindPlayer(v.Target)
			assert(target and target ~= LP, "Select another player first")
			local r = Root()
			assert(r, "Character not found")
			release(false)
			saved = r.CFrame
			local id, started = session, os.clock()
			SetState(self, true)
			Notify("Fling", "Flinging " .. target.Name, "info")
			conn = RunService.Heartbeat:Connect(function()
				if session ~= id then return end
				local root = Root()
				local tr = target.Parent and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
				local elapsed = os.clock() - started
				local reason
				if not root then reason = "Your character is gone"
				elseif not tr then reason = target.Name .. " is gone"
				elseif elapsed > .3 and tr.AssemblyLinearVelocity.Magnitude > 250 then reason = target.Name .. " was flung"
				elseif elapsed >= v.Duration then reason = "Timed out"
				end
				if reason then
					release(true)
					SetState(self, false)
					Notify("Fling", reason, "info")
					return
				end
				local p = tr.Position + tr.AssemblyLinearVelocity * .12 + Vector3.new(0, math.random(-5, 5) / 10, 0)
				root.CFrame = CFrame.new(p)
				root.AssemblyLinearVelocity = Vector3.new(v.Power, v.Power, v.Power)
				root.AssemblyAngularVelocity = Vector3.new(v.Power, v.Power, v.Power)
			end)
		end,
		Stop = function() release(true) end,
		Cleanup = function() release(false) end,
		Source = [==[
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
end

-- ---------------------------------------------------------------- TPWALK
do
	local conn
	local function stop()
		if conn then conn:Disconnect() conn = nil end
	end
	AddCommand({
		Name = "TPWalk", Desc = "Moves you faster by nudging your position as you walk. Not affected by WalkSpeed checks.", Kind = "Toggle",
		Aliases = { "tpw" },
		Inputs = { { Key = "Speed", Label = "Extra studs / sec", Type = "number", Default = 40, Min = 1, Max = 1000 } },
		Func = function(self, v, state)
			stop()
			if not state then return end
			conn = RunService.Heartbeat:Connect(function(dt)
				local c, h = LP.Character, Hum()
				if c and h and h.Health > 0 and not h.Sit and h.MoveDirection.Magnitude > 0 then
					c:TranslateBy(h.MoveDirection * v.Speed * dt)
				end
			end)
		end,
		Cleanup = stop,
		Source = [==[
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
end

-- ---------------------------------------------------------------- CUSTOM CROSSHAIR
do
	local conn, holder, oldIcon
	local function destroy()
		if conn then conn:Disconnect() conn = nil end
		if holder then holder:Destroy() holder = nil end
		if oldIcon ~= nil then
			UserInputService.MouseIconEnabled = oldIcon
			oldIcon = nil
		end
	end
	AddCommand({
		Name = "Custom Crosshair", Desc = "Draws your own crosshair: color, size, gap, dot, outline. Can follow the mouse.", Kind = "Toggle",
		Aliases = { "crosshair", "xhair" },
		Inputs = {
			{ Key = "Color", Label = "Color", Type = "color", Default = C(0, 255, 120) },
			{ Key = "Length", Label = "Line length", Type = "number", Default = 10, Min = 1, Max = 100 },
			{ Key = "Thickness", Label = "Thickness", Type = "number", Default = 2, Min = 1, Max = 12 },
			{ Key = "Gap", Label = "Center gap", Type = "number", Default = 5, Min = 0, Max = 60 },
			{ Key = "Dot", Label = "Center dot", Type = "bool", Default = false },
			{ Key = "Outline", Label = "Black outline", Type = "bool", Default = true },
			{ Key = "FollowMouse", Label = "Follow the mouse", Type = "bool", Default = false },
			{ Key = "HideCursor", Label = "Hide system cursor", Type = "bool", Default = true },
		},
		Func = function(self, v, state)
			destroy()
			if not state then return end
			holder = Instance.new("Frame")
			holder.Name = "MantleCrosshair"
			holder.AnchorPoint = Vector2.new(.5, .5)
			holder.Size = UDim2.fromOffset(0, 0)
			holder.BackgroundTransparency = 1
			holder.ZIndex = 90
			holder.Parent = Gui
			local parts = {}
			for _, n in ipairs({ "Top", "Bottom", "Left", "Right", "Dot" }) do
				local f = Instance.new("Frame")
				f.Name = n
				f.BorderSizePixel = 0
				f.ZIndex = 90
				f.Parent = holder
				local s = Instance.new("UIStroke")
				s.Thickness = 1
				s.Color = Color3.new(0, 0, 0)
				s.Parent = f
				parts[n] = { Frame = f, Stroke = s }
			end
			conn = RunService.RenderStepped:Connect(function()
				local L, T, G = v.Length, v.Thickness, v.Gap
				local layout = {
					Top = { Vector2.new(-T / 2, -(G + L)), Vector2.new(T, L) },
					Bottom = { Vector2.new(-T / 2, G), Vector2.new(T, L) },
					Left = { Vector2.new(-(G + L), -T / 2), Vector2.new(L, T) },
					Right = { Vector2.new(G, -T / 2), Vector2.new(L, T) },
					Dot = { Vector2.new(-T / 2, -T / 2), Vector2.new(T, T) },
				}
				for n, p in pairs(parts) do
					local pos, size = layout[n][1], layout[n][2]
					p.Frame.Position = UDim2.fromOffset(pos.X, pos.Y)
					p.Frame.Size = UDim2.fromOffset(size.X, size.Y)
					p.Frame.BackgroundColor3 = v.Color
					p.Frame.Visible = n ~= "Dot" or v.Dot
					p.Stroke.Enabled = v.Outline
				end
				if v.FollowMouse then
					local m = UserInputService:GetMouseLocation()
					holder.Position = UDim2.fromOffset(m.X, m.Y)
				else
					holder.Position = UDim2.fromScale(.5, .5)
				end
				holder.Visible = not IsUIOpen() -- the real cursor takes over while the Mantle window is open
				if v.HideCursor and not IsUIOpen() then
					if oldIcon == nil then oldIcon = UserInputService.MouseIconEnabled end
					UserInputService.MouseIconEnabled = false
				elseif oldIcon ~= nil then
					UserInputService.MouseIconEnabled = oldIcon
					oldIcon = nil
				end
			end)
		end,
		Cleanup = destroy,
		Source = [==[
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
end

-- ---------------------------------------------------------------- OWNER TAG
-- A gold "Owner" tag over the owner's head. It's drawn locally, so only people running Mantle
-- see it. There's no command for it: it just appears whenever OWNER_USERNAME is in the server.
do
	local OWNER_COLOR = C(255, 196, 52)
	local folder = Instance.new("Folder")
	folder.Name = "MantleOwnerTag"
	folder.Parent = Gui
	local guis = {}

	local function build(head)
		local g = Instance.new("BillboardGui")
		g.Name = "OwnerTag"
		g.Adornee = head
		g.Size = UDim2.fromOffset(200, 22)
		g.StudsOffsetWorldSpace = Vector3.new(0, 3.2, 0)
		g.MaxDistance = 200
		g.ResetOnSpawn = false
		g.Parent = folder
		local l = Instance.new("TextLabel")
		l.BackgroundTransparency = 1
		l.Size = UDim2.fromScale(1, 1)
		l.Font = Enum.Font.GothamBold
		l.TextSize = 16
		l.RichText = false
		l.TextStrokeTransparency = .35
		l.TextColor3 = OWNER_COLOR
		l.Text = "Owner"
		l.Parent = g
		return g
	end

	local function render()
		for _, p in ipairs(Players:GetPlayers()) do
			local isOwner = p.Name:lower() == OWNER_USERNAME:lower()
			local head = isOwner and p.Character and p.Character:FindFirstChild("Head")
			local g = guis[p]
			if head then
				if not g or g.Adornee ~= head then
					if g then g:Destroy() end
					guis[p] = build(head)
				end
			elseif g then
				g:Destroy()
				guis[p] = nil
			end
		end
		for p, g in pairs(guis) do
			if not p.Parent then
				g:Destroy()
				guis[p] = nil
			end
		end
	end

	-- the loop ends on its own once Mantle is terminated (the folder goes with the Gui)
	task.spawn(function()
		while folder.Parent do
			pcall(render)
			task.wait(.5)
		end
	end)
end

-- ---------------------------------------------------------------- BUNNY HOP
do
	local conns = {}
	local function stop()
		for _, c in ipairs(conns) do c:Disconnect() end
		table.clear(conns)
	end
	-- Jumps the moment the humanoid is on the ground. It looks the humanoid up every frame, so it
	-- keeps going through respawns and only ends when the command is toggled off.
	local function hop()
		local h = Hum()
		if not h or h.Health <= 0 or h.Sit or h.PlatformStand then return end
		local st = h:GetState()
		if st == Enum.HumanoidStateType.Jumping or st == Enum.HumanoidStateType.Freefall
			or st == Enum.HumanoidStateType.Swimming or st == Enum.HumanoidStateType.Climbing
			or st == Enum.HumanoidStateType.Dead or st == Enum.HumanoidStateType.Seated then
			return
		end
		if h.FloorMaterial ~= Enum.Material.Air then
			h.Jump = true -- the normal jump path
			h:ChangeState(Enum.HumanoidStateType.Jumping) -- forced, in case the game's controls reset Jump
		end
	end
	AddCommand({
		Name = "Bunny Hop", Desc = "Automatically jumps the moment you land. Runs until you toggle it off.", Kind = "Toggle", Aliases = { "bhop" },
		Func = function(self, v, state)
			stop()
			if not state then return end
			-- RenderStepped runs after the default controls reset Jump each frame; Heartbeat is a backup.
			table.insert(conns, RunService.RenderStepped:Connect(hop))
			table.insert(conns, RunService.Heartbeat:Connect(hop))
		end,
		Cleanup = stop,
		Source = [==[
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
end

-- ---------------------------------------------------------------- FLOAT
do
	local conn, bv
	local function stop()
		if conn then conn:Disconnect() conn = nil end
		if bv then bv:Destroy() bv = nil end
	end
	AddCommand({
		Name = "Float", Desc = "Hover in place. Q to rise, E to lower. You can still walk around.", Kind = "Toggle", Aliases = { "hover" },
		Inputs = { { Key = "Speed", Label = "Rise / lower speed", Type = "number", Default = 30, Min = 1, Max = 500 } },
		Func = function(self, v, state)
			stop()
			if not state then return end
			assert(Root(), "Character not found")
			conn = RunService.Heartbeat:Connect(function()
				local r, h = Root(), Hum()
				if not (r and h) then return end -- between respawns: keep waiting
				-- the part is replaced on respawn, so re-create the mover whenever it's missing
				if not bv or bv.Parent ~= r then
					if bv then bv:Destroy() end
					bv = Instance.new("BodyVelocity")
					bv.Name = "MantleFloat"
					bv.MaxForce = Vector3.new(0, 1e9, 0) -- vertical only: walking still works
					bv.Velocity = Vector3.zero
					bv.Parent = r
				end
				local vy = 0
				if not UserInputService:GetFocusedTextBox() then
					if UserInputService:IsKeyDown(Enum.KeyCode.Q) then vy += v.Speed end
					if UserInputService:IsKeyDown(Enum.KeyCode.E) then vy -= v.Speed end
				end
				bv.Velocity = Vector3.new(0, vy, 0)
			end)
		end,
		Cleanup = stop,
		Source = [==[
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
end

-- ---------------------------------------------------------------- SWIM
do
	local conn, savedGravity
	local function stop()
		if conn then conn:Disconnect() conn = nil end
		if savedGravity then
			workspace.Gravity = savedGravity
			savedGravity = nil
		end
		local h = Hum()
		if h then
			h:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
			h:ChangeState(Enum.HumanoidStateType.Freefall)
		end
	end
	AddCommand({
		Name = "Swim", Desc = "Swim through the air like it's water. Look where you want to go and walk.", Kind = "Toggle", Aliases = { "airswim", "swimair" },
		Func = function(self, v, state)
			stop()
			if not state then return end
			assert(Hum(), "Humanoid not found")
			savedGravity = workspace.Gravity
			conn = RunService.Heartbeat:Connect(function()
				workspace.Gravity = 0 -- stops you sinking; restored when you turn Swim off
				local h = Hum()
				if not h or h.Health <= 0 then return end
				if not h:GetStateEnabled(Enum.HumanoidStateType.Swimming) then
					h:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
				end
				if h:GetState() ~= Enum.HumanoidStateType.Swimming then
					h:ChangeState(Enum.HumanoidStateType.Swimming)
				end
			end)
		end,
		Cleanup = stop,
		Source = [==[
-- Swim (toggle): swim through the air
local originalGravity = workspace.Gravity

local conn = RunService.Heartbeat:Connect(function()
    workspace.Gravity = 0
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return end

    humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
    if humanoid:GetState() ~= Enum.HumanoidStateType.Swimming then
        humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
    end
end)

-- To disable: conn:Disconnect(), workspace.Gravity = originalGravity,
-- then humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
]==],
	})
end

-- ---------------------------------------------------------------- TIME OF DAY
do
	local conn, orig
	local function stop()
		if conn then conn:Disconnect() conn = nil end
		if orig ~= nil then
			Lighting.ClockTime = orig
			orig = nil
		end
	end
	AddCommand({
		Name = "Time Of Day", Desc = "Locks the in-game clock to an hour (0-24). Stop restores it.", Kind = "Run", Silent = true,
		Aliases = { "time", "clocktime" },
		Inputs = { { Key = "Hour", Label = "Hour (0-24)", Type = "number", Default = 12, Min = 0, Max = 24 } },
		Func = function(self, v)
			if orig == nil then orig = Lighting.ClockTime end
			if conn then conn:Disconnect() end
			conn = RunService.Heartbeat:Connect(function()
				Lighting.ClockTime = v.Hour
			end)
			SetState(self, true)
			Notify("Time Of Day", "Locked to hour " .. tostring(v.Hour), "success")
		end,
		Stop = stop,
		Cleanup = stop,
		Source = [==[
-- Time Of Day
local original = Lighting.ClockTime
local conn = RunService.Heartbeat:Connect(function()
    Lighting.ClockTime = 12
end)

-- To restore: conn:Disconnect() and Lighting.ClockTime = original
]==],
	})
end

-- ---------------------------------------------------------------- HEAD SIT
do
	local conn
	local function stop()
		if conn then conn:Disconnect() conn = nil end
		local h = Hum()
		if h then h.Sit = false end
	end
	AddCommand({
		Name = "Head Sit", Desc = "Sit on a player's head and ride along. Press Space or Stop to get off.", Kind = "Run", Silent = true,
		Aliases = { "headsit", "hs" },
		Inputs = { { Key = "Target", Label = "Player", Type = "player" } },
		Func = function(self, v)
			local target = FindPlayer(v.Target)
			assert(target and target ~= LP, "Select another player first")
			assert(Root() and Hum(), "Character not found")
			stop()
			SetState(self, true)
			Notify("Head Sit", "Riding " .. target.Name, "info")
			conn = RunService.Heartbeat:Connect(function()
				local r, h = Root(), Hum()
				local head = target.Parent and target.Character and target.Character:FindFirstChild("Head")
				if not (r and h and head) or (UserInputService:IsKeyDown(Enum.KeyCode.Space) and not UserInputService:GetFocusedTextBox()) then
					stop()
					SetState(self, false)
					Notify("Head Sit", "Stopped", "info")
					return
				end
				h.Sit = true
				r.CFrame = head.CFrame * CFrame.new(0, 1.6, 0)
				r.AssemblyLinearVelocity = Vector3.zero
			end)
		end,
		Stop = stop,
		Cleanup = stop,
		Source = [==[
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
end

-- ---------------------------------------------------------------- ANTI-VOID
do
	local conn
	local function stop()
		if conn then conn:Disconnect() conn = nil end
	end
	AddCommand({
		Name = "Anti-Void", Desc = "Remembers where you last stood and puts you back if you fall toward the void.", Kind = "Toggle",
		Aliases = { "antivoid", "av" },
		Inputs = { { Key = "Margin", Label = "Rescue margin (studs)", Type = "number", Default = 60, Min = 10, Max = 500 } },
		Func = function(self, v, state)
			stop()
			if not state then return end
			local safe, lastNote = nil, 0
			conn = RunService.Heartbeat:Connect(function()
				local r, h = Root(), Hum()
				if not (r and h) then
					safe = nil
					return
				end
				local limit = workspace.FallenPartsDestroyHeight + v.Margin
				if h.FloorMaterial ~= Enum.Material.Air and r.Position.Y > limit + 20 then
					safe = r.CFrame + Vector3.new(0, 3, 0)
				elseif r.Position.Y < limit and safe then
					r.AssemblyLinearVelocity = Vector3.zero
					r.CFrame = safe
					if os.clock() - lastNote > 2 then
						lastNote = os.clock()
						Notify("Anti-Void", "Pulled you back from the void", "success")
					end
				end
			end)
		end,
		Cleanup = stop,
		Source = [==[
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
end

local SetWidgetPinned, SetWidgetEnabled -- assigned once the widget system exists

local function RunCommandLine(text)
	text = (text or ""):match("^%s*(.-)%s*$")
	if text == "" then return end
	Log("info", "> " .. text)
	local head, rest = text:match("^(%S+)%s*(.*)$")
	head = head:lower()

	if head == "help" or head == "cmds" then
		local names = {}
		for _, c in ipairs(Commands) do table.insert(names, Key(c.Name)) end
		Log("info", "Commands: " .. table.concat(names, ", ") .. " | perf | keys | lua <code>")
		Notify("Help", "Command list printed to the console", "info")
		return
	end

	local widgetAlias = { perf = "Performance", keys = "Keybinds", binds = "Keybinds" }
	if widgetAlias[head] then
		local name = widgetAlias[head]
		local cfg = Config.Widgets[name]
		if not cfg.Enabled then
			SetWidgetEnabled(name, true)
		end
		SetWidgetPinned(name, not cfg.Pinned)
		Notify(name, cfg.Pinned and "Widget pinned" or "Widget unpinned", "info")
		return
	end

	if head == "lua" or head == "exec" then
		local ok, f, err = pcall(loadstring, rest)
		if not ok or not f then
			local m = ok and tostring(err) or "loadstring is not available in this environment"
			Log("error", m)
			Notify("Custom command", m, "error")
			return
		end
		local ok2, e2 = pcall(f)
		if ok2 then
			SessionStats.Scripts += 1
			SessionStats.Last = "Custom Lua"
			Notify("Custom command", "Executed", "success")
		else
			Log("error", tostring(e2))
			Notify("Custom command", tostring(e2), "error")
		end
		return
	end

	local cmd = CommandByKey[head]
	if not cmd then
		Log("error", "Unknown command: " .. head)
		Notify("Unknown command", head .. " (try 'help')", "error")
		return
	end

	local clean, mode = {}, nil
	for w in rest:gmatch("%S+") do
		local l = w:lower()
		if l == "on" or l == "off" or l == "stop" then
			mode = l
		else
			table.insert(clean, w)
		end
	end

	local idx = 0
	for _, inp in ipairs(cmd.Inputs or {}) do
		if inp.Type == "text" then
			local words = {}
			for i = idx + 1, #clean do table.insert(words, clean[i]) end
			if #words > 0 then
				local val = table.concat(words, " ")
				cmd.Values[inp.Key] = val
				if cmd.Setters[inp.Key] then cmd.Setters[inp.Key](val) end
			end
			idx = #clean
		elseif inp.Type == "number" or inp.Type == "player" then
			idx += 1
			local a = clean[idx]
			if a then
				local val
				if inp.Type == "number" then
					val = tonumber(a)
				else
					local p = FindPlayer(a)
					if not p then
						Notify(cmd.Name, "No player matches '" .. a .. "'", "error")
						return
					end
					val = p.Name
				end
				if val ~= nil then
					cmd.Values[inp.Key] = val
					if cmd.Setters[inp.Key] then cmd.Setters[inp.Key](val) end
				end
			end
		end
	end

	if cmd.Kind == "Toggle" then
		local want = nil
		if mode == "on" then want = true elseif mode == "off" or mode == "stop" then want = false end
		if want == nil and cmd.Enabled and #clean > 0 then
			Notify(cmd.Name, "Settings updated", "success")
			return
		end
		if want ~= nil and cmd.Enabled == want then
			Notify(cmd.Name, want and "Already enabled" or "Already disabled", "info")
			return
		end
		Execute(cmd)
	else
		if (mode == "off" or mode == "stop") and cmd.Stop then
			StopCommand(cmd)
		else
			Execute(cmd)
		end
	end
end

-- Auto-stop commands that don't survive a reset (everything else keeps running through a respawn)
Connect(LP.CharacterAdded, function()
	for _, cmd in ipairs(Commands) do
		if cmd.StopOnReset and cmd.Enabled then
			pcall(cmd.Func, cmd, cmd.Values, false)
			SetState(cmd, false)
			Log("info", cmd.Name .. " disabled after reset")
		end
	end
end)

--==================================================================================--
--  WINDOW (Game Bar layout: top bar + floating panel + widgets)
--==================================================================================--
-- Loosely typed on purpose: UI.* hooks are attached later from other scopes, and a strict type
-- checker would otherwise reject every one of them ("Key 'X' not found in table 'UI'").
local UI: { [string]: any } = {}
local UIOpen = false
IsUIOpen = function() return UIOpen end
local SetOpen, OpenCmd -- forward declarations
local BAR_POS = UDim2.new(.5, 0, 0, 14)
local WIN_TOP = 70

-- Dimmed backdrop, like the real Game Bar overlay
local Dim = New("Frame", {
	Name = "Dim", Parent = Gui, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0),
	BackgroundTransparency = 1, BorderSizePixel = 0, Visible = false,
})

-- Top bar -----------------------------------------------------------------------------
local Bar = New("CanvasGroup", {
	Name = "Bar", Parent = Gui, AnchorPoint = Vector2.new(.5, 0), Position = BAR_POS,
	Size = UDim2.fromOffset(680, 46), BorderSizePixel = 0, GroupTransparency = 1, Visible = false,
})
Style(Bar, { BackgroundColor3 = "Bg" })
Corner(Bar, 8)
Stroke(Bar)

Label(Bar, "Mantle", 18, F.Bold, "Text", { Position = UDim2.fromOffset(16, 0), Size = UDim2.fromOffset(70, 46) })

local TabList = New("ScrollingFrame", {
	Parent = Bar, BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(88, 0),
	Size = UDim2.new(1, -264, 1, 0), ScrollBarThickness = 0, CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.X, ScrollingDirection = Enum.ScrollingDirection.X,
})
List(TabList, 2, Enum.FillDirection.Horizontal, nil, Enum.VerticalAlignment.Center)

local Clock = Label(Bar, "", 14, F.Med, "Sub", {
	Position = UDim2.new(1, -176, 0, 0), Size = UDim2.fromOffset(78, 46), TextXAlignment = Enum.TextXAlignment.Right,
})

local cmdBarBtn = MakeButton(Bar, ">_", {
	Size = UDim2.fromOffset(40, 30), TextSize = 14, OnClick = function() task.spawn(OpenCmd) end,
})
cmdBarBtn.AnchorPoint = Vector2.new(1, .5)
cmdBarBtn.Position = UDim2.new(1, -48, .5, 0)

local closeBtn = MakeButton(Bar, "×", {
	Size = UDim2.fromOffset(30, 30), TextSize = 18, OnClick = function() SetOpen(false) end,
})
closeBtn.AnchorPoint = Vector2.new(1, .5)
closeBtn.Position = UDim2.new(1, -10, .5, 0)

-- Main panel --------------------------------------------------------------------------
local Window = New("CanvasGroup", {
	Name = "Window", Parent = Gui, AnchorPoint = Vector2.new(.5, 0), Position = UDim2.new(.5, 0, 0, WIN_TOP),
	Size = UDim2.fromOffset(680, 400), BorderSizePixel = 0, GroupTransparency = 1, Visible = false,
})
Style(Window, { BackgroundColor3 = "Bg" })
Corner(Window, 8)
Stroke(Window)
local WinScale = New("UIScale", { Parent = Window, Scale = .96 })

-- Optional background image (set from Settings > Appearance). Sits behind every page.
local BgImage
if FEATURES.Background then
	BgImage = New("ImageLabel", {
		Name = "Background", Parent = Window, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0,
		ScaleType = Enum.ScaleType.Crop, Image = "", ImageTransparency = 1 - Config.BgOpacity, Visible = false, ZIndex = 0,
	})
	Corner(BgImage, 8)
end

local TitleBar = Frame(Window, UDim2.new(1, 0, 0, 38), "Surface")
Frame(TitleBar, UDim2.new(1, 0, 0, 1), "Stroke", { Position = UDim2.new(0, 0, 1, -1) })
local TitleLabel = Label(TitleBar, "Home", 15, F.Bold, "Text", { Position = UDim2.fromOffset(16, 0), Size = UDim2.new(.35, 0, 1, 0) })
local HintLabel = Label(TitleBar, "", 11, F.Reg, "Sub", {
	Position = UDim2.new(.35, 0, 0, 0), Size = UDim2.new(.65, -16, 1, 0), TextXAlignment = Enum.TextXAlignment.Right,
	TextTruncate = Enum.TextTruncate.AtEnd,
})
MakeDraggable(TitleBar, Window)

local PageHolder = Frame(Window, UDim2.new(1, 0, 1, -38), nil, { Position = UDim2.fromOffset(0, 38), ClipsDescendants = true })

local function Resize()
	local cam = workspace.CurrentCamera
	local vp = cam and cam.ViewportSize or Vector2.new(1280, 720)
	local w = math.clamp(vp.X - 24, 320, 680)
	Bar.Size = UDim2.fromOffset(w, 46)
	Window.Size = UDim2.fromOffset(w, math.clamp(vp.Y - WIN_TOP - 20, 240, 420))
	local showClock = vp.X >= 560
	Clock.Visible = showClock
	TabList.Size = UDim2.new(1, showClock and -264 or -188, 1, 0)
	if UI.Clamp then UI.Clamp() end
end

-- Pages & tabs ------------------------------------------------------------------------
local Pages, TabButtons, CurrentTab = {}, {}, nil
local TabInst = {}

local function NewPage(name)
	local sf = New("ScrollingFrame", {
		Parent = PageHolder, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0,
		ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y, Visible = false, ElasticBehavior = Enum.ElasticBehavior.Never,
	})
	Style(sf, { ScrollBarImageColor3 = "Sub" })
	Pad(sf, 14, 10, 14, 16)
	List(sf, 10)
	Pages[name] = sf
	return sf
end

local TabNameList = { "Home", "Commands", "Players", "Misc", "Settings", "Credits" }
local function IsDocked(name)
	local w = Config.Widgets[name]
	return not (w and w.Enabled)
end

local function SelectTab(name)
	if not Pages[name] or not IsDocked(name) then return end
	if CurrentTab == name then return end
	CurrentTab = name
	for n, page in pairs(Pages) do
		if IsDocked(n) then
			if n == name then
				page.Visible = true
				page.Position = UDim2.fromOffset(0, 12)
				Tween(page, .35, { Position = UDim2.fromOffset(0, 0) })
			else
				page.Visible = false
			end
		end
	end
	for n, tb in pairs(TabButtons) do
		tb(n == name)
	end
	TitleLabel.Text = name
end

local function AddTab(name)
	local btn = New("TextButton", {
		Parent = TabList, Size = UDim2.fromOffset(0, 34), AutomaticSize = Enum.AutomaticSize.X, Text = name,
		Font = F.Med, TextSize = TS(14), AutoButtonColor = false, BorderSizePixel = 0, BackgroundTransparency = 1,
	})
	Corner(btn, 6)
	Pad(btn, 12, 0, 12, 0)
	Style(btn, { BackgroundColor3 = "Surface2" })
	local selected = false
	local underline = Frame(btn, UDim2.new(0, 0, 0, 3), "Accent", {
		AnchorPoint = Vector2.new(.5, 1), Position = UDim2.new(.5, 0, 1, -1),
	})
	Corner(underline, 2)
	local upText = Bind(btn, "TextColor3", function() return selected and Theme.Text or Theme.Sub end)
	btn.MouseEnter:Connect(function()
		if not selected then Tween(btn, .12, { BackgroundTransparency = .6 }) end
	end)
	btn.MouseLeave:Connect(function()
		if not selected then Tween(btn, .12, { BackgroundTransparency = 1 }) end
	end)
	TabInst[name] = btn
	TabButtons[name] = function(sel)
		selected = sel
		Tween(btn, .2, { BackgroundTransparency = sel and .35 or 1 })
		Tween(underline, .25, { Size = UDim2.new(sel and .6 or 0, 0, 0, 3) })
		upText(.2)
	end
	btn.MouseButton1Click:Connect(function()
		SelectTab(name)
	end)
end

AddTab("Home")
AddTab("Commands")
AddTab("Players")
AddTab("Misc")
AddTab("Settings")
AddTab("Credits")

-- Inspect overlay ---------------------------------------------------------------------
local Inspect = Frame(Window, UDim2.fromScale(1, 1), "Bg", { Visible = false, ZIndex = 20, Active = true })
local inspHead = Frame(Inspect, UDim2.new(1, 0, 0, 46), "Surface")
local inspTitle = Label(inspHead, "", 15, F.Bold, "Text", { Position = UDim2.fromOffset(18, 0), Size = UDim2.new(1, -200, 1, 0) })
local inspCopy = MakeButton(inspHead, "Copy", { Size = UDim2.fromOffset(66, 28) })
inspCopy.AnchorPoint = Vector2.new(1, .5)
inspCopy.Position = UDim2.new(1, -92, .5, 0)
local inspBack = MakeButton(inspHead, "Back", { Size = UDim2.fromOffset(66, 28), Variant = "Primary" })
inspBack.AnchorPoint = Vector2.new(1, .5)
inspBack.Position = UDim2.new(1, -16, .5, 0)
local codeWrap = Frame(Inspect, UDim2.new(1, -28, 1, -62), "Surface", { Position = UDim2.fromOffset(14, 54) })
Corner(codeWrap, 8)
Stroke(codeWrap)
local codeScroll = New("ScrollingFrame", {
	Parent = codeWrap, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0,
	ScrollBarThickness = 4, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.XY,
	ScrollingDirection = Enum.ScrollingDirection.XY,
})
Style(codeScroll, { ScrollBarImageColor3 = "Sub" })
Pad(codeScroll, 12, 10, 12, 10)
local codeBox = New("TextBox", {
	Parent = codeScroll, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(0, 0),
	AutomaticSize = Enum.AutomaticSize.XY, Font = F.Code, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = false, ClearTextOnFocus = false, TextEditable = false,
	MultiLine = true, Text = "",
})
Style(codeBox, { TextColor3 = "Text" })

local function ShowInspect(cmd)
	if not UIOpen then SetOpen(true) end
	inspTitle.Text = cmd.Name .. "  ·  Source"
	codeBox.Text = cmd.Source or "-- no source available"
	codeScroll.CanvasPosition = Vector2.zero
	Inspect.Visible = true
end
inspBack.MouseButton1Click:Connect(function()
	Inspect.Visible = false
end)
inspCopy.MouseButton1Click:Connect(function()
	if Env.setclipboard then
		CopyText(codeBox.Text, "Code")
	else
		codeBox:CaptureFocus()
		Notify("Inspect", "Clipboard API unavailable. Select the text and press Ctrl+C.", "warn")
	end
end)

--==================================================================================--
--  WIDGETS  (Performance, Keybinds, and any tab turned into a widget)
--==================================================================================--
local Widgets = {}
local WidgetOrder = { "Performance", "Keybinds", "Home", "Commands", "Players", "Misc", "Credits", "Command Bar", "Command History", "Command List" }
local RefreshWidget

local function VP()
	local cam = workspace.CurrentCamera
	return cam and cam.ViewportSize or Vector2.new(1280, 720)
end

local function DefaultWidgetPos(name, w, h)
	local vp = VP()
	if name == "Performance" then
		return vp.X >= 700 and UDim2.fromOffset(18, 78) or UDim2.fromOffset(12, math.max(vp.Y - h - 12, 70))
	elseif name == "Keybinds" then
		if vp.X >= 700 then
			return UDim2.fromOffset(math.max(vp.X - w - 18, 12), 78)
		end
		return UDim2.fromOffset(math.max(vp.X - w - 12, 12), math.max(vp.Y - h - 12, 70))
	elseif name == "Command Bar" then
		return UDim2.fromOffset(math.max(math.floor((vp.X - w) / 2), 8), math.max(vp.Y - h - 24, 70))
	elseif name == "Command History" then
		if vp.X >= 700 then
			return UDim2.fromOffset(18, math.min(78 + 224 + 12, math.max(vp.Y - h - 12, 70)))
		end
		return UDim2.fromOffset(12, 90)
	elseif name == "Command List" then
		return UDim2.fromOffset(math.max(math.floor((vp.X - w) / 2) - 40, 8), 100)
	end
	local off = ((table.find(WidgetOrder, name) or 3) - 3) * 26
	return UDim2.fromOffset(math.max(math.floor((vp.X - w) / 2) + off, 8), 90 + off)
end

local function Front(f)
	local list = {}
	for _, w in pairs(Widgets) do
		table.insert(list, w.Frame)
	end
	table.sort(list, function(a, b) return a.ZIndex < b.ZIndex end)
	local i = 2
	for _, fr in ipairs(list) do
		if fr ~= f then
			fr.ZIndex = i
			i += 1
		end
	end
	f.ZIndex = i
end

local function ClampWidgets()
	local vp = VP()
	for _, w in pairs(Widgets) do
		local f = w.Frame
		local x = math.clamp(f.Position.X.Offset, 0, math.max(vp.X - f.Size.X.Offset, 0))
		local y = math.clamp(f.Position.Y.Offset, 0, math.max(vp.Y - f.Size.Y.Offset, 0))
		f.Position = UDim2.fromOffset(x, y)
	end
end
UI.Clamp = ClampWidgets

RefreshWidget = function(name)
	local w, cfg = Widgets[name], Config.Widgets[name]
	if not (w and cfg) then return end
	local show = cfg.Enabled and (UIOpen or cfg.Pinned)
	local f = w.Frame
	w.Token += 1
	local tok = w.Token
	if show then
		f.Visible = true
		Tween(f, .3, { GroupTransparency = UIOpen and (1 - Config.Opacity) or .12 })
		Tween(w.Scale, .4, { Scale = 1 }, Enum.EasingStyle.Back)
	else
		Tween(w.Scale, .25, { Scale = .96 })
		local tw = Tween(f, .22, { GroupTransparency = 1 })
		tw.Completed:Connect(function()
			if w.Token == tok then
				f.Visible = false
			end
		end)
	end
end

local function RefreshAllWidgets()
	for _, name in ipairs(WidgetOrder) do
		RefreshWidget(name)
	end
end

SetWidgetPinned = function(name, v)
	local cfg = Config.Widgets[name]
	if not cfg then return end
	cfg.Pinned = v and true or false
	local w = Widgets[name]
	if w then
		w.PinBtn.Text = cfg.Pinned and "Pinned" or "Pin"
		w.PinRefresh()
	end
	RefreshWidget(name)
	local sync = UI.WSync and UI.WSync[name]
	if sync then sync.Pin(cfg.Pinned) end
end

SetWidgetEnabled = function(name, v)
	local cfg = Config.Widgets[name]
	if not cfg then return end
	v = v and true or false
	cfg.Enabled = v
	local w, page = Widgets[name], Pages[name]
	if page and w then
		if v then -- tab -> widget
			page.Parent = w.Body
			page.Visible = true
			page.Position = UDim2.new()
			if TabInst[name] then TabInst[name].Visible = false end
			if CurrentTab == name then
				CurrentTab = nil
				for _, n in ipairs(TabNameList) do
					if IsDocked(n) then
						SelectTab(n)
						break
					end
				end
			end
		else -- widget -> tab
			page.Parent = PageHolder
			page.Visible = false
			if TabInst[name] then TabInst[name].Visible = true end
			SelectTab(name)
		end
	end
	RefreshWidget(name)
	local sync = UI.WSync and UI.WSync[name]
	if sync then sync.Show(v) end
end

local function MakeWidget(name, w, h, isTab)
	local f = New("CanvasGroup", {
		Name = name .. "Widget", Parent = Gui, BorderSizePixel = 0, GroupTransparency = 1, Visible = false,
		Size = UDim2.fromOffset(w, h), Position = DefaultWidgetPos(name, w, h), ZIndex = 2,
	})
	Style(f, { BackgroundColor3 = "Bg" })
	Corner(f, 8)
	Stroke(f)
	local scale = New("UIScale", { Parent = f, Scale = .96 })
	local head = Frame(f, UDim2.new(1, 0, 0, 34), "Surface")
	Frame(head, UDim2.new(1, 0, 0, 1), "Stroke", { Position = UDim2.new(0, 0, 1, -1) })
	Label(head, name, 14, F.Bold, "Text", {
		Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -130, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd,
	})
	local rec: { [string]: any } = { Frame = f, Scale = scale, Token = 0, Name = name }
	local closeBtn = MakeButton(head, isTab and "Dock" or "Hide", {
		Size = UDim2.fromOffset(46, 22), TextSize = 11,
		OnClick = function() SetWidgetEnabled(name, false) end,
	})
	closeBtn.AnchorPoint = Vector2.new(1, .5)
	closeBtn.Position = UDim2.new(1, -8, .5, 0)
	local pinBtn, pinRefresh = MakeButton(head, "Pin", {
		Size = UDim2.fromOffset(62, 22), TextSize = 11,
		Active = function() return Config.Widgets[name].Pinned end,
		OnClick = function() SetWidgetPinned(name, not Config.Widgets[name].Pinned) end,
	})
	pinBtn.AnchorPoint = Vector2.new(1, .5)
	pinBtn.Position = UDim2.new(1, -60, .5, 0)
	rec.PinBtn, rec.PinRefresh = pinBtn, pinRefresh
	rec.Body = Frame(f, UDim2.new(1, 0, 1, -34), nil, { Position = UDim2.fromOffset(0, 34), ClipsDescendants = true })
	MakeDraggable(head, f, function() Front(f) end)
	f.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			Front(f)
		end
	end)
	Widgets[name] = rec
	return rec
end

-- Performance ------------------------------------------------------------------------
local PerfW, PerfH = 236, 224
local UpdatePerfValues
do
	local rec = MakeWidget("Performance", PerfW, PerfH)
	local P = rec.Body

	Label(P, "FPS", 12, F.Med, "Sub", { Position = UDim2.fromOffset(12, 10), Size = UDim2.fromOffset(60, 16) })
	local fpsVal = Label(P, "--", 20, F.Bold, "Text", {
		Position = UDim2.new(1, -112, 0, 4), Size = UDim2.fromOffset(100, 24), TextXAlignment = Enum.TextXAlignment.Right,
	})
	local fpsGraph = Graph(P, UDim2.fromOffset(12, 32), UDim2.new(1, -24, 0, 34), 30)

	Label(P, "Ping", 12, F.Med, "Sub", { Position = UDim2.fromOffset(12, 76), Size = UDim2.fromOffset(60, 16) })
	local pingVal = Label(P, "--", 20, F.Bold, "Text", {
		Position = UDim2.new(1, -112, 0, 70), Size = UDim2.fromOffset(100, 24), TextXAlignment = Enum.TextXAlignment.Right,
	})
	local pingGraph = Graph(P, UDim2.fromOffset(12, 98), UDim2.new(1, -24, 0, 34), 30)

	Label(P, "Memory", 12, F.Med, "Sub", { Position = UDim2.fromOffset(12, 142), Size = UDim2.fromOffset(80, 16) })
	local memVal = Label(P, "--", 13, F.Med, "Text", {
		Position = UDim2.new(1, -112, 0, 141), Size = UDim2.fromOffset(100, 18), TextXAlignment = Enum.TextXAlignment.Right,
	})
	Label(P, "Players", 12, F.Med, "Sub", { Position = UDim2.fromOffset(12, 163), Size = UDim2.fromOffset(80, 16) })
	local plrVal = Label(P, "--", 13, F.Med, "Text", {
		Position = UDim2.new(1, -112, 0, 162), Size = UDim2.fromOffset(100, 18), TextXAlignment = Enum.TextXAlignment.Right,
	})

	local fpsHist, pingHist = {}, {}
	local function push(t, v)
		table.insert(t, v)
		if #t > 30 then table.remove(t, 1) end
	end

	UpdatePerfValues = function(fps, ping)
		push(fpsHist, fps)
		push(pingHist, ping)
		if not rec.Frame.Visible then return end
		fpsVal.Text = tostring(fps)
		fpsVal.TextColor3 = fps >= 50 and Theme.Good or (fps >= 30 and Theme.Warn or Theme.Bad)
		pingVal.Text = ping .. " ms"
		pingVal.TextColor3 = ping <= 100 and Theme.Good or (ping <= 200 and Theme.Warn or Theme.Bad)
		local pmax = 150
		for _, p in ipairs(pingHist) do pmax = math.max(pmax, p) end
		fpsGraph(fpsHist, math.max(120, table.unpack(fpsHist)))
		pingGraph(pingHist, pmax)
		memVal.Text = math.floor(Stats:GetTotalMemoryUsageMb() + .5) .. " MB"
		plrVal.Text = #Players:GetPlayers() .. " / " .. Players.MaxPlayers
	end
end

-- Keybinds ---------------------------------------------------------------------------
do
	local rec = MakeWidget("Keybinds", 236, 110)
	local scroll = New("ScrollingFrame", {
		Parent = rec.Body, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0,
		ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
	})
	Style(scroll, { ScrollBarImageColor3 = "Sub" })
	Pad(scroll, 10, 8, 10, 8)
	List(scroll, 4)

	local function rebuild()
		for _, c in ipairs(scroll:GetChildren()) do
			if c:IsA("Frame") or c:IsA("TextLabel") then
				c:Destroy()
			end
		end
		local bound = {}
		for _, cmd in ipairs(Commands) do
			if cmd.Key then table.insert(bound, cmd) end
		end
		table.sort(bound, function(a, b) return a.Name < b.Name end)
		if #bound == 0 then
			Label(scroll, "No keybinds yet. Right-click a command in the Commands tab to set one.", 12, F.Reg, "Sub", {
				Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
			})
		end
		for i, cmd in ipairs(bound) do
			local r = Frame(scroll, UDim2.new(1, 0, 0, 24), nil, { LayoutOrder = i })
			Label(r, cmd.Name, 13, F.Med, "Text", { Size = UDim2.new(1, -70, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd })
			local pill = Pill(r, KeyLabel(cmd.Key), true)
			pill.AnchorPoint = Vector2.new(1, .5)
			pill.Position = UDim2.new(1, 0, .5, 0)
		end
		local h = #bound == 0 and 96 or (34 + 16 + #bound * 28)
		Tween(rec.Frame, .25, { Size = UDim2.fromOffset(236, math.clamp(h, 96, 300)) })
	end
	table.insert(KeyHooks, rebuild)
	rebuild()
end

--==================================================================================--
--  OPEN / CLOSE, MOBILE BUTTON
--==================================================================================--
SetOpen = function(open)
	if open == UIOpen then return end
	UIOpen = open
	local o = 1 - Config.Opacity
	if open then
		Dim.Visible = true
		Tween(Dim, .35, { BackgroundTransparency = Config.Dim and .5 or 1 })
		Bar.Visible, Window.Visible = true, true
		Bar.Position = UDim2.new(.5, 0, 0, -10)
		Tween(Bar, .45, { GroupTransparency = o, Position = BAR_POS })
		Tween(Window, .4, { GroupTransparency = o })
		Tween(WinScale, .5, { Scale = 1 }, Enum.EasingStyle.Back)
	else
		if UI.HideContext then UI.HideContext() end
		CancelBind()
		Tween(Dim, .25, { BackgroundTransparency = 1 })
		Tween(WinScale, .25, { Scale = .96 })
		Tween(Bar, .25, { GroupTransparency = 1, Position = UDim2.new(.5, 0, 0, -10) })
		local tw = Tween(Window, .25, { GroupTransparency = 1 })
		tw.Completed:Connect(function()
			if not UIOpen then
				Window.Visible, Bar.Visible, Dim.Visible = false, false, false
			end
		end)
	end
	RefreshAllWidgets()
end

local function SetOpacity(o)
	Config.Opacity = math.clamp(o, .4, 1)
	if UIOpen then
		Tween(Window, .2, { GroupTransparency = 1 - Config.Opacity })
		Tween(Bar, .2, { GroupTransparency = 1 - Config.Opacity })
	end
	RefreshAllWidgets()
end

local function SetDim(v)
	Config.Dim = v and true or false
	if UIOpen then
		Tween(Dim, .25, { BackgroundTransparency = Config.Dim and .5 or 1 })
	end
	if UI.DimSet then UI.DimSet(Config.Dim) end
end

local Mobile = Frame(Gui, UDim2.fromOffset(68, 34), "Accent", {
	Position = UDim2.new(1, -88, .5, -17), Active = true, ZIndex = 50, Visible = Config.MobileButton,
})
Corner(Mobile, 6)
Label(Mobile, "Mantle", 14, F.Bold, "AccentText", {
	Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, ZIndex = 51,
})
do
	local drag, moved, startPos, startMouse = false, false, nil, nil
	Mobile.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
			drag, moved, startMouse, startPos = true, false, i.Position, Mobile.Position
			i.Changed:Connect(function()
				if i.UserInputState == Enum.UserInputState.End then
					drag = false
					if not moved then SetOpen(not UIOpen) end
				end
			end)
		end
	end)
	Connect(UserInputService.InputChanged, function(i)
		if drag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
			local d = i.Position - startMouse
			if d.Magnitude > 6 then moved = true end
			if moved then
				Mobile.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
			end
		end
	end)
end

local function SetMobile(v)
	Config.MobileButton = v and true or false
	Mobile.Visible = Config.MobileButton
	if UI.MobileSet then UI.MobileSet(Config.MobileButton) end
end

--==================================================================================--
--  THEME / KEYBIND SETTERS
--==================================================================================--
local RenderConsole = function() end

local function SetTheme(name, instant)
	if not Themes[name] then return end
	Config.Theme = name
	Theme = Themes[name]
	Prune()
	for _, e in ipairs(ThemeEntries) do
		local v = e.get()
		if instant then
			e.inst[e.prop] = v
		else
			Tween(e.inst, .3, { [e.prop] = v })
		end
	end
	RenderConsole()
end

local function ValidKey(n)
	local ok, v = pcall(function() return Enum.KeyCode[n] end)
	return ok and v ~= nil
end

local function SetKeybind(name)
	Config.Keybind = name
	HintLabel.Text = name .. " shows / hides Mantle   ·   use the Command Bar widget to run commands"
	if UI.KeybindSet then UI.KeybindSet(name) end
end

-- Background image -------------------------------------------------------------------
local SetBgOpacity, SetBackground
do
	local ContentProvider = game:GetService("ContentProvider")
	local token = 0

	SetBgOpacity = function(o)
		Config.BgOpacity = math.clamp(o, 0, 1)
		if BgImage then BgImage.ImageTransparency = 1 - Config.BgOpacity end
	end

	-- Accepts "123456", "rbxassetid://123456" or an asset URL. Empty / nil clears the image.
	SetBackground = function(raw)
		local id = raw and tostring(raw):match("%d+") or nil
		Config.BgImage = id or ""
		if not BgImage then return end
		token += 1
		local tok = token
		if UI.BgSet then UI.BgSet(Config.BgImage) end
		if not id then
			BgImage.Image = ""
			BgImage.Visible = false
			return
		end
		BgImage.Image = "rbxassetid://" .. id
		BgImage.Visible = true
		task.spawn(function()
			local failed = false
			pcall(function()
				ContentProvider:PreloadAsync({ BgImage }, function(_, status)
					if status ~= Enum.AssetFetchStatus.Success then failed = true end
				end)
			end)
			-- Decal IDs don't load as images directly: fall back to the asset thumbnail, which works for both.
			if failed and tok == token then
				BgImage.Image = ("rbxthumb://type=Asset&id=%s&w=420&h=420"):format(id)
				Log("info", "Background " .. id .. " loaded through its thumbnail (looks like a Decal ID)")
			end
		end)
	end
end

--==================================================================================--
--  COMMAND BAR, COMMAND HISTORY, COMMAND LIST  (widgets)
--==================================================================================--
local CmdBarRec = MakeWidget("Command Bar", 380, 118)
local cmdField, cmdBox = Field(CmdBarRec.Body, "Type a command and press Enter  (help for list)", UDim2.new(1, -20, 0, 34))
cmdField.Position = UDim2.fromOffset(10, 10)
cmdBox.TextSize = TS(15)
local DEFAULT_HINT = "Enter runs it  ·  Up / Down recalls earlier commands"
local cmdHint = Label(CmdBarRec.Body, DEFAULT_HINT, 12, F.Med, "Sub", {
	Position = UDim2.fromOffset(12, 52), Size = UDim2.new(1, -24, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
})

local function Suggest(text)
	local head = (text:match("^%s*(%S*)") or ""):lower()
	if head == "" then
		cmdHint.Text = DEFAULT_HINT
		return
	end
	local cmd = CommandByKey[head]
	if cmd and text:find("^%s*%S+%s") then
		local parts = {}
		for _, inp in ipairs(cmd.Inputs or {}) do
			if inp.Type == "number" or inp.Type == "player" or inp.Type == "text" then
				table.insert(parts, "<" .. inp.Label:lower() .. ">")
			end
		end
		if cmd.Kind == "Toggle" then table.insert(parts, "[on|off]") end
		if cmd.Stop then table.insert(parts, "[off]") end
		cmdHint.Text = Key(cmd.Name) .. " " .. table.concat(parts, " ")
		return
	end
	local out = {}
	for _, c in ipairs(Commands) do
		local match = Key(c.Name):sub(1, #head) == head
		if not match then
			for _, a in ipairs(c.Aliases or {}) do
				if a:sub(1, #head) == head then match = true break end
			end
		end
		if match then table.insert(out, Key(c.Name)) end
	end
	for _, n in ipairs({ "help", "perf", "keys", "lua" }) do
		if n:sub(1, #head) == head then table.insert(out, n) end
	end
	cmdHint.Text = #out > 0 and table.concat(out, "   ", 1, math.min(#out, 8)) or "No matching command"
end

local CmdInputs, CmdIdx = {}, 0
OpenCmd = function()
	if not Config.Widgets["Command Bar"].Enabled then
		SetWidgetEnabled("Command Bar", true)
	end
	cmdBox:CaptureFocus()
end

cmdBox:GetPropertyChangedSignal("Text"):Connect(function()
	Suggest(cmdBox.Text)
end)
cmdBox.FocusLost:Connect(function(enter)
	local t = cmdBox.Text
	CmdIdx = 0
	if enter and t:match("%S") then
		cmdBox.Text = ""
		table.insert(CmdInputs, t)
		if #CmdInputs > 50 then table.remove(CmdInputs, 1) end
		RunCommandLine(t)
	end
end)
Connect(UserInputService.InputBegan, function(input)
	if not cmdBox:IsFocused() then return end
	if input.KeyCode == Enum.KeyCode.Up then
		CmdIdx = math.min(CmdIdx + 1, #CmdInputs)
	elseif input.KeyCode == Enum.KeyCode.Down then
		CmdIdx = math.max(CmdIdx - 1, 0)
	else
		return
	end
	cmdBox.Text = CmdIdx == 0 and "" or CmdInputs[#CmdInputs - CmdIdx + 1]
	cmdBox.CursorPosition = #cmdBox.Text + 1
end)

-- Command History -----------------------------------------------------------------------
do
	local rec = MakeWidget("Command History", 260, 250)
	local clear = MakeButton(rec.Body, "Clear history", {
		Size = UDim2.new(1, -20, 0, 26), TextSize = 12,
		OnClick = function()
			table.clear(History)
			HistoryEvent:Fire()
		end,
	})
	clear.Position = UDim2.fromOffset(10, 8)
	local scroll = New("ScrollingFrame", {
		Parent = rec.Body, Position = UDim2.fromOffset(0, 42), Size = UDim2.new(1, 0, 1, -42), BackgroundTransparency = 1,
		BorderSizePixel = 0, ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
	})
	Style(scroll, { ScrollBarImageColor3 = "Sub" })
	Pad(scroll, 10, 2, 10, 8)
	List(scroll, 2)

	local function render()
		Prune()
		for _, c in ipairs(scroll:GetChildren()) do
			if c:IsA("Frame") or c:IsA("TextLabel") then c:Destroy() end
		end
		if #History == 0 then
			Label(scroll, "Nothing yet. Commands you run show up here.", 12, F.Reg, "Sub", {
				Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
			})
			return
		end
		for i = #History, 1, -1 do -- newest first
			local e = History[i]
			local row = Frame(scroll, UDim2.new(1, 0, 0, 20), nil, { LayoutOrder = #History - i })
			Label(row, e.Time, 11, F.Reg, "Sub", { Size = UDim2.fromOffset(58, 20) })
			Label(row, e.Text, 12, F.Med, e.Ok and "Text" or "Bad", {
				Position = UDim2.fromOffset(60, 0), Size = UDim2.new(1, -60, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd,
			})
		end
	end
	Connect(HistoryEvent.Event, render)
	render()
end

-- Command List --------------------------------------------------------------------------
do
	local rec = MakeWidget("Command List", 320, 330)
	local sf, search = Field(rec.Body, "Search commands…", UDim2.new(1, -20, 0, 30))
	sf.Position = UDim2.fromOffset(10, 8)
	local scroll = New("ScrollingFrame", {
		Parent = rec.Body, Position = UDim2.fromOffset(0, 46), Size = UDim2.new(1, 0, 1, -46), BackgroundTransparency = 1,
		BorderSizePixel = 0, ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
	})
	Style(scroll, { ScrollBarImageColor3 = "Sub" })
	Pad(scroll, 10, 2, 10, 10)
	List(scroll, 6)

	local rows = {}
	for i, cmd in ipairs(Commands) do
		local row = Frame(scroll, UDim2.new(1, 0, 0, 46), "Surface", { LayoutOrder = i })
		Corner(row, 8)
		Stroke(row)
		Label(row, cmd.Name, 13, F.Med, "Text", { Position = UDim2.fromOffset(10, 6), Size = UDim2.new(1, -100, 0, 17), TextTruncate = Enum.TextTruncate.AtEnd })
		local desc = Label(row, cmd.Desc, 11, F.Reg, "Sub", { Position = UDim2.fromOffset(10, 25), Size = UDim2.new(1, -100, 0, 14), TextTruncate = Enum.TextTruncate.AtEnd })
		local function text()
			if cmd.Kind == "Toggle" then return cmd.Enabled and "On" or "Off" end
			return (cmd.Stop and cmd.Enabled) and "Stop" or "Run"
		end
		local btn, refresh = MakeButton(row, text(), {
			Size = UDim2.fromOffset(62, 28), TextSize = 12,
			Active = function() return cmd.Enabled end,
			OnClick = function() Trigger(cmd) end,
		})
		btn.AnchorPoint = Vector2.new(1, .5)
		btn.Position = UDim2.new(1, -8, .5, 0)
		cmd.Listeners[function()
			btn.Text = text()
			refresh()
		end] = true
		cmd.KeyListeners[function(k)
			desc.Text = k and ("[" .. KeyLabel(k) .. "]  " .. cmd.Desc) or cmd.Desc
		end] = true
		table.insert(rows, { frame = row, hay = (cmd.Name .. " " .. cmd.Desc):lower() })
	end
	search:GetPropertyChangedSignal("Text"):Connect(function()
		local q = search.Text:lower()
		for _, r in ipairs(rows) do
			r.frame.Visible = q == "" or r.hay:find(q, 1, true) ~= nil
		end
	end)
end

--==================================================================================--
--  CONSOLE (separate ScreenGui)
--==================================================================================--
local ConsoleGui
do
	ConsoleGui = New("ScreenGui", {
		Name = "MantleConsole", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		IgnoreGuiInset = true, DisplayOrder = 1001, Enabled = false, Parent = Gui.Parent,
	})
	local win = New("CanvasGroup", {
		Parent = ConsoleGui, AnchorPoint = Vector2.new(.5, .5), Position = UDim2.fromScale(.5, .5),
		Size = UDim2.fromOffset(540, 320), BorderSizePixel = 0,
	})
	Style(win, { BackgroundColor3 = "Bg" })
	Corner(win, 8)
	Stroke(win)
	local head = Frame(win, UDim2.new(1, 0, 0, 40), "Surface")
	Frame(head, UDim2.new(1, 0, 0, 1), "Stroke", { Position = UDim2.new(0, 0, 1, -1) })
	Label(head, "Console", 15, F.Bold, "Text", { Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -220, 1, 0) })
	local scroll = New("ScrollingFrame", {
		Parent = win, Position = UDim2.fromOffset(0, 40), Size = UDim2.new(1, 0, 1, -40), BackgroundTransparency = 1,
		BorderSizePixel = 0, ScrollBarThickness = 4, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
	})
	Style(scroll, { ScrollBarImageColor3 = "Sub" })
	Pad(scroll, 12, 8, 12, 8)
	List(scroll, 3)
	MakeDraggable(head, win)

	local lines, counter = {}, 0
	local LevelColor = { info = "Accent", success = "Good", warn = "Warn", error = "Bad" }
	local LevelTag = { info = "INFO", success = "OK", warn = "WARN", error = "ERROR" }
	local function esc(s)
		return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
	end
	local function addLine(e)
		counter += 1
		local col = Theme[LevelColor[e.Level] or "Accent"]
		local l = New("TextLabel", {
			Parent = scroll, BackgroundTransparency = 1, BorderSizePixel = 0, RichText = true, LayoutOrder = counter,
			Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left, Font = F.Code, TextSize = 12,
			Text = ('<font color="#%s">%s</font>  <font color="#%s"><b>%-5s</b></font>  %s'):format(
				Theme.Sub:ToHex(), e.Time, col:ToHex(), LevelTag[e.Level] or "INFO", esc(e.Msg)
			),
		})
		Style(l, { TextColor3 = "Text" })
		table.insert(lines, l)
		if #lines > 250 then
			table.remove(lines, 1):Destroy()
		end
		task.defer(function()
			scroll.CanvasPosition = Vector2.new(0, 1e6)
		end)
	end
	RenderConsole = function()
		for _, l in ipairs(lines) do l:Destroy() end
		table.clear(lines)
		for _, e in ipairs(Logs) do addLine(e) end
	end
	LogEvent.Event:Connect(addLine)

	local clear = MakeButton(head, "Clear", { Size = UDim2.fromOffset(60, 26) })
	clear.AnchorPoint = Vector2.new(1, .5)
	clear.Position = UDim2.new(1, -78, .5, 0)
	clear.MouseButton1Click:Connect(function()
		table.clear(Logs)
		RenderConsole()
	end)
	local close = MakeButton(head, "Close", { Size = UDim2.fromOffset(58, 26), Variant = "Primary" })
	close.AnchorPoint = Vector2.new(1, .5)
	close.Position = UDim2.new(1, -12, .5, 0)
	close.MouseButton1Click:Connect(function()
		ConsoleGui.Enabled = false
	end)
end

--==================================================================================--
--  CONFIG (forward declarations; implemented below)
--==================================================================================--
local SaveConfig, LoadConfig, ResetConfig, Terminate

local AvatarCache = {}
local function LoadAvatar(img, userId)
	if AvatarCache[userId] then
		img.Image = AvatarCache[userId]
		return
	end
	task.spawn(function()
		local ok, content = pcall(Players.GetUserThumbnailAsync, Players, userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
		if ok and content then
			AvatarCache[userId] = content
			if img.Parent then img.Image = content end
		end
	end)
end

--==================================================================================--
--  HOME TAB
--==================================================================================--
do
	local Home = NewPage("Home")
	Label(Home, "Welcome, " .. LP.Name, 22, F.Bold, "Text", { Size = UDim2.new(1, 0, 0, 28), LayoutOrder = 1 })
	Label(Home, "Your Mantle overview", 12, F.Reg, "Sub", { Size = UDim2.new(1, 0, 0, 14), LayoutOrder = 2 })

	-- Profile sheet
	local prof = Frame(Home, UDim2.new(1, 0, 0, 100), "Surface", { LayoutOrder = 3 })
	Corner(prof, 8)
	Stroke(prof)
	local av = New("ImageLabel", {
		Parent = prof, Size = UDim2.fromOffset(72, 72), Position = UDim2.fromOffset(14, 14), BorderSizePixel = 0,
	})
	Style(av, { BackgroundColor3 = "Surface2" })
	Corner(av, 36)
	Stroke(av, "Accent", 2)
	LoadAvatar(av, LP.UserId)
	Label(prof, LP.DisplayName, 18, F.Bold, "Text", { Position = UDim2.fromOffset(100, 14), Size = UDim2.new(1, -114, 0, 22) })
	Label(prof, "@" .. LP.Name, 12, F.Reg, "Sub", { Position = UDim2.fromOffset(100, 38), Size = UDim2.new(1, -114, 0, 16) })
	local pills = Frame(prof, UDim2.new(1, -114, 0, 22), nil, { Position = UDim2.fromOffset(100, 64) })
	List(pills, 6, Enum.FillDirection.Horizontal)
	Pill(pills, "Mantle v" .. VERSION, true)
	Pill(pills, "Account age: " .. LP.AccountAge .. " days")

	-- Game info
	local gi = Card(Home, "Game Info", 4)
	local gHead = Frame(gi, UDim2.new(1, 0, 0, 64), nil)
	local gIcon = New("ImageLabel", {
		Parent = gHead, Size = UDim2.fromOffset(64, 64), BorderSizePixel = 0, ScaleType = Enum.ScaleType.Crop,
		Image = game.GameId ~= 0 and ("rbxthumb://type=GameIcon&id=" .. game.GameId .. "&w=150&h=150") or "",
	})
	Style(gIcon, { BackgroundColor3 = "Surface2" })
	Corner(gIcon, 10)
	Stroke(gIcon)
	local gName = Label(gHead, game.Name ~= "" and game.Name or "Unknown game", 16, F.Bold, "Text", {
		Position = UDim2.fromOffset(76, 8), Size = UDim2.new(1, -76, 0, 24), TextTruncate = Enum.TextTruncate.AtEnd,
	})
	local gBy = Label(gHead, "", 12, F.Reg, "Sub", {
		Position = UDim2.fromOffset(76, 34), Size = UDim2.new(1, -76, 0, 16), TextTruncate = Enum.TextTruncate.AtEnd,
	})
	task.spawn(function() -- the real place name (and creator) come from the marketplace
		local ok, info = pcall(function()
			return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
		end)
		if ok and type(info) == "table" then
			if gName.Parent and type(info.Name) == "string" and info.Name ~= "" then gName.Text = info.Name end
			if gBy.Parent and type(info.Creator) == "table" and info.Creator.Name then gBy.Text = "by " .. tostring(info.Creator.Name) end
		end
	end)

	local function infoRow(parent, k)
		local r = Frame(parent, UDim2.new(1, 0, 0, 18), nil)
		Label(r, k, 12, F.Reg, "Sub", { Size = UDim2.new(.35, 0, 1, 0) })
		return Label(r, "", 12, F.Med, "Text", {
			Position = UDim2.fromScale(.35, 0), Size = UDim2.fromScale(.65, 1), TextTruncate = Enum.TextTruncate.AtEnd,
		})
	end
	local iPlace, iJob = infoRow(gi, "Place ID"), infoRow(gi, "Job ID")
	local iPlayers, iUp = infoRow(gi, "Players"), infoRow(gi, "Server uptime")
	iPlace.Text = tostring(game.PlaceId)
	iJob.Text = game.JobId ~= "" and game.JobId or "Studio"
	local gb = Frame(gi, UDim2.new(1, 0, 0, 30), nil)
	List(gb, 8, Enum.FillDirection.Horizontal)
	MakeButton(gb, "Copy Place ID", { AutoX = true, Height = 28, TextSize = 12, OnClick = function() CopyText(tostring(game.PlaceId), "Place ID") end })
	MakeButton(gb, "Copy Job ID", { AutoX = true, Height = 28, TextSize = 12, OnClick = function() CopyText(game.JobId, "Job ID") end })

	-- General info
	local ge = Card(Home, "General Info", 5)
	local gScripts, gOpen = infoRow(ge, "Scripts ran"), infoRow(ge, "Mantle open for")
	local gLast, gActive = infoRow(ge, "Last script"), infoRow(ge, "Active toggles")
	local gCmds, gBinds = infoRow(ge, "Commands loaded"), infoRow(ge, "Keybinds set")
	local gTheme, gTime = infoRow(ge, "Theme"), infoRow(ge, "Local time")

	function UI.InfoUpdate()
		iPlayers.Text = #Players:GetPlayers() .. " / " .. Players.MaxPlayers
		iUp.Text = FmtTime(workspace.DistributedGameTime)

		gScripts.Text = tostring(SessionStats.Scripts)
		gOpen.Text = FmtTime(os.clock() - StartClock)
		gLast.Text = SessionStats.Last or "None yet"
		local active, bound = 0, 0
		for _, cmd in ipairs(Commands) do
			if cmd.Kind == "Toggle" and cmd.Enabled then active += 1 end
			if cmd.Key then bound += 1 end
		end
		gActive.Text = tostring(active)
		gCmds.Text = tostring(#Commands)
		gBinds.Text = tostring(bound)
		gTheme.Text = Config.Theme
		gTime.Text = (os.date("%I:%M %p"):gsub("^0", ""))
	end
	UI.InfoUpdate()

	-- Quick actions
	local qa = Card(Home, "Quick Actions", 6)
	local QuickHolder = WrapHolder(qa)
	local quickBinds = {}
	function UI.RebuildQuick()
		for _, b in ipairs(quickBinds) do
			b.cmd.Listeners[b.fn] = nil
		end
		quickBinds = {}
		for _, c in ipairs(QuickHolder:GetChildren()) do
			if not c:IsA("UIListLayout") then c:Destroy() end
		end
		local any = false
		for _, name in ipairs(Config.QuickActions) do
			local cmd = CommandByKey[Key(name)]
			if cmd then
				any = true
				local _, refresh = MakeButton(QuickHolder, cmd.Name, {
					AutoX = true, Height = 32,
					Active = function() return cmd.Kind == "Toggle" and cmd.Enabled end,
					OnClick = function() Execute(cmd) end,
				})
				local fn = function() refresh() end
				cmd.Listeners[fn] = true
				table.insert(quickBinds, { cmd = cmd, fn = fn })
			end
		end
		if not any then
			Label(QuickHolder, "No quick actions selected. Pick some in Settings.", 12, F.Reg, "Sub", { Size = UDim2.new(1, 0, 0, 18) })
		end
	end
	UI.RebuildQuick()
end

--==================================================================================--
--  COMMANDS TAB
--==================================================================================--
do
	local Page = NewPage("Commands")

	-- Right-click menu --------------------------------------------------------------
	local Catcher = New("TextButton", {
		Name = "ContextCatcher", Parent = Gui, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "",
		AutoButtonColor = false, Visible = false, ZIndex = 79, BorderSizePixel = 0,
	})
	local Ctx = New("CanvasGroup", {
		Name = "Context", Parent = Gui, Size = UDim2.fromOffset(176, 0), AutomaticSize = Enum.AutomaticSize.Y,
		BorderSizePixel = 0, Visible = false, ZIndex = 80, GroupTransparency = 1,
	})
	Style(Ctx, { BackgroundColor3 = "Surface" })
	Corner(Ctx, 8)
	Stroke(Ctx)
	Pad(Ctx, 5, 5, 5, 5)
	List(Ctx, 3)
	local function HideCtx()
		Catcher.Visible = false
		Ctx.Visible = false
	end
	UI.HideContext = HideCtx
	Catcher.MouseButton1Click:Connect(HideCtx)
	Catcher.MouseButton2Click:Connect(HideCtx)
	local function ShowContext(cmd)
		for _, c in ipairs(Ctx:GetChildren()) do
			if c:IsA("TextButton") then c:Destroy() end
		end
		local n = 0
		local function item(text, fn)
			n += 1
			MakeButton(Ctx, text, {
				Size = UDim2.new(1, 0, 0, 28), TextSize = 12,
				OnClick = function()
					HideCtx()
					fn()
				end,
			})
		end
		item(cmd.Key and ("Change Keybind  (" .. KeyLabel(cmd.Key) .. ")") or "Set Keybind", function() StartBinding(cmd) end)
		if cmd.Key then
			item("Clear Keybind", function()
				SetCommandKey(cmd, nil)
				Notify(cmd.Name, "Keybind cleared", "info")
			end)
		end
		item("Inspect", function() ShowInspect(cmd) end)
		local vp = VP()
		local m = UserInputService:GetMouseLocation()
		local h = n * 31 + 7
		Ctx.Position = UDim2.fromOffset(math.clamp(m.X, 4, math.max(vp.X - 180, 4)), math.clamp(m.Y, 4, math.max(vp.Y - h - 4, 4)))
		Catcher.Visible = true
		Ctx.Visible = true
		Ctx.GroupTransparency = 1
		Tween(Ctx, .14, { GroupTransparency = 0 })
	end

	local sf, search = Field(Page, "Search commands…")
	sf.LayoutOrder = 1
	Label(Page, "Tip: use the Command Bar widget (or the  >_  button) to run a command by typing it. Right-click any command to set a keybind.", 12, F.Reg, "Sub", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true, LayoutOrder = 2,
	})
	local rows = {}

	local function BuildInput(parent, cmd, inp)
		local holder = Frame(parent, UDim2.new(1, 0, 0, 0), nil, { AutomaticSize = Enum.AutomaticSize.Y })
		List(holder, 6)
		local head = Frame(holder, UDim2.new(1, 0, 0, 28), nil)
		Label(head, inp.Label, 12, F.Med, "Sub", { Size = UDim2.new(.45, 0, 1, 0) })
		local k = inp.Key

		if inp.Type == "number" then
			local ff, tb = Field(head, "", UDim2.fromOffset(110, 28))
			ff.Position = UDim2.new(1, -110, 0, 0)
			tb.Text = tostring(inp.Default)
			tb.FocusLost:Connect(function()
				local n = tonumber(tb.Text)
				if n then
					cmd.Values[k] = math.clamp(n, inp.Min or -1e9, inp.Max or 1e9)
				end
				tb.Text = tostring(cmd.Values[k])
			end)
			cmd.Setters[k] = function(v)
				cmd.Values[k] = v
				tb.Text = tostring(v)
			end

		elseif inp.Type == "bool" then
			local sw, setSw = Switch(head, cmd.Values[k], function(v) cmd.Values[k] = v end)
			sw.Position = UDim2.new(1, -40, .5, -11)
			cmd.Setters[k] = function(v)
				cmd.Values[k] = v
				setSw(v, true)
			end

		elseif inp.Type == "color" then
			local preview = Frame(head, UDim2.fromOffset(32, 18), nil, {
				Position = UDim2.new(1, -32, .5, -9), BackgroundTransparency = 0, BackgroundColor3 = cmd.Values[k],
			})
			Corner(preview, 6)
			Stroke(preview)
			local rainbow = {}
			for i = 0, 6 do
				table.insert(rainbow, ColorSequenceKeypoint.new(i / 6, Color3.fromHSV(i / 6, 1, 1)))
			end
			local hueHolder, setHue
			local function setColor(c)
				cmd.Values[k] = c
				preview.BackgroundColor3 = c
			end
			hueHolder, setHue = Slider(holder, 0, 1, (cmd.Values[k]:ToHSV()), function(h)
				setColor(Color3.fromHSV(h, 1, 1))
			end, ColorSequence.new(rainbow))
			local sw = Frame(holder, UDim2.new(1, 0, 0, 24), nil)
			List(sw, 6, Enum.FillDirection.Horizontal)
			for _, col in ipairs({ C(255, 70, 70), C(255, 150, 50), C(255, 220, 60), C(90, 220, 110), C(70, 200, 255), C(90, 120, 255), C(190, 100, 255), C(255, 255, 255) }) do
				local b = New("TextButton", { Parent = sw, Size = UDim2.fromOffset(24, 24), Text = "", AutoButtonColor = false, BorderSizePixel = 0, BackgroundColor3 = col })
				Corner(b, 12)
				Stroke(b)
				b.MouseButton1Click:Connect(function()
					setColor(col)
					setHue((col:ToHSV()), true)
				end)
			end
			cmd.Setters[k] = function(c)
				setColor(c)
				setHue((c:ToHSV()), true)
			end

		elseif inp.Type == "text" then
			local _, tb = Field(holder, inp.Placeholder or "", UDim2.new(1, 0, 0, 30))
			tb.Text = tostring(cmd.Values[k] or "")
			tb.FocusLost:Connect(function()
				cmd.Values[k] = tb.Text
			end)
			cmd.Setters[k] = function(v)
				cmd.Values[k] = v
				tb.Text = tostring(v)
			end

		elseif inp.Type == "player" then
			local btn = MakeButton(head, "Select player…", { Size = UDim2.fromOffset(190, 28) })
			btn.Position = UDim2.new(1, -190, 0, 0)
			local list = New("ScrollingFrame", {
				Parent = holder, Size = UDim2.new(1, 0, 0, 112), Visible = false, BorderSizePixel = 0,
				ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
			})
			Style(list, { BackgroundColor3 = "Surface2", ScrollBarImageColor3 = "Sub" })
			Corner(list, 6)
			Pad(list, 6, 6, 6, 6)
			List(list, 4)
			local function setPlayer(name)
				cmd.Values[k] = name
				btn.Text = name or "Select player…"
			end
			local function rebuild()
				for _, c in ipairs(list:GetChildren()) do
					if c:IsA("TextButton") then c:Destroy() end
				end
				local n = 0
				for _, p in ipairs(Players:GetPlayers()) do
					if p ~= LP then
						n += 1
						local txt = p.DisplayName == p.Name and p.Name or (p.DisplayName .. "  (@" .. p.Name .. ")")
						MakeButton(list, txt, {
							Size = UDim2.new(1, -4, 0, 26), TextSize = 12,
							OnClick = function()
								setPlayer(p.Name)
								list.Visible = false
							end,
						})
					end
				end
				if n == 0 then
					Label(list, "No other players", 12, F.Reg, "Sub", { Size = UDim2.new(1, 0, 0, 20) }).Parent = list
				end
			end
			btn.MouseButton1Click:Connect(function()
				list.Visible = not list.Visible
				if list.Visible then rebuild() end
			end)
			table.insert(PlayerListeners, function()
				if list.Visible then rebuild() end
			end)
			cmd.Setters[k] = setPlayer
		end
	end

	local function BuildRow(cmd, order)
		local row = Frame(Page, UDim2.new(1, 0, 0, 0), "Surface", { AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = order })
		Corner(row, 8)
		Stroke(row)
		List(row, 0)
		local header = New("TextButton", {
			Parent = row, Size = UDim2.new(1, 0, 0, 50), BackgroundTransparency = 1, Text = "", AutoButtonColor = false,
		})
		Label(header, cmd.Name, 14, F.Med, "Text", { Position = UDim2.fromOffset(14, 8), Size = UDim2.new(1, -170, 0, 18) })
		Label(header, cmd.Desc, 11, F.Reg, "Sub", {
			Position = UDim2.fromOffset(14, 28), Size = UDim2.new(1, -170, 0, 14), TextTruncate = Enum.TextTruncate.AtEnd,
		})
		local keyTag = Label(header, "", 11, F.Bold, "Sub", {
			Position = UDim2.new(1, -150, 0, 0), Size = UDim2.fromOffset(66, 50), TextXAlignment = Enum.TextXAlignment.Right,
		})
		local status = Label(header, "", 11, F.Bold, "Good", {
			Position = UDim2.new(1, -78, 0, 0), Size = UDim2.fromOffset(52, 50), TextXAlignment = Enum.TextXAlignment.Right,
		})
		local chev = Label(header, "›", 22, F.Med, "Sub", {
			Position = UDim2.new(1, -26, 0, 0), Size = UDim2.fromOffset(16, 50), TextXAlignment = Enum.TextXAlignment.Center,
		})
		header.MouseButton2Click:Connect(function()
			ShowContext(cmd)
		end)

		local clip = Frame(row, UDim2.new(1, 0, 0, 0), nil, { ClipsDescendants = true, Visible = false })
		local details = Frame(clip, UDim2.new(1, 0, 0, 0), nil, { AutomaticSize = Enum.AutomaticSize.Y })
		Pad(details, 14, 2, 14, 14)
		List(details, 10)
		for _, inp in ipairs(cmd.Inputs or {}) do
			BuildInput(details, cmd, inp)
		end
		local btns = WrapHolder(details)
		MakeButton(btns, cmd.Kind == "Toggle" and "Toggle" or "Run", {
			Variant = "Primary", OnClick = function() Execute(cmd) end,
		})
		if cmd.Stop then
			MakeButton(btns, "Stop", { OnClick = function() StopCommand(cmd) end })
		end
		MakeButton(btns, "Inspect", { OnClick = function() ShowInspect(cmd) end })
		local keyBtn = MakeButton(btns, "Set Keybind", { AutoX = true, Height = 32, OnClick = function() StartBinding(cmd) end })
		cmd.KeyListeners[function(k)
			keyTag.Text = k and ("[" .. KeyLabel(k) .. "]") or ""
			keyBtn.Text = k and ("Key: " .. KeyLabel(k)) or "Set Keybind"
		end] = true

		local open, token = false, 0
		header.MouseButton1Click:Connect(function()
			open = not open
			token += 1
			local my = token
			Tween(chev, .25, { Rotation = open and 90 or 0 })
			if open then
				clip.AutomaticSize = Enum.AutomaticSize.None
				clip.Size = UDim2.new(1, 0, 0, 0)
				clip.Visible = true
				task.spawn(function()
					RunService.RenderStepped:Wait() -- let the layout measure itself
					if my ~= token then return end
					local tw = Tween(clip, .3, { Size = UDim2.new(1, 0, 0, details.AbsoluteSize.Y) })
					tw.Completed:Connect(function()
						if my == token and open then
							clip.Size = UDim2.new(1, 0, 0, 0)
							clip.AutomaticSize = Enum.AutomaticSize.Y
						end
					end)
				end)
			else
				local h = clip.AbsoluteSize.Y
				clip.AutomaticSize = Enum.AutomaticSize.None
				clip.Size = UDim2.new(1, 0, 0, h)
				local tw = Tween(clip, .22, { Size = UDim2.new(1, 0, 0, 0) })
				tw.Completed:Connect(function()
					if my == token and not open then
						clip.Visible = false
					end
				end)
			end
		end)
		cmd.Listeners[function(on)
			status.Text = on and (cmd.Kind == "Toggle" and "ON" or "ACTIVE") or ""
		end] = true
		table.insert(rows, { frame = row, hay = (cmd.Name .. " " .. cmd.Desc):lower() })
	end

	for i, cmd in ipairs(Commands) do
		BuildRow(cmd, i + 10)
	end

	search:GetPropertyChangedSignal("Text"):Connect(function()
		local q = search.Text:lower()
		for _, r in ipairs(rows) do
			r.frame.Visible = q == "" or r.hay:find(q, 1, true) ~= nil
		end
	end)
end

--==================================================================================--
--  PLAYERS TAB
--==================================================================================--
local RebuildPlayers
do
	local Page = NewPage("Players")
	local header = Label(Page, "", 16, F.Bold, "Text", { Size = UDim2.new(1, 0, 0, 20), LayoutOrder = 1 })
	local sf, search = Field(Page, "Search players…")
	sf.LayoutOrder = 2
	local PList = Frame(Page, UDim2.new(1, 0, 0, 0), nil, { AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 3 })
	List(PList, 8)

	local function TeleportToPlayer(p)
		local tr = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
		local r = Root()
		if tr and r then
			r.CFrame = tr.CFrame * CFrame.new(0, 0, 3)
			Log("success", "Teleported to " .. p.Name)
			Notify("Teleport", "Teleported to " .. p.DisplayName, "success")
		else
			Log("error", "Could not teleport to " .. p.Name)
			Notify("Teleport", p.DisplayName .. " has no character", "error")
		end
	end

	local specCmd = CommandByKey["spectate"]
	local function IsSpectating(p)
		return specCmd.Enabled and specCmd.Values.Target == p.Name
	end
	local function SpectatePlayer(p)
		if IsSpectating(p) then
			StopCommand(specCmd) -- pressing it again cancels
			return
		end
		specCmd.Values.Target = p.Name
		if specCmd.Setters.Target then specCmd.Setters.Target(p.Name) end
		Execute(specCmd)
	end

	RebuildPlayers = function()
		for _, c in ipairs(PList:GetChildren()) do
			if c:IsA("Frame") then c:Destroy() end
		end
		local list = Players:GetPlayers()
		table.sort(list, function(a, b) return a.DisplayName:lower() < b.DisplayName:lower() end)
		header.Text = ("In this server  ·  %d"):format(#list)
		local q = search.Text:lower()
		for _, p in ipairs(list) do
			if q == "" or p.Name:lower():find(q, 1, true) or p.DisplayName:lower():find(q, 1, true) then
				local row = Frame(PList, UDim2.new(1, 0, 0, 56), "Surface")
				Corner(row, 8)
				Stroke(row)
				local av = New("ImageLabel", {
					Parent = row, Size = UDim2.fromOffset(38, 38), Position = UDim2.fromOffset(10, 9), BorderSizePixel = 0,
				})
				Style(av, { BackgroundColor3 = "Surface2" })
				Corner(av, 19)
				LoadAvatar(av, p.UserId)
				Label(row, p.DisplayName, 13, F.Bold, "Text", {
					Position = UDim2.fromOffset(58, 10), Size = UDim2.new(1, -250, 0, 18), TextTruncate = Enum.TextTruncate.AtEnd,
				})
				Label(row, "@" .. p.Name, 11, F.Reg, "Sub", {
					Position = UDim2.fromOffset(58, 29), Size = UDim2.new(1, -250, 0, 14), TextTruncate = Enum.TextTruncate.AtEnd,
				})
				if p == LP then
					local you = Pill(row, "You", true)
					you.AnchorPoint = Vector2.new(1, .5)
					you.Position = UDim2.new(1, -12, .5, 0)
				else
					local watching = IsSpectating(p)
					local sp = MakeButton(row, watching and "Stop" or "Spectate", {
						Size = UDim2.fromOffset(78, 30), Active = function() return watching end,
						OnClick = function() SpectatePlayer(p) end,
					})
					sp.AnchorPoint = Vector2.new(1, .5)
					sp.Position = UDim2.new(1, -12, .5, 0)
					local b = MakeButton(row, "Teleport To", { Size = UDim2.fromOffset(96, 30), Variant = "Primary", OnClick = function() TeleportToPlayer(p) end })
					b.AnchorPoint = Vector2.new(1, .5)
					b.Position = UDim2.new(1, -96, .5, 0)
				end
			end
		end
	end
	search:GetPropertyChangedSignal("Text"):Connect(RebuildPlayers)
	CommandByKey["spectate"].Listeners[function() RebuildPlayers() end] = true
	RebuildPlayers()
end

local function PlayersChanged()
	task.defer(function()
		RebuildPlayers()
		for _, fn in ipairs(PlayerListeners) do pcall(fn) end
	end)
end
Connect(Players.PlayerAdded, function(p)
	Log("info", p.Name .. " joined")
	PlayersChanged()
end)
Connect(Players.PlayerRemoving, function(p)
	Log("info", p.Name .. " left")
	PlayersChanged()
end)

--==================================================================================--
--  SETTINGS TAB
--==================================================================================--
-- Music engine (the controls live in Misc > Music Player) ---------------------------
local Music: { [string]: any } = {
	Sound = FEATURES.Music and New("Sound", { Name = "MantleMusic", Volume = .5, Parent = game:GetService("SoundService") }) or nil,
	Playlist = {}, Index = nil, CurrentId = nil, LastId = nil, CurrentName = nil, Loading = false,
	Token = 0, LastManual = 0, Listeners = {},
}
local MusicSound = Music.Sound

if not FEATURES.Music then
	Music.Collect = function() return nil end
	Music.Apply = function() end
end

if FEATURES.Music then (function() -- own function scope so the engine's locals don't use up main-chunk slots
local MarketplaceService = game:GetService("MarketplaceService")

local function MusicChanged()
	for fn in pairs(Music.Listeners) do pcall(fn) end
end
Music.Changed = MusicChanged

local function ParseId(s)
	return s and tostring(s):match("%d+") or nil
end

local function ResolveName(id, cb)
	task.spawn(function()
		local ok, info = pcall(function()
			return MarketplaceService:GetProductInfo(tonumber(id), Enum.InfoType.Asset)
		end)
		if ok and type(info) == "table" and type(info.Name) == "string" and info.Name ~= "" then
			cb(info.Name)
		end
	end)
end

function Music.Play(raw, index)
	local id = ParseId(raw)
	if not id then
		Notify("Music", "Enter a valid sound ID", "warn")
		return
	end
	Music.Token += 1
	local tok = Music.Token
	Music.LastManual = os.clock() -- our own Stop() below must not look like a track ending
	MusicSound:Stop()
	MusicSound.SoundId = "rbxassetid://" .. id
	MusicSound.TimePosition = 0
	local entry = index and Music.Playlist[index] or nil
	local fallback = "Sound " .. id
	Music.CurrentId, Music.LastId, Music.Index, Music.Loading = id, id, index, true
	Music.CurrentName = entry and entry.Name or fallback
	MusicChanged()
	MusicSound:Play()

	if Music.CurrentName == fallback then
		ResolveName(id, function(name)
			if entry then entry.Name = name end
			if tok == Music.Token then
				Music.CurrentName = name
			end
			MusicChanged()
		end)
	end

	task.spawn(function()
		local t0 = os.clock()
		while tok == Music.Token and not MusicSound.IsLoaded and os.clock() - t0 < 10 do
			task.wait(.1)
		end
		if tok ~= Music.Token then return end
		Music.Loading = false
		if not MusicSound.IsLoaded or MusicSound.TimeLength <= 0 then
			Music.LastManual = os.clock()
			MusicSound:Stop()
			Music.CurrentId, Music.Index = nil, nil
			Log("error", "Music: could not load " .. id)
			Notify("Music", "Couldn't load that ID. It may be private, removed, or not an audio asset.", "error")
		else
			Log("success", "Music: playing " .. id)
		end
		MusicChanged()
	end)
end

function Music.Stop()
	Music.Token += 1
	Music.LastManual = os.clock()
	MusicSound:Stop()
	Music.CurrentId, Music.CurrentName, Music.Index, Music.Loading = nil, nil, nil, false
	MusicChanged()
end

function Music.Toggle()
	if not Music.CurrentId then
		if Music.LastId then
			Music.Play(Music.LastId)
		elseif Music.Playlist[1] then
			Music.Play(Music.Playlist[1].Id, 1)
		else
			Notify("Music", "Enter a sound ID first", "warn")
		end
		return
	end
	if MusicSound.IsPlaying then
		MusicSound:Pause()
	elseif MusicSound.IsPaused then
		MusicSound:Resume()
	else
		MusicSound:Play()
	end
	MusicChanged()
end

-- dir: 1 = next, -1 = previous. `auto` = called because a track ended (stops at the end instead of wrapping).
function Music.Step(dir, auto)
	local n = #Music.Playlist
	if n == 0 then
		if auto then Music.Stop() end
		return
	end
	local i = Music.Index or (dir > 0 and 0 or n + 1)
	i += dir
	if i > n then
		if auto then
			Music.Stop()
			return
		end
		i = 1
	elseif i < 1 then
		i = n
	end
	Music.Play(Music.Playlist[i].Id, i)
end

function Music.Add(raw)
	local id = ParseId(raw)
	if not id then
		Notify("Music", "Enter a valid sound ID", "warn")
		return
	end
	for _, e in ipairs(Music.Playlist) do
		if e.Id == id then
			Notify("Music", "Already in your playlist", "info")
			return
		end
	end
	local entry = { Id = id, Name = "Sound " .. id }
	table.insert(Music.Playlist, entry)
	MusicChanged()
	ResolveName(id, function(name)
		entry.Name = name
		MusicChanged()
	end)
	Notify("Music", "Added to playlist", "success")
end

function Music.Remove(i)
	if not Music.Playlist[i] then return end
	table.remove(Music.Playlist, i)
	if Music.Index then
		if Music.Index == i then
			Music.Index = nil -- keeps playing, just no longer part of the list
		elseif Music.Index > i then
			Music.Index -= 1
		end
	end
	MusicChanged()
end

function Music.Collect()
	local list = {}
	for _, e in ipairs(Music.Playlist) do
		table.insert(list, { Id = e.Id, Name = e.Name })
	end
	return { Volume = MusicSound.Volume, Speed = MusicSound.PlaybackSpeed, Loop = MusicSound.Looped, Playlist = list }
end

function Music.Apply(d)
	if type(d) ~= "table" then return end
	if type(d.Volume) == "number" then
		MusicSound.Volume = math.clamp(d.Volume, 0, 1)
		if UI.MusicVol then UI.MusicVol(MusicSound.Volume) end
	end
	if type(d.Speed) == "number" then
		MusicSound.PlaybackSpeed = math.clamp(d.Speed, .25, 2)
		if UI.MusicSpeed then UI.MusicSpeed(MusicSound.PlaybackSpeed) end
	end
	if type(d.Loop) == "boolean" then MusicSound.Looped = d.Loop end
	if type(d.Playlist) == "table" then
		table.clear(Music.Playlist)
		Music.Index = nil
		for _, e in ipairs(d.Playlist) do
			local id = type(e) == "table" and ParseId(e.Id) or nil
			if id then
				table.insert(Music.Playlist, { Id = id, Name = type(e.Name) == "string" and e.Name or ("Sound " .. id) })
			end
		end
	end
	MusicChanged()
end

MusicSound.Ended:Connect(function()
	if os.clock() - Music.LastManual < .4 then return end -- we stopped it ourselves
	if MusicSound.Looped then return end
	if Music.Index then
		Music.Step(1, true)
	else
		Music.Stop()
	end
end)
MusicSound.Paused:Connect(MusicChanged)
MusicSound.Resumed:Connect(MusicChanged)
MusicSound.Played:Connect(MusicChanged)
end)() end -- music engine

local listening = false
do
	local Page = NewPage("Settings")

	local function SettingRow(parent, title, desc)
		local row = Frame(parent, UDim2.new(1, 0, 0, 40), nil)
		Label(row, title, 13, F.Med, "Text", { Size = UDim2.new(1, -170, 0, 18), Position = UDim2.fromOffset(0, desc and 2 or 11) })
		if desc then
			Label(row, desc, 11, F.Reg, "Sub", {
				Size = UDim2.new(1, -170, 0, 14), Position = UDim2.fromOffset(0, 21), TextTruncate = Enum.TextTruncate.AtEnd,
			})
		end
		return row
	end

	-- Appearance
	local app = Card(Page, "Appearance", 1)
	Label(app, "Theme", 13, F.Med, "Text", { Size = UDim2.new(1, 0, 0, 16) })
	local themeHolder = WrapHolder(app)
	for _, name in ipairs(ThemeOrder) do
		MakeButton(themeHolder, name, {
			AutoX = true, Height = 30, TextSize = 12,
			Active = function() return Config.Theme == name end,
			OnClick = function() SetTheme(name) end,
		})
	end

	local ob = Frame(app, UDim2.new(1, 0, 0, 46), nil)
	Label(ob, "UI Opacity", 13, F.Med, "Text", { Size = UDim2.new(.5, 0, 0, 18) })
	local pct = Label(ob, "100%", 12, F.Med, "Sub", {
		Size = UDim2.new(.5, 0, 0, 18), Position = UDim2.fromScale(.5, 0), TextXAlignment = Enum.TextXAlignment.Right,
	})
	local oh, setO = Slider(ob, .4, 1, Config.Opacity, function(v)
		pct.Text = math.floor(v * 100 + .5) .. "%"
		SetOpacity(v)
	end)
	oh.Position = UDim2.fromOffset(0, 24)
	function UI.OpacitySet(v)
		setO(v, true)
		pct.Text = math.floor(v * 100 + .5) .. "%"
	end

	local dr = SettingRow(app, "Dim background", "Darkens the game while Mantle is open")
	local dsw, setD = Switch(dr, Config.Dim, function(v) SetDim(v) end)
	dsw.AnchorPoint = Vector2.new(1, .5)
	dsw.Position = UDim2.new(1, 0, .5, 0)
	function UI.DimSet(v) setD(v, true) end

	-- Background image
	if FEATURES.Background then (function()
	Label(app, "Background image", 13, F.Med, "Text", { Size = UDim2.new(1, 0, 0, 16) })
	Label(app, "Paste a Roblox image or decal ID. It shows behind the Mantle panel.", 11, F.Reg, "Sub", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
	})
	local bgRow = Frame(app, UDim2.new(1, 0, 0, 34), nil)
	List(bgRow, 8, Enum.FillDirection.Horizontal)
	local _, bgBox = Field(bgRow, "Image ID  (e.g. 1234567890)", UDim2.new(1, -150, 0, 34))
	MakeButton(bgRow, "Apply", {
		Size = UDim2.fromOffset(70, 34), Variant = "Primary",
		OnClick = function()
			SetBackground(bgBox.Text)
			Notify("Background", Config.BgImage ~= "" and "Image applied" or "Background cleared", "success")
		end,
	})
	MakeButton(bgRow, "Clear", {
		Size = UDim2.fromOffset(64, 34),
		OnClick = function()
			SetBackground(nil)
			Notify("Background", "Background cleared", "info")
		end,
	})
	bgBox.FocusLost:Connect(function(enter)
		if enter then SetBackground(bgBox.Text) end
	end)
	function UI.BgSet(id)
		bgBox.Text = id
	end

	local bo = Frame(app, UDim2.new(1, 0, 0, 46), nil)
	Label(bo, "Image visibility", 13, F.Med, "Text", { Size = UDim2.new(.5, 0, 0, 18) })
	local bpct = Label(bo, "40%", 12, F.Med, "Sub", {
		Size = UDim2.new(.5, 0, 0, 18), Position = UDim2.fromScale(.5, 0), TextXAlignment = Enum.TextXAlignment.Right,
	})
	local bh, setB = Slider(bo, 0, 1, Config.BgOpacity, function(v)
		bpct.Text = math.floor(v * 100 + .5) .. "%"
		SetBgOpacity(v)
	end)
	bh.Position = UDim2.fromOffset(0, 24)
	function UI.BgOpacitySet(v)
		setB(v, true)
		bpct.Text = math.floor(v * 100 + .5) .. "%"
	end
	end)() end -- FEATURES.Background

	-- Widgets
	local wd = Card(Page, "Widgets & Tabs", 2)
	Label(wd, "Turn tabs into floating widgets. Pinned widgets stay on screen when Mantle is closed.", 11, F.Reg, "Sub", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
	})
	UI.WSync = {}
	local function WidgetRow(name, desc, showLabel)
		local row = Frame(wd, UDim2.new(1, 0, 0, 46), nil)
		Label(row, name, 13, F.Med, "Text", { Size = UDim2.new(1, -110, 0, 18), Position = UDim2.fromOffset(0, 6) })
		Label(row, desc, 11, F.Reg, "Sub", {
			Size = UDim2.new(1, -110, 0, 14), Position = UDim2.fromOffset(0, 25), TextTruncate = Enum.TextTruncate.AtEnd,
		})
		Label(row, showLabel, 10, F.Med, "Sub", {
			Position = UDim2.new(1, -96, 0, 0), Size = UDim2.fromOffset(40, 12), TextXAlignment = Enum.TextXAlignment.Center,
		})
		Label(row, "Pin", 10, F.Med, "Sub", {
			Position = UDim2.new(1, -40, 0, 0), Size = UDim2.fromOffset(40, 12), TextXAlignment = Enum.TextXAlignment.Center,
		})
		local cfg = Config.Widgets[name]
		local s1, set1 = Switch(row, cfg.Enabled, function(v) SetWidgetEnabled(name, v) end)
		s1.Position = UDim2.new(1, -96, 0, 16)
		local s2, set2 = Switch(row, cfg.Pinned, function(v) SetWidgetPinned(name, v) end)
		s2.Position = UDim2.new(1, -40, 0, 16)
		UI.WSync[name] = {
			Show = function(v) set1(v, true) end,
			Pin = function(v) set2(v, true) end,
		}
	end
	WidgetRow("Performance", "FPS, ping, memory and player count", "Show")
	WidgetRow("Keybinds", "Every command keybind you have set", "Show")
	WidgetRow("Command Bar", "Type a command and press Enter", "Show")
	WidgetRow("Command History", "Commands you ran, newest first", "Show")
	WidgetRow("Command List", "Every command with a run / toggle button", "Show")
	WidgetRow("Home", "Show the Home tab as a widget", "Widget")
	WidgetRow("Commands", "Show the Commands tab as a widget", "Widget")
	WidgetRow("Players", "Show the Players tab as a widget", "Widget")
	WidgetRow("Misc", "Show the Misc tab as a widget", "Widget")
	WidgetRow("Credits", "Show the Credits tab as a widget", "Widget")

	-- Controls
	local ctl = Card(Page, "Controls", 3)
	local kr = SettingRow(ctl, "UI toggle keybind", "Show or hide the Mantle bar and panel")
	local keyBtn = MakeButton(kr, Config.Keybind, { Size = UDim2.fromOffset(130, 30) })
	keyBtn.AnchorPoint = Vector2.new(1, .5)
	keyBtn.Position = UDim2.new(1, 0, .5, 0)
	keyBtn.MouseButton1Click:Connect(function()
		listening = true
		keyBtn.Text = "Press a key…"
	end)
	function UI.KeybindSet(n)
		keyBtn.Text = n
	end
	Connect(UserInputService.InputBegan, function(input, gp)
		if BindTarget then
			if input.UserInputType == Enum.UserInputType.Keyboard then
				FinishBind(input.KeyCode)
			end
			return
		end
		if listening then
			if input.UserInputType == Enum.UserInputType.Keyboard then
				listening = false
				if input.KeyCode ~= Enum.KeyCode.Escape then
					SetKeybind(input.KeyCode.Name)
					Notify("Keybind", "UI toggle set to " .. input.KeyCode.Name, "success")
				else
					keyBtn.Text = Config.Keybind
				end
			end
			return
		end
		if gp then return end
		if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
		if input.KeyCode.Name == Config.Keybind then
			SetOpen(not UIOpen)
		else
			local bound = KeyMap[input.KeyCode.Name]
			if bound then task.spawn(Trigger, bound) end
		end
	end)

	local mr = SettingRow(ctl, "Mobile button", "Floating button to open Mantle on touch devices")
	local msw, setM = Switch(mr, Config.MobileButton, function(v) SetMobile(v) end)
	msw.AnchorPoint = Vector2.new(1, .5)
	msw.Position = UDim2.new(1, 0, .5, 0)
	function UI.MobileSet(v) setM(v, true) end

	-- Quick actions
	local qa = Card(Page, "Home Quick Actions", 4)
	Label(qa, "Choose which commands appear on the Home tab.", 11, F.Reg, "Sub", { Size = UDim2.new(1, 0, 0, 14) })
	local qh = WrapHolder(qa)
	UI.QuickChips = {}
	for _, cmd in ipairs(Commands) do
		local function has()
			return table.find(Config.QuickActions, cmd.Name) ~= nil
		end
		local _, refresh = MakeButton(qh, cmd.Name, {
			AutoX = true, Height = 28, TextSize = 12, Active = has,
			OnClick = function()
				local i = table.find(Config.QuickActions, cmd.Name)
				if i then table.remove(Config.QuickActions, i) else table.insert(Config.QuickActions, cmd.Name) end
				UI.QuickChips[cmd.Name]()
				UI.RebuildQuick()
			end,
		})
		UI.QuickChips[cmd.Name] = refresh
	end

	-- Configuration
	local cfg = Card(Page, "Configuration", 5)
	Label(cfg, HasFS and "Saved to your workspace folder (Mantle/config.json) and auto-loaded on start." or "No file system available — configs are kept for this session only.", 11, F.Reg, "Sub", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
	})
	local cb = Frame(cfg, UDim2.new(1, 0, 0, 32), nil)
	List(cb, 8, Enum.FillDirection.Horizontal)
	MakeButton(cb, "Save", { Variant = "Primary", OnClick = function() SaveConfig() end })
	MakeButton(cb, "Load", { OnClick = function() LoadConfig() end })
	MakeButton(cb, "Reset", { OnClick = function() ResetConfig() end })


	-- Advanced
	local adv = Card(Page, "Advanced", 6)
	local cr = SettingRow(adv, "Console", "Opens the Mantle console in its own window")
	local consoleBtn = MakeButton(cr, "Open", { Size = UDim2.fromOffset(100, 30) })
	consoleBtn.AnchorPoint = Vector2.new(1, .5)
	consoleBtn.Position = UDim2.new(1, 0, .5, 0)
	consoleBtn.MouseButton1Click:Connect(function()
		ConsoleGui.Enabled = not ConsoleGui.Enabled
		RenderConsole()
	end)
	local tr = SettingRow(adv, "Terminate UI", "Stops every command and removes Mantle completely")
	local termBtn = MakeButton(tr, "Terminate", { Size = UDim2.fromOffset(100, 30), Variant = "Danger" })
	termBtn.AnchorPoint = Vector2.new(1, .5)
	termBtn.Position = UDim2.new(1, 0, .5, 0)
	local armed = false
	termBtn.MouseButton1Click:Connect(function()
		if armed then
			Terminate()
			return
		end
		armed = true
		termBtn.Text = "Confirm?"
		task.delay(3, function()
			armed = false
			if termBtn.Parent then termBtn.Text = "Terminate" end
		end)
	end)
end

--==================================================================================--
--  MISC TAB  (music player, Infinite Yield launcher)
--==================================================================================--
do
	local Page = NewPage("Misc")

	-- Music player
	if FEATURES.Music then (function()
	local mu = Card(Page, "Music Player", 1)
	local function fmt(s)
		s = math.max(0, math.floor(s))
		return ("%d:%02d"):format(s // 60, s % 60)
	end
	local nowTitle = Label(mu, "Nothing playing", 14, F.Bold, "Text", {
		Size = UDim2.new(1, 0, 0, 18), TextTruncate = Enum.TextTruncate.AtEnd,
	})
	local nowStatus = Label(mu, "Enter a Roblox audio ID below", 11, F.Reg, "Sub", { Size = UDim2.new(1, 0, 0, 14) })

	local lastSeek = 0
	local _, setSeek = Slider(mu, 0, 1, 0, function(a)
		lastSeek = os.clock()
		if Music.CurrentId and MusicSound.TimeLength > 0 then
			MusicSound.TimePosition = a * MusicSound.TimeLength
		end
	end)
	local timeLabel = Label(mu, "0:00 / 0:00", 11, F.Med, "Sub", { Size = UDim2.new(1, 0, 0, 14) })

	local idRow = Frame(mu, UDim2.new(1, 0, 0, 34), nil)
	List(idRow, 8, Enum.FillDirection.Horizontal)
	local _, idBox = Field(idRow, "Roblox audio ID", UDim2.new(1, -150, 0, 34))
	MakeButton(idRow, "Play", {
		Size = UDim2.fromOffset(64, 34), Variant = "Primary", OnClick = function() Music.Play(idBox.Text) end,
	})
	MakeButton(idRow, "+ Add", {
		Size = UDim2.fromOffset(70, 34), OnClick = function() Music.Add(idBox.Text) end,
	})
	idBox.FocusLost:Connect(function(enter)
		if enter and idBox.Text:match("%d") then Music.Play(idBox.Text) end
	end)

	local trans = WrapHolder(mu)
	MakeButton(trans, "Prev", { AutoX = true, Height = 32, OnClick = function() Music.Step(-1) end })
	local playBtn = MakeButton(trans, "Play", { AutoX = true, Height = 32, Variant = "Primary", OnClick = Music.Toggle })
	MakeButton(trans, "Stop", { AutoX = true, Height = 32, OnClick = Music.Stop })
	MakeButton(trans, "Next", { AutoX = true, Height = 32, OnClick = function() Music.Step(1) end })
	local _, loopRefresh = MakeButton(trans, "Loop", {
		AutoX = true, Height = 32, Active = function() return MusicSound.Looped end,
		OnClick = function()
			MusicSound.Looped = not MusicSound.Looped
			Music.Changed()
		end,
	})

	local vr = Frame(mu, UDim2.new(1, 0, 0, 46), nil)
	Label(vr, "Volume", 13, F.Med, "Text", { Size = UDim2.new(.5, 0, 0, 18) })
	local volPct = Label(vr, "50%", 12, F.Med, "Sub", {
		Size = UDim2.new(.5, 0, 0, 18), Position = UDim2.fromScale(.5, 0), TextXAlignment = Enum.TextXAlignment.Right,
	})
	local vh, setVol = Slider(vr, 0, 1, MusicSound.Volume, function(v)
		MusicSound.Volume = v
		volPct.Text = math.floor(v * 100 + .5) .. "%"
	end)
	vh.Position = UDim2.fromOffset(0, 24)
	function UI.MusicVol(v)
		setVol(v, true)
		volPct.Text = math.floor(v * 100 + .5) .. "%"
	end
	UI.MusicVol(MusicSound.Volume)

	local sr = Frame(mu, UDim2.new(1, 0, 0, 46), nil)
	Label(sr, "Playback speed", 13, F.Med, "Text", { Size = UDim2.new(.5, 0, 0, 18) })
	local spdLabel = Label(sr, "1.00x", 12, F.Med, "Sub", {
		Size = UDim2.new(.5, 0, 0, 18), Position = UDim2.fromScale(.5, 0), TextXAlignment = Enum.TextXAlignment.Right,
	})
	local sh, setSpd = Slider(sr, .25, 2, MusicSound.PlaybackSpeed, function(v)
		MusicSound.PlaybackSpeed = v
		spdLabel.Text = ("%.2fx"):format(v)
	end)
	sh.Position = UDim2.fromOffset(0, 24)
	function UI.MusicSpeed(v)
		setSpd(v, true)
		spdLabel.Text = ("%.2fx"):format(v)
	end
	UI.MusicSpeed(MusicSound.PlaybackSpeed)

	Label(mu, "Playlist", 13, F.Med, "Text", { Size = UDim2.new(1, 0, 0, 16) })
	local plHolder = Frame(mu, UDim2.new(1, 0, 0, 0), nil, { AutomaticSize = Enum.AutomaticSize.Y })
	List(plHolder, 6)
	local plSig
	local function rebuildPlaylist()
		local parts = { tostring(Music.Index) }
		for _, e in ipairs(Music.Playlist) do table.insert(parts, e.Id .. ":" .. e.Name) end
		local sig = table.concat(parts, "|")
		if sig == plSig then return end
		plSig = sig
		for _, c in ipairs(plHolder:GetChildren()) do
			if c:IsA("Frame") or c:IsA("TextLabel") then c:Destroy() end
		end
		Prune()
		if #Music.Playlist == 0 then
			Label(plHolder, "Empty. Type an ID above and press + Add.", 12, F.Reg, "Sub", { Size = UDim2.new(1, 0, 0, 16) })
			return
		end
		for i, e in ipairs(Music.Playlist) do
			local row = Frame(plHolder, UDim2.new(1, 0, 0, 40), "Surface2", { LayoutOrder = i })
			Corner(row, 6)
			local current = Music.Index == i
			Label(row, e.Name, 12, current and F.Bold or F.Med, current and "Accent" or "Text", {
				Position = UDim2.fromOffset(10, 4), Size = UDim2.new(1, -150, 0, 16), TextTruncate = Enum.TextTruncate.AtEnd,
			})
			Label(row, e.Id, 10, F.Reg, "Sub", { Position = UDim2.fromOffset(10, 22), Size = UDim2.new(1, -150, 0, 13) })
			local rm = MakeButton(row, "Remove", { Size = UDim2.fromOffset(64, 26), TextSize = 11, OnClick = function() Music.Remove(i) end })
			rm.AnchorPoint = Vector2.new(1, .5)
			rm.Position = UDim2.new(1, -8, .5, 0)
			local pl = MakeButton(row, "Play", {
				Size = UDim2.fromOffset(52, 26), TextSize = 11, Variant = "Primary", OnClick = function() Music.Play(e.Id, i) end,
			})
			pl.AnchorPoint = Vector2.new(1, .5)
			pl.Position = UDim2.new(1, -78, .5, 0)
		end
	end

	local function refreshMusic()
		local playing = MusicSound.IsPlaying
		if Music.CurrentId then
			nowTitle.Text = Music.CurrentName or ("Sound " .. Music.CurrentId)
			nowStatus.Text = Music.Loading and "Loading…" or (playing and "Playing" or (MusicSound.IsPaused and "Paused" or "Stopped"))
		else
			nowTitle.Text = "Nothing playing"
			nowStatus.Text = "Enter a Roblox audio ID below"
			timeLabel.Text = "0:00 / 0:00"
			setSeek(0, true)
		end
		playBtn.Text = playing and "Pause" or ((Music.CurrentId and MusicSound.IsPaused) and "Resume" or "Play")
		loopRefresh()
		rebuildPlaylist()
	end
	Music.Listeners[refreshMusic] = true
	refreshMusic()

	local acc = 0
	Connect(RunService.Heartbeat, function(dt)
		acc += dt
		if acc < .25 then return end
		acc = 0
		if not (UIOpen and (CurrentTab == "Misc" or Config.Widgets.Misc.Enabled) and Music.CurrentId) then return end
		local len, pos = MusicSound.TimeLength, MusicSound.TimePosition
		timeLabel.Text = fmt(pos) .. " / " .. fmt(len)
		if os.clock() - lastSeek > .6 then
			setSeek(len > 0 and pos / len or 0, true)
		end
	end)

	end)() end -- FEATURES.Music

	-- Infinite Yield
	local iy = Card(Page, "Infinite Yield", 2)
	Label(iy, "Loads the Infinite Yield admin script from ScriptBlox. It runs separately from Mantle and needs an executor with HTTP access.", 11, F.Reg, "Sub", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
	})
	local iyRow = Frame(iy, UDim2.new(1, 0, 0, 34), nil)
	local launching = false
	MakeButton(iyRow, "Launch Infinite Yield", {
		Size = UDim2.fromOffset(170, 34), Variant = "Primary",
		OnClick = function()
			if launching then return end
			launching = true
			task.spawn(function()
				local ok, err = pcall(function()
					loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Infinite-Yield-230564"))()
				end)
				launching = false
				if ok then
					SessionStats.Scripts += 1
					SessionStats.Last = "Infinite Yield"
					Log("success", "Infinite Yield launched")
					Record("Infinite Yield  run", true)
					Notify("Infinite Yield", "Launched", "success")
				else
					Log("error", "Infinite Yield: " .. tostring(err))
					Record("Infinite Yield  failed: " .. tostring(err), false)
					Notify("Infinite Yield", tostring(err), "error")
				end
			end)
		end,
	})
end

--==================================================================================--
--  CREDITS TAB
--==================================================================================--
do
	local Page = NewPage("Credits")
	local hero = Frame(Page, UDim2.new(1, 0, 0, 70), nil, { LayoutOrder = 1 })
	Label(hero, "Mantle", 28, F.Bold, "Text", {
		Position = UDim2.new(0, 0, 0, 8), Size = UDim2.new(1, 0, 0, 34), TextXAlignment = Enum.TextXAlignment.Center,
	})
	Label(hero, "Admin utility  ·  Game Bar edition  ·  v" .. VERSION, 12, F.Reg, "Sub", {
		Position = UDim2.new(0, 0, 0, 44), Size = UDim2.new(1, 0, 0, 16), TextXAlignment = Enum.TextXAlignment.Center,
	})

	local card = Card(Page, "Credits", 2)
	local function creditRow(role, who)
		local r = Frame(card, UDim2.new(1, 0, 0, 24), nil)
		Label(r, role, 13, F.Reg, "Sub", { Size = UDim2.new(.4, 0, 1, 0) })
		Label(r, who, 13, F.Bold, "Text", { Position = UDim2.fromScale(.4, 0), Size = UDim2.fromScale(.6, 1) })
	end
	creditRow("Idea", "malachiqx")
	creditRow("Code", "Claude Sonnet 5.5")
	creditRow("Version", VERSION)

	local note = Card(Page, nil, 3)
	Label(note, "Mantle is a private admin script made for friends to use together. Thanks for using it!", 12, F.Reg, "Sub", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
	})
end

--==================================================================================--
--  TAB WIDGETS
--==================================================================================--
do
	local vp = VP()
	local W = math.clamp(vp.X - 24, 300, 380)
	local H = math.clamp(vp.Y - 120, 240, 380)
	for _, name in ipairs({ "Home", "Commands", "Players", "Misc", "Credits" }) do
		MakeWidget(name, W, H, true)
	end
end

--==================================================================================--
--  CONFIG SAVE / LOAD
--==================================================================================--
local function ColorToTable(c) return { c.R, c.G, c.B } end

local function CollectValues(defaults)
	local out = {}
	for _, cmd in ipairs(Commands) do
		for _, inp in ipairs(cmd.Inputs or {}) do
			if inp.Type ~= "player" then
				local v = defaults and inp.Default or cmd.Values[inp.Key]
				if typeof(v) == "Color3" then v = ColorToTable(v) end
				out[cmd.Name] = out[cmd.Name] or {}
				out[cmd.Name][inp.Key] = v
			end
		end
	end
	return out
end

local function CollectWidgets()
	local out, pos = {}, {}
	for name, cfg in pairs(Config.Widgets) do
		out[name] = { Enabled = cfg.Enabled, Pinned = cfg.Pinned }
		local w = Widgets[name]
		if w then
			pos[name] = { w.Frame.Position.X.Offset, w.Frame.Position.Y.Offset }
		end
	end
	return out, pos
end

local function CollectKeybinds()
	local out = {}
	for _, cmd in ipairs(Commands) do
		if cmd.Key then out[cmd.Name] = cmd.Key end
	end
	return out
end

local function CollectConfig()
	local widgets, pos = CollectWidgets()
	return {
		_version = CONFIG_VERSION,
		Theme = Config.Theme, Keybind = Config.Keybind, Opacity = Config.Opacity, Dim = Config.Dim,
		MobileButton = Config.MobileButton, QuickActions = table.clone(Config.QuickActions), Values = CollectValues(false),
		Widgets = widgets, WidgetPos = pos, Keybinds = CollectKeybinds(),
		BgImage = Config.BgImage, BgOpacity = Config.BgOpacity, Music = Music.Collect(),
	}
end

local function ApplyConfig(d)
	if type(d) ~= "table" then return end
	if type(d.Theme) == "string" then SetTheme(d.Theme) end
	if type(d.Opacity) == "number" then
		SetOpacity(d.Opacity)
		UI.OpacitySet(Config.Opacity)
	end
	if type(d.Dim) == "boolean" then SetDim(d.Dim) end
	if type(d.BgOpacity) == "number" then
		SetBgOpacity(d.BgOpacity)
		if UI.BgOpacitySet then UI.BgOpacitySet(Config.BgOpacity) end
	end
	if type(d.BgImage) == "string" then SetBackground(d.BgImage) end
	if type(d.Music) == "table" then Music.Apply(d.Music) end
	if type(d.PerfPinned) == "boolean" then SetWidgetPinned("Performance", d.PerfPinned) end -- older configs
	if type(d.Widgets) == "table" then
		for name, st in pairs(d.Widgets) do
			local cfg = Config.Widgets[name]
			if cfg and type(st) == "table" then
				if type(st.Enabled) == "boolean" and st.Enabled ~= cfg.Enabled then SetWidgetEnabled(name, st.Enabled) end
				if type(st.Pinned) == "boolean" then SetWidgetPinned(name, st.Pinned) end
			end
		end
	end
	if type(d.WidgetPos) == "table" then
		for name, p in pairs(d.WidgetPos) do
			local w = Widgets[name]
			if w and type(p) == "table" and type(p[1]) == "number" and type(p[2]) == "number" then
				w.Frame.Position = UDim2.fromOffset(p[1], p[2])
			end
		end
		ClampWidgets()
	end
	if type(d.Keybinds) == "table" then
		for _, cmd in ipairs(Commands) do
			if cmd.Key then SetCommandKey(cmd, nil) end
		end
		for name, k in pairs(d.Keybinds) do
			local cmd = CommandByKey[Key(tostring(name))]
			if cmd and type(k) == "string" and ValidKey(k) then SetCommandKey(cmd, k) end
		end
	end
	if type(d.Keybind) == "string" and ValidKey(d.Keybind) then SetKeybind(d.Keybind) end
	if type(d.MobileButton) == "boolean" then SetMobile(d.MobileButton) end
	if type(d.QuickActions) == "table" then
		local list = {}
		for _, n in ipairs(d.QuickActions) do
			if type(n) == "string" and CommandByKey[Key(n)] then table.insert(list, CommandByKey[Key(n)].Name) end
		end
		Config.QuickActions = list
		for _, refresh in pairs(UI.QuickChips) do refresh() end
		UI.RebuildQuick()
	end
	if type(d.Values) == "table" then
		for name, vals in pairs(d.Values) do
			local cmd = CommandByKey[Key(tostring(name))]
			if cmd and type(vals) == "table" then
				for k, v in pairs(vals) do
					local setter = cmd.Setters[k]
					if setter then
						if type(v) == "table" and #v == 3 then v = Color3.new(v[1], v[2], v[3]) end
						if typeof(v) == typeof(cmd.Values[k]) then setter(v) end
					end
				end
			end
		end
	end
end

SaveConfig = function()
	local data = CollectConfig()
	shared.MantleConfig = data
	if HasFS then
		local ok, err = pcall(function()
			if Env.makefolder and Env.isfolder and not Env.isfolder("Mantle") then Env.makefolder("Mantle") end
			Env.writefile(CONFIG_FILE, HttpService:JSONEncode(data))
		end)
		if ok then
			Log("success", "Config saved to " .. CONFIG_FILE)
			Notify("Config", "Saved to " .. CONFIG_FILE, "success")
		else
			Log("error", "Config save failed: " .. tostring(err))
			Notify("Config", "Save failed: " .. tostring(err), "error")
		end
	else
		Log("warn", "No file system; config kept for this session only")
		Notify("Config", "No file system here. Saved for this session only.", "warn")
	end
end

LoadConfig = function(silent)
	local data
	if HasFS then
		pcall(function()
			if Env.isfile(CONFIG_FILE) then
				data = HttpService:JSONDecode(Env.readfile(CONFIG_FILE))
			end
		end)
	end
	data = data or shared.MantleConfig
	if not data then
		if not silent then Notify("Config", "No saved config found", "warn") end
		return false
	end
	local ver = type(data._version) == "number" and data._version or 0
	if ver > CONFIG_VERSION then
		-- saved by a newer Mantle: don't half-load keys we don't understand
		Log("warn", "Config is from a newer Mantle (v" .. ver .. "); ignoring it")
		if not silent then Notify("Config", "Saved config is from a newer version; ignored", "warn") end
		return false
	end
	while ver < CONFIG_VERSION do
		local step = Migrations[ver]
		if not step then
			Log("warn", "No migration from config v" .. ver .. "; ignoring saved config")
			if not silent then Notify("Config", "Saved config is outdated and was ignored", "warn") end
			return false
		end
		local ok, res = pcall(step, data)
		if not ok or type(res) ~= "table" then
			Log("error", "Config migration failed: " .. tostring(res))
			return false
		end
		data, ver = res, ver + 1
	end
	ApplyConfig(data)
	Log("success", "Config loaded")
	if not silent then Notify("Config", "Config loaded", "success") end
	return true
end

ResetConfig = function()
	ApplyConfig({
		Theme = "Onyx", Keybind = "RightShift", Opacity = 1, Dim = true,
		MobileButton = UserInputService.TouchEnabled, Widgets = DefaultWidgetConfig(), Keybinds = {},
		QuickActions = table.clone(DEFAULT_QUICK), Values = CollectValues(true),
		BgImage = "", BgOpacity = .4, Music = { Volume = .5, Speed = 1, Loop = false }, -- playlist is kept
	})
	Log("info", "Config reset to defaults")
	Notify("Config", "Reset to defaults", "info")
end

--==================================================================================--
--  LIVE UPDATE LOOP  (FPS, ping, clock, game info)
--==================================================================================--
do
	local function tick()
		local t = os.date("%I:%M %p")
		Clock.Text = (t:gsub("^0", ""))
		if UI.InfoUpdate then UI.InfoUpdate() end
	end
	tick()
	-- FPS is counted on RenderStepped (real rendered frames) over a measured os.clock window,
	-- ping comes from the same "Data Ping" stat the Roblox console shows.
	local frames, last = 0, os.clock()
	local pingAvg
	Connect(RunService.RenderStepped, function()
		frames += 1
		local now = os.clock()
		local elapsed = now - last
		if elapsed >= .5 then
			local fps = frames / elapsed
			frames, last = 0, now
			local ping = GetPing()
			pingAvg = pingAvg and (pingAvg + (ping - pingAvg) * .5) or ping
			UpdatePerfValues(math.floor(fps + .5), math.floor(pingAvg + .5))
			tick()
		end
	end)
end

--==================================================================================--
--  TERMINATE
--==================================================================================--
Terminate = function()
	for _, cmd in ipairs(Commands) do
		pcall(function()
			if cmd.Kind == "Toggle" and cmd.Enabled then
				cmd.Func(cmd, cmd.Values, false)
			elseif cmd.Stop and cmd.Enabled then
				cmd.Stop(cmd, cmd.Values)
			end
			if cmd.Cleanup then cmd.Cleanup(cmd) end
		end)
	end
	for _, c in ipairs(Connections) do
		pcall(function() c:Disconnect() end)
	end
	pcall(function() LogEvent:Destroy() end)
	pcall(function() HistoryEvent:Destroy() end)
	pcall(function() Music.Sound:Destroy() end)
	pcall(function() ConsoleGui:Destroy() end)
	pcall(function() Gui:Destroy() end)
	shared.MantleTerminate = nil
end
shared.MantleTerminate = Terminate

--==================================================================================--
--  STARTUP
--==================================================================================--
Resize()
if workspace.CurrentCamera then
	Connect(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), Resize)
end
SetKeybind(Config.Keybind)
SetTheme("Onyx", true)
for _, name in ipairs(WidgetOrder) do
	local cfg = Config.Widgets[name]
	if cfg.Enabled then SetWidgetEnabled(name, true) end
	SetWidgetPinned(name, cfg.Pinned)
end
LoadConfig(true) -- auto-load saved config if one exists
CurrentTab = nil
for _, n in ipairs(TabNameList) do
	if IsDocked(n) then
		SelectTab(n)
		break
	end
end
-- Mantle stays hidden until you press your keybind or tap the mobile button.

Log("success", ("Mantle v%s loaded for %s"):format(VERSION, LP.Name))
Notify("Mantle", "Loaded. " .. Config.Keybind .. " shows / hides Mantle. Use the Command Bar widget to run commands.", "success")