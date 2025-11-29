local UnsupportedExecutors = {"Xeno", "Solara"}

local function checkExecutor()
    local executor = identifyexecutor and identifyexecutor() or "Unknown"
    local executorName = ""
    
    if type(executor) == "table" then
        executorName = executor.Name or "Unknown"
    elseif type(executor) == "string" then
        executorName = executor
    else
        executorName = "Unknown"
    end
    
    for _, unsupported in pairs(UnsupportedExecutors) do
        if string.lower(executorName) == string.lower(unsupported) then
            local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

            local Localization = WindUI:Localization({
                Enabled = true,
                Prefix = "loc:",
                DefaultLanguage = "en",
                Translations = {
                    ["en"] = {
                        ["LIB_DESC"] = "<b><font color='#FF0000'>ERROR⚠️: Unsupported Executor detected! Some features will not work. Your executor is: " .. executorName .. "</font></b>"
                    }
                }
            })

            WindUI.TransparencyValue = 0.2
            WindUI:SetTheme("Dark")

            local function gradient(text, startColor, endColor)
                local result = ""
                for i = 1, #text do
                    local t = (i - 1) / (#text - 1)
                    local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
                    local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
                    local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
                    result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, text:sub(i, i))
                end
                return result
            end

            WindUI:Popup({
                Title = gradient("Dara Hub", Color3.fromHex("#6A11CB"), Color3.fromHex("#2575FC")),
                Icon = "sparkles",
                Content = "loc:LIB_DESC",
                Buttons = {
                    {
                        Title = "Load Anyway",
                        Variant = "Primary",
                        Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Loadstring%20UI.lua",true))() end
                    }
                }
            })
            
            return false
        end
    end
    
    return true
end

local isSupported = checkExecutor()
if isSupported then
loadstring(game:HttpGet("https://raw.githubusercontent.com/Pnsdgsa/Script-kids/refs/heads/main/Scripthub/Loadstring%20UI.lua",true))()
end
