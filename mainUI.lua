-- Lunar Hub BF - Single File UI (LocalScript for StarterGui)
-- Paste into StarterGui as a LocalScript.
-- Change the title below:
local WINDOW_TITLE = "Lunar Hub BF" -- <-- change the topbar title here

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- GUI root
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LunarHubBF"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- Main window
local window = Instance.new("Frame")
window.Name = "Window"
window.Size = UDim2.fromOffset(920, 520)
window.Position = UDim2.new(0.1,0,0.1,0)
window.AnchorPoint = Vector2.new(0,0)
window.BackgroundColor3 = Color3.fromRGB(30,30,30)
window.BorderSizePixel = 0
window.Parent = screenGui
window.Active = true

-- rounded corners (optional)
local uicorner = Instance.new("UICorner", window)
uicorner.CornerRadius = UDim.new(0, 6)

-- topbar
local topbar = Instance.new("Frame")
topbar.Name = "Topbar"
topbar.Size = UDim2.new(1,0,0,46)
topbar.BackgroundColor3 = Color3.fromRGB(20,20,20)
topbar.BorderSizePixel = 0
topbar.Parent = window

local topTitle = Instance.new("TextLabel")
topTitle.Name = "Title"
topTitle.BackgroundTransparency = 1
topTitle.Size = UDim2.new(0.6,0,1,0)
topTitle.Position = UDim2.new(0.02,0,0,0)
topTitle.Font = Enum.Font.SourceSansBold
topTitle.TextSize = 20
topTitle.TextColor3 = Color3.fromRGB(245,245,245)
topTitle.Text = "🌙  "..WINDOW_TITLE
topTitle.TextXAlignment = Enum.TextXAlignment.Left
topTitle.Parent = topbar

-- control buttons
local controlContainer = Instance.new("Frame", topbar)
controlContainer.Size = UDim2.new(0.35, -10, 1, 0)
controlContainer.Position = UDim2.new(0.65, 0, 0, 0)
controlContainer.BackgroundTransparency = 1

local btnMin = Instance.new("TextButton", controlContainer)
btnMin.Size = UDim2.new(0, 36, 0, 30)
btnMin.Position = UDim2.new(1, -80, 0.5, -15)
btnMin.BackgroundColor3 = Color3.fromRGB(40,40,40)
btnMin.Text = "—"
btnMin.Font = Enum.Font.SourceSansBold
btnMin.TextColor3 = Color3.fromRGB(240,240,240)
btnMin.TextSize = 22
btnMin.AutoButtonColor = true
btnMin.Name = "Minimize"
btnMin.BorderSizePixel = 0

local btnClose = Instance.new("TextButton", controlContainer)
btnClose.Size = UDim2.new(0, 36, 0, 30)
btnClose.Position = UDim2.new(1, -40, 0.5, -15)
btnClose.BackgroundColor3 = Color3.fromRGB(210,40,40)
btnClose.Text = "✕"
btnClose.Font = Enum.Font.SourceSansBold
btnClose.TextColor3 = Color3.fromRGB(255,255,255)
btnClose.TextSize = 18
btnClose.AutoButtonColor = true
btnClose.Name = "Close"
btnClose.BorderSizePixel = 0

local btnCorner1 = Instance.new("UICorner", btnMin)
btnCorner1.CornerRadius = UDim.new(0,6)
local btnCorner2 = Instance.new("UICorner", btnClose)
btnCorner2.CornerRadius = UDim.new(0,6)

-- main content frames: left sidebar and right content
local contentFrame = Instance.new("Frame", window)
contentFrame.Size = UDim2.new(1, -0, 1, -46)
contentFrame.Position = UDim2.new(0, 0, 0, 46)
contentFrame.BackgroundTransparency = 1

local sidebar = Instance.new("Frame", contentFrame)
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 140, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(28,28,28)
sidebar.BorderSizePixel = 0

local sideCorner = Instance.new("UICorner", sidebar)
sideCorner.CornerRadius = UDim.new(0, 4)

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0, 8)
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sideLayout.VerticalAlignment = Enum.VerticalAlignment.Top

local tabContainer = Instance.new("Frame", sidebar)
tabContainer.Size = UDim2.new(1, -12, 0, 80)
tabContainer.Position = UDim2.new(0,6,0,10)
tabContainer.BackgroundTransparency = 1

local tabLayout = Instance.new("UIListLayout", tabContainer)
tabLayout.FillDirection = Enum.FillDirection.Vertical
tabLayout.Padding = UDim.new(0,8)
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left

-- function to create sidebar tab
local tabs = {}
local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Name = name.."Tab"
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(240,240,240)
    btn.Text = name
    btn.AutoButtonColor = true
    btn.Parent = tabContainer
    local corner = Instance.new("UICorner", btn) corner.CornerRadius = UDim.new(0,4)

    tabs[name] = btn
    return btn
end

-- content panel
local contentPanel = Instance.new("Frame", contentFrame)
contentPanel.Name = "ContentPanel"
contentPanel.Size = UDim2.new(1, -150, 1, 0)
contentPanel.Position = UDim2.new(0,150,0,0)
contentPanel.BackgroundColor3 = Color3.fromRGB(22,22,22)
contentPanel.BorderSizePixel = 0

local contentCorner = Instance.new("UICorner", contentPanel)
contentCorner.CornerRadius = UDim.new(0,6)

-- inside content: header + scroll area
local contentHeader = Instance.new("TextLabel", contentPanel)
contentHeader.Size = UDim2.new(1, -24, 0, 52)
contentHeader.Position = UDim2.new(0,12,0,12)
contentHeader.BackgroundTransparency = 1
contentHeader.TextColor3 = Color3.fromRGB(240,240,240)
contentHeader.Font = Enum.Font.SourceSansBold
contentHeader.TextSize = 22
contentHeader.Text = "Section"

local scrollFrame = Instance.new("ScrollingFrame", contentPanel)
scrollFrame.Name = "Scroll"
scrollFrame.Size = UDim2.new(1, -24, 1, -80)
scrollFrame.Position = UDim2.new(0,12,0,72)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0,0,0,0)
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(60,60,60)

local uiList = Instance.new("UIListLayout", scrollFrame)
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Padding = UDim.new(0, 12)

local uiPadding = Instance.new("UIPadding", scrollFrame)
uiPadding.PaddingTop = UDim.new(0,6)
uiPadding.PaddingLeft = UDim.new(0,6)
uiPadding.PaddingRight = UDim.new(0,6)
uiPadding.PaddingBottom = UDim.new(0,6)

-- helper: auto canvas size update
uiList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    local y = uiList.AbsoluteContentSize.Y + 12
    scrollFrame.CanvasSize = UDim2.new(0,0,0,y)
end)

-- Element creators
local ELEMENTS = {
    Buttons = {}, -- track buttons for search
}

-- Paragraph / description
local function createParagraph(title, description)
    local frame = Instance.new("Frame", scrollFrame)
    frame.Size = UDim2.new(1, -12, 0, 64)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    frame.BorderSizePixel = 0
    local corner = Instance.new("UICorner", frame) corner.CornerRadius = UDim.new(0,6)
    local t = Instance.new("TextLabel", frame)
    t.Size = UDim2.new(1, -12, 0, 28)
    t.Position = UDim2.new(0,6,0,6)
    t.BackgroundTransparency = 1
    t.Font = Enum.Font.SourceSansBold
    t.TextSize = 18
    t.TextColor3 = Color3.fromRGB(240,240,240)
    t.Text = title
    t.TextXAlignment = Enum.TextXAlignment.Left

    local d = Instance.new("TextLabel", frame)
    d.Size = UDim2.new(1, -12, 0, 24)
    d.Position = UDim2.new(0,6,0,34)
    d.BackgroundTransparency = 1
    d.Font = Enum.Font.SourceSans
    d.TextSize = 14
    d.TextColor3 = Color3.fromRGB(190,190,190)
    d.Text = description or ""
    d.TextXAlignment = Enum.TextXAlignment.Left
    d.TextYAlignment = Enum.TextYAlignment.Top

    return frame
end

-- Button creator
local function createButton(text, callback)
    local frame = Instance.new("Frame", scrollFrame)
    frame.Size = UDim2.new(1, -12, 0, 44)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    frame.BorderSizePixel = 0
    local corner = Instance.new("UICorner", frame) corner.CornerRadius = UDim.new(0,6)

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -12, 1, -12)
    btn.Position = UDim2.new(0,6,0,6)
    btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.SourceSans
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(240,240,240)
    btn.TextSize = 16
    btn.AutoButtonColor = true

    -- store for search filtering
    table.insert(ELEMENTS.Buttons, {Instance = frame, Button = btn, Name = text})

    btn.MouseButton1Click:Connect(function()
        if type(callback) == "function" then
            pcall(callback)
        end
    end)

    return btn
end

-- Toggle
local function createToggle(text, default, callback)
    local frame = Instance.new("Frame", scrollFrame)
    frame.Size = UDim2.new(1, -12, 0, 44)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    frame.BorderSizePixel = 0
    local corner = Instance.new("UICorner", frame) corner.CornerRadius = UDim.new(0,6)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.82, -12, 1, 0)
    label.Position = UDim2.new(0,8,0,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.SourceSans
    label.TextSize = 16
    label.TextColor3 = Color3.fromRGB(240,240,240)
    label.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("TextButton", frame)
    box.Size = UDim2.new(0, 36, 0, 28)
    box.Position = UDim2.new(1, -46, 0.5, -14)
    box.BackgroundColor3 = Color3.fromRGB(45,45,45)
    box.Text = ""
    box.AutoButtonColor = true
    box.BorderSizePixel = 0
    local u = Instance.new("UICorner", box) u.CornerRadius = UDim.new(0,6)

    local state = default == true
    local indicator = Instance.new("Frame", box)
    indicator.Size = UDim2.new(0.75,0,0.75,0)
    indicator.Position = UDim2.new(0.12,0,0.12,0)
    indicator.BackgroundColor3 = state and Color3.fromRGB(120,200,120) or Color3.fromRGB(50,50,50)
    indicator.BorderSizePixel = 0
    local indCorner = Instance.new("UICorner", indicator) indCorner.CornerRadius = UDim.new(0,4)

    box.MouseButton1Click:Connect(function()
        state = not state
        indicator.BackgroundColor3 = state and Color3.fromRGB(120,200,120) or Color3.fromRGB(50,50,50)
        if type(callback) == "function" then
            pcall(callback, state)
        end
    end)

    return {Frame = frame, Get = function() return state end, Set = function(v)
        state = not not v
        indicator.BackgroundColor3 = state and Color3.fromRGB(120,200,120) or Color3.fromRGB(50,50,50)
    end}
end

-- Dropdown (single select)
local function createDropdown(text, options, defaultIndex, callback)
    options = options or {}
    local frame = Instance.new("Frame", scrollFrame)
    frame.Size = UDim2.new(1, -12, 0, 44)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    frame.BorderSizePixel = 0
    local corner = Instance.new("UICorner", frame) corner.CornerRadius = UDim.new(0,6)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.46, 0, 1, 0)
    label.Position = UDim2.new(0,8,0,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.SourceSans
    label.TextSize = 16
    label.TextColor3 = Color3.fromRGB(240,240,240)
    label.TextXAlignment = Enum.TextXAlignment.Left

    local display = Instance.new("TextButton", frame)
    display.Size = UDim2.new(0.48, -16, 0, 28)
    display.Position = UDim2.new(0.5, 0, 0.5, -14)
    display.BackgroundColor3 = Color3.fromRGB(44,44,44)
    display.AutoButtonColor = true
    display.BorderSizePixel = 0
    display.Text = options[defaultIndex] or "Select"
    display.Font = Enum.Font.SourceSans
    display.TextSize = 15
    display.TextColor3 = Color3.fromRGB(235,235,235)
    local dcorner = Instance.new("UICorner", display) dcorner.CornerRadius = UDim.new(0,6)

    local open = false
    local menu = Instance.new("Frame", display)
    menu.Size = UDim2.new(1,0,0,math.clamp(#options*28, 0, 200))
    menu.Position = UDim2.new(0, 0, 1, 6)
    menu.BackgroundColor3 = Color3.fromRGB(30,30,30)
    menu.BorderSizePixel = 0
    menu.Visible = false
    menu.ZIndex = display.ZIndex + 2
    local menuCorner = Instance.new("UICorner", menu) menuCorner.CornerRadius = UDim.new(0,8)

    local menuLayout = Instance.new("UIListLayout", menu)
    menuLayout.Padding = UDim.new(0, 4)
    menuLayout.SortOrder = Enum.SortOrder.LayoutOrder
    menuLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    menu:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        -- adjust canvas? not needed for small menu
    end)

    for i, opt in ipairs(options) do
        local optBtn = Instance.new("TextButton", menu)
        optBtn.Size = UDim2.new(1, -8, 0, 24)
        optBtn.Position = UDim2.new(0,4,0,0)
        optBtn.BackgroundTransparency = 1
        optBtn.Text = opt
        optBtn.Font = Enum.Font.SourceSans
        optBtn.TextSize = 14
        optBtn.TextColor3 = Color3.fromRGB(230,230,230)
        optBtn.AutoButtonColor = true
        optBtn.MouseButton1Click:Connect(function()
            display.Text = opt
            menu.Visible = false
            open = false
            if type(callback) == "function" then pcall(callback, opt, i) end
        end)
    end

    display.MouseButton1Click:Connect(function()
        open = not open
        menu.Visible = open
    end)

    return {Frame = frame, Get = function() return display.Text end, Set = function(v) display.Text = v end}
end

-- MultiDropdown (checkbox list)
local function createMultiDropdown(text, options, callback)
    options = options or {}
    local frame = Instance.new("Frame", scrollFrame)
    frame.Size = UDim2.new(1, -12, 0, 46)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    frame.BorderSizePixel = 0
    local corner = Instance.new("UICorner", frame) corner.CornerRadius = UDim.new(0,6)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.46, 0, 1, 0)
    label.Position = UDim2.new(0,8,0,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.SourceSans
    label.TextSize = 16
    label.TextColor3 = Color3.fromRGB(240,240,240)
    label.TextXAlignment = Enum.TextXAlignment.Left

    local display = Instance.new("TextButton", frame)
    display.Size = UDim2.new(0.48, -16, 0, 28)
    display.Position = UDim2.new(0.5,0,0.5,-14)
    display.BackgroundColor3 = Color3.fromRGB(44,44,44)
    display.AutoButtonColor = true
    display.BorderSizePixel = 0
    display.Text = "Choose..."
    display.Font = Enum.Font.SourceSans
    display.TextSize = 15
    display.TextColor3 = Color3.fromRGB(235,235,235)
    local dcorner = Instance.new("UICorner", display) dcorner.CornerRadius = UDim.new(0,6)

    local menu = Instance.new("Frame", display)
    menu.Size = UDim2.new(1,0,0,math.clamp(#options*28,0,200))
    menu.Position = UDim2.new(0,0,1,6)
    menu.BackgroundColor3 = Color3.fromRGB(30,30,30)
    menu.BorderSizePixel = 0
    menu.Visible = false
    local menuCorner = Instance.new("UICorner", menu) menuCorner.CornerRadius = UDim.new(0,8)

    local selected = {}
    for i,opt in ipairs(options) do
        local row = Instance.new("Frame", menu)
        row.Size = UDim2.new(1, -8, 0, 26)
        row.Position = UDim2.new(0,4,0, (i-1)*30)
        row.BackgroundTransparency = 1

        local cb = Instance.new("TextButton", row)
        cb.Size = UDim2.new(0,22,0,22)
        cb.Position = UDim2.new(0,0,0,2)
        cb.BackgroundColor3 = Color3.fromRGB(46,46,46)
        cb.Text = ""
        local cc = Instance.new("UICorner", cb) cc.CornerRadius = UDim.new(0,4)
        local tick = Instance.new("TextLabel", cb)
        tick.Size = UDim2.new(1,0,1,0)
        tick.BackgroundTransparency = 1
        tick.Text = ""
        tick.Font = Enum.Font.SourceSansBold

        local optLab = Instance.new("TextLabel", row)
        optLab.Size = UDim2.new(1, -28, 1, 0)
        optLab.Position = UDim2.new(0,28,0,0)
        optLab.BackgroundTransparency = 1
        optLab.Text = opt
        optLab.Font = Enum.Font.SourceSans
        optLab.TextSize = 14
        optLab.TextColor3 = Color3.fromRGB(230,230,230)
        optLab.TextXAlignment = Enum.TextXAlignment.Left

        selected[opt] = false
        cb.MouseButton1Click:Connect(function()
            selected[opt] = not selected[opt]
            tick.Text = selected[opt] and "✓" or ""
            display.Text = table.concat((function()
                local t = {}
                for k,v in pairs(selected) do if v then table.insert(t,k) end end
                return t
            end)(), ", ")
            if display.Text == "" then display.Text = "Choose..." end
            if type(callback) == "function" then pcall(callback, selected) end
        end)
    end

    display.MouseButton1Click:Connect(function()
        menu.Visible = not menu.Visible
    end)

    return {Frame = frame, Get = function() return selected end}
end

-- Slider
local function createSlider(text, min, max, default, callback)
    min = min or 0
    max = max or 100
    default = default or min
    local frame = Instance.new("Frame", scrollFrame)
    frame.Size = UDim2.new(1, -12, 0, 64)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    frame.BorderSizePixel = 0
    local corner = Instance.new("UICorner", frame) corner.CornerRadius = UDim.new(0,6)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.6, -12, 0, 20)
    label.Position = UDim2.new(0,8,0,6)
    label.BackgroundTransparency = 1
    label.Text = text.." : "..tostring(default)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 16
    label.TextColor3 = Color3.fromRGB(240,240,240)
    label.TextXAlignment = Enum.TextXAlignment.Left

    local bar = Instance.new("Frame", frame)
    bar.Size = UDim2.new(1, -24, 0, 16)
    bar.Position = UDim2.new(0,8,0,34)
    bar.BackgroundColor3 = Color3.fromRGB(44,44,44)
    bar.BorderSizePixel = 0
    local bcorner = Instance.new("UICorner", bar) bcorner.CornerRadius = UDim.new(0,6)

    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(120,200,120)
    fill.BorderSizePixel = 0
    local fcorner = Instance.new("UICorner", fill) fcorner.CornerRadius = UDim.new(0,6)

    local knob = Instance.new("TextButton", bar)
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new((default-min)/(max-min), -9, 0.5, -9)
    knob.Text = ""
    knob.BackgroundColor3 = Color3.fromRGB(220,220,220)
    knob.BorderSizePixel = 0
    knob.AutoButtonColor = false
    local kcorner = Instance.new("UICorner", knob) kcorner.CornerRadius = UDim.new(0,9)

    local dragging = false
    local function updateFromX(x)
        local rel = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local val = math.floor((min + (max-min) * rel) * 100) / 100
        fill.Size = UDim2.new(rel,0,1,0)
        knob.Position = UDim2.new(rel, -9, 0.5, -9)
        label.Text = text.." : "..tostring(val)
        if type(callback) == "function" then pcall(callback, val) end
    end

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    knob.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateFromX(input.Position.X)
        end
    end)
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            updateFromX(input.Position.X)
        end
    end)

    return {Frame = frame}
end

-- Search bar: filters buttons by name (case-insensitive)
local searchFrame = Instance.new("Frame", contentPanel)
searchFrame.Size = UDim2.new(0.42, 0, 0, 36)
searchFrame.Position = UDim2.new(1, -12 - (0.42 * contentPanel.AbsoluteSize.X), 0, 12) -- will reposition below
searchFrame.AnchorPoint = Vector2.new(1, 0)
searchFrame.BackgroundTransparency = 1

local searchBox = Instance.new("TextBox", contentPanel)
searchBox.Size = UDim2.new(0.4, -12, 0, 32)
searchBox.Position = UDim2.new(1, -12 - (0.4 * contentPanel.AbsoluteSize.X), 0, 14)
searchBox.AnchorPoint = Vector2.new(1,0)
searchBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
searchBox.PlaceholderText = "Search buttons..."
searchBox.Text = ""
searchBox.ClearTextOnFocus = false
searchBox.Font = Enum.Font.SourceSans
searchBox.TextSize = 16
searchBox.TextColor3 = Color3.fromRGB(230,230,230)
local scCorner = Instance.new("UICorner", searchBox) scCorner.CornerRadius = UDim.new(0,6)

-- Keep searchBox positioned correctly when resizing:
contentPanel:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    searchBox.Position = UDim2.new(1, -12 - (0.4 * contentPanel.AbsoluteSize.X), 0, 14)
end)

local function runSearchFilter(query)
    query = tostring(query or ""):lower()
    for _, v in ipairs(ELEMENTS.Buttons) do
        local name = tostring(v.Name or v.Button.Text or ""):lower()
        local visible = name:find(query) ~= nil
        v.Instance.Visible = visible
    end
end

searchBox.Changed:Connect(function(prop)
    if prop == "Text" then
        runSearchFilter(searchBox.Text)
    end
end)

-- make window draggable by topbar
local dragging = false
local dragStart = Vector2.new(0,0)
local startPos = UDim2.new(0,0,0,0)

topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = window.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
topbar.InputChanged:Connect(function(input)
    -- nothing
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- minimize & close
local minimized = false
btnMin.MouseButton1Click:Connect(function()
    minimized = not minimized
    contentFrame.Visible = not minimized
    window.Size = minimized and UDim2.fromOffset(window.Size.X.Offset, 46) or UDim2.fromOffset(window.Size.X.Offset, 520)
end)
btnClose.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- create default tab & elements
createTab("Main")
-- tab switching behavior: only one tab for now (Main)
tabs.Main.MouseButton1Click:Connect(function()
    contentHeader.Text = "Section"
end)

-- Add default elements (you can remove/change these)
createParagraph("Paragraph", "Description")
createButton("Example Button 1", function() print("Button 1 clicked") end)
createButton("Hello Button 2", function() print("Button 2 clicked") end)
local tog = createToggle("Toggle Option", false, function(state) print("Toggle:", state) end)
createDropdown("Choose One", {"Option A", "Option B", "Option C"}, 1, function(choice, i) print("Dropdown choose:", choice, i) end)
createMultiDropdown("MultiSelect", {"Alpha", "Beta", "Gamma"}, function(selected) print("Multi selected:", selected) end)
createSlider("Volume", 0, 100, 50, function(val) print("Slider:", val) end)

-- Public API (simple) to add new UI items at runtime
local Library = {}
Library.CreateParagraph = createParagraph
Library.CreateButton = createButton
Library.CreateToggle = createToggle
Library.CreateDropdown = createDropdown
Library.CreateMultiDropdown = createMultiDropdown
Library.CreateSlider = createSlider
Library.RunSearch = runSearchFilter

-- provide the library to the LocalPlayer (so you can call from other LocalScripts if needed)
-- (Optional) Attach to PlayerGui as a Module-like table
local holder = Instance.new("ModuleScript")
holder.Name = "LunarHubAPI"
holder.Source = "-- API placeholder created at runtime"
holder.Parent = PlayerGui

-- store API table in a reachable place (not standard practice but convenient in Studio)
-- Use _G only in local dev; safe here since it's LocalScript.
_G.LunarHubBF = Library

-- Inform user in output
print("[LunarHubBF] UI loaded. Use _G.LunarHubBF to add elements at runtime.")

-- Done
