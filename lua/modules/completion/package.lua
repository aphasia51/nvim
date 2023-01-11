local package = require('core.pack').package
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

package({
  'neovim/nvim-lspconfig',
  ft = enable_lsp_filetype,
  config = conf.nvim_lsp,
  dependencies = {
    { 'glepnir/lspsaga.nvim', config = conf.lspsaga },
  },
})

package({ 'windwp/nvim-autopairs', event = 'InsertEnter' })

package({
  'hrsh7th/nvim-cmp',
  event = { "InsertEnter" },
  config = conf.nvim_cmp,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    "hrsh7th/cmp-cmdline",
    "hrsh7th/vim-vsnip",
    "hrsh7th/cmp-vsnip",
    "rafamadriz/friendly-snippets"
  },
})

package({
  "windwp/nvim-ts-autotag",
  config = conf.ts_autotag,
  ft = { "html", "javascript", "xml" },
})
