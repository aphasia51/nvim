local conf = require('modules.ui.config')

packadd({
  'aphasia51/zephyr-nvim',
  lazy = true,
})

packadd({
  'olimorris/onedarkpro.nvim',
  config = conf.onedarkpro,
  lazy = true,
})

packadd({
  'glepnir/galaxyline.nvim',
  enabled = false,
  config = conf.galaxyline,
  event = { 'BufRead', 'BufNewFile' },
  dependencies = 'nvim-tree/nvim-web-devicons',
  lazy = true,
})

packadd({
  'glepnir/whiskyline.nvim',
  dev = true,
  config = conf.whisky,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})

packadd({
  'glepnir/gitsigns.nvim',
  branch = 'patch_2',
  event = { 'InsertEnter' },
  config = conf.gitsigns,
})
