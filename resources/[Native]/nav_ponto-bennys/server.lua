local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Bennys = {}
Tunnel.bindInterface("nav_ponto-bennys",Bennys)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ WEBHOOK ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local BennysatePonto = "SEUWEBHOOK"
-----------------------------------------------------------------------------------------------------------------------------------------
--[ PONTO ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("entrar-servico-bennys")
AddEventHandler("entrar-servico-bennys",function()
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"mecanico.permissao") then
        TriggerClientEvent("Notify",source,"negado","Você já está em serviço.")
    else
        vRP.addUserGroup(user_id,"Mecanico")
        TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
        logEntradaServico()
    end
end)

RegisterServerEvent("sair-servico-bennys")
AddEventHandler("sair-servico-bennys",function()
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"paisana-mecanico.permissao") then
        TriggerClientEvent("Notify",source,"negado","Você já está fora de serviço.")
    else
        vRP.addUserGroup(user_id,"paisana-mecanico")
        TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
        logSaidaServico()
    end
end)

function logEntradaServico()
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    PerformHttpRequest(BennysatePonto, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." entrou em serviço.", description = "Registro de Ponto Bennys. Registro de entrada em serviço.\n⠀", thumbnail = {url = "https://i.imgur.com/g66oKjK.png"}, fields = {{ name = "**Nome do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ` " },{ name = "**Nº Passaporte:**", value = "` "..user_id.." `\n⠀" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/g66oKjK.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
end

function logSaidaServico()
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    PerformHttpRequest(BennysatePonto, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." saiu de serviço.", description = "Registro de Ponto Bennys. Registro de saída de serviço.\n⠀", thumbnail = {url = "https://i.imgur.com/g66oKjK.png"}, fields = {{ name = "**Nome do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ` " },{ name = "**Nº Passaporte:**", value = "` "..user_id.." `\n⠀" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/g66oKjK.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
end

function Bennys.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"mecanico.permissao") or vRP.hasPermission(user_id,"paisana-mecanico.permissao") then
        return true
	end
end