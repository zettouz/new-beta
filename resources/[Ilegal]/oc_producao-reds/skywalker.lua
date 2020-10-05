local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-armas",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local armas = {
	{ item = "ak47" },
	{ item = "ak74u" },
	{ item = "uzi" },
	{ item = "magnum44" },
	{ item = "fiveseven" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-arma")
AddEventHandler("produzir-arma",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(armas) do
			if item == v.item then
				if item == "ak47" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ASSAULTRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpo-ak47") >= 1 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 10 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 3 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"corpo-ak47",1) and vRP.tryGetInventoryItem(user_id,"placa-metal",10) and vRP.tryGetInventoryItem(user_id,"molas",3) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nui",source)

                                            TriggerClientEvent("progress",source,10000,"Montando AK47")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_ASSAULTRIFLE_MK2",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>AK47</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>gatilho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>3x pacotes de mola</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>10x placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>corpo de AK-47</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "ak74u" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_COMPACTRIFLE") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpo-aks74u") >= 1 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 6 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 2 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"corpo-aks74u",1) and vRP.tryGetInventoryItem(user_id,"placa-metal",6) and vRP.tryGetInventoryItem(user_id,"molas",2) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nui",source)

                                            TriggerClientEvent("progress",source,10000,"Montando AKS-74U")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_COMPACTRIFLE",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>AKS-74U</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>gatilho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>2x pacotes de mola</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>6x placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>corpo de AKS-74U</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "uzi" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_MICROSMG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpo-uzi") >= 1 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 3 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 2 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"corpo-uzi",1) and vRP.tryGetInventoryItem(user_id,"placa-metal",3) and vRP.tryGetInventoryItem(user_id,"molas",2) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nui",source)

                                            TriggerClientEvent("progress",source,10000,"Montando MICRO-UZI")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_MICROSMG",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>UZI</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>gatilho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>2x pacotes de mola</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>3x placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>corpo de UZI</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "fiveseven" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_PISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpo-fiveseven") >= 1 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 1 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 1 then
                                    if vRP.tryGetInventoryItem(user_id,"corpo-fiveseven",1) and vRP.tryGetInventoryItem(user_id,"placa-metal",1) and vRP.tryGetInventoryItem(user_id,"molas",1) then
                                        TriggerClientEvent("fechar-nui",source)

                                        TriggerClientEvent("progress",source,10000,"Montando Five Seven")
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"wbody|WEAPON_PISTOL_MK2",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Five Seven</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>pacote de molas</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>placa de metal</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem um <b>corpo de Five Seven</b> na mochila.")
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
    if vRP.hasPermission(user_id,"lc.permissao") then
        return true
    end
end