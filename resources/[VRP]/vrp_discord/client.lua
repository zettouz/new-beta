local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emD = Tunnel.getInterface("vrp_discord")
----------------------------------------------------------------------------------------------------
--[ DISCORD ]---------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        SetDiscordAppId(680996135611269166)

	    local players = emD.discord()
		
	    SetDiscordRichPresenceAsset('logo')
		SetDiscordRichPresenceAssetText('Capeside')
		SetRichPresence("https://discord.gg/Kd8uuRs")
	    SetRichPresence("Jogadores conectados: "..players.." de 300")
		Citizen.Wait(10000)
	end
end)