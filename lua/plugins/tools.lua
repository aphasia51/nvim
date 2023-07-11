return {
  {
    'kylechui/nvim-surround',
    event = { 'InsertEnter' },
    config = function()
      require('nvim-surround').setup({})
    end,
  },

  {
    'akinsho/toggleterm.nvim',
    cmd = { 'ToggleTerm' },
    config = function()
      local ok, toggleterm = pcall(require, 'toggleterm')
      if not ok then
        vim.notify('Could not load toggleterm')
        return
      end

      toggleterm.setup({
        size = function(term)
          if term.direction == 'horizontal' then
            return 8
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.5
          end
        end,
        open_mapping = [[<C-\>]],
        shading_factor = '1',
        direction = 'float',
        shell = vim.fn.has('win32') == 1 and 'pwsh' or vim.o.shell,
        float_opts = {
          border = 'curved',
          width = 76,
          height = 21,
          winblend = 8,
        },
        highlights = {
          FloatBorder = { link = 'keyword' },
        },
      })
      vim.keymap.set('t', 'jk', '<C-\\><C-N>')
    end,
  },

  {
    'norcalli/nvim-colorizer.lua',
    ft = { 'lua', 'css', 'html', 'sass', 'less', 'typescriptreact' },
    config = function()
      local status_ok, colorizer = pcall(require, 'colorizer')
      if not status_ok then
        return
      end
      colorizer.setup({ '*' }, {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = false,
        css_fn = false,
        mode = 'background',
      })
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = { 'InsertEnter' },
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      vim.defer_fn(function()
        require('todo-comments').setup({
          signs = true,
          sign_priority = 8,
          keywords = {
            FIX = {
              icon = ' ',
              color = '#DC2626',
              alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
            },
            TODO = { icon = ' ', color = '#10B981' },
            HACK = { icon = ' ', color = '#7C3AED' },
            WARN = { icon = ' ', color = '#DC2626', alt = { 'WARNING' } },
            NOTE = { icon = ' ', color = '#2563EB', alt = { 'INFO' } },
            PERF = {
              icon = ' ',
              color = '#FBBF24',
              alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' },
            },
          },
          colors = {
            error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
            warning = { 'DiagnosticWarning', 'WarningMsg', '#FBBF24' },
            info = { 'DiagnosticInfo', '#2563EB' },
            hint = { 'DiagnosticHint', '#10B981' },
            default = { 'Identifier', '#7C3AED' },
          },
        })
      end, 20)
    end,
  },

  {
    'mg979/vim-visual-multi',
    branch = 'master',
    event = { 'InsertEnter' },
  },

  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    config = function()
      require('diffview').setup({
        enhanced_diff_hl = true,
        file_panel = {
          listing_style = 'tree',
          tree_options = {
            flatten_dirs = true,
            folder_statuses = 'only_folded',
          },
          win_config = {
            position = 'left',
            width = 28,
          },
        },
      })
    end,
  },

  {
    'mbbill/undotree',
    cmd = { 'UndotreeToggle' },
  },

  {
    'nvimdev/hlsearch.nvim',
    event = { 'BufRead' },
    config = function()
      require('hlsearch').setup()
    end,
  },

  {
    'phaazon/hop.nvim',
    event = { 'BufReadPost' },
    config = function()
      vim.defer_fn(function()
        local hop = require('hop')
        hop.setup({
          keys = 'asdghklqwertyuiopzxcvbnmfj',
        })
      end, 100)
    end,
  },

  -- {
  --   'rcarriga/nvim-notify',
  --   event = 'VeryLazy',
  --   config = function()
  --     require('notify').setup({ render = 'minimal', stages = 'fade', timeout = 200 })
  --   end,
  -- },

  {
    'folke/noice.nvim',
    event = { 'VeryLazy' },
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('noice').setup({
        presets = {
          bottom_search = false,
          command_palette = false,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      })
    end,
  },

  {
    'nvimdev/flybuf.nvim',
    cmd = 'FlyBuf',
    config = function()
      require('flybuf').setup({})
    end,
  },

  {
    'nvimdev/dashboard-nvim',
    event = { 'VimEnter' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local db = require('dashboard')
      db.setup({
        theme = 'hyper',
        config = {
          week_header = {
            enable = true,
          },
          project = {
            enable = true,
          },
          disable_move = true,
          shortcut = {
            {
              desc = 'Update',
              icon = ' ',
              group = 'Operator',
              action = 'Lazy update',
              key = 'u',
            },
            {
              icon = ' ',
              desc = 'Files',
              group = 'Function',
              action = 'Telescope find_files',
              key = 'f',
            },
            {
              icon = ' ',
              desc = 'Apps',
              group = 'String',
              action = 'Telescope app',
              key = 'a',
            },
            {
              icon = ' ',
              desc = 'dotfiles',
              group = 'Constant',
              action = 'Telescope dotfiles',
              key = 'd',
            },
          },
        },
      })
      vim.api.nvim_create_autocmd('TabNewEntered', {
        callback = function()
          vim.cmd('Dashboard')
        end,
      })
    end,
  },
}
