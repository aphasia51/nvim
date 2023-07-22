local lspconfig = require('lspconfig')
local util = require('lspconfig/util')

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
    source = true,
    severity = { min = vim.diagnostic.severity.WARN },
  },
})

local on_attach = function()
  return function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end
end

local capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.codeAction = {
    dynamicRegistration = true,
    codeActionLiteralSupport = {
      codeActionKind = {
        valueSet = (function()
          local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
          table.sort(res)
          return res
        end)(),
      },
    },
  }
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if not status_ok then
    return
  end
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  return capabilities
end

lspconfig.gopls.setup({
  cmd = { 'gopls', 'serve' },
  on_attach = on_attach(),
  capabilities = capabilities(),
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
  on_attach = on_attach(),
  capabilities = capabilities(),

  root_dir = lspconfig.util.root_pattern(
    '.luarc.json',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml'
  ),
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { 'vim' },
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
  on_attach = on_attach(),
  capabilities = capabilities(),

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
  cmd = { 'pyright-langserver', '--stdio' },
  on_attach = on_attach(),
  capabilities = capabilities(),

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

lspconfig.jedi_language_server.setup({
  cmd = { 'jedi-language-server' },
  on_attach = on_attach(),
  capabilities = capabilities(),

  filetype = { 'python', 'python3' },
  root_dir = util.root_pattern(vim.fn.getcwd()),
  single_file_support = true,
})

lspconfig.rust_analyzer.setup({
  on_attach = on_attach(),
  capabilities = capabilities(),

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
