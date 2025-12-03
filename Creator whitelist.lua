-- esp my username 
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local coreGui = game:GetService("CoreGui")

local whitelist = {
    "mounsokdara",
    "iaman2019ogdawg", 
    "1111hh99"
}

local espSettings = {
    text = "DaraHub Creator",
    textColor = Color3.fromRGB(255, 215, 0),
    textSize = 14,
    showDistance = true,
    maxDistance = 1000,
    textOutline = true,
    textOutlineColor = Color3.fromRGB(0, 0, 0)
}

local espCache = {}
local connections = {}
local characterConnections = {}

local function cleanupPlayerESP(player)
    if espCache[player] then
        if espCache[player].billboard then
            espCache[player].billboard:Destroy()
        end
        if espCache[player].updateConnection then
            espCache[player].updateConnection:Disconnect()
        end
        if espCache[player].deathConnection then
            espCache[player].deathConnection:Disconnect()
        end
        espCache[player] = nil
    end
    
    if characterConnections[player] then
        characterConnections[player]:Disconnect()
        characterConnections[player] = nil
    end
end

local function createEsp(player)
    cleanupPlayerESP(player)
    
    if not player.Character then
        characterConnections[player] = player.CharacterAdded:Connect(function()
            task.wait(0.5)
            createEsp(player)
        end)
        return
    end
    
    local character = player.Character
    local humanoid = character:WaitForChild("Humanoid", 2)
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 2)
    
    if not humanoidRootPart or not humanoid then
        task.wait(1)
        if player.Character then
            createEsp(player)
        end
        return
    end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = player.Name .. "_ESP"
    billboard.Adornee = humanoidRootPart
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = espSettings.maxDistance
    billboard.Enabled = true
    billboard.ResetOnSpawn = false
    billboard.Parent = coreGui
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "ESPLabel"
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = espSettings.text
    textLabel.TextColor3 = espSettings.textColor
    textLabel.TextSize = espSettings.textSize
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeTransparency = espSettings.textOutline and 0.5 or 1
    textLabel.TextStrokeColor3 = espSettings.textOutlineColor
    textLabel.Parent = billboard
    
    local function updateESP()
        if not player or not player.Character or not humanoidRootPart or not humanoidRootPart.Parent or humanoid.Health <= 0 then
            if espCache[player] and espCache[player].billboard then
                espCache[player].billboard.Enabled = false
            end
            return
        end
        
        if espCache[player] and espCache[player].billboard then
            espCache[player].billboard.Enabled = true
            espCache[player].billboard.Adornee = humanoidRootPart
            
            if espSettings.showDistance then
                local localPlayer = players.LocalPlayer
                if localPlayer and localPlayer.Character then
                    local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if localRoot then
                        local distance = (humanoidRootPart.Position - localRoot.Position).Magnitude
                        textLabel.Text = espSettings.text .. "\n[" .. math.floor(distance) .. " studs]"
                        return
                    end
                end
            end
            textLabel.Text = espSettings.text
        end
    end
    
    local updateConnection = runService.Heartbeat:Connect(updateESP)
    
    local deathConnection = humanoid.Died:Connect(function()
        if espCache[player] and espCache[player].billboard then
            espCache[player].billboard.Enabled = false
        end
        
        local respawnConnection
        respawnConnection = player.CharacterAdded:Connect(function()
            if respawnConnection then
                respawnConnection:Disconnect()
            end
            task.wait(1)
            createEsp(player)
        end)
    end)
    
    espCache[player] = {
        billboard = billboard,
        label = textLabel,
        updateConnection = updateConnection,
        deathConnection = deathConnection
    }
    
    table.insert(connections, updateConnection)
    table.insert(connections, deathConnection)
    
    characterConnections[player] = player.CharacterRemoving:Connect(function()
        if espCache[player] and espCache[player].billboard then
            espCache[player].billboard.Enabled = false
        end
    end)
end

local function isWhitelisted(playerName)
    for _, whitelistedName in ipairs(whitelist) do
        if playerName == whitelistedName then
            return true
        end
    end
    return false
end

local function removeEsp(player)
    cleanupPlayerESP(player)
end

local function initializePlayer(player)
    if player == players.LocalPlayer then return end
    if not isWhitelisted(player.Name) then return end
    
    if player.Character then
        createEsp(player)
    end
    
    characterConnections[player] = player.CharacterAdded:Connect(function()
        task.wait(1)
        createEsp(player)
    end)
end

for _, player in ipairs(players:GetPlayers()) do
    initializePlayer(player)
end

local playerAddedConnection = players.PlayerAdded:Connect(function(player)
    if isWhitelisted(player.Name) then
        initializePlayer(player)
    end
end)

local playerRemovingConnection = players.PlayerRemoving:Connect(function(player)
    removeEsp(player)
end)

local toggleKey = Enum.KeyCode.F6
local espEnabled = true

local inputConnection = userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == toggleKey then
        espEnabled = not espEnabled
        for _, espData in pairs(espCache) do
            if espData.billboard then
                espData.billboard.Enabled = espEnabled
            end
        end
    end
end)

local wasFocused = true
local focusConnection = userInputService.WindowFocused:Connect(function()
    if not wasFocused then
        wasFocused = true
        task.wait(0.5)
        for _, espData in pairs(espCache) do
            if espData.billboard then
                espData.billboard.Enabled = espEnabled
            end
        end
    end
end)

local unfocusConnection = userInputService.WindowFocusReleased:Connect(function()
    wasFocused = false
end)

local function cleanup()
    for _, connection in ipairs(connections) do
        if connection then
            connection:Disconnect()
        end
    end
    connections = {}
    
    for player in pairs(espCache) do
        removeEsp(player)
    end
    
    for player in pairs(characterConnections) do
        if characterConnections[player] then
            characterConnections[player]:Disconnect()
        end
    end
    
    if playerAddedConnection then playerAddedConnection:Disconnect() end
    if playerRemovingConnection then playerRemovingConnection:Disconnect() end
    if inputConnection then inputConnection:Disconnect() end
    if focusConnection then focusConnection:Disconnect() end
    if unfocusConnection then unfocusConnection:Disconnect() end
end

game:GetService("Debris"):AddItem(script, 0)

return {
    cleanup = cleanup,
    toggleESP = function(state)
        espEnabled = state
        for _, espData in pairs(espCache) do
            if espData.billboard then
                espData.billboard.Enabled = state
            end
        end
    end,
    addToWhitelist = function(username)
        table.insert(whitelist, username)
        for _, player in ipairs(players:GetPlayers()) do
            if player.Name == username and not espCache[player] then
                initializePlayer(player)
            end
        end
    end,
    removeFromWhitelist = function(username)
        for i = #whitelist, 1, -1 do
            if whitelist[i] == username then
                table.remove(whitelist, i)
                for player in pairs(espCache) do
                    if player.Name == username then
                        removeEsp(player)
                    end
                end
                break
            end
        end
    end
}
