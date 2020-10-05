    local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Policia = {}
Tunnel.bindInterface("nav_uniforme-policia",Policia)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ROUPAS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local agentep = {
    [1885233650] = {
        [1] = { 121,0 },
        [2] = { 4,0 },
        [3] = { 11,0 },
        [4] = { 25,1 },
        [5] = { -1,0 },
        [6] = { 25,0 },
        [7] = { 8,0 },			
        [8] = { 56,0 },
        [9] = { 14,0 },
        [10] = { 19,0 },
        [11] = { 32,1 },
        ["p0"] = { 9,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { 121,0 },
        [5] = { -1,0 },
        [7] = { 8,0 },
        [3] = { 14,0 },
        [4] = { 105,0 },
        [8] = { 2,0 },
        [6] = { 25,0 },
        [11] = { 265,0 },
        [9] = { 0,0 },
        [10] = { 16,0 },
        [11] = { 265,1 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,1 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local instrutor = {
    [1885233650] = {
        [1] = { 121,0 },
        [2] = { 4,0 },
        [3] = { 14,0 },
        [4] = { 25,1 },
        [5] = { -1,0 },
        [6] = { 25,0 },
        [7] = { 8,0 },			
        [8] = { 56,0 },
        [9] = { 14,0 },
        [10] = { 18,0 },
        [11] = { 31,1 },
        ["p0"] = { 9,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { 121,0 },
        [5] = { -1,0 },
        [7] = { 8,0 },
        [3] = { 14,0 },
        [4] = { 105,0 },
        [8] = { 2,0 },
        [6] = { 25,0 },
        [11] = { 264,0 },
        [9] = { 0,0 },
        [10] = { 15,0 },
        [11] = { 264,1 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,1 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local treinamento = {
    [1885233650] = {
        [1] = { 121,0 },
        [2] = { 4,0 },
        [3] = { 0,0 },
        [4] = { 25,1 },
        [5] = { -1,0 },
        [6] = { 25,0 },
        [7] = { 8,0 },			
        [8] = { 57,0 },
        [9] = { 14,0 },
        [10] = { -1,0 },
        [11] = { 38,3 },		
        ["p0"] = { 9,4 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { 121,0 },
        [5] = { -1,0 },
        [7] = { 8,0 },
        [3] = { 14,0 },
        [4] = { 30,0 },
        [8] = { 2,0 },
        [6] = { 25,0 },
        [11] = { 266,1 },
        [9] = { 0,0 },
        [10] = { -1,0 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,1 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local investigador = {
    [1885233650] = {
        [1] = { 52,3 },
        [2] = { 4,0 },
        [3] = { 22,0 },
        [4] = { 34,0 },
        [5] = { -1,0 },
        [6] = { 35,1 },
        [7] = { 1,0 },			
        [8] = { 38,0 },
        [9] = { 4,3 },
        [10] = { -1,0 },
        [11] = { 63,0 },
        ["p0"] = { 39,4 },
        ["p1"] = { 25,4 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { 121,0 },
        [3] = { 11,0 },
        [4] = { 25,1 },
        [5] = { -1,0 },
        [6] = { 25,0 },
        [7] = { 1,0 },
        [8] = { 57,0 },
        [9] = { 4,4 },
        [10] = { -1,0 },
        [11] = { 32,1 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }

    }
}

local tatico = {
    [1885233650] = {
   	[1] = { 122,0 },
			[5] = { -1,0 },
			[7] = { 1,0 },
			[3] = { 22,0 },
			[4] = { 32,1 },
			[8] = { 137,0 },
			[6] = { 13,0 },
			[11] = { 51,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { 17,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { 35,0 }, -- Mascara
        [3] = { 31,0 }, -- Maos
        [4] = { 30,2 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 25,0 }, -- Sapato
        [7] = { 1,0 },	-- Acessorios		
        [8] = { 108,0 }, -- Camisa
        [9] = { 7,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 46,0 }, -- Jaqueta		
        ["p0"] = { 116,0 }, -- Chapeu
        ["p1"] = { 27,4 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { -1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    }
}
local transito = {
    [1885233650] = {
        [1] = { 121,0 },
        [5] = { -1,0 },
        [7] = { 0,0 },
        [3] = { 14,0 },
        [4] = { 25,0 },
        [8] = { 15,0 },
        [6] = { 25,0 },
        [11] = { 31,0 },
        [9] = { 10,0 },
        [10] = { -1,0 },
        ["p0"] = { 9,2 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

RegisterServerEvent("agentep")
AddEventHandler("agentep",function()
    local user_id = vRP.getUserId(source)
    local custom = agentep
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)

RegisterServerEvent("instrutor")
AddEventHandler("instrutor",function()
    local user_id = vRP.getUserId(source)
    local custom = instrutor
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)

RegisterServerEvent("treinamento")
AddEventHandler("treinamento",function()
    local user_id = vRP.getUserId(source)
    local custom = treinamento
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)

RegisterServerEvent("investigador")
AddEventHandler("investigador",function()
    local user_id = vRP.getUserId(source)
    local custom = investigador
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)

RegisterServerEvent("tatico")
AddEventHandler("tatico",function()
    local user_id = vRP.getUserId(source)
    local custom = tatico
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)

RegisterServerEvent("tirar-uniforme")
AddEventHandler("tirar-uniforme",function()
    local user_id = vRP.getUserId(source)
    vRP.removeCloak(source)
end)

function Policia.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"bcso.permissao") or vRP.hasPermission(user_id,"paisana-bcso.permissao") then
        return true
	end
end