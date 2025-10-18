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
            ["SPEED_HACK"] = "Speed Hack",
            ["PLAYER_NAME_ESP"] = "Player Name ESP",
            ["PLAYER_BOX_ESP"] = "Player Box ESP",
            ["BOX_TYPE"] = "Box Type",
            ["PLAYER_TRACER"] = "Player Tracer",
            ["PLAYER_DISTANCE_ESP"] = "Player Distance ESP",
            ["HIGHLIGHTS"] = "Highlights",
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

local keybindFile = "keybind_config.txt"

local function getCleanKeyName(keyCode)
    local keyString = tostring(keyCode)
    return keyString:gsub("Enum%.KeyCode%.", "")
end

local function saveKeybind(keyCode)
    writefile(keybindFile, tostring(keyCode))
end

local function loadKeybind()
    if isfile(keybindFile) then
        local savedKey = readfile(keybindFile)
        for _, key in pairs(Enum.KeyCode:GetEnumItems()) do
            if tostring(key) == savedKey then
                return key
            end
        end
    end
    return Enum.KeyCode.RightControl
end

local initialKey = loadKeybind()
local initialKeyName = getCleanKeyName(initialKey)
Window:SetToggleKey(initialKey)

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local originalGameGravity = workspace.Gravity
local player = Players.LocalPlayer
local placeId = game.PlaceId
local jobId = game.JobId
local playerGui = player:WaitForChild("PlayerGui")

local featureStates = {
    InfiniteJump = false,
    Fly = false,
    TPWALK = false,
    JumpBoost = false,
    AntiAFK = false,
    FullBright = false,
    NoFog = false,
    SpeedHack = false,
    FlySpeed = 5,
    TpwalkValue = 1,
    JumpPower = 5,
    JumpMethod = "Hold",
    Speed = 16,
    PlayerESP = {
        name = false,
        box = false,
        tracer = false,
        distance = false,
        highlights = false,
        boxType = "2D"
    }
}

local flying = false
local bodyVelocity, bodyGyro
local ToggleTpwalk = false
local TpwalkConnection
local AntiAFKConnection
local isJumpHeld = false
local antiAFKConnection = nil
local playerEspElements = {}
local espConnection

local function getServerLink()
    return "https://www.roblox.com/games/" .. placeId .. "/" .. jobId
end

local function rejoinServer()
    TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
end

local function serverHop()
    local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
    local randomServer = servers.data[math.random(1, #servers.data)]
    TeleportService:TeleportToPlaceInstance(placeId, randomServer.id, player)
end

local function hopToSmallServer()
    local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
    table.sort(servers.data, function(a, b) return a.playing < b.playing end)
    if servers.data[1] then
        TeleportService:TeleportToPlaceInstance(placeId, servers.data[1].id, player)
    end
end

local function startAntiAFK()
    if antiAFKConnection then return end
    antiAFKConnection = RunService.Heartbeat:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

local function stopAntiAFK()
    if antiAFKConnection then
        antiAFKConnection:Disconnect()
        antiAFKConnection = nil
    end
end

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

-- Create Tabs
local MainTab = Window:Tab({
    Icon = "home",
    Title = "Main"
})

local PlayerTab = Window:Tab({
    Icon = "user",
    Title = "loc:Player_TAB"
})

local VisualsTab = Window:Tab({
    Icon = "eye",
    Title = "loc:VISUALS_TAB"
})

local ESPTab = Window:Tab({
    Icon = "target",
    Title = "loc:ESP_TAB"
})

local SettingsTab = Window:Tab({
    Icon = "settings",
    Title = "loc:SETTINGS_TAB"
})

-- Main Tab
MainTab:Section({ Title = "Server Info", TextSize = 20 })
MainTab:Divider()

local placeName = "Unknown"
local success, productInfo = pcall(function()
    return MarketplaceService:GetProductInfo(placeId)
end)
if success and productInfo then
    placeName = productInfo.Name
end

MainTab:Paragraph({
    Title = "Game Mode",
    Desc = placeName
})

MainTab:Button({
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
            Content = "The server invite link has been copied to your clipboard",
            Duration = 3
        })
    end
})

local numPlayers = #Players:GetPlayers()
local maxPlayers = Players.MaxPlayers

MainTab:Paragraph({
    Title = "Current Players",
    Desc = numPlayers .. " / " .. maxPlayers
})

MainTab:Paragraph({
    Title = "Server ID",
    Desc = jobId
})

MainTab:Paragraph({
    Title = "Place ID",
    Desc = tostring(placeId)
})

MainTab:Section({ Title = "Server Tools", TextSize = 20 })
MainTab:Divider()

MainTab:Button({
    Title = "Rejoin",
    Desc = "Rejoin the current place",
    Icon = "refresh-cw",
    Callback = function()
        rejoinServer()
    end
})

MainTab:Button({
    Title = "Server Hop",
    Desc = "Hop to a random server",
    Icon = "shuffle",
    Callback = function()
        serverHop()
    end
})

MainTab:Button({
    Title = "Hop to Small Server",
    Desc = "Hop to the smallest available server",
    Icon = "minimize",
    Callback = function()
        hopToSmallServer()
    end
})

MainTab:Button({
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

MainTab:Section({ Title = "Misc", TextSize = 20 })
MainTab:Divider()

local AntiAFKToggle = MainTab:Toggle({
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

-- Player Tab
PlayerTab:Section({ Title = "loc:FEATURES", TextSize = 40 })
PlayerTab:Section({ Title = "Movement and Player Features", TextSize = 20 })
PlayerTab:Divider()

local InfiniteJumpToggle = PlayerTab:Toggle({
    Title = "loc:INFINITE_JUMP",
    Value = false,
    Callback = function(state)
        featureStates.InfiniteJump = state
    end
})

local JumpMethodDropdown = PlayerTab:Dropdown({
    Title = "loc:JUMP_METHOD",
    Values = {"Hold", "Toggle"},
    Value = "Hold",
    Callback = function(value)
        featureStates.JumpMethod = value
    end
})

local FlyToggle = PlayerTab:Toggle({
    Title = "loc:FLY",
    Value = false,
    Callback = function(state)
        featureStates.Fly = state
        if state then
            if character and rootPart then
                flying = true
                bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.Parent = rootPart
                
                bodyGyro = Instance.new("BodyGyro")
                bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
                bodyGyro.CFrame = rootPart.CFrame
                bodyGyro.Parent = rootPart
            end
        else
            flying = false
            if bodyVelocity then bodyVelocity:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end
        end
    end
})

local FlySpeedSlider = PlayerTab:Slider({
    Title = "loc:FLY_SPEED",
    Value = { Min = 1, Max = 100, Default = 5 },
    Callback = function(value)
        featureStates.FlySpeed = value
        if flying and bodyVelocity then
            bodyVelocity.Velocity = Vector3.new(0, value, 0)
        end
    end
})

local SpeedHackToggle = PlayerTab:Toggle({
    Title = "loc:SPEED_HACK",
    Value = false,
    Callback = function(state)
        featureStates.SpeedHack = state
        if state and character and humanoid then
            humanoid.WalkSpeed = featureStates.Speed
        else
            if character and humanoid then
                humanoid.WalkSpeed = 16
            end
        end
    end
})

local SpeedSlider = PlayerTab:Slider({
    Title = "Speed Value",
    Value = { Min = 16, Max = 500, Default = 16 },
    Callback = function(value)
        featureStates.Speed = value
        if featureStates.SpeedHack and character and humanoid then
            humanoid.WalkSpeed = value
        end
    end
})

local TPWALKToggle = PlayerTab:Toggle({
    Title = "loc:TPWALK",
    Value = false,
    Callback = function(state)
        featureStates.TPWALK = state
        ToggleTpwalk = state
        if state then
            TpwalkConnection = RunService.Heartbeat:Connect(function()
                if character and rootPart and humanoid then
                    local moveVector = humanoid.MoveDirection * featureStates.TpwalkValue
                    rootPart.CFrame = rootPart.CFrame + moveVector
                end
            end)
        else
            if TpwalkConnection then
                TpwalkConnection:Disconnect()
                TpwalkConnection = nil
            end
        end
    end
})

local TPWALKSlider = PlayerTab:Slider({
    Title = "loc:TPWALK_VALUE",
    Value = { Min = 1, Max = 100, Default = 1 },
    Callback = function(value)
        featureStates.TpwalkValue = value
    end
})

local JumpBoostToggle = PlayerTab:Toggle({
    Title = "loc:JUMP_HEIGHT",
    Value = false,
    Callback = function(state)
        featureStates.JumpBoost = state
        if character and humanoid then
            humanoid.JumpPower = state and featureStates.JumpPower or 50
        end
    end
})

local JumpBoostSlider = PlayerTab:Slider({
    Title = "loc:JUMP_POWER",
    Value = { Min = 1, Max = 100, Default = 5 },
    Callback = function(value)
        featureStates.JumpPower = value
        if featureStates.JumpBoost and character and humanoid then
            humanoid.JumpPower = value
        end
    end
})

-- Visuals Tab
VisualsTab:Section({ Title = "loc:FEATURES", TextSize = 40 })
VisualsTab:Section({ Title = "Visual Enhancements", TextSize = 20 })
VisualsTab:Divider()

local FullBrightToggle = VisualsTab:Toggle({
    Title = "loc:FULL_BRIGHT",
    Value = false,
    Callback = function(state)
        featureStates.FullBright = state
        if state then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        else
            Lighting.Brightness = 1
            Lighting.ClockTime = 12
            Lighting.FogEnd = 100
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.fromRGB(64, 64, 64)
        end
    end
})

local NoFogToggle = VisualsTab:Toggle({
    Title = "loc:NO_FOG",
    Value = false,
    Callback = function(state)
        featureStates.NoFog = state
        Lighting.FogEnd = state and 100000 or 100
    end
})

-- ESP Tab
ESPTab:Section({ Title = "Player ESP", TextSize = 20 })
ESPTab:Divider()

local PlayerNameESPToggle = ESPTab:Toggle({
    Title = "loc:PLAYER_NAME_ESP",
    Value = false,
    Callback = function(state)
        featureStates.PlayerESP.name = state
    end
})

local PlayerBoxESPToggle = ESPTab:Toggle({
    Title = "loc:PLAYER_BOX_ESP",
    Value = false,
    Callback = function(state)
        featureStates.PlayerESP.box = state
    end
})

local BoxTypeDropdown = ESPTab:Dropdown({
    Title = "loc:BOX_TYPE",
    Values = {"2D", "3D"},
    Value = "2D",
    Callback = function(value)
        featureStates.PlayerESP.boxType = value
    end
})

local PlayerTracerToggle = ESPTab:Toggle({
    Title = "loc:PLAYER_TRACER",
    Value = false,
    Callback = function(state)
        featureStates.PlayerESP.tracer = state
    end
})

local PlayerDistanceESPToggle = ESPTab:Toggle({
    Title = "loc:PLAYER_DISTANCE_ESP",
    Value = false,
    Callback = function(state)
        featureStates.PlayerESP.distance = state
    end
})

local HighlightsToggle = ESPTab:Toggle({
    Title = "loc:HIGHLIGHTS",
    Value = false,
    Callback = function(state)
        featureStates.PlayerESP.highlights = state
        if state then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    local highlight = plr.Character:FindFirstChild("Highlight")
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Parent = plr.Character
                        highlight.FillColor = Color3.new(0, 1, 0)
                        highlight.OutlineColor = Color3.new(1, 1, 1)
                    end
                    highlight.Enabled = true
                end
            end
        else
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    local highlight = plr.Character:FindFirstChild("Highlight")
                    if highlight then
                        highlight.Enabled = false
                    end
                end
            end
        end
    end
})

-- ESP Implementation
local function createEspElements(plr)
    if plr == player then return end
    playerEspElements[plr] = {
        name = Drawing.new("Text"),
        box = Drawing.new("Square"),
        tracer = Drawing.new("Line"),
        distance = Drawing.new("Text")
    }
    playerEspElements[plr].name.Size = 16
    playerEspElements[plr].name.Center = true
    playerEspElements[plr].name.Outline = true
    playerEspElements[plr].name.Color = Color3.new(1, 1, 1)
    playerEspElements[plr].box.Size = Vector2.new(0, 0)
    playerEspElements[plr].box.Color = Color3.new(0, 1, 0)
    playerEspElements[plr].box.Thickness = 2
    playerEspElements[plr].box.Filled = false
    playerEspElements[plr].tracer.Color = Color3.new(0, 1, 0)
    playerEspElements[plr].tracer.Thickness = 1
    playerEspElements[plr].distance.Size = 16
    playerEspElements[plr].distance.Center = true
    playerEspElements[plr].distance.Outline = true
    playerEspElements[plr].distance.Color = Color3.new(1, 1, 1)
end

local function updateEsp()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local char = plr.Character
            local hrp = char.HumanoidRootPart
            local vector, onScreen = camera:WorldToViewportPoint(hrp.Position)
            if not playerEspElements[plr] then
                createEspElements(plr)
            end
            local esp = playerEspElements[plr]
            if onScreen then
                local head = char:FindFirstChild("Head")
                if head then
                    local top = camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local leg = camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                    local height = top.Y - leg.Y
                    local width = height / 2
                end
                local size = (leg.Y - top.Y)
                local width = size / 2
                if featureStates.PlayerESP.name then
                    esp.name.Text = plr.Name
                    esp.name.Position = Vector2.new(vector.X, top.Y - 16)
                    esp.name.Visible = true
                else
                    esp.name.Visible = false
                end
                if featureStates.PlayerESP.box then
                    if featureStates.PlayerESP.boxType == "2D" then
                        esp.box.Size = Vector2.new(width * 2, size)
                        esp.box.Position = Vector2.new(vector.X - width, top.Y)
                        esp.box.Visible = true
                    else
                        -- 3D box implementation would go here
                        esp.box.Visible = false
                    end
                else
                    esp.box.Visible = false
                end
                if featureStates.PlayerESP.tracer then
                    esp.tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                    esp.tracer.To = Vector2.new(vector.X, vector.Y)
                    esp.tracer.Visible = true
                else
                    esp.tracer.Visible = false
                end
                if featureStates.PlayerESP.distance then
                    local dist = (rootPart.Position - hrp.Position).Magnitude
                    esp.distance.Text = math.floor(dist) .. "m"
                    esp.distance.Position = Vector2.new(vector.X, vector.Y + size / 2 + 16)
                    esp.distance.Visible = true
                else
                    esp.distance.Visible = false
                end
            else
                esp.name.Visible = false
                esp.box.Visible = false
                esp.tracer.Visible = false
                esp.distance.Visible = false
            end
        else
            if playerEspElements[plr] then
                for _, obj in pairs(playerEspElements[plr]) do
                    obj.Visible = false
                end
            end
        end
    end
end

espConnection = RunService.Heartbeat:Connect(updateEsp)

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        wait(1)
    end)
end)

-- Settings Tab
SettingsTab:Section({ Title = "Settings", TextSize = 40 })
SettingsTab:Section({ Title = "Personalize", TextSize = 20 })
SettingsTab:Divider()

local themes = {}
for themeName, _ in pairs(WindUI:GetThemes()) do
    table.insert(themes, themeName)
end
table.sort(themes)

local canChangeTheme = true
local canChangeDropdown = true

local ThemeDropdown = SettingsTab:Dropdown({
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

local TransparencySlider = SettingsTab:Slider({
    Title = "loc:TRANSPARENCY",
    Value = { Min = 0, Max = 1, Default = 0.2, Step = 0.1 },
    Callback = function(value)
        WindUI.TransparencyValue = tonumber(value)
        Window:ToggleTransparency(tonumber(value) > 0)
    end
})

local ThemeToggle = SettingsTab:Toggle({
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

SettingsTab:Section({ Title = "Configuration Manager", TextSize = 20 })
SettingsTab:Section({ Title = "Save and load your settings", TextSize = 16, TextTransparency = 0.25 })
SettingsTab:Divider()

local ConfigNameInput = SettingsTab:Input({
    Title = "Config Name",
    Value = configName,
    Callback = function(value)
        configName = value or "default"
    end
})

local ConfigManager = Window.ConfigManager
if ConfigManager then
    ConfigManager:Init(Window)
    
    SettingsTab:Button({
        Title = "loc:SAVE_CONFIG",
        Icon = "save",
        Variant = "Primary",
        Callback = function()
            configFile = ConfigManager:CreateConfig(configName)
            configFile:Register("InfiniteJumpToggle", InfiniteJumpToggle)
            configFile:Register("JumpMethodDropdown", JumpMethodDropdown)
            configFile:Register("FlyToggle", FlyToggle)
            configFile:Register("FlySpeedSlider", FlySpeedSlider)
            configFile:Register("SpeedHackToggle", SpeedHackToggle)
            configFile:Register("SpeedSlider", SpeedSlider)
            configFile:Register("TPWALKToggle", TPWALKToggle)
            configFile:Register("TPWALKSlider", TPWALKSlider)
            configFile:Register("JumpBoostToggle", JumpBoostToggle)
            configFile:Register("JumpBoostSlider", JumpBoostSlider)
            configFile:Register("AntiAFKToggle", AntiAFKToggle)
            configFile:Register("FullBrightToggle", FullBrightToggle)
            configFile:Register("NoFogToggle", NoFogToggle)
            configFile:Register("PlayerNameESPToggle", PlayerNameESPToggle)
            configFile:Register("PlayerBoxESPToggle", PlayerBoxESPToggle)
            configFile:Register("BoxTypeDropdown", BoxTypeDropdown)
            configFile:Register("PlayerTracerToggle", PlayerTracerToggle)
            configFile:Register("PlayerDistanceESPToggle", PlayerDistanceESPToggle)
            configFile:Register("HighlightsToggle", HighlightsToggle)
            configFile:Register("ThemeDropdown", ThemeDropdown)
            configFile:Register("TransparencySlider", TransparencySlider)
            configFile:Register("ThemeToggle", ThemeToggle)
            configFile:Save()
            WindUI:Notify({
                Title = "Config Saved",
                Content = "Configuration saved successfully.",
                Duration = 2
            })
        end
    })

    SettingsTab:Button({
        Title = "loc:LOAD_CONFIG",
        Icon = "folder",
        Callback = function()
            configFile = ConfigManager:CreateConfig(configName)
            local loadedData = configFile:Load()
            if loadedData then
                if loadedData.InfiniteJumpToggle then InfiniteJumpToggle:Set(loadedData.InfiniteJumpToggle) end
                if loadedData.JumpMethodDropdown then JumpMethodDropdown:Select(loadedData.JumpMethodDropdown) end
                if loadedData.FlyToggle then FlyToggle:Set(loadedData.FlyToggle) end
                if loadedData.FlySpeedSlider then FlySpeedSlider:Set(loadedData.FlySpeedSlider) end
                if loadedData.SpeedHackToggle then SpeedHackToggle:Set(loadedData.SpeedHackToggle) end
                if loadedData.SpeedSlider then SpeedSlider:Set(loadedData.SpeedSlider) end
                if loadedData.TPWALKToggle then TPWALKToggle:Set(loadedData.TPWALKToggle) end
                if loadedData.TPWALKSlider then TPWALKSlider:Set(loadedData.TPWALKSlider) end
                if loadedData.JumpBoostToggle then JumpBoostToggle:Set(loadedData.JumpBoostToggle) end
                if loadedData.JumpBoostSlider then JumpBoostSlider:Set(loadedData.JumpBoostSlider) end
                if loadedData.AntiAFKToggle then AntiAFKToggle:Set(loadedData.AntiAFKToggle) end
                if loadedData.FullBrightToggle then FullBrightToggle:Set(loadedData.FullBrightToggle) end
                if loadedData.NoFogToggle then NoFogToggle:Set(loadedData.NoFogToggle) end
                if loadedData.PlayerNameESPToggle then PlayerNameESPToggle:Set(loadedData.PlayerNameESPToggle) end
                if loadedData.PlayerBoxESPToggle then PlayerBoxESPToggle:Set(loadedData.PlayerBoxESPToggle) end
                if loadedData.BoxTypeDropdown then BoxTypeDropdown:Select(loadedData.BoxTypeDropdown) end
                if loadedData.PlayerTracerToggle then PlayerTracerToggle:Set(loadedData.PlayerTracerToggle) end
                if loadedData.PlayerDistanceESPToggle then PlayerDistanceESPToggle:Set(loadedData.PlayerDistanceESPToggle) end
                if loadedData.HighlightsToggle then HighlightsToggle:Set(loadedData.HighlightsToggle) end
                if loadedData.ThemeDropdown then ThemeDropdown:Select(loadedData.ThemeDropdown) end
                if loadedData.TransparencySlider then TransparencySlider:Set(loadedData.TransparencySlider) end
                if loadedData.ThemeToggle ~= nil then ThemeToggle:Set(loadedData.ThemeToggle) end
                WindUI:Notify({
                    Title = "Config Loaded",
                    Content = "Configuration loaded successfully.",
                    Duration = 2
                })
            else
                WindUI:Notify({
                    Title = "Config Error",
                    Content = "No configuration found.",
                    Duration = 2
                })
            end
        end
    })
else
    SettingsTab:Paragraph({
        Title = "Config Manager Not Available",
        Desc = "This feature requires ConfigManager",
        Image = "alert-triangle",
        ImageSize = 20,
        Color = "White"
    })
end

-- Keybind Settings
SettingsTab:Section({ Title = "Keybind Settings", TextSize = 20 })
SettingsTab:Section({ Title = "Change toggle key for GUI", TextSize = 16, TextTransparency = 0.25 })
SettingsTab:Divider()

SettingsTab:Keybind({
    Flag = "keybind ui toggles",
    Title = "Keybind",
    Desc = "Keybind to open ui",
    Value = initialKeyName,
    Callback = function(v)
        local keyCode = Enum.KeyCode[v]
        Window:SetToggleKey(keyCode)
        saveKeybind(keyCode)
    end
})

-- Implementations
UserInputService.JumpRequest:Connect(function()
    if featureStates.InfiniteJump then
        if featureStates.JumpMethod == "Hold" then
            isJumpHeld = true
        elseif featureStates.JumpMethod == "Toggle" then
            featureStates.InfiniteJump = not featureStates.InfiniteJump
            InfiniteJumpToggle:Set(featureStates.InfiniteJump)
        end
        if character and humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        isJumpHeld = false
    end
end)

RunService.Heartbeat:Connect(function()
    if featureStates.InfiniteJump and isJumpHeld and character and humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
    
    if flying and bodyVelocity and bodyGyro and rootPart then
        local moveVector = humanoid.MoveDirection * featureStates.FlySpeed
        bodyVelocity.Velocity = Vector3.new(moveVector.X, featureStates.FlySpeed, moveVector.Z)
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
    end
    
    if character and humanoid then
        if featureStates.SpeedHack then
            humanoid.WalkSpeed = featureStates.Speed
        end
    end
    
    updateEsp()
end)

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    if featureStates.SpeedHack then
        humanoid.WalkSpeed = featureStates.Speed
    end
end)

Window:SelectTab(1)

Window:UnlockAll()

Window:OnClose(function()
    print("Press " .. initialKeyName .. " To Reopen")
    if not game:GetService("UserInputService").TouchEnabled then
        pcall(function()
            WindUI:Notify({
                Title = "GUI Closed",
                Content = "Press " .. initialKeyName .. " To Reopen",
                Duration = 3
            })
        end)
    end
end)

Window:OnOpen(function()
    print("Window opened")
end)
