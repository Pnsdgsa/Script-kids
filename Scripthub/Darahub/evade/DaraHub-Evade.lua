local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Mobile UI detection
local UserInputService = game:GetService("UserInputService")
local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
local mobileUI

if isMobile then
    repeat task.wait(0.25) until game:IsLoaded()
    getgenv().Image = "rbxassetid://7229442422"
    getgenv().ToggleUI = "E"

    task.spawn(function()
        if not getgenv().LoadedMobileUI == true then 
            getgenv().LoadedMobileUI = true
            local OpenUI = Instance.new("ScreenGui")
            local ImageButton = Instance.new("ImageButton")
            local UICorner = Instance.new("UICorner")
            
            OpenUI.Name = "OpenUI"
            OpenUI.Parent = game:GetService("CoreGui")
            OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            
            ImageButton.Parent = OpenUI
            ImageButton.BackgroundColor3 = Color3.fromRGB(105,105,105)
            ImageButton.BackgroundTransparency = 0.8
            ImageButton.Position = UDim2.new(0.9,0,0.1,0)
            ImageButton.Size = UDim2.new(0,50,0,50)
            ImageButton.Image = getgenv().Image
            ImageButton.Draggable = true
            ImageButton.Transparency = 1
            
            UICorner.CornerRadius = UDim.new(0,200)
            UICorner.Parent = ImageButton
            
            ImageButton.MouseButton1Click:Connect(function()
                game:GetService("VirtualInputManager"):SendKeyEvent(true,getgenv().ToggleUI,false,game)
            end)
            
            mobileUI = OpenUI
        end
    end)
end

local Window = Fluent:CreateWindow({
    Title = "Fluent " .. Fluent.Version,
    SubTitle = "by dawid",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.E
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Auto = Window:AddTab({ Title = "Auto", Icon = "refresh-cw" }),
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Player reference
local player = Players.LocalPlayer

-- Feature states (persistent across respawns)
local featureStates = {
    InfiniteJump = false,
    Fly = false,
    SpeedHack = false,
    JumpBoost = false,
    AntiAFK = false,
    AutoCarry = false,
    FullBright = false,
    NoFog = false,
    AutoVote = false,
    AutoSelfRevive = false,
    AutoWin = false,
    AutoMoneyFarm = false,
    PlayerTracer = false,
    NextbotTracer = false,
    FlySpeed = 50,
    TpwalkValue = 1,
    JumpPower = 50,
    JumpMethod = "Hold",
    SelectedMap = 1,
    -- ESP States
    ESPPlayer = false,
    ESPTicket = false,
    ESPNextbot = false,
    TracerDowned = false
}

-- Character references (will be updated on respawn)
local character, humanoid, rootPart
local isJumpHeld = false

-- Fly Variables
local flying = false
local bodyVelocity, bodyGyro

-- Speed Hack Variables
local ToggleTpwalk = false
local TpwalkConnection

-- Jump Boost Variables
local jumpCount = 0
local MAX_JUMPS = math.huge

-- Anti AFK Variables
local AntiAFKConnection

-- Auto Carry Variables
local AutoCarryConnection

-- ESP Variables
local playerESPThread, ticketESPThread, nextbotESPThread, tracerThread
local tracerLines = {}

-- Tracer Variables
local playerTracerConnection, nextbotTracerConnection
local playerTracerLines = {}
local nextbotTracerLines = {}

-- Visual Variables
local originalBrightness = Lighting.Brightness
local originalFogEnd = Lighting.FogEnd
local originalOutdoorAmbient = Lighting.OutdoorAmbient
local originalAmbient = Lighting.Ambient
local originalGlobalShadows = Lighting.GlobalShadows

-- Auto Features Variables
local AutoVoteConnection, AutoSelfReviveConnection, AutoWinConnection, AutoMoneyFarmConnection

-- Function to check if player is grounded
local function isPlayerGrounded()
    if not character or not humanoid or not rootPart then
        return false
    end

    local rayOrigin = rootPart.Position
    local rayDirection = Vector3.new(0, -3, 0)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    return raycastResult ~= nil
end

-- Function to make player jump
local function bouncePlayer()
    if character and humanoid and rootPart and humanoid.Health > 0 then
        if not isPlayerGrounded() then
            humanoid.Jump = true
            local jumpVelocity = math.sqrt(1.5 * humanoid.JumpHeight * workspace.Gravity) * 1.5
            rootPart.Velocity = Vector3.new(rootPart.Velocity.X, jumpVelocity * humanoid.JumpPower / 50, rootPart.Velocity.Z)
        end
    end
end

-- Fly Functions
local function startFlying()
    if not character or not humanoid or not rootPart then return end
    
    flying = true
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = rootPart
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyGyro.CFrame = rootPart.CFrame
    bodyGyro.Parent = rootPart
    
    humanoid.PlatformStand = true
    
    Fluent:Notify({
        Title = "Fly",
        Content = "Fly Enabled - Speed: " .. featureStates.FlySpeed,
        Duration = 3
    })
end

local function stopFlying()
    flying = false
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end
    if humanoid then
        humanoid.PlatformStand = false
    end
end

local function updateFly()
    if not flying or not bodyVelocity or not bodyGyro then return end
    
    local camera = workspace.CurrentCamera
    local cameraCFrame = camera.CFrame
    local direction = Vector3.new(0, 0, 0)
    
    local moveDirection = humanoid.MoveDirection
    if moveDirection.Magnitude > 0 then
        local forwardVector = cameraCFrame.LookVector
        local rightVector = cameraCFrame.RightVector
        local forwardComponent = moveDirection:Dot(forwardVector) * forwardVector
        local rightComponent = moveDirection:Dot(rightVector) * rightVector
        direction = direction + (forwardComponent + rightComponent).Unit * moveDirection.Magnitude
    end
    
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) or humanoid.Jump then
        direction = direction + Vector3.new(0, 1, 0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
        direction = direction - Vector3.new(0, 1, 0)
    end
    bodyVelocity.Velocity = direction.Magnitude > 0 and direction.Unit * (featureStates.FlySpeed * 2) or Vector3.new(0, 0, 0)
    bodyGyro.CFrame = cameraCFrame
end

-- Speed Hack (TP Walk) Functions
local function Tpwalking()
    if ToggleTpwalk and character and humanoid and rootPart then
        local moveDirection = humanoid.MoveDirection
        local moveDistance = featureStates.TpwalkValue
        local origin = rootPart.Position
        local direction = moveDirection * moveDistance
        local targetPosition = origin + direction

        -- Raycast to prevent wall clipping
        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {character}
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        local raycastResult = workspace:Raycast(origin, direction, raycastParams)

        if raycastResult then
            local hitPosition = raycastResult.Position
            local distanceToHit = (hitPosition - origin).Magnitude
            if distanceToHit < math.abs(moveDistance) then
                targetPosition = origin + (direction.Unit * (distanceToHit - 0.1))
            end
        end

        rootPart.CFrame = CFrame.new(targetPosition) * rootPart.CFrame.Rotation
        rootPart.CanCollide = true
    end
end

local function startTpwalk()
    ToggleTpwalk = true
    if TpwalkConnection then
        TpwalkConnection:Disconnect()
    end
    TpwalkConnection = RunService.Heartbeat:Connect(Tpwalking)
end

local function stopTpwalk()
    ToggleTpwalk = false
    if TpwalkConnection then
        TpwalkConnection:Disconnect()
        TpwalkConnection = nil
    end
    if rootPart then
        rootPart.CanCollide = false
    end
end

-- Jump Boost Functions
local function setupJumpBoost()
    if not character or not humanoid then return end
    
    -- Reset jump count when landing
    humanoid.StateChanged:Connect(function(oldState, newState)
        if newState == Enum.HumanoidStateType.Landed then
            jumpCount = 0
        end
    end)
    
    -- Handle jump request
    humanoid.Jumping:Connect(function(isJumping)
        if isJumping and featureStates.JumpBoost and jumpCount < MAX_JUMPS then
            jumpCount = jumpCount + 1
            humanoid.JumpPower = featureStates.JumpPower
            -- Apply additional jump force if in air (for multi-jump)
            if jumpCount > 1 then
                rootPart:ApplyImpulse(Vector3.new(0, featureStates.JumpPower * rootPart.Mass, 0))
            end
        end
    end)
end

local function startJumpBoost()
    if humanoid then
        humanoid.JumpPower = featureStates.JumpPower
    end
end

local function stopJumpBoost()
    jumpCount = 0
    if humanoid then
        humanoid.JumpPower = 50
    end
end

-- Anti AFK Functions
local function startAntiAFK()
    AntiAFKConnection = player.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

local function stopAntiAFK()
    if AntiAFKConnection then
        AntiAFKConnection:Disconnect()
        AntiAFKConnection = nil
    end
end

-- Auto Carry Functions
local function startAutoCarry()
    AutoCarryConnection = RunService.Heartbeat:Connect(function()
        if not featureStates.AutoCarry then return end
        
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, other in ipairs(Players:GetPlayers()) do
                if other ~= player and other.Character and other.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (hrp.Position - other.Character.HumanoidRootPart.Position).Magnitude
                    if dist <= 20 then
                        local args = { "Carry", [3] = other.Name }
                        pcall(function()
                            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Character"):WaitForChild("Interact"):FireServer(unpack(args))
                        end)
                        task.wait(0.01)
                    end
                end
            end
        end
    end)
end

local function stopAutoCarry()
    if AutoCarryConnection then
        AutoCarryConnection:Disconnect()
        AutoCarryConnection = nil
    end
end

-- FullBright Functions (Fixed)
local function startFullBright()
    originalBrightness = Lighting.Brightness
    originalOutdoorAmbient = Lighting.OutdoorAmbient
    originalAmbient = Lighting.Ambient
    originalGlobalShadows = Lighting.GlobalShadows
    
    Lighting.Brightness = 2
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    Lighting.GlobalShadows = false
end

local function stopFullBright()
    Lighting.Brightness = originalBrightness
    Lighting.OutdoorAmbient = originalOutdoorAmbient
    Lighting.Ambient = originalAmbient
    Lighting.GlobalShadows = originalGlobalShadows
end

-- No Fog Functions
local function startNoFog()
    originalFogEnd = Lighting.FogEnd
    Lighting.FogEnd = 1000000
end

local function stopNoFog()
    Lighting.FogEnd = originalFogEnd
end

-- Auto Vote Functions
local function fireVoteServer(mapNumber)
    local eventsFolder = ReplicatedStorage:WaitForChild("Events", 10)
    if eventsFolder then
        local playerFolder = eventsFolder:WaitForChild("Player", 10)
        if playerFolder then
            local voteEvent = playerFolder:WaitForChild("Vote", 10)
            if voteEvent and typeof(voteEvent) == "Instance" and voteEvent:IsA("RemoteEvent") then
                local args = {[1] = mapNumber}
                voteEvent:FireServer(unpack(args))
            end
        end
    end
end

local function startAutoVote()
    AutoVoteConnection = RunService.Heartbeat:Connect(function()
        fireVoteServer(featureStates.SelectedMap)
    end)
end

local function stopAutoVote()
    if AutoVoteConnection then
        AutoVoteConnection:Disconnect()
        AutoVoteConnection = nil
    end
end

-- Auto Self Revive Functions
local function startAutoSelfRevive()
    AutoSelfReviveConnection = RunService.Heartbeat:Connect(function()
        if character and character:GetAttribute("Downed") then
            ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(true)
        end
    end)
end

local function stopAutoSelfRevive()
    if AutoSelfReviveConnection then
        AutoSelfReviveConnection:Disconnect()
        AutoSelfReviveConnection = nil
    end
end

-- Auto Win Functions
local function startAutoWin()
    AutoWinConnection = RunService.Heartbeat:Connect(function()
        if character and rootPart then
            if character:GetAttribute("Downed") then
                ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(true)
                task.wait(0.5)
            end

            if not character:GetAttribute("Downed") then
                local securityPart = Instance.new("Part")
                securityPart.Name = "SecurityPartTemp"
                securityPart.Size = Vector3.new(10, 1, 10)
                securityPart.Position = Vector3.new(0, 500, 0)
                securityPart.Anchored = true
                securityPart.Transparency = 1
                securityPart.CanCollide = true
                securityPart.Parent = Workspace

                rootPart.CFrame = securityPart.CFrame + Vector3.new(0, 3, 0)
                task.wait(0.5)
                securityPart:Destroy()
            end
        end
    end)
end

local function stopAutoWin()
    if AutoWinConnection then
        AutoWinConnection:Disconnect()
        AutoWinConnection = nil
    end
end

-- Auto Money Farm Functions
local function startAutoMoneyFarm()
    AutoMoneyFarmConnection = RunService.Heartbeat:Connect(function()
        if character and rootPart then
            if character:GetAttribute("Downed") then
                ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(true)
                task.wait(0.5)
            end

            local downedPlayerFound = false
            local playersInGame = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Players")
            if playersInGame then
                for _, v in pairs(playersInGame:GetChildren()) do
                    if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") and v:GetAttribute("Downed") then
                        rootPart.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                        ReplicatedStorage.Events.Character.Interact:FireServer("Revive", true, v)
                        task.wait(0.5)
                        downedPlayerFound = true
                        break
                    end
                end
            end

            local securityPart = Instance.new("Part")
            securityPart.Name = "SecurityPartTemp"
            securityPart.Size = Vector3.new(10, 1, 10)
            securityPart.Position = Vector3.new(0, 500, 0)
            securityPart.Anchored = true
            securityPart.Transparency = 1
            securityPart.CanCollide = true
            securityPart.Parent = Workspace
            rootPart.CFrame = securityPart.CFrame + Vector3.new(0, 3, 0)
        end
    end)
end

local function stopAutoMoneyFarm()
    if AutoMoneyFarmConnection then
        AutoMoneyFarmConnection:Disconnect()
        AutoMoneyFarmConnection = nil
    end
end

-- Manual Revive Function
local function manualRevive()
    if character and character:GetAttribute("Downed") then
        ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(true)
        Fluent:Notify({
            Title = "Revive",
            Content = "Attempting to revive yourself",
            Duration = 3
        })
    else
        Fluent:Notify({
            Title = "Revive",
            Content = "You are not downed",
            Duration = 3
        })
    end
end

-- Tracer Functions
local function cleanupTracers(tracerTable)
    for _, line in ipairs(tracerTable) do
        if line and line.Remove then 
            line:Remove()
        elseif line then 
            line.Visible = false 
        end
    end
    tracerTable = {}
end

local function startPlayerTracer()
    playerTracerConnection = RunService.Heartbeat:Connect(function()
        cleanupTracers(playerTracerLines)
        
        local folder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players")
        if folder then
            for _, char in ipairs(folder:GetChildren()) do
                if char:IsA("Model") then
                    local team = char:GetAttribute("Team")
                    local downed = char:GetAttribute("Downed")
                    -- Ignore downed players and nextbots
                    if team ~= "Nextbot" and char.Name ~= player.Name and downed ~= true then
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if hrp and workspace.CurrentCamera then
                            local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
                            if onScreen then
                                local tracer = Drawing.new("Line")
                                tracer.Color = Color3.fromRGB(0, 255, 0) -- Green for players
                                tracer.Thickness = 2
                                tracer.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
                                tracer.To = Vector2.new(pos.X, pos.Y)
                                tracer.ZIndex = 1
                                tracer.Visible = true
                                table.insert(playerTracerLines, tracer)
                            end
                        end
                    end
                end
            end
        end
    end)
end

local function stopPlayerTracer()
    if playerTracerConnection then
        playerTracerConnection:Disconnect()
        playerTracerConnection = nil
    end
    cleanupTracers(playerTracerLines)
end

local function startNextbotTracer()
    nextbotTracerConnection = RunService.Heartbeat:Connect(function()
        cleanupTracers(nextbotTracerLines)
        
        local folder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players")
        if folder then
            for _, npc in ipairs(folder:GetChildren()) do
                if npc:IsA("Model") and npc:GetAttribute("Team") == "Nextbot" then
                    local hrp = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Hitbox")
                    if hrp and workspace.CurrentCamera then
                        local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
                        if onScreen then
                            local tracer = Drawing.new("Line")
                            tracer.Color = Color3.fromRGB(255, 0, 0) -- Red for nextbots
                            tracer.Thickness = 2
                            tracer.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
                            tracer.To = Vector2.new(pos.X, pos.Y)
                            tracer.ZIndex = 1
                            tracer.Visible = true
                            table.insert(nextbotTracerLines, tracer)
                        end
                    end
                end
            end
        end
    end)
end

local function stopNextbotTracer()
    if nextbotTracerConnection then
        nextbotTracerConnection:Disconnect()
        nextbotTracerConnection = nil
    end
    cleanupTracers(nextbotTracerLines)
end

-- Function to reapply all active features after respawn
local function reapplyFeatures()
    -- Reapply Fly
    if featureStates.Fly then
        if flying then
            stopFlying()
        end
        startFlying()
    end
    
    -- Reapply Speed Hack
    if featureStates.SpeedHack then
        if ToggleTpwalk then
            stopTpwalk()
        end
        startTpwalk()
    end
    
    -- Reapply Jump Boost
    if featureStates.JumpBoost then
        startJumpBoost()
    end
    
    -- Reapply Anti AFK
    if featureStates.AntiAFK then
        if AntiAFKConnection then
            stopAntiAFK()
        end
        startAntiAFK()
    end
    
    -- Reapply Auto Carry
    if featureStates.AutoCarry then
        if AutoCarryConnection then
            stopAutoCarry()
        end
        startAutoCarry()
    end
    
    -- Reapply Visual Features
    if featureStates.FullBright then
        startFullBright()
    else
        stopFullBright()
    end
    
    if featureStates.NoFog then
        startNoFog()
    else
        stopNoFog()
    end
    
    -- Reapply Auto Features
    if featureStates.AutoVote then
        if AutoVoteConnection then
            stopAutoVote()
        end
        startAutoVote()
    end
    
    if featureStates.AutoSelfRevive then
        if AutoSelfReviveConnection then
            stopAutoSelfRevive()
        end
        startAutoSelfRevive()
    end
    
    if featureStates.AutoWin then
        if AutoWinConnection then
            stopAutoWin()
        end
        startAutoWin()
    end
    
    if featureStates.AutoMoneyFarm then
        if AutoMoneyFarmConnection then
            stopAutoMoneyFarm()
        end
        startAutoMoneyFarm()
    end
    
    -- Reapply Tracer Features
    if featureStates.PlayerTracer then
        if playerTracerConnection then
            stopPlayerTracer()
        end
        startPlayerTracer()
    end
    
    if featureStates.NextbotTracer then
        if nextbotTracerConnection then
            stopNextbotTracer()
        end
        startNextbotTracer()
    end
    
    Fluent:Notify({
        Title = "System",
        Content = "Features reapplied after respawn",
        Duration = 3
    })
end

-- Handle character loading
local function onCharacterAdded(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Set up jump boost system
    setupJumpBoost()
    
    -- Reapply all active features
    reapplyFeatures()
end

-- Input handling for different jump methods
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.Space then
        if featureStates.InfiniteJump then
            if featureStates.JumpMethod == "Hold" then
                isJumpHeld = true
                bouncePlayer()
                -- Hold loop
                spawn(function()
                    while isJumpHeld and featureStates.InfiniteJump and featureStates.JumpMethod == "Hold" do
                        bouncePlayer()
                        wait(0.1)
                    end
                end)
            elseif featureStates.JumpMethod == "Spam" then
                bouncePlayer()
            end
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.Space then
        isJumpHeld = false
    end
end)

-- Initialize character
if player.Character then
    onCharacterAdded(player.Character)
end
player.CharacterAdded:Connect(onCharacterAdded)

-- Connect fly update
RunService.RenderStepped:Connect(updateFly)

-- UI Setup
do
    -- Add Infinite Jump toggle (at the top)
    local InfiniteJumpToggle = Tabs.Main:AddToggle("InfiniteJump", {
        Title = "Infinite Jump", 
        Default = false 
    })

    InfiniteJumpToggle:OnChanged(function()
        featureStates.InfiniteJump = Options.InfiniteJump.Value
        if Options.InfiniteJump.Value then
            Fluent:Notify({
                Title = "Infinite Jump",
                Content = "Enabled - Method: " .. featureStates.JumpMethod,
                Duration = 3
            })
        else
            isJumpHeld = false
            Fluent:Notify({
                Title = "Infinite Jump",
                Content = "Disabled",
                Duration = 3
            })
        end
    end)

    -- Add dropdown for jump method
    local Dropdown = Tabs.Main:AddDropdown("JumpMethod", {
        Title = "Jump Method",
        Values = {"Hold", "Spam"},
        Multi = false,
        Default = "Hold",
    })

    Dropdown:OnChanged(function(Value)
        featureStates.JumpMethod = Value
        print("Jump method changed to:", Value)
    end)

    -- Add Fly toggle
    local FlyToggle = Tabs.Main:AddToggle("Fly", {
        Title = "Fly",
        Default = false
    })

    FlyToggle:OnChanged(function()
        featureStates.Fly = Options.Fly.Value
        if Options.Fly.Value then
            startFlying()
        else
            stopFlying()
        end
    end)

    -- Add Fly Speed slider (Max 900)
    local FlySpeedSlider = Tabs.Main:AddSlider("FlySpeed", {
        Title = "Fly Speed",
        Description = "Adjust fly movement speed",
        Default = 50,
        Min = 1,
        Max = 900,
        Rounding = 1,
        Callback = function(Value)
            featureStates.FlySpeed = Value
            if flying then
                Fluent:Notify({
                    Title = "Fly Speed",
                    Content = "Speed updated to: " .. Value,
                    Duration = 2
                })
            end
        end
    })

    FlySpeedSlider:OnChanged(function(Value)
        featureStates.FlySpeed = Value
    end)

    -- Add Speed Hack toggle
    local SpeedHackToggle = Tabs.Main:AddToggle("SpeedHack", {
        Title = "Speed Hack",
        Default = false
    })

    SpeedHackToggle:OnChanged(function()
        featureStates.SpeedHack = Options.SpeedHack.Value
        if Options.SpeedHack.Value then
            startTpwalk()
        else
            stopTpwalk()
        end
    end)

    -- Add Speed Hack slider with default value 1
    local SpeedHackSlider = Tabs.Main:AddSlider("SpeedHackValue", {
        Title = "Speed Hack Value",
        Description = "Adjust teleport distance per frame",
        Default = 1,
        Min = 1,
        Max = 500,
        Rounding = 1,
        Callback = function(Value)
            featureStates.TpwalkValue = Value
            if ToggleTpwalk then
                Fluent:Notify({
                    Title = "Speed Hack",
                    Content = "Speed updated to: " .. Value,
                    Duration = 2
                })
            end
        end
    })

    SpeedHackSlider:OnChanged(function(Value)
        featureStates.TpwalkValue = Value
    end)

    -- Add Jump Height toggle
    local JumpBoostToggle = Tabs.Main:AddToggle("JumpBoost", {
        Title = "Jump Height",
        Default = false
    })

    JumpBoostToggle:OnChanged(function()
        featureStates.JumpBoost = Options.JumpBoost.Value
        if Options.JumpBoost.Value then
            startJumpBoost()
            Fluent:Notify({
                Title = "Jump Height",
                Content = "Enabled - Power: " .. featureStates.JumpPower,
                Duration = 3
            })
        else
            stopJumpBoost()
            Fluent:Notify({
                Title = "Jump Height",
                Content = "Disabled",
                Duration = 3
            })
        end
    end)

    -- Add Jump Power slider
    local JumpBoostSlider = Tabs.Main:AddSlider("JumpPower", {
        Title = "Jump Power",
        Description = "Adjust jump height and power",
        Default = 50,
        Min = 16,
        Max = 500,
        Rounding = 1,
        Callback = function(Value)
            featureStates.JumpPower = Value
            if featureStates.JumpBoost then
                if humanoid then
                    humanoid.JumpPower = featureStates.JumpPower
                end
                Fluent:Notify({
                    Title = "Jump Height",
                    Content = "Jump power updated to: " .. Value,
                    Duration = 2
                })
            end
        end
    })

    JumpBoostSlider:OnChanged(function(Value)
        featureStates.JumpPower = Value
    end)

    -- Add Anti AFK toggle
    local AntiAFKToggle = Tabs.Main:AddToggle("AntiAFK", {
        Title = "Anti AFK",
        Default = false
    })

    AntiAFKToggle:OnChanged(function()
        featureStates.AntiAFK = Options.AntiAFK.Value
        if Options.AntiAFK.Value then
            startAntiAFK()
            Fluent:Notify({
                Title = "Anti AFK",
                Content = "Enabled - You won't be kicked for AFK",
                Duration = 3
            })
        else
            stopAntiAFK()
            Fluent:Notify({
                Title = "Anti AFK",
                Content = "Disabled",
                Duration = 3
            })
        end
    end)

    -- Visuals Tab
    -- Add FullBright toggle
    local FullBrightToggle = Tabs.Visuals:AddToggle("FullBright", {
        Title = "FullBright",
        Default = false
    })

    FullBrightToggle:OnChanged(function()
        featureStates.FullBright = Options.FullBright.Value
        if Options.FullBright.Value then
            startFullBright()
            Fluent:Notify({
                Title = "FullBright",
                Content = "Enabled",
                Duration = 3
            })
        else
            stopFullBright()
            Fluent:Notify({
                Title = "FullBright",
                Content = "Disabled",
                Duration = 3
            })
        end
    end)

    -- Add No Fog toggle
    local NoFogToggle = Tabs.Visuals:AddToggle("NoFog", {
        Title = "Remove Fog",
        Default = false
    })

    NoFogToggle:OnChanged(function()
        featureStates.NoFog = Options.NoFog.Value
        if Options.NoFog.Value then
            startNoFog()
            Fluent:Notify({
                Title = "No Fog",
                Content = "Enabled",
                Duration = 3
            })
        else
            stopNoFog()
            Fluent:Notify({
                Title = "No Fog",
                Content = "Disabled",
                Duration = 3
            })
        end
    end)

    -- Add Player Tracer toggle
    local PlayerTracerToggle = Tabs.Visuals:AddToggle("PlayerTracer", {
        Title = "Player Tracer (Ignore Downed)",
        Default = false
    })

    PlayerTracerToggle:OnChanged(function()
        featureStates.PlayerTracer = Options.PlayerTracer.Value
        if Options.PlayerTracer.Value then
            startPlayerTracer()
            Fluent:Notify({
                Title = "Player Tracer",
                Content = "Enabled - Ignoring downed players",
                Duration = 3
            })
        else
            stopPlayerTracer()
            Fluent:Notify({
                Title = "Player Tracer",
                Content = "Disabled",
                Duration = 3
            })
        end
    end)

    -- Add Nextbot Tracer toggle
    local NextbotTracerToggle = Tabs.Visuals:AddToggle("NextbotTracer", {
        Title = "Nextbot Tracer",
        Default = false
    })

    NextbotTracerToggle:OnChanged(function()
        featureStates.NextbotTracer = Options.NextbotTracer.Value
        if Options.NextbotTracer.Value then
            startNextbotTracer()
            Fluent:Notify({
                Title = "Nextbot Tracer",
                Content = "Enabled",
                Duration = 3
            })
        else
            stopNextbotTracer()
            Fluent:Notify({
                Title = "Nextbot Tracer",
                Content = "Disabled",
                Duration = 3
            })
        end
    end)

    -- Auto Tab
    -- Add Auto Carry toggle
    local AutoCarryToggle = Tabs.Auto:AddToggle("AutoCarry", {
        Title = "Auto Carry",
        Default = false
    })

    AutoCarryToggle:OnChanged(function()
        featureStates.AutoCarry = Options.AutoCarry.Value
        if Options.AutoCarry.Value then
            startAutoCarry()
            Fluent:Notify({
                Title = "Auto Carry",
                Content = "Enabled - Automatically carrying nearby players",
                Duration = 3
            })
        else
            stopAutoCarry()
            Fluent:Notify({
                Title = "Auto Carry",
                Content = "Disabled",
                Duration = 3
            })
        end
    end)

    -- Add Auto Vote dropdown
    local AutoVoteDropdown = Tabs.Auto:AddDropdown("AutoVoteMap", {
        Title = "Auto Vote Map",
        Values = {"Map 1", "Map 2", "Map 3", "Map 4"},
        Multi = false,
        Default = "Map 1",
    })

    AutoVoteDropdown:OnChanged(function(Value)
        if Value == "Map 1" then
            featureStates.SelectedMap = 1
        elseif Value == "Map 2" then
            featureStates.SelectedMap = 2
        elseif Value == "Map 3" then
            featureStates.SelectedMap = 3
        elseif Value == "Map 4" then
            featureStates.SelectedMap = 4
        end
    end)

    -- Add Auto Vote toggle
    local AutoVoteToggle = Tabs.Auto:AddToggle("AutoVote", {
        Title = "Auto Vote",
        Default = false
    })

    AutoVoteToggle:OnChanged(function()
        featureStates.AutoVote = Options.AutoVote.Value
        if Options.AutoVote.Value then
            startAutoVote()
            Fluent:Notify({
                Title = "Auto Vote",
                Content = "Enabled - Auto voting for map " .. featureStates.SelectedMap,
                Duration = 3
            })
        else
            stopAutoVote()
            Fluent:Notify({
                Title = "Auto Vote",
                Content = "Disabled",
                Duration = 3
            })
        end
    end)

    -- Add Auto Self Revive toggle
    local AutoSelfReviveToggle = Tabs.Auto:AddToggle("AutoSelfRevive", {
        Title = "Auto Self Revive",
        Default = false
    })

    AutoSelfReviveToggle:OnChanged(function()
        featureStates.AutoSelfRevive = Options.AutoSelfRevive.Value
        if Options.AutoSelfRevive.Value then
            startAutoSelfRevive()
            Fluent:Notify({
                Title = "Auto Self Revive",
                Content = "Enabled - Automatically reviving when downed",
                Duration = 3
            })
        else
            stopAutoSelfRevive()
            Fluent:Notify({
                Title = "Auto Self Revive",
                Content = "Disabled",
                Duration = 3
            })
        end
    end)

    -- Add Manual Revive button
    Tabs.Auto:AddButton({
        Title = "Manual Revive",
        Description = "Manually revive yourself",
        Callback = function()
            manualRevive()
        end
    })

    -- Add Auto Win toggle
    local AutoWinToggle = Tabs.Auto:AddToggle("AutoWin", {
        Title = "Auto Win",
        Default = false
    })

    AutoWinToggle:OnChanged(function()
        featureStates.AutoWin = Options.AutoWin.Value
        if Options.AutoWin.Value then
            startAutoWin()
            Fluent:Notify({
                Title = "Auto Win",
                Content = "Enabled - Auto win farming",
                Duration = 3
            })
        else
            stopAutoWin()
            Fluent:Notify({
                Title = "Auto Win",
                Content = "Disabled",
                Duration = 3
            })
        end
    end)

    -- Add Auto Money Farm toggle
    local AutoMoneyFarmToggle = Tabs.Auto:AddToggle("AutoMoneyFarm", {
        Title = "Auto Money Farm",
        Default = false
    })

    AutoMoneyFarmToggle:OnChanged(function()
        featureStates.AutoMoneyFarm = Options.AutoMoneyFarm.Value
        if Options.AutoMoneyFarm.Value then
            startAutoMoneyFarm()
            Fluent:Notify({
                Title = "Auto Money Farm",
                Content = "Enabled - Auto money farming",
                Duration = 3
            })
        else
            stopAutoMoneyFarm()
            Fluent:Notify({
                Title = "Auto Money Farm",
                Content = "Disabled",
                Duration = 3
            })
        end
    end)

    -- Set initial values
    Options.InfiniteJump:SetValue(false)
    Options.Fly:SetValue(false)
    Options.SpeedHack:SetValue(false)
    Options.JumpBoost:SetValue(false)
    Options.AntiAFK:SetValue(false)
    Options.AutoCarry:SetValue(false)
    Options.FullBright:SetValue(false)
    Options.NoFog:SetValue(false)
    Options.PlayerTracer:SetValue(false)
    Options.NextbotTracer:SetValue(false)
    Options.AutoVote:SetValue(false)
    Options.AutoSelfRevive:SetValue(false)
    Options.AutoWin:SetValue(false)
    Options.AutoMoneyFarm:SetValue(false)
    FlySpeedSlider:SetValue(50)
    SpeedHackSlider:SetValue(1)
    JumpBoostSlider:SetValue(50)
end

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()
