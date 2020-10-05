-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local hour = 0
local minute = 0
local month = ""
local dayOfMonth = 0
local proximity = 8.001
local voice = 2
-----------------------------------------------------------------------------------------------------------------------------------------
-- CalculateTimeToDisplay
-----------------------------------------------------------------------------------------------------------------------------------------
function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()
	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CalculateDateToDisplay
-----------------------------------------------------------------------------------------------------------------------------------------
function CalculateDateToDisplay()
	month = GetClockMonth()
	dayOfMonth = GetClockDayOfMonth()
	if month == 0 then
		month = "Janeiro"
	elseif month == 1 then
		month = "Fevereiro"
	elseif month == 2 then
		month = "Março"
	elseif month == 3 then
		month = "Abril"
	elseif month == 4 then
		month = "Maio"
	elseif month == 5 then
		month = "Junho"
	elseif month == 6 then
		month = "Julho"
	elseif month == 7 then
		month = "Agosto"
	elseif month == 8 then
		month = "Setembro"
	elseif month == 9 then
		month = "Outubro"
	elseif month == 10 then
		month = "Novembro"
	elseif month == 11 then
		month = "Dezembro"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEOVERLAY
-----------------------------------------------------------------------------------------------------------------------------------------
function UpdateOverlay()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
	CalculateTimeToDisplay()
	CalculateDateToDisplay()
	NetworkClearVoiceChannel()
	NetworkSetTalkerProximity(proximity)

	--SendNUIMessage({ dia = dayOfMonth, mes = month, hora = hour, minuto = minute, rua = street, voz = voice })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	NetworkSetTalkerProximity(proximity)
	while true do
		Citizen.Wait(1000)
		UpdateOverlay()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOME-BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if IsControlJustPressed(1,212) and GetEntityHealth(PlayerPedId()) > 100 then
			if proximity == 3.001 then
				voice = 2
				proximity = 8.001
			elseif proximity == 8.001 then
				voice = 3
				proximity = 15.001
			elseif proximity == 15.001 then
				voice = 4
				proximity = 30.001
			elseif proximity == 30.001 then
				voice = 1
				proximity = 3.001
			end
			UpdateOverlay()
		end
	end
end)]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE ON CAR
-----------------------------------------------------------------------------------------------------------------------------------------
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if IsPedInAnyVehicle(PlayerPedId()) then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			local speed = GetEntitySpeed(vehicle)*2.236936
			if proximity == 8.001 and speed >= 40 then
				voice = 3
				proximity = 15.001
			elseif proximity == 15.001 and speed <= 40 then
				voice = 2
				proximity = 8.001
			end
		end
		UpdateOverlay()
	end
end)]]