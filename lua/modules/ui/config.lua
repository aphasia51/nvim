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

return config
