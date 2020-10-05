local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
fan_radar = Tunnel.getInterface("orp_radar")

local multar = false
local flash = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- RADAR
----------------------------------------------------------------------------------------------------------------------------------------

local radares = {  
	--{ ['x'] = 290.60, ['y'] = -853.14, ['z'] = 29.16, ['m'] = 80 }, --PRAÇA
	--{ ['x'] = 224.84, ['y'] = -1041.40, ['z'] = 29.36, ['m'] = 80 }, --PRAÇA
	--{ ['x'] = 105.20, ['y'] = -1000.39, ['z'] = 29.39, ['m'] = 80 }, --PRAÇA
	--{ ['x'] = 173.28, ['y'] = -817.71, ['z'] = 31.17, ['m'] = 80 }, --PRAÇA
	{ ['x'] = 261.54, ['y'] = -584.69, ['z'] = 43.32, ['m'] = 80 }, --HOSPITAL
	--{ ['x'] = 783.67, ['y'] = -1005.85,35, ['z'] = 26.13, ['m'] = 80 }, --PONTE MECANICA
--	{ ['x'] = 1711.68, ['y'] = -899.17, ['z'] = 68.299, ['m'] = 180 }, --RODOVIA
--	{ ['x'] = 2094.61, ['y'] = 1401.91, ['z'] = 75.38, ['m'] = 180 }, --RODOVIA
	--{ ['x'] = 1517.21, ['y'] = 862.46, ['z'] = 77.08, ['m'] = 180 }, --RODOVIA
 	--{ ['x'] = -2591.46, ['y'] = 3179.21, ['z'] = 14.14, ['m'] = 180 }, --RODOVIA
	--{ ['x'] = 1105.42, ['y'] = 6487.66, ['z'] = 21.06, ['m'] = 180 },	--RODOVIA
	--{ ['x'] = -2932.00, ['y'] = 85.19, ['z'] = 13.57, ['m'] = 180 }, --RODOVIA
}


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		for v,k in pairs(radares) do
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(ped, false)
			local driver = GetPedInVehicleSeat(vehicle, -1)
			local distance = GetDistanceBetweenCoords(k.x,k.y,k.z,GetEntityCoords(ped),true)
			local speed = GetEntitySpeed(vehicle)*3.6
			if distance <= 20.0 and driver == ped then
				if speed >= k.m and fan_radar.checkperm() and not multa then 
					TriggerEvent("Notify","importante","<b>Radar</b> "..k.m.." KM/H<br> Você está livre do radar, obrigado por seus serviços")
					multa = true
					SetTimeout(1000,function()
						multa = false
					end)
				end

				if speed >= k.m and not fan_radar.checkperm() then
					if not flash then
						flash = true
						PlaySoundFrontend( -1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1 )
						vRP.setDiv("radar",".div_radar { background: #fff; margin: 0; width: 100%; height: 100%; opacity: 0.9; }","")
						SetTimeout(20,function()
							vRP.removeDiv("radar")
						end)
					end
					if not multa then
						multa = true
						SetTimeout(10000,function()
							flash = false
							multa = false
							calculo = 1000
							fan_radar.checarMulta(calculo)
							vRP.removeDiv("radar")
							TriggerEvent("Notify","aviso","<b>Multa</b> <br>Você foi multado por alta velocidade em: <b>"..calculo.."$</b>")
						end)
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	for v, k in pairs(radares) do
		posblip = AddBlipForCoord(k.x, k.y, k.z)
		SetBlipSprite(posblip, 184)
		SetBlipScale(posblip, 0.3)
		SetBlipColour(posblip, 69)
		SetBlipColour(posblip,4)
		SetBlipAsShortRange(posblip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Radar de Velocidade")
		EndTextCommandSetBlipName(posblip)
	end
end)