-- Creditos: @BADTRIP#0611

-----------------------------------------------------------------------------------------------------------------------------------------
-- importa os Utils do VRP
-----------------------------------------------------------------------------------------------------------------------------------------	
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

-----------------------------------------------------------------------------------------------------------------------------------------
-- Tunnel e Proxy VRP
-----------------------------------------------------------------------------------------------------------------------------------------
vRPclient = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- Tunnel e Proxy do Resource
-----------------------------------------------------------------------------------------------------------------------------------------
vRPidd = {}
Tunnel.bindInterface("vrp_id",vRPidd)
Proxy.addInterface("vrp_id",vRPidd)
SVIDclient = Tunnel.getInterface("vrp_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- variavels de Configuração
-----------------------------------------------------------------------------------------------------------------------------------------
local distancia = 300
local mostraSeuID = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- variavels de Função
-----------------------------------------------------------------------------------------------------------------------------------------
local players = {}
local admin= {}
local blips = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- Esse loop cria um array (table) com as informações de ids - Se fizer direto no loop do DRAWTEXT ele tem um delay ao mostrar o id (fica piscando)
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            for id = 0, 256 do 
                if NetworkIsPlayerActive(id) then
                    if GetPlayerPed(id) ~= PlayerId() then           
                        local pid = SVIDclient.getId(GetPlayerServerId(id))
                        local name = SVIDclient.getNome(GetPlayerServerId(id))
                        players[id] = "<b>"..pid.." "..name.."</b>"
                        admin = SVIDclient.getPermissao()
                    end
                end
            end
        end
    end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Esse Loop Print os ID's na Cabeça
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
	    while true do
	    	Citizen.Wait(5)
	      	if blips then
		        for _, id in ipairs(GetActivePlayers()) do
			        x1, y1, z1 = table.unpack( GetEntityCoords( PlayerPedId(), true ) )
			        x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
			        distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
			    	if admin and (PlayerPedId() ~= GetPlayerPed( id ) or mostraSeuID)then
				    	if ((distance < distancia)) then
				    		DrawText3D(x2, y2, z2+1.4, players[id], 255, 255, 255)
				    	end
				    end
				end
			end
	    end
end)


RegisterCommand("blips",function(source,args)
    if admin then
        if blips then
            blips = false
        else
            blips = true
        end
    end    
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- cria o texto 3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.0, 0.40)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
