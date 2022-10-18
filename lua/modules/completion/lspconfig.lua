local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()

if not packer_plugins["cmp-nvim-lsp"].loaded then
  vim.cmd([[packadd cmp-nvim-lsp]])
end
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local signs = {
  Error = " ",
  Warn = " ",
  Info = " ",
  Hint = " ",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  virtual_text = {
    prefix = "﮿",
    spacing = 4,
    source = true,
    severity = { min = vim.diagnostic.severity.WARN },
  },
})

lspconfig.gopls.setup({
  cmd = { "gopls", "--remote=auto" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
  capabilities = capabilities,
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
  },
})

lspconfig.sumneko_lua.setup({
  filetypes = { "lua" },
  root_dir = lspconfig.util.root_pattern(
    ".luarc.json",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    ".git"
  ),
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { "vim", "packer_plugins" },
      },
      runtime = { version = "LuaJIT" },
      workspace = {
        library = vim.list_extend({ [vim.fn.expand("$VIMRUNTIME/lua")] = true }, {}),
      },
    },
  },
})

lspconfig.clangd.setup({
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  root_dir = lspconfig.util.root_pattern(
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git"
  ),
})

lspconfig.pyright.setup({
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir = lspconfig.util.root_pattern(unpack({
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    -- customize
    "manage.py",
    "run.py",
    ".git",
  })),
})

local servers = {
  "bashls",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup({})
end
