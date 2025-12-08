
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
--[[ v1.0.0 https://wearedevs.net/obfuscator ]] return(function(...)local u={"\048\043\099\049\052\072\078\061","\051\055\071\115\052\090\071\115\050\043\080\084\050\085\066\114","\051\083\083\084\054\085\080\080\052\115\071\114\071\079\114\102\051\069\061\061","\077\071\069\055\065\055\073\072\052\067\078\055\082\106\061\061","\052\072\077\061";"\051\111\071\108\054\081\071\084\065\111\114\117\050\043\080\102\106\055\083\122\050\072\071\122\050\043\080\103\051\107\061\061";"\077\056\099\066\050\114\084\113\048\085\065\043\071\085\083\054","\109\122\121\110\116\100\061\061";"\106\071\048\082\097\070\117\067\117\055\066\086\065\081\084\054","\065\090\119\100\050\090\117\109","\065\081\083\116\052\081\070\061","\051\085\071\074\052\072\048\114","\052\081\071\108","\071\089\090\111\097\069\061\061";"\065\055\107\119\054\067\117\086\077\083\048\113\071\071\048\104\080\090\102\061","\106\098\074\097\082\081\099\082\052\114\114\109\071\072\083\117","\117\055\083\109\052\043\114\102\077\111\101\118\082\118\084\054","\082\107\061\061","\122\080\049\047";"\073\100\089\074\112\098\083\085","\065\081\089\056\065\068\099\047\052\085\051\061","\048\055\067\084\065\081\117\102";"\077\067\109\121\117\049\051\061";"\054\118\099\112\117\068\047\101\048\071\047\054\087\115\047\072\054\068\050\061","\117\097\117\119\052\068\099\074\065\055\122\066\054\081\075\055";"\071\055\114\108\048\081\089\072";"\108\065\100\108\074\106\105\075";"\097\083\083\110\106\100\061\061","\082\116\107\114\048\105\102\047\082\107\061\061";"\051\072\080\049\087\090\119\111","\080\098\048\081\077\068\114\086\097\097\117\097\052\090\071\084\077\085\100\061","\054\111\099\098\053\043\114\116\082\081\073\067\080\070\114\097\052\106\061\061";"\043\067\089\111\050\100\061\061","\043\067\089\074\048\043\080\084\065\081\083\116\052\081\070\061","\065\050\085\104","\048\085\066\103\052\072\078\061","\050\111\114\115\048\106\061\061","\082\090\114\071\080\067\084\098\087\056\099\099\054\118\107\056\097\069\061\061","\117\115\089\108\054\111\047\079\106\111\065\111\097\090\080\108";"\050\055\089\108\050\055\083\115";"\090\081\065\047\097\079\080\072\050\090\083\081\070\079\075\056\071\083\051\061";"\087\043\065\118\090\070\117\054\090\111\079\067\071\090\083\116\097\072\107\061";"\053\110\081\108\079\075\051\061";"\066\105\103\103\088\112\069\061";"\052\118\079\061","","\052\083\101\100\097\115\071\104\050\098\050\049\051\079\071\112\117\098\075\061","\087\085\071\081\052\067\084\088\052\083\078\119\080\085\107\119\087\072\070\061";"\050\057\074\047\101\054\076\072";"\043\067\089\122\048\090\073\061";"\050\055\084\084\051\107\061\061";"\052\090\083\047\052\107\061\061";"\053\052\098\077\107\050\122\061","\043\067\089\047\052\085\080\114\053\069\061\061";"\071\081\083\074\051\081\071\049\078\079\080\114\065\081\071\110\065\081\071\098\078\106\061\061";"\052\118\078\061";"\051\085\083\108\048\081\089\074";"\097\114\117\122\087\070\065\085\106\114\098\115\054\115\067\054\090\098\075\061";"\088\047\057\117","\051\081\117\084\052\081\100\061","\050\055\084\114\050\055\074\043\087\090\119\098\052\072\065\118\052\055\119\098\087\043\080\047\052\055\119\056";"\090\043\098\061","\048\072\117\067\050\107\061\061","\106\106\108\074","\052\090\083\115\087\069\061\061";"\065\081\089\108\065\090\067\116\048\043\078\061"}local function U(U)return u[U+(772882+-745736)]end for U,V in ipairs({{-723239-(-723240),-410035-(-410101)};{-449717+449718;36809-36793};{593689-593672;181558-181492}})do while V[-356138-(-356139)]<V[211035-211033]do u[V[666585+-666584]],u[V[1039098-1039096]],V[-1018816-(-1018817)],V[-45092+45094]=u[V[-915404+915406]],u[V[988922-988921]],V[342695-342694]+(-440930-(-440931)),V[784378-784376]-(-633296+633297)end end do local U=table.insert local V=u local K=string.len local r=table.concat local W={w=938905-938848,A=-582825+582854;N=843172+-843164;L=783934-783875;["\043"]=597084+-597061,O=-158292+158296,["\051"]=346133-346105;Z=-976877-(-976899),f=-184829-(-184869),J=-242792+242837,a=741321+-741302;["\057"]=335651+-335588,["\055"]=-699494-(-699548),b=775166-775130;G=-209451-(-209472),v=-769319-(-769322),Q=661227+-661221;V=-990070+990128,["\056"]=-818415+818466,D=568137+-568130,j=275934-275918,t=-346253+346287;U=394528-394490;z=165716-165672,T=-649808-(-649841);i=468185-468183;B=-110359-(-110408),P=437620-437603,["\049"]=705960+-705910;p=-896884-(-896894);l=-27818-(-27864);H=-570276-(-570331),q=-839646-(-839657),k=-707041-(-707073),F=-1021165-(-1021185),y=772164+-772133,h=347065+-347023;c=1028447-1028438,s=948333-948281,S=-95770+95775;["\050"]=-176023-(-176047);["\047"]=635460+-635419,I=86733-86677,n=-299791-(-299826);M=-754316+754328,d=-227467+227515,["\054"]=-911668-(-911686);C=-434980+435033;R=714473+-714459,m=36796+-36753;u=465866-465853;X=-1010216+1010231;x=683059-682997;K=-108651+108711;W=920057+-920031;g=-659780+659827,r=-712925-(-712962),Y=367840-367779;e=-78825-(-78826);["\052"]=-179296-(-179323),E=-337607+337607;o=-223310+223349;["\048"]=888880+-888855;["\053"]=998830+-998800}local S=math.floor local y=string.char local P=string.sub local t=type for u=-109085+109086,#V,-121308-(-121309)do local j=V[u]if t(j)=="\115\116\114\105\110\103"then local t=K(j)local s={}local w=-214967-(-214968)local G=795919-795919 local v=-934075+934075 while w<=t do local u=P(j,w,w)local V=W[u]if V then G=G+V*(-802251-(-802315))^((-356595+356598)-v)v=v+(344170-344169)if v==-560314-(-560318)then v=581231+-581231 local u=S(G/(998686+-933150))local V=S((G%(-230678+296214))/(-371036+371292))local K=G%(773140-772884)U(s,y(u,V,K))G=90552+-90552 end elseif u=="\061"then U(s,y(S(G/(6405-(-59131)))))if w>=t or P(j,w+(939106+-939105),w+(-159237+159238))~="\061"then U(s,y(S((G%(961086+-895550))/(-265684+265940))))end break end w=w+(646356-646355)end V[u]=r(s)end end end return(function(u,K,r,W,S,y,P,N,z,t,c,w,s,B,m,b,j,G,V,v)V,w,j,B,t,c,b,v,G,m,s,z,N=function(V,r,W,S)local d,P,C,X,I,H,i,F,k,T,p,o,Z,v,Y,G,Q,l,L,a,j,R,h,J,e,f,x,q,g,M,A,D,w,c while V do if V<7790772-(-201760)then if V<-712276+5122465 then if V<-611715+3230183 then if V<2186427-562428 then if V<688342-(-296741)then if V<1238146-538776 then if V<397738+-238529 then a=1803816231176-(-729663)d=U(-155608-(-128498))v=U(157626-184730)G=u[v]c=t[W[-140465-(-140466)]]F=t[W[185335+-185333]]L=F(d,a)v=c[L]P=G[v]G=t[W[669257+-669254]]V=P==G j=V V=-805196+9714956 else d=824299+-824299 a=500091+-499836 w=G V=t[W[-40718+40719]]L=V(d,a)j[w]=L V=-440161+6268823 w=nil end else F=nil L=nil v=nil V=17077055-882745 end else if V<310151+1185693 then if V<-792081+2115869 then V=-870674+3699114 else c=c+F P=c<=v d=not L P=d and P d=c>=v d=L and d P=d or P d=-258622+3853792 V=P and d P=730349+10337631 V=V or P end else V=true V=V and 991542+14855024 or-220854+16735409 end end else if V<3463174-1008622 then if V<1468721-(-835482)then if V<328857+1614777 then M=-668293+668296 g=-537315+537380 a=s()t[a]=P V=t[L]P=V(M,g)V=852533+-852533 g=V M=s()t[M]=P V=-114989+114989 R=U(-997958-(-970822))P=u[R]Y=B(-1041028+14667268,{})R={P(Y)}P=-639366+639368 q=V V={K(R)}R=V V=R[P]P=U(-406027-(-378897))e=U(-102730-(-75621))Y=V V=u[P]x=t[G]p=u[e]e=p(Y)p=U(55908-83009)o=x(e,p)x={o()}P=V(K(x))x=s()t[x]=P o=t[M]p=o o=-638806-(-638807)e=o o=599638-599638 A=e<o P=-121551+121552 o=P-e V=11369970-437114 else V=t[W[628381-628371]]w=t[W[392855+-392844]]j[V]=w V=t[W[-740203-(-740215)]]w={V(j)}P={K(w)}V=u[U(-164874+137775)]end else f=U(-734089-(-707004))e=U(-330442+303333)V=u[e]A=u[f]e=V(A)V=U(-735792+708652)u[V]=e V=9394996-362032 end else if V<1759662-(-711352)then G=309572-309498 w=t[W[449101-449098]]V=-364553+15294890 j=w*G w=1000163+-999906 P=j%w t[W[669317+-669314]]=P else P=U(-49178-(-22043))V=u[P]P=V()V=P and 10017006-(-677659)or 2535663-(-237231)end end end else if V<467864+3141097 then if V<426882+2408625 then if V<356459+2418943 then if V<2563834-(-176188)then l=t[w]Z=l V=l and 8359433-294458 or 13977025-(-295868)else V=nil P={V}V=u[U(-936874-(-909786))]end else V=true V=V and 52373+4698126 or-371392+14670664 end else if V<-588666+3704114 then if V<2992740-37068 then j=false V=u[U(-895263+868148)]P={j}else t[w]=o V=t[w]V=V and 624496+3047324 or 12431953-285583 end else d=c g=U(464318+-491449)o=20293967698926-(-84220)M=u[g]x=U(-73928-(-46806))q=t[W[-123017-(-123018)]]p=-1036649+10265733374997 R=t[W[34697-34695]]Y=R(x,o)o=U(-620196+593101)g=q[Y]q=U(-55088+27957)a=M[g]M=a(d)g=u[q]R=t[W[-249818-(-249819)]]Y=t[W[502119+-502117]]x=Y(o,p)q=R[x]a=g[q]g=a(d)P=M*g g=U(899417-926548)x=U(844445+-871582)M=u[g]q=t[W[892682-892681]]R=t[W[945200-945198]]o=6173347092893-446051 Y=R(x,o)g=q[Y]a=M[g]M=a(d)V=P*M x=U(726996-754128)a=V o=28823102427128-(-107637)g=U(-737289-(-710158))M=u[g]q=t[W[744339-744338]]R=t[W[321490+-321488]]Y=R(x,o)g=q[Y]q=155886+-155885 P=M[g]g=d+q o=U(-754300-(-727189))M=P(g)q=U(-476410+449279)p=412320643458-309442 g=u[q]R=t[W[-136508-(-136509)]]Y=t[W[-983766-(-983768)]]x=Y(o,p)q=R[x]R=828423+-828422 P=g[q]q=R/d R=1e-06 g=P(q)V=M*g M=V g=a*M q=d+R a=nil d=nil M=nil P=g/q V=G+P G=V V=309625+1043842 end end else if V<554280+3212962 then if V<936910+2747571 then if V<4156102-510300 then V=true t[W[-220205+220206]]=V V=u[U(-111956-(-84843))]P={}else V=845115+4550997 end else j=t[W[592729+-592728]]P=#j j=-569979-(-569979)V=P==j V=V and 16224564-1031565 or 8053582-251822 end else if V<816838+3520319 then V=14613188-30576 G=t[W[-643276+643282]]w=G==j P=w else P=a V=M V=a and-808705+2739163 or 14181466-(-620754)end end end end else if V<6168144-11340 then if V<-346317+6098358 then if V<462746+4542392 then if V<5057253-162416 then if V<5407053-845033 then V=-438895+16633205 else P=U(359776-386916)V=u[P]j=U(583254-610339)P=u[j]j=U(-49518+22433)u[j]=V V=3099287-270847 j=U(-232526-(-205386))u[j]=P j=t[W[-935687+935688]]w=j()end else P=U(-216580-(-189476))V=u[P]V=V and 955436+5323700 or 3846681-955650 end else if V<5666390-242694 then if V<6257760-1025629 then d=M e=U(131925+-159025)p=u[e]e=U(650225-677318)o=p[e]p=o(j,d)d=nil o=t[W[-889854+889860]]e=o()x=p+e Y=x+F x=-994330+994586 R=Y%x F=R x=G[w]V=809142+6010436 e=592479-592478 p=F+e o=v[p]Y=x..o G[w]=Y else Y=nil R=nil M=b(M)v=b(v)g=nil q=nil c=b(c)a=b(a)L=b(L)F=nil Y=-329190-(-329191)M=s()R={}d=nil L=U(-882443-(-855312))x=b(x)F=U(-519162-(-492031))G=b(G)w=b(w)w=nil v=s()G=nil t[v]=w w=s()t[w]=G c=u[F]F=U(-785771+758677)V=16671954-552819 G=c[F]x=349396+-349140 A=x a=U(212244-239344)c=s()g={}t[c]=G q=s()F=u[L]L=U(381211-408350)d=U(-1071475-(-1044356))G=F[L]L=u[d]d=U(604384+-631502)F=L[d]d=u[a]a=U(752180-779325)L=d[a]d=283493-283493 a=s()t[a]=d d=-164134-(-164136)t[M]=d d={}x=-607118-(-607119)t[q]=g g=736298+-736298 f=x x=-1020781+1020781 D=f<x x=Y-f end else V=v V=u[U(-397221-(-370083))]P={G}end end else if V<-546880+6554872 then if V<-825443+6699320 then if V<259839+5565906 then V={}L=-563611-(-563866)t[W[-787346+787348]]=V c=35184372667695-578863 V=-479876+7299454 P=t[W[853909+-853906]]v=P P=w%c d=U(274336-301436)t[W[374674-374670]]=P M=-298139+298140 F=w%L L=821058+-821056 g=M c=F+L t[W[639555-639550]]=c L=u[d]d=U(-594322+567205)F=L[d]L=F(j)d=-791842-(-791843)F=U(110098+-137182)G[w]=F M=747227-747227 a=L F=-495191-(-495261)q=g<M M=d-g else G=G+c L=not F w=G<=v w=L and w L=G>=v L=F and L w=L or w L=1017959+-335266 V=w and L w=-343196+2399270 V=V or w end else j=r[-128655+128656]w=U(1010457+-1037582)L=2810863502616-(-327684)P=u[w]G=t[W[584101-584100]]v=t[W[194020+-194018]]F=U(-371321+344235)c=v(F,L)w=G[c]V=P[w]P=V()V=-607580+607580 v=j w=P P=-845408+845409 G=V c=-776382-(-776383)F=c c=-179973+179973 L=F<c c=P-F V=-87336+1440803 end else if V<-653003+6733364 then V=P and 10568173-(-702717)or 8570759-818352 else R=U(-251057+223938)V=-15490+4377998 q=u[R]R=U(-639895-(-612775))g=q[R]a=g end end end else if V<387877+6743780 then if V<5880205-(-406289)then if V<725784+5547426 then if V<6587687-361957 then A=#R x=553995+-553994 Y=G(x,A)V=440268+12537448 x=F(R,Y)A=t[q]Y=nil J=-561196+561197 D=x-J f=L(D)A[x]=f x=nil else j=U(943678-970819)P=U(-904326-(-877197))V=u[P]P=V(j)P={}V=u[U(533559-560641)]end else V=false d=945956+6677883510017 j=V V=false w=V L=U(-688696+661593)G=U(236122+-263226)P=u[G]v=t[W[-499394-(-499395)]]c=t[W[-411892-(-411894)]]F=c(L,d)G=v[F]V=P[G]V=V and 352311-292408 or-257548+9167308 end else if V<7361047-502501 then if V<77514+6449809 then V=3450833-461707 p=g==q o=p else M=M+g R=not q d=M<=a d=R and d R=M>=a R=q and R d=R or d R=686746+4455862 V=d and R d=-310818+1179108 V=V or d end else a=-619519+619521 w=t[W[-641442+641445]]G=113508+-113476 g=-725120-(-725133)j=w%G v=t[W[-307833+307837]]L=t[W[132347+-132345]]Y=t[W[773853-773850]]R=Y-j Y=-19425+19457 q=R/Y M=g-q d=a^M F=L/d c=v(F)v=-16942+4294984238 G=c%v c=-609338+609340 v=c^j w=G/v d=-695370-(-695371)v=t[W[-531666-(-531670)]]L=w%d d=-194907+4295162203 F=L*d c=v(F)a=568490+-568234 v=t[W[-477936-(-477940)]]F=v(w)G=c+F c=828427-762891 v=G%c V=974667+6827093 w=nil L=-632572-(-698108)F=G-v c=F/L G=nil L=-443011+443267 F=v%L d=v-F L=d/a g=-14206+14462 v=nil a=687270+-687014 d=c%a M=c-d a=M/g M={F;L;d,a}a=nil d=nil L=nil t[W[-594876+594877]]=M j=nil F=nil c=nil end end else if V<7185036-(-707108)then if V<7336021-(-435597)then if V<863940+6745127 then V=B(-186846+1450956,{v})p={V()}P={K(p)}V=u[U(-381384-(-354279))]else V=t[W[-470700+470707]]V=V and 8086066-185631 or 10787061-(-914307)end else V=u[U(-467564+440473)]G=U(415950+-443069)w=u[G]G=U(-479924-(-452806))j=w[G]G=t[W[-997668+997669]]w={j(G)}P={K(w)}end else if V<187927+7770491 then j=U(663228-690357)G=1030576-1030576 V=u[j]w=t[W[-338626-(-338634)]]j=V(w,G)V=12245976-544608 else G=w V=6002043-273412 end end end end end else if V<11805925-(-322618)then if V<1031935+9461508 then if V<8166992-(-744433)then if V<8000830-(-452138)then if V<7786481-(-604136)then if V<63307+8196158 then I=-905968-(-905969)l=X[I]Z=l V=13804385-(-468508)else A=155317+-155317 x=#R V=-473616+6653284 Y=x==A end else J=b(J)C=b(C)T=b(T)i=b(i)f=b(f)X=nil V=-655166+11588022 D=b(D)end else if V<256360+8285771 then if V<423617+8098231 then V=l P=Z V=486902+13795368 else w=t[W[-597984+597985]]c=465739-465737 v=-135475+135476 G=w(v,c)w=999012+-999011 j=G==w P=j V=j and 6191834-181473 or 12005381-(-52157)end else v=U(908825+-935929)a=20079113471568-(-220726)G=u[v]c=t[W[248673-248672]]F=t[W[557451-557449]]d=U(407466-434609)L=F(d,a)v=c[L]P=G[v]V=P and 209707+15454456 or-653203+10207922 end end else if V<-736943+10374738 then if V<9012988-(-596154)then if V<-841022+9925063 then V=2137276-532006 else v=V G=j V=j and 5358737-(-369894)or 6917758-(-1042554)end else f=s()J=137350+-137250 D=U(51207+-78338)t[f]=o H=-942315+942315 P=u[D]D=U(-1041448+1014309)V=P[D]D=258907-258906 P=V(D,J)D=s()T=-847990+848245 t[D]=P J=-758733+758733 C=324993-324992 V=t[L]P=V(J,T)T=-651450-(-651451)J=s()t[J]=P V=t[L]i=t[D]X=791436+-791434 P=V(T,i)T=s()I=U(-281470-(-254361))t[T]=P P=t[L]i=P(C,X)X=U(118777+-145889)P=-579057-(-579058)V=i==P i=s()t[i]=V l=u[I]P=U(-196096+168995)Q=t[L]V=U(-408598+381465)k=479066+-469066 h={Q(H,k)}I=l(K(h))V=Y[V]l=U(930958-958070)Z=I..l C=X..Z V=V(Y,P,C)C=s()X=U(-479062-(-451926))t[C]=V P=u[X]Z=m(-978134+9511199,{L;f;M,G;w,x;i;C;D;T,J;a})X={P(Z)}V={K(X)}X=V V=t[i]V=V and 683296+11067377 or 2243710-(-425007)end else if V<10766731-584460 then p=t[w]V=p and-113634+6431342 or 2848774-(-140352)o=p else h=72615-72613 Q=X[h]h=t[C]I=Q==h V=7749699-(-762614)Z=I end end end else if V<11959343-732376 then if V<10482789-(-443492)then if V<9772630-(-1008890)then if V<11333715-735101 then F=t[c]P=F V=929037+11492221 else P=U(876064+-903188)V=u[P]j=t[W[-677027+677028]]P={V(j)}P={K(P)}V=u[U(-735627-(-708500))]end else V=684034-(-921236)end else if V<11050369-(-58021)then if V<11068641-37334 then o=o+e f=not A P=o<=p P=f and P f=o>=p f=A and f P=f or P f=8823328-(-787130)V=P and f P=50509+9963951 V=V or P else v=U(88048+-115173)P=u[v]d=U(-355406+328299)c=t[W[646387-646386]]F=t[W[324726-324724]]a=4043525437727-274885 L=F(d,a)v=c[L]V=P[v]P=V()v=P V=v-w P={G;V}V=u[U(-252727-(-225604))]end else A=U(-91759-(-64619))V=u[A]A=U(609724+-636809)u[A]=V V=-287743+9320707 end end else if V<562049+11401354 then if V<-95539+11806574 then if V<-867898+12306052 then P=U(688304-715434)a=m(14862544-849720,{})d=U(64073+-91209)V=u[P]j=t[W[-484399-(-484403)]]v=U(58660+-85769)G=u[v]L=u[d]d={L(a)}L=340401+-340399 F={K(d)}c=F[L]v=G(c)G=U(-336264-(-309163))w=j(v,G)j={w()}P=V(K(j))w=t[W[195464+-195459]]j=P V=w and 714421+3116508 or 14672704-90092 P=w else V={}G=t[W[-987770+987779]]j=V v=G G=-260645-(-260646)c=G w=609758+-609757 V=437178+5391484 G=472326+-472326 F=c<G G=w-c end else Z=t[w]P=Z V=Z and 16808378-800844 or 576028+13706242 end else if V<-619617+12640438 then j=r V=true L=U(733105-760241)w=s()G=U(960758+-987858)t[w]=V P=u[G]G=U(-121753-(-94645))v=s()c=s()V=P[G]G=s()t[G]=V V=m(-175412+6430859,{})t[v]=V V=false d=z(951845+2676956,{c})t[c]=V F=u[L]L=F(d)P=L V=L and 10817167-294191 or 127314+12293944 else V=5799714-(-210647)w=t[W[-449025+449027]]G=t[W[-335044+335047]]j=w==G P=j end end end end else if V<15062904-736671 then if V<13912678-409936 then if V<12384348-(-590379)then if V<11881247-(-615773)then if V<11659198-(-640018)then V=true V=-1004186+8456372 else F=P L=U(1020518+-1047649)P=u[L]d=U(-643082+615963)L=U(-752357+725218)V=P[L]q=U(224758-251877)L=s()t[L]=V P=u[d]d=U(763045-790135)V=P[d]g=u[q]a=g d=V M=V V=g and-119045+6235473 or 709545+3652963 end else V=t[W[-486632-(-486633)]]j=r[-567458+567459]w=r[394881-394879]G=V V=G[w]V=V and 449930+4000460 or 4813428-(-987261)end else if V<-923111+14349482 then if V<290438+12802986 then x=#R A=-225987-(-225987)Y=x==A V=Y and 982216+12500694 or 721864+5457804 else Y=x J=Y R[Y]=J V=16480689-361554 Y=nil end else Y={}x=s()t[x]=Y A=B(3007886-(-684502),{x,a,M,c})Y=s()t[Y]=A A={}P={}D=U(-763449+736321)i=U(919921-947063)J={}X=U(-920808-(-893712))f=s()G=nil I=nil F=nil t[f]=A R=nil A=u[D]C=t[f]T={[i]=C;[X]=I}c=b(c)D=A(J,T)A=N(13870068-918939,{f,x;q,a,M,Y})q=b(q)t[v]=D M=b(M)t[w]=A c=s()d=nil a=b(a)g=nil Y=b(Y)G=318731+9681269 V=u[U(589990+-617104)]L=nil t[c]=G F=t[v]x=b(x)a=U(-130677-(-103596))M=372014435962-(-193075)L=t[w]d=L(a,M)M=U(295312+-322428)f=b(f)g=-510164+17784025327917 G=F[d]F=s()t[F]=G L=t[v]d=t[w]a=d(M,g)G=L[a]d=U(-643755+616620)L=s()t[L]=G G=m(450711+4469732,{v,w,F;L})u[d]=G d=U(-269926+242802)q=U(964455-991599)G=z(769957+5174405,{v,w})u[d]=G L=b(L)d=U(-236247-(-209103))G=m(512956+1990544,{c})u[d]=G d=U(742320+-769456)G=u[d]F=b(F)g=u[q]w=b(w)q={G(g)}v=b(v)M=q[-816959+816962]c=b(c)a=q[713323+-713321]d=q[1005587-1005586]M=nil d=nil a=nil end end else if V<15043225-769595 then if V<-683512+14897085 then if V<14751326-996917 then G=-578060+16002259 w=U(893231-920323)j=w^G P=595556+15952356 V=P-j P=U(480520+-507622)j=V V=P/j P={V}V=u[U(354597-381718)]else G=7543906-29831 P=15743015-(-958519)w=U(-557644-(-530518))j=w^G V=P-j j=V P=U(577498-604632)V=P/j P={V}V=u[U(437277+-464360)]end else t[w]=Z h=t[T]H=-125857-(-125858)Q=h+H I=X[Q]l=g+I I=956975+-956719 V=l%I Q=t[J]g=V I=q+Q Q=580659-580403 l=I%Q V=8572489-175134 q=l end else if V<13818754-(-475656)then V=152329+8245026 t[w]=P else V=u[U(-179255-(-152157))]P={}end end end else if V<-170168+15977594 then if V<13981008-(-925667)then if V<15323910-618776 then if V<22280+14444516 then V=true V=V and 597388+10210886 or-830799+8282985 else t[W[-380977-(-380982)]]=P V=7873321-120914 j=nil end else M=U(-645160+618040)a=u[M]V=-274594+2205052 P=a end else if V<16382004-793523 then if V<-51095+14985991 then w=t[W[219474-219471]]G=-68670+68671 j=w~=G V=j and 177638+6693472 or-404641+2873859 else w=t[W[558219-558217]]G=-873602+873687 j=w*G w=33799955074015-839270 P=j+w j=-523760+35184372612592 w=918380-918379 V=P%j t[W[-114664-(-114666)]]=V j=t[W[644671-644668]]V=154335+2314883 P=j~=w end else c=U(-877746-(-850642))a=U(-647522-(-620435))V=8899577-(-655142)v=u[c]M=739610+10513054992901 F=t[W[424024-424023]]L=t[W[666372-666370]]d=L(a,M)c=F[d]G=v[c]v=t[W[491365-491361]]P=G==v w=P end end else if V<16137642-(-21002)then if V<208728+15889844 then if V<-545874+16410992 then A=-702029+702035 V=t[L]e=387469+-387468 p=V(e,A)A=U(466538+-493678)V=U(-955793+928653)u[V]=p e=u[A]A=911589+-911587 V=e>A V=V and-413613+2861633 or 11568089-365572 else l=V h=47277+-47276 Q=X[h]h=false I=Q==h V=I and 405574+10036389 or-263689+8776002 Z=I end else x=x+f J=not D Y=x<=A Y=J and Y J=x>=A J=D and J Y=J or Y J=-939446+14134563 V=Y and J Y=-6381+8360572 V=V or Y end else if V<16599990-111667 then P={w}V=u[U(-716555+689449)]else V=u[U(-287596-(-260507))]P={}end end end end end end end V=#S return K(P)end,374281+-374281,{},function(u,U)local K=G(U)local r=function(r,W)return V(u,{r;W},U,K)end return r end,{},function(u,U)local K=G(U)local r=function(...)return V(u,{...},U,K)end return r end,function(u)j[u]=j[u]-(-845680+845681)if j[u]==751643+-751643 then j[u],t[u]=nil,nil end end,function(u)local U,V=834357+-834356,u[546366+-546365]while V do j[V],U=j[V]-(652122+-652121),(-522614+522615)+U if j[V]==450683-450683 then j[V],t[V]=nil,nil end V=u[U]end end,function(u)for U=316885+-316884,#u,-897581+897582 do j[u[U]]=(-51626+51627)+j[u[U]]end if r then local V=r(true)local K=S(V)K[U(496548-523690)],K[U(-25499+-1598)],K[U(-183497+156417)]=u,v,function()return 1711270-(-866170)end return V else return W({},{[U(170276-197373)]=v,[U(-399336-(-372194))]=u,[U(910953+-938033)]=function()return 3098100-520660 end})end end,function(u,U)local K=G(U)local r=function(r,W,S)return V(u,{r,W,S},U,K)end return r end,function()w=w+(-274031+274032)j[w]=802732+-802731 return w end,function(u,U)local K=G(U)local r=function(r)return V(u,{r},U,K)end return r end,function(u,U)local K=G(U)local r=function(r,W,S,y)return V(u,{r;W,S,y},U,K)end return r end return(c(11731973-(-274588),{}))(K(P))end)(getfenv and getfenv()or _ENV,unpack or table[U(682854-709974)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
