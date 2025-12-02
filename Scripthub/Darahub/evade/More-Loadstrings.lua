
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
--[[ v1.0.0 https://wearedevs.net/obfuscator ]] return(function(...)local y={"\084\073\080\101\072\087\110\055","\080\111\107\083\115\053\052\122\068\087\098\101\120\119\115\053","\068\118\121\061";"\068\118\105\061";"\075\111\084\110\068\109\061\061";"\084\048\065\069\068\073\115\047";"\108\085\080\052\065\073\121\112\068\085\116\108\080\085\085\101\075\106\061\061";"\115\043\070\069\115\108\061\061";"\050\116\081\055\071\112\061\061";"\107\050\065\090\087\067\080\115\115\118\065\088\084\119\047\083\085\109\061\061","\068\074\065\078","\102\054\106\047\115\089\113\117\102\106\061\061","\102\106\061\061";"\071\055\047\053\115\108\061\061";"\068\074\081\083\115\067\100\053\084\048\047\078\115\112\061\061";"\065\074\070\069\084\074\065\101\105\121\080\047\107\074\065\119\107\074\065\111\105\108\061\061";"\084\043\065\053\068\087\065\053\071\050\080\083\071\048\052\047","\075\087\100\053\065\118\106\073\071\055\070\078\068\118\070\048\084\065\108\061","\085\111\065\098\088\097\083\104\065\074\100\104\049\053\107\116\107\085\084\061";"\080\043\115\057\115\085\116\057\120\070\057\050\107\070\100\122\065\116\049\061";"\107\074\081\078\107\087\116\054\115\050\105\061","\102\070\085\061","\084\074\100\083\068\074\112\061";"\107\074\081\097\107\067\057\117\068\048\084\061";"\080\074\052\048\087\047\083\075\071\048\116\067\085\043\047\087","\071\043\083\083\084\106\061\061";"\107\087\110\112\071\087\100\086";"\050\116\081\098\115\087\090\061";"\072\053\052\100\085\067\085\112\065\050\117\088\100\047\099\097\049\065\085\061";"\068\087\070\053\072\109\061\061","\065\048\080\089\049\119\080\069\115\047\057\067\075\048\070\108\087\109\061\061","\071\043\081\078\071\043\070\053";"\115\043\116\083\107\074\100\113";"\075\067\080\053\084\121\107\047\107\109\061\061","\050\116\081\069\115\050\080\083\107\074\070\054\068\074\085\061";"\052\088\066\104\056\065\085\043\055\057\101\052\113\090\090\053\101\070\116\077\087\050\107\085\115\081\085\070\098\101\065\099\047\098\057\089\073\100\122\107\085\078\076\084\088\048\043\047\114\065\112\070\065\101\079\043\077\071\099\049\087\099\065\119\119\079\056\107\067\085\049\054\081\056\047\084\117\090\102\071\080\048\112\050\053\112\114\049\113\110\084\084\054\085\120\099\121\070\115\106\084\082\071\098\076\076\081\068\055\106\115\071\043\069\114\111\099\076\043\118\118\073\090\107\055\115\087\049\055\112\069\118\071\076\115\106\098\047\104\076\078\098\074\116\076\115\069\108\107\066\119\072\104\105\071\043\111\055\102\097\108\056\119\074\110\069\053\114\074\115\053\104\104\117\075\106\109\047\055\112\106\052\097\114\106\043\109\065\081\082\057\076\051\054\115\073\115\072\070\104\050\083\073\071\053\120\083\080\087\086\078\057\067\083\112\085\075\076\116\110\089\114\049\121\066\082\078\077\047\114\077\108\108\053\107\103\106\084\082\090\080\099\067\051\113\106\087\085\049\111\097\076\122\048\056\084\056\048\119\120\076\086\113\061";"\065\111\108\097\115\097\047\116\084\097\047\074\102\050\100\050\088\108\061\061";"\100\043\080\121\068\106\061\061","","\115\048\052\122\068\073\105\061","\107\074\070\054\068\074\085\061","\084\070\099\073\108\055\100\122\108\087\080\057\115\053\111\101\102\109\061\061","\085\074\083\075\075\119\065\053\087\047\083\119\065\116\109\043\088\112\061\061","\050\116\081\117\068\048\080\047\120\109\061\061";"\084\048\070\078\115\074\081\069";"\115\073\100\116\071\106\061\061","\115\050\057\101\068\073\105\061"}local function l(l)return y[l-(259083-220761)]end for l,p in ipairs({{-196806-(-196807),-664361-(-664408)};{254749-254748,-120982-(-121014)};{514370+-514337,441732-441685}})do while p[644923-644922]<p[-102258+102260]do y[p[-543143-(-543144)]],y[p[290438-290436]],p[-804700-(-804701)],p[955429+-955427]=y[p[382695+-382693]],y[p[848569+-848568]],p[189843-189842]+(418210+-418209),p[-870488-(-870490)]-(570110-570109)end end do local l=type local p=y local P={a=-833011-(-833062);["\043"]=-18435+18489,["\055"]=-282682-(-282721);J=236733+-236727,L=344405-344345,v=163390-163387;P=558259-558242,["\047"]=598696+-598659;E=-92968+93013;t=-629138+629191,p=-797322-(-797370),T=404859-404831;["\051"]=1018162+-1018151,["\052"]=900380-900331;I=-706270+706325,F=-292946+292951,f=449567+-449553;["\057"]=-567292+567301,["\054"]=124589-124555,H=667000-666974;r=74707+-74697;K=472498+-472480;R=-476746+476804,A=-938673-(-938694);["\049"]=457035+-457023,q=-985427+985467,w=-208541-(-208576),u=-598175+598216,["\048"]=-609801-(-609839),["\056"]=385593-385531,U=-5353-(-5373);y=-270714+270718;b=744304-744260,d=401186+-401173,i=237062-237054,D=956880+-956853;c=161944+-161943,o=-234757+234793;m=-252696-(-252696),["\050"]=818281-818258,C=915112-915105;h=-1044753+1044795;j=-906838-(-906870);z=-649235+649282,s=360331-360306,e=-114202+114252;V=848844+-848801,W=843574-843552,Y=-758758+758760,k=-294918+294947,S=1045304-1045271,x=49176+-49146;X=827519+-827500,n=-669784-(-669841),M=-820428-(-820487),O=-80611+80642;g=741957+-741942,G=346453+-346429;Q=830890-830829;["\053"]=-620609-(-620661),N=-349847+349893,l=1022513-1022497;Z=871636+-871580,B=-25108-(-25171)}local G=math.floor local n=string.sub local g=string.char local x=string.len local H=table.concat local b=table.insert for y=136468-136467,#p,-361481-(-361482)do local I=p[y]if l(I)=="\115\116\114\105\110\103"then local l=x(I)local j={}local U=688071-688070 local w=432709+-432709 local s=397197+-397197 while U<=l do local y=n(I,U,U)local p=P[y]if p then w=w+p*(-179543+179607)^((1381+-1378)-s)s=s+(97711-97710)if s==-499536+499540 then s=780746-780746 local y=G(w/(726814-661278))local l=G((w%(-892002-(-957538)))/(-618797-(-619053)))local p=w%(246423-246167)b(j,g(y,l,p))w=-865917+865917 end elseif y=="\061"then b(j,g(G(w/(-529105-(-594641)))))if U>=l or n(I,U+(665695-665694),U+(826189-826188))~="\061"then b(j,g(G((w%(880170-814634))/(-141588-(-141844)))))end break end U=U+(695360-695359)end p[y]=H(j)end end end return(function(y,P,G,n,g,x,H,I,N,U,L,r,F,M,j,k,w,s,b,p)w,p,s,L,F,j,r,b,k,M,U,N,I=function(y)for l=-224117-(-224118),#y,400266-400265 do I[y[l]]=(721922+-721921)+I[y[l]]end if G then local p=G(true)local P=g(p)P[l(-288308+326659)],P[l(-878962+917325)],P[l(162384+-124049)]=y,s,function()return-434078+-1626161 end return p else return n({},{[l(-401449+439812)]=s,[l(96170+-57819)]=y;[l(468468-430133)]=function()return-1982477-77762 end})end end,function(p,G,n,g)local s,V,T,u,v,d,f,z,U,A,o,q,J,O,e,Y,a,C,H,Z,h,W,E,w,I,c,K,i,S,B,F,D,m,t while p do if p<8412954-729657 then if p<4186852-(-848384)then if p<-846775+2669010 then if p<916087-(-90789)then if p<-474136+1314526 then if p<-329071-(-757509)then if p<908509+-836391 then H={}p=y[l(-821518+859882)]else H=16371927-452553 U=l(601862-563503)w=6391117-(-289197)I=U^w p=H-I H=l(519991-481646)I=p p=H/I H={p}p=y[l(-123623+161961)]end else w=w+F U=w<=s m=not O U=m and U m=w>=s m=O and m U=m or U m=-245799+15623337 p=U and m U=-860948+8526618 p=p or U end else if p<471589-(-459356)then p=true b[n[-756517-(-756518)]]=p H={}p=y[l(-609719-(-648055))]else z=b[U]p=z and 7872049-(-591851)or-450418+11132085 T=z end end else if p<990507-(-354993)then if p<-206393+1323883 then D=-167142+167143 C=856820-856814 p=b[m]V=p(D,C)C=l(686016+-647658)p=l(-717418+755776)y[p]=V D=y[C]C=-619786+619788 p=D>C p=p and 6655229-(-1029382)or 2523655-549891 else p=z p=12775863-238675 H=T end else if p<215276+1260550 then p=-541363+12188977 v=l(-480299+518633)i=y[v]H=i else b[n[-750669+750674]]=H p=479837+3376045 I=nil end end end else if p<402978+2987391 then if p<3124135-282468 then if p<768915+1863125 then if p<216480+1798681 then C=l(172158+-133800)p=y[C]C=l(-973105+1011462)y[C]=p p=2928319-(-28029)else p=true p=p and-996522+13477691 or 16161626-945965 end else V=b[U]E=V p=V and 6114850-(-519729)or 634185+9577060 end else if p<961395+2312211 then p=935148+10950853 else D=l(281224+-242869)A=v V=y[D]D=l(631531-593163)E=V[D]V=E(I,A)p=12507225-395268 A=nil E=b[n[495577+-495571]]D=E()o=V+D Y=o+O o=-302254-(-302510)d=Y%o O=d o=w[U]D=-417897+417898 V=O+D E=s[V]Y=o..E w[U]=Y end end else if p<776340+3478487 then if p<2715570-(-971944)then d=l(-242253+280601)u=y[d]d=l(-524854+563188)S=u[d]i=S p=210+4432768 else p=b[n[252469-252462]]p=p and-268723+15226859 or 6514368-580696 end else if p<-781424+5445085 then p=v H=i p=i and 11160943-(-486671)or 48070+1356197 else p=true p=804474+14411187 end end end end else if p<973599+5396741 then if p<231665+5348857 then if p<612940+4679467 then if p<-263435+5462590 then if p<-884683+6061903 then m=nil s=nil O=nil p=353259+10429995 else Y={}c=l(162620+-124296)e=l(-212675-(-251026))s=nil o=j()b[o]=Y Y=j()C=N(-366491+14463490,{o,i;v;F})q=j()A=nil b[Y]=C B={}C={}b[q]=C C=y[c]f=b[q]W=nil K=l(39828+-1486)Z={[e]=f,[K]=W}O=nil c=C(B,Z)m=nil C=M(-34071+6716051,{q,o;u,i;v,Y})F=r(F)q=r(q)i=r(i)p=y[l(566656+-528307)]o=r(o)u=r(u)U=c v=r(v)m=l(-474647+513009)Y=r(Y)v=l(-420251-(-458594))S=nil S=-14483+28179363097557 w=C F=l(719983-681614)d=nil s=y[F]H={}O=y[m]i=w(v,S)A=U[i]i=true v=l(33079+5262)v=O[v]m={v(O,A,i)}F=s(P(m))w=nil s=F()U=nil end else O=b[F]p=14541211-701612 H=O end else if p<811078+4621730 then p=960263-(-787081)w=b[n[-752967+752973]]U=w==I H=U else p=-410874+11194128 end end else if p<5775612-(-136636)then if p<5065546-(-660774)then A=l(-305465+343820)F=-319110+35184372407942 v=633763-633762 m=148427-148172 p={}b[n[-113969-(-113971)]]=p H=b[n[-158560-(-158563)]]s=H H=U%F b[n[631795+-631791]]=H O=U%m m=562570+-562568 F=O+m b[n[-146748+146753]]=F m=y[A]p=11142034-(-969923)A=l(365002+-326637)O=m[A]m=O(I)O=l(113167-74821)A=752494-752493 w[U]=O O=-743779-(-743945)S=v i=m v=338646-338646 u=S<v v=A-S else p=H and-972372+17034158 or 351575+3504307 end else if p<127987+5968247 then p={}I=p U=-422102+422103 w=b[n[264292-264283]]s=w w=1001826-1001825 F=w p=352831+174218 w=935242-935242 O=F<w w=U-F else H=l(-915011-(-953369))p=y[H]I=l(79055-40698)H=y[I]I=l(944194-905837)y[I]=p I=l(-230647+269005)y[I]=H I=b[n[-843353-(-843354)]]U=I()p=15121399-(-406343)end end end else if p<9021+6667949 then if p<666288+5907661 then if p<-249125+6717182 then if p<6592066-166239 then C=-695977-(-695977)o=#d Y=o==C p=Y and 4659510-(-538609)or 6139926-(-536870)else F=-313065-(-313067)s=-706795-(-706796)U=b[n[546295-546294]]w=U(s,F)U=287052+-287051 I=w==U H=I p=I and 6059340-180589 or 7999035-642576 end else w=l(898011-859663)U=y[w]w=l(569958-531598)I=U[w]w=b[n[233401+-233400]]U={I(w)}H={P(U)}p=y[l(-455898+494230)]end else if p<6504671-(-140612)then p=10587014-375769 V=S==u E=V else C=#d o=1036413-1036412 Y=s(o,C)B=36258-36257 o=O(d,Y)C=b[u]c=o-B Y=nil q=m(c)p=355812+6027776 C[o]=q o=nil end end else if p<7736609-87660 then if p<-154378+6911263 then p=b[n[963086-963085]]U=G[595535-595533]w=p p=w[U]I=G[820600-820599]p=p and 5806498-271783 or 664597+4966825 else U=b[n[525394+-525392]]w=b[n[649255+-649252]]p=6610747-731996 I=U==w H=I end else if p<-345175+8011952 then p=b[n[413360-413350]]U=b[n[-559732-(-559743)]]I[p]=U p=b[n[-292512+292524]]U={p(I)}H={P(U)}p=y[l(-681550-(-719894))]else q=not C E=E+D H=E<=V H=q and H q=E>=V q=C and q H=q or H q=-994257+15648963 p=H and q H=375480+2454954 p=p or H end end end end end else if p<12076145-(-1003749)then if p<10918918-233654 then if p<10561854-809384 then if p<9454718-53670 then if p<-485782+8982845 then if p<9017969-680981 then D=l(-869009+907340)q=l(584398-546041)p=y[D]C=y[q]D=p(C)p=l(-252340+290698)y[p]=D p=-255335+3211683 else W=320684-320683 p=9908537-(-773130)z=K[W]T=z end else t=277991-277990 J=K[t]t=false W=J==t z=p T=W p=W and 12432318-111234 or-716518+2056013 end else if p<-439296+10086447 then T=b[U]H=T p=T and-967607+9611412 or-680841+13218029 else F=j()p=true m=l(146743+-108413)w=l(530670+-492315)I=G U=j()b[U]=p H=y[w]w=l(996524-958184)p=H[w]w=j()A=M(1015182+-105830,{F})s=j()b[w]=p p=M(14890393-(-533612),{})b[s]=p p=false b[F]=p O=y[m]m=O(A)p=m and 48540+5163966 or 13145956-(-693643)H=m end end else if p<11163965-1011212 then if p<9699418-(-269892)then w=-866819+866820 U=b[n[-259970-(-259973)]]I=U~=w p=I and 13989265-22300 or 776432+15657025 else H=761273+6714185 U=l(489663+-451334)w=11633895-(-101549)I=U^w p=H-I I=p H=l(-701491+739816)p=H/I H={p}p=y[l(380115-341765)]end else if p<570846+10019698 then b[U]=E p=b[U]p=p and 315666+10422628 or 388838+4426661 else b[U]=T h=-370319+370320 t=b[Z]J=t+h W=K[J]z=S+W W=-776870+777126 p=z%W S=p J=b[B]W=u+J p=-49510+14428393 J=703478+-703222 z=W%J u=z end end end else if p<11764764-(-150777)then if p<11040379-(-617715)then if p<12022302-867878 then if p<-202205+10973491 then p=17011002-395662 else H={U}p=y[l(-939913+978274)]end else v=-594508-(-594511)i=j()b[i]=H S=779234-779169 p=b[m]d=l(198327-159997)H=p(v,S)v=j()p=723385+-723385 Y=M(-347980+10478708,{})b[v]=H S=p p=-1462+1462 H=y[d]D=l(320890-282559)u=p d={H(Y)}H=452666+-452664 p={P(d)}d=p p=d[H]H=l(1007555+-969227)Y=p p=y[H]o=b[w]V=y[D]D=V(Y)V=l(310935+-272569)E=o(D,V)o={E()}H=p(P(o))o=j()b[o]=H H=1030230+-1030229 E=b[v]V=E E=-714944-(-714945)D=E E=-109214+109214 C=D<E E=H-D p=7541018-(-139783)end else if p<11564044-(-159528)then p=15234564-(-293178)else p=true p=p and 473388+613595 or 14327738-1045589 end end else if p<178625+12287028 then if p<11934330-(-324304)then v=v+S A=v<=i d=not u A=d and A d=v>=i d=u and d A=d or A d=5958+3320503 p=A and d A=6153828-1001435 p=p or A else t=704441-704439 J=K[t]t=b[f]W=J==t T=W p=495976+843519 end else if p<-551453+13045412 then p=11878660-(-7341)else b[U]=H p=13402779-(-976104)end end end end else if p<16280311-1042994 then if p<-597071+15001735 then if p<-546366+14622328 then if p<-583964+14529240 then if p<12811944-(-964306)then p=y[l(-961895-(-1000251))]H={}else A=l(656042-617694)O=H m=l(934308+-895971)H=y[m]m=l(48901+-10549)p=H[m]u=l(-899470-(-937818))m=j()b[m]=p H=y[A]A=l(970653+-932314)p=H[A]A=p v=p S=y[u]i=S p=S and 690769+2718369 or 4237854-(-195124)end else U=b[n[446728+-446725]]w=775539+-775507 I=U%w s=b[n[-18935-(-18939)]]i=807927+-807925 m=b[n[562327+-562325]]S=722132-722119 Y=b[n[-282973+282976]]d=Y-I Y=-511251+511283 u=d/Y v=S-u A=i^v O=m/A F=s(O)s=4293970267-(-997029)w=F%s F=132834+-132832 s=F^I S=777286+-777030 A=-837627-(-837628)U=w/s s=b[n[-175443-(-175447)]]m=U%A A=4294953223-(-14073)O=m*A F=s(O)i=-1024551+1024807 s=b[n[-232121+232125]]O=s(U)w=F+O F=81651+-16115 m=426573+-361037 s=w%F O=w-s w=nil F=O/m m=967866+-967610 O=s%m A=s-O m=A/i i=-875288-(-875544)s=nil A=F%i v=F-A i=v/S U=nil v={O,m;A;i}m=nil p=6074961-(-407552)A=nil b[n[571275-571274]]=v I=nil i=nil O=nil F=nil end else if p<1041600+13301090 then I=b[n[269446+-269445]]H=#I I=554809-554809 p=H==I p=p and 85808+16363299 or 6326942-(-155571)else q=r(q)B=r(B)c=r(c)p=-446295+8127096 e=r(e)K=nil Z=r(Z)f=r(f)end end else if p<1003828+13781655 then if p<15217850-654092 then o=o+q B=not c Y=o<=C Y=B and Y B=o>=C B=c and B Y=B or Y B=15754305-(-640589)p=Y and B Y=15561295-297080 p=p or Y else c=l(874536+-836199)q=j()b[q]=E H=y[c]B=877583-877483 Z=37791+-37536 c=l(-791141-(-829493))p=H[c]c=625937-625936 H=p(c,B)c=j()b[c]=H p=b[m]B=556443-556443 f=-968919+968920 H=p(B,Z)B=j()b[B]=H K=-712123-(-712125)p=b[m]a=-305249-(-315249)e=b[c]Z=-222269-(-222270)h=861086+-861086 H=p(Z,e)Z=j()W=l(-462742-(-501073))b[Z]=H H=b[m]e=H(f,K)H=-864146+864147 p=e==H e=j()H=l(-348610+386976)K=l(-141799+180166)b[e]=p p=l(-970081-(-1008434))z=y[W]J=b[m]p=Y[p]t={J(h,a)}W=z(P(t))z=l(-364501-(-402868))T=W..z f=K..T p=p(Y,H,f)K=l(-263005-(-301335))f=j()T=N(-39219+6484166,{m,q,v,w;U;o;e,f,c;Z,B;i})b[f]=p H=y[K]K={H(T)}p={P(K)}K=p p=b[e]p=p and-820343+10386256 or-271379+1219606 end else if p<15931163-828816 then w=774488-774488 I=l(595265+-556911)p=y[I]U=b[n[-459339-(-459347)]]I=p(U,w)p=34395+5899277 else p=k(-741595+12435067,{s})V={p()}H={P(V)}p=y[l(976655+-938328)]end end end else if p<15822111-(-467696)then if p<15169406-(-301016)then if p<15902492-493772 then if p<41343+15308733 then p=6097694-(-579102)o=#d C=395222-395222 Y=o==C else i=696789-696534 p=b[n[-634638-(-634639)]]A=540936-540936 m=p(A,i)U=w I[U]=m U=nil p=-401425-(-928474)end else H=l(283853-245499)I=l(-91519-(-129842))p=y[H]H=p(I)H={}p=y[l(-173230-(-211556))]end else if p<15317345-(-304360)then p=true p=p and 6498153-298096 or-731458+775967 else H=l(-887302+925630)s=l(-41545+79876)p=y[H]i=L(488630-415135,{})I=b[n[494717-494713]]A=l(707360-669030)w=y[s]m=y[A]A={m(i)}O={P(A)}m=510218+-510216 F=O[m]s=w(F)w=l(-293421-(-331787))U=I(s,w)I={U()}H=p(P(I))U=b[n[-983563-(-983568)]]I=H H=U p=U and-600953+5896036 or 1973117-225773 end end else if p<15561945-(-883008)then if p<-241981+16651770 then Y=o B=Y d[Y]=B p=996606+13475649 Y=nil else w=-364080-(-364290)U=b[n[-83409-(-83412)]]I=U*w U=832730-832473 H=I%U b[n[-147928+147931]]=H p=-358508+10140426 end else if p<58445+16556422 then U=b[n[-450139-(-450141)]]w=-946515-(-946672)I=U*w U=-925509+6471359490826 H=I+U I=35184372764434-675602 p=H%I b[n[390166+-390164]]=p U=-657799+657800 p=965863+15467594 I=b[n[-220328+220331]]H=I~=U else O=nil d=nil o=r(o)O=l(-353054-(-391391))A=nil m=r(m)d={}i=r(i)m=l(-958069+996406)s=r(s)U=r(U)o=-46536+46792 Y=nil F=r(F)u=nil i=l(-547600-(-585955))w=r(w)F=y[O]O=l(-650895+689242)v=r(v)w=nil Y=-384902+384903 C=o U=nil u=j()s=F[O]S=nil F=j()o=973712+-973711 b[F]=s A=l(-642486+680834)O=y[m]m=l(656606+-618254)p=14165246-(-307009)s=O[m]m=y[A]A=l(785293-746933)O=m[A]A=y[i]i=l(524004+-485671)m=A[i]q=o o=-21193+21193 c=q<o i=j()A=236969-236969 b[i]=A v=j()A=767786+-767784 S={}b[v]=A A={}b[u]=S o=Y-q S=-562552+562552 end end end end end end end p=#g return P(H)end,function(y)local l,p=538255-538254,y[856861+-856860]while p do I[p],l=I[p]-(115610+-115609),(-577884+577885)+l if 536272+-536272==I[p]then I[p],b[p]=nil,nil end p=y[l]end end,function(y,l)local P=w(l)local G=function(G,n,g,x,H)return p(y,{G;n,g,x,H},l,P)end return G end,function(y,l)local P=w(l)local G=function(...)return p(y,{...},l,P)end return G end,function()U=U+(-1017904-(-1017905))I[U]=735869+-735868 return U end,function(y)I[y]=I[y]-(-40544-(-40545))if 200985-200985==I[y]then I[y],b[y]=nil,nil end end,{},function(y,l)local P=w(l)local G=function(G,n,g,x)return p(y,{G;n;g;x},l,P)end return G end,function(y,l)local P=w(l)local G=function(G,n,g)return p(y,{G,n,g},l,P)end return G end,842971-842971,function(y,l)local P=w(l)local G=function()return p(y,{},l,P)end return G end,{}return(F(8954859-(-747775),{}))(P(H))end)(getfenv and getfenv()or _ENV,unpack or table[l(530417-492083)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
