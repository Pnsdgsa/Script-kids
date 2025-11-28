local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local playerGui = player.PlayerGui
local frame = playerGui:WaitForChild("Teleport_UI"):WaitForChild("Frame")

local SCALE_FACTOR = 0.7
local COSMETICS_SCALE_FACTOR = 0.5

local function scaleUDim2(udim2, scale)
    return UDim2.new(udim2.X.Scale * scale, udim2.X.Offset * scale, udim2.Y.Scale * scale, udim2.Y.Offset * scale)
end

local function scaleVector2(vector2, scale)
    return Vector2.new(vector2.X * scale, vector2.Y * scale)
end

frame.Size = scaleUDim2(UDim2.new(0.4, 0, 0.085, 0), SCALE_FACTOR)

local function ensureSizeConstraint(uiElement, minSize)
    local sizeConstraint = uiElement:FindFirstChildOfClass("UISizeConstraint")
    if not sizeConstraint then
        sizeConstraint = Instance.new("UISizeConstraint")
        sizeConstraint.Parent = uiElement
    end
    sizeConstraint.MinSize = scaleVector2(minSize, SCALE_FACTOR)
end

local function removeHoverEffects(button)
    button.HoverImage = ""
    button.PressedImage = ""
    button.AutoButtonColor = false
    
    local hoverEffects = button:FindFirstChild("HoverEffects")
    if hoverEffects then
        hoverEffects:Destroy()
    end
    
    local clickEffects = button:FindFirstChild("ClickEffects")
    if clickEffects then
        clickEffects:Destroy()
    end
end

local sellButton = frame:WaitForChild("Sell")
sellButton.Size = scaleUDim2(UDim2.new(0.22, 0, 0.791, 0), SCALE_FACTOR)
ensureSizeConstraint(sellButton, Vector2.new(50, 1))
removeHoverEffects(sellButton)

local seedsButton = frame:WaitForChild("Seeds")
seedsButton.Size = scaleUDim2(UDim2.new(0.22, 0, 0.791, 0), SCALE_FACTOR)
ensureSizeConstraint(seedsButton, Vector2.new(50, 1))
removeHoverEffects(seedsButton)

local gardenButton = frame:WaitForChild("Garden")
gardenButton.Size = scaleUDim2(UDim2.new(0.35, 0, 0.985, 0), SCALE_FACTOR)
ensureSizeConstraint(gardenButton, Vector2.new(100, 1))
removeHoverEffects(gardenButton)

local petsButton = frame:WaitForChild("Pets")
removeHoverEffects(petsButton)

local gearButton = frame:WaitForChild("Gear")
removeHoverEffects(gearButton)

local cosmeticsCraftingButton = frame:FindFirstChild("COSMETICS_and_crafting") or gearButton:Clone()
cosmeticsCraftingButton.Name = "COSMETICS_and_crafting"
cosmeticsCraftingButton.Size = scaleUDim2(UDim2.new(0.35, 0, 0.985, 0), COSMETICS_SCALE_FACTOR)
cosmeticsCraftingButton.Position = scaleUDim2(UDim2.new(0, 0, 0, 250), COSMETICS_SCALE_FACTOR)
cosmeticsCraftingButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
cosmeticsCraftingButton.BackgroundTransparency = 0
cosmeticsCraftingButton.Image = ""
cosmeticsCraftingButton.Visible = false
removeHoverEffects(cosmeticsCraftingButton)

local gearVisibility = cosmeticsCraftingButton:FindFirstChild("GearVisiblity")
if gearVisibility then
    gearVisibility:Destroy()
end

local cosmeticsCraftingStroke = cosmeticsCraftingButton:FindFirstChild("UIStroke") or Instance.new("UIStroke")
cosmeticsCraftingStroke.Name = "UIStroke"
cosmeticsCraftingStroke.Color = Color3.fromRGB(100, 0, 100)
cosmeticsCraftingStroke.Thickness = 1 * COSMETICS_SCALE_FACTOR
cosmeticsCraftingStroke.Parent = cosmeticsCraftingButton

local cosmeticsCraftingTextLabel = cosmeticsCraftingButton:FindFirstChild("Txt")
if cosmeticsCraftingTextLabel and cosmeticsCraftingTextLabel:IsA("TextLabel") then
    cosmeticsCraftingTextLabel.Text = "COSM/CRAFT"
    cosmeticsCraftingTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    cosmeticsCraftingTextLabel.TextSize = cosmeticsCraftingTextLabel.TextSize * COSMETICS_SCALE_FACTOR
else
    cosmeticsCraftingTextLabel = Instance.new("TextLabel")
    cosmeticsCraftingTextLabel.Name = "Txt"
    cosmeticsCraftingTextLabel.Text = "COSM/CRAFT"
    cosmeticsCraftingTextLabel.Size = UDim2.new(1, 0, 1, 0)
    cosmeticsCraftingTextLabel.BackgroundTransparency = 1
    cosmeticsCraftingTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    cosmeticsCraftingTextLabel.TextScaled = true
    cosmeticsCraftingTextLabel.Parent = cosmeticsCraftingButton
end

local textStroke = cosmeticsCraftingTextLabel:FindFirstChild("UIStroke") or Instance.new("UIStroke")
textStroke.Name = "UIStroke"
textStroke.Color = Color3.fromRGB(58, 0, 0)
textStroke.Thickness = 1 * COSMETICS_SCALE_FACTOR
textStroke.Parent = cosmeticsCraftingTextLabel

ensureSizeConstraint(cosmeticsCraftingButton, Vector2.new(100, 1))
cosmeticsCraftingButton.Parent = frame

local eventButton = frame:FindFirstChild("Event") or gardenButton:Clone()
eventButton.Name = "Event"
eventButton.Size = scaleUDim2(UDim2.new(0.35, 0, 0.985, 0), SCALE_FACTOR)
eventButton.Position = scaleUDim2(UDim2.new(0, 0, 0, 200), SCALE_FACTOR)
eventButton.Image = "rbxassetid://110208924430993"
removeHoverEffects(eventButton)

local eventTextLabel = eventButton:FindFirstChild("Txt")
if eventTextLabel and eventTextLabel:IsA("TextLabel") then
    eventTextLabel.Text = "EVENT"
    eventTextLabel.TextSize = eventTextLabel.TextSize * SCALE_FACTOR
else
    eventTextLabel = Instance.new("TextLabel")
    eventTextLabel.Name = "Txt"
    eventTextLabel.Text = "EVENT"
    eventTextLabel.Size = UDim2.new(1, 0, 1, 0)
    eventTextLabel.BackgroundTransparency = 1
    eventTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    eventTextLabel.TextScaled = true
    eventTextLabel.Parent = eventButton
end

ensureSizeConstraint(eventButton, Vector2.new(100, 1))
eventButton.Parent = frame

petsButton.Size = scaleUDim2(petsButton.Size, SCALE_FACTOR)
gearButton.Size = scaleUDim2(gearButton.Size, SCALE_FACTOR)

local function scaleButtonText(button)
    local textLabel = button:FindFirstChild("Txt")
    if textLabel and textLabel:IsA("TextLabel") then
        if not textLabel.TextScaled then
            textLabel.TextSize = textLabel.TextSize * SCALE_FACTOR
        end
    end
end

scaleButtonText(petsButton)
scaleButtonText(gearButton)
scaleButtonText(sellButton)
scaleButtonText(seedsButton)
scaleButtonText(gardenButton)

petsButton.Visible = true
gearButton.Visible = true
gardenButton.Visible = true
eventButton.Visible = true
task.spawn(function()
    task.wait(0)
    cosmeticsCraftingButton.Visible = true
end)

local function teleportToObject(object)
    if object then
        local targetPosition
        if object:IsA("Model") and object.PrimaryPart then
            targetPosition = object.PrimaryPart.Position
        else
            local parts = object:GetDescendants()
            local totalPosition = Vector3.new(0, 0, 0)
            local partCount = 0
            for _, descendant in pairs(parts) do
                if descendant:IsA("BasePart") then
                    totalPosition = totalPosition + descendant.Position
                    partCount = partCount + 1
                end
            end
            if partCount > 0 then
                targetPosition = totalPosition / partCount
            else
                local firstPart = object:FindFirstChildWhichIsA("BasePart")
                if firstPart then
                    targetPosition = firstPart.Position
                else
                    return nil
                end
            end
        end
        return targetPosition
    end
    return nil
end

local function teleportToRandomUpdateItem()
    local updateItems = workspace:WaitForChild("Interaction"):WaitForChild("UpdateItems")
    if updateItems then
        local children = updateItems:GetChildren()
        if #children > 0 then
            local randomObject = children[math.random(1, #children)]
            local targetPosition = teleportToObject(randomObject)
            if targetPosition then
                if character and humanoidRootPart then
                    local yawAngle = math.rad(90)
                    local targetCFrame = CFrame.new(targetPosition + Vector3.new(0, 5, 0)) * CFrame.Angles(0, yawAngle, 0)
                    humanoidRootPart.CFrame = targetCFrame
                    print("Teleported to random UpdateItems object: " .. randomObject.Name .. " at position: " .. tostring(targetPosition))
                else
                    warn("Character or HumanoidRootPart not found!")
                end
            else
                local fallbackObjects = {
                    {object = workspace.CraftingTables, offset = Vector3.new(3, 0, 0)},
                    {object = workspace.NPCS["Pet Stand"], offset = Vector3.new(5, 0, 0)},
                    {object = workspace.NPCS["Gear Stands"], offset = Vector3.new(3, 0, 0)}
                }
                for _, fallback in pairs(fallbackObjects) do
                    if fallback.object then
                        local fallbackPosition = teleportToObject(fallback.object)
                        if fallbackPosition then
                            if character and humanoidRootPart then
                                local yawAngle = math.rad(90)
                                local targetCFrame = CFrame.new(fallbackPosition + fallback.offset) * CFrame.Angles(0, yawAngle, 0)
                                humanoidRootPart.CFrame = targetCFrame
                                warn("Random object failed! Teleported to " .. fallback.object.Name .. " at position: " .. tostring(fallbackPosition))
                                return
                            end
                        end
                    end
                end
                warn("All teleport targets failed!")
            end
        else
            local fallbackObjects = {
                {object = workspace.CraftingTables, offset = Vector3.new(3, 0, 0)},
                {object = workspace.NPCS["Pet Stand"], offset = Vector3.new(5, 0, 0)},
                {object = workspace.NPCS["Gear Stands"], offset = Vector3.new(3, 0, 0)}
            }
            for _, fallback in pairs(fallbackObjects) do
                if fallback.object then
                    local fallbackPosition = teleportToObject(fallback.object)
                    if fallbackPosition then
                        if character and humanoidRootPart then
                            local yawAngle = math.rad(90)
                            local targetCFrame = CFrame.new(fallbackPosition + fallback.offset) * CFrame.Angles(0, yawAngle, 0)
                            humanoidRootPart.CFrame = targetCFrame
                            warn("No objects in UpdateItems! Teleported to " .. fallback.object.Name .. " at position: " .. tostring(fallbackPosition))
                            return
                        end
                    end
                end
            end
            warn("All teleport targets failed!")
        end
    else
        local fallbackObjects = {
            {object = workspace.CraftingTables, offset = Vector3.new(3, 0, 0)},
            {object = workspace.NPCS["Pet Stand"], offset = Vector3.new(5, 0, 0)},
            {object = workspace.NPCS["Gear Stands"], offset = Vector3.new(3, 0, 0)}
        }
        for _, fallback in pairs(fallbackObjects) do
            if fallback.object then
                local fallbackPosition = teleportToObject(fallback.object)
                if fallbackPosition then
                    if character and humanoidRootPart then
                        local yawAngle = math.rad(90)
                        local targetCFrame = CFrame.new(fallbackPosition + fallback.offset) * CFrame.Angles(0, yawAngle, 0)
                        humanoidRootPart.CFrame = targetCFrame
                        warn("UpdateItems not found! Teleported to " .. fallback.object.Name .. " at position: " .. tostring(fallbackPosition))
                        return
                    end
                end
            end
        end
        warn("All teleport targets failed!")
    end
end

local function teleportPlayer(position)
    if character and humanoidRootPart then
        local yawAngle = math.rad(90)
        local targetCFrame = CFrame.new(position) * CFrame.Angles(0, yawAngle, 0)
        humanoidRootPart.CFrame = targetCFrame
    else
        warn("Character or HumanoidRootPart not found!")
    end
end

petsButton.MouseButton1Click:Connect(function()
    local petStand = workspace.NPCS["Pet Stand"]
    if petStand then
        local targetPosition = teleportToObject(petStand)
        if targetPosition then
            teleportPlayer(targetPosition + Vector3.new(5, 0, 0))
        else
            teleportPlayer(Vector3.new(-285, 3, -0))
        end
    else
        teleportPlayer(Vector3.new(-285, 3, -0))
    end
end)

gearButton.MouseButton1Click:Connect(function()
    local gearStands = workspace.NPCS["Gear Stands"]
    if gearStands then
        local targetPosition = teleportToObject(gearStands)
        if targetPosition then
            teleportPlayer(targetPosition + Vector3.new(3, 0, 0))
        else
            teleportPlayer(Vector3.new(-285, 3, -14))
        end
    else
        teleportPlayer(Vector3.new(-285, 3, -14))
    end
end)

eventButton.MouseButton1Click:Connect(function()
    teleportToRandomUpdateItem()
end)

cosmeticsCraftingButton.MouseButton1Click:Connect(function()
    local craftingTables = workspace.CraftingTables
    if craftingTables then
        local targetPosition = teleportToObject(craftingTables)
        if targetPosition then
            teleportPlayer(targetPosition + Vector3.new(3, 0, 0))
        else
            teleportPlayer(Vector3.new(-287, 3, -25))
        end
    else
        teleportPlayer(Vector3.new(-287, 3, -25))
    end
end)
