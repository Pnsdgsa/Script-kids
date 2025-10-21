local player = game.Players.LocalPlayer
local guiService = game:GetService("GuiService")
local starterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Hide the default Roblox topbar (optional, comment out if topbar is needed)
starterGui:SetCore("TopbarEnabled", false)

-- Check for existing CustomTopGui and Frame
local screenGui = player.PlayerGui:FindFirstChild("CustomTopGui")
if not screenGui then
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CustomTopGui"
    screenGui.IgnoreGuiInset = false
    screenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
    screenGui.DisplayOrder = 100
    screenGui.Parent = player:WaitForChild("PlayerGui")
end

local frame = screenGui:FindFirstChild("Frame")
if not frame then
    frame = Instance.new("Frame")
    frame.Parent = screenGui
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.Size = UDim2.new(1, 0, 1, -2)
end

local scrollingFrame = frame:FindFirstChild("Right")
if not scrollingFrame then
    scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Name = "Right"
    scrollingFrame.Parent = frame
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.Position = UDim2.new(0, 12, 0, 0)
    scrollingFrame.Size = UDim2.new(1, -24, 1, 0)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
    scrollingFrame.ScrollBarThickness = 0
    scrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
    scrollingFrame.ScrollingEnabled = false

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Parent = scrollingFrame
    uiListLayout.Padding = UDim.new(0, 12)
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.FillDirection = Enum.FillDirection.Horizontal
    uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
else
    -- Clear existing children in ScrollingFrame
    for _, child in ipairs(scrollingFrame:GetChildren()) do
        if child:IsA("GuiObject") and child ~= scrollingFrame:FindFirstChildOfClass("UIListLayout") then
            child:Destroy()
        end
    end
end

-- Secondary button implementation
if _G.SecondaryButtonLoaded then
    return
end
_G.SecondaryButtonLoaded = true

local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local isHovering = false
local currentTween = nil
local hideDelay = 0.3

local Secondary = Instance.new("Frame")
Secondary.Name = "Secondary"
Secondary.Parent = scrollingFrame
Secondary.BackgroundTransparency = 1
Secondary.ClipsDescendants = true
Secondary.LayoutOrder = 1
Secondary.Size = UDim2.new(0, 44, 0, 44)
Secondary.ZIndex = 20

local IconButton = Instance.new("Frame")
IconButton.Name = "IconButton"
IconButton.Parent = Secondary
IconButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IconButton.BackgroundTransparency = 0.3
IconButton.BorderSizePixel = 0
IconButton.ClipsDescendants = true
IconButton.Size = UDim2.new(1, 0, 1, 0)
IconButton.ZIndex = 2

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = IconButton

local Menu = Instance.new("ScrollingFrame")
Menu.Name = "Menu"
Menu.Parent = IconButton
Menu.BackgroundTransparency = 1
Menu.BorderSizePixel = 0
Menu.Position = UDim2.new(0, 4, 0, 0)
Menu.Selectable = false
Menu.Size = UDim2.new(1, 0, 1, 0)
Menu.ZIndex = 20
Menu.BottomImage = ""
Menu.CanvasSize = UDim2.new(0, 0, 1, -1)
Menu.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
Menu.ScrollBarThickness = 3
Menu.TopImage = ""

local MenuUIListLayout = Instance.new("UIListLayout")
MenuUIListLayout.Name = "MenuUIListLayout"
MenuUIListLayout.Parent = Menu
MenuUIListLayout.FillDirection = Enum.FillDirection.Horizontal
MenuUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
MenuUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

local MenuGap = Instance.new("Frame")
MenuGap.Name = "MenuGap"
MenuGap.Parent = Menu
MenuGap.AnchorPoint = Vector2.new(0, 0.5)
MenuGap.BackgroundTransparency = 1
MenuGap.Size = UDim2.new(0, 4, 0, 0)
MenuGap.Visible = false
MenuGap.ZIndex = 5

local IconSpot = Instance.new("Frame")
IconSpot.Name = "IconSpot"
IconSpot.Parent = Menu
IconSpot.AnchorPoint = Vector2.new(0, 0.5)
IconSpot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
IconSpot.BackgroundTransparency = 1
IconSpot.Position = UDim2.new(0, 4, 0.5, 0)
IconSpot.Size = UDim2.new(0, 36, 1, -8)
IconSpot.ZIndex = 5

local UICorner_2 = Instance.new("UICorner")
UICorner_2.CornerRadius = UDim.new(1, 0)
UICorner_2.Parent = IconSpot

local IconOverlay = Instance.new("Frame")
IconOverlay.Name = "IconOverlay"
IconOverlay.Parent = IconSpot
IconOverlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
IconOverlay.BackgroundTransparency = 0.925
IconOverlay.Size = UDim2.new(1, 0, 1, 0)
IconOverlay.Visible = false
IconOverlay.ZIndex = 6

local UICorner_3 = Instance.new("UICorner")
UICorner_3.CornerRadius = UDim.new(1, 0)
UICorner_3.Parent = IconOverlay

local ClickRegion = Instance.new("TextButton")
ClickRegion.Name = "ClickRegion"
ClickRegion.Parent = IconSpot
ClickRegion.BackgroundTransparency = 1
ClickRegion.Size = UDim2.new(1, 0, 1, 0)
ClickRegion.ZIndex = 20
ClickRegion.Text = ""

local UICorner_4 = Instance.new("UICorner")
UICorner_4.CornerRadius = UDim.new(1, 0)
UICorner_4.Parent = ClickRegion

local Contents = Instance.new("Frame")
Contents.Name = "Contents"
Contents.Parent = IconSpot
Contents.BackgroundTransparency = 1
Contents.Size = UDim2.new(1, 0, 1, 0)

local ContentsList = Instance.new("UIListLayout")
ContentsList.Name = "ContentsList"
ContentsList.Parent = Contents
ContentsList.FillDirection = Enum.FillDirection.Horizontal
ContentsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
ContentsList.SortOrder = Enum.SortOrder.LayoutOrder
ContentsList.VerticalAlignment = Enum.VerticalAlignment.Center
ContentsList.Padding = UDim.new(0, 3)

local PaddingLeft = Instance.new("Frame")
PaddingLeft.Name = "PaddingLeft"
PaddingLeft.Parent = Contents
PaddingLeft.BackgroundTransparency = 1
PaddingLeft.LayoutOrder = 1
PaddingLeft.Size = UDim2.new(0, 9, 1, 0)
PaddingLeft.ZIndex = 5

local PaddingCenter = Instance.new("Frame")
PaddingCenter.Name = "PaddingCenter"
PaddingCenter.Parent = Contents
PaddingCenter.BackgroundTransparency = 1
PaddingCenter.LayoutOrder = 3
PaddingCenter.Size = UDim2.new(0, 0, 1, 0)
PaddingCenter.ZIndex = 5

local PaddingRight = Instance.new("Frame")
PaddingRight.Name = "PaddingRight"
PaddingRight.Parent = Contents
PaddingRight.BackgroundTransparency = 1
PaddingRight.LayoutOrder = 5
PaddingRight.Size = UDim2.new(0, 11, 1, 0)
PaddingRight.ZIndex = 5

local IconLabelContainer = Instance.new("Frame")
IconLabelContainer.Name = "IconLabelContainer"
IconLabelContainer.Parent = Contents
IconLabelContainer.AnchorPoint = Vector2.new(0, 0.5)
IconLabelContainer.BackgroundTransparency = 1
IconLabelContainer.LayoutOrder = 4
IconLabelContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
IconLabelContainer.Size = UDim2.new(0, 0, 1, 0)
IconLabelContainer.Visible = false
IconLabelContainer.ZIndex = 3

local IconLabel = Instance.new("TextLabel")
IconLabel.Name = "IconLabel"
IconLabel.Parent = IconLabelContainer
IconLabel.BackgroundTransparency = 1
IconLabel.LayoutOrder = 4
IconLabel.Size = UDim2.new(0, 45, 1, 0)
IconLabel.ZIndex = 15
IconLabel.Font = Enum.Font.GothamMedium
IconLabel.Text = "Zoom"
IconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
IconLabel.TextSize = 16
IconLabel.TextWrapped = true
IconLabel.TextXAlignment = Enum.TextXAlignment.Left
IconLabel.Visible = false

local IconImage = Instance.new("ImageLabel")
IconImage.Name = "IconImage"
IconImage.Parent = Contents
IconImage.AnchorPoint = Vector2.new(0, 0.5)
IconImage.BackgroundTransparency = 1
IconImage.LayoutOrder = 2
IconImage.Position = UDim2.new(0, 11, 0.5, 0)
IconImage.Size = UDim2.new(0.7, 0, 0.7, 0)
IconImage.ZIndex = 15
IconImage.Image = "rbxassetid://126943351764139"

local IconImageCorner = Instance.new("UICorner")
IconImageCorner.Name = "IconImageCorner"
IconImageCorner.CornerRadius = UDim.new(0, 0)
IconImageCorner.Parent = IconImage

local IconImageRatio = Instance.new("UIAspectRatioConstraint")
IconImageRatio.Name = "IconImageRatio"
IconImageRatio.Parent = IconImage
IconImageRatio.DominantAxis = Enum.DominantAxis.Height

local IconSpotGradient = Instance.new("UIGradient")
IconSpotGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(96, 98, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(77, 78, 80))}
IconSpotGradient.Rotation = 45
IconSpotGradient.Name = "IconSpotGradient"
IconSpotGradient.Parent = IconSpot

local IconGradient = Instance.new("UIGradient")
IconGradient.Name = "IconGradient"
IconGradient.Parent = IconButton

local smallButtonSize = UDim2.new(0, 44, 0, 44)
local largeButtonSize = UDim2.new(0, 100, 0, 44)
local smallIconSpotSize = UDim2.new(0, 36, 1, -8)
local largeIconSpotSize = UDim2.new(0, 92, 1, -8)
local smallLabelSize = UDim2.new(0, 0, 1, 0)
local largeLabelSize = UDim2.new(0, 45, 1, 0)

local function hideTextWithDelay()
    task.wait(hideDelay)
    if not isHovering then
        IconLabel.Visible = false
        IconLabelContainer.Visible = false
        IconOverlay.Visible = false
    end
end

local function expand()
    isHovering = true
    if currentTween then
        currentTween:Cancel()
    end
    IconLabel.Visible = true
    IconLabelContainer.Visible = true
    IconOverlay.Visible = true
    currentTween = TweenService:Create(Secondary, tweenInfo, {Size = largeButtonSize})
    currentTween:Play()
    TweenService:Create(IconSpot, tweenInfo, {Size = largeIconSpotSize}):Play()
    TweenService:Create(IconLabelContainer, tweenInfo, {Size = largeLabelSize}):Play()
end

local function contract()
    isHovering = false
    if currentTween then
        currentTween:Cancel()
    end
    currentTween = TweenService:Create(Secondary, tweenInfo, {Size = smallButtonSize})
    currentTween:Play()
    TweenService:Create(IconSpot, tweenInfo, {Size = smallIconSpotSize}):Play()
    TweenService:Create(IconLabelContainer, tweenInfo, {Size = smallLabelSize}):Play()
    hideTextWithDelay()
end

ClickRegion.MouseEnter:Connect(expand)
ClickRegion.MouseLeave:Connect(contract)

ClickRegion.MouseButton1Down:Connect(function()
    local ohTable1 = {
        ["Key"] = "Secondary",
        ["Down"] = true
    }
    player.PlayerScripts.Events.temporary_events.UseKeybind:Fire(ohTable1)
end)

ClickRegion.MouseButton1Up:Connect(function()
    local ohTable1 = {
        ["Key"] = "Secondary",
        ["Down"] = false
    }
    player.PlayerScripts.Events.temporary_events.UseKeybind:Fire(ohTable1)
end)

ClickRegion.MouseLeave:Connect(function()
    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        local ohTable1 = {
            ["Key"] = "Secondary",
            ["Down"] = false
        }
        player.PlayerScripts.Events.temporary_events.UseKeybind:Fire(ohTable1)
    end
end)

player.CharacterAdded:Connect(function()
    task.wait(0.1)
    isHovering = false
    if currentTween then
        currentTween:Cancel()
        currentTween = nil
    end
    Secondary.Size = smallButtonSize
    IconSpot.Size = smallIconSpotSize
    IconLabelContainer.Size = smallLabelSize
    IconLabel.Visible = false
    IconLabelContainer.Visible = false
    IconOverlay.Visible = false
end)

player.AncestryChanged:Connect(function()
    if not player.Parent then
        _G.SecondaryButtonLoaded = nil
        if Secondary then
            Secondary:Destroy()
        end
    end
end)

-- Debug: Verify positions and sizes
print("ScreenGui Size:", screenGui.AbsoluteSize)
print("Frame Position:", frame.AbsolutePosition, "Size:", frame.AbsoluteSize)
print("ScrollingFrame Position:", scrollingFrame.AbsolutePosition, "Size:", scrollingFrame.AbsoluteSize)
print("Secondary Button Size:", Secondary.AbsoluteSize)
