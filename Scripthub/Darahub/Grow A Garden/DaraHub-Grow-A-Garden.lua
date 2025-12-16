if getgenv().DaraHubExecuted then
    return
end
getgenv().DaraHubExecuted = true

WindUI = nil

do
    ok, result = pcall(function()
        return require("./src/Init")
    end)
    
    if ok then
        WindUI = result
    else 
         WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end
end

WindUI.TransparencyValue = 0.2
WindUI:SetTheme("Dark")
if makefolder then
    pcall(function() makefolder("DaraHub") end)
    pcall(function() makefolder("DaraHub/Games") end)
    pcall(function() makefolder("DaraHub/Games/Grow-A-Garden") end)
end
local Window = WindUI:CreateWindow({
    NewElements = true,
    Title = "Dara Hub | Grow A Garden",
    Icon = "rbxassetid://137330250139083",
    Author = "Made by: Pnsdg And Yomka",
    Folder = "DaraHub/Games/Grow-A-Garden",
    Size = UDim2.fromOffset(580, 490),
    Theme = "Dark",
    HidePanelBackground = false,
    Acrylic = false,
    HideSearchBar = false,
    SideBarWidth = 200
})


isWindowOpen = false
updateWindowOpenState = function()
    if Window and type(Window.IsOpen) == "function" then
        ok, val = pcall(function() return Window:IsOpen() end)
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
Window:SetIconSize(48)
Window:Tag({
    Title = "V1",
    Color = Color3.fromHex("#30ff6a")
})
function safeResolve(value)
    if not Localization or not Localization.Enabled then
        return value
    end
    
    if type(value) == "string" and value:sub(1, #Localization.Prefix) == Localization.Prefix then
        local key = value:sub(#Localization.Prefix + 1)
        local lang = Localization.Translations and Localization.Translations[Localization.DefaultLanguage]
        if lang and lang[key] then
            return lang[key]
        end
    end
    
    return value
end

originalCreateWindow = WindUI.CreateWindow
WindUI.CreateWindow = function(self, config)
    if config and Localization then
        for key, value in pairs(config) do
            if type(value) == "string" then
                config[key] = safeResolve(value)
            end
        end
    end
    
    return originalCreateWindow(self, config)
end

function resolveWindowProperties(window)
    if not window then return end
    
    if window.Title and type(window.Title) == "string" then
        window.Title = safeResolve(window.Title)
    end
    if window.Author and type(window.Author) == "string" then
        window.Author = safeResolve(window.Author)
    end
end

resolveWindowProperties(Window)

print("Window Title:", Window.Title)
print("Window Author:", Window.Author)

HttpService = game:GetService("HttpService")
Players = game:GetService("Players")
MarketplaceService = game:GetService("MarketplaceService")

localPlayer = Players.LocalPlayer
if not localPlayer then
    warn("Local player not found!")
    return
end

OSTime = os.time()
Time = os.date("!*t", OSTime)

placeId = game.PlaceId
jobId = game.JobId
placeName = MarketplaceService:GetProductInfo(placeId).Name or "Unknown Game"

placeUrl = string.format("https://www.roblox.com/games/%d/", placeId)
serverJoinUrl = string.format("https://www.roblox.com/games/start?placeId=%d&jobId=%s", placeId, jobId)
playerProfileUrl = string.format("https://www.roblox.com/users/%d/profile", localPlayer.UserId)

WebhookUrl = "https://discord.com/api/webhooks/1445295029580206222/e3plUoiO1FrcKjIP1V7EC_XBkRLmRu-sHuNxDcg0dkWeJaEOW0Jw6OJg9hs8gzaI0l0y"

windowTitle = Window and Window.Title or "Unknown Window"
windowAuthor = Window and Window.Author or "Unknown Author"

Embed = {
    title = "⚡ Script Executed",
    description = string.format("**%s** (`%d`) used an execution script", localPlayer.Name, localPlayer.UserId),
    color = 16753920,
    author = {
        name = localPlayer.Name,
        url = playerProfileUrl,
        icon_url = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png", localPlayer.UserId)
    },
    fields = {
        {
            name = "📝 Details",
            value = string.format("**Player:** [%s](%s)\n**Game:** [%s](%s)\n**Time:** <t:%d:R>", 
                localPlayer.Name, playerProfileUrl, placeName, placeUrl, OSTime),
            inline = true
        },
        {
            name = "🔗 Join Information",
            value = string.format("**Server ID:** `%s`\n**Place ID:** `%d`\n[Direct Join Link](%s)", 
                jobId, placeId, serverJoinUrl),
            inline = true
        },
        {
            name = "📊 Account Age",
            value = string.format("**Created:** <t:%d:D>\n**Account Age:** %d days", 
                localPlayer.AccountAge, localPlayer.AccountAge),
            inline = true
        },
        {
            name = "💻 Script Info",
            value = string.format("**Window Title:** %s\n**Author:** %s", 
                windowTitle, windowAuthor),
            inline = true
        }
    },
    timestamp = string.format("%d-%d-%dT%02d:%02d:%02dZ", Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec),
    footer = {
        text = string.format("Execution Log | Place: %s", placeName),
        icon_url = "https://cdn.discordapp.com/embed/avatars/4.png"
    },
    thumbnail = {
        url = string.format("https://www.roblox.com/asset-thumbnail/image?assetId=%d&width=420&height=420&format=png", placeId)
    }
}

success, result = pcall(function()
    requestFunc = syn and syn.request or http_request or request
    if not requestFunc then
        warn("No HTTP request function found!")
        return
    end
    
    return requestFunc {
        Url = WebhookUrl,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode({
            embeds = { Embed },
            content = string.format("⚠️ **%s** just executed a script!\n\n📋 **Player Info:**\n• Username: %s\n• User ID: %d\n• Display Name: %s\n• Account Age: %d days\n\n🎮 **Game Info:**\n• Game: %s\n• Place ID: %d\n\n💻 **Script Info:**\n• Window Title: %s\n• Author: %s\n\n🔗 **Join their server:**\n%s", 
                localPlayer.Name, 
                localPlayer.Name, 
                localPlayer.UserId, 
                localPlayer.DisplayName, 
                localPlayer.AccountAge, 
                placeName, 
                placeId,
                windowTitle,
                windowAuthor,
                serverJoinUrl)
        })
    }
end)
Window:CreateTopbarButton("theme-switcher", "moon", function()
    WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "Light" or "Dark")
end, 990)

Players = game:GetService("Players")
UserInputService = game:GetService("UserInputService")
RunService = game:GetService("RunService")
VirtualUser = game:GetService("VirtualUser")
Lighting = game:GetService("Lighting")
ReplicatedStorage = game:GetService("ReplicatedStorage")
workspace = game:GetService("Workspace")
originalGameGravity = workspace.Gravity
TeleportService = game:GetService("TeleportService")
HttpService = game:GetService("HttpService")
MarketplaceService = game:GetService("MarketplaceService")
player = Players.LocalPlayer
playerGui = player:WaitForChild("PlayerGui")
placeId = game.PlaceId
jobId = game.JobId

featureStates = {
    InfiniteJump = false,
    Fly = false,
    FlySpeed = 5,
    TPWALK = false,
    TpwalkValue = 1,
    JumpBoost = false,
    JumpPower = 5,
    AntiAFK = false,
    SpeedHack = false,
    SpeedValue = 16,
    Noclip = false,
    InnocentESP = {names = false, boxes = false, tracers = false, distance = false, boxType = "2D"},
    MurderESP = {names = false, boxes = false, tracers = false, distance = false, boxType = "2D"},
    HeroSheriffESP = {names = false, boxes = false, tracers = false, distance = false, boxType = "2D"},
    InnocentHighlights = false,
    MurderHighlights = false,
    SheriffHeroHighlights = false
}

local function IsAlive(Player, currentRoles)
    for i, v in pairs(currentRoles) do
        if Player.Name == i then
            if not v.Killed and not v.Dead then
                return true
            else
                return false
            end
        end
    end
    return false
end

local function getOutlineColor(c)
    local lum = 0.299 * c.R + 0.587 * c.G + 0.114 * c.B
    if lum > 0.5 then
        return Color3.new(0,0,0)
    else
        return Color3.new(1,1,1)
    end
end

FeatureSection = Window:Section({ Title = "Features", Opened = true })

Tabs = {
    Main = FeatureSection:Tab({ Title = "Main", Icon = "layout-grid" }),
    Player = FeatureSection:Tab({ Title = "Player", Icon = "user" }),
    Garden = FeatureSection:Tab({ Title = "Garden", Icon = "fence" }),
    Visuals = FeatureSection:Tab({ Title = "Visuals", Icon = "camera" }),
    Esp = FeatureSection:Tab({ Title = "Esp", Icon = "eye" }),
    Teleport = FeatureSection:Tab({ Title = "Teleport", Icon = "navigation" }),
    Misc = FeatureSection:Tab({ Title = "Misc", Icon = "star" }),
    Utility = FeatureSection:Tab({ Title = "Utility", Icon = "wrench" }),
    Shop = FeatureSection:Tab({ Title = "Shop", Icon = "shopping-cart" }),
    Settings = FeatureSection:Tab({ Title = "Settings", Icon = "settings" }),
    Info = FeatureSection:Tab({ Title = "Info", Icon = "info" }),
}

Tabs.Main:Section({ Title = "Server Info", TextSize = 20 })
Tabs.Main:Divider()

placeName = "Unknown"
success, productInfo = pcall(function()
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
        serverLink = string.format("https://www.roblox.com/games/start?placeId=%d&jobId=%s", placeId, jobId)
        pcall(function()
            setclipboard(serverLink)
        end)
    end
})

numPlayers = #Players:GetPlayers()
maxPlayers = Players.MaxPlayers

playerCountParagraph = Tabs.Main:Paragraph({
    Title = "Current Players",
    Desc = numPlayers .. " / " .. maxPlayers
})

RunService.Heartbeat:Connect(function()
    local modelCount = 0
    
    for _, player in ipairs(Players:GetPlayers()) do
        if workspace:FindFirstChild(player.Name) then
            modelCount = modelCount + 1
        end
    end
    
    playerCountParagraph:SetDesc(numPlayers .. " Online/ " .. maxPlayers .. "Max | Player Models Found: " .. modelCount .. "")
end)
ModelPlayerAntiBrokenServer = Tabs.Main:Paragraph({
    Title = "Player Model Server Status",
    Desc = "Waiting..."
})

playerModelCheckConnection = RunService.Heartbeat:Connect(function()
    local playerCount = #Players:GetPlayers()
    local modelCount = 0
    
    for _, player in ipairs(Players:GetPlayers()) do
        if workspace:FindFirstChild(player.Name) then
            modelCount = modelCount + 1
        end
    end
    
    if playerCount == modelCount then
        ModelPlayerAntiBrokenServer:SetDesc("Player Model Is Correct Definitely Playable")
    else
        ModelPlayerAntiBrokenServer:SetDesc("Unplayable Server Detected! Missing Player Model, Find a new server")
    end
end)
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
        TeleportService:Teleport(game.PlaceId, player)
    end
})

Tabs.Main:Button({
    Title = "Server Hop",
    Desc = "Hop to a random server",
    Icon = "shuffle",
    Callback = function()
        AllIDs = {}
        foundAnything = ""
        actualHour = os.date("!*t").hour
        Deleted = false
        S_T = game:GetService("TeleportService")
        S_H = game:GetService("HttpService")

        File = pcall(function()
            AllIDs = S_H:JSONDecode(readfile("server-hop-temp.json"))
        end)
        if not File then
            table.insert(AllIDs, actualHour)
            pcall(function()
                writefile("server-hop-temp.json", S_H:JSONEncode(AllIDs))
            end)
        end

        function TPReturner(placeId)
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

        function Teleport(placeId)
            while wait() do
                pcall(function()
                    TPReturner(placeId)
                    if foundAnything ~= "" then
                        TPReturner(placeId)
                    end
                end)
            end
        end

        Teleport(game.PlaceId)
    end
})

Tabs.Main:Button({
    Title = "Hop to Small Server",
    Desc = "Hop to the smallest available server",
    Icon = "minimize",
    Callback = function()
        request = request or (http and http.request) or (syn and syn.request)
        if not request then
            return
        end

        response = request({
            Url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100",
            Method = "GET",
        })

        if response.StatusCode == 200 then
            serverData = HttpService:JSONDecode(response.Body)
            smallestServer = nil
            smallestPlayerCount = math.huge

            for _, server in pairs(serverData.data) do
                if server.id ~= jobId and server.playing < server.maxPlayers and server.playing < smallestPlayerCount then
                    smallestPlayerCount = server.playing
                    smallestServer = server
                end
            end

            if smallestServer then
                TeleportService:TeleportToPlaceInstance(placeId, smallestServer.id, player)
            end
        end
    end
})

Tabs.Main:Button({
    Title = "Advanced Server Hop",
    Desc = "Finding a Server inside your game",
    Icon = "server",
    Callback = function()
        success, result = pcall(function()
            script = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Advanced%20Server%20Hop.lua"))()
        end)
    end
})

Tabs.Player:Section({ Title = "Player", TextSize = 40 })
Tabs.Player:Divider()

character = nil
humanoid = nil
rootPart = nil

function onCharacterAdded(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid", 5)
    rootPart = character:WaitForChild("HumanoidRootPart", 5)
    if featureStates.JumpBoost and humanoid then
        humanoid.JumpPower = featureStates.JumpPower
        humanoid.JumpHeight = featureStates.JumpPower
        setupJumpBoost()
    end
    if featureStates.SpeedHack and humanoid then
        humanoid.WalkSpeed = featureStates.SpeedValue
    end
end

player.CharacterAdded:Connect(onCharacterAdded)
if player.Character then
    onCharacterAdded(player.Character)
end

UserInputService.JumpRequest:connect(function()
    if featureStates.InfiniteJump then
        player.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
    end
end)

InfiniteJumpToggle = Tabs.Player:Toggle({
    Title = "Infinite Jump",
        Flag = "InfiniteJumpToggle",
    Value = featureStates.InfiniteJump,
    Callback = function(state)
        featureStates.InfiniteJump = state
    end
})

SpeedToggle = Tabs.Player:Toggle({
    Title = "Speed Hack",
        Flag = "SpeedToggle",
    Value = featureStates.SpeedHack,
    Callback = function(state)
        featureStates.SpeedHack = state
        if state and humanoid then
            humanoid.WalkSpeed = featureStates.SpeedValue
        elseif humanoid then
            humanoid.WalkSpeed = 16
        end
    end
})

SpeedSlider = Tabs.Player:Slider({
    Title = "Speed Value",
        Flag = "SpeedSlider",
    Desc = "Adjust walk speed",
    Value = { Min = 16, Max = 200, Default = featureStates.SpeedValue, Step = 1 },
    Callback = function(value)
        featureStates.SpeedValue = value
        if featureStates.SpeedHack and humanoid then
            humanoid.WalkSpeed = value
        end
    end
})

Noclip = nil
Clip = nil

function noclip()
    Clip = false
    local function Nocl()
        if Clip == false and player.Character ~= nil then
            for _,v in pairs(player.Character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide then
                    v.CanCollide = false
                end
            end
        end
        wait(0.21)
    end
    Noclip = RunService.Stepped:Connect(Nocl)
end

function clip()
    if Noclip then 
        Noclip:Disconnect() 
    end
    Clip = true
    if player.Character then
        for _,v in pairs(player.Character:GetDescendants()) do
            if v:IsA('BasePart') then
                v.CanCollide = true
            end
        end
    end
end

NoclipToggle = Tabs.Player:Toggle({
    Title = "Noclip",
        Flag = "NoclipToggle",
    Value = featureStates.Noclip,
    Callback = function(state)
        featureStates.Noclip = state
        if state then
            noclip()
        else
            clip()
        end
    end
})

flying = false
bodyVelocity = nil
bodyGyro = nil
flyConnection = nil

function startFlying()
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

function stopFlying()
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

function updateFly()
    if not flying or not bodyVelocity or not bodyGyro then return end
    camera = workspace.CurrentCamera
    cameraCFrame = camera.CFrame
    direction = Vector3.new(0, 0, 0)
    moveDirection = humanoid.MoveDirection
    if moveDirection.Magnitude > 0 then
        forwardVector = cameraCFrame.LookVector
        rightVector = cameraCFrame.RightVector
        forwardComponent = moveDirection:Dot(forwardVector) * forwardVector
        rightComponent = moveDirection:Dot(rightVector) * rightVector
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

FlyToggle = Tabs.Player:Toggle({
    Title = "Fly",
        Flag = "FlyToggle",
    Value = featureStates.Fly,
    Callback = function(state)
        featureStates.Fly = state
        if state then
            startFlying()
            flyConnection = RunService.Heartbeat:Connect(updateFly)
        else
            stopFlying()
            if flyConnection then
                flyConnection:Disconnect()
                flyConnection = nil
            end
        end
    end
})

FlySpeedSlider = Tabs.Player:Slider({
    Title = "Fly Speed",
        Flag = "FlySpeedSlider",
    Value = { Min = 1, Max = 200, Default = featureStates.FlySpeed, Step = 1 },
    Desc = "Adjust fly speed",
    Callback = function(value)
        featureStates.FlySpeed = value
    end
})
ToggleTpwalk = false
TpwalkConnection = nil

function Tpwalking()
    if ToggleTpwalk and character and humanoid and rootPart then
        moveDirection = humanoid.MoveDirection
        moveDistance = featureStates.TpwalkValue
        origin = rootPart.Position
        direction = moveDirection * moveDistance
        targetPosition = origin + direction
        raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {character}
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastResult = workspace:Raycast(origin, direction, raycastParams)
        if raycastResult then
            hitPosition = raycastResult.Position
            distanceToHit = (hitPosition - origin).Magnitude
            if distanceToHit < math.abs(moveDistance) then
                targetPosition = origin + (direction.Unit * (distanceToHit - 0.1))
            end
        end
        rootPart.CFrame = CFrame.new(targetPosition) * rootPart.CFrame.Rotation
        rootPart.CanCollide = true
    end
end

function startTpwalk()
    ToggleTpwalk = true
    if TpwalkConnection then
        TpwalkConnection:Disconnect()
    end
    TpwalkConnection = RunService.Heartbeat:Connect(Tpwalking)
end

function stopTpwalk()
    ToggleTpwalk = false
    if TpwalkConnection then
        TpwalkConnection:Disconnect()
        TpwalkConnection = nil
    end
    if rootPart then
        rootPart.CanCollide = false
    end
end

TPWALKToggle = Tabs.Player:Toggle({
    Title = "TP WALK",
        Flag = "TPWALKToggle",
    Value = featureStates.TPWALK,
    Callback = function(state)
        featureStates.TPWALK = state
        if state then
            startTpwalk()
        else
            stopTpwalk()
        end
    end
})

TPWALKSlider = Tabs.Player:Slider({
    Title = "TPWALK VALUE",
        Flag = "TPWALKSlider",
    Desc = "Adjust TPWALK speed",
    Value = { Min = 1, Max = 200, Default = featureStates.TpwalkValue, Step = 1 },
    Callback = function(value)
        featureStates.TpwalkValue = value
    end
})

jumpCount = 0
MAX_JUMPS = math.huge

function setupJumpBoost()
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

function startJumpBoost()
    if humanoid then
        humanoid.JumpPower = featureStates.JumpPower
        humanoid.JumpHeight = featureStates.JumpPower
    end
    setupJumpBoost()
end

function stopJumpBoost()
    jumpCount = 0
    if humanoid then
        humanoid.JumpPower = 50
        humanoid.JumpHeight = 50
    end
end

JumpBoostToggle = Tabs.Player:Toggle({
    Title = "Jump Height",
        Flag = "JumpBoostToggle",
    Value = featureStates.JumpBoost,
    Callback = function(state)
        featureStates.JumpBoost = state
        if state then
            startJumpBoost()
        else
            stopJumpBoost()
        end
    end
})

JumpBoostSlider = Tabs.Player:Slider({
    Title = "Jump Power",
        Flag = "JumpBoostSlider",
    Desc = "Adjust jump height",
    Value = { Min = 1, Max = 200, Default = featureStates.JumpPower, Step = 1 },
    Callback = function(value)
        featureStates.JumpPower = value
        if featureStates.JumpBoost then
            if humanoid then
                humanoid.JumpPower = featureStates.JumpPower
                humanoid.JumpHeight = featureStates.JumpPower
            end
        end
    end
})
Tabs.Garden:Section({ Title = "Auto Plant", TextSize = 20 })
plantEnabled = false
plantTask = nil
selectedSeeds = {}
plantMode = "Random"
savedPosition = Vector3.new(0, 0, 0)
autoEquipSeed = true
plantDelay = 0.1

Players = game:GetService("Players")
ReplicatedStorage = game:GetService("ReplicatedStorage")
Player = Players.LocalPlayer
Character = Player.Character or Player.CharacterAdded:Wait()
Backpack = Player.Backpack
GameEvents = ReplicatedStorage.GameEvents
Plant_RE = GameEvents.Plant_RE

seedDataModule = game:GetService("ReplicatedStorage"):WaitForChild("Data"):WaitForChild("SeedData")

loadSeedNames = function()
    dropdownItems = {}
    
    success, seedData = pcall(require, seedDataModule)
    
    if success then
        seedsList = {}
        
        for seedName, seedInfo in pairs(seedData) do
            if seedInfo.SeedName then
                table.insert(seedsList, {
                    Name = seedName,
                    DisplayName = seedInfo.SeedName,
                    Icon = seedInfo.FruitIcon or seedInfo.Asset or ""
                })
            end
        end
        
        table.sort(seedsList, function(a, b)
            return a.DisplayName < b.DisplayName
        end)
        
        for _, seed in ipairs(seedsList) do
            table.insert(dropdownItems, {
                Title = seed.DisplayName,
                Icon = seed.Icon,
                Desc = seed.Name,
                Value = seed.Name
            })
        end
    end
    
    return dropdownItems
end

getEquippedSeed = function()
    if #selectedSeeds == 0 then
        for _, container in ipairs({Character, Backpack}) do
            for _, tool in ipairs(container:GetChildren()) do
                if tool:IsA("Tool") then
                    itemType = tool:GetAttribute("ItemType")
                    seedName = tool:GetAttribute("ItemName") or tool:GetAttribute("Seed") or tool.Name
                    
                    if (itemType and itemType == "Seed") or tool.Name:find("Seed") then
                        return tool, seedName
                    end
                end
            end
        end
    else
        for _, container in ipairs({Character, Backpack}) do
            for _, tool in ipairs(container:GetChildren()) do
                if tool:IsA("Tool") then
                    itemType = tool:GetAttribute("ItemType")
                    seedName = tool:GetAttribute("ItemName") or tool:GetAttribute("Seed") or tool.Name
                    
                    if (itemType and itemType == "Seed") or tool.Name:find("Seed") then
                        for _, selected in ipairs(selectedSeeds) do
                            if seedName == selected then
                                return tool, seedName
                            end
                        end
                    end
                end
            end
        end
    end
    return nil, nil
end

equipSeed = function(tool)
    if tool and autoEquipSeed then
        humanoid = Character:FindFirstChildOfClass("Humanoid")
        if humanoid and tool.Parent == Backpack then
            humanoid:EquipTool(tool)
            task.wait(0.1)
        end
    end
end

getPlantingPosition = function()
    if not Character then return Vector3.new(0, 4, 0) end
    
    if plantMode == "Under player" then
        hrp = Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            return hrp.Position + Vector3.new(0, -2, 0)
        end
        return Vector3.new(0, 4, 0)
        
    elseif plantMode == "Saved Position" then
        return savedPosition
        
    elseif plantMode == "Random" then
        hrp = Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            basePos = hrp.Position
            offsetX = math.random(-20, 20)
            offsetZ = math.random(-20, 20)
            return basePos + Vector3.new(offsetX, -2, offsetZ)
        end
        return Vector3.new(math.random(-50, 50), 4, math.random(-50, 50))
    end
    
    return Vector3.new(0, 4, 0)
end

plantSeed = function()
    if not Plant_RE then return false end
    
    tool, seedName = getEquippedSeed()
    if not tool then return false end
    
    equipSeed(tool)
    
    position = getPlantingPosition()
    
    success = pcall(function()
        Plant_RE:FireServer(position, seedName)
    end)
    
    return success
end

startAutoPlant = function()
    plantTask = task.spawn(function()
        while plantEnabled do
            plantSeed()
            task.wait(plantDelay)
            
            for i = 1, 5 do
                if not plantEnabled then break end
                plantSeed()
            end
            task.wait(0.05)
        end
    end)
end

seedDropdown = Tabs.Garden:Dropdown({
    Title = "Select Seed",
    Desc = "Select multiple seeds or leave empty for all",
    Values = loadSeedNames(),
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(options)
        selectedSeeds = {}
        for _, option in ipairs(options) do
            if option.Value then
                table.insert(selectedSeeds, option.Value)
            end
        end
    end
})

modeDropdown = Tabs.Garden:Dropdown({
    Title = "Select Mode",
    Values = {
        {Title = "Random", Icon = "shuffle", Value = "Random"},
        {Title = "Under player", Icon = "user", Value = "Under player"},
        {Title = "Saved Position", Icon = "save", Value = "Saved Position"}
    },
    Value = {Title = "Random", Icon = "shuffle", Value = "Random"},
    Callback = function(option)
        plantMode = option.Value
    end
})

Tabs.Garden:Button({
    Title = "Save current Position",
    Callback = function()
        hrp = Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            savedPosition = hrp.Position + Vector3.new(0, -2, 0)
        end
    end
})

Tabs.Garden:Button({
    Title = "Clear Saved Position",
    Callback = function()
        savedPosition = Vector3.new(0, 0, 0)
    end
})

autoEquipToggle = Tabs.Garden:Toggle({
    Title = "Auto Equip Seed",
    Value = true,
    Callback = function(state)
        autoEquipSeed = state
    end
})

autoPlantToggle = Tabs.Garden:Toggle({
    Title = "Auto Plant",
    Value = false,
    Callback = function(state)
        plantEnabled = state
        
        if state then
            startAutoPlant()
        elseif plantTask then
            task.cancel(plantTask)
            plantTask = nil
        end
    end
})

delaySlider = Tabs.Garden:Slider({
    Title = "Auto plant Delay",
    Step = 0.001,
    Value = {Min = 0.001, Max = 2, Default = 0.1},
    Callback = function(value)
        plantDelay = value
    end
})
Tabs.Visuals:Section({ Title = "Visual", TextSize = 20 })
    Tabs.Visuals:Divider()
    local cameraStretchConnection
local function setupCameraStretch()
    cameraStretchConnection = nil
    local stretchHorizontal = 0.80
    local stretchVertical = 0.80
    CameraStretchToggle = Tabs.Visuals:Toggle({
        Title = "Camera Stretch",
        Flag = "CameraStretchToggle",
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

    CameraStretchHorizontalInput = Tabs.Visuals:Input({
        Title = "Camera Stretch Horizontal",
        Flag = "CameraStretchHorizontalInput",
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

    CameraStretchVerticalInput = Tabs.Visuals:Input({
        Title = "Camera Stretch Vertical",
        Flag = "CameraStretchVerticalInput",
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
	    FullBrightToggle = Tabs.Visuals:Toggle({
    Title = "Full Bright",
        Flag = "FullBrightToggle",
    Desc = "Ya Like drinking Night Vision while mining in da cave and sceard of creeper blow you up dawg?",
    Value = false,
    Callback = function(state)
        featureStates.FullBright = state
        if state then
            local Lighting = game:GetService("Lighting")
            
            featureStates.originalBrightness = Lighting.Brightness
            featureStates.originalAmbient = Lighting.Ambient
            featureStates.originalOutdoorAmbient = Lighting.OutdoorAmbient
            featureStates.originalColorShiftBottom = Lighting.ColorShift_Bottom
            featureStates.originalColorShiftTop = Lighting.ColorShift_Top
            
            local function applyFullBright()
                if Lighting.Brightness ~= 1 then
                    Lighting.Brightness = 1
                end
                if Lighting.Ambient ~= Color3.new(1, 1, 1) then
                    Lighting.Ambient = Color3.new(1, 1, 1)
                end
                if Lighting.OutdoorAmbient ~= Color3.new(1, 1, 1) then
                    Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
                end
                if Lighting.ColorShift_Bottom ~= Color3.new(1, 1, 1) then
                    Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
                end
                if Lighting.ColorShift_Top ~= Color3.new(1, 1, 1) then
                    Lighting.ColorShift_Top = Color3.new(1, 1, 1)
                end
            end
            
            applyFullBright()
            
            if featureStates.fullBrightConnection then
                featureStates.fullBrightConnection:Disconnect()
            end
            
            featureStates.fullBrightConnection = RunService.Heartbeat:Connect(function()
                if featureStates.FullBright then
                    applyFullBright()
                end
            end)
            
            featureStates.fullBrightCharConnection = game.Players.LocalPlayer.CharacterAdded:Connect(function()
                task.wait(1)
                if featureStates.FullBright then
                    applyFullBright()
                end
            end)
            
        else
            if featureStates.fullBrightConnection then
                featureStates.fullBrightConnection:Disconnect()
                featureStates.fullBrightConnection = nil
            end
            
            if featureStates.fullBrightCharConnection then
                featureStates.fullBrightCharConnection:Disconnect()
                featureStates.fullBrightCharConnection = nil
            end
            
            if featureStates.originalBrightness then
                local Lighting = game:GetService("Lighting")
                Lighting.Brightness = featureStates.originalBrightness
                Lighting.Ambient = featureStates.originalAmbient
                Lighting.OutdoorAmbient = featureStates.originalOutdoorAmbient
                Lighting.ColorShift_Bottom = featureStates.originalColorShiftBottom
                Lighting.ColorShift_Top = featureStates.originalColorShiftTop
            end
        end
    end
})
local FOVSlider = Tabs.Visuals:Slider({
    Title = "Field of View",
        Flag = "FOVSlider",
    Value = { Min = 1, Max = 120, Default = originalFOV, Step = 1 },
    Callback = function(value)
        workspace.CurrentCamera.FieldOfView = tonumber(value)
    end
})
setupCameraStretch()
innocentEspElements = {}
murderEspElements = {}
sheriffEspElements = {}
coinEspElements = {}
gunEspElements = {}

playerEspConnection = nil
roleUpdateConnection = nil
roleData = {}
lastRoleUpdate = 0
roleUpdating = false
HighlightsConnection = nil
coinEspConnection = nil
gunEspConnection = nil

local getPlayerDataRemote = ReplicatedStorage:FindFirstChild("GetPlayerData", true)

featureStates.CoinESP = featureStates.CoinESP or {
    names = false,
    boxes = false,
    tracers = false,
    distance = false,
    boxType = "3D"
}

featureStates.GunESP = featureStates.GunESP or {
    names = false,
    boxes = false,
    tracers = false,
    distance = false,
    boxType = "3D"
}

featureStates.CoinHighlights = featureStates.CoinHighlights or false
featureStates.GunHighlights = featureStates.GunHighlights or false

local lastCoinSearch = 0
local lastGunSearch = 0
local coinCache = {}
local gunCache = {}
local cachedPlayers = {}
local lastPlayerCacheUpdate = 0

function isAnyRoleESPActive()
    local roles = {"InnocentESP", "MurderESP", "HeroSheriffESP", "CoinESP", "GunESP"}
    for _, role in ipairs(roles) do
        local states = featureStates[role]
        if states and (states.names or states.boxes or states.tracers or states.distance) then
            return true
        end
    end
    return false
end

local function checkAnyHighlights()
    return featureStates.InnocentHighlights or featureStates.MurderHighlights or featureStates.SheriffHeroHighlights or featureStates.CoinHighlights or featureStates.GunHighlights
end

function isAnyRoleNeeded()
    return isAnyRoleESPActive() or checkAnyHighlights()
end

function startRoleUpdating()
    if roleUpdating then return end
    roleUpdating = true
    updateRoles()
    roleUpdateConnection = RunService.Heartbeat:Connect(function()
        updateRoles()
    end)
end

function stopRoleUpdating()
    if roleUpdateConnection then
        roleUpdateConnection:Disconnect()
        roleUpdateConnection = nil
    end
    roleUpdating = false
    roleData = {}
end

function manageRoleUpdating()
    if isAnyRoleNeeded() then
        startRoleUpdating()
    else
        stopRoleUpdating()
    end
end

function updateRoles()
    if not getPlayerDataRemote then return end
    if tick() - lastRoleUpdate < 2 then return end
    lastRoleUpdate = tick()
    local success, roles = pcall(function()
        return getPlayerDataRemote:InvokeServer()
    end)
    if success and roles then
        roleData = {}
        for key, v in pairs(roles) do
            if v then
                roleData[key] = v
            end
        end
        refreshHighlights()
    end
end

function managePlayerESPConnection()
    local active = isAnyRoleESPActive()
    if active then
        if not playerEspConnection then
            playerEspConnection = RunService.RenderStepped:Connect(updateRoleESP)
        end
    else
        if playerEspConnection then
            playerEspConnection:Disconnect()
            playerEspConnection = nil
        end
    end
    manageRoleUpdating()
end

function manageHighlightsConnection()
    if checkAnyHighlights() then
        startHighlights()
    else
        stopHighlights()
    end
end

function manageCoinESPConnection()
    local coinActive = featureStates.CoinESP.names or featureStates.CoinESP.boxes or featureStates.CoinESP.tracers or featureStates.CoinESP.distance
    if coinActive then
        if not coinEspConnection then
            coinEspConnection = RunService.RenderStepped:Connect(updateCoinESP)
        end
    else
        if coinEspConnection then
            coinEspConnection:Disconnect()
            coinEspConnection = nil
            cleanupCoinElements()
        end
    end
end

function manageGunESPConnection()
    local gunActive = featureStates.GunESP.names or featureStates.GunESP.boxes or featureStates.GunESP.tracers or featureStates.GunESP.distance
    if gunActive then
        if not gunEspConnection then
            gunEspConnection = RunService.RenderStepped:Connect(updateGunESP)
        end
    else
        if gunEspConnection then
            gunEspConnection:Disconnect()
            gunEspConnection = nil
            cleanupGunElements()
        end
    end
end

function cleanupAllRoleElements()
    local elementTables = {innocentEspElements, murderEspElements, sheriffEspElements, coinEspElements, gunEspElements}
    for _, elemTable in ipairs(elementTables) do
        for target, esp in pairs(elemTable) do
            cleanupDrawingTable(esp)
            elemTable[target] = nil
        end
    end
end

function cleanupCoinElements()
    for target, esp in pairs(coinEspElements) do
        cleanupDrawingTable(esp)
        coinEspElements[target] = nil
    end
end

function cleanupGunElements()
    for target, esp in pairs(gunEspElements) do
        cleanupDrawingTable(esp)
        gunEspElements[target] = nil
    end
end

function getDistanceFromPlayer(targetPosition)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return 0 end
    return (targetPosition - player.Character.HumanoidRootPart.Position).Magnitude
end

function cleanupDrawingTable(drawingTable)
    for _, drawing in pairs(drawingTable) do
        if type(drawing) == "table" then
            for _, line in ipairs(drawing) do
                pcall(line.Remove, line)
            end
        else
            pcall(drawing.Remove, drawing)
        end
    end
end

function createESPObject()
    return {
        box = Drawing.new("Square"),
        tracer = Drawing.new("Line"),
        name = Drawing.new("Text"),
        distance = Drawing.new("Text"),
        boxLines = {}
    }
end

function setupESPObject(esp)
    esp.box.Thickness = 2
    esp.box.Filled = false
    esp.tracer.Thickness = 1
    esp.name.Size = 14
    esp.name.Center = true
    esp.name.Outline = true
    esp.distance.Size = 14
    esp.distance.Center = true
    esp.distance.Outline = true
end

function draw3DBox(esp, cf, pos, camera, boxColor, boxSize)
    if not cf or not camera then return end
    
    boxSize = boxSize or Vector3.new(4, 5, 3)
    local size = boxSize
    local offsets = {
        Vector3.new( size.X/2,  size.Y/2,  size.Z/2), Vector3.new( size.X/2,  size.Y/2, -size.Z/2),
        Vector3.new( size.X/2, -size.Y/2,  size.Z/2), Vector3.new( size.X/2, -size.Y/2, -size.Z/2),
        Vector3.new(-size.X/2,  size.Y/2,  size.Z/2), Vector3.new(-size.X/2,  size.Y/2, -size.Z/2),
        Vector3.new(-size.X/2, -size.Y/2,  size.Z/2), Vector3.new(-size.X/2, -size.Y/2, -size.Z/2),
    }
    
    local screenPoints = {}
    local anyPointOnScreen = false

    for i, offset in ipairs(offsets) do
        local success, vec, onScreen = pcall(function()
            local worldPos = cf * CFrame.Angles(0, math.rad(90), 0) * offset
            return camera:WorldToViewportPoint(worldPos)
        end)
        if success then
            screenPoints[i] = {pos = Vector2.new(vec.X, vec.Y), depth = vec.Z, onScreen = onScreen}
            if onScreen and vec.Z > 0 then anyPointOnScreen = true end
        end
    end

    if not esp.boxLines or #esp.boxLines == 0 then
        esp.boxLines = {}
        for i = 1, 12 do
            local line = Drawing.new("Line")
            line.Thickness = 1
            line.ZIndex = 2
            table.insert(esp.boxLines, line)
        end
    end

    local edges = {
        {1, 2}, {1, 3}, {1, 5}, {2, 4}, {2, 6},
        {3, 4}, {3, 7}, {5, 6}, {5, 7}, {4, 8}, {6, 8}, {7, 8}
    }

    local distance = (player.Character and player.Character:FindFirstChild("HumanoidRootPart") and 
        (player.Character.HumanoidRootPart.Position - pos).Magnitude) or 10
    local thickness = math.clamp(3 / (distance / 50), 1, 3)

    for i, edge in ipairs(edges) do
        local line = esp.boxLines[i]
        if line then
            local p1, p2 = screenPoints[edge[1]], screenPoints[edge[2]]
            line.Color = boxColor or Color3.fromRGB(255, 255, 255)
            line.Thickness = thickness
            line.Transparency = 1
            if anyPointOnScreen and p1 and p2 and p1.depth > 0 and p2.depth > 0 then
                line.From = p1.pos
                line.To = p2.pos
                line.Visible = true
            else
                line.Visible = false
            end
        end
    end
end

function getPlayerRole(plr)
    local playerKey = plr.Name
    return roleData[playerKey] and roleData[playerKey].Role
end

function findCoinServerParts()
    if tick() - lastCoinSearch < 3 then
        return coinCache
    end
    
    lastCoinSearch = tick()
    coinCache = {}
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and obj.Name == "Coin_Server" then
            table.insert(coinCache, obj)
        end
    end
    
    return coinCache
end

function findDropGunParts()
    if tick() - lastGunSearch < 3 then
        return gunCache
    end
    
    lastGunSearch = tick()
    gunCache = {}
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and obj.Name == "DropGun" then
            table.insert(gunCache, obj)
        end
    end
    
    return gunCache
end

function getCachedPlayers()
    if tick() - lastPlayerCacheUpdate < 1 then
        return cachedPlayers
    end
    
    lastPlayerCacheUpdate = tick()
    cachedPlayers = Players:GetPlayers()
    return cachedPlayers
end

function updateCoinESP()
    local camera = workspace.CurrentCamera
    if not camera then return end
    
    local screenBottomCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
    local currentCoinTargets = {}
    
    local coins = findCoinServerParts()
    
    for _, coinPart in ipairs(coins) do
        if coinPart and coinPart.Parent then
            currentCoinTargets[coinPart] = true
            
            if not coinEspElements[coinPart] then
                coinEspElements[coinPart] = createESPObject()
                setupESPObject(coinEspElements[coinPart])
            end
            
            local esp = coinEspElements[coinPart]
            local vector, onScreen = camera:WorldToViewportPoint(coinPart.Position)
            
            if onScreen then
                local coinColor = Color3.fromRGB(255, 215, 0)
                local states = featureStates.CoinESP
                
                local topY = camera:WorldToViewportPoint(coinPart.Position + Vector3.new(0, 2, 0)).Y
                local bottomY = camera:WorldToViewportPoint(coinPart.Position - Vector3.new(0, 2, 0)).Y
                local size = math.max(10, (bottomY - topY) / 2)
                
                if states.boxes then
                    if states.boxType == "2D" then
                        esp.box.Visible = true
                        esp.box.Size = Vector2.new(size * 2, size * 2)
                        esp.box.Position = Vector2.new(vector.X - size, vector.Y - size)
                        esp.box.Color = coinColor
                        for _, line in ipairs(esp.boxLines) do line.Visible = false end
                    else
                        esp.box.Visible = false
                        pcall(draw3DBox, esp, coinPart.CFrame, coinPart.Position, camera, coinColor, Vector3.new(3, 3, 3))
                    end
                else
                    esp.box.Visible = false
                    for _, line in ipairs(esp.boxLines) do line.Visible = false end
                end
                
                esp.tracer.Visible = states.tracers
                if states.tracers then
                    esp.tracer.From = screenBottomCenter
                    esp.tracer.To = Vector2.new(vector.X, vector.Y)
                    esp.tracer.Color = coinColor
                end
                
                esp.name.Visible = states.names
                if states.names then
                    esp.name.Text = "Coin"
                    esp.name.Position = Vector2.new(vector.X, vector.Y - size - 15)
                    esp.name.Color = coinColor
                end
                
                esp.distance.Visible = states.distance
                if states.distance then
                    local distance = getDistanceFromPlayer(coinPart.Position)
                    esp.distance.Text = string.format("%.1f", distance)
                    esp.distance.Position = Vector2.new(vector.X, vector.Y + size + 5)
                    esp.distance.Color = coinColor
                end
            else
                esp.box.Visible = false
                esp.tracer.Visible = false
                esp.name.Visible = false
                esp.distance.Visible = false
                for _, line in ipairs(esp.boxLines) do line.Visible = false end
            end
        end
    end
    
    for target, esp in pairs(coinEspElements) do
        if not currentCoinTargets[target] then
            cleanupDrawingTable(esp)
            coinEspElements[target] = nil
        end
    end
end

function updateGunESP()
    local camera = workspace.CurrentCamera
    if not camera then return end
    
    local screenBottomCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
    local currentGunTargets = {}
    
    local guns = findDropGunParts()
    
    for _, gunPart in ipairs(guns) do
        if gunPart and gunPart.Parent then
            currentGunTargets[gunPart] = true
            
            if not gunEspElements[gunPart] then
                gunEspElements[gunPart] = createESPObject()
                setupESPObject(gunEspElements[gunPart])
            end
            
            local esp = gunEspElements[gunPart]
            local vector, onScreen = camera:WorldToViewportPoint(gunPart.Position)
            
            if onScreen then
                local gunColor = Color3.fromRGB(255, 0, 255)
                local states = featureStates.GunESP
                
                local topY = camera:WorldToViewportPoint(gunPart.Position + Vector3.new(0, 2, 0)).Y
                local bottomY = camera:WorldToViewportPoint(gunPart.Position - Vector3.new(0, 2, 0)).Y
                local size = math.max(10, (bottomY - topY) / 2)
                
                if states.boxes then
                    if states.boxType == "2D" then
                        esp.box.Visible = true
                        esp.box.Size = Vector2.new(size * 2, size * 2)
                        esp.box.Position = Vector2.new(vector.X - size, vector.Y - size)
                        esp.box.Color = gunColor
                        for _, line in ipairs(esp.boxLines) do line.Visible = false end
                    else
                        esp.box.Visible = false
                        pcall(draw3DBox, esp, gunPart.CFrame, gunPart.Position, camera, gunColor, Vector3.new(3, 3, 3))
                    end
                else
                    esp.box.Visible = false
                    for _, line in ipairs(esp.boxLines) do line.Visible = false end
                end
                
                esp.tracer.Visible = states.tracers
                if states.tracers then
                    esp.tracer.From = screenBottomCenter
                    esp.tracer.To = Vector2.new(vector.X, vector.Y)
                    esp.tracer.Color = gunColor
                end
                
                esp.name.Visible = states.names
                if states.names then
                    esp.name.Text = "Gun"
                    esp.name.Position = Vector2.new(vector.X, vector.Y - size - 15)
                    esp.name.Color = gunColor
                end
                
                esp.distance.Visible = states.distance
                if states.distance then
                    local distance = getDistanceFromPlayer(gunPart.Position)
                    esp.distance.Text = string.format("%.1f", distance)
                    esp.distance.Position = Vector2.new(vector.X, vector.Y + size + 5)
                    esp.distance.Color = gunColor
                end
            else
                esp.box.Visible = false
                esp.tracer.Visible = false
                esp.name.Visible = false
                esp.distance.Visible = false
                for _, line in ipairs(esp.boxLines) do line.Visible = false end
            end
        end
    end
    
    for target, esp in pairs(gunEspElements) do
        if not currentGunTargets[target] then
            cleanupDrawingTable(esp)
            gunEspElements[target] = nil
        end
    end
end

function updateRoleESP()
    local camera = workspace.CurrentCamera
    if not camera then return end
    
    local screenBottomCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
    local currentInnocentTargets = {}
    local currentMurderTargets = {}
    local currentSheriffTargets = {}

    local players = getCachedPlayers()

    for _, otherPlayer in ipairs(players) do
        if otherPlayer ~= player then
            local model = otherPlayer.Character
            if model then
                local hrp = model:FindFirstChild("HumanoidRootPart")
                local humanoid = model:FindFirstChild("Humanoid")
                if hrp and humanoid then
                    local playerRole = getPlayerRole(otherPlayer)
                    local isDead = humanoid.Health <= 0
                    local espColor, states, elements, currentTargets
                    if isDead then
                        espColor = Color3.fromRGB(255, 255, 255)
                        states = featureStates.InnocentESP
                        elements = innocentEspElements
                        currentTargets = currentInnocentTargets
                    elseif playerRole == "Murderer" then
                        espColor = Color3.fromRGB(255, 0, 0)
                        states = featureStates.MurderESP
                        elements = murderEspElements
                        currentTargets = currentMurderTargets
                    elseif playerRole == "Sheriff" then
                        espColor = Color3.fromRGB(0, 0, 255)
                        states = featureStates.HeroSheriffESP
                        elements = sheriffEspElements
                        currentTargets = currentSheriffTargets
                    elseif playerRole == "Hero" then
                        espColor = Color3.fromRGB(255, 255, 0)
                        states = featureStates.HeroSheriffESP
                        elements = sheriffEspElements
                        currentTargets = currentSheriffTargets
                    else
                        if playerRole == "Innocent" then
                            espColor = Color3.fromRGB(0, 255, 0)
                        else
                            espColor = Color3.fromRGB(255, 255, 255)
                        end
                        states = featureStates.InnocentESP
                        elements = innocentEspElements
                        currentTargets = currentInnocentTargets
                    end
                    local anyActive = states.names or states.boxes or states.tracers or states.distance
                    if anyActive then
                        currentTargets[model] = true
                        if not elements[model] then
                            elements[model] = createESPObject()
                            setupESPObject(elements[model])
                        end
                        local esp = elements[model]
                        local vector, onScreen = camera:WorldToViewportPoint(hrp.Position)
                        if onScreen then
                            local topY = camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0)).Y
                            local bottomY = camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y
                            local size = (bottomY - topY) / 2
                            local boxSize = humanoid and Vector3.new(2, humanoid.HipHeight + 5, 2) or Vector3.new(4, 5, 3)
                            if states.boxes then
                                if states.boxType == "2D" then
                                    esp.box.Visible = true
                                    esp.box.Size = Vector2.new(size * 2, size * 3)
                                    esp.box.Position = Vector2.new(vector.X - size, vector.Y - size * 1.5)
                                    esp.box.Color = espColor
                                    for _, line in ipairs(esp.boxLines) do line.Visible = false end
                                else
                                    esp.box.Visible = false
                                    pcall(draw3DBox, esp, hrp.CFrame, hrp.Position, camera, espColor, boxSize)
                                end
                            else
                                esp.box.Visible = false
                                for _, line in ipairs(esp.boxLines) do line.Visible = false end
                            end
                            esp.tracer.Visible = states.tracers
                            if states.tracers then
                                esp.tracer.From = screenBottomCenter
                                esp.tracer.To = Vector2.new(vector.X, vector.Y)
                                esp.tracer.Color = espColor
                            end
                            esp.name.Visible = states.names
                            if states.names then
                                esp.name.Text = otherPlayer.Name
                                esp.name.Position = Vector2.new(vector.X, vector.Y - size * 1.5 - 20)
                                esp.name.Color = espColor
                            end
                            esp.distance.Visible = states.distance
                            if states.distance then
                                local distance = getDistanceFromPlayer(hrp.Position)
                                esp.distance.Text = string.format("%.1f", distance)
                                esp.distance.Position = Vector2.new(vector.X, vector.Y + size * 1.5 + 5)
                                esp.distance.Color = espColor
                            end
                        else
                            esp.box.Visible = false
                            esp.tracer.Visible = false
                            esp.name.Visible = false
                            esp.distance.Visible = false
                            for _, line in ipairs(esp.boxLines) do line.Visible = false end
                        end
                    end
                end
            end
        end
    end

    for target, esp in pairs(innocentEspElements) do
        if not currentInnocentTargets[target] then
            cleanupDrawingTable(esp)
            innocentEspElements[target] = nil
        end
    end
    for target, esp in pairs(murderEspElements) do
        if not currentMurderTargets[target] then
            cleanupDrawingTable(esp)
            murderEspElements[target] = nil
        end
    end
    for target, esp in pairs(sheriffEspElements) do
        if not currentSheriffTargets[target] then
            cleanupDrawingTable(esp)
            sheriffEspElements[target] = nil
        end
    end
end

function startHighlights()
    if not HighlightsConnection then
        HighlightsConnection = RunService.Heartbeat:Connect(updateRoleHighlights)
    end
end

function stopHighlights()
    if HighlightsConnection then
        HighlightsConnection:Disconnect()
        HighlightsConnection = nil
        clearAllHighlights()
    end
end

function clearAllHighlights()
    for _, plr in pairs(getCachedPlayers()) do
        if plr.Character then
            local highlight = plr.Character:FindFirstChild("PlayerHighlight")
            if highlight then
                highlight:Destroy()
            end
        end
    end
    
    if featureStates.CoinHighlights or featureStates.GunHighlights then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Part") and (obj.Name == "Coin_Server" or obj.Name == "DropGun") then
                local highlight = obj:FindFirstChild("ItemHighlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end

function refreshHighlights()
    if not HighlightsConnection then return end
    clearAllHighlights()
end

function updateRoleHighlights()
    if not roleData then return end

    local sheriffName = nil
    for name, data in pairs(roleData) do
        if data.Role == "Sheriff" then
            sheriffName = name
            break
        end
    end
    local sheriffPlayer = sheriffName and Players:FindFirstChild(sheriffName)
    local isSheriffAlive = sheriffPlayer and IsAlive(sheriffPlayer, roleData)

    local players = getCachedPlayers()

    for _, plr in ipairs(players) do
        if plr ~= player and plr.Character then
            local model = plr.Character
            local highlight = model:FindFirstChild("PlayerHighlight")
            local data = roleData[plr.Name]
            local role = data and data.Role
            local isAlivePlayer = data and IsAlive(plr, roleData)
            local highlightEnabled = false
            if not role then
                highlightEnabled = featureStates.InnocentHighlights
            elseif role == "Murderer" then
                highlightEnabled = featureStates.MurderHighlights
            elseif role == "Sheriff" or role == "Hero" then
                highlightEnabled = featureStates.SheriffHeroHighlights
            else
                highlightEnabled = featureStates.InnocentHighlights
            end
            if highlightEnabled then
                local color
                if not data or not isAlivePlayer then
                    color = Color3.new(1,1,1)
                else
                    if role == "Murderer" then
                        color = Color3.fromRGB(225, 0, 0)
                    elseif role == "Sheriff" then
                        color = Color3.fromRGB(0, 0, 225)
                    elseif role == "Hero" and not isSheriffAlive then
                        color = Color3.fromRGB(255, 250, 0)
                    else
                        color = Color3.fromRGB(0, 225, 0)
                    end
                end
                local outlineColor = getOutlineColor(color)
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "PlayerHighlight"
                    highlight.Adornee = model
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = model
                end
                highlight.FillColor = color
                highlight.OutlineColor = outlineColor
            else
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end

    if featureStates.CoinHighlights then
        local coins = findCoinServerParts()
        for _, coinPart in ipairs(coins) do
            if coinPart and coinPart.Parent then
                local highlight = coinPart:FindFirstChild("ItemHighlight")
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "ItemHighlight"
                    highlight.Adornee = coinPart
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = coinPart
                end
                highlight.FillColor = Color3.fromRGB(255, 215, 0)
                highlight.OutlineColor = getOutlineColor(Color3.fromRGB(255, 215, 0))
            end
        end
    end

    if featureStates.GunHighlights then
        local guns = findDropGunParts()
        for _, gunPart in ipairs(guns) do
            if gunPart and gunPart.Parent then
                local highlight = gunPart:FindFirstChild("ItemHighlight")
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "ItemHighlight"
                    highlight.Adornee = gunPart
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = gunPart
                end
                highlight.FillColor = Color3.fromRGB(255, 0, 255)
                highlight.OutlineColor = getOutlineColor(Color3.fromRGB(255, 0, 255))
            end
        end
    end
end

Players.PlayerRemoving:Connect(function(plr)
    if plr.Character then
        local highlight = plr.Character:FindFirstChild("PlayerHighlight")
        if highlight then
            highlight:Destroy()
        end
    end
end)

coinEspConnection = RunService.RenderStepped:Connect(updateCoinESP)
gunEspConnection = RunService.RenderStepped:Connect(updateGunESP)
local xRay = false
Tabs.Visuals:Toggle({
    Title = "X-ray Vision",
    Compact = true,
    Callback = function(state)
        xRay = state
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part:IsDescendantOf(LocalPlayer.Character) then
                part.LocalTransparencyModifier = state and 0.7 or 0
            end
        end
    end
})
Tabs.Visuals:Button({
    Title = "Shit Render", 
    Callback = function()
        Lighting = game:GetService("Lighting")
        Terrain = workspace:FindFirstChildOfClass("Terrain")
        Players = game:GetService("Players")
        LocalPlayer = Players.LocalPlayer

        Lighting.GlobalShadows = false
        Lighting.FogEnd = 1e10
        Lighting.Brightness = 1

        if Terrain then
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 1
        end

        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj:Destroy()
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                obj:Destroy()
            elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                obj:Destroy()
            end
        end

        for _, player in ipairs(Players:GetPlayers()) do
            local char = player.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("Accessory") or part:IsA("Clothing") then
                        part:Destroy()
                    end
                end
            end
        end
    end
})
local function spawnWeapon(name)
    local DataBase, PlayerData = require(game:GetService("ReplicatedStorage").Database.Sync.Item),
                                  require(game:GetService("ReplicatedStorage").Modules.ProfileData)
    local newOwned = {}
    newOwned[name] = 1
    local PlayerWeapons = PlayerData.Weapons
    game:GetService("RunService"):BindToRenderStep("InventoryUpdate", 0, function()
        PlayerWeapons.Owned = newOwned
    end)
    game.Players.LocalPlayer.Character:BreakJoints()
end
Tabs.Esp:Section({ Title = "Innocent ESP" })

InnocentNameESPToggle = Tabs.Esp:Toggle({
    Title = "Innocent Name ESP",
        Flag = "InnocentNameESPToggle",
    Value = false,
    Callback = function(state)
        featureStates.InnocentESP.names = state
        managePlayerESPConnection()
    end
})

InnocentBoxESPToggle = Tabs.Esp:Toggle({
    Title = "Innocent Box ESP",
        Flag = "InnocentBoxESPToggle",
    Value = false,
    Callback = function(state)
        featureStates.InnocentESP.boxes = state
        managePlayerESPConnection()
    end
})

InnocentBoxTypeDropdown = Tabs.Esp:Dropdown({
    Title = "Innocent Box Type",
        Flag = "InnocentBoxTypeDropdown",
    Values = {"2D", "3D"},
    Value = "2D",
    Callback = function(value)
        featureStates.InnocentESP.boxType = value
    end
})

InnocentTracerToggle = Tabs.Esp:Toggle({
    Title = "Innocent Tracer",
        Flag = "InnocentTracerToggle",
    Value = false,
    Callback = function(state)
        featureStates.InnocentESP.tracers = state
        managePlayerESPConnection()
    end
})

InnocentDistanceESPToggle = Tabs.Esp:Toggle({
    Title = "Innocent Distance ESP",
        Flag = "InnocentDistanceESPToggle",
    Value = false,
    Callback = function(state)
        featureStates.InnocentESP.distance = state
        managePlayerESPConnection()
    end
})

InnocentHighlightsToggle = Tabs.Esp:Toggle({
    Title = "Innocent Highlights",
        Flag = "InnocentHighlightsToggle",
    Value = false,
    Callback = function(state)
        featureStates.InnocentHighlights = state
        manageHighlightsConnection()
        refreshHighlights()
    end
})

Tabs.Esp:Section({ Title = "Murder ESP" })

MurderNameESPToggle = Tabs.Esp:Toggle({
    Title = "Murder Name ESP",
        Flag = "MurderNameESPToggle",
    Value = false,
    Callback = function(state)
        featureStates.MurderESP.names = state
        managePlayerESPConnection()
    end
})

MurderBoxESPToggle = Tabs.Esp:Toggle({
    Title = "Murder Box ESP",
        Flag = "MurderBoxESPToggle",
    Value = false,
    Callback = function(state)
        featureStates.MurderESP.boxes = state
        managePlayerESPConnection()
    end
})

MurderBoxTypeDropdown = Tabs.Esp:Dropdown({
    Title = "Murder Box Type",
        Flag = "MurderBoxTypeDropdown",
    Values = {"2D", "3D"},
    Value = "2D",
    Callback = function(value)
        featureStates.MurderESP.boxType = value
    end
})

MurderTracerToggle = Tabs.Esp:Toggle({
    Title = "Murder Tracer",
        Flag = "MurderTracerToggle",
    Value = false,
    Callback = function(state)
        featureStates.MurderESP.tracers = state
        managePlayerESPConnection()
    end
})

MurderDistanceESPToggle = Tabs.Esp:Toggle({
    Title = "Murder Distance ESP",
        Flag = "MurderDistanceESPToggle",
    Value = false,
    Callback = function(state)
        featureStates.MurderESP.distance = state
        managePlayerESPConnection()
    end
})

MurderHighlightsToggle = Tabs.Esp:Toggle({
    Title = "Murder Highlights",
        Flag = "MurderHighlightsToggle",
    Value = false,
    Callback = function(state)
        featureStates.MurderHighlights = state
        manageHighlightsConnection()
        refreshHighlights()
    end
})

Tabs.Esp:Section({ Title = "Hero/Sheriff ESP" })

HeroSheriffNameESPToggle = Tabs.Esp:Toggle({
    Title = "Hero/Sheriff Name ESP",
        Flag = "HeroSheriffNameESPToggle",
    Value = false,
    Callback = function(state)
        featureStates.HeroSheriffESP.names = state
        managePlayerESPConnection()
    end
})

HeroSheriffBoxESPToggle = Tabs.Esp:Toggle({
    Title = "Hero/Sheriff Box ESP",
        Flag = "HeroSheriffBoxESPToggle",
    Value = false,
    Callback = function(state)
        featureStates.HeroSheriffESP.boxes = state
        managePlayerESPConnection()
    end
})

HeroSheriffBoxTypeDropdown = Tabs.Esp:Dropdown({
    Title = "Hero/Sheriff Box Type",
        Flag = "HeroSheriffBoxTypeDropdown",
    Values = {"2D", "3D"},
    Value = "2D",
    Callback = function(value)
        featureStates.HeroSheriffESP.boxType = value
    end
})

HeroSheriffTracerToggle = Tabs.Esp:Toggle({
    Title = "Hero/Sheriff Tracer",
        Flag = "HeroSheriffTracerToggle",
    Value = false,
    Callback = function(state)
        featureStates.HeroSheriffESP.tracers = state
        managePlayerESPConnection()
    end
})

HeroSheriffDistanceESPToggle = Tabs.Esp:Toggle({
    Title = "Hero/Sheriff Distance ESP",
        Flag = "HeroSheriffDistanceESPToggle",
    Value = false,
    Callback = function(state)
        featureStates.HeroSheriffESP.distance = state
        managePlayerESPConnection()
    end
})

SheriffHeroHighlightsToggle = Tabs.Esp:Toggle({
    Title = "Sheriff/Hero Highlights",
        Flag = "SheriffHeroHighlightsToggle",
    Value = false,
    Callback = function(state)
        featureStates.SheriffHeroHighlights = state
        manageHighlightsConnection()
        refreshHighlights()
    end
})
Tabs.Esp:Section({ Title = "Gun ESP" })

GunNameESPToggle = Tabs.Esp:Toggle({
    Title = "Gun ESP",
        Flag = "GunNameESPToggle",
    Value = false,
    Callback = function(state)
        featureStates.GunESP.names = state
        manageGunESPConnection()
    end
})

GunBoxESPToggle = Tabs.Esp:Toggle({
    Title = "Gun Box ESP",
        Flag = "GunBoxESPToggle",
    Value = false,
    Callback = function(state)
        featureStates.GunESP.boxes = state
        manageGunESPConnection()
    end
})

GunBoxTypeDropdown = Tabs.Esp:Dropdown({
    Title = "Gun Box Type",
        Flag = "GunBoxTypeDropdown",
    Values = {"2D", "3D"},
    Value = "3D",
    Callback = function(value)
        featureStates.GunESP.boxType = value
    end
})

GunTracerToggle = Tabs.Esp:Toggle({
    Title = "Gun Tracer",
        Flag = "GunTracerToggle",
    Value = false,
    Callback = function(state)
        featureStates.GunESP.tracers = state
        manageGunESPConnection()
    end
})

GunDistanceESPToggle = Tabs.Esp:Toggle({
    Title = "Gun Distance ESP",
        Flag = "GunDistanceESPToggle",
    Value = false,
    Callback = function(state)
        featureStates.GunESP.distance = state
        manageGunESPConnection()
    end
})

GunHighlightsToggle = Tabs.Esp:Toggle({
    Title = "Gun Highlights",
        Flag = "GunHighlightsToggle",
    Value = false,
    Callback = function(state)
        featureStates.GunHighlights = state
        manageHighlightsConnection()
        refreshHighlights()
    end
})
Tabs.Esp:Section({ Title = "Coin ESP" })

CoinNameESPToggle = Tabs.Esp:Toggle({
    Title = "Coin ESP",
        Flag = "CoinNameESPToggle",
    Value = false,
    Callback = function(state)
        featureStates.CoinESP.names = state
        manageCoinESPConnection()
    end
})

CoinBoxESPToggle = Tabs.Esp:Toggle({
    Title = "Coin Box ESP",
        Flag = "CoinBoxESPToggle",
    Value = false,
    Callback = function(state)
        featureStates.CoinESP.boxes = state
        manageCoinESPConnection()
    end
})

CoinBoxTypeDropdown = Tabs.Esp:Dropdown({
    Title = "Coin Box Type",
        Flag = "CoinBoxTypeDropdown",
    Values = {"2D", "3D"},
    Value = "3D",
    Callback = function(value)
        featureStates.CoinESP.boxType = value
    end
})

CoinTracerToggle = Tabs.Esp:Toggle({
    Title = "Coin Tracer",
        Flag = "CoinTracerToggle",
    Value = false,
    Callback = function(state)
        featureStates.CoinESP.tracers = state
        manageCoinESPConnection()
    end
})

CoinDistanceESPToggle = Tabs.Esp:Toggle({
    Title = "Coin Distance ESP",
        Flag = "CoinDistanceESPToggle",
    Value = false,
    Callback = function(state)
        featureStates.CoinESP.distance = state
        manageCoinESPConnection()
    end
})

CoinHighlightsToggle = Tabs.Esp:Toggle({
    Title = "Coin Highlights",
        Flag = "CoinHighlightsToggle",
    Value = false,
    Callback = function(state)
        featureStates.CoinHighlights = state
        manageHighlightsConnection()
        refreshHighlights()
    end
})



Tabs.Teleport:Section({ Title = "Teleport", TextSize = 20 })
Tabs.Teleport:Divider()

function GetPlayerList()
    local playerList = {"Select a player"}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player then
            table.insert(playerList, plr.Name)
        end
    end
    return playerList
end

TeleportPlayerDropdown = Tabs.Teleport:Dropdown({
    Title = "Select Player",
        Flag = "TeleportPlayerDropdown",
    Values = GetPlayerList(),
    Value = "Select a player",
    Callback = function(value)
        selectedPlayerName = value
    end
})

function UpdatePlayerList()
    TeleportPlayerDropdown:Refresh(GetPlayerList(), "Select a player")
end

Tabs.Teleport:Button({
    Title = "Teleport to Player",
    Desc = "Teleport to the selected player",
    Icon = "user",
    Callback = function()
        if selectedPlayerName and selectedPlayerName ~= "Select a player" then
            targetPlayer = Players:FindFirstChild(selectedPlayerName)
            
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        end
    end
})

Tabs.Teleport:Button({
    Title = "Teleport to Random Player",
    Desc = "Teleport to a random player in the server",
    Icon = "users",
    Callback = function()
        otherPlayers = {}
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                table.insert(otherPlayers, plr)
            end
        end
        
        if #otherPlayers > 0 then
            randomPlayer = otherPlayers[math.random(1, #otherPlayers)]
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = randomPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    end
})


Players.PlayerAdded:Connect(function()
    UpdatePlayerList()
end)

Players.PlayerRemoving:Connect(function()
    UpdatePlayerList()
end)

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid", 5)
    rootPart = character:WaitForChild("HumanoidRootPart", 5)
end)

Tabs.Misc:Section({ Title = "Misc", TextSize = 40 })
Tabs.Misc:Divider()

AntiAFKConnection = nil

startAntiAFK = function()
    AntiAFKConnection = player.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

stopAntiAFK = function()
    if AntiAFKConnection then
        AntiAFKConnection:Disconnect()
        AntiAFKConnection = nil
    end
end

AntiAFKToggle = Tabs.Misc:Toggle({
    Title = "Anti AFK",
        Flag = "AntiAFKToggle",
    Value = featureStates.AntiAFK,
    Callback = function(state)
        featureStates.AntiAFK = state
        if state then
            startAntiAFK()
        else
            stopAntiAFK()
        end
    end
})

TimeChangerInput = Tabs.Utility:Input({
    Title = "Set Time (HH:MM)",
        Flag = "TimeChangerInput",
    Placeholder = "12:00",
    Callback = function(value)
        value = value:gsub("^%s*(.-)%s*$", "%1")
        
        local h_str, m_str = value:match("(%d+):(%d+)")
        if h_str and m_str then
            local h = tonumber(h_str)
            local m = tonumber(m_str)
            
            if h and m and h >= 0 and h <= 23 and m >= 0 and m <= 59 and #h_str <= 2 and #m_str <= 2 then
                local totalHours = h + (m / 60)
                game:GetService("Lighting").ClockTime = totalHours
             end
        end
    end
})
GravityToggle = Tabs.Utility:Toggle({
    Title = "Custom Gravity",
        Flag = "GravityToggle",
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

GravityInput = Tabs.Utility:Input({
    Title = "Gravity Value",
        Flag = "GravityInput",
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

GravityGUIToggle = Tabs.Utility:Toggle({
    Title = "Gravity toggle shortcuts",
        Flag = "GravityGUIToggle",
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
featureStates.NoRender = false
featureStates.NoRenderColor = Color3.fromRGB(0, 0, 0)

NoRenderToggle = Tabs.Utility:Toggle({
    Title = "No Render",
        Flag = "NoRenderToggle",
    Desc = "Disable 3D rendering for performance",
    Value = false,
    Callback = function(state)
        featureStates.NoRender = state
        game:GetService("RunService"):Set3dRenderingEnabled(not state)
        
        if state then
            local gui = Instance.new("ScreenGui")
            gui.Name = "NoRenderBackground"
            gui.IgnoreGuiInset = true
            gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            gui.ResetOnSpawn = false
            
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BackgroundColor3 = featureStates.NoRenderColor
            frame.BorderSizePixel = 0
            frame.Parent = gui
            
            gui.Parent = player.PlayerGui
        else
            local gui = player.PlayerGui:FindFirstChild("NoRenderBackground")
            if gui then
                gui:Destroy()
            end
        end
    end
})

NoRenderColorPicker = Tabs.Utility:Colorpicker({
    Title = "No Render Color",
        Flag = "NoRenderColorPicker",
    Desc = "Choose background color when No Render is enabled",
    Default = Color3.fromRGB(0, 0, 0),
    Transparency = 0,
    Callback = function(color)
        featureStates.NoRenderColor = color
        
        if featureStates.NoRender then
            local gui = player.PlayerGui:FindFirstChild("NoRenderBackground")
            if gui then
                local frame = gui:FindFirstChildOfClass("Frame")
                if frame then
                    frame.BackgroundColor3 = color
                end
            end
        end
    end
})
featureStates.RemoveTextures = false

RemoveTexturesButton = Tabs.Utility:Button({
    Title = "Remove Textures",
    Callback = function()
        for _, part in ipairs(workspace:GetDescendants()) do
            if part:IsA("Part") or part:IsA("MeshPart") or part:IsA("UnionOperation") or part:IsA("WedgePart") or part:IsA("CornerWedgePart") then
                if part:IsA("Part") then
                    part.Material = Enum.Material.SmoothPlastic
                end
                if part:FindFirstChildWhichIsA("Texture") then
                    local texture = part:FindFirstChildWhichIsA("Texture")
                    texture.Texture = "rbxassetid://0"
                end
                if part:FindFirstChildWhichIsA("Decal") then
                    local decal = part:FindFirstChildWhichIsA("Decal")
                    decal.Texture = "rbxassetid://0"
                end
            end
        end
    end
})
game:GetService("Players").PlayerRemoving:Connect(function(leavingPlayer)
    if leavingPlayer == player then
        game:GetService("RunService"):Set3dRenderingEnabled(true)
    end
end)
LowQualityButton = Tabs.Utility:Button({
    Title = "Low Quality",
    Desc = "Disable textures, effects, and optimize graphics",
    Callback = function()
        local ToDisable = {
            Textures = true,
            VisualEffects = true,
            Parts = true,
            Particles = true,
            Sky = true
        }

        local ToEnable = {
            FullBright = false
        }

        local Stuff = {}

        for _, v in next, game:GetDescendants() do
            if ToDisable.Parts then
                if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                    table.insert(Stuff, 1, v)
                end
            end
            
            if ToDisable.Particles then
                if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Explosion") or v:IsA("Sparkles") or v:IsA("Fire") then
                    v.Enabled = false
                    table.insert(Stuff, 1, v)
                end
            end
            
            if ToDisable.VisualEffects then
                if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("SunRaysEffect") then
                    v.Enabled = false
                    table.insert(Stuff, 1, v)
                end
            end
            
            if ToDisable.Textures then
                if v:IsA("Decal") or v:IsA("Texture") then
                    v.Texture = ""
                    table.insert(Stuff, 1, v)
                end
            end
            
            if ToDisable.Sky then
                if v:IsA("Sky") then
                    v.Parent = nil
                    table.insert(Stuff, 1, v)
                end
            end
        end

        if ToEnable.FullBright then
            local Lighting = game:GetService("Lighting")
            
            Lighting.FogColor = Color3.fromRGB(255, 255, 255)
            Lighting.FogEnd = math.huge
            Lighting.FogStart = math.huge
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 5
            Lighting.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
            Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            Lighting.Outlines = true
        end
    end
})

local antiFlingEnabled = false
local antiFlingConnection = nil

local function setCanCollideOfModelDescendants(model, bval)
    if not model then return end
    for _, v in pairs(model:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = bval
        end
    end
end

local function startAntiFling()
    if antiFlingConnection then return end
    
    antiFlingConnection = RunService.Stepped:Connect(function()
        if antiFlingEnabled then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer and player.Character then
                    setCanCollideOfModelDescendants(player.Character, false)
                end
            end
        end
    end)
end

local function stopAntiFling()
    if antiFlingConnection then
        antiFlingConnection:Disconnect()
        antiFlingConnection = nil
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character then
            setCanCollideOfModelDescendants(player.Character, true)
        end
    end
end

if _G.a then
    local v1, v2, v3 = pairs(_G.a)
    while true do
        local v4
        v3, v4 = v1(v2, v3)
        if v3 == nil then
            break
        end
        v4:Disconnect()
    end
    _G.a = nil
end

repeat
    task.wait()
until game.Players.LocalPlayer

vu5 = game.Players.LocalPlayer
vu6 = nil
vu7 = nil
vu8 = nil
vu9 = false
vu10 = {}

function vu16()
    vu6 = vu5.Character or vu5.CharacterAdded:Wait()
    vu7 = vu6:WaitForChild("Humanoid")
    vu8 = vu6:WaitForChild("HumanoidRootPart")
    vu10 = {}
    v11 = vu6
    v12, v13, v14 = pairs(v11:GetDescendants())
    while true do
        v15 = nil
        v14, v15 = v12(v13, v14)
        if v14 == nil then
            break
        end
        if v15:IsA("BasePart") and v15.Transparency == 0 then
            vu10[#vu10 + 1] = v15
        end
    end
end

function vu30()
    invisibleGui = Instance.new("ScreenGui")
    invisibleGui.Name = "InvisibleGui"
    invisibleGui.IgnoreGuiInset = true
    invisibleGui.ResetOnSpawn = false
    invisibleGui.Enabled = false
    invisibleGui.Parent = game:GetService("CoreGui")

    frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 120, 0, 120)
    frame.Position = UDim2.new(0.5, -30, 0.12, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.35
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = invisibleGui

    corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame

    stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(150, 150, 150)
    stroke.Thickness = 2
    stroke.Parent = frame

    label = Instance.new("TextLabel")
    label.Text = "INVISIBLE"
    label.Size = UDim2.new(0.9, 0, 0.5, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Roboto
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.TextScaled = true
    label.Parent = frame

    invisibleButton = Instance.new("TextButton")
    invisibleButton.Name = "InvisibleButton"
    invisibleButton.Text = "OFF"
    invisibleButton.Size = UDim2.new(0.9, 0, 0.5, 0)
    invisibleButton.Position = UDim2.new(0.05, 0, 0.5, 0)
    invisibleButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    invisibleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    invisibleButton.Font = Enum.Font.Roboto
    invisibleButton.TextSize = 14
    invisibleButton.TextXAlignment = Enum.TextXAlignment.Center
    invisibleButton.TextYAlignment = Enum.TextYAlignment.Center
    invisibleButton.TextScaled = true
    invisibleButton.Parent = frame

    buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = invisibleButton

    invisibleButton.MouseButton1Click:Connect(function()
        vu9 = not vu9
        if vu9 then
            invisibleButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
            invisibleButton.Text = "ON"
        else
            invisibleButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
            invisibleButton.Text = "OFF"
        end
        
        v26, v27, v28 = pairs(vu10)
        while true do
            v29 = nil
            v28, v29 = v26(v27, v28)
            if v28 == nil then
                break
            end
            v29.Transparency = v29.Transparency == 0 and 0.5 or 0
        end
    end)
end

vu16()
vu30()

v31 = {
    nil,
    nil
}
v32 = vu5

v31[1] = vu5:GetMouse().KeyDown:Connect(function(p33)
    if p33 == "i" then
        vu9 = not vu9
        
        gui = game:GetService("CoreGui"):FindFirstChild("InvisibleGui")
        if gui then
            button = gui:FindFirstChild("InvisibleButton", true)
            if button then
                if vu9 then
                    button.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
                    button.Text = "ON"
                else
                    button.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
                    button.Text = "OFF"
                end
            end
        end
        
        v34, v35, v36 = pairs(vu10)
        while true do
            v37 = nil
            v36, v37 = v34(v35, v36)
            if v36 == nil then
                break
            end
            v37.Transparency = v37.Transparency == 0 and 0.5 or 0
        end
    end
end)

v31[2] = game:GetService("RunService").Heartbeat:Connect(function()
    if vu9 then
        v38 = vu8.CFrame
        v39 = vu7.CameraOffset
        v40 = v38 * CFrame.new(0, -200000, 0)
        v41 = vu7
        v42 = vu8
        v43 = v40:ToObjectSpace(CFrame.new(v38.Position)).Position
        v42.CFrame = v40
        v41.CameraOffset = v43
        game:GetService("RunService").RenderStepped:Wait()
        v44 = vu7
        vu8.CFrame = v38
        v44.CameraOffset = v39
    end
end)

vu5.CharacterAdded:Connect(function()
    vu9 = false
    vu16()
    
    gui = game:GetService("CoreGui"):FindFirstChild("InvisibleGui")
    if gui then
        button = gui:FindFirstChild("InvisibleButton", true)
        if button then
            button.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
            button.Text = "OFF"
        end
    end
end)

_G.a = v31
local invisibleGuiActive = false

InvisibleGuiToggle = Tabs.Utility:Toggle({
    Title = "Invisible GUI",
    Flag = "InvisibleGuiToggle",
    Value = false,
    Callback = function(state)
        if state then
            invisibleGuiActive = true
            
            local invisibleGui = game:GetService("CoreGui"):FindFirstChild("InvisibleGui")
            if invisibleGui then
                invisibleGui.Enabled = true
            else
            end
        else
            invisibleGuiActive = false
            
            local invisibleGui = game:GetService("CoreGui"):FindFirstChild("InvisibleGui")
            if invisibleGui then
                invisibleGui.Enabled = false
            end
        end
    end
})


Tabs.Shop:Section({ Title = "Auto Buy", TextSize = 40 })
Tabs.Shop:Section({ Title = "Seed Shop", TextSize = 20 })
Tabs.Shop:Divider()

local seedShopDataModule = game:GetService("ReplicatedStorage"):WaitForChild("Data"):WaitForChild("SeedShopData")
local seedDataModule = game:GetService("ReplicatedStorage"):WaitForChild("Data"):WaitForChild("SeedData")
local BuySeedStock = game:GetService("ReplicatedStorage").GameEvents.BuySeedStock

local autoBuyEnabled = false
local autoBuyTask = nil
local selectedSeeds = {}
local autoBuyAllEnabled = false
local autoBuyAllTask = nil

local seedDropdown = Tabs.Shop:Dropdown({
    Title = "Select Auto Seed",
    Desc = "Choose seeds to auto buy",
    Values = {
        {
            Title = "Loading seeds...",
            Icon = "loader",
            Desc = "Please wait"
        }
    },
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(options) 
        selectedSeeds = {}
        for _, option in ipairs(options) do
            if option.Data and option.Data.Name then
                table.insert(selectedSeeds, option.Data.Name)
            end
        end
    end
})

task.spawn(function()
    local success, seedShopData = pcall(require, seedShopDataModule)
    local success2, seedData = pcall(require, seedDataModule)
    
    if success and success2 then
        local dropdownItems = {}
        
        for seedName, shopInfo in pairs(seedShopData) do
            local seedInfo = seedData[seedName]
            if seedInfo and shopInfo.DisplayInShop ~= false then
                table.insert(dropdownItems, {
                    Title = seedInfo.SeedName or seedName,
                    Icon = seedInfo.FruitIcon or seedInfo.Asset or "",
                    Desc = string.format("$%s | %s", 
                        shopInfo.Price or 0, 
                        seedInfo.SeedRarity or "Unknown"),
                    Value = seedName,
                    Data = {
                        Name = seedName,
                        DisplayName = seedInfo.SeedName or seedName,
                        Price = shopInfo.Price or 0,
                        Rarity = seedInfo.SeedRarity or "Unknown"
                    }
                })
            end
        end
        
        table.sort(dropdownItems, function(a, b)
            return a.Data.Price < b.Data.Price
        end)
        
        seedDropdown:Refresh(dropdownItems, {})
    else
        seedDropdown:Refresh({
            {
                Title = "Failed to load",
                Icon = "x-circle",
                Desc = "Seed data modules not found"
            }
        })
    end
end)

local autoBuyToggle = Tabs.Shop:Toggle({
    Title = "Auto Buy Seed",
    Value = false,
    Callback = function(state)
        autoBuyEnabled = state
        
        if state then
            autoBuyTask = task.spawn(function()
                while autoBuyEnabled do
                    if #selectedSeeds > 0 then
                        for _, seedName in ipairs(selectedSeeds) do
                            BuySeedStock:FireServer("Shop", seedName)
                            task.wait(0.01)
                        end
                        
                        for i = 1, 5 do
                            if not autoBuyEnabled then break end
                            
                            for _, seedName in ipairs(selectedSeeds) do
                                BuySeedStock:FireServer("Shop", seedName)
                            end
                            task.wait(0.05)
                        end
                    else
                        task.wait(0.5)
                    end
                    
                    task.wait(0.1)
                end
            end)
        else
            if autoBuyTask then
                task.cancel(autoBuyTask)
                autoBuyTask = nil
            end
        end
    end
})

local autoBuyAllToggle = Tabs.Shop:Toggle({
    Title = "Auto Buy All Seed",
    Value = false,
    Callback = function(state)
        autoBuyAllEnabled = state
        
        if state then
            autoBuyAllTask = task.spawn(function()
                while autoBuyAllEnabled do
                    local success, seedShopData = pcall(require, seedShopDataModule)
                    if success then
                        for seedName, shopInfo in pairs(seedShopData) do
                            if shopInfo.DisplayInShop ~= false then
                                BuySeedStock:FireServer("Shop", seedName)
                                task.wait(0.01)
                            end
                        end
                        
                        for i = 1, 10 do
                            if not autoBuyAllEnabled then break end
                            
                            for seedName, shopInfo in pairs(seedShopData) do
                                if shopInfo.DisplayInShop ~= false then
                                    BuySeedStock:FireServer("Shop", seedName)
                                end
                            end
                            task.wait(0.03)
                        end
                    else
                        task.wait(0.5)
                    end
                    
                    task.wait(0.2)
                end
            end)
        else
            if autoBuyAllTask then
                task.cancel(autoBuyAllTask)
                autoBuyAllTask = nil
            end
        end
    end
})
Tabs.Shop:Section({ Title = "Daily Seed Shop", TextSize = 20 })
Tabs.Shop:Divider()

local dailySeedShopDataModule = game:GetService("ReplicatedStorage"):WaitForChild("Data"):WaitForChild("DailySeedShopData")
local seedDataModule = game:GetService("ReplicatedStorage"):WaitForChild("Data"):WaitForChild("SeedData")
local BuyDailySeedShopStock = game:GetService("ReplicatedStorage").GameEvents.BuyDailySeedShopStock

local dailyAutoBuyEnabled = false
local dailyAutoBuyTask = nil
local dailySelectedSeeds = {}
local dailyBuyAllEnabled = false
local dailyBuyAllTask = nil

local function loadDailySeedData()
    local success, dailyData = pcall(require, dailySeedShopDataModule)
    local success2, seedData = pcall(require, seedDataModule)
    
    if success and success2 then
        return dailyData, seedData
    end
    return nil, nil
end

local function getDailySeeds()
    local dailyData, seedData = loadDailySeedData()
    if not dailyData or not seedData then return {} end
    
    local dailySeeds = {}
    
    for seedName, shopInfo in pairs(dailyData) do
        local seedInfo = seedData[seedName]
        if seedInfo then
            table.insert(dailySeeds, {
                Title = seedInfo.SeedName or seedName,
                Icon = seedInfo.FruitIcon or seedInfo.Asset or "",
                Desc = string.format("$%s | Stock: %d", 
                    shopInfo.Price or 0, 
                    shopInfo.MaxStock or 1),
                Value = seedName,
                Data = {
                    Name = seedName,
                    DisplayName = seedInfo.SeedName or seedName,
                    Price = shopInfo.Price or 0,
                    MaxStock = shopInfo.MaxStock or 1
                }
            })
        end
    end
    
    table.sort(dailySeeds, function(a, b)
        return a.Data.Price < b.Data.Price
    end)
    
    return dailySeeds
end

local dailySeedDropdown = Tabs.Shop:Dropdown({
    Title = "Select Daily Seed",
    Desc = "Choose daily seeds to auto buy",
    Values = {
        {
            Title = "Loading daily seeds...",
            Icon = "loader",
            Desc = "Please wait"
        }
    },
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(options) 
        dailySelectedSeeds = {}
        for _, option in ipairs(options) do
            if option.Data and option.Data.Name then
                table.insert(dailySelectedSeeds, option.Data.Name)
            end
        end
    end
})

task.spawn(function()
    local dailySeeds = getDailySeeds()
    if #dailySeeds > 0 then
        dailySeedDropdown:Refresh(dailySeeds, {})
    else
        dailySeedDropdown:Refresh({
            {
                Title = "No Daily Seeds",
                Icon = "x-circle",
                Desc = "Daily shop data not found"
            }
        })
    end
end)

local autoBuyDailyToggle = Tabs.Shop:Toggle({
    Title = "Auto Buy Daily Seed",
    Value = false,
    Callback = function(state)
        dailyAutoBuyEnabled = state
        
        if state then
            dailyAutoBuyTask = task.spawn(function()
                while dailyAutoBuyEnabled do
                    if #dailySelectedSeeds > 0 then
                        for _, seedName in ipairs(dailySelectedSeeds) do
                            BuyDailySeedShopStock:FireServer(seedName)
                            task.wait(0.01)
                        end
                        
                        for i = 1, 5 do
                            if not dailyAutoBuyEnabled then break end
                            
                            for _, seedName in ipairs(dailySelectedSeeds) do
                                BuyDailySeedShopStock:FireServer(seedName)
                            end
                            task.wait(0.05)
                        end
                    else
                        task.wait(0.5)
                    end
                    
                    task.wait(0.1)
                end
            end)
        else
            if dailyAutoBuyTask then
                task.cancel(dailyAutoBuyTask)
                dailyAutoBuyTask = nil
            end
        end
    end
})

local autoBuyAllDailyToggle = Tabs.Shop:Toggle({
    Title = "Auto Buy All Daily Seed",
    Value = false,
    Callback = function(state)
        dailyBuyAllEnabled = state
        
        if state then
            dailyBuyAllTask = task.spawn(function()
                while dailyBuyAllEnabled do
                    local dailyData, _ = loadDailySeedData()
                    if dailyData then
                        for seedName, _ in pairs(dailyData) do
                            BuyDailySeedShopStock:FireServer(seedName)
                            task.wait(0.01)
                        end
                        
                        for i = 1, 8 do
                            if not dailyBuyAllEnabled then break end
                            
                            for seedName, _ in pairs(dailyData) do
                                BuyDailySeedShopStock:FireServer(seedName)
                            end
                            task.wait(0.04)
                        end
                    else
                        task.wait(0.5)
                    end
                    
                    task.wait(0.15)
                end
            end)
        else
            if dailyBuyAllTask then
                task.cancel(dailyBuyAllTask)
                dailyBuyAllTask = nil
            end
        end
    end
})
Tabs.Shop:Section({ Title = "Pet Egg Autobuy", TextSize = 20 })
Tabs.Shop:Divider()

local petEggDataModule = game:GetService("ReplicatedStorage"):WaitForChild("Data"):WaitForChild("PetEggData")
local petEggsModule = game:GetService("ReplicatedStorage"):WaitForChild("Data"):WaitForChild("PetRegistry"):WaitForChild("PetEggs")
local BuyPetEgg = game:GetService("ReplicatedStorage").GameEvents.BuyPetEgg

local eggAutoBuyEnabled = false
local eggAutoBuyTask = nil
local selectedEggs = {}
local eggAutoBuyAllEnabled = false
local eggAutoBuyAllTask = nil

local function loadEggData()
    local success, eggData = pcall(require, petEggDataModule)
    local success2, eggsInfo = pcall(require, petEggsModule)
    
    if success and success2 then
        return eggData, eggsInfo
    end
    return nil, nil
end

local eggDropdown = Tabs.Shop:Dropdown({
    Title = "Select Egg",
    Desc = "Choose eggs to auto buy",
    Values = {
        {
            Title = "Loading eggs...",
            Icon = "loader",
            Desc = "Please wait"
        }
    },
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(options) 
        selectedEggs = {}
        for _, option in ipairs(options) do
            if option.Data and option.Data.Name then
                table.insert(selectedEggs, option.Data.Name)
            end
        end
    end
})

task.spawn(function()
    local eggData, eggsInfo = loadEggData()
    
    if eggData and eggsInfo then
        local dropdownItems = {}
        
        for eggName, eggInfo in pairs(eggData) do
            local eggDetails = eggsInfo[eggName]
            if eggDetails then
                table.insert(dropdownItems, {
                    Title = eggInfo.EggName or eggName,
                    Icon = eggDetails.Icon or "",
                    Desc = string.format("$%s | %s", 
                        eggInfo.Price or 0, 
                        eggInfo.EggRarity or "Unknown"),
                    Value = eggName,
                    Data = {
                        Name = eggName,
                        DisplayName = eggInfo.EggName or eggName,
                        Price = eggInfo.Price or 0,
                        Rarity = eggInfo.EggRarity or "Unknown"
                    }
                })
            end
        end
        
        table.sort(dropdownItems, function(a, b)
            return a.Data.Price < b.Data.Price
        end)
        
        eggDropdown:Refresh(dropdownItems, {})
    else
        eggDropdown:Refresh({
            {
                Title = "Failed to load",
                Icon = "x-circle",
                Desc = "Egg data modules not found"
            }
        })
    end
end)

local autoBuyEggToggle = Tabs.Shop:Toggle({
    Title = "Auto Buy Egg",
    Value = false,
    Callback = function(state)
        eggAutoBuyEnabled = state
        
        if state then
            eggAutoBuyTask = task.spawn(function()
                while eggAutoBuyEnabled do
                    if #selectedEggs > 0 then
                        for _, eggName in ipairs(selectedEggs) do
                            BuyPetEgg:FireServer(eggName)
                            task.wait(0.01)
                        end
                        
                        for i = 1, 5 do
                            if not eggAutoBuyEnabled then break end
                            
                            for _, eggName in ipairs(selectedEggs) do
                                BuyPetEgg:FireServer(eggName)
                            end
                            task.wait(0.05)
                        end
                    else
                        task.wait(0.5)
                    end
                    
                    task.wait(0.1)
                end
            end)
        else
            if eggAutoBuyTask then
                task.cancel(eggAutoBuyTask)
                eggAutoBuyTask = nil
            end
        end
    end
})

local autoBuyAllEggToggle = Tabs.Shop:Toggle({
    Title = "Auto Buy All Egg",
    Value = false,
    Callback = function(state)
        eggAutoBuyAllEnabled = state
        
        if state then
            eggAutoBuyAllTask = task.spawn(function()
                while eggAutoBuyAllEnabled do
                    local eggData, _ = loadEggData()
                    if eggData then
                        for eggName, _ in pairs(eggData) do
                            BuyPetEgg:FireServer(eggName)
                            task.wait(0.01)
                        end
                        
                        for i = 1, 8 do
                            if not eggAutoBuyAllEnabled then break end
                            
                            for eggName, _ in pairs(eggData) do
                                BuyPetEgg:FireServer(eggName)
                            end
                            task.wait(0.04)
                        end
                    else
                        task.wait(0.5)
                    end
                    
                    task.wait(0.15)
                end
            end)
        else
            if eggAutoBuyAllTask then
                task.cancel(eggAutoBuyAllTask)
                eggAutoBuyAllTask = nil
            end
        end
    end
})
Tabs.Shop:Section({ Title = "Gear Shop Autobuy", TextSize = 20 })
Tabs.Shop:Divider()

local gearShopDataModule = game:GetService("ReplicatedStorage"):WaitForChild("Data"):WaitForChild("GearShopData")
local gearDataModule = game:GetService("ReplicatedStorage"):WaitForChild("Data"):WaitForChild("GearData")
local BuyGearStock = game:GetService("ReplicatedStorage").GameEvents.BuyGearStock

local gearAutoBuyEnabled = false
local gearAutoBuyTask = nil
local selectedGears = {}
local gearAutoBuyAllEnabled = false
local gearAutoBuyAllTask = nil

local function loadGearData()
    local success, gearShopData = pcall(require, gearShopDataModule)
    local success2, gearInfo = pcall(require, gearDataModule)
    
    if success and success2 then
        return gearShopData, gearInfo
    end
    return nil, nil
end

local gearDropdown = Tabs.Shop:Dropdown({
    Title = "Select Gear",
    Desc = "Choose gear to auto buy",
    Values = {
        {
            Title = "Loading gear...",
            Icon = "loader",
            Desc = "Please wait"
        }
    },
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(options) 
        selectedGears = {}
        for _, option in ipairs(options) do
            if option.Data and option.Data.Name then
                table.insert(selectedGears, option.Data.Name)
            end
        end
    end
})

task.spawn(function()
    local gearShopData, gearInfo = loadGearData()
    
    if gearShopData and gearInfo and gearShopData.Gear then
        local dropdownItems = {}
        
        for gearName, shopInfo in pairs(gearShopData.Gear) do
            local gearDetails = gearInfo[gearName]
            if gearDetails and (shopInfo.DisplayInShop ~= false) then
                table.insert(dropdownItems, {
                    Title = gearDetails.GearName or gearName,
                    Icon = gearDetails.Asset or "",
                    Desc = string.format("$%s | %s", 
                        shopInfo.Price or 0, 
                        gearDetails.GearRarity or "Unknown"),
                    Value = gearName,
                    Data = {
                        Name = gearName,
                        DisplayName = gearDetails.GearName or gearName,
                        Price = shopInfo.Price or 0,
                        Rarity = gearDetails.GearRarity or "Unknown"
                    }
                })
            end
        end
        
        table.sort(dropdownItems, function(a, b)
            return a.Data.Price < b.Data.Price
        end)
        
        gearDropdown:Refresh(dropdownItems, {})
    else
        gearDropdown:Refresh({
            {
                Title = "Failed to load",
                Icon = "x-circle",
                Desc = "Gear data modules not found"
            }
        })
    end
end)

local autoBuyGearToggle = Tabs.Shop:Toggle({
    Title = "Auto Buy Gear",
    Value = false,
    Callback = function(state)
        gearAutoBuyEnabled = state
        
        if state then
            gearAutoBuyTask = task.spawn(function()
                while gearAutoBuyEnabled do
                    if #selectedGears > 0 then
                        for _, gearName in ipairs(selectedGears) do
                            BuyGearStock:FireServer(gearName)
                            task.wait(0.01)
                        end
                        
                        for i = 1, 5 do
                            if not gearAutoBuyEnabled then break end
                            
                            for _, gearName in ipairs(selectedGears) do
                                BuyGearStock:FireServer(gearName)
                            end
                            task.wait(0.05)
                        end
                    else
                        task.wait(0.5)
                    end
                    
                    task.wait(0.1)
                end
            end)
        else
            if gearAutoBuyTask then
                task.cancel(gearAutoBuyTask)
                gearAutoBuyTask = nil
            end
        end
    end
})

local autoBuyAllGearToggle = Tabs.Shop:Toggle({
    Title = "Auto Buy All Gear",
    Value = false,
    Callback = function(state)
        gearAutoBuyAllEnabled = state
        
        if state then
            gearAutoBuyAllTask = task.spawn(function()
                while gearAutoBuyAllEnabled do
                    local gearShopData, _ = loadGearData()
                    if gearShopData and gearShopData.Gear then
                        for gearName, shopInfo in pairs(gearShopData.Gear) do
                            if shopInfo.DisplayInShop ~= false then
                                BuyGearStock:FireServer(gearName)
                                task.wait(0.01)
                            end
                        end
                        
                        for i = 1, 8 do
                            if not gearAutoBuyAllEnabled then break end
                            
                            for gearName, shopInfo in pairs(gearShopData.Gear) do
                                if shopInfo.DisplayInShop ~= false then
                                    BuyGearStock:FireServer(gearName)
                                end
                            end
                            task.wait(0.04)
                        end
                    else
                        task.wait(0.5)
                    end
                    
                    task.wait(0.15)
                end
            end)
        else
            if gearAutoBuyAllTask then
                task.cancel(gearAutoBuyAllTask)
                gearAutoBuyAllTask = nil
            end
        end
    end
})
Tabs.Shop:Section({ Title = "Cosmetic Autobuy", TextSize = 20 })
Tabs.Shop:Divider()

local crateShopModule = game:GetService("ReplicatedStorage"):WaitForChild("Data"):WaitForChild("CosmeticCrateShopData")
local itemShopModule = game:GetService("ReplicatedStorage"):WaitForChild("Data"):WaitForChild("CosmeticItemShopData")
local cosmeticRegistryModule = game:GetService("ReplicatedStorage"):WaitForChild("Data"):WaitForChild("CosmeticRegistry"):WaitForChild("CosmeticList")

local BuyCosmeticCrate = game:GetService("ReplicatedStorage").GameEvents.BuyCosmeticCrate
local BuyCosmeticItem = game:GetService("ReplicatedStorage").GameEvents.BuyCosmeticItem
local BuyCosmeticShopFence = game:GetService("ReplicatedStorage").GameEvents.BuyCosmeticShopFence

local cosmeticAutoBuyEnabled = false
local cosmeticAutoBuyTask = nil
local selectedCosmetics = {}
local cosmeticAutoBuyAllEnabled = false
local cosmeticAutoBuyAllTask = nil

local function loadCosmeticData()
    local success, crateData = pcall(require, crateShopModule)
    local success2, itemData = pcall(require, itemShopModule)
    local success3, registryData = pcall(require, cosmeticRegistryModule)
    
    if success and success2 and success3 then
        return crateData, itemData, registryData
    end
    return nil, nil, nil
end

local cosmeticDropdown = Tabs.Shop:Dropdown({
    Title = "Select Cosmetic",
    Desc = "Choose cosmetics to auto buy",
    Values = {
        {
            Title = "Loading cosmetics...",
            Icon = "loader",
            Desc = "Please wait"
        }
    },
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(options) 
        selectedCosmetics = {}
        for _, option in ipairs(options) do
            if option.Data and option.Data.Name and option.Data.Type then
                table.insert(selectedCosmetics, {
                    Name = option.Data.Name,
                    Type = option.Data.Type,
                    DisplayName = option.Data.DisplayName
                })
            end
        end
    end
})

task.spawn(function()
    local crateData, itemData, registryData = loadCosmeticData()
    
    if crateData and itemData and registryData then
        local dropdownItems = {}
        
        for crateName, crateInfo in pairs(crateData) do
            local regInfo = registryData[crateInfo.CrateName or crateName]
            table.insert(dropdownItems, {
                Title = crateInfo.CrateName or crateName,
                Icon = regInfo and regInfo.Icon or "",
                Desc = string.format("Crate | $%s | %s", 
                    crateInfo.Price or 0, 
                    crateInfo.CrateRarity or "Unknown"),
                Value = crateName,
                Data = {
                    Name = crateName,
                    DisplayName = crateInfo.CrateName or crateName,
                    Price = crateInfo.Price or 0,
                    Rarity = crateInfo.CrateRarity or "Unknown",
                    Type = "CRATE"
                }
            })
        end
        
        for itemName, itemInfo in pairs(itemData) do
            local regInfo = registryData[itemInfo.CosmeticName or itemName]
            table.insert(dropdownItems, {
                Title = itemInfo.CosmeticName or itemName,
                Icon = regInfo and regInfo.Icon or "",
                Desc = string.format("Item | $%s", 
                    itemInfo.Price or 0),
                Value = itemName,
                Data = {
                    Name = itemName,
                    DisplayName = itemInfo.CosmeticName or itemName,
                    Price = itemInfo.Price or 0,
                    Type = "ITEM"
                }
            })
        end
        
        local fences = {
            {Name = "FLOWER", DisplayName = "Flower Fence", Type = "FENCE", Price = 0},
            {Name = "WOOD", DisplayName = "Wood Fence", Type = "FENCE", Price = 0},
            {Name = "STONE", DisplayName = "Stone Fence", Type = "FENCE", Price = 0},
        }
        
        for _, fence in ipairs(fences) do
            table.insert(dropdownItems, {
                Title = fence.DisplayName,
                Icon = "grid", 
                Desc = "Fence",
                Value = fence.Name,
                Data = {
                    Name = fence.Name,
                    DisplayName = fence.DisplayName,
                    Price = fence.Price,
                    Type = "FENCE"
                }
            })
        end
        
        table.sort(dropdownItems, function(a, b)
            if a.Data.Type == b.Data.Type then
                return a.Title < b.Title
            end
            return a.Data.Type < b.Data.Type
        end)
        
        cosmeticDropdown:Refresh(dropdownItems, {})
    else
        cosmeticDropdown:Refresh({
            {
                Title = "Failed to load",
                Icon = "x-circle",
                Desc = "Cosmetic data not found"
            }
        })
    end
end)

local autoBuyCosmeticToggle = Tabs.Shop:Toggle({
    Title = "Auto Buy Cosmetic",
    Value = false,
    Callback = function(state)
        cosmeticAutoBuyEnabled = state
        
        if state then
            cosmeticAutoBuyTask = task.spawn(function()
                while cosmeticAutoBuyEnabled do
                    if #selectedCosmetics > 0 then
                        for _, cosmetic in ipairs(selectedCosmetics) do
                            if cosmetic.Type == "CRATE" then
                                BuyCosmeticCrate:FireServer(cosmetic.Name, "Cosmetics")
                            elseif cosmetic.Type == "ITEM" then
                                BuyCosmeticItem:FireServer(cosmetic.Name, "Cosmetics")
                            elseif cosmetic.Type == "FENCE" then
                                BuyCosmeticShopFence:FireServer(cosmetic.Name, "Fences")
                            end
                            task.wait(0.01)
                        end
                        
                        for i = 1, 5 do
                            if not cosmeticAutoBuyEnabled then break end
                            
                            for _, cosmetic in ipairs(selectedCosmetics) do
                                if cosmetic.Type == "CRATE" then
                                    BuyCosmeticCrate:FireServer(cosmetic.Name, "Cosmetics")
                                elseif cosmetic.Type == "ITEM" then
                                    BuyCosmeticItem:FireServer(cosmetic.Name, "Cosmetics")
                                elseif cosmetic.Type == "FENCE" then
                                    BuyCosmeticShopFence:FireServer(cosmetic.Name, "Fences")
                                end
                            end
                            task.wait(0.05)
                        end
                    else
                        task.wait(0.5)
                    end
                    
                    task.wait(0.1)
                end
            end)
        else
            if cosmeticAutoBuyTask then
                task.cancel(cosmeticAutoBuyTask)
                cosmeticAutoBuyTask = nil
            end
        end
    end
})

local autoBuyAllCosmeticToggle = Tabs.Shop:Toggle({
    Title = "Auto Buy All Cosmetic",
    Value = false,
    Callback = function(state)
        cosmeticAutoBuyAllEnabled = state
        
        if state then
            cosmeticAutoBuyAllTask = task.spawn(function()
                while cosmeticAutoBuyAllEnabled do
                    local crateData, itemData, _ = loadCosmeticData()
                    
                    if crateData then
                        for crateName, _ in pairs(crateData) do
                            BuyCosmeticCrate:FireServer(crateName, "Cosmetics")
                            task.wait(0.01)
                        end
                    end
                    
                    if itemData then
                        for itemName, _ in pairs(itemData) do
                            BuyCosmeticItem:FireServer(itemName, "Cosmetics")
                            task.wait(0.01)
                        end
                    end
                    
                    local fences = {"FLOWER", "WOOD", "STONE"}
                    for _, fenceName in ipairs(fences) do
                        BuyCosmeticShopFence:FireServer(fenceName, "Fences")
                        task.wait(0.01)
                    end
                    
                    for i = 1, 8 do
                        if not cosmeticAutoBuyAllEnabled then break end
                        
                        if crateData then
                            for crateName, _ in pairs(crateData) do
                                BuyCosmeticCrate:FireServer(crateName, "Cosmetics")
                            end
                        end
                        
                        if itemData then
                            for itemName, _ in pairs(itemData) do
                                BuyCosmeticItem:FireServer(itemName, "Cosmetics")
                            end
                        end
                        
                        for _, fenceName in ipairs(fences) do
                            BuyCosmeticShopFence:FireServer(fenceName, "Fences")
                        end
                        
                        task.wait(0.04)
                    end
                    
                    task.wait(0.15)
                end
            end)
        else
            if cosmeticAutoBuyAllTask then
                task.cancel(cosmeticAutoBuyAllTask)
                cosmeticAutoBuyAllTask = nil
            end
        end
    end
})

Tabs.Settings:Section({ Title = "Config Manager", TextSize = 20 })
Tabs.Settings:Divider()

-- Services
local ConfigManager = Window.ConfigManager
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local CurrentConfigName = "default"
local AutoLoadConfig = "default"
local AutoLoadEnabled = false
local AutoSaveEnabled = false
local ConfigListDropdown = nil
local AutoSaveConnection = nil

local function FileExists(path)
    if isfile then
        return pcall(readfile, path)
    end
    return false
end

local function WriteFile(path, content)
    if writefile then
        return pcall(writefile, path, content)
    end
    return false
end

local function ReadFile(path)
    if readfile then
        local success, content = pcall(readfile, path)
        if success then
            return content
        end
    end
    return ""
end

local function loadAutoLoadSettings()
    local autoLoadFile = "Darahub/AutoLoad/Game/Grow-A-Garden/AutoLoad.json"
    
    if FileExists(autoLoadFile) then
        local content = ReadFile(autoLoadFile)
        
        if content ~= "" then
            local success, data = pcall(function()
                return HttpService:JSONDecode(content)
            end)
            
            if success and data then
                AutoLoadConfig = data.configName or "default"
                AutoLoadEnabled = data.enabled or false
                return true
            end
        end
    end
    
    AutoLoadConfig = "default"
    AutoLoadEnabled = false
    return false
end

local function saveAutoLoadSettings()
    local autoLoadFile = "Darahub/AutoLoad/Game/Grow-A-Garden/AutoLoad.json"
    
    local success = WriteFile(autoLoadFile, "")
    if not success then
        if makefolder then
            pcall(function() makefolder("Darahub") end)
            pcall(function() makefolder("Darahub/AutoLoad") end)
            pcall(function() makefolder("Darahub/AutoLoad/Game") end)
            pcall(function() makefolder("Darahub/AutoLoad/Game/Grow-A-Garden") end)
        end
    end
    
    local data = {
        enabled = AutoLoadEnabled,
        configName = AutoLoadConfig
    }
    
    local success, json = pcall(function()
        return HttpService:JSONEncode(data)
    end)
    
    if success then
        WriteFile(autoLoadFile, json)
    end
end

loadAutoLoadSettings()

local ConfigNameInput = Tabs.Settings:Input({
    Title = "Config Name",
        Flag = "ConfigNameInput",
    Flag = "ConfigNameInput",
    Desc = "Name for your config file",
    Icon = "file-cog",
    Placeholder = "default",
    Value = CurrentConfigName,
    Callback = function(value)
        if value ~= "" then
            CurrentConfigName = value
        end
    end
})

Tabs.Settings:Space()

local AutoLoadToggle = Tabs.Settings:Toggle({
    Title = "Auto Load",
        Flag = "AutoLoadToggle",
    Flag = "AutoLoadToggle",
    Desc = "Automatically load this config when script starts",
    Value = AutoLoadEnabled,
    Callback = function(state)
        AutoLoadEnabled = state
        if state then
            AutoLoadConfig = CurrentConfigName
            WindUI:Notify({
                Title = "Auto-Load",
                Content = "Config '" .. CurrentConfigName .. "' will load automatically on startup",
                Duration = 3
            })
        end
        saveAutoLoadSettings()
    end
})

local AutoSaveToggle = Tabs.Settings:Toggle({
    Title = "Auto Save",
        Flag = "AutoSaveToggle",
    Flag = "AutoSaveToggle",
    Desc = "Automatically save changes to config every second",
    Value = AutoSaveEnabled,
    Callback = function(state)
        AutoSaveEnabled = state
        
        -- Stop existing auto-save loop if it exists
        if AutoSaveConnection then
            AutoSaveConnection:Disconnect()
            AutoSaveConnection = nil
        end
        
        if state then
            WindUI:Notify({
                Title = "Auto-Save",
                Content = "Config will save automatically every second",
                Duration = 2
            })
            
            -- Start auto-save loop
            AutoSaveConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if AutoSaveEnabled and CurrentConfigName ~= "" then
                    task.spawn(function()
                        Window.CurrentConfig = ConfigManager:Config(CurrentConfigName)
                        Window.CurrentConfig:Save()
                    end)
                end
                task.wait(1) -- Save every second
            end)
        else
            WindUI:Notify({
                Title = "Auto-Save",
                Content = "Auto-save disabled",
                Duration = 2
            })
        end
    end
})

Tabs.Settings:Space()

local function refreshConfigList()
    local allConfigs = ConfigManager:AllConfigs() or {}
    
    -- Ensure "default" config exists
    if not table.find(allConfigs, "default") then
        -- Create default config if it doesn't exist
        local defaultConfig = ConfigManager:Config("default")
        if defaultConfig and defaultConfig.Save then
            defaultConfig:Save()
        end
        table.insert(allConfigs, 1, "default")
    end
    
    table.sort(allConfigs, function(a, b)
        return a:lower() < b:lower()
    end)
    
    local defaultValue = table.find(allConfigs, CurrentConfigName) and CurrentConfigName or "default"
    
    if ConfigListDropdown and ConfigListDropdown.Refresh then
        ConfigListDropdown:Refresh(allConfigs, defaultValue)
    end
end

ConfigListDropdown = Tabs.Settings:Dropdown({
    Title = "Existing Configs",
        Flag = "ConfigListDropdown",
    Flag = "ConfigListDropdown",
    Desc = "Select from saved configs",
    Values = {"default"},
    Value = "default",
    Callback = function(value)
        CurrentConfigName = value
        ConfigNameInput:Set(value)
        
        if AutoLoadEnabled then
            AutoLoadConfig = value
            saveAutoLoadSettings()
        end
        
        local config = ConfigManager:GetConfig(value)
        if config then
            WindUI:Notify({
                Title = "Config Selected",
                Content = "Config '" .. value .. "' selected",
                Duration = 2
            })
        end
    end
})

Tabs.Settings:Space()

local SaveConfigButton = Tabs.Settings:Button({
    Title = "Save Config",
    Desc = "Save current settings to config",
    Icon = "save",
    Callback = function()
        if CurrentConfigName == "" then
            WindUI:Notify({
                Title = "Error",
                Content = "Please enter a config name",
                Duration = 3
            })
            return
        end
        
        Window.CurrentConfig = ConfigManager:Config(CurrentConfigName)
        
        local success = Window.CurrentConfig:Save()
        if success then
            WindUI:Notify({
                Title = "Config Saved",
                Content = "Config '" .. CurrentConfigName .. "' saved successfully",
                Duration = 3
            })
            
            if AutoLoadEnabled then
                AutoLoadConfig = CurrentConfigName
                saveAutoLoadSettings()
            end
            
            task.wait(0.5)
            refreshConfigList()
        else
            WindUI:Notify({
                Title = "Error",
                Content = "Failed to save config",
                Duration = 3
            })
        end
    end
})

Tabs.Settings:Space()

local LoadConfigButton = Tabs.Settings:Button({
    Title = "Load Config",
    Desc = "Load settings from selected config",
    Icon = "folder-open",
    Callback = function()
        if CurrentConfigName == "" then
            WindUI:Notify({
                Title = "Error",
                Content = "Please enter a config name",
                Duration = 3
            })
            return
        end
        
        Window.CurrentConfig = ConfigManager:CreateConfig(CurrentConfigName)
        
        local success = Window.CurrentConfig:Load()
        if success then
            WindUI:Notify({
                Title = "Config Loaded",
                Content = "Config '" .. CurrentConfigName .. "' loaded successfully",
                Duration = 3
            })
            
            if AutoLoadEnabled then
                AutoLoadConfig = CurrentConfigName
                saveAutoLoadSettings()
            end
        else
            WindUI:Notify({
                Title = "Error",
                Content = "Config '" .. CurrentConfigName .. "' not found or empty",
                Duration = 3
            })
        end
    end
})

Tabs.Settings:Space()

local DeleteConfigButton = Tabs.Settings:Button({
    Title = "Delete Config",
    Desc = "Delete selected config",
    Icon = "trash-2",
    Color = Color3.fromHex("#ff4830"),
    Callback = function()
        if CurrentConfigName == "default" then
            WindUI:Notify({
                Title = "Error",
                Content = "Cannot delete default config",
                Duration = 3
            })
            return
        end
        
        local success = ConfigManager:DeleteConfig(CurrentConfigName)
        if success then
            WindUI:Notify({
                Title = "Config Deleted",
                Content = "Config '" .. CurrentConfigName .. "' deleted",
                Duration = 3
            })
            
            CurrentConfigName = "default"
            ConfigNameInput:Set("default")
            
            if AutoLoadEnabled then
                AutoLoadConfig = "default"
                saveAutoLoadSettings()
            end
            
            task.wait(0.5)
            refreshConfigList()
        else
            WindUI:Notify({
                Title = "Error",
                Content = "Failed to delete config or config doesn't exist",
                Duration = 3
            })
        end
    end
})

Tabs.Settings:Space()

local RefreshConfigButton = Tabs.Settings:Button({
    Title = "Refresh Config List",
    Desc = "Update the list of available configs",
    Icon = "refresh-cw",
    Callback = function()
        refreshConfigList()
        WindUI:Notify({
            Title = "Config List Refreshed",
            Content = "Config list updated",
            Duration = 2
        })
    end
})

task.spawn(function()
    task.wait(0.5) 
    refreshConfigList()
    
    -- Automatically set "default" config in the input box
    ConfigNameInput:Set("default")
    
    if AutoLoadEnabled then
        CurrentConfigName = AutoLoadConfig
        ConfigNameInput:Set(CurrentConfigName)
        
        task.wait(1)
        Window.CurrentConfig = ConfigManager:Config(CurrentConfigName)
        
        if Window.CurrentConfig:Load() then
            WindUI:Notify({
                Title = "Auto-Loaded",
                Content = "Config '" .. CurrentConfigName .. "' loaded automatically",
                Duration = 3
            })
        end
    end
end)

-- Start auto-save loop if enabled on startup
if AutoSaveEnabled then
    task.spawn(function()
        task.wait(1)
        
        if AutoSaveEnabled then
            -- Start auto-save loop
            AutoSaveConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if AutoSaveEnabled and CurrentConfigName ~= "" then
                    task.spawn(function()
                        Window.CurrentConfig = ConfigManager:Config(CurrentConfigName)
                        Window.CurrentConfig:Save()
                    end)
                end
                task.wait(1) -- Save every second
            end)
        end
    end)
end
Tabs.Settings:Dropdown({
    Title = "Select Theme",
    Values = {"Dark", "Light", "Blue", "Red", "Green", "Purple"},
    Value = "Dark",
    Callback = function(value)
        WindUI:SetTheme(value)
    end
})

Tabs.Settings:Slider({
    Title = "Window Transparency",
    Value = { Min = 0, Max = 1, Default = 0.2, Step = 0.1 },
    Callback = function(value)
        WindUI.TransparencyValue = value
    end
})
    Tabs.Settings:Section({ Title = "Keybinds" })
        Tabs.Settings:Keybind({
        Flag = "Keybind",
        Title = "Keybind",
        Desc = "Keybind to open ui",
        Value = "RightControl",
        Callback = function(RightControl)
            Window:SetToggleKey(Enum.KeyCode[RightControl])
        end
    })
    Tabs.Settings:Keybind({
    Title = "Invisible Toggle",
    Desc = "Keybind to toggle invisible mode",
    Value = "I",
    Callback = function(v)
        vu9 = not vu9
        
        gui = game:GetService("CoreGui"):FindFirstChild("InvisibleGui")
        if gui then
            button = gui:FindFirstChild("InvisibleButton", true)
            if button then
                if vu9 then
                    button.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
                    button.Text = "ON"
                else
                    button.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
                    button.Text = "OFF"
                end
            end
        end
        
        v34, v35, v36 = pairs(vu10)
        while true do
            v37 = nil
            v36, v37 = v34(v35, v36)
            if v36 == nil then
                break
            end
            v37.Transparency = v37.Transparency == 0 and 0.5 or 0
        end
    end
})
Tabs.Utility:Slider({
    Title = "Invisible GUI Scale",
    Desc = "Adjust GUI scale",
    Step = 0.01,
    Value = { Min = 0.5, Max = 2, Default = 1 },
    Callback = function(v)
        gui = game:GetService("CoreGui"):FindFirstChild("InvisibleGui")
        if gui then
            if not gui:FindFirstChild("GuiScale") then
                local uIScale = Instance.new("UIScale")
                uIScale.Name = "GuiScale"
                uIScale.Parent = gui
            end
            gui:FindFirstChild("GuiScale").Scale = v
        end
    end
})
    do
     InviteCode = "ny6pJgnR6c"
     DiscordAPI = "https://discord.com/api/v10/invites/" .. InviteCode .. "?with_counts=true&with_expiration=true"

     success = pcall(function()
        Response = game:GetService("HttpService"):JSONDecode(request({
            Url = DiscordAPI,
            Method = "GET"
        }).Body)
        return Response
    end)
    
    if success and Response and Response.guild then
        Tabs.Info:Section({
            Title = "Join My Discord Server",
            TextSize = 20,
        })
         DiscordServerParagraph = Tabs.Info:Paragraph({
            Title = tostring(Response.guild.name),
        Flag = "DiscordServerParagraph",
            Desc = tostring(Response.guild.description),
            Image = "https://cdn.discordapp.com/icons/" .. Response.guild.id .. "/" .. Response.guild.icon .. ".png?size=1024",
            -- Thumbnail = "https://cdn.discordapp.com/banners/1300692552005189632/35981388401406a4b7dffd6f447a64c4.png?size=512",
            ImageSize = 48,
            Buttons = {
                {
                    Title = "Copy link",
                    Icon = "link",
                    Callback = function()
                        setclipboard("https://discord.gg/" .. InviteCode)
                    end
                }
            }
        })
    end
end
loadstring(game:HttpGet('https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Teleport_UI_gag.lua'))()