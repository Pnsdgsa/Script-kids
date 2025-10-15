local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

if _G.LeaderboardButtonLoaded then
    return
end
_G.LeaderboardButtonLoaded = true

local function waitForBetaButton()
    local topBarApp = CoreGui:FindFirstChild("TopBarApp")
    if not topBarApp then
        repeat task.wait() until CoreGui:FindFirstChild("TopBarApp")
    end
    
    local topBarApp = CoreGui.TopBarApp
    local topBarAppInstance = topBarApp:FindFirstChild("TopBarApp")
    if not topBarAppInstance then
        repeat task.wait() until topBarApp:FindFirstChild("TopBarApp")
    end
    
    local unibarLeftFrame = topBarApp.TopBarApp:FindFirstChild("UnibarLeftFrame")
    if not unibarLeftFrame then
        repeat task.wait() until topBarApp.TopBarApp:FindFirstChild("UnibarLeftFrame")
    end
    
    local stackedElements = unibarLeftFrame:FindFirstChild("StackedElements")
    if not stackedElements then
        repeat task.wait() until unibarLeftFrame:FindFirstChild("StackedElements")
    end
    
    local betaButton = stackedElements:FindFirstChild("Button")
    if not betaButton then
        repeat task.wait() until stackedElements:FindFirstChild("Button")
    end
    
    return stackedElements, betaButton
end

local unibarLeftFrame, betaButton = waitForBetaButton()

if unibarLeftFrame:FindFirstChild("Leaderborad") then
    return
end

local leaderboardObj
local success, errorMessage = pcall(function()
    local LeaderboardModule = require(ReplicatedStorage.Modules.Client.Loader.CharacterController.UIController.Leaderboard)
    leaderboardObj = LeaderboardModule.new()
    leaderboardObj:Initialize()
end)

if not success then
    warn("Failed to load Leaderboard Module:", errorMessage)
    leaderboardObj = nil
end

local player = Players.LocalPlayer

local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local isHovering = false
local currentTween = nil
local hideDelay = 0.3

local Leaderborad = Instance.new("Frame")
local IconButton = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Menu = Instance.new("ScrollingFrame")
local MenuUIListLayout = Instance.new("UIListLayout")
local MenuGap = Instance.new("Frame")
local IconSpot = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local IconOverlay = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local ClickRegion = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local Contents = Instance.new("Frame")
local ContentsList = Instance.new("UIListLayout")
local PaddingLeft = Instance.new("Frame")
local PaddingCenter = Instance.new("Frame")
local PaddingRight = Instance.new("Frame")
local IconLabelContainer = Instance.new("Frame")
local IconLabel = Instance.new("TextLabel")
local IconImage = Instance.new("ImageLabel")
local IconImageCorner = Instance.new("UICorner")
local IconImageRatio = Instance.new("UIAspectRatioConstraint")
local IconSpotGradient = Instance.new("UIGradient")
local IconGradient = Instance.new("UIGradient")

local Spacer = Instance.new("Frame")
Spacer.Name = "LeaderboardSpacer"
Spacer.Size = UDim2.new(0, 9, 1, 0)
Spacer.BackgroundTransparency = 1

local betaButtonLayoutOrder = betaButton.LayoutOrder
Spacer.LayoutOrder = betaButtonLayoutOrder + 1
Spacer.Parent = unibarLeftFrame

Leaderborad.Name = "Leaderborad"
Leaderborad.Parent = unibarLeftFrame
Leaderborad.BackgroundTransparency = 1.000
Leaderborad.ClipsDescendants = true
Leaderborad.LayoutOrder = betaButtonLayoutOrder + 2  
Leaderborad.Size = UDim2.new(0, 44, 0, 44)
Leaderborad.ZIndex = 20

IconButton.Name = "IconButton"
IconButton.Parent = Leaderborad
IconButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IconButton.BackgroundTransparency = 0.300
IconButton.BorderSizePixel = 0
IconButton.ClipsDescendants = true
IconButton.Size = UDim2.new(1, 0, 1, 0)
IconButton.ZIndex = 2

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = IconButton

Menu.Name = "Menu"
Menu.Parent = IconButton
Menu.BackgroundTransparency = 1.000
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

MenuUIListLayout.Name = "MenuUIListLayout"
MenuUIListLayout.Parent = Menu
MenuUIListLayout.FillDirection = Enum.FillDirection.Horizontal
MenuUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
MenuUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

MenuGap.Name = "MenuGap"
MenuGap.Parent = Menu
MenuGap.AnchorPoint = Vector2.new(0, 0.5)
MenuGap.BackgroundTransparency = 1.000
MenuGap.Size = UDim2.new(0, 4, 0, 0)
MenuGap.Visible = false
MenuGap.ZIndex = 5

IconSpot.Name = "IconSpot"
IconSpot.Parent = Menu
IconSpot.AnchorPoint = Vector2.new(0, 0.5)
IconSpot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
IconSpot.BackgroundTransparency = 1.000
IconSpot.Position = UDim2.new(0, 4, 0.5, 0)
IconSpot.Size = UDim2.new(0, 36, 1, -8)
IconSpot.ZIndex = 5

UICorner_2.CornerRadius = UDim.new(1, 0)
UICorner_2.Parent = IconSpot

IconOverlay.Name = "IconOverlay"
IconOverlay.Parent = IconSpot
IconOverlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
IconOverlay.BackgroundTransparency = 0.925
IconOverlay.Size = UDim2.new(1, 0, 1, 0)
IconOverlay.Visible = false
IconOverlay.ZIndex = 6

UICorner_3.CornerRadius = UDim.new(1, 0)
UICorner_3.Parent = IconOverlay

ClickRegion.Name = "ClickRegion"
ClickRegion.Parent = IconSpot
ClickRegion.BackgroundTransparency = 1.000
ClickRegion.Size = UDim2.new(1, 0, 1, 0)
ClickRegion.ZIndex = 20
ClickRegion.Text = ""

UICorner_4.CornerRadius = UDim.new(1, 0)
UICorner_4.Parent = ClickRegion

Contents.Name = "Contents"
Contents.Parent = IconSpot
Contents.BackgroundTransparency = 1.000
Contents.Size = UDim2.new(1, 0, 1, 0)

ContentsList.Name = "ContentsList"
ContentsList.Parent = Contents
ContentsList.FillDirection = Enum.FillDirection.Horizontal
ContentsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
ContentsList.SortOrder = Enum.SortOrder.LayoutOrder
ContentsList.VerticalAlignment = Enum.VerticalAlignment.Center
ContentsList.Padding = UDim.new(0, 3)

PaddingLeft.Name = "PaddingLeft"
PaddingLeft.Parent = Contents
PaddingLeft.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PaddingLeft.BackgroundTransparency = 1.000
PaddingLeft.BorderColor3 = Color3.fromRGB(0, 0, 0)
PaddingLeft.BorderSizePixel = 0
PaddingLeft.LayoutOrder = 1
PaddingLeft.Size = UDim2.new(0, 9, 1, 0)
PaddingLeft.ZIndex = 5

PaddingCenter.Name = "PaddingCenter"
PaddingCenter.Parent = Contents
PaddingCenter.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PaddingCenter.BackgroundTransparency = 1.000
PaddingCenter.BorderColor3 = Color3.fromRGB(0, 0, 0)
PaddingCenter.BorderSizePixel = 0
PaddingCenter.LayoutOrder = 3
PaddingCenter.Size = UDim2.new(0, 0, 1, 0)
PaddingCenter.ZIndex = 5

PaddingRight.Name = "PaddingRight"
PaddingRight.Parent = Contents
PaddingRight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PaddingRight.BackgroundTransparency = 1.000
PaddingRight.BorderColor3 = Color3.fromRGB(0, 0, 0)
PaddingRight.BorderSizePixel = 0
PaddingRight.LayoutOrder = 5
PaddingRight.Size = UDim2.new(0, 11, 1, 0)
PaddingRight.ZIndex = 5

IconLabelContainer.Name = "IconLabelContainer"
IconLabelContainer.Parent = Contents
IconLabelContainer.AnchorPoint = Vector2.new(0, 0.5)
IconLabelContainer.BackgroundTransparency = 1.000
IconLabelContainer.LayoutOrder = 4
IconLabelContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
IconLabelContainer.Size = UDim2.new(0, 0, 1, 0)
IconLabelContainer.Visible = false
IconLabelContainer.ZIndex = 3

IconLabel.Name = "IconLabel"
IconLabel.Parent = IconLabelContainer
IconLabel.BackgroundTransparency = 1.000
IconLabel.LayoutOrder = 4
IconLabel.Size = UDim2.new(0, 1306, 1, 0)
IconLabel.ZIndex = 15
IconLabel.Font = Enum.Font.GothamMedium
IconLabel.Text = "Leaderboard"
IconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
IconLabel.TextSize = 16.000
IconLabel.TextWrapped = true
IconLabel.TextXAlignment = Enum.TextXAlignment.Left
IconLabel.Visible = false

IconImage.Name = "IconImage"
IconImage.Parent = Contents
IconImage.AnchorPoint = Vector2.new(0, 0.5)
IconImage.BackgroundTransparency = 1.000
IconImage.LayoutOrder = 2
IconImage.Position = UDim2.new(0, 11, 0.5, 0)
IconImage.Size = UDim2.new(0.7, 0, 0.7, 0)
IconImage.ZIndex = 15
IconImage.Image = "rbxassetid://5107166345" 

IconImageCorner.CornerRadius = UDim.new(0, 0)
IconImageCorner.Name = "IconImageCorner"
IconImageCorner.Parent = IconImage

IconImageRatio.Name = "IconImageRatio"
IconImageRatio.Parent = IconImage
IconImageRatio.DominantAxis = Enum.DominantAxis.Height

IconSpotGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(96, 98, 100)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(77, 78, 80))}
IconSpotGradient.Rotation = 45
IconSpotGradient.Name = "IconSpotGradient"
IconSpotGradient.Parent = IconSpot

IconGradient.Name = "IconGradient"
IconGradient.Parent = IconButton

local smallButtonSize = UDim2.new(0, 43, 0, 43)
local largeButtonSize = UDim2.new(0, 143, 0, 44)
local smallIconSpotSize = UDim2.new(0, 36, 1, -8)
local largeIconSpotSize = UDim2.new(0, 135, 1, -8)
local smallLabelSize = UDim2.new(0, 0, 1, 0)
local largeLabelSize = UDim2.new(0, 88, 1, 0)

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
    
    currentTween = TweenService:Create(Leaderborad, tweenInfo, {Size = largeButtonSize})
    currentTween:Play()
    
    TweenService:Create(IconSpot, tweenInfo, {Size = largeIconSpotSize}):Play()
    TweenService:Create(IconLabelContainer, tweenInfo, {Size = largeLabelSize}):Play()
end

local function contract()
    isHovering = false
    
    if currentTween then
        currentTween:Cancel()
    end
    
    currentTween = TweenService:Create(Leaderborad, tweenInfo, {Size = smallButtonSize})
    currentTween:Play()
    
    TweenService:Create(IconSpot, tweenInfo, {Size = smallIconSpotSize}):Play()
    TweenService:Create(IconLabelContainer, tweenInfo, {Size = smallLabelSize}):Play()
    
    hideTextWithDelay()
end

ClickRegion.MouseEnter:Connect(function()
    expand()
end)

ClickRegion.MouseLeave:Connect(function()
    contract()
end)

ClickRegion.MouseButton1Click:Connect(function()
    local isPC = not UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled
    
    if isPC then
        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Tab, false, game)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Tab, false, game)
    else
        if leaderboardObj then
            local success, result = pcall(function()
                leaderboardObj:KeyUsed("Leaderboard", true, {Key = "Leaderboard", Down = true})
            end)
            
            if not success then
                warn("Failed to trigger leaderboard:", result)
            end
        else
            warn("Leaderboard module not loaded")
        end
    end
end)

player.CharacterAdded:Connect(function()
    task.wait(0.1)
    isHovering = false
    if currentTween then
        currentTween:Cancel()
        currentTween = nil
    end
    
    Leaderborad.Size = smallButtonSize
    IconSpot.Size = smallIconSpotSize
    IconLabelContainer.Size = smallLabelSize
    IconLabel.Visible = false
    IconLabelContainer.Visible = false
    IconOverlay.Visible = false
end)

player.AncestryChanged:Connect(function()
    if not player.Parent then
        _G.LeaderboardButtonLoaded = nil
        if Leaderborad then
            Leaderborad:Destroy()
        end
        if Spacer then
            Spacer:Destroy()
        end
    end
end)

return Leaderborad
