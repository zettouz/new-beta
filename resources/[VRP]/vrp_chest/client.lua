-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_chest",src)
vSERVER = Tunnel.getInterface("vrp_chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local chestTimer = 0
local chestOpen = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("chestClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data)
	vSERVER.takeItem(tostring(chestOpen),data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
	vSERVER.storeItem(tostring(chestOpen),data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Creative:UpdateChest")
AddEventHandler("Creative:UpdateChest",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestChest",function(data,cb)
	local inventario,inventario2,peso,maxpeso,peso2,maxpeso2 = vSERVER.openChest(tostring(chestOpen))
	if inventario then
		cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2 })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local chest = {
	{ ['nome'] = "Policia1", ['x'] = -1107.15, ['y'] = -825.56, ['z'] = 14.29, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Arsenal~w~." },
	{ ['nome'] = "Policia2", ['x'] = -1078.19, ['y'] = -815.85, ['z'] = 11.04, ['titulo'] = "[~g~E~w~] Para acessar o ~r~Armázem de Evidencias~w~." },
	{ ['nome'] = "Paramedico", ['x'] = 343.18, ['y'] = -574.35, ['z'] = 43.29, ['titulo'] = "[~g~E~w~]  uma ~g~Receita~w~." },
	{ ['nome'] = "Paramedico2", ['x'] = 307.62, ['y'] = -579.63, ['z'] = 43.31, ['titulo'] = "[~g~E~w~]  uma ~g~Baú~w~." },
	{ ['nome'] = "Vagos", ['x'] = 337.45, ['y'] = -2011.9, ['z'] = 22.4, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	{ ['nome'] = "Ballas", ['x'] = 107.98, ['y'] = -1982.58, ['z'] = 20.97, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	{ ['nome'] = "Families", ['x'] = -145.1, ['y'] = -1599.77, ['z'] = 35.07, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	{ ['nome'] = "DriftKing", ['x'] = -1144.35, ['y'] = -2004.57, ['z'] = 13.18, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	{ ['nome'] = "Yakuza", ['x'] = -917.68, ['y'] = -1464.99, ['z'] = 5.18, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	{ ['nome'] = "Corleone", ['x'] = -1870.29, ['y'] = 2059.28, ['z'] = 135.44, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	{ ['nome'] = "Mafia", ['x'] = 1403.72, ['y'] = 1145.27, ['z'] = 114.33, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	{ ['nome'] = "Cosanostra", ['x'] = 3581.64, ['y'] = 3693.19, ['z'] = 27.13, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	{ ['nome'] = "Bratva", ['x'] = 565.97, ['y'] = -3117.53, ['z'] = 18.77, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	{ ['nome'] = "Motoclub", ['x'] = 884.81, ['y'] = -2102.89, ['z'] = 35.59, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	{ ['nome'] = "MidnightClub", ['x'] = -344.71, ['y'] = -128.04, ['z'] = 39.01, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	{ ['nome'] = "HellsAngels", ['x'] = -2674.28, ['y'] = 1328.22, ['z'] = 140.88, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	{ ['nome'] = "Bahamas", ['x'] = -1378.19, ['y'] = -622.7, ['z'] = -1.47, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	{ ['nome'] = "Dolls", ['x'] = -1635.19, ['y'] = -3000.19, ['z'] = -78.14, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	{ ['nome'] = "Dolls2", ['x'] = -1583.14, ['y'] = -3014.39, ['z'] = -76.0, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Bar~w~." },
	{ ['nome'] = "Mecanico", ['x'] = 950.47, ['y'] = -969.0, ['z'] = 39.76, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." }
	--{ ['nome'] = "Paramedico", ['x'] = 358.80, ['y'] = -594.31, ['z'] = 47.32, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	--{ ['nome'] = "Mercenarios", ['x'] = -1.50, ['y'] = -536.07, ['z'] = 175.34, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	--{ ['nome'] = "Trafico", ['x'] = 1272.19, ['y'] = -1712.52, ['z'] = 54.77, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	--{ ['nome'] = "Bennys", ['x'] = -224.34, ['y'] = -1320.26, ['z'] = 30.89, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	--{ ['nome'] = "Sheriff", ['x'] = -437.77, ['y'] = 5988.52, ['z'] = 31.71, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	--{ ['nome'] = "Mecanico", ['x'] = 98.0, ['y'] = 6619.31, ['z'] = 32.44, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	--{ ['nome'] = "Policiasandy", ['x'] = 1841.88, ['y'] = 3689.80, ['z'] = 34.25, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	--{ ['nome'] = "Furious", ['x'] = 3568.04, ['y'] = 3699.59, ['z'] = 28.13, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	--{ ['nome'] = "Families2", ['x'] = 2160.52, ['y'] = -18.76, ['z'] = 229.98, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	--{ ['nome'] = "Concessionaria", ['x'] = -1153.66, ['y'] = -1680.64, ['z'] = 11.8, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	--{ ['nome'] = "Concessionaria2", ['x'] = 2244.05, ['y'] = 2872.63, ['z'] = 55.2, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	--{ ['nome'] = "Skulls", ['x'] = 1393.31, ['y'] = -775.31, ['z'] = 74.34, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	--{ ['nome'] = "Cassino", ['x'] = 986.59, ['y'] = -68.66, ['z'] = 78.48, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	--{ ['nome'] = "Merry", ['x'] = 118.88, ['y'] = -729.24, ['z'] = 242.15, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	--{ ['nome'] = "Reds", ['x'] = 566.06, ['y'] = -3117.85, ['z'] = 18.77, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." },
	--{ ['nome'] = "HellsAngels2", ['x'] = -2671.33, ['y'] = 1337.82, ['z'] = 140.88, ['titulo'] = "[~g~E~w~] Para acessar o ~g~Baú~w~." }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		if chestTimer > 0 then
			chestTimer = chestTimer - 3
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("chest",function(source,args)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	for k,v in pairs(chest) do
		local distance = Vdist(x,y,z,v[2],v[3],v[4])
		if distance <= 2.0 and chestTimer <= 0 then
			chestTimer = 3
			if vSERVER.checkIntPermissions(v[1]) then
				SetNuiFocus(true,true)
				SendNUIMessage({ action = "showMenu" })
				chestOpen = v['nome']
			end
		end
	end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local timing = 1000
		
		for k,v in pairs(chest) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local chest = chest[k]
			
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), chest.x, chest.y, chest.z, true ) <= 2 then
				timing = 5
				DrawText3D(chest.x, chest.y, chest.z, chest.titulo)
			end
			
			if distance <= 5 then
				timing = 5
				DrawMarker(23,chest.x,chest.y,chest.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,20,20,20,240,0,0,0,0)
				if distance <= 1.2 and chestTimer <= 0 then
					if IsControlJustPressed(0,38) and vSERVER.checkIntPermissions(v['nome']) then
						chestTimer = 3
						SetNuiFocus(true,true)
						SendNUIMessage({ action = "showMenu" })
						chestOpen = v['nome']
					end
				end
			end
		end
		Citizen.Wait(timing)
	end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end

