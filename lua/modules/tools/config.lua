local config = {}

function config.gitsigns()
	local status_ok, gitsigns = pcall(require, "gitsigns")
	if not status_ok then
		vim.notify("gitsigns not found!")
		return
	end

	gitsigns.setup({
		current_line_blame = true,
		current_line_blame_formatter = " <author> - <summary>, <author_time:%Y-%m-%d>",
		current_line_blame_formatter_opts = {
			relative_time = false,
		},
		signs = {
			add = { hl = "GitGutterAdd", text = "▍" },
			change = { hl = "GitGutterChange", text = "▍" },
			delete = { hl = "GitGutterDelete", text = "▍" },
			topdelete = { hl = "GitGutterDeleteChange", text = "▔" },
			changedelete = { hl = "GitGutterChange", text = "▍" },
			untracked = { hl = "GitGutterAdd", text = "▍" },
		},
	})
end

function config.todo()
	require("todo-comments").setup({
		signs = true, -- show icons in the signs column
		sign_priority = 8, -- sign priority
		keywords = {
			FIX = {
				icon = " ",
				color = "#DC2626",
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
			},
			TODO = { icon = " ", color = "#10B981" },
			HACK = { icon = " ", color = "#7C3AED" },
			WARN = { icon = " ", color = "#DC2626", alt = { "WARNING" } },
			NOTE = { icon = " ", color = "#2563EB", alt = { "INFO" } },
			PERF = { icon = " ", color = "#FBBF24", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		},
		colors = {
			error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
			warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
			info = { "DiagnosticInfo", "#2563EB" },
			hint = { "DiagnosticHint", "#10B981" },
			default = { "Identifier", "#7C3AED" },
		},
	})
end

function config.toggleterm()
	local ok, toggleterm = pcall(require, "toggleterm")
	if not ok then
		vim.notify("Could not load toggleterm")
		return
	end

	toggleterm.setup({
		size = function(term)
			if term.direction == "horizontal" then
				return 8
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.5
			end
		end,
		open_mapping = [[<C-\>]],
		shading_factor = "1",
		direction = "float",
		shell = vim.fn.has("win32") == 1 and "pwsh" or vim.o.shell,
		-- This field is only relevant if direction is set to 'float'
		float_opts = {
			border = "single",
			width = 76,
			height = 21,
			winblend = 8,
		},
		highlights = {
			FloatBorder = { link = "keyword" },
		},
	})
	vim.keymap.set("t", "jk", "<C-\\><C-N>")
end

function config.colorizer()
	local status_ok, colorizer = pcall(require, "colorizer")
	if not status_ok then
		return
	end
	colorizer.setup({ "*" }, {
		RGB = true,
		RRGGBB = true,
		names = false,
		RRGGBBAA = true,
		rgb_fn = true,
		hsl_fn = true,
		css = false,
		css_fn = false,
		mode = "background",
	})
end

function config.diffview()
	require("diffview").setup({
		enhanced_diff_hl = true,
	})
end

function config.outline()
	require("symbols-outline").setup({
		width = 25,
		keymaps = {
			hover_symbol = "<C-space>",
			toggle_preview = "<C-k>",
			rename_symbol = "r",
			code_actions = "a",
			fold = "h",
			unfold = "l",
			fold_all = "W",
			unfold_all = "E",
			fold_reset = "R",
		},
	})
end

function config.noice()
	require("noice").setup({
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		presets = {
			bottom_search = false,
			command_palette = false,
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = false,
		},
	})
end

function config.smooth_cursor()
	require("smoothcursor").setup({
		autostart = true,
		cursor = "⌱", -- cursor shape (need nerd font)
		intervals = 35, -- tick interval
		linehl = nil, -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
		type = "exp", -- define cursor movement calculate function, "default" or "exp" (exponential).
		fancy = {
			enable = true, -- enable fancy mode
			head = { cursor = "↠", texthl = "SmoothCursor", linehl = nil },
			body = {
				{ cursor = "", texthl = "SmoothCursorRed" },
				{ cursor = "", texthl = "SmoothCursorPurple" },
				{ cursor = "●", texthl = "SmoothCursorYellow" },
				{ cursor = "●", texthl = "SmoothCursorGreen" },
				{ cursor = "•", texthl = "SmoothCursorAqua" },
				{ cursor = ".", texthl = "SmoothCursorBlue" },
				{ cursor = ".", texthl = "SmoothCursorOrange" },
			},
			tail = { cursor = nil, texthl = "SmoothCursor" },
		},
		priority = 10, -- set marker priority
		speed = 25, -- max is 100 to stick to your current position
		texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
		threshold = 3,
		timeout = 3000,
	})
end

function config.hop()
	local hop = require("hop")
	hop.setup({
		keys = "asdghklqwertyuiopzxcvbnmfj",
	})
end

return config
