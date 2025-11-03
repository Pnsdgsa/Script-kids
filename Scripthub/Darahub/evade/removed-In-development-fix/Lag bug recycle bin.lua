

--bhop
getgenv().autoJumpEnabled = false
getgenv().bhopMode = "Acceleration"
getgenv().bhopAccelValue = -0.1

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
        if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
            local gui = LocalPlayer.PlayerGui:FindFirstChild("BhopGui")
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

local BhopGui = LocalPlayer.PlayerGui:FindFirstChild("BhopGui")

if BhopGui then
    BhopGui.Enabled = false
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


-- auto emote removed 


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
EmoteDropdown", EmoteDropdown)
configFile:Register("AutoEmoteToggle", AutoEmoteToggle)

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
