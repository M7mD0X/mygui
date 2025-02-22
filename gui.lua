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
    local Page = Instance.new("Frame")

    TabButton.Size = UDim2.new(0, 100, 1, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    TabButton.Text = name
    TabButton.Parent = TabHolder

    Page.Size = UDim2.new(1, 0, 1, -65)
    Page.Position = UDim2.new(0, 0, 0, 65)
    Page.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Page.Visible = false
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

-- Create Tabs
local tab1 = CreateTab("Tab 1")
local tab2 = CreateTab("Tab 2")
local tab3 = CreateTab("Tab 3")
local tab4 = CreateTab("Tab 4")
local settingsTab = CreateTab("Settings")

-- Show first tab by default
Pages[1].Visible = true

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
