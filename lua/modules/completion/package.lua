local conf = require('modules.completion.config')

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

packadd({
  'neovim/nvim-lspconfig',
  ft = enable_lsp_filetype,
  -- event = { "VeryLazy" },
  config = conf.nvim_lsp,
})

packadd({
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  config = conf.lspsaga,
})

packadd({ 'windwp/nvim-autopairs', event = 'InsertEnter' })

packadd({
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter' },
  config = conf.nvim_cmp,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/vim-vsnip',
    'hrsh7th/cmp-vsnip',
    'rafamadriz/friendly-snippets',
  },
})

packadd({
  'windwp/nvim-ts-autotag',
  config = conf.ts_autotag,
  ft = { 'html', 'javascript', 'xml' },
})
