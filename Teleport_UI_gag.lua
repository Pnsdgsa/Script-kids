local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local playerGui = player.PlayerGui
local frame = playerGui:WaitForChild("Teleport_UI"):WaitForChild("Frame")

frame.Size = UDim2.new(0.4, 0, 0.085, 0)

local sellButton = frame:WaitForChild("Sell")
sellButton.Size = UDim2.new(0.22, 0, 0.791, 0)
sellButton.Txt.UISizeConstraint.MinSize = Vector2.new(50, 1)

local seedsButton = frame:WaitForChild("Seeds")
seedsButton.Size = UDim2.new(0.22, 0, 0.791, 0)
seedsButton.Txt.UISizeConstraint.MinSize = Vector2.new(50, 1)

local gardenButton = frame:WaitForChild("Garden")
gardenButton.Size = UDim2.new(0.35, 0, 0.985, 0)
gardenButton.Txt.UISizeConstraint.MinSize = Vector2.new(100, 1)

local petsButton = frame:WaitForChild("Pets")
local gearButton = frame:WaitForChild("Gear")
local cosmeticsCraftingButton = frame:FindFirstChild("COSMETICS_and_crafting") or gearButton:Clone()
cosmeticsCraftingButton.Name = "COSMETICS_and_crafting"
cosmeticsCraftingButton.Position = UDim2.new(0, 0, 0, 250)
cosmeticsCraftingButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
cosmeticsCraftingButton.Visible = false

local gearVisibility = cosmeticsCraftingButton:FindFirstChild("GearVisiblity")
if gearVisibility then
    gearVisibility:Destroy()
end

local cosmeticsCraftingStroke = cosmeticsCraftingButton:FindFirstChild("UIStroke") or Instance.new("UIStroke")
cosmeticsCraftingStroke.Name = "UIStroke"
cosmeticsCraftingStroke.Color = Color3.fromRGB(100, 0, 100)
cosmeticsCraftingStroke.Thickness = 1
cosmeticsCraftingStroke.Parent = cosmeticsCraftingButton
local cosmeticsCraftingTextLabel = cosmeticsCraftingButton:FindFirstChild("Txt")
if cosmeticsCraftingTextLabel and cosmeticsCraftingTextLabel:IsA("TextLabel") then
    cosmeticsCraftingTextLabel.Text = "COSM/CRAFT"
    cosmeticsCraftingTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
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
textStroke.Thickness = 1
textStroke.Parent = cosmeticsCraftingTextLabel
cosmeticsCraftingButton.Parent = frame

local eventButton = frame:FindFirstChild("Event") or gardenButton:Clone()
eventButton.Name = "Event"
eventButton.Size = UDim2.new(0.35, 0, 0.985, 0)
eventButton.Position = UDim2.new(0, 0, 0, 200)
eventButton.Image = "rbxassetid://110208924430993"
eventButton.HoverImage = "rbxassetid://135080523802244"
local eventTextLabel = eventButton:FindFirstChild("Txt")
if eventTextLabel and eventTextLabel:IsA("TextLabel") then
    eventTextLabel.Text = "EVENT"
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
eventTextLabel.UISizeConstraint.MinSize = Vector2.new(100, 1)
eventButton.Parent = frame

petsButton.Visible = true
gearButton.Visible = true
gardenButton.Visible = true
eventButton.Visible = true
task.spawn(function()
    task.wait(0)
    cosmeticsCraftingButton.Visible = true
end)

-- Teleport function for UpdateItems
local function teleportToUpdateItems()
    local updateItems = workspace:WaitForChild("Interaction"):WaitForChild("UpdateItems")
    if updateItems then
        local targetPosition
        if updateItems:IsA("Folder") or updateItems:IsA("Model") then
            if updateItems:IsA("Model") and updateItems.PrimaryPart then
                targetPosition = updateItems.PrimaryPart.Position
            else
                local parts = updateItems:GetDescendants()
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
                    local firstPart = updateItems:FindFirstChildWhichIsA("BasePart")
                    if firstPart then
                        targetPosition = firstPart.Position
                    else
                        warn("No valid parts found in UpdateItems to teleport to!")
                        return
                    end
                end
            end
            if character and humanoidRootPart then
                local yawAngle = math.rad(90)
                local targetCFrame = CFrame.new(targetPosition + Vector3.new(0, 5, 0)) * CFrame.Angles(0, yawAngle, 0)
                humanoidRootPart.CFrame = targetCFrame
                print("Teleported to UpdateItems at position: ", targetPosition)
            else
                warn("Character or HumanoidRootPart not found!")
            end
        else
            warn("UpdateItems is not a Folder or Model!")
        end
    else
        warn("UpdateItems not found in workspace.Interaction!")
    end
end

-- Teleport function for hardcoded positions
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
    teleportPlayer(Vector3.new(-285, 3, -0))
end)
gearButton.MouseButton1Click:Connect(function()
    teleportPlayer(Vector3.new(-285, 3, -14))
end)
eventButton.MouseButton1Click:Connect(function()
    teleportToUpdateItems()
end)
cosmeticsCraftingButton.MouseButton1Click:Connect(function()
    teleportPlayer(Vector3.new(-287, 3, -25))
end)
