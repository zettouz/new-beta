local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_bank")

RegisterCommand("inoite", function(source)

	local userID 	= vRP.getUserId(source)
	local player 	= vRP.getUserSource(userID)

	if vRP.hasPermission(userID,"mindmaster.permissao") then
	TriggerClientEvent("cuqui_noiteCrime:iniciar", source)
	print("[NOITE DE CRIME] O Deus ".. GetPlayerName(source) .." deu inicio a expurgacao")
	end

end)

--[[RegisterNetEvent("cuqui_noiteCrime:notificacaoInicio")
AddEventHandler("cuqui_noiteCrime:notificacaoInicio", function(source)
	TriggerClientEvent("pNotify:SendNotification", -1, {text = "<div class='imagem-notificacao-crime'></div><div class='texto'> <b>[EXPURGAÇÃO]</b> Crimes são permitidos por <b>12 horas</b>. <br><b>Que Deus esteja conosco!</div>", layout = "bottomCenter", type = "warning", theme = "metroui", timeout = 2500})
	vRPclient.giveWeapons(-1,{
	  ["weapon_assaultrifle"] = {ammo=300},
	  ["weapon_combatpistol"] = {ammo=300},
	  ["weapon_carabinerifle"] = {ammo=300},
	  ["weapon_sniperifle"] = {ammo=300},
	  ["weapon_carabinerifle_mk2"] = {ammo=300},
	  ["weapon_smg"] = {ammo=300},
	}, true)
end)]]--

RegisterNetEvent("cuqui_noiteCrime:notificacaoInicio")
AddEventHandler("cuqui_noiteCrime:notificacaoInicio", function(source)
	TriggerClientEvent("pNotify:SendNotification", -1, {text = "<div class='imagem-notificacao-crime'></div><div class='texto'> <b>[EXPURGAÇÃO]</b> Crimes são permitidos por <b>12 horas</b>. <br><b>Que Deus esteja conosco!</div>", layout = "bottomCenter", type = "warning", theme = "metroui", timeout = 2500})
	--[[vRPclient.giveWeapons(-1,{
	  ["weapon_pistol50"] = {ammo=30},
	}, false)]]--
end)

RegisterNetEvent("cuqui_noiteCrime:terminou")
AddEventHandler("cuqui_noiteCrime:terminou", function(source)
	TriggerClientEvent("pNotify:SendNotification", -1, {text = "<div class='imagem-notificacao-crime'></div><div class='texto'> <b>[EXPURGAÇÃO]</b> Os serviços emergenciais poderão trabalhar agora.<br> <b>Obrigado por participar (NOME Roleplay).</b></div>", layout = "bottomCenter", type = "info", theme = "metroui", timeout = 2500})
end)

RegisterCommand("tnoite", function(source)
	local userID 	= vRP.getUserId(source)
	local player 	= vRP.getUserSource(userID)

	if vRP.hasPermission(userID,"noiteCrime") then
		TriggerClientEvent("cuqui_noiteCrime:terminarExpurgacao", source)
	end
end)


