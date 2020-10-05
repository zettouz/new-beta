-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("vrp_spawn",cRP)
vSERVER = Tunnel.getInterface("vrp_spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = nil
local cam2 = nil
local chose = true
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCHARS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_spawn:setupChars")
AddEventHandler("vrp_spawn:setupChars",function()
	chose = true
	DoScreenFadeOut(10)

	while not IsScreenFadedOut() do
		Citizen.Wait(10)
	end

	SetTimecycleModifier("hud_def_blur")
	FreezeEntityPosition(PlayerPedId(),true)
	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",248.78,156.58,136.23,300.00,0.00,0.00,100.00,false,0)
	SetCamActive(cam,true)
	RenderScriptCams(true,false,1,true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_spawn:setupUI")
AddEventHandler("vrp_spawn:setupUI",function(characters)
	DoScreenFadeIn(500)
	Citizen.Wait(500)

	SetNuiFocus(true,true)
	SendNUIMessage({ action = "openui", characters = characters })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNCHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_spawn:spawnChar")
AddEventHandler("vrp_spawn:spawnChar",function(status)
	SetTimecycleModifier("default")
	DoScreenFadeIn(500)
	Citizen.Wait(500)

	SetCamActive(cam,false)
	DestroyCam(cam,true)
	chose = false

	TriggerEvent("hudActived")
	TriggerEvent("vrp_login:Spawn",status)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELOADCHARS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_spawn:reloadChars")
AddEventHandler("vrp_spawn:reloadChars",function(chars)
	SendNUIMessage({ action = "update", characters = chars })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CharacterChosen",function(data)
	SetNuiFocus(false,false)
	DoScreenFadeOut(500)

	while not IsScreenFadedOut() do
		Citizen.Wait(10)
	end

	TriggerServerEvent("vrp_spawn:charChosen",tonumber(data.id))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCREATED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("B2KCharacterCreate",function()
	SetTimecycleModifier("default")
	DoScreenFadeOut(500)
	Citizen.Wait(500)

	SetCamActive(cam,false)
	DestroyCam(cam,true)

	while not IsScreenFadedOut() do
		Citizen.Wait(10)
	end

	TriggerServerEvent("vrp_spawn:b2k:createNewChar")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETECHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("DeleteCharacter",function(data)
	TriggerServerEvent("vrp_spawn:deleteChar",tonumber(data.id))
end)