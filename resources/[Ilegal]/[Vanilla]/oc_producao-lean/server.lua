local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

farM = {}
Tunnel.bindInterface("oc_producao-lean",farM)
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("proc-lQLean")
AddEventHandler("proc-lQLean", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("lean-baixa") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"prelean-alta",1) then

            TriggerClientEvent("progress",source,2000,"Processando")
            TriggerClientEvent("proc_lean:posicao",source)
            TriggerClientEvent("emotes",source,"mecanico3")

            SetTimeout(2000,function()
                vRPclient._stopAnim(source,false)
                vRP.giveInventoryItem(user_id,"lean-baixa",3)
                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Lean de baixa qualidade</b>.")
            end)
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Pre-Lean de alta qualidade</b> na mochila.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","<b>Inventário cheio</b>.")
    end
end)

RegisterServerEvent("proc-mQLean")
AddEventHandler("proc-mQLean", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("lean-media") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"lean-baixa",3) then
            
            TriggerClientEvent("progress",source,2000,"Processando")
            TriggerClientEvent("proc_lean:posicao",source)
            TriggerClientEvent("emotes",source,"mecanico3")

            SetTimeout(2000,function()
                vRPclient._stopAnim(source,false)
                vRP.giveInventoryItem(user_id,"lean-media",2)
                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Lean de média qualidade</b>.")
            end)
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Lean de baixa qualidade</b> na mochila.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","<b>Inventário cheio</b>.")
    end
end)

RegisterServerEvent("proc-hQLean")
AddEventHandler("proc-hQLean", function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("lean-alta") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"lean-media",2) then
            
            TriggerClientEvent("progress",source,2000,"Processando")
                    TriggerClientEvent("proc_lean:posicao",source)
                    TriggerClientEvent("emotes",source,"mecanico3")
    
            SetTimeout(2000,function()
                vRPclient._stopAnim(source,false)
                vRP.giveInventoryItem(user_id,"lean-alta",1)
                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Lean de alta qualidade</b>.")
            end)
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Lean de media qualidade</b> na mochila.")
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