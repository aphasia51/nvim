local ok, tree_c = pcall(require, "nvim-tree.config")
if not ok then
  vim.notify(tree_c, vim.log.levels.ERROR)
  return
end

-- following options are the default
require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = { "startify", "dashboard" },
  open_on_tab = false,
  hijack_cursor = true,
  update_cwd = true,
  hijack_directories = { enable = true, auto_open = true },
  diagnostics = {
    enable = false,
    icons = { hint = "", info = "", warning = "", error = "" },
  },
  update_focused_file = { enable = false, update_cwd = false, ignore_list = {} },
  system_open = { cmd = nil, args = {} },
  git = {
    ignore = false,
  },
  filters = {
    dotfiles = true,
    custom = {
      ".git",
      "node_modules",

      ".cache",
    },
  },
  actions = {
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",

        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",

      },
    },
    icons = {
      webdev_colors = true,
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          git = {
            unstaged = "",
            staged = "",
            unmerged = "",
            renamed = "凜",
            untracked = "",
            deleted = "",
            ignored = "",
          },
          folder = {
            arrow_open = "",
            arrow_closed = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
        },
    },

  },
  view = {
    width = 28,
    -- height = 30,
    side = "left",
  },
})
