-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_robberys",src)
vSERVER = Tunnel.getInterface("vrp_robberys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbery = false
local timedown = 0
local robmark = nil
local coordenadaX = nil
local coordenadaY = nil
local coordenadaZ = nil
local h = nil
local robberyId = nil
--Game
local game = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbers = {
	[1] = { ['x'] = 2549.43 , ['y'] = 384.90 , ['z'] = 108.62 , h = 80.0 },
    [2] = { ['x'] = 1159.67 , ['y'] = -313.91 , ['z'] = 69.20 , h = 100.0 },
    [3] = { ['x'] = 28.27 , ['y'] = -1339.48 , ['z'] = 29.49 , h = 0.0 },
    [4] = { ['x'] = -709.59 , ['y'] = -904.10 , ['z'] = 19.21 , h = 90.0 },
    [5] = { ['x'] = -43.23 , ['y'] = -1748.475 , ['z'] = 29.42 , h = 50.0 },
    [6] = { ['x'] = 378.17 , ['y'] = 333.12 , ['z'] = 103.56 , h = 340.0 },
    [7] = { ['x'] = -3249.79 , ['y'] = 1004.40 , ['z'] = 12.83 , h = 80.0 },
    [8] = { ['x'] = 1734.72 , ['y'] = 6420.65 , ['z'] = 35.03 , h = 330.0 },
    [9] = { ['x'] = 546.37 , ['y'] = 2662.89 , ['z'] = 42.15 , h = 190.0 },
    [10] = { ['x'] = 1959.38 , ['y'] = 3748.83 , ['z'] = 32.34 , h = 30.0 },
    [11] = { ['x'] = 2672.90 , ['y'] = 3286.58 , ['z'] = 55.24 , h = 60.0 },
    [12] = { ['x'] = 1707.93 , ['y'] = 4920.44 , ['z'] = 42.06 , h = 320.0 },
    [13] = { ['x'] = -1829.23 , ['y'] = 798.76 , ['z'] = 138.19 , h = 120.0 },
    [14] = { ['x'] = -2959.65 , ['y'] = 387.15 , ['z'] = 14.04 , h = 120.0 },
    [15] = { ['x'] = -3047.84 , ['y'] = 585.58 , ['z'] = 7.90 , h = 120.0 },
    [16] = { ['x'] = 1126.73 , ['y'] = -980.08 , ['z'] = 45.41 , h = 3530.0 },
    [17] = { ['x'] = 1169.23 , ['y'] = 2717.80 , ['z'] = 37.15 , h = 274.8 },
    [18] = { ['x'] = -1478.86 , ['y'] = -375.43 , ['z'] = 39.16 , h = 120.0 },
    [19] = { ['x'] = -1220.81 , ['y'] = -915.96 , ['z'] = 11.32 , h = 120.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERSBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		-- SetNuiFocus(false, false)
		local ped = PlayerPedId()
		-- ClearPedTasks(ped)
		if not robbery then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(robbers) do
				local distance = Vdist(x,y,z,v.x,v.y,v.z)
				if distance <= 1.5 and GetEntityHealth(ped) > 101 then
					DrawText3D(v.x, v.y, v.z, "PRESSIONE  ~r~E~w~  PARA INICIAR O ROUBO")
					if IsControlJustPressed(0,38) and timedown <= 0 and vSERVER.checkPermission() then
						if vSERVER.checkPolice() then
							local ped = PlayerPedId()
							SetEntityCoords(ped,v.x,v.y,v.z-1)
							SetEntityHeading(ped,v.h)
							game = true
							SendNUIMessage({
								type = "startgame"
							})
							SetNuiFocus(true, true)
							vRP._playAnim(false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female", 1}},true)
							
							vSERVER.startRobbery(k,v.x,v.y,v.z,v.h)
						end
					end
				end
			end
		else
			if IsControlJustPressed(0,244) or GetEntityHealth(ped) <= 101 then
				robbery = false
				timedown = 0
				vSERVER.stopRobbery()
				ClearPedTasks(ped)
			end
			drawText("APERTE ~r~M~w~ PARA CANCELAR O ROUBO EM ANDAMENTO",4,0.5,0.88,0.36,255,255,255,50)
			if timedown ~= 0 then
				drawText("AGUARDE ~g~"..timedown.." SEGUNDOS~w~ ATÉ QUE TERMINE O ROUBO",4,0.5,0.9,0.46,255,255,255,150)
			end
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startRobbery(x2,y2,z2,h)
	robbery = true
	SetPedComponentVariation(PlayerPedId(),5,45,0,2)
	Citizen.CreateThread(function()
		while robbery do
			Citizen.Wait(5)
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(x,y,z,x2,y2,z2)
			coordenadaX = x
			coordenadaY = y
			coordenadaZ = z
			head = h
			if distance >= 10.0 then
				robbery = false
				vSERVER.stopRobbery()
			end
		end
	end)
end

function src.startGrab(time)
	timedown = time
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERYPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startRobberyPolice(x,y,z,localidade)
	if not DoesBlipExist(robmark) then
		robmark = AddBlipForCoord(x,y,z)
		SetBlipScale(robmark,0.5)
		SetBlipSprite(robmark,161)
		SetBlipColour(robmark,59)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Roubo: "..localidade)
		EndTextCommandSetBlipName(robmark)
		SetBlipAsShortRange(robmark,false)
		SetBlipRoute(robmark,true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPROBBERYPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.stopRobberyPolice()
	if DoesBlipExist(robmark) then
		RemoveBlip(robmark)
		robmark = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMEDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if timedown >= 1 then
			timedown = timedown - 1
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(x,y,z,coordenadaX,coordenadaY,coordenadaZ)
			if distance >= 1.0 or not GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") then
				-- robbery = false
				-- ClearPedTasks(ped)
			end
			if timedown == 0 then
				robbery = false
				ClearPedTasks(GetPlayerPed(-1))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function drawText(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

RegisterNUICallback("win", function(data, cb)
	if game then 
		game = false
		SendNUIMessage({
			type = "close"
		})
		SetNuiFocus(false, false)
		local ped = PlayerPedId()
		ClearPedTasks(ped)
		TriggerServerEvent("robberys:win")
	end
end)

RegisterNUICallback("lose", function(data, cb)
	if game then 
		game = false
		SendNUIMessage({
			type = "close"
		})
		SetNuiFocus(false, false)
		local ped = PlayerPedId()
		robbery = false
		ClearPedTasks(ped)
		TriggerServerEvent("robberys:lose")
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