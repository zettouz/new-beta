-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("vrp_sysblips",cRP)
vSERVER = Tunnel.getInterface("vrp_sysblips")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local system = {}
local actived = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.toggleBlips(status)
	actived = status
	if not actived then
		for k,v in pairs(system) do
			local blip = GetBlipFromEntity(GetPlayerPed(GetPlayerFromServerId(k)))
			if blip ~= 0 then
				RemoveBlip(blip)
				system[k] = nil
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeBlips(status)
	local blip = GetBlipFromEntity(GetPlayerPed(GetPlayerFromServerId(status)))
	if blip ~= 0 then
		RemoveBlip(blip)
		system[status] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEALLBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateAllBlips(status)
	system = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TREADBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if actived then
			for k,v in pairs(system) do
				local player = GetPlayerFromServerId(v.src)
				local ped = GetPlayerPed(player)
				if GetBlipFromEntity(ped) == 0 then
					local blip = AddBlipForEntity(ped)
					SetBlipSprite(blip,1)
					HideNumberOnBlip(blip)
					SetBlipAlpha(blip,255)
					ShowHeadingIndicatorOnBlip(blip,true)
					SetBlipColour(blip,v.color)
					SetBlipAsShortRange(blip,true)
					SetBlipScale(blip,0.6)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(v.name)
					EndTextCommandSetBlipName(blip)
				end
			end
		end
		Citizen.Wait(200)
	end
end)