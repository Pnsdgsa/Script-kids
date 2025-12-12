local player = game.Players.LocalPlayer
local guiService = game:GetService("GuiService")
local starterGui = game:GetService("StarterGui")

local playerGui = player:WaitForChild("PlayerGui")
if playerGui:FindFirstChild("CustomTopGui") then
    return
end

starterGui:SetCore("TopbarEnabled", false)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomTopGui"
screenGui.IgnoreGuiInset = false
screenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
screenGui.DisplayOrder = 100
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
frame.Position = UDim2.new(0, 0, 0, 0)
frame.Size = UDim2.new(1, 0, 1, -2)

local scrollingFrame = Instance.new("ScrollingFrame")
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
-- Create the popup screen gui directly in CoreGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DiscordGiveawayPopup"
screenGui.DisplayOrder = 999
screenGui.Parent = game:GetService("CoreGui")

-- Create the main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 200)
frame.Position = UDim2.new(0.5, -200, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Add corner rounding
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

-- Add shadow effect
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.7
shadow.ZIndex = -1
shadow.Parent = frame

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 8)
shadowCorner.Parent = shadow

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(88, 101, 242) -- Discord blue
title.Text = "MINECRAFT JAVA GIVEAWAY!"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = title

-- Message text
local message = Instance.new("TextLabel")
message.Size = UDim2.new(0.9, 0, 0, 80)
message.Position = UDim2.new(0.05, 0, 0.2, 0)
message.BackgroundTransparency = 1
message.Text = "I'm doing Minecraft java account giveaway in 1k member be sure join my discord server for better luck :)"
message.TextColor3 = Color3.fromRGB(255, 255, 255)
message.TextWrapped = true
message.TextScaled = true
message.Font = Enum.Font.Gotham
message.TextYAlignment = Enum.TextYAlignment.Top
message.Parent = frame

-- Discord link (smaller text)
local discordLink = Instance.new("TextLabel")
discordLink.Size = UDim2.new(0.9, 0, 0, 20)
discordLink.Position = UDim2.new(0.05, 0, 0.65, 0)
discordLink.BackgroundTransparency = 1
discordLink.Text = "https://discord.gg/ny6pJgnR6c"
discordLink.TextColor3 = Color3.fromRGB(114, 137, 218) -- Lighter discord blue
discordLink.TextScaled = true
discordLink.Font = Enum.Font.Gotham
discordLink.Parent = frame

-- Buttons container
local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(0.9, 0, 0, 40)
buttonContainer.Position = UDim2.new(0.05, 0, 0.8, 0)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = frame

-- "No thx bro" button
local noButton = Instance.new("TextButton")
noButton.Size = UDim2.new(0.48, 0, 1, 0)
noButton.Position = UDim2.new(0, 0, 0, 0)
noButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
noButton.Text = "No thx bro"
noButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noButton.Font = Enum.Font.Gotham
noButton.Parent = buttonContainer

local noCorner = Instance.new("UICorner")
noCorner.CornerRadius = UDim.new(0, 6)
noCorner.Parent = noButton

-- "YES COPY LINK" button
local yesButton = Instance.new("TextButton")
yesButton.Size = UDim2.new(0.48, 0, 1, 0)
yesButton.Position = UDim2.new(0.52, 0, 0, 0)
yesButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
yesButton.Text = "YES COPY LINK"
yesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
yesButton.Font = Enum.Font.GothamBold
yesButton.Parent = buttonContainer

local yesCorner = Instance.new("UICorner")
yesCorner.CornerRadius = UDim.new(0, 6)
yesCorner.Parent = yesButton

-- Button hover effects
noButton.MouseEnter:Connect(function()
	noButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
end)

noButton.MouseLeave:Connect(function()
	noButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)

yesButton.MouseEnter:Connect(function()
	yesButton.BackgroundColor3 = Color3.fromRGB(105, 115, 255)
end)

yesButton.MouseLeave:Connect(function()
	yesButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
end)

-- Button functionality
noButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

yesButton.MouseButton1Click:Connect(function()
	-- Copy link to clipboard
	local success = pcall(function()
		game:GetService("GuiService"):CopyToClipboard("https://discord.gg/ny6pJgnR6c")
	end)
	
	if success then
		yesButton.Text = "LINK COPIED!"
		yesButton.BackgroundColor3 = Color3.fromRGB(67, 181, 129) -- Green for success
		
		-- Reset button after 2 seconds
		wait(2)
		if yesButton and yesButton.Parent then
			yesButton.Text = "YES COPY LINK"
			yesButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
		end
	else
		yesButton.Text = "COPY FAILED!"
		yesButton.BackgroundColor3 = Color3.fromRGB(240, 71, 71) -- Red for error
		
		-- Reset button after 2 seconds
		wait(2)
		if yesButton and yesButton.Parent then
			yesButton.Text = "YES COPY LINK"
			yesButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
		end
	end
end)

-- Close button (X in corner)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(240, 71, 71)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Make the popup draggable
local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

title.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if dragging and input == dragInput then
		update(input)
	end
end)
