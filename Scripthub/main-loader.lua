loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/Universal/Fps%20display.lua"))()

local ScriptGroups = {
    ["https://darahub.vercel.app/api/script/DaraHub-Evade.lua"] = {
        name = "Evade",
        placeIds = {
            10324346056, -- Big Team
            9872472334,  -- Evade
            10662542523, -- Casual
            10324347967, -- Social Space
            121271605799901, -- Player Nextbots
            10808838353, -- VC Only
            11353528705, -- Pro
            99214917572799, -- Custom Servers
        }
    },
    ["https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/Evade%20Legacy/DaraHub-Evade-Legacy"] = {
        name = "Legacy Evade",
        placeIds = {96537472072550}
    },
    ["https://darahub.vercel.app/api/script/DaraHub-MM2.lua"] = {
        name = "Murder Mystery 2",
        placeIds = {142823291}
    },
    ["https://darahub.vercel.app/api/script/DaraHub-Grow-A-Garden.lua"] = {
        name = "Grow-a-Garden",
        placeIds = {
            126884695634066, -- New Players
            124977557560410  -- Regular
        }
    }
}

local UniversalScript = {
    name = "Universal Script",
    url = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/Universal/Darahub-Universal.lua"
}

local currentGameId = game.PlaceId
local selectedUrl = nil
local scriptName = ""

-- Find which script group the current game belongs to
for url, group in pairs(ScriptGroups) do
    for _, placeId in ipairs(group.placeIds) do
        if currentGameId == placeId then
            selectedUrl = url
            scriptName = group.name
            break
        end
    end
    if selectedUrl then break end
end

-- Load the appropriate script
if selectedUrl then
    local success, result = pcall(function()
        return loadstring(game:HttpGet(selectedUrl))()
    end)
    if not success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Script Error",
            Text = scriptName .. " failed to load: " .. tostring(result),
            Duration = 5
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Script Loaded",
            Text = scriptName .. " has been loaded successfully!",
            Duration = 3
        })
    end
else
    -- Load universal script for unsupported games
    local success, result = pcall(function()
        return loadstring(game:HttpGet(UniversalScript.url))()
    end)
    if not success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Universal Script Error",
            Text = "Failed to load universal script: " .. tostring(result),
            Duration = 5
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Universal Script Loaded",
            Text = "Loaded universal features for this game",
            Duration = 3
        })
    end
end

-- Other scripts
loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Create%20Loadstring%20file.lua",true))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Creator%20whitelist.lua"))()

-- Auto-reexecute on teleport
local queueonteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (DaraHub and DaraHub.queue_on_teleport)
if queueonteleport then
    queueonteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/main-loader.lua'))()")
end
