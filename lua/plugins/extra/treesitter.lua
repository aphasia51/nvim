require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'c',
    'cpp',
    'rust',
    'lua',
    'go',
    'python',
    'proto',
    'typescript',
    'javascript',
    'tsx',
    'bash',
    'css',
    'scss',
    'diff',
    'dockerfile',
    'gomod',
    'gosum',
    'gowork',
    'graphql',
    'html',
    'sql',
    'markdown',
    'markdown_inline',
    'json',
    'jsonc',
  },
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
