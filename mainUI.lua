-- CoolUI Library (single LocalScript)
-- Place this in StarterPlayerScripts or StarterGui (as a LocalScript)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- THEME: change these to brand your UI
local THEME = {
    Main = Color3.fromRGB(20, 20, 35),
    Accent = Color3.fromRGB(72, 126, 199),
    Light = Color3.fromRGB(230, 230, 240),
    Dark = Color3.fromRGB(15, 15, 25),
    Corner = UDim.new(0, 10),
    Font = Enum.Font.Gotham
}

-- UTILS
local function make(cls, props)
    local obj = Instance.new(cls)
    if props then
        for k, v in pairs(props) do obj[k] = v end
    end
    return obj
end

local function tween(obj, props, time, style, direction)
    local info = TweenInfo.new(time or 0.25, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out)
    TweenService:Create(obj, info, props):Play()
end

-- Create main ScreenGui
local screenGui = make("ScreenGui", {Name = "Lunar Hub", Parent = playerGui, ResetOnSpawn = false})
screenGui.DisplayOrder = 999

-- Main Window
local window = make("Frame", {
    Name = "Window",
    Parent = screenGui,
    Size = UDim2.new(0, 720, 0, 420),
    Position = UDim2.new(0.5, -360, 0.5, -210),
    BackgroundColor3 = THEME.Main,
    Active = true,
    ClipsDescendants = true
})
local uiCorner = make("UICorner", {CornerRadius = THEME.Corner, Parent = window})
local uiStroke = make("UIStroke", {Parent = window, Color = Color3.fromRGB(0,0,0), Thickness = 1, Transparency = 0.6})

-- Shadow (subtle) - simulated by an outer frame
local shadow = make("Frame", {
    Name = "Shadow", Parent = screenGui,
    Size = window.Size, Position = window.Position,
    BackgroundColor3 = Color3.new(0,0,0), BackgroundTransparency = 0.85,
    ZIndex = 0
})
make("UICorner", {CornerRadius = THEME.Corner, Parent = shadow})

-- Header (drag)
local header = make("Frame", {
    Name = "Header", Parent = window,
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = THEME.Dark
})
make("UICorner", {CornerRadius = THEME.Corner, Parent = header})
local title = make("TextLabel", {
    Parent = header, Text = "CoolUI Library",
    Size = UDim2.new(0.6, 0, 1, 0),
    Position = UDim2.new(0, 12, 0, 0),
    BackgroundTransparency = 1, TextColor3 = THEME.Light, Font = THEME.Font, TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left
})
local closeBtn = make("TextButton", {
    Parent = header, Text = "✕", Size = UDim2.new(0, 36, 0, 28),
    Position = UDim2.new(1, -44, 0.5, -14), BackgroundColor3 = THEME.Dark, TextColor3 = THEME.Light, Font = THEME.Font, TextSize = 20
})
make("UICorner", {CornerRadius = UDim.new(0,8), Parent = closeBtn})

-- Left tabs list
local leftPanel = make("Frame", {
    Name = "Left", Parent = window,
    Size = UDim2.new(0, 180, 1, -48),
    Position = UDim2.new(0, 0, 0, 48),
    BackgroundColor3 = THEME.Dark
})
make("UICorner", {CornerRadius = UDim.new(0,8), Parent = leftPanel})
local tabsLayout = make("UIListLayout", {Parent = leftPanel, Padding = UDim.new(0,8), SortOrder = Enum.SortOrder.LayoutOrder})
tabsLayout.Padding = UDim.new(0,8)

local contentFrame = make("Frame", {
    Name = "Content", Parent = window,
    Size = UDim2.new(1, -190, 1, -58),
    Position = UDim2.new(0, 190, 0, 58),
    BackgroundColor3 = THEME.Main
})
make("UICorner", {CornerRadius = UDim.new(0,6), Parent = contentFrame})

-- Tabs -> each tab will have its own container inside contentFrame
local tabs = {}
local activeTab = nil

-- Basic Notification system
local notifContainer = make("Frame", {
    Name = "NotifContainer", Parent = screenGui, Size = UDim2.new(0, 300, 0, 100),
    Position = UDim2.new(1, -320, 0, 20), BackgroundTransparency = 1
})

local function notify(titleText, bodyText, duration)
    duration = duration or 3
    local card = make("Frame", {
        Parent = notifContainer, Size = UDim2.new(1, 0, 0, 72), BackgroundColor3 = THEME.Dark,
        Position = UDim2.new(0, 0, 0, 0)
    })
    make("UICorner", {Parent = card, CornerRadius = UDim.new(0,8)})
    local t = make("TextLabel", {Parent = card, Text = titleText, Size = UDim2.new(1, -12, 0, 26), Position = UDim2.new(0, 6, 0, 6), BackgroundTransparency = 1, TextColor3 = THEME.Light, Font = THEME.Font, TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left})
    local b = make("TextLabel", {Parent = card, Text = bodyText, Size = UDim2.new(1, -12, 0, 40), Position = UDim2.new(0, 6, 0, 28), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(200,200,210), Font = THEME.Font, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left})
    card.Position = UDim2.new(1, 20, 0, 0) -- offscreen
    tween(card, {Position = UDim2.new(0, 0, 0, 0)}, 0.35)
    delay(duration, function()
        tween(card, {Position = UDim2.new(1, 20, 0, 0)}, 0.35)
        wait(0.4)
        card:Destroy()
    end)
end

-- Dragging
do
    local dragging = false
    local dragStart, startPos
    header.InputBegan:Connect(function(input)
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
    header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            UserInputService.InputChanged:Connect(function() end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            shadow.Position = window.Position
        end
    end)
end

-- Close button
closeBtn.MouseButton1Click:Connect(function()
    tween(window, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.28)
    tween(shadow, {Size = UDim2.new(0, 0, 0, 0)}, 0.28)
    delay(0.28, function() screenGui:Destroy() end)
end)

-- Library API
local Library = {}

function Library:CreateTab(tabName)
    -- tab button
    local idx = #tabs + 1
    local btn = make("TextButton", {
        Parent = leftPanel, Text = tabName, Size = UDim2.new(1, -16, 0, 38), Position = UDim2.new(0, 8, 0, 8 * idx),
        BackgroundColor3 = THEME.Main, TextColor3 = THEME.Light, Font = THEME.Font, TextSize = 16
    })
    make("UICorner", {Parent = btn, CornerRadius = UDim.new(0,6)})
    -- container
    local container = make("Frame", {Parent = contentFrame, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = false})
    local layout = make("UIListLayout", {Parent = container, Padding = UDim.new(0,8)})
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local tab = {Name = tabName, Button = btn, Container = container}
    tabs[tabName] = tab

    btn.MouseButton1Click:Connect(function()
        -- hide others
        for _, t in pairs(tabs) do
            if t.Container then t.Container.Visible = false end
            if t.Button then tween(t.Button, {BackgroundColor3 = THEME.Main}, 0.18) end
        end
        container.Visible = true
        tween(btn, {BackgroundColor3 = THEME.Accent}, 0.18)
        activeTab = tab
    end)

    -- auto-activate first tab
    if not activeTab then
        btn:CaptureFocus()
        btn.MouseButton1Click:Wait() -- trigger to ensure style, but safe
        btn:ReleaseFocus()
        -- manual activation:
        for _, t in pairs(tabs) do if t.Container then t.Container.Visible = false end end
        container.Visible = true
        tween(btn, {BackgroundColor3 = THEME.Accent}, 0.18)
        activeTab = tab
    end

    -- Methods for section and elements
    function tab:CreateSection(sectionName)
        local section = make("Frame", {Parent = container, Size = UDim2.new(1, -16, 0, 120), BackgroundColor3 = THEME.Dark})
        section.Position = UDim2.new(0, 8, 0, 0)
        make("UICorner", {Parent = section, CornerRadius = UDim.new(0,6)})
        local header = make("TextLabel", {Parent = section, Text = sectionName, Size = UDim2.new(1, -12, 0, 30), Position = UDim2.new(0,6,0,6), BackgroundTransparency = 1, TextColor3 = THEME.Light, Font = THEME.Font, TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left})
        local content = make("Frame", {Parent = section, Size = UDim2.new(1, -12, 1, -48), Position = UDim2.new(0,6,0,36), BackgroundTransparency = 1})
        local contentLayout = make("UIListLayout", {Parent = content, Padding = UDim.new(0,8), SortOrder = Enum.SortOrder.LayoutOrder})
        contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left

        local sectionAPI = {}

        -- Button
        function sectionAPI:AddButton(text, callback)
            local btn = make("TextButton", {Parent = content, Text = text, Size = UDim2.new(1, -4, 0, 36), BackgroundColor3 = THEME.Main, TextColor3 = THEME.Light, Font = THEME.Font, TextSize = 16})
            make("UICorner", {Parent = btn, CornerRadius = UDim.new(0,6)})
            btn.MouseButton1Click:Connect(function()
                tween(btn, {BackgroundColor3 = THEME.Accent}, 0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                wait(0.09)
                tween(btn, {BackgroundColor3 = THEME.Main}, 0.12)
                if type(callback) == "function" then
                    callback()
                end
            end)
            return btn
        end

        -- Toggle
        function sectionAPI:AddToggle(text, default, callback)
            local frame = make("Frame", {Parent = content, Size = UDim2.new(1, -4, 0, 36), BackgroundTransparency = 1})
            local label = make("TextLabel", {Parent = frame, Text = text, Position = UDim2.new(0, 6, 0, 6), Size = UDim2.new(0.7, 0, 1, 0), BackgroundTransparency = 1, TextColor3 = THEME.Light, Font = THEME.Font, TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left})
            local toggle = make("TextButton", {Parent = frame, Text = "", Position = UDim2.new(1, -52, 0.5, -12), Size = UDim2.new(0, 40, 0, 24), BackgroundColor3 = THEME.Main})
            make("UICorner", {Parent = toggle, CornerRadius = UDim.new(0,12)})
            local fill = make("Frame", {Parent = toggle, Size = UDim2.new(default and 0.5 or 0, 0, 1, 0), BackgroundColor3 = THEME.Accent, Position = UDim2.new(0, 0, 0, 0)})
            local dot = make("Frame", {Parent = toggle, Size = UDim2.new(0, 0, 1, 0), BackgroundTransparency = 1})
            make("UICorner", {Parent = fill, CornerRadius = UDim.new(0,12)})

            local state = default or false
            local function setState(s)
                state = s
                if state then
                    tween(fill, {Size = UDim2.new(0.5, 0, 1, 0)}, 0.18)
                else
                    tween(fill, {Size = UDim2.new(0, 0, 1, 0)}, 0.18)
                end
                if type(callback) == "function" then callback(state) end
            end
            toggle.MouseButton1Click:Connect(function() setState(not state) end)
            setState(state)
            return {
                Set = setState,
                Get = function() return state end,
                UI = frame
            }
        end

        -- Slider
        function sectionAPI:AddSlider(text, min, max, default, callback)
            min = min or 0; max = max or 100; default = default or min
            local frame = make("Frame", {Parent = content, Size = UDim2.new(1, -4, 0, 48), BackgroundTransparency = 1})
            local label = make("TextLabel", {Parent = frame, Text = text .. " ("..tostring(default)..")", Position = UDim2.new(0, 6, 0, 6), Size = UDim2.new(1, -12, 0, 22), BackgroundTransparency = 1, TextColor3 = THEME.Light, Font = THEME.Font, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left})
            local bar = make("Frame", {Parent = frame, Position = UDim2.new(0, 6, 0, 28), Size = UDim2.new(1, -12, 0, 10), BackgroundColor3 = THEME.Main})
            make("UICorner", {Parent = bar, CornerRadius = UDim.new(0,6)})
            local fill = make("Frame", {Parent = bar, Size = UDim2.new( (default-min)/(max-min), 0, 1, 0), BackgroundColor3 = THEME.Accent})
            make("UICorner", {Parent = fill, CornerRadius = UDim.new(0,6)})

            local dragging = false
            local function setValueFromPos(x)
                local rel = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                local val = min + rel * (max - min)
                fill.Size = UDim2.new(rel, 0, 1, 0)
                label.Text = text .. " ("..math.floor(val)..")"
                if type(callback) == "function" then callback(val) end
            end

            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    setValueFromPos(input.Position.X)
                end
            end)
            bar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    setValueFromPos(input.Position.X)
                end
            end)
            return {
                Set = function(v)
                    local rel = math.clamp((v-min)/(max-min), 0, 1)
                    fill.Size = UDim2.new(rel, 0, 1, 0)
                    label.Text = text .. " ("..math.floor(v)..")"
                    if type(callback) == "function" then callback(v) end
                end
            }
        end

        -- Dropdown
        function sectionAPI:AddDropdown(text, options, callback)
            options = options or {}
            local frame = make("Frame", {Parent = content, Size = UDim2.new(1, -4, 0, 36), BackgroundTransparency = 1})
            local label = make("TextLabel", {Parent = frame, Text = text, Position = UDim2.new(0, 6, 0, 6), Size = UDim2.new(0.6, 0, 1, 0), BackgroundTransparency = 1, TextColor3 = THEME.Light, Font = THEME.Font, TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left})
            local btn = make("TextButton", {Parent = frame, Text = "Select", Position = UDim2.new(1, -120, 0.5, -14), Size = UDim2.new(0, 110, 0, 28), BackgroundColor3 = THEME.Main})
            make("UICorner", {Parent = btn, CornerRadius = UDim.new(0,6)})
            local list = make("Frame", {Parent = frame, Size = UDim2.new(0, 160, 0, 0), Position = UDim2.new(1, -160, 1, 6), BackgroundColor3 = THEME.Dark, Visible = false})
            make("UICorner", {Parent = list, CornerRadius = UDim.new(0,6)})
            local listLayout = make("UIListLayout", {Parent = list, Padding = UDim.new(0,4)})
            listLayout.SortOrder = Enum.SortOrder.LayoutOrder

            local open = false
            btn.MouseButton1Click:Connect(function()
                open = not open
                list.Visible = open
                if open then
                    tween(list, {Size = UDim2.new(0, 160, 0, math.clamp(#options*32, 32, 240))}, 0.18)
                else
                    tween(list, {Size = UDim2.new(0, 160, 0, 0)}, 0.12)
                    delay(0.12, function() list.Visible = false end)
                end
            end)

            local function populate()
                list:ClearAllChildren()
                make("UIListLayout", {Parent = list, Padding = UDim.new(0,4)})
                for i, opt in ipairs(options) do
                    local oBtn = make("TextButton", {Parent = list, Text = tostring(opt), Size = UDim2.new(1, -8, 0, 28), BackgroundColor3 = THEME.Main})
                    make("UICorner", {Parent = oBtn, CornerRadius = UDim.new(0,6)})
                    oBtn.MouseButton1Click:Connect(function()
                        btn.Text = tostring(opt)
                        if type(callback) == "function" then callback(opt) end
                        open = false
                        tween(list, {Size = UDim2.new(0, 160, 0, 0)}, 0.12)
                        delay(0.12, function() list.Visible = false end)
                    end)
                end
            end
            populate()
            return {
                SetOptions = function(newOptions)
                    options = newOptions
                    populate()
                end
            }
        end

        -- Textbox
        function sectionAPI:AddTextbox(placeholder, default, callback)
            default = default or ""
            local box = make("TextBox", {Parent = content, Text = default, PlaceholderText = placeholder or "", Size = UDim2.new(1, -4, 0, 36), BackgroundColor3 = THEME.Main, TextColor3 = THEME.Light, Font = THEME.Font, TextSize = 16})
            make("UICorner", {Parent = box, CornerRadius = UDim.new(0,6)})
            box.FocusLost:Connect(function(enterPressed)
                if type(callback) == "function" then callback(box.Text, enterPressed) end
            end)
            return box
        end

        return sectionAPI
    end

    return tab
end

-- Expose notify via library
Library.Notify = notify

-- Give library reference to global for easy access while developing
_G.CoolUI = Library

-- Small demo setup (auto-run to show usage)
do
    local tab = Library:CreateTab("Main")
    local section = tab:CreateSection("General")
    section:AddButton("Say Hello", function() notify("Hello!", "You pressed the Hello button.") end)
    local tgl = section:AddToggle("Enable Power", false, function(val) notify("Toggle", "Power: "..tostring(val)) end)
    local slider = section:AddSlider("Speed", 0, 100, 25, function(v) -- pretend set speed
        -- You can use v to set speed of something in your game
    end)
    local dd = section:AddDropdown("Choose Mode", {"Easy", "Normal", "Hard"}, function(sel) notify("Mode", "Selected: "..tostring(sel)) end)
    local tb = section:AddTextbox("Type here...", "", function(text)
        notify("Typed", text)
    end)

    -- Another tab
    local visuals = Library:CreateTab("Visuals")
    local sec2 = visuals:CreateSection("Effects")
    sec2:AddButton("Spawn Sparkles", function() notify("Sparkles", "Would spawn sparkles in-game!") end)
end

print("CoolUI loaded: _G.CoolUI available")
