fx_version 'cerulean'
game 'gta5'

author 'DimeloEli'

lua54 'yes'

client_script 'client.lua'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}