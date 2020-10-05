-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local sanitizes = module("cfg/sanitizes")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_homes",src)
vCLIENT = Tunnel.getInterface("vrp_homes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookbaucasas = "SEUWEBHOOK"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("homes/get_homeuser","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home")
vRP._prepare("homes/get_homeuserid","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id")
vRP._prepare("homes/get_homeuserowner","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home AND owner = 1")
vRP._prepare("homes/get_homeuseridowner","SELECT * FROM vrp_homes_permissions WHERE home = @home AND owner = 1")
vRP._prepare("homes/get_homepermissions","SELECT * FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/add_permissions","INSERT IGNORE INTO vrp_homes_permissions(home,user_id) VALUES(@home,@user_id)")
vRP._prepare("homes/buy_permissions","INSERT IGNORE INTO vrp_homes_permissions(home,user_id,owner,tax,garage) VALUES(@home,@user_id,1,@tax,1)")
vRP._prepare("homes/count_homepermissions","SELECT COUNT(*) as qtd FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/upd_permissions","UPDATE vrp_homes_permissions SET garage = 1 WHERE home = @home AND user_id = @user_id")
vRP._prepare("homes/rem_permissions","DELETE FROM vrp_homes_permissions WHERE home = @home AND user_id = @user_id")
vRP._prepare("homes/upd_taxhomes","UPDATE vrp_homes_permissions SET tax = @tax WHERE user_id = @user_id, home = @home AND owner = 1")
vRP._prepare("homes/rem_allpermissions","DELETE FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/get_allhomes","SELECT * FROM vrp_homes_permissions WHERE owner = @owner")
vRP._prepare("homes/get_allvehs","SELECT * FROM vrp_vehicles")
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMESINFO
-----------------------------------------------------------------------------------------------------------------------------------------
local homes = {
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------FORTHILLS-----------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
["FH01"] = { 3000000,2,1000 },
["FH02"] = { 3000000,2,1000 },
["FH03"] = { 3000000,2,1000 },
["FH04"] = { 3000000,2,1000 },
["FH05"] = { 3000000,2,1000 },
["FH06"] = { 3000000,2,1000 },
["FH07"] = { 3000000,2,1000 },
["FH08"] = { 3000000,2,1000 },
["FH09"] = { 3000000,2,1000 },
["FH10"] = { 3000000,2,1000 },
["FH11"] = { 3000000,2,1000 },
["FH12"] = { 3000000,2,1000 },
["FH13"] = { 3000000,2,1000 },
["FH14"] = { 3000000,2,1000 },
["FH15"] = { 3000000,2,1000 },
["FH16"] = { 3000000,2,1000 },
["FH17"] = { 3000000,2,1000 },
["FH18"] = { 3000000,2,1000 },
["FH19"] = { 3000000,2,1000 },
["FH20"] = { 3000000,2,1000 },
["FH21"] = { 3000000,2,1000 },
["FH22"] = { 3000000,2,1000 },
["FH23"] = { 3000000,2,1000 },
["FH24"] = { 3000000,2,1000 },
["FH25"] = { 3000000,2,1000 },
["FH26"] = { 3000000,2,1000 },
["FH27"] = { 3000000,2,1000 },
["FH28"] = { 3000000,2,1000 },
["FH29"] = { 3000000,2,1000 },
["FH30"] = { 3000000,2,1000 },
["FH31"] = { 3000000,2,1000 },
["FH32"] = { 3000000,2,1000 },
["FH33"] = { 3000000,2,1000 },
["FH34"] = { 3000000,2,1000 },
["FH35"] = { 3000000,2,1000 },
["FH36"] = { 3000000,2,1000 },
["FH37"] = { 3000000,2,1000 },
["FH38"] = { 3000000,2,1000 },
["FH39"] = { 3000000,2,1000 },
["FH40"] = { 3000000,2,1000 },
["FH41"] = { 3000000,2,1000 },
["FH42"] = { 3000000,2,1000 },
["FH43"] = { 3000000,2,1000 },
["FH44"] = { 3000000,2,1000 },
["FH45"] = { 3000000,2,1000 },
["FH46"] = { 3000000,2,1000 },
["FH47"] = { 3000000,2,1000 },
["FH48"] = { 3000000,2,1000 },
["FH49"] = { 3000000,2,1000 },
["FH50"] = { 3000000,2,1000 },
["FH51"] = { 3000000,2,1000 },
["FH52"] = { 3000000,2,1000 },
["FH53"] = { 3000000,2,1000 },
["FH54"] = { 3000000,2,1000 },
["FH55"] = { 3000000,2,1000 },
["FH56"] = { 3000000,2,1000 },
["FH57"] = { 3000000,2,1000 },
["FH58"] = { 3000000,2,1000 },
["FH59"] = { 3000000,2,1000 },
["FH60"] = { 3000000,2,1000 },
["FH61"] = { 3000000,2,1000 },
["FH62"] = { 3000000,2,1000 },
["FH63"] = { 3000000,2,1000 },
["FH64"] = { 3000000,2,1000 },
["FH65"] = { 3000000,2,1000 },
["FH66"] = { 3000000,2,1000 },
["FH67"] = { 3000000,2,1000 },
["FH68"] = { 3000000,2,1000 },
["FH69"] = { 3000000,2,1000 },
["FH70"] = { 3000000,2,1000 },
["FH71"] = { 3000000,2,1000 },
["FH72"] = { 3000000,2,1000 },
["FH73"] = { 3000000,2,1000 },
["FH74"] = { 3000000,2,1000 },
["FH75"] = { 3000000,2,1000 },
["FH76"] = { 3000000,2,1000 },
["FH77"] = { 3000000,2,1000 },
["FH78"] = { 3000000,2,1000 },
["FH79"] = { 3000000,2,1000 },
["FH80"] = { 3000000,2,1000 },
["FH81"] = { 3000000,2,1000 },
["FH82"] = { 3000000,2,1000 },
["FH83"] = { 3000000,2,1000 },
["FH84"] = { 3000000,2,1000 },
["FH85"] = { 3000000,2,1000 },
["FH86"] = { 3000000,2,1000 },
["FH87"] = { 3000000,2,1000 },
["FH88"] = { 3000000,2,1000 },
["FH89"] = { 3000000,2,1000 },
["FH90"] = { 3000000,2,1000 },
["FH91"] = { 3000000,2,1000 },
["FH92"] = { 3000000,2,1000 },
["FH93"] = { 3000000,2,1000 },
["FH94"] = { 3000000,2,1000 },
["FH95"] = { 3000000,2,1000 },
["FH96"] = { 3000000,2,1000 },
["FH97"] = { 3000000,2,1000 },
["FH98"] = { 3000000,2,1000 },
["FH99"] = { 3000000,2,1000 },
["FH100"] = { 3000000,2,1000 },
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------LUXURY--------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
["LX02"] = { 5000000,2,1000 },
["LX01"] = { 5000000,2,1000 },
["LX03"] = { 5000000,2,1000 },
["LX04"] = { 5000000,2,1000 },
["LX05"] = { 5000000,2,1000 },
["LX06"] = { 5000000,2,1000 },
["LX07"] = { 5000000,2,1000 },
["LX08"] = { 5000000,2,1000 },
["LX09"] = { 5000000,2,1000 },
["LX10"] = { 5000000,2,1000 },
["LX11"] = { 5000000,2,1000 },
["LX12"] = { 5000000,2,1000 },
["LX13"] = { 5000000,2,1000 },
["LX14"] = { 5000000,2,1000 },
["LX15"] = { 5000000,2,1000 },
["LX16"] = { 5000000,2,1000 },
["LX17"] = { 5000000,2,1000 },
["LX18"] = { 5000000,2,1000 },
["LX19"] = { 5000000,2,1000 },
["LX20"] = { 5000000,2,1000 },
["LX21"] = { 5000000,2,1000 },
["LX22"] = { 5000000,2,1000 },
["LX23"] = { 5000000,2,1000 },
["LX24"] = { 5000000,2,1000 },
["LX25"] = { 5000000,2,1000 },
["LX26"] = { 5000000,2,1000 },
["LX27"] = { 5000000,2,1000 },
["LX28"] = { 5000000,2,1000 },
["LX29"] = { 5000000,2,1000 },
["LX30"] = { 5000000,2,1000 },
["LX31"] = { 5000000,2,1000 },
["LX32"] = { 5000000,2,1000 },
["LX33"] = { 5000000,2,1000 },
["LX34"] = { 5000000,2,1000 },
["LX35"] = { 5000000,2,1000 },
["LX36"] = { 5000000,2,1000 },
["LX37"] = { 5000000,2,1000 },
["LX38"] = { 5000000,2,1000 },
["LX39"] = { 5000000,2,1000 },
["LX40"] = { 5000000,2,1000 },
["LX41"] = { 5000000,2,1000 },
["LX42"] = { 5000000,2,1000 },
["LX43"] = { 5000000,2,1000 },
["LX44"] = { 5000000,2,1000 },
["LX45"] = { 5000000,2,1000 },
["LX46"] = { 5000000,2,1000 },
["LX47"] = { 5000000,2,1000 },
["LX48"] = { 5000000,2,1000 },
["LX49"] = { 5000000,2,1000 },
["LX50"] = { 5000000,2,1000 },
["LX51"] = { 5000000,2,1000 },
["LX52"] = { 99999999,2,1000 },
["LX53"] = { 5000000,2,5000 },
["LX54"] = { 5000000,2,1000 },
["LX55"] = { 5000000,2,1000 },
["LX56"] = { 5000000,2,1000 },
["LX57"] = { 5000000,2,1000 },
["LX58"] = { 5000000,2,1000 },
["LX59"] = { 5000000,2,1000 },
["LX60"] = { 5000000,2,1000 },
["LX61"] = { 5000000,2,1000 },
["LX62"] = { 5000000,2,1000 },
["LX63"] = { 5000000,2,1000 },
["LX64"] = { 5000000,2,1000 },
["LX65"] = { 5000000,2,1000 },
["LX66"] = { 5000000,2,1000 },
["LX67"] = { 5000000,2,1000 },
["LX68"] = { 5000000,2,1000 },
["LX69"] = { 5000000,2,1000 },
["LX70"] = { 5000000,2,1000 },	
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------SAMIR-------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
["LS01"] = { 1200000,2,200 },
["LS02"] = { 1200000,2,200 },
["LS03"] = { 1200000,2,200 },
["LS04"] = { 1200000,2,200 },
["LS05"] = { 1200000,2,200 },
["LS06"] = { 1200000,2,200 },
["LS07"] = { 1400000,2,200 },
["LS08"] = { 1200000,2,200 },
["LS09"] = { 1400000,2,200 },
["LS10"] = { 1200000,2,200 },
["LS11"] = { 900000,2,200 },
["LS12"] = { 900000,2,200 },
["LS13"] = { 1200000,2,200 },
["LS14"] = { 1200000,2,200 },
["LS15"] = { 900000,2,200 },
["LS16"] = { 1200000,2,200 },
["LS17"] = { 1000000,2,200 },
["LS18"] = { 1200000,2,200 },
["LS19"] = { 1200000,2,200 },
["LS20"] = { 1200000,2,200 },
["LS21"] = { 1000000,2,200 },
["LS22"] = { 1200000,2,200 },
["LS23"] = { 1200000,2,200 },
["LS24"] = { 1200000,2,200 },
["LS25"] = { 1200000,2,200 },
["LS26"] = { 1200000,2,200 },
["LS27"] = { 1200000,2,200 },
["LS28"] = { 1200000,2,200 },
["LS29"] = { 1200000,2,200 },
["LS30"] = { 1200000,2,200 },
["LS31"] = { 1200000,2,200 },
["LS32"] = { 1200000,2,200 },
["LS33"] = { 1200000,2,200 },
["LS34"] = { 1200000,2,200 },
["LS35"] = { 1200000,2,200 },
["LS36"] = { 1200000,2,200 },
["LS37"] = { 1200000,2,200 },
["LS38"] = { 1200000,2,200 },
["LS39"] = { 1200000,2,200 },
["LS40"] = { 1200000,2,200 },
["LS41"] = { 1200000,2,200 },
["LS42"] = { 1200000,2,200 },
["LS43"] = { 1200000,2,200 },
["LS44"] = { 1200000,2,200 },
["LS45"] = { 1200000,2,200 },
["LS46"] = { 1200000,2,200 },
["LS47"] = { 1200000,2,200 },
["LS48"] = { 1200000,2,200 },
["LS49"] = { 1200000,2,200 },
["LS50"] = { 1200000,2,200 },
["LS51"] = { 1200000,2,200 },
["LS52"] = { 1200000,2,200 },
["LS53"] = { 1200000,2,200 },
["LS54"] = { 1200000,2,200 },
["LS55"] = { 1200000,2,200 },
["LS56"] = { 1200000,2,200 },
["LS57"] = { 1200000,2,200 },
["LS58"] = { 1200000,2,200 },
["LS59"] = { 1200000,2,200 },
["LS60"] = { 1200000,2,200 },
["LS61"] = { 1200000,2,200 },
["LS62"] = { 1200000,2,200 },
["LS63"] = { 1200000,2,200 },
["LS64"] = { 1200000,2,200 },
["LS65"] = { 1200000,2,200 },
["LS66"] = { 1200000,2,200 },
["LS67"] = { 1200000,2,200 },
["LS68"] = { 1200000,2,200 },
["LS69"] = { 1200000,2,200 },
["LS70"] = { 1200000,2,200 },
["LS71"] = { 1200000,2,200 },
["LS72"] = { 1200000,2,200 },
-----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------BOLLINI------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
["BL01"] = { 300000,2,200 },
["BL02"] = { 300000,2,200 },
["BL03"] = { 300000,2,200 },
["BL04"] = { 300000,2,200 },
["BL05"] = { 300000,2,200 },
["BL06"] = { 300000,2,200 },
["BL07"] = { 300000,2,200 },
["BL08"] = { 300000,2,200 },
["BL09"] = { 300000,2,200 },
["BL10"] = { 300000,2,200 },
["BL11"] = { 300000,2,200 },
["BL12"] = { 300000,2,200 },
["BL13"] = { 300000,2,200 },
["BL14"] = { 300000,2,200 },
["BL15"] = { 300000,2,200 },
["BL16"] = { 300000,2,200 },
["BL17"] = { 300000,2,200 },
["BL18"] = { 300000,2,200 },
["BL19"] = { 300000,2,200 },
["BL20"] = { 300000,2,200 },
["BL21"] = { 300000,2,200 },
["BL22"] = { 300000,2,200 },
["BL23"] = { 300000,2,200 },
["BL24"] = { 300000,2,200 },
["BL25"] = { 300000,2,200 },
["BL26"] = { 300000,2,200 },
["BL27"] = { 300000,2,200 },
["BL28"] = { 300000,2,200 },
["BL29"] = { 300000,2,200 },
["BL30"] = { 300000,2,200 },
["BL31"] = { 300000,2,200 },
["BL32"] = { 300000,2,200 },
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------LOSVAGOS------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
["LV01"] = { 300000,2,250 },
["LV02"] = { 300000,2,250 },
["LV03"] = { 300000,2,250 },
["LV04"] = { 300000,2,250 },
["LV05"] = { 300000,2,250 },
["LV06"] = { 300000,2,250 },
["LV07"] = { 300000,2,250 },
["LV08"] = { 300000,2,250 },
["LV09"] = { 300000,2,250 },
["LV10"] = { 300000,2,250 },
["LV11"] = { 300000,2,250 },
["LV12"] = { 300000,2,250 },
["LV13"] = { 300000,2,250 },
["LV14"] = { 300000,2,250 },
["LV15"] = { 300000,2,250 },
["LV16"] = { 300000,2,250 },
["LV17"] = { 300000,2,250 },
["LV18"] = { 300000,2,250 },
["LV19"] = { 300000,2,250 },
["LV20"] = { 300000,2,250 },
["LV21"] = { 300000,2,250 },
["LV22"] = { 300000,2,250 },
["LV23"] = { 300000,2,250 },
["LV24"] = { 300000,2,250 },
["LV25"] = { 300000,2,250 },
["LV26"] = { 300000,2,250 },
["LV27"] = { 300000,2,250 },
["LV28"] = { 300000,2,250 },
["LV29"] = { 300000,2,250 },
["LV30"] = { 300000,2,250 },
["LV31"] = { 300000,2,250 },
["LV32"] = { 300000,2,250 },
["LV33"] = { 300000,2,250 },
["LV34"] = { 300000,2,250 },
["LV35"] = { 300000,2,250 },
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------KRONDORS------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
["KR01"] = { 300000,2,200 },
["KR02"] = { 300000,2,200 },
["KR03"] = { 300000,2,200 },
["KR04"] = { 300000,2,200 },
["KR05"] = { 300000,2,200 },
["KR06"] = { 300000,2,200 },
["KR07"] = { 300000,2,200 },
["KR08"] = { 300000,2,200 },
["KR09"] = { 300000,2,200 },
["KR10"] = { 300000,2,200 },
["KR11"] = { 300000,2,200 },
["KR12"] = { 300000,2,200 },
["KR13"] = { 300000,2,200 },
["KR14"] = { 300000,2,200 },
["KR15"] = { 300000,2,200 },
["KR16"] = { 300000,2,200 },
["KR17"] = { 300000,2,200 },
["KR18"] = { 300000,2,200 },
["KR19"] = { 300000,2,200 },
["KR20"] = { 300000,2,200 },
["KR21"] = { 300000,2,200 },
["KR22"] = { 300000,2,200 },
["KR23"] = { 300000,2,200 },
["KR24"] = { 300000,2,200 },
["KR25"] = { 300000,2,200 },
["KR26"] = { 300000,2,200 },
["KR27"] = { 300000,2,200 },
["KR28"] = { 300000,2,200 },
["KR29"] = { 300000,2,200 },
["KR30"] = { 300000,2,200 },
["KR31"] = { 300000,2,200 },
["KR32"] = { 300000,2,200 },
["KR33"] = { 300000,2,200 },
["KR34"] = { 300000,2,200 },
["KR35"] = { 300000,2,200 },
["KR36"] = { 300000,2,200 },
["KR37"] = { 300000,2,200 },
["KR38"] = { 300000,2,200 },
["KR39"] = { 300000,2,200 },
["KR40"] = { 300000,2,200 },
["KR41"] = { 300000,2,200 },
-----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------GROOVEMOTEL--------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
["GR01"] = { 300000,2,200 },
["GR02"] = { 300000,2,200 },
["GR03"] = { 300000,2,200 },
["GR04"] = { 300000,2,200 },
["GR05"] = { 300000,2,200 },
["GR06"] = { 300000,2,200 },
["GR07"] = { 300000,2,200 },
["GR08"] = { 300000,2,200 },
["GR09"] = { 300000,2,200 },
["GR10"] = { 300000,2,200 },
["GR11"] = { 300000,2,200 },
["GR12"] = { 300000,2,200 },
["GR13"] = { 300000,2,200 },
["GR14"] = { 300000,2,200 },
["GR15"] = { 300000,2,200 },
-----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------ALLSUELLMOTEL------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
["AS01"] = { 300000,2,200 },
["AS02"] = { 300000,2,200 },
["AS03"] = { 300000,2,200 },
["AS04"] = { 300000,2,200 },
["AS05"] = { 300000,2,200 },
["AS06"] = { 300000,2,200 },
["AS07"] = { 300000,2,200 },
["AS08"] = { 300000,2,200 },
["AS09"] = { 300000,2,200 },
["AS10"] = { 300000,2,200 },
["AS12"] = { 300000,2,200 },
["AS13"] = { 300000,2,200 },
["AS14"] = { 300000,2,200 },
["AS15"] = { 300000,2,200 },
["AS16"] = { 300000,2,200 },
["AS17"] = { 300000,2,200 },
["AS18"] = { 300000,2,200 },
["AS19"] = { 300000,2,200 },
["AS20"] = { 300000,2,200 },
["AS21"] = { 300000,2,200 },
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------PINKCAGEMOTEL-----------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
["PC01"] = { 500000,2,150 },
["PC02"] = { 500000,2,150 },
["PC03"] = { 500000,2,150 },
["PC04"] = { 500000,2,150 },
["PC05"] = { 500000,2,150 },
["PC06"] = { 500000,2,150 },
["PC07"] = { 500000,2,150 },
["PC08"] = { 500000,2,150 },
["PC09"] = { 500000,2,150 },
["PC10"] = { 500000,2,150 },
["PC11"] = { 500000,2,150 },
["PC12"] = { 500000,2,150 },
["PC13"] = { 500000,2,150 },
["PC14"] = { 500000,2,150 },
["PC15"] = { 500000,2,150 },
["PC16"] = { 500000,2,150 },
["PC17"] = { 500000,2,150 },
["PC18"] = { 500000,2,150 },
["PC19"] = { 500000,2,150 },
["PC20"] = { 500000,2,150 },
["PC21"] = { 500000,2,150 },
["PC22"] = { 500000,2,150 },
["PC23"] = { 500000,2,150 },
["PC24"] = { 500000,2,150 },
["PC25"] = { 500000,2,150 },
["PC26"] = { 500000,2,150 },
["PC27"] = { 500000,2,150 },
["PC28"] = { 500000,2,150 },
["PC29"] = { 500000,2,150 },
["PC30"] = { 500000,2,150 },
["PC31"] = { 500000,2,150 },
["PC32"] = { 500000,2,150 },
["PC33"] = { 500000,2,150 },
["PC34"] = { 500000,2,150 },
["PC35"] = { 500000,2,150 },
["PC36"] = { 500000,2,150 },
["PC37"] = { 500000,2,150 },
["PC38"] = { 500000,2,150 },
-----------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------PALETOMOTEL------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
["PL01"] = { 200000,2,150 },
["PL02"] = { 200000,2,150 },
["PL03"] = { 200000,2,150 },
["PL04"] = { 200000,2,150 },
["PL05"] = { 200000,2,150 },
["PL06"] = { 200000,2,150 },
["PL07"] = { 200000,2,150 },
["PL08"] = { 200000,2,150 },
["PL09"] = { 200000,2,150 },
["PL11"] = { 200000,2,150 },
["PL12"] = { 200000,2,150 },
["PL13"] = { 200000,2,150 },
["PL14"] = { 200000,2,150 },
["PL15"] = { 200000,2,150 },
["PL16"] = { 200000,2,150 },
["PL17"] = { 200000,2,150 },
["PL18"] = { 200000,2,150 },
["PL19"] = { 200000,2,150 },
["PL20"] = { 200000,2,150 },
["PL21"] = { 200000,2,150 },
["PL22"] = { 200000,2,150 },
-----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------PALETOBAY-------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
["PB01"] = { 400000,2,250 },
["PB02"] = { 400000,2,250 },
["PB03"] = { 400000,2,250 },
["PB04"] = { 400000,2,250 },
["PB05"] = { 400000,2,250 },
["PB06"] = { 400000,2,250 },
["PB07"] = { 400000,2,250 },
["PB08"] = { 400000,2,250 },
["PB09"] = { 400000,2,250 },
["PB10"] = { 400000,2,250 },
["PB11"] = { 400000,2,250 },
["PB12"] = { 400000,2,250 },
["PB13"] = { 400000,2,250 },
["PB14"] = { 400000,2,250 },
["PB15"] = { 400000,2,250 },
["PB16"] = { 400000,2,250 },
["PB17"] = { 400000,2,250 },
["PB18"] = { 400000,2,250 },
["PB19"] = { 400000,2,250 },
["PB20"] = { 400000,2,250 },
["PB21"] = { 400000,2,250 },
["PB22"] = { 400000,2,250 },
["PB23"] = { 400000,2,250 },
["PB24"] = { 400000,2,250 },
["PB25"] = { 400000,2,250 },
["PB26"] = { 400000,2,250 },
["PB27"] = { 400000,2,250 },
["PB28"] = { 400000,2,250 },
["PB29"] = { 400000,2,250 },
["PB30"] = { 400000,2,250 },
["PB31"] = { 400000,2,250 },
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------MANSAO------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
["MS01"] = { 99999999,2,1500 },
["MS02"] = { 99999999,2,1500 },
["MS03"] = { 99999999,2,1500 },
["MS04"] = { 99999999,5,1500 },
["MS05"] = { 5000000,2,1500 },
["MS06"] = { 5000000,2,1500 },
["MS07"] = { 5000000,2,1500 },
["MS08"] = { 5000000,2,1500 },
["MS09"] = { 5000000,2,1500 },
-----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------Zancudo Avenue--------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
["ZA01"] = { 1850000,1,500 },
-----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------SANDYSHORE------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
["SS01"] = { 99999999,2,1000 },
-----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------SANDYSHORE------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
--["FZ01"] = { 99999999,2,1500 },
["FZ02"] = { 99999999,2,1500 },
["FZ03"] = { 99999999,4,4000 },
["FZ04"] = { 99999999,2,1500 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local blipHomes = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		blipHomes = {}
		for k,v in pairs(homes) do
			local checkHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(k) })
			if checkHomes[1] == nil then
				table.insert(blipHomes,{ name = tostring(k) })
				Citizen.Wait(10)
			end
		end
		Citizen.Wait(30*60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('homes',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] == "add" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local totalResidents = vRP.query("homes/count_homepermissions",{ home = tostring(args[2]) })
				if parseInt(totalResidents[1].qtd) >= parseInt(homes[tostring(args[2])][2]) then
					TriggerClientEvent("Notify",source,"negado","A residência "..tostring(args[2]).." atingiu o máximo de moradores.",10000)
					return
				end

				vRP.execute("homes/add_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
				local identity = vRP.getUserIdentity(parseInt(args[3]))
				if identity then
					TriggerClientEvent("Notify",source,"sucesso","Permissão na residência <b>"..tostring(args[2]).."</b> adicionada para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
				end
			end
		elseif args[1] == "rem" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homeuser",{ user_id = parseInt(args[3]), home = tostring(args[2]) })
				if userHomes[1] then
					vRP.execute("homes/rem_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
					local identity = vRP.getUserIdentity(parseInt(args[3]))
					if identity then
						TriggerClientEvent("Notify",source,"importante","Permissão na residência <b>"..tostring(args[2]).."</b> removida de <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
			end
		elseif args[1] == "garage" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homeuser",{ user_id = parseInt(args[3]), home = tostring(args[2]) })
				if userHomes[1] then
					if vRP.tryFullPayment(user_id,50000) then
						vRP.execute("homes/upd_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
						local identity = vRP.getUserIdentity(parseInt(args[3]))
						if identity then
							TriggerClientEvent("Notify",source,"sucesso","Adicionado a permissão da garagem a <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				end
			end
		elseif args[1] == "list" then
			vCLIENT.setBlipsHomes(source,blipHomes)
		elseif args[1] == "check" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homepermissions",{ home = tostring(args[2]) })
				if parseInt(#userHomes) > 1 then
					local permissoes = ""
					for k,v in pairs(userHomes) do
						if v.user_id ~= user_id then
							local identity = vRP.getUserIdentity(v.user_id)
							permissoes = permissoes.."<b>Nome:</b> "..identity.name.." "..identity.firstname.." - <b>Passaporte:</b> "..v.user_id
							if k ~= #userHomes then
								permissoes = permissoes.."<br>"
							end
						end
						Citizen.Wait(10)
					end
					TriggerClientEvent("Notify",source,"importante","Permissões da residência <b>"..tostring(args[2]).."</b>: <br>"..permissoes,20000)
				else
					TriggerClientEvent("Notify",source,"negado","Nenhuma permissão encontrada.",20000)
				end
			end
		elseif args[1] == "transfer" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local identity = vRP.getUserIdentity(parseInt(args[3]))
				if identity then
					local ok = vRP.request(source,"Transferir a residência <b>"..tostring(args[2]).."</b> para <b>"..identity.name.." "..identity.firstname.."</b> ?",30)
					if ok then
						vRP.execute("homes/rem_allpermissions",{ home = tostring(args[2]) })
						vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]), tax = parseInt(myHomes[1].tax) })
						TriggerClientEvent("Notify",source,"importante","Transferiu a residência <b>"..tostring(args[2]).."</b> para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
			end
		elseif args[1] == "tax" and homes[tostring(args[2])] then
			local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(args[2]) })
			if ownerHomes[1] then
				--if not vRP.hasGroup(user_id,"Platina") then
					local house_price = parseInt(homes[tostring(args[2])][1])
					local house_tax = 0.03
					if house_price >= 99999999 then
						house_tax = 0.00
					end
					if vRP.tryFullPayment(user_id,parseInt(house_price * house_tax)) then
						vRP.execute("homes/rem_permissions",{ home = tostring(args[2]), user_id = parseInt(ownerHomes[1].user_id) })
						vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = parseInt(ownerHomes[1].user_id), tax = parseInt(os.time()) })
						TriggerClientEvent("Notify",source,"sucesso","Pagamento de <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b> efetuado com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				--end
			end
		else
			local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if parseInt(#myHomes) >= 1 then
				for k,v in pairs(myHomes) do
					local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(v.home) })
					if ownerHomes[1] then
						local house_price = parseInt(homes[tostring(v.home)][1])
						local house_tax = 0.03
						if house_price >= 99999999 then
							house_tax = 0.00
						end

						if parseInt(os.time()) >= parseInt(ownerHomes[1].tax+24*15*60*60) then
							TriggerClientEvent("Notify",source,"negado","<b>Residência:</b> "..v.home.."<br><b>Property Tax:</b> Atrasado<br>Valor: <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b>",20000)
						else
							TriggerClientEvent("Notify",source,"importante","<b>Residência:</b> "..v.home.."<br>Taxa em: "..vRP.getDayHours(parseInt(86400*15-(os.time()-ownerHomes[1].tax))).."<br>Valor: <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b>",20000)
						end
						Citizen.Wait(10)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
		if parseInt(#myHomes) >= 1 then
			for k,v in pairs(myHomes) do
				vCLIENT.setBlipsOwner(source,v.home)
				Citizen.Wait(10)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEDOWNTIME
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		for k,v in pairs(actived) do
			if v > 0 then
				actived[k] = v - 2
				if v == 0 then
					actived[k] = nil
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local answered = {}
function src.checkPermissions(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			if not vRP.searchReturn(source,user_id) then
				local homeResult = vRP.query("homes/get_homepermissions",{ home = tostring(homeName) })
				if parseInt(#homeResult) >= 1 then
					local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
					local resultOwner = vRP.query("homes/get_homeuseridowner",{ home = tostring(homeName) })
					if myResult[1] then

						if homes[homeName][1] >= 70000000 then
							return true
						end

						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*18*60*60) then

							local cows = vRP.getSData("chest:"..tostring(homeName))
							local rows = json.decode(cows) or {}
							if rows then
								vRP.execute("creative/rem_srv_data",{ dkey = "chest:"..tostring(homeName) })
							end

							vRP.execute("homes/rem_allpermissions",{ home = tostring(homeName) })
							TriggerClientEvent("Notify",source,"aviso","A <b>Property Tax</b> venceu por <b>3 dias</b> e a casa foi vendida.",10000)
							return false
						elseif parseInt(os.time()) <= parseInt(resultOwner[1].tax+24*15*60*60) then
							return true
						else
							TriggerClientEvent("Notify",source,"aviso","A <b>Property Tax</b> da residência está atrasada.",10000)
							return false
						end
					else
						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*18*60*60) and homes[homeName][1] < 5000000 then

							local cows = vRP.getSData("chest:"..tostring(homeName))
							local rows = json.decode(cows) or {}
							if rows then
								vRP.execute("creative/rem_srv_data",{ dkey = "chest:"..tostring(homeName) })
							end

							vRP.execute("homes/rem_allpermissions",{ home = tostring(homeName) })
							return false
						end

						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*15*60*60) and homes[homeName][1] < 5000000 then
							TriggerClientEvent("Notify",source,"aviso","A <b>Property Tax</b> da residência está atrasada.",10000)
							return false
						end

						answered[user_id] = nil
						for k,v in pairs(homeResult) do
							local player = vRP.getUserSource(parseInt(v.user_id))
							if player then
								if not answered[user_id] then
									TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> tocou o interfone da residência <b>"..tostring(homeName).."</b>.<br>Deseja permitir a entrada do mesmo?",10000)
									local ok = vRP.request(player,"Permitir acesso a residência?",30)
									if ok then
										answered[user_id] = true
										return true
									end
								end
							end
							Citizen.Wait(10)
						end
					end
				else
					local ok = vRP.request(source,"Deseja efetuar a compra da residência <b>"..tostring(homeName).."</b> por <b>$"..vRP.format(parseInt(homes[tostring(homeName)][1])).."</b> ?",30)
					if ok then
						if vRP.tryFullPayment(user_id,parseInt(homes[tostring(homeName)][1])) then
							vRP.execute("homes/buy_permissions",{ home = tostring(homeName), user_id = parseInt(user_id), tax = parseInt(os.time()) })
							TriggerClientEvent("Notify",source,"sucesso","A residência <b>"..tostring(homeName).."</b> foi comprada com sucesso.",10000)
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
						end
					end
					return false
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkIntPermissions(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
			if myResult[1] or vRP.hasPermission(user_id,"bcso.permissao") then
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('outfit',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local homeName = vCLIENT.getHomeStatistics(source)
		local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
		if myResult[1] then
			local data = vRP.getSData("outfit:"..tostring(homeName))
			local result = json.decode(data) or {}
			if result then
				if args[1] == "save" and args[2] then
					local custom = vRPclient.getCustomPlayer(source)
					if custom then
						local outname = sanitizeString(rawCommand:sub(13),sanitizes.homename[1],sanitizes.homename[2])
						if result[outname] == nil and string.len(outname) > 0 then
							result[outname] = custom
							vRP.setSData("outfit:"..tostring(homeName),json.encode(result))
							TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> adicionado com sucesso.",10000)
						else
							TriggerClientEvent("Notify",source,"aviso","Nome escolhido já existe na lista de <b>Outfits</b>.",10000)
						end
					end
				elseif args[1] == "rem" and args[2] then
					local outname = sanitizeString(rawCommand:sub(12),sanitizes.homename[1],sanitizes.homename[2])
					if result[outname] ~= nil and string.len(outname) > 0 then
						result[outname] = nil
						vRP.setSData("outfit:"..tostring(homeName),json.encode(result))
						TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> removido com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Nome escolhido não encontrado na lista de <b>Outfits</b>.",10000)
					end
				elseif args[1] == "apply" and args[2] then
					local outname = sanitizeString(rawCommand:sub(14),sanitizes.homename[1],sanitizes.homename[2])
					if result[outname] ~= nil and string.len(outname) > 0 then
						TriggerClientEvent("updateRoupas",source,result[outname])
						TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> aplicado com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Nome escolhido não encontrado na lista de <b>Outfits</b>.",10000)
					end
				else
					for k,v in pairs(result) do
						TriggerClientEvent("Notify",source,"importante","<b>Outfit:</b> "..k,20000)
						Citizen.Wait(10)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.openChest(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(homeName))
		local result = json.decode(data) or {}
		if result then
			for k,v in pairs(result) do
				table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end

			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end
		end
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(homes[tostring(homeName)][3])
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.storeItem(homeName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			if string.match(itemName,"identidade") then
				TriggerClientEvent("Notify",source,"importante","Não pode guardar este item.",8000)
				return
			end

			local data = vRP.getSData("chest:"..tostring(homeName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(amount)
					if new_weight <= parseInt(homes[tostring(homeName)][3]) then
						if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(amount)) then
							SendWebhookMessage(webhookbaucasas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..(tostring(homeName)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							if items[itemName] ~= nil then
								items[itemName].amount = parseInt(items[itemName].amount) + parseInt(amount)
							else
								items[itemName] = { amount = parseInt(amount) }
							end
							actived[parseInt(user_id)] = 2
						end
					else
						TriggerClientEvent("Notify",source,"negado","<b>Vault</b> cheio.",8000)
					end
				else
					local inv = vRP.getInventory(parseInt(user_id))
					for k,v in pairs(inv) do
						if itemName == k then
							local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(v.amount)
							if new_weight <= parseInt(homes[tostring(homeName)][3]) then
								if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(v.amount)) then
									if items[itemName] ~= nil then
										items[itemName].amount = parseInt(items[itemName].amount) + parseInt(v.amount)
									else
										items[itemName] = { amount = parseInt(v.amount) }
									end
									SendWebhookMessage(webhookbaucasas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..(tostring(homeName)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									actived[parseInt(user_id)] = 2
								end
							else
								TriggerClientEvent("Notify",source,"negado","<b>Vault</b> cheio.",8000)
							end
						end
					end
				end
				vRP.setSData("chest:"..tostring(homeName),json.encode(items))
				TriggerClientEvent('Creative:UpdateVault',source,'updateVault')
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.takeItem(homeName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			local data = vRP.getSData("chest:"..tostring(homeName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then
							SendWebhookMessage(webhookbaucasas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..(tostring(homeName)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(amount))
							items[itemName].amount = parseInt(items[itemName].amount) - parseInt(amount)
							if parseInt(items[itemName].amount) <= 0 then
								items[itemName] = nil
							end
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				else
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(items[itemName].amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then
							SendWebhookMessage(webhookbaucasas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..(tostring(homeName)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(items[itemName].amount))
							items[itemName] = nil
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				end
				TriggerClientEvent('Creative:UpdateVault',source,'updateVault')
				vRP.setSData("chest:"..tostring(homeName),json.encode(items))
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"bcso.permissao") then
			return true
		end
		return false
	end
end