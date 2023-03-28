local config = {}

function config.telescope()
  local actions = require('telescope.actions')
  local fb_actions = require('telescope').extensions.file_browser.actions
  require('telescope').setup({
    defaults = {
      prompt_prefix = '' .. ' ',
      selection_caret = ' ',
      layout_config = {
        horizontal = { prompt_position = 'top', results_width = 0.6 },
        vertical = { mirror = false },
      },
      sorting_strategy = 'ascending',
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      mappings = {
        i = {
          ['<C-j>'] = actions.cycle_history_next,
          ['<C-k>'] = actions.cycle_history_prev,
          ['<leader>f'] = actions.close,
          ['<CR>'] = actions.select_default,

          ['<C-x>'] = actions.select_horizontal,
          ['<C-v>'] = actions.select_vertical,
          ['<C-t>'] = actions.select_tab,

          ['<A-k>'] = actions.preview_scrolling_up,
          ['<A-j>'] = actions.preview_scrolling_down,

          ['<Tab>'] = actions.move_selection_next,
          ['<S-Tab>'] = actions.move_selection_previous,
          ['<C-_>'] = actions.which_key, -- keys from pressing <C-/>
        },
        n = {
          ['<esc>'] = actions.close,
          ['q'] = actions.close,
          ['<C-f>'] = actions.close,
          ['<CR>'] = actions.select_default,
          ['o'] = actions.select_default,

          ['<C-x>'] = actions.select_horizontal,
          ['<C-v>'] = actions.select_vertical,
          ['<C-t>'] = actions.select_tab,

          ['<Tab>'] = actions.move_selection_next,
          ['<S-Tab'] = actions.move_selection_previous,
          ['j'] = actions.move_selection_next,
          ['k'] = actions.move_selection_previous,
          ['gg'] = actions.move_to_top,
          ['G'] = actions.move_to_bottom,
          ['<A-k>'] = actions.preview_scrolling_up,
          ['<A-j>'] = actions.preview_scrolling_down,
          ['?'] = actions.which_key,
        },
      },
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
      file_browser = {
        mappings = {
          ['n'] = {
            ['u'] = fb_actions.goto_parent_dir,
          },
        },
      },
    },
  })
  require('telescope').load_extension('fzy_native')
  require('telescope').load_extension('dotfiles')
  require('telescope').load_extension('file_browser')
  require('telescope').load_extension('app')
end

function config.nvim_treesitter()
  local ignored = {
    'phpdoc',
    'astro',
    'arduino',
    'beancount',
    'bibtex',
    'bluprint',
    'eex',
    'ecma',
    'elvish',
    'embedded_template',
    'vala',
    'wgsl',
    'verilog',
    'twig',
    'turtle',
    'm68k',
    'hocon',
    'lalrpop',
    'ledger',
    'meson',
    'mehir',
    'rasi',
    'rego',
    'racket',
    'pug',
    'java',
    'tlaplus',
    'supercollider',
    'slint',
    'sparql',
    'rst',
    'rnoweb',
    'm68k',
  }
  vim.defer_fn(function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'go',
        'gomod',
        'python',
        'rust',
        'lua',
        'vim',
        'proto',
        'c',
        'json',
        'bash',
        'yaml',
        'markdown',
        'markdown_inline',
        'css',
        'javascript',
        'regex',
        'bash',
      },
      ignore_install = ignored,
      autotag = {
        enable = true,
      },
      highlight = {
        enable = true,
        disable = function(lang, bufnr)
          local lines = vim.api.nvim_buf_line_count(bufnr)
          if lang ~= nil and lines >= 1800 then
            -- vim.cmd([[syntax off]])
            -- vim.cmd([[filetype off]])
            -- vim.cmd([[set noundofile]])
            -- vim.cmd([[set noswapfile]])
            -- vim.cmd([[set noloadplugins]])
            print('Large file, skipped treesitter')
            return true
          else
            return false
          end
        end,
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
      },
    })
  end, 50)
end

function config.mutchar()
  vim.defer_fn(function()
    require('mutchar').setup({
      ['go'] = {
        rules = {
          { ';', ':=' },
        },
        one_to_one = true,
      },
    })
  end, 200)
end

function config.comment()
  vim.defer_fn(function()
    local ok, m = pcall(require, 'Comment')
    if not ok then
      return
    end

    m.setup({
      toggler = {
        line = 'gcc',
        block = 'gcb',
      },
      opleader = {
        line = 'gc',

        block = 'gb',
      },
      extra = {
        above = 'gck',
        below = 'gcj',
        eol = 'gca',
      },
    })
  end, 500)
end

function config.trouble()
  local trouble = require('trouble')
  -- local null_ls = require("null-ls")
  trouble.setup({
    -- source = {
    -- 	null_ls.builtins.code_actions.gitsigns,
    -- },
    position = 'bottom',
    height = 7,
    width = 50,
    mode = 'workspace_diagnostics',
    auto_close = true,
    action_keys = {
      cspell_good = 'f',
      cspell_all_good = 'sg',
    },
    use_diagnostic_signs = true,
  })
end

function config.easyformat()
  local configs = require('easyformat.config')
  configs.lua = {
    ignore_patterns = { '%pspec', 'neovim/*' },
  }
  configs.c = {
    ignore_patterns = { 'neovim/*' },
  }
  configs.python = {
    cmd = 'black',
    args = { '-' },
    stdin = true,
  }
  configs.python = {
    cmd = 'isort',
    args = { '-' },
    stdin = true,
  }
  configs.use_default({
    'go',
  })
  require('easyformat').setup({
    fmt_on_save = true,
  })
end

function config.go()
  vim.defer_fn(function()
    require('go').setup()
  end, 100)
end

return config
