-- Banana Cat Hub UI Library (with Buttons + Dropdown)
-- By ToRie & ChatGPT

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Library = {}
Library.__index = Library

function Library:CreateWindow(Config)
	Config = Config or {}
	local Title = Config.Title or "Banana UI"
	local Size = Config.Size or UDim2.fromOffset(500, 320)
	local TabWidth = Config.TabWidth or 160

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "BananaUI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = game.CoreGui

	local Main = Instance.new("Frame")
	Main.Size = Size
	Main.Position = UDim2.new(0.5, -Size.X.Offset / 2, 0.5, -Size.Y.Offset / 2)
	Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	Main.BorderSizePixel = 0
	Main.Parent = ScreenGui

	Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

	local Stroke = Instance.new("UIStroke", Main)
	Stroke.Color = Color3.fromRGB(0, 255, 200)
	Stroke.Thickness = 1.3
	Stroke.Transparency = 0.6

	local TopBar = Instance.new("Frame")
	TopBar.Size = UDim2.new(1, 0, 0, 30)
	TopBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
	TopBar.Parent = Main

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Text = Title
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextSize = 16
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Position = UDim2.new(0, 10, 0, 0)
	TitleLabel.Size = UDim2.new(1, -100, 1, 0)
	TitleLabel.Parent = TopBar

	local function MakeBtn(name, text, offset)
		local Btn = Instance.new("TextButton")
		Btn.Name = name
		Btn.Text = text
		Btn.Font = Enum.Font.GothamBold
		Btn.TextSize = 16
		Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
		Btn.Size = UDim2.new(0, 28, 0, 28)
		Btn.Position = UDim2.new(1, offset, 0, 1)
		Btn.Parent = TopBar
		Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
		return Btn
	end

	local Minimize = MakeBtn("Minimize", "🗕", -90)
	local Maximize = MakeBtn("Maximize", "🗖", -60)
	local Close = MakeBtn("Close", "✖", -30)

	local TabHolder = Instance.new("Frame")
	TabHolder.Size = UDim2.new(0, TabWidth, 1, -30)
	TabHolder.Position = UDim2.new(0, 0, 0, 30)
	TabHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	TabHolder.Parent = Main

	local TabList = Instance.new("UIListLayout", TabHolder)
	TabList.Padding = UDim.new(0, 5)
	TabList.SortOrder = Enum.SortOrder.LayoutOrder

	local ContentHolder = Instance.new("Frame")
	ContentHolder.Size = UDim2.new(1, -TabWidth, 1, -30)
	ContentHolder.Position = UDim2.new(0, TabWidth, 0, 30)
	ContentHolder.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
	ContentHolder.Parent = Main

	-- Dragging
	local dragging, dragStart, startPos
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
		local goal = minimized and Size or UDim2.fromOffset(Size.X.Offset, 30)
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

	local function CreateTab(name)
		local Button = Instance.new("TextButton")
		Button.Name = name .. "_Tab"
		Button.Text = name
		Button.Font = Enum.Font.GothamSemibold
		Button.TextSize = 14
		Button.Size = UDim2.new(1, -10, 0, 28)
		Button.TextColor3 = Color3.fromRGB(255, 255, 255)
		Button.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
		Button.Parent = TabHolder
		Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)

		local Content = Instance.new("ScrollingFrame")
		Content.Size = UDim2.new(1, -10, 1, -10)
		Content.Position = UDim2.new(0, 5, 0, 5)
		Content.BackgroundTransparency = 1
		Content.ScrollBarThickness = 4
		Content.Visible = false
		Content.Parent = ContentHolder
		local Layout = Instance.new("UIListLayout", Content)
		Layout.Padding = UDim.new(0, 5)

		Button.MouseButton1Click:Connect(function()
			for _, child in ipairs(ContentHolder:GetChildren()) do
				if child:IsA("ScrollingFrame") then
					child.Visible = false
				end
			end
			for _, b in ipairs(TabHolder:GetChildren()) do
				if b:IsA("TextButton") then
					b.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
				end
			end
			Content.Visible = true
			Button.BackgroundColor3 = Color3.fromRGB(0, 200, 150)
		end)

		local TabAPI = {}

		function TabAPI:AddSection(title)
			local Section = Instance.new("Frame")
			Section.Size = UDim2.new(1, -10, 0, 30)
			Section.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
			Section.BorderSizePixel = 0
			Section.Parent = Content
			Instance.new("UICorner", Section).CornerRadius = UDim.new(0, 8)

			local Label = Instance.new("TextLabel")
			Label.Text = title
			Label.Font = Enum.Font.GothamBold
			Label.TextSize = 14
			Label.TextColor3 = Color3.fromRGB(255, 255, 255)
			Label.BackgroundTransparency = 1
			Label.Position = UDim2.new(0, 10, 0, 0)
			Label.Size = UDim2.new(1, -10, 1, 0)
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Parent = Section

			local SectionAPI = {}

			function SectionAPI:AddButton(text, callback)
				local Btn = Instance.new("TextButton")
				Btn.Text = text
				Btn.Font = Enum.Font.Gotham
				Btn.TextSize = 14
				Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
				Btn.Size = UDim2.new(1, -10, 0, 30)
				Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
				Btn.Parent = Content
				Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

				Btn.MouseButton1Click:Connect(function()
					TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(0, 200, 150)}):Play()
					task.wait(0.1)
					TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
					if callback then callback() end
				end)
			end

			function SectionAPI:AddDropdown(text, items, callback)
				local Frame = Instance.new("Frame")
				Frame.Size = UDim2.new(1, -10, 0, 30)
				Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
				Frame.Parent = Content
				Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

				local Label = Instance.new("TextLabel")
				Label.Text = text
				Label.Font = Enum.Font.Gotham
				Label.TextSize = 14
				Label.TextColor3 = Color3.fromRGB(255, 255, 255)
				Label.BackgroundTransparency = 1
				Label.Position = UDim2.new(0, 10, 0, 0)
				Label.Size = UDim2.new(0.6, 0, 1, 0)
				Label.TextXAlignment = Enum.TextXAlignment.Left
				Label.Parent = Frame

				local Drop = Instance.new("TextButton")
				Drop.Text = "▼"
				Drop.Font = Enum.Font.GothamBold
				Drop.TextSize = 14
				Drop.TextColor3 = Color3.fromRGB(255, 255, 255)
				Drop.Size = UDim2.new(0, 30, 1, 0)
				Drop.Position = UDim2.new(1, -35, 0, 0)
				Drop.BackgroundTransparency = 1
				Drop.Parent = Frame

				local Open = false
				local DropdownFrame = Instance.new("Frame")
				DropdownFrame.Size = UDim2.new(1, -10, 0, 0)
				DropdownFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
				DropdownFrame.ClipsDescendants = true
				DropdownFrame.Parent = Content
				Instance.new("UICorner", DropdownFrame).CornerRadius = UDim.new(0, 8)
				local List = Instance.new("UIListLayout", DropdownFrame)
				List.Padding = UDim.new(0, 3)

				for _, item in ipairs(items) do
					local Option = Instance.new("TextButton")
					Option.Text = item
					Option.Font = Enum.Font.Gotham
					Option.TextSize = 14
					Option.TextColor3 = Color3.fromRGB(255, 255, 255)
					Option.Size = UDim2.new(1, 0, 0, 25)
					Option.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
					Option.Parent = DropdownFrame
					Instance.new("UICorner", Option).CornerRadius = UDim.new(0, 6)

					Option.MouseButton1Click:Connect(function()
						if callback then callback(item) end
						TweenService:Create(DropdownFrame, TweenInfo.new(0.3), {Size = UDim2.fromOffset(Size.X.Offset - TabWidth - 20, 0)}):Play()
						Open = false
					end)
				end

				Drop.MouseButton1Click:Connect(function()
					Open = not Open
					local count = #items
					local newSize = Open and 30 * count or 0
					TweenService:Create(DropdownFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(Size.X.Offset - TabWidth - 20, newSize)}):Play()
				end)
			end

			return SectionAPI
		end

		return TabAPI
	end

	local default = CreateTab("Main")
	default.Visible = true
	TabHolder:FindFirstChild("Main_Tab").BackgroundColor3 = Color3.fromRGB(0, 200, 150)

	return setmetatable({
		CreateTab = CreateTab,
		Main = Main,
		ContentHolder = ContentHolder
	}, Library)
end

return Library
