local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-families",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local families = {
	{ item = "planta-alta" },
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-families")
AddEventHandler("produzir-families",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(families) do
			if item == v.item then
				if item == "planta-alta" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("planta-alta") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"tetra-hidrocanabinol") >= 100 then
                            if vRP.getInventoryItemAmount(user_id,"haxixe") >= 100 then
                                if vRP.getInventoryItemAmount(user_id,"skunk") >= 100 then
                                    if vRP.getInventoryItemAmount(user_id,"beck") >= 20 then
                                        if vRP.tryGetInventoryItem(user_id,"tetra-hidrocanabinol",100) and vRP.tryGetInventoryItem(user_id,"haxixe",100) and vRP.tryGetInventoryItem(user_id,"skunk",100) and vRP.tryGetInventoryItem(user_id,"beck",20) then
                                            TriggerClientEvent("fechar-nui-families",source)

                                            TriggerClientEvent("progress",source,10000,"Montando planta de Alta")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"planta-alta",20)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>planta de Alta</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Beck</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Skunk</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Haxixe</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Tetra Hidrocanabinol</b> na mochila.")
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
    if vRP.hasPermission(user_id,"families.permissao") then
        return true
    end
end