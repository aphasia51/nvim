local config = {}

function config.galaxyline()
  require('modules.ui.statusline')
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
    numhl = true,
    signs = {
      add = { hl = 'GitGutterAdd', text = '+' },
      change = { hl = 'GitGutterChange', text = '┃' },
      delete = { hl = 'GitGutterDelete', text = '⚊' },
      topdelete = { hl = 'GitSignsDeleteChange', text = '‾' },
      changedelete = { hl = 'GitSignsChange', text = '~' },
      untracked = { hl = 'GitSignsAdd', text = '┇' },
    },
  })
end

return config
