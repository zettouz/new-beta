-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "relogioroubado" then
		TriggerServerEvent("jewelry-vender","relogioroubado")
	elseif data == "pulseiraroubada" then
		TriggerServerEvent("jewelry-vender","pulseiraroubada")
	elseif data == "anelroubado" then
		TriggerServerEvent("jewelry-vender","anelroubado")
	elseif data == "colarroubado" then
		TriggerServerEvent("jewelry-vender","colarroubado")
	elseif data == "brincoroubado" then
		TriggerServerEvent("jewelry-vender","brincoroubado")
	elseif data == "carteiraroubada" then
		TriggerServerEvent("jewelry-vender","carteiraroubada")
	elseif data == "tabletroubado" then
		TriggerServerEvent("jewelry-vender","tabletroubado")
	elseif data == "sapatosroubado" then
		TriggerServerEvent("jewelry-vender","sapatosroubado")	
	elseif data == "roupas" then
		TriggerServerEvent("jewelry-vender","roupas")			

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),707.31,-966.99,30.41,true)
		if distance <= 3 then
			DrawMarker(21,707.31,-966.99,30.41-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
	end
end)