
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_drogas")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local pedlist = {}
local segundos = 0
local selectnpc = nil
local porcentagem = 0
local pweapon = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDA DE DROGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = GetPlayerPed(-1)
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local random,npc = FindFirstPed()
			repeat
				if IsControlJustPressed(1,38) then
					local x2,y2,z2 = table.unpack(GetEntityCoords(npc))
					if not IsPedDeadOrDying(npc) and not IsPedAPlayer(npc) and Vdist(x,y,z,x2,y2,z2) <= 1.5 and not IsPedInAnyVehicle(npc) and not pedlist[npc] and not selectnpc and GetPedType(npc) ~= 28 then
						if emP.checkItens() then
							selectnpc = npc
							pedlist[npc] = true
							porcentagem = math.random(100)

							if porcentagem >= 1 and porcentagem <= 86 then
								segundos = 10
							elseif porcentagem >= 87 and porcentagem <= 93 then
								segundos = -1
								selectnpc = nil
								emP.MarcarOcorrencia()
							elseif porcentagem >= 94 then
								segundos = -1
								selectnpc = nil
								emP.MarcarOcorrencia()
								TaskSetBlockingOfNonTemporaryEvents(npc,true)
								pweapon = math.random(3)
								if pweapon == 1 then
									GiveWeaponToPed(npc,0x555AF99A,100,true,true)
								elseif pweapon == 2 then
									GiveWeaponToPed(npc,0x394F415C,100,true,true)
								elseif pweapon == 3 then
									GiveWeaponToPed(npc,0xD205520E,100,true,true)
								end
								TaskShootAtEntity(npc,ped,15000,GetHashKey("FIRING_PATTERN_FULL_AUTO"))
							end

							repeat
								Citizen.Wait(10)
							until not selectnpc

							if porcentagem >= 1 and porcentagem <= 84 and segundos == 0 then
								emP.checkPayment()
							end

							concluido = true
						end
					end
				end
				concluido,npc = FindNextPed(random)
			until not concluido
			EndFindPed(random)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30*60000)
		pedlist = {}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if segundos > 0 then
			drawTxt("AGUARDE ~b~"..segundos.."~w~ SEGUNDOS ATÉ FINALIZAR A NEGOCIAÇÃO",4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUINDO O TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos > 0 then
			local ped = GetPlayerPed(-1)
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local x2,y2,z2 = table.unpack(GetEntityCoords(selectnpc))
			if Vdist(x,y,z,x2,y2,z2) <= 5 and not IsPedDeadOrDying(selectnpc) then
				segundos = segundos - 1
				if segundos == 0 then
					TaskPlayAnim(selectnpc,"mp_common","givetake1_a",3.0,3.0,-1,48,10,0,0,0)
					selectnpc = nil
				end
			else
				segundos = -1
				selectnpc = nil
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