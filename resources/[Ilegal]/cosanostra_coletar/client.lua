local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("cosanostra_coletar")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = 3583.92
local CoordenadaY = 3691.74
local CoordenadaZ = 27.13
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS  3583.92,3691.74,27.13
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 802.98, ['y'] = 2174.82, ['z'] = 53.08 },
	[2] = { ['x'] = 247.51, ['y'] = 3169.45, ['z'] = 42.79 },
	[3] = { ['x'] = 194.83, ['y'] = 3030.91, ['z'] = 44.02 },
	[4] = { ['x'] = 722.49, ['y'] = 2330.79, ['z'] = 51.76 },
	[5] = { ['x'] = 1218.58, ['y'] = 1848.77, ['z'] = 78.97 },
	[6] = { ['x'] = 1586.29, ['y'] = 2906.98, ['z'] = 57.98 },
	[7] = { ['x'] = 2389.25, ['y'] = 3341.72, ['z'] = 47.95 },
	[8] = { ['x'] = 2709.32, ['y'] = 4316.32, ['z'] = 46.16 },
	[9] = { ['x'] = 1308.89, ['y'] = 4362.16, ['z'] = 41.55 },
	[10] = { ['x'] = 710.76, ['y'] = 4185.41, ['z'] = 41.09 },
	[11] = { ['x'] = 471.32, ['y'] = 2607.57, ['z'] = 44.48 },
	[12] = { ['x'] = -43.79, ['y'] = 1959.9, ['z'] = 190.36 },
	[13] = { ['x'] = 2507.1, ['y'] = 4097.15, ['z'] = 38.72 },
	[14] = { ['x'] = 2251.48, ['y'] = 5155.52, ['z'] = 57.89 },
	[15] = { ['x'] = 1742.47, ['y'] = 3804.42, ['z'] = 35.12 },
	[16] = { ['x'] = 1290.09, ['y'] = 3630.73, ['z'] = 33.2 },
	[17] = { ['x'] = 346.76, ['y'] = 3405.46, ['z'] = 36.86 },
	[18] = { ['x'] = 266.0, ['y'] = 2598.34, ['z'] = 44.83 },
	[19] = { ['x'] = 1258.4, ['y'] = 2740.05, ['z'] = 38.75 },
	[20] = { ['x'] = 1776.31, ['y'] = 3327.4, ['z'] = 41.44 },
	[21] = { ['x'] = 905.75, ['y'] = 3586.26, ['z'] = 33.44 },
	[22] = { ['x'] = 1532.63, ['y'] = 3722.16, ['z'] = 34.83 },
	[23] = { ['x'] = 1928.47, ['y'] = 4609.25, ['z'] = 40.35 },
	[24] = { ['x'] = 2487.69, ['y'] = 3726.2, ['z'] = 43.93 },
	[25] = { ['x'] = 1983.0, ['y'] = 3026.27, ['z'] = 47.91 },
	[26] = { ['x'] = 983.9, ['y'] = 2718.94, ['z'] = 39.51 },
	[27] = { ['x'] = 256.24, ['y'] = 2585.95, ['z'] = 44.92 },
	[28] = { ['x'] = 1394.4, ['y'] = 3649.37, ['z'] = 34.68 },
	[29] = { ['x'] = 1830.74, ['y'] = 3738.03, ['z'] = 33.97 },
	[30] = { ['x'] = 1696.91, ['y'] = 3595.45, ['z'] = 35.62 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 3 then
				DrawMarker(21,CoordenadaX,CoordenadaY,CoordenadaZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A COLETA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() then
						servico = true
						selecionado = math.random(30)
						CriandoBlip(locs,selecionado)
						TriggerEvent("Notify","sucesso","Você entrou em serviço.")
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 3 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA COLETAR OS ITENS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() and not IsPedInAnyVehicle(ped) then
						if emP.checkPayment() then
							TriggerEvent('cancelando',true)
							RemoveBlip(blips)
							backentrega = selecionado
							processo = true
							segundos = 10
							vRP._playAnim(false,{{"amb@medic@standing@tendtodead@idle_a","idle_a"}},true)
							while true do
								if backentrega == selecionado then
									selecionado = math.random(30)
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlip(locs,selecionado)
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
      Citizen.Wait(1)
      if servico then
			drawTxt("~y~PRESSIONE ~r~F7 ~w~SE DESEJA FINALIZAR A ROTA ",4,0.270,0.905,0.45,255,255,255,200)
			drawTxt("VA ATÉ O DESTINO PARA COLETAR OS ~g~ITENS",4,0.270,0.93,0.45,255,255,255,200)
      end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos > 0 then
			segundos = segundos - 1
			if segundos == 0 then
				processo = false
				TriggerEvent('cancelando',false)
				ClearPedTasks(PlayerPedId())
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coleta de Itens")
	EndTextCommandSetBlipName(blips)
end
