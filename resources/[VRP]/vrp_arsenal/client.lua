-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_arsenal",src)
vSERVER = Tunnel.getInterface("vrp_arsenal")
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALS
-----------------------------------------------------------------------------------------------------------------------------------------
local restock = {
	{ 440.26,-975.62,30.69 }, -- Delegacia LSPD
	{ 1853.03,3690.6,34.22 }, -- Delegacia Sandy
	{ -449.41,6012.63,31.72 }, -- Delegacia Paleto
	{ 310.48,-597.51,43.3 } -- Hospital LSPD
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("restock",function(source,args)
	local ped = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(ped))
	for k,v in pairs(restock) do
		if Vdist(x,y,z,v[1],v[2],v[3]) <= 1.5 then
			if args[1] == "pistol" and vSERVER.checkPermissions("bcso.permissao") then
				--SetPedArmour(ped,100)
				TriggerEvent("cap666",100)
				RemoveAllPedWeapons(ped,true)
				weaponPed("WEAPON_NIGHTSTICK",0)
				weaponPed("WEAPON_FLASHLIGHT",0)
				weaponPed("WEAPON_COMBATPISTOL",250)
				weaponPed("WEAPON_APPISTOL",250)
				weaponPed("WEAPON_PISTOL50",250)
				weaponPed("WEAPON_STUNGUN",0)
				TriggerEvent("Notify","importante","Restock <b>Pistol</b> aplicado com sucesso.",10000)
			elseif args[1] == "patrol" and vSERVER.checkPermissions("bcso.permissao") then
				--SetPedArmour(ped,100)
				TriggerEvent("cap666",100)
				RemoveAllPedWeapons(ped,true)
				weaponPed("WEAPON_NIGHTSTICK",0)
				weaponPed("WEAPON_FLASHLIGHT",0)
				weaponPed("WEAPON_COMBATPISTOL",250)
				weaponPed("WEAPON_APPISTOL",250)
				weaponPed("WEAPON_SMG",250)
				weaponPed("WEAPON_STUNGUN",0)
				TriggerEvent("Notify","importante","Restock <b>Patrol</b> aplicado com sucesso.",10000)
			elseif args[1] == "swat" and vSERVER.checkPermissions("bcso.permissao") then
				--SetPedArmour(ped,100)
				TriggerEvent("cap666",100)
				RemoveAllPedWeapons(ped,true)
				weaponPed("WEAPON_NIGHTSTICK",0)
				weaponPed("WEAPON_FLASHLIGHT",0)
				weaponPed("WEAPON_COMBATPISTOL",250)
				weaponPed("WEAPON_PISTOL50",250)
				weaponPed("WEAPON_PUMPSHOTGUN",250)
				weaponPed("WEAPON_CARBINERIFLE",250)
				weaponPed("WEAPON_STUNGUN",0)
				TriggerEvent("Notify","importante","Restock <b>Swat</b> aplicado com sucesso.",10000)
			elseif args[1] == "combat" and vSERVER.checkPermissions("bcso.permissao") then
				--SetPedArmour(ped,100)
				TriggerEvent("cap666",100)
				RemoveAllPedWeapons(ped,true)
				weaponPed("WEAPON_NIGHTSTICK",0)
				weaponPed("WEAPON_FLASHLIGHT",0)
				weaponPed("WEAPON_COMBATPISTOL",250)
				weaponPed("WEAPON_PISTOL50",250)
				weaponPed("WEAPON_PUMPSHOTGUN",250)
				weaponPed("WEAPON_BULLPUPRIFLE_MK2",250)
				weaponPed("WEAPON_STUNGUN",0)
				TriggerEvent("Notify","importante","Restock <b>Combat</b> aplicado com sucesso.",10000)
			elseif args[1] == "medic" and vSERVER.checkPermissions("paramedico.permissao") then
				--SetPedArmour(ped,100)
				TriggerEvent("cap666",100)
				RemoveAllPedWeapons(ped,true)
				weaponPed("WEAPON_NIGHTSTICK",0)
				weaponPed("WEAPON_FLASHLIGHT",0)
				weaponPed("WEAPON_STUNGUN",0)
				TriggerEvent("Notify","importante","Restock <b>Medic</b> aplicado com sucesso.",10000)
			else
				--SetPedArmour(ped,0)
				TriggerEvent("cap666",0)
				RemoveAllPedWeapons(ped,true)
				TriggerEvent("Notify","importante","Efetuado a limpeza em todos os armamentos.",10000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONPED
-----------------------------------------------------------------------------------------------------------------------------------------
function weaponPed(weapon,ammoclip)
	GiveWeaponToPed(GetPlayerPed(-1),GetHashKey(weapon),ammoclip,false,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
local weapons = {
	["WEAPON_VINTAGEPISTOL"] = {
		"COMPONENT_VINTAGEPISTOL_CLIP_02"
	},
	["WEAPON_PISTOL"] = {
		"COMPONENT_PISTOL_CLIP_02",
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_HEAVYPISTOL"] = {
		"COMPONENT_HEAVYPISTOL_CLIP_02",
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_PISTOL_MK2"] = {
		"COMPONENT_PISTOL_MK2_CLIP_02",
		"COMPONENT_AT_PI_RAIL",
		"COMPONENT_AT_PI_FLSH_02",
		"COMPONENT_AT_PI_COMP"
	},
	["WEAPON_COMBATPISTOL"] = {
		"COMPONENT_COMBATPISTOL_CLIP_02",
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_APPISTOL"] = {
		"COMPONENT_APPISTOL_CLIP_02",
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_SNSPISTOL"] = {
		"COMPONENT_SNSPISTOL_CLIP_02"
	},
	["WEAPON_MICROSMG"] = {
		"COMPONENT_MICROSMG_CLIP_02",
		"COMPONENT_AT_PI_FLSH",
		"COMPONENT_AT_SCOPE_MACRO"
	},
	["WEAPON_SMG"] = {
		"COMPONENT_SMG_CLIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02",
		"COMPONENT_AT_PI_SUPP"
	},
	["WEAPON_ASSAULTSMG"] = {
		"COMPONENT_ASSAULTSMG_CLIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO",
		"COMPONENT_AT_AR_SUPP_02"
	},
	["WEAPON_COMBATPDW"] = {
		"COMPONENT_COMBATPDW_CLIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_AR_AFGRIP",
		"COMPONENT_AT_SCOPE_SMALL"
	},
	["WEAPON_PUMPSHOTGUN"] = {
		"COMPONENT_AT_AR_FLSH"
	},
	["WEAPON_CARBINERIFLE"] = {
		"COMPONENT_CARBINERIFLE_CLIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_ASSAULTRIFLE"] = {
		"COMPONENT_ASSAULTRIFLE_CLIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_GUSENBERG"] = {
		"COMPONENT_GUSENBERG_CLIP_02"
	},
	["WEAPON_MACHINEPISTOL"] = {
		"COMPONENT_MACHINEPISTOL_CLIP_02",
		"COMPONENT_AT_PI_SUPP"
	},
	["WEAPON_MINISMG"] = {
		"COMPONENT_MINISMG_CLIP_02"
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		"COMPONENT_ASSAULTRIFLE_MK2_CLIP_02",
		"COMPONENT_AT_AR_AFGRIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_PISTOL50"] = {
		"COMPONENT_PISTOL50_CLIP_02",
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_SNSPISTOL_MK2"] = {
		"COMPONENT_SNSPISTOL_MK2_CLIP_02",
		"COMPONENT_AT_PI_FLSH_03",
		"COMPONENT_AT_PI_RAIL_02",
		"COMPONENT_AT_PI_COMP_02"
	},
	["WEAPON_SMG_MK2"] = {
		"COMPONENT_SMG_MK2_CLIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_BULLPUPRIFLE"] = {
		"COMPONENT_BULLPUPRIFLE_CLIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_SMALL",
		"COMPONENT_AT_AR_SUPP"
	},
	["WEAPON_BULLPUPRIFLE_MK2"] = {
		"COMPONENT_BULLPUPRIFLE_MK2_CLIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_SPECIALCARBINE"] = {
		"COMPONENT_SPECIALCARBINE_CLIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_SPECIALCARBINE_MK2"] = {
		"COMPONENT_SPECIALCARBINE_MK2_CLIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_STUNGUN"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,args)
	local ped = GetPlayerPed(-1)
	for k,v in pairs(weapons) do
		if GetSelectedPedWeapon(ped) == GetHashKey(k) then
			for k2,v2 in pairs(v) do
				GiveWeaponComponentToPed(ped,GetHashKey(k),GetHashKey(v2))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WECOLORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wecolors",function(source,args)
	local ped = GetPlayerPed(-1)
	if parseInt(args[1]) >= 0 and parseInt(args[1]) <= 7 then
		for k,v in pairs(weapons) do
			if HasPedGotWeapon(ped,GetHashKey(k)) then
				SetPedWeaponTintIndex(ped,GetHashKey(k),parseInt(args[1]))
			end
		end
	end
end)