-- Load WindUI
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- Localization setup
local Localization = WindUI:Localization({
    Enabled = true,
    Prefix = "loc:",
    DefaultLanguage = "en",
    Translations = {
        ["en"] = {
            ["SCRIPT_TITLE"] = "Dara Hub",
            ["WELCOME"] = "Made by: Pnsdg And Yomka",
            ["FEATURES"] = "Features",
            ["Player_TAB"] = "Player",
            ["AUTO_TAB"] = "Auto",
            ["VISUALS_TAB"] = "Visuals",
            ["ESP_TAB"] = "ESP",
            ["SETTINGS_TAB"] = "Settings",
            ["INFINITE_JUMP"] = "Infinite Jump",
            ["JUMP_METHOD"] = "Infinite Jump Method",
            ["FLY"] = "Fly",
            ["FLY_SPEED"] = "Fly Speed",
            ["TPWALK"] = "TP WALK",
            ["TPWALK_VALUE"] = "TPWALK VALUE",
            ["JUMP_HEIGHT"] = "Jump Height",
            ["JUMP_POWER"] = "Jump Height",
            ["ANTI_AFK"] = "Anti AFK",
            ["FULL_BRIGHT"] = "FullBright",
            ["NO_FOG"] = "Remove Fog",
            ["FOV"] = "Field of View",
            ["PLAYER_NAME_ESP"] = "Player Name ESP",
            ["PLAYER_BOX_ESP"] = "Player Box ESP",
            ["PLAYER_TRACER"] = "Player Tracer",
            ["PLAYER_DISTANCE_ESP"] = "Player Distance ESP",
            ["PLAYER_RAINBOW_BOXES"] = "Player Rainbow Boxes",
            ["PLAYER_RAINBOW_TRACERS"] = "Player Rainbow Tracers",
            ["NEXTBOT_ESP"] = "Nextbot ESP",
            ["NEXTBOT_NAME_ESP"] = "Nextbot Name ESP",
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
local isWindowOpen = false
local function updateWindowOpenState()
    if Window and type(Window.IsOpen) == "function" then
        local ok, val = pcall(function() return Window:IsOpen() end)
        if ok and type(val) == "boolean" then
            isWindowOpen = val
            return
        end
    end
    if Window and Window.Opened ~= nil then
        isWindowOpen = Window.Opened
        return
    end
    isWindowOpen = isWindowOpen or false
end

pcall(updateWindowOpenState)

local currentKey = Enum.KeyCode.RightControl 
local keyConnection = nil
local isListeningForInput = false
local keyInputConnection = nil

local keyBindButton = nil

local keybindFile = "keybind_config.txt"

local function getCleanKeyName(keyCode)
    local keyString = tostring(keyCode)
    return keyString:gsub("Enum%.KeyCode%.", "")
end

local function saveKeybind()
    local keyString = tostring(currentKey)
    writefile(keybindFile, keyString)
end

local function loadKeybind()
    if isfile(keybindFile) then
        local savedKey = readfile(keybindFile)
        for _, key in pairs(Enum.KeyCode:GetEnumItems()) do
            if tostring(key) == savedKey then
                currentKey = key
                return true
            end
        end
    end
    return false
end

loadKeybind()

local function updateKeybindButtonDesc()
    if not keyBindButton then return false end
    local desc = "Current Key: " .. getCleanKeyName(currentKey)
    local success = false

    local methods = {
        function()
            if type(keyBindButton.SetDesc) == "function" then
                keyBindButton:SetDesc(desc)
            else
                error("no SetDesc")
            end
        end,
        function()
            if type(keyBindButton.Set) == "function" then
                keyBindButton:Set("Desc", desc)
            else
                error("no Set")
            end
        end,
        function()
            if keyBindButton.Desc ~= nil then
                keyBindButton.Desc = desc
            else
                error("no Desc property")
            end
        end,
        function()
            if type(keyBindButton.SetDescription) == "function" then
                keyBindButton:SetDescription(desc)
            else
                error("no SetDescription")
            end
        end,
        function()
            if type(keyBindButton.SetValue) == "function" then
                keyBindButton:SetValue(desc)
            else
                error("no SetValue")
            end
        end
    }

    for _, fn in ipairs(methods) do
        local ok = pcall(fn)
        if ok then
            success = true
            break
        end
    end

    if not success then
        pcall(function()
            WindUI:Notify({
                Title = "Keybind",
                Content = desc,
                Duration = 2
            })
        end)
    end

    return success
end

local function bindKey(keyBindButtonParam)
    local targetButton = keyBindButtonParam or keyBindButton

    if isListeningForInput then 
        isListeningForInput = false
        if keyConnection then
            keyConnection:Disconnect()
            keyConnection = nil
        end
        WindUI:Notify({
            Title = "Keybind",
            Content = "Key binding cancelled",
            Duration = 2
        })
        return
    end
    
    isListeningForInput = true
    WindUI:Notify({
        Title = "Keybind",
        Content = "Press any key to bind...",
        Duration = 3
    })
    
    keyConnection = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.UserInputType == Enum.UserInputType.Keyboard then
            currentKey = input.KeyCode
            isListeningForInput = false
            if keyConnection then
                keyConnection:Disconnect()
                keyConnection = nil
            end
            
            saveKeybind()
            
            WindUI:Notify({
                Title = "Keybind",
                Content = "Key bound to: " .. getCleanKeyName(currentKey),
                Duration = 3
            })
            pcall(function()
                updateKeybindButtonDesc()
            end)
        end
    end)
end

local function handleKeyPress(input, gameProcessed)
    if gameProcessed then return end
    
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentKey then
        local success, isVisible = pcall(function()
            if Window and type(Window.IsOpen) == "function" then
                return Window:IsOpen()
            elseif Window and Window.Opened ~= nil then
                return Window.Opened
            else
                return isWindowOpen
            end
        end)
        if not success then
            isVisible = isWindowOpen
        end

        if isVisible then
            if Window and type(Window.Close) == "function" then
                pcall(function() Window:Close() end)
            else
                isWindowOpen = false
                if Window and type(Window.OnClose) == "function" then
                    pcall(function() Window:OnClose() end)
                end
            end
        else
            if Window and type(Window.Open) == "function" then
                pcall(function() Window:Open() end)
            else
                isWindowOpen = true
                if Window and type(Window.OnOpen) == "function" then
                    pcall(function() Window:OnOpen() end)
                end
            end
        end
    end
end

keyInputConnection = game:GetService("UserInputService").InputBegan:Connect(handleKeyPress)
Window:SetIconSize(48)
Window:Tag({
    Title = "v1.0.6",
    Color = Color3.fromHex("#30ff6a")
})


--[[

-- Disabled fucking beta skid
Window:Tag({
Title = "Beta",
Color = Color3.fromHex("#315dff")

]]

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
local originalGameGravity = workspace.Gravity
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local placeId = game.PlaceId
local jobId = game.JobId
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()
local FREECAM_SPEED = 50
local SENSITIVITY = 0.002
local ZOOM_SPEED = 10
local MIN_ZOOM = 2
local MAX_ZOOM = 100
local FOV_SPEED = 5
local MIN_FOV = 10
local MAX_FOV = 120
local DEFAULT_FOV = 70
local isFreecamEnabled = false
local isFreecamMovementEnabled = true
local cameraPosition = Vector3.new(0, 10, 0)
local cameraRotation = Vector2.new(0, 0)
local JUMP_FORCE = 50
local isMobile = not UserInputService.KeyboardEnabled
local touchConnection
local lastTouchPosition = nil
local lastYPosition = nil
local isJumping = false
local isAltHeld = false
local heartbeatConnection
local inputChangedConnection
local characterAddedConnection
local dragging = false
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FreecamGui"
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false
local controlFrame = Instance.new("Frame")
controlFrame.Name = "ControlFrame"
controlFrame.Size = UDim2.new(0, 140, 0, 150)
controlFrame.Position = UDim2.new(0, 10, 0, 10)
controlFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
controlFrame.BackgroundTransparency = 1
controlFrame.BorderSizePixel = 2
controlFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
controlFrame.Visible = false 
controlFrame.Parent = screenGui
local freecamButton = Instance.new("TextButton")
freecamButton.Name = "FreecamButton"
freecamButton.Text = "Enable Freecam"
freecamButton.Size = UDim2.new(0, 120, 0, 30)
freecamButton.Position = UDim2.new(0, 10, 0, 0)
freecamButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
freecamButton.TextColor3 = Color3.fromRGB(255, 255, 255)
freecamButton.Font = Enum.Font.SourceSans
freecamButton.TextSize = 14
freecamButton.Parent = controlFrame

local movementButton = Instance.new("TextButton")
movementButton.Name = "MovementButton"
movementButton.Text = "Control Player "
movementButton.Size = UDim2.new(0, 120, 0, 30)
movementButton.Position = UDim2.new(0, 10, 0, 35)
movementButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
movementButton.TextColor3 = Color3.fromRGB(255, 255, 255)
movementButton.Font = Enum.Font.SourceSans
movementButton.TextSize = 14
movementButton.Visible = false
movementButton.Parent = controlFrame

local sliderFrame = Instance.new("Frame")
sliderFrame.Name = "FOVSliderFrame"
sliderFrame.Size = UDim2.new(0, 120, 0, 60)
sliderFrame.Position = UDim2.new(0, 10, 0, 70)
sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
sliderFrame.BorderSizePixel = 0
sliderFrame.Visible = false
sliderFrame.Parent = controlFrame
local fovLabel = Instance.new("TextLabel")
fovLabel.Name = "FOVLabel"
fovLabel.Size = UDim2.new(1, 0, 0, 15)
fovLabel.Position = UDim2.new(0, 0, 0, 5)
fovLabel.BackgroundTransparency = 1
fovLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fovLabel.Font = Enum.Font.SourceSans
fovLabel.TextSize = 12
fovLabel.Text = "FOV: " .. DEFAULT_FOV
fovLabel.Parent = sliderFrame

local sliderBar = Instance.new("Frame")
sliderBar.Name = "SliderBar"
sliderBar.Size = UDim2.new(0, 100, 0, 8)
sliderBar.Position = UDim2.new(0, 10, 0, 35)
sliderBar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
sliderBar.Parent = sliderFrame

local sliderHandle = Instance.new("TextButton")
sliderHandle.Name = "SliderHandle"
sliderHandle.Size = UDim2.new(0, 16, 0, 16)
sliderHandle.Position = UDim2.new(0, (DEFAULT_FOV - MIN_FOV) / (MAX_FOV - MIN_FOV) * 100 - 8, 0, -4)
sliderHandle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
sliderHandle.Text = ""
sliderHandle.Parent = sliderBar
local function updateFOV()
    local sliderPos = sliderHandle.Position.X.Offset
    local normalizedValue = math.clamp((sliderPos + 8) / 100, 0, 1)
    local newFOV = MIN_FOV + normalizedValue * (MAX_FOV - MIN_FOV)
    camera.FieldOfView = math.clamp(newFOV, MIN_FOV, MAX_FOV)
    fovLabel.Text = "FOV: " .. math.floor(camera.FieldOfView + 0.5)
end

sliderHandle.MouseButton1Down:Connect(function()
    dragging = true
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local mousePos = input.Position.X
        local barPos = sliderBar.AbsolutePosition.X
        local barWidth = sliderBar.AbsoluteSize.X
        local newX = math.clamp(mousePos - barPos - 8, -8, barWidth - 8)
        sliderHandle.Position = UDim2.new(0, newX, 0, -4)
        updateFOV()
    end
end)
local playerCage = nil
local CAGE_SIZE = Vector3.new(6, 8, 6)
local CAGE_OFFSET = Vector3.new(0, -3, 0)

local function createPlayerCage(position)
    if playerCage then
        playerCage:Destroy()
        playerCage = nil
    end
    
    playerCage = Instance.new("Folder")
    playerCage.Name = "PlayerCage"
    playerCage.Parent = workspace
    
    local cageCFrame = CFrame.new(position + CAGE_OFFSET)
    
    local function createCagePart(size, cframeOffset, name)
        local part = Instance.new("Part")
        part.Name = name
        part.Size = size
        part.CFrame = cageCFrame * cframeOffset
        part.Anchored = true
        part.CanCollide = true
        part.Transparency = 1
        part.BrickColor = BrickColor.new("Institutional white")
        part.Material = Enum.Material.ForceField
        part.Parent = playerCage
        return part
    end
    
    -- Floor (prevents falling)
    local floorPart = createCagePart(Vector3.new(CAGE_SIZE.X + 0.2, 0.2, CAGE_SIZE.Z + 0.2), CFrame.new(0, -CAGE_SIZE.Y / 2, 0), "Floor")
    
    -- Ceiling (prevents upward escape/jump)
    createCagePart(Vector3.new(CAGE_SIZE.X + 0.2, 0.2, CAGE_SIZE.Z + 0.2), CFrame.new(0, CAGE_SIZE.Y / 2, 0), "Ceiling")
    
    -- Walls (prevents horizontal movement)
    local wallThickness = 0.2
    -- Front wall
    createCagePart(Vector3.new(CAGE_SIZE.X + 0.2, CAGE_SIZE.Y, wallThickness), CFrame.new(0, 0, -CAGE_SIZE.Z / 2), "FrontWall")
    -- Back wall
    createCagePart(Vector3.new(CAGE_SIZE.X + 0.2, CAGE_SIZE.Y, wallThickness), CFrame.new(0, 0, CAGE_SIZE.Z / 2), "BackWall")
    -- Left wall
    createCagePart(Vector3.new(wallThickness, CAGE_SIZE.Y, CAGE_SIZE.Z + 0.2), CFrame.new(-CAGE_SIZE.X / 2, 0, 0), "LeftWall")
    -- Right wall
    createCagePart(Vector3.new(wallThickness, CAGE_SIZE.Y, CAGE_SIZE.Z + 0.2), CFrame.new(CAGE_SIZE.X / 2, 0, 0), "RightWall")
    
    playerCage.PrimaryPart = floorPart
end

local function destroyPlayerCage()
    if playerCage then
        playerCage:Destroy()
        playerCage = nil
    end
end

local function freezePlayer(character)
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    
    lastYPosition = rootPart.Position.Y
    
    local diedConnection
    diedConnection = humanoid.Died:Connect(function()
        destroyPlayerCage() 
        deactivateFreecam()
        diedConnection:Disconnect()
    end)
    
    if heartbeatConnection then heartbeatConnection:Disconnect() end
    heartbeatConnection = RunService.Heartbeat:Connect(function(dt)
        if not isFreecamEnabled or not character.Parent then
            destroyPlayerCage()
            if rootPart then rootPart.Anchored = false end
            return
        end
        
        local shouldCage = isFreecamMovementEnabled and not isAltHeld
        if shouldCage then
    if not playerCage then
        createPlayerCage(rootPart.Position)
    else
        local newPos = rootPart.Position + CAGE_OFFSET
        playerCage:SetPrimaryPartCFrame(CFrame.new(newPos))
    end
else
    destroyPlayerCage()
end
        
        if isFreecamMovementEnabled then
            local currentY = rootPart.Position.Y
            if humanoid.FloorMaterial == Enum.Material.Air and not isJumping then
                local gravity = -196.2 * dt
                currentY = currentY + gravity * dt
            end
            rootPart.Position = Vector3.new(rootPart.Position.X, currentY, rootPart.Position.Z)
            lastYPosition = currentY
        end
    end)
end

UserInputService.JumpRequest:Connect(function()
    if not isFreecamEnabled or not isFreecamMovementEnabled then return end
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if humanoid and rootPart and humanoid.FloorMaterial ~= Enum.Material.Air then
        isJumping = true
        local currentY = rootPart.Position.Y
        rootPart.Position = Vector3.new(rootPart.Position.X, currentY + JUMP_FORCE * 0.1, rootPart.Position.Z)
        task.delay(0.5, function() isJumping = false end)
    end
end)

local function updateCamera(dt)
    if not isFreecamEnabled or isAltHeld then return end
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local moveVector = Vector3.new(0, 0, 0)
    if isFreecamMovementEnabled and humanoid and humanoid.MoveDirection.Magnitude > 0 then
        local forward = camera.CFrame.LookVector
        local right = camera.CFrame.RightVector
        local forwardComponent = humanoid.MoveDirection:Dot(forward) * forward
        local rightComponent = humanoid.MoveDirection:Dot(right) * right
        moveVector = forwardComponent + rightComponent
    end
    if isFreecamMovementEnabled then
        if UserInputService:IsKeyDown(Enum.KeyCode.E) or UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveVector = moveVector + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Q) or UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveVector = moveVector - Vector3.new(0, 1, 0)
        end
    end
    if moveVector.Magnitude > 0 then
        moveVector = moveVector.Unit * FREECAM_SPEED * dt
        cameraPosition = cameraPosition + moveVector
    end
    
    camera.CameraType = Enum.CameraType.Scriptable
    local rotationCFrame = CFrame.Angles(0, cameraRotation.Y, 0) * CFrame.Angles(cameraRotation.X, 0, 0)
    camera.CFrame = CFrame.new(cameraPosition) * rotationCFrame
end

local function onMouseMove(input)
    if not isFreecamEnabled or isMobile or dragging then return end
    cameraRotation = cameraRotation + Vector2.new(-input.Delta.Y * SENSITIVITY, -input.Delta.X * SENSITIVITY)
    cameraRotation = Vector2.new(math.clamp(cameraRotation.X, -math.pi/2, math.pi/2), cameraRotation.Y)
end

local function onTouchMoved(input, gameProcessed)
    if not isFreecamEnabled or gameProcessed or dragging then return end
    
    if lastTouchPosition then
        local delta = input.Position - lastTouchPosition
        cameraRotation = cameraRotation + Vector2.new(-delta.Y * SENSITIVITY / 0.1, -delta.X * SENSITIVITY / 0.1)
        cameraRotation = Vector2.new(math.clamp(cameraRotation.X, -math.pi/2, math.pi/2), cameraRotation.Y)
    end
    lastTouchPosition = input.Position
end

local function onTouchEnded(input)
    lastTouchPosition = nil
end

local function onScroll(input)
    if not isFreecamEnabled or isMobile then return end
    if input.UserInputType == Enum.UserInputType.MouseWheel then
        local zoomDirection = input.Position.Z
        local isCtrlHeld = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
        local isAltHeld = UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or UserInputService:IsKeyDown(Enum.KeyCode.RightAlt)
        
        if isCtrlHeld then
            local newFOV = camera.FieldOfView - zoomDirection * FOV_SPEED
            camera.FieldOfView = math.clamp(newFOV, MIN_FOV, MAX_FOV)
            fovLabel.Text = "FOV: " .. math.floor(camera.FieldOfView + 0.5)
            sliderHandle.Position = UDim2.new(0, (camera.FieldOfView - MIN_FOV) / (MAX_FOV - MIN_FOV) * 100 - 8, 0, -4)
        elseif isAltHeld and isFreecamMovementEnabled then
            local zoomAmount = zoomDirection * ZOOM_SPEED
            local lookVector = camera.CFrame.LookVector
            local newPosition = cameraPosition + lookVector * zoomAmount
            local distance = (newPosition - (cameraPosition + lookVector * MIN_ZOOM)).Magnitude
            if distance >= MIN_ZOOM and distance <= MAX_ZOOM then
                cameraPosition = newPosition
            end
        elseif isFreecamMovementEnabled then
            local zoomAmount = zoomDirection * ZOOM_SPEED
            local lookVector = camera.CFrame.LookVector
            local newPosition = cameraPosition + lookVector * zoomAmount
            local distance = (newPosition - (cameraPosition + lookVector * MIN_ZOOM)).Magnitude
            if distance >= MIN_ZOOM and distance <= MAX_ZOOM then
                cameraPosition = newPosition
            end
        end
    end
end

local function reloadFreecam()
    isFreecamEnabled = false
    isFreecamMovementEnabled = true
    camera.CameraType = Enum.CameraType.Custom
    camera.FieldOfView = DEFAULT_FOV
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    cameraPosition = Vector3.new(0, 10, 0)
    cameraRotation = Vector2.new(0, 0)
    dragging = false
    destroyPlayerCage()
    
    if heartbeatConnection then heartbeatConnection:Disconnect() end
    if touchConnection then touchConnection:Disconnect() end
    if inputChangedConnection then inputChangedConnection:Disconnect() end
    freecamButton.Text = "Enable Freecam"
    movementButton.Text = "Control Player "
    movementButton.Visible = false
    sliderFrame.Visible = false
    fovLabel.Text = "FOV: " .. DEFAULT_FOV
    sliderHandle.Position = UDim2.new(0, (DEFAULT_FOV - MIN_FOV) / (MAX_FOV - MIN_FOV) * 100 - 8, 0, -4)
end

local function activateFreecam()
    if isFreecamEnabled then return end
    isFreecamEnabled = true
    isFreecamMovementEnabled = true
    camera.CameraType = Enum.CameraType.Scriptable
    camera.FieldOfView = DEFAULT_FOV
    
    cameraPosition = camera.CFrame.Position
    local lookVector = camera.CFrame.LookVector
    cameraRotation = Vector2.new(math.asin(-lookVector.Y), math.atan2(-lookVector.X, lookVector.Z))
    
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    freecamButton.Text = "Disable Freecam"
    movementButton.Text = "Control Player "
    movementButton.Visible = true
    sliderFrame.Visible = true
    fovLabel.Text = "FOV: " .. DEFAULT_FOV
    sliderHandle.Position = UDim2.new(0, (DEFAULT_FOV - MIN_FOV) / (MAX_FOV - MIN_FOV) * 100 - 8, 0, -4)
    
    if player.Character then
        freezePlayer(player.Character)
    end
    
    if characterAddedConnection then characterAddedConnection:Disconnect() end
    characterAddedConnection = player.CharacterAdded:Connect(function()
        reloadFreecam()
    end)
    
    if isMobile then
        if touchConnection then touchConnection:Disconnect() end
        touchConnection = UserInputService.TouchMoved:Connect(onTouchMoved)
        UserInputService.TouchEnded:Connect(onTouchEnded)
    end
    
    if inputChangedConnection then inputChangedConnection:Disconnect() end
    inputChangedConnection = UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            onMouseMove(input)
        elseif input.UserInputType == Enum.UserInputType.MouseWheel then
            onScroll(input)
        end
    end)
end

local function deactivateFreecam()
    if not isFreecamEnabled then return end
    isFreecamEnabled = false
    isFreecamMovementEnabled = true
    isAltHeld = false
    dragging = false
    camera.CameraType = Enum.CameraType.Custom
    camera.FieldOfView = DEFAULT_FOV
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    destroyPlayerCage()
    freecamButton.Text = "Enable Freecam"
    movementButton.Text = "Control Player "
    movementButton.Visible = false
    sliderFrame.Visible = false
    fovLabel.Text = "FOV: " .. DEFAULT_FOV
    sliderHandle.Position = UDim2.new(0, (DEFAULT_FOV - MIN_FOV) / (MAX_FOV - MIN_FOV) * 100 - 8, 0, -4)
    
    if player.Character then
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then rootPart.Anchored = false end
    end
    
    if heartbeatConnection then heartbeatConnection:Disconnect() end
    if touchConnection then touchConnection:Disconnect() end
end

freecamButton.MouseButton1Click:Connect(function()
    if isFreecamEnabled then
        deactivateFreecam()
    else
        activateFreecam()
    end
end)


movementButton.MouseButton1Click:Connect(function()
    isFreecamMovementEnabled = not isFreecamMovementEnabled
    movementButton.Text = isFreecamMovementEnabled and "Control Player " or "Control Freecam"
    if player.Character then
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.Anchored = false
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
        if isFreecamEnabled then
            isAltHeld = true
            if player.Character then
                local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    rootPart.Anchored = false
                end
            end
        end
    elseif input.KeyCode == Enum.KeyCode.P and (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
        if isFreecamEnabled then
            deactivateFreecam()
        else
            activateFreecam()
        end
    end
end)
UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
        if isFreecamEnabled then
            isAltHeld = false
            if player.Character then
                local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    rootPart.Anchored = false
                end
            end
        end
    end
end)

RunService.Heartbeat:Connect(updateCamera)
if characterAddedConnection then characterAddedConnection:Disconnect() end
characterAddedConnection = player.CharacterAdded:Connect(function()
    reloadFreecam()
end)
local currentSettings = {
    Speed = "1500",
    JumpCap = "1",
    AirStrafeAcceleration = "187"
}
local emoteList = {}

local success, emotesFolder = pcall(function()
    return game:GetService("ReplicatedStorage").Items.Emotes
end)

if success and typeof(emotesFolder) == "Instance" then
    for _, emote in ipairs(emotesFolder:GetChildren()) do
        if emote:IsA("ModuleScript") or emote:IsA("LocalScript") or emote:IsA("Script") then
            table.insert(emoteList, emote.Name)
        end
    end
end

getgenv().SelectedEmote = nil
getgenv().EmoteEnabled = false
local appliedOnce = false
local playerModelPresent = false
local gameStatsPath = workspace:WaitForChild("Game"):WaitForChild("Stats")
getgenv().ApplyMode = "Not Optimized"
local requiredFields = {
    Friction = true,
    AirStrafeAcceleration = true,
    JumpHeight = true,
    RunDeaccel = true,
    JumpSpeedMultiplier = true,
    JumpCap = true,
    SprintCap = true,
    WalkSpeedMultiplier = true,
    BhopEnabled = true,
    Speed = true,
    AirAcceleration = true,
    RunAccel = true,
    SprintAcceleration = true
}

local function hasAllFields(tbl)
    if type(tbl) ~= "table" then return false end
    for field, _ in pairs(requiredFields) do
        if rawget(tbl, field) == nil then return false end
    end
    return true
end

local function getConfigTables()
    local tables = {}
    for _, obj in ipairs(getgc(true)) do
        local success, result = pcall(function()
            if hasAllFields(obj) then return obj end
        end)
        if success and result then
            table.insert(tables, result)
        end
    end
    return tables
end

local function applyToTables(callback)
    local targets = getConfigTables()
    if #targets == 0 then return end
    
    if getgenv().ApplyMode == "Optimized" then
        task.spawn(function()
            for i, tableObj in ipairs(targets) do
                if tableObj and typeof(tableObj) == "table" then
                    pcall(callback, tableObj)
                end
                
                if i % 3 == 0 then
                    task.wait()
                end
            end
        end)
    else
        for i, tableObj in ipairs(targets) do
            if tableObj and typeof(tableObj) == "table" then
                pcall(callback, tableObj)
            end
        end
    end
end

local function applyStoredSettings()
    local settings = {
        {field = "Speed", value = tonumber(currentSettings.Speed)},
        {field = "JumpCap", value = tonumber(currentSettings.JumpCap)},
        {field = "AirStrafeAcceleration", value = tonumber(currentSettings.AirStrafeAcceleration)}
    }
    
    for _, setting in ipairs(settings) do
        if setting.value and tostring(setting.value) ~= "1500" and tostring(setting.value) ~= "1" and tostring(setting.value) ~= "187" then
            applyToTables(function(obj)
                obj[setting.field] = setting.value
            end)
        end
    end
end

local function applySettingsWithDelay()
    if not playerModelPresent or appliedOnce then
        return
    end
    
    appliedOnce = true
    
    local settings = {
        {field = "Speed", value = tonumber(currentSettings.Speed), delay = math.random(1, 14)},
        {field = "JumpCap", value = tonumber(currentSettings.JumpCap), delay = math.random(1, 14)},
        {field = "AirStrafeAcceleration", value = tonumber(currentSettings.AirStrafeAcceleration), delay = math.random(1, 14)}
    }
    
    for _, setting in ipairs(settings) do
        if setting.value and tostring(setting.value) ~= "1500" and tostring(setting.value) ~= "1" and tostring(setting.value) ~= "187" then
            task.spawn(function()
                task.wait(setting.delay)
                applyToTables(function(obj)
                    obj[setting.field] = setting.value
                end)
            end)
        end
    end
end

local function isPlayerModelPresent()
    local GameFolder = workspace:FindFirstChild("Game")
    local PlayersFolder = GameFolder and GameFolder:FindFirstChild("Players")
    return PlayersFolder and PlayersFolder:FindFirstChild(player.Name) ~= nil
end
local featureStates = {
    AutoWhistle = false,
    CustomGravity = false,
    GravityValue = originalGameGravity,
    InfiniteJump = false,
    Fly = false,
    TPWALK = false,
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
    DisableCameraShake = false,
    PlayerESP = {
        boxes = false,
        tracers = false,
        names = false,
        distance = false,
        rainbowBoxes = false,
        rainbowTracers = false,
        boxType = "2D",
    },
    NextbotESP = {
        boxes = false,
        tracers = false,
        names = false,
        distance = false,
        rainbowBoxes = false,
        rainbowTracers = false,
        boxType = "2D",
    },
    DownedBoxESP = false,
    DownedTracer = false,
    DownedNameESP = false,
    DownedDistanceESP = false,
    DownedBoxType = "2D",
    FlySpeed = 5,
    TpwalkValue = 1,
    JumpPower = 5,
    JumpMethod = "Hold",
    SelectedMap = 1,
    DesiredFOV = 70,
    ZoomValue = 1,
    TimerDisplay = false
}
-- Variables
local character, humanoid, rootPart
local isJumpHeld = false

local flying = false
local bodyVelocity, bodyGyro

local ToggleTpwalk = false
local TpwalkConnection

local jumpCount = 0
local MAX_JUMPS = math.huge

local AntiAFKConnection

local AutoCarryConnection

local reviveRange = 10
local loopDelay = 0.15
local reviveLoopHandle = nil
local interactEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Character"):WaitForChild("Interact")

local playerEspElements = {}
local playerEspConnection = nil
local nextbotESPThread = nil
local downedTracerConnection
local downedNameESPConnection
local downedTracerLines = {}
local downedNameESPLabels = {}
local function draw3DBox(esp, hrp, camera, boxColor, boxSize)
    if not hrp or not camera then
        warn("draw3DBox: Missing hrp or camera")
        return
    end

    boxSize = boxSize or Vector3.new(3, 5, 2)
    local size = boxSize
    local offsets = {
        Vector3.new( size.X/2,  size.Y/2,  size.Z/2),
        Vector3.new( size.X/2,  size.Y/2, -size.Z/2),
        Vector3.new( size.X/2, -size.Y/2,  size.Z/2),
        Vector3.new( size.X/2, -size.Y/2, -size.Z/2),
        Vector3.new(-size.X/2,  size.Y/2,  size.Z/2),
        Vector3.new(-size.X/2,  size.Y/2, -size.Z/2),
        Vector3.new(-size.X/2, -size.Y/2,  size.Z/2),
        Vector3.new(-size.X/2, -size.Y/2, -size.Z/2),
    }
    local screenPoints = {}
    local anyPointOnScreen = false

    for i, offset in ipairs(offsets) do
        local success, vec, onScreen = pcall(function()
            local worldPos = hrp.CFrame * offset
            return camera:WorldToViewportPoint(worldPos)
        end)
        if not success then
            warn("draw3DBox: WorldToViewportPoint failed for offset " .. i)
            return
        end
        screenPoints[i] = {pos = Vector2.new(vec.X, vec.Y), depth = vec.Z, onScreen = onScreen}
        if onScreen and vec.Z > 0 then
            anyPointOnScreen = true
        end
    end

    if not esp.boxLines or #esp.boxLines == 0 then
        esp.boxLines = {}
        for i = 1, 12 do
            local success, line = pcall(function()
                local newLine = Drawing.new("Line")
                newLine.Thickness = 1
                newLine.ZIndex = 2
                return newLine
            end)
            if success then
                table.insert(esp.boxLines, line)
            else
                warn("draw3DBox: Failed to create Drawing.Line for index " .. i)
            end
        end
    end

    local edges = {
        {1, 2}, {1, 3}, {1, 5},
        {2, 4}, {2, 6},
        {3, 4}, {3, 7},
        {5, 6}, {5, 7},
        {4, 8}, {6, 8}, {7, 8} 
    }

    local distance = (player.Character and player.Character:FindFirstChild("HumanoidRootPart") and 
        (player.Character.HumanoidRootPart.Position - hrp.Position).Magnitude) or 10
    local thickness = math.clamp(3 / (distance / 50), 1, 3)

    local lineIndex = 1
    for _, edge in ipairs(edges) do
        if lineIndex > #esp.boxLines then
            warn("draw3DBox: Not enough lines for edge " .. lineIndex)
            break
        end
        local p1 = screenPoints[edge[1]]
        local p2 = screenPoints[edge[2]]
        local line = esp.boxLines[lineIndex]
        if not line then
            warn("draw3DBox: Line not found at index " .. lineIndex)
            break
        end
        line.Color = boxColor or Color3.fromRGB(255, 255, 255)
        line.Thickness = thickness
        line.Transparency = 1
        if anyPointOnScreen and p1.depth > 0 and p2.depth > 0 then
            line.From = p1.pos
            line.To = p2.pos
            line.Visible = true
        else
            line.Visible = false
        end
        lineIndex = lineIndex + 1
    end

    for i = lineIndex, #esp.boxLines do
        esp.boxLines[i].Visible = false
    end
end

local function updatePlayerESP()
    if not camera then camera = workspace.CurrentCamera end
    if not camera then
        warn("updatePlayerESP: Camera not found")
        return
    end
    local screenBottomCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
    local currentTargets = {}

    if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players") then
        for _, model in pairs(workspace.Game.Players:GetChildren()) do
            if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") then
                local isPlayer = Players:GetPlayerFromCharacter(model) ~= nil
                local humanoid = model:FindFirstChild("Humanoid")
                if isPlayer and model.Name ~= player.Name and humanoid and humanoid.Health > 0 then
                    currentTargets[model] = true
                    if not playerEspElements[model] then
                        playerEspElements[model] = {
                            box = Drawing.new("Square"),
                            tracer = Drawing.new("Line"),
                            name = Drawing.new("Text"),
                            distance = Drawing.new("Text"),
                            boxLines = {}
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

                        local boxSize = Vector3.new(3, 5, 2)
                        if humanoid then
                            boxSize = Vector3.new(3, humanoid.HipHeight + 3, 2)
                        end

                        if toggles.boxes then
                            local boxColor
                            if toggles.rainbowBoxes then
                                local hue = (tick() % 5) / 5
                                boxColor = Color3.fromHSV(hue, 1, 1)
                            else
                                boxColor = Color3.fromRGB(0, 255, 0)
                            end
                            if toggles.boxType == "2D" then
                                esp.box.Visible = true
                                esp.box.Size = Vector2.new(size * 2, size * 3)
                                esp.box.Position = Vector2.new(vector.X - size, vector.Y - size * 1.5)
                                esp.box.Color = boxColor
                                if esp.boxLines then
                                    for _, line in ipairs(esp.boxLines) do
                                        line.Visible = false
                                    end
                                end
                            else
                                esp.box.Visible = false
                                pcall(function()
                                    draw3DBox(esp, hrp, camera, boxColor, boxSize)
                                end)
                            end
                        else
                            esp.box.Visible = false
                            if esp.boxLines then
                                for _, line in ipairs(esp.boxLines) do
                                    line.Visible = false
                                end
                            end
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
                        if esp.boxLines then
                            for _, line in ipairs(esp.boxLines) do
                                line.Visible = false
                            end
                        end
                    end
                end
            end
        end
    end

    for target, esp in pairs(playerEspElements) do
        if not currentTargets[target] then
            for _, drawing in pairs(esp) do
                if type(drawing) == "table" then
                    for _, line in ipairs(drawing) do
                        pcall(function() line:Remove() end)
                    end
                else
                    pcall(function() drawing:Remove() end)
                end
            end
            playerEspElements[target] = nil
        end
    end
end

local function updateNextbotESP()
    local camera = workspace.CurrentCamera
    if not camera then
        warn("updateNextbotESP: Camera not found")
        return
    end
    local screenBottomCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
    local currentTargets = {}

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
                boxLines = {}
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

            local boxSize = Vector3.new(3, 5, 2)
            if model:FindFirstChild("Humanoid") then
                local humanoid = model:FindFirstChild("Humanoid")
                boxSize = Vector3.new(3, humanoid.HipHeight + 3, 2)
            end

            if toggles.boxes then
                local boxColor
                if toggles.rainbowBoxes then
                    local hue = (tick() % 5) / 5
                    boxColor = Color3.fromHSV(hue, 1, 1)
                else
                    boxColor = Color3.fromRGB(255, 0, 0)
                end
                if toggles.boxType == "2D" then
                    esp.box.Visible = true
                    esp.box.Size = Vector2.new(size * 2, size * 3)
                    esp.box.Position = Vector2.new(vector.X - size, vector.Y - size * 1.5)
                    esp.box.Color = boxColor
                    if esp.boxLines then
                        for _, line in ipairs(esp.boxLines) do
                            line.Visible = false
                        end
                    end
                else
                    esp.box.Visible = false
                    pcall(function()
                        draw3DBox(esp, hrp, camera, boxColor, boxSize)
                    end)
                end
            else
                esp.box.Visible = false
                if esp.boxLines then
                    for _, line in ipairs(esp.boxLines) do
                        line.Visible = false
                    end
                end
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
                esp.name.Color = Color3.fromRGB(255, 0, 0)
            else
                esp.name.Visible = false
            end

            if toggles.distance then
                local distance = (player.Character and player.Character:FindFirstChild("HumanoidRootPart") and 
                    (player.Character.HumanoidRootPart.Position - hrp.Position).Magnitude) or 0
                esp.distance.Visible = true
                esp.distance.Text = string.format("%.1f", distance)
                esp.distance.Position = Vector2.new(vector.X, vector.Y + size * 1.5 + 5)
                esp.distance.Color = Color3.fromRGB(255, 0, 0)
            else
                esp.distance.Visible = false
            end
        else
            esp.box.Visible = false
            esp.tracer.Visible = false
            esp.name.Visible = false
            esp.distance.Visible = false
            if esp.boxLines then
                for _, line in ipairs(esp.boxLines) do
                    line.Visible = false
                end
            end
        end
    end

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

    for target, esp in pairs(nextbotEspElements) do
        if not currentTargets[target] then
            for _, drawing in pairs(esp) do
                if type(drawing) == "table" then
                    for _, line in ipairs(drawing) do
                        pcall(function() line:Remove() end)
                    end
                else
                    pcall(function() drawing:Remove() end)
                end
            end
            nextbotEspElements[target] = nil
        end
    end
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
        if esp.boxLines then
            for _, line in ipairs(esp.boxLines) do
                pcall(function() line:Remove() end)
            end
        end
    end
    playerEspElements = {}
end

local function startPlayerESP()
    if playerEspConnection then return end
    playerEspConnection = RunService.RenderStepped:Connect(updatePlayerESP)
end

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

local nextbotEspElements = {}
local nextbotEspConnection = nil
local function updateNextbotESP()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local screenBottomCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
    local currentTargets = {}

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
                boxLines = {}
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
                local boxColor
                if toggles.rainbowBoxes then
                    local hue = (tick() % 5) / 5
                    boxColor = Color3.fromHSV(hue, 1, 1)
                else
                    boxColor = Color3.fromRGB(255, 0, 0)
                end
                if toggles.boxType == "2D" then
                    esp.box.Visible = true
                    esp.box.Size = Vector2.new(size * 2, size * 3)
                    esp.box.Position = Vector2.new(vector.X - size, vector.Y - size * 1.5)
                    esp.box.Color = boxColor
                    if esp.boxLines then
                        for _, line in ipairs(esp.boxLines) do
                            line.Visible = false
                        end
                    end
                else
                    esp.box.Visible = false
                    draw3DBox(esp, hrp, camera, boxColor)
                end
            else
                esp.box.Visible = false
                if esp.boxLines then
                    for _, line in ipairs(esp.boxLines) do
                        line.Visible = false
                    end
                end
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
                esp.name.Color = Color3.fromRGB(255, 0, 0)
            else
                esp.name.Visible = false
            end
            if toggles.distance then
                local distance = (player.Character and player.Character:FindFirstChild("HumanoidRootPart") and 
                    (player.Character.HumanoidRootPart.Position - hrp.Position).Magnitude) or 0
                esp.distance.Visible = true
                esp.distance.Text = string.format("%.1f", distance)
                esp.distance.Position = Vector2.new(vector.X, vector.Y + size * 1.5 + 5)
                esp.distance.Color = Color3.fromRGB(255, 0, 0)
            else
                esp.distance.Visible = false
            end
        else
            esp.box.Visible = false
            esp.tracer.Visible = false
            esp.name.Visible = false
            esp.distance.Visible = false
            if esp.boxLines then
                for _, line in ipairs(esp.boxLines) do
                    line.Visible = false
                end
            end
        end
    end

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
    for target, esp in pairs(nextbotEspElements) do
        if not currentTargets[target] then
            for _, drawing in pairs(esp) do
                if type(drawing) == "table" then
                    for _, line in ipairs(drawing) do
                        pcall(function() line:Remove() end)
                    end
                else
                    pcall(function() drawing:Remove() end)
                end
            end
            nextbotEspElements[target] = nil
        end
    end
end

local function startNextbotNameESP()
    if nextbotEspConnection then 
        nextbotEspConnection:Disconnect()
        nextbotEspConnection = nil
    end
    nextbotEspConnection = RunService.RenderStepped:Connect(updateNextbotESP)
    updateNextbotESP()
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
        if esp.boxLines then
            for _, line in ipairs(esp.boxLines) do
                pcall(function() line:Remove() end)
            end
        end
    end
    nextbotEspElements = {}
end
local function setupNextbotDetection()
    if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players") then
        workspace.Game.Players.ChildAdded:Connect(function(child)
            if child:IsA("Model") and isNextbotModel(child) and featureStates.NextbotESP.names or featureStates.NextbotESP.boxes or featureStates.NextbotESP.tracers or featureStates.NextbotESP.distance then
                task.wait(0.5)
                updateNextbotESP()
            end
        end)
    end
    if workspace:FindFirstChild("NPCs") then
        workspace.NPCs.ChildAdded:Connect(function(child)
            if child:IsA("Model") and isNextbotModel(child) and featureStates.NextbotESP.names or featureStates.NextbotESP.boxes or featureStates.NextbotESP.tracers or featureStates.NextbotESP.distance then
                task.wait(0.5)
                updateNextbotESP()
            end
        end)
    end
end
local function toggleNextbotNameESP()
    if featureStates.NextbotESP.names or featureStates.NextbotESP.boxes or featureStates.NextbotESP.tracers or featureStates.NextbotESP.distance then
        startNextbotNameESP()
        setupNextbotDetection()
    else
        stopNextbotNameESP()
    end
end
local function toggleNextbotNameESP()
    if espEnabled then
        stopNextbotNameESP()
        espEnabled = false
    else
        startNextbotNameESP()
        setupNextbotDetection()
        espEnabled = true
    end
end

game:GetService("Players").PlayerRemoving:Connect(function(leavingPlayer)
    if leavingPlayer == player then
        stopNextbotNameESP()
    end
end)

-- Visual Variables
local originalBrightness = Lighting.Brightness
local originalFogEnd = Lighting.FogEnd
local originalOutdoorAmbient = Lighting.OutdoorAmbient
local originalAmbient = Lighting.Ambient
local originalGlobalShadows = Lighting.GlobalShadows
local originalFOV = workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView or 70
local originalAtmospheres = {}

for _, v in pairs(Lighting:GetDescendants()) do
    if v:IsA("Atmosphere") then
        table.insert(originalAtmospheres, v)
    end
end
local function startNoFog()
    originalFogEnd = Lighting.FogEnd
    Lighting.FogEnd = 1000000
    for _, v in pairs(Lighting:GetDescendants()) do
        if v:IsA("Atmosphere") then
            v:Destroy()
        end
    end
end
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

local function bouncePlayer()
    if character and humanoid and rootPart and humanoid.Health > 0 then
        if not isPlayerGrounded() then
            humanoid.Jump = true
            local jumpVelocity = math.sqrt(1.5 * humanoid.JumpHeight * workspace.Gravity) * 1.5
            rootPart.Velocity = Vector3.new(rootPart.Velocity.X, jumpVelocity * humanoid.JumpPower / 50, rootPart.Velocity.Z)
        end
    end
end

local function getDistanceFromPlayer(targetPosition)
    if not character or not rootPart then return 0 end
    return (targetPosition - rootPart.Position).Magnitude
end

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
if featureStates.CustomGravity then
    workspace.Gravity = featureStates.GravityValue
else
    workspace.Gravity = originalGameGravity
end
if not featureStates.GravityValue or type(featureStates.GravityValue) ~= "number" then
    featureStates.GravityValue = originalGameGravity
end
local function reapplyFeatures()
    if featureStates.Fly then
        if flying then stopFlying() end
        startFlying()
    end
end
if featureStates.AutoWhistle then
    stopAutoWhistle()
    startAutoWhistle()
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
local function getServerLink()
    local placeId = game.PlaceId
    local jobId = game.JobId
    return string.format("https://www.roblox.com/games/start?placeId=%d&jobId=%s", placeId, jobId)
end

local function stopNoFog()
    Lighting.FogEnd = originalFogEnd
    for _, atmosphere in pairs(originalAtmospheres) do
        if not atmosphere.Parent then
            local newAtmosphere = Instance.new("Atmosphere")
            for _, prop in pairs({"Density", "Offset", "Color", "Decay", "Glare", "Haze"}) do
                if atmosphere[prop] then
                    newAtmosphere[prop] = atmosphere[prop]
                end
            end
            newAtmosphere.Parent = Lighting
        end
    end
end
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
local autoWhistleHandle = nil

local function startAutoWhistle()
    if autoWhistleHandle then return end  
    autoWhistleHandle = task.spawn(function()
        while featureStates.AutoWhistle do
            pcall(function() 
                game:GetService("ReplicatedStorage").Events.Character.Whistle:FireServer()
            end)
            task.wait(1)
        end
    end)
end

local function stopAutoWhistle()
    featureStates.AutoWhistle = false
    if autoWhistleHandle then
        task.cancel(autoWhistleHandle)
        autoWhistleHandle = nil
    end
end
local function manualRevive()
    if character and character:GetAttribute("Downed") then
        ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(true)
    end
end

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
                                if featureStates.DownedBoxESP then
                                    local boxColor = Color3.fromRGB(255, 255, 0)
                                    if featureStates.DownedBoxType == "2D" then
                                        local topY = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0)).Y
                                        local bottomY = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y
                                        local size = (bottomY - topY) / 2
                                        local box = Drawing.new("Square")
                                        box.Thickness = 2
                                        box.Filled = false
                                        box.Color = boxColor
                                        box.Size = Vector2.new(size * 2, size * 3)
                                        box.Position = Vector2.new(pos.X - size, pos.Y - size * 1.5)
                                        box.ZIndex = 1
                                        box.Visible = true
                                        table.insert(downedTracerLines, box)
                                    else
                                        local size = Vector3.new(3, 5, 2)
                                        local offsets = {
                                            Vector3.new( size.X/2,  size.Y/2,  size.Z/2),
                                            Vector3.new( size.X/2,  size.Y/2, -size.Z/2),
                                            Vector3.new( size.X/2, -size.Y/2,  size.Z/2),
                                            Vector3.new( size.X/2, -size.Y/2, -size.Z/2),
                                            Vector3.new(-size.X/2,  size.Y/2,  size.Z/2),
                                            Vector3.new(-size.X/2,  size.Y/2, -size.Z/2),
                                            Vector3.new(-size.X/2, -size.Y/2,  size.Z/2),
                                            Vector3.new(-size.X/2, -size.Y/2, -size.Z/2),
                                        }
                                        local screenPoints = {}
                                        for i, offset in ipairs(offsets) do
                                            local worldPos = hrp.CFrame * offset
                                            local vec, _ = workspace.CurrentCamera:WorldToViewportPoint(worldPos)
                                            screenPoints[i] = {pos = Vector2.new(vec.X, vec.Y), depth = vec.Z}
                                        end
                                        local edges = {
                                            {1,2}, {1,3}, {1,5},
                                            {2,4}, {2,6},
                                            {3,4}, {3,7},
                                            {5,6}, {5,7},
                                            {4,8}, {6,8}, {7,8}
                                        }
                                        for _, edge in ipairs(edges) do
                                            local p1 = screenPoints[edge[1]]
                                            p2 = screenPoints[edge[2]]
                                            if p1.depth > 0 and p2.depth > 0 then
                                                local line = Drawing.new("Line")
                                                line.Thickness = 2
                                                line.Color = boxColor
                                                line.From = p1.pos
                                                line.To = p2.pos
                                                line.Visible = true
                                                table.insert(downedTracerLines, line)
                                            end
                                        end
                                    end
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

local function onCharacterAdded(newCharacter, plr)
    if plr == player then
        character = newCharacter
        humanoid = character:WaitForChild("Humanoid", 5)
        rootPart = character:WaitForChild("HumanoidRootPart", 5)
        if not humanoid or not rootPart then
            warn("Failed to find Humanoid or HumanoidRootPart")
            return
        end
        if type(setupJumpBoost) == "function" then
            setupJumpBoost()
        else
            warn("setupJumpBoost is not a function")
        end
        if type(reapplyFeatures) == "function" then
            reapplyFeatures()
        else
            warn("reapplyFeatures is not a function")
        end
    end
end
if featureStates.ZoomValue then
    local success, zoomObj = pcall(function()
        return game:GetService("Players").LocalPlayer.PlayerScripts.Camera.FOVAdjusters.Zoom
    end)
    if success and zoomObj then
        zoomObj.Value = featureStates.ZoomValue
    end
end
local function reapplyFeatures()
    if featureStates.Fly then
        if flying then stopFlying() end
        startFlying()
    end
    if featureStates.TPWALK then
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
    if featureStates.NextbotESP.names or featureStates.NextbotESP.boxes or featureStates.NextbotESP.tracers or featureStates.NextbotESP.distance then
        stopNextbotNameESP()
        startNextbotNameESP()
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
if featureStates.TimerDisplay then
TimerDisplayToggle:Set(true)
end
local function onPlayerAdded(plr)
    plr.CharacterAdded:Connect(function(newCharacter)
        onCharacterAdded(newCharacter, plr)
    end)
    if plr.Character then
        onCharacterAdded(plr.Character, plr)
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)

for _, plr in ipairs(Players:GetPlayers()) do
    onPlayerAdded(plr)
end

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
                if not isJumpHeld then
                    isJumpHeld = true
                    bouncePlayer()
                end
            end
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.Space then
        isJumpHeld = false
    end
end)

local function setupMobileJumpButton()
    local success, result = pcall(function()
        local touchGui = player.PlayerGui:WaitForChild("TouchGui", 5)
        local touchControlFrame = touchGui:WaitForChild("TouchControlFrame", 5)
        local jumpButton = touchControlFrame:WaitForChild("JumpButton", 5)
        
        jumpButton.Activated:Connect(function()
            if featureStates.InfiniteJump then
                if featureStates.JumpMethod == "Spam" then
                    bouncePlayer()
                elseif featureStates.JumpMethod == "Hold" then
                    bouncePlayer()
                end
            end
        end)

        jumpButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                isJumpHeld = true
                if featureStates.InfiniteJump and featureStates.JumpMethod == "Hold" then
                    while isJumpHeld and featureStates.InfiniteJump and featureStates.JumpMethod == "Hold" do
                        bouncePlayer()
                        task.wait(0.1)
                    end
                end
            end
        end)

        jumpButton.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                isJumpHeld = false
            end
        end)
    end)
    if not success then
        warn("Failed to set up mobile jump button: " .. tostring(result))
    end
end

if player.Character then
    onCharacterAdded(player.Character, player)
else
    player.CharacterAdded:Connect(function(newCharacter)
        onCharacterAdded(newCharacter, player)
    end)
end

RunService.RenderStepped:Connect(updateFly)

RunService.Heartbeat:Connect(function()
    if workspace.CurrentCamera and featureStates.DesiredFOV then
        workspace.CurrentCamera.FieldOfView = featureStates.DesiredFOV
    end
end)
RunService.Heartbeat:Connect(function()
    if workspace.CurrentCamera and featureStates.DesiredFOV then
        workspace.CurrentCamera.FieldOfView = featureStates.DesiredFOV
    end
    if featureStates.ZoomValue then
        local success, zoomObj = pcall(function()
            return game:GetService("Players").LocalPlayer.PlayerScripts.Camera.FOVAdjusters.Zoom
        end)
        if success and zoomObj then
            zoomObj.Value = featureStates.ZoomValue
        end
    end
end)
local function setupGui()
local function getServers()
    local request = request({
        Url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Desc&limit=100",
        Method = "GET",
    })

    if request.StatusCode == 200 then
        local serverData = HttpService:JSONDecode(request.Body)
        local serverList = {}

        for _, server in pairs(serverData.data) do
            if server.id ~= jobId and server.playing < server.maxPlayers then
                local serverInfo = {
                    serverId = server.id or "N/A",
                    players = server.playing or 0,
                    maxPlayers = server.maxPlayers or 0,
                    ping = server.ping or "N/A",
                }
                table.insert(serverList, serverInfo)
            end
        end
        return serverList
    else
        return {}
    end
end

local function serverHop()

local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local S_T = game:GetService("TeleportService")
local S_H = game:GetService("HttpService")

local File = pcall(function()
	AllIDs = S_H:JSONDecode(readfile("server-hop-temp.json"))
end)
if not File then
	table.insert(AllIDs, actualHour)
	pcall(function()
		writefile("server-hop-temp.json", S_H:JSONEncode(AllIDs))
	end)

end
local function TPReturner(placeId)
	local Site;
	if foundAnything == "" then
		Site = S_H:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. placeId .. '/servers/Public?sortOrder=Asc&limit=100'))
	else
		Site = S_H:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. placeId .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
	end
	local ID = ""
	if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
		foundAnything = Site.nextPageCursor
	end
	local num = 0;
	for i,v in pairs(Site.data) do
		local Possible = true
		ID = tostring(v.id)
		if tonumber(v.maxPlayers) > tonumber(v.playing) then
			for _,Existing in pairs(AllIDs) do
				if num ~= 0 then
					if ID == tostring(Existing) then
						Possible = false
					end
				else
					if tonumber(actualHour) ~= tonumber(Existing) then
						local delFile = pcall(function()
							delfile("server-hop-temp.json")
							AllIDs = {}
							table.insert(AllIDs, actualHour)
						end)
					end
				end
				num = num + 1
			end
			if Possible == true then
				table.insert(AllIDs, ID)
				wait()
				pcall(function()
					writefile("server-hop-temp.json", S_H:JSONEncode(AllIDs))
					wait()
					S_T:TeleportToPlaceInstance(placeId, ID, game.Players.LocalPlayer)
				end)
				wait(4)
			end
		end
	end
end
local module = {}
function module:Teleport(placeId)
	while wait() do
		pcall(function()
			TPReturner(placeId)
			if foundAnything ~= "" then
				TPReturner(placeId)
			end
		end)
	end
end
module:Teleport(game.PlaceId)
return module
end


local function rejoinServer()
    TeleportService:TeleportToPlaceInstance(placeId, jobId)
end

    local FeatureSection = Window:Section({ Title = "loc:FEATURES", Opened = true })

    local Tabs = {
    Main = FeatureSection:Tab({ Title = "Main", Icon = "layout-grid" }),
    Player = FeatureSection:Tab({ Title = "loc:Player_TAB", Icon = "user" }),
    Auto = FeatureSection:Tab({ Title = "loc:AUTO_TAB", Icon = "repeat-2" }),
    Visuals = FeatureSection:Tab({ Title = "loc:VISUALS_TAB", Icon = "camera" }),
    ESP = FeatureSection:Tab({ Title = "loc:ESP_TAB", Icon = "eye" }),
    Utility = FeatureSection:Tab({ Title = "Utility", Icon = "wrench"}),
    Settings = FeatureSection:Tab({ Title = "loc:SETTINGS_TAB", Icon = "settings" })
    
}


-- Main Tab
Tabs.Main:Section({ Title = "Server Info", TextSize = 20 })
Tabs.Main:Divider()

local placeName = "Unknown"
local success, productInfo = pcall(function()
    return MarketplaceService:GetProductInfo(placeId)
end)
if success and productInfo then
    placeName = productInfo.Name
end

Tabs.Main:Paragraph({
    Title = "Game Mode",
    Desc = placeName
})

Tabs.Main:Button({
    Title = "Copy Server Link",
    Desc = "Copy the current server's join link",
    Icon = "link",
    Callback = function()
        local serverLink = getServerLink()
        pcall(function()
            setclipboard(serverLink)
        end)
        WindUI:Notify({
                Icon = "link",
                Title = "Link Copied",
                Content = "The server invite link has been copied to your clipborad",
                Duration = 3
        })
    end
})

local numPlayers = #Players:GetPlayers()
local maxPlayers = Players.MaxPlayers

Tabs.Main:Paragraph({
    Title = "Current Players",
    Desc = numPlayers .. " / " .. maxPlayers
})

Tabs.Main:Paragraph({
    Title = "Server ID",
    Desc = jobId
})

Tabs.Main:Paragraph({
    Title = "Place ID",
    Desc = tostring(placeId)
})

Tabs.Main:Section({ Title = "Server Tools", TextSize = 20 })
Tabs.Main:Divider()

Tabs.Main:Button({
    Title = "Rejoin",
    Desc = "Rejoin the current server",
    Icon = "refresh-cw",
    Callback = function()
        rejoinServer()
    end
})

Tabs.Main:Button({
    Title = "Server Hop",
    Desc = "Hop to a random server",
    Icon = "shuffle",
    Callback = function()
        serverHop()
    end
})

Tabs.Main:Button({
    Title = "Hop to Small Server",
    Desc = "Hop to the smallest available server",
    Icon = "minimize",
    Callback = function()
        hopToSmallServer()
    end
})

Tabs.Main:Button({
       Title = "Advanced Server Hop",
       Desc = "Finding a Server inside your game",
       Icon = "server",
       Callback = function()
           local success, result = pcall(function()
               local script = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Advanced%20Server%20Hop.lua"))()
           end)
           if not success then
               WindUI:Notify({
                   Title = "Error",
                   Content = "Oopsie Daisy Some thing wrong happening with the Github Repository link, Unfortunately this script no longer exsit: " .. tostring(result),
                   Duration = 4
               })
           else
               WindUI:Notify({
                   Title = "Success",
                   Content = "Script Is Loaded",
                   Duration = 3
               })
           end
       end
   })
   Tabs.Main:Section({ Title = "Misc", TextSize = 20 })
   Tabs.Main:Divider()
   Tabs.Main:Button({
    Title = "Show/Hide Reload button",
    Desc = "This button allow you to use front view mode without keyboard or any tool in vip server",
    Icon = "switch-camera",
    Callback = function()
        if reloadVisible then
            if reloadButton then
                reloadButton.Visible = false
                reloadButton.Active = false
            end
            reloadVisible = false
        else
            reloadButton = game:GetService("Players").LocalPlayer.PlayerGui.Shared.HUD.Mobile.Right.Mobile.ReloadButton
            local originalParent = reloadButton.Parent
            reloadButton.Parent = nil
            wait()
            reloadButton.Parent = originalParent
            reloadButton.Visible = true
            reloadButton.Active = true
            reloadVisible = true
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
   -- Player Tabs
   Tabs.Player:Section({ Title = "Player", TextSize = 40 })
    Tabs.Player:Divider()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local remoteEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Character"):WaitForChild("PassCharacterInfo")

local BOUNCE_HEIGHT = 0
local BOUNCE_EPSILON = 0.1
local BOUNCE_ENABLED = false
local touchConnections = {}

local function setupBounceOnTouch(character)
    if not BOUNCE_ENABLED then return end
    
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    if touchConnections[character] then
        touchConnections[character]:Disconnect()
        touchConnections[character] = nil
    end
    
    local touchConnection
    touchConnection = humanoidRootPart.Touched:Connect(function(hit)
        local playerBottom = humanoidRootPart.Position.Y - humanoidRootPart.Size.Y / 2
        local playerTop = humanoidRootPart.Position.Y + humanoidRootPart.Size.Y / 2
        local hitBottom = hit.Position.Y - hit.Size.Y / 2
        local hitTop = hit.Position.Y + hit.Size.Y / 2
        
        if hitTop <= playerBottom + BOUNCE_EPSILON then
            return
        elseif hitBottom >= playerTop - BOUNCE_EPSILON then
            return
        end
        
        remoteEvent:FireServer({}, {2})
        
        if BOUNCE_HEIGHT > 0 then
            local bodyVel = Instance.new("BodyVelocity")
            bodyVel.MaxForce = Vector3.new(0, math.huge, 0)
            bodyVel.Velocity = Vector3.new(0, BOUNCE_HEIGHT, 0)
            bodyVel.Parent = humanoidRootPart
            Debris:AddItem(bodyVel, 0.2)
        end
    end)
    
    touchConnections[character] = touchConnection
    
    character.AncestryChanged:Connect(function()
        if not character.Parent then
            if touchConnections[character] then
                touchConnections[character]:Disconnect()
                touchConnections[character] = nil
            end
        end
    end)
end

local function disableBounce()
    for character, connection in pairs(touchConnections) do
        if connection then
            connection:Disconnect()
            touchConnections[character] = nil
        end
    end
end

if player.Character then
    setupBounceOnTouch(player.Character)
end

player.CharacterAdded:Connect(setupBounceOnTouch)

if Tabs and Tabs.Player then
    Tabs.Player:Section({ Title = "Bounce Settings", TextSize = 20 })
    
    local BounceToggle
    local BounceHeightInput
    local EpsilonInput
    
    BounceToggle = Tabs.Player:Toggle({
        Title = "Enable Bounce",
        Value = false,
        Callback = function(state)
            BOUNCE_ENABLED = state
            if state then
                if player.Character then
                    setupBounceOnTouch(player.Character)
                end
            else
                disableBounce()
            end
            BounceHeightInput:Set({ Enabled = state })
            EpsilonInput:Set({ Enabled = state })
        end
    })

    BounceHeightInput = Tabs.Player:Input({
        Title = "Bounce Height",
        Placeholder = "0",
        Value = tostring(BOUNCE_HEIGHT),
        Numeric = true,
        Enabled = false,
        Callback = function(value)
            local num = tonumber(value)
            if num then
                BOUNCE_HEIGHT = math.max(0, num)
            end
        end
    })

    EpsilonInput = Tabs.Player:Input({
        Title = "Touch Detection Epsilon",
        Placeholder = "0.1",
        Value = tostring(BOUNCE_EPSILON),
        Numeric = true,
        Enabled = false,
        Callback = function(value)
            local num = tonumber(value)
            if num then
                BOUNCE_EPSILON = math.max(0, num)
            end
        end
    })
end
    local InfiniteJumpToggle = Tabs.Player:Toggle({
        Title = "loc:INFINITE_JUMP",
        Value = false,
        Callback = function(state)
            featureStates.InfiniteJump = state
        end
    })

    local JumpMethodDropdown = Tabs.Player:Dropdown({
        Title = "loc:JUMP_METHOD",
        Values = {"Hold", "Spam"},
        Value = "Hold",
        Callback = function(value)
            featureStates.JumpMethod = value
        end
    })

local infiniteSlideEnabled = false
local slideFrictionValue = -8
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local keys = {
    "Friction", "AirStrafeAcceleration", "JumpHeight", "RunDeaccel",
    "JumpSpeedMultiplier", "JumpCap", "SprintCap", "WalkSpeedMultiplier",
    "BhopEnabled", "Speed", "AirAcceleration", "RunAccel", "SprintAcceleration"
}

local function hasAll(tbl)
    if type(tbl) ~= "table" then return false end
    for _, k in ipairs(keys) do
        if rawget(tbl, k) == nil then return false end
    end
    return true
end

local cachedTables = nil
local plrModel = nil
local slideConnection = nil

local function getConfigTables()
    local tables = {}
    for _, obj in ipairs(getgc(true)) do
        local success, result = pcall(function()
            if hasAll(obj) then return obj end
        end)
        if success and result then
            table.insert(tables, obj)
        end
    end
    return tables
end

local function setFriction(value)
    if not cachedTables then return end
    for _, t in ipairs(cachedTables) do
        pcall(function()
            t.Friction = value
        end)
    end
end

local function updatePlayerModel()
    local GameFolder = workspace:FindFirstChild("Game")
    local PlayersFolder = GameFolder and GameFolder:FindFirstChild("Players")
    if PlayersFolder then
        plrModel = PlayersFolder:FindFirstChild(LocalPlayer.Name)
    else
        plrModel = nil
    end
end

local function onHeartbeat()
    if not plrModel then
        setFriction(5)
        return
    end
    local success, currentState = pcall(function()
        return plrModel:GetAttribute("State")
    end)
    if success and currentState then
        if currentState == "Slide" then
            pcall(function()
                plrModel:SetAttribute("State", "EmotingSlide")
            end)
        elseif currentState == "EmotingSlide" then
            setFriction(slideFrictionValue)
        else
            setFriction(5)
        end
    else
        setFriction(5)
    end
end

local InfiniteSlideToggle = Tabs.Player:Toggle({
    Title = "Infinite Slide",
    Value = false,
    Callback = function(state)
        infiniteSlideEnabled = state
        if slideConnection then
            slideConnection:Disconnect()
            slideConnection = nil
        end
        if state then
            cachedTables = getConfigTables()
            updatePlayerModel()
            slideConnection = RunService.Heartbeat:Connect(onHeartbeat)
            LocalPlayer.CharacterAdded:Connect(function()
                task.wait(0.1)
                updatePlayerModel()
            end)
        else
            cachedTables = nil
            plrModel = nil
            setFriction(5)
        end
    end,
})

local InfiniteSlideSpeedInput = Tabs.Player:Input({
    Title = "Set Infinite Slide Speed (Negative Only)",
    Value = tostring(slideFrictionValue),
    Placeholder = "-8 (negative only)",
    Callback = function(text)
        local num = tonumber(text)
        if num and num < 0 then
            slideFrictionValue = num
        end
    end,
})
    local FlyToggle = Tabs.Player:Toggle({
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
local noclipConnections = {}
local noclipEnabled = false

local function setNoCollision()
    for _, object in pairs(workspace:GetDescendants()) do
        if object:IsA("BasePart") and not object:IsDescendantOf(player.Character) then
            object.CanCollide = false
        end
    end
end

local function restoreCollisions()
    for _, object in pairs(workspace:GetDescendants()) do
        if object:IsA("BasePart") and not object:IsDescendantOf(player.Character) then
            object.CanCollide = true
        end
    end
end

local function checkPlayerPosition()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    local humanoidRootPart = player.Character.HumanoidRootPart
    local rayOrigin = humanoidRootPart.Position
    local rayDistance = math.clamp(10, 1, 50)  
    local rayDirection = Vector3.new(0, -rayDistance, 0)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {player.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    if raycastResult and raycastResult.Instance:IsA("BasePart") then
        raycastResult.Instance.CanCollide = true
    end
    for _, object in pairs(workspace:GetDescendants()) do
        if object:IsA("BasePart") and object ~= (raycastResult and raycastResult.Instance) and not object:IsDescendantOf(player.Character) then
            object.CanCollide = false
        end
    end
end

local function onCharacterAdded(newCharacter)
    character = newCharacter
    humanoidRootPart = newCharacter:WaitForChild("HumanoidRootPart")
    if noclipEnabled then
        setNoCollision()
    end
end

    local FlySpeedSlider = Tabs.Player:Slider({
        Title = "loc:FLY_SPEED",
        Value = { Min = 1, Max = 200, Default = 5, Step = 1 },
                Desc = "Adjust fly speed",
        Callback = function(value)
            featureStates.FlySpeed = value
        end
    })
local NoclipToggle = Tabs.Player:Toggle({
    Title = "Noclip",
    Desc = "Note: This feature Can make you fall to the void non-stop so be careful what you're doing when toggles this on",
    Icon = "ghost",
    Callback = function(state)
        noclipEnabled = state
        if state then
            character = player.Character
            humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            if character then
                setNoCollision()
            end
            noclipConnections.characterAdded = player.CharacterAdded:Connect(onCharacterAdded)
            noclipConnections.descendantAdded = workspace.DescendantAdded:Connect(function(descendant)
                if noclipEnabled and descendant:IsA("BasePart") and not descendant:IsDescendantOf(player.Character) then
                    descendant.CanCollide = false
                end
            end)
            noclipConnections.heartbeat = RunService.Heartbeat:Connect(checkPlayerPosition)
        else
            for _, conn in pairs(noclipConnections) do
                if conn then conn:Disconnect() end
            end
            noclipConnections = {}
            restoreCollisions()
        end
    end
})
    local TPWALKToggle = Tabs.Player:Toggle({
        Title = "loc:TPWALK",
        Value = false,
        Callback = function(state)
            featureStates.TPWALK = state
            if state then
                startTpwalk()
            else
                stopTpwalk()
            end
        end
    })

    local TPWALKSlider = Tabs.Player:Slider({
        Title = "loc:TPWALK_VALUE",
         Desc = "Adjust TPWALK speed",
        Value = { Min = 1, Max = 200, Default = 1, Step = 1 },
        Callback = function(value)
            featureStates.TpwalkValue = value
        end
    })

    local JumpBoostToggle = Tabs.Player:Toggle({
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

    local JumpBoostSlider = Tabs.Player:Slider({
        Title = "loc:JUMP_POWER",
        Desc = "Adjust jump height",
        Value = { Min = 1, Max = 200, Default = 5, Step = 1 },
        Callback = function(value)
            featureStates.JumpPower = value
            if featureStates.JumpBoost then
                if humanoid then
                    humanoid.JumpPower = featureStates.JumpPower
                end
            end
        end
    })

Tabs.Player:Section({ Title = "Modifications" })

local function createValidatedInput(config)
    return function(input)
        local val = tonumber(input)
        if not val then return end
        
        if config.min and val < config.min then return end
        if config.max and val > config.max then return end
        
        currentSettings[config.field] = tostring(val)
        applyToTables(function(obj)
            obj[config.field] = val
        end)
    end
end

local SpeedInput = Tabs.Player:Input({
    Title = "Set Speed",
    Icon = "speedometer",
    Placeholder = "Default 1500",
    Value = currentSettings.Speed,
    Callback = createValidatedInput({
        field = "Speed",
        min = 1450,
        max = 100008888
    })
})

local JumpCapInput = Tabs.Player:Input({
    Title = "Set Jump Cap",
    Icon = "chevrons-up",
    Placeholder = "Default 1",
    Value = currentSettings.JumpCap,
    Callback = createValidatedInput({
        field = "JumpCap",
        min = 0.1,
        max = 5088888
    })
})

local StrafeInput = Tabs.Player:Input({
    Title = "Strafe Acceleration",
    Icon = "wind",
    Placeholder = "Default 187",
    Value = currentSettings.AirStrafeAcceleration,
    Callback = createValidatedInput({
        field = "AirStrafeAcceleration",
        min = 1,
        max = 1000888888
    })
})

local ApplyMethodDropdown = Tabs.Player:Dropdown({
    Title = "Select Apply Method",
    Values = { "Not Optimized", "Optimized" },
    Multi = false,
    Default = getgenv().ApplyMode,
    Callback = function(value)
        getgenv().ApplyMode = value
    end
})
    -- Visuals Tab
    Tabs.Visuals:Section({ Title = "Visual", TextSize = 20 })
    Tabs.Visuals:Divider()
    local cameraStretchConnection
local function setupCameraStretch()
    cameraStretchConnection = nil
    local stretchHorizontal = 0.80
    local stretchVertical = 0.80
    local CameraStretchToggle = Tabs.Visuals:Toggle({
        Title = "Camera Stretch",
        Value = false,
        Callback = function(state)
            if state then
                if cameraStretchConnection then cameraStretchConnection:Disconnect() end
                cameraStretchConnection = game:GetService("RunService").RenderStepped:Connect(function()
                    local Camera = workspace.CurrentCamera
                    Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, stretchHorizontal, 0, 0, 0, stretchVertical, 0, 0, 0, 1)
                end)
            else
                if cameraStretchConnection then
                    cameraStretchConnection:Disconnect()
                    cameraStretchConnection = nil
                end
            end
        end
    })

    local CameraStretchHorizontalInput = Tabs.Visuals:Input({
        Title = "Camera Stretch Horizontal",
        Placeholder = "0.80",
        Numeric = true,
        Value = tostring(stretchHorizontal),
        Callback = function(value)
            local num = tonumber(value)
            if num then
                stretchHorizontal = num
                if cameraStretchConnection then
                    cameraStretchConnection:Disconnect()
                    cameraStretchConnection = game:GetService("RunService").RenderStepped:Connect(function()
                        local Camera = workspace.CurrentCamera
                        Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, stretchHorizontal, 0, 0, 0, stretchVertical, 0, 0, 0, 1)
                    end)
                end
            end
        end
    })

    local CameraStretchVerticalInput = Tabs.Visuals:Input({
        Title = "Camera Stretch Vertical",
        Placeholder = "0.80",
        Numeric = true,
        Value = tostring(stretchVertical),
        Callback = function(value)
            local num = tonumber(value)
            if num then
                stretchVertical = num
                if cameraStretchConnection then
                    cameraStretchConnection:Disconnect()
                    cameraStretchConnection = game:GetService("RunService").RenderStepped:Connect(function()
                        local Camera = workspace.CurrentCamera
                        Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, stretchHorizontal, 0, 0, 0, stretchVertical, 0, 0, 0, 1)
                    end)
                end
            end
        end
    })
end

setupCameraStretch()


local module_upvr = {}
module_upvr.__index = module_upvr

local currentModuleInstance = nil

function module_upvr.new()
    if currentModuleInstance then
        currentModuleInstance = nil
    end

    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui", 5)
    local self = setmetatable({
        Player = player,
        Enabled = false,
        Visible = false,
    }, module_upvr)

    local nextbotNoise
    local success, err = pcall(function()
        local shared = playerGui:FindFirstChild("Shared")
        if shared then
            local hud = shared:FindFirstChild("HUD")
            if hud then
                nextbotNoise = hud:FindFirstChild("NextbotNoise")
            end
        end
        if not nextbotNoise then
            local hud = playerGui:FindFirstChild("HUD")
            if hud then
                nextbotNoise = hud:FindFirstChild("NextbotNoise")
            end
        end
        if not nextbotNoise then
            nextbotNoise = playerGui:FindFirstChild("NextbotNoise")
        end
    end)

    if not success or not nextbotNoise then
        warn("Failed to find NextbotNoise in PlayerGui: " .. (err or "Unknown error"))
        return self
    end

    self.originalSize = nextbotNoise.Size
    self.originalPosition = nextbotNoise.Position
    self.originalImageTransparency = nextbotNoise.ImageTransparency
    self.originalNoiseTransparency = nextbotNoise:FindFirstChild("Noise") and nextbotNoise.Noise.ImageTransparency or 0
    self.originalNoise2Transparency = nextbotNoise:FindFirstChild("Noise2") and nextbotNoise.Noise2.ImageTransparency or 0

    local transparencySuccess, transparencyErr = pcall(function()
        local inset = game:GetService("GuiService"):GetGuiInset()
        nextbotNoise.Position = UDim2.new(0.5, 0, 0, -inset.Y)
        nextbotNoise.Size = UDim2.new(0, 0, 0, 0)
        nextbotNoise.ImageTransparency = 1
        if nextbotNoise:FindFirstChild("Noise") then
            nextbotNoise.Noise.ImageTransparency = 1
        else
            warn("Noise not found in NextbotNoise")
        end
        if nextbotNoise:FindFirstChild("Noise2") then
            nextbotNoise.Noise2.ImageTransparency = 1
        else
            warn("Noise2 not found in NextbotNoise")
        end
    end)

    if not transparencySuccess then
        warn("Failed to set vignette properties: " .. transparencyErr)
    end

    self.Noise = nextbotNoise
    currentModuleInstance = self
    return self
end

function module_upvr.stop(self)
    if self.Noise then
        local success, err = pcall(function()
            self.Noise.Size = self.originalSize
            self.Noise.Position = self.originalPosition
            self.Noise.ImageTransparency = self.originalImageTransparency
            if self.Noise:FindFirstChild("Noise") then
                self.Noise.Noise.ImageTransparency = self.originalNoiseTransparency
            end
            if self.Noise:FindFirstChild("Noise2") then
                self.Noise.Noise2.ImageTransparency = self.originalNoise2Transparency
            end
        end)
        if not success then
            warn("Failed to restore vignette properties: " .. err)
        end
    end
    currentModuleInstance = nil
end

function module_upvr.Update(arg1, arg2)
    if arg1 and arg1.Noise then
        local success, err = pcall(function()
            if arg1.Noise:IsA("ImageLabel") or arg1.Noise:IsA("Frame") then
                arg1.Noise.ImageTransparency = 1
                if arg1.Noise:FindFirstChild("Noise") then
                    arg1.Noise.Noise.ImageTransparency = 1
                end
                if arg1.Noise:FindFirstChild("Noise2") then
                    arg1.Noise.Noise2.ImageTransparency = 1
                end
            end
        end)
        if not success then
            warn("Update failed to set transparencies: " .. err)
        end
    end
end



local stableCameraInstance = nil

local StableCamera = {}
StableCamera.__index = StableCamera

function StableCamera.new(maxDistance)
    local self = setmetatable({}, StableCamera)
    self.Player = Players.LocalPlayer
    self.MaxDistance = maxDistance or 50
    self._conn = RunService.RenderStepped:Connect(function(dt) self:Update(dt) end)
    return self
end

local function tryResetShake(player)
    if not player then return end
    local ok, playerScripts = pcall(function() return player:FindFirstChild("PlayerScripts") end)
    if not ok or not playerScripts then return end
    local cameraSet = playerScripts:FindFirstChild("Camera") and playerScripts.Camera:FindFirstChild("Set")
    if cameraSet and type(cameraSet.Invoke) == "function" then
        pcall(function()
            cameraSet:Invoke("CFrameOffset", "Shake", CFrame.new())
        end)
    end
end

function StableCamera:Update(dt)
    if Players and Players.LocalPlayer then
        tryResetShake(Players.LocalPlayer)
    end
end

function StableCamera:Destroy()
    if self._conn then
        self._conn:Disconnect()
        self._conn = nil
    end
end

local DisableCameraShakeToggle = Tabs.Visuals:Toggle({
    Title = "Disable Camera Shake",
    Value = false,
    Callback = function(state)
        featureStates.DisableCameraShake = state
        if state then
            if stableCameraInstance then
                stableCameraInstance:Destroy()
                stableCameraInstance = nil
            end
            stableCameraInstance = StableCamera.new(50)
            pcall(function()
                WindUI:Notify({ Title = "Camera", Content = "Camera shake disabled", Duration = 0 })
            end)
        else
            if stableCameraInstance then
                stableCameraInstance:Destroy()
                stableCameraInstance = nil
            end
            pcall(function()
                WindUI:Notify({ Title = "Camera", Content = "Camera shake enabled", Duration = 0 })
            end)
        end
    end
})

local vignetteEnabled = false

local Disablevignette = Tabs.Visuals:Toggle({
    Title = "Disable Vignette",
    Default = false,
    Callback = function(value)
        vignetteEnabled = value
        if value then
            local vignetteInstance = module_upvr.new()
            if vignetteInstance then
                vignetteConnection = game:GetService("RunService").Heartbeat:Connect(function(dt)
                    module_upvr.Update(vignetteInstance, dt)
                end)
            end
        else
            if vignetteConnection then
                vignetteConnection:Disconnect()
                vignetteConnection = nil
            end
            if currentModuleInstance then
                module_upvr.stop(currentModuleInstance)
            end
        end
    end
})

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    warn("Player respawned - checking vignette disable")
    wait(1)
    
    if vignetteEnabled then
        warn("Reapplying vignette disable after respawn")
        local vignetteInstance = module_upvr.new()
        if vignetteInstance then
            if vignetteConnection then
                vignetteConnection:Disconnect()
            end
            vignetteConnection = game:GetService("RunService").Heartbeat:Connect(function(dt)
                module_upvr.Update(vignetteInstance, dt)
            end)
        end
    end
end)

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
    Value = { Min = 10, Max = 120, Default = 70, Step = 1 },
    Callback = function(value)
        featureStates.DesiredFOV = value
        local camera = workspace.CurrentCamera or game:GetService("Workspace"):WaitForChild("CurrentCamera", 5)
        if camera then
            camera.FieldOfView = value
        end
        local zoomSliderValue = (value - 10) * (200 / 110)
        featureStates.ZoomValue = zoomSliderValue * 0.01
        ZoomSlider:Set(math.floor(zoomSliderValue + 0.5)) 
        local success, zoomObj = pcall(function()
            return game:GetService("Players").LocalPlayer.PlayerScripts.Camera.FOVAdjusters.Zoom
        end)
        if success and zoomObj then
            zoomObj.Value = featureStates.ZoomValue
        end
    end
})
local TimerDisplayToggle = Tabs.Visuals:Toggle({
    Title = "Timer Display",
    Value = false,
    Callback = function(state)
        featureStates.TimerDisplay = state
        if state then
            pcall(function()
                local Players = game:GetService("Players")
                local LocalPlayer = Players.LocalPlayer
                local PlayerGui = LocalPlayer.PlayerGui
                local MainInterface = PlayerGui:WaitForChild("MainInterface")
                local TimerContainer = MainInterface:WaitForChild("TimerContainer")
                TimerContainer.Visible = true
            end)
            
            task.spawn(function()
                while featureStates.TimerDisplay do
                    local success, result = pcall(function()
                        local Players = game:GetService("Players")
                        local player = Players.LocalPlayer
                        
                        if not player then
                            return false
                        end
                        
                        local playerGui = player:FindFirstChild("PlayerGui")
                        if not playerGui then
                            return false
                        end
                        
                        local shared = playerGui:WaitForChild("Shared", 1)
                        if not shared then
                            return false
                        end
                        
                        local hud = shared:WaitForChild("HUD", 1)
                        if not hud then
                            return false
                        end
                        
                        local overlay = hud:WaitForChild("Overlay", 1)
                        if not overlay then
                            return false
                        end
                        
                        local default = overlay:WaitForChild("Default", 1)
                        if not default then
                            return false
                        end
                        
                        local roundOverlay = default:WaitForChild("RoundOverlay", 1)
                        if not roundOverlay then
                            return false
                        end
                        
                        local round = roundOverlay:WaitForChild("Round", 1)
                        if not round then
                            return false
                        end
                        
                        local roundTimer = round:WaitForChild("RoundTimer", 1)
                        if not roundTimer then
                            return false
                        end
                        
                        roundTimer.Visible = false
                        return true
                    end)
                    
                    if not success or not result then
                        task.wait(0)
                    else
                        task.wait(0)
                    end
                end
            end)
        else
            pcall(function()
                local Players = game:GetService("Players")
                local LocalPlayer = Players.LocalPlayer
                local PlayerGui = LocalPlayer.PlayerGui
                local MainInterface = PlayerGui:WaitForChild("MainInterface")
                local TimerContainer = MainInterface:WaitForChild("TimerContainer")
                TimerContainer.Visible = false
            end)
        end
    end
})

    -- ESP Tab
    Tabs.ESP:Section({ Title = "ESP", TextSize = 40 })
    Tabs.ESP:Divider()
    Tabs.ESP:Section({ Title = "Player ESP" })
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

    local PlayerBoxTypeDropdown = Tabs.ESP:Dropdown({
        Title = "Player Box Type",
        Values = {"2D", "3D"},
        Value = "2D",
        Callback = function(value)
            featureStates.PlayerESP.boxType = value
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

    Tabs.ESP:Section({ Title = "Nextbot Name ESP" })

local NextbotESPToggle = Tabs.ESP:Toggle({
    Title = "loc:NEXTBOT_NAME_ESP",
    Value = false,
    Callback = function(state)
        featureStates.NextbotESP.names = state
        if state then
            startNextbotNameESP()
            setupNextbotDetection()
        else
            stopNextbotNameESP()
        end
    end
})

local NextbotBoxESPToggle = Tabs.ESP:Toggle({
    Title = "Nextbot Box ESP",
    Value = false,
    Callback = function(state)
        featureStates.NextbotESP.boxes = state
        if state or featureStates.NextbotESP.names or featureStates.NextbotESP.tracers or featureStates.NextbotESP.distance then
            startNextbotNameESP()
        else
            stopNextbotNameESP()
        end
    end
})

local NextbotBoxTypeDropdown = Tabs.ESP:Dropdown({
    Title = "Nextbot Box Type",
    Values = {"2D", "3D"},
    Value = "2D",
    Callback = function(value)
        featureStates.NextbotESP.boxType = value
    end
})
local NextbotRainbowBoxesToggle = Tabs.ESP:Toggle({
    Title = "Nextbot Rainbow Boxes",
    Value = false,
    Callback = function(state)
        featureStates.NextbotESP.rainbowBoxes = state
        if featureStates.NextbotESP.boxes then
            stopNextbotNameESP()
            startNextbotNameESP()
        end
    end
})
local NextbotTracerToggle = Tabs.ESP:Toggle({
    Title = "Nextbot Tracer",
    Value = false,
    Callback = function(state)
        featureStates.NextbotESP.tracers = state
        if state or featureStates.NextbotESP.names or featureStates.NextbotESP.boxes or featureStates.NextbotESP.distance then
            startNextbotNameESP()
        else
            stopNextbotNameESP()
        end
    end
})
local NextbotRainbowTracersToggle = Tabs.ESP:Toggle({
    Title = "Nextbot Rainbow Tracers",
    Value = false,
    Callback = function(state)
        featureStates.NextbotESP.rainbowTracers = state
        if featureStates.NextbotESP.tracers then
            stopNextbotNameESP()
            startNextbotNameESP()
        end
    end
})
local NextbotDistanceESPToggle = Tabs.ESP:Toggle({
    Title = "Nextbot Distance ESP",
    Value = false,
    Callback = function(state)
        featureStates.NextbotESP.distance = state
        if state or featureStates.NextbotESP.names or featureStates.NextbotESP.boxes or featureStates.NextbotESP.tracers then
            startNextbotNameESP()
        else
            stopNextbotNameESP()
        end
    end
})


    Tabs.ESP:Section({ Title = "Downed Player ESP" })

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

    local DownedBoxTypeDropdown = Tabs.ESP:Dropdown({
        Title = "Downed Box Type",
        Values = {"2D", "3D"},
        Value = "2D",
        Callback = function(value)
            featureStates.DownedBoxType = value
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
    Tabs.Auto:Section({ Title = "Auto", TextSize = 40 })
local _Players = game:GetService("Players")
local _LocalPlayer = _Players.LocalPlayer
local BhopToggle = Tabs.Auto:Toggle({
    Title = "Bhop",
    Value = false,
    Callback = function(state)
        featureStates.Bhop = state
        if not state then
            getgenv().autoJumpEnabled = false
            if jumpGui and jumpToggleBtn then
                jumpToggleBtn.Text = "Off"
                jumpToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                jumpGui.Enabled = isMobile and state
            end
        end
        if _LocalPlayer and _LocalPlayer:FindFirstChild("PlayerGui") then
            local gui = _LocalPlayer.PlayerGui:FindFirstChild("BhopGui")
            if gui then
                gui.Enabled = state
            end
        end
    end
})
featureStates.BhopHold = false

getgenv().bhopHoldActive = false

local BhopHoldToggle = Tabs.Auto:Toggle({
    Title = "Bhop (Jump button or Space)",
    Value = false,
    Callback = function(state)
        featureStates.BhopHold = state
        if not state then
            getgenv().bhopHoldActive = false
        end
    end
})

local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.Space and featureStates.BhopHold then
        getgenv().bhopHoldActive = true
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        getgenv().bhopHoldActive = false
    end
end)

local function setupJumpButton()
    local success, err = pcall(function()
        local touchGui = player:WaitForChild("PlayerGui"):WaitForChild("TouchGui", 5)
        if not touchGui then return end
        local touchControlFrame = touchGui:WaitForChild("TouchControlFrame", 5)
        if not touchControlFrame then return end
        local jumpButton = touchControlFrame:WaitForChild("JumpButton", 5)
        if not jumpButton then return end
        
        jumpButton.MouseButton1Down:Connect(function()
            if featureStates.BhopHold then
                getgenv().bhopHoldActive = true
            end
        end)
        
        jumpButton.MouseButton1Up:Connect(function()
            getgenv().bhopHoldActive = false
        end)
    end)
    if not success then
        warn("Failed to setup jump button: " .. tostring(err))
    end
end
setupJumpButton()
player.CharacterAdded:Connect(setupJumpButton)

task.spawn(function()
    while true do
        local friction = 5
        local isBhopActive = getgenv().autoJumpEnabled or getgenv().bhopHoldActive
        if isBhopActive and getgenv().bhopMode == "Acceleration" then
            friction = getgenv().bhopAccelValue or -0.5
        end
        for _, t in pairs(getgc(true)) do
            if type(t) == "table" and rawget(t, "Friction") then
                if getgenv().bhopMode == "No Acceleration" then
                else
                    t.Friction = friction
                end
            end
        end
        task.wait(0.15)
    end
end)

task.spawn(function()
    while true do
        local isBhopActive = getgenv().autoJumpEnabled or getgenv().bhopHoldActive
        if isBhopActive then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                local humanoid = character.Humanoid
                if humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
            if getgenv().bhopMode == "No Acceleration" then
                task.wait(0.05)
            else
                task.wait()
            end
        else
            task.wait()
        end
    end
end)
local BhopModeDropdown = Tabs.Auto:Dropdown({
    Title = "Bhop Mode",
    Values = {"Acceleration", "No Acceleration"},
    Value = "Acceleration",
    Callback = function(value)
        getgenv().bhopMode = value
    end
})
local BhopAccelInput = Tabs.Auto:Input({
    Title = "Bhop Acceleration (Negative Only)",
    Placeholder = "-0.5",
    Numeric = true,
    Callback = function(value)
        if tostring(value):sub(1,1) == "-" then
            local n = tonumber(value)
            if n then getgenv().bhopAccelValue = n end
        end
    end
})
local AutoEmoteToggle = Tabs.Auto:Toggle({
    Title = "Auto Emote (Hold Crouch Button)",
    Value = false,
    Callback = function(state)
        getgenv().EmoteEnabled = state
    end
})
local EmoteDropdown = Tabs.Auto:Dropdown({
    Title = "Select Emote",
    Values = emoteList,
    Multi = false,
    Callback = function(option)
        getgenv().SelectedEmote = option
    end
})

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
    local AutoWhistleToggle = Tabs.Auto:Toggle({
    Title = "Auto Whistle",
    Value = false,
    Callback = function(state)
        featureStates.AutoWhistle = state
        if state then
            startAutoWhistle()
        else
            stopAutoWhistle()
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

-- Utility Tab

local FreeCamToggle = Tabs.Utility:Toggle({
    Title = "Free Cam UI",
    Desc = "Note: Sometimes it's may be glitchy so don't use it too often, I can't really fix it",
    Icon = "camera",
    Value = false,
    Callback = function(state)
        controlFrame.Visible = state and isMobile
        if state and isMobile then
         print ("")
        elseif state and not isMobile then
            WindUI:Notify({
                Title = "Free Cam",
                Content = "Use Ctrl+P to toggle Free Cam.",
                Duration = 3
            })
            if not isFreecamEnabled then
                deactivateFreecam()
            end
        else
            if isFreecamEnabled then
                deactivateFreecam()
            end
        end
    end
})
local FreeCamSpeedSlider = Tabs.Utility:Slider({
    Title = "Free Cam Speed",
    Desc = "Adjust movement speed in Free Cam",
    Value = { Min = 1, Max = 500, Default = 50, Step = 1 },
    Callback = function(value)
        FREECAM_SPEED = value
    end
})

local TimeChangerInput = Tabs.Utility:Input({
    Title = "Set Time (HH:MM)",
    Placeholder = "12:00",
    Value = "",
    Callback = function(value)
        value = value:gsub("^%s*(.-)%s*$", "%1")
        
        local h_str, m_str = value:match("(%d+):(%d+)")
        if h_str and m_str then
            local h = tonumber(h_str)
            local m = tonumber(m_str)
            
            if h and m and h >= 0 and h <= 23 and m >= 0 and m <= 59 and #h_str <= 2 and #m_str <= 2 then
                local totalHours = h + (m / 60)
                game:GetService("Lighting").ClockTime = totalHours
                
                WindUI:Notify({
                    Title = "Time Changer",
                    Content = "Time set to " .. string.format("%02d:%02d", h, m),
                    Duration = 2
                })
            else
                WindUI:Notify({
                    Title = "Time Changer",
                    Content = "Invalid time! Hours: 00-23, Minutes: 00-59 (e.g., 09:30 or 12:00)",
                    Duration = 3
                })
            end
        else
            WindUI:Notify({
                Title = "Time Changer",
                Content = "Invalid format! Use HH:MM (e.g., 09:30)",
                Duration = 2
            })
        end
    end
})
getgenv().lagSwitchEnabled = false
getgenv().lagDuration = 0.5
local lagGui = nil
local lagGuiButton = nil
local lagInputConnection = nil
local isLagActive = false

local function makeDraggable(frame)
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    local function updateInput(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                updateInput(input)
            end
        end
    end)
end

local function createLagGui(yOffset)
    local lagGuiOld = playerGui:FindFirstChild("LagSwitchGui")
    if lagGuiOld then lagGuiOld:Destroy() end
    lagGui = Instance.new("ScreenGui")
    lagGui.Name = "LagSwitchGui"
    lagGui.IgnoreGuiInset = true
    lagGui.ResetOnSpawn = false
    lagGui.Enabled = getgenv().lagSwitchEnabled
    lagGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 60, 0, 60)
    frame.Position = UDim2.new(0.5, -30, 0.12 + (yOffset or 0), 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.35
    frame.BorderSizePixel = 0
    frame.Parent = lagGui
    makeDraggable(frame)

    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 6)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(150, 150, 150)
    stroke.Thickness = 2

    local label = Instance.new("TextLabel", frame)
    label.Text = "Lag"
    label.Size = UDim2.new(0.9, 0, 0.3, 0)
    label.Position = UDim2.new(0.05, 0, 0.05, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Roboto
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.TextScaled = true

    local subLabel = Instance.new("TextLabel", frame)
    subLabel.Text = "Switch"
    subLabel.Size = UDim2.new(0.9, 0, 0.3, 0)
    subLabel.Position = UDim2.new(0.05, 0, 0.3, 0)
    subLabel.BackgroundTransparency = 1
    subLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    subLabel.Font = Enum.Font.Roboto
    subLabel.TextSize = 14
    subLabel.TextXAlignment = Enum.TextXAlignment.Center
    subLabel.TextYAlignment = Enum.TextYAlignment.Center
    subLabel.TextScaled = true

    lagGuiButton = Instance.new("TextButton", frame)
    lagGuiButton.Name = "TriggerButton"
    lagGuiButton.Text = "Trigger"
    lagGuiButton.Size = UDim2.new(0.9, 0, 0.35, 0)
    lagGuiButton.Position = UDim2.new(0.05, 0, 0.6, 0)
    lagGuiButton.BackgroundColor3 = Color3.fromRGB(0, 120, 80)
    lagGuiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    lagGuiButton.Font = Enum.Font.Roboto
    lagGuiButton.TextSize = 12
    lagGuiButton.TextXAlignment = Enum.TextXAlignment.Center
    lagGuiButton.TextYAlignment = Enum.TextYAlignment.Center
    lagGuiButton.TextScaled = true

    local buttonCorner = Instance.new("UICorner", lagGuiButton)
    buttonCorner.CornerRadius = UDim.new(0, 4)

    lagGuiButton.MouseButton1Click:Connect(function()
        task.spawn(function()
            local start = tick()
            while tick() - start < (getgenv().lagDuration or 0.5) do
                local a = math.random(1, 1000000) * math.random(1, 1000000)
                a = a / math.random(1, 10000)
            end
        end)
    end)
end

if not lagInputConnection then
    lagInputConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.L and getgenv().lagSwitchEnabled and not isLagActive then
            isLagActive = true
            task.spawn(function()
                local duration = getgenv().lagDuration or 0.5
                local start = tick()
                while tick() - start < duration do
                    local a = math.random(1, 1000000) * math.random(1, 1000000)
                    a = a / math.random(1, 10000)
                end
                isLagActive = false
            end)
        end
    end)
end

local LagSwitchToggle = Tabs.Utility:Toggle({
    Title = "Lag Switch",
    Icon = "zap",
    Value = false,
    Callback = function(state)
        getgenv().lagSwitchEnabled = state
        if state then
            if not lagGui then
                createLagGui(0)
            else
                lagGui.Enabled = true
            end
        else
            if lagGui then
                lagGui.Enabled = false
            end
        end
    end
})

local LagDurationInput = Tabs.Utility:Input({
    Title = "Lag Duration (seconds)",
    Placeholder = "0.5",
    Value = tostring(getgenv().lagDuration),
    NumbersOnly = true,
    Callback = function(text)
        local n = tonumber(text)
        if n and n > 0 then
            getgenv().lagDuration = n
        end
    end
})

local GravityToggle = Tabs.Utility:Toggle({
    Title = "Custom Gravity",
    Value = false,
    Callback = function(state)
        featureStates.CustomGravity = state
        if state then
            workspace.Gravity = featureStates.GravityValue
        else
            workspace.Gravity = originalGameGravity
        end
    end
})

local GravityInput = Tabs.Utility:Input({
    Title = "Gravity Value",
    Placeholder = tostring(originalGameGravity),
    Value = tostring(featureStates.GravityValue),
    Callback = function(text)
        local num = tonumber(text)
        if num then
            featureStates.GravityValue = num
            if featureStates.CustomGravity then
                workspace.Gravity = num
            end
        end
    end
})
getgenv().gravityGuiVisible = false

local GravityGUIToggle = Tabs.Utility:Toggle({
    Title = "Gravity toggle shortcuts",
    Desc = "Toggle gui or keybind for quick enable gravity",
    Icon = "toggle-right",
    Value = false,
    Callback = function(state)
        getgenv().gravityGuiVisible = state
        local gravityGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("GravityGui")
        if gravityGui then
            gravityGui.Enabled = state
        end
        if not state then
            WindUI:Notify({
                Title = "Gravity GUI",
                Content = "GUI And keybind disabled.",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "Gravity toggle shortcuts",
                Content = "GUI is enabled or Press J to toggle gravity.",
                Duration = 3
            })
        end
    end
})

    -- Settings Tab
    Tabs.Settings:Section({ Title = "Settings", TextSize = 40 })
    Tabs.Settings:Section({ Title = "Personalize", TextSize = 20 })
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
                configFile:Register("FreeCamSpeedSlider", FreeCamSpeedSlider)
                configFile:Register("JumpMethodDropdown", JumpMethodDropdown)
                configFile:Register("FlyToggle", FlyToggle)
                configFile:Register("FlySpeedSlider", FlySpeedSlider)
                configFile:Register("ZoomSlider", ZoomSlider)
                configFile:Register("TPWALKToggle", TPWALKToggle)
                configFile:Register("TPWALKSlider", TPWALKSlider)
                configFile:Register("JumpBoostToggle", JumpBoostToggle)
                configFile:Register("JumpBoostSlider", JumpBoostSlider)
                configFile:Register("AntiAFKToggle", AntiAFKToggle)
                configFile:Register("FullBrightToggle", FullBrightToggle)
                configFile:Register("FOVSlider", FOVSlider)
                configFile:Register("PlayerBoxESPToggle", PlayerBoxESPToggle)
                configFile:Register("PlayerBoxTypeDropdown", PlayerBoxTypeDropdown)
                configFile:Register("PlayerTracerToggle", PlayerTracerToggle)
                configFile:Register("PlayerNameESPToggle", PlayerNameESPToggle)
                configFile:Register("PlayerDistanceESPToggle", PlayerDistanceESPToggle)
                configFile:Register("PlayerRainbowBoxesToggle", PlayerRainbowBoxesToggle)
                configFile:Register("PlayerRainbowTracersToggle", PlayerRainbowTracersToggle)
                configFile:Register("NextbotESPToggle", NextbotESPToggle)
                configFile:Register("NextbotBoxESPToggle", NextbotBoxESPToggle)
                configFile:Register("NextbotBoxTypeDropdown", NextbotBoxTypeDropdown)
                configFile:Register("NextbotTracerToggle", NextbotTracerToggle)
                configFile:Register("NextbotDistanceESPToggle", NextbotDistanceESPToggle)
                configFile:Register("NextbotRainbowBoxesToggle", NextbotRainbowBoxesToggle)
                configFile:Register("NextbotRainbowTracersToggle", NextbotRainbowTracersToggle)
                configFile:Register("DownedBoxESPToggle", DownedBoxESPToggle)
                configFile:Register("DownedBoxTypeDropdown", DownedBoxTypeDropdown)
                configFile:Register("EmoteDropdown", EmoteDropdown)
configFile:Register("AutoEmoteToggle", AutoEmoteToggle)
 configFile:Register("NoFogToggle", NoFogToggle)
                configFile:Register("DownedTracerToggle", DownedTracerToggle)
                configFile:Register("DownedNameESPToggle", DownedNameESPToggle)
                configFile:Register("DownedDistanceESPToggle", DownedDistanceESPToggle)
                configFile:Register("AutoCarryToggle", AutoCarryToggle)
                configFile:Register("AutoReviveToggle", AutoReviveToggle)
                configFile:Register("AutoVoteDropdown", AutoVoteDropdown)
                configFile:Register("AutoVoteToggle", AutoVoteToggle)
                configFile:Register("AutoSelfReviveToggle", AutoSelfReviveToggle)
                configFile:Register("AutoWinToggle", AutoWinToggle)
                configFile:Register("TimerDisplayToggle", TimerDisplayToggle)
                configFile:Register("AutoMoneyFarmToggle", AutoMoneyFarmToggle)
                configFile:Register("ThemeDropdown", ThemeDropdown)
                configFile:Register("TransparencySlider", TransparencySlider)
                configFile:Register("ThemeToggle", ThemeToggle)
                configFile:Register("SpeedInput", SpeedInput)
                configFile:Register("AutoWhistleToggle", AutoWhistleToggle)
                configFile:Register("JumpCapInput", JumpCapInput)
                configFile:Register("StrafeInput", StrafeInput)
                configFile:Register("ApplyMethodDropdown", ApplyMethodDropdown)
                configFile:Register("InfiniteSlideToggle", InfiniteSlideToggle)
                configFile:Register("GravityToggle", GravityToggle)
                configFile:Register("GravityInput", GravityInput)
                configFile:Register("InfiniteSlideSpeedInput", InfiniteSlideSpeedInput)
                configFile:Register("LagSwitchToggle", LagSwitchToggle)
                configFile:Register("LagDurationInput", LagDurationInput)
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
                    if loadedData.TimerDisplayToggle then
    TimerDisplayToggle:Set(loadedData.TimerDisplayToggle)
end
if loadedData.FreeCamSpeedSlider then
    FreeCamSpeedSlider:Set(loadedData.FreeCamSpeedSlider)
end
if loadedData.AutoWhistleToggle then AutoWhistleToggle:Set(loadedData.AutoWhistleToggle) end
if loadedData.GravityToggle then GravityToggle:Set(loadedData.GravityToggle) end
if loadedData.GravityInput then GravityInput:Set(loadedData.GravityInput) end
if loadedData.SpeedInput then SpeedInput:Set(loadedData.SpeedInput) end
if loadedData.JumpCapInput then JumpCapInput:Set(loadedData.JumpCapInput) end
if loadedData.StrafeInput then StrafeInput:Set(loadedData.StrafeInput) end
if loadedData.ApplyMethodDropdown then ApplyMethodDropdown:Select(loadedData.ApplyMethodDropdown) end
if loadedData.InfiniteSlideToggle then InfiniteSlideToggle:Set(loadedData.InfiniteSlideToggle) end
if loadedData.InfiniteSlideSpeedInput then InfiniteSlideSpeedInput:Set(loadedData.InfiniteSlideSpeedInput) end
if loadedData.EmoteDropdown then EmoteDropdown:Select(loadedData.EmoteDropdown) end
if loadedData.AutoEmoteToggle then AutoEmoteToggle:Set(loadedData.AutoEmoteToggle) end
if loadedData.LagSwitchToggle then LagSwitchToggle:Set(loadedData.LagSwitchToggle) end
if loadedData.LagDurationInput then LagDurationInput:Set(loadedData.LagDurationInput) end
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

    Tabs.Settings:Section({ Title = "Keybind Settings", TextSize = 20 })
    Tabs.Settings:Section({ Title = "Change toggle key for GUI", TextSize = 16, TextTransparency = 0.25 })
    Tabs.Settings:Divider()

    keyBindButton = Tabs.Settings:Button({
        Title = "Keybind",
        Desc = "Current Key: " .. getCleanKeyName(currentKey),
        Icon = "key",
        Variant = "Primary",
        Callback = function()
            bindKey(keyBindButton)
        end
    })

    pcall(updateKeybindButtonDesc)
Tabs.Settings:Section({ Title = "Game Settings", TextSize = 35 })
Tabs.Settings:Section({ Title = "Note: This is a permanent Changes, it's can be used to pass limit value, This action acquired rejoins to see the results", TextSize = 15 })
Tabs.Settings:Divider()
Tabs.Settings:Section({ Title = "Visual", TextSize = 20 })
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChangeSettingRemote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Data"):WaitForChild("ChangeSetting")

local MapShadowToggle = Tabs.Settings:Toggle({
    Title = "Map Shadow",
    Value = Lighting.GlobalShadows,
    Callback = function(state)
        ChangeSettingRemote:InvokeServer(6, state)
    end
})

Lighting:GetPropertyChangedSignal("GlobalShadows"):Connect(function()
    MapShadowToggle:Set(Lighting.GlobalShadows)
end)
    Window:SelectTab(1)
end



setupGui()
setupMobileJumpButton()

Window:OnClose(function()
    isWindowOpen = false
	print ("Press " .. getCleanKeyName(currentKey) .. " To Reopen")
    if ConfigManager and configFile then
        configFile:Set("playerData", MyPlayerData)
        configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))
        configFile:Save()
    end
    if not game:GetService("UserInputService").TouchEnabled then
        pcall(function()
            WindUI:Notify({
                Title = "GUI Closed",
                Content = "Press " .. getCleanKeyName(currentKey) .. " To Reopen",
                Duration = 3
            })
        end)
    end
end)
Window:OnDestroy(function()
    print("Window destroyed")
    if keyConnection then
        keyConnection:Disconnect()
    end
    if keyInputConnection then
        keyInputConnection:Disconnect()
    end
    saveKeybind()
end)

Window:OnOpen(function()
    print("Window opened")
    isWindowOpen = true
end)

Window:UnlockAll()

local roundStartedConnection
local timerConnection

local function setupAttributeConnections()
    if roundStartedConnection then roundStartedConnection:Disconnect() end
    if timerConnection then timerConnection:Disconnect() end
    
    if gameStatsPath then
        roundStartedConnection = gameStatsPath:GetAttributeChangedSignal("RoundStarted"):Connect(function()
            local roundStarted = gameStatsPath:GetAttribute("RoundStarted")
            if roundStarted == true then
                appliedOnce = false
                applyStoredSettings()
            end
        end)
        
        timerConnection = gameStatsPath:GetAttributeChangedSignal("Timer"):Connect(function()
            if isPlayerModelPresent() and not appliedOnce then
                applySettingsWithDelay()
            end
        end)
    end
end

setupAttributeConnections()

task.spawn(function()
    while true do
        task.wait(0.5)
        local currentlyPresent = isPlayerModelPresent()
        
        if currentlyPresent and not playerModelPresent then
            playerModelPresent = true
            applyStoredSettings()
        elseif not currentlyPresent and playerModelPresent then
            playerModelPresent = false
        end
    end
end)

game:GetService("UserInputService").WindowFocused:Connect(function()
    saveKeybind()
end)


do
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui")
getgenv().autoJumpEnabled = false
getgenv().bhopMode = "Acceleration"
getgenv().bhopAccelValue = -0.1
local uiToggledViaUI = false 
local isMobile = UserInputService.TouchEnabled 
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
local function createToggleGui(name, varName, yOffset)
    local gui = playerGui:FindFirstChild(name.."Gui")
    if gui then gui:Destroy() end
    gui = Instance.new("ScreenGui", playerGui)
    gui.Name = name.."Gui"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Enabled = isMobile

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 60, 0, 60)
    frame.Position = UDim2.new(0.5, -30, 0.12 + yOffset, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.35
    frame.BorderSizePixel = 0
    makeDraggable(frame)

    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 6)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(150, 150, 150)
    stroke.Thickness = 2

    local label = Instance.new("TextLabel", frame)
    label.Text = name
    label.Size = UDim2.new(0.9, 0, 0.4, 0)
    label.Position = UDim2.new(0.05, 0, 0.05, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Roboto
    label.TextSize = 20 
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center

    local toggleBtn = Instance.new("TextButton", frame)
    toggleBtn.Name = "ToggleButton"
    toggleBtn.Text = getgenv()[varName] and "On" or "Off"
    toggleBtn.Size = UDim2.new(0.9, 0, 0.55, 0)
    toggleBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
    toggleBtn.BackgroundColor3 = getgenv()[varName] and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(0, 0, 0)
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255) 
    toggleBtn.Font = Enum.Font.Roboto
    toggleBtn.TextSize = 20 
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Center
    toggleBtn.TextYAlignment = Enum.TextYAlignment.Center

    local buttonCorner = Instance.new("UICorner", toggleBtn)
    buttonCorner.CornerRadius = UDim.new(0, 4) 

    toggleBtn.MouseButton1Click:Connect(function()
        getgenv()[varName] = not getgenv()[varName]
        uiToggledViaUI = true
        toggleBtn.Text = getgenv()[varName] and "On" or "Off"
        toggleBtn.BackgroundColor3 = getgenv()[varName] and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(0, 0, 0)
        gui.Enabled = true
    end)

    return gui, toggleBtn
end

local jumpGui, jumpToggleBtn
local MainTab = {}
MainTab.Toggle = function(self, config)
    config.Title = config.Title or "Toggle"
    config.Callback = config.Callback or function() end
    config.Value = config.Value or false

    local toggle = {
        Set = function(self, value)
            config.Value = value
            config.Callback(value)
        end
    }
    config.Callback(config.Value)
    return toggle
end

MainTab.Dropdown = function(self, config)
    config.Title = config.Title or "Dropdown"
    config.Values = config.Values or {}
    config.Multi = config.Multi or false
    config.Default = config.Default or (config.Multi and {} or config.Values[1])
    config.Callback = config.Callback or function() end

    local dropdown = {
        Select = function(self, value)
            config.Callback(value)
        end
    }
    config.Callback(config.Default)
    return dropdown
end

MainTab.Input = function(self, config)
    config.Title = config.Title or "Input"
    config.Placeholder = config.Placeholder or ""
    config.Value = config.Value or ""
    config.Callback = config.Callback or function() end

    local input = {
        Set = function(self, value)
            config.Callback(value)
        end
    }
    return input
end

MainTab:Toggle({
    Title = "Bhop",
    Value = false,
    Callback = function(state)
        if not jumpGui then
            jumpGui, jumpToggleBtn = createToggleGui("Bhop", "autoJumpEnabled", 0.12)
        end
        jumpGui.Enabled = (state and uiToggledViaUI) or isMobile 
        jumpToggleBtn.Text = state and "On" or "Off"
        jumpToggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(0, 0, 0)
    end
})

MainTab:Dropdown({
    Title = "Bhop Mode",
    Values = {"Acceleration", "No Acceleration"},
    Multi = false,
    Default = "Acceleration",
    Callback = function(value)
        getgenv().bhopMode = value
    end
})

MainTab:Input({
    Title = "Bhop Acceleration (Negative Only)",
    Placeholder = "-0.5",
    Numeric = true,
    Callback = function(value)
        if tostring(value):sub(1, 1) == "-" then
            getgenv().bhopAccelValue = tonumber(value)
        end
    end
})

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.KeyCode == Enum.KeyCode.B and featureStates.Bhop then 
        getgenv().autoJumpEnabled = not getgenv().autoJumpEnabled
        uiToggledViaUI = false
        if jumpGui and jumpToggleBtn then
            jumpGui.Enabled = isMobile and getgenv().autoJumpEnabled
            jumpToggleBtn.Text = getgenv().autoJumpEnabled and "On" or "Off"
            jumpToggleBtn.BackgroundColor3 = getgenv().autoJumpEnabled and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(0, 0, 0)
        end
        MainTab:Toggle({
            Title = "Bhop",
            Value = getgenv().autoJumpEnabled,
            Callback = function(state)
                if not jumpGui then
                    jumpGui, jumpToggleBtn = createToggleGui("Bhop", "autoJumpEnabled", 0.12)
                end
                getgenv().autoJumpEnabled = state
                jumpGui.Enabled = (state and uiToggledViaUI) or (isMobile and state)
                jumpToggleBtn.Text = state and "On" or "Off"
                jumpToggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(0, 0, 0)
            end
        }):Set(getgenv().autoJumpEnabled)
    end
end)
task.spawn(function()
    while true do
        local friction = 5
        if getgenv().autoJumpEnabled and getgenv().bhopMode == "Acceleration" then
            friction = getgenv().bhopAccelValue or -5
        end
        if getgenv().autoJumpEnabled == false then
            friction = 5
        end

        for _, t in pairs(getgc(true)) do
            if type(t) == "table" and rawget(t, "Friction") then
                if getgenv().bhopMode == "No Acceleration" then
                else
                    t.Friction = friction
                end
            end
        end
        task.wait(0.15)
    end
end)

task.spawn(function()
    while true do
        if getgenv().autoJumpEnabled then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                local humanoid = character.Humanoid
                if humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
            if getgenv().bhopMode == "No Acceleration" then
                task.wait(0.05)
            else
                task.wait()
            end
        else
            task.wait()
        end
    end
end)
task.spawn(function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local guiPath = { "PlayerGui", "Shared", "HUD", "Mobile", "Right", "Mobile", "CrouchButton" }

    local function waitForDescendant(parent, name)
        local found = parent:FindFirstChild(name, true)
        while not found do
            parent.DescendantAdded:Wait()
            found = parent:FindFirstChild(name, true)
        end
        return found
    end

    local function connectCrouchButton()
        local gui = player:WaitForChild(guiPath[1])
        for i = 2, #guiPath do
            gui = waitForDescendant(gui, guiPath[i])
        end
        local button = gui

        local holding = false
        local validHold = false

        button.MouseButton1Down:Connect(function()
            holding = true
            validHold = true
            task.delay(0.5, function()
                if holding and validHold and getgenv().EmoteEnabled and getgenv().SelectedEmote then
                    local args = { [1] = getgenv().SelectedEmote }
                    game:GetService("ReplicatedStorage"):WaitForChild("Events", 9e9):WaitForChild("Character", 9e9):WaitForChild("Emote", 9e9):FireServer(unpack(args))
                end
            end)
        end)

        button.MouseButton1Up:Connect(function()
            holding = false
            validHold = false
        end)
    end

    while true do
        pcall(connectCrouchButton)
        task.wait(1)
    end
end)
end
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local BhopGui = LocalPlayer.PlayerGui:FindFirstChild("BhopGui")

if BhopGui then
    BhopGui.Enabled = false
end
if not featureStates then
    featureStates = {
        CustomGravity = false,
        GravityValue = workspace.Gravity
    }
end
local originalGameGravity = workspace.Gravity
local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui", 5)

local function makeDraggable(frame)
    local dragging = false
    local dragStart = nil
    local startPos = nil

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    frame.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

local function createGravityGui(yOffset)
    local gravityGuiOld = playerGui:FindFirstChild("GravityGui")
    if gravityGuiOld then gravityGuiOld:Destroy() end
    
    local gravityGui = Instance.new("ScreenGui")
    gravityGui.Name = "GravityGui"
    gravityGui.IgnoreGuiInset = true
    gravityGui.ResetOnSpawn = false
    gravityGui.Enabled = getgenv().gravityGuiVisible
    gravityGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 60, 0, 60)
    frame.Position = UDim2.new(0.5, -30, 0.12 + (yOffset or 0), 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.35
    frame.BorderSizePixel = 0
    frame.Parent = gravityGui
    makeDraggable(frame)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(150, 150, 150)
    stroke.Thickness = 2
    stroke.Parent = frame

    local label = Instance.new("TextLabel")
    label.Text = "Gravity"
    label.Size = UDim2.new(0.9, 0, 0.3, 0)
    label.Position = UDim2.new(0.05, 0, 0.05, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Roboto
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.TextScaled = true
    label.Parent = frame

    local subLabel = Instance.new("TextLabel")
    subLabel.Text = "Toggle"
    subLabel.Size = UDim2.new(0.9, 0, 0.3, 0)
    subLabel.Position = UDim2.new(0.05, 0, 0.3, 0)
    subLabel.BackgroundTransparency = 1
    subLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    subLabel.Font = Enum.Font.Roboto
    subLabel.TextSize = 14
    subLabel.TextXAlignment = Enum.TextXAlignment.Center
    subLabel.TextYAlignment = Enum.TextYAlignment.Center
    subLabel.TextScaled = true
    subLabel.Parent = frame

    local gravityGuiButton = Instance.new("TextButton")
    gravityGuiButton.Name = "ToggleButton"
    gravityGuiButton.Text = featureStates.CustomGravity and "On" or "Off"
    gravityGuiButton.Size = UDim2.new(0.9, 0, 0.35, 0)
    gravityGuiButton.Position = UDim2.new(0.05, 0, 0.6, 0)
    gravityGuiButton.BackgroundColor3 = featureStates.CustomGravity and Color3.fromRGB(0, 120, 80) or Color3.fromRGB(120, 0, 0)
    gravityGuiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    gravityGuiButton.Font = Enum.Font.Roboto
    gravityGuiButton.TextSize = 12
    gravityGuiButton.TextXAlignment = Enum.TextXAlignment.Center
    gravityGuiButton.TextYAlignment = Enum.TextYAlignment.Center
    gravityGuiButton.TextScaled = true
    gravityGuiButton.Parent = frame

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = gravityGuiButton

    gravityGuiButton.MouseButton1Click:Connect(function()
        featureStates.CustomGravity = not featureStates.CustomGravity
        if featureStates.CustomGravity then
            workspace.Gravity = featureStates.GravityValue
        else
            workspace.Gravity = originalGameGravity
        end
        gravityGuiButton.Text = featureStates.CustomGravity and "On" or "Off"
        gravityGuiButton.BackgroundColor3 = featureStates.CustomGravity and Color3.fromRGB(0, 120, 80) or Color3.fromRGB(120, 0, 0)
    end)
end
createGravityGui()
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.J and getgenv().gravityGuiVisible then
        featureStates.CustomGravity = not featureStates.CustomGravity
        if featureStates.CustomGravity then
            workspace.Gravity = featureStates.GravityValue
        else
            workspace.Gravity = originalGameGravity
        end
        local gravityGui = playerGui:FindFirstChild("GravityGui")
        if gravityGui then
            local button = gravityGui.Frame:FindFirstChild("ToggleButton")
            if button then
                button.Text = featureStates.CustomGravity and "On" or "Off"
                button.BackgroundColor3 = featureStates.CustomGravity and Color3.fromRGB(0, 120, 80) or Color3.fromRGB(120, 0, 0)
            end
        end
        WindUI:Notify({
            Title = "Gravity",
            Content = "Custom Gravity " .. (featureStates.CustomGravity and "enabled" or "disabled"),
            Duration = 2
        })
    end
end)
if featureStates.CustomGravity then
    workspace.Gravity = featureStates.GravityValue
else
    workspace.Gravity = originalGameGravity
end
local downedConnection = nil

local function setupDownedListener(character)
    if downedConnection then
        downedConnection:Disconnect()
        downedConnection = nil
    end
    
    if character then
        downedConnection = character:GetAttributeChangedSignal("Downed"):Connect(function()
            if character:GetAttribute("Downed") == true then
                deactivateFreecam()
            end
        end)
        
        if character:GetAttribute("Downed") == true then
            deactivateFreecam()
        end
    end
end

player.CharacterAdded:Connect(function(character)
    setupDownedListener(character)
end)

if player.Character then
    setupDownedListener(player.Character)
end
 
local respawnTeleportConnection
if respawnTeleportConnection then respawnTeleportConnection:Disconnect() end
respawnTeleportConnection = player.CharacterAdded:Connect(function(character)
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
    if humanoidRootPart then
        local spawnsFolder = workspace:WaitForChild("Game"):WaitForChild("Map"):WaitForChild("Parts"):WaitForChild("Spawns")
        local spawns = spawnsFolder:GetChildren()
        local availableSpawns = {}
        for _, spawn in ipairs(spawns) do
            if spawn:IsA("Part") and spawn:GetAttribute("Available") == true then
                table.insert(availableSpawns, spawn)
            end
        end
        if #availableSpawns > 0 then
            local randomSpawn = availableSpawns[math.random(1, #availableSpawns)]
            humanoidRootPart.CFrame = randomSpawn.CFrame + Vector3.new(0, 5, 0)
        elseif #spawns > 0 then
            local randomSpawn = spawns[math.random(1, #spawns)]
            humanoidRootPart.CFrame = randomSpawn.CFrame + Vector3.new(0, 5, 0)
        end
    end
end)

--[[the part of loadstring prevent error]]

local script = loadstring(game:HttpGet('https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/TimerGUI-NoRepeat'))()
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





local script = loadstring(game:HttpGet('https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/U%20already%20have%20it%20lol'))()

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

local script = loadstring(game:HttpGet('https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/evade%20leaderboard%20button.lua'))()

                local securityPart = Instance.new("Part")
                securityPart.Name = "SecurityPart"
                securityPart.Size = Vector3.new(10, 1, 10)
                securityPart.Position = Vector3.new(0, 500, 0)
                securityPart.Anchored = true
                securityPart.CanCollide = true
                securityPart.Parent = workspace
                rootPart.CFrame = securityPart.CFrame + Vector3.new(0, 3, 0) 
                