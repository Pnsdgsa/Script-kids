local PlaceScripts = {
    [10324346056] = { 
        name = "Big Team", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua" 
    },
    [9872472334] = { 
        name = "Evade", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua" 
    },
    [96537472072550] = { 
        name = "Legacy Evade", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/Evade%20Legacy/DaraHub-Evade-Legacy.lua" 
    },
    [10662542523] = { 
        name = "Casual", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua" 
    },
    [10324347967] = { 
        name = "Social Space", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua" 
    },
    [121271605799901] = { 
        name = "Player Nextbots", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua" 
    },
    [10808838353] = { 
        name = "VC Only", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua" 
    },
    [11353528705] = { 
        name = "Pro", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua" 
    },
    [99214917572799] = { 
        name = "Custom Servers", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua" 
    },
    [142823291] = { 
        name = "Murder Mystery 2", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/MM2/DaraHub-MM2.lua" 
    },
    [126884695634066] = { 
        name = "Grow-a-Garden-[NEW-PLAYERS]", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/Grow%20A%20Garden/DaraHub-Grow-A-Garden.lua" 
    },
    [124977557560410] = { 
        name = "Grow-a-Garden", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/Grow%20A%20Garden/DaraHub-Grow-A-Garden.lua" 
    }
}

local UniversalScript = {
    name = "Universal Script",
    url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/Universal/Darahub-Universal.lua"
}

local currentGameId = game.PlaceId
local selectedScript = PlaceScripts[currentGameId]

-- Function to safely load scripts
local function loadScript(url, scriptName)
    local success, result = pcall(function()
        local scriptContent = game:HttpGet(url, true)
        if scriptContent then
            return loadstring(scriptContent)()
        end
        return false
    end)
    
    if not success then
        warn("Failed to load " .. scriptName .. ": " .. tostring(result))
    end
    
    return success
end

-- Load appropriate script
if selectedScript then
    loadScript(selectedScript.url, selectedScript.name)
else
    loadScript(UniversalScript.url, UniversalScript.name)
end

-- Setup teleport queue
local queueonteleport = (syn and syn.queue_on_teleport) or queue_on_teleport

if queueonteleport then
    queueonteleport([[
        wait(1)
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/main-loader.lua'))()
    ]])
end
-- Check if popup should be shown based on saved preference
local DataHubPath = "DaraHub/"
local settingFileName = "disable_popup.txt"
local fullPath = DataHubPath .. settingFileName

-- Function to read file
local function readFile(path)
	local success, result = pcall(function()
		local file = readfile(path)
		return file
	end)
	return success and result or nil
end

-- Function to write file
local function writeFile(path, content)
	local success, errorMsg = pcall(function()
		writefile(path, content)
	end)
	return success
end

-- Check if DaraHub folder exists, create if not
local function ensureFolderExists()
	local folderPath = DataHubPath:gsub("/", "")
	local success, _ = pcall(function()
		if not isfolder(folderPath) then
			makefolder(folderPath)
		end
	end)
	return success
end

-- Check if popup should be shown
local function shouldShowPopup()
	-- First ensure folder exists
	if not ensureFolderExists() then
		return true -- Show popup if can't create folder
	end
	
	-- Try to read the setting file
	local content = readFile(fullPath)
	
	-- If file doesn't exist or contains "false", show popup
	if content == nil then
		return true
	end
	
	-- Check if file contains "true" (case-insensitive)
	local disablePopup = content:lower():gsub("%s+", "") == "true"
	
	return not disablePopup
end

-- If should not show popup, exit script
if not shouldShowPopup() then
	return
end

-- Create the popup screen gui directly in CoreGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ExecutorWarningPopup"
screenGui.DisplayOrder = 999
screenGui.Parent = game:GetService("CoreGui")

-- Create the main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 450, 0, 250)
frame.Position = UDim2.new(0.5, -225, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Add corner rounding
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Add shadow effect
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 15, 1, 15)
shadow.Position = UDim2.new(0, -7.5, 0, -7.5)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.8
shadow.ZIndex = -1
shadow.Parent = frame

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 12)
shadowCorner.Parent = shadow

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(220, 60, 60) -- Warning red
title.Text = "EXECUTOR WARNING"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = title

-- Warning icon
local warningIcon = Instance.new("ImageLabel")
warningIcon.Size = UDim2.new(0, 40, 0, 40)
warningIcon.Position = UDim2.new(0.5, -20, 0.1, 0)
warningIcon.BackgroundTransparency = 1
warningIcon.Image = "rbxassetid://6031075938" -- Warning icon
warningIcon.ImageColor3 = Color3.fromRGB(255, 200, 50)
warningIcon.Parent = frame

-- Message text
local message = Instance.new("TextLabel")
message.Size = UDim2.new(0.9, 0, 0, 100)
message.Position = UDim2.new(0.05, 0, 0.25, 0)
message.BackgroundTransparency = 1
message.Text = "if you see gui go invisible update your executor it's might help to fix this issues"
message.TextColor3 = Color3.fromRGB(255, 255, 255)
message.TextWrapped = true
message.TextScaled = false
message.TextSize = 18
message.Font = Enum.Font.Gotham
message.TextYAlignment = Enum.TextYAlignment.Top
message.Parent = frame

-- Checkbox container
local checkboxContainer = Instance.new("Frame")
checkboxContainer.Size = UDim2.new(0.9, 0, 0, 25)
checkboxContainer.Position = UDim2.new(0.05, 0, 0.65, 0)
checkboxContainer.BackgroundTransparency = 1
checkboxContainer.Parent = frame

-- Checkbox frame
local checkboxFrame = Instance.new("Frame")
checkboxFrame.Size = UDim2.new(0, 25, 0, 25)
checkboxFrame.Position = UDim2.new(0, 0, 0, 0)
checkboxFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
checkboxFrame.Parent = checkboxContainer

local checkboxCorner = Instance.new("UICorner")
checkboxCorner.CornerRadius = UDim.new(0, 4)
checkboxCorner.Parent = checkboxFrame

-- Checkbox button
local checkboxButton = Instance.new("TextButton")
checkboxButton.Size = UDim2.new(1, 0, 1, 0)
checkboxButton.Position = UDim2.new(0, 0, 0, 0)
checkboxButton.BackgroundTransparency = 1
checkboxButton.Text = ""
checkboxButton.Parent = checkboxFrame

-- Checkmark (hidden by default)
local checkmark = Instance.new("ImageLabel")
checkmark.Size = UDim2.new(0.8, 0, 0.8, 0)
checkmark.Position = UDim2.new(0.1, 0, 0.1, 0)
checkmark.BackgroundTransparency = 1
checkmark.Image = "rbxassetid://6031302931" -- Checkmark icon
checkmark.ImageColor3 = Color3.fromRGB(0, 200, 80)
checkmark.Visible = false
checkmark.Parent = checkboxFrame

-- Checkbox label
local checkboxLabel = Instance.new("TextLabel")
checkboxLabel.Size = UDim2.new(1, -30, 1, 0)
checkboxLabel.Position = UDim2.new(0, 30, 0, 0)
checkboxLabel.BackgroundTransparency = 1
checkboxLabel.Text = "Never show this pop up again"
checkboxLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
checkboxLabel.TextXAlignment = Enum.TextXAlignment.Left
checkboxLabel.Font = Enum.Font.Gotham
checkboxLabel.Parent = checkboxContainer

-- OK Button
local okButton = Instance.new("TextButton")
okButton.Size = UDim2.new(0.5, 0, 0, 40)
okButton.Position = UDim2.new(0.25, 0, 0.85, 0)
okButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
okButton.Text = "OK"
okButton.TextColor3 = Color3.fromRGB(255, 255, 255)
okButton.Font = Enum.Font.GothamBold
okButton.TextSize = 18
okButton.Parent = frame

local okCorner = Instance.new("UICorner")
okCorner.CornerRadius = UDim.new(0, 8)
okCorner.Parent = okButton

-- Button hover effects
local isChecked = false

checkboxButton.MouseButton1Click:Connect(function()
	isChecked = not isChecked
	checkmark.Visible = isChecked
	
	-- Animate checkbox
	checkboxFrame.BackgroundColor3 = isChecked and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(60, 60, 60)
end)

checkboxButton.MouseEnter:Connect(function()
	checkboxFrame.BackgroundColor3 = isChecked and Color3.fromRGB(90, 90, 90) or Color3.fromRGB(70, 70, 70)
end)

checkboxButton.MouseLeave:Connect(function()
	checkboxFrame.BackgroundColor3 = isChecked and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(60, 60, 60)
end)

okButton.MouseEnter:Connect(function()
	okButton.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
end)

okButton.MouseLeave:Connect(function()
	okButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
end)

-- OK Button functionality
okButton.MouseButton1Click:Connect(function()
	-- Save the setting if checkbox is checked
	if isChecked then
		-- Ensure folder exists
		ensureFolderExists()
		
		-- Write the setting to file
		local success = writeFile(fullPath, "true")
		
		if not success then
			-- If failed to write, show warning but still close
			warn("Failed to save preference to file.")
		end
	end
	
	-- Close the popup
	screenGui:Destroy()
end)

-- Close button (X in corner)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
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

-- Add a subtle animation when popup appears
frame.Position = UDim2.new(0.5, -225, 0.4, -125) -- Start slightly higher
local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local tween = tweenService:Create(frame, tweenInfo, {Position = UDim2.new(0.5, -225, 0.5, -125)})
tween:Play()
-- Create the popup screen gui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DiscordGiveawayPopup"
screenGui.DisplayOrder = 999
screenGui.ResetOnSpawn = false

-- Only create if not already exists
if not game:GetService("CoreGui"):FindFirstChild("DiscordGiveawayPopup") then
    screenGui.Parent = game:GetService("CoreGui")
else
    screenGui = game:GetService("CoreGui"):FindFirstChild("DiscordGiveawayPopup")
end

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
title.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
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
discordLink.TextColor3 = Color3.fromRGB(114, 137, 218)
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
    local success = pcall(function()
        if setclipboard then
            setclipboard("https://discord.gg/ny6pJgnR6c")
        else
            game:GetService("GuiService"):CopyToClipboard("https://discord.gg/ny6pJgnR6c")
        end
    end)
    
    if success then
        yesButton.Text = "LINK COPIED!"
        yesButton.BackgroundColor3 = Color3.fromRGB(67, 181, 129)
        
        task.wait(2)
        if yesButton and yesButton.Parent then
            yesButton.Text = "YES COPY LINK"
            yesButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        end
    else
        yesButton.Text = "COPY FAILED!"
        yesButton.BackgroundColor3 = Color3.fromRGB(240, 71, 71)
        
        task.wait(2)
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
