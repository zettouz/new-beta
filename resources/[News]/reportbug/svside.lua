
local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local webhook = "SEUWEBHOOK"
local marcadagua = "Sistema de ajuda"
local img = "https://cdn.discordapp.com/attachments/599007573626191872/726999213161840670/download.png"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

RegisterCommand('reportar',function(source,args,rawCommand)
  local user_id = vRP.getUserId(source)
  local report = vRP.prompt(source,"Usuario ou ID que deseja Reportar:","")
  local report2 = vRP.prompt(source,"Motivo:","")
      if report == "" then 
      TriggerClientEvent('chatMessage', source, "Desculpe", {50, 205, 50},"Voce nao reportou nada por tanto nada sera feito.")
  else
      synterinho(3553599,"Novo Reporte! 🚨", "> **__ID DENUNCIANTE:__** \n```yaml\n"..user_id.."```> **__ID OU NOME DO DENUNCIADO:__** \n```yaml\n"..report.."```> **__MOTIVO DO REPORTE:__** \n```yaml\n"..report2.."```")
      TriggerClientEvent('chatMessage', source, "Obrigado", {50, 205, 50},"Voce reportou o ID/Usuario: ^0"..report..". SEU REPORT FOI ENVIADO AO DISCORD") 
      print("Um Reporte novo foi enviado pelo id:"..user_id)
  end
end)

function synterinho(corzinha, titulopika, logfull)
    local synter = {
      {
        ["color"] = corzinha,
        ["title"] = titulopika,
        ["description"] = logfull,
        ["footer"] = {
            ["text"] = marcadagua,
            ["icon_url"] = img,
        },
    }
  }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({avatar_url = img, username = marcadagua, embeds = synter}), { ['Content-Type'] = 'application/json' })
  end

