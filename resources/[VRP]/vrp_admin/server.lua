local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ WEBHOOK ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookadmin = "SEUWEBHOOK"
local logAdminItem = "SEUWEBHOOK"
local logAdminWhitelist = "SEUWEBHOOK"
local logAdminBans = "SEUWEBHOOK"
local logAdminKick = "SEUWEBHOOK"
local webhookfac = "SEUWEBHOOK"
local webhookkeys = "SEUWEBHOOK"
local webhookcds = "SEUWEBHOOK"
local webhookblacklist = "SEUWEBHOOK"
local webhookungroup = "SEUWEBHOOK"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

RegisterServerEvent("adminLogs:Armamentos")
AddEventHandler("adminLogs:Armamentos",function(weapon)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
    	SendWebhookMessage(webhookblacklist,"```prolog\n[BLACKLIST ARMAS]: "..user_id.." " .. "\n[ARMA]: " .. weapon ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```<&692696213283405927>")  
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR COLOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('carcolor',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"mindmaster.permissao") then
        local vehicle = vRPclient.getNearestVehicle(source,7)
        if vehicle then
            local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
            rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
            local r,g,b = table.unpack(splitString(rgb," "))
            TriggerClientEvent('vcolorv',source,vehicle,tonumber(r),tonumber(g),tonumber(b))
            TriggerClientEvent('Notify',source,"sucesso","Cor Alterada")
        end
    end
end) 
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TPTOWAY
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tptoway',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nuser_id = vRP.getUserSource(parseInt(args[1]))
    if vRP.hasPermission(user_id,"chat.permissao") then
        TriggerClientEvent('tptoway',nuser_id)
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- STATUS
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('status',function(source,args,rawCommand)
    local onlinePlayers = GetNumPlayerIndices()
    local policia = vRP.getUsersByPermission("bcso.permissao")
    local paramedico = vRP.getUsersByPermission("dmla.permissao")
	local mec = vRP.getUsersByPermission("mecanico.permissao")
	local staff = vRP.getUsersByPermission("chat.permissao")
	--local ilegal = vRP.getUsersByPermission("ilegal.permissao")
	local user_id = vRP.getUserId(source)        
		TriggerClientEvent("Notify",source,"importante","<bold><b>Jogadores</b>: <b>"..onlinePlayers.."<br>Administração</b>: <b>"..#staff.."<br>Policiais</b>: <b>"..#policia.."<br>Paramédicos</b>: <b>"..#paramedico.."<br>Mecânicos</b>: <b>"..#mec.."</b></bold>",9000)
	end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VROUPAS ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local player_customs = {}
RegisterCommand('vroupas',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local custom = vRPclient.getCustomization(source)
	
    if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"helper.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"chat.permissao") then
        if player_customs[source] then
            player_customs[source] = nil
            vRPclient._removeDiv(source,"customization")
        else 
			local content = ""
			
            for k,v in pairs(custom) do
                content = content..k.." => "..json.encode(v).."<br/>" 
            end

            player_customs[source] = true
            vRPclient._setDiv(source,"customization",".div_customization{ margin: auto; padding: 4px; width: 250px; margin-top: 200px; margin-right: 50px; background: rgba(15,15,15,0.7); color: #ffff; font-weight: bold; }",content)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BLIPS ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if first_spawn then
        blips[source] = { source }
       TriggerClientEvent("blips:updateBlips",-1,blips)
        if vRP.hasPermission(user_id,"blips.permissao") then
            TriggerClientEvent("blips:adminStart",source)
        end
     end
 end)

AddEventHandler("playerDropped",function()
	if blips[source] then
		blips[source] = nil
		TriggerClientEvent("blips:updateBlips",-1,blips)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARSENAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('a',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if user_id then
		if args[1] == "kit" and vRP.hasPermission(user_id,"mindmaster.permissao") then
			vRPclient.giveWeapons(source,{["WEAPON_STUNGUN"] = { ammo = 0 }})
			vRPclient.giveWeapons(source,{["WEAPON_NIGHTSTICK"] = { ammo = 0 }})
			vRPclient.giveWeapons(source,{["WEAPON_FLASHLIGHT"] = { ammo = 0 }})
			vRPclient.giveWeapons(source,{["WEAPON_BAT"] = { ammo = 0 }})
			vRPclient.giveWeapons(source,{["WEAPON_FIREWORK"] = { ammo = 100 }})
			vRPclient.setArmour(source,100)
	elseif args[1] == "colete" and vRP.hasPermission(user_id,"mindmaster.permissao") then
		vRPclient.setArmour(source,100)
		elseif args[1] == "limpar" and vRP.hasPermission(user_id,"mindmaster.permissao") then
			vRPclient.giveWeapons(source,{},true)
			vRPclient.setArmour(source,0)
		--elseif vRP.hasPermission(user_id,"bcso.permissao") then
			TriggerClientEvent("Notify",source,"negado","Armamento não encontrado.")
			TriggerEvent("webhook:enviarlogcolete", "Comando - A KIT ", "ID "..user_id.." usou o comando /A KIT "..rawCommand:sub(4)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
		end
	end
end)

RegisterServerEvent("webhook:enviarlogcolete") --ENVIA O LOG DO GOD PARA O DISCORD
AddEventHandler("webhook:enviarlogcolete",function(name,message)
    if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
    PerformHttpRequest('SEUWEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ESTOQUE ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('estoque',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"mindmaster.permissao") then
        if args[1] and args[2] then
            vRP.execute("creative/set_estoque",{ vehicle = args[1], quantidade = args[2] })
            TriggerClientEvent("Notify",source,"sucesso","Você colocou mais <b>"..args[2].."</b> no estoque, para o carro <b>"..args[1].."</b>.") 
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USER VEHS [ADMIN]
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('uservehs',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"chat.permissao") then
        	local nuser_id = parseInt(args[1])
            if nuser_id > 0 then 
                local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(nuser_id) })
                local car_names = {}
                for k,v in pairs(vehicle) do
                	table.insert(car_names, "<b>" .. vRP.vehicleName(v.vehicle) .. "</b>")
                    --TriggerClientEvent("Notify",source,"importante","<b>Modelo:</b> "..v.vehicle,10000)
                end
                car_names = table.concat(car_names, ", ")
                local identity = vRP.getUserIdentity(nuser_id)
                TriggerClientEvent("Notify",source,"importante","Veículos de <b>"..identity.name.." " .. identity.firstname.. " ("..#vehicle..")</b>: "..car_names,10000)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ADICIONAR CARRO ]--------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserId(parseInt(args[2]))
    if vRP.hasPermission(user_id,"mindmaster.permissao") then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nplayer)
            local identity = vRP.getUserIdentity(user_id)
            local identitynu = vRP.getUserIdentity(nuser_id)
            vRP.execute("creative/add_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time()) })
            TriggerClientEvent("Notify",source,"sucesso","Você adicionou o veículo <b>"..args[1].."</b> para o Passaporte: <b>"..parseInt(args[2]).."</b>.") 
			
			local nomeCar = args[1]
			local quantCar = parseInt(args[2])

			PerformHttpRequest(logAdminItem, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "REGISTRO DE ESTOQUE:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
						thumbnail = {
						url = "https://i.imgur.com/IP2d2mU.png"
						}, 
						fields = {
							{ 
								name = "**Quem adicionou:**", 
								value = "` "..identity.name.." "..identity.firstname.." ` "
							},
							{ 
								name = "**Nº de Passaporte:**", 
								value = "` "..user_id.." ` "
							},
							{ 
								name = "**Carro adicionado:**", 
								value = "` "..nomeCar.." ` "
							},
							{ 
								name = "**Quantidade adicionada:**", 
								value = "` "..quantCar.." `\n⠀"
							}
						}, 
						footer = { 
							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
							icon_url = "https://i.imgur.com/IP2d2mU.png" 
						},
						color = 15914080 
					}
				}
			}), { ['Content-Type'] = 'application/json' })
			

        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ REMOVER CARRO ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('remcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserId(parseInt(args[2]))
    if vRP.hasPermission(user_id,"mindmaster.permissao") then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nplayer)
            local identity = vRP.getUserIdentity(user_id)
            local identitynu = vRP.getUserIdentity(nuser_id)
            vRP.execute("creative/rem_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time())  }) 
            TriggerClientEvent("Notify",source,"sucesso","Você removeu o veículo <b>"..args[1].."</b> do Passaporte: <b>"..parseInt(args[2]).."</b>.") 
			
			local nomeCar = args[1]
			local quantCar = parseInt(args[2])

			PerformHttpRequest(logAdminItem, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "REGISTRO DE ESTOQUE:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
						thumbnail = {
						url = "https://i.imgur.com/IP2d2mU.png"
						}, 
						fields = {
							{ 
								name = "**Quem removeu:**", 
								value = "` "..identity.name.." "..identity.firstname.." ` "
							},
							{ 
								name = "**Nº de Passaporte:**", 
								value = "` "..user_id.." ` "
							},
							{ 
								name = "**Carro removido:**", 
								value = "` "..nomeCar.." ` "
							},
							{ 
								name = "**Quantidade removida:**", 
								value = "` "..quantCar.." `\n⠀"
							}
						}, 
						footer = { 
							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
							icon_url = "https://i.imgur.com/IP2d2mU.png" 
						},
						color = 15914080 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ UNCUFF ]------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('uncuff',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
			TriggerClientEvent("admcuff",source)
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ SYNCAREA ]----------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limpararea',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if vRP.hasPermission(user_id,"chat.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
        TriggerClientEvent("syncarea",-1,x,y,z)
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ LIMPAR ARMAS ]------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('removearmas',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"mindmaster.permissao") then
        local users = vRP.getUsers()
        for k,v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
                TriggerClientEvent('limparArmas',id)
                print(id)
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ APAGAO ]------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('apagao',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id,"mindmaster.permissao") and args[1] ~= nil then
            local cond = tonumber(args[1])
            --TriggerEvent("cloud:setApagao",cond)
            TriggerClientEvent("cloud:setApagao",-1,cond)                    
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ RAIOS ]-------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('raios', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id,"mindmaster.permissao") and args[1] ~= nil then
            local vezes = tonumber(args[1])
            TriggerClientEvent("cloud:raios",-1,vezes)           
        end
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ TROCAR SEXO ]--------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('skin',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
        if parseInt(args[1]) then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("skinmenu",nplayer,args[2])
                TriggerClientEvent("Notify",source,"sucesso","Você setou a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.")
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ DEBUG ]-------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('debug',function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
			TriggerClientEvent("ToggleDebug",player)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRYDELETEOBJ ]-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj",function(index)
    TriggerClientEvent("syncdeleteobj",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FIX ]--------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fix',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local vehicle = vRPclient.getNearestVehicle(source,11)
	if vehicle then
		if vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
			TriggerClientEvent('reparar',source)
			TriggerEvent("webhook:enviarlogfix", "Comando - Fix ", "ID "..user_id.." usou /FIX "..rawCommand:sub(4)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
		end
	end
end)

RegisterServerEvent("webhook:enviarlogfix") --ENVIA O LOG DO FIX PARA O DISCORD
AddEventHandler("webhook:enviarlogfix",function(name,message)
if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
PerformHttpRequest('SEUWEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MATAR ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('matar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.killGod(nplayer)
				vRPclient.setHealth(nplayer,0)
				
                TriggerClientEvent("resetBleeding",nplayer)
				TriggerClientEvent("resetDiagnostic",nplayer)

				vRP.varyThirst(nplayer,-15)
				vRP.varyHunger(nplayer,-15)
            end
        else
            vRPclient.killGod(source)
			vRPclient.setHealth(source,0)

			vRP.varyThirst(source,-100)
			vRP.varyHunger(source,-100)

            TriggerClientEvent("resetBleeding",source)
			TriggerClientEvent("resetDiagnostic",source)
			TriggerEvent("webhook:enviarlogmatar", "Comando - Matar ", "ID "..user_id.." usou /MATAR "..rawCommand:sub(4)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
        end
    end
end)
RegisterServerEvent("webhook:enviarlogmatar") --ENVIA O LOG DO FIX PARA O DISCORD
AddEventHandler("webhook:enviarlogmatar",function(name,message)
if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
PerformHttpRequest('SEUWEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limparea',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent("syncarea",-1,x,y,z)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ GOD ]--------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('god',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.killGod(nplayer)
				vRPclient.setHealth(nplayer,400)
				vRPclient.setArmour(nplayer,100)
				
                TriggerClientEvent("resetBleeding",nplayer)
				TriggerClientEvent("resetDiagnostic",nplayer)

				vRP.varyThirst(nplayer,-15)
				vRP.varyHunger(nplayer,-15)
            end
        else
            vRPclient.killGod(source)
			vRPclient.setHealth(source,400)
			vRPclient.setArmour(source,100)

			vRP.varyThirst(source,-100)
			vRP.varyHunger(source,-100)

            TriggerClientEvent("resetBleeding",source)
			TriggerClientEvent("resetDiagnostic",source)
			TriggerEvent("webhook:enviarloggod", "Comando - God ", "ID "..user_id.." usou /GOD "..rawCommand:sub(4)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
        end
    end
end)

RegisterServerEvent("webhook:enviarloggod") --ENVIA O LOG DO GOD PARA O DISCORD
AddEventHandler("webhook:enviarloggod",function(name,message)
    if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
    PerformHttpRequest('SEUWEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VIDA ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('vida',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local vida = vRPclient.getHealth(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		local nplayer = vRP.getUserSource(parseInt(args[1]))
		if args[1] then
			vRPclient.killGod(source)
			vRPclient.setHealth(source,args[1])
			TriggerClientEvent("resetBleeding",source)
            TriggerClientEvent("resetDiagnostic",source)	
			TriggerClientEvent("Notify",source,"sucesso","Você está com <b>"..args[1].."</b> de vida.")
		else
			TriggerClientEvent("Notify",source,"sucesso","Você está com <b>"..vida.."</b> de vida.")
		end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPARBOLSA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limparbolsa',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao")  then
		if args[1] then
			local tuser_id = tonumber(args[1])
			local tplayer = vRP.getUserSource(tonumber(tuser_id))
			local tplayerID = vRP.getUserId (tonumber(tplayer))
				if tplayerID ~= nil then
				local identity = vRP.getUserIdentity(user_id)
					vRP.clearInventory(tuser_id)
					TriggerClientEvent("Notify",source,"sucesso","Limpou inventario do <id>"..args[1].."</b>.")
				else
					TriggerClientEvent("Notify",source,"negado","O usuário não foi encontrado ou está offline.")
			end
		else
			vRP.clearInventory(user_id)
			TriggerClientEvent("Notify",source,"sucesso","Você limpou seu inventário.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ GOD ALL ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('godall',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"mindmaster.permissao") then
    	local users = vRP.getUsers()
        for k,v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
            	vRPclient.killGod(id)
				vRPclient.setHealth(id,400)
				print(id)
				TriggerEvent("webhook:enviargodall", "Comando - Curar ", "ID "..user_id.." usou /CURAR "..rawCommand:sub(4)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
            end
        end
    end
end)

RegisterServerEvent("webhook:enviargodall") --ENVIA O LOG DO GOD PARA O DISCORD
AddEventHandler("webhook:enviargodall",function(name,message)
    if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
    PerformHttpRequest('SEUWEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ COLETE ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('armor',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mindmaster.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.setArmour(nplayer,100)
			end
		else
			vRPclient.setArmour(source,100)
			TriggerEvent("webhook:enviarlogcolete", "Comando - Colete ", "ID "..user_id.." usou o comando /ARMOR "..rawCommand:sub(4)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
		end
	end
end)

RegisterServerEvent("webhook:enviarlogcolete") --ENVIA O LOG DO GOD PARA O DISCORD
AddEventHandler("webhook:enviarlogcolete",function(name,message)
    if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
    PerformHttpRequest('SEUWEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CURAR ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('curar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        local oplayer = vRPclient.getNearestPlayer(source,5)
        local nuser_id = vRP.getUserId(oplayer)
        local identidade = vRP.getUserIdentity(user_id)
        if oplayer~=nil then
            TriggerClientEvent("Notify",source,"importante","Você curou um player próximo | ID: "..nuser_id.."")
            TriggerClientEvent("Notify",oplayer,"importante","Você foi curado por: "..identidade.name.." "..identidade.firstname.."")
            vRPclient.killGod(oplayer)
            vRPclient.setHealth(oplayer,300)
			--vRPclient.setArmour(oplayer,0)    
			TriggerEvent("webhook:enviarlogcurar", "Comando - CURAR ", "ID "..user_id.." usou o comando /CURAR "..rawCommand:sub(4)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
			TriggerClientEvent("resetBleeding",oplayer)
        else
            TriggerClientEvent("Notify",source,"importante","Não há ninguém próximo.")
        end
    end
end)

RegisterServerEvent("webhook:enviarlogcurar") --ENVIA O LOG DO GOD PARA O DISCORD
AddEventHandler("webhook:enviarlogcurar",function(name,message)
    if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
    PerformHttpRequest('SEUWEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNAR ARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
local qtdAmmunition = 250
local itemlist = {
    ["WEAPON_PISTOL_MK2"] = { arg = "fiveseven" },
    ["WEAPON_ASSAULTSMG"] = { arg = "ar" },
    ["WEAPON_ASSAULTRIFLE"] = { arg = "ak103" }
}

RegisterCommand('arma',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"mindmaster.permissao") then
        if args[1] then
            for k,v in pairs(itemlist) do
                if v.arg == args[1] then
                    result = k
                    vRPclient.giveWeapons(source,{[result] = { ammo = qtdAmmunition }})
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ADM FUEL ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('admfuel',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"mindmaster.permissao") then
			TriggerClientEvent("admfuel",source)
		end	
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ HASH ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hash',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mindmaster.permissao") then
		TriggerClientEvent('vehash',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TUNING ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tunar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mindmaster.permissao") then
		TriggerClientEvent('vehtuning',source)
		TriggerEvent("webhook:enviarlogtuning", "Comando - Tunar ", "ID "..user_id.." usou o comando /Tunar "..rawCommand:sub(4)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
	end
end)

RegisterServerEvent("webhook:enviarlogtuning") --ENVIA O LOG DO GOD PARA O DISCORD
AddEventHandler("webhook:enviarlogtuning",function(name,message)
    if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
    PerformHttpRequest('SEUWEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ WL ]---------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wl',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"chat.permissao")  or vRP.hasPermission(user_id,"helper.permissao") or vRP.hasPermission(user_id,"aprovador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
        if args[1] then
            vRP.setWhitelisted(parseInt(args[1]),true)
            TriggerClientEvent("Notify",source,"sucesso","Você aprovou o passaporte <b>"..args[1].."</b> na whitelist.")
			
			local idwhite = parseInt(args[1])

			PerformHttpRequest(logAdminWhitelist, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "REGISTRO DE WHITELIST:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
						thumbnail = {
						url = "https://i.imgur.com/IP2d2mU.png"
						}, 
						fields = {
							{ 
								name = "**Quem adicionou:**", 
								value = "` "..identity.name.." "..identity.firstname.." ` "
							},
							{ 
								name = "**Nº de Passaporte:**", 
								value = "` "..user_id.." ` "
							},
							{ 
								name = "**ID adicionado a Whitelist:**", 
								value = "` "..idwhite.." ` "
							}
						}, 
						footer = { 
							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
							icon_url = "https://i.imgur.com/IP2d2mU.png"
						},
						color = 15914080 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ UNWL ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unwl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]),false)
			TriggerClientEvent("Notify",source,"sucesso","Você retirou o passaporte <b>"..args[1].."</b> da whitelist.")
			
			local idwhite = parseInt(args[1])

			PerformHttpRequest(logAdminWhitelist, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "REGISTRO DE WHITELIST:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
						thumbnail = {
						url = "https://i.imgur.com/IP2d2mU.png"
						}, 
						fields = {
							{ 
								name = "**Quem removeu:**", 
								value = "` "..identity.name.." "..identity.firstname.." ` "
							},
							{ 
								name = "**Nº de Passaporte:**", 
								value = "` "..user_id.." ` "
							},
							{ 
								name = "**ID removido da Whitelist:**", 
								value = "` "..idwhite.." ` "
							}
						}, 
						footer = { 
							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
							icon_url = "https://i.imgur.com/IP2d2mU.png" 
						},
						color = 15914080 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ KICK ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kick',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]))
			if id then
				vRP.kick(id,"Você foi expulso da cidade.")
				TriggerClientEvent("Notify",source,"sucesso","Você kickou o passaporte <b>"..args[1].."</b> da cidade.")
				
				local kikado = parseInt(args[1])

				PerformHttpRequest(logAdminKick, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 
							title = "REGISTRO DE KICKS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
							thumbnail = {
							url = "https://i.imgur.com/IP2d2mU.png"
							}, 
							fields = {
								{ 
									name = "**Quem kickou:**", 
									value = "` "..identity.name.." "..identity.firstname.." ` "
								},
								{ 
									name = "**Nº de Passaporte:**", 
									value = "` "..user_id.." ` "
								},
								{ 
									name = "**ID que foi kickado:**", 
									value = "` "..kikado.." ` "
								}
							}, 
							footer = { 
								text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
								icon_url = "https://i.imgur.com/IP2d2mU.png" 
							},
							color = 15914080 
						}
					}
				}), { ['Content-Type'] = 'application/json' })

			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ KICK ALL ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kickall',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
        local users = vRP.getUsers()
        for k,v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
				vRP.kick(id,"Você foi vitima do terremoto.")
					TriggerEvent("webhook:enviarlogkickall", "Comando - Kickall ", "ID "..user_id.." KICKOU TODOS DO SERVIDOR! "..rawCommand:sub(4)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
            end
        end
    end
end)

RegisterServerEvent("webhook:enviarlogkickall") --ENVIA O LOG DO GOD PARA O DISCORD
AddEventHandler("webhook:enviarlogkickall",function(name,message)
    if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
    PerformHttpRequest('SEUWEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BAN ]--------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
		if args[1] then

			local t_user_id = vRP.getUserSource(parseInt(args[1]))

			vRP.setBanned(parseInt(args[1]),true)
			vRP.kick(t_user_id,"Você foi banido! [ Mais informações em: discord.gg/Kd8uuRs ]")
			TriggerClientEvent("Notify",source,"sucesso","Você baniu o passaporte <b>"..args[1].."</b> da cidade.")

			 PerformHttpRequest(logAdminBans, function(err, text, headers) end, 'POST', json.encode({
			 	embeds = {
			 		{ 
			 			title = "REGISTRO DE BANIMENTO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			 			thumbnail = {
			 			url = "https://i.imgur.com/IP2d2mU.png"
			 			}, 
			 			fields = {
			 				{ 
			 					name = "**QUEM FOI BANIDO:**", 
			 					value = "` ["..t_user_id.."] `"
			 				},
			 				{ 
			 					name = "**QUEM BANIU:**", 
			 					value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `"
			 				}
			 			}, 
			 			footer = { 
			 				text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
			 				icon_url = "https://i.imgur.com/IP2d2mU.png" 
			 			},
			 			color = 15914080 
			 		}
			 	}
			 }), { ['Content-Type'] = 'application/json' })

		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ UNBAN ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
		if args[1] then
			vRP.setBanned(parseInt(args[1]),false)
			TriggerClientEvent("Notify",source,"sucesso","Você desbaniu o passaporte <b>"..args[1].."</b> da cidade.")
			SendWebhookMessage(logAdminBans,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DESBANIU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MONEY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('money',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
		if args[1] then
			vRP.giveMoney(user_id,parseInt(args[1]))
			SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FEZ]: $"..vRP.format(parseInt(args[1])).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ NC ]---------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('nc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
		vRPclient.toggleNoclip(source)
		TriggerEvent("webhook:enviarlognoclip", "Comando - Noclip ", "ID "..user_id.." usou o comando /NC "..rawCommand:sub(4)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
	end
end)

RegisterServerEvent("webhook:enviarlognoclip") --ENVIA O LOG DO NC PARA O DISCORD
AddEventHandler("webhook:enviarlognoclip",function(name,message)
    if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
    PerformHttpRequest('SEUWEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TPCDS ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
		local fcoords = vRP.prompt(source,"Cordenadas:","")
		if fcoords == "" then
			return
		end
		local coords = {}
		for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
			table.insert(coords,parseInt(coord))
		end
		vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Toggle Admin
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('admin',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
		vRP.removeUserGroup(user_id,"admin")
		vRP.addUserGroup(user_id,"adminoff")
	elseif vRP.hasPermission(user_id,"adminoff.permissao") then
		vRP.removeUserGroup(user_id,"adminoff")
		vRP.addUserGroup(user_id,"admin")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ COORDENADAS ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		heading = GetEntityHeading(GetPlayerPed(-1))
		vRP.prompt(source,"Cordenadas:","['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z))
	end
end)

RegisterCommand('cds2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		vRP.prompt(source,"Cordenadas:",tD(x)..","..tD(y)..","..tD(z))
	end
end)

RegisterCommand('cds3',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		vRP.prompt(source,"Cordenadas:","{x="..tD(x)..", y="..tD(y)..", z="..tD(z).."},")
	end
end)

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ GROUP ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('group',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
		if args[1] and args[2] then
			vRP.addUserGroup(parseInt(args[1]),args[2])
			TriggerClientEvent("Notify",source,"sucesso","Você setou o passaporte <b>"..parseInt(args[1]).."</b> no grupo <b>"..args[2].."</b>.")
			SendWebhookMessage(webhookungroup,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]: "..args[1].." \n[GRUPO]: "..args[2].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ UNGROUP ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ungroup',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
		if args[1] and args[2] then
			vRP.removeUserGroup(parseInt(args[1]),args[2])
			TriggerClientEvent("Notify",source,"sucesso","Você removeu o passaporte <b>"..parseInt(args[1]).."</b> do grupo <b>"..args[2].."</b>.")
				SendWebhookMessage(webhookungroup,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..args[1].." \n[GRUPO]: "..args[2].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- [ TPALL ] ----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if vRP.hasPermission(user_id,"mindmaster.permissao") then
        local rusers = vRP.getUsers()
        for k,v in pairs(rusers) do
            local rsource = vRP.getUserSource(k)
            if rsource ~= source then
                vRPclient.teleport(rsource,x,y,z)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TPTOME ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tptome',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			local x,y,z = vRPclient.getPosition(source)
			if tplayer then
				vRPclient.teleport(tplayer,x,y,z)
				TriggerEvent("webhook:enviarlogtp", "Comando - Tptome ", "ID "..user_id.." puxou jogador "..args[1].."")
			end
		end
	end
end)

RegisterServerEvent("webhook:enviarlogtp") --ENVIA O LOG DO TP PARA O DISCORD
AddEventHandler("webhook:enviarlogtp",function(name,message)
    if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
    PerformHttpRequest('SEUWEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TPTO ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpto',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"chat.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			if tplayer then
				vRPclient.teleport(source,vRPclient.getPosition(tplayer))
				TriggerEvent("webhook:enviarlogtpto", "Comando - Tpto ", "ID "..user_id.." foi até o jogador "..args[1].."")
			end
		end
	end
end)

RegisterServerEvent("webhook:enviarlogtpto") --ENVIA O LOG DO TPTO PARA O DISCORD
AddEventHandler("webhook:enviarlogtpto",function(name,message)
    if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
    PerformHttpRequest('SEUWEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TPWAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpway',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"chat.permissao") then
		TriggerClientEvent('tptoway',source)
		TriggerEvent("webhook:enviarlogtpway", "Comando - Tpway ", "ID "..user_id.." usou o comando /TPWAY")
	end
end)

RegisterServerEvent("webhook:enviarlogtpway") --ENVIA O LOG DO TPTO PARA O DISCORD
AddEventHandler("webhook:enviarlogtpway",function(name,message)
    if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
    PerformHttpRequest('SEUWEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DELNPCS ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('delnpcs',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		TriggerClientEvent('delnpcs',source)
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------
----[ ADM ]--------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
--[[RegisterCommand('adm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end
		SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MENSAGEM]: "..mensagem.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		vRPclient.setDiv(-1,"anuncio",".div_anuncio { background: rgba(255,50,50,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 27%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 16px; }","<bold>"..mensagem.."</bold><br><br>Mensagem enviada por: Administrador")
		SetTimeout(60000,function()
			vRPclient.removeDiv(-1,"anuncio")
		end)
	end
end)]]--

-------------------------------------------------------------------------------------------------------------------------------------------
----[ FESTINHA ]---------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('festa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"evento.permissao") then
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end
		SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MENSAGEM]: "..mensagem.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        vRPclient.setDiv(-1,"festa"," @keyframes blinking {    0%{ background-color: #ff3d50; border: 2px solid #871924; opacity: 0.8; } 25%{ background-color: #d22d99; border: 2px solid #901f69; opacity: 0.8; } 50%{ background-color: #55d66b; border: 2px solid #126620; opacity: 0.8; } 75%{ background-color: #22e5e0; border: 2px solid #15928f; opacity: 0.8; } 100%{ background-color: #222291; border: 2px solid #6565f2; opacity: 0.8; }  } .div_festinha { font-size: 11px; font-family: arial; color: rgba(255, 255, 255,1); padding: 20px; bottom: 22%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; animation: blinking 1s infinite; } bold { font-size: 16px; }","<bold>"..mensagem.."</bold><br><br>Festeiro(a): "..identity.name.." "..identity.firstname)
        SetTimeout(15000,function()
            vRPclient.removeDiv(-1,"festa")
		end)
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------
----[ ADM2 ]-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
--[[RegisterCommand('adm2',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        local identity = vRP.getUserIdentity(user_id)
        local mensagem = vRP.prompt(source,"Mensagem:","")
        if mensagem == "" then
            return
        end
        TriggerClientEvent("ANotify",-1,"remover","<b>"..mensagem.."</b><br><br>Mensagem enviada por: <b>"..identity.name.."</b>")
        SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MENSAGEM]: "..mensagem.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
    end
end)]]--
-----------------------------------------------------------------------------------------------------------------------------------------
--[ PLAYERSON ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pon',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
        local users = vRP.getUsers()
        local players = ""
        local quantidade = 0
        for k,v in pairs(users) do
            if k ~= #users then
                players = players..", "
            end
            players = players..k
            quantidade = quantidade + 1
        end
        TriggerClientEvent('chatMessage',source,"TOTAL ONLINE",{255,160,0},quantidade)
        TriggerClientEvent('chatMessage',source,"ID's ONLINE",{255,160,0},players)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP FACS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addballas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"liderballas.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Ballas \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.addUserGroup(parseInt(args[1]),"Ballas")
		end
	end
end)

RegisterCommand('removeballas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"liderballas.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Removeu]:"..parseInt(args[1]).." \n[GRUPO]: Ballas \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.removeUserGroup(parseInt(args[1]),"Ballas")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addvagos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"lidervagos.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Vagos \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.addUserGroup(parseInt(args[1]),"Vagos")
		end
	end
end)

RegisterCommand('removevagos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"lidervagos.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Removeu]:"..parseInt(args[1]).." \n[GRUPO]: Vagos \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.removeUserGroup(parseInt(args[1]),"Vagos")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addcoscosanostra',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"lidercoscosanostra.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Coscosanostra \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.addUserGroup(parseInt(args[1]),"Cosanostra")
		end
	end
end)

RegisterCommand('removecoscosanostra',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"lidercoscosanostra.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Removeu]:"..parseInt(args[1]).." \n[GRUPO]: Coscosanostra \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.removeUserGroup(parseInt(args[1]),"Cosanostra")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addfamilies',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"liderfamilies.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Families \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.addUserGroup(parseInt(args[1]),"Families")
		end
	end
end)

RegisterCommand('removefamilies',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"liderfamilies.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Removeu]:"..parseInt(args[1]).." \n[GRUPO]: Families \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.removeUserGroup(parseInt(args[1]),"Families")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addpolicia',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"liderbcso.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Policia \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.addUserGroup(parseInt(args[1]),"Policia")
		end
	end
end)

RegisterCommand('removepolicia',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"liderbcso.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Removeu]:"..parseInt(args[1]).." \n[GRUPO]: Policia \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.removeUserGroup(parseInt(args[1]),"Policia")
			vRP.removeUserGroup(parseInt(args[1]),"PaisanaPolicia")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addnews',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"lidernews.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: News \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.addUserGroup(parseInt(args[1]),"News")
		end
	end
end)

RegisterCommand('removenews',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"lidernews.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Removeu]:"..parseInt(args[1]).." \n[GRUPO]: News \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.removeUserGroup(parseInt(args[1]),"News")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addmafia',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"lidermafia.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Mafia \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.addUserGroup(parseInt(args[1]),"Mafia")
		end
	end
end)

RegisterCommand('removemafia',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"lidermafia.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Removeu]:"..parseInt(args[1]).." \n[GRUPO]: Mafia \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.removeUserGroup(parseInt(args[1]),"Mafia")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addbratva',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"liderbratva.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Bratva \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.addUserGroup(parseInt(args[1]),"Yakuza")
		end
	end
end)

RegisterCommand('removebratva',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"liderbratva.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Removeu]:"..parseInt(args[1]).." \n[GRUPO]: Bratva/Yakuza \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.removeUserGroup(parseInt(args[1]),"Yakuza")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addmotoclub',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"lidermotoclub.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Motoclub \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.addUserGroup(parseInt(args[1]),"Motoclub")
		end
	end
end)

RegisterCommand('removemotoclub',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"lidermotoclub.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Removeu]:"..parseInt(args[1]).." \n[GRUPO]: Motoclub \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.removeUserGroup(parseInt(args[1]),"Motoclub")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addparamedico',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"liderparamedico.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Paramedico \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.addUserGroup(parseInt(args[1]),"Paramedico")
		end
	end
end)

RegisterCommand('removeparamedico',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"liderparamedico.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Removeu]:"..parseInt(args[1]).." \n[GRUPO]: Paramedico \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.removeUserGroup(parseInt(args[1]),"Paramedico")
			vRP.removeUserGroup(parseInt(args[1]),"PaisanaParamedico")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addmecanico',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"mecanicolider.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Mecanico \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.addUserGroup(parseInt(args[1]),"Mecanico")
		end
	end
end)

RegisterCommand('removemecanico',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"mecanicolider.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Removeu]:"..parseInt(args[1]).." \n[GRUPO]: Mecanico \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.removeUserGroup(parseInt(args[1]),"Mecanico")
			vRP.removeUserGroup(parseInt(args[1]),"PaisanaMecanico")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addserpentes',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"liderserpentes.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Serpentes \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.addUserGroup(parseInt(args[1]),"Serpentes")
		end
	end
end)

RegisterCommand('removeserpentes',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"liderserpentes.permissao") then
		if args[1] then
			SendWebhookMessage(webhookfac,"```css\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Removeu]:"..parseInt(args[1]).." \n[GRUPO]: Serpentes \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
			vRP.removeUserGroup(parseInt(args[1]),"Serpentes")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
