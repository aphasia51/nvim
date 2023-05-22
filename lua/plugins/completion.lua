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

return{


  {
    'neovim/nvim-lspconfig',
    lazy = false,
    ft = enable_lsp_filetype,
    -- event = { "VeryLazy" },
    config = function()
      require('plugins.extra.lspconfig')
    end
  },

  {
    'nvimdev/lspsaga.nvim',
    lazy = false,
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup({
        symbol_in_winbar = {
          ignore_patterns = { '%w_spec' },
        },
        ui = {
          border = 'single',
          colors = {
            normal_bg = '#262a33',
          },
          kind = {
            ['Folder'] = { ' ', '@repeat' },
          },
        },
      })
    end
  },

  { 'windwp/nvim-autopairs', event = 'InsertEnter' },

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
      -- {
      --   'L3MON4D3/LuaSnip',
      --   config = function()
      --     require("luasnip.loaders.from_vscode").lazy_load()
      --   end
      -- },
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require('plugins.extra.cmp')
    end
  },

  {
    'windwp/nvim-ts-autotag',
    ft = { 'html', 'javascript', 'xml' },
    config = function()
      require('nvim-ts-autotag').setup({})
    end
  }
}
