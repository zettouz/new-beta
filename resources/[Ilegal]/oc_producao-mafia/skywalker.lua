local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-mafia",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local mafia = {
	{ item = "ak47" },
	{ item = "microsmg" },
	{ item = "gusenberg" },
	{ item = "combatpistol" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-mafia")
AddEventHandler("produzir-mafia",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(mafia) do
			if item == v.item then
				if item == "ak47" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ASSAULTRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 250 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 150 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 100 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 100 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",250) and vRP.tryGetInventoryItem(user_id,"placa-metal",150) and vRP.tryGetInventoryItem(user_id,"molas",100) and vRP.tryGetInventoryItem(user_id,"gatilho",100) then
                                            TriggerClientEvent("fechar-nui-mafia",source)

                                            TriggerClientEvent("progress",source,10000,"Montando AK47")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_ASSAULTRIFLE_MK2",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>AK47</b>.")
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
                elseif item == "combatpistol" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_COMBATPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 130 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 80 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 50 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 50 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",130) and vRP.tryGetInventoryItem(user_id,"placa-metal",80) and vRP.tryGetInventoryItem(user_id,"molas",50) and vRP.tryGetInventoryItem(user_id,"gatilho",50) then
                                            TriggerClientEvent("fechar-nui-mafia",source)

                                            TriggerClientEvent("progress",source,10000,"Montando Combat Pistol")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_COMBATPISTOL",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Combat Pistol</b>.")
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
                elseif item == "microsmg" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_MICROSMG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 180 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 120 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 100 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 100 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",180) and vRP.tryGetInventoryItem(user_id,"placa-metal",120) and vRP.tryGetInventoryItem(user_id,"molas",100) and vRP.tryGetInventoryItem(user_id,"gatilho",100) then
                                            TriggerClientEvent("fechar-nui-mafia",source)

                                            TriggerClientEvent("progress",source,10000,"Montando MICRO-UZI")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_MICROSMG",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>UZI</b>.")
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
                elseif item == "gusenberg" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_GUSENBERG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 200 then
                            if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 130 then
                                if vRP.getInventoryItemAmount(user_id,"molas") >= 70 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 70 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",200) and vRP.tryGetInventoryItem(user_id,"placa-metal",130) and vRP.tryGetInventoryItem(user_id,"molas",70) and vRP.tryGetInventoryItem(user_id,"gatilho",70) then
                                            TriggerClientEvent("fechar-nui-mafia-mafia",source)

                                            TriggerClientEvent("progress",source,10000,"Montando Guserberg")
                                            TriggerClientEvent("mafia:posicao1",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_GUSENBERG",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Gusenberg</b>.")
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
    if vRP.hasPermission(user_id,"mafia.permissao") then
        return true
    end
end