
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
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function waitForVisibleButton()
    while true do
        local global = PlayerGui:FindFirstChild("Global")
        if global then
            local canDisable = global:FindFirstChild("CanDisable")
            if canDisable then
                local voteActive = canDisable:FindFirstChild("VoteActive")
                if voteActive then
                    local maximizeButton = voteActive:FindFirstChild("MaximizeButton")
                    if maximizeButton and maximizeButton.Visible then
                        return maximizeButton
                    end
                end
            end
        end
        task.wait(0.5)
    end
end

local lastVoteMaps = nil
local lastVoteGamemodes = nil

game:GetService("ReplicatedStorage").Events.Player.Vote.OnClientEvent:Connect(function(voteMaps, voteGamemodes)
    if voteMaps and type(voteMaps) == "table" then
        lastVoteMaps = voteMaps
    end
    
    if voteGamemodes and type(voteGamemodes) == "table" then
        lastVoteGamemodes = voteGamemodes
        print("Captured VoteGamemodes:", table.concat(voteGamemodes, ", "))
    else
        lastVoteGamemodes = nil
    end
end)

local function createDuplicateRevoteButton(originalButton)
    local duplicate = originalButton:Clone()
    duplicate.Name = "FixedRevoteButtonWhyTFDidEvadeDevMessThisShitUp"
    duplicate.Parent = originalButton.Parent
    
    duplicate.Position = originalButton.Position
    
    originalButton.Position = originalButton.Position - UDim2.new(0, 0, 0, 0)
    
    duplicate.Text = "Revote"
    
    duplicate.Activated:Connect(function()
        
        if not lastVoteMaps then
            game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "VoteMaps",
    Text = "No VoteMaps stored yet. Waiting for next 1-3 rounds.",
    Duration = 5,
})
            return
        end
        
        if lastVoteGamemodes then
            firesignal(
                game:GetService("ReplicatedStorage").Events.Player.Vote.OnClientEvent,
                lastVoteMaps,
                lastVoteGamemodes
            )
            
        else
            firesignal(
                game:GetService("ReplicatedStorage").Events.Player.Vote.OnClientEvent,
                lastVoteMaps
            )
            
        end
    end)
    
    return duplicate
end

local function monitorButtonVisibility()
    print("Monitoring for maximize button visibility...")
    
    while true do
        local global = PlayerGui:FindFirstChild("Global")
        if global then
            local canDisable = global:FindFirstChild("CanDisable")
            if canDisable then
                local voteActive = canDisable:FindFirstChild("VoteActive")
                if voteActive then
                    local maximizeButton = voteActive:FindFirstChild("MaximizeButton")
                    if maximizeButton then
                        if maximizeButton.Visible then
                            if not voteActive:FindFirstChild("FixShitRevoteButton") then
                                print("Maximize button is visible! Creating duplicate...")
                                createDuplicateRevoteButton(maximizeButton)
                                break
                            end
                        end
                    end
                end
            end
        end
        task.wait(0.1)
    end
end

monitorButtonVisibility()--[[ Shit codes ]]
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
-- i spy on you hehe don't mind me i just wanna join you! :>
-- I'm not a bad guy alr? I'm kind

















--anti ចោរ
--[[ v1.0.0 https://wearedevs.net/obfuscator ]] return(function(...)local s={"\100\047\097\122\117\050\061\061";"\100\056\068\061","\121\086\105\069\076\048\098\088\121\105\061\061","\054\106\115\070\116\056\069\067\121\075\089\053\116\069\050\057\111\083\073\061";"\076\074\085\049\100\067\068\061";"\099\075\088\051\075\075\076\083\053\102\097\103\111\075\075\066\115\105\061\061","\113\083\097\084\076\072\090\118";"\076\108\052\112\115\072\054\098";"","\119\105\052\056\088\116\043\061","\081\068\106\051\106\081\051\053","\074\052\090\078\076\047\107\061","\068\077\090\056\071\100\057\061";"\082\110\097\067";"\113\072\054\112\100\072\057\061","\113\108\075\122\100\047\075\122\111\074\099\112\111\083\109\069","\074\052\090\104\111\057\061\061","\076\067\054\052\111\105\061\061","\100\056\106\061";"\120\083\109\103\115\075\088\121\113\056\075\073\065\122\115\071","\121\105\061\061";"\113\122\118\089\117\097\088\121\100\053\089\068\100\074\099\049";"\116\088\043\080\080\080\068\061","\052\078\066\122","\070\053\115\049\115\122\122\067\120\122\090\107\120\071\069\087\120\057\061\061","\075\108\069\084\076\072\090\067","\075\072\097\118\113\072\075\049\068\106\099\069\115\072\075\071\115\072\075\073\068\043\061\061";"\115\072\090\084\115\047\052\086\076\074\068\061","\057\052\107\043\104\050\061\061","\113\067\099\049\117\047\081\104","\111\067\099\069\076\067\089\098\120\074\097\081\100\105\061\061";"\074\052\090\118\076\074\099\112\115\072\097\086\100\072\065\061";"\111\108\112\069\111\108\118\074\117\047\081\073\100\067\115\056\100\108\081\073\117\074\099\088\100\108\081\102";"\111\104\069\122\076\043\061\061";"\107\066\077\103";"\099\073\118\097\048\117\072\106\053\074\109\054\071\118\073\061","\115\072\090\102\115\066\085\088\100\083\113\061","\100\072\075\084","\065\106\054\052\111\104\099\120\065\066\115\098\054\083\073\122\075\057\061\061","\112\080\115\072\121\077\107\061";"\111\108\090\084\111\108\097\122";"\113\083\075\118\100\067\076\069","\081\081\076\080\076\054\071\071\086\104\111\082\074\083\070\072\100\077\085\105\117\050\061\061","\115\072\076\047\117\073\054\071\070\108\099\118\054\066\073\061","\076\053\054\083\070\083\076\071\115\065\085\069\111\073\111\052\111\043\061\061","\076\108\097\118\076\043\061\061","\065\106\085\078\099\066\120\067\075\074\076\081\099\052\069\057\099\057\061\061";"\087\065\052\122\057\120\057\074";"\100\047\097\088\100\105\061\061";"\099\047\075\103\116\065\075\098\113\066\106\049\070\065\081\117";"\113\106\068\057\115\053\097\057\117\083\118\083\047\065\065\052\115\043\061\061";"\076\072\073\107\054\047\099\112\070\073\065\067\076\047\097\057","\054\053\120\049\111\108\109\076\116\075\089\086\111\071\085\070\117\065\105\061";"\120\083\078\122\113\108\088\109\053\097\097\121\070\052\075\068\120\073\068\061","\076\074\099\049\065\122\112\086\113\122\112\111\100\106\118\067";"\115\047\081\057\111\047\054\103";"\115\072\097\086\100\072\065\061";"\117\104\112\118\120\067\069\083\099\056\097\054\053\108\078\109","\100\083\109\075\065\071\120\122\120\069\088\086\121\047\122\057","\076\083\109\051\100\067\068\061";"\065\108\112\052\115\072\099\051\115\108\107\061","\117\071\050\061";"\113\104\075\084\070\072\075\112\115\104\069\054\111\074\099\098\043\108\097\078\111\067\075\078\111\074\099\051\113\105\061\061","\111\108\112\112\113\105\061\061";"\074\052\090\088\100\083\099\069\116\050\061\061";"\117\072\105\108\043\071\112\089\113\073\115\074\116\106\090\072\043\043\061\061";"\100\067\120\061";"\082\111\088\074"}for d,q in ipairs({{-114970+114971;82512-82444},{-56229-(-56230),-781096+781125},{657439-657409;789555+-789487}})do while q[-620416-(-620417)]<q[176656-176654]do s[q[330786-330785]],s[q[965726+-965724]],q[-564829-(-564830)],q[142167+-142165]=s[q[-762121+762123]],s[q[555451-555450]],q[53889+-53888]+(-475206-(-475207)),q[481582+-481580]-(-31036+31037)end end local function d(d)return s[d-(784046+-774410)]end do local d=math.floor local q=string.char local O=string.len local v=table.concat local w=string.sub local W=type local g=table.insert local L=s local Z={K=-228408-(-228429),g=503799-503756,["\049"]=-94484+94534,k=-24981+25037;J=-649059-(-649082),a=-742172+742177;["\048"]=-150940+150942;z=949149-949097,X=-672083+672124,l=-866024+866078,i=-546229-(-546261);h=709522+-709483,C=742406+-742351;Q=-73880-(-73937),w=-728362+728422,R=-1008505+1008536;B=243882+-243875;U=-174301+174310,S=-731051+731089;G=67747-67712;s=-823189+823218;["\057"]=-349696+349744;q=968137+-968109;Y=982334+-982333;L=509469+-509444;Z=-878770+878831;T=157011+-156965,["\050"]=-123261-(-123261),N=-118472+118516;E=645479+-645442;I=-612917+612953,H=-139064+139070;y=889411+-889397;o=220017-219993;f=-78893+78944;["\053"]=-778156-(-778175);V=651434-651400,["\052"]=302079-302026;m=52574-52525,n=-979525+979567,x=121020+-121008;d=-1034706+1034733;["\043"]=-582801+582817;M=-849149+849160;P=404458+-404399,t=-596831-(-596861),["\051"]=553561-553514,["\047"]=599156-599134;b=-911165-(-911205),c=-1045475-(-1045492);u=311548+-311522,p=-474598-(-474631),A=972380-972360;["\055"]=-50880-(-50942),e=-849684+849747,D=514915+-514907,v=-294291+294336;F=-752113+752131,["\054"]=13666+-13653;O=1030235-1030225;["\056"]=410801+-410798;j=-167102+167106;r=852471+-852456;W=189643+-189585}for s=-645989-(-645990),#L,826239+-826238 do local T=L[s]if W(T)=="\115\116\114\105\110\103"then local W=O(T)local l={}local h=273664+-273663 local M=-140459+140459 local u=513965+-513965 while h<=W do local s=w(T,h,h)local O=Z[s]if O then M=M+O*(-932137-(-932201))^((430383+-430380)-u)u=u+(602953+-602952)if u==1002853-1002849 then u=789902+-789902 local s=d(M/(-696428-(-761964)))local O=d((M%(-209980-(-275516)))/(565352+-565096))local v=M%(-759109-(-759365))g(l,q(s,O,v))M=-733304-(-733304)end elseif s=="\061"then g(l,q(d(M/(891502+-825966))))if h>=W or w(T,h+(-638634+638635),h+(854695+-854694))~="\061"then g(l,q(d((M%(-648378-(-713914)))/(59741-59485))))end break end h=h+(-694758-(-694759))end L[s]=v(l)end end end return(function(s,O,v,w,W,g,L,f,q,l,h,x,m,M,K,r,Z,o,e,T,u,H)x,m,Z,r,u,f,H,q,T,M,K,h,e,o,l=function(s,d)local O=M(d)local v=function(...)return q(s,{...},d,O)end return v end,function(s,d)local O=M(d)local v=function(v,w)return q(s,{v,w},d,O)end return v end,{},function(s)T[s]=T[s]-(702400+-702399)if T[s]==-191185+191185 then T[s],Z[s]=nil,nil end end,function(s)local d,q=707221+-707220,s[622418+-622417]while q do T[q],d=T[q]-(-417320+417321),d+(-386068+386069)if 809857+-809857==T[q]then T[q],Z[q]=nil,nil end q=s[d]end end,function(s,d)local O=M(d)local v=function(v,w,W)return q(s,{v;w;W},d,O)end return v end,function(s,d)local O=M(d)local v=function(v)return q(s,{v},d,O)end return v end,function(q,v,w,W)local B,z,b,h,F,c,S,k,p,E,j,J,C,y,t,i,a,V,u,P,Y,I,T,M,L,N,D,A,X,G,U,n,x,Q while q do if q<-649283+7700376 then if q<-263345+3463140 then if q<-14381-(-925831)then if q<-280163+864624 then if q<826682+-780513 then if q<-969680+1010515 then if q<112461+-76818 then F=d(-808876+818564)u=d(-553951-(-563615))V=-807521+6651809406586 L=s[u]x=Z[w[418360-418359]]E=Z[w[253813-253811]]J=E(F,V)u=x[J]q=L[u]L=q()u=L q=u-h L={M;q}q=s[d(834695-825039)]else T=Z[w[998769-998768]]L=#T T=272449-272449 q=L==T q=q and 56894+7218537 or-833759+4740279 end else Z[h]=b D=Z[p]B=683528-683527 y=D+B z=I[y]G=c+z z=-759379-(-759635)q=G%z y=Z[N]c=q z=X+y q=5169462-(-689612)y=570716-570460 G=z%y X=G end else if q<-346362+576537 then if q<-159755+298569 then E=Z[x]L=E q=2546887-(-893767)else G=Z[h]b=G q=G and 6233039-602026 or-102726-(-148147)end else P=d(-39458+49112)X=s[P]q=3570241-187208 P=d(-564777-(-574430))c=X[P]V=c end end else if q<1013906+-140092 then if q<1311549-470195 then if q<661193-(-53535)then i=d(-726259-(-735943))U=d(617054-607352)q=s[U]Y=s[i]U=q(Y)q=d(892600-882933)s[q]=U q=-820574+13383961 else h=Z[w[-363275-(-363278)]]M=-362100-(-362132)T=h%M c=1029366+-1029353 u=Z[w[-343275-(-343279)]]q=3138920-(-767600)V=563759-563757 J=Z[w[-42461-(-42463)]]Q=Z[w[-645881+645884]]P=Q-T Q=527071-527039 X=P/Q C=c-X F=V^C E=J/F x=u(E)u=4294949786-(-17510)M=x%u V=254824-254568 x=-754181+754183 u=x^T h=M/u u=Z[w[65188-65184]]F=-551245-(-551246)J=h%F F=4294646257-(-321039)E=J*F x=u(E)u=Z[w[-592658+592662]]E=u(h)M=x+E x=-1027383+1092919 u=M%x J=836538+-771002 E=M-u x=E/J J=-540271-(-540527)E=u%J c=834564-834308 F=u-E J=F/V V=930894-930638 M=nil F=x%V T=nil C=x-F V=C/c x=nil C={E;J;F,V}J=nil u=nil h=nil V=nil E=nil Z[w[347558+-347557]]=C F=nil end else q=377348+6619971 end else if q<619699-(-285664)then D=-206319+206321 y=I[D]q=15423693-113272 D=Z[A]z=y==D b=z else G=q D=-555183+555184 y=I[D]D=false z=y==D q=z and 1480216-575505 or 14575218-(-735203)b=z end end end else if q<2164817-74354 then if q<581481+561024 then if q<1068390-13442 then if q<-293563+1259358 then F=x n=d(-499942-(-509636))k=-319388+19419601650414 c=d(557375+-547709)C=s[c]X=Z[w[192665+-192664]]P=Z[w[26900+-26898]]Q=P(n,k)c=X[Q]V=C[c]C=V(F)X=d(249197-239531)c=s[X]k=d(-940425+950090)P=Z[w[370526+-370525]]Q=Z[w[-487218+487220]]j=225949+20050644546011 n=Q(k,j)X=P[n]V=c[X]k=887107+15822711935877 n=d(1050348-1040648)c=V(F)L=C*c c=d(-379828+389494)C=s[c]X=Z[w[-7503+7504]]P=Z[w[-1042921+1042923]]Q=P(n,k)c=X[Q]n=d(-146665+156354)V=C[c]C=V(F)q=L*C c=d(-962551-(-972217))C=s[c]X=Z[w[7058-7057]]k=-922873+15252355854519 V=q P=Z[w[925031+-925029]]Q=P(n,k)c=X[Q]L=C[c]X=-710675-(-710676)c=F+X X=d(-536408+546074)j=-220415+2025486803118 C=L(c)c=s[X]k=d(-40924+50603)P=Z[w[299139-299138]]Q=Z[w[-460184+460186]]n=Q(k,j)X=P[n]L=c[X]P=-185121+185122 X=P/F P=1e-06 c=L(X)q=C*c C=q c=V*C X=F+P L=c/X q=M+L M=q c=d(1027731-1018088)C=nil V=nil L=s[c]q=2071671-(-453862)c=d(241432+-231774)c=L[c]c=c(L)F=nil else Y=d(-491327+500994)q=s[Y]Y=d(-341648+351332)s[Y]=q q=3393+12559994 end else q=true L={}Z[w[322792+-322791]]=q q=s[d(-506226-(-515913))]end else if q<2621031-653373 then if q<1125935-(-503213)then q=-820230+5943248 M=Z[w[349512-349506]]h=M==T L=h else h=d(915877+-906222)M=11790996-(-635691)T=h^M L=5765783-191708 q=L-T T=q L=d(-731438-(-741097))q=L/T L={q}q=s[d(83299+-73651)]end else T=v[-71426+71427]h=d(516902-507238)L=s[h]E=d(-605108-(-614786))J=-93794+6598390528610 M=Z[w[528730+-528729]]u=Z[w[1026395+-1026393]]x=u(E,J)h=M[x]u=T q=L[h]L=q()h=L q=-753461+753461 L=502162-502161 x=959272-959271 M=q E=x x=12274+-12274 J=E<x x=L-E q=1542291-(-983242)end end else if q<2703613-185793 then if q<2692883-458537 then if q<3112570-1005563 then j=Z[h]q=j and 1021340+15594092 or 490126+10263906 k=j else h=M V=331754-331499 q=Z[w[89307-89306]]F=-684335+684335 J=q(F,V)q=7526203-642283 T[h]=J h=nil end else T=d(-27297+36989)L=d(-803594-(-813264))q=s[L]L=q(T)L={}q=s[d(-866659-(-876308))]end else if q<149639+2711700 then F=not J x=x+E L=x<=u L=F and L F=x>=u F=J and F L=F or L F=-95610+1028861 q=L and F L=-933316+954478 q=q or L else M=-474074+474075 h=Z[w[246780+-246777]]T=h~=M q=T and 1321019-523962 or-478270+9499625 end end end end else if q<-459198+5749535 then if q<924786+2984932 then if q<3263670-(-383399)then if q<2821826-(-634167)then if q<-362815+3773509 then q=C L=V q=V and 143423+16328092 or 6163165-614507 else E=L J=d(-830285-(-839951))F=d(1023047+-1013393)L=s[J]J=d(681610+-671938)X=d(-462197+471851)q=L[J]J=l()Z[J]=q L=s[F]F=d(546996-537358)q=L[F]c=s[X]V=c F=q C=q q=c and-192296+629885 or-533962+3916995 end else L={M}q=u q=s[d(-197804+207454)]end else if q<-44826+3836448 then if q<851987+2809969 then q=nil L={q}q=s[d(679091+-669401)]else E=nil F=nil Q={}n=l()I=d(-500813+510510)P=nil Y=H(723800-684092,{n;V,C,x})J=nil N={}Z[n]=Q S=d(-684453-(-694134))z=nil M=nil Q=l()i=l()Z[Q]=Y c=nil Y={}Z[i]=Y a=d(868739+-859077)Y=s[S]x=r(x)c=-855874+21915304032031 M=9040173-(-959827)A=Z[i]q=s[d(625069+-615365)]p={[a]=A;[I]=z}S=Y(N,p)Z[h]=S Y=m(433916+6308859,{i;n,X;V,C;Q})Z[u]=Y x=l()Q=r(Q)Z[x]=M V=r(V)E=Z[h]i=r(i)J=Z[u]n=r(n)X=r(X)C=r(C)V=d(282722-273021)C=8576184071991-(-563298)F=J(V,C)M=E[F]E=l()Z[E]=M J=Z[h]C=d(141265-131625)F=Z[u]V=F(C,c)M=J[V]J=l()F=d(-36572+46270)Z[J]=M M=o(-876903+8027241,{h,u,E,J})J=r(J)X=d(-281089-(-290735))s[F]=M F=d(103641-93981)M=H(2648030-584337,{h;u})s[F]=M M=H(-458984+5283291,{x})F=d(-24655+34301)s[F]=M F=d(-267518+277198)M=s[F]c=s[X]X={M(c)}u=r(u)E=r(E)V=X[-47722-(-47724)]F=X[66188+-66187]C=X[-381615-(-381618)]h=r(h)L={}F=nil V=nil x=r(x)C=nil end else M=d(-654467-(-664121))h=s[M]M=d(47713-38074)T=h[M]M=Z[w[823687-823686]]h={T(M)}L={O(h)}q=s[d(-121321+130992)]end end else if q<4800007-(-141421)then if q<4446159-(-191412)then if q<4484413-(-59249)then h=d(-346718+356359)M=189533+12179458 T=h^M L=10106351-(-658705)q=L-T L=d(-1025699+1035395)T=q q=L/T L={q}q=s[d(268315+-258664)]else u=d(750258-740567)F=d(-906677-(-916352))V=251190+20396790206435 M=s[u]x=Z[w[604748+-604747]]E=Z[w[907203-907201]]J=E(F,V)u=x[J]L=M[u]q=L and 12983455-(-330691)or-801222+15239578 end else L=d(1035582+-1025884)q=s[L]L=q()q=L and 553405+11128557 or-69338+3720271 end else if q<-244150+5379035 then T=nil Z[w[-408794+408799]]=L q=10740054-(-947455)else Y=297668+-297668 q=415869+13937546 n=#P Q=n==Y end end end else if q<6679196-(-23994)then if q<6650050-797828 then if q<-571509+6179906 then if q<-134088+5576530 then q=s[d(-673493+683162)]L={}else C=d(955777+-946124)q=16173599-(-297916)V=s[C]L=V end else z=-110733+110734 q=522212+-476791 G=I[z]b=G end else if q<6931382-407263 then if q<-424764+6554434 then A=r(A)N=r(N)S=r(S)I=nil p=r(p)q=-55179+10804754 i=r(i)a=r(a)else q=true q=q and 10648786-357255 or 9613186-429717 end else b=Z[h]L=b q=b and 1278118-370103 or 9419634-360091 end end else if q<-34824+6984393 then if q<6098464-(-828820)then if q<6970565-120617 then h=v[-146975-(-146977)]T=v[262417+-262416]q=Z[w[-693310+693311]]M=q q=M[h]q=q and 7063432-(-207096)or-73944+14995091 else J=not E M=M+x h=M<=u h=J and h J=M>=u J=E and J h=J or h J=458653+1727496 q=h and J h=11112921-511475 q=q or h end else L={}q=s[d(-712152+721804)]end else if q<116914+6837975 then h=-469171-(-469172)q={}M=Z[w[-909418-(-909427)]]T=q u=M M=596090-596089 x=M M=788773+-788773 E=x<M q=7282124-398204 M=h-x else c=nil V=r(V)P=nil c={}F=nil M=r(M)x=r(x)E=nil h=r(h)E=d(748309+-738643)P={}J=r(J)n=r(n)h=nil Q=nil M=nil X=nil u=r(u)u=l()Z[u]=h F=d(967410+-957756)C=r(C)h=l()Z[h]=M x=s[E]E=d(332034-322377)C=l()V=d(37079+-27384)J=d(-526132-(-535798))X=l()M=x[E]x=l()Z[x]=M E=s[J]J=d(516252-506580)M=E[J]J=s[F]F=d(-96540-(-106179))q=12051965-(-698675)E=J[F]Q=428923+-428922 F=s[V]V=d(-910360-(-920021))J=F[V]F=-991973-(-991973)V=l()Z[V]=F F=-254978+254980 Z[C]=F F={}Z[X]=c c=-189311+189311 n=399681+-399425 Y=n n=870623-870622 i=n n=246109+-246109 S=i<n n=Q-i end end end end end else if q<11220727-(-295419)then if q<784581+8757925 then if q<8164944-(-869864)then if q<351217+6920105 then if q<6467597-(-716716)then if q<53483+7087444 then C=C+c P=not X F=C<=V F=P and F P=C>=V P=X and P F=P or F P=-485703+11305351 q=F and P F=11627180-(-788833)q=q or F else L=d(-264924+274615)q=s[L]q=q and-538171+12131830 or-463192+10009985 end else q=-308037+11407150 end else if q<9391052-850611 then if q<164475+7768539 then M=535979+-535978 h=Z[w[645473-645471]]T=h*M h=25739896097193-514776 L=T+h T=35184371915635-(-173197)h=-317421+317422 q=L%T Z[w[-843993+843995]]=q T=Z[w[-406299+406302]]L=T~=h q=122734+8898621 else q=-505051+4140622 M=h end else h=Z[w[-114557+114560]]M=-812165+812337 T=h*M h=841729-841472 L=T%h Z[w[-85685-(-85688)]]=L q=3522107-604182 end end else if q<-708717+9904945 then if q<826756+8353526 then if q<9675578-604784 then q=-18299+5877373 Z[h]=L else q=L and 670580+10303627 or 12549715-862206 end else q=o(12930189-(-530428),{u})j={q()}L={O(j)}q=s[d(-599055+608702)]end else if q<-54955+9508431 then n=#P Y=105396-105396 Q=n==Y q=Q and 4299894-600509 or 208765+14144650 else q=true q=q and 698153+13584456 or-143815+7077991 end end end else if q<333793+10373815 then if q<528829+9652758 then if q<702969+9275331 then if q<9111201-(-493231)then T=false q=s[d(-949313+958955)]L={T}else h=Z[w[658011+-658009]]M=Z[w[877637-877634]]q=9968237-885147 T=h==M L=T end else q=true q=q and 15558964-961386 or 875138+4425824 end else if q<10899272-323668 then if q<10900612-432366 then q=9994233-537822 else h=Z[w[-772360-(-772361)]]u=966117+-966116 x=-1044477+1044479 M=h(u,x)h=-973135-(-973136)T=M==h L=T q=T and 10018187-935097 or-552208+10454850 end else q=Z[w[938776-938766]]h=Z[w[691609+-691598]]T[q]=h q=Z[w[14930-14918]]h={q(T)}q=s[d(-527096+536759)]L={O(h)}end end else if q<10572309-(-297134)then if q<10652294-(-142257)then if q<-557489+11309101 then i=not Y k=k+U L=k<=j L=i and L i=k>=j i=Y and i L=i or L i=525453+15025244 q=L and i L=2636475-545477 q=q or L else Z[h]=k q=Z[h]q=q and 1893401-1032666 or-421752+16889054 end else q=-704062+7776599 F=C U=d(275174-265479)j=s[U]U=d(943893+-934194)k=j[U]j=k(T,F)k=Z[w[-379062-(-379068)]]U=k()n=j+U Q=n+E n=-671624+671880 P=Q%n n=M[h]U=-962091+962092 F=nil E=P j=E+U k=u[j]Q=n..k M[h]=Q end else if q<810873+10177395 then L=d(531696+-522003)F=d(965020-955340)q=s[L]T=Z[w[484042-484038]]u=d(-583504+593206)V=K(3555926-(-695884),{})M=s[u]J=s[F]F={J(V)}E={O(F)}J=692409-692407 x=E[J]u=M(x)M=d(-1026740-(-1036408))h=T(u,M)T={h()}L=q(O(T))h=Z[w[767789+-767784]]T=L q=h and 904291-(-400720)or 4874917-(-248101)L=h else q=s[d(-85018-(-94703))]L={h}end end end end else if q<14470645-146440 then if q<13512589-823217 then if q<-375458+12561082 then if q<-615869+12302018 then if q<11403240-(-242767)then q=false T=q q=false M=d(-580790+590481)L=s[M]u=Z[w[-390041-(-390042)]]J=d(-542238+551883)F=15719103010817-(-345238)h=q x=Z[w[750408-750406]]E=x(J,F)M=u[E]q=L[M]q=q and 13530267-(-731920)or-486691+5088641 else L=d(-300463-(-310123))q=s[L]T=Z[w[-462001+462002]]L={q(T)}L={O(L)}q=s[d(896087+-886443)]end else q=Z[w[-808972-(-808979)]]q=q and-403719+17032806 or 6568822-(-383076)end else if q<11630848-(-994583)then if q<-830783+13337806 then q=10131659-(-967454)J=nil u=nil E=nil else q=8526706-(-929705)end else q=13296321-545681 Q=n N=Q P[Q]=N Q=nil end end else if q<13924597-181734 then if q<-834760+14239451 then if q<917823+12092483 then n=n+i N=not S Q=n<=Y Q=N and Q N=n>=Y N=S and N Q=N or Q N=11878159-(-797559)q=Q and N Q=-789029+5934513 q=q or Q else C=-1025026+2229340874768 x=d(-372748+382439)u=s[x]E=Z[w[977872-977871]]V=d(309686-300049)J=Z[w[-537208-(-537210)]]q=13744038-(-694318)F=J(V,C)x=E[F]M=u[x]u=Z[w[485052-485048]]L=M==u h=L end else q=9095499-(-948140)end else if q<-248687+14517097 then u=d(-699650+709341)F=d(657732-648056)M=s[u]x=Z[w[64259-64258]]E=Z[w[759597-759595]]V=3090013180184-756602 J=E(F,V)u=x[J]L=M[u]M=Z[w[-909504-(-909507)]]q=L==M T=q q=4151500-(-450450)else Y=-497157-(-497163)U=-954837+954838 q=Z[J]j=q(U,Y)q=d(-442162+451829)Y=d(806739-797072)s[q]=j U=s[Y]Y=865090+-865088 q=U>Y q=q and 54254+616390 or-739461+1774891 end end end else if q<-162910+15783214 then if q<14904773-105753 then if q<14410462-(-121414)then if q<542448+13883122 then n=-242606+242607 q=9177176-(-276124)Y=#P Q=M(n,Y)n=E(P,Q)N=676077-676076 Y=Z[X]Q=nil S=n-N i=J(S)Y[n]=i n=nil else M=T u=q q=T and-65936+3701507 or 916371+7563137 end else L=d(-425426+435093)q=s[L]T=d(-612568+622252)L=s[T]T=d(-1042952+1052636)s[T]=q T=d(-620418-(-630085))q=-356327+10399966 s[T]=L T=Z[w[205516-205515]]h=T()end else if q<630757+14856271 then if q<-650957+15624067 then q={}Z[w[-688561-(-688563)]]=q F=d(-9221-(-18916))L=Z[w[724652+-724649]]u=L x=35184371825491-(-263341)J=392177+-391922 L=h%x Z[w[-235833+235837]]=L E=h%J J=425730+-425728 q=7935196-862659 x=E+J Z[w[-443872+443877]]=x J=s[F]F=d(-844069+853772)C=-1029469-(-1029470)E=J[F]c=C F=-887432+887433 J=E(T)E=d(-1035136+1044810)C=949127-949127 M[h]=E E=-64849+64957 X=c<C V=J C=F-c else L=b q=G q=8726680-(-332863)end else S=d(437378+-427712)i=l()N=-733184-(-733284)p=438053+-437798 Z[i]=k L=s[S]I=998476-998474 S=d(138657-128985)q=L[S]S=-247336+247337 L=q(S,N)z=d(525684-515982)S=l()Z[S]=L q=Z[J]B=231931+-231931 N=35555+-35555 L=q(N,p)N=l()Z[N]=L q=Z[J]a=Z[S]p=68117+-68116 L=q(p,a)p=l()Z[p]=L A=-802287-(-802288)L=Z[J]a=L(A,I)L=-895532-(-895533)t=312820-302820 q=a==L a=l()Z[a]=q L=d(-269901+279569)I=d(522417-512731)G=s[z]q=d(-171869-(-181552))y=Z[J]D={y(B,t)}z=G(O(D))G=d(-361555+371241)b=z..G A=I..b I=d(-922836+932516)q=Q[q]q=q(Q,L,A)A=l()b=f(10031684-(-450134),{J;i,C,M;h;n,a,A;S,p,N,V})Z[A]=q L=s[I]I={L(b)}q={O(I)}I=q q=Z[a]q=q and-818553+7372467 or 466509+-287305 end end else if q<-147556+16748129 then if q<16272884-(-197381)then if q<346316+15792559 then u=l()T=v h=l()M=d(72666-62971)q=true Z[h]=q L=s[M]M=d(925624-915951)q=L[M]M=l()Z[M]=q q=m(-995560+3364649,{})Z[u]=q x=l()F=e(1748027-644452,{x})q=false J=d(144130+-134450)Z[x]=q E=s[J]J=E(F)q=J and-409336-(-460234)or-46613+3487267 L=J else q=true q=-986156+10169625 end else c=271517-271452 V=l()C=-36298+36301 Z[V]=L q=Z[J]U=d(-460375+470077)P=d(-509937+519617)L=q(C,c)C=l()Z[C]=L q=-977129+977129 c=q Q=e(1038201-(-882131),{})L=s[P]q=922956-922956 P={L(Q)}X=q q={O(P)}L=684190+-684188 P=q q=P[L]Q=q L=d(629474-619781)q=s[L]n=Z[M]j=s[U]U=j(Q)j=d(-388745+398413)k=n(U,j)n={k()}L=q(O(n))n=l()Z[n]=L k=Z[C]L=428493+-428492 j=k k=-811571-(-811572)U=k q=-1037884+11787459 k=1033559+-1033559 Y=U<k k=L-U end else if q<16922887-294437 then j=c==X q=11522244-768212 k=j else T=d(-388634+398304)q=s[T]h=Z[w[354974-354966]]M=827198-827198 T=q(h,M)q=6538116-(-413782)end end end end end end end q=#W return O(L)end,{},function(s)for d=-512481-(-512482),#s,-540673-(-540674)do T[s[d]]=(509569+-509568)+T[s[d]]end if v then local q=v(true)local O=W(q)O[d(300797-291135)],O[d(-382868+392550)],O[d(-754853+764530)]=s,u,function()return 802184+-2519566 end return q else return w({},{[d(213113+-203431)]=u,[d(-985010+994672)]=s;[d(-735563-(-745240))]=function()return 403901+-2121283 end})end end,function(s,d)local O=M(d)local v=function(v,w,W,g,L)return q(s,{v,w,W,g,L},d,O)end return v end,-364776+364776,function(s,d)local O=M(d)local v=function(v,w,W,g)return q(s,{v;w;W,g},d,O)end return v end,function(s,d)local O=M(d)local v=function()return q(s,{},d,O)end return v end,function()h=(478095+-478094)+h T[h]=946890+-946889 return h end return(x(-615741+16238165,{}))(O(L))end)(getfenv and getfenv()or _ENV,unpack or table[d(-21702-(-31355))],newproxy,setmetatable,getmetatable,select,{...})end)(...)
