local validLoadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/main-loader.lua"))()'

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")
local Player = Players.LocalPlayer

if makefolder and not isfolder("DaraHub") then
    makefolder("DaraHub")
end

local CONFIG_FILE_NAME = "DaraHub/DaraHubBigThxForSupport.lua"
local OLD_CONFIG_FILE_NAME = "DaraHubBigThxForSupport.lua"

local function handleOldFile()
    local success, content = pcall(function()
        if readfile then
            return readfile(OLD_CONFIG_FILE_NAME)
        end
        return nil
    end)
    if success and content and content == validLoadstring then
        local execSuccess, errorMsg = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/main-loader.lua"))()
        end)
        if execSuccess then
            pcall(function()
                if delfile then
                    delfile(OLD_CONFIG_FILE_NAME)
                end
            end)
            return true
        else
            warn("Old file execution failed: " .. tostring(errorMsg))
        end
    end
    return false
end

local oldHandled = handleOldFile()

local function readFileContent()
    local success, content = pcall(function()
        if readfile then
            return readfile(CONFIG_FILE_NAME)
        end
        return nil
    end)
    return success and content or nil
end

local function saveFileContent(content)
    local success, errorMsg = pcall(function()
        if writefile then
            writefile(CONFIG_FILE_NAME, content)
            return true
        end
        return false
    end)
    return success, errorMsg
end

local function autoExecuteFromConfig()
    local fileContent = readFileContent()
    if fileContent and fileContent == validLoadstring then
        local success, errorMsg = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/main-loader.lua"))()
        end)
        if success then
            return true
        else
            warn("Auto-execution failed: " .. tostring(errorMsg))
            return false
        end
    end
    return false
end

local autoExecuted = autoExecuteFromConfig()

if oldHandled or autoExecuted then
    return
end

local scaleFactor
pcall(function()
    scaleFactor = GuiService:GetScaleFactor() or 1
end)
if not scaleFactor then
    scaleFactor = 1
end

local baseWidth = 180 * scaleFactor
local baseHeight = 280 * scaleFactor

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LoadstringUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = true
ScreenGui.IgnoreGuiInset = true

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, baseWidth, 0, baseHeight)
Frame.Position = UDim2.new(0.5, -baseWidth / 2, 0.5, -baseHeight / 2)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8 * scaleFactor)
UICorner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30 * scaleFactor)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "Get Script"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.Parent = Frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 24 * scaleFactor, 0, 24 * scaleFactor)
CloseButton.Position = UDim2.new(1, -28 * scaleFactor, 0, 3 * scaleFactor)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = Frame

local CloseButtonCorner = Instance.new("UICorner")
CloseButtonCorner.CornerRadius = UDim.new(0, 4 * scaleFactor)
CloseButtonCorner.Parent = CloseButton

local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(0.9, 0, 0, 50 * scaleFactor)
InputBox.Position = UDim2.new(0.05, 0, 0.12, 0)
InputBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.Text = ""
InputBox.PlaceholderText = "Enter loadstring here"
InputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
InputBox.TextScaled = true
InputBox.TextWrapped = true
InputBox.Font = Enum.Font.SourceSans
InputBox.Parent = Frame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 4 * scaleFactor)
InputCorner.Parent = InputBox

local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Size = UDim2.new(0.9, 0, 0, 28 * scaleFactor)
ExecuteButton.Position = UDim2.new(0.05, 0, 0.32, 0)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
ExecuteButton.Text = "Execute"
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.TextScaled = true
ExecuteButton.Font = Enum.Font.SourceSansBold
ExecuteButton.Parent = Frame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 4 * scaleFactor)
ButtonCorner.Parent = ExecuteButton

local MessageLabel = Instance.new("TextLabel")
MessageLabel.Size = UDim2.new(0.9, 0, 0, 20 * scaleFactor)
MessageLabel.Position = UDim2.new(0.05, 0, 0.45, 0)
MessageLabel.BackgroundTransparency = 1
MessageLabel.Text = ""
MessageLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
MessageLabel.TextScaled = true
MessageLabel.Font = Enum.Font.SourceSans
MessageLabel.Parent = Frame

local CopyButton = Instance.new("TextButton")
CopyButton.Size = UDim2.new(0.9, 0, 0, 22 * scaleFactor)
CopyButton.Position = UDim2.new(0.05, 0, 0.55, 0)
CopyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
CopyButton.Text = "Copy Link"
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.TextScaled = true
CopyButton.Font = Enum.Font.SourceSansBold
CopyButton.Parent = Frame

local CopyButtonCorner = Instance.new("UICorner")
CopyButtonCorner.CornerRadius = UDim.new(0, 4 * scaleFactor)
CopyButtonCorner.Parent = CopyButton

local DiscordContainer = Instance.new("Frame")
DiscordContainer.Size = UDim2.new(0.9, 0, 0, 35 * scaleFactor)
DiscordContainer.Position = UDim2.new(0.05, 0, 0.68, 0)
DiscordContainer.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordContainer.Parent = Frame

local DiscordContainerCorner = Instance.new("UICorner")
DiscordContainerCorner.CornerRadius = UDim.new(0, 4 * scaleFactor)
DiscordContainerCorner.Parent = DiscordContainer

local DiscordIcon = Instance.new("ImageLabel")
DiscordIcon.Size = UDim2.new(0, 32 * scaleFactor, 0, 32 * scaleFactor)
DiscordIcon.Position = UDim2.new(0, 5 * scaleFactor, 0.5, -16 * scaleFactor)
DiscordIcon.BackgroundTransparency = 1
DiscordIcon.Parent = DiscordContainer

local DiscordLabel = Instance.new("TextLabel")
DiscordLabel.Size = UDim2.new(1, -40 * scaleFactor, 1, 0)
DiscordLabel.Position = UDim2.new(0, 40 * scaleFactor, 0, 0)
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.Text = "Join Discord"
DiscordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordLabel.TextScaled = true
DiscordLabel.Font = Enum.Font.SourceSansBold
DiscordLabel.Parent = DiscordContainer

-- Add a TextButton overlay for clicking on the Discord container
local DiscordButton = Instance.new("TextButton")
DiscordButton.Size = UDim2.new(1, 0, 1, 0)
DiscordButton.BackgroundTransparency = 1
DiscordButton.Text = ""
DiscordButton.Parent = DiscordContainer

local DescriptionLabel = Instance.new("TextLabel")
DescriptionLabel.Size = UDim2.new(0.9, 0, 0, 30 * scaleFactor)
DescriptionLabel.Position = UDim2.new(0.05, 0, 0.85, 0)
DescriptionLabel.BackgroundTransparency = 1
DescriptionLabel.Text = "Sorry Ads Link Required for free uses"
DescriptionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DescriptionLabel.TextScaled = true
DescriptionLabel.TextWrapped = true
DescriptionLabel.Font = Enum.Font.SourceSans
DescriptionLabel.Parent = Frame

local function downloadDiscordIcon()
    local url = "https://static.vecteezy.com/system/resources/thumbnails/018/930/718/small_2x/discord-logo-discord-icon-transparent-free-png.png"
    local filename = "DaraHub/discord_logo.png"
    
    if not isfile(filename) then
        local request = http_request or (syn and syn.request) or request
        if request then
            local success, response = pcall(function()
                return request({
                    Url = url,
                    Method = "GET"
                })
            end)
            if success and response and response.Body then
                pcall(function()
                    writefile(filename, response.Body)
                end)
            end
        end
    end
    
    if isfile(filename) then
        local image = getcustomasset or getsynasset
        if image then
            pcall(function()
                DiscordIcon.Image = image(filename)
            end)
        end
    end
end

downloadDiscordIcon()

local function executeLoadstring(input)
    if input == validLoadstring then
        MessageLabel.Text = "Loadstring is valid! Executing script..."
        
        local saveSuccess, saveError = saveFileContent(input)
        if not saveSuccess then
            MessageLabel.Text = "Executing but failed to save config"
        end
        
        local success, errorMsg = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/main-loader.lua"))()
        end)
        if success then
            MessageLabel.Text = "Script executed successfully!"
            wait(1)
            ScreenGui:Destroy()
            return true
        else
            MessageLabel.Text = "Execution failed: " .. tostring(errorMsg)
            return false
        end
    else
        MessageLabel.Text = "Woppsi this is not my script"
        return false
    end
end

ExecuteButton.MouseButton1Click:Connect(function()
    executeLoadstring(InputBox.Text)
end)

CopyButton.MouseButton1Click:Connect(function()
    local link = "https://pnsdgpost.blogspot.com/2025/10/dara-hub-script.html"
    if setclipboard then
        setclipboard(link)
        MessageLabel.Text = "Link copied!"
    else
        MessageLabel.Text = "Clipboard not supported"
    end
end)

DiscordButton.MouseButton1Click:Connect(function()
    local discordUrl = "https://discord.gg/your-invite-link"
    if setclipboard then
        setclipboard(discordUrl)
        MessageLabel.Text = "Discord link copied!"
    else
        MessageLabel.Text = "Clipboard not supported"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local existingContent = readFileContent()
if existingContent then
    InputBox.Text = existingContent
end
local WeekendMode = false

local currentDay = os.date("*t").wday
if currentDay == 6 or currentDay == 7 then
    WeekendMode = true
    
    if game:GetService("CoreGui"):FindFirstChild("LoadstringUI") then
        game:GetService("CoreGui").LoadstringUI:Destroy()
    end
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/main-loader.lua"))()
    
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local StarterGui = game:GetService("StarterGui")
    
    StarterGui:SetCore("SendNotification", {
        Title = "Darahub",
        Text = "Weekend mode activated! Feel free to use the script",
        Icon = "rbxassetid://137330250139083",
        Duration = 10,
        Button1 = "Close"
    })
end

return WeekendMode
