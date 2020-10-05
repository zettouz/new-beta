
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local flood = {}
local delayflood = {}

vRP = Proxy.getInterface("vRP")

---------------------------------------------
--- WEBHOOOK
---------------------------------------------
local webhookchat = "SEUWEBHOOK"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

--[[AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end

    TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        fal = identity.name.. " " .. identity.firstname
        TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0 0 5px 0; background-image: linear-gradient(to right, rgba(36, 211, 242,1) 3%, rgba(36, 211, 242,0) 95%); border-radius: 15px 50px 30px 5px;"><i class="fab fa-twitter"></i> @{0}:<br>{1}</div>',
        args = { fal, message }
        })

    end
 end)]]

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

   -- if not WasEventCanceled() then
      --  TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    --end

    CancelEvent()
    end)

-- player join messages


-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                    })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
    end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
    end)
	
 -----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('911', function(source, args, rawCommand)
    -----------------------------------INICIO AntiFlood
    if(flood[source]==nil)then
        flood[source] = 1
        delayflood[source] = os.time()
    else
        if(os.time()-delayflood[source]<1)then
            flood[source]= flood[source] + 1
            if(flood[source]==15)then
                local id = vRP.getUserId(source)
                print("[ABUSER] "..id.."  foi kikado tentando sobrecarregar o servidor!")
                DropPlayer(source, "hoje nao")
                local identity = vRP.getUserIdentity(id)
                SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..id.." "..identity.name.." "..identity.firstname.." \n[TENTOU DERRUBAR O SERVIDOR!] \n[Chat]: 911 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        else
            flood[source]=nil
            delayflood[source] = nil
        end
        delayflood[source] = os.time()
    end    
    -----------------------------------FIM AntiFlood
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local identity = vRP.getUserIdentity(user_id)
        TriggerClientEvent('chatMessage', -1, "[911] ".. identity.name .. " " .. identity.firstname .." ", {65, 105, 255}, rawCommand:sub(4))          
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('112', function(source, args, rawCommand)
    -----------------------------------INICIO AntiFlood
    if(flood[source]==nil)then
        flood[source] = 1
        delayflood[source] = os.time()
    else
        if(os.time()-delayflood[source]<1)then
            flood[source]= flood[source] + 1
            if(flood[source]==15)then
                local id = vRP.getUserId(source)
                print("[ABUSER] "..id.."  foi kikado tentando sobrecarregar o servidor!")
                DropPlayer(source, "hoje nao")
                local identity = vRP.getUserIdentity(id)
                SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..id.." "..identity.name.." "..identity.firstname.." \n[TENTOU DERRUBAR O SERVIDOR!] \n[Chat]: 112 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        else
            flood[source]=nil
            delayflood[source] = nil
        end
        delayflood[source] = os.time()
    end    
    -----------------------------------FIM AntiFlood
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local identity = vRP.getUserIdentity(user_id)
        TriggerClientEvent('chatMessage', -1, "[112] ".. identity.name .. " " .. identity.firstname .." ", {139, 0, 0}, rawCommand:sub(4))        
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MEC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mec', function(source, args, rawCommand)
    -----------------------------------INICIO AntiFlood
    if(flood[source]==nil)then
        flood[source] = 1
        delayflood[source] = os.time()
    else
        if(os.time()-delayflood[source]<1)then
            flood[source]= flood[source] + 1
            if(flood[source]==15)then
                local id = vRP.getUserId(source)
                print("[ABUSER] "..id.."  foi kikado tentando sobrecarregar o servidor!")
                DropPlayer(source, "hoje nao")
                local identity = vRP.getUserIdentity(id)
                SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..id.." "..identity.name.." "..identity.firstname.." \n[TENTOU DERRUBAR O SERVIDOR!] \n[Chat]: MEC "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        else
            flood[source]=nil
            delayflood[source] = nil
        end
        delayflood[source] = os.time()
    end    
    -----------------------------------FIM AntiFlood
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local identity = vRP.getUserIdentity(user_id)
        TriggerClientEvent('chatMessage', -1, "[NOME Motors] ".. identity.name .. " " .. identity.firstname .." ", {179, 89, 0}, rawCommand:sub(4))      
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FRP
-----------------------------------------------------------------------------------------------------------------------------------------
--[[RegisterCommand('frp', function(source, args, rawCommand)
    -----------------------------------INICIO AntiFlood
    if(flood[source]==nil)then
        flood[source] = 1
        delayflood[source] = os.time()
    else
        if(os.time()-delayflood[source]<1)then
            flood[source]= flood[source] + 1
            if(flood[source]==15)then
                local id = vRP.getUserId(source)
                print("[ABUSER] "..id.."  foi kikado tentando sobrecarregar o servidor!")
                DropPlayer(source, "hoje nao")
                local identity = vRP.getUserIdentity(id)
                SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..id.." "..identity.name.." "..identity.firstname.." \n[TENTOU DERRUBAR O SERVIDOR!] \n[Chat]: FRP "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        else
            flood[source]=nil
            delayflood[source] = nil
        end
        delayflood[source] = os.time()
    end    
    -----------------------------------FIM AntiFlood
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local identity = vRP.getUserIdentity(user_id)
        TriggerClientEvent('chatMessage', -1, " ".. identity.name .. " " .. identity.firstname .." ", {0, 255, 127}, rawCommand:sub(4))
    end
end)]]--
-----------------------------------------------------------------------------------------------------------------------------------------
-- TWT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('twt', function(source, args, rawCommand)
    -----------------------------------INICIO AntiFlood
    if(flood[source]==nil)then
        flood[source] = 1
        delayflood[source] = os.time()
    else
        if(os.time()-delayflood[source]<1)then
            flood[source]= flood[source] + 1
            if(flood[source]==15)then
                local id = vRP.getUserId(source)
                print("[ABUSER] "..id.."  foi kikado tentando sobrecarregar o servidor!")
                DropPlayer(source, "hoje nao")
                local identity = vRP.getUserIdentity(id)
                SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..id.." "..identity.name.." "..identity.firstname.." \n[TENTOU DERRUBAR O SERVIDOR!] \n[Chat]: TWT "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        else
            flood[source]=nil
            delayflood[source] = nil
        end
        delayflood[source] = os.time()
    end    
    -----------------------------------FIM AntiFlood
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local identity = vRP.getUserIdentity(user_id)
        TriggerClientEvent('chatMessage', -1, "[TWT] ".. identity.name .. " " .. identity.firstname .." ", {0, 202, 255}, rawCommand:sub(4))
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ILEGAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ilegal', function(source, args, rawCommand)
    -----------------------------------INICIO AntiFlood
    if(flood[source]==nil)then
        flood[source] = 1
        delayflood[source] = os.time()
    else
        if(os.time()-delayflood[source]<1)then
            flood[source]= flood[source] + 1
            if(flood[source]==15)then
                local id = vRP.getUserId(source)
                print("[ABUSER] "..id.."  foi kikado tentando sobrecarregar o servidor!")
                DropPlayer(source, "hoje nao")
                local identity = vRP.getUserIdentity(id)
                SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..identity.name.." "..identity.firstname.." \n[TENTOU DERRUBAR O SERVIDOR!] \n[Chat]: Ilegal "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        else
            flood[source]=nil
            delayflood[source] = nil
        end
        delayflood[source] = os.time()
    end    
    -----------------------------------FIM AntiFlood
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local identity = vRP.getUserIdentity(user_id)
        TriggerClientEvent('chatMessage', -1, "[ILEGAL] " .. user_id .." ", {0, 0, 0}, rawCommand:sub(7))
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDIDOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('bandidos', function(source, args, rawCommand)
    -----------------------------------INICIO AntiFlood
    if(flood[source]==nil)then
        flood[source] = 1
        delayflood[source] = os.time()
    else
        if(os.time()-delayflood[source]<1)then
            flood[source]= flood[source] + 1
            if(flood[source]==15)then
                local id = vRP.getUserId(source)
                print("[ABUSER] "..id.."  foi kikado tentando sobrecarregar o servidor!")
                DropPlayer(source, "hoje nao")
                local identity = vRP.getUserIdentity(id)
                SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..id.." "..identity.name.." "..identity.firstname.." \n[TENTOU DERRUBAR O SERVIDOR!] \n[Chat]: BANDIDOS "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        else
            flood[source]=nil
            delayflood[source] = nil
        end
        delayflood[source] = os.time()
    end    
    -----------------------------------FIM AntiFlood
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local identity = vRP.getUserIdentity(user_id)
        TriggerClientEvent('chatMessage', -1, "[BANDIDOS] ".. identity.name .. " " .. identity.firstname .." ", {75, 0, 130}, rawCommand:sub(9))
    end
end)
    
    RegisterCommand('clear', function(source)
        local user_id = vRP.getUserId(source);
        if user_id ~= nil then
            if vRP.hasPermission(user_id, "chat.permissao") then
                TriggerClientEvent("chat:clear", -1);
            --  TriggerClientEvent("chatMessage", source, " ");
            else
                TriggerClientEvent("chat:clear", source);
                --TriggerClientEvent("chatMessage", source, "Você não tem permissão");
            end
        end
    end)