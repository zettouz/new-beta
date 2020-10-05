local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("frutas_coletar")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
local segundos = 0
local list = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CORDENADAS DAS ARVORES
-----------------------------------------------------------------------------------------------------------------------------------------
local arvores = {
	{ 2325.38,4761.92,36.04,243.26 }, 
	{ 2327.09,4770.99,36.12,243.26 }, 
	{ 2338.75,4767.45,35.24,243.26 }, 
	{ 2343.1,4755.86,34.83,243.26 }, 
	{ 2353.22,4760.77,34.37,243.26 }, 
	{ 2366.79,4751.73,33.86,243.26 }, 
	{ 2374.41,4735.47,33.73,243.26 }, 
	{ 2386.57,4736.6,33.28,243.26 }, 
	{ 2386.63,4724.78,33.63,243.26 }, 
	{ 2402.07,4717.57,33.17,243.26 }, 
	{ 2404.13,4704.32,33.39,243.26 }, 
	{ 2412.39,4707.61,33.01,243.26 }, 
	{ 2423.67,4698.3,33.06,243.26 }, 
	{ 2421.97,4687.03,33.69,243.26 }, 
	{ 2433.94,4679.03,33.39,243.26 }, 
	{ 2443.04,4672.47,33.34,243.26 },
	{ 2424.18,4658.41,33.47,35.57 },
	{ 2420.22,4673.42,33.87,35.57 },
	{ 2407.37,4676.57,33.98,35.57 }, 
	{ 2402.03,4687.86,33.7,35.57 }, 
	{ 2390.16,4690.68,33.94,35.57 }, 
	{ 2381.95,4700.23,33.92,35.57 }, 
	{ 2383.52,4712.69,33.7,35.57 }, 
	{ 2367.24,4715.51,34.3,35.57 }, 
	{ 2365.13,4729.2,34.17,35.57 }, 
	{ 2359.66,4723.56,34.54,35.57 }, 
	{ 2350.88,4733.79,34.83,35.57 }, 
	{ 2339.87,4741.12,35.08,35.57 }, 
	{ 2325.01,4746.59,36.02,35.57 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if not processo then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(arvores) do
				local distance = Vdist(x,y,z,v[1],v[2],v[3])
				if distance <= 25 and not list[k] then
					DrawMarker(21,v[1],v[2],v[3],0,0,0,0,180.0,130.0,0.5,0.5,0.5,255,0,0,50,1,0,0,1)
					if distance <= 1.2 then
						drawTxt("PRESSIONE  ~r~E~w~  PARA COLHER LARANJA",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) then
							list[k] = true
							processo = true
							segundos = 4
							SetEntityCoords(ped,v[1],v[2],v[3]-1)
							SetEntityHeading(ped,v[4])
							vRP._playAnim(false,{{"amb@prop_human_movie_bulb@base","base"}},true)
							emP.checkFrutas()
							TriggerEvent('cancelando',true)
						end
					end
				end
			end
		else
			drawTxt("AGUARDE ~g~"..segundos.."~w~ SEGUNDOS ATÉ FINALIZAR A COLHEITA DAS LARANJAS",4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if processo and segundos > 0 then
			segundos = segundos - 1
			if segundos == 0 then
				processo = false
				vRP._stopAnim(false)
				TriggerEvent('cancelando',false)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(180000)
		list = {}
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