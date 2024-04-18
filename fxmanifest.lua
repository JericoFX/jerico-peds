fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
name 'Jerico-Peds'
author 'JericoFX'
version '0.1.1'
license 'LGPL-3.0-or-later'
repository ''
description 'no'

shared_scripts {
    "@ox_lib/init.lua"
}
client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}
