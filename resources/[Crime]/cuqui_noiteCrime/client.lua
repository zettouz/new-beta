RegisterNetEvent("cuqui_noiteCrime:iniciar")
AddEventHandler("cuqui_noiteCrime:iniciar", function(source)

	TriggerServerEvent('InteractSound_SV:PlayOnAll', 'noitecrimemulher', 0.4)
	Wait(52200)
	TriggerServerEvent('InteractSound_SV:PlayOnAll', 'sirene', 0.2)
	TriggerServerEvent('cuqui_noiteCrime:notificacaoInicio', source)
	TriggerServerEvent('noiteCrime:blackout', source)
	
	local segundos = 340
	for i = segundos, 1, -1 do	
		Wait(1000)
		print("Segundos restantes: ".. i)	
	end	
	TriggerEvent("cuqui_noiteCrime:terminarExpurgacao", source)

end)

RegisterNetEvent("cuqui_noiteCrime:terminarExpurgacao")
AddEventHandler("cuqui_noiteCrime:terminarExpurgacao", function(source)
	TriggerServerEvent('noiteCrime:tiraBlackout', source)
	TriggerServerEvent('cuqui_noiteCrime:terminou', source)
end)


