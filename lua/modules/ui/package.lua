local conf = require('modules.ui.config')

packadd({
  'aphasia51/zephyr-nvim',
  dev = true,
  lazy = true,
})

packadd({
  'nvimdev/galaxyline.nvim',
  enabled = false,
  config = conf.galaxyline,
  event = { 'BufRead', 'BufNewFile' },
  dependencies = 'nvim-tree/nvim-web-devicons',
  lazy = true,
})

packadd({
  'nvimdev/whiskyline.nvim',
  dev = true,
  config = function()
    require('whiskyline').setup({})
  end,
  dependencies = 'nvim-tree/nvim-web-devicons',
})

packadd({
  'lewis6991/gitsigns.nvim',
  -- event = { 'InsertEnter' },
  config = conf.gitsigns,
})

packadd({
  'nvimdev/indentmini.nvim',
  event = 'BufEnter',
  config = function()
    require('indentmini').setup({})
  end,
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
})
