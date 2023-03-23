local conf = require('modules.editor.config')

packadd({
  'nvim-telescope/telescope.nvim',
  cmd = { 'Telescope' },
  config = conf.telescope,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
  },
})

packadd({
  'nvim-treesitter/nvim-treesitter',
  event = { 'VeryLazy' },
  -- build = ':TSUpdate',
  config = conf.nvim_treesitter,
})

packadd({
  'glepnir/mutchar.nvim',
  ft = { 'go' },
  config = conf.mutchar,
})

packadd({
  'numToStr/Comment.nvim',
  event = { 'BufRead' },
  config = conf.comment,
})

packadd({
  'folke/trouble.nvim',
  config = conf.trouble,
  cmd = { 'TroubleToggle' },
})

packadd({
  'glepnir/easyformat.nvim',
  ft = { 'c', 'cpp', 'rust', 'lua', 'go', 'python' },
  config = conf.easyformat,
})
