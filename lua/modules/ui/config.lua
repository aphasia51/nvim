local config = {}

function config.theme()
  vim.cmd.colorscheme("zephyr")
end

function config.galaxyline()
  require("modules.ui.statusline")
end

function config.indent_blankline()
  vim.opt.list = true
  vim.opt.listchars:append("space: ")
  require("indent_blankline").setup({
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    filetype_exclude = {
      "dashboard",
      "DogicPrompt",
      "log",
      "fugitive",
      "gitcommit",
      "packer",
      "markdown",
      "json",
      "txt",
      "vista",
      "help",
      "todoist",
      "NvimTree",
      "git",
      "TelescopePrompt",
      "undotree",
    },
    buftype_exclude = { "terminal", "nofile", "prompt" },
    context_patterns = {
      "class",
      "function",
      "method",
      "block",
      "list_literal",
      "selector",
      "^if",
      "^table",
      "if_statement",
      "while",
      "for",
    },
  })
end

return config
