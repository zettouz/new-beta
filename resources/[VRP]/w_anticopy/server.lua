local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "w_anticopy")

src = {}
Tunnel.bindInterface("w_anticopy",src)
Proxy.addInterface("w_anticopy",src)

local loaded = {}
function src.pegaTrouxa()
    local source = source
    local user_id = vRP.getUserId(source)

    local fields2 = {}
    table.insert(fields2, { name = "ChomeInspector:", value = 'ID => **'..user_id..'** \nFoi pego tentando roubar o Html/Client da cidade.', inline = true });
    PerformHttpRequest("SEUWEBHOOK", function(err, text, headers) end, 'POST', json.encode({username = "In Game Log System", content = nil, embeds = {{color = 16754176, fields = fields2,}}}), { ['Content-Type'] = 'application/json' }) 
    print("Tentativa de Acesso ao Chrome Inspector! ID: "..user_id)
    vRP.kick(source,"PAPAI DEVIL TE MANDOU UM BEIJO!")    
    vRP.setBanned(user_id,true)

end

