local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
hP = {}
Tunnel.bindInterface("oc_producao-hospital",hP)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local hospital = {
	{ item = "kitmedico" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-hospital")
AddEventHandler("produzir-hospital",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(hospital) do
			if item == v.item then
                if item == "kitmedico" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("kitmedico") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"antisseptico") >= 20 then
                            if vRP.getInventoryItemAmount(user_id,"atadura") >= 20 then
                                if vRP.getInventoryItemAmount(user_id,"gaze") >= 20 then
                                    if vRP.tryGetInventoryItem(user_id,"antisseptico",20) and vRP.tryGetInventoryItem(user_id,"gaze",20) and vRP.tryGetInventoryItem(user_id,"atadura",20) then
                                        TriggerClientEvent("fechar-nui-hospital",source)
                                        
                                        TriggerClientEvent("progress",source,30000,"Fabricando Kit Médico")
                                        TriggerClientEvent("hospital:posicao1",source)
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                        SetTimeout(30000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"kitmedico",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Você fabricou um <b>Kit Médico</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Gaze</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Atadura</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem um <b>Antisséptico</b> na mochila.")
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
function hP.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"dmla.permissao") then
        return true
    end
end