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
				if item == "advancedrifle" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ADVANCEDRIFLE") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 40 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 30 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 5 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",40) and vRP.tryGetInventoryItem(user_id,"placa-metal",30) and vRP.tryGetInventoryItem(user_id,"molas",5) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nui-ballas",source)

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
                elseif item == "composito-alta" then
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
                elseif item == "assaultsmg" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ASSAULTSMG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 20 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 20 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 10 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",20) and vRP.tryGetInventoryItem(user_id,"placa-metal",20) and vRP.tryGetInventoryItem(user_id,"molas",10) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nui-ballas",source)

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
                                            TriggerClientEvent("fechar-nui-ballas-ballas",source)

                                            TriggerClientEvent("progress",source,10000,"Montando MG")
                                            TriggerClientEvent("ballas:posicao1",source)
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
    if vRP.hasPermission(user_id,"ballas.permissao") then
        return true
    end
end