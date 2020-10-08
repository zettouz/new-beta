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
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbers = {
	[1] = { ['x'] = 28.25, ['y'] = -1339.22, ['z'] = 29.5 },
	[2] = { ['x'] = 2549.25, ['y'] = 384.93, ['z'] = 108.63 },
	[3] = { ['x'] = 1159.53, ['y'] = -314.11, ['z'] = 69.21 },
	[4] = { ['x'] = -709.68, ['y'] = -904.08, ['z'] = 19.22 },
	[5] = { ['x'] = -43.44, ['y'] = -1748.46, ['z'] = 29.43 },
	[6] = { ['x'] = 378.1, ['y'] = 333.4, ['z'] = 103.57 },
	[7] = { ['x'] = -3250.01, ['y'] = 1004.45, ['z'] = 12.84 },
	[8] = { ['x'] = 1734.66, ['y'] = 6420.88, ['z'] = 35.04 },
	[9] = { ['x'] = 546.5, ['y'] = 2662.84, ['z'] = 42.16 },
	[10] = { ['x'] = 1959.25, ['y'] = 3748.87, ['z'] = 32.35 },
	[11] = { ['x'] = 2672.86, ['y'] = 3286.75, ['z'] = 55.25 },
	[12] = { ['x'] = 1707.86, ['y'] = 4920.41, ['z'] = 42.07 },
	[13] = { ['x'] = -1829.22, ['y'] = 798.86, ['z'] = 138.2 },
	--[14] = { ['x'] = 1394.96, ['y'] = 3613.92, ['z'] = 34.99 },
	[15] = { ['x'] = -2959.49, ['y'] = 387.15, ['z'] = 14.05 },
	[16] = { ['x'] = -3047.85, ['y'] = 585.73, ['z'] = 7.91 },
	[17] = { ['x'] = 1126.89, ['y'] = -980.15, ['z'] = 45.42 },
	[18] = { ['x'] = 1169.23, ['y'] = 2717.86, ['z'] = 37.16 },
	[19] = { ['x'] = -1479.03, ['y'] = -375.45, ['z'] = 39.17 },
	[20] = { ['x'] = -1220.88, ['y'] = -915.91, ['z'] = 11.33 },
	[21] = { ['x'] = 169.02, ['y'] = 6644.55, ['z'] = 31.72 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERSBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if not robbery then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(robbers) do
				local distance = Vdist(x,y,z,v.x,v.y,v.z)
				if distance <= 1.1 and GetEntityHealth(ped) > 101 then
					drawText("PRESSIONE  ~r~E~w~  PARA INICIAR O ROUBO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and timedown <= 0 then
						timedown = 3
						if vSERVER.checkPolice() then
							vSERVER.startRobbery(k,v.x,v.y,v.z)
						end
					end
				end
			end
		else
			drawText("PARA CANCELAR O ROUBO SAIA PELA PORTA DA FRENTE",4,0.5,0.88,0.36,255,255,255,50)
			drawText("AGUARDE ~g~"..timedown.." SEGUNDOS~w~ ATÉ QUE TERMINE O ROUBO",4,0.5,0.9,0.46,255,255,255,150)
			if GetEntityHealth(PlayerPedId()) <= 101 then
				robbery = false
				vSERVER.stopRobbery()
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startRobbery(time,x2,y2,z2)
	robbery = true
	timedown = time
	SetPedComponentVariation(PlayerPedId(),5,45,0,2)
	Citizen.CreateThread(function()
		while robbery do
			Citizen.Wait(5)
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(x,y,z,x2,y2,z2)
			if distance >= 10.0 then
				robbery = false
				vSERVER.stopRobbery()
			end
		end
	end)
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
			if timedown == 0 then
				robbery = false
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