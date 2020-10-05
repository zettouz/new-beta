local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Policia = {}
Tunnel.bindInterface("nav_uniforme-oc-coca",Policia)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ROUPAS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local coca = {
    [1885233650] = {
        [1] = { -1,0 }, -- Mascara
        [3] = { 15,0 }, -- Maos
        [4] = { 61,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 34,0 }, -- Sapato
        [7] = { 5,0 }, -- Acessorios			
        [8] = { 15,0 }, -- Blusa	
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 15,0 }, -- Jaqueta
        ["p0"] = { -1,0 }, -- Chapeu
    },
        [-1667301416] = {
            [1] = { -1,0 }, -- Mascara
            [3] = { 15,0 }, -- Maos
            [4] = { 14,8 }, -- Calça
            [5] = { -1,0,0 }, -- Mochila
            [6] = { 35,0 }, -- Sapato
            [7] = { 6,1 }, -- Acessorios	
            [8] = { 6,0 }, -- Blusa			
            [9] = { 0,0 }, -- Colete
            [10] = { -1,0 }, -- Adesivo
            [11] = { 18,0 }, -- Jaqueta
            ["p0"] = { -1,0 }, -- Chapeu

    }
}

RegisterServerEvent("coca")
AddEventHandler("coca",function()
    local user_id = vRP.getUserId(source)
    local custom = coca
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)


RegisterServerEvent("tirar-uniforme")
AddEventHandler("tirar-uniforme",function()
    local user_id = vRP.getUserId(source)
    vRP.removeCloak(source)
end)

function Policia.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"ilegal.permissao") then
        return true
	end
end