local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Library = {}
Library.__index = Library

function Library:CreateWindow(Config)
	Config = Config or {}
	local Title = Config.Title or "Banana UI"
	local Size = Config.Size or UDim2.fromOffset(500, 320)
	local TabWidth = Config.TabWidth or 160

	-- ScreenGui
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "BananaUI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = game.CoreGui

	-- Main Frame
	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Size = Size
	Main.Position = UDim2.new(0.5, -Size.X.Offset / 2, 0.5, -Size.Y.Offset / 2)
	Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	Main.BorderSizePixel = 0
	Main.ClipsDescendants = true
	Main.Parent = ScreenGui

	-- Corner + Shadow
	local Corner = Instance.new("UICorner", Main)
	Corner.CornerRadius = UDim.new(0, 12)

	local UIStroke = Instance.new("UIStroke", Main)
	UIStroke.Thickness = 1.5
	UIStroke.Color = Color3.fromRGB(0, 255, 200)
	UIStroke.Transparency = 0.5

	-- TopBar
	local TopBar = Instance.new("Frame")
	TopBar.Name = "TopBar"
	TopBar.Size = UDim2.new(1, 0, 0, 30)
	TopBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
	TopBar.BorderSizePixel = 0
	TopBar.Parent = Main

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Name = "Title"
	TitleLabel.Text = Title
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextSize = 16
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Position = UDim2.new(0, 10, 0, 0)
	TitleLabel.Size = UDim2.new(1, -100, 1, 0)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Parent = TopBar

	-- Window Buttons
	local function MakeButton(name, symbol, offsetX)
		local Btn = Instance.new("TextButton")
		Btn.Name = name
		Btn.Text = symbol
		Btn.Font = Enum.Font.GothamBold
		Btn.TextSize = 16
		Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
		Btn.Size = UDim2.new(0, 28, 0, 28)
		Btn.Position = UDim2.new(1, offsetX, 0, 1)
		Btn.Parent = TopBar
		local corner = Instance.new("UICorner", Btn)
		corner.CornerRadius = UDim.new(0, 6)
		return Btn
	end

	local Minimize = MakeButton("Minimize", "🗕", -90)
	local Maximize = MakeButton("Maximize", "🗖", -60)
	local Close = MakeButton("Close", "✖", -30)

	-- Dragging
	local dragging = false
	local dragStart, startPos
	TopBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = Main.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	-- Button Functions
	local minimized = false
	Minimize.MouseButton1Click:Connect(function()
		local goal = minimized and UDim2.fromOffset(Size.X.Offset, Size.Y.Offset) or UDim2.fromOffset(Size.X.Offset, 30)
		TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = goal}):Play()
		minimized = not minimized
	end)

	local maximized = false
	Maximize.MouseButton1Click:Connect(function()
		if not maximized then
			Main:TweenSize(UDim2.new(1, -100, 1, -100), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.4, true)
		else
			Main:TweenSize(Size, Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.4, true)
		end
		maximized = not maximized
	end)

	Close.MouseButton1Click:Connect(function()
		TweenService:Create(Main, TweenInfo.new(0.3), {Size = UDim2.fromOffset(0, 0), Transparency = 1}):Play()
		task.wait(0.3)
		ScreenGui:Destroy()
	end)

	return setmetatable({Main = Main, TopBar = TopBar}, Library)
end

return Library
