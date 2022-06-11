vim.opt.list = true
--vim.opt.listchars:append("space:▫")
--vim.opt.listchars:append("eol: ")

require("indent_blankline").setup {
  buftype_exclude = { "terminal", "prompt", "nofile", "help" },
  filetype_exclude = { "packer", "lspinfo", "dashboard" },
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
}
