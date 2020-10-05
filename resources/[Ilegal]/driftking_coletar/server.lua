local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("driftking_coleta",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"driftking.permissao")
end

function emP.checkPayment()
	local source = source
   local user_id = vRP.getUserId(source)
   local quant1 = math.random(5)
   local quant2 = math.random(5)
   local quant3 = math.random(5)
   local quant4 = math.random(5)
   local quant5 = math.random(5)
   local quant6 = math.random(5)
   local quant7 = math.random(5)
   if user_id then
      if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("arame") <= vRP.getInventoryMaxWeight(user_id) then
         vRP.giveInventoryItem(user_id,"arame",quant1)
         vRP.giveInventoryItem(user_id,"tinta",quant2)
         vRP.giveInventoryItem(user_id,"papel",quant3)
         vRP.giveInventoryItem(user_id,"caneta",quant4)
         vRP.giveInventoryItem(user_id,"cilindro",quant5)
         vRP.giveInventoryItem(user_id,"gas",quant6)
         vRP.giveInventoryItem(user_id,"ferrob",quant7)
         TriggerClientEvent("progress",source,10000,"coletando")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant1.."x Arame/b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant2.."x Tinta</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant3.."x Papel</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant4.."x Caneta</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant5.."x Cilindro</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant6.."x Gas</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant7.."x Ferro</b>")
         return true
      else
         TriggerClientEvent("Notify",source,"negado","<b>Inventário Cheio</b>.")
		end
	end
end
math.random(2)
