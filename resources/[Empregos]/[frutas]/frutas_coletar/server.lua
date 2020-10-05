
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("frutas_coletar",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function emP.Quantidadefrutas()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(4)
	end
end

function emP.checkFrutas()
	emP.Quantidadefrutas()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("laranja")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) then
			TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>"..quantidade[source].."</b> Laranjas.") 
			vRP.giveInventoryItem(user_id,"laranja",quantidade[source])
			quantidade[source] = nil
			return true
		else
			TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.")
			return false
		end
	end
end