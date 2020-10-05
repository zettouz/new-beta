
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emP = Tunnel.getInterface("emp_leiteiro-entregas")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0

local CoordenadaX = 2338.88
local CoordenadaY = 4862.99
local CoordenadaZ = 41.81

local quantidade = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 25.75, ['y'] = -1346.49, ['z'] = 29.49 },
	[2] = { ['x'] = -41.12, ['y'] = -1748.14, ['z'] = 29.57 },
	[3] = { ['x'] = 375.87, ['y'] = 334.16, ['z'] = 103.57 },
	[4] = { ['x'] = 1160.88, ['y'] = -312.11, ['z'] = 69.36 },
	[5] = { ['x'] = -1484.85, ['y'] = -374.89, ['z'] = 40.17 },
	[6] = { ['x'] = -703.03, ['y'] = -916.85, ['z'] = 19.22 }
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
				DrawMarker(23,CoordenadaX,CoordenadaY,CoordenadaZ-0.97,0,0,0,0,0,0,1.0,1.0,0.5,247,217,99,100,0,0,0,0)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~y~E~w~  PARA INICIAR AS ENTREGAS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						servico = true
						selecionado = math.random(6)
						CriandoBlip(locs,selecionado)
						emP.Quantidade()
						TriggerEvent("Notify","sucesso","Você entrou em serviço.")
						TriggerEvent("Notify","importante","Vá até o próximo local e entregue <b>"..quantidade.."x Garrafas de Leite</b>.")
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
			local vehicle = GetPlayersLastVehicle()
			if distance <= 3 and GetEntityModel(vehicle) == 1026149675 then
				DrawMarker(23,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,247,217,99,100,0,0,0,0)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~y~G~w~  PARA ENTREGAR AS GARRAFAS DE LEITE",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,47) then
						if emP.checkPayment() then
							RemoveBlip(blips)
							backentrega = selecionado
							while true do
								if backentrega == selecionado then
									selecionado = math.random(9)
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlip(locs,selecionado)
							TriggerEvent("Notify","importante","Vá até o próximo local e entregue <b>"..quantidade.."x Garrafas de Leite</b>.")
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
			if IsControlJustPressed(0,121) then
				TriggerEvent("Notify","importante","Vá até o próximo local e entregue <b>"..quantidade.."x Garrafas de Leite</b>.")
			elseif IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
			end
		end
	end
end)

RegisterNetEvent("quantidade-leite")
AddEventHandler("quantidade-leite",function(status)
    quantidade = status
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
	AddTextComponentString("Entrega de Leite")
	EndTextCommandSetBlipName(blips)
end