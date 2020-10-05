-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("vrp_spawn",cRP)
vCLIENT = Tunnel.getInterface("vrp_spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCHARS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_spawn:setupChars")
AddEventHandler("vrp_spawn:setupChars",function(source)
	local source = source
	local steam = vRP.getSteam(source)

	Citizen.Wait(1000)
	TriggerClientEvent("vrp_spawn:setupUI",source,getPlayerCharacters(steam))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
local spawnLogin = {}
RegisterServerEvent("vrp_spawn:charChosen")
AddEventHandler("vrp_spawn:charChosen",function(id)
	local source = source
	TriggerClientEvent("densityActived", source)


	TriggerEvent("baseModule:idLoaded",source,id)

	if spawnLogin[parseInt(id)] then
		TriggerClientEvent("vrp_spawn:spawnChar",source,false)
	else
		spawnLogin[parseInt(id)] = true
		TriggerClientEvent("vrp_spawn:spawnChar",source,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATECHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_spawn:b2k:createNewChar")
AddEventHandler("vrp_spawn:b2k:createNewChar",function()
	local source = source
	local steam = vRP.getSteam(source)
	local persons = getPlayerCharacters(steam)

	local registration = vRP.generateRegistrationNumber()
	local phone = vRP.generatePhoneNumber()
	vRP.execute("vRP/init_user_identity",{ steam = steam, registration = registration, phone = phone, name = "Individuo", firstname = "Indigente" })

	local newId = vRP.getUserByRegistration(registration)

	TriggerEvent("baseModule:idLoaded",source,newId)
	vRP.execute("vRP/set_rg",{ user_id = parseInt(newId), timephone = parseInt(os.time()) })

	-- save barbershop
	Citizen.Wait(1000)
	vRP.setUData(parseInt(newId),"backup:CharID", 1)

	TriggerClientEvent("b2k-character:createChar", source)
	TriggerClientEvent("b2k-character:characterCreate", source)
	--TriggerClientEvent("hudActived",source)

	if vRP.getInventoryItemAmount(newId,"identidade") <= 0 then
		vRP.giveInventoryItem(newId,"identidade",1)
	end
end)



RegisterServerEvent("vrp_spawn:b2k:updateNewChar")
AddEventHandler("vrp_spawn:b2k:updateNewChar",function(name,name2,currentCharacterMode)
	local source = source
	local steam = vRP.getSteam(source)
	local user_id = vRP.getUserId(source)

	vRP.execute("vRP/update_user_created",{ id = user_id, name = name, firstname = name2 })

	Citizen.Wait(1000)
	vRP.execute("vRP/updateSkinCharacter",{ user_id = parseInt(user_id), char_id = 1,
		fathers = parseInt(currentCharacterMode.fathersID),
		kinship = parseInt(currentCharacterMode.mothersID),
		eyecolor = parseInt(currentCharacterMode.eyesColor),
		skincolor = parseInt(currentCharacterMode.skinColor),
		acne = parseInt(currentCharacterMode.blemishesModel),
		stains = parseInt(currentCharacterMode.complexionModel),
		freckles = parseInt(currentCharacterMode.frecklesModel),
		aging = parseInt(currentCharacterMode.ageingModel),
		hair = parseInt(currentCharacterMode.hairModel),
		haircolor = parseInt(currentCharacterMode.firstHairColor),
		haircolor2 = parseInt(currentCharacterMode.secondHairColor),
		makeup = parseInt(currentCharacterMode.makeupModel),
		makeupintensity = parseInt(10),
		makeupcolor = 0,
		lipstick = parseInt(currentCharacterMode.lipstickModel),
		lipstickintensity = 10,
		lipstickcolor = parseInt(currentCharacterMode.lipstickColor),
		eyebrow = parseInt(currentCharacterMode.eyebrowsModel),
		eyebrowintensity = 10,
		eyebrowcolor = parseInt(currentCharacterMode.eyebrowsColor),
		beard = parseInt(currentCharacterMode.beardModel),
		beardintentisy = 10,
		beardcolor = parseInt(currentCharacterMode.beardColor),
		blush = parseInt(currentCharacterMode.blushModel),
		blushintentisy = 10,
		blushcolor = parseInt(currentCharacterMode.blushColor),

		shapemix = currentCharacterMode.shapeMix,
        eyebrowsheight = currentCharacterMode.eyebrowsHeight,
        eyebrowswidth = currentCharacterMode.eyebrowsWidth,
        nosewidth = currentCharacterMode.noseWidth,
        noseheight = currentCharacterMode.noseHeight,
        noselength = currentCharacterMode.noseLength,
        nosebridge = currentCharacterMode.noseBridge,
        nosetip = currentCharacterMode.noseTip,
        noseshift = currentCharacterMode.noseShift,
        cheekboneheight = currentCharacterMode.cheekboneHeight,
        cheekbonewidth = currentCharacterMode.cheekboneWidth,
        cheekswidth = currentCharacterMode.cheeksWidth,
        lipswidth = currentCharacterMode.lips,
        jawwidth = currentCharacterMode.jawWidth,
        jawheight = currentCharacterMode.jawHeight,
        chinlength = currentCharacterMode.chinLength,
        chinposition = currentCharacterMode.chinPosition,
        chinwidth = currentCharacterMode.chinWidth,
        chinshape = currentCharacterMode.chinShape,
        neckwidth = currentCharacterMode.neckWidth,
        chestmodel = currentCharacterMode.chestModel,
        chestcolor = currentCharacterMode.chestColor,
        sundamagemodel = currentCharacterMode.sundamageModel
	})

	TriggerClientEvent("vrp:forceUpdateCust", source)
	Citizen.Wait(1000)

	spawnLogin[parseInt(user_id)] = true
	TriggerClientEvent("densityActived",source)
	TriggerClientEvent("vrp_spawn:spawnChar",source,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETECHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_spawn:deleteChar")
AddEventHandler("vrp_spawn:deleteChar",function(id)
	local source = source
	local steam = vRP.getSteam(source)

	vRP.execute("vRP/remove_characters",{ id = id })
	TriggerClientEvent("vrp_spawn:reloadChars",source,getPlayerCharacters(steam))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERCHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function getPlayerCharacters(steam)
	return vRP.query("vRP/get_characters",{ steam = steam })
end