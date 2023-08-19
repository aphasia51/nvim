local enable_lsp_filetype = {
  'go',
  'lua',
  'sh',
  'rust',
  'c',
  'cpp',
  'typescript',
  'typescriptreact',
  'javascript',
  'json',
  'python',
}

return {

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre' },
    ft = enable_lsp_filetype,
    config = function()
      require('plugins.extra.lspconfig')
    end,
  },

  {
    'nvimdev/lspsaga.nvim',
    event = { 'BufReadPost' },
    config = function()
      require('lspsaga').setup({
        implement = { enable = true },
        symbol_in_winbar = {
          enable = true,
          hide_keyword = true,
          ignore_patterns = { '%w_spec' },
        },
        ui = {
          kind = {
            ['Folder'] = { ' ', '@repeat' },
          },
        },
      })
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-vsnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require('plugins.extra.cmp')
    end,
  },

  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
    config = function()
      require('plugins.extra.autopairs').setup()
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    ft = { 'html', 'javascript', 'xml' },
    config = function()
      require('nvim-ts-autotag').setup({})
    end,
  },
}
