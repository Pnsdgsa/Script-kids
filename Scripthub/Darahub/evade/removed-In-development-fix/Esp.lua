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

    boxSize = boxSize or Vector3.new(4, 5, 3)
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
            local worldPos = hrp.CFrame * CFrame.Angles(0, math.rad(90), 0) * offset
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

                        local boxSize = Vector3.new(4, 5, 3)
                        if humanoid then
                            boxSize = Vector3.new(2, humanoid.HipHeight + 5, 2)
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

            local boxSize = Vector3.new(4, 5, 3)
            if model:FindFirstChild("Humanoid") then
                local humanoid = model:FindFirstChild("Humanoid")
                boxSize = Vector3.new(2, humanoid.HipHeight + 5, 2)
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
