local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("hospital_coletar")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = 309.52
local CoordenadaY = -596.54
local CoordenadaZ = 43.3
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS   40283203,78222656,8852081299
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 180.44, ['y'] = -283.33, ['z'] = 50.28 },
	[2] = { ['x'] = 307.35, ['y'] = -216.71, ['z'] = 58.02 },
	[3] = { ['x'] = 284.16, ['y'] = 31.13, ['z'] = 88.61 },
	[4] = { ['x'] = 251.87, ['y'] = 358.56, ['z'] = 105.97 },
	[5] = { ['x'] = -0.73, ['y'] = 302.18, ['z'] = 111.08 },
	[6] = { ['x'] = -245.9, ['y'] = 155.92, ['z'] = 74.07 },
	[7] = { ['x'] = -786.32, ['y'] = 36.94, ['z'] = 48.34 },
	[8] = { ['x'] = -894.0, ['y'] = 130.31, ['z'] = 59.27 },
	[9] = { ['x'] = -788.42, ['y'] = -6.51, ['z'] = 40.88 },
	[10] = { ['x'] = -1094.91, ['y'] = 427.17, ['z'] = 75.88 },
	[11] = { ['x'] = -1090.01, ['y'] = 548.5, ['z'] = 103.64 },
	[12] = { ['x'] = -1579.04, ['y'] = 184.97, ['z'] = 58.86 },
	[13] = { ['x'] = -1564.41, ['y'] = -300.36, ['z'] = 48.23 },
	[14] = { ['x'] = -1263.84, ['y'] = -636.84, ['z'] = 26.97 },
	[15] = { ['x'] = -1342.74, ['y'] = -872.02, ['z'] = 16.87 },
	[16] = { ['x'] = -819.5, ['y'] = -902.06, ['z'] = 18.89 },
	[17] = { ['x'] = -822.4, ['y'] = -1223.3, ['z'] = 7.37 },
	[18] = { ['x'] = -667.69, ['y'] = -971.62, ['z'] = 22.35 },
	[19] = { ['x'] = -232.26, ['y'] = -915.51, ['z'] = 32.32 },
	[20] = { ['x'] = 143.02, ['y'] = -832.96, ['z'] = 31.18 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 30.0 then
				DrawMarker(21,CoordenadaX,CoordenadaY,CoordenadaZ-0.5,0,0,0,0,180.0,130.0,1.0,1.0,0.5,240,0,0,30,1,0,0,1)
				if distance <= 1.5 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR A ROTA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() then
						servico = true
						selecionado = 1
						CriandoBlip(locs,selecionado)
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
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.7,0,0,0,0,180.0,130.0,1.0,1.0,0.5,240,200,80,30,1,0,0,1)
				if distance <= 1.5 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA COLETAR OS ITENS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() then
                  if emP.checkPayment() then
                     RemoveBlip(blips)
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
