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
controlFrame.Visible = isMobile 
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

if not isMobile then
    WindUI:Notify({
        Title = "Free Cam",
        Content = "Use Ctrl+P to toggle Free Cam.",
        Duration = 3
    })
end

local FreeCamSpeedSlider = Tabs.Utility:Slider({
    Title = "Free Cam Speed",
    Desc = "Adjust movement speed in Free Cam",
    Value = { Min = 1, Max = 500, Default = 50, Step = 1 },
    Callback = function(value)
        FREECAM_SPEED = value
    end
})

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

if player.Character then
    setupDownedListener(player.Character)
end

player.CharacterAdded:Connect(setupDownedListener)

configFile:Register("FreeCamSpeedSlider", FreeCamSpeedSlider)
