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
src = {}
Tunnel.bindInterface("vrp_mdt",src)
vCLIENT = Tunnel.getInterface("vrp_mdt")

RegisterCommand("mdt",function(source,args,rawCommand)
	local usource = source
    	MySQL.Async.fetchAll("SELECT * FROM (SELECT * FROM `mdt_reports` ORDER BY `id` DESC LIMIT 3) sub ORDER BY `id` DESC", {}, function(reports)
    		for r = 1, #reports do
    			reports[r].charges = json.decode(reports[r].charges)
    		end
    		MySQL.Async.fetchAll("SELECT * FROM (SELECT * FROM `mdt_warrants` ORDER BY `id` DESC LIMIT 3) sub ORDER BY `id` DESC", {}, function(warrants)
    			for w = 1, #warrants do
    				warrants[w].charges = json.decode(warrants[w].charges)
    			end


    			local officer = GetCharacterName(usource)
    			TriggerClientEvent('mdt:toggleVisibilty', usource, reports, warrants, officer)
    		end)
    	end)
end)

RegisterServerEvent("mdt:hotKeyOpen")
AddEventHandler("mdt:hotKeyOpen", function()
	local usource = source
    	MySQL.Async.fetchAll("SELECT * FROM (SELECT * FROM `mdt_reports` ORDER BY `id` DESC LIMIT 3) sub ORDER BY `id` DESC", {}, function(reports)
    		for r = 1, #reports do
    			reports[r].charges = json.decode(reports[r].charges)
    		end
    		MySQL.Async.fetchAll("SELECT * FROM (SELECT * FROM `mdt_warrants` ORDER BY `id` DESC LIMIT 3) sub ORDER BY `id` DESC", {}, function(warrants)
    			for w = 1, #warrants do
    				warrants[w].charges = json.decode(warrants[w].charges)
    			end


    			local officer = GetCharacterName(usource)
    			TriggerClientEvent('mdt:toggleVisibilty', usource, reports, warrants, officer)
    		end)
    	end)
end)

RegisterServerEvent("mdt:getOffensesAndOfficer")
AddEventHandler("mdt:getOffensesAndOfficer", function()
	local usource = source
	local charges = {}
	MySQL.Async.fetchAll('SELECT * FROM fine_types', {
	}, function(fines)
		for j = 1, #fines do
			table.insert(charges, fines[j])
		end

		local officer = GetCharacterName(usource)

		TriggerClientEvent("mdt:returnOffensesAndOfficer", usource, charges, officer)
	end)
end)

RegisterServerEvent("mdt:performOffenderSearch")
AddEventHandler("mdt:performOffenderSearch", function(query)
	local usource = source
	local matches = {}

	MySQL.Async.fetchAll("SELECT * FROM `vrp_user_identities` WHERE LOWER(`name`) LIKE @query OR LOWER(`firstname`) LIKE @query OR CONCAT(LOWER(`name`), ' ', LOWER(`firstname`)) LIKE @query", {
		['@query'] = string.lower('%'..query..'%') -- % wildcard, needed to search for all alike results
	}, function(result)
		for index, data in ipairs(result) do
			table.insert(matches, data)
		end

		TriggerClientEvent("mdt:returnOffenderSearchResults", usource, matches)
	end)
end)

RegisterServerEvent("mdt:getOffenderDetails")
AddEventHandler("mdt:getOffenderDetails", function(offender)
	local usource = source
	-- GetLicenses(offender.identifier, function(licenses) offender.licenses = licenses end)
	-- while offender.licenses == nil do Citizen.Wait(0) end
	MySQL.Async.fetchAll('SELECT * FROM `user_mdt` WHERE `char_id` = @id', {
		['@id'] = offender.user_id
	}, function(result)
		offender.notes = ""
		offender.mugshot_url = ""
		if result[1] then
			offender.notes = result[1].notes
			offender.mugshot_url = result[1].mugshot_url
		end
		MySQL.Async.fetchAll('SELECT * FROM `user_convictions` WHERE `char_id` = @id', {
			['@id'] = offender.user_id
		}, function(convictions)
			if convictions[1] then
				offender.convictions = {}
				for i = 1, #convictions do
					local conviction = convictions[i]
					offender.convictions[conviction.offense] = conviction.count
				end
			end

			MySQL.Async.fetchAll('SELECT * FROM `mdt_warrants` WHERE `char_id` = @id', {
				['@id'] = offender.user_id
			}, function(warrants)
				if warrants[1] then
					offender.haswarrant = true
				end

				TriggerClientEvent("mdt:returnOffenderDetails", usource, offender)
			end)
		end)
	end)
end)

RegisterServerEvent("mdt:getOffenderDetailsById")
AddEventHandler("mdt:getOffenderDetailsById", function(char_id)
	local usource = source
	MySQL.Async.fetchAll('SELECT * FROM `vrp_user_identities` WHERE `user_id` = @id', {
		['@id'] = char_id
	}, function(result)
		local offender = result[1]
		MySQL.Async.fetchAll('SELECT * FROM `user_mdt` WHERE `char_id` = @id', {
			['@id'] = offender.user_id
		}, function(result)
			offender.notes = ""
			offender.mugshot_url = ""
			if result[1] then
				offender.notes = result[1].notes
				offender.mugshot_url = result[1].mugshot_url
			end
			MySQL.Async.fetchAll('SELECT * FROM `user_convictions` WHERE `char_id` = @id', {
				['@id'] = offender.user_id
			}, function(convictions)
				if convictions[1] then
					offender.convictions = {}
					for i = 1, #convictions do
						local conviction = convictions[i]
						offender.convictions[conviction.offense] = conviction.count
					end
				end

				TriggerClientEvent("mdt:returnOffenderDetails", usource, offender)
			end)
		end)

	end)
end)

RegisterServerEvent("mdt:saveOffenderChanges")
AddEventHandler("mdt:saveOffenderChanges", function(id, changes, identifier)
	MySQL.Async.fetchAll('SELECT * FROM `user_mdt` WHERE `char_id` = @id', {
		['@id']  = id
	}, function(result)
		if result[1] then
			MySQL.Async.execute('UPDATE `user_mdt` SET `notes` = @notes, `mugshot_url` = @mugshot_url WHERE `char_id` = @id', {
				['@id'] = id,
				['@notes'] = changes.notes,
				['@mugshot_url'] = changes.mugshot_url
			})
		else
			MySQL.Async.insert('INSERT INTO `user_mdt` (`char_id`, `notes`, `mugshot_url`) VALUES (@id, @notes, @mugshot_url)', {
				['@id'] = id,
				['@notes'] = changes.notes,
				['@mugshot_url'] = changes.mugshot_url
			})
		end

		for i = 1, #changes.licenses_removed do
			local license = changes.licenses_removed[i]
			MySQL.Async.execute('DELETE FROM `user_licenses` WHERE `type` = @type AND `owner` = @identifier', {
				['@type'] = license.type,
				['@identifier'] = identifier
			})
		end
		if changes.convictions then 
			for conviction, amount in pairs(changes.convictions) do	
				MySQL.Async.execute('UPDATE `user_convictions` SET `count` = @count WHERE `char_id` = @id AND `offense` = @offense', {
					['@id'] = id,
					['@count'] = amount,
					['@offense'] = conviction
				})
			end
		end

		for i = 1, #changes.convictions_removed do
			MySQL.Async.execute('DELETE FROM `user_convictions` WHERE `char_id` = @id AND `offense` = @offense', {
				['@id'] = id,
				['offense'] = changes.convictions_removed[i]
			})
		end
	end)
end)

RegisterServerEvent("mdt:saveReportChanges")
AddEventHandler("mdt:saveReportChanges", function(data)
	MySQL.Async.execute('UPDATE `mdt_reports` SET `title` = @title, `incident` = @incident WHERE `id` = @id', {
		['@id'] = data.id,
		['@title'] = data.title,
		['@incident'] = data.incident
	})
end)

RegisterServerEvent("mdt:deleteReport")
AddEventHandler("mdt:deleteReport", function(id)
	MySQL.Async.execute('DELETE FROM `mdt_reports` WHERE `id` = @id', {
		['@id']  = id
	})
end)

RegisterServerEvent("mdt:submitNewReport")
AddEventHandler("mdt:submitNewReport", function(data)
	local usource = source
	local author = GetCharacterName(source)
	if tonumber(data.sentence) and tonumber(data.sentence) > 0 then
		data.sentence = tonumber(data.sentence)
	else 
		data.sentence = nil 
	end
	charges = json.encode(data.charges)
	data.date = os.date('%m-%d-%Y %H:%M:%S', os.time())
	MySQL.Async.insert('INSERT INTO `mdt_reports` (`char_id`, `title`, `incident`, `charges`, `author`, `name`, `date`, `jailtime`) VALUES (@id, @title, @incident, @charges, @author, @name, @date, @sentence)', {
		['@id']  = data.char_id,
		['@title'] = data.title,
		['@incident'] = data.incident,
		['@charges'] = charges,
		['@author'] = author,
		['@name'] = data.name,
		['@date'] = data.date,
		['@sentence'] = data.sentence
	}, function(id)
		TriggerEvent("mdt:getReportDetailsById", id, usource)
	end)

	for offense, count in pairs(data.charges) do
		MySQL.Async.fetchAll('SELECT * FROM `user_convictions` WHERE `offense` = @offense AND `char_id` = @id', {
			['@offense'] = offense,
			['@id'] = data.char_id
		}, function(result)
			if result[1] then
				MySQL.Async.execute('UPDATE `user_convictions` SET `count` = @count WHERE `offense` = @offense AND `char_id` = @id', {
					['@id']  = data.char_id,
					['@offense'] = offense,
					['@count'] = count + 1
				})
			else
				MySQL.Async.insert('INSERT INTO `user_convictions` (`char_id`, `offense`, `count`) VALUES (@id, @offense, @count)', {
					['@id']  = data.char_id,
					['@offense'] = offense,
					['@count'] = count
				})
			end
		end)
	end
end)

function prison_lock(target_id)
	local player = vRP.getUserSource(parseInt(target_id))
	if player then
		SetTimeout(20000,function()
			local value = vRP.getUData(parseInt(target_id),"vRP:prisao")
			local tempo = json.decode(value) or 0
			if parseInt(tempo) >= 1 then
				TriggerClientEvent("Notify",player,"importante","Ainda vai passar <b>"..parseInt(tempo).." meses</b> preso.")
				vRP.setUData(parseInt(target_id),"vRP:prisao",json.encode(parseInt(tempo)-1))
				prison_lock(parseInt(target_id))
			elseif parseInt(tempo) == 0 then
				TriggerClientEvent('prisioneiro',player,false)
				vRPclient.teleport(player,1850.5,2604.0,45.5)
				vRP.setUData(parseInt(target_id),"vRP:prisao",json.encode(-1))
				TriggerClientEvent("Notify",player,"importante","Sua sentença terminou, esperamos não ve-lo novamente.")
			end
			vRPclient.PrisionGod(player)
		end)
	end
end

RegisterServerEvent("mdt:jailPlayer")
AddEventHandler("mdt:jailPlayer", function(usource, player, jailtime, jailmsg)
	local user_id = vRP.getUserId(usource)

	local playerId = vRP.getUserId(player)
	if player then
		vRP.setUData(parseInt(playerId),"vRP:prisao",json.encode(jailtime))
		vRPclient.setHandcuffed(player,false)
		TriggerClientEvent('prisioneiro',player,true)
		vRPclient.teleport(player,1680.1,2513.0,45.5)
		prison_lock(parseInt(playerId))
		TriggerClientEvent('removealgemas',player)
		TriggerClientEvent("vrp_sound:source",player,'jaildoor',0.7)
		TriggerClientEvent("vrp_sound:source",usource,'jaildoor',0.7)

		
		local oficialid = vRP.getUserIdentity(user_id)
		local identity = vRP.getUserIdentity(parseInt(playerId))
		local nplayer = vRP.getUserSource(parseInt(playerId))
				
		TriggerClientEvent("Notify",usource,"sucesso","Prisão efetuada com sucesso.")
		TriggerClientEvent("Notify",player,"importante","Você foi preso por <b>"..jailtime.." meses</b>.<br><b>Motivo:</b> "..jailmsg..".")
	end 
end)

RegisterServerEvent("mdt:billPlayer")
AddEventHandler("mdt:billPlayer", function(usource, player, finemsg, fine)
	local user_id = vRP.getUserId(usource)
	local playerId = vRP.getUserId(player)

	local value = vRP.getUData(playerId,"vRP:multas")
	local multas = json.decode(value) or 0
	vRP.setUData(playerId,"vRP:multas",json.encode(tonumber(multas)+tonumber(fine)))

	local oficialid = vRP.getUserIdentity(user_id)
	local identity = vRP.getUserIdentity(playerId)
	

	TriggerClientEvent("Notify",source,"sucesso","Multa aplicada com sucesso.")
	TriggerClientEvent("Notify",player,"importante","Você foi multado em <b>$"..vRP.format(tonumber(fine)).." dólares</b>.<br><b>Motivo:</b> "..finemsg..".")
end)

RegisterServerEvent("mdt:sentencePlayer")
AddEventHandler("mdt:sentencePlayer", function(jailtime, charges, char_id, fine, players)
	local usource = source
	local jailmsg = ""
	for offense, amount in pairs(charges) do
		jailmsg = jailmsg .. " "..offense.." x"..amount.." |"
	end

	for _, src in pairs(players) do
		if tonumber(src) ~= 0 and GetPlayerName(src) then
			MySQL.Async.fetchAll('SELECT * FROM `vrp_user_identities` WHERE `user_id` = @id', {
				['@id'] = char_id
			}, function(result)
				if result[1].user_id == char_id then
					if jailtime and tonumber(jailtime) > 0 then
						jailtime = math.ceil(jailtime)
						TriggerEvent("mdt:jailPlayer", usource, src, jailtime, jailmsg)
					end
					if tonumber(fine) > 0 then
						TriggerEvent("mdt:billPlayer", usource, src, 'Fine: '..jailmsg, fine)
					end
					return
				end
			end)
		end
	end
end)

RegisterServerEvent("mdt:performReportSearch")
AddEventHandler("mdt:performReportSearch", function(query)
	local usource = source
	local matches = {}
	MySQL.Async.fetchAll("SELECT * FROM `mdt_reports` WHERE `id` LIKE @query OR LOWER(`title`) LIKE @query OR LOWER(`name`) LIKE @query OR LOWER(`author`) LIKE @query or LOWER(`charges`) LIKE @query", {
		['@query'] = string.lower('%'..query..'%') -- % wildcard, needed to search for all alike results
	}, function(result)

		for index, data in ipairs(result) do
			data.charges = json.decode(data.charges)
			table.insert(matches, data)
		end

		TriggerClientEvent("mdt:returnReportSearchResults", usource, matches)
	end)
end)
vRP._prepare("mdt/user_identities","SELECT * FROM `vrp_user_identities` WHERE LOWER(`registration`) LIKE @query ")
vRP._prepare("mdt/user_vehicles","SELECT * FROM `vrp_user_vehicles` WHERE `user_id` = @id")

RegisterServerEvent("mdt:performVehicleSearch")
AddEventHandler("mdt:performVehicleSearch", function(query)
	local usource = source
	local matches = {}
	local identities = vRP.query("mdt/user_identities",{ query = string.lower('%'..query..'%') }) 
	for index, identity in ipairs(identities) do
		if identity then
			local cars = vRP.query("mdt/user_vehicles",{ id = identity.user_id }) 
			for index, car in ipairs(cars) do
				local data = {}
				data.registration = identity.registration
				data.owner = identity.name .. ' ' .. identity.firstname
				local tuning = vRP.getSData("custom:u"..identity.user_id.."veh_"..car.vehicle) or {}
				local data_decoded = json.decode(tuning) or {}
				data.modelhash = car.vehicle
				if data_decoded.color then 
					if data_decoded.color[1] then
						data.color = colors[tostring(data_decoded.color[1])]
						if colors[tostring(data_decoded.color[2])] then
							data.color = colors[tostring(data_decoded.color[2])] .. " on " .. colors[tostring(data_decoded.color[1])]
						end
					end
				end
				table.insert(matches, data)
			end
		end
	end
	TriggerClientEvent("mdt:returnVehicleSearchResults", usource, matches)
end)

RegisterServerEvent("mdt:performVehicleSearchInFront")
AddEventHandler("mdt:performVehicleSearchInFront", function(query)
	local usource = source
		MySQL.Async.fetchAll("SELECT * FROM `owned_vehicles` WHERE `plate` = @query", {
			['@query'] = query
		}, function(result)
			TriggerClientEvent("mdt:toggleVisibilty", usource)
			TriggerClientEvent("mdt:returnVehicleSearchInFront", usource, result, query)
		end)
end)

RegisterServerEvent("mdt:getVehicle")
AddEventHandler("mdt:getVehicle", function(vehicle)
	local usource = source

	MySQL.Async.fetchAll("SELECT * FROM `vrp_user_identities` WHERE `registration` = @query", {
		['@query'] = vehicle.registration
	}, function(result)
		if result[1] then
			vehicle.owner_id = result[1].user_id
		end

		-- vehicle.type = types[vehicle.type]
		TriggerClientEvent("mdt:returnVehicleDetails", usource, vehicle)
	end)
end)

RegisterServerEvent("mdt:getWarrants")
AddEventHandler("mdt:getWarrants", function()
	local usource = source
	MySQL.Async.fetchAll("SELECT * FROM `mdt_warrants`", {}, function(warrants)
		for i = 1, #warrants do
			warrants[i].expire_time = ""
			warrants[i].charges = json.decode(warrants[i].charges)
		end
		TriggerClientEvent("mdt:returnWarrants", usource, warrants)
	end)
end)

RegisterServerEvent("mdt:submitNewWarrant")
AddEventHandler("mdt:submitNewWarrant", function(data)
	local usource = source
	data.charges = json.encode(data.charges)
	data.author = GetCharacterName(source)
	data.date = os.date('%m-%d-%Y %H:%M:%S', os.time())
	MySQL.Async.insert('INSERT INTO `mdt_warrants` (`name`, `char_id`, `report_id`, `report_title`, `charges`, `date`, `expire`, `notes`, `author`) VALUES (@name, @char_id, @report_id, @report_title, @charges, @date, @expire, @notes, @author)', {
		['@name']  = data.name,
		['@char_id'] = data.char_id,
		['@report_id'] = data.report_id,
		['@report_title'] = data.report_title,
		['@charges'] = data.charges,
		['@date'] = data.date,
		['@expire'] = data.expire,
		['@notes'] = data.notes,
		['@author'] = data.author
	}, function()
		TriggerClientEvent("mdt:completedWarrantAction", usource)
	end)
end)

RegisterServerEvent("mdt:deleteWarrant")
AddEventHandler("mdt:deleteWarrant", function(id)
	local usource = source
	MySQL.Async.execute('DELETE FROM `mdt_warrants` WHERE `id` = @id', {
		['@id']  = id
	}, function()
		TriggerClientEvent("mdt:completedWarrantAction", usource)
	end)
end)

RegisterServerEvent("mdt:getReportDetailsById")
AddEventHandler("mdt:getReportDetailsById", function(query, _source)
	if _source then source = _source end
	local usource = source
	MySQL.Async.fetchAll("SELECT * FROM `mdt_reports` WHERE `id` = @query", {
		['@query'] = query
	}, function(result)
		if result and result[1] then
			result[1].charges = json.decode(result[1].charges)
			TriggerClientEvent("mdt:returnReportDetails", usource, result[1])
		end
	end)
end)

function GetLicenses(identifier, cb)
	MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @owner', {
		['@owner'] = identifier
	}, function(result)
		local licenses   = {}
		local asyncTasks = {}

		for i=1, #result, 1 do

			local scope = function(type)
				table.insert(asyncTasks, function(cb)
					MySQL.Async.fetchAll('SELECT * FROM licenses WHERE type = @type', {
						['@type'] = type
					}, function(result2)
						table.insert(licenses, {
							type  = type,
							label = result2[1].label
						})

						cb()
					end)
				end)
			end

			scope(result[i].type)

		end

		Async.parallel(asyncTasks, function(results)
			if #licenses == 0 then licenses = false end
			cb(licenses)
		end)

	end)
end

function GetCharacterName(source)
	local userID = vRP.getUserId(source)

	local result = MySQL.Sync.fetchAll('SELECT name, firstname FROM vrp_user_identities WHERE user_id = @id', {
		['@id'] = userID
	})

	if result[1] and result[1].name and result[1].firstname then
		return ('%s %s'):format(result[1].name, result[1].firstname)
	end
end

function tprint (tbl, indent)
  if not indent then indent = 0 end
  local toprint = string.rep(" ", indent) .. "{\r\n"
  indent = indent + 2 
  for k, v in pairs(tbl) do
    toprint = toprint .. string.rep(" ", indent)
    if (type(k) == "number") then
      toprint = toprint .. "[" .. k .. "] = "
    elseif (type(k) == "string") then
      toprint = toprint  .. k ..  "= "   
    end
    if (type(v) == "number") then
      toprint = toprint .. v .. ",\r\n"
    elseif (type(v) == "string") then
      toprint = toprint .. "\"" .. v .. "\",\r\n"
    elseif (type(v) == "table") then
      toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
    else
      toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
    end
  end
  toprint = toprint .. string.rep(" ", indent-2) .. "}"
  return toprint
end