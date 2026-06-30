--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
--auto farm script 👇🏻

-- [[ ECLIPSE VIPER: OFFICIAL LOADER ]] --
local Success, Error = pcall(function()
    if not game:IsLoaded() then game.Loaded:Wait() end
    
    loadstring(game:HttpGet("https://pastebin.com/raw/bHFF2Xkc"))()
end)

if not Success then
    warn("Eclipse Viper Loader Error: " .. tostring(Error))
end

--anti afk script 👇🏻

loadstring(game:HttpGet("https://pastebin.com/raw/UJcSMgzH"))()
