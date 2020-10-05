local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emD = Tunnel.getInterface("vrp_discord")
----------------------------------------------------------------------------------------------------
--[ DISCORD ]---------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        SetDiscordAppId(703384543188615359)

	    local players = emD.discord()
		
	    SetDiscordRichPresenceAsset('logo')
		SetDiscordRichPresenceAssetText('Beta City')
		SetRichPresence("https://discord.gg/n4vrnbb")
	    SetRichPresence("Jogadores conectados: "..players.." de 300")
		Citizen.Wait(10000)
	end
end)