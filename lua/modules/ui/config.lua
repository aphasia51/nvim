local config = {}

function config.zephyr()
  vim.cmd("colorscheme zephyr")
end

function config.galaxyline()
  require("modules.ui.statusline")
end

function config.nvim_tree()
  require("nvim-tree").setup({
    view = {
      width = 30,
      height = 30,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      hide_root_folder = false,
      mappings = {
        list = {
          { key = { "l" }, action = "edit" },
          { key = { "s" }, action = "split" },
          { key = { "v" }, action = "vsplit" },
        },
      },
    },
    renderer = {
      icons = {
        glyphs = {
          default = "",
          symlink = "",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            deleted = "",
            ignored = "",
            renamed = "",
            staged = "",
            unmerged = "",
            unstaged = "",
            untracked = "ﲉ",
          },
        },
      },
    },
  })
end

function config.gitsigns()
  if not packer_plugins["plenary.nvim"].loaded then
    vim.cmd([[packadd plenary.nvim]])
  end
  require("gitsigns").setup({
    signs = {
      add = { hl = "GitGutterAdd", text = "▋" },
      change = { hl = "GitGutterChange", text = "▋" },
      delete = { hl = "GitGutterDelete", text = "▋" },
      topdelete = { hl = "GitGutterDeleteChange", text = "▔" },
      changedelete = { hl = "GitGutterChange", text = "▎" },
    },
    keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,

      ["n ]g"] = { expr = true, "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
      ["n [g"] = { expr = true, "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },

      ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
      ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line()<CR>',

      -- Text objects
      ["o ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
      ["x ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
    },
  })
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
