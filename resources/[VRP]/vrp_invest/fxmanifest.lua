fx_version 'bodacious'
game 'gta5'

ui_page 'client/html/UI.html'


server_scripts {
    '@vrp/lib/utils.lua',
    'config.lua',
    'server/server.lua',
}

client_scripts {
	'@vrp/lib/utils.lua',
    'config.lua',
    'client/client.lua'
}

export 'openUI'

files {
    'client/html/UI.html',
    'client/html/script.js',
    'client/html/style.css',
    'client/html/media/font/Futura-Bold.woff',
    'client/html/media/img/circle.png',
    'client/html/media/img/curve.png',
    'client/html/media/img/fingerprint.jpg',
    'client/html/media/img/logo-big.png',
    'client/html/media/img/logo-top.png',
}