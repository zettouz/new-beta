local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-vagos",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local vagos = {
	{ item = "pasta-alta" },
	{ item = "assaultsmg" },
	{ item = "advancedrifle" },
	{ item = "weaponmg" },
	{ item = "fiveseven" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-vagos")
AddEventHandler("produzir-vagos",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(vagos) do
			if item == v.item then
				if item == "advancedrifle" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ADVANCEDRIFLE") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 40 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 30 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 5 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",40) and vRP.tryGetInventoryItem(user_id,"placa-metal",30) and vRP.tryGetInventoryItem(user_id,"molas",5) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nui-vagos",source)

                                            TriggerClientEvent("progress",source,10000,"Montando Advanced Rifle")
                                            TriggerClientEvent("vagos:posicao1",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_mquerosene@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_ADVANCEDRIFLE",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Advanced Rifle</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>gatilho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>5x pacotes de mola</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>30x placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>peça de arma</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "pasta-alta" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pasta-alta") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"acido-sulfurico") >= 100 then
                            if vRP.getInventoryItemAmount(user_id,"folhas-coca") >= 100 then
                                if vRP.getInventoryItemAmount(user_id,"calcio-po") >= 100 then
                                    if vRP.getInventoryItemAmount(user_id,"querosene") >= 20 then
                                        if vRP.tryGetInventoryItem(user_id,"acido-sulfurico",100) and vRP.tryGetInventoryItem(user_id,"folhas-coca",100) and vRP.tryGetInventoryItem(user_id,"calcio-po",100) and vRP.tryGetInventoryItem(user_id,"querosene",20) then
                                            TriggerClientEvent("fechar-nui-vagos",source)

                                            TriggerClientEvent("progress",source,10000,"Montando Pasta de Alta")
                                            TriggerClientEvent("vagos:posicao1",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_mquerosene@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"pasta-alta",20)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Pasta de Alta</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Querosene</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Cálcio em Pó</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Folhas de Coca</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Ácido Sulfúrico</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "assaultsmg" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ASSAULTSMG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 20 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 20 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 10 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",20) and vRP.tryGetInventoryItem(user_id,"placa-metal",20) and vRP.tryGetInventoryItem(user_id,"molas",10) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nui-vagos",source)

                                            TriggerClientEvent("progress",source,10000,"Montando Assault-SMG")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_mquerosene@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_ASSAULTSMG",1)
                                                TriggerClientEvent("vagos:posicao1",source)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Assault-SMG</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>gatilho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>10x pacotes de mola</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>20x placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>peça de arma</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "gusenberg" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_MG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 25 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 5 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",25) and vRP.tryGetInventoryItem(user_id,"placa-metal",20) and vRP.tryGetInventoryItem(user_id,"molas",1) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nui-vagos-vagos",source)

                                            TriggerClientEvent("progress",source,10000,"Montando MG")
                                            TriggerClientEvent("vagos:posicao1",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_mquerosene@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_MG",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>MG</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>gatilho</b> na mochila.")
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
    if vRP.hasPermission(user_id,"vagos.permissao") then
        return true
    end
end