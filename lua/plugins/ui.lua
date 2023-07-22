return {
  {
    'aphasia51/zephyr-nvim',
    dev = true,
    lazy = false,
  },

  {
    'rebelot/heirline.nvim',
    event = { 'UiEnter' },
    config = function()
      require('plugins.extra.heirline')
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'InsertEnter' },
    config = function()
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
    end,
  },

  {
    'nvimdev/indentmini.nvim',
    event = 'BufEnter',
    config = function()
      require('indentmini').setup({
        char = '│',
      })
    end,
  },
}
