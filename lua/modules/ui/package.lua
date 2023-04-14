local conf = require('modules.ui.config')

packadd({
  'aphasia51/zephyr-nvim',
  dev = true,
  lazy = true,
})

packadd({
  'nvimdev/galaxyline.nvim',
  config = conf.galaxyline,
  event = { 'BufRead', 'BufNewFile' },
  dependencies = 'nvim-tree/nvim-web-devicons',
  lazy = true,
})

packadd({
  'lewis6991/gitsigns.nvim',
  event = { 'InsertEnter' },
  config = conf.gitsigns,
})
