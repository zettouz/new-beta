
local menuactive = false
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
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BUTTON ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "comprar-agua" then
		TriggerServerEvent("bebida-comprar","agua")

	elseif data == "comprar-cola" then
		TriggerServerEvent("bebida-comprar","cola")

	elseif data == "comprar-sprunk" then
		TriggerServerEvent("bebida-comprar","sprunk")

	elseif data == "comprar-energetico" then
		TriggerServerEvent("bebida-comprar","energetico")

	elseif data == "comprar-leite" then
		TriggerServerEvent("bebida-comprar","leite")

	elseif data == "comprar-barracho" then
		TriggerServerEvent("bebida-comprar","barracho")

	elseif data == "comprar-patriot" then
		TriggerServerEvent("bebida-comprar","patriot")

	elseif data == "comprar-pibwassen" then
		TriggerServerEvent("bebida-comprar","pibwassen")
	
	elseif data == "fechar" then
		ToggleActionMenu()
	
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local lojas = {
	{ ['x'] = 313.14, ['y'] = -587.86, ['z'] = 43.3 },
	{ ['x'] = 322.1, ['y'] = -600.26, ['z'] = 43.3 },
	{ ['x'] = -208.03, ['y'] = -1342.09, ['z'] = 34.9 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)

		for k,v in pairs(lojas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local lojas = lojas[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), lojas.x, lojas.y, lojas.z, true ) <= 2 then
				DrawText3D(lojas.x, lojas.y, lojas.z, "[~g~E~w~] Para ~g~COMPRAR~w~.")
			end
			
			if distance <= 15 then
				DrawMarker(23, lojas.x, lojas.y, lojas.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,20,20,20,240,0,0,0,0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
						ToggleActionMenu()
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z, text)
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