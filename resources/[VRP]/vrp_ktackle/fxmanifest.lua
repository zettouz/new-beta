fx_version 'bodacious'
game 'gta5'

ui_page 'client/html/UI.html'


server_scripts {
    '@vrp/lib/utils.lua',
    'config.lua',
    'server.lua',
}

client_scripts {
	'@vrp/lib/utils.lua',
    'config.lua',
    'client.lua'
}