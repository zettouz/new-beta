local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local idgens = Tools.newIDGenerator()

src = {}
Tunnel.bindInterface("vrp_player",src)

vDIAGNOSTIC = Tunnel.getInterface("vrp_diagnostic")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ WEBHOOK ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookgive = "SEUWEBHOOK"
local webhookgarmas = "SEUWEBHOOK"
local webhookgarmas250 = "SEUWEBHOOK"
local webhookequipar = "SEUWEBHOOK"
local webhookenviaritem = "SEUWEBHOOK"
local webhookenviardinheiro = "SEUWEBHOOK"
local webhookdropar = "SEUWEBHOOK"
local webhookpaypal = "SEUWEBHOOK"
--local webhookgive = "SEUWEBHOOK"
local webhooksaquear = "SEUWEBHOOK"
--local webhookgcoletej = "SEUWEBHOOK"
local webhookvidaroupas = "SEUWEBHOOK"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CHECK ROUPAS ]-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkRoupas()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,"vip.permissao") then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui <b>Roupas ou Acessórios</b> na mochila.") 
			return false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CHECK ACESSORIOS ]-------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
--[[function src.checkMascara()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"mascara") >= 1 or vRP.hasPermission(user_id,"vip.permissao") then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui uma <b>máscara</b> em sua mochila.") 
			return false
		end
	end
end

function src.checkOculos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"oculos") >= 1 or vRP.hasPermission(user_id,"vip.permissao") then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui um <b>óculos</b> em sua mochila.") 
			return false
		end
	end
end

function src.checkChapeu()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"chapeu") >= 1 or vRP.hasPermission(user_id,"vip.permissao") then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui um <b>chapéu</b> em sua mochila.") 
			return false
		end
	end
end

function src.checkSapatos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"sapatos") >= 1 or vRP.hasPermission(user_id,"vip.permissao") then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui <b>sapatos</b> em sua mochila.") 
			return false
		end
	end
end]]--
-----------------------------------------------------------------------------------------------------------------------------------------
-- /COBRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cobrar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local consulta = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(consulta)
	local resultado = json.decode(consulta) or 0
	local banco = vRP.getBankMoney(nuser_id)
	local identity =  vRP.getUserIdentity(user_id)
	local identityu = vRP.getUserIdentity(nuser_id)
	if vRP.request(consulta,"Deseja pagar <b>$"..vRP.format(parseInt(args[1])).."</b> dólares para <b>"..identity.name.." "..identity.firstname.."</b>?",30) then    
		if banco >= parseInt(args[1]) then
			if parseInt(args[1]) < 0 then
				vRPclient.setHealth(source,10)
				TriggerClientEvent("Notify",source,"negado","Oh bom, o <b>Jackson</b> já arrumou esse bug, e de presente, vai arrumar seu <b>BAN</b> seu merda.")
				return
			end
			vRP.setBankMoney(nuser_id,parseInt(banco-args[1]))
			vRP.giveBankMoney(user_id,parseInt(args[1]))
			
			vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>$"..vRP.format(parseInt(args[1])).." dólares</b> de <b>"..identityu.name.. " "..identityu.firstname.."</b>.")
			vRPclient._playAnim(nuser_id,true,{{"mp_common","givetake1_a"}},false)				
			local player = vRP.getUserSource(parseInt(args[2]))
			if player == nil then
				return
			else
				local identity = vRP.getUserIdentity(user_id)
				TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> transferiu <b>$"..vRP.format(parseInt(args[1])).." dólares</b> para sua conta.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ITEMLIST ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	---------------------------------------------------------------------------------------------------
	--[ Ultilitários legais ]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["mochila"] = { index = "mochila", nome = "Mochila" },
	["celular"] = { index = "celular", nome = "iFruit XI" },
	["radio"] = { index = "radio", nome = "WalkTalk" },
	["mascara"] = { index = "mascara", nome = "Mascara" },
	["identidade"] = { index = "identidade", nome = "Identidade" },
	["colete"] = { index = "colete", nome = "Colete Balístico" },
	["militec"] = { index = "militec", nome = "Militec" },
	["repairkit"] = { index = "repairkit", nome = "Kit de Reparos" },
	["roupas"] = { index = "roupas", nome = "Roupas" },
	["mascara"] = { index = "mascara", nome = "Mascara" },
	["oculos"] = { index = "oculos", nome = "Oculos" },
	["plus"] = { index = "plus", nome = "Pass Plus" },
	["advanced"] = { index = "advanced", nome = "Pass Advanced" },
	["standard"] = { index = "standard", nome = "Pass Standard" },
	---------------------------------------------------------------------------------------------------
	--[ Ultilitários Ilegais]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["dinheiro-sujo"] = { index = "dinheiro-sujo", nome = "Dinheiro Sujo" },
	["algema"] = { index = "algema", nome = "Algema" },
	["lockpick"] = { index = "lockpick", nome = "Lockpick" },
	["capuz"] = { index = "capuz", nome = "Capuz" },
	["placa"] = { index = "placa", nome = "Placa" },
	["c4"] = { index = "c4", nome = "C4 Completa" },
	["serra"] = { index = "serra", nome = "Serra" },
	["furadeira"] = { index = "furadeira", nome = "Furadeira" },
	["raceticket"] = { index = "raceticket", nome = "Race Ticket" },
	---------------------------------------------------------------------------------------------------
	--[ Ultilitários NOVOS BAHAMAS]--------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["losna"] = { index = "losna", nome = "Losna" },
	["anis"] = { index = "anis", nome = "Anis" },
	["funcho"] = { index = "funcho", nome = "Funcho" },
	["ervas"] = { index = "ervas", nome = "Ervas" },
	["acucar"] = { index = "acucar", nome = "Açucar" },
	["taca"] = { index = "taca", nome = "Taça" },
	["preabsinto-alta"] = { index = "preabsinto-alta", nome = "Pre-Absinto HQ" },
	["absinto-baixa"] = { index = "absinto-baixa", nome = "Absinto BQ" },
	["absinto-media"] = { index = "absinto-media", nome = "Absinto MQ" },
	["absinto-alta"] = { index = "absinto-alta", nome = "Absinto HQ" },
	---------------------------------------------------------------------------------------------------
	--[ Ultilitários NOVOS VANILLA]--------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["balahalls"] = { index = "balahalls", nome = "Bala Halls" },
	["gelo"] = { index = "gelo", nome = "Gelo" },
	["codeina"] = { index = "codeina", nome = "Codeina" },
	["refrigerante"] = { index = "refrigerante", nome = "Refrigerante" },
	["alcool"] = { index = "alcool", nome = "Alcool" },
	["copo"] = { index = "copo", nome = "Copo" },
	["prelean-alta"] = { index = "prelean-alta", nome = "Pre-Lean HQ" },
	["lean-baixa"] = { index = "lean-baixa", nome = "Lean BQ" },
	["lean-media"] = { index = "lean-media", nome = "Lean MQ" },
	["lean-alta"] = { index = "lean-alta", nome = "Lean HQ" },
	---------------------------------------------------------------------------------------------------
	--[ Ultilitários Ilegais]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["fita"] = { index = "fita", nome = "Fita" },
	["fios"] = { index = "fios", nome = "Fios" },
	["controle"] = { index = "controle", nome = "Controle" },
	["armacaodefuradeira"] = { index = "armacaodefuradeira", nome = "Armação de Furadeira" },
	["broca"] = { index = "broca", nome = "Broca" },
	["ferrob"] = { index = "ferrob", nome = "Ferro" },
	["armacaodeserra"] = { index = "armacaodeserra", nome = "Armação de Serra" },
	["disco"] = { index = "disco", nome = "Disco" },
	["pano"] = { index = "pano", nome = "Pano" },
	["corda"] = { index = "corda", nome = "Corda" },
	["keycard"] = { index = "keycard", nome = "Cartão Roubo" },
	["chave"] = { index = "chave", nome = "Chave" },
	["pendrivebanco"] = { index = "pendrive2", nome = "Pendrive Roubo" },
	["c4b"] = { index = "c4b", nome = "C4 Básica" },
	["pendrive2"] = { index = "pendrivebanco", nome = "Pendrive Reutilizável" },
	["keycard2"] = { index = "keycard2", nome = "Cartão Reutilizável" },
	---------------------------------------------------------------------------------------------------
	--[ Ultilitários Corrida]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["arame"] = { index = "arame", nome = "Arame" },
	["tinta"] = { index = "tinta", nome = "Tinta" },
	["papel"] = { index = "papel", nome = "Papel" },
	["caneta"] = { index = "caneta", nome = "Caneta" },
	["cilindro"] = { index = "cilindro", nome = "Cilindro" },
	["gas"] = { index = "gas", nome = "Gás" },
	---------------------------------------------------------------------------------------------------
	--[ Empregos ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["diamante"] = { index = "diamante", nome = "Min. Diamante" },
	["ouro"] = { index = "ouro", nome = "Min. Ouro" },
	["bronze"] = { index = "bronze", nome = "Min. Bronze" },
	["ferro"] = { index = "ferro", nome = "Min. Ferro" },
	["rubi"] = { index = "rubi", nome = "Min. Rubi" },
	["esmeralda"] = { index = "esmeralda", nome = "Min. Esmeralda" },
	["safira"] = { index = "safira", nome = "Min. Safira" },
	["topazio"] = { index = "topazio", nome = "Min. Topazio" },
	["ametista"] = { index = "ametista", nome = "Min. Ametista" },
	["diamante2"] = { index = "diamante2", nome = "Diamante" },
	["ouro2"] = { index = "ouro2", nome = "Ouro" },
	["bronze2"] = { index = "bronze2", nome = "Bronze" },
	["ferro2"] = { index = "ferro2", nome = "Ferro" },
	["rubi2"] = { index = "rubi2", nome = "Rubi" },
	["esmeralda2"] = { index = "esmeralda2", nome = "Esmeralda" },
	["safira2"] = { index = "safira2", nome = "Safira" },
	["topazio2"] = { index = "topazio2", nome = "Topazio" },
	["ametista2"] = { index = "ametista2", nome = "Ametista" },
	["sacodelixo"] = { index = "sacodelixo", nome = "Saco de lixo" },
	["garrafadeleite"] = { index = "garrafadeleite", nome = "Garrafa de leite" },
	["garrafavazia"] = { index = "garrafavazia", nome = "Garrafa vazia" },
	["encomenda"] = { index = "encomenda", nome = "Encomenda" },
	["tora"] = { index = "tora", nome = "Tora" },
	["laranja"] = { index = "laranja", nome = "Laranja" },
	---------------------------------------------------------------------------------------------------
	--[ Bebidas Não Alcoólicas ]-----------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["agua"] = { index = "agua", nome = "Água" },
	["leite"] = { index = "leite", nome = "Leite" },
	["cafe"] = { index = "cafe", nome = "Café" },
	["cafecleite"] = { index = "cafecleite", nome = "Café com leite" },
	["cafeexpresso"] = { index = "cafeexpresso", nome = "Café Expresso" },
	["capuccino"] = { index = "capuccino", nome = "Capuccino" },
	["frappuccino"] = { index = "frappuccino", nome = "Frapuccino" },
	["cha"] = { index = "cha", nome = "Chá" },
	["icecha"] = { index = "icecha", nome = "Chá Gelado" },
	["sprunk"] = { index = "sprunk", nome = "Sprunk" },
	["cola"] = { index = "cola", nome = "Cola" },
	["energetico"] = { index = "energetico", nome = "Energético" },
	---------------------------------------------------------------------------------------------------
	--[ Bebidas Alcoólicas ]---------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["pibwassen"] = { index = "pibwassen", nome = "PibWassen" },
	["tequilya"] = { index = "tequilya", nome = "Tequilya" },
	["patriot"] = { index = "patriot", nome = "Patriot" },
	["blarneys"] = { index = "blarneys", nome = "Blarneys" },
	["jakeys"] = { index = "jakeys", nome = "Jakeys" },
	["barracho"] = { index = "barracho", nome = "Barracho" },
	["ragga"] = { index = "ragga", nome = "Ragga" },
	["nogo"] = { index = "nogo", nome = "Nogo" },
	["mount"] = { index = "mount", nome = "Mount" },
	["cherenkov"] = { index = "cherenkov", nome = "Cherenkov" },
	["bourgeoix"] = { index = "bourgeoix", nome = "Bourgeoix" },
	["bleuterd"] = { index = "bleuterd", nome = "Bleuterd" },
	---------------------------------------------------------------------------------------------------
	--[ Comidas de FastFood ]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["sanduiche"] = { index = "sanduiche", nome = "Sanduíche" },
	["rosquinha"] = { index = "rosquinha", nome = "Rosquinha" },
	["hotdog"] = { index = "hotdog", nome = "HotDog" },
	["xburguer"] = { index = "xburguer", nome = "xBurguer" },
	["chips"] = { index = "chips", nome = "Batata Chips" },
	["batataf"] = { index = "batataf", nome = "Batata Frita" },
	["pizza"] = { index = "pizza", nome = "Pedaço de Pizza" },
	["frango"] = { index = "frango", nome = "Frango Frito" },
	["bcereal"] = { index = "bcereal", nome = "Barra de Cereal" },
	["bchocolate"] = { index = "bchocolate", nome = "Barra de Chocolate" },
	["taco"] = { index = "taco", nome = "Taco" },
	["yakisoba"] = { index = "yakisoba", nome = "Yakisoba" },
	["isca"] = { index = "isca", nome = "Isca" },
	["dourado"] = { index = "dourado", nome = "Dourado" },
	["corvina"] = { index = "corvina", nome = "Corvina" },
	["salmao"] = { index = "salmao", nome = "Salmão" },
	["pacu"] = { index = "pacu", nome = "Pacu" },
	["pintado"] = { index = "pintado", nome = "Pintado" },
	["pirarucu"] = { index = "pirarucu", nome = "Pirarucu" },
	["tilapia"] = { index = "tilapia", nome = "Tilápia" },
	["tucunare"] = { index = "tucunare", nome = "Tucunaré" },
	["lambari"] = { index = "lambari", nome = "Lambari" },
	---------------------------------------------------------------------------------------------------
	--[ Remédios ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["xarelto"] = { index = "xarelto", nome = "Xarelto" },
	["dipirona"] = { index = "dipirona", nome = "Dipirona" },
	["tandrilax"] = { index = "tandrilax", nome = "Tandrilax" },
	["dorflex"] = { index = "dorflex", nome = "Dorflex" },
	["buscopan"] = { index = "buscopan", nome = "Buscopan" },
	["nebacetin"] = { index = "nebacetin", nome = "Nebacetin" },
	["hirudoid"] = { index = "hirudoid", nome = "Hirudoid" },
	---------------------------------------------------------------------------------------------------
	--[ Receitas ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["r-xarelto"] = { index = "r-xarelto", nome = "Receituário Xarelto" },
	["r-nebacetin"] = { index = "r-nebacetin", nome = "Receituário Nebacetin" },
	["r-tandrilax"] = { index = "r-tandrilax", nome = "Receituário Tandrilax" },
	["r-dipirona"] = { index = "r-dipirona", nome = "Receituário Dipirona" },
	["r-dorflex"] = { index = "r-dorflex", nome = "Receituário Dorflex" },
	["r-buscopan"] = { index = "r-buscopan", nome = "Receituário Buscopan" },
	["r-hirudoid"] = { index = "r-hirudoid", nome = "Receituário Hirudoid" },
	--------------------------------------------------------------------------------------------------
	--[ Organização Criminosa de Drogas 01 ]-----------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["meta-alta"] = { index = "meta-alta", nome = "Metanfetamina HQ" }, -- 8 Processos;
	["meta-media"] = { index = "meta-media", nome = "Metanfetamina MQ" }, -- 4 Processos;
	["meta-baixa"] = { index = "meta-baixa", nome = "Metanfetamina LQ" }, -- 2 Processos;
	--[ Sub produto ]----------------------------------------------------------------------------------
	["composito-alta"] = { index = "composito-alta", nome = "Compósito HQ" },
	["composito-media"] = { index = "composito-media", nome = "Compósito MQ" },
	["composito-baixa"] = { index = "composito-baixa", nome = "Compósito LQ" },
	--[ Ingredientes ]---------------------------------------------------------------------------------
	["nitrato-amonia"] = { index = "nitrato-amonia", nome = "Nitrato de Amônia" },
	["hidroxido-sodio"] = { index = "hidroxido-sodio", nome = "Hidróxido de Sódio" },
	["pseudoefedrina"] = { index = "pseudoefedrina", nome = "Pseudoefedrina" },
	["eter"] = { index = "eter", nome = "Éter" },
	---------------------------------------------------------------------------------------------------
	--[ Organização Criminosa de Drogas 02 ]-----------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["coca-alta"] = { index = "coca-alta", nome = "Cocaína HQ" }, -- 8 Processos;
	["coca-media"] = { index = "coca-media", nome = "Cocaína MQ" }, -- 4 Processos;
	["coca-baixa"] = { index = "coca-baixa", nome = "Cocaína LQ" }, -- 2 Processos;
	--[ Sub produto ]----------------------------------------------------------------------------------
	["pasta-alta"] = { index = "pasta-alta", nome = "Pasta Base HQ" },
	["pasta-media"] = { index = "pasta-media", nome = "Pasta Base MQ" },
	["pasta-baixa"] = { index = "pasta-baixa", nome = "Pasta Base LQ" },
	--[ Ingredientes ]---------------------------------------------------------------------------------
	["acido-sulfurico"] = { index = "acido-sulfurico", nome = "Ácido Sulfúrico" },
	["folhas-coca"] = { index = "folhas-coca", nome = "Folhas de Coca" },
	["calcio-po"] = { index = "calcio-po", nome = "Cálcio em Pó" },
	["querosene"] = { index = "querosene", nome = "Querosene" },
	---------------------------------------------------------------------------------------------------
	--[ Organização Criminosa de Drogas 03 ]-----------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["maconha-alta"] = { index = "maconha-alta", nome = "Maconha HQ" }, -- 8 Processos;
	["maconha-media"] = { index = "maconha-media", nome = "Maconha MQ" }, -- 4 Processos;
	["maconha-baixa"] = { index = "maconha-baixa", nome = "Maconha LQ" }, -- 2 Processos;
	--[ Sub produto ]----------------------------------------------------------------------------------
	["planta-alta"] = { index = "planta-alta", nome = "Planta Base HQ" },
	["planta-media"] = { index = "planta-media", nome = "Planta Base MQ" },
	["planta-baixa"] = { index = "planta-baixa", nome = "Planta Base LQ" },
	--[ Ingredientes ]---------------------------------------------------------------------------------
	["tetra-hidrocanabinol"] = { index = "tetra-hidrocanabinol", nome = "Tetra Hidrocanabinol" },
	["haxixe"] = { index = "haxixe", nome = "Haxixe" },
	["skunk"] = { index = "skunk", nome = "Skunk" },
	["beck"] = { index = "beck", nome = "Beck" },
	---------------------------------------------------------------------------------------------------
	--[ Organização Criminosa ]------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["corpo-ak47"] = { index = "corpo-ak47", nome = "Corpo de AK-47" },
	["pecadearma"] = { index = "pecadearma", nome = "Peça de Arma" },
	["corpo-aks74u"] = { index = "corpo-aks74u", nome = "Corpo de AKS-74U" },
	["corpo-uzi"] = { index = "corpo-uzi", nome = "Corpo de Uzi" },
	["corpo-glock"] = { index = "corpo-glock", nome = "Corpo de Glock 19" },
	["corpo-fiveseven"] = { index = "corpo-fiveseven", nome = "Corpo de Five Seven" },
	["corpo-magnum"] = { index = "corpo-magnum", nome = "Corpo de Magnum 44" },
	--[ Ingredientes ]---------------------------------------------------------------------------------
	["molas"] = { index = "molas", nome = "Molas" },
	["placa-metal"] = { index = "placa-metal", nome = "Placa de Metal" },
	["gatilho"] = { index = "gatilho", nome = "Cartucho" },
	["capsulas"] = { index = "capsulas", nome = "Capsulas de Munição" },
	["polvora"] = { index = "polvora", nome = "Polvora" },
	["tecido"] = { index = "tecido", nome = "Tecido" },
	["kevlar"] = { index = "kevlar", nome = "Kevlar" },
	--[ Lavagem ]--------------------------------------------------------------------------------------
	["pendrive"] = { index = "pendrive", nome = "Pendrive" },
	["cartao"] = { index = "cartao", nome = "Cartão" },
	["acessoalavagem"] = { index = "acessoalavagem", nome = "Acesso a Lavagem" },
	---------------------------------------------------------------------------------------------------
	--[ Ingredientes Médico ]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["gaze"] = { index = "gaze", nome = "Gaze" },
	["atadura"] = { index = "atadura", nome = "Atadura" },
	["antisseptico"] = { index = "antisseptico", nome = "Antisséptico" },
	["kitmedico"] = { index = "kitmedico", nome = "Kit Médico" },
	---------------------------------------------------------------------------------------------------
	--[ Ingredientes Mecanico ]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["ferramentas"] = { index = "ferramentas", nome = "Ferramentas" },
	["engrenagem"] = { index = "engrenagem", nome = "Engrenagem" },
	["vidro"] = { index = "vidro", nome = "Vidro" },
	["macarico"] = { index = "macarico", nome = "Maçarico" },
	["estepe"] = { index = "estepe", nome = "Estepe" },
	---------------------------------------------------------------------------------------------------
	--[ ARMAS / OUTROS ]-------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------	
	["wbody|GADGET_PARACHUTE"] = { index = "paraquedas", nome = "Paraquedas" },
	["wbody|WEAPON_PETROLCAN"] = { index = "gasolina", nome = "Galão de Gasolina" },
	["wbody|WEAPON_FLARE"] = { index = "sinalizador", nome = "Sinalizador" },
	["wbody|WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor" },
	---------------------------------------------------------------------------------------------------
	--[ CORPO A CORPO ]--------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------	
	["wbody|WEAPON_KNIFE"] = { index = "faca", nome = "Faca" },
	["wbody|WEAPON_DAGGER"] = { index = "adaga", nome = "Adaga" },
	["wbody|WEAPON_KNUCKLE"] = { index = "ingles", nome = "Soco-Inglês" },
	["wbody|WEAPON_MACHETE"] = { index = "machete", nome = "Machete" },
	["wbody|WEAPON_SWITCHBLADE"] = { index = "canivete", nome = "Canivete" },
	["wbody|WEAPON_WRENCH"] = { index = "grifo", nome = "Chave de Grifo" },
	["wbody|WEAPON_HAMMER"] = { index = "martelo", nome = "Martelo" },
	["wbody|WEAPON_GOLFCLUB"] = { index = "golf", nome = "Taco de Golf" },
	["wbody|WEAPON_CROWBAR"] = { index = "cabra", nome = "Pé de Cabra" },
	["wbody|WEAPON_HATCHET"] = { index = "machado", nome = "Machado" },
	["wbody|WEAPON_FLASHLIGHT"] = { index = "lanterna", nome = "Lanterna" },
	["wbody|WEAPON_BAT"] = { index = "beisebol", nome = "Taco de Beisebol" },
	["wbody|WEAPON_BOTTLE"] = { index = "garrafa", nome = "Garrafa" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "batalha", nome = "Machado de Batalha" },
	["wbody|WEAPON_POOLCUE"] = { index = "sinuca", nome = "Taco de Sinuca" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "pedra", nome = "Machado de Pedra" },
	["wbody|WEAPON_NIGHTSTICK"] = { index = "cassetete", nome = "Cassetete" },
	---------------------------------------------------------------------------------------------------
	--[ PISTOLA ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_COMBATPISTOL"] = { index = "glock", nome = "Glock 19" },
	["wbody|WEAPON_REVOLVER_MK2"] = { index = "magnum44", nome = "Magnum 44" },
	["wbody|WEAPON_PISTOL_MK2"] = { index = "fiveseven", nome = "FN Five Seven" },
	["wbody|WEAPON_PISTOL50"] = { index = "deserteagle", nome = "Desert Eagle" },
	["wbody|WEAPON_STUNGUN"] = { index = "taser", nome = "Taser" },
	---------------------------------------------------------------------------------------------------
	--[ NOVAS ]----------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_HEAVYPISTOL"] = { index = "heavypistol", nome = "Heavy Pistol" },
	["wbody|WEAPON_APPISTOL"] = { index = "apppistol", nome = "AP.Pistol" },
	["wbody|WEAPON_MINISMG"] = { index = "minismg", nome = "Mini SMG" },
	["wbody|WEAPON_ADVANCEDRIFLE"] = { index = "advancedrifle", nome = "Advanced Rifle" },
	["wbody|WEAPON_SPECIALCARBINE"] = { index = "specialcarbine", nome = "Special Carbine" },
	["wbody|WEAPON_BULLPUPRIFLE"] = { index = "bullpuprifle", nome = "Bullpup Rifle" },
	["wbody|WEAPON_MG"] = { index = "mg", nome = "MG" },
	["wbody|WEAPON_COMBATMG"] = { index = "combatmg", nome = "Combat MG" },
	["wbody|WEAPON_GUSENBERG"] = { index = "gusenberg", nome = "Gusenberg" },
	["wbody|WEAPON_SNIPERRIFLE"] = { index = "sniperrifle", nome = "Sniper Rifle" },
	["wbody|WEAPON_HEAVYSNIPER"] = { index = "heavysniper", nome = "Heavy Sniper" },
	["wbody|WEAPON_MARKSMANRIFLE"] = { index = "marksmanrifle", nome = "Marksman Rifle" },
	["wbody|WEAPON_RPG"] = { index = "rpg", nome = "RPG" },
	["wbody|WEAPON_GRENADELAUNCHER"] = { index = "grenadelauncher", nome = "Grenade Launcher" },
	["wbody|WEAPON_GRENADELAUNCHER_SMOKE"] = { index = "grenadelaunchersmoke", nome = "Grenade Launcher.S" },
	["wbody|WEAPON_COMPACTLAUNCHER"] = { index = "compactlauncher", nome = "Compact Launcher" },
	["wbody|WEAPON_GRENADE"] = { index = "grenade", nome = "Granada" },
	["wbody|WEAPON_MOLOTOV"] = { index = "molotov", nome = "Molotov" },
	["wbody|WEAPON_STICKYBOMB"] = { index = "c4", nome = "C-4" },
	["wbody|WEAPON_PROXIME"] = { index = "proxime", nome = "C-4 Proxime" },
	["wbody|WEAPON_DOUBLEACTION"] = { index = "doubleaction", nome = "Double Action" },
	["wbody|WEAPON_RAYPISTOL"] = { index = "raypistol", nome = "Ray Pistol" },
	["wbody|WEAPON_NAVYREVOLVER"] = { index = "navyrevolver", nome = "Navy Revolver" },
	["wbody|WEAPON_ASSAULTSMG"] = { index = "assaultsmg", nome = "Assault SMG" },
	["wbody|WEAPON_SNSPISTOL"] = { index = "snspistol", nome = "SNS Pistol" },
	["wbody|WEAPON_SNSPISTOL_MK2"] = { index = "snspistol", nome = "SNS Pistol MK2" },
	["wammo|WEAPON_HEAVYPISTOL"] = { index = "m.heavypistol", nome = "M.Heavy Pistol" },
	["wammo|WEAPON_APPISTOL"] = { index = "m.apppistol", nome = "M.AP.Pistol" },
	["wammo|WEAPON_APPISTOL"] = { index = "m.apppistol", nome = "M.AP.Pistol" },
	["wammo|WEAPON_MINISMG"] = { index = "m.minismg", nome = "M.Mini SMG" },
	["wammo|WEAPON_ADVANCEDRIFLE"] = { index = "municao", nome = "M.Advanced Rifle" },
	["wammo|WEAPON_SPECIALCARBINE"] = { index = "municao", nome = "M.Special Carbine" },
	["wammo|WEAPON_BULLPUPRIFLE"] = { index = "m.bullpuprifle", nome = "M.Bullpup Rifle" },
	["wammo|WEAPON_MG"] = { index = "m.mg", nome = "M.MG" },
	["wammo|WEAPON_COMBATMG"] = { index = "m.combatmg", nome = "M.Combat MG" },
	["wammo|WEAPON_GUSENBERG"] = { index = "m.gusenberg", nome = "M.Gusenberg" },
	["wammo|WEAPON_SNIPERRIFLE"] = { index = "m.sniperrifle", nome = "M.Sniper Rifle" },
	["wammo|WEAPON_HEAVYSNIPER"] = { index = "m.heavysniper", nome = "M.Heavy Sniper" },
	["wammo|WEAPON_MARKSMANRIFLE"] = { index = "m.marksmanrifle", nome = "M.Marksman Rifle" },
	["wammo|WEAPON_RPG"] = { index = "m.rpg", nome = "M.RPG" },
	["wammo|WEAPON_GRENADELAUNCHER"] = { index = "m.grenadelauncher", nome = "M.Grenade Launcher" },
	["wammo|WEAPON_GRENADELAUNCHER_SMOKE"] = { index = "m.grenadelaunchersmoke", nome = "M.Grenade Launcher.S" },
	["wammo|WEAPON_COMPACTLAUNCHER"] = { index = "m.compactlauncher", nome = "M.Compact Launcher" },
	["wammo|WEAPON_GRENADE"] = { index = "m.grenade", nome = "M.Granada" },
	["wammo|WEAPON_MOLOTOV"] = { index = "m.molotov", nome = "M.Molotov" },
	["wammo|WEAPON_STICKYBOMB"] = { index = "m.c4", nome = "M.C-4" },
	["wammo|WEAPON_PROXIME"] = { index = "m.proxime", nome = "M.C-4 Proxime" },
	["wammo|WEAPON_DOUBLEACTION"] = { index = "m.doubleaction", nome = "M.Double Action" },
	["wammo|WEAPON_NAVYREVOLVER"] = { index = "m.navyrevolver", nome = "M.Navy Revolver" },
	---------------------------------------------------------------------------------------------------
	--[ FUZIL ]----------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_CARBINERIFLE_MK2"] = { index = "m4a1", nome = "M4A1" },
	["wbody|WEAPON_ASSAULTRIFLE_MK2"] = { index = "ak47", nome = "AK-47" },
	["wbody|WEAPON_COMPACTRIFLE"] = { index = "aks", nome = "AKS-74U" },
	---------------------------------------------------------------------------------------------------
	--[ SMG ]------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_SMG"] = { index = "mp5", nome = "MP5" },
	["wbody|WEAPON_MICROSMG"] = { index = "uzi", nome = "Uzi" },
	---------------------------------------------------------------------------------------------------
	--[ SHOTGUN ]--------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_PUMPSHOTGUN_MK2"] = { index = "remington", nome = "Remington 870" },
	---------------------------------------------------------------------------------------------------
	--[ RIFLES ]---------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_MUSKET"] = { index = "winchester22", nome = "Winchester 22" },
	---------------------------------------------------------------------------------------------------
	--[ MUNIÇÕES ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wammo|GADGET_PARACHUTE"] = { index = "m-paraquedas", nome = "M.Paraquedas" },
	["wammo|WEAPON_PETROLCAN"] = { index = "combustivel", nome = "Combustível" },
	["wammo|WEAPON_FLARE"] = { index = "m-sinalizador", nome = "M.Sinalizador" },
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "m-extintor", nome = "M.Extintor" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-glock", nome = "M.Glock 19" },
	["wammo|WEAPON_SNSPISTOL"] = { index = "municao", nome = "M.SNSPistol" },
	["wammo|WEAPON_SNSPISTOL_MK2"] = { index = "municao", nome = "M.SNSPistol" },
	["wammo|WEAPON_REVOLVER_MK2"] = { index = "m-magnum357", nome = "M.Magnum 357" },
	["wammo|WEAPON_PISTOL_MK2"] = { index = "m-fiveseven", nome = "M.FN Five Seven" },
	["wammo|WEAPON_PISTOL50"] = { index = "m-deserteagle", nome = "M.Desert Eagle" },
	["wammo|WEAPON_STUNGUN"] = { index = "m-taser", nome = "M.Taser" },
	["wammo|WEAPON_CARBINERIFLE_MK2"] = { index = "m-m4a1", nome = "M.M4A1" },
	["wammo|WEAPON_ASSAULTRIFLE_MK2"] = { index = "m-ak47", nome = "M.AK-47" },
	["wammo|WEAPON_ASSAULTSMG"] = { index = "municao", nome = "M.Assault SMG" },
	["wammo|WEAPON_COMPACTRIFLE"] = { index = "m-aks", nome = "M.AKS-74U" },
	["wammo|WEAPON_SMG"] = { index = "m-mp5", nome = "M.MP5" },
	["wammo|WEAPON_MICROSMG"] = { index = "m-uzi", nome = "M.Uzi" },
	["wammo|WEAPON_PUMPSHOTGUN_MK2"] = { index = "m-remington", nome = "M.Remington 870" },
	["wammo|WEAPON_MUSKET"] = { index = "m-winchester22", nome = "M.Winchester 22" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ITEM ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('item',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
		if args[1] and args[2] and itemlist[args[1]] ~= nil then
			vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]))
			SendWebhookMessage(webhookgive,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[PEGOU]: "..args[1].." \n[QUANTIDADE]: "..vRP.format(parseInt(args[2])).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)

--RegisterCommand('item',function(source,args,rawCommand)
--	local user_id = vRP.getUserId(source)
--	local identity = vRP.getUserIdentity(user_id)
--	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then
--		if args[1] and args[2] and itemlist[args[1]] ~= nil then
--			vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]))
--
--			local nomeItem = itemlist[args[1]]
--			local quantItem = parseInt(args[2])
--			
--			PerformHttpRequest(webhookgive, function(err, text, headers) end, 'POST', json.encode({
--				embeds = {
--					{ 
--						title = "REGISTRO DE COMANDO /ITEM:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
--						thumbnail = {
--						url = "https://media.discordapp.net/attachments/693350063857991680/740845174351069224/4444444_-_Copia.png"
--						}, 
--						fields = {
--							{ 
--								name = "**Quem pegou:**", 
--								value = "` "..identity.name.." "..identity.firstname.." ` "
--							},
--							{ 
--								name = "**Nº de Passaporte:**", 
--								value = "` "..user_id.." ` "
--							},
--							{ 
--								name = "**Item:**", 
--								value = "` "..nomeItem.." ` "
--							},
--							{ 
--								name = "**Quantidade:**", 
--								value = "` "..quantItem.." `\n⠀"
--							}
--						}, 
--						footer = { 
--							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
--							icon_url = "https://media.discordapp.net/attachments/693350063857991680/740845174351069224/4444444_-_Copia.png" 
--						},
--						color = 15914080 
--					}
--				}
--			}), { ['Content-Type'] = 'application/json' })
--
--		end
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- bvida
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('bvida',function(source,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)		
		vRPclient._setCustomization(source,vRPclient.getCustomization(source))
		vRP.removeCloak(source)	
		SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[UTILIZOU COMANDO]: BVIDA "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ USER VEHS [ADMIN]]-------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('uservehs',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"chat.permissao") then
        	local nuser_id = parseInt(args[1])
            if nuser_id > 0 then 
                local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(nuser_id) })
                local car_names = {}
                for k,v in pairs(vehicle) do
                	table.insert(car_names, "<b>" .. vRP.vehicleName(v.vehicle) .. "</b>")
                    --TriggerClientEvent("Notify",source,"importante","<b>Modelo:</b> "..v.vehicle,10000)
                end
                car_names = table.concat(car_names, ", ")
                local identity = vRP.getUserIdentity(nuser_id)
                TriggerClientEvent("Notify",source,"importante","Veículos de <b>"..identity.name.." " .. identity.firstname.. " ("..#vehicle..")</b>: "..car_names,10000)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ RESKIN ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('reskin',function(source,rawCommand)
	local user_id = vRP.getUserId(source)		
	vRPclient._setCustomization(vRPclient.getCustomization(source))		
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ID ]---------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('id',function(source,rawCommand)	
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		local identity = vRP.getUserIdentity(nuser_id)
		vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 8%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #d1257d; }","<div class=\"local\"><b>Passaporte:</b> ( "..vRP.format(identity.user_id).." )</div>")
		vRP.request(source,"Você deseja fechar o registro geral?",1000)
		vRPclient.removeDiv(source,"completerg")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ GCOLETE ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('gcolete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local armour = vRPclient.getArmour(player)
	if armour > 95 then
       vRPclient.setArmour(source,0)
       vRP.giveInventoryItem(user_id,"colete",1,true)
       TriggerClientEvent("tirandocolete",player)
       TriggerClientEvent("Notify",source,"sucesso","Você guardou o seu <b>Colete</b>.")
    else
	   TriggerClientEvent("Notify",source,"negado","<b>Coletes</b> danificados não podem ser <b>Guardados</b>.")
	   TriggerEvent("webhook:enviarloggcolete", "Comando - Guardou Colete ", "ID "..user_id.." usou o comando /gcolete "..rawCommand:sub(4)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
    end
end)

RegisterServerEvent("webhook:enviarloggcolete") --ENVIA O LOG DO NC PARA O DISCORD
AddEventHandler("webhook:enviarloggcolete",function(name,message)
    if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
    PerformHttpRequest('SEUWEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ JCOLETE ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jcolete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local armour = vRPclient.getArmour(player)
	if armour < 95 then
       vRPclient.setArmour(source,0)
       TriggerClientEvent("tirandocolete",player)
       TriggerClientEvent("Notify",source,"sucesso","Você jogou fora o seu <b>Colete</b>.")
       vRPclient._playAnim(player,true,{{"pickup_object","pickup_low",1}},false)
    else
	   TriggerClientEvent("Notify",source,"negado","Seu <b>Colete</b> nao está <b>Danificado</b>.")
	   TriggerEvent("webhook:enviarlogjcolete", "Comando - Jogou fora Colete ", "ID "..user_id.." usou o comando /jcolete "..rawCommand:sub(4)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
    end
end)

RegisterServerEvent("webhook:enviarlogjcolete") --ENVIA O LOG DO NC PARA O DISCORD
AddEventHandler("webhook:enviarlogjcolete",function(name,message)
    if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
    PerformHttpRequest('SEUWEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ REVISTAR ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('revistar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		local identity = vRP.getUserIdentity(user_id)
		local weapons = vRPclient.getWeapons(nplayer)
		local money = vRP.getMoney(nuser_id)
		local data = vRP.getUserDataTable(nuser_id)

		--TriggerClientEvent('cancelando',source,true)
		--TriggerClientEvent('cancelando',nplayer,true)
		--TriggerClientEvent('carregar',nplayer,source)
		--vRPclient._playAnim(source,false,{{"misscarsteal4@director_grip","end_loop_grip"}},true)
		--vRPclient._playAnim(nplayer,false,{{"random@mugging3","handsup_standing_base"}},true)
		--TriggerClientEvent("progress",source,5000,"revistando")
		--SetTimeout(5000,function()

			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3"..string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg^4  ]  - -")
			if data and data.inventory then
				for k,v in pairs(data.inventory) do
					TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k))
				end
			end
			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
			for k,v in pairs(weapons) do
				if v.ammo < 1 then
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k))
				else
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k).." | "..vRP.format(parseInt(v.ammo)).."x Munições")
				end
			end

			--vRPclient._stopAnim(source,false)
			--vRPclient._stopAnim(nplayer,false)
			--TriggerClientEvent('cancelando',source,false)
			--TriggerClientEvent('cancelando',nplayer,false)
			--TriggerClientEvent('carregar',nplayer,source)
			TriggerClientEvent('chatMessage',source,"",{},"     $"..vRP.format(parseInt(money)).." Dólares")
		--end)
		TriggerClientEvent("Notify",nplayer,"aviso","Você está sendo <b>Revistado</b>.")
		--TriggerClientEvent("Notify",nplayer,"aviso","Revistado por <b>"..identity.name.." "..identity.firstname.."</b>.",8000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ SALÁRIO ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local salarios = {

	{ ['permissao'] = "bronze.permissao", ['nome'] = "Bronze", ['payment'] = 1000 },
	{ ['permissao'] = "prata.permissao", ['nome'] = "Prata", ['payment'] = 2000 },
	{ ['permissao'] = "ouro.permissao", ['nome'] = "Ouro", ['payment'] = 3000 },
	{ ['permissao'] = "platina.permissao", ['nome'] = "Platina", ['payment'] = 4000 },
	{ ['permissao'] = "diamante.permissao", ['nome'] = "Diamante", ['payment'] = 5000 },
	{ ['permissao'] = "supremo.permissao", ['nome'] = "Supremo", ['payment'] = 6000 },
	{ ['permissao'] = "capeside.permissao", ['nome'] = "NOME", ['payment'] = 8000 },

	{ ['permissao'] = "bcso.permissao", ['nome'] = "Policia", ['payment'] = 5500 },
	{ ['permissao'] = "mecanico.permissao", ['nome'] = "Mecânico", ['payment'] = 4500 },
	{ ['permissao'] = "concessionaria.permissao", ['nome'] = "Concessionaria", ['payment'] = 4500 },
	{ ['permissao'] = "vanilla.permissao", ['nome'] = "Vanilla", ['payment'] = 6500 },
	{ ['permissao'] = "bahamas.permissao", ['nome'] = "Bahamas", ['payment'] = 6500 },
	{ ['permissao'] = "dmla.permissao", ['nome'] = "Paramédico", ['payment'] = 7000 }
}

RegisterServerEvent('salario:pagamento')
AddEventHandler('salario:pagamento',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(salarios) do
			if vRP.hasPermission(user_id,v.permissao) then
				TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
				TriggerClientEvent("Notify",source,"importante","Obrigado por colaborar com a cidade, seu salario de <b>$"..vRP.format(parseInt(v.payment)).." dólares</b> foi depositado.")
				vRP.giveBankMoney(user_id,parseInt(v.payment))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ NOCARJACK ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local veiculos = {}
RegisterServerEvent("TryDoorsEveryone")
AddEventHandler("TryDoorsEveryone",function(veh,doors,placa)
	if not veiculos[placa] then
		TriggerClientEvent("SyncDoorsEveryone",-1,veh,doors)
		veiculos[placa] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ AFKSYSTEM ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("kickAFK")
AddEventHandler("kickAFK",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,"chat.permissao") then
        DropPlayer(source,"Voce foi desconectado por ficar ausente.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ SEQUESTRO ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sequestro',function(source,args,rawCommand)
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		if vRPclient.isHandcuffed(nplayer) then
			if not vRPclient.getNoCarro(source) then
				local vehicle = vRPclient.getNearestVehicle(source,7)
				if vehicle then
					if vRPclient.getCarroClass(source,vehicle) then
						vRPclient.setMalas(nplayer)
					end
				end
			elseif vRPclient.isMalas(nplayer) then
				vRPclient.setMalas(nplayer)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ENVIAR ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('enviar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	local identity = vRP.getUserIdentity(user_id)
	local identitynu = vRP.getUserIdentity(nuser_id)
	  --[[if nuser_id and args[1] and parseInt(args[2]) > 0 then
		for k,v in pairs(itemlist) do
			if args[1] == v.index then
				if vRP.getInventoryWeight(nuser_id)+vRP.getItemWeight(k)*parseInt(args[2]) <= vRP.getInventoryMaxWeight(nuser_id) then
					if vRP.tryGetInventoryItem(user_id,k,parseInt(args[2])) then
						vRP.giveInventoryItem(nuser_id,k,parseInt(args[2]))
						vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
						TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..vRP.format(parseInt(args[2])).."x "..v.nome.."</b>.",8000)
						vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
						TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..vRP.format(parseInt(args[2])).."x "..v.nome.."</b>.",8000)
						SendWebhookMessage(webhookenviaritem,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: "..vRP.format(parseInt(args[2])).." "..v.nome.." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end
				end
			end
		end
	end]]--
	if nuser_id and parseInt(args[1]) > 0 then
		if vRP.tryPayment(user_id,parseInt(args[1])) then
			vRP.giveMoney(nuser_id,parseInt(args[1]))
			vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",source,"sucesso","Enviou <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.",8000)
			vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.",8000)
			SendWebhookMessage(webhookenviardinheiro,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: $"..vRP.format(parseInt(args[1])).." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		else
			TriggerClientEvent("Notify",source,"negado","Não tem a quantia que deseja enviar.",8000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ GARMAS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('garmas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local rtime = math.random(3,8)

	TriggerClientEvent("Notify",source,"aviso","<b>Aguarde!</b> Suas armas estão sendo desequipadas.",10000)
	TriggerClientEvent("progress",source,10000,"guardando")

	SetTimeout(1000*rtime,function()
		if user_id then
			local weapons = vRPclient.replaceWeapons(source,{})
			for k,v in pairs(weapons) do
				vRP.giveInventoryItem(user_id,"wbody|"..k,1)
				if v.ammo > 0 then
					vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
				end
				SendWebhookMessage(webhookgarmas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.itemNameList("wbody|"..k).." \n[QUANTIDADE]: "..v.ammo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
			TriggerClientEvent("Notify",source,"sucesso","Guardou seu armamento na mochila.")
		end
	end)
	SetTimeout(10000,function()
		TriggerClientEvent("Notify",source,"sucesso","Guardou seu armamento na mochila.")
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ROUBAR ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('roubar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		local nuser_id = vRP.getUserId(nplayer)
		local policia = vRP.getUsersByPermission("bcso.permissao")
		if #policia > 0 then
			if vRP.request(nplayer,"Você está sendo roubado, deseja passar tudo?",30) then
				local vida = vRPclient.getHealth(nplayer)
				if vida <= 100 then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
					TriggerClientEvent("progress",source,30000,"roubando")
					SetTimeout(30000,function()
						local ndata = vRP.getUserDataTable(nuser_id)
						if ndata ~= nil then
							if ndata.inventory ~= nil then
								for k,v in pairs(ndata.inventory) do
									if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
										if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
											vRP.giveInventoryItem(user_id,k,v.amount)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
									end
								end
							end
						end
						local weapons = vRPclient.replaceWeapons(nplayer,{})
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
									vRP.giveInventoryItem(user_id,"wbody|"..k,1)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody|"..k).."</b> por causa do peso.")
							end
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
										vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo|"..k).."</b> por causa do peso.")
								end
							end
						end
						local nmoney = vRP.getMoney(nuser_id)
						if vRP.tryPayment(nuser_id,nmoney) then
							vRP.giveMoney(user_id,nmoney)
						end
						vRPclient.setStandBY(source,parseInt(600))
						vRPclient._stopAnim(source,false)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
					end)
				else
					local ndata = vRP.getUserDataTable(nuser_id)
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
										vRP.giveInventoryItem(user_id,k,v.amount)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
								end
							end
						end
					end
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
								vRP.giveInventoryItem(user_id,"wbody|"..k,1)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody|"..k).."</b> por causa do peso.")
						end
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
									vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo|"..k).."</b> por causa do peso.")
							end
						end
					end
					local nmoney = vRP.getMoney(nuser_id)
					if vRP.tryPayment(nuser_id,nmoney) then
						vRP.giveMoney(user_id,nmoney)
					end
					vRPclient.setStandBY(source,parseInt(600))
					TriggerClientEvent("Notify",source,"sucesso","Roubo concluido com sucesso.")
				end
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa está resistindo ao roubo.")
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('motor',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local mPlaca = vRPclient.ModelName(source,3)
	local mPlacaUser = vRP.getUserByRegistration(mPlaca)
	if mPlaca then
		if not vRPclient.isInVehicle(source) then
			if vRP.hasPermission(user_id,"mecanico.permissao") then
				if user_id ~= mPlacaUser then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
					TriggerClientEvent("progress",source,30000,"reparando")
					SetTimeout(30000,function()
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('repararmotor',source)
						vRPclient._stopAnim(source,false)
					end)
				else
					TriggerClientEvent("Notify",source,"aviso","Não pode efetuar reparos em seu próprio veículo.")
				end
			else
				if vRP.tryGetInventoryItem(user_id,"militec",1) then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
					TriggerClientEvent("progress",source,30000,"reparando")
					SetTimeout(30000,function()
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('repararmotor',source)
						vRPclient._stopAnim(source,false)
					end)
				else
					TriggerClientEvent("Notify",source,"negado","Precisa de um <b>Militec-1</b> para reparar o motor.")
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Precisa estar próximo ou fora do veículo para efetuar os reparos.")
		end
	end
end)

RegisterServerEvent("trymotor")
AddEventHandler("trymotor",function(nveh)
	TriggerClientEvent("syncmotor",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('reparar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if not vRPclient.isInVehicle(source) then
        local vehicle = vRPclient.getNearestVehicle(source,7)
        if vRP.hasPermission(user_id,"mecanico.permissao") then
            if vRP.tryGetInventoryItem(user_id,"ferramentas",1) then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
				TriggerClientEvent("progress",source,30000,"reparando")
				SetTimeout(30000,function()
					TriggerClientEvent('cancelando',source,false)
					TriggerClientEvent('reparar',source,vehicle)
					vRPclient._stopAnim(source,false)
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Precisa de uma <b>Ferramenta</b> para reparar o veículo.")
			end
        else
            if vRP.tryGetInventoryItem(user_id,"repairkit",1) then
                TriggerClientEvent('cancelando',source,true)
                vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
                TriggerClientEvent("progress",source,30000,"reparando")
                SetTimeout(30000,function()
                    TriggerClientEvent('cancelando',source,false)
                    TriggerClientEvent('reparar',source,vehicle)
                    vRPclient._stopAnim(source,false)
                end)
            else
                TriggerClientEvent("Notify",source,"negado","Precisa de um <b>Kit de Reparos</b> para reparar o veículo.")
            end
        end
    else
        TriggerClientEvent("Notify",source,"negado","Precisa estar próximo ou fora do veículo para efetuar os reparos.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ SAQUEAR ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('saquear',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		if vRPclient.isInComa(nplayer) then
			local identity_user = vRP.getUserIdentity(user_id)
			local nuser_id = vRP.getUserId(nplayer)
			local nidentity = vRP.getUserIdentity(nuser_id)
			local policia = vRP.getUsersByPermission("bcso.permissao")
			local itens_saque = {}
			if #policia >= 0 then
				local vida = vRPclient.getHealth(nplayer)
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
				TriggerClientEvent("progress",source,20000,"saqueando")
				SetTimeout(20000,function()
					local ndata = vRP.getUserDataTable(nuser_id)
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
										vRP.giveInventoryItem(user_id,k,v.amount)
										table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList(k).." [QUANTIDADE]: "..v.amount)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
								end
							end
						end
					end
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
								vRP.giveInventoryItem(user_id,"wbody|"..k,1)
								table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wbody|"..k).." [QUANTIDADE]: "..1)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody|"..k).."</b> por causa do peso.")
						end
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
									vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
									table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wammo|"..k).." [QTD]: "..v.ammo)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo|"..k).."</b> por causa do peso.")
							end
						end
					end
					local nmoney = vRP.getMoney(nuser_id)
					if vRP.tryPayment(nuser_id,nmoney) then
						vRP.giveMoney(user_id,nmoney)
					end
					vRPclient.setStandBY(source,parseInt(600))
					vRPclient._stopAnim(source,false)
					TriggerClientEvent('cancelando',source,false)
					local apreendidos = table.concat(itens_saque, "\n")
					TriggerClientEvent("Notify",source,"importante","Saque concluido com sucesso.")
					SendWebhookMessage(webhooksaquear,"```prolog\n[ID]: "..user_id.." "..identity_user.name.." "..identity_user.firstname.."\n[SAQUEOU]: "..nuser_id.." "..nidentity.name.." " ..nidentity.firstname .. "\n" .. apreendidos ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end)
			else
				TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você só pode saquear quem está em coma.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRYTOW ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytow")
AddEventHandler("trytow",function(nveh,rveh)
	TriggerClientEvent("synctow",-1,nveh,rveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRUNK ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytrunk")
AddEventHandler("trytrunk",function(nveh)
	TriggerClientEvent("synctrunk",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ WINS ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trywins")
AddEventHandler("trywins",function(nveh)
	TriggerClientEvent("syncwins",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ HOOD ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryhood")
AddEventHandler("tryhood",function(nveh)
	TriggerClientEvent("synchood",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DOORS ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydoors")
AddEventHandler("trydoors",function(nveh,door)
	TriggerClientEvent("syncdoors",-1,nveh,door)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CALL ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
RegisterCommand('call',function(source,args,rawCommand)
	local source = source
	local answered = false
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	vida = vRPclient.getHealth(source)
	vRPclient._CarregarObjeto(source,"cellphone@","cellphone_call_to_text","prop_amb_phone",50,28422)
	if user_id then
		local descricao = vRP.prompt(source,"Descrição:","")
		if descricao == "" then
			vRPclient._stopAnim(source,false)
			vRPclient._DeletarObjeto(source)
			return
		end

		local x,y,z = vRPclient.getPosition(source)
		local players = {}
		vRPclient._stopAnim(source,false)
		vRPclient._DeletarObjeto(source)
		local especialidade = false
		--if args[1] == "911" then
		--	players = vRP.getUsersByPermission("bcso.permissao")
		--	especialidade = "policiais"
		--elseif args[1] == "112" then
		--	players = vRP.getUsersByPermission("dmla.permissao")
		--	especialidade = "colaboradores do <b>Departamento Médico</b>"
		--elseif args[1] == "mec" then
		--	players = vRP.getUsersByPermission("mecanico.permissao")
		--	especialidade = "mecânicos"
		--elseif args[1] == "taxi" then
		--	players = vRP.getUsersByPermission("taxista.permissao")
		--	especialidade = "taxistas"
		--elseif args[1] == "adv" then
		--	players = vRP.getUsersByPermission("advogado.permissao")
		--	especialidade = "advogados"
		--elseif args[1] == "juiz" then
		--	players = vRP.getUsersByPermission("juiz.permissao")	
		--	especialidade = "juizes"
		--elseif args[1] == "css" then
		--	players = vRP.getUsersByPermission("conce.permissao")	
		--	especialidade = "vendedores"
		--elseif args[1] == "jornal" then
		--	players = vRP.getUsersByPermission("news.permissao")	
		--	especialidade = "jornalistas"
		--elseif args[1] == "bns" then
		--	players = vRP.getUsersByPermission("bennys.permissao")	
		--	especialidade = "ninguém da Bennys"
		--elseif args[1] == "adm" then
		--	players = vRP.getUsersByPermission("chat.permissao")	
		--	especialidade = "Administradores"
		--end
		if args[1] == "adm" then
			players = vRP.getUsersByPermission("chat.permissao")	
			especialidade = "Administradores"
		end
		local adm = ""
		if especialidade == "Administradores" then
			adm = "[AJUDA] "
		end
		
		vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
		if #players == 0  and especialidade ~= "policiais" then
			TriggerClientEvent("Notify",source,"importante","Não há "..especialidade.." em serviço.")
		else
			local identitys = vRP.getUserIdentity(user_id)
			TriggerClientEvent("Notify",source,"sucesso","Chamado enviado com sucesso.")
			for l,w in pairs(players) do
				local player = vRP.getUserSource(parseInt(w))
				local nuser_id = vRP.getUserId(player)
				if player and player ~= uplayer then
					async(function()
						vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
					    TriggerClientEvent('chatMessage',player,"CHAMADO",{255,215,100},adm.."Enviado por ^1"..identitys.name.." "..identitys.firstname.."^0 ["..user_id.."], "..descricao)
						local ok = vRP.request(player,"<b>"..identitys.name.." "..identitys.firstname.." ["..user_id.."],</b> "..descricao.."",30)
						if ok then
							if not answered then
								answered = true
								local identity = vRP.getUserIdentity(nuser_id)
								TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
								vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
								vRPclient._setGPS(player,x,y)
							else
								TriggerClientEvent("Notify",player,"importante","Chamado ja foi atendido por outra pessoa.")
								vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
							end
						end
						local id = idgens:gen()
						blips[id] = vRPclient.addBlip(player,x,y,z,358,71,"Chamado",0.6,false)
						SetTimeout(300000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /mascara
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setmascara",source,args[1],args[2])
					endWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[UTILIZOU COMANDO]: MASCARA "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /blusa
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('blusa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setblusa",source,args[1],args[2])
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[UTILIZOU COMANDO]: BLUSA "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /colete
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('colete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setcolete",source,args[1],args[2])
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[UTILIZOU COMANDO]: COLETE "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")	
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /jaqueta
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jaqueta',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setjaqueta",source,args[1],args[2])
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[UTILIZOU COMANDO]: JAQUETA "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /maos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('maos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setmaos",source,args[1],args[2])
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[UTILIZOU COMANDO]: MAOS "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /calca
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('calca',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setcalca",source,args[1],args[2])
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[UTILIZOU COMANDO]: CALÇA "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /acessorios
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('acessorios',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setacessorios",source,args[1],args[2])
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[UTILIZOU COMANDO]: ACESSORIOS "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")	
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /mochila
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mochila',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setmochila",source,args[1],args[2])
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[UTILIZOU COMANDO]: MOCHILA "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sapatos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sapatos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setsapatos",source,args[1],args[2])
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[UTILIZOU COMANDO]: SAPATOS "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /chapeu
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('chapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setchapeu",source,args[1],args[2])
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[UTILIZOU COMANDO]: CHAPEU "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /oculos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('oculos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setoculos",source,args[1],args[2])
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[UTILIZOU COMANDO]: OCULOS "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")	
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ACESSÓRIOS ]-------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
--[[RegisterCommand('mascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("acmascara",source,args[1],args[2])
				end
			end
		end
	end
end)

RegisterCommand('oculos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("acoculos",source,args[1],args[2])
				end
			end
		end
	end
end)

RegisterCommand('chapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("acchapeu",source,args[1],args[2])
				end
			end
		end
	end
end)

RegisterCommand('sapatos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("acsapatos",source,args[1],args[2])
				end
			end
		end
	end
end)]]--
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- ROUPAS
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- local roupas = {
-- 	["pm"] = {
-- 		[1885233650] = {
-- 			[1] = { 121,0,2 },
-- 			[3] = { 19,0,2 },
-- 			[4] = { 31,0,2 },
-- 			[5] = { -1,0 },
-- 			[6] = { 24,0,2 },
-- 			[7] = { 1,0,2 },			
-- 			[8] = { 55,0,2 },
-- 			[9] = { 6,0,2 },
-- 			[10] = { -1,0,2 },
-- 			[11] = { 2,2,2 },
-- 			["p0"] = { -1,0 },
-- 			["p1"] = { -1,0 },
-- 			["p2"] = { -1,0 },
-- 			["p6"] = { -1,0 },
-- 			["p7"] = { -1,0 }
-- 		},
-- 		[-1667301416] = {
-- 			[1] = { 121,0,2 },
-- 			[3] = { 14,0,2 },
-- 			[4] = { 54,1,2 },
-- 			[5] = { -1,0 },
-- 			[6] = { 24,0,2 },
-- 			[7] = { 1,0,2 },			
-- 			[8] = { 32,0,2 },
-- 			[9] = { 7,0,2 },
-- 			[10] = { -1,0 },
-- 			[11] = { 25,0,2 },			
-- 			["p0"] = { -1,0 },
-- 			["p1"] = { -1,0 },
-- 			["p2"] = { -1,0 },
-- 			["p6"] = { -1,0 },
-- 			["p7"] = { -1,0 }
-- 		}
-- 	},
-- ["samu"] = {
-- 	[1885233650] = {
-- 		[1] = { 121,0 },
-- 		[3] = { 74,0 },
-- 		[4] = { 96,0 },
-- 		[5] = { -1,0 },
-- 		[6] = { 56,1 },
-- 		[7] = { 127,0 },
-- 		[8] = { 56,1 },
-- 		[9] = { -1,0 },
-- 		[10] = { 58,0 },
-- 		[11] = { 250,0 },
-- 		["p0"] = { -1,0 },
-- 		["p1"] = { -1,0 },
-- 		["p2"] = { -1,0 },
-- 		["p6"] = { -1,0 },
-- 		["p7"] = { -1,0 }
-- 	},
-- 	[-1667301416] = {
-- 		[1] = { 121,0 },
-- 		[3] = { 96,0 },
-- 		[4] = { 99,0 },
-- 		[5] = { -1,0 },
-- 		[6] = { 27,0 },
-- 		[7] = { 97,0 },
-- 		[8] = { 27,1 },
-- 		[9] = { -1,0 },
-- 		[10] = { 66,0 },
-- 		[11] = { 258,0 },
-- 		["p0"] = { -1,0 },
-- 		["p1"] = { -1,0 },
-- 		["p2"] = { -1,0 },
-- 		["p6"] = { -1,0 },
-- 		["p7"] = { -1,0 }
-- 	}
-- },
-- ["samu2"] = {
-- 	[1885233650] = {
-- 		[1] = { 121,0 },
-- 		[3] = { 81,0 },
-- 		[4] = { 10,0 },
-- 		[5] = { -1,0 },
-- 		[6] = { 56,1 },
-- 		[7] = { 127,0 },			
-- 		[8] = { 56,1 },
-- 		[9] = { -1,0 },
-- 		[10] = { 58,0 },
-- 		[11] = { 95,1 },
-- 		["p0"] = { -1,0 },
-- 		["p1"] = { -1,0 },
-- 		["p2"] = { -1,0 },
-- 		["p6"] = { -1,0 },
-- 		["p7"] = { -1,0 }
-- 	},
-- 	[-1667301416] = {
-- 		[1] = { 0,0 },
-- 		[3] = { 106,1 },
-- 		[4] = { 37,0 },
-- 		[5] = { 0,0 },
-- 		[6] = { 27,0 },
-- 		[7] = { 97,0 },			
-- 		[8] = { 27,1 },
-- 		[9] = { -1,0 },
-- 		[10] = { 66,0 },
-- 		[11] = { 86,1 },
-- 		["p0"] = { -1,0 },
-- 		["p1"] = { -1,0 },
-- 		["p2"] = { -1,0 },
-- 		["p6"] = { -1,0 },
-- 		["p7"] = { -1,0 }
-- 	}
-- },
-- ["samu3"] = {
-- 	[1885233650] = {
-- 		[1] = { 121,0 },
-- 		[3] = { 38,0 },
-- 		[4] = { 96,0 },
-- 		[5] = { -1,0 },
-- 		[6] = { 56,1 },
-- 		[7] = { 126,0 },			
-- 		[8] = { 71,3 },
-- 		[9] = { -1,0 },
-- 		[10] = { 57,0 },
-- 		[11] = { 249,0 },
-- 		["p0"] = { -1,0 },
-- 		["p1"] = { -1,1 },
-- 		["p2"] = { -1,0 },
-- 		["p6"] = { -1,0 },
-- 		["p7"] = { -1,0 }
-- 	},
-- 	[-1667301416] = {
-- 		[1] = { 121,0 },
-- 		[3] = { 18,0 },
-- 		[4] = { 99,0 },
-- 		[5] = { -1,0 },
-- 		[6] = { 27,0 },
-- 		[7] = { 14,3 },
-- 		[8] = { 77,3 },		
-- 		[9] = { -1,0 },
-- 		[10] = { 65,0 },
-- 		[11] = { 257,0 },		
-- 		["p0"] = { -1,0 },
-- 		["p1"] = { -1,0 },
-- 		["p2"] = { -1,0 },
-- 		["p6"] = { -1,0 },
-- 		["p7"] = { -1,0 }
-- 	}
-- },
-- ["samu4"] = {
-- 	[1885233650] = {
-- 		[1] = { -1,0 },
-- 		[3] = { 81,0 },
-- 		[4] = { 25,5 },
-- 		[5] = { -1,0 },
-- 		[6] = { 21,9 },
-- 		[7] = { 126,0 },			
-- 		[8] = { 56,1 },
-- 		[9] = { -1,0 },
-- 		[10] = { -1,0 },
-- 		[11] = { 13,0 },
-- 		["p0"] = { -1,0 },
-- 		["p1"] = { -1,0 },
-- 		["p2"] = { -1,0 },
-- 		["p6"] = { -1,0 },
-- 		["p7"] = { -1,0 }
-- 	},
-- 	[-1667301416] = {
-- 		[1] = { -1,0 },
-- 		[3] = { 85,0 },
-- 		[4] = { 37,5 },
-- 		[5] = { -1,0 },
-- 		[6] = { 10,1 },
-- 		[7] = { 14,3 },		
-- 		[8] = { 27,1 },
-- 		[9] = { -1,0 },
-- 		[10] = { -1,0 },
-- 		[11] = { 27,0 },
-- 		["p0"] = { -1,0 },
-- 		["p1"] = { -1,0 },
-- 		["p2"] = { -1,0 },
-- 		["p6"] = { -1,0 },
-- 		["p7"] = { -1,0 }
-- 	}
-- },
-- ["samu5"] = {
-- 	[1885233650] = {
-- 		[1] = { -1,0 },
-- 		[3] = { 4,0 },
-- 		[4] = { 25,5 },
-- 		[5] = { -1,0 },
-- 		[6] = { 21,9 },
-- 		[7] = { 126,0 },			
-- 		[8] = { 31,0 },
-- 		[9] = { -1,0 },
-- 		[10] = { -1,0 },
-- 		[11] = { 31,7 },
-- 		["p0"] = { -1,0 },
-- 		["p1"] = { -1,0 },
-- 		["p2"] = { -1,0 },
-- 		["p6"] = { -1,0 },
-- 		["p7"] = { -1,0 }
-- 	},
-- 	[-1667301416] = {
-- 		[1] = { -1,0 },
-- 		[3] = { 1,0 },
-- 		[4] = { 37,5 },
-- 		[5] = { -1,0 },
-- 		[6] = { 0,2 },
-- 		[7] = { 14,3 },		
-- 		[8] = { 64,2 },
-- 		[9] = { -1,0 },
-- 		[10] = { -1,0 },
-- 		[11] = { 57,7 },
-- 		["p0"] = { -1,0 },
-- 		["p1"] = { -1,0 },
-- 		["p2"] = { -1,0 },
-- 		["p6"] = { -1,0 },
-- 		["p7"] = { -1,0 }
-- 	}
-- },
-- ["samu6"] = {
-- 	[1885233650] = {
-- 		[1] = { -1,0 },
-- 		[3] = { 74,0 },
-- 		[4] = { 3,3 },
-- 		[5] = { -1,0 },
-- 		[6] = { 7,0 },
-- 		[7] = { 126,0 },			
-- 		[8] = { 15,0 },
-- 		[9] = { -1,0 },
-- 		[10] = { -1,0 },
-- 		[11] = { 16,1 },
-- 		["p0"] = { -1,0 },
-- 		["p1"] = { -1,0 },
-- 		["p2"] = { -1,0 },
-- 		["p6"] = { -1,0 },
-- 		["p7"] = { -1,0 }
-- 	},
-- 	[-1667301416] = {
-- 		[1] = { -1,0 },
-- 		[3] = { 96,0 },
-- 		[4] = { 3,13 },
-- 		[5] = { -1,0 },
-- 		[6] = { 10,1 },
-- 		[7] = { 14,3 },
-- 		[8] = { 15,0 },
-- 		[9] = { -1,0 },
-- 		[10] = { -1,0 },	
-- 		[11] = { 141,1 },		
-- 		["p0"] = { -1,0 },
-- 		["p1"] = { -1,0 },
-- 		["p2"] = { -1,0 },
-- 		["p6"] = { -1,0 },
-- 		["p7"] = { -1,0 }
-- 	}
-- },
-- ["mergulho"] = {
-- 	[1885233650] = {
-- 		[1] = { 122,0 },
-- 		[3] = { 31,0 },
-- 		[4] = { 94,0 },
-- 		[5] = { -1,0 },
-- 		[6] = { 67,0 },
-- 		[7] = { -1,0 },
-- 		[8] = { 123,0 },
-- 		[9] = { -1,0 },
-- 		[10] = { -1,0 },
-- 		[11] = { 243,0 },			
-- 		["p0"] = { -1,0 },
-- 		["p1"] = { 26,0 },
-- 		["p2"] = { -1,0 },
-- 		["p6"] = { -1,0 },
-- 		["p7"] = { -1,0 }
-- 	},
-- 	[-1667301416] = {
-- 		[1] = { 122,0 },
-- 		[3] = { 18,0 },
-- 		[4] = { 97,0 },
-- 		[5] = { -1,0 },
-- 		[6] = { 70,0 },
-- 		[7] = { -1,0 },
-- 		[8] = { 153,0 },
-- 		[9] = { -1,0 },
-- 		[10] = { -1,0 },
-- 		[11] = { 251,0 },
-- 		["p0"] = { -1,0 },
-- 		["p1"] = { 28,0 },
-- 		["p2"] = { -1,0 },
-- 		["p6"] = { -1,0 },
-- 		["p7"] = { -1,0 }
-- 	}
-- },
--     ["mecanico"] = {
-- 		[1885233650] = {                                      
-- 			[1] = { -1,0 },
-- 			[3] = { 12,0 },
-- 			[4] = { 39,0 },
-- 			[5] = { -1,0 },
-- 			[6] = { 24,0 },
-- 			[7] = { 109,0 },
-- 			[8] = { 89,0 },
-- 			[9] = { 14,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 66,0 }
-- 		},
-- 		[-1667301416] = {
-- 			[1] = { -1,0 },
-- 			[3] = { 14,0 },
-- 			[4] = { 38,0 },
-- 			[5] = { -1,0 },
-- 			[6] = { 24,0 },
-- 			[7] = { 2,0 },
-- 			[8] = { 56,0 },
-- 			[9] = { 35,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 59,0 }
-- 		}
-- 	},
-- 	["preso"] = {
-- 		[1885233650] = {                                      
-- 			[1] = { -1,0 },
-- 			[3] = { 1,0,2 },
-- 			[4] = { 7,15,2 },
-- 			[5] = { -1,0 },
-- 			[6] = { 1,0,2 },
-- 			[7] = { -1,0,2 },
-- 			[8] = { 15,0,2 },
-- 			[9] = { -1,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 238,0,2 }
-- 		},
-- 		[-1667301416] = {
-- 			[1] = { -1,0 },
-- 			[3] = { 4,0,2 },
-- 			[4] = { 3,15,2 },
-- 			[5] = { 0,0,2 },
-- 			[6] = { 1,1,2 },
-- 			[7] = { -1,0 },
-- 			[8] = { 7,0,2 },
-- 			[9] = { 0,0,2 },
-- 			[10] = { 0,0,2 },
-- 			[11] = { 118,0,2 }
-- 		}
-- 	},
--     ["lixeiro"] = {
-- 		[1885233650] = {                                      
-- 			[1] = { -1,0 },
-- 			[3] = { 17,0 },
-- 			[4] = { 36,0 },
-- 			[5] = { -1,0 },
-- 			[6] = { 27,0 },
-- 			[7] = { -1,0 },
-- 			[8] = { 59,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 57,0 }
-- 		},
-- 		[-1667301416] = {
-- 			[1] = { -1,0 },
-- 			[3] = { 18,0 },
-- 			[4] = { 35,0 },
-- 			[5] = { -1,0 },
-- 			[6] = { 26,0 },
-- 			[7] = { -1,0 },
-- 			[8] = { 36,0 },
-- 			[9] = { -1,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 50,0 }
-- 		}
-- 	},
-- 	["carteiro"] = {
-- 		[1885233650] = {                                      
-- 			[1] = { -1,0 },
-- 			[3] = { 0,0 },
-- 			[4] = { 17,10 },
-- 			[5] = { 40,0 },
-- 			[6] = { 7,0 },
-- 			[7] = { -1,0 },
-- 			[8] = { 15,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 242,3 }
-- 		},
-- 		[-1667301416] = {
-- 			[1] = { -1,0 },
-- 			[3] = { 14,0 },
-- 			[4] = { 14,1 },
-- 			[5] = { 40,0 },
-- 			[6] = { 10,1 },
-- 			[7] = { -1,0 },
-- 			[8] = { 6,0 },
-- 			[9] = { -1,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 250,3 }
-- 		}
-- 	},
-- 	["fazendeiro"] = {
-- 		[1885233650] = {                                      
-- 			[1] = { -1,0 },
-- 			[3] = { 37,0 },
-- 			[4] = { 7,0 },
-- 			[5] = { -1,0 },
-- 			[6] = { 15,6 },
-- 			[7] = { -1,0 },
-- 			[8] = { 15,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 95,2 },
-- 			["p0"] = { 105,23 },
-- 			["p1"] = { 5,0 }
-- 		},
-- 		[-1667301416] = {
-- 			[1] = { -1,0 },
-- 			[3] = { 45,0 },
-- 			[4] = { 25,10 },
-- 			[5] = { -1,0 },
-- 			[6] = { 21,1 },
-- 			[7] = { -1,0 },
-- 			[8] = { 6,0 },
-- 			[9] = { -1,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 171,4 },
-- 			["p0"] = { 104,23 },
-- 			["p1"] = { 11,2 }
-- 		}
-- 	},
-- 	["lavagem"] = {
-- 		[1885233650] = {                                      
-- 			[1] = { 0,0,2 },
-- 			[3] = { 19,0,2 },
-- 			[4] = { 31,4,2 },
-- 			[5] = { -1,0,2 },
-- 			[6] = { 24,0,2 },
-- 			[7] = { 0,0,2 },
-- 			[8] = { 15,0,2 },
-- 			[10] = { -1,0,2 },
-- 			[11] = { 50,4,2 },
-- 			["p0"] = { 39,4 },
-- 			["p1"] = { 23,0 }
-- 		},
-- 		[-1667301416] = {
-- 			[1] = { -1,0 },
-- 			[3] = { 45,0 },
-- 			[4] = { 25,10 },
-- 			[5] = { -1,0 },
-- 			[6] = { 21,1 },
-- 			[7] = { -1,0 },
-- 			[8] = { 6,0 },
-- 			[9] = { -1,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 171,4 },
-- 			["p0"] = { 104,23 },
-- 			["p1"] = { 11,2 }
-- 		}
-- 	},
-- 	["taxista"] = {
-- 		[1885233650] = {                                      
-- 			[1] = { -1,0 },
-- 			[3] = { 11,0 },
-- 			[4] = { 35,0 },
-- 			[5] = { -1,0 },
-- 			[6] = { 10,0 },
-- 			[7] = { -1,0 },
-- 			[8] = { 15,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 13,0 }
-- 		},
-- 		[-1667301416] = {
-- 			[1] = { -1,0 },
-- 			[3] = { 0,0 },
-- 			[4] = { 112,0 },
-- 			[5] = { -1,0 },
-- 			[6] = { 6,0 },
-- 			[7] = { -1,0 },
-- 			[8] = { 6,0 },
-- 			[9] = { -1,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 27,0 }
-- 		}
-- 	},
-- 	["caminhoneiro"] = {
-- 		[1885233650] = {                                      
-- 			[1] = { -1,0 },
-- 			[3] = { 0,0 },
-- 			[4] = { 63,0 },
-- 			[5] = { -1,0 },
-- 			[6] = { 27,0 },
-- 			[7] = { -1,0 },
-- 			[8] = { 81,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 173,3 },
-- 			["p1"] = { 8,0 }
-- 		},
-- 		[-1667301416] = {
-- 			[1] = { -1,0 },
-- 			[3] = { 14,0 },
-- 			[4] = { 74,5 },
-- 			[5] = { -1,0 },
-- 			[6] = { 9,0 },
-- 			[7] = { -1,0 },
-- 			[8] = { 92,0 },
-- 			[9] = { -1,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 175,3 },
-- 			["p1"] = { 11,0 }
-- 		}
-- 	},
-- 	["gesso"] = {
-- 		[1885233650] = {
-- 			[1] = { -1,0 },
-- 			[3] = { 1,0 },
-- 			[4] = { 84,9 },
-- 			[5] = { -1,0 },
-- 			[6] = { 13,0 },
-- 			[7] = { -1,0 },			
-- 			[8] = { -1,0 },
-- 			[9] = { -1,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 186,9 },			
-- 			["p0"] = { -1,0 },
-- 			["p1"] = { -1,0 },
-- 			["p2"] = { -1,0 },
-- 			["p6"] = { -1,0 },
-- 			["p7"] = { -1,0 }
-- 		},
-- 		[-1667301416] = {
-- 			[1] = { -1,0 },
-- 			[3] = { 3,0 },
-- 			[4] = { 86,9 },
-- 			[5] = { -1,0 },
-- 			[6] = { 12,0 },
-- 			[7] = { -1,0 },		
-- 			[8] = { -1,0 },
-- 			[9] = { -1,0 },
-- 			[10] = { -1,0 },
-- 			[11] = { 188,9 },
-- 			["p0"] = { -1,0 },
-- 			["p1"] = { -1,0 },
-- 			["p2"] = { -1,0 },
-- 			["p6"] = { -1,0 },
-- 			["p7"] = { -1,0 }
-- 		}
-- 	},
-- 	["motorista"] = {
-- 		[1885233650] = {
-- 			[1] = { -1,0 }, -- máscara
-- 			[3] = { 0,0 }, -- maos
-- 			[4] = { 10,0 }, -- calça
-- 			[5] = { -1,0 }, -- mochila
-- 			[6] = { 21,0 }, -- sapato
-- 			[7] = { -1,0 }, -- acessorios		
-- 			[8] = { -1,0 }, -- blusa
-- 			[9] = { -1,0 }, -- colete
-- 			[10] = { -1,0 }, -- adesivo
-- 			[11] = { 242,1 }, -- jaqueta		
-- 			["p0"] = { -1,0 }, -- chapeu
-- 			["p1"] = { 7,0 }, -- oculos
-- 			["p2"] = { -1,0 },
-- 			["p6"] = { -1,0 },
-- 			["p7"] = { -1,0 }
-- 		},
-- 		[-1667301416] = {
-- 			[1] = { -1,0 }, -- máscara
-- 			[3] = { 14,0 }, -- maos
-- 			[4] = { 37,0 }, -- calça
-- 			[5] = { -1,0 }, -- mochila
-- 			[6] = { 27,0 }, -- sapato
-- 			[7] = { -1,0 },  -- acessorios		
-- 			[8] = { -1,0 }, -- blusa
-- 			[9] = { -1,0 }, -- colete
-- 			[10] = { -1,0 }, -- adesivo
-- 			[11] = { 250,1 }, -- jaqueta
-- 			["p0"] = { -1,0 }, -- chapeu
-- 			["p1"] = { -1,0 }, -- oculos
-- 			["p2"] = { -1,0 },
-- 			["p6"] = { -1,0 },
-- 			["p7"] = { -1,0 }
-- 		}
-- 	},
-- 	["pescador"] = {
-- 		[1885233650] = {
-- 			[1] = { -1,0 }, -- máscara
-- 			[3] = { 0,0 }, -- maos
-- 			[4] = { 98,19 }, -- calça
-- 			[5] = { -1,0 }, -- mochila
-- 			[6] = { 24,0 }, -- sapato
-- 			[7] = { -1,0 }, -- acessorios		
-- 			[8] = { 85,2 }, -- blusa
-- 			[9] = { -1,0 }, -- colete
-- 			[10] = { -1,0 }, -- adesivo
-- 			[11] = { 247,12 }, -- jaqueta		
-- 			["p0"] = { 104,20 }, -- chapeu
-- 			["p1"] = { 5,0 }, -- oculos
-- 			["p2"] = { -1,0 },
-- 			["p6"] = { -1,0 },
-- 			["p7"] = { -1,0 }
-- 		},
-- 		[-1667301416] = {
-- 			[1] = { -1,0 }, -- máscara
-- 			[3] = { 14,0 }, -- maos
-- 			[4] = { 101,19 }, -- calça
-- 			[5] = { -1,0 }, -- mochila
-- 			[6] = { 24,0 }, -- sapato
-- 			[7] = { -1,0 },  -- acessorios		
-- 			[8] = { 88,1 }, -- blusa
-- 			[9] = { -1,0 }, -- colete
-- 			[10] = { -1,0 }, -- adesivo
-- 			[11] = { 255,13 }, -- jaqueta
-- 			["p0"] = { -1,0 }, -- chapeu
-- 			["p1"] = { 11,0 }, -- oculos
-- 			["p2"] = { -1,0 },
-- 			["p6"] = { -1,0 },
-- 			["p7"] = { -1,0 }
-- 		}
-- 	}
-- }

RegisterCommand('roupas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if args[1] then
					local custom = roupas[tostring(args[1])]
					if custom then
						local old_custom = vRPclient.getCustomization(source)
						local idle_copy = {}

						idle_copy = vRP.save_idle_custom(source,old_custom)
						idle_copy.modelhash = nil

						for l,w in pairs(custom[old_custom.modelhash]) do
							idle_copy[l] = w
						end
						vRPclient._playAnim(source,true,{{"clothingshirt","try_shirt_positive_d"}},false)
						Citizen.Wait(2500)
						vRPclient._stopAnim(source,true)
						vRPclient._setCustomization(source,idle_copy)
					end
				else
					vRPclient._playAnim(source,true,{{"clothingshirt","try_shirt_positive_d"}},false)
					Citizen.Wait(2500)
					vRPclient._stopAnim(source,true)
					vRP.removeCloak(source)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ PAYPAL ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('paypal',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if args[1] == "sacar" and parseInt(args[2]) > 0 then
			local consulta = vRP.getUData(user_id,"vRP:paypal")
			local resultado = json.decode(consulta) or 0
			local confirmacao = vRP.prompt(source,"Deseja sacar o seu dinheiro do paypal?","")
			if confirmacao == "" then
				return
			end
			if resultado >= parseInt(args[2]) then
				vRP.giveBankMoney(user_id,parseInt(args[2]))
				vRP.setUData(user_id,"vRP:paypal",json.encode(parseInt(resultado-args[2])))
				TriggerClientEvent("Notify",source,"bom","Você efetuou o saque de <b>$"..vRP.format(parseInt(args[2])).." dólares</b> da sua conta paypal.")
			else
				TriggerClientEvent("Notify",source,"aviso","Dinheiro insuficiente em sua conta paypal.")
			end
		elseif args[1] == "trans" and parseInt(args[2]) > 0 and parseInt(args[3]) > 0 then
			local consulta = vRP.getUData(parseInt(args[2]),"vRP:paypal")
			local resultado = json.decode(consulta) or 0
			local banco = vRP.getBankMoney(user_id)
			local identityu = vRP.getUserIdentity(parseInt(args[2]))
			local confirmacao = vRP.prompt(source,"Deseja transferir <b> $ "..vRP.format(parseInt(args[3])).."</b> Para : "..identityu.name.." "..identityu.firstname.."?","Sim")
				if confirmacao == "" then
					return
				end
			--if vRP.request(source,"Deseja transferir <b>$"..vRP.format(parseInt(args[3])).."</b> dólares para <b>"..identityu.name.." "..identityu.firstname.."</b>?",30) then	
				if banco >= parseInt(args[3]) then
					vRP.setBankMoney(user_id,parseInt(banco-args[3]))
					vRP.setUData(parseInt(args[2]),"vRP:paypal",json.encode(parseInt(resultado+args[3])))
					TriggerClientEvent("Notify",source,"bom","Enviou <b>$"..vRP.format(parseInt(args[3])).." dólares</b> ao passaporte <b>"..vRP.format(parseInt(args[2])).."</b>.")
					SendWebhookMessage(webhookpaypal,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: $"..vRP.format(parseInt(args[3])).." \n[PARA O ID]: "..parseInt(args[2]).." "..identityu.name.." "..identityu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					local player = vRP.getUserSource(parseInt(args[2]))
					if player == nil then
						return
					else
						local identity = vRP.getUserIdentity(user_id)
						TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> transferiu <b>$"..vRP.format(parseInt(args[3])).." dólares</b> para sua conta do paypal.")
					end
				else
					TriggerClientEvent("Notify",source,"aviso","Dinheiro insuficiente.")
			--	end
			end
		end
	end
end)



RegisterCommand("fps20", function()
    TriggerEvent("lafa2k_flag:fps20")
end)