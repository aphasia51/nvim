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
      require('plugins.extra.telescope.teleconf')
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost' },
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
      trouble.setup({
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
    'nvimdev/guard.nvim',
    dependencies = {
      'nvimdev/guard-collection',
    },
    -- event = { 'BufRead' },
    ft = { 'c', 'cpp', 'rust', 'lua', 'go', 'typescript', 'javascript', 'javascriptreact' },
    config = function()
      local ft = require('guard.filetype')
      ft('c'):fmt({
        cmd = 'clang-format',
        stdin = true,
        ignore_patterns = { 'neovim', 'vim' },
      })

      ft('lua'):fmt({
        cmd = 'stylua',
        args = { '-' },
        stdin = true,
        ignore_patterns = '%w_spec%.lua',
      })
      ft('go'):fmt('lsp'):append('golines')
      ft('rust'):fmt('rustfmt')
      ft('typescript', 'javascript', 'typescriptreact', 'javascriptreact'):fmt('prettier')

      require('guard').setup({
        -- fmt_on_save = false,
      })
    end,
  },

  {
    'ray-x/go.nvim',
    ft = { 'go' },
    config = function()
      vim.defer_fn(function()
        require('go').setup({})
      end, 100)
    end,
  },
}
