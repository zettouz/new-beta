local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("vrp_bonus")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local bonus = false
local tablet = "p_ld_id_card_01"
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function()
	TransitionFromBlurred(1000)
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ bonus = false })
	TriggerServerEvent("vrp_inventory:Cancel")
	TaskClearLookAt(GetPlayerPed(-1))
	bonus = false
end)

RegisterCommand("bonus",function(source,args)
	if GetEntityHealth(GetPlayerPed(-1)) > 101 then
		if bonus then 
			TriggerServerEvent("vrp_inventory:Cancel")
			TaskClearLookAt(GetPlayerPed(-1))
		else
			TransitionToBlurred(1000)
			local anim1 = "amb@world_human_stand_mobile@female@text@enter"
			RequestAnimDict(anim1)
			TaskPlayAnim(GetPlayerPed(-1), anim1, "enter", 8.0, 1.0, -1, 50, 0, 0, 0, 0)
			Citizen.Wait(1000)
			vRP._createObjects("amb@world_human_stand_mobile@female@text@base","base",tablet,49,28422)
		end
		bonus = not bonus

		local lixeiro,pescador,lenhador,leiteiro,minerador,motorista,caminhoneiro,carteiro,piloto,policial,paramedico,cacador,assassino,contrabandista,taxista,mecanico,corredor,traficante,transportador = vRPNserver.Bonus()
		SendNUIMessage({ bonus = bonus, lixeiro = lixeiro, pescador = pescador, lenhador = lenhador, leiteiro = leiteiro, minerador = minerador, motorista = motorista, caminhoneiro = caminhoneiro, carteiro = carteiro, piloto = piloto, policial = policial, paramedico = paramedico, cacador = cacador, assassino = assassino, contrabandista = contrabandista, taxista = taxista, mecanico = mecanico, corredor = corredor, traficante = traficante, transportador = transportador })
		SetNuiFocus(true,true)
	end
end)