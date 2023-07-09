local lspconfig = require('lspconfig')

local signs = {
  Error = '',
  Warn = '',
  Info = '',
  Hint = '',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  signs = {
    priority = 99,
  },
  severity_sort = true,
  virtual_text = {
    prefix = '🔥',
    -- spacing = 4,
    source = true,
    severity = { min = vim.diagnostic.severity.WARN },
  },
})

function Attach(client)
  vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
  client.server_capabilities.semanticTokensProvider = nil
  -- local orignal = vim.notify
  -- local mynotify = function(msg, level, opts)
  --   if msg == 'No code actions available' or msg:find('overly') then
  --     return
  --   end
  --   orignal(msg, level, opts)
  -- end
  -- vim.notify = mynotify
end

lspconfig.gopls.setup({
  cmd = { 'gopls', '--remote=auto' },
  on_attach = function(client, _)
    Attach(client)
  end,
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = lspconfig.util.root_pattern('go.mod'),
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
  },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

lspconfig.lua_ls.setup({
  filetypes = { 'lua' },
  root_dir = lspconfig.util.root_pattern(
    '.luarc.json',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml'
  ),
  on_attach = Attach,
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { 'vim', 'packer_plugins' },
      },
      runtime = { version = 'LuaJIT' },
      workspace = {
        library = vim.list_extend({ [vim.fn.expand('$VIMRUNTIME/lua')] = true }, {}),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

lspconfig.clangd.setup({
  on_attach = Attach,
  cmd = {
    'clangd',
    '--background-index',
    '--suggest-missing-includes',
    '--clang-tidy',
    '--header-insertion=iwyu',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  root_dir = lspconfig.util.root_pattern(
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac'
  ),
})

lspconfig.pyright.setup({
  on_attach = Attach,
  cmd = { 'pyright-langserver', '--stdio' },
  root_dir = lspconfig.util.root_pattern(unpack({
    'WORKSPACE',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    -- customize
    'manage.py',
    'main.py',
    'run.py',
  })),
  filetypes = { 'python' },
  single_file_support = true,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'basic', -- off, basic, strict
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        autoImportCompletions = true,
        diagnosticMode = 'openFilesOnly',
        diagnosticSeverityOverrides = {
          strictListInference = true,
          strictDictionaryInference = true,
          strictSetInference = true,
          reportUnusedImport = 'warning',
          reportUnusedClass = 'warning',
          reportUnusedFunction = 'warning',
          reportUnusedVariable = 'warning',
          reportUnusedCoroutine = 'warning',
          reportDuplicateImport = 'warning',
          reportPrivateUsage = 'warning',
          reportUnusedExpression = 'warning',
          reportConstantRedefinition = 'error',
          reportIncompatibleMethodOverride = 'error',
          reportMissingImports = 'error',
          reportUndefinedVariable = 'error',
          reportAssertAlwaysTrue = 'error',
        },
      },
    },
  },
})

lspconfig.rust_analyzer.setup({
  on_attach = Attach,
  settings = {
    ['rust-analyzer'] = {
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = false,
      },
    },
  },
})

local servers = {
  'bashls',
}

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    on_attach = Attach,
  })
end

vim.lsp.handlers['workspace/diagnostic/refresh'] = function(_, _, ctx)
  local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.diagnostic.reset(ns, bufnr)
  return true
end
