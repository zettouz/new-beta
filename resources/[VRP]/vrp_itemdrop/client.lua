local dropList = {}

RegisterNetEvent('DropSystem:remove')
AddEventHandler('DropSystem:remove',function(id)
	if dropList[id] ~= nil then
		dropList[id] = nil
	end
end)

RegisterNetEvent('DropSystem:createForAll')
AddEventHandler('DropSystem:createForAll',function(id,marker)
	dropList[id] = marker
end)

local cooldown = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k,v in pairs(dropList) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 150 then
				DrawMarker(25,v.x,v.y,cdz+0.01,0,0,0,0,0,0,0.4,0.4,0.5,255,255,255,15,0,0,2,0,0,0,0)
				DrawMarker(21,v.x,v.y,cdz+0.60,0,0,0,0,180.0,130.0,0.6,0.8,0.5,255,0,0,50,1,0,0,1)
				if distance <= 5 then
					DrawText3D(v.x, v.y, v.z, "[~g~E~w~] Para pegar ~g~"..v.count.."x~r~ "..string.upper(v.name))
					if distance <= 1.2 and v.count ~= nil and v.name ~= nil and not IsPedInAnyVehicle(ped) then
						if IsControlJustPressed(1,38) and not cooldown then
							cooldown = true
							TriggerServerEvent('DropSystem:take',k)
							SetTimeout(3000,function()
								cooldown = false
							end)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------------
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