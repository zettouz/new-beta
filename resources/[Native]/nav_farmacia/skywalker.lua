local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "xarelto", quantidade = 1, compra = 3000 },
	{ item = "dipirona", quantidade = 1, compra = 500 },
	{ item = "nebacetin", quantidade = 1, compra = 500 },
	{ item = "kitmedico", quantidade = 1, compra = 8000 },
	{ item = "tandrilax", quantidade = 1, compra = 500 },
	{ item = "hirudoid", quantidade = 1, compra = 500 },
	{ item = "dorflex", quantidade = 1, compra = 500 },
	{ item = "buscopan", quantidade = 1, compra = 500 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ COMPRAR ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmacia-comprar")
AddEventHandler("farmacia-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if item == "xarelto" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
						if vRP.tryGetInventoryItem(user_id,"r-xarelto",1) then
							if vRP.tryPayment(user_id,parseInt(v.compra)) then
								vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
								TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
							else
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Você precisa de uma receita médica para isso.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
					end
				elseif item == "nebacetin" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
						if vRP.tryGetInventoryItem(user_id,"r-nebacetin",1) then
							if vRP.tryPayment(user_id,parseInt(v.compra)) then
								vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
								TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
							else
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Você precisa de uma receita médica para isso.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
					end
				elseif item == "hirudoid" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
						if vRP.tryGetInventoryItem(user_id,"r-hirudoid",1) then
							if vRP.tryPayment(user_id,parseInt(v.compra)) then
								vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
								TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
							else
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Você precisa de uma receita médica para isso.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
					end
				elseif item == "dipirona" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
						if vRP.tryGetInventoryItem(user_id,"r-dipirona",1) then
							if vRP.tryPayment(user_id,parseInt(v.compra)) then
								vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
								TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
							else
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Você precisa de uma receita médica para isso.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
					end
				elseif item == "kitmedico" then
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
				elseif item == "tandrilax" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
						if vRP.tryGetInventoryItem(user_id,"r-tandrilax",1) then
							if vRP.tryPayment(user_id,parseInt(v.compra)) then
								vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
								TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
							else
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Você precisa de uma receita médica para isso.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
					end
				elseif item == "dorflex" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
						if vRP.tryGetInventoryItem(user_id,"r-dorflex",1) then
							if vRP.tryPayment(user_id,parseInt(v.compra)) then
								vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
								TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
							else
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Você precisa de uma receita médica para isso.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
					end
				elseif item == "buscopan" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
						if vRP.tryGetInventoryItem(user_id,"r-buscopan",1) then
							if vRP.tryPayment(user_id,parseInt(v.compra)) then
								vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
								TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
							else
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Você precisa de uma receita médica para isso.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
					end
				end
			end
		end
	end
end)