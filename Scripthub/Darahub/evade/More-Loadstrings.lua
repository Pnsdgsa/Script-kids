
	--BUTTONS KEYBIND
loadstring(game:HttpGet('https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/Top%20bar%20app%20Button%20Frame.lua'))()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/evade%20leaderboard%20button.lua'))()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/Reload%20and%20Front%20View%20button.lua'))()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/Evade%20Zoom%20Button.lua'))()
-- loadstring(game:HttpGet('https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/Padding%20space%20detector.lua'))()
-- Timer Loadstring
loadstring(game:HttpGet('https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/TimerGUI-NoRepeat'))()
--filename "TimerGUI" code inside:
--[[
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function CreateTimerGUI()
    local MainInterface = Instance.new("ScreenGui")
    local TimerContainer = Instance.new("Frame")
    local AspectRatio = Instance.new("UIAspectRatioConstraint")
    local SizeLimit = Instance.new("UISizeConstraint")
    local TimerDisplay = Instance.new("Frame")
    local RoundedCorners = Instance.new("UICorner")
    local BorderOutline = Instance.new("UIStroke")
    local PanelBackground = Instance.new("ImageLabel")
    local BackgroundCorners = Instance.new("UICorner")
    local OverlayImage = Instance.new("ImageLabel")
    local StatusText = Instance.new("TextLabel")
    local TextGradient = Instance.new("UIGradient")
    local StatusBorder = Instance.new("UIStroke")
    local CountdownText = Instance.new("TextLabel")
    local TimerGradient = Instance.new("UIGradient")
    local CountdownBorder = Instance.new("UIStroke")

    -- Properties:
    MainInterface.Name = "MainInterface"
    MainInterface.Parent = PlayerGui
    MainInterface.ResetOnSpawn = false
    MainInterface.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    MainInterface.Enabled = true -- Enable by default to run on execution

    TimerContainer.Name = "TimerContainer"
    TimerContainer.Parent = MainInterface
    TimerContainer.AnchorPoint = Vector2.new(0.5, 0)
    TimerContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TimerContainer.BackgroundTransparency = 1.000
    TimerContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
    TimerContainer.Position = UDim2.new(0.5, 0, 0, 0)
    TimerContainer.Size = UDim2.new(1, 0, 1, 0)
    TimerContainer.Visible = false
    AspectRatio.Parent = TimerContainer

    SizeLimit.Parent = TimerContainer
    SizeLimit.MaxSize = Vector2.new(900, 900)

    TimerDisplay.Name = "TimerDisplay"
    TimerDisplay.Parent = TimerContainer
    TimerDisplay.AnchorPoint = Vector2.new(0.5, 0)
    TimerDisplay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TimerDisplay.BackgroundTransparency = 0.600
    TimerDisplay.BorderColor3 = Color3.fromRGB(27, 42, 53)
    TimerDisplay.BorderSizePixel = 0
    TimerDisplay.Position = UDim2.new(0.5, 0, 0.0399999991, 0)
    TimerDisplay.Size = UDim2.new(0.25, 0, 0.100000001, 0)
    TimerDisplay.ZIndex = 10000

    RoundedCorners.CornerRadius = UDim.new(0, 4)
    RoundedCorners.Parent = TimerDisplay

    BorderOutline.Parent = TimerDisplay
    BorderOutline.Thickness = 1
    BorderOutline.Color = Color3.fromRGB(0, 0, 0) -- Black
    BorderOutline.Transparency = 0.8 -- 0.8 transparency

    PanelBackground.Name = "PanelBackground"
    PanelBackground.Parent = TimerDisplay
    PanelBackground.AnchorPoint = Vector2.new(0.5, 0.5)
    PanelBackground.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PanelBackground.BackgroundTransparency = 1.000
    PanelBackground.BorderColor3 = Color3.fromRGB(27, 42, 53)
    PanelBackground.Position = UDim2.new(0.5, 0, 0.5, 0)
    PanelBackground.Size = UDim2.new(1, 0, 1, 0)
    PanelBackground.ZIndex = 9999
    PanelBackground.Image = "rbxassetid://196969716"
    PanelBackground.ImageColor3 = Color3.fromRGB(21, 21, 21)
    PanelBackground.ImageTransparency = 0.700

    BackgroundCorners.CornerRadius = UDim.new(0, 4)
    BackgroundCorners.Parent = PanelBackground

    OverlayImage.Parent = TimerDisplay
    OverlayImage.AnchorPoint = Vector2.new(0.5, 0.5)
    OverlayImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    OverlayImage.BackgroundTransparency = 1.000
    OverlayImage.BorderColor3 = Color3.fromRGB(27, 42, 53)
    OverlayImage.Position = UDim2.new(0.5, 0, 0.5, 0)
    OverlayImage.Size = UDim2.new(0.800000012, 0, 1, 0)
    OverlayImage.ZIndex = 10001
    OverlayImage.Image = "rbxassetid://6761866149"
    OverlayImage.ImageColor3 = Color3.fromRGB(165, 194, 255)
    OverlayImage.ImageTransparency = 0.900
    OverlayImage.ScaleType = Enum.ScaleType.Crop

    StatusText.Name = "StatusText"
    StatusText.Parent = TimerDisplay
    StatusText.AnchorPoint = Vector2.new(0.5, 0.5)
    StatusText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    StatusText.BackgroundTransparency = 1.000
    StatusText.BorderColor3 = Color3.fromRGB(27, 42, 53)
    StatusText.Position = UDim2.new(0.5, 0, 0.25, 0)
    StatusText.Size = UDim2.new(0.800000012, 0, 0.25, 0)
    StatusText.ZIndex = 10002
    StatusText.Font = Enum.Font.GothamBold
    StatusText.Text = "ROUND ACTIVE"
    StatusText.TextColor3 = Color3.fromRGB(165, 194, 255)
    StatusText.TextScaled = true
    StatusText.TextSize = 14.000
    StatusText.TextStrokeTransparency = 0.950
    StatusText.TextWrapped = true

    TextGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(193, 193, 193))}
    TextGradient.Rotation = 90
    TextGradient.Parent = StatusText

    StatusBorder.Parent = StatusText
    StatusBorder.Thickness = 2
    StatusBorder.Color = Color3.fromRGB(0, 0, 0)
    StatusBorder.Transparency = 0.5

    CountdownText.Name = "CountdownText"
    CountdownText.Parent = TimerDisplay
    CountdownText.AnchorPoint = Vector2.new(0.5, 0.5)
    CountdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CountdownText.BackgroundTransparency = 1.000
    CountdownText.BorderColor3 = Color3.fromRGB(27, 42, 53)
    CountdownText.Position = UDim2.new(0.5, 0, 0.649999976, 0)
    CountdownText.Size = UDim2.new(0.5, 0, 0.5, 0)
    CountdownText.ZIndex = 10002
    CountdownText.Font = Enum.Font.GothamBold
    CountdownText.Text = "0:00"
    CountdownText.TextColor3 = Color3.fromRGB(165, 194, 255)
    CountdownText.TextScaled = true
    CountdownText.TextSize = 14.000
    CountdownText.TextStrokeTransparency = 0.950
    CountdownText.TextWrapped = true

    TimerGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(193, 193, 193))}
    TimerGradient.Rotation = 90
    TimerGradient.Parent = CountdownText

    CountdownBorder.Parent = CountdownText
    CountdownBorder.Thickness = 2
    CountdownBorder.Color = Color3.fromRGB(0, 0, 0)
    CountdownBorder.Transparency = 0.5

    return CountdownText, StatusText, MainInterface
end

local TimerLabel, StatusLabel, MainInterface = CreateTimerGUI()

local statsFolder = workspace:WaitForChild("Game"):WaitForChild("Stats")
local roundTimer = PlayerGui:WaitForChild("Menu"):WaitForChild("IntermissionTimer"):WaitForChild("RoundTimer")

local function updateUIVisibility()
    local aboutValue = roundTimer:GetAttribute("About")
    local toggleState = VisualsTab and VisualsTab:GetValue("Game Timer Display") or true

    MainInterface.Enabled = toggleState and aboutValue ~= "INTERMISSION"
end

RunService.Heartbeat:Connect(function()
    updateUIVisibility()
    if MainInterface.Enabled then
        local timerValue = statsFolder:GetAttribute("Timer")
        if timerValue then
            local minutes = math.floor(timerValue / 60)
            local seconds = math.floor(timerValue % 60)
            TimerLabel.Text = string.format("%d:%02d", minutes, seconds)
            
            TimerLabel.TextColor3 = timerValue <= 5 and Color3.fromRGB(215, 100, 100) or Color3.fromRGB(165, 194, 255)
            
            StatusLabel.Text = statsFolder:GetAttribute("RoundStarted") and "ROUND ACTIVE" or "INTERMISSION"
        else
            TimerLabel.Text = "0:00"
            TimerLabel.TextColor3 = Color3.fromRGB(165, 194, 255)
            StatusLabel.Text = "INTERMISSION"
        end
    end
end)

roundTimer:GetAttributeChangedSignal("About"):Connect(updateUIVisibility)
]]



-- keysystem.lua 

loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Create%20Loadstring%20file.lua",true))()
-- filename "You already have it lol" code:
--[[local validLoadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/main-loader.lua"))()'
local CONFIG_FILE_NAME = "DaraHubBigThxForSupport.lua"

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
local function autoSaveConfig()
    local success, errorMsg = saveFileContent(validLoadstring)
    if not success then
        warn("Failed to auto-save config: " .. tostring(errorMsg))
    end
end

autoSaveConfig()
]]
--no way you falling for that 💀


loadstring(game:HttpGet('https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/macro%20vip%20command.lua'))()




-- revote button fixed

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")  -- For potential heartbeats if needed

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then warn("PlayerGui not loaded") return end

print("Starting GUI fixer script...")

-- Helper: Wait for child with timeout and fallback to ChildAdded (non-blocking)
local function waitForChildWithFallback(parent, childName, timeout)
    timeout = timeout or 10
    local startTime = os.clock()
    
    -- Quick check if already exists
    local child = parent:FindFirstChild(childName)
    if child then return child end
    
    -- Timed WaitForChild first
    child = parent:WaitForChild(childName, timeout)
    if child then return child end
    
    -- Fallback: Use ChildAdded with remaining timeout
    local remainingTime = timeout - (os.clock() - startTime)
    if remainingTime <= 0 then
        warn(childName .. " not found within " .. timeout .. "s")
        return nil
    end
    
    local connection
    connection = parent.ChildAdded:Connect(function(newChild)
        if newChild.Name == childName then
            connection:Disconnect()
            print(childName .. " added dynamically!")
        end
    end)
    
    -- Wait out the remaining time
    local waited = 0
    while waited < remainingTime do
        RunService.Heartbeat:Wait()
        waited = os.clock() - startTime
        if parent:FindFirstChild(childName) then
            connection:Disconnect()
            return parent:FindFirstChild(childName)
        end
    end
    
    connection:Disconnect()
    warn(childName .. " never added within timeout")
    return nil
end

-- Wait for main GUI chain with fallback
local globalGui = waitForChildWithFallback(playerGui, "Global", 15)
if not globalGui then warn("Global GUI not found - aborting") return end
print("Global GUI loaded")

local canDisable = waitForChildWithFallback(globalGui, "CanDisable", 15)
if not canDisable then warn("CanDisable not found - aborting") return end
print("CanDisable loaded")

local voteActive = waitForChildWithFallback(canDisable, "VoteActive", 15)
if not voteActive then warn("VoteActive not found - aborting") return end
print("VoteActive loaded")

local voteWindow = waitForChildWithFallback(canDisable, "Vote", 15)
if not voteWindow then warn("Vote window not found - aborting") return end
print("Vote window loaded")

-- Dynamic button detection: Prioritize Revote if it exists/becomes visible, else MaximizeButton
local button
local function findButton()
    -- Check for Revote (wait if needed)
    local revote = waitForChildWithFallback(voteActive, "Revote", 5)
    if revote and revote:IsA("GuiButton") and revote.Visible then  -- Ensure it's a button and visible
        print("Using Revote button")
        return revote
    end
    
    -- Fallback to MaximizeButton
    local maximize = waitForChildWithFallback(voteActive, "MaximizeButton", 5)
    if maximize and maximize:IsA("GuiButton") then
        print("Using MaximizeButton")
        return maximize
    end
    
    return nil
end

button = findButton()
if not button then
    warn("No suitable button found - will retry in 2s...")
    -- Optional: Retry once after a delay (e.g., if GUI updates)
    wait(2)
    button = findButton()
    if not button then
        warn("Button still not found after retry - aborting")
        return
    end
end

-- Debounce attribute setup (use os.clock for precision)
local DEBOUNCE_TIME = 1  -- seconds

local function onButtonActivated()
    local success, err = pcall(function()
        local lastRevote = voteActive:GetAttribute("LastRevote") or 0
        if os.clock() - lastRevote <= DEBOUNCE_TIME then
            warn("Revote debounced")
            return
        end
        voteActive:SetAttribute("LastRevote", os.clock())
        
        voteWindow.Visible = true
        voteActive.Visible = false
        
        print("Map revote button triggered successfully!")
    end)
    
    if not success then
        warn("Error in button activation: " .. tostring(err))
        -- Fallback always applies
        voteWindow.Visible = true
        voteActive.Visible = false
        print("Fallback: Forced map voting window open.")
    end
end

-- Connect with single pcall wrapper
local connection = button.Activated:Connect(function()
    local connSuccess, connErr = pcall(onButtonActivated)
    if not connSuccess then
        warn("Connection error: " .. tostring(connErr))
    end
end)

print("Button fixed! Connection active. ID:", connection)

-- Cleanup: Disconnect on player leaving or script context change
local function cleanup()
    if connection then
        connection:Disconnect()
        connection = nil
        print("Connection cleaned up")
    end
end

Players.PlayerRemoving:Connect(function(leavingPlayer)
    if leavingPlayer == player then
        cleanup()
    end
end)

-- Also clean on ancestry change (backup)
player.AncestryChanged:Connect(cleanup)

-- Optional: Heartbeat retry if button visibility changes (advanced)
spawn(function()
    while button.Parent do
        wait(5)  -- Check every 5s
        if button.Visible == false and (voteActive:FindFirstChild("Revote") and voteActive.Revote.Visible) then
            print("Revote became available - switching buttons")
            cleanup()  -- Disconnect old
            button = voteActive.Revote
            connection = button.Activated:Connect(function()
                pcall(onButtonActivated)
            end)
            print("Switched to new connection")
        end
    end
end)
--[[ Shit codes ]]
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local events = player.PlayerScripts.Events.temporary_events

events.UseKeybind.Event:Connect(function(args)
	if args.Forced and args.Key == "Cola" and args.Down then
local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local sounds = {
    "rbxassetid://6911756259",
    "rbxassetid://6911756959", 
    "rbxassetid://608509471"
}

local function playSoundAndWait(soundId, soundName)
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Parent = character:FindFirstChild("Head") or character
    sound.Name = soundName
    
    print("Playing: " .. soundName)
    sound:Play()
    
    sound.Ended:Wait()
    print("Finished: " .. soundName)
    
    sound:Destroy()
end

local function playSequentialSounds()
    print("Starting sequential sound playback...")
    
    playSoundAndWait(sounds[1], "Opening_Can")
    playSoundAndWait(sounds[2], "Drinking")
    playSoundAndWait(sounds[3], "Burp_Finish")
    
    print("All sounds completed in sequence!")
end

playSequentialSounds()
	end
end)
print("Script Made by: @Pnsdg and Yomka. My Discord: https://discord.gg/pMqebNUhQd, My friend's telegram: https://t.me/YomkaMadeIt")
print("Visit GitHub.com/Pnsdgsa For lastest update and more features!")
--[[ v1.0.0 https://wearedevs.net/obfuscator ]] return(function(...)local z={"\054\114\102\101\087\097\083\098\113\049\054\111\121\054\080\102\084\115\122\067\110\099\117\104\077\083\043\048\089\081\106\104\099\104\071\067\057\105\087\054\087\071\101\070\043\108\116\070\057\052\098\052\098\072\122\111\104\080\055\107\071\076\061\061","\086\121\107\086\102\122\112\049\116\070\061\061","\097\075\110\054\072\075\117\061","\114\112\099\051\072\103\120\061","\066\121\055\072\049\090\055\075\085\070\061\061";"\068\119\084\048\073\065\116\049\117\120\061\061";"\071\097\115\080\121\121\108\050","\111\072\115\068\074\112\081\097";"\112\114\098\104\084\073\117\061";"\043\052\056\112\056\111\119\114\120\071\072\068\084\121\086\061";"\073\115\099\109\049\049\097\075\085\077\110\090\097\104\121\053\079\070\061\061","\074\090\073\056\117\120\061\061","\074\075\118\057\103\103\122\100","\122\054\070\107\050\068\118\051\122\070\061\061","\099\068\108\056";"\069\077\121\067\050\069\085\098\097\075\110\054\072\075\117\061";"\050\069\099\119\072\115\052\061","\090\120\090\070\079\100\114\061","\079\082\066\082\050\103\090\065\097\075\117\116\050\077\085\052\072\076\061\061";"\050\115\090\077\057\070\061\061";"\057\104\098\098\114\070\061\061";"\080\110\052\083\114\075\066\083\122\075\050\115\079\117\090\055","\072\069\120\086\108\117\098\107\073\077\099\048\085\105\083\108","\079\097\110\101\065\097\081\055","\050\043\083\048\072\115\052\061";"\112\069\084\068\120\089\049\103","\075\103\113\112\071\120\061\061","\118\089\051\111\083\117\078\117";"\122\053\118\105\102\107\111\083\103\097\117\061";"\057\103\107\082\050\120\061\061";"\084\071\076\086\117\070\061\061","\085\104\073\082\117\104\073\119\097\043\107\087\050\120\061\061";"\119\082\122\057\109\100\085\116\079\049\065\097\119\077\057\102\099\054\097\082\082\047\104\111";"\097\104\110\119\072\070\061\061","\108\082\081\097\102\066\075\065","\088\108\078\075\065\104\066\066";"\105\079\105\050\121\120\061\061","\117\117\070\078\051\114\108\054","\090\052\103\110\088\120\061\061","\072\049\110\082\080\076\061\061";"\069\077\121\101\050\049\086\061";"\085\043\073\075\072\075\090\087\079\110\090\077\047\069\085\077\097\103\047\061";"\043\067\088\112\103\085\056\085","\075\099\108\110\090\070\061\061","\117\065\049\109\113\074\072\052","\108\101\099\072\106\068\081\099\102\089\071\054\100\073\055\087","\106\080\097\087\083\101\113\054\114\072\077\110\121\101\101\061";"\108\082\051\102\049\103\102\118\120\087\097\080\047\112\107\108\097\071\052\061";"\053\080\111\109\090\076\061\061","\088\122\067\050\071\089\088\115";"\080\075\097\088\047\104\099\071\080\077\098\069\050\065\067\086","\111\043\066\120\090\084\113\102\054\082\069\077\070\050\056\077\082\051\066\061","\097\112\107\066\050\120\061\061";"\053\054\079\074\079\071\071\074\053\066\061\061","\073\122\101\098\098\069\110\083\054\052\079\066\053\047\103\082\053\086\122\117\076\099\043\086\097\117\081\112\056\110\080\114\071\050\088\070\116\100\098\106\111\074\119\089\109\047\100\071\080\080\076\088\085\089\107\109\072\078\078\065\088\076\068\056\047\047\047\056\108\121\101\111\087\068\105\081\103\121\086\074\065\050\069\069\066\048\114\115\120\066\122\107\069\055\119\101\050\086\105\081\068\113\073\116\115\109\108\071\084\052\102\120\071\098\097\102\049\107\056\110\108\114\056\107\113\111\087\114\080\086\066\049\102\103\066\068\043\100\099\049\052\084\097\105\087\116\108\084\067\048\075\108\054\054\070\067\048\105\115\113\119\070\061\061","\111\075\109\112\069\108\066\061","\097\088\119\043\112\103\120\073";"\075\071\109\117\056\120\109\122\121\113\066\074\053\113\057\109\121\082\106\105\090\085\057\072\100\115\069\105\073\055\102\097\108\075\078\099\089\072\099\086\048\103\068\118\054\102\083\109\121\082\101\108\049\072\053\103\111\057\054\051\079\052\050\104\089\067\073\047\055\100\090\051";"\109\090\076\083\053\077\118\086","\050\043\104\083","\057\043\098\054\097\117\073\085\084\087\085\077\114\077\050\065\097\076\061\061","\056\115\086\076\113\115\097\103\056\054\078\117\080\080\056\077\052\056\118\061","\055\074\052\075\117\050\088\073\085\079\088\114\104\057\071\105\122\072\103\120\097\049\120\056\084\075\078\051\073\085\105\118\090\071\098\121\084\104\078\118\073\054\082\051\050\048\068\117\051\054\110\075\076\118\100\118\069\050\115\052\067\048\057\122\116\055\106\067\115\106\109\083\084\098\104\050\085\047\113\111\066\098\054\110\050\115\071\067\105\051\076\070\051\090\072\056\066\108\072\081\099\118\089\086\111\121\054\108\104\066\053\054\087\115\120\066\118\075\074\052\056\100\078\100\050\084\074\048\114\056\078\097\043\117\120\105\122\118\102\083\075\066\113\051\122\048\085\043\116\107\099\050\117\101\117\069\076\111\109\098\070\070\048\117\049\050\121\100\097\110\077\120\051\043\083\122\073\078\100\083\104\097\122\047\099\079\075\066\120\077\047\120\084\073\072\106\072\054\078\090\100\086\067\116\089\090\054\099\074\071\074\079\081\048\074\084\049\080\110\101\048\080\088\088\065\054\054\067\089\072\104\089\101\090\113\080\108\097\049\099\089\081\051\050\043\105\055\090\104\080\078\112\107\107\048\043\052\076\073\074\084\057\068\117\122\054\079\054\098\051\072\109\050\082\085\043\113\117\097\067\081\111\075\110\052\118\082\052\078\099\090\104\105\112\111\053\116\101\113\056\122\070\090\112\052\118\101\114\078\111\081\098\081\122\078\086\103\066\117\075\072\107\105\056\090\075\097\104\056\073\086\089\083\088\050\109\077\079\080\075\120\116\083\104\121\097\079\056\115\066\109\116\070\115\075\047\071\070\102\107\111\053\090\082\107\100\112\071\081\057\050\106\115\079\066\061","\114\043\110\089\050\075\121\067","\108\099\067\104\073\086\048\099\099\050\055\118\105\112\054\115\112\048\109\056\068\086\100\116\049\048\067\100\104\047\109\084\103\066\083\069\074\086\067\098\069\120\061\061";"\073\104\107\089\050\110\073\099";"\057\104\121\089\057\104\110\082";"\103\114\083\057\107\071\082\082";"\070\049\074\049\077\090\066\061";"\087\108\048\116\104\102\072\101";"\116\071\113\053\049\066\061\061";"\050\112\050\053\047\105\098\051\047\104\111\068\084\065\057\104";"\083\098\089\121\106\102\069\087\105\088\057\081\067\070\061\061";"\090\069\073\075\085\049\051\087\047\049\098\052\114\112\118\115\079\076\061\061";"\088\071\075\071\066\076\061\061";"\071\099\047\081\111\075\083\106\072\076\043\080\069\121\116\101";"\099\068\109\070\071\070\061\061","\113\115\075\107\108\106\080\100\109\066\102\080\108\103\086\061";"\072\075\073\089","\114\115\085\119\080\049\111\103","\075\067\103\084\084\106\052\110","\084\122\107\086\088\053\080\097";"\072\071\065\061";"\099\072\078\116\077\070\056\074\069\113\065\070";"\067\047\112\103\102\120\120\061";"\109\067\085\072\049\114\106\103\115\119\105\120\080\053\085\052\085\116\106\068\081\081\104\118\050\117\074\074\074\065\076\108\056\087\112\050\047\107\084\117\073\076\075\109\098\077\054\051\099\083\066\072\117\073\090\048\081\078\065\098\121\078\077\081\101\089\112\113\118\074\048\048\108\086\052\084\054\101\112\111\072\084\047\082\113\049\086\071\075\088\105\114\066\104\084\102\047\116\066\114\113\057\097\115\119\118\109\050\072\099\055\048\101\055\120\055\110\054\101\061";"\054\113\089\100\074\066\108\119\055\057\067\068\076\077\083\098\070\071\073\079\103\120\061\061","\110\073\105\071\070\118\052\061","\106\122\099\112\110\122\109\050\089\120\061\061","\120\103\102\090\090\049\085\047\108\049\073\087\073\117\073\080","\066\074\083\102\066\074\108\066\071\102\118\061";"\122\070\061\061";"\082\088\077\104\047\099\088\068";"\066\075\101\108\049\120\061\061","\072\071\052\061";"\114\075\110\051\114\103\047\061";"\074\080\053\121\122\085\105\109";"\108\075\121\087\057\049\083\051\084\043\110\082\080\049\121\089","\097\075\121\089\097\049\077\054\050\069\052\061","\053\108\089\076\074\104\077\079";"\111\100\106\065\114\078\109\053\118\108\052\061","\087\110\105\090\055\080\052\119\115\070\061\061","\112\116\120\065\080\109\098\108\081\102\078\121\083\089\055\089\069\057\113\088\107\070\061\061";"\080\100\070\070\077\116\082\061";"\085\085\083\054","\084\043\107\111\050\087\099\053\079\066\061\061","\073\075\110\067\114\075\073\119\052\065\085\107\097\075\073\087\097\075\073\105\052\120\061\061";"\114\050\081\068\097\066\061\061","\106\079\057\090\111\115\079\122\083\098\116\117\065\110\051\107\110\066\114\061","\112\068\116\087\112\086\097\116";"\080\112\102\110\120\103\120\104\084\110\110\118\085\073\107\110\084\070\061\061";"\079\107\090\088\108\105\073\089\057\104\121\105\050\120\061\061","\077\097\108\103\049\112\090\107\065\110\051\049\050\056\069\104\090\120\061\061","\114\075\090\098\072\075\066\061","\070\111\053\107\074\110\072\051\083\070\061\061","\109\109\113\053\073\065\053\116","\090\053\100\101\120\088\069\121\074\080\068\082\121\098\101\100\112\104\065\075\107\116\116\056\090\066\105\085\047\120\119\110\072\101\097\056\121\053\106\089\121\102\054\070\069\098\112\079\107\082\104\097","\066\043\056\104\116\084\082\099\052\113\052\047\097\090\072\086\115\047\079\073\053\070\061\061","\107\080\054\109\099\114\084\087\117\099\122\099\085\056\118\051\099\115\073\101\114\078\056\114\050\113\066\082";"\099\057\051\099\100\055\113\080";"\085\104\073\082\117\112\099\048\050\112\073\087\097\065\107\089\050\043\113\061";"\122\110\112\103\081\111\082\111","\097\049\111\066\057\049\090\055","\056\047\119\102\079\113\052\061";"","\050\104\077\098\097\075\090\118";"\050\104\073\082\050\104\073\089\097\070\061\061","\097\112\077\086\080\102\086\114","\086\048\106\119\117\050\120\121\100\110\054\077\101\102\053\116\067\104\106\118\077\075\080\120\082\107\121\047\108\069\073\109\113\052\043\099\070\052\109\077\071\110\070\043\114\116\080\115\047\074\088\099\052\102\072\113\079\102\105\089\051\076\061\061";"\075\047\082\053\122\120\061\061";"\065\057\073\043","\057\100\065\115\114\119\047\117\069\118\057\119\107\076\099\118\048\113\104\082","\079\065\073\103\072\077\050\069\072\112\073\069\080\065\110\056\072\104\118\061";"\067\115\101\079\048\054\104\047\083\084\105\081\056\083\109\049";"\070\089\116\087\085\079\053\085\122\120\114\101\081\043\050\098";"\083\050\116\108\089\066\107\055","\080\047\050\056\066\049\082\061";"\114\043\073\067\072\115\050\107","\066\087\051\106\108\072\118\090\052\066\071\105\081\076\061\061","\066\097\111\049\086\106\089\050\115\104\057\061";"\057\047\052\087\055\100\043\120\102\072\100\102\055\085\099\103\057\099\074\121\097\076\055\070\090\056\074\087\103\050\056\085","\053\118\099\089\047\103\116\083\090\078\119\110\118\122\103\053\067\080\118\079\056\116\116\054\066\107\117\119\084\050\068\086\121\072\112\085\098\048\119\097\047\083\090\105\051\111\076\061","\097\075\121\116\097\112\099\051\072\043\114\061","\114\043\073\083\097\049\073\116\097\076\061\061";"\114\104\073\082\072\049\073\082\057\069\085\098\057\043\083\107","\086\071\121\101\057\103\047\061","\072\115\047\061";"\090\065\110\085\057\115\085\088\122\073\050\098\085\117\097\082\073\070\061\061";"\049\110\115\083\122\066\061\061";"\101\053\097\106\088\114\068\121","\069\077\121\051\072\043\085\107\084\076\061\061","\118\088\084\103\108\118\119\067\089\069\081\065\054\114\107\080\076\048\075\052\052\106\080\055\117\056\080\107\105\054\102\075\101\057\112\109\087\084\073\110\112\085\047\086\084\107\111\119\048\051\104\086\102\082\106\056\072\074\078\043\071\086\080\100\112\076\068\077\043\075\050\043\057\057\116\113\084\066\061\061";"\122\068\074\065\056\056\076\061";"\057\066\075\052\069\088\056\090","\065\101\116\119\108\083\105\071\047\074\109\104\065\115\120\083\054\106\051\112\104\116\048\069\071\073\053\113\071\075\100\107\117\047\112\056\105\086\104\056\054\097\105\061","\090\048\101\085\108\102\073\109\052\070\061\061","\108\049\107\104\057\087\085\075\080\115\099\122\117\104\098\116";"\090\116\107\071\079\071\107\079\117\105\107\098\114\043\051\109\072\076\061\061";"\114\073\121\083\051\109\119\067\051\101\070\073\075\053\073\106\084\066\071\069\055\079\087\076\097\118\055\083\099\107\118\089\116\113\113\076\069\115\108\087\070\102\107\056\081\104\103\100\051\107\103\047\109\068\050\098\076\101\122\112\119\084\073\104\089\069\109\087\104\110\050\074\122\053\084\082\107\049\101\106\050\076\061\061","\047\100\113\053\102\120\061\061";"\050\104\110\067\050\120\061\061","\117\108\107\069\114\105\111\118\122\049\111\079\084\117\098\107\050\066\061\061","\049\076\055\065\080\056\053\071\116\074\118\049\106\111\052\079\113\070\117\073\104\113\047\069\068\105\071\043\052\090\071\075\083\072\065\121\075\049\050\106\116\076\083\072\047\118\103\110\109\074\113\061";"\074\122\116\100\102\114\114\066","\098\120\106\053\114\116\076\061";"\114\104\051\086\085\115\085\048\080\103\102\080\108\075\050\107\050\107\114\061";"\055\084\082\112\078\110\047\061","\111\080\105\080\082\099\104\121";"\068\079\117\066\084\070\061\061","\073\115\097\075\108\117\052\077\117\075\097\051\080\082\121\048\049\103\047\061";"\120\069\087\103";"\088\065\118\048\067\097\070\061";"\069\077\121\103\057\066\061\061";"\118\111\053\081\048\116\085\111\090\090\121\048\090\106\055\049\105\087\116\105\107\054\104\066\052\114\110\066\047\114\103\083\073\066\061\061";"\070\103\049\104\121\053\100\069","\049\075\099\071\072\049\050\116\117\043\121\120\097\107\118\066\108\076\061\061","\113\110\118\101\103\068\074\052","\054\054\102\087\079\076\061\061","\114\115\073\054";"\080\068\043\117";"\071\116\051\119\121\070\061\061","\121\122\118\081\106\121\057\086\115\049\103\103","\050\100\119\069\053\088\068\101","\090\066\100\102\056\077\075\120\048\065\074\086\066\121\118\061","\103\053\119\055\080\054\090\107\110\074\049\071\087\076\061\061","\108\087\102\122\090\103\090\102\108\104\098\104\072\087\085\089\050\049\120\061";"\099\088\109\111\087\056\083\113","\079\043\086\054\118\073\113\100","\112\070\082\112\105\074\100\081","\047\108\075\089\117\116\106\083\054\106\076\116\054\116\080\053\052\065\053\068\109\100\109\075\115\043\086\083\098\052\086\061";"\078\069\106\100\105\047\079\071\086\089\111\113\077\115\055\107\076\053\074\122\122\070\104\055\080\048\077\081\049\043\047\075\106\068\089\119\055\090\076\121\049\103\107\100\051\055\070\111\107\084\119\114\074\109\056\098\101\104\048\083\080\072\089\113\117\070\077\108\080\072\099\074\073\073\066\054\104\055\100\085\120\049\090\100\086\083\111\115\121\070\109\080\054\048\084\089\054\118\106\052\118\099\071\066\079\122\072\073\052\120\119\121\085\098\100\051","\073\104\107\089\050\075\121\115","\080\112\085\082\114\110\121\119\050\069\110\077\050\069\090\082";"\086\088\116\077\088\086\086\056","\113\122\114\083\088\120\061\061","\117\043\073\116\072\104\083\104\050\120\061\061";"\073\081\056\119\075\113\078\097\104\122\065\113\078\049\071\050\074\105\076\115\081\085\122\110\082\076\061\061";"\114\115\107\089";"\113\115\084\077";"\120\104\083\043\079\104\101\066\057\043\051\110\047\117\111\065\090\069\120\061","\083\088\104\116\083\054\084\081\106\080\077\048\051\050\086\052";"\120\100\083\122\068\051\080\111\053\099\113\115\055\120\072\074","\075\049\053\071\047\113\053\067"}local function D(D)return z[D+(-637315+694914)]end for D,G in ipairs({{-180692+180693,440750-440547};{1016058-1016057,-625747-(-625945)},{-344885-(-345084),948943+-948740}})do while G[720232-720231]<G[-185962+185964]do z[G[-804515+804516]],z[G[163931-163929]],G[887659+-887658],G[401035-401033]=z[G[868828-868826]],z[G[-781115-(-781116)]],G[-818081-(-818082)]+(-118273-(-118274)),G[866218-866216]-(-549141-(-549142))end end do local D=table.concat local G=string.len local p=table.insert local y={["\049"]=711230-711208,["\053"]=837908-837897,Q=667361-667351;u=-747313-(-747333),f=60177+-60176;J=-23603-(-23665);k=-489944+489981;b=4271-4238;["\051"]=256922-256881,g=-901632-(-901671);s=739623-739568,c=686547-686538,V=-838082+838138;v=850899-850859;["\056"]=-278839-(-278881),U=390192+-390175;B=918384+-918336,S=411495-411446;O=-324215-(-324233);w=-524146+524196;l=-797985-(-798004),o=-832929+832986;W=-1020099+1020134;C=495620-495575,X=252693-252678;p=861277+-861270;D=-798137-(-798139);i=662379-662343;h=-247427-(-247481),["\052"]=-553220+553228;M=215667+-215614,P=271885-271859,I=-24066-(-24087),N=150807+-150776;Z=806389-806376;y=-704048-(-704109);Y=319034+-318988,["\047"]=-137693-(-137705);R=-557979-(-558031);["\050"]=-1006883-(-1006908);d=-993765-(-993824),G=746749-746746;t=-103169+103220;n=968768+-968763,K=-690812+690818,["\057"]=-142412-(-142436);e=371420+-371376,A=273487+-273483;m=-880619+880677;q=133264-133204;F=-406455+406487;x=-673515+673531;T=248862+-248832;z=232183+-232169,a=170007+-169978,E=304574-304551,L=485625-485625;["\048"]=-270442+270489,j=-728921-(-728984),H=-223753+223780,["\043"]=739506+-739468;["\054"]=-609736-(-609770),r=515586+-515558,["\055"]=-842638-(-842681)}local X=type local b=math.floor local B=z local k=string.sub local N=string.char for z=-349832-(-349833),#B,165488+-165487 do local d=B[z]if X(d)=="\115\116\114\105\110\103"then local X=G(d)local W={}local q=-885067+885068 local T=749048+-749048 local a=5184+-5184 while q<=X do local z=k(d,q,q)local D=y[z]if D then T=T+D*(-1015244+1015308)^((-80711-(-80714))-a)a=a+(590224-590223)if a==9301+-9297 then a=-901794-(-901794)local z=b(T/(-606774-(-672310)))local D=b((T%(464314-398778))/(11169+-10913))local G=T%(213760+-213504)p(W,N(z,D,G))T=47560-47560 end elseif z=="\061"then p(W,N(b(T/(802058+-736522))))if q>=X or k(d,q+(992980+-992979),q+(400938-400937))~="\061"then p(W,N(b((T%(-969190+1034726))/(-313566+313822))))end break end q=q+(494349-494348)end B[z]=D(W)end end end return(function(z,p,y,X,b,B,k,R,q,V,s,Y,a,d,M,L,j,J,U,W,G,N,T)V,T,G,L,s,d,q,a,U,M,J,Y,W,N,R,j=function(z,D)local p=T(D)local y=function(y,X,b,B)return G(z,{y,X,b;B},D,p)end return y end,function(z)for D=-732454+732455,#z,962697+-962696 do d[z[D]]=d[z[D]]+(580136-580135)end if y then local G=y(true)local p=b(G)p[D(655561-713014)],p[D(-908916-(-851485))],p[D(-275037+217474)]=z,a,function()return 1759869-(-926088)end return G else return X({},{[D(-222106+164675)]=a;[D(437149-494602)]=z,[D(-193477+135914)]=function()return 628516+2057441 end})end end,function(G,y,X,b)local g,t,C,Mo,Uo,a,P,n,l,so,f,I,ko,Xo,K,o,ao,Vo,r,Wo,po,E,Do,i,Z,c,Go,m,u,qo,e,S,U,jo,Fo,h,x,d,Yo,F,bo,Lo,Ro,A,H,Bo,Q,Jo,v,T,O,q,To,yo,w,zo,No,k while G do if G<6423593-(-488401)then if G<281502+2768430 then if G<920247-(-514163)then if G<1790683-748407 then if G<528208-7829 then if G<348553-200323 then if G<-740453+833534 then if G<812295-735949 then G=true k={}N[X[-433878-(-433879)]]=G G=z[D(-67208+9737)]else G=14547985-(-11649)N[q]=k end else G=z[D(-851207-(-793789))]k={}end else if G<182551+16027 then G=-355903+1900019 else f=859240+10323820361311 C=D(-861266+803708)O=N[a]Z=N[q]G=569103+7173907 w=Z(C,f)A=O[w]v=A end end else if G<1379578-641732 then if G<817112+-234563 then G=N[X[732275+-732265]]q=N[X[-741105+741116]]d[G]=q G=N[X[976645-976633]]q={G(d)}G=z[D(-27752-29686)]k={p(q)}else e=850216+5522415915235 m=D(50294+-107829)T=G H=N[X[730334+-730333]]F=N[X[-915552-(-915554)]]I=F(m,e)U=H[I]a=d[U]G=a and 445726+5408265 or 553117+10172643 q=a end else if G<27793-(-720386)then G={}T=N[X[-811541-(-811550)]]q=-1035831-(-1035832)a=T d=G T=328233-328232 U=T T=-330993+330993 H=U<T G=11022765-(-1030605)T=q-U else I=e E=D(-490134-(-432610))r=z[E]E=D(-511614-(-454040))P=r[E]r=P(d,I)P=N[X[121367+-121361]]E=P()t=r+E l=t+H t=945835+-945579 u=l%t H=u E=889491+-889490 I=nil t=T[q]r=H+E P=a[r]l=t..P T[q]=l G=778218+5462677 end end end else if G<2239969-996231 then if G<777939+286540 then if G<-17146+1068719 then d=k G=not d G=G and 8507116-531003 or 739445+2925288 else G=e G=m and-949931+6450770 or 2176269-(-654036)k=m end else if G<1034197-(-36508)then e=16785133188447-(-567593)U=D(-668114+610563)m=D(720103+-777625)a=z[U]U=a(q)H=N[X[171478+-171477]]F=N[X[-390147+390149]]I=F(m,e)a=H[I]T=U==a k=T G=T and 753243+7496552 or-207291+3471301 else G=k and-976662+4585095 or 703318+1869927 end end else if G<929954-(-453488)then if G<-524108+1866996 then q=D(658376-715869)k=14005216-(-252588)T=416888+3166382 d=q^T G=k-d d=G k=D(-187193+129620)G=k/d k={G}G=z[D(-875395-(-817802))]else G=614533+12444330 U=a[T]k=U end else if G<1793954-404902 then q=N[X[922414-922412]]T=133092-133063 d=q*T q=21310833195595-447368 k=d+q d=72898+35184372015934 G=k%d N[X[853608-853606]]=G q=-23068+23069 d=N[X[162818-162815]]G=10805375-549455 k=d~=q else N[X[-135600+135605]]=k d=nil G=-416965+13779059 end end end end else if G<3497932-893083 then if G<-498208+2489116 then if G<596187+911373 then if G<-420671+1857600 then h=not v P=P+E k=P<=r k=h and k h=P>=r h=v and h k=h or k h=-735505+4386269 G=k and h k=2860554-(-1039629)G=G or k else T=485872+-485871 q=N[X[8978+-8975]]d=q~=T G=d and 14300716-917963 or-349805+10605725 end else if G<1438151-(-482354)then G=true G=G and 8484860-(-111501)or 774394+1201950 else G=z[D(-748154-(-690611))]k={}end end else if G<1848027-(-505888)then if G<2657911-401901 then G=a[T]k={G}G=z[D(-932994+875566)]else q=D(-876747+819249)k=-685780+9704592 T=546471-504817 d=q^T G=k-d d=G k=D(241769-299283)G=k/d k={G}G=z[D(324815+-382347)]end else if G<-494854+3022703 then k={q}G=z[D(-704192+646636)]else k=d G=d and 7127987-418118 or 7000576-895561 end end end else if G<-269182+3072057 then if G<-472999+3113884 then if G<-291946+2911083 then T=nil a=nil G=-299951+2735988 else u=D(-465502-(-407932))k={}m=z[u]G=z[D(933760-991313)]A=D(613370-670784)t=N[a]v=N[q]O=6417203368916-919592 h=v(A,O)l=t[h]u=m(l)end else if G<2508312-(-199770)then d=y[338901+-338900]q=y[142158-142156]G=N[X[-171639+171640]]T=G G=T[q]G=G and 2988854-(-359704)or-572107+5792049 else n=N[a]zo=17389189464507-(-581094)G=-849559+16088449 x=N[q]o=D(-93978-(-36483))c=x(o,zo)f=n[c]O=f end end else if G<3822906-896722 then if G<981445+1900462 then e=D(904777+-962258)G=952335+4548504 m=z[e]k=m else zo=D(-722759-(-665207))x=N[a]Do=19557981623997-(-134358)c=N[q]o=c(zo,Do)n=x[o]G=-124732+11873551 O=n end else if G<2825147-(-152422)then G=z[D(-295713+238132)]k={q}else G=-898959+10495490 end end end end end else if G<4458261-(-77435)then if G<562549+3127195 then if G<-843558+4349837 then if G<2744108-(-612933)then if G<-665953+3959341 then G=k and-700510+15290702 or-767502+3203539 else G=3594046-650458 end else if G<978323+2444945 then G=N[F]v=-732830-(-732836)E=-512928+512929 r=G(E,v)v=D(500414+-557923)G=D(622512-680021)z[G]=r E=z[v]v=-918023+918025 G=E>v G=G and 11918468-666382 or 7107141-591459 else l=D(-556809-(-499352))u=z[l]t=N[a]O=33575638119741-440363 A=D(-871417-(-813943))v=N[q]Z=461382+20480254089978 h=v(A,O)l=t[h]m=u[l]u=m()t=D(-341215-(-283758))O=D(-721822-(-664295))l=z[t]v=N[a]h=N[q]A=h(O,Z)t=v[A]m=l[t]Z=61982+10339461701808 w=-34905+15176399365108 O=D(-812697-(-755224))v=N[a]x=20535462783874-(-244184)h=N[q]A=h(O,Z)t=v[A]l=m(t,u)v=D(608096+-665539)n=D(-484015+426519)t=z[v]h=N[a]A=N[q]C=29520886997563-93321 Z=D(-320567-(-262969))O=A(Z,w)v=h[O]m=t[v]w=D(80175+-137770)t=W()N[t]=m h=D(1014528+-1071971)v=z[h]A=N[a]O=N[q]Z=O(w,C)O=D(-178533-(-121050))h=A[Z]m=v[h]h=G O=S[O]Z=N[t]O=O(S,Z)w=N[a]C=N[q]f=C(n,x)Z=w[f]A=O[Z]G=A and-257362+8000372 or-410108-(-927977)v=A end end else if G<3875349-248560 then if G<382786+3214191 then q=y[553594+-553592]G=q and-969599+9598566 or 37040+7565464 d=y[-58838+58839]else k=N[X[842997+-842996]]q=N[X[-174391-(-174393)]]U=-880869+8362862247963 I=D(-428492+370992)a=D(-548501-(-491021))T=q(a,U)m=915817+12774309535187 q=D(-139647+82141)G=k[T]k=z[q]U=N[X[-150622+150623]]H=N[X[987904+-987902]]F=H(I,m)a=U[F]q=D(-985397-(-927989))q=k[q]T=d[a]q=q(k,T)d[G]=q G=2323712-(-249533)end else if G<3072864-(-585075)then A=-469570+469670 Q=D(-985125-(-927561))h=W()O=235486-235231 N[h]=P k=z[Q]Q=D(-685866-(-628326))G=k[Q]Q=-668133-(-668134)k=G(Q,A)w=-3798-(-3799)Q=W()c=-349316-(-349316)N[Q]=k A=688169+-688169 C=121146+-121144 G=N[F]k=G(A,O)A=W()N[A]=k o=-71646-(-81646)G=N[F]Z=N[Q]O=249059+-249058 k=G(O,Z)O=W()f=D(717373+-774834)N[O]=k k=N[F]Z=k(w,C)k=64367-64366 G=Z==k k=D(-878237-(-820647))Z=W()C=D(-98854-(-41342))N[Z]=G K=z[f]n=N[F]x={n(c,o)}G=D(-65503-(-7919))f=K(p(x))K=D(916740+-974252)G=l[G]g=f..K w=C..g G=G(l,k,w)w=W()N[w]=G C=D(-664961-(-607471))k=z[C]g=V(110966+8795974,{F,h,e,T;q,t;Z,w;Q,O,A;m})C={k(g)}G={p(C)}C=G G=N[Z]G=G and 9119348-454293 or-164916+14834227 else T=N[X[975477+-975476]]u=459439+29366241538747 F=3739700767307-(-498818)a=N[X[624671-624669]]S=32526664150234-750000 K=19389510423923-1045039 l=21830564529219-531598 v=6409+13797409292303 m=819398+2184553546547 H=D(254941+-312485)e=31626697199893-743310 U=a(H,F)Q=D(-13690-43760)q=T[U]T=N[X[269861+-269858]]U=N[X[780373-780372]]H=N[X[-912070-(-912072)]]r=949746+14686590540996 I=D(253924-311353)i=D(-442081+384611)F=H(I,m)C=575447+10913644678147 E=D(-96736-(-39234))a=U[F]m=D(82185-139752)H=N[X[-145518-(-145519)]]F=N[X[-114795+114797]]I=F(m,e)e=D(386899-444347)U=H[I]F=N[X[540126+-540125]]I=N[X[64765+-64763]]m=I(e,S)H=F[m]m=N[X[800146+-800145]]e=N[X[419008-419006]]S=e(i,u)I=m[S]u=D(380335+-437836)e=N[X[1035032-1035031]]S=N[X[615442-615440]]i=S(u,l)m=e[i]F={[I]=m}i=D(-885253+827688)P=D(795788-853203)g=90631+21073670751310 m=N[X[-133179+133180]]u=24000756013000-(-21472)e=N[X[16198+-16196]]S=e(i,u)I=m[S]A=11737617815158-934173 m=N[X[240234+-240230]]u=N[X[-638518+638519]]l=N[X[210124-210122]]t=l(P,r)i=u[t]l=N[X[192648-192643]]u={l}w=17866694876038-768775 t=N[X[304094+-304093]]f=31852662146317-(-226531)P=N[X[-643609+643611]]r=P(E,v)l=t[r]r=D(-237565+180041)P=z[r]E=N[X[-627934-(-627935)]]v=N[X[906138+-906136]]h=v(Q,A)A=13810229833701-333511 Q=D(449992-507533)r=E[h]t=P[r]E=N[X[621805-621804]]e=D(-1049016-(-991524))v=N[X[-726114-(-726116)]]Z=D(-207035+149443)h=v(Q,A)r=E[h]v=N[X[-795767-(-795773)]]Q=N[X[146931-146930]]A=N[X[79436+-79434]]O=A(Z,w)h=Q[O]E=v[h]h=N[X[-8561-(-8567)]]w=D(-697269+639834)A=N[X[357210-357209]]O=N[X[458408+-458406]]Z=O(w,C)Q=A[Z]v=h[Q]Q=N[X[98440-98434]]C=D(760255-817789)O=N[X[-850173-(-850174)]]Z=N[X[647698+-647696]]w=Z(C,g)A=O[w]h=Q[A]A=N[X[268638-268632]]g=D(-170034-(-112614))Z=N[X[437626+-437625]]w=N[X[389828+-389826]]C=w(g,K)O=Z[C]Q=A[O]K=D(-910359+852828)O=N[X[-549016-(-549022)]]w=N[X[185292+-185291]]C=N[X[-359929-(-359931)]]g=C(K,f)Z=w[g]A=O[Z]O=N[X[244550-244543]]Z=N[X[936438+-936430]]w=N[X[30663-30654]]C=N[X[850986-850976]]g=N[X[43774+-43763]]P=t(r,E,v,h,Q,A,O,Z,w,C,g)S={[i]=u;[l]=P}e=m[e]e=e(m,S)k={[q]=T,[a]=U,[H]=F;[I]=e}G={d(k)}k={p(G)}G=z[D(525890-583420)]end end end else if G<4610692-499300 then if G<3721023-(-108794)then if G<-865806+4575789 then l=686749+22717466422965 H=a m=D(-281020+223469)I=z[m]m=I(F)u=D(962769+-1020316)e=N[X[-641233-(-641234)]]S=N[X[859995-859993]]i=S(u,l)I=e[i]G=m==I G=G and 7765351-880860 or 8074+13542255 else x=-960000-(-960002)n=C[x]x=N[w]f=n==x g=f G=-352199+9935643 end else if G<4872609-929904 then r=N[q]P=r G=r and-891258+11882034 or 4936483-(-138821)else zo=D(-997913+940501)o=z[zo]Do=N[a]po=D(197031-254448)Xo=9593880803726-(-186341)yo=N[q]Go=yo(po,Xo)zo=Do[Go]G=-48116+9200083 c=o[zo]n=c end end else if G<5322554-967792 then if G<-284217+4607717 then G=n G=f and 38111+15200779 or 813611+1979241 O=f else G=-451316+13827874 f=238000+-237999 K=C[f]g=K end else if G<3984044-(-466915)then d=y[1031137+-1031136]G=d and-245996-(-829376)or 450505-(-783709)k=d else a=D(-665486-(-608026))G=-255339+8847738 T=z[a]d=T end end end end else if G<364163+5625538 then if G<69256+5344759 then if G<366074+4732957 then if G<-942884+5574392 then G=12663711-757986 else N[q]=P G=N[q]G=G and 4939942-396601 or-288518+6555447 end else if G<4236303-(-944715)then q=G a=D(856515-913926)T=z[a]d=T G=T and-935317+9527716 or-847163+5378567 else F=147212+-146957 U=-637907+35184372726739 G={}e=1016821+-1016820 I=D(-39346+-18178)N[X[713861+-713859]]=G k=N[X[77902-77899]]a=k k=q%U N[X[-63769+63773]]=k H=q%F F=-538492+538494 U=H+F S=e e=-709415+709415 N[X[-921052-(-921057)]]=U F=z[I]I=D(-283837+226312)i=S<e H=F[I]F=H(d)H=D(473759+-531238)m=F T[q]=H H=-990309+990482 I=31143+-31142 e=I-S G=-355806+6596701 end end else if G<-713258+6262658 then if G<700843+4792216 then G=q k=d G=d and 2015480-970231 or 5902353-794754 else m=W()N[m]=k S=-650276+650341 l=L(3328945-1030424,{})G=N[F]e=618381+-618378 E=D(671516+-728977)k=G(e,S)G=344945-344945 e=W()S=G N[e]=k G=-90658-(-90658)i=G u=D(-80850+23360)k=z[u]u={k(l)}k=1040187-1040185 G={p(u)}u=G G=u[k]k=D(-822901+765396)l=G G=z[k]t=N[T]r=z[E]E=r(l)r=D(-784418-(-726828))P=t(E,r)t={P()}k=G(p(t))t=W()N[t]=k k=-639049-(-639050)G=-801364+2236456 P=N[e]r=P P=-124003+124004 E=P P=261255-261255 v=E<P P=k-E end else if G<-279560+6171553 then i=D(732007-789446)H=D(-830386+772835)U=z[H]m=N[X[1034655-1034654]]u=222865+30280186548355 G=10188693-(-537067)e=N[X[-336730+336732]]S=e(i,u)I=m[S]S=30756083742457-(-360696)F=d[I]e=D(-609958+552537)H=U(F)F=N[X[-159567+159568]]I=N[X[-72569+72571]]m=I(e,S)U=F[m]a=H==U q=a else t=828713-828712 v=#u l=T(t,v)G=856647+11219680 t=H(u,l)A=373921+-373920 v=N[i]Q=t-A h=F(Q)l=nil v[t]=h t=nil end end end else if G<7181748-647403 then if G<-982806+7223886 then if G<146425+6050775 then G=k and-734962+15649342 or 145166+15851020 else u=not i e=e+S I=e<=m I=u and I u=e>=m u=i and u I=u or I u=78984+843748 G=I and u I=-729421+10639730 G=G or I end else if G<6727949-358501 then G=true G=11769206-(-718226)else v=D(-901774-(-844265))G=z[v]v=D(973966-1031487)z[v]=G G=7624692-115876 end end else if G<-24237+6700069 then if G<7466706-878645 then l=t A=l G=190563+12289443 u[l]=A l=nil else a=D(-826745-(-769339))T=z[a]q=G G=T and-883159+17355958 or 5029131-(-438761)d=T end else if G<329583+6449190 then m=D(404108-461612)T=G H=N[X[-878517+878518]]e=305963+25941110981636 F=N[X[-198234+198236]]I=F(m,e)U=H[I]a=d[U]q=a G=a and 10257856-(-953081)or-745419+16084255 else I=D(-34958-22548)G=z[I]I=D(-314392+256984)I=G[I]I=I(G,F)G=-702842+14253171 q[H]=I end end end end end end else if G<11703594-(-47984)then if G<802007+8751817 then if G<-368165+8528733 then if G<8242540-627658 then if G<6681243-(-551257)then if G<7836400-741298 then a=N[X[899132+-899131]]I=331414+3922258983052 q=y[-1039314+1039316]U=N[X[-595924-(-595926)]]d=y[10404+-10403]F=D(857369+-914768)H=U(F,I)T=a[H]k=d[T]G=not k G=G and 15032057-(-370650)or 331508-(-734419)else d=N[X[41748-41747]]k=#d d=469932+-469932 G=k==d G=G and-865476+2250937 or 9754915-(-260724)end else if G<313371+7255515 then G=-306167+9902698 else G=N[X[152911+-152908]]T={G(d,q)}k={p(T)}G=z[D(-943121-(-885675))]end end else if G<530277+7242441 then if G<8357783-627496 then G=true G=G and 428330+2549845 or 12808334-320902 else n=15651360933136-714904 x=-590614+8570248516268 G=h h=W()N[h]=v O=D(254411-311935)f=D(-1072790-(-1015210))c=23265428815479-(-994266)Do=4614879320003-(-274593)A=z[O]Z=N[a]w=N[q]C=w(f,n)O=Z[C]f=D(-650969+593520)n=547962658088-(-41943)v=A[O]Z=N[a]w=N[q]C=w(f,n)O=Z[C]Z=N[t]A=v(O,Z)Z=D(547785+-605309)n=D(-512867-(-455331))O=z[Z]w=N[a]C=N[q]f=C(n,x)Z=w[f]x=9519065065838-153630 v=O[Z]n=D(-438908+381362)w=N[a]C=N[q]f=C(n,x)Z=w[f]w=N[t]O=v(Z,w,m)v=W()N[v]=O x=D(-345006+287410)w=D(209773-267297)Z=z[w]C=N[a]f=N[q]n=f(x,c)w=C[n]O=Z[w]C=N[a]zo=D(97289+-154783)f=N[q]x=D(-90704-(-33217))c=14092664527226-(-163880)n=f(x,c)w=C[n]f=N[i]x=N[a]c=N[q]o=c(zo,Do)n=x[o]c=D(-238724-(-181312))C=f[n]Z=O(w,C)x=-323874+18837142131557 w=N[a]n=D(-386182-(-328633))C=N[q]f=C(n,x)n=G O=w[f]w=W()N[w]=O C=G x=z[c]G=x and 9902128-(-597546)or 4038103-(-259670)f=x end else if G<766160+7209649 then q=N[X[-730684-(-730686)]]T=N[X[-434046+434049]]G=-663945+14311281 d=q==T k=d else k=D(-850672+793102)F=-11912+1584232116585 G=z[k]H=D(-44532+-13007)T=N[X[605639+-605638]]a=N[X[87500-87498]]U=a(H,F)q=T[U]k=G(q)k={}G=z[D(640454+-697888)]end end end else if G<-652639+9273746 then if G<-665137+9190400 then if G<7521253-(-683579)then H=nil Z=D(-1021398+963945)T=nil u=nil l={}h=W()Q=D(369606-427065)A={}t=W()f=nil N[t]=l v=j(571993+6553679,{t;m;e;U})l=W()N[l]=v v={}F=nil N[h]=v v=z[Q]w=N[h]C=D(-857432-(-799844))H=D(914864-972341)U=M(U)O={[Z]=w;[C]=f}I=nil Q=v(A,O)v=V(-60367+2767849,{h,t,i;m,e;l})e=M(e)S=nil h=M(h)m=M(m)S=599278862363-1048324 i=M(i)l=M(l)t=M(t)e=D(-904841+847328)N[a]=Q N[q]=v U=z[H]H=U()F=N[a]I=N[q]m=I(e,S)U=F[m]T=H[U]G=T and 15326441-168012 or-686817+15314364 else i=D(-162208+104649)u=149926+9040632186571 U=-455460+455461 a=D(-566886-(-509461))m=N[X[-137038-(-137039)]]e=N[X[697396+-697394]]S=e(i,u)a=q[a]e=D(976715+-1034291)I=m[S]F=d[I]H=#F S=10196001230221-(-17662)a=a(q,U,H)F=N[X[-697896-(-697897)]]I=N[X[994395+-994393]]m=I(e,S)H=F[m]G=3350829-86819 U=d[H]T=a==U k=T end else if G<76640+8516560 then G=q k=d G=215426-(-829823)else k=D(-452392-(-394883))G=z[k]d=D(364910-422431)k=z[d]d=D(555932+-613453)z[d]=G G=995860+548256 d=D(49276-106785)z[d]=k d=N[X[678639+-678638]]q=d()end end else if G<9145315-354614 then if G<428661+8224764 then k=D(-621283-(-563775))G=z[k]U={G(q)}a=U[525776-525773]G=-1028474+10919645 k=U[853150+-853149]T=U[1028655-1028653]U=k else g=N[q]k=g G=g and 14120513-(-718637)or 543817+-452411 end else if G<8793291-(-196109)then a=561225+-561224 q=N[X[-125936+125937]]U=1038238-1038236 T=q(a,U)q=-590064+590065 d=T==q G=d and 13012474-(-634862)or-640403+8613019 k=d else O=n G=x G=n and 11126787-(-622032)or-817501+3732844 end end end end else if G<68150+10261421 then if G<10627225-728161 then if G<8665598-(-965983)then if G<-217265+9813216 then k=g G=K G=-194145+285551 else G=true G=G and-236658+3603771 or 455952+-347393 end else if G<-533930+10323896 then G=721931+685400 T=N[X[429808-429802]]q=T==d k=q else a,F=U(T,a)G=a and-229963+3933405 or 15223214-(-222038)end end else if G<9254186-(-804061)then if G<330685+9608941 then F=nil H=nil a=nil G=3827894-884306 else T=D(512389-569787)q=z[T]T=D(234060+-291526)d=q[T]G=z[D(-14462+-43120)]T=N[X[138408-138407]]q={d(T)}k={p(q)}end else if G<-713443+10965757 then m=Y(1162552-(-83023),{})I=D(644932-702422)k=D(360598-418103)G=z[k]d=N[X[-968406+968410]]a=D(-469439-(-411978))T=z[a]F=z[I]I={F(m)}F=509452-509450 H={p(I)}U=H[F]a=T(U)T=D(-319174-(-261584))q=d(a,T)d={q()}k=G(p(d))d=k q=N[X[856055-856050]]k=q G=q and-842859+10509172 or 2060395-653064 else T=1008176+-1007988 q=N[X[318180+-318177]]d=q*T q=997259-997002 k=d%q G=-971399+2465420 N[X[-840624-(-840627)]]=k end end end else if G<10884510-(-166415)then if G<10111809-(-827196)then if G<10354858-(-227824)then o=D(-509662-(-452250))c=z[o]zo=N[a]G=-870865+5168638 po=22455526104631-30047 Do=N[q]Go=D(-316316+258768)yo=Do(Go,po)o=zo[yo]x=c[o]f=x else G=T G=252070-(-982144)k=q end else if G<289062+10687561 then F=D(615018+-672524)i=D(602318+-659787)H=R(-1016512+8096622,{a;q})F=z[F]I=D(-368349+310941)F[I]=H u=33430799764914-954595 I=D(744371+-801909)F=z[I]m=N[a]e=N[q]S=e(i,u)I=m[S]H=F[I]t=11255099146891-208402 F=W()u=29052075806248-(-992944)i=D(-938421-(-881018))h=D(585152-642603)l=D(754206-811697)N[F]=H I=D(-705427+647889)H=z[I]m=N[a]e=N[q]S=e(i,u)I=m[S]e=D(30303+-87715)m=J(3538793-7024,{a,q;F})H[I]=m H=R(-1038657+5419853,{a;q})m=z[e]A=11536194510786-674503 I=H(m)m=D(-401263-(-343866))I=z[m]S=N[a]i=N[q]u=i(l,t)e=S[u]u=D(558061-615473)i=z[u]l=N[a]t=N[q]v=t(h,A)u=l[v]A=-664167+15604467613385 S=i[u]m=I(e,S)l=D(-840954-(-783412))m=D(73753+-131150)I=z[m]S=N[a]h=D(-631883+574482)i=N[q]t=13217067573849-215631 u=i(l,t)e=S[u]u=D(-662480+605068)i=z[u]l=N[a]t=N[q]v=t(h,A)u=l[v]l=D(-920881-(-863287))S=i[u]m=I(e,S)v=34527899952980-(-153466)m=D(423824+-481267)t=33014638133742-(-506399)I=z[m]h=4287394493204-125768 S=N[a]m=D(-194181+136609)i=N[q]u=i(l,t)e=S[u]m=I[m]t=D(734963-792452)m=m(I,e)I=W()e=D(-707006-(-649563))N[I]=m m=z[e]i=N[a]u=N[q]e=D(-485322+427750)e=m[e]l=u(t,v)S=i[l]e=e(m,S)S=D(368508-425951)m=z[S]S=D(-1009632+952060)u=N[a]l=N[q]v=D(64008+-121579)S=m[S]t=l(v,h)v=D(-522186-(-464660))h=33613915624878-(-845686)i=u[t]S=S(m,i)u=N[a]l=N[q]t=l(v,h)i=u[t]m=e[i]i=W()N[i]=m u=N[i]m=not u G=m and-879732+3499215 or 671355+2813445 else r=S==i P=r G=5156498-81194 end end else if G<-455170+11744385 then if G<10432027-(-810255)then H=D(-849083+791532)U=z[H]u=-776378+32286828565364 m=N[X[933238-933237]]e=N[X[702246-702244]]G=334096+15004740 i=D(-928493-(-871009))S=e(i,u)e=D(681811+-739227)I=m[S]S=19704097223200-708169 F=d[I]H=U(F)F=N[X[-4145-(-4146)]]I=N[X[573386+-573384]]m=I(e,S)U=F[m]a=H==U q=a else E=D(695611-753072)h=D(-537350-(-479829))G=z[E]v=z[h]E=G(v)G=D(417525-475034)z[G]=E G=6847995-(-660821)end else if G<519737+11028072 then k=D(778042-835629)G=z[k]d=D(-190292+132795)k=G(d)k={}G=z[D(-437501-(-379916))]else zo=D(-10183+-47284)G=f Go=-878520+17969552918631 bo=13164013201801-(-192104)f=W()N[f]=O ko=236661+31186619161669 x=N[a]c=N[q]jo=33310228894474-431731 Xo=D(475372+-532917)Do=1908914022539-(-432877)o=c(zo,Do)To=-986938+28507407057684 Bo=D(-613651+556091)Yo=D(-564305-(-506861))n=x[o]yo=-833850+20711402151654 Do=D(211599+-269006)c=N[a]Mo=-9462+13803288526353 Wo=28768479937560-(-405564)o=N[q]zo=o(Do,yo)x=c[zo]o=N[a]so=32288198250333-218274 yo=D(213889-271446)zo=N[q]Do=zo(yo,Go)c=o[Do]Do=D(-597218-(-539694))zo=z[Do]yo=N[a]Go=N[q]Vo=-871857+11439168397951 po=Go(Xo,bo)Do=yo[po]o=zo[Do]yo=N[a]Xo=D(753774+-811215)Go=N[q]H=nil bo=32247595238392-84304 po=Go(Xo,bo)ao=D(97194+-154682)Do=yo[po]Go=N[i]Xo=N[a]bo=N[q]No=bo(Bo,ko)po=Xo[No]yo=Go[po]ko=D(896438+-953961)qo=D(263329+-320884)po=N[i]bo=N[a]No=N[q]Bo=No(ko,Wo)Xo=bo[Bo]Bo=D(-913181+855671)Go=po[Xo]ko=33055874551653-(-175291)Xo=30077861182895-(-522503)zo=o(Do,yo,Go)Do=N[a]yo=N[q]po=D(-938984-(-881526))bo=D(808759+-866199)No=30530146410157-(-989403)Go=yo(po,Xo)o=Do[Go]Do=-336675+17090595 T=nil Go=N[a]po=N[q]Xo=po(bo,No)yo=Go[Xo]Xo=N[a]bo=N[q]No=bo(Bo,ko)po=Xo[No]bo=N[i]Bo=N[a]ko=N[q]Wo=ko(qo,To)To=31447140833037-531930 No=Bo[Wo]Xo=bo[No]No=N[a]qo=-748043+1762978491711 Bo=N[q]Wo=D(-679051-(-621552))ko=Bo(Wo,qo)bo=No[ko]Bo=N[a]qo=D(-738142+680678)ko=N[q]Wo=ko(qo,To)No=Bo[Wo]Wo=D(554229-611753)ko=z[Wo]qo=N[a]e=nil To=N[q]Uo=To(ao,Mo)ao=D(-72265+14747)Mo=-338501+12102439862344 Wo=qo[Uo]Bo=ko[Wo]qo=N[a]To=N[q]Uo=To(ao,Mo)Jo=D(707179-764776)Wo=qo[Uo]To=N[i]ao=N[a]Mo=N[q]Lo=Mo(Jo,Vo)Uo=ao[Lo]qo=To[Uo]ko=Bo(Wo,qo)To=32637902588410-36508 qo=D(279767-337193)Bo=D(87896-145372)Go={[po]=Xo,[bo]=Z,[No]=ko}ko=2119+8139803313799 Xo=N[a]bo=N[q]No=bo(Bo,ko)F=M(F)ao=875607+23791162674927 Ro=D(-768959-(-711494))po=Xo[No]Lo=D(-593280+535689)Bo=N[a]ko=N[q]Jo=761424+33185864490509 Uo=21762987944157-(-802489)Wo=ko(qo,To)No=Bo[Wo]ko=N[a]To=D(408502-466030)Wo=N[q]qo=Wo(To,Uo)Bo=ko[qo]Uo=D(-793475+736043)Wo=N[a]qo=N[q]To=qo(Uo,ao)ko=Wo[To]To=D(-682048+624524)qo=z[To]Uo=N[a]ao=N[q]Mo=ao(Lo,Jo)To=Uo[Mo]Wo=qo[To]Lo=D(-742390-(-684938))Uo=N[a]Jo=-925482+30333237614167 ao=N[q]Mo=ao(Lo,Jo)To=Uo[Mo]ao=N[i]Lo=N[a]Jo=N[q]Vo=Jo(Yo,jo)Mo=Lo[Vo]Uo=ao[Mo]Lo=-17467+21266922973930 ao=N[h]qo=Wo(To,Uo,Z,ao,A,u)To=N[a]Uo=N[q]Mo=D(966640+-1024050)ao=Uo(Mo,Lo)Jo=D(-655208-(-597630))Wo=To[ao]Uo=9241528449966-(-824609)Vo=31697055608484-259324 To=true bo={[No]=Bo;[ko]=qo,[Wo]=To}To=D(-515758+458229)ko=N[a]Wo=N[q]qo=Wo(To,Uo)Bo=ko[qo]ao=-681997+2740736634121 Wo=N[a]Yo=67255+34040216991540 Mo=341804+4919692317126 Uo=D(-390305-(-332820))qo=N[q]To=qo(Uo,ao)Fo=260860+30042464091049 ko=Wo[To]qo=N[a]ao=D(-544968-(-487449))To=N[q]Uo=To(ao,Mo)Wo=qo[Uo]Uo=D(783607-841131)To=z[Uo]ao=N[a]Mo=N[q]Lo=Mo(Jo,Vo)Jo=D(-744937+687492)Vo=-185074+20129926199183 Uo=ao[Lo]qo=To[Uo]ao=N[a]Mo=N[q]Lo=Mo(Jo,Vo)Uo=ao[Lo]ao=N[t]Mo=N[v]To=qo(Uo,m,ao,Mo)Uo=N[a]Lo=D(938922-996483)ao=N[q]Jo=14513574400537-751539 Mo=ao(Lo,Jo)qo=Uo[Mo]Uo=true ao=16070665551214-532531 No={[Bo]=ko;[Wo]=To;[qo]=Uo}Wo=N[a]qo=N[q]Mo=22038839480134-(-989392)Uo=D(234987-292564)To=qo(Uo,ao)ao=D(-166305+108819)ko=Wo[To]qo=N[a]To=N[q]Uo=To(ao,Mo)Lo=40603877862-1016276 Wo=qo[Uo]Mo=D(137329+-194766)To=N[a]Uo=N[q]Vo=D(226684-284250)ao=Uo(Mo,Lo)qo=To[ao]ao=D(-47579+-9945)Uo=z[ao]Mo=N[a]Lo=N[q]Jo=Lo(Vo,Yo)m=nil ao=Mo[Jo]To=Uo[ao]Mo=N[a]Lo=N[q]Vo=D(960267+-1017742)Yo=18481193270-(-581330)Jo=Lo(Vo,Yo)ao=Mo[Jo]Lo=N[i]Vo=N[a]Yo=N[q]jo=Yo(Ro,so)Jo=Vo[jo]Mo=Lo[Jo]Jo=N[i]Yo=N[a]so=D(687553-744972)jo=N[q]Ro=jo(so,Fo)Vo=Yo[Ro]Lo=Jo[Vo]Jo=D(-871323-(-813769))Uo=To(ao,Mo,Lo)ao=N[a]jo=232773+20504721364999 Mo=N[q]Vo=23063+28786962094661 Lo=Mo(Jo,Vo)To=ao[Lo]Jo=885940+26658463853513 ao=true Bo={[ko]=Wo;[qo]=Uo,[To]=ao}qo=N[a]Mo=-721389+27181688353630 To=N[q]Yo=D(249517+-307024)ao=D(-909666+852133)Uo=To(ao,Mo)Wo=qo[Uo]Mo=D(803711+-861228)To=N[a]Z=nil Lo=231895+25388239414359 Uo=N[q]ao=Uo(Mo,Lo)qo=To[ao]Uo=N[a]ao=N[q]Lo=D(325370-382886)Mo=ao(Lo,Jo)To=Uo[Mo]Mo=D(544736+-602260)ao=z[Mo]Lo=N[a]Jo=N[q]Vo=Jo(Yo,jo)Mo=Lo[Vo]jo=1048176+27151216341747 Yo=D(-880597+823135)Uo=ao[Mo]Lo=N[a]Jo=N[q]Vo=Jo(Yo,jo)Mo=Lo[Vo]Lo=N[C]Vo=D(-1024542-(-967088))Jo=N[f]Yo=321991+22921232613354 ao=Uo(Mo,Lo,Jo)Mo=N[a]Lo=N[q]Jo=Lo(Vo,Yo)Uo=Mo[Jo]Mo=true ko={[Wo]=qo,[To]=ao;[Uo]=Mo}ao=4069285757226-948676 Wo=D(731423+-788943)Xo={bo,No,Bo;ko}Lo=7263440834728-(-507022)S=nil Uo=D(616114-673541)qo=-970222+34308011084885 No=N[a]Bo=N[q]ko=Bo(Wo,qo)Jo=1522815944895-689658 bo=No[ko]ko=D(-903610-(-846086))Mo=D(-299001+241592)Bo=z[ko]Wo=N[a]qo=N[q]To=qo(Uo,ao)ko=Wo[To]ao=34360401128203-650379 No=Bo[ko]Wo=N[a]Uo=D(-369005+311542)qo=N[q]A=nil To=qo(Uo,ao)ko=Wo[To]To=N[a]jo=240273+34708680266897 Ro=16087882218192-515469 Uo=N[q]ao=Uo(Mo,Lo)qo=To[ao]Wo=l[qo]Uo=N[a]ao=N[q]k={}Lo=D(-569592-(-512006))Mo=ao(Lo,Jo)To=Uo[Mo]Vo=-44976+20939017164230 qo=l[To]Jo=D(351977-409401)ao=N[a]Mo=N[q]Lo=Mo(Jo,Vo)Yo=-651419+31054605543703 Uo=ao[Lo]To=l[Uo]Mo=N[a]Vo=D(517973+-575428)Lo=N[q]Jo=Lo(Vo,Yo)ao=Mo[Jo]Uo=l[ao]Lo=N[a]Jo=N[q]u=nil Yo=D(-868665-(-811076))Vo=Jo(Yo,jo)Mo=Lo[Vo]ao=l[Mo]Jo=N[a]jo=D(875569+-932974)Vo=N[q]Yo=Vo(jo,Ro)Lo=Jo[Yo]Mo=l[Lo]Bo=No(ko,Wo,qo,To,Uo,ao,Mo)Mo=20791232157820-799403 ko=N[a]Uo=29180460905192-(-344620)Wo=N[q]To=D(948889-1006371)qo=Wo(To,Uo)No=ko[qo]qo=N[a]l=nil ao=D(-956861+899438)To=N[q]Uo=To(ao,Mo)Jo=D(-605633-(-548065))Wo=qo[Uo]Uo=D(-992085-(-934561))Vo=150648+25329410843034 To=z[Uo]ao=N[a]Mo=N[q]Lo=Mo(Jo,Vo)Jo=D(1003905+-1061335)Vo=914752+31921196303568 Uo=ao[Lo]qo=To[Uo]ao=N[a]Mo=N[q]Lo=Mo(Jo,Vo)G=z[D(-524705-(-467263))]jo=2728387469592-318498 Uo=ao[Lo]ao=N[h]To=qo(Uo,ao)Uo=N[a]Jo=-262906+25710924280254 ao=N[q]Lo=D(-1084369-(-1026794))Mo=ao(Lo,Jo)Jo=D(-731844-(-674444))qo=Uo[Mo]Vo=-691214+21842094928841 ao=N[a]Mo=N[q]Lo=Mo(Jo,Vo)Mo=16866751388150-260936 Uo=ao[Lo]ko={[Wo]=To,[qo]=Uo}qo=N[a]To=N[q]ao=D(-864053-(-806631))Uo=To(ao,Mo)Wo=qo[Uo]Uo=N[a]Jo=164690+5040125396440 ao=N[q]Lo=D(-519735+462302)Mo=ao(Lo,Jo)To=Uo[Mo]Mo=D(-618346+560822)ao=z[Mo]Yo=D(-347954+290486)Lo=N[a]Jo=N[q]Vo=Jo(Yo,jo)Mo=Lo[Vo]jo=-735774+3721220227298 Uo=ao[Mo]Lo=N[a]Yo=D(-984987-(-927574))Jo=N[q]Vo=Jo(Yo,jo)Mo=Lo[Vo]Lo=N[t]ao=Uo(Mo,Lo)qo={[To]=ao}O={[n]=x;[c]=zo,[o]=Do,[yo]=Go,[po]=Xo,[bo]=Bo,[No]=ko,[Wo]=qo}n=W()N[n]=O x=D(-138532-(-81042))o=s(744573+5909418,{a;q;w,I,n;i,h;t,C;f,v})i=M(i)I=M(I)h=M(h)q=M(q)O=z[x]zo={O(o)}f=M(f)x=zo[-40188-(-40189)]t=M(t)w=M(w)C=M(C)a=M(a)n=M(n)c=zo[-399651+399653]x=nil v=M(v)c=nil end end end end end else if G<885391+13701616 then if G<12365092-(-1005878)then if G<514439+11812988 then if G<-1004884+12977368 then if G<-64629+11961564 then u=D(-305018-(-247620))i=z[u]u=D(-948129-(-890648))S=i[u]m=S G=1700794-641422 else i=nil F=M(F)T=M(T)F=D(41978+-99542)m=M(m)u=nil I=nil U=M(U)q=M(q)H=nil G=80224+12399782 l=nil i=W()m=D(-252907+195383)q=nil T=nil t=M(t)u={}I=D(-1033750+976352)S=nil a=M(a)e=M(e)H=D(-335411-(-277847))a=W()N[a]=q q=W()N[q]=T t=-676785-(-677041)U=z[H]H=D(-760698+703119)T=U[H]U=W()N[U]=T H=z[F]F=D(-61871-(-4331))S={}T=H[F]F=z[I]I=D(764206-821672)l=-308587+308588 H=F[I]I=z[m]m=D(-110032-(-52449))F=I[m]I=897804+-897804 m=W()N[m]=I I=-345918+345920 e=W()N[e]=I I={}N[i]=S S=82657+-82657 v=t t=121433+-121432 h=t t=895277-895277 Q=h<t t=l-h end else if G<-277111+12336524 then F=not H T=T+U q=T<=a q=F and q F=T>=a F=H and F q=F or q F=15844471-(-400783)G=q and F q=47691-(-534016)G=G or q else t=#u v=-721198-(-721198)l=t==v G=l and-358878+8551520 or 801712+5170056 end end else if G<-1008046+13827786 then if G<11983608-(-502230)then A=not Q t=t+h l=t<=v l=A and l A=t>=v A=Q and A l=A or l A=-246431+6808182 G=l and A l=1015768+13570570 G=G or l else G=V(-618178+810284,{a})r={G()}k={p(r)}G=z[D(-164157+106595)]end else if G<304414+12807883 then G=k and 2258340-65602 or 3392096-773151 else G=N[X[408052-408045]]G=G and 15856947-550563 or 658964+82605 end end end else if G<13036993-(-756613)then if G<13136089-(-345422)then if G<41424+13337547 then N[q]=g c=724273-724272 x=N[O]n=x+c f=C[n]K=S+f f=-842348+842604 G=K%f n=N[A]S=G f=i+n n=861263-861007 K=f%n G=13761614-(-798020)i=K else S=776366+-776353 T=-647638-(-647670)q=N[X[-53868+53871]]d=q%T m=-39358+39360 a=N[X[605054+-605050]]F=N[X[973067+-973065]]l=N[X[-843077+843080]]u=l-d l=-270054+270086 i=u/l e=S-i I=m^e H=F/I U=a(H)a=-714880+4295682176 I=-132687-(-132688)G=132872+9882767 T=U%a U=-1047804-(-1047806)a=U^d m=1040165+-1039909 q=T/a a=N[X[1037775-1037771]]F=q%I I=4295656511-689215 H=F*I U=a(H)a=N[X[-612254+612258]]H=a(q)T=U+H U=-205868+271404 a=T%U H=T-a F=-193308-(-258844)U=H/F q=nil F=-21028+21284 H=a%F S=-157496+157752 d=nil I=a-H F=I/m T=nil a=nil m=-877764-(-878020)I=U%m e=U-I m=e/S U=nil e={H,F,I,m}m=nil H=nil N[X[952895+-952894]]=e F=nil I=nil end else if G<13632918-29972 then H=nil G=10420933-529762 F=nil else G=k and 9346530-(-829208)or 445425+12916669 end end else if G<14542433-412019 then if G<13484973-(-592070)then F=D(-565764-(-508258))i=-234721+22050710420733 S=D(611277+-668792)H=z[F]I=N[a]m=N[q]e=m(S,i)F=I[e]U=H[F]T=U G=10614694-(-333950)else H=N[U]G=-573028+17085714 k=H end else if G<14026115-(-556991)then w=M(w)Z=M(Z)A=M(A)h=M(h)O=M(O)Q=M(Q)G=-888774+2323866 C=nil else v=367266+-367266 G=-524977+6496745 t=#u l=t==v end end end end else if G<288538+14978088 then if G<14888607-137840 then if G<199061+14440281 then if G<14177133-(-426754)then H=N[X[187351+-187350]]F=N[X[873816-873814]]m=D(205813-263249)e=76213+30331793902967 I=F(m,e)m=-907996+21314846327201 G=D(643543-700968)U=H[I]I=D(-489895-(-432493))a=d[U]G=q[G]T=#a a=-415698-(-415699)k=T+a G=G(q,k)U=N[X[40383+-40382]]H=N[X[-21112+21114]]F=H(I,m)a=U[F]T=G k=d[a]m=D(-336852+279380)H=N[X[-776083+776084]]F=N[X[675149+-675147]]e=15196871168811-(-608377)I=F(m,e)U=H[I]a=d[U]G=k[a]a=G G=a and-447265+1821898 or 12368611-(-690252)k=a else U=D(-661953+604476)T=z[U]U=T()m=D(-499494-(-441991))e=7073674021588-(-426505)H=N[a]F=N[q]S=D(400478+-458028)I=F(m,e)T=H[I]H=true U[T]=H T=nil F=D(360457-417963)H=z[F]I=N[a]i=-454694+29288243750252 m=N[q]e=m(S,i)F=I[e]U=H[F]G=U and 14708266-631294 or 10916980-(-31664)end else if G<903537+13755269 then T=D(-981380+923856)U=W()d=y q=W()G=true N[q]=G k=z[T]T=D(-545648-(-488170))a=W()I=V(-49460-(-90437),{U})G=k[T]T=W()N[T]=G G=J(940748+10464772,{})F=D(-629466+571976)N[a]=G G=false N[U]=G H=z[F]F=H(I)G=F and 13458770-(-619257)or 16398516-(-114170)k=F else K=N[q]G=K and-575614+4909348 or 13349197-(-27361)g=K end end else if G<15562968-490604 then if G<15059765-172097 then K=G x=-23858+23859 n=C[x]x=false f=n==x G=f and 379890+3330355 or 8676695-(-906749)g=f else k=N[X[150554+-150553]]m=33595942544840-174252 U=177600+11117520150136 a=D(-328774-(-271263))q=N[X[-337821+337823]]T=q(a,U)q=D(-129846-(-72340))I=D(-706142-(-648573))G=k[T]k=z[q]U=N[X[-455743+455744]]H=N[X[-674233-(-674235)]]F=H(I,m)a=U[F]q=D(-407396+349988)T=d[a]q=k[q]q=q(k,T)d[G]=q G=16931228-935042 end else if G<-779201+16016847 then k={}G=z[D(-1026849-(-969402))]else G=C o=D(-234572-(-177160))C=W()x=G N[C]=O c=z[o]f=G n=c G=c and 626218+3415586 or 753950+8398017 end end end else if G<15097031-(-855382)then if G<14441746-(-935520)then if G<14654201-(-663596)then d=D(-802242-(-744655))G=z[d]q=N[X[219540+-219532]]T=-307153-(-307153)d=G(q,T)G=778776+-37207 else G=T k=q G=5218156-(-886859)end else if G<381505+15046075 then G=z[D(663995+-721451)]k={q}else G=8245351-642847 end end else if G<1009996+15427228 then if G<16289141-264705 then G=z[D(452944+-510348)]k={}d=nil else q=T I=368107-368107 G=N[X[3021-3020]]m=-139975+140230 F=G(I,m)G=-279500+12332870 d[q]=F q=nil end else if G<361650+16151000 then U=D(-1028530-(-971124))m=D(-316880+259484)a=z[U]H=N[X[739594+-739593]]F=N[X[587918+-587916]]e=5080727531588-(-907513)I=F(m,e)U=H[I]T=a[U]G=4907313-(-560579)d=T else H=k F=D(342845-400409)k=z[F]F=D(-817015-(-759475))G=k[F]F=W()i=D(697821+-755219)N[F]=G I=D(-354877-(-297479))k=z[I]I=D(-338425-(-280888))G=k[I]e=G S=z[i]m=S I=G G=S and 11600625-(-151870)or-736449+1795821 end end end end end end end end G=#b return p(k)end,function(z,D)local p=T(D)local y=function()return G(z,{},D,p)end return y end,function(z,D)local p=T(D)local y=function(y,X,b)return G(z,{y,X,b},D,p)end return y end,{},562266+-562266,function(z)local D,G=650756-650755,z[-531929-(-531930)]while G do d[G],D=d[G]-(-129537-(-129538)),D+(-438474-(-438475))if d[G]==-814761+814761 then d[G],N[G]=nil,nil end G=z[D]end end,function(z,D)local p=T(D)local y=function(...)return G(z,{...},D,p)end return y end,function(z)d[z]=d[z]-(-822278+822279)if-196553+196553==d[z]then d[z],N[z]=nil,nil end end,function(z,D)local p=T(D)local y=function(y,X)return G(z,{y,X},D,p)end return y end,function(z,D)local p=T(D)local y=function(y)return G(z,{y},D,p)end return y end,function()q=(906785-906784)+q d[q]=538372+-538371 return q end,{},function(z,D)local p=T(D)local y=function(y,X,b,B,k,N)return G(z,{y;X,b,B,k,N},D,p)end return y end,function(z,D)local p=T(D)local y=function(y,X,b,B,k)return G(z,{y;X;b;B,k},D,p)end return y end return(U(14553568-(-104918),{}))(p(k))end)(getfenv and getfenv()or _ENV,unpack or table[D(813026+-870507)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
