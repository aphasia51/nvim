vim.cmd([[packadd nvim-lsp-installer]])
vim.cmd([[packadd lspsaga.nvim]])
vim.cmd([[packadd cmp-nvim-lsp]])
local nvim_lsp = require("lspconfig")
local saga = require("lspsaga")
local lsp_installer = require("nvim-lsp-installer")

-- Override diagnostics symbol

saga.init_lsp_saga({
  code_action_icon = '💡',
  -- diagnostic_header_icon = {' ',' ',' ','ﴞ '},
  diagnostic_header = {'😡','😥','😤','😐'},
  code_action_lightbulb = {
    enable = true,
    sign = true,
    sign_priority = 20,
    virtual_text = true,
  },
  -- error_sign = "",
  -- warn_sign = "",
  -- hint_sign = "",
  -- infor_sign = "",
})

lsp_installer.setup({})

vim.diagnostic.config({
  --virtual_text = {
  --  source = "always"
  --},
  virtual_text = {
    -- only show virtual when error
    severity = vim.diagnostic.severity.ERROR,
    prefix = "",
    format  = function (diagnostic)
      if diagnostic.severity == vim.diagnostic.severity.ERROR then
        return string.format("⏻: %s", diagnostic.message)
      end
      return diagnostic.message
    end
  },
  float = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

local signs = {
  { name = "DiagnosticSignError", text = '', texthl = 'DiagnosticSignError' },
  { name = "DiagnosticSignWarn", text = '', texthl = 'DiagnosticSignWarn' },
  { name = "DiagnosticSignInfo", text = 'ﬤ', texthl = 'DiagnosticSignInfo' },
  { name = "DiagnosticSignHint", text = '', texthl = 'DiagnosticSignHint' },

}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.texthl })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local function custom_attach(client)
  if
		client.name == "tsserver"
		or client.name == "jsonls"
		or client.name == "sumneko_lua"
		or client.name == "html"
		or client.name == "gopls"
	then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end
	require("lsp_signature").on_attach({
		bind = false,
		use_lspsaga = false,
		floating_window = false,
		fix_pos = false,
		hint_enable = false,
    hint_prefix = "🥵 ",  -- Panda for parameter
		hi_parameter = "LspSignatureActiveParameter", --"Search",
    max_height = 4,
    max_width = 60,
		handler_opts = { "shadw" },
    -- toggle_key = "sp"
	})
end

local function switch_source_header_splitcmd(bufnr, splitcmd)
	bufnr = nvim_lsp.util.validate_bufnr(bufnr)
	local clangd_client = nvim_lsp.util.get_active_client_by_name(bufnr, "clangd")
	local params = { uri = vim.uri_from_bufnr(bufnr) }
	if clangd_client then
		clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
			if err then
				error(tostring(err))
			end
			if not result then
				print("Corresponding file can’t be determined")
				return
			end
			vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
		end)
	else
		print("method textDocument/switchSourceHeader is not supported by any servers active on the current buffer")
	end
end

-- Override server settings here

for _, server in ipairs(lsp_installer.get_installed_servers()) do
	if server.name == "gopls" then
		nvim_lsp.gopls.setup({
			on_attach = custom_attach,
			--[[ flags = {
        debounce_text_changes = 800,
        debounce_did_change_notify = 250,
      }, ]]
			capabilities = capabilities,
			cmd = { "gopls", "-remote=auto" },
			settings = {
				gopls = {
					usePlaceholders = true,
					analyses = {
						nilness = true,
						shadow = true,
						unusedparams = true,
						unusewrites = true,
            staticcheck = true,
					},
				},
			},
		})

  elseif server.name == "sqls" then
    require'lspconfig'.sqls.setup{
      on_attach = function(client, bufnr)
        require('sqls').on_attach(client, bufnr)
      end,
      settings = {
        sqls = {
          connections = {
            {
              driver = 'mysql',
              user = "xhs",
              passwd = "asxhs",
              proto = "tcp",
              host = "172.19.48.1",
              dbName = "dahaizi",
              -- dataSourceName = 'xhs:asxhs@tcp(172.19.48.1:3306)/dahaizi'
            },
            {
              driver = 'mysql',
              dataSourceName = 'xhs:asxhs@tcp(172.19.48.1:3306)/bubble',
            },
          },
        },
      },
    }
  elseif server.name == "sumneko_lua" then
		nvim_lsp.sumneko_lua.setup({
			capabilities = capabilities,
			on_attach = custom_attach,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim", "packer_plugins" } },
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						},

						maxPreload = 100000,
						preloadFileSize = 10000,
					},
					telemetry = { enable = false },
				},
			},
		})
	elseif server.name == "clangd" then
		local copy_capabilities = capabilities
		copy_capabilities.offsetEncoding = { "utf-16" }

		nvim_lsp.clangd.setup({
			capabilities = copy_capabilities,
			single_file_support = true,
			on_attach = custom_attach,
			args = {
				"--background-index",
				"-std=c++20",
				"--pch-storage=memory",
				"--clang-tidy",
				"--suggest-missing-includes",
			},
			commands = {
				ClangdSwitchSourceHeader = {
					function()
						switch_source_header_splitcmd(0, "edit")
					end,
					description = "Open source/header in current buffer",
				},
				ClangdSwitchSourceHeaderVSplit = {
					function()
						switch_source_header_splitcmd(0, "vsplit")
					end,
					description = "Open source/header in a new vsplit",
				},
				ClangdSwitchSourceHeaderSplit = {
					function()
						switch_source_header_splitcmd(0, "split")
					end,
					description = "Open source/header in a new split",
				},
			},
		})
	elseif server.name == "jsonls" then

		nvim_lsp.jsonls.setup({
			flags = { debounce_text_changes = 500 },
			capabilities = capabilities,
			on_attach = custom_attach,
			settings = {
				json = {
					-- Schemas https://www.schemastore.org
					schemas = {
						{
							fileMatch = { "package.json" },
							url = "https://json.schemastore.org/package.json",
						},

						{
							fileMatch = { "tsconfig*.json" },
							url = "https://json.schemastore.org/tsconfig.json",
						},
						{
							fileMatch = {
								".prettierrc",
								".prettierrc.json",
								"prettier.config.json",
							},
							url = "https://json.schemastore.org/prettierrc.json",
						},
						{
							fileMatch = { ".eslintrc", ".eslintrc.json" },
							url = "https://json.schemastore.org/eslintrc.json",
						},
						{
							fileMatch = {
								".babelrc",

								".babelrc.json",
								"babel.config.json",
							},
							url = "https://json.schemastore.org/babelrc.json",
						},
						{
							fileMatch = { "lerna.json" },
							url = "https://json.schemastore.org/lerna.json",
						},
						{
							fileMatch = {
								".stylelintrc",
								".stylelintrc.json",
								"stylelint.config.json",
							},
							url = "http://json.schemastore.org/stylelintrc.json",
						},
						{
							fileMatch = { "/.github/workflows/*" },
							url = "https://json.schemastore.org/github-workflow.json",

						},
					},
				},
			},
		})
	else
		nvim_lsp[server.name].setup({
			capabilities = capabilities,
			on_attach = custom_attach,
		})
	end
end

