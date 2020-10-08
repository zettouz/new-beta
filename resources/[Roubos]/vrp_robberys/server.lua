-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_robberys",src)
vCLIENT = Tunnel.getInterface("vrp_robberys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbery = false
local id = nil
local x = nil
local y = nil
local z = nil
local timedown = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookdepartamento = "COLOCA SEU WEBHOOK AQUI"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbers = {
	[1] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[2] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[3] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[4] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[5] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[6] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[7] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[8] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[9] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[10] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[11] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[12] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[13] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[14] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[15] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[16] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[17] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[18] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
	[19] = { ['place'] = "Loja de Departamento", ['seconds'] = 20, ['rewmin'] = 80000, ['rewmax'] = 145000 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policia = vRP.getUsersByPermission("policia.permissao")
		if #policia < 0 then
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
			return false
		elseif (os.time()-timedown) <= 20 then
			TriggerClientEvent("Notify",source,"aviso","Os cofres estão vazios, aguarde <b>"..vRP.format(parseInt((20-(os.time()-timedown)))).." segundos</b> até que os civis efetuem depositos.",8000)
			return false
		end
	end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startRobbery(robberyId,x,y,z,h)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		robbery = true
		id = robberyId
		x = x
		y = y 
		z = z
		vCLIENT.startRobbery(source,x,y,z,h)
	end
end


function src.grabMoney()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	timedown = os.time()
	vCLIENT.startGrab(source, robbers[id].seconds)
	vRPclient.playAnim(source,false,{{"anim@heists@ornate_bank@grab_cash_heels","grab",1}},true)
	TriggerClientEvent("vrp_sound:source",source,'alarm',0.7)
	-- vRPclient.setStandBY(source,parseInt(600))

	local policia = vRP.getUsersByPermission("policia.permissao")
	for k,v in pairs(policia) do
		local policial = vRP.getUserSource(v)
		if policial then
			async(function()
				vCLIENT.startRobberyPolice(policial,x,y,z,robbers[id].place)
				vRPclient.playSound(policial,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
				TriggerClientEvent('chatMessage',policial,"911",{64,64,255},"O roubo começou no ^1"..robbers[id].place.."^0, dirija-se até o local e intercepte os assaltantes.")
			end)
		end
	end
	local recompensa = parseInt(math.random(robbers[id].rewmin,robbers[id].rewmax))
	SendWebhookMessage(webhookdepartamento,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\n[Tipo]: Loja de Departamentos \n[Recebido]: $ "..vRP.format(parseInt(recompensa)).." Dinheiro Sujo\r```")
	SetTimeout(robbers[id].seconds*1000,function()
		if robbery then
			robbery = false
			vRP.searchTimer(user_id,1800)
			vRP.giveInventoryItem(user_id,"dinheiro-sujo",recompensa)
			TriggerClientEvent("Notify",source,"sucesso","Você recebeu $"..vRP.format(parseInt(recompensa)).." de Dinheiro Sujo.",8000)
			for k,v in pairs(policia) do
				local policial = vRP.getUserSource(v)
				if policial then
					async(function()
						vCLIENT.stopRobberyPolice(policial)
						TriggerClientEvent('chatMessage',policial,"911",{64,64,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
					end)
				end
			end
		end
	end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.stopRobbery()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if robbery then
			robbery = false
			id = nil
			x = nil
			y = nil 
			z = nil
			local policia = vRP.getUsersByPermission("policia.permissao")
			for k,v in pairs(policia) do
				local policial = vRP.getUserSource(v)
				if policial then
					async(function()
						vCLIENT.stopRobberyPolice(policial)
						TriggerClientEvent('chatMessage',policial,"911",{64,64,255},"O assaltante saiu correndo e deixou tudo para trás.")
					end)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return not (vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") or vRP.hasPermission(user_id,"paisanapolicia.permissao") or vRP.hasPermission(user_id,"paisanaparamedico.permissao"))
end

RegisterServerEvent("robberys:win")
AddEventHandler("robberys:win", function(job)
    local source = source
	local user_id = vRP.getUserId(source)
	TriggerClientEvent("Notify",source,"sucesso","Você conseguiu abrir o cofre!.",8000)
	src.grabMoney()
end)

RegisterServerEvent("robberys:lose")
AddEventHandler("robberys:lose", function(job)
    local source = source
	local user_id = vRP.getUserId(source)
	robbery = false
	id = nil
	x = nil
	y = nil 
	z = nil
	TriggerClientEvent("Notify",source,"aviso","Você não conseguiu abrir o cofre tente novamente!.",8000)
end)