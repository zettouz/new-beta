local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("vrp_bonus",vRPN)
Proxy.addInterface("vrp_bonus",vRPN)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.Bonus()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserAptitudes(user_id)
		if data then
			return vRP.format(parseInt(data.creative.lixeiro)),vRP.format(parseInt(data.creative.pescador)),vRP.format(parseInt(data.creative.lenhador)),vRP.format(parseInt(data.creative.leiteiro)),vRP.format(parseInt(data.creative.minerador)),vRP.format(parseInt(data.creative.motorista)),vRP.format(parseInt(data.creative.caminhoneiro)),vRP.format(parseInt(data.creative.carteiro)),vRP.format(parseInt(data.creative.piloto)),vRP.format(parseInt(data.creative.policial)),vRP.format(parseInt(data.creative.paramedico)),vRP.format(parseInt(data.creative.cacador)),vRP.format(parseInt(data.creative.assassino)),vRP.format(parseInt(data.creative.contrabandista)),vRP.format(parseInt(data.creative.taxista)),vRP.format(parseInt(data.creative.mecanico)),vRP.format(parseInt(data.creative.corredor)),vRP.format(parseInt(data.creative.traficante)),vRP.format(parseInt(data.creative.transportador))
		end
	end
end