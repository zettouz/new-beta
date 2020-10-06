local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("cosanostra_coletar",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"cosanostra.permissao")
end

function emP.checkPayment()
	local source = source
   local user_id = vRP.getUserId(source)
   local quant1 = math.random(20)
   local quant2 = math.random(15)
   local quant3 = math.random(5)
   local quant4 = math.random(10)
   if user_id then
      if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("capsulas") <= vRP.getInventoryMaxWeight(user_id) then
         vRP.giveInventoryItem(user_id,"capsulas",quant1)
         vRP.giveInventoryItem(user_id,"polvora",quant2)
         vRP.giveInventoryItem(user_id,"tecido",quant3)
         vRP.giveInventoryItem(user_id,"placa-metal",quant4)
         TriggerClientEvent("progress",source,10000,"coletando")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant1.."x Capsulas</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant2.."x Polvora</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant3.."x Tecidos</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant4.."x Placa de Metal</b>")
         return true
      else
         TriggerClientEvent("Notify",source,"negado","<b>Inventário Cheio</b>.")
		end
	end
end
math.random(2)
