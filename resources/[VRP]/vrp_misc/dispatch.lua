-----------------------------------------------------------------------------------------------------------------------------------------
--[ DESABILITAR X NA MOTO ]--------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			if GetPedInVehicleSeat(vehicle,0) == ped and GetVehicleClass(vehicle) == 8 then
				DisableControlAction(0,73,true) 
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DESABILITAR A CORONHADA ]------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        if IsPedArmed(ped,6) then
            DisableControlAction(0,140,true)
            DisableControlAction(0,141,true)
            DisableControlAction(0,142,true)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ HS 1 TIRO ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Wait(5)

        SetPedSuffersCriticalHits(PlayerPedId(-1), true)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ REMOVER ARMA ABAIXO DE 40MPH DENTRO DO CARRO ]---------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				local speed = GetEntitySpeed(vehicle)*2.236936
				if speed >= 40 then
					SetPlayerCanDoDriveBy(PlayerId(),false)
				else
					SetPlayerCanDoDriveBy(PlayerId(),true)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DESATIVA O CONTROLE DO CARRO ENQUANTO ESTIVER NO AR ]--------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local veh = GetVehiclePedIsIn(PlayerPedId(),false)
        if DoesEntityExist(veh) and not IsEntityDead(veh) then
            local model = GetEntityModel(veh)
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and not IsThisModelABicycle(model) and not IsThisModelABike(model) and not IsThisModelAQuadbike(model) and IsEntityInAir(veh) then
                DisableControlAction(0,59)
                DisableControlAction(0,60)
                --DisableControlAction(0,73)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ESTOURAR OS PNEUS ]------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
            if GetPedInVehicleSeat(vehicle,-1) == ped then
                local speed = GetEntitySpeed(vehicle)*2.236936
                if speed >= 180 and math.random(100) >= 97 then
                    if GetVehicleTyresCanBurst(vehicle) == false then return end
                    local pneus = GetVehicleNumberOfWheels(vehicle)
                    local pneusEffects
                    if pneus == 2 then
                        pneusEffects = (math.random(2)-1)*4
                    elseif pneus == 4 then
                        pneusEffects = (math.random(4)-1)
                        if pneusEffects > 1 then
                            pneusEffects = pneusEffects + 2
                        end
                    elseif pneus == 6 then
                        pneusEffects = (math.random(6)-1)
                    else
                        pneusEffects = 0
                    end
                    SetVehicleTyreBurst(vehicle,pneusEffects,false,1000.0)
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DRIFT ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		if IsPedInAnyVehicle(ped) then
			local speed = GetEntitySpeed(vehicle)*2.236936
			if GetPedInVehicleSeat(vehicle,-1) == ped 
				and (GetEntityModel(vehicle) ~= GetHashKey("coach") 
					and GetEntityModel(vehicle) ~= GetHashKey("bus") 
					and GetEntityModel(vehicle) ~= GetHashKey("youga2") 
					and GetEntityModel(vehicle) ~= GetHashKey("ratloader") 
					and GetEntityModel(vehicle) ~= GetHashKey("taxi") 
					and GetEntityModel(vehicle) ~= GetHashKey("boxville2") 
					and GetEntityModel(vehicle) ~= GetHashKey("trash2") 
					and GetEntityModel(vehicle) ~= GetHashKey("tiptruck") 
					and GetEntityModel(vehicle) ~= GetHashKey("rebel") 
					and GetEntityModel(vehicle) ~= GetHashKey("speedo") 
					and GetEntityModel(vehicle) ~= GetHashKey("phantom") 
					and GetEntityModel(vehicle) ~= GetHashKey("packer") 
					and GetEntityModel(vehicle) ~= GetHashKey("paramedicoambu")) then
					if speed <= 100.0 then
					if IsControlPressed(1,21) then
						SetVehicleReduceGrip(vehicle,true)
					else
						SetVehicleReduceGrip(vehicle,false)
					end
				end    
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BLIPS ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {
	-- { ['x'] = 2309.69, ['y'] = 4754.71, ['z'] = 37.13, ['sprite'] = 77, ['color'] = 4, ['nome'] = "Laranja", ['scale'] = 0.4 },
	{ ['x'] = -1095.26, ['y'] = -833.35, ['z'] = 14.29, ['sprite'] = 60, ['color'] = 32, ['nome'] = "Departamento de Polícia", ['scale'] = 0.6 },
	{ ['x'] = 1867.42, ['y'] = 3688.06, ['z'] = 34.27, ['sprite'] = 60, ['color'] = 66, ['nome'] = "Departamento de Polícia", ['scale'] = 0.6 },
	{ ['x'] = -440.19, ['y'] = 6019.41, ['z'] = 31.5, ['sprite'] = 60, ['color'] = 66, ['nome'] = "Departamento de Polícia", ['scale'] = 0.6 },
	{ ['x'] = 318.18, ['y'] = -1077.04, ['z'] = 29.48, ['sprite'] = 403, ['color'] = 36, ['nome'] = "Farmárcia", ['scale'] = 0.6 },
	{ ['x'] = 97.71, ['y'] = -223.69, ['z'] = 54.64, ['sprite'] = 403, ['color'] = 36, ['nome'] = "Farmárcia", ['scale'] = 0.6 },
	--{ ['x'] = -643.33, ['y'] = -286.36, ['z'] = 35.49, ['sprite'] = 88, ['color'] = 4, ['nome'] = "iFruit", ['scale'] = 0.4 },
	-- { ['x'] = 2346.35, ['y'] = 2567.99, ['z'] = 46.59, ['sprite'] = 496, ['color'] = 4, ['nome'] = "Peace", ['scale'] = 0.4 },
	{ ['x'] = 293.16, ['y'] = -583.67, ['z'] = 43.2, ['sprite'] = 489, ['color'] = 8, ['nome'] = "Hospital", ['scale'] = 0.8 },
	{ ['x'] = 1813.14, ['y'] = 3686.95, ['z'] = 34.23, ['sprite'] = 489, ['color'] = 8, ['nome'] = "Hospital", ['scale'] = 0.6 },
	-- { ['x'] = 103.2, ['y'] = -1938.52, ['z'] = 20.81, ['sprite'] = 84, ['color'] = 4, ['nome'] = "Ballas", ['scale'] = 0.4 },
	-- { ['x'] = -121.18, ['y'] = -1614.05, ['z'] = 31.95, ['sprite'] = 84, ['color'] = 4, ['nome'] = "Grove Street Families", ['scale'] = 0.4 },
	-- { ['x'] = 328.82, ['y'] = -2035.25, ['z'] = 20.96, ['sprite'] = 84, ['color'] = 4, ['nome'] = "Los Vagos", ['scale'] = 0.4 },
	{ ['x'] = 132.65, ['y'] = 94.24, ['z'] = 83.51, ['sprite'] = 67, ['color'] = 4, ['nome'] = "Carteiro", ['scale'] = 0.4 },
	{ ['x'] = -1061.73, ['y'] = -2965.69, ['z'] = 13.97, ['sprite'] = 307, ['color'] = 4, ['nome'] = "Aeroporto", ['scale'] = 0.5 },
	{ ['x'] = 275.45, ['y'] = -344.94, ['z'] = 45.18, ['sprite'] = 357, ['color'] = 77, ['nome'] = "Garagem", ['scale'] = 0.4 },
	{ ['x'] = 100.72, ['y'] = -1073.31, ['z'] = 29.38, ['sprite'] = 357, ['color'] = 77, ['nome'] = "Garagem", ['scale'] = 0.4 },
	-- { -437.98,6022.18,31.5,188,4,"Departamento de Polícia",0.5 },
	-- { -175.24,6383.37,31.5,51,4,"Farmácia",0.4 },

	{ ['x'] = 945.54, ['y'] = -989.3, ['z'] = 39.13, ['sprite'] = 402, ['color'] = 47, ['nome'] = "Mecânica", ['scale'] = 0.7 },

	-- { ['x'] = -46.38, ['y'] = -1098.54, ['z'] = 26.43, ['sprite'] = 78, ['color'] = 4, ['nome'] = "Motorsport", ['scale'] = 0.5 },

	--GRUPPE6
	{ ['x'] = -35.84, ['y'] = -663.82, ['z'] = 33.49, ['sprite'] = 67, ['color'] = 4, ['nome'] = "Transportador de Valores", ['scale'] = 0.5 },

	--UBEREATS
	{ ['x'] = -519.74, ['y'] = -675.54, ['z'] = 33.68, ['sprite'] = 226, ['color'] = 4, ['nome'] = "UberEats", ['scale'] = 0.5 },

	--CONCESSIONARIA
	{ ['x'] = -801.45, ['y'] = -222.9, ['z'] = 37.08, ['sprite'] = 669, ['color'] = 66, ['nome'] = "Concessionaria", ['scale'] = 0.6 },

	-- { ['x'] = 68.7, ['y'] = 3708.68, ['z'] = 39.76, ['sprite'] = 488, ['color'] = 4, ['nome'] = "The Lost MC", ['scale'] = 0.6 },

	-- { ['x'] = -42.42, ['y'] = -1663.03, ['z'] = 29.5, ['sprite'] = 439, ['color'] = 4, ['nome'] = "Albany", ['scale'] = 0.6 },

	{ ['x'] = -1436.77, ['y'] = -277.68, ['z'] = 46.21, ['sprite'] = 361, ['color'] = 35, ['nome'] = "Posto de Gasolina", ['scale'] = 0.3 },
	{ ['x'] = -2096.59, ['y'] = -339.87, ['z'] = 13.03, ['sprite'] = 361, ['color'] = 35, ['nome'] = "Posto de Gasolina", ['scale'] = 0.3 },

	-- JOALHERIA

	{ ['x'] = -629.39, ['y'] = -236.12, ['z'] = 38.06, ['sprite'] = 439, ['color'] = 46, ['nome'] = "Joalheria", ['scale'] = 0.5 },

	-- BAHAMAS & VANILLA

	{ ['x'] = -1388.4, ['y'] = -586.9, ['z'] = 30.22, ['sprite'] = 93, ['color'] = 8, ['nome'] = "Bahamas", ['scale'] = 0.5 },

	{ ['x'] = -564.41, ['y'] = 275.84, ['z'] = 83.11, ['sprite'] = 93, ['color'] = 4, ['nome'] = "Tequilala", ['scale'] = 0.5 },

	-- CAIXINHAS

	{ ['x'] = 119.10, ['y'] = -883.70, ['z'] = 31.12, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = -1315.80, ['y'] = -834.76, ['z'] = 16.96, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = 285.44, ['y'] = 143.38, ['z'] = 104.17, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = 1138.23, ['y'] = -468.89, ['z'] = 66.73, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = 1077.70, ['y'] = -776.54, ['z'] = 58.24, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = -710.03, ['y'] = -818.90, ['z'] = 23.72 , ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = -821.63, ['y'] = -1081.89, ['z'] = 11.13, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = -1409.75, ['y'] = -100.44, ['z'] = 52.38, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = -846.29, ['y'] = -341.28, ['z'] = 38.68, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = -2072.36, ['y'] = -317.23, ['z'] = 13.31, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = -526.64, ['y'] = -1222.97, ['z'] = 18.45, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = -254.41, ['y'] = -692.46, ['z'] = 33.60, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = -203.69, ['y'] = -861.47, ['z'] = 30.26, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = -303.30, ['y'] = -829.81, ['z'] = 32.41, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = -301.72, ['y'] = -830.03, ['z'] = 32.41, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = 146.05, ['y'] = -1035.03, ['z'] = 29.34 , ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = 147.66, ['y'] = -1035.67, ['z'] = 29.34, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = -258.80, ['y'] = -723.40, ['z'] = 33.46, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = -256.15, ['y'] = -716.00, ['z'] = 33.51, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },
	{ ['x'] = -537.85, ['y'] = -854.37, ['z'] = 29.28, ['sprite'] = 108, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.4 },


	-- EMPREGOS
	{ ['x'] = 3807.89, ['y'] = 4478.64, ['z'] = 6.37, ['sprite'] = 68, ['color'] = 13, ['nome'] = "Central | Pescadores", ['scale'] = 0.5 },
	--{ ['x'] = 2319.06, ['y'] = 4763.1, ['z'] = 36.79, ['sprite'] = 515, ['color'] = 13, ['nome'] = "Central | Frutas", ['scale'] = 0.5 },
	{ ['x'] = 2954.84, ['y'] = 2792.55, ['z'] = 40.83, ['sprite'] = 103, ['color'] = 13, ['nome'] = "Mineração", ['scale'] = 0.5 },
	{ ['x'] = -349.84, ['y'] = -1569.79, ['z'] = 25.22, ['sprite'] = 318, ['color'] = 13, ['nome'] = "Central | Lixeiros", ['scale'] = 0.5 },
	{ ['x'] = 900.58, ['y'] = -177.25, ['z'] = 73.91, ['sprite'] = 225, ['color'] = 13, ['nome'] = "Central | Taxista", ['scale'] = 0.5 },
	{ ['x'] = 1218.74, ['y'] = -1266.87, ['z'] = 36.42, ['sprite'] = 285, ['color'] = 13, ['nome'] = "Central | Lenhadores", ['scale'] = 0.5 },
	{ ['x'] = 173.10, ['y'] = -26.04, ['z'] = 68.34, ['sprite'] = 499, ['color'] = 13, ['nome'] = "Central | Leiteiros", ['scale'] = 0.5 },
	{ ['x'] = 286.91, ['y'] = 2843.27, ['z'] = 44.70, ['sprite'] = 477, ['color'] = 13, ['nome'] = "Central | Mineradores", ['scale'] = 0.5 },
	{ ['x'] = 1196.5, ['y'] = -3253.62, ['z'] = 7.1, ['sprite'] = 477, ['color'] = 13, ['nome'] = "Central | Caminhoneiro", ['scale'] = 0.5 },
	{ ['x'] = 1648.67, ['y'] = 3235.93, ['z'] = 40.07, ['sprite'] = 380, ['color'] = 1, ['nome'] = "Corrida Explosiva", ['scale'] = 0.6 },
	{ ['x'] = 713.68, ['y'] = 3820.77, ['z'] = 51.01, ['sprite'] = 68, ['color'] = 13, ['nome'] = "Lagoa de Pescaria", ['scale'] = 0.5 },
	{ ['x'] = 1337.27, ['y'] = 4269.93, ['z'] = 31.51, ['sprite'] = 455, ['color'] = 13, ['nome'] = "Barcos", ['scale'] = 0.5 },
	{ ['x'] = 1084.83, ['y'] = -2002.68, ['z'] = 31.39, ['sprite'] = 467, ['color'] = 13, ['nome'] = "Refinar Minério", ['scale'] = 0.6 },

	-- { ['x'] = 285.44, ['y'] = 143.38, ['z'] = 104.17, ['sprite'] = 207, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.5 },
	-- { ['x'] = 285.44, ['y'] = 143.38, ['z'] = 104.17, ['sprite'] = 207, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.5 },
	-- { ['x'] = 285.44, ['y'] = 143.38, ['z'] = 104.17, ['sprite'] = 207, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.5 },
	-- { ['x'] = 285.44, ['y'] = 143.38, ['z'] = 104.17, ['sprite'] = 207, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.5 },
	-- { ['x'] = 285.44, ['y'] = 143.38, ['z'] = 104.17, ['sprite'] = 207, ['color'] = 4, ['nome'] = "Caixa Eletrônico", ['scale'] = 0.5 }
}

Citizen.CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v.x,v.y,v.z)
		SetBlipSprite(blip,v.sprite)
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v.color)
		SetBlipScale(blip,v.scale)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.nome)
		EndTextCommandSetBlipName(blip)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TASERTIME ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local tasertime = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		if IsPedBeingStunned(ped) then
			SetPedToRagdoll(ped,10000,10000,0,0,0,0)
		end

		if IsPedBeingStunned(ped) and not tasertime then
			tasertime = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
		elseif not IsPedBeingStunned(ped) and tasertime then
			tasertime = false
			SetTimeout(5000,function()
				SetTimecycleModifier("hud_def_desat_Trevor")
				SetTimeout(10000,function()
					SetTimecycleModifier("")
					SetTransitionTimecycleModifier("")
					StopGameplayCamShaking()
				end)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BLACKLIST ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
blackWeapons = {
	--"WEAPON_PISTOL50",
	--"WEAPON_SNSPISTOL_MK2",
	--"WEAPON_HEAVYPISTOL",
	--"WEAPON_FLAREGUN",
	"WEAPON_MARKSMANPISTOL",
	--"WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	--"WEAPON_RAYPISTOL",
	"WEAPON_SMG_MK2",
	"WEAPON_MACHINEPISTOL",
	--"WEAPON_MINISMG",
	"WEAPON_RAYCARBINE",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DBSHOTGUN",
	"WEAPON_AUTOSHOTGUN",
	--"WEAPON_ASSAULTRIFLE_MK2",
	--"WEAPON_CARBINERIFLE_MK2",
	--"WEAPON_ADVANCEDRIFLE",
	--"WEAPON_SPECIALCARBINE",
	--"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_BULLPUPRIFLE_MK2",
	--"WEAPON_COMPACTRIFLE",
	--"WEAPON_MG",
	--"WEAPON_COMBATMG",
	--"WEAPON_COMBATMG_MK2",
	--"WEAPON_SNIPERRIFLE",
	--"WEAPON_HEAVYSNIPER",
	--"WEAPON_HEAVYSNIPER_MK2",
	--"WEAPON_MARKSMANRIFLE",
	--"WEAPON_MARKSMANRIFLE_MK2",
	--"WEAPON_RPG",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_MINIGUN",
	--"WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_RAYMINIGUN",
	"WEAPON_GRENADE",
	"WEAPON_BZGAS",
	"WEAPON_MOLOTOV",
	"WEAPON_STICKYBOMB",
	"WEAPON_PROXMINE",
	"WEAPON_PIPEBOMB",
	--"WEAPON_SNOWBALL",
	"WEAPON_BALL",
	"WEAPON_SMOKEGRENADE"
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in ipairs(blackWeapons) do
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(v) then
				RemoveWeaponFromPed(PlayerPedId(),GetHashKey(v))
				TriggerServerEvent("adminLogs:Armamentos", v)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BLACKOUT ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local isBlackout = false
local oldSpeed = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		if IsEntityAVehicle(vehicle) and GetPedInVehicleSeat(vehicle,-1) == PlayerPedId() then
			local currentSpeed = GetEntitySpeed(vehicle)*2.236936
			if currentSpeed ~= oldSpeed then
				if not isBlackout and (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= 50) then
					blackout()
				end
				oldSpeed = currentSpeed
			end
		else
			if oldSpeed ~= 0 then
				oldSpeed = 0
			end
		end

		if isBlackout then
			DisableControlAction(0,63,true)
			DisableControlAction(0,64,true)
			DisableControlAction(0,71,true)
			DisableControlAction(0,72,true)
			DisableControlAction(0,75,true)
		end
	end
end)

function blackout()
	TriggerEvent("vrp_sound:source",'heartbeat',0.5)
	if not isBlackout then
		isBlackout = true
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())-200)
		Citizen.CreateThread(function()
			DoScreenFadeOut(500)
			while not IsScreenFadedOut() do
				Citizen.Wait(10)
			end
			Citizen.Wait(5000)
			DoScreenFadeIn(5000)
			isBlackout = false
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DAMAGE WALK MODE ]-------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local hurt = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if not IsEntityInWater(ped) then
			if GetEntityHealth(ped) <= 199 then
				setHurt()
			elseif hurt and GetEntityHealth(ped) > 200 then
				setNotHurt()
			end
		end
	end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(PlayerPedId(),"move_m@injured",true)
	SetPlayerHealthRechargeMultiplier(PlayerId(),0.0)
	DisableControlAction(0,21) 
	DisableControlAction(0,22)
end

function setNotHurt()
    hurt = false
	SetPlayerHealthRechargeMultiplier(PlayerId(),0.0)
    ResetPedMovementClipset(PlayerPedId())
    ResetPedWeaponMovementClipset(PlayerPedId())
    ResetPedStrafeClipset(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ COOLDOWN BUNNYHOP ]------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local bunnyhop = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if bunnyhop > 0 then
            bunnyhop = bunnyhop - 5
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedJumping(ped) and bunnyhop <= 0 then
            bunnyhop = 5
        end
        if bunnyhop > 0 then
            DisableControlAction(0,22,true)
        end
        Citizen.Wait(5)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ SOM AMBIENTE ]-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function() 
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE");
	SetAudioFlag("PoliceScannerDisabled",true); 
  end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUDAR DE ASSENTO
-----------------------------------------------------------------------------------------------------------------------------------------
local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterCommand("assento", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FALL WHILE RUNING AND JUMPING
-----------------------------------------------------------------------------------------------------------------------------------------
--[[local ragdoll_chance = 0.99
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then
			local chance_result = math.random()
			if chance_result < ragdoll_chance then
				Citizen.Wait(600)
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE',0.5)
				SetPedToRagdoll(ped,5000,1,2)
			else
				Citizen.Wait(2000)
			end
		end
	end
end)]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- WALK SHAKE
-----------------------------------------------------------------------------------------------------------------------------------------
--[[playerMoving = false
Citizen.CreateThread(function()
	while true do 
		Wait(1)
		if not IsPedInAnyVehicle(PlayerPedId(), false) and GetEntitySpeed(PlayerPedId()) >= 0.5 and GetFollowPedCamViewMode() ~= 4 then
			if playerMoving == false then
				ShakeGameplayCam("ROAD_VIBRATION_SHAKE", 1.0)
				playerMoving = true
			end
		else
			if playerMoving == true then
				StopGameplayCamShaking(false)
				playerMoving = false
			end
		end
	end
end)]]