local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_desmanche")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local segundos = 0
local roubando = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['x'] = 2350.52, ['y'] = 3133.54, ['z'] = 48.21, ['perm'] = "desmanche.permissao" },
	{ ['x'] = 1978.42, ['y'] = 5171.28, ['z'] = 47.64, ['perm'] = "desmanche.permissao" },
	{ ['x'] = 1533.97, ['y'] = 3534.66, ['z'] = 35.43, ['perm'] = "desmanche.permissao" },
	{ ['x'] = 1265.67, ['y'] = -2563.91, ['z'] = 42.83, ['perm'] = "desmanche.permissao" },
	{ ['x'] = 1535.16, ['y'] = 3547.12, ['z'] = 36.94, ['perm'] = "desmanche.permissao" }  
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESMANCHE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if not roubando then
			for _,v in pairs(locais) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(v)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),v.x,v.y,v.z)
				if distance <= 50 and GetPedInVehicleSeat(GetVehiclePedIsUsing(ped),-1) == ped then
					DrawMarker(23,v.x,v.y,v.z-0.96,0,0,0,0,0,0,5.0,5.0,0.5,255,0,0,50,0,0,0,0)
					if distance <= 3.1 and IsControlJustPressed(0,38) then
						if emP.checkVehicle() and emP.checkPermission(v.perm) and emP.checkPolice() then
							roubando = true
							segundos = 60
							FreezeEntityPosition(GetVehiclePedIsUsing(ped),true)

							repeat
								Citizen.Wait(10)
							until segundos == 0

							TriggerServerEvent("desmancheVehicles5454564645666")
							roubando = false
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if roubando then
			if segundos > 0 then
				DisableControlAction(0,75)
				drawTxt("AGUARDE ~g~"..segundos.." SEGUNDOS~w~, ESTAMOS DESATIVANDO O ~y~RASTREADOR ~w~DO VEÍCULO",4,0.5,0.93,0.50,255,255,255,180)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUINDO O TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if roubando then
			if segundos > 0 then
				segundos = segundos - 1
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