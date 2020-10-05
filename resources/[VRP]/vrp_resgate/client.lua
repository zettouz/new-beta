local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

Resg = Tunnel.getInterface("vrp_resgate")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ REANIMAR ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('reanimar')
AddEventHandler('reanimar',function()
	local handle,ped = FindFirstPed()
	local finished = false
	local reviver = nil
	repeat
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(ped),true)
		if IsPedDeadOrDying(ped) and not IsPedAPlayer(ped) and distance <= 1.5 and reviver == nil then
			reviver = ped
			TriggerEvent("cancelando",true)
			vRP._playAnim(false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
			TriggerEvent("progress",15000,"reanimando")
			SetTimeout(15000,function()
				SetEntityHealth(reviver,130)
				local newped = ClonePed(reviver,GetEntityHeading(reviver),true,true)
				TaskWanderStandard(newped,10.0,10)
				local model = GetEntityModel(reviver)
				SetModelAsNoLongerNeeded(model)
				Citizen.InvokeNative(0xAD738C3085FE7E11,reviver,true,true)
				TriggerServerEvent("trydeleteped",PedToNet(reviver))
				vRP._stopAnim(false)
				TriggerServerEvent("reanimar:pagamento55884896")
				TriggerEvent("cancelando",false)
			end)
			finished = true
		end
		finished,ped = FindNextPed(handle)
	until not finished
	EndFindPed(handle)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MACAS DO HOSPITAL ]------------------------------------------------------------------------------------------------------------------ 
-----------------------------------------------------------------------------------------------------------------------------------------
local macas = {
	{ ['x'] = 348.28, ['y'] = -581.52, ['z'] = 43.29, ['x2'] = 349.01, ['y2'] = -582.0, ['z2'] = 44.21, ['h'] = 160.8 },
	{ ['x'] = 350.87, ['y'] = -582.4, ['z'] = 43.29, ['x2'] = 351.54, ['y2'] = -583.08, ['z2'] = 44.21, ['h'] = 160.8 },
	{ ['x'] = 353.48, ['y'] = -583.39, ['z'] = 43.29, ['x2'] = 354.17, ['y2'] = -583.98, ['z2'] = 44.21, ['h'] = 160.8 },
	{ ['x'] = 355.75, ['y'] = -584.53, ['z'] = 43.29, ['x2'] = 356.53, ['y2'] = -584.95, ['z2'] = 44.21, ['h'] = 160.8 },
	{ ['x'] = 366.36, ['y'] = -581.34, ['z'] = 43.29, ['x2'] = 367.25, ['y2'] = -581.65, ['z2'] = 44.21, ['h'] = 334.32 },
	{ ['x'] = 361.88, ['y'] = -579.73, ['z'] = 43.29, ['x2'] = 361.02, ['y2'] = -579.42, ['z2'] = 44.21, ['h'] = 334.32 },
	{ ['x'] = 358.11, ['y'] = -579.19, ['z'] = 43.29, ['x2'] = 359.03, ['y2'] = -579.35, ['z2'] = 44.21, ['h'] = 334.32 },
	{ ['x'] = 355.87, ['y'] = -578.31, ['z'] = 43.29, ['x2'] = 356.75, ['y2'] = -578.47, ['z2'] = 44.21, ['h'] = 334.32 },
	{ ['x'] = 353.41, ['y'] = -577.4, ['z'] = 43.29, ['x2'] = 354.44, ['y2'] = -577.44, ['z2'] = 44.21, ['h'] = 334.32 },
	{ ['x'] = 350.87, ['y'] = -576.4, ['z'] = 43.29, ['x2'] = 351.88, ['y2'] = -576.68, ['z2'] = 44.21, ['h'] = 334.32 },
	{ ['x'] = 330.41, ['y'] = -568.99, ['z'] = 43.29, ['x2'] = 331.44, ['y2'] = -569.2, ['z2'] = 44.21, ['h'] = 334.32 },
	{ ['x'] = 327.48, ['y'] = -568.06, ['z'] = 43.29, ['x2'] = 328.44, ['y2'] = -568.27, ['z2'] = 44.21, ['h'] = 334.32 },
	{ ['x'] = 324.71, ['y'] = -566.75, ['z'] = 43.29, ['x2'] = 325.48, ['y2'] = -567.06, ['z2'] = 44.21, ['h'] = 334.32 },
	{ ['x'] = 328.36, ['y'] = -575.05, ['z'] = 43.29, ['x2'] = 329.26, ['y2'] = -575.36, ['z2'] = 44.21, ['h'] = 160.8 },
	{ ['x'] = 325.3, ['y'] = -573.82, ['z'] = 43.29, ['x2'] = 326.17, ['y2'] = -574.14, ['z2'] = 44.21, ['h'] = 160.8 },
	{ ['x'] = 322.2, ['y'] = -572.83, ['z'] = 43.29, ['x2'] = 322.98, ['y2'] = -573.1, ['z2'] = 44.21, ['h'] = 160.8 },
	{ ['x'] = 355.01, ['y'] = -572.24, ['z'] = 28.92, ['x2'] = 355.76, ['y2'] = -572.4, ['z2'] = 29.95, ['h'] = 336.18 },
	{ ['x'] = 356.98, ['y'] = -566.43, ['z'] = 28.93, ['x2'] = 357.88, ['y2'] = -566.58, ['z2'] = 29.95, ['h'] = 336.18},
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MACAS DO NORTE ]---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	{ ['x'] = 1820.66, ['y'] = 3673.29, ['z'] = 34.28, ['x2'] = 1819.68, ['y2'] = 3673.12, ['z2'] = 35.2, ['h'] = 34.67 },
	{ ['x'] = 1827.1, ['y'] = 3675.49, ['z'] = 34.28, ['x2'] = 1826.54, ['y2'] = 3676.75, ['z2'] = 35.2, ['h'] = 25.96 },
	{ ['x'] = 1818.78, ['y'] = 3677.54, ['z'] = 34.28, ['x2'] = 1818.48, ['y2'] = 3678.42, ['z2'] = 35.02, ['h'] = 299.13 },
	{ ['x'] = 1822.24, ['y'] = 3679.64, ['z'] = 34.28, ['x2'] = 1822.08, ['y2'] = 3680.65, ['z2'] = 34.99, ['h'] = 296.86 },
	{ ['x'] = 1829.47, ['y'] = 3678.59, ['z'] = 34.28, ['x2'] = 1828.59, ['y2'] = 3678.33, ['z2'] = 34.98, ['h'] = 29.4 },
	{ ['x'] = 322.2, ['y'] = -572.83, ['z'] = 43.29, ['x2'] = 322.98, ['y2'] = -573.1, ['z2'] = 44.21, ['h'] = 160.8 },
	{ ['x'] = 1831.95, ['y'] = 3674.64, ['z'] = 34.28, ['x2'] = 1830.94, ['y2'] = 3674.37, ['z2'] = 34.99, ['h'] = 29.4 },
}

local macas2 = { 
	{ ['x'] = 309.26, ['y'] = -573.12, ['z'] = 43.31, ['x2'] = 308.68, ['y2'] = -573.4, ['z2'] = 44.26, ['h'] = 26.74 },
	{ ['x'] = 311.17, ['y'] = -562.23, ['z'] = 43.31, ['x2'] = 310.6, ['y2'] = -562.49, ['z2'] = 44.26, ['h'] = 25.4 },
	{ ['x'] = 314.74, ['y'] = -564.04, ['z'] = 43.31, ['x2'] = 315.32, ['y2'] = -564.25, ['z2'] = 44.26, ['h'] = 334.32 },
	{ ['x'] = 320.96, ['y'] = -566.2, ['z'] = 43.31, ['x2'] = 320.47, ['y2'] = -565.94, ['z2'] = 44.26, ['h'] = 334.32 },
	{ ['x'] = 306.2, ['y'] = -579.71, ['z'] = 48.25, ['x2'] = 305.47, ['y2'] = -579.53, ['z2'] = 49.02, ['h'] = 160.05 },
	{ ['x'] = 308.95, ['y'] = -571.1, ['z'] = 48.28, ['x2'] = 308.76, ['y2'] = -571.66, ['z2'] = 49.22, ['h'] = 74.15 },

}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ USO ]-------------------------------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------------------
local emMaca = false
Citizen.CreateThread(function()
	while true do
		local timing = 1000
		for k,v in pairs(macas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local cod = macas[k]
			
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), cod.x, cod.y, cod.z, true ) <= 2 then
				timing = 5
				DrawText3D(cod.x, cod.y, cod.z, "[~g~E~w~] Para deitar       [~r~G~w~] Para iniciar tratamento")
			end
			
			if distance <= 1.1 then
				timing = 5
				if IsControlJustPressed(0,38) then
					SetEntityCoords(ped,v.x2,v.y2,v.z2)
					SetEntityHeading(ped,v.h)
					vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
					emMaca = true
				end
				if IsControlJustPressed(0,47) then
					if Resg.checkServices() then
						TriggerEvent('tratamento-macas')
						TriggerEvent('resetDiagnostic')
						TriggerEvent('resetWarfarina')
						SetEntityCoords(ped,v.x2,v.y2,v.z2)
						SetEntityHeading(ped,v.h)
						vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
					else
						TriggerEvent("Notify","aviso","Existem paramédicos em serviço.")
					end
				end
			end
			
			if emMaca then
				timing = 5
				if IsControlJustPressed(0,167) then
					ClearPedTasks(GetPlayerPed(-1))
					emMaca = false
				end
			end
		end
		Citizen.Wait(timing)
	end
end)

Citizen.CreateThread(function()
	while true do
		local timing = 1000
		for k,v in pairs(macas2) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local cod = macas2[k]
			
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), cod.x, cod.y, cod.z, true ) <= 2 then
				timing = 5
				DrawText3D(cod.x, cod.y, cod.z, "[~g~E~w~] Para deitar")
			end
			
			if distance <= 1.1 then
				timing = 5
				if IsControlJustPressed(0,38) then
					SetEntityCoords(ped,v.x2,v.y2,v.z2)
					SetEntityHeading(ped,v.h)
					vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
				end
			end
		end
		Citizen.Wait(timing)
	end
end)

RegisterNetEvent('tratamento-macas')
AddEventHandler('tratamento-macas',function()
	TriggerEvent("cancelando",true)
	repeat
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())+1)
		Citizen.Wait(1500)
	until GetEntityHealth(PlayerPedId()) >= 400 or GetEntityHealth(PlayerPedId()) <= 100
	TriggerEvent("Notify","importante","Tratamento concluido.")
	TriggerEvent("cancelando",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRATAMENTO ]-------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local tratamento = false
RegisterNetEvent("tratamento")
AddEventHandler("tratamento",function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armour = GetPedArmour(ped)

    SetEntityHealth(ped,health)
	--SetPedArmour(ped,armour)
	TriggerEvent("cap666",armour)
	
	if emMaca then
		if tratamento then
			return
		end

		tratamento = true
		TriggerEvent("Notify","sucesso","Tratamento iniciado, aguarde a liberação do <b>profissional médico.</b>.",8000)
		TriggerEvent('resetWarfarina')
		TriggerEvent('resetDiagnostic')
		

		if tratamento then
			repeat
				Citizen.Wait(600)
				if GetEntityHealth(ped) > 101 then
					SetEntityHealth(ped,GetEntityHealth(ped)+1)
				end
			until GetEntityHealth(ped) >= 240 or GetEntityHealth(ped) <= 101
				TriggerEvent("Notify","sucesso","Tratamento concluido.",8000)
				tratamento = false
		end
	else
		TriggerEvent("Notify","negado","Você precisa estar deitado em uma maca para ser tratado.",8000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRATAMENTO ]-------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local tratamento2 = false
RegisterNetEvent("tratamento2")
AddEventHandler("tratamento2",function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armour = GetPedArmour(ped)

    SetEntityHealth(ped,health)
	--SetPedArmour(ped,armour)
	TriggerEvent("cap666",armour)
	
	if emMaca then
		if tratamento2 then
			return
		end

		tratamento2 = true
		TriggerEvent("Notify","sucesso","Tratamento iniciado, aguarde a liberação do <b>profissional médico.</b>.",8000)
		TriggerEvent('resetWarfarina')
		TriggerEvent('resetDiagnostic')
		

		if tratamento2 then
			repeat
				Citizen.Wait(600)
				if GetEntityHealth(ped) > 101 then
					SetEntityHealth(ped,GetEntityHealth(ped)+1)
				end
			until GetEntityHealth(ped) >= 400 or GetEntityHealth(ped) <= 101
				TriggerEvent("Notify","sucesso","Tratamento concluido.",8000)
				tratamento2 = false
		end
	else
		TriggerEvent("Notify","negado","Você precisa estar deitado em uma maca para ser tratado.",8000)
	end
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

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end