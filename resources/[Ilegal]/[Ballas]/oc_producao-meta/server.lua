local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

farM = {}
Tunnel.bindInterface("oc_producao-meta",farM)
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("proc-lQMeta")
AddEventHandler("proc-lQMeta", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("meta-baixa") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"composito-alta",1) then
            
            TriggerClientEvent("progress",source,2000,"Processando")
            TriggerClientEvent("proc_meta:posicao",source)
            TriggerClientEvent("emotes",source,"mecanico2")

            SetTimeout(2000,function()
                vRPclient._stopAnim(source,false)
                vRP.giveInventoryItem(user_id,"meta-baixa",3)
                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Metafetamina de baixa qualidade</b>.")
            end)
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Compósito de alta qualidade</b> na mochila.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","<b>Inventário cheio</b>.")
    end
end)

RegisterServerEvent("proc-mQMeta")
AddEventHandler("proc-mQMeta", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("meta-media") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"meta-baixa",3) then
            
            TriggerClientEvent("progress",source,2000,"Processando")
            TriggerClientEvent("proc_meta:posicao",source)
            TriggerClientEvent("emotes",source,"mecanico2")

            SetTimeout(2000,function()
                vRPclient._stopAnim(source,false)
                vRP.giveInventoryItem(user_id,"meta-media",2)
                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Metafetamina de média qualidade</b>.")
            end)
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>metanfetamina de baixa qualidade</b> na mochila.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","<b>Inventário cheio</b>.")
    end
end)

RegisterServerEvent("proc-hQMeta")
AddEventHandler("proc-hQMeta", function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("meta-alta") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"meta-media",2) then
            
            TriggerClientEvent("progress",source,2000,"Processando")
            TriggerClientEvent("proc_meta:posicao",source)
            TriggerClientEvent("emotes",source,"mecanico2")
    
            SetTimeout(2000,function()
                vRPclient._stopAnim(source,false)
                vRP.giveInventoryItem(user_id,"meta-alta",1)
                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Metafetamina de alta qualidade</b>.")
            end)
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>metanfetamina de media qualidade</b> na mochila.")
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
    if vRP.hasPermission(user_id,"ballas.permissao") then
        return true
    end
end