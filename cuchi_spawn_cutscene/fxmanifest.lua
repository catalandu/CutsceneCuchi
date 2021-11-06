fx_version 'adamant'
games  {'rdr3', 'gta5'}

ui_page 'html/index.html'

files {
    'html/music.mp3',
	'html/index.html'
}

shared_script "config.lua" -- Fichier de config

client_scripts {
    "client/*.lua" -- Récuperer tous les fichiers client
}