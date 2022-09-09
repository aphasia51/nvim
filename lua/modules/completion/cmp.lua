local cmp = require("cmp")

require("nvim-autopairs").setup({})
cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "✪",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword =  "➽",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "⛼",
	Event = "",
	Operator = "",
	TypeParameter = "",
	VimCmdLine = "",
}

cmp.setup({
	preselect = cmp.PreselectMode.Item,
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = function(entry, item)
			-- return special icon for cmdline completion
			if entry.source.name == "cmdline" then
				item.kind = string.format("%s %s", kind_icons["VimCmdLine"], "Vim")
				return item
			end
			local meta_type = item.kind
			item.kind = kind_icons[item.kind] .. ""

			local source_menu = {
				buffer = "[✇ Buf]",
				nvim_lsp = meta_type, --'[ LSP]',
				-- luasnip = "[ Sni]",
				vsnip = "[ Sni]",
				-- snippet = "[ Sni]",
				path = "[~ Pat]",
			}

			--item.menu = (			-- item.kind = string.format("%s %s", kind_icons[item.kind], item.kind)
			-- item.kind = kind_icons[item.kind] .. ''
			item.menu = (source_menu)[entry.source.name]
			return item
		end,
	},
	window = {
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
		completion = {
			border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
			winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
		},
	},
	mapping = {
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {
			"i",
			"c",
		}),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {
			"i",
			"c",
		}),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"]() == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp", priority = 98 },
		{ name = "vsnip", priority = 99 },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "dictionary", keyword_length = 2 },
	},
	experimental = {
		ghost_text = true,
	},
})

cmp.setup.cmdline("/", {

	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{
			name = "buffer",
		},
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
