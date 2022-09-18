local config = {}

function config.zephyr()
  vim.cmd("colorscheme zephyr")
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

function config.bufferline()
  require("bufferline").setup({
    options = {
      indicator = { icon = " " },
      modified_icon = "✎",
      sort_by = "insert_at_end",
      offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "left" } },
      separator_style = "slant",
    },
    highlights = { buffer_selected = { italic = false, bold = false } },
  })
end

return config
