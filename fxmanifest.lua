fx_version 'cerulean'
games { 'gta5' }
author 'sysmagma @ echo.dev'
description 'ECHO DEVELOPMENT - FACTION INVITE SYSTEM'
version '1.0.1'

shared_scripts {
    'backend/shared/config.lua',
}

client_scripts {
    'backend/client/main.lua',
    'backend/client/nuicallbacks.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',

    'backend/server/main.lua',
}

ui_page "frontend/index.html"
files {
    "frontend/index.html",
    "frontend/**/*.*",
}