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
-- require('telescope').load_extension('dotfiles')
require('telescope').load_extension('file_browser')
-- require('telescope').load_extension('app')
