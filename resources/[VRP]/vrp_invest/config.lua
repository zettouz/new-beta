Config = {}

-- Language
Config.Locale = 'en'

-- Blips
Config.BlipCoords = {
    {x=-692.28, y=-587.52, z=31.55},
    {x=243.27, y=-1072.81, z=29.29},
    {x=-840.45, y=-334.11, z=38.68},
    {x=-59.98, y=-790.45, z=44.23},
    {x=254.44934082031,y=210.65216064453,z=106.28678131104}
}
Config.BlipName = "IBOVESPA"
Config.BlipID = 374
Config.BlipActive = false

-- Open & close key
Config.Keys = {
    Open = "E",
    Close = "ESC"
}

-- Loop for new stock rates 
Config.InvestRateTime = 10 -- Minutes

-- Stock settings
Config.Stock = {
    Minimum = -3,
    Maximum = 30,
    Time = 120,
    Limit = 10000,
    Lost = 10
}


-- Debug mode
Config.Debug = false