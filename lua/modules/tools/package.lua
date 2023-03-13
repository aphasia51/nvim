local package = require('core.pack').package
local conf = require('modules.tools.config')

package({
  'williamboman/mason.nvim',
  config = function()
    require('mason').setup({
      ui = {
        border = 'single',
      },
    })
  end,
  cmd = { 'Mason' },
})

package({
  'kylechui/nvim-surround',
  config = function()
    require('nvim-surround').setup({})
  end,
  event = { 'InsertEnter' },
})

package({
  -- 'lewis6991/gitsigns.nvim',
  'glepnir/gitsigns.nvim',
  branch = 'patch_2',
  -- event = { 'BufRead', 'BufNewFile' },
  event = { 'InsertEnter' },
  config = conf.gitsigns,
})

package({
  'akinsho/toggleterm.nvim',
  config = conf.toggleterm,
  cmd = { 'ToggleTerm' },
})

package({
  'norcalli/nvim-colorizer.lua',
  config = conf.colorizer,
  -- event = { 'VeryLazy' },
  ft = { 'lua', 'css', 'html', 'sass', 'less', 'typescriptreact' },
})

package({
  'simrat39/symbols-outline.nvim',
  cmd = 'SymbolsOutline',
  config = conf.outline,
})

package({
  'skywind3000/asyncrun.vim',
  cmd = { 'AsyncRun' },
})

package({
  'skywind3000/asynctasks.vim',
  dependencies = 'skywind3000/asyncrun.vim',
  cmd = { 'AsyncTask' },
  config = function()
    vim.g.asyncrun_open = 7
    vim.g.asynctasks_term_rows = 8
    vim.g.asynctasks_term_cols = 80
  end,
})

package({
  'folke/todo-comments.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = conf.todo,
  event = { 'InsertEnter' },
})

package({
  'mg979/vim-visual-multi',
  branch = 'master',
  event = { 'InsertEnter' },
})

package({
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
  config = conf.diffview,
})

package({
  'mbbill/undotree',
  cmd = { 'UndotreeToggle' },
})

package({
  'glepnir/hlsearch.nvim',
  event = { 'InsertEnter' },
  config = function()
    require('hlsearch').setup()
  end,
})

package({
  'phaazon/hop.nvim',
  event = { 'VeryLazy' },
  config = conf.hop,
})

package({
  'folke/noice.nvim',
  event = 'VeryLazy',
  config = conf.noice,
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
})

package({
  'gen740/SmoothCursor.nvim',
  enabled = false,
  event = 'VeryLazy',
  config = conf.smooth_cursor,
})
