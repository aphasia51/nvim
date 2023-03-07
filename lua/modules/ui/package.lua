local package = require('core.pack').package
local conf = require('modules.ui.config')

package({
  'aphasia51/zephyr-nvim',
  -- config = conf.theme,
  event = { 'BufRead', 'BufNewFile' },
})

package({
  'glepnir/galaxyline.nvim',
  config = conf.galaxyline,
  -- event = { 'BufRead', 'BufNewFile' },
  event = { 'VeryLazy' },
  dependencies = 'nvim-tree/nvim-web-devicons',
  lazy = true,
})

package({
  'lukas-reineke/indent-blankline.nvim',
  enabled = false,
  event = { 'VeryLazy' },
  config = conf.indent_blankline,
})
