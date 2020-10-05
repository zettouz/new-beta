local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("vrp_races",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookcorrida = "SEUWEBHOOK"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local racePoint = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
local payments = {
	[1] = { 9000,14000 },
	[2] = { 12000,17000 },
	[3] = { 14000,19000 },
	[4] = { 6000,11000 },
	[5] = { 6000,11000 },
	[6] = { 9000,14000 },
	[7] = { 10000,15000 },
	[8] = { 10000,15000 },
	[9] = { 7000,12000 },
	[10] = { 7000,12000 },
	[11] = { 6000,11000 },
	[12] = { 6000,11000 },
	[13] = { 8000,13000 },
	[14] = { 9000,14000 },
	[15] = { 14000,19000 },
	[16] = { 12000,17000 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANDOMPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		racePoint = math.random(#payments)
		Citizen.Wait(5*60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETRACEPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.getRacepoint()
	return parseInt(racePoint)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTBOMBRACE
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.startRace()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.tryGetInventoryItem(user_id,"raceticket",1)
		TriggerEvent("eblips:add2",{ name = "Corredor", src = source, color = 2 })
		SendWebhookMessage(webhookcorrida,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKTICKET
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkTicket()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"raceticket") >= 1 then
			return true
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEBOMBRACE
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.removeRace(check,status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("eblips:remove",source)

		if status then
			vRP.wantedTimer(user_id,300)

				local result = math.random(payments[check][1],payments[check][2])
				vRP.giveInventoryItem(user_id,"dinheiro-sujo",parseInt(result))

				if vRP.tryGetInventoryItem(user_id,"energetic",1) then
					vRP.giveInventoryItem(user_id,"dinheiro-sujo",math.random(1000,1500))
				end
			end
		end
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEFUSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("defuse",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Policia") then
			local nplayer = vRPclient.getNearestPlayer(source,3)
			if nplayer then
				TriggerClientEvent("vrp_races:defuse",nplayer)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEFUSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("racenum",function(source,args,rawCommand)
	racePoint = parseInt(args[1])
end)