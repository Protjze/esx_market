fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

author 'SUP2Ak'
version '1.0'

description 'supv_blackmarket'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    '_g.lua',
    'config/shared.lua'
}

client_scripts {
    'config/client.lua', 
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

depandencies {
    '/onesync',
    'oxmysql',
    'ox_lib',
    'es_extended',
}
