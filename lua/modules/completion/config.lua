local config = {}

function config.nvim_lsp()
  require('modules.completion.lspconfig')
end

function config.lspsaga()
  require('lspsaga').setup({
    symbol_in_winbar = {
      ignore_patterns = { '%w_spec' },
    },
    ui = {
      border = 'single',
      colors = {
        normal_bg = '#262a33',
      },
      kind = {
        ['Folder'] = { ' ', '@repeat' },
      },
    },
  })
end

function config.lua_snip()
  local ls = require('luasnip')
  ls.config.set_config({
    history = false,
    updateevents = 'TextChanged,TextChangedI',
  })
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = { './snippets/' },
  })
end

function config.nvim_cmp()
  require('modules.completion.cmp')
end

function config.ts_autotag()
  local status, autotag = pcall(require, 'nvim-ts-autotag')
  if not status then
    return
  end

  autotag.setup({})
end

return config
