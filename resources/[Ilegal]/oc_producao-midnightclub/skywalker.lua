local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-midnightclub",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local midnightclub = {
	{ item = "placa" },
	{ item = "raceticket" },
	{ item = "nitro" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-midnightclub")
AddEventHandler("produzir-midnightclub",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(midnightclub) do
			if item == v.item then
				if item == "placa" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("placa") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"arame") >= 40 then
                            if vRP.getInventoryItemAmount(user_id,"tinta") >= 40 then
                                if vRP.getInventoryItemAmount(user_id,"ferrob") >= 40 then
                                    if vRP.tryGetInventoryItem(user_id,"arame",40) and vRP.tryGetInventoryItem(user_id,"tinta",40) and vRP.tryGetInventoryItem(user_id,"ferrob",40) then
                                        TriggerClientEvent("fechar-nui",source)
                                        TriggerClientEvent("progress",source,10000,"Montando Placa")
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"placa",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>PLACA</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Ferro</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Tinta</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Arame</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "raceticket" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("raceticket") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"papel") >= 20 then
                            if vRP.getInventoryItemAmount(user_id,"caneta") >= 20 then
                                if vRP.tryGetInventoryItem(user_id,"papel",20) and vRP.tryGetInventoryItem(user_id,"caneta",20) then
                                    TriggerClientEvent("fechar-nui",source)
                                    TriggerClientEvent("progress",source,10000,"Montando Ticket Corrida")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"raceticket",1)
                                        TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Ticket Corrida</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Caneta</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Papel</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "nitro" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("nitro") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"cilindro") >= 70 then
                            if vRP.getInventoryItemAmount(user_id,"gas") >= 70 then
                                if vRP.tryGetInventoryItem(user_id,"cilindro",70) and vRP.tryGetInventoryItem(user_id,"gas",70) then
                                    TriggerClientEvent("fechar-nui",source)
                                    TriggerClientEvent("progress",source,10000,"Montando NITRO")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"nitro",1)
                                        TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>NITRO</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Gás</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Cilindro</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function oC.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"midnightclub.permissao") then
        return true
    end
end