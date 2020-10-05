local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

farM = {}
Tunnel.bindInterface("oc_producao-maconha",farM)
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("proc-lQMaconha")
AddEventHandler("proc-lQMaconha", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("maconha-baixa") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"planta-alta",1) then

            TriggerClientEvent("progress",source,2000,"Processando")
            TriggerClientEvent("proc_maconha:posicao",source)
            TriggerClientEvent("emotes",source,"maconha")

            SetTimeout(2000,function()
                vRPclient._stopAnim(source,false)
                vRP.giveInventoryItem(user_id,"maconha-baixa",3)
                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Maconha de baixa qualidade</b>.")
            end)
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Planta de alta qualidade</b> na mochila.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","<b>Inventário cheio</b>.")
    end
end)

RegisterServerEvent("proc-mQMaconha")
AddEventHandler("proc-mQMaconha", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("maconha-media") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"maconha-baixa",3) then
            
            TriggerClientEvent("progress",source,2000,"Processando")
            TriggerClientEvent("proc_maconha:posicao",source)
            TriggerClientEvent("emotes",source,"maconha")

            SetTimeout(2000,function()
                vRPclient._stopAnim(source,false)
                vRP.giveInventoryItem(user_id,"maconha-media",2)
                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Maconha de média qualidade</b>.")
            end)
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Maconha de baixa qualidade</b> na mochila.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","<b>Inventário cheio</b>.")
    end
end)

RegisterServerEvent("proc-hQMaconha")
AddEventHandler("proc-hQMaconha", function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("maconha-alta") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"maconha-media",2) then
            
            TriggerClientEvent("progress",source,2000,"Processando")
                    TriggerClientEvent("proc_maconha:posicao",source)
                    TriggerClientEvent("emotes",source,"mecanico3")
    
            SetTimeout(2000,function()
                vRPclient._stopAnim(source,false)
                vRP.giveInventoryItem(user_id,"maconha-alta",1)
                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Maconha de alta qualidade</b>.")
            end)
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Maconha de media qualidade</b> na mochila.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","<b>Inventário cheio</b>.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function farM.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"ilegal.permissao") then
        return true
    end
end