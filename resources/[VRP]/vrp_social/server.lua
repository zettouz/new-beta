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
Tunnel.bindInterface("vrp_social",cRP)
vCLIENT = Tunnel.getInterface("vrp_social")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local twitter = {}
local police = {}
local paramedic = {}
local mechanic = {}
local taxi = {}
local anonymous = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTTWITTER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestTwitter()
	return twitter
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST911
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.request911()
	return police
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST112
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.request112()
	return paramedic
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMECHANIC
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestMechanic()
	return mechanic
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTTAXI
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestTaxi()
	return taxi
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTANONYMOUS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestAnonymous()
	return anonymous
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDTWITTER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.sendMessage(message,page)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local text = ""
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			if page == "Anonymous" then
				text = "<b>Desconhecido</b> <i>("..os.date("%H")..":"..os.date("%M")..")</i><b>:</b> "..message
			else
				text = "<b>"..identity.name.." "..identity.firstname.."</b> <i>("..os.date("%H")..":"..os.date("%M")..")</i><b>:</b> "..message
			end

			if page == "Twitter" then
				table.insert(twitter,{ text = text })
				vCLIENT.updateTablet(-1,"addTwitter",{ text = text })
				TriggerClientEvent("Notify",-1,"importante","Novo tweet de <b>"..identity.name.." "..identity.firstname.."</b>.",1000)
			elseif page == "911" then
				table.insert(police,{ text = text })
				vCLIENT.updateTablet(-1,"add911",{ text = text })
				sendMessages("bcso",identity.name,identity.firstname)
			elseif page == "112" then
				table.insert(paramedic,{ text = text })
				vCLIENT.updateTablet(-1,"add112",{ text = text })
				sendMessages("dmla",identity.name,identity.firstname)
			elseif page == "Mechanic" then
				table.insert(mechanic,{ text = text })
				vCLIENT.updateTablet(-1,"addMechanic",{ text = text })
				sendMessages("mecanico",identity.name,identity.firstname)
			elseif page == "Taxi" then
				table.insert(taxi,{ text = text })
				vCLIENT.updateTablet(-1,"addTaxi",{ text = text })
				sendMessages("Taxi",identity.name,identity.firstname)
			elseif page == "Anonymous" then
				table.insert(anonymous,{ text = text })
				vCLIENT.updateTablet(-1,"addAnonymous",{ text = text })
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDMESSAGES
-----------------------------------------------------------------------------------------------------------------------------------------
function sendMessages(permission,name,firstname)
	local consult = vRP.numPermission(permission)
	for k,v in pairs(consult) do
		local nSource = vRP.getUserSource(v)
		if nSource then
			async(function()
				TriggerClientEvent("Notify",nSource,"importante","Nova <b>"..permission.."</b> mensagem de <b>"..name.." "..firstname.."</b>.",1000)
			end)
		end
	end
end