local package = require("core.pack").package
local conf = require("modules.tools.config")

package({
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup({
      ui = {
        border = "single",
      },
    })
  end,
  event = { "BufNewFile", "BufRead" },
})

package({
  "kylechui/nvim-surround",
  config = function()
    require("nvim-surround").setup({})
  end,
  event = { "BufNewFile", "BufRead" },
})

package({
  "lewis6991/gitsigns.nvim",
  config = conf.gitsigns,
  requires = { "nvim-lua/plenary.nvim", opt = true },
  event = { "BufReadPre", "BufNewFile" },
})

package({
  "akinsho/toggleterm.nvim",
  config = conf.toggleterm,
  event = { "BufRead", "BufNewFile" },
})

package({
  "norcalli/nvim-colorizer.lua",
  config = conf.colorizer,
  event = { "BufReadPre" },
})

package({
  "simrat39/symbols-outline.nvim",
  cmd = "SymbolsOutline",
  config = conf.outline,
})

package({
  "skywind3000/asyncrun.vim",
  cmd = { "AsyncRun" },
})

package({
  "skywind3000/asynctasks.vim",
  requires = "skywind3000/asyncrun.vim",
  cmd = { "AsyncTask" },
  config = function()
    vim.g.asyncrun_open = 7
    vim.g.asynctasks_term_rows = 8
    vim.g.asynctasks_term_cols = 80
  end,
})

package({
  "dstein64/vim-startuptime",
  cmd = { "StartupTime" },
})

package({
  "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = conf.todo,
  event = { "BufReadPre", "BufNewFile" },
})

package({
  "windwp/nvim-ts-autotag",
  ft = { "html", "xml" },
})

package({
  "folke/which-key.nvim",
  config = conf.which_key,
  event = { "BufRead", "BufNewFile" },
})

package({
  "mg979/vim-visual-multi",
  branch = "master",
  event = { "BufRead", "BufNewFile" },
})

package({
  "sindrets/diffview.nvim",
  event = { "BufRead" },
  after = { "plenary.nvim" },
  config = conf.diffview,
})

package({
  "mbbill/undotree",
  event = { "BufRead", "BufNewFile" },
})
