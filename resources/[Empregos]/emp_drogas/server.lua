
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("emp_drogas",emP)
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local quantidade = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookdrugs = "SEUWEBHOOK"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(4,8)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkItens()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.getInventoryItemAmount(user_id,"baseado") >= quantidade[source]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserAptitudes(user_id)
		if data then
			if vRP.tryGetInventoryItem(user_id,"baseado",quantidade[source]) then
				local price = math.random(150,250)
				local payment = price+(price*data.creative.traficante*0.0001)
				vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(payment*quantidade[source]))
				vRPclient._playAnim(source,true,{"mp_common","givetake1_a"},false)
				TriggerClientEvent("vrp_sound:source",source,'coin',0.2)
				TriggerClientEvent("Notify",source,"sucesso","Entrega concluída, recebido <b>$"..vRP.format(parseInt(payment*quantidade[source])).." dólares</b>.",8000)
				quantidade[source] = nil
			end
		end
	end
end

function emP.MarcarOcorrencia()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.searchTimer(user_id,120)
		TriggerClientEvent("Notify",source,"aviso","A policia foi acionada.",8000)
		local soldado = vRP.getUsersByPermission("bcso.permissao")

		if parseInt(#soldado) <= 3 then
			TriggerClientEvent("lockCops",source)
		end

		local x,y,z = vRPclient.getPosition(source)
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,153,84,"Ocorrência",0.5,false)
					vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					TriggerClientEvent('chatMessage',player,"Dispatch",{65,130,255},"Recebemos uma denuncia de drogas, verifique o ocorrido.")
					SetTimeout(30000,function()
						idgens:free(id)
						vRPclient.removeBlip(player,blips[id])
						blips[id] = nil
					end)
				end)
			end
			SendWebhookMessage(webhookdrugs,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FOI DENUNCIADO] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			Citizen.Wait(10)
		end
	end
end