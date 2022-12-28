local config = {}

function config.nvim_lsp()
	require("modules.completion.lspconfig")
end

function config.lspsaga()
	local saga = require("lspsaga")
	saga.init_lsp_saga({
		symbol_in_winbar = {
			enable = true,
		},
		finder_icons = {
			def = "  ",
			ref = "諭 ",
			link = "  ",
		},
		definition_action_keys = {
			vsplit = "<C-v>",
		},
		code_action_lightbulb = {
			sign_priority = 99,
		},
	})
end

function config.lua_snip()
	local ls = require("luasnip")
	ls.config.set_config({
		history = false,
		updateevents = "TextChanged,TextChangedI",
	})
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_vscode").lazy_load({
		paths = { "./snippets/" },
	})
end

function config.nvim_cmp()
	require("modules.completion.cmp")
end

function config.ts_autotag()
  local status, autotag = pcall(require, "nvim-ts-autotag")
  if (not status) then return end

  autotag.setup({})
end

return config
