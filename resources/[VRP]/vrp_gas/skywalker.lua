local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
--------------------------------------------------------------------------------------------------------------------------------
--[ CONEXÕES ]------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
gaS = {}
Tunnel.bindInterface("vrp_gas",gaS)

function gaS.notRadiacao()
    local source = source
    local user_id = vRP.getUserId(source)

    TriggerClientEvent("Notify",source,"negado","Você entrou na área contaminada! Saia imediatamente.")
end