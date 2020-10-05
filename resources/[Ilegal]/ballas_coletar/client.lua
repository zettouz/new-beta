local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("ballas_coletar")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = 88.01
local CoordenadaY = -1985.41
local CoordenadaZ = 20.42
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS  88.01,-1985.41,20.42
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 879.86, ['y'] = -205.07, ['z'] = 71.98 },
	[2] = { ['x'] = 418.7, ['y'] = -207.08, ['z'] = 59.92 },
	[3] = { ['x'] = 474.96, ['y'] = -635.79, ['z'] = 25.65 }, 
	[4] = { ['x'] = 1170.09, ['y'] = -402.72, ['z'] = 71.98 }, 
	[5] = { ['x'] = 156.3, ['y'] = -116.86, ['z'] = 62.6 }, 
	[6] = { ['x'] = -2.07, ['y'] = -1442.08, ['z'] = 30.97 }, 
	[7] = { ['x'] = -578.06, ['y'] = -1012.83, ['z'] = 22.33 }, 
	[8] = { ['x'] = 113.42, ['y'] = -277.68, ['z'] = 46.34 }, 
	[9] = { ['x'] = -510.87, ['y'] = -53.02, ['z'] = 42.12 }, 
	[10] = { ['x'] = -598.79, ['y'] = 170.45, ['z'] = 66.07 }, 
	[11] = { ['x'] = -480.72, ['y'] = -402.05, ['z'] = 34.55 }, 
	[12] = { ['x'] = 17.73, ['y'] = -13.85, ['z'] = 70.32 }, 
	[13] = { ['x'] = 1308.47, ['y'] = -661.17, ['z'] = 67.51 }, 
	[14] = { ['x'] = 371.68, ['y'] = 72.54, ['z'] = 98.18 }, 
	[15] = { ['x'] = -316.92, ['y'] = -226.17, ['z'] = 36.85 }, 
	[16] = { ['x'] = -155.04, ['y'] = 214.65, ['z'] = 98.33 },
	[17] = { ['x'] = -884.33, ['y'] = -1072.1, ['z'] = 2.17 }, 
	[18] = { ['x'] = -1257.53, ['y'] = -1149.95, ['z'] = 7.78 },
	[19] = { ['x'] = -988.8, ['y'] = -1575.62, ['z'] = 5.24 }, 
	[20] = { ['x'] = -1247.07, ['y'] = -1358.31, ['z'] = 7.83 }, 
	[21] = { ['x'] = 115.98, ['y'] = 170.79, ['z'] = 112.46 }, 
	[22] = { ['x'] = -1793.44, ['y'] = -663.9, ['z'] = 10.61 }, 
	[23] = { ['x'] = -1471.77, ['y'] = -920.11, ['z'] = 10.03 }, 
	[24] = { ['x'] = -1307.77, ['y'] = -832.78, ['z'] = 17.14 },
	[25] = { ['x'] = -1152.14, ['y'] = -913.34, ['z'] = 6.8 }, 
	[26] = { ['x'] = -684.33, ['y'] = -1171.0, ['z'] = 10.62 }, 
	[27] = { ['x'] = -588.36, ['y'] = -783.67, ['z'] = 25.02 },
	[28] = { ['x'] = -699.64, ['y'] = -1315.87, ['z'] = 5.11 }, 
	[29] = { ['x'] = -14.33, ['y'] = -1441.55, ['z'] = 31.11 },
	[30] = { ['x'] = 415.78, ['y'] = -1485.57, ['z'] = 30.15 }, 
	[31] = { ['x'] = 1286.6, ['y'] = -1604.32, ['z'] = 54.83 }, 
	[32] = { ['x'] = 872.89, ['y'] = -1579.52, ['z'] = 30.98 }, 
	[33] = { ['x'] = 981.34, ['y'] = -1805.61, ['z'] = 35.49 },
	[34] = { ['x'] = 1220.89, ['y'] = -1270.54, ['z'] = 35.36 },
	[35] = { ['x'] = 1451.19, ['y'] = -1720.56, ['z'] = 68.76 }, 
	[36] = { ['x'] = 512.54, ['y'] = -1790.79, ['z'] = 28.92 }, 
	[37] = { ['x'] = 152.85, ['y'] = -1823.72, ['z'] = 27.87 }, 
	[38] = { ['x'] = 84.12, ['y'] = -1966.73, ['z'] = 20.94 },
	[39] = { ['x'] = 484.27, ['y'] = -1876.54, ['z'] = 26.31 }, 
	[40] = { ['x'] = -80.89, ['y'] = -1326.1, ['z'] = 29.27 },
	[41] = { ['x'] = 368.42, ['y'] = -1107.38, ['z'] = 29.41 }, 
	[42] = { ['x'] = 167.0, ['y'] = -1709.63, ['z'] = 29.3 }, 
	[43] = { ['x'] = 393.92, ['y'] = -723.05, ['z'] = 29.29 }, 
	[44] = { ['x'] = 373.02, ['y'] = -1441.36, ['z'] = 29.44 }, 
	[45] = { ['x'] = 295.2, ['y'] = -1007.2, ['z'] = 29.34 }, 
	[46] = { ['x'] = -763.2, ['y'] = -618.06, ['z'] = 30.48 }, 
	[47] = { ['x'] = -620.4, ['y'] = -306.9, ['z'] = 34.86 },
	[48] = { ['x'] = -1204.36, ['y'] = -1083.82, ['z'] = 7.89 }, 
	[49] = { ['x'] = -1186.03, ['y'] = -1385.82, ['z'] = 4.63 }, 
	[50] = { ['x'] = -1023.52, ['y'] = -1614.41, ['z'] = 5.09 }, 
	[51] = { ['x'] = -741.58, ['y'] = -982.3, ['z'] = 17.44 }, 
	[52] = { ['x'] = -1965.37, ['y'] = -296.92, ['z'] = 41.1 }, 
	[53] = { ['x'] = -83.06, ['y'] = 16.55, ['z'] = 71.64 },
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
						selecionado = 1
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
		Citizen.Wait(1)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.5 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA COLETAR OS ITENS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() then
                  if emP.checkPayment() then
					 TriggerEvent('cancelando',true)
					 RemoveBlip(blips)
					 backentrega = selecionado
					 processo = true
					 segundos = 10
					 vRP._playAnim(false,{{"amb@medic@standing@tendtodead@idle_a","idle_a"}},true)
                     if selecionado == #locs then
                        selecionado = 1
                     else
                        selecionado = selecionado + 1
                     end
                     CriandoBlip(locs,selecionado)
                  end
					end
				end
			end
      end
	end
end)

--[[Citizen.CreateThread(function()
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
								if selecionado == #locs then
									selecionado = 1
								else
									selecionado = selecionado + 1
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
end)]]--

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
