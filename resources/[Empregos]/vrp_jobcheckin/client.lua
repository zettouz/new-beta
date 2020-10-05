
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
jobServer = Tunnel.getInterface("vrp_jobcheckin")
src = {}
Tunnel.bindInterface("vrp_jobcheckin",src)
Proxy.addInterface("vrp_jobcheckin",src)

local inMenu = false

function src.openJob(jobInfo)
	inMenu = true
	SetNuiFocus(true, true)
	SendNUIMessage({action = 'open', title = jobInfo['titulo'], desc = jobInfo['descricao'], callback = jobInfo['callBackEvent'] })
	--StartScreenEffect("MenuMGSelectionIn", 0, true)
end

function src.close()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({action = 'close'})
 	--StopScreenEffect("MenuMGSelectionIn")
end
-----------------------------------------------------------------------------------------------------------------------------------------------
--	Eventos
-----------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStop",function(resource)
    if resource == GetCurrentResourceName() then
        src.close()
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------------
--	CallBacks
-----------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('checkin', function(callback)
    local callback = callback['callback']
    vRP.playSound("ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
    TriggerEvent(callback)
    src.close()
end)

RegisterNUICallback('close', function()
	src.close()
end)
-----------------------------------------------------------------------------------------------------------------------------------------------
--	CallBacks Empregos
-----------------------------------------------------------------------------------------------------------------------------------------------
local emprego = false
function src.CheckJob()
	return emprego
end

function src.SetJob(status)
	emprego = status
end

local segundos = 0
function src.CheckTimer()
	return segundos
end

function src.LeaveJob()
	segundos = 200
	repeat Citizen.Wait(1000)
	segundos = segundos - 1
    until segundos == 0
    emprego = false
end