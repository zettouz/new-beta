local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-bahamas",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local bahamas = {
	{ item = "absinto-alta" },
	{ item = "assaultsmg" },
	{ item = "advancedrifle" },
	{ item = "weaponmg" },
	{ item = "fiveseven" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-bahamas")
AddEventHandler("produzir-bahamas",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(bahamas) do
			if item == v.item then
                if item == "preabsinto-alta" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("preabsinto-alta") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"losna") >= 100 then
                            if vRP.getInventoryItemAmount(user_id,"anis") >= 100 then
                                if vRP.getInventoryItemAmount(user_id,"funcho") >= 100 then
                                    if vRP.getInventoryItemAmount(user_id,"ervas") >= 100 then
                                        if vRP.getInventoryItemAmount(user_id,"acucar") >= 100 then
                                            if vRP.getInventoryItemAmount(user_id,"taca") >= 20 then
                                                if vRP.tryGetInventoryItem(user_id,"losna",100) and vRP.tryGetInventoryItem(user_id,"anis",100) and vRP.tryGetInventoryItem(user_id,"funcho",100) and vRP.tryGetInventoryItem(user_id,"ervas",100) and vRP.tryGetInventoryItem(user_id,"acucar",100) and vRP.tryGetInventoryItem(user_id,"taca",20) then
                                                    TriggerClientEvent("fechar-nui-bahamas",source)
                                                
                                                    TriggerClientEvent("progress",source,10000,"Montando Pre-Absinto de Alta")
                                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                                
                                                    SetTimeout(10000,function()
                                                        vRPclient._stopAnim(source,false)
                                                        vRP.giveInventoryItem(user_id,"preabsinto-alta",20)
                                                        TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Pre-Absinto de Alta</b>.")
                                                    end)
                                                end
                                            else
                                                TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Losna</b> na mochila.")
                                            end
                                        else
                                            TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Anis</b> na mochila.")
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Funcho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Ervas</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Açucar</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Taça</b> na mochila.")
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
    if vRP.hasPermission(user_id,"bahamas.permissao") then
        return true
    end
end