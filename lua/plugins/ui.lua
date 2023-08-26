return {
  {
    'aphasia51/zephyr-nvim',
    dev = true,
    lazy = false,
    config = function()
      vim.cmd('colorscheme ' .. 'zephyr')
    end,
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
    dependencies = { 'nvim-tree/nvim-web-devicons' },
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
    'shellRaining/hlchunk.nvim',
    event = { 'UIEnter' },
    config = function()
      require('hlchunk').setup({
        chunk = {
          exclude_filetypes = {
            aerial = true,
            dashboard = true,
            zsh = true,
            tmux = true,
            toml = true,
          },
          style = {
            { fg = '#3f444a' },
          },
        },
        line_num = {
          enable = false,
        },
        blank = {
          enable = false,
        },
      })
    end,
  },
}
