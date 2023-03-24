local config = {}

function config.galaxyline()
  vim.defer_fn(function()
    require('modules.ui.statusline')
  end, 200)
end

function config.whisky()
  vim.defer_fn(function()
    require('whiskyline').setup()
  end, 20)
end

function config.gitsigns()
  local status_ok, gitsigns = pcall(require, 'gitsigns')
  if not status_ok then
    vim.notify('gitsigns not found!')
    return
  end

  gitsigns.setup({
    current_line_blame = true,
    current_line_blame_formatter = ' <author> - <summary>, <author_time:%Y-%m-%d>',
    current_line_blame_formatter_opts = {
      relative_time = false,
    },
    signs = {
      add = { text = '+' },
      change = { text = '┃' },
      delete = { text = '⚊' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┇' },
    },
  })
end

function config.onedarkpro()
  require('onedarkpro').setup({
    highlights = {
      PmenuSel = { bg = '#856D72', fg = 'NONE' },
      DashboardHeader = { fg = '#957FB8' },
      DashboardFooter = { fg = '#6e7171' },

      DashboardProjectIcon = { fg = '#7788d4' },
      DashboardProjectTitle = { fg = '#4491D4' },
      DashboardProjectTitleIcon = { fg = '#f0945d' },

      DashboardMruIcon = { fg = '#f0945d' },
      DashboardMruTitle = { fg = '#4491D4' },

      DashboardShortCutIcon = { fg = '#69a794' },
    },
  })
end

return config
