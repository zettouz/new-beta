local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("mafia_coletar",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"mafia.permissao")
end

function emP.checkPayment()
	local source = source
   local user_id = vRP.getUserId(source)
   local quant1 = math.random(10) -- quantidade peca de arma
   local quant2 = math.random(8) --quantidade placa
   local quant3 = math.random(5) --quantidade mola
   local quant4 = math.random(5) --quantidade gatilho
   if user_id then
      if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pecadearma") <= vRP.getInventoryMaxWeight(user_id) then
         vRP.giveInventoryItem(user_id,"pecadearma",quant1)
         vRP.giveInventoryItem(user_id,"placa-metal",quant2)
         vRP.giveInventoryItem(user_id,"molas",quant3)
         vRP.giveInventoryItem(user_id,"gatilho",quant4)
         TriggerClientEvent("progress",source,10000,"coletando")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant1.."x Peça de Arma</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant2.."x Placa de Metal</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant3.."x Molas</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant4.."x Gatilho</b>")
         return true
      else
         TriggerClientEvent("Notify",source,"negado","<b>Inventário Cheio</b>.")
		end
	end
end
math.random(2)
