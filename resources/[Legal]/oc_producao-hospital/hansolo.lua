local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local timedown = 0
vRP = Proxy.getInterface("vRP")

hP = Tunnel.getInterface("oc_producao-hospital")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodHospital = {
	{ ['x'] = 304.01, ['y'] = -580.17, ['z'] = 43.29 }
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
	if data == "produzir-ak47" then
		TriggerServerEvent("produzir-hospital","ak47")

	elseif data == "produzir-ak74u" then
		TriggerServerEvent("produzir-hospital","ak74u")

	elseif data == "produzir-uzi" then
		TriggerServerEvent("produzir-hospital","uzi")

	elseif data == "produzir-magnum44" then
		TriggerServerEvent("produzir-hospital","magnum44")

	elseif data == "produzir-kitmedico" then
		TriggerServerEvent("produzir-hospital","kitmedico")
		timedown = 30

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)


RegisterNetEvent("fechar-nui-hospital")
AddEventHandler("fechar-nui-hospital", function()
	ToggleActionMenu()
	onmenu = false

	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local bowz,cdz = GetGroundZFor_3dCoord(304.01, -580.17, 43.29)
	local distance = GetDistanceBetweenCoords(304.01, -580.17, cdz, x, y, z, true)

	if distance < 1.2 then
		TriggerEvent("hospital:posicao1")	
	end
end)

RegisterNetEvent("hospital:posicao1")
AddEventHandler("hospital:posicao1", function()
	local ped = PlayerPedId()
	SetEntityHeading(ped, 160.67)
	SetEntityCoords(ped, 304.01, -580.17, 43.29-0.95, false, false, false, false)
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		for k,v in pairs(prodHospital) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local prodHospital = prodHospital[k]
			local idHospital = prodHospital[id]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prodHospital.x, prodHospital.y, prodHospital.z, true ) <= 1 and not onmenu then
				DrawText3D(prodHospital.x, prodHospital.y, prodHospital.z, "[~r~E~w~] Para acessar a ~r~BANCADA~w~.")
			end
			if distance <= 15 then
				DrawMarker(23, prodHospital.x, prodHospital.y, prodHospital.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and hP.checkPermissao() then
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