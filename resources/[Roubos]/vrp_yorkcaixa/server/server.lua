-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("vrp_yorkcaixa",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = 0
local recompensa = 0
local andamento = false
local dinheirosujo = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookcaixaeletronico = "SEUWEBHOOK"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADES
-----------------------------------------------------------------------------------------------------------------------------------------
local caixas = {
	[1] = { ['seconds'] = 40 },
	[2] = { ['seconds'] = 45 },
	[3] = { ['seconds'] = 45 },
	[4] = { ['seconds'] = 38 },
	[5] = { ['seconds'] = 35 },
	[6] = { ['seconds'] = 35 },
	[7] = { ['seconds'] = 60 },
	[8] = { ['seconds'] = 45 },
	[9] = { ['seconds'] = 40 },
	[10] = { ['seconds'] = 65 },
	[11] = { ['seconds'] = 50 },
	[12] = { ['seconds'] = 35 },
	[13] = { ['seconds'] = 55 },
	[14] = { ['seconds'] = 60 },
	[15] = { ['seconds'] = 50 },
	[16] = { ['seconds'] = 50 },
	[17] = { ['seconds'] = 50 },
	[18] = { ['seconds'] = 50 },
	[19] = { ['seconds'] = 50 },
	[20] = { ['seconds'] = 50 },
	[22] = { ['seconds'] = 50 },
	[24] = { ['seconds'] = 50 },
	[25] = { ['seconds'] = 50 },
	[26] = { ['seconds'] = 50 },
	[27] = { ['seconds'] = 70 },
	[28] = { ['seconds'] = 70 },
	[29] = { ['seconds'] = 70 },
	[30] = { ['seconds'] = 70 },
	[31] = { ['seconds'] = 70 },
	[32] = { ['seconds'] = 80 }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkRobbery(x,y,z) --id,x,y,z,head
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("bcso.permissao")
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if #policia < 0 then
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
			return false
		elseif (os.time()-timers) <= 600 then
			TriggerClientEvent("Notify",source,"aviso","Os caixas estão vazios, aguarde <b>"..vRP.format(parseInt((600-(os.time()-timers)))).." segundos</b> até que os civis depositem dinheiro.",8000)
			return false
		else
			andamento = true
			timers = os.time()
			dinheirosujo = {}
			for l,w in pairs(policia) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('blip:criar:caixaeletronico',player,x,y,z)
						vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
						TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O roubo começou no ^1Caixa Eletrônico^0, dirija-se até o local e intercepte os assaltantes.")
					end)
				end
			end
			SendWebhookMessage(webhookcaixaeletronico,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			if player then
				async(function()
					TriggerClientEvent('blip:remover:caixaeletronico',player)
					TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
				end)
			end
			return true
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.cancelRobbery()
	if andamento then
		andamento = false
		local policia = vRP.getUsersByPermission("bcso.permissao")
		for l,w in pairs(policia) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					TriggerClientEvent('blip:remover:caixaeletronico',player)
					TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O assaltante saiu correndo e deixou tudo para trás.")
				end)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			for k,v in pairs(dinheirosujo) do
				if v > 0 then
					dinheirosujo[k] = v - 1
					vRP._giveInventoryItem(k,"dinheiro-sujo",recompensa)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return not (vRP.hasPermission(user_id,"bcso.permissao") or vRP.hasPermission(user_id,"dmla.permissao") or vRP.hasPermission(user_id,"paisana-bcso.permissao") or vRP.hasPermission(user_id,"paisana-dmla.permissao"))
end

function func.giveItens()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		random = math.random(10000,12000)
		vRP.giveInventoryItem(user_id,"dinheiro-sujo",parseInt(random))
		TriggerClientEvent("Notify",source,"sucesso","Você roubou <b>"..random.."</b> de dinheiro sujo.")
	end
end

function func.getItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"c4b",1) then
			return true
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de uma <b>C4 Básica</b> para explodir o cofre.")
			return false
		end
	end
end

function func.checkItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"c4b") >= 1 then
			return true
		else
			return false
		end
	end
end