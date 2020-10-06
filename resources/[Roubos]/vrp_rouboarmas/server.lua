local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("vrp_rouboarmas",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local idgens = Tools.newIDGenerator()
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookrouboarmas = "https://discordapp.com/api/webhooks/701152179649511555/cLW5BzRu_wltR7MiebsvF-fAS9tCluBW5bZPZbpinQJZHqp3PMJP5u8_TKZvfj4RIAHt"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ARMASLIST
-----------------------------------------------------------------------------------------------------------------------------------------

local armalist = {
	[1] = { ['index'] = "wbody|WEAPON_SNSPISTOL", ['qtd'] = 1, ['name'] = "PISTOLA FAJUTA" },
    [2] = { ['index'] = "wbody|WEAPON_PISTOL_MK2", ['qtd'] = 1, ['name'] = "FIVE SEVEN" },
    [4] = { ['index'] = "wbody|WEAPON_MACHINEPISTOL", ['qtd'] = 1, ['name'] = "TEC-9" },
    [5] = { ['index'] = "wbody|WEAPON_BULLPUPRIFLE", ['qtd'] = 1, ['name'] = "BULLPUP RIFLE" },
    [6] = { ['index'] = "wbody|WEAPON_ASSAULTRIFLE", ['qtd'] = 1, ['name'] = "Ak-47" },
    [8] = { ['index'] = "wammo|WEAPON_SNSPISTOL", ['qtd'] = 35, ['name'] = "MUNIÇÃO DE FAJUTA" },
    [9] = { ['index'] = "wammo|WEAPON_PISTOL_MK2", ['qtd'] = 50, ['name'] = "MUNIÇÃO DE FIVE SEVEN" },
    [11] = { ['index'] = "wammo|WEAPON_MACHINEPISTOL", ['qtd'] = 50, ['name'] = "MUNIÇÃO DE TEC-9" },
    [12] = { ['index'] = "wammo|WEAPON_BULLPUPRIFLE", ['qtd'] = 30, ['name'] = "MUNIÇÃO DE BULLPUP" },
    [13] = { ['index'] = "wammo|WEAPON_ASSAULTRIFLE", ['qtd'] = 50, ['name'] = "MUNIÇÃO DE AK-47" },
	[16] = { ['index'] = "dinheirosujo", ['qtd'] = 3500, ['name'] = "Dinheiro Sujo" },
	[17] = { ['index'] = "dinheirosujo", ['qtd'] = 1500, ['name'] = "Dinheiro Sujo" },
	[18] = { ['index'] = "dinheirosujo", ['qtd'] = 500, ['name'] = "Dinheiro Sujo" },
	[19] = { ['index'] = "dinheirosujo", ['qtd'] = 2500, ['name'] = "Dinheiro Sujo" },
	[20] = { ['index'] = "dinheirosujo", ['qtd'] = 1500, ['name'] = "Dinheiro Sujo" },
	[21] = { ['index'] = "dinheirosujo", ['qtd'] = 3100, ['name'] = "Dinheiro Sujo" },
	[22] = { ['index'] = "dinheirosujo", ['qtd'] = 3000, ['name'] = "Dinheiro Sujo" },
	[23] = { ['index'] = "dinheirosujo", ['qtd'] = 3000, ['name'] = "Dinheiro Sujo" },
	[24] = { ['index'] = "dinheirosujo", ['qtd'] = 4100, ['name'] = "Dinheiro Sujo" },
	[25] = { ['index'] = "dinheirosujo", ['qtd'] = 3600, ['name'] = "Dinheiro Sujo" },
	[26] = { ['index'] = "dinheirosujo", ['qtd'] = 2400, ['name'] = "Dinheiro Sujo" },
	[27] = { ['index'] = "dinheirosujo", ['qtd'] = 3600, ['name'] = "Dinheiro Sujo" },
	[28] = { ['index'] = "dinheirosujo", ['qtd'] = 3100, ['name'] = "Dinheiro Sujo" },
	[29] = { ['index'] = "dinheirosujo", ['qtd'] = 4100, ['name'] = "Dinheiro Sujo" },
	[30] = { ['index'] = "dinheirosujo", ['qtd'] = 3200, ['name'] = "Dinheiro Sujo" },
	[31] = { ['index'] = "dinheirosujo", ['qtd'] = 5500, ['name'] = "Dinheiro Sujo" },
	[32] = { ['index'] = "dinheirosujo", ['qtd'] = 1300, ['name'] = "Dinheiro Sujo" },
	[33] = { ['index'] = "dinheirosujo", ['qtd'] = 1500, ['name'] = "Dinheiro Sujo" },
	[34] = { ['index'] = "dinheirosujo", ['qtd'] = 3200, ['name'] = "Dinheiro Sujo" },
	[35] = { ['index'] = "dinheirosujo", ['qtd'] = 2100, ['name'] = "Dinheiro Sujo" },
	[36] = { ['index'] = "dinheirosujo", ['qtd'] = 900, ['name'] = "Dinheiro Sujo" },
	[37] = { ['index'] = "dinheirosujo", ['qtd'] = 300, ['name'] = "Dinheiro Sujo" },
	[38] = { ['index'] = "wbody|WEAPON_KNIFE", ['qtd'] = 1, ['name'] = "Faca" },
	[39] = { ['index'] = "wbody|WEAPON_DAGGER", ['qtd'] = 1, ['name'] = "Adaga" },
	[40] = { ['index'] = "wbody|WEAPON_KNUCKLE", ['qtd'] = 1, ['name'] = "Soco-Inglês" },
	[41] = { ['index'] = "wbody|WEAPON_MACHETE", ['qtd'] = 1, ['name'] = "Machete" },
	[42] = { ['index'] = "wbody|WEAPON_SWITCHBLADE", ['qtd'] = 1, ['name'] = "Canivete" },
	[43] = { ['index'] = "wbody|WEAPON_WRENCH", ['qtd'] = 1, ['name'] = "Chave de Grifo" },
	[44] = { ['index'] = "wbody|WEAPON_HAMMER", ['qtd'] = 1, ['name'] = "Martelo" },
	[45] = { ['index'] = "wbody|WEAPON_GOLFCLUB", ['qtd'] = 1, ['name'] = "Taco de Golf" },
	[46] = { ['index'] = "wbody|WEAPON_CROWBAR", ['qtd'] = 1, ['name'] = "Pé de Cabra" },
	[47] = { ['index'] = "wbody|WEAPON_HATCHET", ['qtd'] = 1, ['name'] = "Machado" },
	[48] = { ['index'] = "wbody|WEAPON_FLASHLIGHT", ['qtd'] = 1, ['name'] = "Lanterna" },
	[49] = { ['index'] = "wbody|WEAPON_BAT", ['qtd'] = 1, ['name'] = "Taco de Beisebol" },
	[50] = { ['index'] = "wbody|WEAPON_BOTTLE", ['qtd'] = 1, ['name'] = "Garrafa" },
	[51] = { ['index'] = "wbody|WEAPON_BATTLEAXE", ['qtd'] = 1, ['name'] = "Machado de Batalha" },
	[52] = { ['index'] = "wbody|WEAPON_POOLCUE", ['qtd'] = 1, ['name'] = "Taco de Sinuca" },
	[53] = { ['index'] = "wbody|WEAPON_STONE_HATCHET", ['qtd'] = 1, ['name'] = "Machado de Pedra" }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(timers) do
			if v > 0 then
				timers[k] = v - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkRobbery(id,x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local policia = vRP.getUsersByPermission("policia.permissao")
		if #policia >= 0 then
			if timers[id] == 0 or not timers[id] then
				timers[id] = 900
				TriggerClientEvent('iniciandolojadearmas',source,x,y,z)
				vRPclient._playAnim(source,false,{{"oddjobs@shop_robbery@rob_till","loop"}},true)
				local random = math.random(100)
				if random >= 10 then
					TriggerClientEvent("Notify",source,"aviso","A policia foi acionada.",8000)
					TriggerClientEvent("vrp_sound:source",source,'alarm',0.3)
					vRPclient.setStandBY(source,parseInt(60))
					for l,w in pairs(policia) do
						local player = vRP.getUserSource(parseInt(w))
						if player then
							async(function()
								local ids = idgens:gen()
								vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
								blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo em andamento",0.5,true)
								TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O roubo começou na ^1Loja de armas^0, dirija-se até o local e intercepte o assaltante.")
								SetTimeout(20000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
							end)
						end
					end
				end
				local randitem = math.random(#armalist)
				SetTimeout(45000,function()
					local randlist = math.random(100)
					if randlist >= 50 and randlist <= 100 then
							SendWebhookMessage(webhookrouboarmas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n [ROUBOU]: "..armalist[randitem].qtd.." "..armalist[randitem].name.."  "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\n[Tipo]: Loja de Armas \n[Recebeu]: Você recebeu "..armalist[randitem].qtd.."x <b>"..armalist[randitem].name.."</b>.\r```")
							vRP.giveInventoryItem(user_id,armalist[randitem].index,armalist[randitem].qtd)
							TriggerClientEvent("Notify",source,"sucesso","Você recebeu "..armalist[randitem].qtd.."x <b>"..armalist[randitem].name.."</b>.",8000)
						end
				end)
			else
				TriggerClientEvent("Notify",source,"aviso","O seguro ainda não cobriu o ultimo assalto, aguarde <b>"..timers[id].." segundos</b> até a cobertura.",8000)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return not (vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") or vRP.hasPermission(user_id,"paisanapolicia.permissao") or vRP.hasPermission(user_id,"paisanaparamedico.permissao"))
end