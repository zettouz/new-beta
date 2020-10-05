local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-dolls",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local dolls = {
    { item = "c4" },
    { item = "serra" },
    { item = "capuz" },
    { item = "algema" },
    { item = "c4b" },
    { item = "lockpick" },
	{ item = "furadeira" },
    { item = "masterpick" },
    { item = "keycard" },
	{ item = "pendrivebanco" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-dolls")
AddEventHandler("produzir-dolls",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(dolls) do
			if item == v.item then
				if item == "c4" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("c4") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"polvora") >= 70 then
                            if vRP.getInventoryItemAmount(user_id,"fita") >= 70 then
                                if vRP.getInventoryItemAmount(user_id,"fios") >= 70 then
                                    if vRP.getInventoryItemAmount(user_id,"controle") >= 70 then
                                        if vRP.tryGetInventoryItem(user_id,"polvora",70) and vRP.tryGetInventoryItem(user_id,"fita",70) and vRP.tryGetInventoryItem(user_id,"fios",70) and vRP.tryGetInventoryItem(user_id,"controle",70) then
                                            TriggerClientEvent("fechar-nui-dolls",source)

                                            TriggerClientEvent("progress",source,10000,"Montando C4")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"c4",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>C4</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Controle</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Fios</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Plastico</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Polvora</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "furadeira" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("furadeira") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"armacaodefuradeira") >= 25 then
                            if vRP.getInventoryItemAmount(user_id,"ferrob") >= 25 then
                                if vRP.getInventoryItemAmount(user_id,"broca") >= 25 then
                                    if vRP.tryGetInventoryItem(user_id,"armacaodefuradeira",25) and vRP.tryGetInventoryItem(user_id,"ferrob",25) and vRP.tryGetInventoryItem(user_id,"broca",25) then
                                        TriggerClientEvent("fechar-nui-dolls",source)
                                        TriggerClientEvent("progress",source,10000,"Montando Furadeira")
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"furadeira",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Furadeira</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Ferro</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Broca</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Armação de Furadeira</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "serra" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("serra") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"armacaodeserra") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"ferrob") >= 30 then
                                if vRP.getInventoryItemAmount(user_id,"disco") >= 30 then
                                    if vRP.tryGetInventoryItem(user_id,"armacaodeserra",30) and vRP.tryGetInventoryItem(user_id,"ferrob",30) and vRP.tryGetInventoryItem(user_id,"disco",30) then
                                        TriggerClientEvent("fechar-nui-dolls",source)
                                        TriggerClientEvent("progress",source,10000,"Montando Serra")
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"serra",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>SERRA</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Disco</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Ferro</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Armação de Serra</b> na mochila.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "capuz" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("capuz") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pano") >= 25 then
                            if vRP.getInventoryItemAmount(user_id,"corda") >= 25 then
                                if vRP.tryGetInventoryItem(user_id,"pano",25) and vRP.tryGetInventoryItem(user_id,"corda",25) then
                                    TriggerClientEvent("fechar-nui-dolls",source)
                                    TriggerClientEvent("progress",source,10000,"Montando Capuz")
                                    TriggerClientEvent("dolls:posicao1",source)
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"capuz",1)
                                        TriggerClientEvent("Notify",source,"sucesso","Você montou um <b>Capuz</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Corda</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Pano</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "algema" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("algema") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"ferrob") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"chave") >= 30 then
                                if vRP.tryGetInventoryItem(user_id,"ferrob",30) and vRP.tryGetInventoryItem(user_id,"chave",30) then
                                    TriggerClientEvent("fechar-nui-dolls",source)
                                    TriggerClientEvent("progress",source,10000,"Montando Algemas")
                                    TriggerClientEvent("dolls:posicao1",source)
                                    vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                    SetTimeout(10000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"algema",1)
                                        TriggerClientEvent("Notify",source,"sucesso","Você montou um <b>Algemas</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Chaves</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Ferro</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "c4b" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("c4b") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"polvora") >= 10 then
                            if vRP.getInventoryItemAmount(user_id,"fita") >= 10 then
                                if vRP.getInventoryItemAmount(user_id,"fios") >= 10 then
                                    if vRP.getInventoryItemAmount(user_id,"controle") >= 10 then
                                        if vRP.tryGetInventoryItem(user_id,"polvora",10) and vRP.tryGetInventoryItem(user_id,"fita",10) and vRP.tryGetInventoryItem(user_id,"fios",10) and vRP.tryGetInventoryItem(user_id,"controle",10) then
                                            TriggerClientEvent("fechar-nui-dolls",source)

                                            TriggerClientEvent("progress",source,10000,"Montando C4 Básica")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"c4b",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>C4 Básica</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Controle</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Fios</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Plastico</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você não tem <b>Polvora</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "lockpick" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("lockpick") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"ferrob") >= 40 then
                            if vRP.tryGetInventoryItem(user_id,"ferrob",40) then
                                TriggerClientEvent("fechar-nui-dolls",source)
                                TriggerClientEvent("progress",source,10000,"Montando Lockpick")
                                TriggerClientEvent("dolls:posicao1",source)
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"lockpick",1)
                                    TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Lockpick</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Ferro</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "masterpick" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("masterpick") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"ferrob") >= 100 then
                            if vRP.tryGetInventoryItem(user_id,"ferrob",100) then
                                TriggerClientEvent("fechar-nui-dolls",source)
                                TriggerClientEvent("progress",source,10000,"Montando Masterpick")
                                TriggerClientEvent("dolls:posicao1",source)
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"masterpick",1)
                                    TriggerClientEvent("Notify",source,"sucesso","Você montou um <b>Masterpick</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Ferro</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "keycard" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("keycard") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"keycard2") >= 40 then
                            if vRP.tryGetInventoryItem(user_id,"keycard2",40) then
                                TriggerClientEvent("fechar-nui-dolls",source)
                                TriggerClientEvent("progress",source,10000,"Montando Keycard")
                                TriggerClientEvent("dolls:posicao1",source)
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"keycard",1)
                                    TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Keycard</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Cartão Reutilizável</b>.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"sucesso","Espaço insuficiente na mochila.")
                    end
                elseif item == "pendrivebanco" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pendrivebanco") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pendrive2") >= 30 then
                            if vRP.tryGetInventoryItem(user_id,"pendrive2",30) then
                                TriggerClientEvent("fechar-nui-dolls",source)
                                TriggerClientEvent("progress",source,10000,"Montando Pendrive")
                                TriggerClientEvent("dolls:posicao1",source)
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"pendrivebanco",1)
                                    TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Pendrive</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"sucesso","Você precisa de <b>Pendrive Reutilizável</b>.")
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
    if vRP.hasPermission(user_id,"dolls.permissao") then
        return true
    end
end