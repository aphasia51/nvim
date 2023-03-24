local conf = require('modules.tools.config')

packadd({
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

packadd({
  'kylechui/nvim-surround',
  config = function()
    require('nvim-surround').setup({})
  end,
  event = { 'InsertEnter' },
})

packadd({
  'akinsho/toggleterm.nvim',
  config = conf.toggleterm,
  cmd = { 'ToggleTerm' },
})

packadd({
  'norcalli/nvim-colorizer.lua',
  config = conf.colorizer,
  -- event = { 'VeryLazy' },
  ft = { 'lua', 'css', 'html', 'sass', 'less', 'typescriptreact' },
})

packadd({
  'simrat39/symbols-outline.nvim',
  cmd = 'SymbolsOutline',
  config = conf.outline,
})

packadd({
  'skywind3000/asyncrun.vim',
  cmd = { 'AsyncRun' },
})

packadd({
  'skywind3000/asynctasks.vim',
  dependencies = 'skywind3000/asyncrun.vim',
  cmd = { 'AsyncTask' },
  config = function()
    vim.g.asyncrun_open = 7
    vim.g.asynctasks_term_rows = 8
    vim.g.asynctasks_term_cols = 80
  end,
})

packadd({
  'folke/todo-comments.nvim',
  event = { 'InsertEnter' },
  config = conf.todo,
  dependencies = 'nvim-lua/plenary.nvim',
})

packadd({
  'mg979/vim-visual-multi',
  branch = 'master',
  event = { 'InsertEnter' },
})

packadd({
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
  config = conf.diffview,
})

packadd({
  'mbbill/undotree',
  cmd = { 'UndotreeToggle' },
})

packadd({
  'glepnir/hlsearch.nvim',
  event = { 'InsertEnter' },
  config = function()
    require('hlsearch').setup()
  end,
})

packadd({
  'phaazon/hop.nvim',
  event = { 'VeryLazy' },
  config = conf.hop,
})

packadd({
  'folke/noice.nvim',
  event = 'VeryLazy',
  config = conf.noice,
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
})

packadd({
  'gen740/SmoothCursor.nvim',
  enabled = false,
  event = 'VeryLazy',
  config = conf.smooth_cursor,
})

packadd({
  'glepnir/flybuf.nvim',
  cmd = 'FlyBuf',
  config = function()
    require('flybuf').setup({})
  end,
})

packadd({
  'glepnir/dashboard-nvim',
  event = 'VimEnter',
  config = conf.dashboard,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})
