local config = {}

function config.filetype()
  vim.cmd([[packadd filetype.nvim]])
  require("filetype").setup({
    overrides = {
      extensions = {
        -- Set the filetype of *.pn files to potion
        pn = "potion",
      },
      literal = {
        MyBackupFile = "lua",
      },
      complex = {
        [".*git/config"] = "gitconfig", -- Included in the plugin
      },
      -- The same as the ones above except the keys map to functions
      function_extensions = {
        ["cpp"] = function()
          vim.bo.filetype = "cpp"
          -- Remove annoying indent jumping
          vim.bo.cinoptions = vim.bo.cinoptions .. "L0"
        end,
        ["pdf"] = function()
          vim.bo.filetype = "pdf"
          -- Open in PDF viewer (Skim.app) automatically
          vim.fn.jobstart("open -a skim " .. '"' .. vim.fn.expand("%") .. '"')
        end,
      },
      function_literal = {
        Brewfile = function()
          vim.cmd("syntax off")
        end,
      },

      function_complex = {
        ["*.math_notes/%w+"] = function()
          vim.cmd("iabbrev $ $$")
        end,
      },

      shebang = {
        -- Set the filetype of files with a dash shebang to sh
        dash = "sh",
      },
    },
  })
end

function config.gitsigns()
  if not packer_plugins["plenary.nvim"].loaded then
    vim.cmd([[packadd plenary.nvim]])
  end

  local status_ok, gitsigns = pcall(require, "gitsigns")
  if not status_ok then
    vim.notify("gitsigns not found!")
    return
  end

  gitsigns.setup({
    signs = {
      add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      changedelete = {
        hl = "GitSignsChange",
        text = "~",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
    },
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_formatter = " 🩺 <author>, <author_time:%Y-%m-%d> - <summary>",
    current_line_blame_formatter_opts = {
      relative_time = false,
    },
  })
end

function config.todo()
  require("todo-comments").setup({
    signs = true, -- show icons in the signs column
    sign_priority = 8, -- sign priority
    keywords = {
      FIX = {
        icon = " ",
        color = "#DC2626",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = " ", color = "#10B981" },
      HACK = { icon = " ", color = "#7C3AED" },
      WARN = { icon = " ", color = "#FBBF24", alt = { "WARNING" } },
      NOTE = { icon = " ", color = "#2563EB", alt = { "INFO" } },
      PERF = { icon = " ", color = "#FC9868", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    },
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
    },
  })
end

function config.toggleterm()
  local ok, toggleterm = pcall(require, "toggleterm")
  if not ok then
    vim.notify("Could not load toggleterm")
    return
  end

  toggleterm.setup({
    size = function(term)
      if term.direction == "horizontal" then
        return 8
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.5
      end
    end,
    open_mapping = [[<C-\>]],
    shading_factor = "1",
    direction = "float",
    shell = vim.fn.has("win32") == 1 and "pwsh" or vim.o.shell,
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      border = "curved",
      width = 76,
      height = 21,
      winblend = 8,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  })
  vim.keymap.set("t", "jk", "<C-\\><C-N>")
end

function config.which_key()
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    return
  end

  local setup = {
    ignore_missing = true,
  }

  local opts = {
    mode = "n",
    prefix = "<Space>",
    nowait = true,
  }

  local mappings = {
    g = {
      name = "Git",
      -- g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
      f = { "<cmd>DiffviewFileHistory<CR>", "File History" },
      p = { "<cmd>DiffviewOpen<CR>", "Diff Project" },
      n = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
      N = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      S = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Hunk" },
      u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
      U = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      d = {
        "<cmd>Gitsigns diffthis HEAD<cr>",
        "Diff",
      },
    },

    l = {
      name = "LSP",
      r = { "<cmd>Lspsaga rename<cr>", "Lspsaga Rename" },
      f = { "<cmd>Lspsaga lsp_finder<cr>", "Lsp finder" },
      n = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "diagno next" },

      p = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "diagno prev" },
      d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "definition" },
      h = { "<cmd>Lspsaga hover_doc<CR>", "hover doc" },
      s = { "<cmd>Lspsaga show_line_diagnostics<CR>", "line diagno" },
      g = { "<cmd>Lspsaga signature_help<CR>", "sign help" },
    },
    t = {
      name = "Telescope",
      t = { "<cmd>TodoTelescope<cr>", "Todo List" },
      d = { "<cmd>Telescop diagnostics<cr>", "diagno List" },
      c = { "<cmd>Telescop git_commits<cr>", "git commits" },
      b = { "<cmd>Telescop buffers<cr>", "buffers list" },
    },
  }

  which_key.setup(setup)
  which_key.register(mappings, opts)
end

function config.notify()
  vim.notify = require("notify")
  local status_ok, notify = pcall(require, "notify")
  if not status_ok then
    vim.notify("notify module not found!")
    return
  end

  vim.notify = notify
  notify.setup({
    stages = "fade_in_slide_out",
    on_open = nil,
    on_close = nil,
    render = "default",
    timeout = 5000,
    max_width = nil,
    max_height = nil,
    background_colour = "Normal",
    minimum_width = 50,
    icons = {
      ERROR = "",
      WARN = "",
      INFO = "",
      DEBUG = "",
      TRACE = "✎",
    },
  })
  local work_time = 1000 * 60 * 20
  local function clock()
    local timer = vim.loop.new_timer()
    timer:start(
      work_time,
      work_time,
      vim.schedule_wrap(function()
        vim.notify("别TM的卷了, 停下来歇会儿", "WARN", { title = "反卷小助手" })
      end)
    )
  end

  clock()
end

function config.colorizer()
  local status_ok, colorizer = pcall(require, "colorizer")
  if not status_ok then
    return
  end
  colorizer.setup({ "*" }, {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = false, -- "Name" codes like Blue oe blue
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes: foreground, background, virtualtext
    mode = "background", -- Set the display mode.)
  })
end

function config.diffview()
  -- Lua
  local cb = require 'diffview.config'.diffview_callback

  require 'diffview'.setup {
    diff_binaries = false, -- Show diffs for binaries
    enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
    use_icons = true, -- Requires nvim-web-devicons
    icons = { -- Only applies when use_icons is true.
      folder_closed = "",
      folder_open = "",
    },
    signs = {
      fold_closed = "",
      fold_open = "",
    },
    file_panel = {
      win_config = {
        position = "left", -- One of 'left', 'right', 'top', 'bottom'
        width = 35, -- Only applies when position is 'left' or 'right'
        height = 10, -- Only applies when position is 'top' or 'bottom'
      },
      listing_style = "tree", -- One of 'list' or 'tree'
      tree_options = { -- Only applies when listing_style is 'tree'
        flatten_dirs = true, -- Flatten dirs that only contain one single dir
        folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
      },
    },
    file_history_panel = {
      win_config = {
        position = "bottom",
        width = 35,
        height = 16,
      },
      log_options = {
        single_file = {
          max_count = 512,
          follow = true,
        },
        multi_file = {
          max_count = 128,
          -- follow = false   -- `follow` only applies to single-file history
        },
      },
    },
    default_args = { -- Default args prepended to the arg-list for the listed commands
      DiffviewOpen = {},
      DiffviewFileHistory = {},
    },
    hooks = {}, -- See ':h diffview-config-hooks'
    key_bindings = {
      disable_defaults = false, -- Disable the default key bindings
      -- The `view` bindings are active in the diff buffers, only when the current
      -- tabpage is a Diffview.

      view = {

        ["<tab>"] = cb("select_next_entry"), -- Open the diff for the next file

        ["<s-tab>"]    = cb("select_prev_entry"), -- Open the diff for the previous file
        ["gf"]         = cb("goto_file"), -- Open the file in a new split in previous tabpage
        ["<C-w><C-f>"] = cb("goto_file_split"), -- Open the file in a new split
        ["<C-w>gf"]    = cb("goto_file_tab"), -- Open the file in a new tabpage
        ["<leader>e"]  = cb("focus_files"), -- Bring focus to the files panel
        ["<leader>b"]  = cb("toggle_files"), -- Toggle the files panel.
      },
      file_panel = {

        ["j"]      = cb("next_entry"), -- Bring the cursor to the next file entry
        ["<down>"] = cb("next_entry"),
        ["k"]      = cb("prev_entry"), -- Bring the cursor to the previous file entry.
        ["<up>"]   = cb("prev_entry"),

        ["<cr>"]          = cb("select_entry"), -- Open the diff for the selected entry.
        ["o"]             = cb("select_entry"),
        ["<2-LeftMouse>"] = cb("select_entry"),
        ["<Space>"]       = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
        ["S"]             = cb("stage_all"), -- Stage all entries.
        ["U"]             = cb("unstage_all"), -- Unstage all entries.
        ["r"]             = cb("restore_entry"), -- Restore entry to the state on the left side.
        ["R"]             = cb("refresh_files"), -- Update stats and entries in the file list.
        ["<tab>"]         = cb("select_next_entry"),
        ["<s-tab>"]       = cb("select_prev_entry"),
        ["gf"]            = cb("goto_file"),
        ["<C-w><C-f>"]    = cb("goto_file_split"),
        ["<C-w>gf"]       = cb("goto_file_tab"),
        ["i"]             = cb("listing_style"), -- Toggle between 'list' and 'tree' views
        ["f"]             = cb("toggle_flatten_dirs"), -- Flatten empty subdirectories in tree listing style.
        ["<leader>e"]     = cb("focus_files"),
        ["<leader>b"]     = cb("toggle_files"),
      },
      file_history_panel = {
        ["g!"] = cb("options"), -- Open the option panel

        ["<C-A-d>"] = cb("open_in_diffview"), -- Open the entry under the cursor in a diffview

        ["y"]  = cb("copy_hash"), -- Copy the commit hash of the entry under the cursor
        ["zR"] = cb("open_all_folds"),

        ["zM"]     = cb("close_all_folds"),
        ["j"]      = cb("next_entry"),
        ["<down>"] = cb("next_entry"),

        ["k"]    = cb("prev_entry"),
        ["<up>"] = cb("prev_entry"),

        ["<cr>"] = cb("select_entry"),
        ["o"]    = cb("select_entry"),

        ["<2-LeftMouse>"] = cb("select_entry"),
        ["<tab>"]         = cb("select_next_entry"),
        ["<s-tab>"]       = cb("select_prev_entry"),
        ["gf"]            = cb("goto_file"),
        ["<C-w><C-f>"]    = cb("goto_file_split"),
        ["<C-w>gf"]       = cb("goto_file_tab"),
        ["<leader>e"]     = cb("focus_files"),
        ["<leader>b"]     = cb("toggle_files"),
      },
      option_panel = {
        ["<tab>"] = cb("select"),

        ["q"] = cb("close"),
      },
    },
  }

end

return config
