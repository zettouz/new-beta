local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("vagos_coletar",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"vagos.permissao")
end

function emP.checkPayment()
	local source = source
   local user_id = vRP.getUserId(source)
   local quant1 = math.random(15)
   local quant2 = math.random(15)
   local quant3 = math.random(15)
   local quant4 = math.random(2)
   if user_id then
      if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("acido-sulfurico") <= vRP.getInventoryMaxWeight(user_id) then
         vRP.giveInventoryItem(user_id,"acido-sulfurico",quant1)
         vRP.giveInventoryItem(user_id,"folhas-coca",quant2)
         vRP.giveInventoryItem(user_id,"calcio-po",quant3)
         vRP.giveInventoryItem(user_id,"querosene",quant4)
         TriggerClientEvent("progress",source,10000,"coletando")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant1.."x Ácido Sulfúrico</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant2.."x Folhas de Coca</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant3.."x Cálcio em Pó</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant4.."x Querosene</b>")
         return true
      else
         TriggerClientEvent("Notify",source,"negado","<b>Inventário Cheio</b>.")
		end
	end
end
math.random(2)
