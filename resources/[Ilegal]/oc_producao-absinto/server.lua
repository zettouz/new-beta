local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

farM = {}
Tunnel.bindInterface("oc_producao-absinto",farM)
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("proc-lQAbsinto")
AddEventHandler("proc-lQAbsinto", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("absinto-baixa") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"preabsinto-alta",1) then

            TriggerClientEvent("progress",source,2000,"Processando")
            TriggerClientEvent("absinto:posicao",source)
            TriggerClientEvent("emotes",source,"mecanico3")

            SetTimeout(2000,function()
                vRPclient._stopAnim(source,false)
                vRP.giveInventoryItem(user_id,"absinto-baixa",3)
                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Absinto de baixa qualidade</b>.")
            end)
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Pre-Absinto de alta qualidade</b> na mochila.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","<b>Inventário cheio</b>.")
    end
end)

RegisterServerEvent("proc-mQAbsinto")
AddEventHandler("proc-mQAbsinto", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("absinto-media") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"absinto-baixa",3) then
            
            TriggerClientEvent("progress",source,2000,"Processando")
            TriggerClientEvent("absinto:posicao",source)
            TriggerClientEvent("emotes",source,"mecanico3")

            SetTimeout(2000,function()
                vRPclient._stopAnim(source,false)
                vRP.giveInventoryItem(user_id,"absinto-media",2)
                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Absinto de média qualidade</b>.")
            end)
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Absinto de baixa qualidade</b> na mochila.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","<b>Inventário cheio</b>.")
    end
end)

RegisterServerEvent("proc-hQAbsinto")
AddEventHandler("proc-hQAbsinto", function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("absinto-alta") <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.tryGetInventoryItem(user_id,"absinto-media",2) then
            
            TriggerClientEvent("progress",source,2000,"Processando")
                    TriggerClientEvent("absinto:posicao",source)
                    TriggerClientEvent("emotes",source,"mecanico3")
    
            SetTimeout(2000,function()
                vRPclient._stopAnim(source,false)
                vRP.giveInventoryItem(user_id,"absinto-alta",1)
                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>Absinto de alta qualidade</b>.")
            end)
        else
            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Absinto de media qualidade</b> na mochila.")
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