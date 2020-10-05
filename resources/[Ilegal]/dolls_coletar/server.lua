local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("dolls_coletar",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"dolls.permissao")
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
   local quant8 = math.random(5)
   local quant9 = math.random(5)
   local quant10 = math.random(5)
   local quant11 = math.random(5)
   local quant12 = math.random(5)
   local quant13 = math.random(5)
   local quant14 = math.random(5)
   if user_id then
      if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("fita") <= vRP.getInventoryMaxWeight(user_id) then
         vRP.giveInventoryItem(user_id,"fita",quant1)
         vRP.giveInventoryItem(user_id,"fios",quant2)
         vRP.giveInventoryItem(user_id,"controle",quant3)
         vRP.giveInventoryItem(user_id,"armacaodefuradeira",quant4)
         vRP.giveInventoryItem(user_id,"broca",quant5)
         vRP.giveInventoryItem(user_id,"ferrob",quant6)
         vRP.giveInventoryItem(user_id,"armacaodeserra",quant7)
         vRP.giveInventoryItem(user_id,"disco",quant8)
         vRP.giveInventoryItem(user_id,"pano",quant9)
         vRP.giveInventoryItem(user_id,"corda",quant10)
         vRP.giveInventoryItem(user_id,"pendrive2",quant11)
         vRP.giveInventoryItem(user_id,"keycard2",quant12)
         vRP.giveInventoryItem(user_id,"chave",quant13)
         vRP.giveInventoryItem(user_id,"polvora",quant14)
         TriggerClientEvent("progress",source,10000,"coletando")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant1.."x Fitas</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant2.."x Fios</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant3.."x Controle</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant4.."x Armação de Furadeira</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant5.."x Broca</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant6.."x Ferro</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant7.."x Armação de Serra</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant8.."x Disco</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant9.."x Pano</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant10.."x Corda</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant11.."x Pendrive Reutilizável</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant12.."x Cartão Reutilizável</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant13.."x Chaves</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Você Recebeu "..quant14.."x Polvora</b>")
         return true
      else
         TriggerClientEvent("Notify",source,"negado","<b>Inventário Cheio</b>.")
		end
	end
end
math.random(2)
