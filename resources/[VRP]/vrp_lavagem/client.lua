local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("vrp_lavagem")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS --
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIZAÇÃO DAS LAVAGENS DE DINHEIRO --
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1 , ['x'] = 29.31 , ['y'] = -1398.28 , ['z'] = 28.74, ['h'] = 4.54 },
	{ ['id'] = 2 , ['x'] = 1987.52, ['y'] = 3051.02, ['z'] = 47.22, ['h'] = 323.61 },
	{ ['id'] = 3 , ['x'] = 1275.58 , ['y'] = -1710.24 , ['z'] = 54.77, ['h'] = 302.01 },
	{ ['id'] = 4 , ['x'] = -571.44, ['y'] = 289.95, ['z'] = 79.18, ['h'] = 267.02 },
	{ ['id'] = 5 , ['x'] = -60.32, ['y'] = -2517.85, ['z'] = 7.41, ['h'] = 301.48 },
	{ ['id'] = 6 , ['x'] = 1558.56, ['y'] = 3518.13, ['z'] = 36.13, ['h'] = 217.39 },
	{ ['id'] = 7 , ['x'] = 1556.14, ['y'] = 3523.37, ['z'] = 36.12, ['h'] = 21.72 },
	{ ['id'] = 8 , ['x'] = 92.58, ['y'] = 3753.75, ['z'] = 40.78, ['h'] = 336.52 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO --
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for _,v in pairs(locais) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 1.2 and not andamento then
				drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A INVASÃO AO SISTEMA DO BANCO",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and emP.checkDinheiro() and not IsPedInAnyVehicle(ped) and emP.checkPermission() and emP.checkPolice() then
					emP.lavagemPolicia(v.id,v.x,v.y,v.z,v.h)
					emP.webhookyakuza ()
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO LAVAGEM DE DINHEIRO --
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciandolavagem")
AddEventHandler("iniciandolavagem",function(head,x,y,z)
	segundos = 20
	andamento = true
	SetEntityHeading(PlayerPedId(),head)
	SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
	SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
	TriggerEvent('cancelando',true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM --
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				andamento = false
				ClearPedTasks(PlayerPedId())
				TriggerEvent('cancelando',false)
				emP.checkPayment()
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES --
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