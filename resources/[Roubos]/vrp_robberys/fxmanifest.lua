fx_version 'bodacious'
game 'gta5'

author 'Jackson Silva'
description 'Roubo de Loja de departamento'
version '1.0.0'

ui_page 'ui/index.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'client.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua'
}

files {
	'ui/**/*'
}