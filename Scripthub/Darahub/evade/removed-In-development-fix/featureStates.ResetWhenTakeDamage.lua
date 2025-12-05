   local Players = game:GetService("Players")
local player = Players.LocalPlayer

local featureStates = {
    ResetWhenTakeDamage = false,
    ResetDamageType = "Any Damage"
}

local function monitorAnyDamage()
    local function setupCharacter(character)
        local humanoid = character:WaitForChild("Humanoid")
        local lastHealth = humanoid.Health
        local isAlive = true
        
        local function checkAliveStatus()
            if character:GetAttribute("Downed") then
                return false
            end
            
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                return true
            end
            
            return false
        end
        
        humanoid.HealthChanged:Connect(function(currentHealth)
            local wasAlive = isAlive
            isAlive = checkAliveStatus()
            
            if featureStates.ResetWhenTakeDamage and isAlive and currentHealth < lastHealth then
                if featureStates.ResetDamageType == "Any Damage" then
                    game:GetService("ReplicatedStorage").Events.Character.ToolAction:FireServer(-2)
                    
                    local sound = Instance.new("Sound")
                    sound.SoundId = "rbxassetid://8164951181"
                    sound.Volume = 3
                    sound.Parent = game:GetService("SoundService")
                    sound:Play()
                    
                    sound.Ended:Connect(function()
                        sound:Destroy()
                    end)
                elseif featureStates.ResetDamageType == "Low Health" and currentHealth <= 25 then
                    game:GetService("ReplicatedStorage").Events.Character.ToolAction:FireServer(-2)
                    
                    local sound = Instance.new("Sound")
                    sound.SoundId = "rbxassetid://8164951181"
                    sound.Volume = 3
                    sound.Parent = game:GetService("SoundService")
                    sound:Play()
                    
                    sound.Ended:Connect(function()
                        sound:Destroy()
                    end)
                end
            end
            
            lastHealth = currentHealth
        end)
        
        character:GetAttributeChangedSignal("Downed"):Connect(function()
            isAlive = not character:GetAttribute("Downed")
        end)
        
        isAlive = checkAliveStatus()
    end
    
    if player.Character then
        setupCharacter(player.Character)
    end
    player.CharacterAdded:Connect(setupCharacter)
end

monitorAnyDamage()
