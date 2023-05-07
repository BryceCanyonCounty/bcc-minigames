game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'
author "VORP @Bytesizd"

client_scripts {
    'client/services/*.lua',
    'client/main.lua'
}

ui_page {
    "ui/shim.html"
}

files {
    "ui/shim.html",
    "ui/js/*.*",
    "ui/css/*.*",
    "ui/fonts/*.*",
    "ui/img/*.*"
}

export "initiate"

version '1.0.0'
