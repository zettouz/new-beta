local cfg = module("cfg/inventory")

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookbaucasa = "SEUWEBHOOK"
local webhookbaustatic = "SEUWEBHOOK"
local webhookbaustaticpolicia = "SEUWEBHOOK"
local webhookbauvagos = "SEUWEBHOOK"
local webhookbaufamilies = "SEUWEBHOOK"
local webhookbauballas = "SEUWEBHOOK"
local webhookbaumafia = "SEUWEBHOOK"
local webhookbautriade = "SEUWEBHOOK"
local webhookbaumc = "SEUWEBHOOK"
local webhookbaucosanostra = "SEUWEBHOOK"
local webhookbauyakuza = "SEUWEBHOOK"
local webhookbauflanela = "SEUWEBHOOK"
local webhookbaucorredores = "SEUWEBHOOK"
local webhookbauhellsangels = "SEUWEBHOOK"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

local itemlist = {
	---------------------------------------------------------------------------------------------------
	--[ Ultilitários legais ]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["mochila"] = { index = "mochila", nome = "Mochila", type = "usar" },
	["celular"] = { index = "celular", nome = "iFruit XI", type = "usar" },
	["celularquebrado"] = { index = "celularquebrado", nome = "iFruit XI Quebrado", type = "usar" },
	["radio"] = { index = "radio", nome = "WalkTalk", type = "usar" },
	["mascara"] = { index = "mascara", nome = "Mascara", type = "usar" },
	["oculos"] = { index = "oculos", nome = "Óculos", type = "usar" },
	["sapatos"] = { index = "sapatos", nome = "Sapatos", type = "usar" },
	["blusa"] = { index = "blusa", nome = "Blusa", type = "usar" },
	["jaqueta"] = { index = "jaqueta", nome = "Jaqueta", type = "usar" },
	["calca"] = { index = "calca", nome = "Calca", type = "usar" },
	["chapeu"] = { index = "chapeu", nome = "Chapéu", type = "usar" },
	["acessorios"] = { index = "acessorios", nome = "Acessórios", type = "usar" },
	["roupas"] = { index = "roupas", nome = "Roupas", type = "usar" },
	["identidade"] = { index = "identidade", nome = "Identidade", type = "usar" },
	["colete"] = { index = "colete", nome = "Colete Balístico", type = "usar" },
	["militec"] = { index = "militec", nome = "Militec", type = "usar" },
	["repairkit"] = { index = "repairkit", nome = "Kit de Reparos", type = "usar" },
	["camera"] = { index = "camera", nome = "Camera", type = "usar" },
	["filmadora"] = { index = "filmadora", nome = "Filmadora", type = "usar" },
	["microfone"] = { index = "microfone", nome = "Microfone", type = "usar" },
	["tablet"] = { index = "tablet", nome = "Tablet", type = "usar" },
	["notebook"] = { index = "notebook", nome = "Notebook", type = "usar" },
	["plus"] = { index = "plus", nome = "Pass Plus", type = "usar" },
	["advanced"] = { index = "advanced", nome = "Pass Advanced", type = "usar" },
	["standard"] = { index = "standard", nome = "Pass Standard", type = "usar" },
	---------------------------------------------------------------------------------------------------
	--[ Ticket ] --------------------------------------------------------------------------------------
	-- ["tcarro"] = { index = "carro", nome = "Ticket Carro", type = "usar" },
	-- ["tmoto"] = { index = "moto", nome = "Ticket Moto", type = "usar" },
	---------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	--[ Ultilitários Ilegais]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["dinheiro-sujo"] = { index = "dinheiro-sujo", nome = "Dinheiro Sujo", type = "usar" },
	["dinheiro-molhado"] = { index = "dinheiro-molhado", nome = "Dinheiro Molhado", type = "usar" },
	["algema"] = { index = "algema", nome = "Algema", type = "usar" },
	["secador"] = { index = "secador", nome = "Secador", type = "usar" },
	["lockpick"] = { index = "lockpick", nome = "Lockpick", type = "usar" },
	["capuz"] = { index = "capuz", nome = "Capuz", type = "usar" },
	["placa"] = { index = "placa", nome = "Placa", type = "usar" },
	["c4"] = { index = "c4", nome = "C4 Completa", type = "usar" },
	["serra"] = { index = "serra", nome = "Serra", type = "usar" },
	["furadeira"] = { index = "furadeira", nome = "Furadeira", type = "usar" },
	["raceticket"] = { index = "raceticket", nome = "Race Ticket", type = "usar" },
	---------------------------------------------------------------------------------------------------
	--[ Ultilitários NOVOS BAHAMAS]--------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["losna"] = { index = "losna", nome = "Losna", type = "usar" },
	["anis"] = { index = "anis", nome = "Anis", type = "usar" },
	["funcho"] = { index = "funcho", nome = "Funcho", type = "usar" },
	["ervas"] = { index = "ervas", nome = "Ervas", type = "usar" },
	["acucar"] = { index = "acucar", nome = "Açucar", type = "usar" },
	["taca"] = { index = "taca", nome = "Taça", type = "usar" },
	["preabsinto-alta"] = { index = "preabsinto-alta", nome = "Pre-Absinto HQ", type = "usar" },
	["absinto-baixa"] = { index = "absinto-baixa", nome = "Absinto BQ", type = "usar" },
	["absinto-media"] = { index = "absinto-media", nome = "Absinto MQ", type = "usar" },
	["absinto-alta"] = { index = "absinto-alta", nome = "Absinto HQ", type = "usar" },
	---------------------------------------------------------------------------------------------------
	--[ Ultilitários NOVOS VANILLA]--------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["balahalls"] = { index = "balahalls", nome = "Bala Halls", type = "usar" },
	["gelo"] = { index = "gelo", nome = "Gelo", type = "usar" },
	["codeina"] = { index = "codeina", nome = "Codeina", type = "usar" },
	["refrigerante"] = { index = "refrigerante", nome = "Refrigerante", type = "usar" },
	["alcool"] = { index = "alcool", nome = "Alcool", type = "usar" },
	["copo"] = { index = "copo", nome = "Copo", type = "usar" },
	["prelean-alta"] = { index = "prelean-alta", nome = "Pre-Lean HQ", type = "usar" },
	["lean-baixa"] = { index = "lean-baixa", nome = "Lean BQ", type = "usar" },
	["lean-media"] = { index = "lean-media", nome = "Lean MQ", type = "usar" },
	["lean-alta"] = { index = "lean-alta", nome = "Lean HQ", type = "usar" },
	---------------------------------------------------------------------------------------------------
	--[ Ultilitários Ilegais]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["fita"] = { index = "fita", nome = "Fita", type = "usar" },
	["fios"] = { index = "fios", nome = "Fios", type = "usar" },
	["controle"] = { index = "controle", nome = "Controle", type = "usar" },
	["armacaodefuradeira"] = { index = "armacaodefuradeira", nome = "Armação de Furadeira", type = "usar" },
	["broca"] = { index = "broca", nome = "Broca", type = "usar" },
	["ferrob"] = { index = "ferrob", nome = "Ferro", type = "usar" },
	["armacaodeserra"] = { index = "armacaodeserra", nome = "Armação de Serra", type = "usar" },
	["disco"] = { index = "disco", nome = "Disco", type = "usar" },
	["pano"] = { index = "pano", nome = "Pano", type = "usar" },
	["corda"] = { index = "corda", nome = "Corda", type = "usar" },
	["keycard"] = { index = "keycard", nome = "Cartão Roubo", type = "usar" },
	["chave"] = { index = "chave", nome = "Chave", type = "usar" },
	["pendrivebanco"] = { index = "pendrive2", nome = "Pendrive Roubo", type = "usar" },
	["c4b"] = { index = "c4b", nome = "C4 Básica", type = "usar" },
	["pendrive2"] = { index = "pendrivebanco", nome = "Pendrive Reutilizável", type = "usar" },
	["keycard2"] = { index = "keycard2", nome = "Cartão Reutilizável", type = "usar" },
	---------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	--[ Ultilitários CORRIDA ]-------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["arame"] = { index = "arame", nome = "Arame", type = "usar" },
	["tinta"] = { index = "tinta", nome = "Tinta", type = "usar" },
	["papel"] = { index = "papel", nome = "Papel", type = "usar" },
	["caneta"] = { index = "caneta", nome = "Caneta", type = "usar" },
	["cilindro"] = { index = "cilindro", nome = "Cilindro", type = "usar" },
	["gas"] = { index = "gas", nome = "Gás", type = "usar" },
	---------------------------------------------------------------------------------------------------
	--[ Bebidas Não Alcoólicas ]-----------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["agua"] = { index = "agua", nome = "Água", type = "usar" },
	["leite"] = { index = "leite", nome = "Leite", type = "usar" },
	["cafe"] = { index = "cafe", nome = "Café", type = "usar" },
	["cafecleite"] = { index = "cafecleite", nome = "Café com Leite", type = "usar" },
	["cafeexpresso"] = { index = "cafeexpresso", nome = "Café Expresso", type = "usar" },
	["capuccino"] = { index = "capuccino", nome = "Capuccino", type = "usar" },
	["frappuccino"] = { index = "frappuccino", nome = "Frapuccino", type = "usar" },
	["cha"] = { index = "cha", nome = "Chá", type = "usar" },
	["icecha"] = { index = "icecha", nome = "Chá Gelado", type = "usar" },
	["sprunk"] = { index = "sprunk", nome = "Sprunk", type = "usar" },
	["cola"] = { index = "cola", nome = "Cola", type = "usar" },
	["energetico"] = { index = "energetico", nome = "Energético", type = "usar" },
	---------------------------------------------------------------------------------------------------
	--[ Bebidas Alcoólicas ]---------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["pibwassen"] = { index = "pibwassen", nome = "PibWassen", type = "usar" },
	["tequilya"] = { index = "tequilya", nome = "Tequilya", type = "usar" },
	["patriot"] = { index = "patriot", nome = "Patriot", type = "usar" },
	["blarneys"] = { index = "blarneys", nome = "Blarneys", type = "usar" },
	["jakeys"] = { index = "jakeys", nome = "Jakeys", type = "usar" },
	["barracho"] = { index = "barracho", nome = "Barracho", type = "usar" },
	["ragga"] = { index = "ragga", nome = "Ragga", type = "usar" },
	["nogo"] = { index = "nogo", nome = "Nogo", type = "usar" },
	["mount"] = { index = "mount", nome = "Mount", type = "usar" },
	["cherenkov"] = { index = "cherenkov", nome = "Cherenkov", type = "usar" },
	["bourgeoix"] = { index = "bourgeoix", nome = "Bourgeoix", type = "usar" },
	["bleuterd"] = { index = "bleuterd", nome = "Bleuterd", type = "usar" },
	---------------------------------------------------------------------------------------------------
	--[ Comidas de FastFood ]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["sanduiche"] = { index = "sanduiche", nome = "Sanduíche", type = "usar" },
	["rosquinha"] = { index = "rosquinha", nome = "Rosquinha", type = "usar" },
	["hotdog"] = { index = "hotdog", nome = "HotDog", type = "usar" },
	["xburguer"] = { index = "xburguer", nome = "xBurguer", type = "usar" },
	["chips"] = { index = "chips", nome = "Batata Chips", type = "usar" },
	["batataf"] = { index = "batataf", nome = "Batata Frita", type = "usar" },
	["pizza"] = { index = "pizza", nome = "Pedaço de Pizza", type = "usar" },
	["frango"] = { index = "frango", nome = "Frango Frito", type = "usar" },
	["bcereal"] = { index = "bcereal", nome = "Barra de Cereal", type = "usar" },
	["bchocolate"] = { index = "bchocolate", nome = "Barra de Chocolate", type = "usar" },
	["taco"] = { index = "taco", nome = "Taco", type = "usar" },
	["yakisoba"] = { index = "yakisoba", nome = "Yakisoba", type = "usar" },
	["isca"] = { index = "isca", nome = "Isca", type = "usar" },
	["dourado"] = { index = "dourado", nome = "Dourado", type = "usar" },
	["corvina"] = { index = "corvina", nome = "Corvina", type = "usar" },
	["salmao"] = { index = "salmao", nome = "Salmão", type = "usar" },
	["pacu"] = { index = "pacu", nome = "Pacu", type = "usar" },
	["pintado"] = { index = "pintado", nome = "Pintado", type = "usar" },
	["pirarucu"] = { index = "pirarucu", nome = "Pirarucu", type = "usar" },
	["tilapia"] = { index = "tilapia", nome = "Tilápia", type = "usar" },
	["tucunare"] = { index = "tucunare", nome = "Tucunaré", type = "usar" },
	["lambari"] = { index = "lambari", nome = "Lambari", type = "usar" },
	---------------------------------------------------------------------------------------------------
	--[ Remédios ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["xarelto"] = { index = "xarelto", nome = "Xarelto", type = "usar" },
	["dipirona"] = { index = "dipirona", nome = "Dipirona", type = "usar" },
	["tandrilax"] = { index = "tandrilax", nome = "Tandrilax", type = "usar" },
	["dorflex"] = { index = "dorflex", nome = "Dorflex", type = "usar" },
	["buscopan"] = { index = "buscopan", nome = "Buscopan", type = "usar" },
	["nebacetin"] = { index = "nebacetin", nome = "Nebacetin", type = "usar" },
	["hirudoid"] = { index = "hirudoid", nome = "Hirudoid", type = "usar" },
	---------------------------------------------------------------------------------------------------
	--[ Receitas ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["r-xarelto"] = { index = "r-xarelto", nome = "Receituário Xarelto", type = "usar" },
	["r-dipirona"] = { index = "r-dipirona", nome = "Receituário Dipirona", type = "usar" },
	["r-tandrilax"] = { index = "r-tandrilax", nome = "Receituário Tandrilax", type = "usar" },
	["r-dorflex"] = { index = "r-dorflex", nome = "Receituário Dorflex", type = "usar" },
	["r-buscopan"] = { index = "r-buscopan", nome = "Receituário Buscopan", type = "usar" },
	["r-nebacetin"] = { index = "r-nebacetin", nome = "Receituário Nebacetin", type = "usar" },
	["r-hirudoid"] = { index = "r-hirudoid", nome = "Receituário Hirudoid", type = "usar" },
	---------------------------------------------------------------------------------------------------
	--[ Organização Criminosa de Drogas 01 ]-----------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["meta-alta"] = { index = "meta-alta", nome = "Metanfetamina HQ", type = "usar" }, -- 6 Processos;
	["meta-media"] = { index = "meta-media", nome = "Metanfetamina MQ", type = "usar" }, -- 4 Processos;
	["meta-baixa"] = { index = "meta-baixa", nome = "Metanfetamina LQ", type = "usar" }, -- 2 Processos;
	--[ Sub produto ]----------------------------------------------------------------------------------
	["composito-alta"] = { index = "composito-alta", nome = "Compósito HQ", type = "usar" },
	["composito-media"] = { index = "composito-media", nome = "Compósito MQ", type = "usar" },
	["composito-baixa"] = { index = "composito-baixa", nome = "Compósito LQ", type = "usar" },
	--[ Ingredientes ]---------------------------------------------------------------------------------
	["nitrato-amonia"] = { index = "nitrato-amonia", nome = "Nitrato de Amônia", type = "usar" },
	["hidroxido-sodio"] = { index = "hidroxido-sodio", nome = "Hidróxido de Sódio", type = "usar" },
	["pseudoefedrina"] = { index = "pseudoefedrina", nome = "Pseudoefedrina", type = "usar" },
	["eter"] = { index = "eter", nome = "Éter", type = "usar" },
	---------------------------------------------------------------------------------------------------
	--[ Organização Criminosa de Drogas 02 ]-----------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["coca-alta"] = { index = "coca-alta", nome = "Cocaína HQ", type = "usar" }, -- 6 Processos;
	["coca-media"] = { index = "coca-media", nome = "Cocaína MQ", type = "usar" }, -- 4 Processos;
	["coca-baixa"] = { index = "coca-baixa", nome = "Cocaína LQ", type = "usar" }, -- 2 Processos;
	--[ Sub produto ]----------------------------------------------------------------------------------
	["pasta-alta"] = { index = "pasta-alta", nome = "Pasta Base HQ", type = "usar" },
	["pasta-media"] = { index = "pasta-media", nome = "Pasta Base MQ", type = "usar" },
	["pasta-baixa"] = { index = "pasta-baixa", nome = "Pasta Base LQ", type = "usar" },
	--[ Ingredientes ]---------------------------------------------------------------------------------
	["acido-sulfurico"] = { index = "acido-sulfurico", nome = "Ácido Sulfúrico", type = "usar" },
	["folhas-coca"] = { index = "folhas-coca", nome = "Folhas de Coca", type = "usar" },
	["calcio-po"] = { index = "calcio-po", nome = "Cálcio em Pó", type = "usar" },
	["querosene"] = { index = "querosene", nome = "Querosene", type = "usar" },
	---------------------------------------------------------------------------------------------------
	--[ Organização Criminosa de Drogas 03 ]-----------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["maconha-alta"] = { index = "maconha-alta", nome = "Maconha HQ", type = "usar" }, -- 6 Processos;
	["maconha-media"] = { index = "maconha-media", nome = "Maconha MQ", type = "usar" }, -- 4 Processos;
	["maconha-baixa"] = { index = "maconha-baixa", nome = "Maconha LQ", type = "usar" }, -- 2 Processos;
	--[ Sub produto ]----------------------------------------------------------------------------------
	["planta-alta"] = { index = "planta-alta", nome = "Planta Base HQ", type = "usar" },
	["planta-media"] = { index = "planta-media", nome = "Planta Base MQ", type = "usar" },
	["planta-baixa"] = { index = "planta-baixa", nome = "Planta Base LQ", type = "usar" },
	--[ Ingredientes ]---------------------------------------------------------------------------------
	["tetra-hidrocanabinol"] = { index = "tetra-hidrocanabinol", nome = "Tetra Hidrocanabinol", type = "usar" },
	["haxixe"] = { index = "haxixe", nome = "Haxixe", type = "usar" },
	["skunk"] = { index = "skunk", nome = "Skunk", type = "usar" },
	["beck"] = { index = "beck", nome = "Beck", type = "usar" },
	--------------------------------------------------------------------------------------------------
	--[ Ingredientes Médico ]-------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------
	["gaze"] = { index = "gaze", nome = "Gaze", type = "usar" },
	["atadura"] = { index = "atadura", nome = "Atadura", type = "usar" },
	["antisseptico"] = { index = "antisseptico", nome = "Antisséptico", type = "usar" },
	["kitmedico"] = { index = "kitmedico", nome = "Kit Médico", type = "usar" },
	--------------------------------------------------------------------------------------------------
	--[ Ingredientes Mecânico ]-----------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------
	["engrenagem"] = { index = "engrenagem", nome = "Engrenagem", type = "usar" },
	["vidro"] = { index = "vidro", nome = "Vidro", type = "usar" },
	["macarico"] = { index = "macarico", nome = "Maçarico", type = "usar" },
	["estepe"] = { index = "estepe", nome = "Estepe", type = "usar" },
	["ferramentas"] = { index = "ferramentas", nome = "Ferramentas", type = "usar" },
	---------------------------------------------------------------------------------------------------
	--[ Organização Criminosa de Armas 02 ]-----------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["corpo-ak47"] = { index = "corpo-ak47", nome = "Corpo de AK-47", type = "usar" },
	["pecadearma"] = { index = "pecadearma", nome = "Peça de Arma", type = "usar" },
	["corpo-aks"] = { index = "corpo-aks", nome = "Corpo de AKS-74U", type = "usar" },
	["corpo-uzi"] = { index = "corpo-uzi", nome = "Corpo de Uzi", type = "usar" },
	["corpo-glock"] = { index = "corpo-glock", nome = "Corpo de Glock 19", type = "usar" },
	["corpo-fivesen"] = { index = "corpo-fivesen", nome = "Corpo de Five Seven", type = "usar" },
	["corpo-magnum"] = { index = "corpo-magnum", nome = "Corpo de Magnum 44", type = "usar" },
	["corpo-fiveseven"] = { index = "corpo-fiveseven", nome = "Corpo de Five Seven", type = "usar" },
	--[ Ingredientes ]---------------------------------------------------------------------------------
	["molas"] = { index = "molas", nome = "Molas", type = "usar" },
	["placa-metal"] = { index = "placa-metal", nome = "Placa de Metal", type = "usar" },
	["gatilho"] = { index = "gatilho", nome = "Cartucho", type = "usar" },
	["capsulas"] = { index = "capsulas", nome = "Capsulas de Munição", type = "usar" },
	["polvora"] = { index = "polvora", nome = "Polvora", type = "usar" },
	["tecido"] = { index = "tecido", nome = "Tecido", type = "usar" },
	["kevlar"] = { index = "kevlar", nome = "Kevlar", type = "usar" },
	--[ Lavagem ]--------------------------------------------------------------------------------------
	["pendrive"] = { index = "pendrive", nome = "Pendrive", type = "usar" },
	["cartao"] = { index = "cartao", nome = "Cartao", type = "usar" },
	["acessoalavagem"] = { index = "acessoalavagem", nome = "Acesso a Lavagem", type = "usar" },
	---------------------------------------------------------------------------------------------------
	--[ Ingredientes Médicos ]-------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["gaze"] = { index = "gaze", nome = "Gaze", type = "usar" },
	["atadura"] = { index = "atadura", nome = "Atadura", type = "usar" },
	["antisseptico"] = { index = "antisseptico", nome = "Antisseptico", type = "usar" },
	["kitmedico"] = { index = "kitmedico", nome = "Kitmedico", type = "usar" },
	--------------------------------------------------------------------------------------------------
	--[ Empregos ]------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------
	["diamante"] = { index = "diamante", nome = "Min. Diamante", type = "usar" },
	["ouro"] = { index = "ouro", nome = "Min. Ouro", type = "usar" },
	["bronze"] = { index = "bronze", nome = "Min. Bronze", type = "usar" },
	["ferro"] = { index = "ferro", nome = "Min. Ferro", type = "usar" },
	["rubi"] = { index = "rubi", nome = "Min. Rubi", type = "usar" },
	["esmeralda"] = { index = "esmeralda", nome = "Min. Esmeralda", type = "usar" },
	["safira"] = { index = "safira", nome = "Min. Safira", type = "usar" },
	["topazio"] = { index = "topazio", nome = "Min. Topazio", type = "usar" },
	["ametista"] = { index = "ametista", nome = "Min. Ametista", type = "usar" },
	["diamante2"] = { index = "diamante2", nome = "Diamante", type = "usar" },
	["ouro2"] = { index = "ouro2", nome = "Ouro", type = "usar" },
	["bronze2"] = { index = "bronze2", nome = "Bronze", type = "usar" },
	["ferro2"] = { index = "ferro2", nome = "Ferro", type = "usar" },
	["rubi2"] = { index = "rubi2", nome = "Rubi", type = "usar" },
	["esmeralda2"] = { index = "esmeralda2", nome = "Esmeralda", type = "usar" },
	["safira2"] = { index = "safira2", nome = "Safira", type = "usar" },
	["topazio2"] = { index = "topazio2", nome = "Topazio", type = "usar" },
	["ametista2"] = { index = "ametista2", nome = "Ametista", type = "usar" },

	["sacodelixo"] = { index = "sacodelixo", nome = "Saco de lixo", type = "usar" },

	["garrafadeleite"] = { index = "garrafadeleite", nome = "Garrafa de leite", type = "usar" },
	["garrafavazia"] = { index = "garrafavazia", nome = "Garrafa vazia", type = "usar" },

	["encomenda"] = { index = "encomenda", nome = "Encomenda", type = "usar" },

	["tora"] = { index = "tora", nome = "Tora", type = "usar" },
	["laranja"] = { index = "laranja", nome = "Laranja", type = "usar" },
	---------------------------------------------------------------------------------------------------
	--[ ARMAS / OUTROS ]-------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------	
	["wbody|GADGET_PARACHUTE"] = { index = "paraquedas", nome = "Paraquedas", type = "equipar" },
	["wbody|WEAPON_PETROLCAN"] = { index = "gasolina", nome = "Galão de Gasolina", type = "equipar" },
	["wbody|WEAPON_FLARE"] = { index = "sinalizador", nome = "Sinalizador", type = "equipar" },
	["wbody|WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor", type = "equipar" },
	---------------------------------------------------------------------------------------------------
	--[ CORPO A CORPO ]--------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------	
	["wbody|WEAPON_KNIFE"] = { index = "faca", nome = "Faca", type = "equipar" },
	["wbody|WEAPON_DAGGER"] = { index = "adaga", nome = "Adaga", type = "equipar" },
	["wbody|WEAPON_KNUCKLE"] = { index = "ingles", nome = "Soco-Inglês", type = "equipar" },
	["wbody|WEAPON_MACHETE"] = { index = "machete", nome = "Machete", type = "equipar" },
	["wbody|WEAPON_SWITCHBLADE"] = { index = "canivete", nome = "Canivete", type = "equipar" },
	["wbody|WEAPON_WRENCH"] = { index = "grifo", nome = "Chave de Grifo", type = "equipar" },
	["wbody|WEAPON_HAMMER"] = { index = "martelo", nome = "Martelo", type = "equipar" },
	["wbody|WEAPON_GOLFCLUB"] = { index = "golf", nome = "Taco de Golf", type = "equipar" },
	["wbody|WEAPON_CROWBAR"] = { index = "cabra", nome = "Pé de Cabra", type = "equipar" },
	["wbody|WEAPON_HATCHET"] = { index = "machado", nome = "Machado", type = "equipar" },
	["wbody|WEAPON_FLASHLIGHT"] = { index = "lanterna", nome = "Lanterna", type = "equipar" },
	["wbody|WEAPON_BAT"] = { index = "beisebol", nome = "Taco de Beisebol", type = "equipar" },
	["wbody|WEAPON_BOTTLE"] = { index = "garrafa", nome = "Garrafa", type = "equipar" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "batalha", nome = "Machado de Batalha", type = "equipar" },
	["wbody|WEAPON_POOLCUE"] = { index = "sinuca", nome = "Taco de Sinuca", type = "equipar" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "pedra", nome = "Machado de Pedra", type = "equipar" },
	["wbody|WEAPON_NIGHTSTICK"] = { index = "cassetete", nome = "Cassetete", type = "equipar" },
	---------------------------------------------------------------------------------------------------
	--[ PISTOLA ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_COMBATPISTOL"] = { index = "glock", nome = "Glock 19", type = "equipar" },
	["wbody|WEAPON_REVOLVER_MK2"] = { index = "magnum44", nome = "Magnum 44", type = "equipar" },
	["wbody|WEAPON_PISTOL_MK2"] = { index = "fiveseven", nome = "FN Five Seven", type = "equipar" },
	["wbody|WEAPON_PISTOL50"] = { index = "deserteagle", nome = "Desert Eagle", type = "equipar" },
	["wbody|WEAPON_STUNGUN"] = { index = "taser", nome = "Taser", type = "equipar" },
	---------------------------------------------------------------------------------------------------
	--[ NOVAS ]----------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_HEAVYPISTOL"] = { index = "heavypistol", nome = "Heavy Pistol", type = "equipar" },
	["wbody|WEAPON_SNSPISTOL"] = { index = "snspistol", nome = "SNS Pistol", type = "equipar" },
	["wbody|WEAPON_SNSPISTOL_MK2"] = { index = "snspistol", nome = "SNS Pistol", type = "equipar" },
	["wbody|WEAPON_APPISTOL"] = { index = "apppistol", nome = "AP.Pistol", type = "equipar" },
	["wbody|WEAPON_MINISMG"] = { index = "minismg", nome = "Mini SMG", type = "equipar" },
	["wbody|WEAPON_ADVANCEDRIFLE"] = { index = "advancedrifle", nome = "Advanced Rifle", type = "equipar" },
	["wbody|WEAPON_SPECIALCARBINE"] = { index = "specialcarbine", nome = "Special Carbine", type = "equipar" },
	["wbody|WEAPON_BULLPUPRIFLE"] = { index = "bullpuprifle", nome = "Bullpup Rifle", type = "equipar" },
	["wbody|WEAPON_MG"] = { index = "mg", nome = "MG", type = "equipar" },
	["wbody|WEAPON_COMBATMG"] = { index = "combatmg", nome = "Combat MG", type = "equipar" },
	["wbody|WEAPON_GUSENBERG"] = { index = "gusenberg", nome = "Gusenberg", type = "equipar" },
	["wbody|WEAPON_SNIPERRIFLE"] = { index = "sniperrifle", nome = "Sniper Rifle", type = "equipar" },
	["wbody|WEAPON_HEAVYSNIPER"] = { index = "heavysniper", nome = "Heavy Sniper", type = "equipar" },
	["wbody|WEAPON_MARKSMANRIFLE"] = { index = "marksmanrifle", nome = "Marksman Rifle", type = "equipar" },
	["wbody|WEAPON_RPG"] = { index = "rpg", nome = "RPG", type = "equipar" },
	["wbody|WEAPON_GRENADELAUNCHER"] = { index = "grenadelauncher", nome = "Grenade Launcher", type = "equipar" },
	["wbody|WEAPON_GRENADELAUNCHER_SMOKE"] = { index = "grenadelaunchersmoke", nome = "Grenade Launcher.S", type = "equipar" },
	["wbody|WEAPON_COMPACTLAUNCHER"] = { index = "compactlauncher", nome = "Compact Launcher", type = "equipar" },
	["wbody|WEAPON_GRENADE"] = { index = "grenade", nome = "Granada", type = "equipar" },
	["wbody|WEAPON_MOLOTOV"] = { index = "molotov", nome = "Molotov", type = "equipar" },
	["wbody|WEAPON_STICKYBOMB"] = { index = "c4", nome = "C-4", type = "equipar" },
	["wbody|WEAPON_PROXIME"] = { index = "c4", nome = "C-4", type = "equipar" },
	["wbody|WEAPON_DOUBLEACTION"] = { index = "doubleaction", nome = "Double Action", type = "equipar" },
	["wbody|WEAPON_RAYPISTOL"] = { index = "raypistol", nome = "Ray Pistol", type = "equipar" },
	["wbody|WEAPON_NAVYREVOLVER"] = { index = "navyrevolver", nome = "Navy Revolver", type = "equipar" },
	["wbody|WEAPON_ASSAULTSMG"] = { index = "assaultsmg", nome = "Assault SMG", type = "equipar" },
	---------------------------------------------------------------------------------------------------
	--[ FUZIL ]----------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_CARBINERIFLE_MK2"] = { index = "m4a1", nome = "M4A1", type = "equipar" },
	["wbody|WEAPON_ASSAULTRIFLE_MK2"] = { index = "ak47", nome = "AK-47", type = "equipar" },
	["wbody|WEAPON_COMPACTRIFLE"] = { index = "aks", nome = "AKS-74U", type = "equipar" },
	---------------------------------------------------------------------------------------------------
	--[ SMG ]------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_SMG"] = { index = "mp5", nome = "MP5", type = "equipar" },
	["wbody|WEAPON_MICROSMG"] = { index = "uzi", nome = "Uzi", type = "equipar" },
	---------------------------------------------------------------------------------------------------
	--[ SHOTGUN ]--------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_PUMPSHOTGUN_MK2"] = { index = "remington", nome = "Remington 870", type = "equipar" },
	---------------------------------------------------------------------------------------------------
	--[ RIFLES ]---------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody|WEAPON_MUSKET"] = { index = "winchester22", nome = "Winchester 22", type = "equipar" },
	---------------------------------------------------------------------------------------------------
	--[ MUNIÇÕES ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wammo|GADGET_PARACHUTE"] = { index = "m-paraquedas", nome = "M.Paraquedas", type = "recarregar" },
	["wammo|WEAPON_PETROLCAN"] = { index = "combustivel", nome = "Combustível", type = "recarregar" },
	["wammo|WEAPON_FLARE"] = { index = "m-sinalizador", nome = "M.Sinalizador", type = "recarregar" },
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "m-extintor", nome = "M.Extintor", type = "recarregar" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-glock", nome = "M.Glock 19", type = "recarregar" },
	["wammo|WEAPON_REVOLVER_MK2"] = { index = "m-magnum44", nome = "M.MAGNUM 44", type = "recarregar" },
	["wammo|WEAPON_PISTOL_MK2"] = { index = "m-fiveseven", nome = "M.FN Five Seven", type = "recarregar" },
	["wammo|WEAPON_PISTOL50"] = { index = "m-deserteagle", nome = "M.Desert Eagle", type = "recarregar" },
	["wammo|WEAPON_STUNGUN"] = { index = "m-taser", nome = "M.Taser", type = "recarregar" },
	["wammo|WEAPON_CARBINERIFLE_MK2"] = { index = "m-m4a1", nome = "M.M4A1", type = "recarregar" },
	["wammo|WEAPON_ASSAULTRIFLE_MK2"] = { index = "m-ak47", nome = "M.AK-47", type = "recarregar" },
	["wammo|WEAPON_SNSPISTOL"] = { index = "municao", nome = "M.SNS Pistol", type = "recarregar" },
	["wammo|WEAPON_SNSPISTOL_MK2"] = { index = "municao", nome = "M.SNS Pistol", type = "recarregar" },
	["wammo|WEAPON_COMPACTRIFLE"] = { index = "m-aks", nome = "M.AKS-74U", type = "recarregar" },
	["wammo|WEAPON_SMG"] = { index = "m-mp5", nome = "M.MP5", type = "recarregar" },
	["wammo|WEAPON_MICROSMG"] = { index = "m-uzi", nome = "M.UZI", type = "recarregar" },
	["wammo|WEAPON_PUMPSHOTGUN_MK2"] = { index = "m-remington", nome = "M.Remington 870", type = "recarregar" },
	["wammo|WEAPON_MUSKET"] = { index = "m-winchester22", nome = "M.Winchester 22", type = "recarregar" },
	---------------------------------------------------------------------------------------------------
	--[ MUNIÇÕES NOVAS ]-------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wammo|WEAPON_HEAVYPISTOL"] = { index = "m.heavypistol", nome = "M.Heavy Pistol", type = "recarregar" },
	["wammo|WEAPON_APPISTOL"] = { index = "m.apppistol", nome = "M.AP.Pistol", type = "recarregar" },
	["wammo|WEAPON_MINISMG"] = { index = "m.minismg", nome = "M.Mini SMG", type = "recarregar" },
	["wammo|WEAPON_ADVANCEDRIFLE"] = { index = "municao", nome = "M.Advanced Rifle", type = "recarregar" },
	["wammo|WEAPON_SPECIALCARBINE"] = { index = "municao", nome = "M.Special Carbine", type = "recarregar" },
	["wammo|WEAPON_BULLPUPRIFLE"] = { index = "m.bullpuprifle", nome = "M.Bullpup Rifle", type = "recarregar" },
	["wammo|WEAPON_MG"] = { index = "m.mg", nome = "M.MG", type = "recarregar" },
	["wammo|WEAPON_COMBATMG"] = { index = "m.combatmg", nome = "M.Combat MG", type = "recarregar" },
	["wammo|WEAPON_GUSENBERG"] = { index = "m.gusenberg", nome = "M.Gusenberg", type = "recarregar" },
	["wammo|WEAPON_SNIPERRIFLE"] = { index = "m.sniperrifle", nome = "M.Sniper Rifle", type = "recarregar" },
	["wammo|WEAPON_HEAVYSNIPER"] = { index = "m.heavysniper", nome = "M.Heavy Sniper", type = "recarregar" },
	["wammo|WEAPON_MARKSMANRIFLE"] = { index = "m.marksmanrifle", nome = "M.Marksman Rifle", type = "recarregar" },
	["wammo|WEAPON_RPG"] = { index = "m.rpg", nome = "M.RPG", type = "recarregar" },
	["wammo|WEAPON_GRENADELAUNCHER"] = { index = "m.grenadelauncher", nome = "M.Grenade Launcher", type = "recarregar" },
	["wammo|WEAPON_GRENADELAUNCHER_SMOKE"] = { index = "m.grenadelaunchersmoke", nome = "M.Grenade Launcher.S", type = "recarregar" },
	["wammo|WEAPON_COMPACTLAUNCHER"] = { index = "m.compactlauncher", nome = "M.Compact Launcher", type = "recarregar" },
	["wammo|WEAPON_GRENADE"] = { index = "m.grenade", nome = "M.M.Granada", type = "recarregar" },
	["wammo|WEAPON_MOLOTOV"] = { index = "m.molotov", nome = "M.Molotov", type = "recarregar" },
	["wammo|WEAPON_STICKYBOMB"] = { index = "m.c4", nome = "M.C-4", type = "recarregar" },
	["wammo|WEAPON_PROXIME"] = { index = "m.proxime", nome = "M.Proxime", type = "recarregar" },
	["wammo|WEAPON_NAVYREVOLVER"] = { index = "m.navyrevolver", nome = "M.Navy Revolver", type = "recarregar" },
	["wammo|WEAPON_DOUBLEACTION"] = { index = "m.doubleaction", nome = "M.Double Action", type = "recarregar" },
	["wammo|WEAPON_ASSAULTSMG"] = { index = "municao", nome = "M.Assault SMG", type = "recarregar" }
}

function vRP.itemNameList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].nome
	end
end

function vRP.itemIndexList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].index
	end
end

function vRP.itemTypeList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].type
	end
end

function vRP.itemBodyList(item)
	if itemlist[item] ~= nil then
		return itemlist[item]
	end
end

vRP.items = {}
function vRP.defInventoryItem(idname,name,weight)
	if weight == nil then
		weight = 0
	end
	local item = { name = name, weight = weight }
	vRP.items[idname] = item
end

function vRP.computeItemName(item,args)
	if type(item.name) == "string" then
		return item.name
	else
		return item.name(args)
	end
end

function vRP.computeItemWeight(item,args)
	if type(item.weight) == "number" then
		return item.weight
	else
		return item.weight(args)
	end
end

function vRP.parseItem(idname)
	return splitString(idname,"|")
end

function vRP.getItemDefinition(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemName(item,args),vRP.computeItemWeight(item,args)
	end
	return nil,nil
end

function vRP.getItemWeight(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemWeight(item,args)
	end
	return 0
end

function vRP.computeItemsWeight(items)
	local weight = 0
	for k,v in pairs(items) do
		local iweight = vRP.getItemWeight(k)
		weight = weight+iweight*v.amount
	end
	return weight
end

function vRP.giveInventoryItem(user_id,idname,amount)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
		local entry = data.inventory[idname]
		if entry then
			entry.amount = entry.amount + amount
		else
			data.inventory[idname] = { amount = amount }
		end
	end
end

--local creative_itens = "SEUWEBHOOK"

function vRP.tryGetInventoryItem(user_id,idname,amount)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
		--if idname == "tora" or idname == "carnedepuma" or idname == "etiqueta" then
			--creativeLogs(creative_itens,"**USER_ID:** "..user_id.." **ITEM:** "..idname.." - **QUANTIDADE:** "..parseInt(amount).." - "..os.date("%H:%M:%S"))
		--end
		local entry = data.inventory[idname]
		if entry and entry.amount >= amount then
			entry.amount = entry.amount - amount

			if entry.amount <= 0 then
				data.inventory[idname] = nil
			end
			return true
		end
	end
	return false
end

function vRP.getInventoryItemAmount(user_id,idname)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		local entry = data.inventory[idname]
		if entry then
			return entry.amount
		end
	end
	return 0
end

function vRP.getInventory(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		return data.inventory
	end
end

function vRP.getInventoryWeight(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		return vRP.computeItemsWeight(data.inventory)
	end
	return 0
end

function vRP.getInventoryMaxWeight(user_id)
	return math.floor(vRP.expToLevel(vRP.getExp(user_id,"physical","strength")))*3
end

function vRP.clearInventory(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data then
        data.inventory = {}
    end
end

RegisterServerEvent("clearInventory")
AddEventHandler("clearInventory",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local data = vRP.getUserDataTable(user_id)
        if data then
            data.inventory = {}
        end

        vRP.setMoney(user_id,0)
        vRPclient._clearWeapons(source)
        vRPclient._setHandcuffed(source,false)

        if not vRP.hasPermission(user_id,"mochila.permissao") then
            vRP.setExp(user_id,"physical","strength",20)
        end
    end
end)

AddEventHandler("vRP:playerJoin", function(user_id,source,name)
	local data = vRP.getUserDataTable(user_id)
	if not data.inventory then
		data.inventory = {}
	end
end)

local chests = {}
local function build_itemlist_menu(name,items,cb)
	local menu = { name = name }
	local kitems = {}

	local choose = function(player,choice)
		local idname = kitems[choice]
		if idname then
			cb(idname)
		end
	end

	for k,v in pairs(items) do 
		local name,weight = vRP.getItemDefinition(k)
		if name then
			kitems[name] = k
			menu[name] = { choose,"<text01>Quantidade:</text01> <text02>"..v.amount.."</text02><text01>Peso:</text01> <text02>"..string.format("%.2f",weight).."kg</text02>" }
		end
	end

	return menu
end

function vRP.openChest(source,name,max_weight,cb_close,cb_in,cb_out)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		local identity = vRP.getUserIdentity(user_id)
		if data.inventory then
			if not chests[name] then
				local close_count = 0
				local chest = { max_weight = max_weight }
				chests[name] = chest 
				local cdata = vRP.getSData("chest:"..name)
				chest.items = json.decode(cdata) or {}

				local menu = { name = "Baú" }
				local cb_take = function(idname)
					local citem = chest.items[idname]
					local amount = vRP.prompt(source,"Quantidade:","")
					if parseInt(amount) > 0 and parseInt(amount) <= citem.amount then
						local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(idname)*parseInt(amount)
						if new_weight <= vRP.getInventoryMaxWeight(user_id) then
							vRP.giveInventoryItem(user_id,idname,parseInt(amount))
								if name == "static:1" then
									SendWebhookMessage(webhookbaustaticpolicia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Policia "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```<@&628630606649098276>")
								elseif name == "static:2" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Motoclub "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbaumc,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Motoclub "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:3" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Marabunta "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:4" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Ballas "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbauballas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Ballas "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:5" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Vagos "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbauvagos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Vagos "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:6" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Families "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbaugroove,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Families "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:7" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Mafia "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbaumafia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Mafia "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:8" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Bratva "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbaubratva,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Bratva "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:9" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Motoclub "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:10" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Flanela "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbauflanela,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Flanela "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:11" then
									-- Colocar depois
								elseif name == "static:12" then
									--SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Corleone "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:13" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Serpentes "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbauserpentes,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Serpentes "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:14" then
									--SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Concessionaria "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:15" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Cosanostra "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbaucosanostra,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Cosanostra "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							end
							citem.amount = citem.amount - parseInt(amount)

							if citem.amount <= 0 then
								chest.items[idname] = nil
							end

							if cb_out then
								cb_out(idname,parseInt(amount))
							end
							vRP.closeMenu(source)
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Valor inválido.",8000)
					end
				end

				local ch_take = function(player,choice)
					local weight = vRP.computeItemsWeight(chest.items)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",chest.items,cb_take)

					submenu.onclose = function()
						close_count = close_count - 1
						vRP.openMenu(player,menu)
					end
					close_count = close_count + 1
					vRP.openMenu(player,submenu)
				end

				local cb_put = function(idname)
					if string.match(idname,"identidade") then
						TriggerClientEvent("Notify",source,"importante","Não pode guardar a <b>Identidade</b> em veículos.",8000)
						return
					end

					local amount = vRP.prompt(source,"Quantidade:","")
					local new_weight = vRP.computeItemsWeight(chest.items)+vRP.getItemWeight(idname)*parseInt(amount)
					if new_weight <= max_weight then
						if parseInt(amount) > 0 and vRP.tryGetInventoryItem(user_id,idname,parseInt(amount)) then
							
							if name == "static:1" then
								SendWebhookMessage(webhookbaustaticpolicia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Policia "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:2" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Motoclub "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbaumc,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Motoclub "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:3" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Marabunta "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:4" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Ballas "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbauballas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Ballas "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:5" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Vagos "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbauvagos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Vagos "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:6" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Families "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbaugroove,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Families "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:7" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Mafia "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbaumafia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Mafia "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:8" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Bratva "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbaubratva,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Bratva "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:9" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Motoclub "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:10" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Flanela "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbauflanela,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Flanela "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:11" then
								-- Colocar depois
							elseif name == "static:12" then
								--SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Corleone "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:13" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Serpentes "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbauserpentes,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Serpentes "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:14" then
								--SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Concessionaria "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:15" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Cosanostra "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbaucosanostra,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Cosanostra "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							end

							local citem = chest.items[idname]

							if citem ~= nil then
								citem.amount = citem.amount + parseInt(amount)
							else
								chest.items[idname] = { amount = parseInt(amount) }
							end

							if cb_in then
								cb_in(idname,parseInt(amount))
							end
							vRP.closeMenu(source)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Baú cheio.",8000)
					end
				end

				local ch_put = function(player,choice)
					local weight = vRP.computeItemsWeight(data.inventory)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",data.inventory,cb_put)

					submenu.onclose = function()
						close_count = close_count-1
						vRP.openMenu(player,menu)
					end

					close_count = close_count + 1
					vRP.openMenu(player,submenu)
				end

				menu["Retirar"] = { ch_take }
				menu["Colocar"] = { ch_put }

				menu.onclose = function()
					if close_count == 0 then
						vRP.setSData("chest:"..name,json.encode(chest.items))
						chests[name] = nil
						if cb_close then
							cb_close()
						end
					end
				end
				vRP.openMenu(source,menu)
			else
				TriggerClientEvent("Notify",source,"importante","Está sendo utilizado no momento.",8000)
			end
		end
	end
end

local function build_client_static_chests(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(cfg.static_chests) do
			local mtype,x,y,z = table.unpack(v)
			local schest = cfg.static_chest_types[mtype]

			if schest then
				local function schest_enter(source)
					local user_id = vRP.getUserId(source)
					if user_id and vRP.hasPermissions(user_id,schest.permissions or {}) then
						vRP.openChest(source,"static:"..k,schest.weight or 0)
					end
				end

				local function schest_leave(source)
					vRP.closeMenu(source)
				end

				vRP.setArea(source,"vRP:static_chest:"..k,x,y,z,1,1,schest_enter,schest_leave)
			end
		end
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		build_client_static_chests(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
local vehglobal = {
	["blista"] = { ['name'] = "Blista", ['price'] = 80000, ['tipo'] = "carros" },
	["brioso"] = { ['name'] = "Brioso", ['price'] = 35000, ['tipo'] = "carros" },
	["emperor"] = { ['name'] = "Emperor", ['price'] = 55000, ['tipo'] = "carros" },
	["emperor2"] = { ['name'] = "Emperor 2", ['price'] = 40000, ['tipo'] = "carros" },
	["dilettante"] = { ['name'] = "Dilettante", ['price'] = 40000, ['tipo'] = "carros" },
	["issi2"] = { ['name'] = "Issi2", ['price'] = 90000, ['tipo'] = "carros" },
	["panto"] = { ['name'] = "Panto", ['price'] = 8000, ['tipo'] = "carros" },
	["prairie"] = { ['name'] = "Prairie", ['price'] = 25000, ['tipo'] = "carros" },
	["rhapsody"] = { ['name'] = "Rhapsody", ['price'] = 10000, ['tipo'] = "carros" },
	["cogcabrio"] = { ['name'] = "Cogcabrio", ['price'] = 400000, ['tipo'] = "carros" },
	["exemplar"] = { ['name'] = "Exemplar", ['price'] = 80000, ['tipo'] = "carros" },
	["f620"] = { ['name'] = "F620", ['price'] = 55000, ['tipo'] = "carros" },
	["felon"] = { ['name'] = "Felon", ['price'] = 70000, ['tipo'] = "carros" },
	["ingot"] = { ['name'] = "Ingot", ['price'] = 90000, ['tipo'] = "carros" },
	["jackal"] = { ['name'] = "Jackal", ['price'] = 60000, ['tipo'] = "carros" },
	["oracle"] = { ['name'] = "Oracle", ['price'] = 70000, ['tipo'] = "carros" },
	["oracle2"] = { ['name'] = "Oracle2", ['price'] = 80000, ['tipo'] = "carros" },
	["sentinel"] = { ['name'] = "Sentinel", ['price'] = 14000, ['tipo'] = "carros" },
	["sentinel2"] = { ['name'] = "Sentinel2", ['price'] = 50000, ['tipo'] = "carros" },
	["windsor"] = { ['name'] = "Windsor", ['price'] = 150000, ['tipo'] = "carros" },
	["windsor2"] = { ['name'] = "Windsor2", ['price'] = 200000, ['tipo'] = "carros" },
	["zion"] = { ['name'] = "Zion", ['price'] = 80000, ['tipo'] = "carros" },
	["zion2"] = { ['name'] = "Zion2", ['price'] = 85000, ['tipo'] = "carros" },
	["blade"] = { ['name'] = "Blade", ['price'] = 110000, ['tipo'] = "carros" },
	["buccaneer"] = { ['name'] = "Buccaneer", ['price'] = 130000, ['tipo'] = "carros" },
	["buccaneer2"] = { ['name'] = "Buccaneer2", ['price'] = 200000, ['tipo'] = "carros" },
	["primo"] = { ['name'] = "Primo", ['price'] = 40000, ['tipo'] = "carros" },
	["chino"] = { ['name'] = "Chino", ['price'] = 130000, ['tipo'] = "carros" },
	["coquette3"] = { ['name'] = "Coquette3", ['price'] = 195000, ['tipo'] = "carros" },
	["dukes"] = { ['name'] = "Dukes", ['price'] = 180000, ['tipo'] = "carros" },
	["faction"] = { ['name'] = "Faction", ['price'] = 150000, ['tipo'] = "carros" },
	["faction3"] = { ['name'] = "Faction3", ['price'] = 350000, ['tipo'] = "carros" },
	["gauntlet"] = { ['name'] = "Gauntlet", ['price'] = 165000, ['tipo'] = "carros" },
	["gauntlet2"] = { ['name'] = "Gauntlet2", ['price'] = 165000, ['tipo'] = "carros" },
	["hermes"] = { ['name'] = "Hermes", ['price'] = 280000, ['tipo'] = "carros" },
	["hotknife"] = { ['name'] = "Hotknife", ['price'] = 180000, ['tipo'] = "carros" },
	["moonbeam"] = { ['name'] = "Moonbeam", ['price'] = 220000, ['tipo'] = "carros" },
	["moonbeam2"] = { ['name'] = "Moonbeam2", ['price'] = 250000, ['tipo'] = "carros" },
	["nightshade"] = { ['name'] = "Nightshade", ['price'] = 270000, ['tipo'] = "carros" },
	["picador"] = { ['name'] = "Picador", ['price'] = 150000, ['tipo'] = "carros" },
	["ruiner"] = { ['name'] = "Ruiner", ['price'] = 320000, ['tipo'] = "carros" },
	["sabregt"] = { ['name'] = "Sabregt", ['price'] = 350000, ['tipo'] = "carros" },
	["sabregt2"] = { ['name'] = "Sabregt2", ['price'] = 400000, ['tipo'] = "carros" },
	["slamvan"] = { ['name'] = "Slamvan", ['price'] = 100000, ['tipo'] = "carros" },
	["slamvan3"] = { ['name'] = "Slamvan3", ['price'] = 150000, ['tipo'] = "carros" },
	["stalion"] = { ['name'] = "Stalion", ['price'] = 150000, ['tipo'] = "carros" },
	["stalion2"] = { ['name'] = "Stalion2", ['price'] = 150000, ['tipo'] = "carros" },
	["tampa"] = { ['name'] = "Tampa", ['price'] = 220000, ['tipo'] = "carros" },
	["vigero"] = { ['name'] = "Vigero", ['price'] = 170000, ['tipo'] = "carros" },
	["virgo"] = { ['name'] = "Virgo", ['price'] = 130000, ['tipo'] = "carros" },
	["virgo2"] = { ['name'] = "Virgo2", ['price'] = 150000, ['tipo'] = "carros" },
	["virgo3"] = { ['name'] = "Virgo3", ['price'] = 180000, ['tipo'] = "carros" },
	["voodoo"] = { ['name'] = "Voodoo", ['price'] = 190000, ['tipo'] = "carros" },
	["voodoo2"] = { ['name'] = "Voodoo2", ['price'] = 100000, ['tipo'] = "carros" },
	["yosemite"] = { ['name'] = "Yosemite", ['price'] = 350000, ['tipo'] = "carros" },
	["bfinjection"] = { ['name'] = "Bfinjection", ['price'] = 80000, ['tipo'] = "carros" },
	["bifta"] = { ['name'] = "Bifta", ['price'] = 190000, ['tipo'] = "carros" },
	["bodhi2"] = { ['name'] = "Bodhi2", ['price'] = 170000, ['tipo'] = "carros" },
	["brawler"] = { ['name'] = "Brawler", ['price'] = 250000, ['tipo'] = "carros" },
	["trophytruck"] = { ['name'] = "Trophytruck", ['price'] = 400000, ['tipo'] = "carros" },
	["trophytruck2"] = { ['name'] = "Trophytruck2", ['price'] = 400000, ['tipo'] = "carros" },
	["dubsta3"] = { ['name'] = "Dubsta3", ['price'] = 470000, ['tipo'] = "carros" },
	["mesa3"] = { ['name'] = "Mesa3", ['price'] = 200000, ['tipo'] = "carros" },
	["rancherxl"] = { ['name'] = "Rancherxl", ['price'] = 250000, ['tipo'] = "carros" },
	["rebel2"] = { ['name'] = "Rebel2", ['price'] = 250000, ['tipo'] = "carros" },
	["riata"] = { ['name'] = "Riata", ['price'] = 250000, ['tipo'] = "carros" },
	["dloader"] = { ['name'] = "Dloader", ['price'] = 150000, ['tipo'] = "carros" },
	["sandking"] = { ['name'] = "Sandking", ['price'] = 400000, ['tipo'] = "carros" },
	["sandking2"] = { ['name'] = "Sandking2", ['price'] = 350000, ['tipo'] = "carros" },
	["baller"] = { ['name'] = "Baller", ['price'] = 150000, ['tipo'] = "carros" },
	["baller2"] = { ['name'] = "Baller2", ['price'] = 150000, ['tipo'] = "carros" },
	["baller3"] = { ['name'] = "Baller3", ['price'] = 155000, ['tipo'] = "carros" },
	["baller4"] = { ['name'] = "Baller4", ['price'] = 185000, ['tipo'] = "carros" },
	["baller5"] = { ['name'] = "Baller5", ['price'] = 1000000, ['tipo'] = "carros" },
	["baller6"] = { ['name'] = "Baller6", ['price'] = 1200000, ['tipo'] = "carros" },
	["bjxl"] = { ['name'] = "Bjxl", ['price'] = 200000, ['tipo'] = "carros" },
	["cavalcade"] = { ['name'] = "Cavalcade", ['price'] = 110000, ['tipo'] = "carros" },
	["cavalcade2"] = { ['name'] = "Cavalcade2", ['price'] = 150000, ['tipo'] = "carros" },
	["contender"] = { ['name'] = "Contender", ['price'] = 550000, ['tipo'] = "carros" },
	["dubsta"] = { ['name'] = "Dubsta", ['price'] = 250000, ['tipo'] = "carros" },
	["dubsta2"] = { ['name'] = "Dubsta2", ['price'] = 350000, ['tipo'] = "carros" },
	["fq2"] = { ['name'] = "Fq2", ['price'] = 110000, ['tipo'] = "carros" },
	["granger"] = { ['name'] = "Granger", ['price'] = 345000, ['tipo'] = "carros" },
	["gresley"] = { ['name'] = "Gresley", ['price'] = 150000, ['tipo'] = "carros" },
	["habanero"] = { ['name'] = "Habanero", ['price'] = 100000, ['tipo'] = "carros" },
	["seminole"] = { ['name'] = "Seminole", ['price'] = 250000, ['tipo'] = "carros" },
	["serrano"] = { ['name'] = "Serrano", ['price'] = 120000, ['tipo'] = "carros" },
	["xls"] = { ['name'] = "Xls", ['price'] = 170000, ['tipo'] = "carros" },
	["xls2"] = { ['name'] = "Xls2", ['price'] = 300000, ['tipo'] = "carros" },
	["asea"] = { ['name'] = "Asea", ['price'] = 35000, ['tipo'] = "carros" },
	["asterope"] = { ['name'] = "Asterope", ['price'] = 50000, ['tipo'] = "carros" },
	["cog552"] = { ['name'] = "Cog552", ['price'] = 850000, ['tipo'] = "carros" },
	["cognoscenti"] = { ['name'] = "Cognoscenti", ['price'] = 250000, ['tipo'] = "carros" },
	["cognoscenti2"] = { ['name'] = "Cognoscenti2", ['price'] = 850000, ['tipo'] = "carros" },
	["stanier"] = { ['name'] = "Stanier", ['price'] = 55000, ['tipo'] = "carros" },
	["stratum"] = { ['name'] = "Stratum", ['price'] = 75000, ['tipo'] = "carros" },
	["surge"] = { ['name'] = "Surge", ['price'] = 230000, ['tipo'] = "carros" },
	["tailgater"] = { ['name'] = "Tailgater", ['price'] = 110000, ['tipo'] = "carros" },
	["warrener"] = { ['name'] = "Warrener", ['price'] = 90000, ['tipo'] = "carros" },
	["washington"] = { ['name'] = "Washington", ['price'] = 90000, ['tipo'] = "carros" },
	["alpha"] = { ['name'] = "Alpha", ['price'] = 310000, ['tipo'] = "carros" },
	["banshee"] = { ['name'] = "Banshee", ['price'] = 380000, ['tipo'] = "carros" },
	["bestiagts"] = { ['name'] = "Bestiagts", ['price'] = 320000, ['tipo'] = "carros" },
	["blista2"] = { ['name'] = "Blista2", ['price'] = 55000, ['tipo'] = "carros" },
	["blista3"] = { ['name'] = "Blista3", ['price'] = 110000, ['tipo'] = "carros" },
	["buffalo"] = { ['name'] = "Buffalo", ['price'] = 200000, ['tipo'] = "carros" },
	["buffalo3"] = { ['name'] = "Buffalo3", ['price'] = 300000, ['tipo'] = "carros" },
	["carbonizzare"] = { ['name'] = "Carbonizzare", ['price'] = 390000, ['tipo'] = "carros" },
	["comet2"] = { ['name'] = "Comet2", ['price'] = 310000, ['tipo'] = "carros" },
	["comet3"] = { ['name'] = "Comet3", ['price'] = 380000, ['tipo'] = "carros" },
	["comet5"] = { ['name'] = "Comet5", ['price'] = 400000, ['tipo'] = "carros" },
	["coquette"] = { ['name'] = "Coquette", ['price'] = 500000, ['tipo'] = "carros" },
	["elegy"] = { ['name'] = "Elegy", ['price'] = 350000, ['tipo'] = "carros" },
	["elegy2"] = { ['name'] = "Elegy2", ['price'] = 450000, ['tipo'] = "carros" },
	["feltzer2"] = { ['name'] = "Feltzer2", ['price'] = 450000, ['tipo'] = "carros" },
	["furoregt"] = { ['name'] = "Furoregt", ['price'] = 310000, ['tipo'] = "carros" },
	["fusilade"] = { ['name'] = "Fusilade", ['price'] = 210000, ['tipo'] = "carros" },
	["futo"] = { ['name'] = "Futo", ['price'] = 110000, ['tipo'] = "carros" },
	["jester"] = { ['name'] = "Jester", ['price'] = 950000, ['tipo'] = "carros" },
	["khamelion"] = { ['name'] = "Khamelion", ['price'] = 350000, ['tipo'] = "carros" },
	["kuruma"] = { ['name'] = "Kuruma", ['price'] = 500000, ['tipo'] = "carros" },
	["massacro"] = { ['name'] = "Massacro", ['price'] = 350000, ['tipo'] = "carros" },
	["massacro2"] = { ['name'] = "Massacro2", ['price'] = 400000, ['tipo'] = "carros" },
	["ninef"] = { ['name'] = "Ninef", ['price'] = 500000, ['tipo'] = "carros" },
	["ninef2"] = { ['name'] = "Ninef2", ['price'] = 520000, ['tipo'] = "carros" },
	["omnis"] = { ['name'] = "Omnis", ['price'] = 240000, ['tipo'] = "carros" },
	["pariah"] = { ['name'] = "Pariah", ['price'] = 620000, ['tipo'] = "carros" },
	["penumbra"] = { ['name'] = "Penumbra", ['price'] = 200000, ['tipo'] = "carros" },
	["raiden"] = { ['name'] = "Raiden", ['price'] = 450000, ['tipo'] = "carros" },
	["rapidgt"] = { ['name'] = "Rapidgt", ['price'] = 400000, ['tipo'] = "carros" },
	["rapidgt2"] = { ['name'] = "Rapidgt2", ['price'] = 450000, ['tipo'] = "carros" },
	["ruston"] = { ['name'] = "Ruston", ['price'] = 350000, ['tipo'] = "carros" },
	["schafter3"] = { ['name'] = "Schafter3", ['price'] = 270000, ['tipo'] = "carros" },
	["schafter5"] = { ['name'] = "Schafter5", ['price'] = 255000, ['tipo'] = "carros" },
	["schwarzer"] = { ['name'] = "Schwarzer", ['price'] = 200000, ['tipo'] = "carros" },
	["sentinel3"] = { ['name'] = "Sentinel3", ['price'] = 75000, ['tipo'] = "carros" },
	["seven70"] = { ['name'] = "Seven70", ['price'] = 570000, ['tipo'] = "carros" },
	["specter"] = { ['name'] = "Specter", ['price'] = 300000, ['tipo'] = "carros" },
	["specter2"] = { ['name'] = "Specter2", ['price'] = 330000, ['tipo'] = "carros" },
	["streiter"] = { ['name'] = "Streiter", ['price'] = 250000, ['tipo'] = "carros" },
	["sultan"] = { ['name'] = "Sultan", ['price'] = 430000, ['tipo'] = "carros" },
	["surano"] = { ['name'] = "Surano", ['price'] = 360000, ['tipo'] = "carros" },
	["tampa2"] = { ['name'] = "Tampa2", ['price'] = 250000, ['tipo'] = "carros" },
	["tropos"] = { ['name'] = "Tropos", ['price'] = 250000, ['tipo'] = "carros" },
	["verlierer2"] = { ['name'] = "Verlierer2", ['price'] = 200000, ['tipo'] = "carros" },
	["btype2"] = { ['name'] = "Btype2", ['price'] = 460000, ['tipo'] = "carros" },
	["btype3"] = { ['name'] = "Btype3", ['price'] = 485000, ['tipo'] = "carros" },
	["casco"] = { ['name'] = "Casco", ['price'] = 200000, ['tipo'] = "carros" },
	["cheetah"] = { ['name'] = "Cheetah", ['price'] = 425000, ['tipo'] = "carros" },
	["coquette2"] = { ['name'] = "Coquette2", ['price'] = 200000, ['tipo'] = "carros" },
	["feltzer3"] = { ['name'] = "Feltzer3", ['price'] = 220000, ['tipo'] = "carros" },
	["gt500"] = { ['name'] = "Gt500", ['price'] = 350000, ['tipo'] = "carros" },
	["infernus2"] = { ['name'] = "Infernus2", ['price'] = 350000, ['tipo'] = "carros" },
	["jb700"] = { ['name'] = "Jb700", ['price'] = 260000, ['tipo'] = "carros" },
	["mamba"] = { ['name'] = "Mamba", ['price'] = 1200000, ['tipo'] = "carros" },
	["manana"] = { ['name'] = "Manana", ['price'] = 130000, ['tipo'] = "carros" },
	["monroe"] = { ['name'] = "Monroe", ['price'] = 230000, ['tipo'] = "carros" },
	["peyote"] = { ['name'] = "Peyote", ['price'] = 150000, ['tipo'] = "carros" },
	["pigalle"] = { ['name'] = "Pigalle", ['price'] = 150000, ['tipo'] = "carros" },
	["rapidgt3"] = { ['name'] = "Rapidgt3", ['price'] = 300000, ['tipo'] = "carros" },
	["retinue"] = { ['name'] = "Retinue", ['price'] = 200000, ['tipo'] = "carros" },
	["stinger"] = { ['name'] = "Stinger", ['price'] = 210000, ['tipo'] = "carros" },
	["stingergt"] = { ['name'] = "Stingergt", ['price'] = 230000, ['tipo'] = "carros" },
	["torero"] = { ['name'] = "Torero", ['price'] = 160000, ['tipo'] = "carros" },
	["tornado"] = { ['name'] = "Tornado", ['price'] = 250000, ['tipo'] = "carros" },
	["tornado2"] = { ['name'] = "Tornado2", ['price'] = 160000, ['tipo'] = "carros" },
	["tornado6"] = { ['name'] = "Tornado6", ['price'] = 250000, ['tipo'] = "carros" },
	["turismo2"] = { ['name'] = "Turismo2", ['price'] = 290000, ['tipo'] = "carros" },
	["ztype"] = { ['name'] = "Ztype", ['price'] = 500000, ['tipo'] = "carros" },
	["adder"] = { ['name'] = "Adder", ['price'] = 620000, ['tipo'] = "carros" },
	["autarch"] = { ['name'] = "Autarch", ['price'] = 760000, ['tipo'] = "carros" },
	["banshee2"] = { ['name'] = "Banshee2", ['price'] = 430000, ['tipo'] = "carros" },
	["bullet"] = { ['name'] = "Bullet", ['price'] = 420000, ['tipo'] = "carros" },
	["cheetah2"] = { ['name'] = "Cheetah2", ['price'] = 240000, ['tipo'] = "carros" },
	["entityxf"] = { ['name'] = "Entityxf", ['price'] = 850000, ['tipo'] = "carros" },
	["fmj"] = { ['name'] = "Fmj", ['price'] = 900000, ['tipo'] = "carros" },
	["gp1"] = { ['name'] = "Gp1", ['price'] = 659000, ['tipo'] = "carros" },
	["infernus"] = { ['name'] = "Infernus", ['price'] = 650000, ['tipo'] = "carros" },
	["nero"] = { ['name'] = "Nero", ['price'] = 750000, ['tipo'] = "carros" },
	["nero2"] = { ['name'] = "Nero2", ['price'] = 850000, ['tipo'] = "carros" },
	["osiris"] = { ['name'] = "Osiris", ['price'] = 1600000, ['tipo'] = "carros" },
	["penetrator"] = { ['name'] = "Penetrator", ['price'] = 1080000, ['tipo'] = "carros" },
	["pfister811"] = { ['name'] = "Pfister811", ['price'] = 830000, ['tipo'] = "carros" },
	["reaper"] = { ['name'] = "Reaper", ['price'] = 630000, ['tipo'] = "carros" },
	["sc1"] = { ['name'] = "Sc1", ['price'] = 500000, ['tipo'] = "carros" },
	["sultanrs"] = { ['name'] = "Sultan RS", ['price'] = 500000, ['tipo'] = "carros" },
	["t20"] = { ['name'] = "T20", ['price'] = 670000, ['tipo'] = "carros" },
	["tempesta"] = { ['name'] = "Tempesta", ['price'] = 650000, ['tipo'] = "carros" },
	["turismor"] = { ['name'] = "Turismor", ['price'] = 600000, ['tipo'] = "carros" },
	["tyrus"] = { ['name'] = "Tyrus", ['price'] = 1200000, ['tipo'] = "carros" },
	["vacca"] = { ['name'] = "Vacca", ['price'] = 620000, ['tipo'] = "carros" },
	["visione"] = { ['name'] = "Visione", ['price'] = 790000, ['tipo'] = "carros" },
	["voltic"] = { ['name'] = "Voltic", ['price'] = 440000, ['tipo'] = "carros" },
	["zentorno"] = { ['name'] = "Zentorno", ['price'] = 920000, ['tipo'] = "carros" },
	["sadler"] = { ['name'] = "Sadler", ['price'] = 300000, ['tipo'] = "carros" },
	["bison"] = { ['name'] = "Bison", ['price'] = 400000, ['tipo'] = "carros" },
	["bison2"] = { ['name'] = "Bison2", ['price'] = 430000, ['tipo'] = "carros" },
	["bobcatxl"] = { ['name'] = "Bobcatxl", ['price'] = 260000, ['tipo'] = "carros" },
	--["burrito"] = { ['name'] = "Burrito", ['price'] = 260000, ['tipo'] = "carros" },
	--["burrito2"] = { ['name'] = "Burrito2", ['price'] = 260000, ['tipo'] = "carros" },
	["burrito3"] = { ['name'] = "Burrito3", ['price'] = 260000, ['tipo'] = "carros" },
	--["burrito4"] = { ['name'] = "Burrito4", ['price'] = 260000, ['tipo'] = "carros" },
	["mule4"] = { ['name'] = "Mule4", ['price'] = 900000, ['tipo'] = "carros" },
	["rallytruck"] = { ['name'] = "RallyTruck", ['price'] = 1800000, ['tipo'] = "carros" },
	["minivan"] = { ['name'] = "Minivan", ['price'] = 110000, ['tipo'] = "carros" },
	["minivan2"] = { ['name'] = "Minivan2", ['price'] = 220000, ['tipo'] = "carros" },
	["paradise"] = { ['name'] = "Paradise", ['price'] = 460000, ['tipo'] = "carros" },
	["pony"] = { ['name'] = "Pony", ['price'] = 490000, ['tipo'] = "carros" },
	["pony2"] = { ['name'] = "Pony2", ['price'] = 500000, ['tipo'] = "carros" },
	["rumpo"] = { ['name'] = "Rumpo", ['price'] = 460000, ['tipo'] = "carros" },
	--["rumpo2"] = { ['name'] = "Rumpo2", ['price'] = 260000, ['tipo'] = "carros" },
	["rumpo3"] = { ['name'] = "Rumpo3", ['price'] = 650000, ['tipo'] = "carros" },
	["surfer"] = { ['name'] = "Surfer", ['price'] = 600000, ['tipo'] = "carros" },
	--["youga"] = { ['name'] = "Youga", ['price'] = 260000, ['tipo'] = "carros" },
	["huntley"] = { ['name'] = "Huntley", ['price'] = 310000, ['tipo'] = "carros" },
	["landstalker"] = { ['name'] = "Landstalker", ['price'] = 230000, ['tipo'] = "carros" },
	["mesa"] = { ['name'] = "Mesa", ['price'] = 190000, ['tipo'] = "carros" },
	["patriot"] = { ['name'] = "Patriot", ['price'] = 350000, ['tipo'] = "carros" },
	["radi"] = { ['name'] = "Radi", ['price'] = 100000, ['tipo'] = "carros" },
	["rocoto"] = { ['name'] = "Rocoto", ['price'] = 210000, ['tipo'] = "carros" },
	["tyrant"] = { ['name'] = "Tyrant", ['price'] = 700000, ['tipo'] = "carros" },
	["entity2"] = { ['name'] = "Entity2", ['price'] = 1000000, ['tipo'] = "carros" },
	["cheburek"] = { ['name'] = "Cheburek", ['price'] = 70000, ['tipo'] = "carros" },
	["hotring"] = { ['name'] = "Hotring", ['price'] = 210000, ['tipo'] = "carros" },
	["jester3"] = { ['name'] = "Jester3", ['price'] = 545000, ['tipo'] = "carros" },
	["flashgt"] = { ['name'] = "Flashgt", ['price'] = 470000, ['tipo'] = "carros" },
	["ellie"] = { ['name'] = "Ellie", ['price'] = 300000, ['tipo'] = "carros" },
	["michelli"] = { ['name'] = "Michelli", ['price'] = 100000, ['tipo'] = "carros" },
	["fagaloa"] = { ['name'] = "Fagaloa", ['price'] = 120000, ['tipo'] = "carros" },
	["dominator"] = { ['name'] = "Dominator", ['price'] = 300000, ['tipo'] = "carros" },
	["dominator2"] = { ['name'] = "Dominator2", ['price'] = 500000, ['tipo'] = "carros" },
	["dominator3"] = { ['name'] = "Dominator3", ['price'] = 1250000, ['tipo'] = "carros" },
	["issi3"] = { ['name'] = "Issi3", ['price'] = 190000, ['tipo'] = "carros" },
	["taipan"] = { ['name'] = "Taipan", ['price'] = 620000, ['tipo'] = "carros" },
	["gb200"] = { ['name'] = "Gb200", ['price'] = 295000, ['tipo'] = "carros" },
	["stretch"] = { ['name'] = "Stretch", ['price'] = 1520000, ['tipo'] = "carros" },
	["guardian"] = { ['name'] = "Guardian", ['price'] = 640000, ['tipo'] = "carros" },
	["kamacho"] = { ['name'] = "Kamacho", ['price'] = 460000, ['tipo'] = "carros" },
	["neon"] = { ['name'] = "Neon", ['price'] = 700000, ['tipo'] = "carros" },
	["cyclone"] = { ['name'] = "Cyclone", ['price'] = 1220000, ['tipo'] = "carros" },
	["italigtb"] = { ['name'] = "Italigtb", ['price'] = 1000000, ['tipo'] = "carros" },
	["italigtb2"] = { ['name'] = "Italigtb2", ['price'] = 1200000, ['tipo'] = "carros" },
	["vagner"] = { ['name'] = "Vagner", ['price'] = 780000, ['tipo'] = "carros" },
	["xa21"] = { ['name'] = "Xa21", ['price'] = 1330000, ['tipo'] = "carros" },
	["tezeract"] = { ['name'] = "Tezeract", ['price'] = 920000, ['tipo'] = "carros" },
	["prototipo"] = { ['name'] = "Prototipo", ['price'] = 800000, ['tipo'] = "carros" },
	["patriot2"] = { ['name'] = "Patriot2", ['price'] = 1050000, ['tipo'] = "carros" },
	["swinger"] = { ['name'] = "Swinger", ['price'] = 1050000, ['tipo'] = "carros" },
	["clique"] = { ['name'] = "Clique", ['price'] = 30000, ['tipo'] = "carros" },
	["deveste"] = { ['name'] = "Deveste", ['price'] = 1250000, ['tipo'] = "carros" },
	["deviant"] = { ['name'] = "Deviant", ['price'] = 770000, ['tipo'] = "carros" },
	["impaler"] = { ['name'] = "Impaler", ['price'] = 820000, ['tipo'] = "carros" },
	["italigto"] = { ['name'] = "Italigto", ['price'] = 1000000, ['tipo'] = "carros" },
	["schlagen"] = { ['name'] = "Schlagen", ['price'] = 700000, ['tipo'] = "carros" },
	["toros"] = { ['name'] = "Toros", ['price'] = 520000, ['tipo'] = "carros" },
	["tulip"] = { ['name'] = "Tulip", ['price'] = 320000, ['tipo'] = "carros" },
	["vamos"] = { ['name'] = "Vamos", ['price'] = 320000, ['tipo'] = "carros" },
	["freecrawler"] = { ['name'] = "Freecrawler", ['price'] = 650000, ['tipo'] = "carros" },
	["fugitive"] = { ['name'] = "Fugitive", ['price'] = 250000, ['tipo'] = "carros" },
	["glendale"] = { ['name'] = "Glendale", ['price'] = 90000, ['tipo'] = "carros" },
	["intruder"] = { ['name'] = "Intruder", ['price'] = 60000, ['tipo'] = "carros" },
	["le7b"] = { ['name'] = "Le7b", ['price'] = 700000, ['tipo'] = "carros" },
	["lurcher"] = { ['name'] = "Lurcher", ['price'] = 150000, ['tipo'] = "carros" },
	["lynx"] = { ['name'] = "Lynx", ['price'] = 970000, ['tipo'] = "carros" },
	["phoenix"] = { ['name'] = "Phoenix", ['price'] = 500000, ['tipo'] = "carros" },
	["premier"] = { ['name'] = "Premier", ['price'] = 50000, ['tipo'] = "carros" },
	["raptor"] = { ['name'] = "Raptor", ['price'] = 400000, ['tipo'] = "carros" },
	["sheava"] = { ['name'] = "Sheava", ['price'] = 500000, ['tipo'] = "carros" },
	["z190"] = { ['name'] = "Z190", ['price'] = 350000, ['tipo'] = "carros" },
	["freecrawler"] = { ['name'] = "Freecrawler", ['price'] = 300000, ['tipo'] = "carros" },
	["type263"] = { ['name'] = "Kombi 63", ['price'] = 500000, ['tipo'] = "carros" },
	["beetle74"] = { ['name'] = "Fusca 74", ['price'] = 500000, ['tipo'] = "carros" },
	["fe86"] = { ['name'] = "Escorte", ['price'] = 500000, ['tipo'] = "carros" },

	--MOTOS
	
	["akuma"] = { ['name'] = "Akuma", ['price'] = 500000, ['tipo'] = "motos" },
	["avarus"] = { ['name'] = "Avarus", ['price'] = 440000, ['tipo'] = "motos" },
	["bagger"] = { ['name'] = "Bagger", ['price'] = 300000, ['tipo'] = "motos" },
	["bati"] = { ['name'] = "Bati", ['price'] = 370000, ['tipo'] = "motos" },
	["bati2"] = { ['name'] = "Bati2", ['price'] = 400000, ['tipo'] = "motos" },
	["bf400"] = { ['name'] = "Bf400", ['price'] = 280000, ['tipo'] = "motos" },
	["carbonrs"] = { ['name'] = "Carbonrs", ['price'] = 400000, ['tipo'] = "motos" },
	["chimera"] = { ['name'] = "Chimera", ['price'] = 340000, ['tipo'] = "motos" },
	["cliffhanger"] = { ['name'] = "Cliffhanger", ['price'] = 300000, ['tipo'] = "motos" },
	["daemon2"]  = { ['name'] = "Daemon2", ['price'] = 250000, ['tipo'] = "motos" },
	["defiler"] = { ['name'] = "Defiler", ['price'] = 390000, ['tipo'] = "motos" },
	["diablous"] = { ['name'] = "Diablous", ['price'] = 630000, ['tipo'] = "motos" },
	["diablous2"] = { ['name'] = "Diablous2", ['price'] = 660000, ['tipo'] = "motos" },
	["double"] = { ['name'] = "Double", ['price'] = 660000, ['tipo'] = "motos" },
	["enduro"] = { ['name'] = "Enduro", ['price'] = 200000, ['tipo'] = "motos" },
	["esskey"] = { ['name'] = "Esskey", ['price'] = 320000, ['tipo'] = "motos" },
	["faggio"] = { ['name'] = "Faggio", ['price'] = 4000, ['tipo'] = "motos" },
	["faggio2"] = { ['name'] = "Faggio2", ['price'] = 5000, ['tipo'] = "motos" },
	["faggio3"] = { ['name'] = "Faggio3", ['price'] = 6000, ['tipo'] = "motos" },
	["fcr"] = { ['name'] = "Fcr", ['price'] = 270000, ['tipo'] = "motos" },
	["fcr2"] = { ['name'] = "Fcr2", ['price'] = 310000, ['tipo'] = "motos" },
	["gargoyle"] = { ['name'] = "Gargoyle", ['price'] = 345000, ['tipo'] = "motos" },
	["hakuchou"] = { ['name'] = "Hakuchou", ['price'] = 700000, ['tipo'] = "motos" },
	["hakuchou2"] = { ['name'] = "Hakuchou2", ['price'] = 850000, ['tipo'] = "motos" },
	["hexer"] = { ['name'] = "Hexer", ['price'] = 250000, ['tipo'] = "motos" },
	["innovation"] = { ['name'] = "Innovation", ['price'] = 450000, ['tipo'] = "motos" },
	["lectro"] = { ['name'] = "Lectro", ['price'] = 470000, ['tipo'] = "motos" },
	["manchez"] = { ['name'] = "Manchez", ['price'] = 355000, ['tipo'] = "motos" },
	["nemesis"] = { ['name'] = "Nemesis", ['price'] = 350000, ['tipo'] = "motos" },
	["nightblade"] = { ['name'] = "Nightblade", ['price'] = 510000, ['tipo'] = "motos" },
	["pcj"] = { ['name'] = "Pcj", ['price'] = 330000, ['tipo'] = "motos" },
	["ruffian"] = { ['name'] = "Ruffian", ['price'] = 345000, ['tipo'] = "motos" },
	["sanchez"] = { ['name'] = "Sanchez", ['price'] = 185000, ['tipo'] = "motos" },
	["sanchez2"] = { ['name'] = "Sanchez2", ['price'] = 195000, ['tipo'] = "motos" },
	["sovereign"] = { ['name'] = "Sovereign", ['price'] = 385000, ['tipo'] = "motos" },
	["thrust"] = { ['name'] = "Thrust", ['price'] = 375000, ['tipo'] = "motos" },
	["vader"] = { ['name'] = "Vader", ['price'] = 345000, ['tipo'] = "motos" },
	["vindicator"] = { ['name'] = "Vindicator", ['price'] = 340000, ['tipo'] = "motos" },
	["vortex"] = { ['name'] = "Vortex", ['price'] = 315000, ['tipo'] = "motos" },
	["wolfsbane"] = { ['name'] = "Wolfsbane", ['price'] = 390000, ['tipo'] = "motos" },
	["zombiea"] = { ['name'] = "Zombiea", ['price'] = 355000, ['tipo'] = "motos" },
	["zombieb"] = { ['name'] = "Zombieb", ['price'] = 360000, ['tipo'] = "motos" },
	["shotaro"] = { ['name'] = "Shotaro", ['price'] = 1500000, ['tipo'] = "motos" },
	["ratbike"] = { ['name'] = "Ratbike", ['price'] = 230000, ['tipo'] = "motos" },
	["blazer"] = { ['name'] = "Blazer", ['price'] = 230000, ['tipo'] = "motos" },
	["blazer4"] = { ['name'] = "Blazer4", ['price'] = 370000, ['tipo'] = "motos" },
	["africat"] = { ['name'] = "Africa Twin", ['price'] = 400000, ['tipo'] = "motos" },
	["rc"] = { ['name'] = "KTM", ['price'] = 4000000, ['tipo'] = "motos" },



	--TRABALHO

	["youga2"] = { ['name'] = "Youga2", ['price'] = 1000, ['tipo'] = "work" },
	["stockade"] = { ['name'] = "Stockade", ['price'] = 1000, ['tipo'] = "work" },
	["felon2"] = { ['name'] = "Felon2", ['price'] = 1000, ['tipo'] = "work" },
	["boxville2"] = { ['name'] = "Boxville2", ['price'] = 1000, ['tipo'] = "work" },
	["pbus"] = { ['name'] = "PBus", ['price'] = 1000, ['tipo'] = "work" },
	["policiacharger2018"] = { ['name'] = "Dodge Charger 2018", ['price'] = 1000, ['tipo'] = "work" },
	["policiamustanggt"] = { ['name'] = "Mustang GT", ['price'] = 1000, ['tipo'] = "work" },
	["14charger"] = { ['name'] = "2014 Charger", ['price'] = 1000, ['tipo'] = "work" },
	["18tahoe"] = { ['name'] = "2018 Tahoe", ['price'] = 1000, ['tipo'] = "work" },
	["18charger"] = { ['name'] = "2018 Charger", ['price'] = 1000, ['tipo'] = "work" },
	["19durango"] = { ['name'] = "Unidade Tatica", ['price'] = 1000, ['tipo'] = "work" },
	["chargervtr"] = { ['name'] = "Sheriff NÃO USAR", ['price'] = 1000, ['tipo'] = "work" },
	["policiacapricesid"] = { ['name'] = "GM Caprice SID", ['price'] = 1000, ['tipo'] = "work" },
	["policiaschaftersid"] = { ['name'] = "GM Schafter SID", ['price'] = 1000, ['tipo'] = "work" },
	["policiasilverado"] = { ['name'] = "Chevrolet Silverado", ['price'] = 1000, ['tipo'] = "work" },
	["policiatahoe"] = { ['name'] = "Chevrolet Tahoe", ['price'] = 1000, ['tipo'] = "work" },
	["policiaexplorer"] = { ['name'] = "Ford Explorer", ['price'] = 1000, ['tipo'] = "work" },
	["policiataurus"] = { ['name'] = "Ford Taurus", ['price'] = 1000, ['tipo'] = "work" },
	["policiavictoria"] = { ['name'] = "Ford Victoria", ['price'] = 1000, ['tipo'] = "work" },
	["pol718"] = { ['name'] = "Porsche", ['price'] = 1000, ['tipo'] = "work" },
	["ems_gs1200"] = { ['name'] = "Moto Policia", ['price'] = 1000, ['tipo'] = "work" },
	["scorcher"] = { ['name'] = "Policia Bicicleta", ['price'] = 1000, ['tipo'] = "work" },
	["policiabmwr1200"] = { ['name'] = "BMW R1200", ['price'] = 1000, ['tipo'] = "work" },
	["policiaheli"] = { ['name'] = "Policia Helicóptero", ['price'] = 1000, ['tipo'] = "work" },
	["fbi2"] = { ['name'] = "Granger SOG", ['price'] = 1000, ['tipo'] = "work" },
	["policeb"] = { ['name'] = "Harley Davidson", ['price'] = 1000, ['tipo'] = "work" },
	["riot"] = { ['name'] = "Blindado", ['price'] = 1000, ['tipo'] = "work" },
	["paramedicoambu"] = { ['name'] = "Ambulância", ['price'] = 1000, ['tipo'] = "work" },
	["ambulance"] = { ['name'] = "Ambulancia", ['price'] = 1000, ['tipo'] = "work" },
	["qrv"] = { ['name'] = "Explore", ['price'] = 1000, ['tipo'] = "work" },
	["hpsuv"] = { ['name'] = "SUV", ['price'] = 1000, ['tipo'] = "work" },
	["paramedicocharger2014"] = { ['name'] = "Dodge Charger 2014", ['price'] = 1000, ['tipo'] = "work" },
	["paramedicoheli"] = { ['name'] = "Paramédico Helicóptero", ['price'] = 1000, ['tipo'] = "work" },
	["seasparrow"] = { ['name'] = "Paramédico Helicóptero Água", ['price'] = 1000, ['tipo'] = "work" },
	["coach"] = { ['name'] = "Coach", ['price'] = 1000, ['tipo'] = "work" },
	["bus"] = { ['name'] = "Ônibus", ['price'] = 1000, ['tipo'] = "work" },
	["flatbed"] = { ['name'] = "Reboque", ['price'] = 1000, ['tipo'] = "work" },
	["towtruck"] = { ['name'] = "Towtruck", ['price'] = 1000, ['tipo'] = "work" },
	["towtruck2"] = { ['name'] = "Towtruck2", ['price'] = 1000, ['tipo'] = "work" },
	["ratloader"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["ratloader2"] = { ['name'] = "Ratloader2", ['price'] = 1000, ['tipo'] = "work" },
	["rubble"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["taxi"] = { ['name'] = "Taxi", ['price'] = 1000, ['tipo'] = "work" },
	["boxville4"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["trash2"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["tiptruck"] = { ['name'] = "Tiptruck", ['price'] = 1000, ['tipo'] = "work" },
	["scorcher"] = { ['name'] = "Scorcher", ['price'] = 1000, ['tipo'] = "work" },
	["mule3"] = { ['name'] = "Mule", ['price'] = 1000, ['tipo'] = "work" },
	["tribike"] = { ['name'] = "Tribike", ['price'] = 1000, ['tipo'] = "work" },
	["tribike2"] = { ['name'] = "Tribike2", ['price'] = 1000, ['tipo'] = "work" },
	["tribike3"] = { ['name'] = "Tribike3", ['price'] = 1000, ['tipo'] = "work" },
	["fixter"] = { ['name'] = "Fixter", ['price'] = 1000, ['tipo'] = "work" },
	["cruiser"] = { ['name'] = "Cruiser", ['price'] = 1000, ['tipo'] = "work" },
	["bmx"] = { ['name'] = "Bmx", ['price'] = 1000, ['tipo'] = "work" },
	["surfboard"] = { ['name'] = "Prancha de Surf", ['price'] = 1000, ['tipo'] = "work" },
	["dinghy"] = { ['name'] = "Dinghy", ['price'] = 1000, ['tipo'] = "work" },
	["jetmax"] = { ['name'] = "Jetmax", ['price'] = 1000, ['tipo'] = "work" },
	["marquis"] = { ['name'] = "Marquis", ['price'] = 1000, ['tipo'] = "work" },
	["seashark3"] = { ['name'] = "Seashark3", ['price'] = 1000, ['tipo'] = "work" },
	["speeder"] = { ['name'] = "Speeder", ['price'] = 1000, ['tipo'] = "work" },
	["speeder2"] = { ['name'] = "Speeder2", ['price'] = 1000, ['tipo'] = "work" },
	["squalo"] = { ['name'] = "Squalo", ['price'] = 1000, ['tipo'] = "work" },
	["suntrap"] = { ['name'] = "Suntrap", ['price'] = 1000, ['tipo'] = "work" },
	["toro"] = { ['name'] = "Toro", ['price'] = 1000, ['tipo'] = "work" },
	["toro2"] = { ['name'] = "Toro2", ['price'] = 1000, ['tipo'] = "work" },
	["tropic"] = { ['name'] = "Tropic", ['price'] = 1000, ['tipo'] = "work" },
	["tropic2"] = { ['name'] = "Tropic2", ['price'] = 1000, ['tipo'] = "work" },
	["phantom"] = { ['name'] = "Phantom", ['price'] = 1000, ['tipo'] = "work" },
	["packer"] = { ['name'] = "Packer", ['price'] = 1000, ['tipo'] = "work" },
	["supervolito"] = { ['name'] = "Supervolito", ['price'] = 1000, ['tipo'] = "work" },
	["supervolito2"] = { ['name'] = "Supervolito2", ['price'] = 1000, ['tipo'] = "work" },
	["cuban800"] = { ['name'] = "Cuban800", ['price'] = 1000, ['tipo'] = "work" },
	["mammatus"] = { ['name'] = "Mammatus", ['price'] = 1000, ['tipo'] = "work" },
	["vestra"] = { ['name'] = "Vestra", ['price'] = 1000, ['tipo'] = "work" },
	["velum2"] = { ['name'] = "Velum2", ['price'] = 1000, ['tipo'] = "work" },
	["buzzard2"] = { ['name'] = "Buzzard2", ['price'] = 1000, ['tipo'] = "work" },
	["frogger"] = { ['name'] = "Frogger", ['price'] = 1000, ['tipo'] = "work" },
	["maverick"] = { ['name'] = "Maverick", ['price'] = 1000, ['tipo'] = "work" },
	["tanker2"] = { ['name'] = "Gas", ['price'] = 1000, ['tipo'] = "work" },
	["armytanker"] = { ['name'] = "Diesel", ['price'] = 1000, ['tipo'] = "work" },
	["tvtrailer"] = { ['name'] = "Show", ['price'] = 1000, ['tipo'] = "work" },
	["trailerlogs"] = { ['name'] = "Woods", ['price'] = 1000, ['tipo'] = "work" },
	["tr4"] = { ['name'] = "Cars", ['price'] = 1000, ['tipo'] = "work" },
	["speedo"] = { ['name'] = "Speedo", ['price'] = 200000, ['tipo'] = "work" },
	["primo2"] = { ['name'] = "Primo2", ['price'] = 200000, ['tipo'] = "work" },
	["faction2"] = { ['name'] = "Faction2", ['price'] = 200000, ['tipo'] = "work" },
	["chino2"] = { ['name'] = "Chino2", ['price'] = 200000, ['tipo'] = "work" },
	["tornado5"] = { ['name'] = "Tornado5", ['price'] = 200000, ['tipo'] = "work" },
	["daemon"] = { ['name'] = "Daemon", ['price'] = 200000, ['tipo'] = "work" },
	["sanctus"] = { ['name'] = "Sanctus", ['price'] = 200000, ['tipo'] = "work" },
	["gburrito"] = { ['name'] = "GBurrito", ['price'] = 200000, ['tipo'] = "work" },
	["slamvan2"] = { ['name'] = "Slamvan2", ['price'] = 100000, ['tipo'] = "work" },
	["stafford"] = { ['name'] = "Stafford", ['price'] = 200000, ['tipo'] = "work" },
	["cog55"] = { ['name'] = "Cog55", ['price'] = 200000, ['tipo'] = "work" },
	["superd"] = { ['name'] = "Superd", ['price'] = 200000, ['tipo'] = "work" },
	["btype"] = { ['name'] = "Btype", ['price'] = 200000, ['tipo'] = "work" },
	["tractor2"] = { ['name'] = "Tractor2", ['price'] = 1000, ['tipo'] = "work" },
	["rebel"] = { ['name'] = "Rebel", ['price'] = 1000, ['tipo'] = "work" },
	["flatbed3"] = { ['name'] = "flatbed3", ['price'] = 1000, ['tipo'] = "work" },
	["volatus"] = { ['name'] = "Volatus", ['price'] = 1000000, ['tipo'] = "work" },
	["cargobob2"] = { ['name'] = "Cargo Bob", ['price'] = 1000000, ['tipo'] = "work" },		
	
	--IMPORTADOS

	["dodgechargersrt"] = { ['name'] = "Dodge Charger SRT", ['price'] = 5400000, ['tipo'] = "import" },
	["audirs6"] = { ['name'] = "Audi RS6", ['price'] = 2800000, ['tipo'] = "import" },
	["bmwm3f80"] = { ['name'] = "BMW M3 F80", ['price'] = 2650000, ['tipo'] = "import" },
	["fordmustang"] = { ['name'] = "Ford Mustang", ['price'] = 3100000, ['tipo'] = "import" },
	["lancerevolution9"] = { ['name'] = "Lancer Evolution 9", ['price'] = 2600000, ['tipo'] = "import" },
	["lancerevolutionx"] = { ['name'] = "Lancer Evolution X", ['price'] = 2900000, ['tipo'] = "import" },
	["focusrs"] = { ['name'] = "Focus RS", ['price'] = 2400000, ['tipo'] = "import" },
	["mercedesa45"] = { ['name'] = "Mercedes A45", ['price'] = 2600000, ['tipo'] = "import" },
	["audirs7"] = { ['name'] = "Audi RS7", ['price'] = 3100000, ['tipo'] = "import" },
	["hondafk8"] = { ['name'] = "Honda FK8", ['price'] = 2900000, ['tipo'] = "import" },
	["mustangmach1"] = { ['name'] = "Mustang Mach 1", ['price'] = 3500000, ['tipo'] = "import" },
	["teslaprior"] = { ['name'] = "Tesla Prior", ['price'] = 3150000, ['tipo'] = "import" },		
	["m2"] = { ['name'] = "BMW M2", ['price'] = 3100000, ['tipo'] = "import" },
	["amarok"] = { ['name'] = "VW Amarok", ['price'] = 3300000, ['tipo'] = "import" },
	["bbentayga"] = { ['name'] = "Bentley Bentayga", ['price'] = 3600000, ['tipo'] = "import" },
	["evoque"] = { ['name'] = "Ranger Rover Evoque", ['price'] = 2500000, ['tipo'] = "import" },
	["xj6"] = { ['name'] = "XJ-6", ['price'] = 2600000, ['tipo'] = "import" },
	["btr04"] = { ['name'] = "Subaru Impreza STI 2006", ['price'] = 3500000, ['tipo'] = "import" },
	["z28"] = { ['name'] = "Camaro 2018 z 4.0", ['price'] = 3900000, ['tipo'] = "import" },
	["c7"] = { ['name'] = "Corvete C7 Stingray", ['price'] = 3900000, ['tipo'] = "import" },
	["mlnovitec"] = { ['name'] = "Maserati Levante Novitec", ['price'] = 4100000, ['tipo'] = "import" },
	["cx75"] = { ['name'] = "Jaguar cx75", ['price'] = 4200000, ['tipo'] = "import" },
	["dk350z"] = { ['name'] = "Nissan 350z", ['price'] = 6300000, ['tipo'] = "import" },
	["urus"] = { ['name'] = "Lamborghini Urus", ['price'] = 7700000, ['tipo'] = "import" },
	["sti"] = { ['name'] = "Subaru Impreza WRX STI Sedan 2011", ['price'] = 5200000, ['tipo'] = "import" },
	["sq72016"] = { ['name'] = "Audi SQ7", ['price'] = 5200000, ['tipo'] = "import" },
	["sbrwrx"] = { ['name'] = "Subaru Impreza Rally", ['price'] = 7200000, ['tipo'] = "import" },
	["spyker"] = { ['name'] = "Spyker", ['price'] = 5400000, ['tipo'] = "import" },
	["raptor2017"] = { ['name'] = "Ford Ranger Raptor", ['price'] = 4100000, ['tipo'] = "import" },
	["amggtr"] = { ['name'] = "Mercedez AMG GTR", ['price'] = 5300000, ['tipo'] = "import" },
	["nissan370z"] = { ['name'] = "Nissan 370z", ['price'] = 5300000, ['tipo'] = "import" },
	["fz07"] = { ['name'] = "Yamaha FZ", ['price'] = 520000, ['tipo'] = "import" },
	["charger"] = { ['name'] = "Dodge Charger 1995", ['price'] = 4300000, ['tipo'] = "import" },
	["moss"] = { ['name'] = "Mercedez Sls Amg Boss", ['price'] = 5100000, ['tipo'] = "import" },
	["hornet"] = { ['name'] = "Hornet", ['price'] = 2600000, ['tipo'] = "import" },
	["tiger"] = { ['name'] = "Tiger", ['price'] = 2800000, ['tipo'] = "import" },
	["terzo"] = { ['name'] = "Lamborghini Terzo", ['price'] = 9600000, ['tipo'] = "import" },
	["4c"] = { ['name'] = "Alfa Romeo 4C", ['price'] = 5500000, ['tipo'] = "import" },
	["99viper"] = { ['name'] = "Viper", ['price'] = 6200000, ['tipo'] = "import" },
	["ap2"] = { ['name'] = "ap2", ['price'] = 6200000, ['tipo'] = "import" },
	["contgt2011"] = { ['name'] = "contgt2011", ['price'] = 6200000, ['tipo'] = "import" },
	["mteche39"] = { ['name'] = "MTECHE39", ['price'] = 6200000, ['tipo'] = "import" },
	["rcf"] = { ['name'] = "rcf", ['price'] = 4200000, ['tipo'] = "import" },
	["rs5"] = { ['name'] = "Audi RS5", ['price'] = 4100000, ['tipo'] = "import" },
	["s600w220"] = { ['name'] = "s600w220", ['price'] = 6200000, ['tipo'] = "import" },
	["rs318"] = { ['name'] = "Audi RS3", ['price'] = 3400000, ['tipo'] = "import" },
	["amggt"] = { ['name'] = "Mercedez AMG GTR", ['price'] = 6400000, ['tipo'] = "import" },
	["f82"] = { ['name'] = "f82", ['price'] = 4400000, ['tipo'] = "import" },
	["cayenne"] = { ['name'] = "Porsche Cayenne", ['price'] = 8100000, ['tipo'] = "import" },
	["fx50s"] = { ['name'] = "fx50s", ['price'] = 4400000, ['tipo'] = "import" },
	["argiulia"] = { ['name'] = "argiulia", ['price'] = 2400000, ['tipo'] = "import" },
	["megaram"] = { ['name'] = "megaram", ['price'] = 2900000, ['tipo'] = "import" },
	["boss302"] = { ['name'] = "boss302", ['price'] = 2900000, ['tipo'] = "import" },
	["pana"] = { ['name'] = "pana", ['price'] = 2900000, ['tipo'] = "import" },
	["pg8"] = { ['name'] = "pg8", ['price'] = 2900000, ['tipo'] = "import" },
	["rrsport"] = { ['name'] = "rrsport", ['price'] = 2900000, ['tipo'] = "import" },
	["runner"] = { ['name'] = "runner", ['price'] = 2900000, ['tipo'] = "import" },
	["srt8"] = { ['name'] = "srt8", ['price'] = 2900000, ['tipo'] = "import" },
	["vapidlow"] = { ['name'] = "vapidlow", ['price'] = 2900000, ['tipo'] = "import" },
	["demon"] = { ['name'] = "demon", ['price'] = 2900000, ['tipo'] = "import" },
	["z28"] = { ['name'] = "z28", ['price'] = 2900000, ['tipo'] = "import" },
	["e63amg"] = { ['name'] = "e63amg", ['price'] = 2900000, ['tipo'] = "import" },
	["gt86"] = { ['name'] = "gt86", ['price'] = 2900000, ['tipo'] = "import" },
	["h1humm"] = { ['name'] = "h1humm", ['price'] = 2900000, ['tipo'] = "import" },
	["h6"] = { ['name'] = "h6", ['price'] = 2900000, ['tipo'] = "import" },
	["k5blzr"] = { ['name'] = "k5blzr", ['price'] = 2900000, ['tipo'] = "import" },
	["kodiak"] = { ['name'] = "kodiak", ['price'] = 2900000, ['tipo'] = "import" },
	["mfc"] = { ['name'] = "mfc", ['price'] = 2900000, ['tipo'] = "import" },
	["models"] = { ['name'] = "models", ['price'] = 2900000, ['tipo'] = "import" },
	["prius"] = { ['name'] = "prius", ['price'] = 2900000, ['tipo'] = "import" },
	["ram3500"] = { ['name'] = "ram3500", ['price'] = 2900000, ['tipo'] = "import" },
	["rx450h"] = { ['name'] = "rx450h", ['price'] = 2900000, ['tipo'] = "import" },
	["rrphantom"] = { ['name'] = "rrphantom", ['price'] = 2900000, ['tipo'] = "import" },
	["slsamg"] = { ['name'] = "slsamg", ['price'] = 2900000, ['tipo'] = "import" },
	["xt660"] = { ['name'] = "xt660", ['price'] = 2900000, ['tipo'] = "import" },

	--EXCLUSIVE 
	
-----------------------------------------------------------------------------------------------------------------------------------------------------
---- MOTOS
-----------------------------------------------------------------------------------------------------------------------------------------------------
	["r1"] = { ['name'] = "Yamaha R1", ['price'] = 1000000, ['tipo'] = "exclusive" },	
	["bmws"] = { ['name'] = "BMW S1000 RR", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["r1250"] = { ['name'] = "BMW GS R1250", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["hcbr17"] = { ['name'] = "Honda CBR 1000", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["hayabusa"] = { ['name'] = "Hayabusa", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["z1000"] = { ['name'] = "Z1000", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["cb500x"] = { ['name'] = "Honda CB500", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["r6"] = { ['name'] = "Yamaha R6", ['price'] = 1000000, ['tipo'] = "import" },
	["zx10"] = { ['name'] = "Kawasaki ZX10R", ['price'] = 1000000, ['tipo'] = "exclusive" },	
	["dm1200"] = { ['name'] = "Ducati DM1200", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["nh2r"] = { ['name'] = "Ninja NH2R", ['price'] = 1000000, ['tipo'] = "exclusive" },
	-----------------------------------------------------------------------------------------------------------------------------------------------------
---- ALTERNATIVOS
-----------------------------------------------------------------------------------------------------------------------------------------------------
	["shotaro"] = { ['name'] = "Shotaro", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["stretch"] = { ['name'] = "Stretch", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["phantom3"] = { ['name'] = "Phantom", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["zr3802"] = { ['name'] = "ZR3802", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["buzzard2"] = { ['name'] = "Buzzard2", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["frogger"] = { ['name'] = "Frogger", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["pbus2"] = { ['name'] = "Ônibus Festival", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["monster4"] = { ['name'] = "Monster", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["cargobob2"] = { ['name'] = "Cargo Bob", ['price'] = 1000000, ['tipo'] = "exclusive" },	
	["deathbike2"] = { ['name'] = "Death Bike", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["sanctus"] = { ['name'] = "Sanctus", ['price'] = 1000000, ['tipo'] = "exclusive" },
-----------------------------------------------------------------------------------------------------------------------------------------------------
---- CARROS
-----------------------------------------------------------------------------------------------------------------------------------------------------
	["f8t"] = { ['name'] = "Ferrari F8 Turbo", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["p1"] = { ['name'] = "P1 GTR", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["porsche930"] = { ['name'] = "Porsche 930", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["na1"] = { ['name'] = "Honda NSX-R", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["panamera17turbo"] = { ['name'] = "Porshce Panamera Turbo", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["f458"] = { ['name'] = "Ferrari 458", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["senna"] = { ['name'] = "MacLaren Senna", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["divo"] = { ['name'] = "Bugatti Divo", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["rmodsian"] = { ['name'] = "Lamborghini Sian", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lw458s"] = { ['name'] = "Ferrari 458 s", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["kiagt"] = { ['name'] = "kiagt", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lp610"] = { ['name'] = "lp610", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["rmodlp750"] = { ['name'] = "rmodlp750", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["acs8"] = { ['name'] = "BMW i8", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["ttrs"] = { ['name'] = "Audi TTS", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["gtr"] = { ['name'] = "Nissan GTR", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bmwm4gts"] = { ['name'] = "BMW M4 GTS", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["skyline"] = { ['name'] = "Nissan Skyline R34", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["s15"] = { ['name'] = "Nissan Silvia S15", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["vantage"] = { ['name'] = "Aston Martin Vantage", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["celta"] = { ['name'] = "Celta Paredão", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["veneno"] = { ['name'] = "Lamborghini Veneno", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["agerars"] = { ['name'] = "Koenigsegg Agera RS", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["msohs"] = { ['name'] = "Mclaren 688 HS", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["19ftype"] = { ['name'] = "Jaguar F-Type", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["nissantitan17"] = { ['name'] = "Nissan Titan 2017", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["m6e63"] = { ['name'] = "BMW M6 E63", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["180sx"] = { ['name'] = "Nissan 180SX", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["filthynsx"] = { ['name'] = "Honda NSX", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lp700r"] = { ['name'] = "Lamborghini LP700R Conversível", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["2013r8"] = { ['name'] = "Audi R8 PPI Razor", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["toyotasupra"] = { ['name'] = "Toyota Supra", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["w900"] = { ['name'] = "Kenworth W900", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["cargobob"] = { ['name'] = "CSC Cargobob", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["fc15"] = { ['name'] = "Ferrari fc15", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["trophytruck"] = { ['name'] = "Trophytruck", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["ferrariitalia"] = { ['name'] = "Ferrari Italia", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["BALLTRUCK"] = { ['name'] = "Rola Bot", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["supersport"] = { ['name'] = "Bugatti", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mazdarx7"] = { ['name'] = "Mazda RX-7", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["zondab"] = { ['name'] = "Pagani Zonda Barchetta", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bugatti"] = { ['name'] = "Bugatti Veyron", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["18performante"] = { ['name'] = "Lamborghini Huracan", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mst"] = { ['name'] = "Mustang", ['price'] = 1000000, ['tipo'] = "exclusive" },
	--["divo"] = { ['name'] = "Bugatti Divo", ['price'] = 2000000, ['tipo'] = "import" },
	-- ["rmodlp770"] = { ['name'] = "Lamborghini LP770", ['price'] = 2000000, ['tipo'] = "exclusive" },
	--["caracara2"] = { ['name'] = "Caracara2", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["drafter"] = { ['name'] = "Drafter", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["dynasty"] = { ['name'] = "Dynasty", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["emerus"] = { ['name'] = "Emerus", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["gauntlet3"] = { ['name'] = "Gauntlet3", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["gauntlet4"] = { ['name'] = "Gauntlet4", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["hellion"] = { ['name'] = "Hellion", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["issi7"] = { ['name'] = "Issi7", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["jugular"] = { ['name'] = "Jugular", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["krieger"] = { ['name'] = "Krieger", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["locust"] = { ['name'] = "Locust", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["nebula"] = { ['name'] = "Nebula", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["neo"] = { ['name'] = "Neo", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["novak"] = { ['name'] = "Novak", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["paragon"] = { ['name'] = "Paragon", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["paragon2"] = { ['name'] = "Paragon", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["peyote2"] = { ['name'] = "Peyote2", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["s80"] = { ['name'] = "s80", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["thrax"] = { ['name'] = "Moto Thrax", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["zion3"] = { ['name'] = "Zion3", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["rrocket"] = { ['name'] = "Rrocket", ['price'] = 2000000, ['tipo'] = "exclusive" },
    --["brutus"] = { ['name'] = "Brutus", ['price'] = 2000000, ['tipo'] = "exclusive" },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleGlobal()
	return vehglobal
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLENAME
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleName(vname)
	return vehglobal[vname].name
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEPRICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehiclePrice(vname)
	return vehglobal[vname].price
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleType(vname)
	return vehglobal[vname].tipo
end

function vRP.openChest2(source,name,max_weight,cb_close,cb_in,cb_out)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		local identity = vRP.getUserIdentity(user_id)
		if data.inventory then
			if not chests[name] then
				local close_count = 0
				local chest = { max_weight = max_weight }
				chests[name] = chest 
				local cdata = vRP.getSData("chest:"..name)
				chest.items = json.decode(cdata) or {}

				local menu = { name = "Baú" }
				local cb_take = function(idname)
					local citem = chest.items[idname]
					local amount = vRP.prompt(source,"Quantidade:","")
					amount = parseInt(amount)
					if amount > 0 and amount <= citem.amount then
						local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(idname)*amount
						if new_weight <= vRP.getInventoryMaxWeight(user_id) then
							vRP.giveInventoryItem(user_id,idname,amount)
							SendWebhookMessage(webhookbaucasa,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: "..name.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							citem.amount = citem.amount - amount

							if citem.amount <= 0 then
								chest.items[idname] = nil
							end

							if cb_out then
								cb_out(idname,amount)
							end
							vRP.closeMenu(source)
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Valor inválido.")
					end
				end

				local ch_take = function(player,choice)
					local weight = vRP.computeItemsWeight(chest.items)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",chest.items,cb_take)

					submenu.onclose = function()
						close_count = close_count - 1
						vRP.openMenu(player,menu)
					end
					close_count = close_count + 1
					vRP.openMenu(player,submenu)
				end

				local cb_put = function(idname)
					local amount = vRP.prompt(source,"Quantidade:","")
					amount = parseInt(amount)
					local new_weight = vRP.computeItemsWeight(chest.items)+vRP.getItemWeight(idname)*amount
					if new_weight <= max_weight then
						if amount > 0 and vRP.tryGetInventoryItem(user_id,idname,amount) then
							SendWebhookMessage(webhookbaucasa,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: "..name.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							local citem = chest.items[idname]

							if citem ~= nil then
								citem.amount = citem.amount + amount
							else
								chest.items[idname] = { amount = amount }
							end

							if cb_in then
								cb_in(idname,amount)
							end
							vRP.closeMenu(source)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Baú cheio.")
					end
				end

				local ch_put = function(player,choice)
					local weight = vRP.computeItemsWeight(data.inventory)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",data.inventory,cb_put)

					submenu.onclose = function()
						close_count = close_count-1
						vRP.openMenu(player,menu)
					end

					close_count = close_count+1
					vRP.openMenu(player,submenu)
				end

				menu["Retirar"] = { ch_take }
				menu["Colocar"] = { ch_put }

				menu.onclose = function()
					if close_count == 0 then
						vRP.setSData("chest:"..name,json.encode(chest.items))
						chests[name] = nil
						if cb_close then
							cb_close()
						end
					end
				end
				vRP.openMenu(source,menu)
			else
				TriggerClientEvent("Notify",source,"importante","O baú está sendo utilizado no momento.")
			end
		end
	end
end