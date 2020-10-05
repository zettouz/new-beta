local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Resg = {}
Tunnel.bindInterface("nav_uniforme-mecanico",Resg)
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
local mecanico = {
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

local mecanico0 = {
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

local mecanico1 = {
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

local mecanico2 = {
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
        [3] = { 20,0 },
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

local mecanico3 = {
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

local mecanico4 = {
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

local mecanico5 = {
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

RegisterServerEvent("mecanico")
AddEventHandler("mecanico",function()
    local user_id = vRP.getUserId(source)
    local custom = mecanico
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

RegisterServerEvent("mecanico0")
AddEventHandler("mecanico0",function()
    local user_id = vRP.getUserId(source)
    local custom = mecanico0
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

RegisterServerEvent("mecanico1")
AddEventHandler("mecanico1",function()
    local user_id = vRP.getUserId(source)
    local custom = mecanico1
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

RegisterServerEvent("mecanico2")
AddEventHandler("mecanico2",function()
    local user_id = vRP.getUserId(source)
    local custom = mecanico2
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

RegisterServerEvent("mecanico3")
AddEventHandler("mecanico3",function()
    local user_id = vRP.getUserId(source)
    local custom = mecanico3
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

RegisterServerEvent("mecanico4")
AddEventHandler("mecanico4",function()
    local user_id = vRP.getUserId(source)
    local custom = mecanico4
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

RegisterServerEvent("mecanico4")
AddEventHandler("mecanico4",function()
    local user_id = vRP.getUserId(source)
    local custom = mecanico4
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

RegisterServerEvent("mecanico5")
AddEventHandler("mecanico5",function()
    local user_id = vRP.getUserId(source)
    local custom = mecanico5
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
    if vRP.hasPermission(user_id,"mecanico.permissao") or vRP.hasPermission(user_id,"paisana-mecanico.permissao") then
        return true
	end
end