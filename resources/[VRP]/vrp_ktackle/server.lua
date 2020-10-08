-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_ktackle",src)
vCLIENT = Tunnel.getInterface("vrp_ktackle")

RegisterServerEvent('jackson:tryTackle')
AddEventHandler('jackson:tryTackle', function()

	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,1.5)
	
	if nplayer then
		local nuserId = vRP.getUserId(nplayer)
		if not vRPclient.isHandcuffed(source) and (vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"admin.permissao")) then
			TriggerClientEvent('jackson:getTackled', nplayer, source)
			TriggerClientEvent('jackson:playTackle', source)
		else
			TriggerClientEvent('jackson:updateTackle', source)
		end
	else
		TriggerClientEvent('jackson:updateTackle', source)
	end
end)