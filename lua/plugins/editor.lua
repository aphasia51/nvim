return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = { 'Telescope' },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
    },
    config = function()
      require('plugins.extra.telescope.telescope')
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('plugins.extra.treesitter')
    end,
  },

  {
    'numToStr/Comment.nvim',
    event = { 'BufRead' },
    config = function()
      vim.defer_fn(function()
        local ok, m = pcall(require, 'Comment')
        if not ok then
          return
        end

        m.setup({
          toggler = {
            line = 'gcc',
            block = 'gcb',
          },
          opleader = {
            line = 'gc',

            block = 'gb',
          },
          extra = {
            above = 'gck',
            below = 'gcj',
            eol = 'gca',
          },
        })
      end, 500)
    end,
  },

  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle' },
    config = function()
      local trouble = require('trouble')
      -- local null_ls = require("null-ls")
      trouble.setup({
        -- source = {
        -- 	null_ls.builtins.code_actions.gitsigns,
        -- },
        position = 'bottom',
        height = 7,
        width = 50,
        mode = 'workspace_diagnostics',
        auto_close = true,
        action_keys = {
          cspell_good = 'f',
          cspell_all_good = 'sg',
        },
        use_diagnostic_signs = true,
      })
    end,
  },

  {
    'nvimdev/easyformat.nvim',
    ft = { 'c', 'cpp', 'rust', 'lua', 'go', 'python' },
    config = function()
      local configs = require('easyformat.config')
      configs.lua = {
        ignore_patterns = { '%pspec', 'neovim/*' },
      }
      configs.c = {
        ignore_patterns = { 'neovim/*' },
      }
      configs.use_default({
        'cpp',
        'go',
        'javascript',
        'javascriptreact',
      })
      require('easyformat').setup({
        fmt_on_save = true,
      })
    end,
  },

  {
    'ray-x/go.nvim',
    ft = { 'go', 'gomod' },
    config = function()
      vim.defer_fn(function()
        require('go').setup()
      end, 100)
    end,
  },
}
