vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
vim.api.nvim_set_keymap("x", " ", "", { noremap = true })

require("core.pack"):boot_strap()
require("core.options")
require("core.keymap")
require("internal.autocmds")
