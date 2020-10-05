local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local timedown = 0
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("oc_producao-families")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachine = {
	{ ['x'] = -134.78, ['y'] = -1609.63, ['z'] = 35.04 }
}
---134.78,-1609.63,35.04
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
	if data == "produzir-heavypistol" then
		TriggerServerEvent("produzir-families","heavypistol")
		timedown = 10

	elseif data == "produzir-assaultmg" then
		TriggerServerEvent("produzir-families","assaultsmg")
		timedown = 10

	elseif data == "produzir-advancedrifle" then
		TriggerServerEvent("produzir-families","advancedrifle")
		timedown = 10

	elseif data == "produzir-planta-alta" then
		TriggerServerEvent("produzir-families","planta-alta")
		timedown = 10

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)


RegisterNetEvent("fechar-nui-families")
AddEventHandler("fechar-nui-families", function()
	ToggleActionMenu()
	onmenu = false

	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local bowz,cdz = GetGroundZFor_3dCoord(-134.78, -1609.63, 35.04)
	local distance = GetDistanceBetweenCoords(-134.78, -1609.63, cdz, x, y, z, true)

	if distance < 1.2 then
		TriggerEvent("families:posicao1")	
	end
end)

RegisterNetEvent("families:posicao1")
AddEventHandler("families:posicao1", function()
	local ped = PlayerPedId()
	SetEntityHeading(ped, 69.49)
	SetEntityCoords(ped, -134.78, -1609.63, 35.04-0.95, false, false, false, false)
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
			local idBancada = prodMachine[id]

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