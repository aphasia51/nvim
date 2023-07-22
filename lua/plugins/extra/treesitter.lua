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
-- vim.defer_fn(function()
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
  autotag = { enable = true },
  autopairs = { enable = true },
  highlight = {
    enable = true,
    disable = function(lang, bufnr)
      local lines = vim.api.nvim_buf_line_count(bufnr)
      if lang ~= nil and lines >= 1800 then
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
