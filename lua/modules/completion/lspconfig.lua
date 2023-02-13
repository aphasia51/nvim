local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- add for css completion
capabilities.textDocument.completion.completionItem.snippetSupport = true

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
	signs = {
    priority = 99,
  },
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
	root_dir = lspconfig.util.root_pattern("go.mod"),
	capabilities = capabilities,
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
	filetypes = { "lua" },
	root_dir = lspconfig.util.root_pattern(
		".luarc.json",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml"
	),
	on_attach = function(client, _)
		client.server_capabilities.semanticTokensProvider = nil
	end,
	capabilities = capabilities,
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
			telemetry = {
				enable = false,
			},
		},
	},
})

lspconfig.clangd.setup({
	capabilities = capabilities,
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
		"configure.ac"
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
	})),
})

lspconfig.tsserver.setup({
	capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
	cmd = { "typescript-language-server", "--stdio" },
})

lspconfig.tailwindcss.setup({
  capabilities = capabilities,
  cmd = { "tailwindcss-language-server", "--stdio" },
  root_dir = lspconfig.util.root_pattern('tailwind.config.js', 'tailwind.config.ts', 'postcss.config.js', 'postcss.config.ts', 'package.json', 'node_modules', 'index.html')
})

local servers = {
	"bashls",
	"rust_analyzer",
}

for _, server in ipairs(servers) do
	lspconfig[server].setup({
		capabilities = capabilities,
	})
end

vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
	local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
	pcall(vim.diagnostic.reset, ns)
	return true
end
