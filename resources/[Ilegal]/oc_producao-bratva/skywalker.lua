local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-bratva",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local bratva = {
	{ item = "snspistol" },
	{ item = "assaultsmg" },
	{ item = "advancedrifle" },
	{ item = "weaponmg" },
	{ item = "fiveseven" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-bratva")
AddEventHandler("produzir-bratva",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(bratva) do
			if item == v.item then
				if item == "advancedrifle" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ADVANCEDRIFLE") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 280 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 150 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 100 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 100 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",280) and vRP.tryGetInventoryItem(user_id,"placa-metal",150) and vRP.tryGetInventoryItem(user_id,"molas",100) and vRP.tryGetInventoryItem(user_id,"gatilho",100) then
                                            TriggerClientEvent("fechar-nui-bratva",source)

                                            TriggerClientEvent("progress",source,10000,"Montando Advanced Rifle")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_ADVANCEDRIFLE",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Advanced Rifle</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Cartucho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>pacotes de mola</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>peça de arma</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "snspistol" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_SNSPISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 130 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 80 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 50 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 50 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",130) and vRP.tryGetInventoryItem(user_id,"placa-metal",80) and vRP.tryGetInventoryItem(user_id,"molas",50) and vRP.tryGetInventoryItem(user_id,"gatilho",50) then
                                            TriggerClientEvent("fechar-nui-bratva",source)

                                            TriggerClientEvent("progress",source,10000,"Montando SNS PISTOL")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_SNSPISTOL_MK2",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>SNS PISTOL</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Cartucho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>pacotes de mola</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>peça de arma</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "assaultsmg" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ASSAULTSMG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 210 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 120 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 100 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 100 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",210) and vRP.tryGetInventoryItem(user_id,"placa-metal",120) and vRP.tryGetInventoryItem(user_id,"molas",100) and vRP.tryGetInventoryItem(user_id,"gatilho",100) then
                                            TriggerClientEvent("fechar-nui-bratva",source)

                                            TriggerClientEvent("progress",source,10000,"Montando Assault-SMG")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_ASSAULTSMG",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Assault-SMG</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Cartucho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>pacotes de mola</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>peça de arma</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "weaponmg" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_MG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 240 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 130 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 70 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 70 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",240) and vRP.tryGetInventoryItem(user_id,"placa-metal",130) and vRP.tryGetInventoryItem(user_id,"molas",70) and vRP.tryGetInventoryItem(user_id,"gatilho",70) then
                                            TriggerClientEvent("fechar-nui-bratva-bratva",source)

                                            TriggerClientEvent("progress",source,10000,"Montando MG")
                                            TriggerClientEvent("bratva:posicao1",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_MG",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>MG</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Cartucho</b> na mochila.")
                                end
                                    else
                                    TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>pacote de molas</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>placa de metal</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem um <b>peça de arma</b> na mochila.")
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
    if vRP.hasPermission(user_id,"bratva.permissao") then
        return true
    end
end