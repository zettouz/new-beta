local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-ballas",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local ballas = {
	{ item = "composito-alta" },
	{ item = "assaultsmg" },
	{ item = "advancedrifle" },
	{ item = "weaponmg" },
	{ item = "fiveseven" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-ballas")
AddEventHandler("produzir-ballas",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(ballas) do
			if item == v.item then
				if item == "composito-alta" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("composito-alta") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"nitrato-amonia") >= 100 then
                            if vRP.getInventoryItemAmount(user_id,"hidroxido-sodio") >= 100 then
                                if vRP.getInventoryItemAmount(user_id,"pseudoefedrina") >= 100 then
                                    if vRP.getInventoryItemAmount(user_id,"eter") >= 20 then
                                        if vRP.tryGetInventoryItem(user_id,"nitrato-amonia",100) and vRP.tryGetInventoryItem(user_id,"hidroxido-sodio",100) and vRP.tryGetInventoryItem(user_id,"pseudoefedrina",100) and vRP.tryGetInventoryItem(user_id,"eter",20) then
                                            TriggerClientEvent("fechar-nui-ballas",source)

                                            TriggerClientEvent("progress",source,10000,"Montando Composito de Alta")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"composito-alta",20)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Composito de Alta</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Éter</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Pseudoefedrina</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Hidróxido de Sódio</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Nitrato de Amônia</b> na mochila.")
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
    if vRP.hasPermission(user_id,"ballas.permissao") then
        return true
    end
end