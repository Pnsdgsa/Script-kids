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

loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/Universal/Fps%20display.lua"))()

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
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/Evade%20Legacy/DaraHub-Evade-Legacy" 
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
    }, --MM2
     [142823291] = { 
        name = "Murder Mystery 2", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/MM2/DaraHub-MM2.lua" 
    },-- GAG Coming sooner 
    [126884695634066] = { 
        name = "Grow-a-Garden-[NEW-PLAYERS]", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Teleport_UI_gag.lua" 
    },
    [124977557560410] = { 
        name = "Grow-a-Garden", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Teleport_UI_gag.lua" 
    },
}

local UniversalScript = {
    name = "Universal Script",
    url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/Universal/Darahub-Universal.lua"
}

local currentGameId = game.PlaceId
local selectedScript = PlaceScripts[currentGameId]

if selectedScript then
    if selectedScript.url == "UNSUPPORTED" then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error - Game Not Supported",
            Text = selectedScript.name .. " is currently unsupported. Please check back later.",
            Duration = 5
        })
    else
        local success, result = pcall(function()
            return loadstring(game:HttpGet(selectedScript.url))()
        end)
        if not success then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "",
                Text = "" .. selectedScript.name .. " script: " .. tostring(result),
                Duration = 5
            })
        end
    end
else
    local success, result = pcall(function()
        return loadstring(game:HttpGet(UniversalScript.url))()
    end)
    if not success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "",
            Text = "" .. tostring(result),
            Duration = 5
        })
    end
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Create%20Loadstring%20file.lua",true))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Creator%20whitelist.lua"))()

local queueonteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (DaraHub and DaraHub.queue_on_teleport)

if queueonteleport then
 
    queueonteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/main-loader.lua'))()")
 
end
