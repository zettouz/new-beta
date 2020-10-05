local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local timedown = 0
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("oc_producao-motoclub")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachine = {
	{ ['x'] = 897.4, ['y'] = -2115.28, ['z'] = 30.77 }
}
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
local onmenu = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "produzir-m-ak47" then
		TriggerServerEvent("produzir-motoclub","m-ak47")
		timedown = 10

	elseif data == "produzir-m-advancedrifle" then
		TriggerServerEvent("produzir-motoclub","m-advancedrifle")
		timedown = 10

	elseif data == "produzir-m-assaultsmg" then
		TriggerServerEvent("produzir-motoclub","m-assaultsmg")
		timedown = 10

	elseif data == "produzir-m-microsmg" then
		TriggerServerEvent("produzir-motoclub","m-microsmg")
		timedown = 10

	elseif data == "produzir-m-gusenberg" then
		TriggerServerEvent("produzir-motoclub","m-gusenberg")
		timedown = 10

	elseif data == "produzir-m-weaponmg" then
		TriggerServerEvent("produzir-motoclub","m-weaponmg")
		timedown = 10

	elseif data == "produzir-m-glock" then
		TriggerServerEvent("produzir-motoclub","m-glock")
		timedown = 10

	elseif data == "produzir-m-snspistol" then
		TriggerServerEvent("produzir-motoclub","m-snspistol")
		timedown = 10

	elseif data == "produzir-kevlar" then
		TriggerServerEvent("produzir-motoclub","kevlar")
		timedown = 10

	elseif data == "produzir-colete" then
		TriggerServerEvent("produzir-motoclub","colete")
		timedown = 10

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)

RegisterNetEvent("fechar-nui-motoclub")
AddEventHandler("fechar-nui-motoclub", function()
	ToggleActionMenu()
	onmenu = false


	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local bowz,cdz = GetGroundZFor_3dCoord(897.4, -2115.28, 30.77)
	local distance = GetDistanceBetweenCoords(897.4, -2115.28, cdz, x, y, z, true)

	if distance < 1.2 then
		TriggerEvent("motoclub:posicao1")	
	end
end)

RegisterNetEvent("motoclub:posicao1")
AddEventHandler("motoclub:posicao1", function()
	local ped = PlayerPedId()
	SetEntityHeading(ped, 173.29)
	SetEntityCoords(ped, 897.4, -2115.28, 30.77-0.90,false,false,false,false)
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		for k,v in pairs(prodMachine) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local prodMachine = prodMachine[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prodMachine.x, prodMachine.y, prodMachine.z, true ) <= 1 and not onmenu then
				DrawText3D(prodMachine.x, prodMachine.y, prodMachine.z, "[~r~E~w~] Para acessar a ~r~BANCADA~w~.")
			end
			if distance <= 15 then
				DrawMarker(23, prodMachine.x, prodMachine.y, prodMachine.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and oC.checkPermissao() then
						ToggleActionMenu()
						onmenu = true
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMEDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		if timedown > 0 and GetEntityHealth(ped) > 101 then
			timedown = timedown - 1
			if timedown <= 1 then
				TriggerServerEvent("vrp_inventory:Cancel")
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local TimeDistance = 500
		if timedown > 0 then
			TimeDistance = 4
			DisableControlAction(0,38,true)
		end
		Citizen.Wait(TimeDistance)
	end
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end