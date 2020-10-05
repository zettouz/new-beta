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
cRP = {}
Tunnel.bindInterface("vrp_sysblips",cRP)
vCLIENT = Tunnel.getInterface("vrp_sysblips")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local system = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_sysblips::Add")
AddEventHandler("vrp_sysblips::Add",function(status)
	system[status.src] = status
	for k,v in pairs(system) do
		vCLIENT.updateAllBlips(k,system)
		Citizen.Wait(10)
	end
	vCLIENT.toggleBlips(status.src,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_sysblips::Remove")
AddEventHandler("vrp_sysblips::Remove",function(status)
	system[status] = nil
	for k,v in pairs(system) do
		vCLIENT.removeBlips(tonumber(k),status)
		Citizen.Wait(10)
	end
	vCLIENT.toggleBlips(status,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if system[source] then
		system[source] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	if vRP.hasPermission(user_id,"bcso.permissao") then
		TriggerEvent("vrp_sysblips::Add",{ name = "Policia", src = source, color = 3 })
	elseif vRP.hasPermission(user_id,"dmla.permissao") then
		TriggerEvent("vrp_sysblips::Add",{ name = "Paramedico", src = source, color = 83 })
	end
end)