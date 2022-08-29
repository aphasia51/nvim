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
  'glepnir/nvim-lspconfig',
  ft = enable_lsp_filetype,
  config = conf.nvim_lsp,
})

package({ 'glepnir/lspsaga.nvim', after = 'nvim-lspconfig', config = conf.lspsaga })

package({ 'windwp/nvim-autopairs', event = 'InsertEnter' })

package({
  { "rafamadriz/friendly-snippets", event = { "InsertEnter", "CmdlineEnter" } },
  { "hrsh7th/vim-vsnip", after = { "friendly-snippets", "nvim-autopairs" } },
  { "hrsh7th/nvim-cmp", after = { "vim-vsnip" }, config = conf.nvim_cmp },
  { "hrsh7th/cmp-vsnip", after = { "nvim-cmp" } },
  { "hrsh7th/cmp-nvim-lsp", after = { "nvim-cmp" } },
  { "hrsh7th/cmp-buffer", after = { "nvim-cmp" } },
  { "hrsh7th/cmp-path", after = { "nvim-cmp" } },
  { "hrsh7th/cmp-cmdline", after = { "nvim-cmp" } },
})
