local config = {}

function config.todo()
  require('todo-comments').setup({
    signs = true, -- show icons in the signs column
    sign_priority = 8, -- sign priority
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
      PERF = { icon = ' ', color = '#FBBF24', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
    },
    colors = {
      error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
      warning = { 'DiagnosticWarning', 'WarningMsg', '#FBBF24' },
      info = { 'DiagnosticInfo', '#2563EB' },
      hint = { 'DiagnosticHint', '#10B981' },
      default = { 'Identifier', '#7C3AED' },
    },
  })
end

function config.toggleterm()
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
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      border = 'single',
      width = 76,
      height = 21,
      winblend = 8,
    },
    highlights = {
      FloatBorder = { link = 'keyword' },
    },
  })
  vim.keymap.set('t', 'jk', '<C-\\><C-N>')
end

function config.colorizer()
  vim.defer_fn(function()
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
  end, 500)
end

function config.diffview()
  require('diffview').setup({
    enhanced_diff_hl = true,
  })
end

function config.outline()
  require('symbols-outline').setup({
    width = 25,
    keymaps = {
      hover_symbol = '<C-space>',
      toggle_preview = '<C-k>',
      rename_symbol = 'r',
      code_actions = 'a',
      fold = 'h',
      unfold = 'l',
      fold_all = 'W',
      unfold_all = 'E',
      fold_reset = 'R',
    },
  })
end

function config.noice()
  vim.defer_fn(function()
    require('noice').setup({
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    })
  end, 200)
end

function config.hop()
  vim.defer_fn(function()
    local hop = require('hop')
    hop.setup({
      keys = 'asdghklqwertyuiopzxcvbnmfj',
    })
  end, 200)
end

function config.dashboard()
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
      disable_move = false,
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
end

return config
