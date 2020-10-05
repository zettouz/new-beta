local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Resg = {}
Tunnel.bindInterface("nav_uniforme-medico",Resg)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ROUPAS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-- [1] = { -1,0 }, -- máscara
-- [3] = { 0,0 }, -- maos
-- [4] = { 10,0 }, -- calça
-- [5] = { -1,0 }, -- mochila
-- [6] = { 21,0 }, -- sapato
-- [7] = { -1,0 }, -- acessorios		
-- [8] = { -1,0 }, -- blusa
-- [9] = { -1,0 }, -- colete
-- [10] = { -1,0 }, -- adesivo
-- [11] = { 242,1 }, -- jaqueta		
-- ["p0"] = { -1,0 }, -- chapeu
-- ["p1"] = { 7,0 }, -- oculos
local diretoria = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 12,0 },
        [4] = { 45,0 },
        [5] = { -1,0 },
        [6] = { 21,0 },
        [7] = { 127,0 },			
        [8] = { 35,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 30,0 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [2] = { 5,0 },
        [3] = { 6,0 },
        [4] = { 37,0 },
        [5] = { -1,0 },
        [6] = { 0,0 },
        [7] = { 14,0 },			
        [8] = { 38,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 58,0 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local medico = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 77,0 },
        [4] = { 20,0 },
        [5] = { -1,0 },
        [6] = { 21,9 },
        [7] = { 126,0 },			
        [8] = { 32,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 29,7 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [2] = { 5,0 },
        [3] = { 92,0 },
        [4] = { 37,5 },
        [5] = { -1,0 },
        [6] = { 4,0 },
        [7] = { 96,0 },			
        [8] = { 64,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 57,7 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local medico2 = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 85,0 },
        [4] = { 98,15 },
        [5] = { -1,0 },
        [6] = { 42,0 },
        [7] = { 5,0 },			
        [8] = { 15,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 271,0 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [2] = { 5,0 },
        [3] = { 109,0 },
        [4] = { 101,15 },
        [5] = { -1,0 },
        [6] = { 81,0 },
        [7] = { 6,4 },			
        [8] = { 17,0 },
        [9] = { -1,0 },
        [10] = { 0,0 },
        [11] = { 280,0 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local medico3 = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 82,0 },
        [4] = { 10,1 },
        [5] = { -1,0 },
        [6] = { 42,1 },
        [7] = { 127,0 },			
        [8] = { 35,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 30,1 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { 1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { 121,0 },
        [2] = { 5,0 },
        [3] = { 21,0 },
        [4] = { 6,1 },
        [5] = { -1,0 },
        [6] = { 6,0 },
        [7] = { 97,0 },			
        [8] = { 64,0 },
        [9] = { -1,0 },
        [10] = { 7,0 },
        [11] = { 57,8 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local farmaceutico = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 75,0 },
        [4] = { 20,0 },
        [5] = { -1,0 },
        [6] = { 42,0 },
        [7] = { 30,0 },			
        [8] = { 15,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 220,22 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { 1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [3] = { 93,0 },
        [4] = { 11,15 },
        [5] = { -1,0 },
        [6] = { 4,0 },
        [7] = { 96,0 },			
        [8] = { 14,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 230,22 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local enfermeiro = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 74,0 },
        [4] = { 20,0 },
        [5] = { -1,0 },
        [6] = { 42,0 },
        [7] = { 30,0 },			
        [8] = { 15,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 13,0 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { 1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [3] = { 93,0 },
        [4] = { 11,15 },
        [5] = { -1,0 },
        [6] = { 4,0 },
        [7] = { 96,0 },			
        [8] = { 14,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 9,1 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local paramedico = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 81,0 },
        [4] = { 59,8 },
        [5] = { 0,0 },
        [6] = { 25,0 },
        [7] = { 126,0 },			
        [8] = { 15,0 },
        [9] = { 0,0 },
        [10] = { 58,0 },
        [11] = { 95,1 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { 1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [3] = { 93,0 },
        [4] = { 32,0 },
        [5] = { -1,0 },
        [6] = { 24,0 },
        [7] = { 96,0 },			
        [8] = { 15,0 },
        [9] = { -1,0 },
        [10] = { 66,0 },
        [11] = { 150,1 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

RegisterServerEvent("diretoria")
AddEventHandler("diretoria",function()
    local user_id = vRP.getUserId(source)
    local custom = diretoria
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

RegisterServerEvent("medico")
AddEventHandler("medico",function()
    local user_id = vRP.getUserId(source)
    local custom = medico
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

RegisterServerEvent("medico2")
AddEventHandler("medico2",function()
    local user_id = vRP.getUserId(source)
    local custom = medico2
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

RegisterServerEvent("medico3")
AddEventHandler("medico3",function()
    local user_id = vRP.getUserId(source)
    local custom = medico3
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

RegisterServerEvent("socorrista")
AddEventHandler("socorrista",function()
    local user_id = vRP.getUserId(source)
    local custom = socorrista
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

RegisterServerEvent("farmaceutico")
AddEventHandler("farmaceutico",function()
    local user_id = vRP.getUserId(source)
    local custom = farmaceutico
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

RegisterServerEvent("enfermeiro")
AddEventHandler("enfermeiro",function()
    local user_id = vRP.getUserId(source)
    local custom = enfermeiro
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

RegisterServerEvent("paramedico")
AddEventHandler("paramedico",function()
    local user_id = vRP.getUserId(source)
    local custom = paramedico
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
    vRP.removeCloak(source)
end)

function Resg.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"dmla.permissao") or vRP.hasPermission(user_id,"paisana-dmla.permissao") then
        return true
	end
end