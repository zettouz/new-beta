
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("frutas_entregas",emP)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('inicio:sucesso')
AddEventHandler('inicio:sucesso', function()
	local player = source
	local user_id = vRP.getUserId(player)
	if user_id then
		TriggerClientEvent('confirmado', source)
	end
end)

function emP.GetItens()
	local player = source
	local user_id = vRP.getUserId(player)
	if user_id then
		vRP.tryGetInventoryItem(user_id,"laranja",10) 
	end
end


function emP.CheckItens()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"laranja") >= 10 then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Frutas insuficientes.") 
			return false
		end
	end
end

function emP.CheckPayment()
	local player = source
	local user_id = vRP.getUserId(source)	
	random = math.random(1500,1900)	
	if user_id then
		vRP.giveMoney(user_id,parseInt(random))
		TriggerClientEvent("vrp_sound:source",source,'coins',0.3)
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..random.."</b> Dólares.") 
	end
end
