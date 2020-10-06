local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("bahamas_coletar",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"bahamas.permissao")
end

function emP.checkPayment()
	local source = source
   local user_id = vRP.getUserId(source)
   local quant1 = math.random(15)
   local quant2 = math.random(15)
   local quant3 = math.random(15)
   local quant4 = math.random(15)
   local quant5 = math.random(15)
   local quant6 = math.random(2)
   if user_id then
      if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("losna") <= vRP.getInventoryMaxWeight(user_id) then
         vRP.giveInventoryItem(user_id,"losna",quant1)
         vRP.giveInventoryItem(user_id,"anis",quant2)
         vRP.giveInventoryItem(user_id,"funcho",quant3)
         vRP.giveInventoryItem(user_id,"ervas",quant4)
         vRP.giveInventoryItem(user_id,"acucar",quant5)
         vRP.giveInventoryItem(user_id,"taca",quant6)
         TriggerClientEvent("progress",source,10000,"coletando")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant1.."x Losna</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant2.."x Anis</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant3.."x Funcho</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant4.."x Ervas</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant5.."x Acucar</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant6.."x Taça</b>")
         return true
      else
         TriggerClientEvent("Notify",source,"negado","<b>Inventário Cheio</b>.")
		end
	end
end
math.random(2)
