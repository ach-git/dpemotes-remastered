fx_version 'adamant'
game 'gta5'

-- Base script: https://forum.cfx.re/t/dpemotes-1-7-390-emotes-walkingstyles-keybinding-dances-expressions-and-shared-emotes/843105
author 'ach#9690'
repository 'https://github.com/ach-git'
description 'A remasteres of dpemotes by ach#9690'
version '1.0.0'

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",

    'Config.lua',

	'client/*.lua'
}

server_scripts {
    'Config.lua',
    
	'server/*.lua'
}