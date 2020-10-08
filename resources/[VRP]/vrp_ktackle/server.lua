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
	local nplayer = vRPclient.getNearestPlayer(source,3)

	local targetPlayer = GetPlayerPed(nplayer)

	TriggerClientEvent('jackson:getTackled', targetPlayer, source)
	TriggerClientEvent('jackson:playTackle', source)
end)