
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
job = Tunnel.getInterface("cp_postal")
checkIn = Proxy.getInterface("vrp_jobcheckin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local emservico = false
local quantidade = 0
local statuses = false
local nveh = nil
local pegando = false
local andamento = false
local propcaixa = nil
local propcaixa2 = nil
local propcaixa3 = nil
local propcaixa4 = nil
local propcaixa5 = nil
local propcaixa6 = nil
local propcaixa7 = nil
local propcaixa8 = nil
local propcaixa9 = nil
local propcaixa10 = nil
local caixanamao = false
local traseira = false
local portaaberta = false
local portaaberta2 = false
local encomendapega = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DE ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
local entregavan = {
	[1] = {x=-1.41, y=26.59, z=70.87},
	[2] = {x=-2.66, y=135.39, z=87.76},
	[3] = {x=12.04, y=373.62, z=111.49},
	[4] = {x=-87.77, y=423.16, z=112.46},
	[5] = {x=-184.47, y=425.24, z=109.74},
	[6] = {x=-261.85, y=399.8, z=109.28},
	[7] = {x=-370.21, y=350.85, z=108.73},
	[8] = {x=-444.3, y=347.86, z=104.12},
	[9] = {x=-514.8, y=424.53, z=96.39},
	[10] = {x=-578.48, y=514.37, z=105.51},
	[11] = {x=-655.42, y=493.76, z=109.04},
	[12] = {x=-733.14, y=470.42, z=104.97},
	[13] = {x=-777.52, y=449.22, z=95.76},
	[14] = {x=-951.62, y=441.82, z=79.07},
	[15] = {x=-1000.86, y=508.79, z=79.03},
	[16] = {x=-1077.06, y=425.2, z=71.12},
	[17] = {x=-936.06, y=339.95, z=70.95},
	[18] = {x=-1047.81, y=217.73, z=63.14},
	[19] = {x=-977.02, y=148.96, z=60.38},
	[20]  = {x=-922.57, y=110.5, z=54.69}
}

local entregalocal = {
	[1] = {x=3.43, y=36.63, z=71.54},
	[2] = {x=25.24, y=129.45, z=97.22},
	[3] = {x=-1.79, y=397.55, z=120.29},
	[4] = {x=-72.81, y=428.17, z=113.04},
	[5] = {x=-176.69, y=423.42, z=111.25},
	[6] = {x=-255.83, y=398.43, z=109.96},
	[7] = {x=-371.77, y=343.48, z=109.95},
	[8] = {x=-444.35, y=343.21, z=105.58},
	[9] = {x=-516.6, y=433.24, z=97.81},
	[10] = {x=-583.19, y=514.65, z=106.2},
	[11] = {x=-667.28, y=471.97, z=114.14},
	[12] = {x=-718.02, y=448.95, z=106.91},
	[13] = {x=-784.36, y=459.21, z=100.18},
	[14] = {x=-968.41, y=436.75, z=80.58},
	[15] = {x=-996.66, y=517.85, z=83.77},
	[16] = {x=-1094.14, y=427.27, z=75.88},
	[17] = {x=-949.23, y=332.47, z=71.34},
	[18] = {x=-1038.4, y=222.07, z=64.38},
	[19] = {x=-998.11, y=157.82, z=62.32},
	[20] = {x=-913.49, y=108.26, z=55.52}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO TRABALHO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('cp_postal:permissao')
AddEventHandler('cp_postal:permissao',function()
	if not emservico then
		local jobInfo = {
			['titulo'] = "ENTREGADOR",
			['descricao'] = "- Entregue encomendas pela Cidade</br> - Ganhe por Entrega</br> - Sirva a Populaçao",
			['callBackEvent'] = "cp_postal:checkIn"
		}
		checkIn.openJob(jobInfo)
	end
end)

RegisterNetEvent('cp_postal:checkIn')
AddEventHandler('cp_postal:checkIn',function()
	if checkIn.CheckTimer() == 0 then
		if checkIn.CheckJob() == false then
			checkIn.SetJob(true)
		    emservico = true
		    parte = 0
		    destino = math.random(1,20)
		    TriggerEvent("Notify","importante","<b>Roger:</b> Você está <b>Contratado</b>, pegue a <b>Van</b> com o <b>Bob</b> ali embaixo!")
		    ColocarRoupa()
		else
	    	TriggerEvent("Notify","importante","Você já está em <b>Serviço</b> em um outro <b>Emprego</b>!")
	    end
	else
		TriggerEvent("Notify","importante","Você acabou de sair de um <b>Serviço</b>, aguarde <b>"..checkIn.CheckTimer().." Segundos</b> para iniciar <b>Novamente</b>!")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if GetDistanceBetweenCoords(GetEntityCoords(ped), 133.26,96.62,83.51,true) <= 30 then --pegar emprego
		    if GetDistanceBetweenCoords(GetEntityCoords(ped), 133.26,96.62,83.51,true) <= 1 then
                if IsControlJustPressed(0,38) then	
				    TriggerServerEvent('cp_postal:permissao')
				end
			end
		end
		if emservico and parte == 0 then
			if GetDistanceBetweenCoords(GetEntityCoords(ped),120.81,100.16,81.12,true) <= 20 then --pegar van
		       -- DrawMarker(21,120.81,100.16,81.12-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,65,105,255,50,0,0,0,1)
		        if GetDistanceBetweenCoords(GetEntityCoords(ped), 120.81,100.16,81.12,true) <= 1 then --pegar van
                    if IsControlJustPressed(0,38) then	
                    	Fade(1200)
				        TriggerEvent("Notify","importante","<b>Bob:</b> Abra as portas traseiras da <b>Van</b> e coloque as <b>encomendas</b> depressa!")
		                spawnVan()
                        parte = 1
				    end
			    end
		    end
		end
		if emservico and parte == 1 then
		    local veh = GetVanPosition(10)
			local coordsVan = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.7, 0.0)
			local model = GetEntityModel(veh)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),117.95,102.02,81.16,true)
			local distance2 = GetDistanceBetweenCoords(GetEntityCoords(ped),coordsVan.x,coordsVan.y,coordsVan.z,true)
			if distance <= 50 and not pegando and portaaberta then
				DrawMarker(21,117.95,102.02,81.16-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,65,105,255,50,0,0,0,1)
				if distance < 1.5 and not IsPedInAnyVehicle(ped) then
                    if IsControlJustPressed(0,38) and not andamento then
                    	if quantidade < 10 then
                            pegando = true
                            andamento = true
                            caixanamao = true
                            TriggerEvent('cancelando',true)
                            vRP._CarregarObjeto("anim@heists@box_carry@","idle","hei_prop_heist_box",50,28422)
                        else
                        	vRP.playSound("5_SEC_WARNING","HUD_MINI_GAME_SOUNDSET")
                        	TriggerEvent("Notify","aviso","Você colocou o máximo de <b>estoque</b> na <b>Van</b>!")
                        end
					end
				end
			end
			if pegando and distance2 <= 1.5 and not IsPedInAnyVehicle(ped) then
                if model == -233098306 and GetVehicleNumberPlateText(veh) == vRP.getRegistrationNumber() then
					DrawText3Ds(coordsVan.x,coordsVan.y,coordsVan.z+0.80,"~b~[E] ~w~Guardar")
					TriggerEvent('cancelando',false)
                    if IsControlJustPressed(0,38) and andamento then
                    	quantidade = quantidade + 1
                    	vRP._DeletarObjeto()
                        FreezeEntityPosition(ped,true)
                        RequestAnimDict("anim@heists@money_grab@briefcase")
				        while not HasAnimDictLoaded("anim@heists@money_grab@briefcase") do
					        Citizen.Wait(0) 
				        end
				        TaskPlayAnim(ped,"anim@heists@money_grab@briefcase","put_down_case",100.0,200.0,0.3,120,0.2,0,0,0)
				        Wait(800)
				        vRP._DeletarObjeto()
				        CaixaVan(veh,model)
                        Wait(600)
                        caixanamao = false
                        andamento = false
                        pegando = false
				        ClearPedTasksImmediately(ped)
                        FreezeEntityPosition(ped,false)
                        if quantidade == 10 then
                        	TriggerEvent("Notify","importante","<b>Bob:</b> Você colocou <b>"..quantidade.."/10 Encomendas</b> na <b>Van</b>, agora feche as portas traseiras, entre nela e aguarde que irei adicionar no seu <b>GPS</b> os locais de Entrega!")
                        	vRP.playSound("5_SEC_WARNING","HUD_MINI_GAME_SOUNDSET")
                        	portaaberta = false
                        	time = math.random(10000,15000)
                        	parte = 2
                        	Wait(time)
                            TriggerEvent("Notify","importante","Chamado recebido, entre na <b>Van</b>, e vá ao <b>local</b> entregar a <b>encomenda</b>!")
                        	vRP.playSound("ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
                        	CriandoBlip(entregalocal,destino)
                        else
                        	TriggerEvent("Notify","importante","Você colocou <b>"..quantidade.."/10 Encomendas</b> na <b>Van</b>!")
                            vRP.playSound("5_Second_Timer","DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
                        end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if emservico and parte == 2 then
		    local veh = GetVanPosition(10)
			local coordsVan = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.7, 0.0)
			local model = GetEntityModel(veh)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),coordsVan.x,coordsVan.y,coordsVan.z, true)
			local distance2 = GetDistanceBetweenCoords(GetEntityCoords(ped),entregalocal[destino].x,entregalocal[destino].y,entregalocal[destino].z,true)
			if not pegando and portaaberta2 and not encomendapega and distance <= 1.5 and not IsPedInAnyVehicle(ped) then
				if model == -233098306 and GetVehicleNumberPlateText(veh) == vRP.getRegistrationNumber() then
                    if IsControlJustPressed(0,58) and not andamento then
                    	if quantidade > 0 then
                    	    quantidade = quantidade - 1
                    	    encomendapega = true
                            TriggerEvent('cancelando',true)
                            FreezeEntityPosition(ped,true)
                            RequestAnimDict("pickup_object")
				            while not HasAnimDictLoaded("pickup_object") do
					            Citizen.Wait(0) 
				            end
				            TaskPlayAnim(ped,"pickup_object","pickup_low",100.0,200.0,0.3,120,0.2,0,0,0)
                            Wait(700)
                            pegando = true
				            ClearPedTasksImmediately(ped)
                            FreezeEntityPosition(ped,false)
                            vRP.playSound("Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
                            TriggerEvent("Notify","importante","Você retirou <b>1x Encomenda</b> da <b>Van</b>!")
                            vRP._CarregarObjeto("anim@heists@box_carry@","idle","hei_prop_heist_box",50,28422)
                            TirarCaixa()
                            andamento = true
                        else
                            parte = 1
                            vRP.playSound("5_SEC_WARNING","HUD_MINI_GAME_SOUNDSET")
                        	TriggerEvent("Notify","aviso","Você entregou todas as suas <b>encomendas</b>, volte para a central e pegue mais!")
                            quantidade = 0
                        end
					end
				end
			end
			if pegando and portaaberta2 and encomendapega and distance <= 1.5 and not IsPedInAnyVehicle(ped) then
                if model == -233098306 and GetVehicleNumberPlateText(veh) == vRP.getRegistrationNumber() then
					TriggerEvent('cancelando',false)
                    if IsControlJustPressed(0,58) and andamento then
                    	quantidade = quantidade + 1
                    	encomendapega = false
                    	vRP._DeletarObjeto()
                        FreezeEntityPosition(ped,true)
                        RequestAnimDict("anim@heists@money_grab@briefcase")
				        while not HasAnimDictLoaded("anim@heists@money_grab@briefcase") do
					        Citizen.Wait(0) 
				        end
				        TaskPlayAnim(ped,"anim@heists@money_grab@briefcase","put_down_case",100.0,200.0,0.3,120,0.2,0,0,0)
				        Wait(800)
				        vRP._DeletarObjeto()
				        CaixaVan(veh,model)
                        Wait(600)
                        caixanamao = false
                        andamento = false
                        pegando = false
                        vRP.playSound("5_SEC_WARNING","HUD_MINI_GAME_SOUNDSET")
				        ClearPedTasksImmediately(ped)
                        FreezeEntityPosition(ped,false)
                        TriggerEvent("Notify","importante","Você colocou a <b>encomenda</b> na <b>Van</b>, atualmente com <b>"..quantidade.."/10 Encomendas</b>!")
					end
				end
			end
			if distance2 <= 50 and pegando and encomendapega then
				if distance2 < 1.5 and not IsPedInAnyVehicle(ped) then
					DrawText3Ds(entregalocal[destino].x,entregalocal[destino].y,entregalocal[destino].z+0.35,"~b~[E] ~w~Entregar Encomenda")
					TriggerEvent('cancelando',false)
                    if IsControlJustPressed(0,38) then
                    	if quantidade > 0 then
                    		Fade(1200)
                    		local pagamento = math.random(250,450)
                    		destinoantigo = destino
							pegando = false
							encomendapega = false
                            andamento = false
                            vRP._DeletarObjeto()
                            ClearPedTasksImmediately(ped)
                            TriggerServerEvent("cp_postal:receber",pagamento)
                            portaaberta = false
                            TriggerEvent("Notify","sucesso","<b>Encomenda</b> entregue, Você ganhou <b>$"..pagamento.."</b>, faltam entregar <b>"..quantidade.."/10 <b>Encomendas</b>!")
                            TriggerEvent("Notify","importante","Feche as portas traseiras, entre na <b>Van</b> e aguarde a próxima <b>Entrega</b>!")
                            RemoveBlip(blip)
                            time = math.random(20000,30000)
                        	Wait(time)
                        	TriggerEvent("Notify","sucesso","Chamado recebido, entre na <b>Van</b>, e vá ao <b>local</b> entregar a <b>Encomenda</b>!")
                        	vRP.playSound("ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
                            while true do
                                if destinoantigo == destino then
                                    destino = math.random(1,20)
                                else
                                    break
                                end
                                Citizen.Wait(1)
                            end
                            CriandoBlip(entregalocal,destino)
                        else
                        	parte = 1
                        	vRP.playSound("5_SEC_WARNING","HUD_MINI_GAME_SOUNDSET")
                        	quantidade = 1
                        	TriggerEvent("Notify","aviso","Você entregou todas as suas <b>encomendas</b>, volte para a central e pegue mais!")
                        end
					end
				end
			elseif distance2 <= 50 and not pegando and not encomendapega then
				DrawMarker(21,entregalocal[destino].x,entregalocal[destino].y,entregalocal[destino].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,65,105,255,50,0,0,0,1)
				if distance2 < 1.5 and not IsPedInAnyVehicle(ped) then
					DrawMarker(21,entregalocal[destino].x,entregalocal[destino].y,entregalocal[destino].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,65,105,255,50,0,0,0,1)
					DrawText3Ds(entregalocal[destino].x,entregalocal[destino].y,entregalocal[destino].z+0.35,"~w~ Pegue a Encomenda na ~b~Van")
			    end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local veh = GetVanPosition(10)
		local coordsVan = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.7, 0.0)
        local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),coordsVan.x,coordsVan.y,coordsVan.z,true)
		local model = GetEntityModel(veh)
		if distance <= 2.0 and not IsPedInAnyVehicle(PlayerPedId()) and emservico then
		    if model == -233098306 and GetVehicleNumberPlateText(veh) == vRP.getRegistrationNumber() then
			    if not traseira and not portaaberta and not portaaberta2 then
			        DrawText3Ds(coordsVan.x,coordsVan.y,coordsVan.z+0.80,"~b~[E] ~w~Abrir")
			    	if IsControlJustPressed(0,38) then
				        SetVehicleDoorOpen(veh, 3, false, false)
				        SetVehicleDoorOpen(veh, 2, false, false)
				        traseira = true
				        portaaberta2 = true
				        if parte == 1 then
				            portaaberta = true
				        end
				    end
                elseif traseira and not portaaberta then
            	    if parte == 1 then
	                    DrawText3Ds(coordsVan.x,coordsVan.y,coordsVan.z+0.80,"~b~[E] ~w~Fechar")
	                elseif parte == 2 and not encomendapega then
	            	    DrawText3Ds(coordsVan.x,coordsVan.y,coordsVan.z+0.80,"~b~[E] ~w~Fechar | ~b~[G] ~w~Pegar Encomenda")
	                elseif parte == 2 and encomendapega then
	            	    DrawText3Ds(coordsVan.x,coordsVan.y,coordsVan.z+0.80,"~b~[E] ~w~Fechar | ~b~[G] ~w~Guardar Encomenda")
	                end 
				    if IsControlJustPressed(0,38) then
				        SetVehicleDoorShut(veh, 3, false)
				        SetVehicleDoorShut(veh, 2, false)
				        traseira = false
				        if parte == 2 then
				            portaaberta2 = false
				        end
				    end
                end
			end
		end
		if distance <= 3.0 and not IsPedInAnyVehicle(PlayerPedId()) and emservico then
			if model == -233098306 and GetVehicleNumberPlateText(veh) == vRP.getRegistrationNumber() then
				DrawText3Ds(coordsVan.x,coordsVan.y,coordsVan.z+0.55,"  ~b~"..quantidade.."~w~  /  ~b~10    ")
			end
		end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if andamento then
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,21,true)
			DisableControlAction(0,22,true)
		end
	end
end)

function spawnVan()
	local mhash = "boxville2"
	if not nveh then
	while not HasModelLoaded(mhash) do
	    RequestModel(mhash)
	    Citizen.Wait(10)
	end
		local ped = PlayerPedId()
		local x,y,z = vRP.getPosition()
		nveh = CreateVehicle(mhash, 118.29,95.19,80.94+0.5,250.65,true,false)
		SetVehicleIsStolen(nveh,false)
		SetVehicleOnGroundProperly(nveh)
		SetEntityInvincible(nveh,false)
		SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
		Citizen.InvokeNative(0xAD738C3085FE7E11,nveh,true,true)
		SetVehicleHasBeenOwnedByPlayer(nveh,true)
		SetVehicleDirtLevel(nveh,0.0)
		SetVehRadioStation(nveh,"OFF")
		SetVehicleEngineOn(GetVehiclePedIsIn(ped,false),true)
		SetModelAsNoLongerNeeded(mhash)
	end
end

function Fade(time)
	DoScreenFadeOut(800)
	Wait(time)
	DoScreenFadeIn(800)
end

function FadeRoupa(time,tipo,idle_copy)
	DoScreenFadeOut(800)
	Wait(time)
	if tipo == 1 then 
		vRP.setCustomization(idle_copy)
	else
		TriggerServerEvent("cp_postal:roupa")
	end
	DoScreenFadeIn(800)
end

local RoupaEntregador = {
	["Entregador"] = {
		[1885233650] = {                                      
            [1] = { -1,0 },
            [3] = { 0,0 },
            [4] = { 17,6 },
            [5] = { -1,0 },
            [6] = { 42,0 },
            [7] = { -1,0 },
			[8] = { 15,0 },
			[9] = { -1,0 },
            [10] = { -1,0 },
            [11] = { 242,1 },
            ["p0"] = { -1,0 },
            ["p1"] = { 0,0 }
        },
        [-1667301416] = {
            [1] = { -1,0 },
            [3] = { 14,0 },
            [4] = { 14,1 },
            [5] = { 42,0 },
            [6] = { 10,1 },
            [7] = { -1,0 },
            [8] = { 6,0 },
            [9] = { -1,0 },
            [10] = { -1,0 },
            [11] = { 250,3 },
            ["p0"] = { 58,0 },
            ["p1"] = { 5,0 }
        }
	}
}

function ColocarRoupa()
	if vRP.getHealth() > 101 then
		if not vRP.isHandcuffed() then
			local custom = RoupaEntregador["Entregador"]
			if custom then
				local old_custom = vRP.getCustomization()
				local idle_copy = {}

				idle_copy = job.SaveIdleCustom(old_custom)
				idle_copy.modelhash = nil

				for l,w in pairs(custom[old_custom.modelhash]) do
						idle_copy[l] = w
				end
				FadeRoupa(1200,1,idle_copy)
			end
		end
	end
end

function MainRoupa()
	if vRP.getHealth() > 101 then
		if not vRP.isHandcuffed() then
	        FadeRoupa(1200,2)
	    end
	end
end

function CaixaVan(veh,model)
	if quantidade <= 10 then
		RequestModel(GetHashKey("hei_prop_heist_box"))
        while not HasModelLoaded(GetHashKey("hei_prop_heist_box")) do
            Citizen.Wait(10)
        end
	    local coords = GetOffsetFromEntityInWorldCoords(veh,0.0,0.0,-5.0)
		if quantidade == 1 and model == -233098306 then
			propcaixa = nil
			propcaixa = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa,veh,0.0,-0.25,-3.0,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa,true)
		elseif quantidade == 2 and model == -233098306 then
			propcaixa2 = nil
			propcaixa2 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa2,veh,0.0,0.25,-3.0,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa2,true)
		elseif quantidade == 3 and model == -233098306 then
			propcaixa3 = nil
			propcaixa3 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa3,veh,0.0,-0.25,-2.55,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa3,true)
		elseif quantidade == 4 and model == -233098306 then
			propcaixa4 = nil
			propcaixa4 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa4,veh,0.0,0.25,-2.55,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa4,true)
		elseif quantidade == 5 and model == -233098306 then
			propcaixa5 = nil
			propcaixa5 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa5,veh,0.0,-0.25,-2.1,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa5,true)
		elseif quantidade == 6 and model == -233098306 then
			propcaixa6 = nil
			propcaixa6 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa6,veh,0.0,0.25,-2.1,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa6,true)
		elseif quantidade == 7 and model == -233098306 then
			propcaixa7 = nil
			propcaixa7 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa7,veh,0.0,-0.25,-1.65,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa7,true)
		elseif quantidade == 8 and model == -233098306 then
			propcaix8 = nil
			propcaixa8 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa8,veh,0.0,0.25,-1.65,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa8,true)
		elseif quantidade == 9 and model == -233098306 then
			propcaixa9 = nil
			propcaixa9 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa9,veh,0.0,-0.25,-1.2,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa9,true)
		elseif quantidade == 10 and model == -233098306 then
			propcaix10 = nil
			propcaixa10 = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa10,veh,0.0,0.25,-1.2,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa10,true)
		end
	end
end

function TirarCaixa()
	if quantidade == 1 then
        if DoesEntityExist(propcaixa) then
			DetachEntity(propcaixa,false,false)
			FreezeEntityPosition(propcaixa,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa))
            propcaixa = nil
        end
	elseif quantidade == 2 then
		if DoesEntityExist(propcaixa2) then
			DetachEntity(propcaixa2,false,false)
			FreezeEntityPosition(propcaixa2,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa2))
            propcaixa2 = nil
        end
	elseif quantidade == 3 then
		if DoesEntityExist(propcaixa3) then
			DetachEntity(propcaixa3,false,false)
			FreezeEntityPosition(propcaixa3,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa3))
            propcaixa3 = nil
        end
	elseif quantidade == 4 then
		if DoesEntityExist(propcaixa4) then
			DetachEntity(propcaixa4,false,false)
			FreezeEntityPosition(propcaixa4,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa4))
            propcaixa4 = nil
        end
	elseif quantidade == 5 then
		if DoesEntityExist(propcaixa5) then
			DetachEntity(propcaixa5,false,false)
			FreezeEntityPosition(propcaixa5,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa5))
            propcaixa5 = nil
        end
	elseif quantidade == 6 then
		if DoesEntityExist(propcaixa6) then
			DetachEntity(propcaixa6,false,false)
			FreezeEntityPosition(propcaixa6,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa6))
            propcaixa6 = nil
        end
    elseif quantidade == 7 then
		if DoesEntityExist(propcaixa7) then
			DetachEntity(propcaixa7,false,false)
			FreezeEntityPosition(propcaixa7,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa7))
            propcaixa7 = nil
        end
    elseif quantidade == 8 then
		if DoesEntityExist(propcaixa8) then
			DetachEntity(propcaixa8,false,false)
			FreezeEntityPosition(propcaixa8,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa8))
            propcaixa8 = nil
        end
    elseif quantidade == 9 then
		if DoesEntityExist(propcaixa9) then
			DetachEntity(propcaixa9,false,false)
			FreezeEntityPosition(propcaixa9,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa9))
            propcaixa9 = nil
        end
    elseif quantidade == 10 then
		if DoesEntityExist(propcaixa10) then
			DetachEntity(propcaixa10,false,false)
			FreezeEntityPosition(propcaixa10,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa10))
            propcaixa10 = nil
        end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,168) and emservico then
			emservico = false
            quantidade = 0
            parte = 0
            statuses = false
            pegando = false
            andamento = false
            caixanamao = false
            traseira = false
            portaaberta = false
            portaaberta2 = false
            encomendapega = false
			TriggerEvent('cancelando',false)
			RemoveBlip(blip)
			vRP.playSound("Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
			MainRoupa()
			if nveh then
			    TriggerServerEvent("trydeleteveh",VehToNet(nveh))
			    nveh = nil
			end
			if DoesEntityExist(propcaixa) then
                DetachEntity(propcaixa,false,false)
                TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa))
                propcaixa = nil
            end
		    if DoesEntityExist(propcaixa2) then
                DetachEntity(propcaixa2,false,false)
                TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa2))
                propcaixa2 = nil
            end
		    if DoesEntityExist(propcaixa3) then
                DetachEntity(propcaixa3,false,false)
                TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa3))
                propcaixa3 = nil
            end
		    if DoesEntityExist(propcaixa4) then
                DetachEntity(propcaixa4,false,false)
                TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa4))
                propcaixa4 = nil
            end 
		    if DoesEntityExist(propcaixa5) then
                DetachEntity(propcaixa5,false,false)
                TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa5))
                propcaixa5 = nil
            end
		    if DoesEntityExist(propcaixa6) then
                DetachEntity(propcaixa6,false,false)
                TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa6))
                propcaixa6 = nil
            end
		    if DoesEntityExist(propcaixa7) then
                DetachEntity(propcaixa7,false,false)
                TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa7))
                propcaixa7 = nil
            end
		    if DoesEntityExist(propcaixa8) then
                DetachEntity(propcaixa8,false,false)
                TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa8))
                propcaixa8 = nil
            end
		    if DoesEntityExist(propcaixa9) then
                DetachEntity(propcaixa9,false,false)
                TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa9))
                propcaixa9 = nil
            end
		    if DoesEntityExist(propcaixa10) then
                DetachEntity(propcaixa10,false,false)
                TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa10))
                propcaixa10 = nil
            end
            checkIn.LeaveJob()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCOES
-----------------------------------------------------------------------------------------------------------------------------------------
function GetVanPosition(radius)
	local ped = PlayerPedId()
	local coordsx = GetEntityCoords(ped, 1)
	local coordsy = GetOffsetFromEntityInWorldCoords(ped, 0.0, radius+0.00001, 0.0)
	local nearVehicle = GetVanDirection(coordsx, coordsy)
	if IsEntityAVehicle(nearVehicle) then
	    return nearVehicle
	else
		local x,y,z = table.unpack(coordsx)
	    if IsPedSittingInAnyVehicle(ped) then
	        local veh = GetVehiclePedIsIn(ped,true)
	        return veh
	    else
	        local veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001,radius+0.0001,0,8192+4096+4+2+1) 
	        if not IsEntityAVehicle(veh) then 
	        	veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001,radius+0.0001,0,4+2+1) 
	        end 
	        return veh
	    end
	end
end

function GetVanDirection(coordFrom,coordTo)
	local position = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a,b,c,d,vehicle = GetRaycastResult(position)
	return vehicle
end

function DrawText3D(x,y,z, text, scl, font) 
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

	local scale = (1/dist)*scl
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov
	if onScreen then
		SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 180)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
	end
end

function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 78)
end

function CriandoBlip(entregalocal,destino)
	blip = AddBlipForCoord(entregalocal[destino].x,entregalocal[destino].y,entregalocal[destino].z)
	SetBlipSprite(blip,162)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.45)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Encomendas")
	EndTextCommandSetBlipName(blip)
end