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
cRP = {}
Tunnel.bindInterface("vrp_streetrace",cRP)
vCLIENT = Tunnel.getInterface("vrp_streetrace")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local race = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
local payments = {
	[1] = { 1000,2000 },
	[2] = { 2000,3000 },
	[3] = { 2000,3000 },
	[4] = { 1000,2000 },
	[5] = { 1000,2000 },
	[6] = { 1000,2000 },
	[7] = { 1000,2000 },
	[8] = { 1000,2000 },
	[9] = { 1000,2000 },
	[10] = { 1000,2000 },
	[11] = { 1000,2000 },
	[12] = { 1000,2000 },
	[13] = { 1000,2000 },
	[14] = { 1000,2000 },
	[15] = { 1000,2000 },
	[16] = { 1000,2000 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTRACE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkTicket()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"raceticket",1) then
			return true
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTRACE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startRace()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local copAmount = vRP.numPermission("bcso.permissao")
		for k,v in pairs(copAmount) do
			local player = vRP.getUserSource(parseInt(v))
			async(function()
				vRPclient.playSound(player,"Event_Message_Purple","GTAO_FM_Events_Soundset")
				TriggerClientEvent("Notify",player,"negado","Um <b>Corredor</b> foi avistado na cidade.",5000)
			end)
		end

		TriggerEvent("vrp_sysblips::Add",{ name = "Runner", src = source, color = 48 })

		return parseInt(race)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPRACE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.stopRace(plate)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("setRemoveEveryone",plate)
		TriggerEvent("vrp_sysblips::Remove",source)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANDOMPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		race = math.random(#payments)
		Citizen.Wait(5*60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod()
	local source = source
	local user_id = vRP.getUserId(source)
	local copAmount = vRP.numPermission("bcso.permissao")
	if user_id then
		vRP.wantedTimer(parseInt(user_id),300)
		TriggerEvent("vrp_sysblips::Remove",source)
		vRP.giveInventoryItem(user_id,"dinheiro-sujo",parseInt(math.random(payments[race][1],payments[race][2])+(500*#copAmount)))
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RUNNERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("runners",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"driftking.permissao") then
			if vRP.hasPermission(parseInt(args[1]),tostring("driftking.permissao")) then
				vRP.execute("vRP/del_group",{ user_id = parseInt(args[1]), permiss = tostring("driftking.permissao") })
				TriggerClientEvent("Notify",source,"negado","Removeu <b>"..parseInt(args[1]).."</b> da lista de corredores.",5000)
			else
				vRP.execute("vRP/add_group",{ user_id = parseInt(args[1]), permiss = tostring("driftking.permissao") })
				TriggerClientEvent("Notify",source,"sucesso","Adicionou <b>"..parseInt(args[1]).."</b> na lista de corredores.",5000)
			end
		end
	end
end)