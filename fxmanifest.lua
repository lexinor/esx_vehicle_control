fx_version 'adamant'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/locale.lua',
    'config.lua',
    'locales/*.lua'
}

client_scripts {
    'client/*.lua'
}