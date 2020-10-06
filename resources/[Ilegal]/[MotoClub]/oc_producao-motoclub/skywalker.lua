local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-motoclub",oC)
-----------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local motoclub = {
	{ item = "m-ak47" },
	{ item = "m-advancedrifle" },
	{ item = "m-assaultsmg" },
    { item = "m-microsmg" },
    { item = "m-gusenberg" },
	{ item = "m-weaponmg" },
	{ item = "m-glock" },
    { item = "m-snspistol" },
    { item = "kevlar" },
	{ item = "colete" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-motoclub")
AddEventHandler("produzir-motoclub",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(motoclub) do
			if item == v.item then
				if item == "m-ak47" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_ASSAULTRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsulas") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 30 then  
                                if vRP.tryGetInventoryItem(user_id,"capsulas",30) and vRP.tryGetInventoryItem(user_id,"polvora",30) then
                                    TriggerClientEvent("fechar-nui-motoclub",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE AK47")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wammo|WEAPON_ASSAULTRIFLE_MK2",30)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições AK47</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "m-advancedrifle" then
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_ADVANCEDRIFLE") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"capsulas") >= 30 then
                                if vRP.getInventoryItemAmount(user_id,"polvora") >= 30 then  
                                    if vRP.tryGetInventoryItem(user_id,"capsulas",30) and vRP.tryGetInventoryItem(user_id,"polvora",30) then
                                        TriggerClientEvent("fechar-nui-motoclub",source)
    
                                        TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE AK47")
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
    
                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"wammo|WEAPON_ADVANCEDRIFLE",30)
                                            TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições Advanced Rifle</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Pólvoras</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end
                elseif item == "m-assaultsmg" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_ASSAULTSMG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsulas") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 20 then  
                                if vRP.tryGetInventoryItem(user_id,"capsulas",30) and vRP.tryGetInventoryItem(user_id,"polvora",20) then
                                    TriggerClientEvent("fechar-nui-motoclub",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE ASSAULTMG")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wammo|WEAPON_ASSAULTSMG",30)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições ASSAULTMG</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>20x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "m-microsmg" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_MICROSMG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsulas") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 20 then  
                                if vRP.tryGetInventoryItem(user_id,"capsulas",30) and vRP.tryGetInventoryItem(user_id,"polvora",20) then
                                    TriggerClientEvent("fechar-nui-motoclub",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE UZI")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wammo|WEAPON_MICROSMG",30)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições ASSAULTMG</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>20x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "m-gusenberg" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_GUSENBERG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsulas") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 15 then  
                                if vRP.tryGetInventoryItem(user_id,"capsulas",30) and vRP.tryGetInventoryItem(user_id,"polvora",15) then
                                    TriggerClientEvent("fechar-nui-motoclub",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE THOMPSHON")
                                    TriggerClientEvent("bancada-municoes:posicao",source)
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wammo|WEAPON_GUSENBERG",30)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições THOMPSON</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>15x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "m-weaponmg" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_MG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsulas") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 15 then  
                                if vRP.tryGetInventoryItem(user_id,"capsulas",30) and vRP.tryGetInventoryItem(user_id,"polvora",15) then
                                    TriggerClientEvent("fechar-nui-motoclub",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE MG")
                                    TriggerClientEvent("bancada-municoes:posicao",source)
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wammo|WEAPON_MG",30)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições THOMPSON</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>15x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "m-glock" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_COMBATPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsulas") >= 6 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 6 then  
                                if vRP.tryGetInventoryItem(user_id,"capsulas",6) and vRP.tryGetInventoryItem(user_id,"polvora",6) then
                                    TriggerClientEvent("fechar-nui-motoclub",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE GLOCK")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wammo|WEAPON_COMBATPISTOL",12)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições GLOCK</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>6x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>6x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "m-snspistol" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_SNSPISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsulas") >= 6 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 6 then  
                                if vRP.tryGetInventoryItem(user_id,"capsulas",6) and vRP.tryGetInventoryItem(user_id,"polvora",6) then
                                    TriggerClientEvent("fechar-nui-motoclub",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE SNS PISTOL")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"wammo|WEAPON_SNSPISTOL_MK2",12)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições SNS PISTOL</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>6x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>6x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "kevlar" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("kevlar") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"tecido") >= 5 then
                            if vRP.tryGetInventoryItem(user_id,"tecido",5) then
                                TriggerClientEvent("fechar-nui-motoclub",source)
                                TriggerClientEvent("progress",source,10000,"PRODUZINDO KEVLAR")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"kevlar",1)
                                    TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>KEVLAR</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>6x Tecidos</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "colete" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("colete") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"kevlar") >= 15 then  
                                if vRP.tryGetInventoryItem(user_id,"placa-metal",30) and vRP.tryGetInventoryItem(user_id,"kevlar",15) then
                                    TriggerClientEvent("fechar-nui-motoclub",source)

                                    TriggerClientEvent("progress",source,10000,"PRODUZINDO COLETE")
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"colete",1)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>COLETE</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Placa de Metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Kevlar</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
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
    if vRP.hasPermission(user_id,"mc.permissao") then
        return true
    end
end