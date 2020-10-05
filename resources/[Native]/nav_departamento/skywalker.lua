local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "sanduiche", quantidade = 1, compra = 20 },
	{ item = "rosquinha", quantidade = 1, compra = 20 },
	{ item = "isca", quantidade = 1, compra = 65 },
	{ item = "hotdog", quantidade = 1, compra = 20 },
	{ item = "xburguer", quantidade = 1, compra = 20 },
    { item = "chips", quantidade = 1, compra = 20 },
    { item = "batataf", quantidade = 1, compra = 20 },
    { item = "pizza", quantidade = 1, compra = 20 },
	{ item = "taco", quantidade = 1, compra = 20 },
	
	{ item = "agua", quantidade = 1, compra = 20 },
	{ item = "cola", quantidade = 1, compra = 20 },
	{ item = "sprunk", quantidade = 1, compra = 20 },
	{ item = "energetico", quantidade = 1, compra = 2000 },
    { item = "leite", quantidade = 1, compra = 20 },
    { item = "barracho", quantidade = 1, compra = 20 },
    { item = "patriot", quantidade = 1, compra = 20 },
    { item = "pibwassen", quantidade = 1, compra = 20 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ COMPRAR ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("departamento-comprar")
AddEventHandler("departamento-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryPayment(user_id,parseInt(v.compra)) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)