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

-- Rounded corners
local uicorner = Instance.new("UICorner", window)
uicorner.CornerRadius = UDim.new(0, 6)

-- Topbar
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

-- Control buttons
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

-- Main content frames
local contentFrame = Instance.new("Frame", window)
contentFrame.Size = UDim2.new(1, 0, 1, -46)
contentFrame.Position = UDim2.new(0, 0, 0, 46)
contentFrame.BackgroundTransparency = 1

-- Sidebar (tab width fixed to 160)
local sidebar = Instance.new("Frame", contentFrame)
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 160, 1, 0) -- <-- fixed tab width
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

-- Function to create sidebar tab
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

-- Content panel
local contentPanel = Instance.new("Frame", contentFrame)
contentPanel.Name = "ContentPanel"
contentPanel.Size = UDim2.new(1, -160, 1, 0) -- <-- matches sidebar width
contentPanel.Position = UDim2.new(0,160,0,0)
contentPanel.BackgroundColor3 = Color3.fromRGB(22,22,22)
contentPanel.BorderSizePixel = 0

local contentCorner = Instance.new("UICorner", contentPanel)
contentCorner.CornerRadius = UDim.new(0,6)

-- Inside content: header + scroll area
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

-- Auto canvas size update
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

-- Dragging window improvement
local dragging = false
local dragStart = Vector2.zero
local startPos = window.Position

topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = window.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Minimize & Close
local minimized = false
btnMin.MouseButton1Click:Connect(function()
    minimized = not minimized
    contentFrame.Visible = not minimized
    window.Size = minimized and UDim2.fromOffset(window.Size.X.Offset, 46) or UDim2.fromOffset(window.Size.X.Offset, 520)
end)
btnClose.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Default tab
createTab("Main")
tabs.Main.MouseButton1Click:Connect(function()
    contentHeader.Text = "Section"
end)

-- Add default elements
createParagraph("Paragraph", "Description")
createButton("Example Button 1", function() print("Button 1 clicked") end)
createButton("Hello Button 2", function() print("Button 2 clicked") end)

-- Public API
local Library = {}
Library.CreateParagraph = createParagraph
Library.CreateButton = createButton
Library.RunSearch = function(query)
    query = tostring(query or ""):lower()
    for _, v in ipairs(ELEMENTS.Buttons) do
        local name = tostring(v.Name or v.Button.Text or ""):lower()
        v.Instance.Visible = name:find(query) ~= nil
    end
end

-- Provide the library
local holder = Instance.new("ModuleScript")
holder.Name = "LunarHubAPI"
holder.Source = "-- API placeholder created at runtime"
holder.Parent = PlayerGui
_G.LunarHubBF = Library

print("[LunarHubBF] UI loaded. Use _G.LunarHubBF to add elements at runtime.")
