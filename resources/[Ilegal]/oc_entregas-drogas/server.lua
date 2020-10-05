local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

oC = {}
Tunnel.bindInterface("oc_entregas-drogas",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
local idgens = Tools.newIDGenerator()
local blips = {}

function oC.Quantidade()
	local source = source

	if quantidade[source] == nil then
	   quantidade[source] = math.random(1,1)	
	end

	TriggerClientEvent("quantidade-drogas",source,parseInt(quantidade[source]))
end

-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function oC.checkItens()
	oC.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		--if vRP.getInventoryItemAmount(user_id,"coca-alta") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"coca-media") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"coca-baixa") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"meta-alta") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"meta-media") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"meta-baixa") >= quantidade[source] then
		if vRP.getInventoryItemAmount(user_id,"coca-alta") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"meta-alta") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"maconha-alta") >= quantidade[source] then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..quantidade[source].."x porções da sua droga</b>.")		
		end
	end
end

function oC.chamarPoliciais()
    local source = source
    local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
    if user_id then
        local soldado = vRP.getUsersByPermission("bcso.permissao")
        for l,w in pairs(soldado) do
            local player = vRP.getUserSource(parseInt(w))
            if player then
                async(function()
                    local id = idgens:gen()
                    blips[id] = vRPclient.addBlip(player,x,y,z,10,84,"Ocorrência",0.5,false)
                    vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
                    TriggerClientEvent('chatMessage',player,"911",{64,64,255},"Recebemos uma denúncia de Tráfico, dirija-se até o local e intercepte o vendedor.")
                    SetTimeout(10000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
                end)
            end
        end
    end
end

function oC.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"coca-alta",quantidade[source]) then
			randmoney = ((3000)*quantidade[source])
			vRP.giveInventoryItem(user_id,"dinheiro-sujo",randmoney)
	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
	        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares em dinheiro sujo</b>.")
			quantidade[source] = nil
			oC.Quantidade()	
--		elseif vRP.tryGetInventoryItem(user_id,"coca-media",quantidade[source]) then
--			randmoney = ((900)*quantidade[source])
--			vRP.giveInventoryItem(user_id,"dinheiro-sujo",randmoney)
--	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
--	        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
--			quantidade[source] = nil
--			oC.Quantidade()
--		elseif vRP.tryGetInventoryItem(user_id,"coca-baixa",quantidade[source]) then
--			randmoney = ((600)*quantidade[source])
--			vRP.giveInventoryItem(user_id,"dinheiro-sujo",randmoney)
--	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
--	        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
--			quantidade[source] = nil
--			oC.Quantidade()
		elseif vRP.tryGetInventoryItem(user_id,"meta-alta",quantidade[source]) then
			randmoney = ((3000)*quantidade[source])
			vRP.giveInventoryItem(user_id,"dinheiro-sujo",randmoney)
	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
	        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
			quantidade[source] = nil
			oC.Quantidade()
--		elseif vRP.tryGetInventoryItem(user_id,"meta-media",quantidade[source]) then
--			randmoney = ((900)*quantidade[source])
--			vRP.giveInventoryItem(user_id,"dinheiro-sujo",randmoney)
--	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
--	        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
--			quantidade[source] = nil
--			oC.Quantidade()
--		elseif vRP.tryGetInventoryItem(user_id,"meta-baixa",quantidade[source]) then
--			randmoney = ((600)*quantidade[source])
--			vRP.giveInventoryItem(user_id,"dinheiro-sujo",randmoney)
--	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
--	        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
--			quantidade[source] = nil
--			oC.Quantidade()
		elseif vRP.tryGetInventoryItem(user_id,"maconha-alta",quantidade[source]) then
			randmoney = ((3000)*quantidade[source])
			vRP.giveInventoryItem(user_id,"dinheiro-sujo",randmoney)
			TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
			TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
			quantidade[source] = nil
			oC.Quantidade()
		end
	end
end

function oC.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
	--return vRP.hasPermission(user_id,"ilegal.permissao") or vRP.hasPermission(user_id,"bcso.permissao") or vRP.hasPermission(user_id,"mecanico.permissao")  or vRP.hasPermission(user_id,"paisana-mecanico.permissao") or vRP.hasPermission(user_id,"paisana-bcso.permissao") or vRP.hasPermission(user_id,"paisana-dmla.permissao") or vRP.hasPermission(user_id,"dmla.permissao")
	return vRP.hasPermission(user_id,"bcso.permissao") or vRP.hasPermission(user_id,"mecanico.permissao")  or vRP.hasPermission(user_id,"paisana-mecanico.permissao") or vRP.hasPermission(user_id,"paisana-bcso.permissao") or vRP.hasPermission(user_id,"paisana-dmla.permissao") or vRP.hasPermission(user_id,"dmla.permissao")
end
