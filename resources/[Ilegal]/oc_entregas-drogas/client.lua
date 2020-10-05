local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CONEXÕES ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
oC = Tunnel.getInterface("oc_entregas-drogas")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local emprocesso = false
local segundos = 0
local selecionado = 0
local quantidade = 0
local porcentagem = 0
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local CoordenadaX = 2332.63
local CoordenadaY = 4856.33
local CoordenadaZ = 41.81
-----------------------------------------------------------------------------------------------------------------------------------------
--[ RESIDENCIAS ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 879.86, ['y'] = -205.07, ['z'] = 71.98 },
	[2] = { ['x'] = 862.52, ['y'] = -138.65, ['z'] = 79.22 },
	[3] = { ['x'] = 474.96, ['y'] = -635.79, ['z'] = 25.65 }, 
	[4] = { ['x'] = 1170.09, ['y'] = -402.72, ['z'] = 71.98 }, 
	[5] = { ['x'] = 1308.47, ['y'] = -661.17, ['z'] = 67.51 }, 
	[6] = { ['x'] = -2.07, ['y'] = -1442.08, ['z'] = 30.97 }, 
	[7] = { ['x'] = -64.52, ['y'] = -1449.6, ['z'] = 32.53 }, 
	[8] = { ['x'] = 115.71, ['y'] = -271.62, ['z'] = 50.52 }, 
	[9] = { ['x'] = 8.58, ['y'] = -243.14, ['z'] = 51.87 }, 
	[10] = { ['x'] = -9.88, ['y'] = -200.57, ['z'] = 57.09 }, 
	[11] = { ['x'] = -333.03, ['y'] = 101.02, ['z'] = 71.22 }, 
	[12] = { ['x'] = -105.75, ['y'] = 33.02, ['z'] = 71.44 }, 
	[13] = { ['x'] = 143.55, ['y'] = -113.42, ['z'] = 62.3 }, 
	[14] = { ['x'] = 371.69, ['y'] = 72.51, ['z'] = 98.18 }, 
	[15] = { ['x'] = 115.98, ['y'] = 170.79, ['z'] = 112.46 }, 
	[16] = { ['x'] = -155.04, ['y'] = 214.65, ['z'] = 98.33 },
	[17] = { ['x'] = -1492.59, ['y'] = -149.92, ['z'] = 52.51 }, 
	[18] = { ['x'] = -1039.1, ['y'] = -1353.4, ['z'] = 5.56 },
	[19] = { ['x'] = -882.79, ['y'] = -1155.46, ['z'] = 5.17 }, 
	[20] = { ['x'] = -1269.96, ['y'] = -1296.37, ['z'] = 4.01 }, 
	[21] = { ['x'] = -1381.26, ['y'] = -940.87, ['z'] = 10.18 }, 
	[22] = { ['x'] = -1750.47, ['y'] = -697.47, ['z'] = 10.18 }, 
	[23] = { ['x'] = -1487.1, ['y'] = -909.97, ['z'] = 10.03 }, 
	[24] = { ['x'] = -1027.72, ['y'] = -1575.45, ['z'] = 5.27 },
	[25] = { ['x'] = -1208.49, ['y'] = -1384.21, ['z'] = 4.09 }, 
	[26] = { ['x'] = -1097.4, ['y'] = -1673.04, ['z'] = 8.4 }, 
	[27] = { ['x'] = -699.64, ['y'] = -1315.87, ['z'] = 5.11 },
	[28] = { ['x'] = -604.34, ['y'] = -802.52, ['z'] = 25.41 }, 
	[29] = { ['x'] = -32.35, ['y'] = -1446.44, ['z'] = 31.9 },
	[30] = { ['x'] = 415.78, ['y'] = -1485.57, ['z'] = 30.15 }, 
	[31] = { ['x'] = 1286.6, ['y'] = -1604.32, ['z'] = 54.83 }, 
	[32] = { ['x'] = 1185.2, ['y'] = -1620.31, ['z'] = 45.03 }, 
	[33] = { ['x'] = 1354.85, ['y'] = -1690.61, ['z'] = 60.5 },
	[34] = { ['x'] = 1437.53, ['y'] = -1491.87, ['z'] = 63.63 },
	[35] = { ['x'] = 1451.19, ['y'] = -1720.56, ['z'] = 68.76 }, 
	[36] = { ['x'] = 368.58, ['y'] = -1896.02, ['z'] = 25.18 }, 
	[37] = { ['x'] = 367.46, ['y'] = -1802.29, ['z'] = 29.07 }, 
	[38] = { ['x'] = 149.88, ['y'] = -1864.6, ['z'] = 24.6 },
	[39] = { ['x'] = -4.74, ['y'] = -1872.06, ['z'] = 24.16 }, 
	[40] = { ['x'] = -80.89, ['y'] = -1326.1, ['z'] = 29.27 },
	[41] = { ['x'] = 368.42, ['y'] = -1107.38, ['z'] = 29.41 }, 
	[42] = { ['x'] = 328.42, ['y'] = -994.57, ['z'] = 29.32 }, 
	[43] = { ['x'] = 479.18, ['y'] = -106.69, ['z'] = 63.16 }, 
	[44] = { ['x'] = 167.0, ['y'] = -1709.63, ['z'] = 29.3 }, 
	[45] = { ['x'] = -1328.05, ['y'] = -402.57, ['z'] = 36.61 }, 
	[46] = { ['x'] = -1426.24, ['y'] = -99.59, ['z'] = 51.77 }, 
	[47] = { ['x'] = -21.49, ['y'] = -1001.98, ['z'] = 29.5 },
	[48] = { ['x'] = 978.17, ['y'] = -1466.22, ['z'] = 31.52 }, 
	[49] = { ['x'] = -850.83, ['y'] = -252.29, ['z'] = 39.66 }, 
	[50] = { ['x'] = -1023.52, ['y'] = -1614.41, ['z'] = 5.09 }, 
	[51] = { ['x'] = -102.94, ['y'] = 397.5, ['z'] = 112.43 }, 
	[52] = { ['x'] = -1965.37, ['y'] = -296.92, ['z'] = 41.1 }, 
	[53] = { ['x'] = -105.77, ['y'] = 32.88, ['z'] = 71.44 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRABALHAR ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tc",function(source,args)
	if oC.checkPermissao() then
		TriggerEvent("Notify","negado","<b>Desconhecido: </b>O que? Drogas? Que isso? Oi? Não sei não!",4000)
		TriggerEvent("Notify","negado","<b>Desconhecido: </b>Alô, Policia? Quero fazer uma denúncia!",5000)
	else
		if not servico then
			if not emprocesso then
				emprocesso = true
				servico = true
				segundos = 900
				selecionado = math.random(30)
				CriandoBlip(locs,selecionado)
				oC.Quantidade()
				TriggerEvent("Notify","sucesso","Você entrou em serviço.")
				TriggerEvent("Notify","importante","Vá até o próximo local e entregue <b>"..quantidade.."x Drogas</b>.")
			else
				TriggerEvent("Notify","importante","Aguarde <b>"..segundos.." segundos</b> até acharmos outras entregas.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ENTREGAS ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 4 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,247,217,99,100,1,0,0,1)
				if distance <= 2.5 then
					drawTxt("PRESSIONE  ~y~E~w~  PARA ENTREGAR AS DROGAS",4,0.5,0.92,0.35,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if oC.checkItens() then
							porcentagem = math.random(100)

							if porcentagem >= 50 then
								oC.chamarPoliciais()
								TriggerEvent("Notify","negado","O comprador recusou a venda e chamou a policia!")	
							elseif porcentagem < 50 then
								oC.checkPayment()
								RemoveBlip(blips)
								backentrega = selecionado
								while true do
									if backentrega == selecionado then
										selecionado = math.random(53)
									else
										break
									end
									Citizen.Wait(1)
								end
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Vá até o próximo local e entregue <b>"..quantidade.."x Drogas</b>.")
							end
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if emprocesso then
			if segundos > 0 then
				segundos = segundos - 1
				if segundos == 0 then
					emprocesso = false
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CANCELAR ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
			if IsControlJustPressed(0,121) then
				TriggerEvent("Notify","importante","Vá até o próximo local e entregue <b>"..quantidade.."x Drogas</b>.")
			elseif IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ STATUS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("quantidade-drogas")
AddEventHandler("quantidade-drogas",function(status)
    quantidade = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------------
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
	SetBlipSprite(blips,207)
	SetBlipColour(blips,1)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Drogas")
	EndTextCommandSetBlipName(blips)
end