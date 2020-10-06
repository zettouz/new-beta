local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("vrp_lavagem",emP)
local idgens = Tools.newIDGenerator()
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookyakuza = "SEUWEBHOOK"


function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR DINHEIRO SUJO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkDinheiro()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"dinheiro-sujo") >= 100000 and vRP.getInventoryItemAmount(user_id,"acessoalavagem") >= 1 then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente ou você não tem o item para Lavagem.") 
			return false
		end
	end
end

function emP.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
    local policia = vRP.getUsersByPermission("bcso.permissao")
    if user_id then
		if vRP.tryGetInventoryItem(user_id,"dinheiro-sujo",100000) and vRP.tryGetInventoryItem(user_id,"acessoalavagem",1) then
                vRP.giveMoney(user_id,parseInt(100000*("1.")))
            end
        end
    end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAMANDO POLICIA
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.lavagemPolicia(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policia = vRP.getUsersByPermission("bcso.permissao")
			TriggerClientEvent('iniciandolavagem',source,head,x,y,z)
			vRPclient._playAnim(source,false,{{"anim@heists@prison_heistig1_p1_guard_checks_bus","loop"}},true)
			local random = math.random(100)
			if random >= 50 then
				vRPclient.setStandBY(source,parseInt(60))
				for l,w in pairs(policia) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						async(function()
							local ids = idgens:gen()
							blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Ocorrencia",0.5,true)
							TriggerClientEvent('chatMessage',player,"911",{64,64,255},"^1Lavagem^0 de dinheiro em andamento.")
							SetTimeout(15000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
						end)
					end
				end
			end	
		end
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policia = vRP.getUsersByPermission("bcso.permissao")
		if #policia < 0 then
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
			return false
		end
	end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSÃO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"lavagem.permissao")
end

function emP.webhookyakuza ()
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	return SendWebhookMessage(webhookyakuza,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[QUANTIA]: 100.000 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
end