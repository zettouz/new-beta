
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_motorista",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"taxista.permissao")
end

function emP.checkPayment(bonus)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        randmoney = (math.random(150,250)+bonus)
		vRP.giveMoney(user_id,parseInt(randmoney))
		TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
	end
end