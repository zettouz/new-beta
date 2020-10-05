
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = Tunnel.getInterface("frutas_entregas")

function LocalPed()
	return PlayerPedId()
end

local visits = 1
local l = 0
local area = 0
local onjob = false
local CanLeaveItem = false
local stockFrutas = 0
local limitStock = 20
local HashKeyBox = 1405043423
local veh
local prop

local destination = {
	{ x = 1790.82, y = 4594.12, z = 37.69 }, 
	{ x = 1674.70, y = 4880.67, z = 42.03 }, 
	{ x = 1701.71, y = 4931.59, z = 42.07 }, 
	{ x = 2741.11, y = 4412.86, z = 48.63 }, 
	{ x = 1262.07, y = 3545.61, z = 35.17 }, 
	{ x = 1729.40, y = 6413.28, z = 35.04 }, 
	{ x = 1089.19, y = 6509.12, z = 21.34 }, 
	{ x = 159.89, y = 6637.28, z = 31.59 }, 
	{ x = -2192.18, y = 4293.80, z = 49.18 }, 
	{ x = -2508.28, y = 3616.30, z = 13.76 }, 
	{ x = -457.86, y = 2860.16, z = 34.99 }, 
	{ x = 546.83, y = 2672.12, z = 42.16 }, 
	{ x = 1169.28, y = 2714.08, z = 38.16 }, 
	{ x = 1474.84, y = 2723.68, z = 37.59 }
}

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

RegisterNetEvent("confirmado")
AddEventHandler("confirmado", function()
   SpawnVan()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		DrawMarker(21,2306.27,4749.04,37.07-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
		if GetDistanceBetweenCoords(2306.27,4749.04,37.07, GetEntityCoords(LocalPed())) < 1.0 then
			basiccheck()
		end
		if onjob == true then 						
			DrawMarker(21,2304.69,4756.86,37.25-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
			if GetDistanceBetweenCoords(destination[l].x,destination[l].y,destination[l].z, GetEntityCoords(PlayerPedId())) < 30.0 then
				DrawMarker(21,destination[l].x, destination[l].y, destination[l].z,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)		
			end
			if GetDistanceBetweenCoords(destination[l].x,destination[l].y,destination[l].z, GetEntityCoords(PlayerPedId())) < 1.0 then
				if not IsInVehicle() and CanLeaveItem then
					drawTxt("PRESSIONE ~g~E~s~ PARA ENTREGAR A ENCOMENDA", 4,0.5,0.93,0.50,255,255,255,180)
					if (IsControlJustReleased(1, 38)) then
						deliverysucces()
					end
				end
			end
		end
	end
end)


Citizen.CreateThread(function()
	while true do
	Citizen.Wait(10)
		local myCoords = GetEntityCoords(PlayerPedId())
		if onjob then			
			if GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, 2304.69,4756.86,37.25, true) < 0.5 and onjob then
				nearBoxFarm = true
				openMenuBox(nearBoxFarm)
			elseif GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, 2304.69,4756.86,37.25, true) >= 0.5 and onjob then
				nearBoxFarm = false
				openMenuBox(nearBoxFarm)
			end
		end		
	end	
end)



Citizen.CreateThread(function()
	while true do
	Citizen.Wait(10)
		local myCoords = GetEntityCoords(PlayerPedId())
		veh = getNearVeh(8)
		local model = GetEntityModel(veh)
		
		if model == -1207771834 and onjob and CanLeaveItem then	
			coordsCar = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.50, 0.0)	
			local distance = GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, coordsCar.x,coordsCar.y,coordsCar.z, true)
			if distance < 2.0 and onjob and CanLeaveItem then
				nearDeliveryCar = true
				openMenuDeliveryCar(nearDeliveryCar)
			elseif distance >= 2.0 and onjob and CanLeaveItem then
				nearDeliveryCar = false
				openMenuDeliveryCar(nearDeliveryCar)
			end
		end	
		
		if model == -1207771834 and onjob and not CanLeaveItem then
			coordsCar2 = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.50, 0.0)	
			local distance2 = GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, coordsCar2.x,coordsCar2.y,coordsCar2.z, true)
			if distance2 < 1.75 and onjob and not CanLeaveItem then
				nearDeliveryCar2 = true
				getBoxOnCar(nearDeliveryCar2)
			elseif distance2 >= 1.75 and onjob and not CanLeaveItem then
				nearDeliveryCar2 = false
				getBoxOnCar(nearDeliveryCar2)
			end
		end		
	end	
end)

function basiccheck()
	if onjob == false then 
		drawTxt("PRESSIONE ~g~E~s~ PARA INICIAR A ENTREGA DE FRUTAS", 4,0.5,0.93,0.50,255,255,255,180)
		if IsControlJustPressed (1, 38) then
			TriggerServerEvent('inicio:sucesso')
			TriggerEvent("Notify","sucesso","Entregas iniciadas.")
		end
	else
		drawTxt("PRESSIONE ~g~H~s~ PARA SAIR DE TRABALHO", 4,0.5,0.93,0.50,255,255,255,180)
		if IsControlJustPressed(1, 74) then			
			onjob = false
			RemoveBlip(blips)
			SetWaypointOff()
			visits = 1
		end
	end
end

function IsInVehicle()
local ply = PlayerPedId()
	if IsPedSittingInAnyVehicle(ply) then
		return true
	else
		return false
	end
end

function openMenuDeliveryCar(nearDeliveryCar)
	if nearDeliveryCar and CanLeaveItem then
		if stockFrutas <= limitStock then
			drawTxt("PRESSIONE ~g~E~s~ PARA GUARDAR A ENCOMENDA NA CAMIONETE", 4,0.5,0.93,0.50,255,255,255,180)
			if IsControlJustPressed(1, 38) then
				local pid = PlayerPedId()
				SetVehicleDoorOpen(veh, 5, false, true)
				DetachEntity(prop, true, false)
				SetEntityCoords(prop, 0.0, 0.0, 0.0, false, false, false, true)
				CanLeaveItem = false
				RequestAnimDict("anim@heists@money_grab@briefcase")
				while (not HasAnimDictLoaded("anim@heists@money_grab@briefcase")) do
					Citizen.Wait(10) 
				end
				TaskPlayAnim(pid,"anim@heists@money_grab@briefcase","put_down_case",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
				Wait(2000)
				StopAnimTask(pid, "anim@heists@money_grab@briefcase","put_down_case", 1.0)
				SetVehicleDoorsShut(veh, true)
				stockFrutas = stockFrutas + 1
				TriggerEvent("Notify","sucesso","Possui <b>"..stockFrutas.."</b> caixa de frutas na camionete.")
			end
		else
			drawTxt("A camionete esta cheia efetue mais entregas", 4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end

function getBoxOnCar(nearDeliveryCar2)
	if nearDeliveryCar2 and not CanLeaveItem and GetDistanceBetweenCoords(destination[l].x,destination[l].y,destination[l].z, GetEntityCoords(PlayerPedId())) < 20.0 then
		if stockFrutas >= 1 then
			drawTxt("PRESSIONE ~g~E~s~ PARA PEGAR A CAIXA NA CAMIONETE", 4,0.5,0.93,0.50,255,255,255,180)
			if (IsControlJustPressed(1, 38)) then
				Citizen.Wait(100)	
				CanLeaveItem = true
			end				
			if CanLeaveItem then
				local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
				local prop = CreateObject(HashKeyBox, x+5.5, y+5.5, z+0.2,  true,  true, true)
				SetVehicleDoorOpen(veh, 5, false, true)
				AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 11816), -0.17, 0.38, -0.050, 15.0, 285.0, 270.0, true, true, false, true, 1, true)
				RequestAnimDict('anim@heists@box_carry@')
				while not HasAnimDictLoaded('anim@heists@box_carry@') do
					Wait(0)
				end
				TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
				SetVehicleDoorsShut(veh, true)
				repeat
				Citizen.Wait(100)
				if CanLeaveItem == false then
					DeleteEntity(prop)
				end
				until(CanLeaveItem == false)	
			end
		else		
			drawTxt("A camionete esta vazia busque mais encomendas.", 4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end

function openMenuBox(nearBoxFarm)
	if nearBoxFarm and onjob then
		if stockFrutas <= limitStock then
			drawTxt("PRESSIONE ~g~E~s~ PARA PEGAR A CAIXA", 4,0.5,0.93,0.50,255,255,255,180)
			if IsControlJustPressed(1, 38) and emP.CheckItens() then
				Citizen.Wait(100)	
				CanLeaveItem = true	
				emP.GetItens()
			end
			if CanLeaveItem then
				local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
				local prop = CreateObject(HashKeyBox, x+5.5, y+5.5, z+0.2,  true,  true, true)
				AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 11816), -0.17, 0.38, -0.050, 15.0, 285.0, 270.0, true, true, false, true, 1, true)
				RequestAnimDict('anim@heists@box_carry@')
				while not HasAnimDictLoaded('anim@heists@box_carry@') do
					Wait(0)
				end
				TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
				repeat
				Citizen.Wait(100)
				if CanLeaveItem == false then
					DeleteEntity(prop)
				end
				until(CanLeaveItem == false)
			end
		else
			drawTxt("A CAMIONETE ESTÁ CHEIA, EFETUE ALGUMAS ENTREGAS", 4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end


function startjob()
	onjob = true
	area = 1
	if area == 1 then 
	l = math.random(1,14)
	end
	CriandoBlip(locs,selecionado)
end

function SpawnVan()
	if (IsInVehicle()) then
		if IsVehicleModel(GetVehiclePedIsIn(PlayerPedId(), true), GetHashKey("boxville4")) then
			startjob()
		end
	else
		Citizen.Wait(10)
		startjob()
	end
end

function deliverysucces()
	emP.CheckPayment()
	StopAnimTask(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 1.0)
	DetachEntity(prop, true, false)
	SetEntityCoords(prop, 0.0, 0.0, 0.0, false, false, false, true)
	CanLeaveItem = false
	stockFrutas = stockFrutas - 1
	TriggerEvent("Notify","importante","<b>"..stockFrutas.."</b> caixas de frutas restantes.")
	if stockFrutas <= 0 then
		RemoveBlip(blips)
		onjob = false
		TriggerEvent("Notify","aviso","Não possui mais caixas de frutas.")		
	else
		RemoveBlip(blips)
		startjob()
	end
end


function getNearVeh(radius)
	local playerPed = PlayerPedId()
	local coordA = GetEntityCoords(playerPed, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, radius+0.00001, 0.0)
	local nearVehicle = getVehicleInDirection(coordA, coordB)

	if IsEntityAVehicle(nearVehicle) then
	    return nearVehicle
	else
		local x,y,z = table.unpack(coordA)
	    if IsPedSittingInAnyVehicle(playerPed) then
	        local veh = GetVehiclePedIsIn(playerPed, true)
	        return veh
	    else
	        local veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001, radius+0.0001, 0, 8192+4096+4+2+1)
	        if not IsEntityAVehicle(veh) then veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001, radius+0.0001, 0, 4+2+1) end
	        return veh
	    end
	end
end

function IsInVehicle()
	local ply = PlayerPedId()
	if IsPedSittingInAnyVehicle(ply) then
		return true
	else
		return false
	end
end

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(destination[l].x,destination[l].y,destination[l].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de frutas")
	EndTextCommandSetBlipName(blips)
end