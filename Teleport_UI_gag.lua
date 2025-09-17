local player = game:GetService("Players").LocalPlayer
local character = player.Character
local playerGui = player.PlayerGui
local frame = playerGui:WaitForChild("Teleport_UI"):WaitForChild("Frame")

frame.Size = UDim2.new(0.4, 0, 0.085, 0)

local sellButton = frame:WaitForChild("Sell")
sellButton.Size = UDim2.new(0.22, 0, 0.791, 0)

local seedsButton = frame:WaitForChild("Seeds")
seedsButton.Size = UDim2.new(0.22, 0, 0.791, 0)

local gardenButton = frame:WaitForChild("Garden")
gardenButton.Size = UDim2.new(0.35, 0, 0.985, 0)

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
eventButton.Parent = frame

petsButton.Visible = true
gearButton.Visible = true
gardenButton.Visible = true
eventButton.Visible = true
task.spawn(function()
    task.wait(0)
    cosmeticsCraftingButton.Visible = true
end)

local function teleportPlayer(position)
    if character and character:FindFirstChild("HumanoidRootPart") then
        local yawAngle = math.rad(90)
        local targetCFrame = CFrame.new(position) * CFrame.Angles(0, yawAngle, 0)
        character.HumanoidRootPart.CFrame = targetCFrame
    end
end

petsButton.MouseButton1Click:Connect(function()
    teleportPlayer(Vector3.new(-288, 3, -1))
end)
gearButton.MouseButton1Click:Connect(function()
    teleportPlayer(Vector3.new(-285, 3, -14))
end)
eventButton.MouseButton1Click:Connect(function()
    teleportPlayer(Vector3.new(-95, 3, -15))
end)
cosmeticsCraftingButton.MouseButton1Click:Connect(function()
    teleportPlayer(Vector3.new(-287, 3, -25))
end)
