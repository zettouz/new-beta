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
local mostraSeuID = true
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
                        local ped = GetPlayerPed(id)

                        local armour = GetPedArmour(ped)
                        local health = (GetEntityHealth(ped)-100)/300*100

                        if SVIDclient.getUseBlip(pid) then
                            players[id] = {['text']= "<b><i>&#8721;</i> "..pid.." "..name.."</b>", ['health'] = health, ['armour'] = armour }
                        else
                            players[id] = {['text']= "<b>"..pid.." "..name.."</b>", ['health'] = health, ['armour'] = armour }
                        end
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
            SVIDclient.remUseBlip()
            blips = false
        else
            SVIDclient.addUseBlip()
            blips = true
        end
    end    
end)
--Draw this at every frame
function drawProgressBar(x, y, width, height, colour, percent)
    local w = width * (percent/100)
    local x = (x - (width * (percent/100))/2)-width/2    
    DrawRect(x+w, y, w, height, colour[1], colour[2], colour[3], colour[4])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- cria o texto 3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z, player, r,g,b, health,armor)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = 100

    if onScreen and player then
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.0, 0.35)
        SetTextColour(r, g, b, 186)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(player.text)
        DrawText(_x,_y)
        drawProgressBar(_x-0.0150,_y+0.0310, 0.0350, 0.0085, {178,34,34, 100}, 100)
        drawProgressBar(_x-0.0150,_y+0.0310, 0.0350, 0.0085, {178,34,34, 255}, player.health)
        drawProgressBar(_x+0.0180,_y+0.0310, 0.0300, 0.0085, {105,105,105, 80}, 100)
        drawProgressBar(_x+0.0180,_y+0.0310, 0.0300, 0.0085, {105,105,105, 200}, player.armour)

    end
end
