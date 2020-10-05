
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("cp_piloto",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"piloto.permissao")
end

function emP.checkPayment(payment)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        randmoney = (math.random(500,1000)*payment)
        vRP.giveMoney(user_id,parseInt(randmoney))
        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
        TriggerClientEvent("Notify",source,"bom","<b>McKenzie:</b> Você recebeu <b>$"..randmoney.." dólares</b> pela viagem.",3000)
        TriggerClientEvent("Notify",source,"bom","<b>McKenzie:</b> Ei, ei, ei! Vá depressa buscar o próximo passageiro!",5000)
    end
end