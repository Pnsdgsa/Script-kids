repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local scripts = {
    -- evade lol
    [9872472334] = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua",
    [81440632616906] = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua",
    [10324346056] = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua",
    [10662542523] = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua",
    [10324347967] = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua",
    [10808838353] = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua",
    [11353528705] = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua",
   [121271605799901] = "https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/evade/DaraHub-Evade.lua",
}

--Ahhh sadly there's no script for your game 
local url = scripts[game.PlaceId]
if url then
    loadstring(game:HttpGetAsync(url))()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Darahub/UHH-OHH-Sorry-This-Game-is-Not-Supported/Why%20are%20you%20here%3F%20There's%20nothing%20here.lua"))()
end

