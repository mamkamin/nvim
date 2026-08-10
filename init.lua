-- Must be set before loading mappings or plugins.
vim.g.mapleader = " "

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.commands")
require("config.packages")
