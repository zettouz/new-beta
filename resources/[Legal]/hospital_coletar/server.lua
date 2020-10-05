local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("hospital_coletar",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"dmla.permissao")
end

function emP.checkPayment()
	local source = source
   local user_id = vRP.getUserId(source)
   local quantp = math.random(5) -- quantidade pano
   local quantl = math.random(5) --quantidade linha
   local quants = math.random(5) --quantidade linha
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("gaze") <= vRP.getInventoryMaxWeight(user_id) then
         vRP.giveInventoryItem(user_id,"gaze",quantp)
         vRP.giveInventoryItem(user_id,"atadura",quantl)
         vRP.giveInventoryItem(user_id,"antisseptico",quants)
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quantp.."x Gaze</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quantl.."x Atadura</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quants.."x Antisséptico</b>")
         return true
      else
         TriggerClientEvent("Notify",source,"negado","<b>Inventário Cheio</b>.")
		end
	end
end
math.random(2)
