local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
--------------------------------------------------------------------------------------------------------------------------------
--[ CONEXÕES ]------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
gaS = Tunnel.getInterface("vrp_gas")

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local bowz,cdz = GetGroundZFor_3dCoord(-137.6, -1007.27, 4.95)
        local distance = GetDistanceBetweenCoords(-137.6, -1007.27,cdz,x,y,z,true)


		
        if distance < 2550 then
            if IsPlayerPlaying(PlayerId()) then
                SetEntityHealth(ped,GetEntityHealth(ped)-3)
                gaS.notRadiacao()
            end
            if distance < 2450 then
                SetEntityHealth(ped,GetEntityHealth(ped)-10)
                gaS.notRadiacao()
                if distance < 2350 then
                    SetEntityHealth(ped,GetEntityHealth(ped)-30)
                    gaS.notRadiacao()
                end
            end
        end

	end
end)