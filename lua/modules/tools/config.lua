local config = {}

function config.filetype()
	vim.cmd([[packadd filetype.nvim]])
	require("filetype").setup({
		overrides = {
			extensions = {
				-- Set the filetype of *.pn files to potion
				pn = "potion",
			},
			literal = {
				MyBackupFile = "lua",
			},
			complex = {
				[".*git/config"] = "gitconfig", -- Included in the plugin
			},
			-- The same as the ones above except the keys map to functions
			function_extensions = {
				["cpp"] = function()
					vim.bo.filetype = "cpp"
					-- Remove annoying indent jumping
					vim.bo.cinoptions = vim.bo.cinoptions .. "L0"
				end,
				["pdf"] = function()
					vim.bo.filetype = "pdf"
					-- Open in PDF viewer (Skim.app) automatically
					vim.fn.jobstart("open -a skim " .. '"' .. vim.fn.expand("%") .. '"')
				end,
			},
			function_literal = {
				Brewfile = function()
					vim.cmd("syntax off")
				end,
			},

			function_complex = {
				["*.math_notes/%w+"] = function()
					vim.cmd("iabbrev $ $$")
				end,
			},

			shebang = {
				-- Set the filetype of files with a dash shebang to sh
				dash = "sh",
			},
		},
	})
end

function config.gitsigns()
	if not packer_plugins["plenary.nvim"].loaded then
		vim.cmd([[packadd plenary.nvim]])
	end

	local status_ok, gitsigns = pcall(require, "gitsigns")
	if not status_ok then
		vim.notify("gitsigns not found!")
		return
	end

	gitsigns.setup({
		signs = {
			add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
			change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
			delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			changedelete = {
				hl = "GitSignsChange",
				text = "~",
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
		},
		current_line_blame = true,
		current_line_blame_formatter = " 🩺 <author>, <author_time:%Y-%m-%d> - <summary>",
		current_line_blame_formatter_opts = {
			relative_time = false,
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
			WARN = { icon = " ", color = "#FBBF24", alt = { "WARNING" } },
			NOTE = { icon = " ", color = "#2563EB", alt = { "INFO" } },
			PERF = { icon = " ", color = "#FC9868", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
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
			border = "curved",
			width = 76,
			height = 21,
			winblend = 8,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	})
	vim.keymap.set("t", "jk", "<C-\\><C-N>")
end

function config.which_key()
	local status_ok, which_key = pcall(require, "which-key")
	if not status_ok then
		return
	end

	local setup = {
		ignore_missing = true,
	}

	local opts = {
		mode = "n",
		prefix = "<Space>",
		nowait = true,
	}

	local mappings = {
		g = {
			name = "Git",
			-- g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
			f = { "<cmd>DiffviewFileHistory<CR>", "File History" },
			p = { "<cmd>DiffviewOpen<CR>", "Diff Project" },
			n = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
			N = { "<cmd>Gitsigns prev_hunk<cr>", "Prev Hunk" },
			l = { "<cmd>Gitsigns blame_line<cr>", "Blame" },
			r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
			R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
			s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
			S = { "<cmd>Gitsigns stage_buffer<cr>", "Stage Buffer" },
			u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk" },
			U = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk" },
			d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
		},
	}

	which_key.setup(setup)
	which_key.register(mappings, opts)
end

function config.notify()
	local status_ok, notify = pcall(require, "notify")
	if not status_ok then
		vim.notify("notify module not found!")
		return
	end

	vim.notify = notify
	notify.setup({
		stages = "fade_in_slide_out",
		on_open = nil,
		on_close = nil,
		render = "default",
		timeout = 5000,
		max_width = nil,
		max_height = nil,
		background_colour = "Normal",
		minimum_width = 50,
		icons = {
			ERROR = "",
			WARN = "",
			INFO = "",
			DEBUG = "",
			TRACE = "✎",
		},
	})
	local work_time = 1000 * 60 * 20
	local function clock()
		local timer = vim.loop.new_timer()
		timer:start(
			work_time,
			work_time,
			vim.schedule_wrap(function()
				vim.notify("别TM的卷了, 停下来歇会儿", "WARN", { title = "反卷小助手" })
			end)
		)
	end

	clock()
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

return config
