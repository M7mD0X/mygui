local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")

-- Get Game Name (Place Name)
local gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name

-- Create UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local TabHolder = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local HideButton = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")

-- Main UI
MainFrame.Size = UDim2.new(0, 400, 0, 320)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Title Label (Above TabHolder)
TitleLabel.Size = UDim2.new(1, 0, 0, 25)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 16
TitleLabel.Text = gameName .. " - H"
TitleLabel.Parent = MainFrame

-- Tab Holder (Top Bar, Scrollable)
TabHolder.Size = UDim2.new(1, 0, 0, 40)
TabHolder.Position = UDim2.new(0, 0, 0, 25)
TabHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TabHolder.ScrollBarThickness = 5
TabHolder.ScrollingDirection = Enum.ScrollingDirection.X
TabHolder.AutomaticCanvasSize = Enum.AutomaticSize.X
TabHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
TabHolder.Parent = MainFrame

UIListLayout.Parent = TabHolder
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Hide/Show Button
HideButton.Size = UDim2.new(0, 100, 0, 30)
HideButton.Position = UDim2.new(0, 10, 0, 10)
HideButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
HideButton.TextColor3 = Color3.fromRGB(255, 0, 0)
HideButton.Text = "Hide GUI"
HideButton.Parent = ScreenGui

local guiVisible = true
HideButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    MainFrame.Visible = guiVisible
    HideButton.Text = guiVisible and "Hide GUI" or "Show GUI"
end)

-- Tabs & Pages
local Tabs = {}
local Pages = {}

local function CreateTab(name)
    local TabButton = Instance.new("TextButton")
    local Page = Instance.new("ScrollingFrame")

    TabButton.Size = UDim2.new(0, 100, 1, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    TabButton.Text = name
    TabButton.Parent = TabHolder

    -- Create Scrollable Frame for the Page
    Page.Size = UDim2.new(1, 0, 1, -65)
    Page.Position = UDim2.new(0, 0, 0, 65)
    Page.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Page.ScrollBarThickness = 5
    Page.ScrollingDirection = Enum.ScrollingDirection.Y
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.Parent = MainFrame

    table.insert(Tabs, TabButton)
    table.insert(Pages, Page)

    TabButton.MouseButton1Click:Connect(function()
        for _, page in pairs(Pages) do
            page.Visible = false
        end
        Page.Visible = true
    end)

    return Page
end

-- Function to Create a Button (For Any Tab)
local function CreateButton(parent, text, callback)
    local Button = Instance.new("TextButton")

    Button.Size = UDim2.new(1, 0, 0, 40) -- Full width, 40 height
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.TextColor3 = Color3.fromRGB(255, 0, 0)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 18
    Button.Text = text
    Button.Parent = parent

    Button.MouseButton1Click:Connect(function()
        callback() -- Runs the function when clicked
    end)

    return Button
end

-- Add Layout to All Tabs Automatically
for _, page in pairs(Pages) do
    local layout = Instance.new("UIListLayout")
    layout.Parent = page
    layout.Padding = UDim.new(0, 5)
end

-- Create Tabs
local tab1 = CreateTab("Tab 1")
local tab2 = CreateTab("Tab 2")
local tab3 = CreateTab("Tab 3")
local tab4 = CreateTab("Tab 4")
local settingsTab = CreateTab("Settings")

-- Show first tab by default
Pages[1].Visible = true

-- Now You Can Easily Add Buttons to Any Tab!
CreateButton(Pages[1], "Tab 1 1Button", function()
    print("Tab 1 1Button clicked!")
end)

CreateButton(Pages[1], "Tab 1 2Button", function()
    print("Tab 1 2Button clicked!")
end)

CreateButton(Pages[1], "Tab 1 3Button", function()
    print("Tab 1 3Button clicked!")
end)

CreateButton(Pages[1], "Tab 1 4Button", function()
    print("Tab 1 4Button clicked!")
end)

CreateButton(Pages[1], "Tab 1 5Button", function()
    print("Tab 1 5Button clicked!")
end)

CreateButton(Pages[1], "Tab 1 6Button", function()
    print("Tab 1 6Button clicked!")
end)

CreateButton(Pages[1], "Tab 1 7Button", function()
    print("Tab 1 7Button clicked!")
end)

CreateButton(Pages[1], "Tab 1 8Button", function()
    print("Tab 1 8Button clicked!")
end)

CreateButton(Pages[2], "Tab 2 Action", function()
    print("Tab 2 Button clicked!")
end)

CreateButton(Pages[3], "Tab 3 Feature", function()
    print("Tab 3 Button clicked!")
end)

CreateButton(Pages[4], "Tab 4 Stuff", function()
    print("Tab 4 Button clicked!")
end)

-- Add Buttons to the Settings Tab
CreateButton(Pages[5], "Close GUI", function()
    ScreenGui.Enabled = false
end)

-- Drag System (Supports **MOBILE** & PC)
local isDragging = false
local dragStart, startPos

local function StartDrag(input)
    isDragging = true
    dragStart = input.Position
    startPos = MainFrame.Position
end

local function UpdateDrag(input)
    if isDragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
    end
end

local function StopDrag()
    isDragging = false
end

-- Support for **MOBILE Touch**
TitleLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        StartDrag(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        UpdateDrag(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        StopDrag()
    end
end)
