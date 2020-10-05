-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_gruppe6",src)
vSERVER = Tunnel.getInterface("vrp_gruppe6")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local pos = 0
local nveh = nil
local pveh01 = nil
local pveh02 = nil
local CoordenadaX = 849.93
local CoordenadaY = -1284.28
local CoordenadaZ = 28.00
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -1219.11, 	['y'] = -314.59, 	['z'] = 37.72, 	['x2'] = 883.82, ['y2'] = -2382.88, ['z2'] = 28.05, ['h'] = 296.44, ['lugar'] = "1/8" },
	[2] = { ['x'] = -345.50, 	['y'] = -27.71, 	['z'] = 47.49, 	['x2'] = 883.82, ['y2'] = -2382.88, ['z2'] = 28.05, ['h'] = 248.95, ['lugar'] = "2/8" },
	[3] = { ['x'] = 225.70, 	['y'] = 211.13, 	['z'] = 105.54,	['x2'] = 883.82, ['y2'] = -2382.88, ['z2'] = 28.05, ['h'] = 121.03, ['lugar'] = "3/8" },
	[4] = { ['x'] = 294.00, 	['y'] = -276.88, 	['z'] = 53.98, 	['x2'] = 883.82, ['y2'] = -2382.88, ['z2'] = 28.05, ['h'] = 336.96, ['lugar'] = "4/8" },
	[5] = { ['x'] = -2957.00, 	['y'] = 492.97, 	['z'] = 15.30, 	['x2'] = 883.82, ['y2'] = -2382.88, ['z2'] = 28.05, ['h'] = 86.99,  ['lugar'] = "6/8" }
} 
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
		local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

		if distance <= 30.0 then
			DrawMarker(23,CoordenadaX,CoordenadaY,CoordenadaZ-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
			if distance <= 1.2 then
				drawTxt("PRESSIONE  ~b~E~w~  PARA HACKEAR",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and vSERVER.checkTimers() then
					TriggerEvent('cancelando',true)
					vRP._playAnim(false,{{"anim@heists@ornate_bank@hack","hack_loop"}},true)
					laptop = CreateObject(GetHashKey("prop_laptop_01a"),x-0.6,y+0.2,z-1,true,true,true)
					SetEntityHeading(ped,85.77)
					SetEntityHeading(laptop,85.77)
					TriggerEvent("mhacking:show")
					TriggerEvent("mhacking:start",6,30,mycallback) --- Aqui muda o tempo que leva para hackear
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEAR
-----------------------------------------------------------------------------------------------------------------------------------------
function mycallback(success,time)
	if success then
		TriggerEvent("mhacking:hide")
		vSERVER.checkGruppe6()
		DeleteObject(laptop)
		vRP._stopAnim(false)
		TriggerEvent('cancelando',false)
	else
		TriggerEvent("mhacking:hide")
		vSERVER.resetTimer()
		DeleteObject(laptop)
		vRP._stopAnim(false)
		TriggerEvent('cancelando',false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTGruppe6
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startGruppe6()
	pos = math.random(#locs)
	src.spawnGruppe6(locs[pos].x,locs[pos].y,locs[pos].z,locs[pos].x2,locs[pos].y2,locs[pos].z2,locs[pos].h)
	TriggerEvent("chatMessage","ALERTA",{255,70,50},"Hackeado com sucesso, o carro forte está saindo do ^1"..locs[pos].lugar.."^0.",8000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.spawnGruppe6(x,y,z,x2,y2,z2,h)
	local vhash = GetHashKey("stockade")
	while not HasModelLoaded(vhash) do
		RequestModel(vhash)
		Citizen.Wait(10)
	end

	local phash = GetHashKey("s_m_m_security_01")
	while not HasModelLoaded(phash) do
		RequestModel(phash)
		Citizen.Wait(10)
	end

	SetModelAsNoLongerNeeded(phash)

	if HasModelLoaded(vhash) then
		nveh = CreateVehicle(vhash,x,y,z,h,true,false)

		N_0x06faacd625d80caa(nveh)
		SetEntityAsNoLongerNeeded(nveh)
		SetVehicleOnGroundProperly(nveh)
		SetVehicleDoorsLocked(nveh,2)

		pveh01 = CreatePedInsideVehicle(nveh,4,GetHashKey("s_m_m_security_01"),-1,true,false)
		pveh02 = CreatePedInsideVehicle(nveh,4,GetHashKey("s_m_m_security_01"),0,true,false)
		pveh03 = CreatePedInsideVehicle(nveh,4,GetHashKey("s_m_m_security_01"),1,true,false)
		pveh04 = CreatePedInsideVehicle(nveh,4,GetHashKey("s_m_m_security_01"),2,true,false)
		setPedPropertys(pveh01,"WEAPON_MINISMG")
		setPedPropertys(pveh02,"WEAPON_MINISMG")
		setPedPropertys(pveh03,"WEAPON_CARBINERIFLE")
		setPedPropertys(pveh04,"WEAPON_CARBINERIFLE")

		SetEntityAsMissionEntity(pveh01,false,false)
		SetEntityAsMissionEntity(pveh02,false,false)
		SetEntityAsMissionEntity(pveh03,false,false)
		SetEntityAsMissionEntity(pveh04,false,false)

		TaskVehicleDriveToCoordLongrange(pveh01,nveh,x2,y2,z2,10.0,1074528293,1.0)
	end
end

function setPedPropertys(npc,weapon)
	SetPedShootRate(npc,850)
	SetPedSuffersCriticalHits(npc,0)
	SetPedAlertness(npc,100)
	AddArmourToPed(npc,100)
	SetPedAccuracy(npc,100)
	SetPedArmour(npc,100)
	SetPedCanSwitchWeapon(npc,true)
	SetEntityHealth(npc,300)
	SetPedFleeAttributes(npc,0,0)
	SetPedConfigFlag(npc,118,false)
	SetPedCanRagdollFromPlayerImpact(npc,0)
	SetPedCombatAttributes(npc,46,true)
	SetEntityIsTargetPriority(npc,1,0)
	SetPedGetOutUpsideDownVehicle(npc,1)
	SetPedPlaysHeadOnHornAnimWhenDiesInVehicle(npc,1)
	SetPedKeepTask(npc,true)
	SetEntityLodDist(npc,250)
	SetPedCombatAbility(npc,2)
	SetPedCombatRange(npc,50)
	SetPedPathAvoidFire(npc,1)
	SetPedPathCanUseLadders(npc,1)
	SetPedPathCanDropFromHeight(npc,1)
	SetPedPathPreferToAvoidWater(npc,1)
	SetPedGeneratesDeadBodyEvents(npc,1)
	GiveWeaponToPed(npc,GetHashKey(weapon),5000,true,true)

	SetPedCombatAttributes(npc,1,false)
	SetPedCombatAttributes(npc,13,false)
	SetPedCombatAttributes(npc,6,true)
	SetPedCombatAttributes(npc,8,false)
	SetPedCombatAttributes(npc,10,true)
	SetPedFleeAttributes(npc,512,true)
	SetPedConfigFlag(npc,118,false)
	SetPedFleeAttributes(npc,128,true)
	SetEntityLoadCollisionFlag(npc,true)

	SetPedRelationshipGroupHash(npc,GetHashKey("security_guard"))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if DoesEntityExist(nveh) and DoesEntityExist(pveh01) and DoesEntityExist(pveh02) then
			local x,y,z = table.unpack(GetEntityCoords(nveh))
			local x2,y2,z2 = table.unpack(GetOffsetFromEntityInWorldCoords(nveh,0.0,-4.0,0.5))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[pos].x2,locs[pos].y2,locs[pos].z2)
			local distance = GetDistanceBetweenCoords(locs[pos].x2,locs[pos].y2,cdz,x,y,z,true)

			if IsPedDeadOrDying(pveh01) and IsPedDeadOrDying(pveh02) and not DoesEntityExist(bomba) then
				vSERVER.markOcorrency(x,y,z)
				bomba = CreateObject(GetHashKey("prop_c4_final_green"),x,y,z,true,false,false)
				AttachEntityToEntity(bomba,nveh,GetEntityBoneIndexByName(nveh,"door_dside_r"),0.78,0.0,0.0,180.0,-90.0,180.0,false,false,false,true,2,true)
				SetTimeout(20000,function()
					TriggerServerEvent("trydeleteped",PedToNet(pveh01))
					TriggerServerEvent("trydeleteped",PedToNet(pveh02))
					TriggerServerEvent("trydeleteobj",ObjToNet(bomba))
					SetVehicleDoorOpen(nveh,2,0,0)
					SetVehicleDoorOpen(nveh,3,0,0)
					NetworkExplodeVehicle(nveh,1,1,1)
					vSERVER.dropSystem(x2,y2,z2)
					pveh01 = nil
					pveh02 = nil
				end)
			end

			if distance <= 10.0 then
				TriggerServerEvent("trydeleteveh",VehToNet(nveh))
				TriggerServerEvent("trydeleteped",PedToNet(pveh01))
				TriggerServerEvent("trydeleteped",PedToNet(pveh02))
				nveh = nil
				pveh01 = nil
				pveh02 = nil
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