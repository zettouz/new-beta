Config = {}

Config.AbertoAll = false
Config.TotalGaragem = 3
Config.Veiculos = {

    {
        categoria = {title="Basicos", id="nacionais"},
        veiculos = {
            {title = "panto", model="panto", mala=20, preco=10000, estoque = 35}, 
            {title = "brioso", model="brioso", mala=30, preco=25000, estoque = 35}, 
            {title = "issi2", model="issi2", mala=20, preco=23000, estoque = 20},
            {title = "rhapsody", model="rhapsody", mala=30, preco=15000, estoque = 15},
            {title = "habanero", model="habanero", mala=50, preco=35000, estoque = 20},
            {title = "felon2", model="felon2", mala=40, preco=45000, estoque = 20},
            {title = "sentinel", model="sentinel", mala=50, preco=45000, estoque = 20},
        }
    },
    {
        categoria = {title="Sports", id="motosn"},
        veiculos = {
            {title = "massacro", model="massacro", mala=40, preco=400000, estoque = 5},
            {title = "ellie", model="ellie", mala=50, preco=400000, estoque = 5},
            {title = "sentinel3", model="sentinel3", mala=30, preco=300000, estoque = 5},
            {title = "schafter3", model="schafter3", mala=50, preco=350000, estoque = 5},
        }
    },
    {
        categoria = {title="Caminhonetes", id="esportivo"},
        veiculos = {
            {title = "sandking2", model="sandking2", mala=120, preco=500000, estoque = 5},
            {title = "riata", model="riata", mala=80, preco=350000, estoque = 5},
            {title = "rebel2", model="rebel2", mala=100, preco=200000, estoque = 5},
            {title = "baller2", model="baller2", mala=50, preco=750000, estoque = 10},
            {title = "moonbeam", model="moonbeam", mala=80, preco=250000, estoque = 5},
            {title = "mesa3", model="mesa3", mala=60, preco=500000, estoque = 5},
        }
    },
    {
        categoria = {title="Temporada", id="caminhonete"},
        veiculos = {
            {title = "trophytruck", model="trophytruck", mala=15, preco=1300000, estoque = 5},
            {title = "ruston", model="ruston", mala=20, preco=1000000, estoque = 5},
            {title = "jester3", model="jester3", mala=30, preco=650000, estoque = 5},
            {title = "chimera", model="chimera", mala=15, preco=100000, estoque = 5},
            {title = "elegy", model="elegy", mala=30, preco=1000000, estoque = 5},
            {title = "visione", model="visione", mala=20, preco=1500000, estoque = 5},
        }
    },
    {
        categoria = {title="Motos", id="motos"},
        veiculos = {
            {title = "manchez", model="manchez", mala=15, preco=280000, estoque = 10},
            {title = "avarus", model="avarus", mala=15, preco=220000, estoque = 5},
            {title = "lectro", model="lectro", mala=15, preco=350000, estoque = 25},
            {title = "nemesis", model="nemesis", mala=15, preco=50000, estoque = 5},
            {title = "enduro", model="enduro", mala=15, preco=100000, estoque = 5},
            {title = "pcj", model="pcj", mala=15, preco=35000, estoque = 20},         
            {title = "sanchez", model="sanchez", mala=15, preco=60000, estoque = 20},     
            {title = "sanchez2", model="sanchez2", mala=15, preco=70000, estoque = 20},      
        }
    },
    
}

function getVeiculo(modelo)
    for i, cat in pairs(Config.Veiculos) do
        for i2, carro in pairs(cat.veiculos) do 
            if carro.model == modelo then
                return carro
            end
        end
    end
end


function getVeiculos()
    local veiculos = {}
    for i, cat in pairs(Config.Veiculos) do
        for i2, carro in pairs(cat.veiculos) do 
            veiculos[carro.model] = carro
        end
    end

    return veiculos
end