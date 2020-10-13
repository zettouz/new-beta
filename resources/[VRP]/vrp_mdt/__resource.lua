resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "ui/index.html"

files {
    "nui/index.html",
	"nui/css.css",
	"nui/jquery.js",
	"nui/pages/inicio/inicio.html",
	"nui/pages/inicio/inicio.css",
	"nui/pages/inicio/mdt-comando.png",
	"nui/pages/inicio/mdt.jpg",
	"nui/pages/mdt/index.html",
	"nui/pages/mdt/script.js",
	"nui/pages/mdt/style.css"
}

server_scripts {
	"@vrp/lib/utils.lua",
	'@mysql-async/lib/MySQL.lua',
	"sv_mdt.lua",
	"sv_vehcolors.lua"
}

client_script {
	"@vrp/lib/utils.lua",
	"cl_mdt.lua"
}
