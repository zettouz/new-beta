local cfg = {}

cfg.groups = {

	-----------------------------------------------------------------------------
	--  [ STAFF ] ---------------------------------------------------------------
	-----------------------------------------------------------------------------

	["Dono"] = {
		_config = {
			title = "Dono"
		},
		"mindmaster.permissao",
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		"player.wall",
		"chat2.permissao",
		"chat.permissao"
	},
	["Administrador"] = {
		_config = {
			title = "Administrador(a)"
		},
		"administrador.permissao",
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		"player.wall",
		"chat2.permissao",
		"chat.permissao"
	},
	["Moderador"] = {
		_config = {
			title = "Moderador(a)"
		},
		"moderador.permissao",
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		"player.wall",
		"chat2.permissao",
		"chat.permissao"
	},
	["Suporte"] = {
		_config = {
			title = "Suporte"
		},
		"suporte.permissao",
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		"chat2.permissao",
		"chat.permissao"
	},
	["Helper"] = {
		_config = {
			title = "Ajudante"
		},
		"chat2.permissao",
		"helper.permissao"
	},
	["Aprovador"] = {
		_config = {
			title = "Aprovador"
		},
		"aprovador.permissao"
	},
	["Skin"] = {
		_config = {
			title = "Skin",
			gtype = "altl"
		},
		"skin.permissao"
	},

	-----------------------------------------------------------------------------
	--  [ POLICIA & HOSPITAL ] --------------------------------------------------
	-----------------------------------------------------------------------------

	["Policia"] = {
		_config = {
			title = "Policia",
			gtype = "job"
		},
		"bcso.permissao",
		"dpla.permissao",
		"tiros.permissao",
		"player.blips",
		"player.blips"
	},
	["paisana-bcso"] = {
		_config = {
			title = "Policial de Folga",
			gtype = "job"
		},
		"paisana-bcso.permissao",
		"player.blips"
	},


	["Paramedico"] = {
		_config = {
			title = "Hospital",
			gtype = "job"
		},
		"dmla.permissao",
		"player.blips",
		"player.blips"
	}, 
	["paisana-dmla"] = {
		_config = {
			title = "Médico de Folga",
			gtype = "job"
		},
		"paisana-dmla.permissao",
		"player.blips"
	},

	["Merry"] = {
		_config = {
			title = "Merry",
			gtype = "job"
		},
		"merry.permissao",
		"tiros.permissao",
		"player.blips"
	},
	
	-----------------------------------------------------------------------------
	--  [ VIP ] -----------------------------------------------------------------
	-----------------------------------------------------------------------------

	["Bronze"] = {
		_config = {
			title = "Bronze"
		},
		"bronze.permissao",
		gtype = "vip"
	},
	["Prata"] = {
		_config = {
			title = "Prata",
			gtype = "vip"
		},
		"prata.permissao"
	},
	["Ouro"] = {
		_config = {
			title = "Ouro",
			gtype = "vip"
		},
		"ouro.permissao",
		"mochila.permissao",
		"vip.permissao"
	},
	["Platina"] = {
		_config = {
			title = "Platina",
			gtype = "vip"
		},
		"platina.permissao",
		"vip.permissao"
	},	
	["Platina"] = {
		_config = {
			title = "Platina",
			gtype = "vip"
		},
		"platina.permissao",
		"mochila.permissao",
		"vip.permissao"
	},
	["Diamante"] = {
		_config = {
			title = "Diamante",
			gtype = "vip"
		},
		"diamante.permissao",
		"mochila.permissao",
		"vip.permissao"
	},
	["Supremo"] = {
		_config = {
			title = "Supremo",
			gtype = "vip"
		},
		"supremo.permissao",
		"mochila.permissao",
		"vip.permissao"
	},
	["NOME"] = {
		_config = {
			title = "NOME",
			gtype = "vip"
		},
		"capeside.permissao",
		"mochila.permissao",
		"vip.permissao"
	},
	-----------------------------------------------------------------------------
	--  [ PILOTO ] --------------------------------------------------------------
	-----------------------------------------------------------------------------

	["Piloto"] = {
		_config = {
			title = "Piloto",
			gtype = "job"
		},
		"piloto.permissao"
	},

	-----------------------------------------------------------------------------
	--  [ MECÂNICO ] ------------------------------------------------------------
	-----------------------------------------------------------------------------


	["Mecanico"] = {
		_config = {
			title = "Mecânico",
			gtype = "job"
		},
		"mecanico.permissao"
	},
	["paisana-mecanico"] = {
		_config = {
			title = "Mecânico de Folga",
			gtype = "job"
		},
		"paisana-mecanico.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ BALLAS ] ---------------------------------------------------------------
	-----------------------------------------------------------------------------

	["Ballas"] = {
		_config = {
			title = "Ballas",
			gtype = "job",
		},
		"ballas.permissao",
		"ilegal.permissao"
	},
	["lider-ballas"] = {
		_config = {
			title = "Líder Ballas",
			gtype = "job",
		},
		"lider-ballas.permissao",
		"ballas.permissao",
		"ilegal.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ GROVE ] ----------------------------------------------------------------
	-----------------------------------------------------------------------------

	["Families"] = {
		_config = {
			title = "Families",
			gtype = "job",
		},
		"families.permissao",
		"ilegal.permissao"
	},
	["lider-families"] = {
		_config = {
			title = "Líder Families",
			gtype = "job",
		},
		"lider-families.permissao",
		"families.permissao",
		"ilegal.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ VAGOS ] ----------------------------------------------------------------
	-----------------------------------------------------------------------------

	["Vagos"] = {
		_config = {
			title = "Vagos",
			gtype = "job",
		},
		"vagos.permissao",
		"ilegal.permissao"
	},
	["lider-vagos"] = {
		_config = {
			title = "Líder Vagos",
			gtype = "job",
		},
		"lider-vagos.permissao",
		"vagos.permissao",
		"ilegal.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ SKULLS ] ---------------------------------------------------------------
	-----------------------------------------------------------------------------

	["Skulls"] = {
		_config = {
			title = "Skulls",
			gtype = "job",
		},
		"skulls.permissao",
		"ilegal.permissao"
	},
	["lider-skulls"] = {
		_config = {
			title = "Líder Skulls",
			gtype = "job",
		},
		"lider-skulls.permissao",
		"skulls.permissao",
		"ilegal.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ SKULLS ] ---------------------------------------------------------------
	-----------------------------------------------------------------------------

	["Reds"] = {
		_config = {
			title = "Reds",
			gtype = "job",
		},
		"reds.permissao",
		"ilegal.permissao"
	},
	["lider-skulls"] = {
		_config = {
			title = "Líder Reds",
			gtype = "job",
		},
		"lider-reds.permissao",
		"reds.permissao",
		"ilegal.permissao"
	},


	-----------------------------------------------------------------------------
	-- [ MAFIA ] ----------------------------------------------------------------
	-----------------------------------------------------------------------------

	["Mafia"] = {
		_config = {
			title = "Mafia",
			gtype = "job",
		},
		"mafia.permissao",
		"ilegal.permissao"
	},
	["lider-mafia"] = {
		_config = {
			title = "Líder Mafia",
			gtype = "job",
		},
		"lider-mafia.permissao",
		"mafia.permissao",
		"ilegal.permissao"
	},

	-----------------------------------------------------------------------------
	--  [ MC ] ------------------------------------------------------------------
	-----------------------------------------------------------------------------
		
	["Motoclub"] = {
		_config = {
			title = "MC",
			gtype = "job",
		},
		"mc.permissao",
		"ilegal.permissao"
	},
	["lider-mc"] = {
		_config = {
			title = "Líder MC",
			gtype = "job",
		},
		"lider-mc.permissao",
		"ilegal.permissao",
		"mc.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ COSANOSTRA ] -----------------------------------------------------------
	-----------------------------------------------------------------------------

	["Cosanostra"] = {
		_config = {
			title = "Cosanostra",
			gtype = "job",
		},
		"cosanostra.permissao",
		"ilegal.permissao"
	},
	["lider-cosanostra"] = {
		_config = {
			title = "Líder Cosanostra",
			gtype = "job",
		},
		"lider-cosanostra.permissao",
		"cosanostra.permissao",
		"ilegal.permissao"
	},

    -----------------------------------------------------------------------------
	-- [ CORLEONE ] -------------------------------------------------------------
	-----------------------------------------------------------------------------

	["Corleone"] = {
		_config = {
			title = "Corleone",
			gtype = "job",
		},
		"corleone.permissao",
		"lavagem.permissao",
		"ilegal.permissao"
	},
	["lider-corleone"] = {
		_config = {
			title = "Líder Corleone",
			gtype = "job",
		},
		"lider-corleone.permissao",
		"corleone.permissao",
		"ilegal.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ YAKUZA ] ---------------------------------------------------------------
	-----------------------------------------------------------------------------

	["Yakuza"] = {
		_config = {
			title = "Yakuza",
			gtype = "job",
		},
		"yakuza.permissao",
		"lavagem.permissao",
		"ilegal.permissao"
	},
	["lider-yakuza"] = {
		_config = {
			title = "Líder Yakuza",
			gtype = "job",
		},
		"lider-yakuza.permissao",
		"yakuza.permissao",
		"ilegal.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ BRATVA ] ---------------------------------------------------------------
	-----------------------------------------------------------------------------

	["Bratva"] = {
		_config = {
			title = "Bratva",
			gtype = "job",
		},
		"bratva.permissao",
		"ilegal.permissao"
	},
	["lider-bratva"] = {
		_config = {
			title = "Líder Bratva",
			gtype = "job",
		},
		"lider-bratva.permissao",
		"bratva.permissao",
		"ilegal.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ HELLS ANGELS ] ---------------------------------------------------------
	-----------------------------------------------------------------------------

	["HellsAngels"] = {
		_config = {
			title = "Hells Angels",
			gtype = "job",
		},
		"hellsangels.permissao",
		"ilegal.permissao"
	},
	["lider-hellsangels"] = {
		_config = {
			title = "Líder Hells",
			gtype = "job",
		},
		"lider-hellsangels.permissao",
		"hellsangels.permissao",
		"ilegal.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ DOLLS ] ---------------------------------------------------------
	-----------------------------------------------------------------------------

	["Dolls"] = {
		_config = {
			title = "Dolls",
			gtype = "job",
		},
		"dolls.permissao",
		"ilegal.permissao"
	},
	["lider-dolls"] = {
		_config = {
			title = "Líder Hells",
			gtype = "job",
		},
		"lider-dolls.permissao",
		"dolls.permissao",
		"ilegal.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ DriftKing ] ------------------------------------------------------------
	-----------------------------------------------------------------------------

	["DriftKing"] = {
		_config = {
			title = "Drift King",
			gtype = "job",
		},
		"driftking.permissao",
		"desmanche.permissao",
		"ilegal.permissao"
	},
	["lider-driftking"] = {
		_config = {
			title = "Drift King",
			gtype = "job",
		},
		"lider-driftking.permissao",
		"driftking.permissao",
		"desmanche.permissao",
		"ilegal.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ MIDNIGHTCLUB ] ---------------------------------------------------------
	-----------------------------------------------------------------------------

	["MidnightClub"] = {
		_config = {
			title = "Midnight Club",
			gtype = "job",
		},
		"midnightclub.permissao",
		"desmanche.permissao",
		"ilegal.permissao"
	},
	["lider-yakuza"] = {
		_config = {
			title = "Líder Midnight",
			gtype = "job",
		},
		"lider-midnightclub.permissao",
		"midnightclub.permissao",
		"ilegal.permissao"
	},

		-----------------------------------------------------------------------------
	-- [ DriftKing ] ------------------------------------------------------------
	-----------------------------------------------------------------------------

	["Corredor"] = {
		_config = {
			title = "Corredor",
			gtype = "altl",
		},
		"corredor.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ Vanilla ] --------------------------------------------------------------
	-----------------------------------------------------------------------------

	["Vanilla"] = {
		_config = {
			title = "Vanilla",
			gtype = "job",
		},
		"vanilla.permissao",
		"ilegal.permissao"
	},
	["lider-vanilla"] = {
		_config = {
			title = "Líder Vanilla",
			gtype = "job",
		},
		"lider-vanilla.permissao",
		"vanilla.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ Bahamas ] --------------------------------------------------------------
	-----------------------------------------------------------------------------

	["Bahamas"] = {
		_config = {
			title = "Bahamas",
			gtype = "job",
		},
		"bahamas.permissao",
		"ilegal.permissao"
	},
	["lider-bahamas"] = {
		_config = {
			title = "Líder Bahamas",
			gtype = "job",
		},
		"lider-bahamas.permissao",
		"bahamas.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ Concessionaria ] -------------------------------------------------------
	-----------------------------------------------------------------------------

	["Concessionaria"] = {
		_config = {
			title = "Concessionaria",
			gtype = "job",
		},
		"concessionaria.permissao",
		"vendedor.permissao",
		"ilegal.permissao"
	},
	["lider-concessionaria"] = {
		_config = {
			title = "Líder Concessionaria",
			gtype = "job",
		},
		"lider-concessionaria.permissao",
		"concessionaria.permissao",
		"vendedor.permissao",
		"ilegal.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ Concessionaria ] -------------------------------------------------------
	-----------------------------------------------------------------------------

	["Concessionaria"] = {
		_config = {
			title = "Concessionaria",
			gtype = "job",
		},
		"concessionaria.permissao",
		"ilegal.permissao"
	},
	["lider-concessionaria"] = {
		_config = {
			title = "Líder Concessionaria",
			gtype = "job",
		},
		"lider-concessionaria.permissao",
		"concessionaria.permissao",
		"ilegal.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ LOS COLOMBIANOS ] ------------------------------------------------------
	-----------------------------------------------------------------------------

	["lc"] = {
		_config = {
			title = "Los Colombianos",
			gtype = "job",
		},
		"lc.permissao",
		"ilegal.permissao"
	},
	["lider-lc"] = {
		_config = {
			title = "Líder Los Colombianos",
			gtype = "job",
		},
		"lider-lc.permissao",
		"ilegal.permissao",
		"lc.permissao"
	},

	-----------------------------------------------------------------------------
	-- [ PEACE ] ----------------------------------------------------------------
	-----------------------------------------------------------------------------

	["peace"] = {
		_config = {
			title = "Peace",
			gtype = "job",
		},
		"peace.permissao",
		"ilegal.permissao"
	},
	["lider-peace"] = {
		_config = {
			title = "Líder Peace",
			gtype = "job",
		},
		"lider-peace.permissao",
		"ilegal.permissao",
		"peace.permissao"
	},

	-----------------------------------------------------------------------------
	--  [ TAXISTA ] -------------------------------------------------------------
	-----------------------------------------------------------------------------
		
	["taxista"] = {
		_config = {
			title = "Taxista",
			gtype = "job",
		},
		"taxista.permissao"
	},
	["paisana-taxista"] = {
		_config = {
			title = "Taxista de Folga",
			gtype = "job",
		},
		"paisana-taxista.permissao"
	},


}

cfg.users = {
	[1] = { "Dono" }
}

cfg.selectors = {}

return cfg