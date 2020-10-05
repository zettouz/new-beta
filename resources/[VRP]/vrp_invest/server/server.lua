local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")



Cache = {}

--[[

MySQL.Sync.execute("UPDATE `invest` SET amount=(amount/100*(100-@lost)) WHERE active=1 AND job=@label", {
    ["@label"] = v.label,
    ["@lost"] = Config.Stock.Lost
})

]]

vRP._prepare("vRP/set_amount","UPDATE `vrp_invest` SET amount=(amount/100*(100-@lost)) WHERE active=1 AND job=@label")
vRP._prepare("vRP/select_invest","SELECT amount FROM vrp_invest WHERE identifier = @id AND active=1")
vRP._prepare("vRP/get_companies","SELECT * FROM vrp_companies")
vRP._prepare("vRP/update_companies","UPDATE vrp_companies SET investRate = @rate WHERE label = @label")
vRP._prepare("vRP/get_inf","SELECT * FROM vrp_invest WHERE identifier = @id AND active=1 AND job = @job LIMIT 1")
vRP._prepare("vRP/get_result","SELECT vrp_invest.*, vrp_companies.investRate FROM vrp_invest INNER JOIN vrp_companies ON vrp_invest.job = vrp_companies.label WHERE identifier = @id AND active=1 AND job=@job")
vRP._prepare("vRP/up_inf","UPDATE vrp_invest SET amount = amount+@num WHERE identifier = @id AND active=1 AND job = @job")
vRP._prepare("vRP/ins_inf","INSERT INTO vrp_invest (identifier, job, amount, rate) VALUES (@id, @job, @amount, @rate)")
vRP._prepare("vRP/upt_if","UPDATE vrp_invest SET active=0, sold=now(), soldAmount = @money, rate = @rate WHERE id = @id")
vRP._prepare("vRP/updt_companies","UPDATE vrp_companies SET investRate = @invest, rate=@rate WHERE label=@label")
vRP._prepare("vRP/get_invst","SELECT vrp_invest.*, vrp_companies.name,vrp_companies.investRate,vrp_companies.label FROM vrp_invest INNER JOIN vrp_companies ON vrp_invest.job = vrp_companies.label WHERE vrp_invest.identifier=@id")
vRP._prepare("vRP/get_invst2","SELECT vrp_invest.*, vrp_companies.name,vrp_companies.investRate,vrp_companies.label FROM vrp_invest INNER JOIN vrp_companies ON vrp_invest.job = vrp_companies.label WHERE vrp_invest.identifier = @id AND vrp_invest.active=1")
vRP._prepare("vRP/upt_inf","UPDATE vrp_invest SET active=0, sold=now(), soldAmount=@money, rate=@rate WHERE `id`=@id")
-- Get balance of invested companies
RegisterServerEvent("invest:balance")
AddEventHandler("invest:balance", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local user = vRP.query("vRP/select_invest",{id = user_id})
    local identity = vRP.getUserIdentity(user_id)
    local invested = 0
    local nome = identity.name.." "..identity.firstname
    for k, v in pairs(user) do
        invested = invested + v.amount
    end
    TriggerClientEvent("invest:nui", source, {type = "balance",player = nome ,balance = invested})
end)

RegisterServerEvent("invest:list")
AddEventHandler("invest:list", function()
    TriggerClientEvent("invest:nui", source,{type = "list",cache = Cache})
end)

RegisterServerEvent("invest:all")
AddEventHandler("invest:all", function(special)
    local source = source
    local user_id = vRP.getUserId(source)
    local user

    if (special) then 
        user = vRP.query("vRP/get_invst2",{id = user_id})
    else
        user = vRP.query("vRP/get_invst",{id = user_id})
    end

    if(special) then
        TriggerClientEvent("invest:nui", source, {type = "sell", cache = user})
    else 
        TriggerClientEvent("invest:nui", source, {type = "all", cache = user})
    end
end)

-- Invest into a job
RegisterServerEvent("invest:buy")
AddEventHandler("invest:buy", function(job, amount, rate)
    local source = source
    local user_id = vRP.getUserId(source)
    local bank = vRP.getBankMoney(user_id)
    amount = tonumber(amount)
    local inf = vRP.query("vRP/get_inf",{id = user_id, job = job})
    for k, v in pairs(inf) do 
        inf = v 
 
    end

    if amount > 10000 then
        TriggerClientEvent("Notify",source,"aviso","Você atingiu o limite de investimento.")
        return
    end

    if inf.amount ~= nil then
     local checkInvest = amount + tonumber(inf.amount)
        if checkInvest > 10000 then
            TriggerClientEvent("Notify",source,"aviso","Você atingiu o limite de investimento nesta empresa.")
            return
        end
    end
    if (amount == nil or amount <= 0) then
        TriggerClientEvent("Notify",source,"aviso","Você precisa inserir um valor <u>válido</u>.")
        return
    else
        if (bank < amount) then
            TriggerClientEvent("Notify",source,"aviso","Você não possui dinheiro suficiente em sua conta bancária.")
            return
        end
    end

    if (type(inf) == "table" and inf.job ~= nil) then
        vRP.execute("vRP/up_inf", {num = amount, id = user_id, job = job })
        TriggerClientEvent("Notify",source,"bom","Você comprou mais ações da empresa: "..job)
    else
        if rate == nil then
            TriggerClientEvent("Notify",source,"aviso","Ocorreu um erro, tente novamente.")
            return
        end
        vRP.execute("vRP/ins_inf",{id = user_id, job = job, amount = amount, rate = rate})
        TriggerClientEvent("Notify",source,"bom","Você comprou <b>R$: "..amount.."</b> em ações da empresa: <u>"..job.."</u>.")
    end
    vRP.tryFullPayment(user_id,amount)
    TriggerEvent(source, "invest:balance")
end)

RegisterServerEvent("invest:sell")
AddEventHandler("invest:sell", function(job)
    local source = source
    local job = job
    local user_id = vRP.getUserId(source)
    local result = vRP.query("vRP/get_result",{id = user_id, job = job})

    for k, v in pairs(result) do 
        result = v
    end
    local amount = result.amount
    local sellRate = result.investRate - result.rate
    local addMoney = amount + ((sellRate * amount) / 100)
    vRP.execute("vRP/upt_inf",{id = result.id, money = addMoney, rate = sellRate})
    if (addMoney > 0) then
        vRP.giveBankMoney(user_id,parseInt(addMoney))
        TriggerClientEvent("Notify",source,"bom","Você recebeu <b>R$: "..parseInt(addMoney).."</b>.")
    end
    TriggerEvent(source, "invest:balance")
end)



AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    function loopUpdate()
        Citizen.Wait(60000*Config.Stock.Time)
        local companies = vRP.query("vRP/get_companies")
        for k, v in pairs(companies) do
            newRate = genRand(Config.Stock.Minimum, Config.Stock.Maximum, 2)
            
            local rate = "stale"
            if newRate > v.investRate then
                rate = "up"
            elseif newRate < v.investRate then
                rate = "down"
            end
            if (Config.Stock.Lost ~= 0 and newRate < 0) then
                vRP.execute("vRP/set_amount", { label = v.label, lost = Config.Stock.Lost})
            end

            vRP.execute("vRP/updt_companies",{invest = newRate, label = v.label, rate = rate})
            Cache[v.label] = {stock = newRate, rate = rate, label = v.label, name = v.name}
        end
        loopUpdate()
    end

    Citizen.Wait(0)

    local companies = vRP.query("vRP/get_companies")
    
    for k, v in pairs(companies) do
        if(v.investRate == nil) then
            v.investRate = genRand(Config.Stock.Minimum, Config.Stock.Maximum, 2)
            vRP.execute("vRP/update_companies",{rate = v.investRate, label = v.label})
        end
        Cache[v.label] = {stock = v.investRate, rate = v.rate, label = v.label, name = v.name}
    end

    loopUpdate()
end)

function genRand(min, max, decimalPlaces)
    local rand = math.random()*(max-min) + min
    local power = math.pow(10, decimalPlaces)
    return math.floor(rand*power) / power
end