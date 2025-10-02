-- Load WindUI
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- Localization setup
local Localization = WindUI:Localization({
    Enabled = true,
    Prefix = "loc:",
    DefaultLanguage = "en",
    Translations = {
        ["en"] = {
            ["SCRIPT_TITLE"] = "Game Hack UI",
            ["WELCOME"] = "Welcome to the Hack UI!",
            ["LIB_DESC"] = "Beautiful UI library for Roblox",
            ["FEATURES"] = "Features",
            ["MAIN_TAB"] = "Main",
            ["AUTO_TAB"] = "Auto",
            ["VISUALS_TAB"] = "Visuals",
            ["ESP_TAB"] = "ESP",
            ["SETTINGS_TAB"] = "Settings",
            ["INFINITE_JUMP"] = "Infinite Jump",
            ["AUTO_JUMP"] = "Auto Jump",
            ["JUMP_METHOD"] = "Jump Method",
            ["FLY"] = "Fly",
            ["FLY_SPEED"] = "Fly Speed",
            ["SPEED_HACK"] = "Speed Hack",
            ["SPEED_HACK_VALUE"] = "Speed Hack Value",
            ["JUMP_HEIGHT"] = "Jump Height",
            ["JUMP_POWER"] = "Jump Power",
            ["ANTI_AFK"] = "Anti AFK",
            ["FULL_BRIGHT"] = "FullBright",
            ["NO_FOG"] = "Remove Fog",
            ["FOV"] = "Field of View",
            ["PLAYER_BOX_ESP"] = "Player Box ESP",
            ["PLAYER_TRACER"] = "Player Tracer",
            ["PLAYER_NAME_ESP"] = "Player Name ESP",
            ["PLAYER_DISTANCE_ESP"] = "Player Distance ESP",
            ["PLAYER_RAINBOW_BOXES"] = "Player Rainbow Boxes",
            ["PLAYER_RAINBOW_TRACERS"] = "Player Rainbow Tracers",
            ["NEXTBOT_BOX_ESP"] = "Nextbot Box ESP",
            ["NEXTBOT_TRACER"] = "Nextbot Tracer",
            ["NEXTBOT_NAME_ESP"] = "Nextbot Name ESP",
            ["NEXTBOT_DISTANCE_ESP"] = "Nextbot Distance ESP",
            ["NEXTBOT_RAINBOW_BOXES"] = "Nextbot Rainbow Boxes",
            ["NEXTBOT_RAINBOW_TRACERS"] = "Nextbot Rainbow Tracers",
            ["DOWNED_BOX_ESP"] = "Downed Player Box ESP",
            ["DOWNED_TRACER"] = "Downed Player Tracer",
            ["DOWNED_NAME_ESP"] = "Downed Player Name ESP",
            ["DOWNED_DISTANCE_ESP"] = "Downed Player Distance ESP",
            ["AUTO_CARRY"] = "Auto Carry",
            ["AUTO_REVIVE"] = "Auto Revive",
            ["AUTO_VOTE"] = "Auto Vote",
            ["AUTO_VOTE_MAP"] = "Auto Vote Map",
            ["AUTO_SELF_REVIVE"] = "Auto Self Revive",
            ["MANUAL_REVIVE"] = "Manual Revive",
            ["AUTO_WIN"] = "Auto Win",
            ["AUTO_MONEY_FARM"] = "Auto Money Farm",
            ["SAVE_CONFIG"] = "Save Configuration",
            ["LOAD_CONFIG"] = "Load Configuration",
            ["THEME_SELECT"] = "Select Theme",
            ["TRANSPARENCY"] = "Window Transparency"
        }
    }
})

-- Gradient function for popup title
local function gradient(text, startColor, endColor)
    local result = ""
    for i = 1, #text do
        local t = (i - 1) / (#text - 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, text:sub(i, i))
    end
    return result
end

-- Show popup
WindUI:Popup({
    Title = gradient("Game Hack UI", Color3.fromHex("#6A11CB"), Color3.fromHex("#2575FC")),
    Icon = "sparkles",
    Content = "loc:LIB_DESC",
    Buttons = {
        {
            Title = "Get Started",
            Icon = "arrow-right",
            Variant = "Primary",
            Callback = function() end
        }
    }
})

-- Set WindUI properties
WindUI.TransparencyValue = 0.2
WindUI:SetTheme("Dark")

-- Create WindUI window
local Window = WindUI:CreateWindow({
    Title = "loc:SCRIPT_TITLE",
    Icon = "rocket",
    Author = "loc:WELCOME",
    Folder = "GameHackUI",
    Size = UDim2.fromOffset(580, 490),
    Theme = "Dark",
    HidePanelBackground = false,
    Acrylic = false,
    HideSearchBar = false,
    SideBarWidth = 200,
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
        end
    }
})

-- Add tags and time tag
Window:SetIconSize(48)
Window:Tag({
    Title = "v1.0.0",
    Color = Color3.fromHex("#30ff6a")
})
Window:Tag({
    Title = "Beta",
    Color = Color3.fromHex("#315dff")
})
local TimeTag = Window:Tag({
    Title = "--:--",
    Radius = 0,
    Color = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#FF0F7B"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#F89B29"), Transparency = 0 },
    }, {
        Rotation = 45,
    })
})

local hue = 0
task.spawn(function()
    while true do
        local now = os.date("*t")
        local hours = string.format("%02d", now.hour)
        local minutes = string.format("%02d", now.min)
        hue = (hue + 0.01) % 1
        TimeTag:SetTitle(hours .. ":" .. minutes)
        task.wait(0.06)
    end
end)

-- Theme switcher button
Window:CreateTopbarButton("theme-switcher", "moon", function()
    WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "Light" or "Dark")
end, 990)

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")

-- Player reference
local player = Players.LocalPlayer

-- Feature states
local featureStates = {
    InfiniteJump = false,
    AutoJump = false,
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
    AutoRevive = false,
    PlayerESP = {
        boxes = false,
        tracers = false,
        names = false,
        distance = false,
        rainbowBoxes = false,
        rainbowTracers = false,
    },
    NextbotESP = {
        boxes = false,
        tracers = false,
        names = false,
        distance = false,
        rainbowBoxes = false,
        rainbowTracers = false,
    },
    DownedBoxESP = false,
    DownedTracer = false,
    DownedNameESP = false,
    DownedDistanceESP = false,
    FlySpeed = 50,
    TpwalkValue = 1,
    JumpPower = 50,
    JumpMethod = "Hold",
    SelectedMap = 1,
    DesiredFOV = 70
}

-- Character references
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

-- Auto Jump Variables
local AutoJumpConnection

-- Anti AFK Variables
local AntiAFKConnection

-- Auto Carry Variables
local AutoCarryConnection

-- Auto Revive Variables
local reviveRange = 10
local loopDelay = 0.15
local reviveLoopHandle = nil
local interactEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Character"):WaitForChild("Interact")

-- ESP Variables
local playerEspElements = {}
local playerEspConnection = nil
local nextbotEspElements = {}
local nextbotEspConnection = nil
local downedTracerConnection
local downedNameESPConnection
local downedTracerLines = {}
local downedNameESPLabels = {}

-- Player ESP Module
local function updatePlayerESP()
    if not camera then camera = workspace.CurrentCamera end
    local screenBottomCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
    local currentTargets = {}

    if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players") then
        for _, model in pairs(workspace.Game.Players:GetChildren()) do
            if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") then
                local isPlayer = Players:GetPlayerFromCharacter(model) ~= nil
                if isPlayer and model.Name ~= player.Name then
                    currentTargets[model] = true
                    if not playerEspElements[model] then
                        playerEspElements[model] = {
                            box = Drawing.new("Square"),
                            tracer = Drawing.new("Line"),
                            name = Drawing.new("Text"),
                            distance = Drawing.new("Text"),
                        }
                        playerEspElements[model].box.Thickness = 2
                        playerEspElements[model].box.Filled = false
                        playerEspElements[model].tracer.Thickness = 1
                        playerEspElements[model].name.Size = 14
                        playerEspElements[model].name.Center = true
                        playerEspElements[model].name.Outline = true
                        playerEspElements[model].distance.Size = 14
                        playerEspElements[model].distance.Center = true
                        playerEspElements[model].distance.Outline = true
                    end

                    local esp = playerEspElements[model]
                    local hrp = model.HumanoidRootPart
                    local vector, onScreen = camera:WorldToViewportPoint(hrp.Position)

                    if onScreen then
                        local topY = camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0)).Y
                        local bottomY = camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y
                        local size = (bottomY - topY) / 2
                        local toggles = featureStates.PlayerESP

                        if toggles.boxes then
                            esp.box.Visible = true
                            esp.box.Size = Vector2.new(size * 2, size * 3)
                            esp.box.Position = Vector2.new(vector.X - size, vector.Y - size * 1.5)
                            if toggles.rainbowBoxes then
                                local hue = (tick() % 5) / 5
                                esp.box.Color = Color3.fromHSV(hue, 1, 1)
                            else
                                esp.box.Color = Color3.fromRGB(0, 255, 0)
                            end
                        else
                            esp.box.Visible = false
                        end

                        if toggles.tracers then
                            esp.tracer.Visible = true
                            esp.tracer.From = screenBottomCenter
                            esp.tracer.To = Vector2.new(vector.X, vector.Y)
                            if toggles.rainbowTracers then
                                local hue = (tick() % 5) / 5
                                esp.tracer.Color = Color3.fromHSV(hue, 1, 1)
                            else
                                esp.tracer.Color = Color3.fromRGB(0, 255, 0)
                            end
                        else
                            esp.tracer.Visible = false
                        end

                        if toggles.names then
                            esp.name.Visible = true
                            esp.name.Text = model.Name
                            esp.name.Position = Vector2.new(vector.X, vector.Y - size * 1.5 - 20)
                            esp.name.Color = Color3.fromRGB(255, 255, 255)
                        else
                            esp.name.Visible = false
                        end

                        if toggles.distance then
                            local distance = (Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (Players.LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude) or 0
                            esp.distance.Visible = true
                            esp.distance.Text = string.format("%.1f", distance)
                            esp.distance.Position = Vector2.new(vector.X, vector.Y + size * 1.5 + 5)
                            esp.distance.Color = Color3.fromRGB(255, 255, 255)
                        else
                            esp.distance.Visible = false
                        end
                    else
                        esp.box.Visible = false
                        esp.tracer.Visible = false
                        esp.name.Visible = false
                        esp.distance.Visible = false
                    end
                end
            end
        end
    end

    for target, esp in pairs(playerEspElements) do
        if not currentTargets[target] then
            for _, drawing in pairs(esp) do
                pcall(function() drawing:Remove() end)
            end
            playerEspElements[target] = nil
        end
    end
end

local function startPlayerESP()
    if playerEspConnection then return end
    playerEspConnection = RunService.RenderStepped:Connect(updatePlayerESP)
end

local function stopPlayerESP()
    if playerEspConnection then
        playerEspConnection:Disconnect()
        playerEspConnection = nil
    end
    for _, esp in pairs(playerEspElements) do
        for _, drawing in pairs(esp) do
            pcall(function() drawing:Remove() end)
        end
    end
    playerEspElements = {}
end

-- Nextbot ESP Module
local nextBotNames = {}
if ReplicatedStorage:FindFirstChild("NPCs") then
    for _, npc in ipairs(ReplicatedStorage.NPCs:GetChildren()) do
        table.insert(nextBotNames, npc.Name)
    end
end

local function isNextbotModel(model)
    if not model or not model.Name then return false end
    for _, name in ipairs(nextBotNames) do
        if model.Name == name then return true end
    end
    return false
end

local function updateNextbotESP()
    if not camera then camera = workspace.CurrentCamera end
    local screenBottomCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
    local currentTargets = {}

    if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players") then
        for _, model in pairs(workspace.Game.Players:GetChildren()) do
            processModel(model)
        end
    end

    if workspace:FindFirstChild("NPCs") then
        for _, model in pairs(workspace.NPCs:GetChildren()) do
            processModel(model)
        end
    end

    local function processModel(model)
        if not model or not model:IsA("Model") or not model:FindFirstChild("HumanoidRootPart") then return end
        if not isNextbotModel(model) then return end
        currentTargets[model] = true

        if not nextbotEspElements[model] then
            nextbotEspElements[model] = {
                box = Drawing.new("Square"),
                tracer = Drawing.new("Line"),
                name = Drawing.new("Text"),
                distance = Drawing.new("Text"),
            }
            nextbotEspElements[model].box.Thickness = 2
            nextbotEspElements[model].box.Filled = false
            nextbotEspElements[model].tracer.Thickness = 1
            nextbotEspElements[model].name.Size = 14
            nextbotEspElements[model].name.Center = true
            nextbotEspElements[model].name.Outline = true
            nextbotEspElements[model].distance.Size = 14
            nextbotEspElements[model].distance.Center = true
            nextbotEspElements[model].distance.Outline = true
        end

        local esp = nextbotEspElements[model]
        local hrp = model.HumanoidRootPart
        local vector, onScreen = camera:WorldToViewportPoint(hrp.Position)

        if onScreen then
            local topY = camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0)).Y
            local bottomY = camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y
            local size = (bottomY - topY) / 2
            local toggles = featureStates.NextbotESP

            if toggles.boxes then
                esp.box.Visible = true
                esp.box.Size = Vector2.new(size * 2, size * 3)
                esp.box.Position = Vector2.new(vector.X - size, vector.Y - size * 1.5)
                if toggles.rainbowBoxes then
                    local hue = (tick() % 5) / 5
                    esp.box.Color = Color3.fromHSV(hue, 1, 1)
                else
                    esp.box.Color = Color3.fromRGB(255, 0, 0)
                end
            else
                esp.box.Visible = false
            end

            if toggles.tracers then
                esp.tracer.Visible = true
                esp.tracer.From = screenBottomCenter
                esp.tracer.To = Vector2.new(vector.X, vector.Y)
                if toggles.rainbowTracers then
                    local hue = (tick() % 5) / 5
                    esp.tracer.Color = Color3.fromHSV(hue, 1, 1)
                else
                    esp.tracer.Color = Color3.fromRGB(255, 0, 0)
                end
            else
                esp.tracer.Visible = false
            end

            if toggles.names then
                esp.name.Visible = true
                esp.name.Text = model.Name
                esp.name.Position = Vector2.new(vector.X, vector.Y - size * 1.5 - 20)
                esp.name.Color = Color3.fromRGB(255, 255, 255)
            else
                esp.name.Visible = false
            end

            if toggles.distance then
                local distance = (Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                    (Players.LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude) or 0
                esp.distance.Visible = true
                esp.distance.Text = string.format("%.1f", distance)
                esp.distance.Position = Vector2.new(vector.X, vector.Y + size * 1.5 + 5)
                esp.distance.Color = Color3.fromRGB(255, 255, 255)
            else
                esp.distance.Visible = false
            end
        else
            esp.box.Visible = false
            esp.tracer.Visible = false
            esp.name.Visible = false
            esp.distance.Visible = false
        end
    end

    for target, esp in pairs(nextbotEspElements) do
        if not currentTargets[target] then
            for _, drawing in pairs(esp) do
                pcall(function() drawing:Remove() end)
            end
            nextbotEspElements[target] = nil
        end
    end
end

local function startNextbotESP()
    if nextbotEspConnection then return end
    nextbotEspConnection = RunService.RenderStepped:Connect(updateNextbotESP)
end

local function stopNextbotESP()
    if nextbotEspConnection then
        nextbotEspConnection:Disconnect()
        nextbotEspConnection = nil
    end
    for _, esp in pairs(nextbotEspElements) do
        for _, drawing in pairs(esp) do
            pcall(function() drawing:Remove() end)
        end
    end
    nextbotEspElements = {}
end

-- Visual Variables
local originalBrightness = Lighting.Brightness
local originalFogEnd = Lighting.FogEnd
local originalOutdoorAmbient = Lighting.OutdoorAmbient
local originalAmbient = Lighting.Ambient
local originalGlobalShadows = Lighting.GlobalShadows
local originalFOV = workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView or 70

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

-- Function to get distance from local player
local function getDistanceFromPlayer(targetPosition)
    if not character or not rootPart then return 0 end
    return (targetPosition - rootPart.Position).Magnitude
end

-- Auto Jump Functions
local function startAutoJump()
    AutoJumpConnection = RunService.Heartbeat:Connect(function()
        if featureStates.AutoJump and character and humanoid and rootPart and humanoid.Health > 0 then
            humanoid.Jump = true
        end
    end)
end

local function stopAutoJump()
    if AutoJumpConnection then
        AutoJumpConnection:Disconnect()
        AutoJumpConnection = nil
    end
end

-- Auto Revive Functions
local function isPlayerDowned(pl)
    if not pl or not pl.Character then return false end
    local char = pl.Character
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid and humanoid.Health <= 0 then
        return true
    end
    if char.GetAttribute and char:GetAttribute("Downed") == true then
        return true
    end
    return false
end

local function startAutoRevive()
    if reviveLoopHandle then return end
    reviveLoopHandle = task.spawn(function()
        while featureStates.AutoRevive do
            local LocalPlayer = Players.LocalPlayer
            if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local myHRP = LocalPlayer.Character.HumanoidRootPart
                for _, pl in ipairs(Players:GetPlayers()) do
                    if pl ~= LocalPlayer then
                        local char = pl.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            if isPlayerDowned(pl) then
                                local hrp = char.HumanoidRootPart
                                local success, dist = pcall(function()
                                    return (myHRP.Position - hrp.Position).Magnitude
                                end)
                                if success and dist and dist <= reviveRange then
                                    pcall(function()
                                        interactEvent:FireServer("Revive", true, pl.Name)
                                    end)
                                end
                            end
                        end
                    end
                end
            end
            task.wait(loopDelay)
        end
        reviveLoopHandle = nil
    end)
end

local function stopAutoRevive()
    featureStates.AutoRevive = false
    if reviveLoopHandle then
        task.cancel(reviveLoopHandle)
        reviveLoopHandle = nil
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
    humanoid.StateChanged:Connect(function(oldState, newState)
        if newState == Enum.HumanoidStateType.Landed then
            jumpCount = 0
        end
    end)
    humanoid.Jumping:Connect(function(isJumping)
        if isJumping and featureStates.JumpBoost and jumpCount < MAX_JUMPS then
            jumpCount = jumpCount + 1
            humanoid.JumpHeight = featureStates.JumpPower
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
        task.wait(1)
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

-- FullBright Functions
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
                securityPart.Parent = workspace
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
            local playersInGame = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players")
            if playersInGame then
                for _, v in pairs(playersInGame:GetChildren()) do
                    if v:IsA("Model") and v:GetAttribute("Downed") then
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
            securityPart.Parent = workspace
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
    end
end

-- Downed Tracer and Box ESP Functions
local function cleanupTracers(tracerTable)
    for _, drawing in ipairs(tracerTable) do
        if drawing and drawing.Remove then 
            pcall(function() drawing:Remove() end)
        elseif drawing then 
            drawing.Visible = false 
        end
    end
    tracerTable = {}
end

local function startDownedTracer()
    downedTracerConnection = RunService.Heartbeat:Connect(function()
        cleanupTracers(downedTracerLines)
        downedTracerLines = {}
        local folder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players")
        if folder then
            for _, char in ipairs(folder:GetChildren()) do
                if char:IsA("Model") then
                    local team = char:GetAttribute("Team")
                    local downed = char:GetAttribute("Downed")
                    if team ~= "Nextbot" and char.Name ~= player.Name and downed == true then
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if hrp and workspace.CurrentCamera then
                            local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
                            if onScreen then
                                -- Tracer
                                if featureStates.DownedTracer then
                                    local tracer = Drawing.new("Line")
                                    tracer.Color = Color3.fromRGB(255, 165, 0)
                                    tracer.Thickness = 2
                                    tracer.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
                                    tracer.To = Vector2.new(pos.X, pos.Y)
                                    tracer.ZIndex = 1
                                    tracer.Visible = true
                                    table.insert(downedTracerLines, tracer)
                                end
                                -- Box
                                if featureStates.DownedBoxESP then
                                    local topY = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0)).Y
                                    local bottomY = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y
                                    local size = (bottomY - topY) / 2
                                    local box = Drawing.new("Square")
                                    box.Thickness = 2
                                    box.Filled = false
                                    box.Color = Color3.fromRGB(255, 255, 0) -- Yellow
                                    box.Size = Vector2.new(size * 2, size * 3)
                                    box.Position = Vector2.new(pos.X - size, pos.Y - size * 1.5)
                                    box.ZIndex = 1
                                    box.Visible = true
                                    table.insert(downedTracerLines, box)
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end

local function stopDownedTracer()
    if downedTracerConnection then
        downedTracerConnection:Disconnect()
        downedTracerConnection = nil
    end
    cleanupTracers(downedTracerLines)
    downedTracerLines = {}
end

-- Downed Name ESP Functions
local function cleanupNameESPLabels(labelTable)
    for _, label in ipairs(labelTable) do
        if label and label.Remove then 
            label:Remove()
        elseif label then 
            label.Visible = false 
        end
    end
    labelTable = {}
end

local function startDownedNameESP()
    downedNameESPConnection = RunService.Heartbeat:Connect(function()
        cleanupNameESPLabels(downedNameESPLabels)
        downedNameESPLabels = {}
        local folder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players")
        if folder then
            for _, char in ipairs(folder:GetChildren()) do
                if char:IsA("Model") then
                    local team = char:GetAttribute("Team")
                    local downed = char:GetAttribute("Downed")
                    if team ~= "Nextbot" and char.Name ~= player.Name and downed == true then
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if hrp and workspace.CurrentCamera then
                            local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
                            if onScreen then
                                local distance = getDistanceFromPlayer(hrp.Position)
                                local displayText = char.Name
                                if featureStates.DownedDistanceESP then
                                    displayText = displayText .. "\n" .. math.floor(distance) .. " studs"
                                end
                                local label = Drawing.new("Text")
                                label.Text = displayText
                                label.Size = 16
                                label.Center = true
                                label.Outline = true
                                label.OutlineColor = Color3.new(0, 0, 0)
                                label.Color = Color3.fromRGB(255, 165, 0)
                                label.Position = Vector2.new(pos.X, pos.Y - 50)
                                label.Visible = true
                                table.insert(downedNameESPLabels, label)
                            end
                        end
                    end
                end
            end
        end
    end)
end

local function stopDownedNameESP()
    if downedNameESPConnection then
        downedNameESPConnection:Disconnect()
        downedNameESPConnection = nil
    end
    cleanupNameESPLabels(downedNameESPLabels)
    downedNameESPLabels = {}
end

-- Function to handle character loading
local function onCharacterAdded(newCharacter, plr)
    if plr == player then
        character = newCharacter
        humanoid = character:WaitForChild("Humanoid")
        rootPart = character:WaitForChild("HumanoidRootPart")
        print("Character loaded for player: " .. plr.Name)
        setupJumpBoost()
        reapplyFeatures()
    end
end

-- Function to reapply all active features after respawn
local function reapplyFeatures()
    if featureStates.Fly then
        if flying then stopFlying() end
        startFlying()
    end
    if featureStates.AutoJump then
        if AutoJumpConnection then stopAutoJump() end
        startAutoJump()
    end
    if featureStates.SpeedHack then
        if ToggleTpwalk then stopTpwalk() end
        startTpwalk()
    end
    if featureStates.JumpBoost then
        startJumpBoost()
    end
    if featureStates.AntiAFK then
        if AntiAFKConnection then stopAntiAFK() end
        startAntiAFK()
    end
    if featureStates.AutoCarry then
        if AutoCarryConnection then stopAutoCarry() end
        startAutoCarry()
    end
    if featureStates.AutoRevive then
        stopAutoRevive()
        startAutoRevive()
    end
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
    if featureStates.AutoVote then
        if AutoVoteConnection then stopAutoVote() end
        startAutoVote()
    end
    if featureStates.AutoSelfRevive then
        if AutoSelfReviveConnection then stopAutoSelfRevive() end
        startAutoSelfRevive()
    end
    if featureStates.AutoWin then
        if AutoWinConnection then stopAutoWin() end
        startAutoWin()
    end
    if featureStates.AutoMoneyFarm then
        if AutoMoneyFarmConnection then stopAutoMoneyFarm() end
        startAutoMoneyFarm()
    end
    if featureStates.PlayerESP.boxes or featureStates.PlayerESP.tracers or featureStates.PlayerESP.names or featureStates.PlayerESP.distance then
        stopPlayerESP()
        startPlayerESP()
    end
    if featureStates.NextbotESP.boxes or featureStates.NextbotESP.tracers or featureStates.NextbotESP.names or featureStates.NextbotESP.distance then
        stopNextbotESP()
        startNextbotESP()
    end
    if featureStates.DownedBoxESP or featureStates.DownedTracer then
        if downedTracerConnection then stopDownedTracer() end
        startDownedTracer()
    end
    if featureStates.DownedNameESP then
        if downedNameESPConnection then stopDownedNameESP() end
        startDownedNameESP()
    end
    if featureStates.DesiredFOV and workspace.CurrentCamera then
        workspace.CurrentCamera.FieldOfView = featureStates.DesiredFOV
    end
end

-- Function to handle player joining
local function onPlayerAdded(plr)
    plr.CharacterAdded:Connect(function(newCharacter)
        onCharacterAdded(newCharacter, plr)
    end)
    if plr.Character then
        onCharacterAdded(plr.Character, plr)
    end
end

-- Connect player added event
Players.PlayerAdded:Connect(onPlayerAdded)

-- Handle existing players
for _, plr in ipairs(Players:GetPlayers()) do
    onPlayerAdded(plr)
end

-- Input handling for infinite jump (keyboard)
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.Space then
        if featureStates.InfiniteJump then
            if featureStates.JumpMethod == "Hold" then
                isJumpHeld = true
                bouncePlayer()
                task.spawn(function()
                    while isJumpHeld and featureStates.InfiniteJump and featureStates.JumpMethod == "Hold" do
                        bouncePlayer()
                        task.wait(0.1)
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

-- Handle mobile jump button tap and hold
local function setupMobileJumpButton()
    local success, result = pcall(function()
        local touchGui = player.PlayerGui:WaitForChild("TouchGui", 5)
        local touchControlFrame = touchGui:WaitForChild("TouchControlFrame", 5)
        local jumpButton = touchControlFrame:WaitForChild("JumpButton", 5)
        print("Mobile jump button found, setting up")
        
        jumpButton.Activated:Connect(function()
            print("Mobile jump button tapped")
            if featureStates.InfiniteJump then
                bouncePlayer()
            end
        end)

        jumpButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                print("Mobile jump button held")
                isJumpHeld = true
                if featureStates.InfiniteJump then
                    while isJumpHeld and featureStates.InfiniteJump and wait(0.1) do
                        bouncePlayer()
                    end
                end
            end
        end)

        jumpButton.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                print("Mobile jump button released")
                isJumpHeld = false
            end
        end)
    end)
    if not success then
        warn("Failed to set up mobile jump button: " .. tostring(result))
    end
end

-- Initialize character
if player.Character then
    print("Initial character found")
    onCharacterAdded(player.Character, player)
else
    print("Waiting for character to load")
    player.CharacterAdded:Connect(function(newCharacter)
        onCharacterAdded(newCharacter, player)
    end)
end

-- Connect fly update
RunService.RenderStepped:Connect(updateFly)

-- Connect FOV enforcement
RunService.Heartbeat:Connect(function()
    if workspace.CurrentCamera and featureStates.DesiredFOV then
        workspace.CurrentCamera.FieldOfView = featureStates.DesiredFOV
    end
end)

-- UI Setup with WindUI
local function setupGui()
    local FeatureSection = Window:Section({ Title = "loc:FEATURES", Opened = true })

    local Tabs = {
        Main = FeatureSection:Tab({ Title = "loc:MAIN_TAB", Icon = "layout-grid" }),
        Auto = FeatureSection:Tab({ Title = "loc:AUTO_TAB", Icon = "zap" }),
        Visuals = FeatureSection:Tab({ Title = "loc:VISUALS_TAB", Icon = "eye" }),
        ESP = FeatureSection:Tab({ Title = "loc:ESP_TAB", Icon = "scan" }),
        Settings = FeatureSection:Tab({ Title = "loc:SETTINGS_TAB", Icon = "settings" })
    }

    -- Main Tab
    Tabs.Main:Section({ Title = "Movement Features", TextSize = 20 })
    Tabs.Main:Section({ Title = "Control your character's movement", TextSize = 16, TextTransparency = 0.25 })
    Tabs.Main:Divider()

    local InfiniteJumpToggle = Tabs.Main:Toggle({
        Title = "loc:INFINITE_JUMP",
        Value = false,
        Callback = function(state)
            featureStates.InfiniteJump = state
        end
    })

    local AutoJumpToggle = Tabs.Main:Toggle({
        Title = "loc:AUTO_JUMP",
        Value = false,
        Callback = function(state)
            featureStates.AutoJump = state
            if state then
                startAutoJump()
            else
                stopAutoJump()
            end
        end
    })

    local JumpMethodDropdown = Tabs.Main:Dropdown({
        Title = "loc:JUMP_METHOD",
        Values = {"Hold", "Spam"},
        Value = "Hold",
        Callback = function(value)
            featureStates.JumpMethod = value
            print("Jump method changed to: " .. value)
        end
    })

    local FlyToggle = Tabs.Main:Toggle({
        Title = "loc:FLY",
        Value = false,
        Callback = function(state)
            featureStates.Fly = state
            if state then
                startFlying()
            else
                stopFlying()
            end
        end
    })

    local FlySpeedSlider = Tabs.Main:Slider({
        Title = "loc:FLY_SPEED",
        Desc = "Adjust fly movement speed",
        Value = { Min = 1, Max = 900, Default = 50, Step = 1 },
        Callback = function(value)
            featureStates.FlySpeed = value
        end
    })

    local SpeedHackToggle = Tabs.Main:Toggle({
        Title = "loc:SPEED_HACK",
        Value = false,
        Callback = function(state)
            featureStates.SpeedHack = state
            if state then
                startTpwalk()
            else
                stopTpwalk()
            end
        end
    })

    local SpeedHackSlider = Tabs.Main:Slider({
        Title = "loc:SPEED_HACK_VALUE",
        Desc = "Adjust teleport distance per frame",
        Value = { Min = 1, Max = 500, Default = 1, Step = 1 },
        Callback = function(value)
            featureStates.TpwalkValue = value
        end
    })

    local JumpBoostToggle = Tabs.Main:Toggle({
        Title = "loc:JUMP_HEIGHT",
        Value = false,
        Callback = function(state)
            featureStates.JumpBoost = state
            if state then
                startJumpBoost()
            else
                stopJumpBoost()
            end
        end
    })

    local JumpBoostSlider = Tabs.Main:Slider({
        Title = "loc:JUMP_POWER",
        Desc = "Adjust jump height and power",
        Value = { Min = 16, Max = 500, Default = 50, Step = 1 },
        Callback = function(value)
            featureStates.JumpPower = value
            if featureStates.JumpBoost then
                if humanoid then
                    humanoid.JumpPower = featureStates.JumpPower
                end
            end
        end
    })

    local AntiAFKToggle = Tabs.Main:Toggle({
        Title = "loc:ANTI_AFK",
        Value = false,
        Callback = function(state)
            featureStates.AntiAFK = state
            if state then
                startAntiAFK()
            else
                stopAntiAFK()
            end
        end
    })

    -- Visuals Tab
    Tabs.Visuals:Section({ Title = "Visual Enhancements", TextSize = 20 })
    Tabs.Visuals:Section({ Title = "Customize the game visuals", TextSize = 16, TextTransparency = 0.25 })
    Tabs.Visuals:Divider()

    local FullBrightToggle = Tabs.Visuals:Toggle({
        Title = "loc:FULL_BRIGHT",
        Value = false,
        Callback = function(state)
            featureStates.FullBright = state
            if state then
                startFullBright()
            else
                stopFullBright()
            end
        end
    })

    local NoFogToggle = Tabs.Visuals:Toggle({
        Title = "loc:NO_FOG",
        Value = false,
        Callback = function(state)
            featureStates.NoFog = state
            if state then
                startNoFog()
            else
                stopNoFog()
            end
        end
    })

    local FOVSlider = Tabs.Visuals:Slider({
        Title = "loc:FOV",
        Desc = "Adjust Field of View",
        Value = { Min = 10, Max = 120, Default = 70, Step = 1 },
        Callback = function(value)
            featureStates.DesiredFOV = value
            local camera = workspace.CurrentCamera or game:GetService("Workspace"):WaitForChild("CurrentCamera", 5)
            if camera then
                camera.FieldOfView = value
            end
        end
    })

    -- ESP Tab
    Tabs.ESP:Section({ Title = "ESP Features", TextSize = 20 })
    Tabs.ESP:Section({ Title = "Enable visual indicators for players and objects", TextSize = 16, TextTransparency = 0.25 })
    Tabs.ESP:Divider()

    local PlayerBoxESPToggle = Tabs.ESP:Toggle({
        Title = "loc:PLAYER_BOX_ESP",
        Value = false,
        Callback = function(state)
            featureStates.PlayerESP.boxes = state
            if state or featureStates.PlayerESP.tracers or featureStates.PlayerESP.names or featureStates.PlayerESP.distance then
                startPlayerESP()
            else
                stopPlayerESP()
            end
        end
    })

    local PlayerTracerToggle = Tabs.ESP:Toggle({
        Title = "loc:PLAYER_TRACER",
        Value = false,
        Callback = function(state)
            featureStates.PlayerESP.tracers = state
            if state or featureStates.PlayerESP.boxes or featureStates.PlayerESP.names or featureStates.PlayerESP.distance then
                startPlayerESP()
            else
                stopPlayerESP()
            end
        end
    })

    local PlayerNameESPToggle = Tabs.ESP:Toggle({
        Title = "loc:PLAYER_NAME_ESP",
        Value = false,
        Callback = function(state)
            featureStates.PlayerESP.names = state
            if state or featureStates.PlayerESP.boxes or featureStates.PlayerESP.tracers or featureStates.PlayerESP.distance then
                startPlayerESP()
            else
                stopPlayerESP()
            end
        end
    })

    local PlayerDistanceESPToggle = Tabs.ESP:Toggle({
        Title = "loc:PLAYER_DISTANCE_ESP",
        Value = false,
        Callback = function(state)
            featureStates.PlayerESP.distance = state
            if state or featureStates.PlayerESP.boxes or featureStates.PlayerESP.tracers or featureStates.PlayerESP.names then
                startPlayerESP()
            else
                stopPlayerESP()
            end
        end
    })

    local PlayerRainbowBoxesToggle = Tabs.ESP:Toggle({
        Title = "loc:PLAYER_RAINBOW_BOXES",
        Value = false,
        Callback = function(state)
            featureStates.PlayerESP.rainbowBoxes = state
            if featureStates.PlayerESP.boxes then
                stopPlayerESP()
                startPlayerESP()
            end
        end
    })

    local PlayerRainbowTracersToggle = Tabs.ESP:Toggle({
        Title = "loc:PLAYER_RAINBOW_TRACERS",
        Value = false,
        Callback = function(state)
            featureStates.PlayerESP.rainbowTracers = state
            if featureStates.PlayerESP.tracers then
                stopPlayerESP()
                startPlayerESP()
            end
        end
    })

    local NextbotBoxESPToggle = Tabs.ESP:Toggle({
        Title = "loc:NEXTBOT_BOX_ESP",
        Value = false,
        Callback = function(state)
            featureStates.NextbotESP.boxes = state
            if state or featureStates.NextbotESP.tracers or featureStates.NextbotESP.names or featureStates.NextbotESP.distance then
                startNextbotESP()
            else
                stopNextbotESP()
            end
        end
    })

    local NextbotTracerToggle = Tabs.ESP:Toggle({
        Title = "loc:NEXTBOT_TRACER",
        Value = false,
        Callback = function(state)
            featureStates.NextbotESP.tracers = state
            if state or featureStates.NextbotESP.boxes or featureStates.NextbotESP.names or featureStates.NextbotESP.distance then
                startNextbotESP()
            else
                stopNextbotESP()
            end
        end
    })

    local NextbotNameESPToggle = Tabs.ESP:Toggle({
        Title = "loc:NEXTBOT_NAME_ESP",
        Value = false,
        Callback = function(state)
            featureStates.NextbotESP.names = state
            if state or featureStates.NextbotESP.boxes or featureStates.NextbotESP.tracers or featureStates.NextbotESP.distance then
                startNextbotESP()
            else
                stopNextbotESP()
            end
        end
    })

    local NextbotDistanceESPToggle = Tabs.ESP:Toggle({
        Title = "loc:NEXTBOT_DISTANCE_ESP",
        Value = false,
        Callback = function(state)
            featureStates.NextbotESP.distance = state
            if state or featureStates.NextbotESP.boxes or featureStates.NextbotESP.tracers or featureStates.NextbotESP.names then
                startNextbotESP()
            else
                stopNextbotESP()
            end
        end
    })

    local NextbotRainbowBoxesToggle = Tabs.ESP:Toggle({
        Title = "loc:NEXTBOT_RAINBOW_BOXES",
        Value = false,
        Callback = function(state)
            featureStates.NextbotESP.rainbowBoxes = state
            if featureStates.NextbotESP.boxes then
                stopNextbotESP()
                startNextbotESP()
            end
        end
    })

    local NextbotRainbowTracersToggle = Tabs.ESP:Toggle({
        Title = "loc:NEXTBOT_RAINBOW_TRACERS",
        Value = false,
        Callback = function(state)
            featureStates.NextbotESP.rainbowTracers = state
            if featureStates.NextbotESP.tracers then
                stopNextbotESP()
                startNextbotESP()
            end
        end
    })

    local DownedBoxESPToggle = Tabs.ESP:Toggle({
        Title = "loc:DOWNED_BOX_ESP",
        Value = false,
        Callback = function(state)
            featureStates.DownedBoxESP = state
            if state or featureStates.DownedTracer then
                if downedTracerConnection then stopDownedTracer() end
                startDownedTracer()
            else
                stopDownedTracer()
            end
        end
    })

    local DownedTracerToggle = Tabs.ESP:Toggle({
        Title = "loc:DOWNED_TRACER",
        Value = false,
        Callback = function(state)
            featureStates.DownedTracer = state
            if state or featureStates.DownedBoxESP then
                if downedTracerConnection then stopDownedTracer() end
                startDownedTracer()
            else
                stopDownedTracer()
            end
        end
    })

    local DownedNameESPToggle = Tabs.ESP:Toggle({
        Title = "loc:DOWNED_NAME_ESP",
        Value = false,
        Callback = function(state)
            featureStates.DownedNameESP = state
            if state then
                startDownedNameESP()
            else
                stopDownedNameESP()
            end
        end
    })

    local DownedDistanceESPToggle = Tabs.ESP:Toggle({
        Title = "loc:DOWNED_DISTANCE_ESP",
        Value = false,
        Callback = function(state)
            featureStates.DownedDistanceESP = state
            if featureStates.DownedNameESP then
                stopDownedNameESP()
                startDownedNameESP()
            end
        end
    })

    -- Auto Tab
    Tabs.Auto:Section({ Title = "Automation Features", TextSize = 20 })
    Tabs.Auto:Section({ Title = "Automate game tasks", TextSize = 16, TextTransparency = 0.25 })
    Tabs.Auto:Divider()

    local AutoCarryToggle = Tabs.Auto:Toggle({
        Title = "loc:AUTO_CARRY",
        Value = false,
        Callback = function(state)
            featureStates.AutoCarry = state
            if state then
                startAutoCarry()
            else
                stopAutoCarry()
            end
        end
    })

    local AutoReviveToggle = Tabs.Auto:Toggle({
        Title = "loc:AUTO_REVIVE",
        Value = false,
        Callback = function(state)
            featureStates.AutoRevive = state
            if state then
                startAutoRevive()
            else
                stopAutoRevive()
            end
        end
    })

    local AutoVoteDropdown = Tabs.Auto:Dropdown({
        Title = "loc:AUTO_VOTE_MAP",
        Values = {"Map 1", "Map 2", "Map 3", "Map 4"},
        Value = "Map 1",
        Callback = function(value)
            if value == "Map 1" then
                featureStates.SelectedMap = 1
            elseif value == "Map 2" then
                featureStates.SelectedMap = 2
            elseif value == "Map 3" then
                featureStates.SelectedMap = 3
            elseif value == "Map 4" then
                featureStates.SelectedMap = 4
            end
        end
    })

    local AutoVoteToggle = Tabs.Auto:Toggle({
        Title = "loc:AUTO_VOTE",
        Value = false,
        Callback = function(state)
            featureStates.AutoVote = state
            if state then
                startAutoVote()
            else
                stopAutoVote()
            end
        end
    })

    local AutoSelfReviveToggle = Tabs.Auto:Toggle({
        Title = "loc:AUTO_SELF_REVIVE",
        Value = false,
        Callback = function(state)
            featureStates.AutoSelfRevive = state
            if state then
                startAutoSelfRevive()
            else
                stopAutoSelfRevive()
            end
        end
    })

    Tabs.Auto:Button({
        Title = "loc:MANUAL_REVIVE",
        Desc = "Manually revive yourself",
        Icon = "heart",
        Callback = function()
            manualRevive()
        end
    })

    local AutoWinToggle = Tabs.Auto:Toggle({
        Title = "loc:AUTO_WIN",
        Value = false,
        Callback = function(state)
            featureStates.AutoWin = state
            if state then
                startAutoWin()
            else
                stopAutoWin()
            end
        end
    })

    local AutoMoneyFarmToggle = Tabs.Auto:Toggle({
        Title = "loc:AUTO_MONEY_FARM",
        Value = false,
        Callback = function(state)
            featureStates.AutoMoneyFarm = state
            if state then
                startAutoMoneyFarm()
                featureStates.AutoRevive = true
                AutoReviveToggle:Set(true)
                startAutoRevive()
            else
                stopAutoMoneyFarm()
            end
        end
    })

    -- Settings Tab
    Tabs.Settings:Section({ Title = "UI Customization", TextSize = 20 })
    Tabs.Settings:Section({ Title = "Personalize the interface", TextSize = 16, TextTransparency = 0.25 })
    Tabs.Settings:Divider()

    local themes = {}
    for themeName, _ in pairs(WindUI:GetThemes()) do
        table.insert(themes, themeName)
    end
    table.sort(themes)

    local canChangeTheme = true
    local canChangeDropdown = true

    local ThemeDropdown = Tabs.Settings:Dropdown({
        Title = "loc:THEME_SELECT",
        Values = themes,
        SearchBarEnabled = true,
        MenuWidth = 280,
        Value = "Dark",
        Callback = function(theme)
            if canChangeDropdown then
                canChangeTheme = false
                WindUI:SetTheme(theme)
                canChangeTheme = true
            end
        end
    })

    local TransparencySlider = Tabs.Settings:Slider({
        Title = "loc:TRANSPARENCY",
        Value = { Min = 0, Max = 1, Default = 0.2, Step = 0.1 },
        Callback = function(value)
            WindUI.TransparencyValue = tonumber(value)
            Window:ToggleTransparency(tonumber(value) > 0)
        end
    })

    local ThemeToggle = Tabs.Settings:Toggle({
        Title = "Enable Dark Mode",
        Desc = "Use dark color scheme",
        Value = true,
        Callback = function(state)
            if canChangeTheme then
                local newTheme = state and "Dark" or "Light"
                WindUI:SetTheme(newTheme)
                if canChangeDropdown then
                    ThemeDropdown:Select(newTheme)
                end
            end
        end
    })

    WindUI:OnThemeChange(function(theme)
        canChangeTheme = false
        ThemeToggle:Set(theme == "Dark")
        canChangeTheme = true
    end)

    -- Configuration Manager
    local configName = "default"
    local configFile = nil
    local MyPlayerData = {
        name = player.Name,
        level = 1,
        inventory = {}
    }

    Tabs.Settings:Section({ Title = "Configuration Manager", TextSize = 20 })
    Tabs.Settings:Section({ Title = "Save and load your settings", TextSize = 16, TextTransparency = 0.25 })
    Tabs.Settings:Divider()

    Tabs.Settings:Input({
        Title = "Config Name",
        Value = configName,
        Callback = function(value)
            configName = value or "default"
        end
    })

    local ConfigManager = Window.ConfigManager
    if ConfigManager then
        ConfigManager:Init(Window)
        
        Tabs.Settings:Button({
            Title = "loc:SAVE_CONFIG",
            Icon = "save",
            Variant = "Primary",
            Callback = function()
                configFile = ConfigManager:CreateConfig(configName)
                configFile:Register("InfiniteJumpToggle", InfiniteJumpToggle)
                configFile:Register("AutoJumpToggle", AutoJumpToggle)
                configFile:Register("JumpMethodDropdown", JumpMethodDropdown)
                configFile:Register("FlyToggle", FlyToggle)
                configFile:Register("FlySpeedSlider", FlySpeedSlider)
                configFile:Register("SpeedHackToggle", SpeedHackToggle)
                configFile:Register("SpeedHackSlider", SpeedHackSlider)
                configFile:Register("JumpBoostToggle", JumpBoostToggle)
                configFile:Register("JumpBoostSlider", JumpBoostSlider)
                configFile:Register("AntiAFKToggle", AntiAFKToggle)
                configFile:Register("FullBrightToggle", FullBrightToggle)
                configFile:Register("NoFogToggle", NoFogToggle)
                configFile:Register("FOVSlider", FOVSlider)
                configFile:Register("PlayerBoxESPToggle", PlayerBoxESPToggle)
                configFile:Register("PlayerTracerToggle", PlayerTracerToggle)
                configFile:Register("PlayerNameESPToggle", PlayerNameESPToggle)
                configFile:Register("PlayerDistanceESPToggle", PlayerDistanceESPToggle)
                configFile:Register("PlayerRainbowBoxesToggle", PlayerRainbowBoxesToggle)
                configFile:Register("PlayerRainbowTracersToggle", PlayerRainbowTracersToggle)
                configFile:Register("NextbotBoxESPToggle", NextbotBoxESPToggle)
                configFile:Register("NextbotTracerToggle", NextbotTracerToggle)
                configFile:Register("NextbotNameESPToggle", NextbotNameESPToggle)
                configFile:Register("NextbotDistanceESPToggle", NextbotDistanceESPToggle)
                configFile:Register("NextbotRainbowBoxesToggle", NextbotRainbowBoxesToggle)
                configFile:Register("NextbotRainbowTracersToggle", NextbotRainbowTracersToggle)
                configFile:Register("DownedBoxESPToggle", DownedBoxESPToggle)
                configFile:Register("DownedTracerToggle", DownedTracerToggle)
                configFile:Register("DownedNameESPToggle", DownedNameESPToggle)
                configFile:Register("DownedDistanceESPToggle", DownedDistanceESPToggle)
                configFile:Register("AutoCarryToggle", AutoCarryToggle)
                configFile:Register("AutoReviveToggle", AutoReviveToggle)
                configFile:Register("AutoVoteDropdown", AutoVoteDropdown)
                configFile:Register("AutoVoteToggle", AutoVoteToggle)
                configFile:Register("AutoSelfReviveToggle", AutoSelfReviveToggle)
                configFile:Register("AutoWinToggle", AutoWinToggle)
                configFile:Register("AutoMoneyFarmToggle", AutoMoneyFarmToggle)
                configFile:Register("ThemeDropdown", ThemeDropdown)
                configFile:Register("TransparencySlider", TransparencySlider)
                configFile:Register("ThemeToggle", ThemeToggle)
                configFile:Set("playerData", MyPlayerData)
                configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))
                configFile:Save()
            end
        })

        Tabs.Settings:Button({
            Title = "loc:LOAD_CONFIG",
            Icon = "folder",
            Callback = function()
                configFile = ConfigManager:CreateConfig(configName)
                local loadedData = configFile:Load()
                if loadedData then
                    if loadedData.playerData then
                        MyPlayerData = loadedData.playerData
                    end
                    local lastSave = loadedData.lastSave or "Unknown"
                    Tabs.Settings:Paragraph({
                        Title = "Player Data",
                        Desc = string.format("Name: %s\nLevel: %d\nInventory: %s", 
                            MyPlayerData.name, 
                            MyPlayerData.level, 
                            table.concat(MyPlayerData.inventory, ", "))
                    })
                end
            end
        })
    else
        Tabs.Settings:Paragraph({
            Title = "Config Manager Not Available",
            Desc = "This feature requires ConfigManager",
            Image = "alert-triangle",
            ImageSize = 20,
            Color = "White"
        })
    end

    -- Keybind Section
    Tabs.Settings:Section({ Title = "Keybind Settings", TextSize = 20 })
    Tabs.Settings:Section({ Title = "Change toggle key for GUI", TextSize = 16, TextTransparency = 0.25 })
    Tabs.Settings:Divider()

    Tabs.Settings:Input({
        Title = "Toggle Key",
        Desc = "Enter key to toggle GUI (e.g. G)",
        Value = "G",
        Callback = function(value)
            local key = value:upper()
            if Enum.KeyCode[key] then
                toggleKey = Enum.KeyCode[key]
            end
        end
    })

    -- Select default tab
    Window:SelectTab(1)
end

-- Initialize UI and mobile controls
setupGui()
setupMobileJumpButton()

-- Window event handlers
Window:OnClose(function()
    print("Window closed")
    if ConfigManager and configFile then
        configFile:Set("playerData", MyPlayerData)
        configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))
        configFile:Save()
        print("Config auto-saved on close")
    end
end)

Window:OnDestroy(function()
    print("Window destroyed")
end)

Window:OnOpen(function()
    print("Window opened")
end)

Window:UnlockAll()

-- GUI Toggle Logic
local toggleKey = Enum.KeyCode.G
local isVisible = true

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.KeyCode == toggleKey then
        isVisible = not isVisible
        if isVisible then
            Window:Open()
        else
            Window:Close()
        end
    end
end)
