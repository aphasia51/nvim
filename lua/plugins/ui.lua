return {
  {
    'aphasia51/zephyr-nvim',
    dev = true,
    lazy = false,
  },

  {
    'rebelot/heirline.nvim',
    event = 'UiEnter',
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
    'echasnovski/mini.indentscope',
    event = { 'BufReadPre' },
    version = false, -- wait till new 0.7.0 release to put it back on semver
    opts = {
      -- symbol = "▏",
      symbol = '│',
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
