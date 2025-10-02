local PlaceScripts = {
    [10324346056] = { 
        name = "Big Team", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua" 
    },
    [9872472334] = { 
        name = "Evade", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua" 
    },
    [96537472072550] = { 
        name = "Legacy Evade", 
        url = "UNSUPPORTED" 
    },
    [10662542523] = { 
        name = "Casual", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua" 
    },
    [10324347967] = { 
        name = "Social Space", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua" 
    },
    [121271605799901] = { 
        name = "Player Nextbots", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua" 
    },
    [10808838353] = { 
        name = "VC Only", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua" 
    },
    [11353528705] = { 
        name = "Pro", 
        url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua" 
    },
}

local UniversalScript = {
    name = "Universal Script",
    url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/UHH-OHH-Sorry-This-Game-is-Not-Supported/Why%20are%20you%20here%3F%20There's%20nothing%20here.lua"
}

local currentGameId = game.PlaceId
local selectedScript = PlaceScripts[currentGameId]

if selectedScript then
    if selectedScript.url == "UNSUPPORTED" then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Error - Game Not Supported",
            Text = "Legacy Evade is currently unsupported. Please check back later.",
            Duration = 5
        })
    else
        loadstring(game:HttpGet(selectedScript.url))()
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Script loaded - Enjoy!",
            Text = "Credits to [Your Name Here]",
            Duration = 5
        })
    end
else
    loadstring(game:HttpGet(UniversalScript.url))()
end
