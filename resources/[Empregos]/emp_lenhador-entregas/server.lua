
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = {}
Tunnel.bindInterface("emp_lenhador-entregas",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookmonster = "SEUWEBHOOK"


function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function func.Quantidade()
	local source = source
	if quantidade[source] == nil then
	   quantidade[source] = math.random(5,8)	
	end
	   TriggerClientEvent("quantidade-tora",source,parseInt(quantidade[source]))
end

function func.checkPayment()
	func.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"tora",quantidade[source]) then
			randmoney = (math.random(120,170)*quantidade[source])
	        vRP.giveMoney(user_id,parseInt(randmoney))
	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
	        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
			quantidade[source] = nil
			func.Quantidade()
			return true
		else
			SendWebhookMessage(webhookmonster,"```prolog\n[ID]: "..user_id.." \n[TENTOU USAR MONSTERMENU E FOI PEGO NO PULO]\n>>>> "..quantidade[source].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```<&692696213283405927>")
			TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..quantidade[source].."x Toras</b>.")
		end
	end
end