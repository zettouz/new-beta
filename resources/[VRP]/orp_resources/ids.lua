-----------------------------------------------------------------------------------------------------------------------------------------
-- importa os Utils do VRP
-----------------------------------------------------------------------------------------------------------------------------------------	
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

-----------------------------------------------------------------------------------------------------------------------------------------
-- importa os Tunneis e Proxys
-----------------------------------------------------------------------------------------------------------------------------------------	
IDDclient = Tunnel.getInterface("vrp_id")
vRPclient = Tunnel.getInterface("vRP")
vRPidd = {}
Tunnel.bindInterface("vrp_id",vRPidd)
Proxy.addInterface("vrp_id",vRPidd)
vRP = Proxy.getInterface("vRP")
local blipsActive = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- Retorna a permissao pro client
-----------------------------------------------------------------------------------------------------------------------------------------	
function vRPidd.getPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"chat.permissao") then
		return true
	else
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Retorna o ID pro Client
-----------------------------------------------------------------------------------------------------------------------------------------	
function vRPidd.getId(sourceplayer)
	local user_id = vRP.getUserId(sourceplayer)
	return user_id
end

function vRPidd.getNome(sourceplayer)
	local user_id = vRP.getUserId(sourceplayer)
	local identity = vRP.getUserIdentity(user_id)
	return ""..identity.name.." "..identity.firstname..""
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Esconde os ids
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPidd.getUseBlip(sourceplayer)
	local user_id = vRP.getUserId(source)

	return blipsActive[user_id]
end	
function vRPidd.addUseBlip(sourceplayer)
	local source = source
	local user_id = vRP.getUserId(source)

	blipsActive[user_id] = true
	return user_id
end
function vRPidd.remUseBlip(sourceplayer)
	local source = source
	local user_id = vRP.getUserId(source)

	blipsActive[user_id] = false
	return user_id
end