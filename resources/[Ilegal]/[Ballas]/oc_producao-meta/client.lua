local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local timedown = 0
vRP = Proxy.getInterface("vRP")

farM = Tunnel.getInterface("oc_producao-meta")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local procMachine = {
    { ['x'] = 1493.26, ['y'] = 6390.29, ['z'] = 21.26 }
}
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "proc-hQMeta" then
		TriggerServerEvent("proc-hQMeta")
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
		timedown = 2

	elseif data == "proc-mQMeta" then
		TriggerServerEvent("proc-mQMeta")
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
		timedown = 2

	elseif data == "proc-lQMeta" then
		TriggerServerEvent("proc-lQMeta")
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
		timedown = 2

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

RegisterNetEvent("proc_meta:posicao")
AddEventHandler("proc_meta:posicao", function()
	local ped = PlayerPedId()
	SetEntityHeading(ped,174.06)
	SetEntityCoords(ped,1493.3, 6390.54, 21.26-1,false,false,false,false)
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		for k,v in pairs(procMachine) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local procMachine = procMachine[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), procMachine.x, procMachine.y, procMachine.z, true ) <= 2 then
				DrawText3D(procMachine.x, procMachine.y, procMachine.z, "[~r~E~w~] Para acessar a ~g~Processadora~w~.")
			end
			
			if distance <= 15 then
				DrawMarker(23, procMachine.x, procMachine.y, procMachine.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,20,20,20,240,0,0,0,0)
				if distance <= 1.6 then
					if IsControlJustPressed(0,38) and farM.checkPermissao() then
						ToggleActionMenu()
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