local config = {}

function config.telescope()
	if not packer_plugins["plenary.nvim"].loaded then
		vim.cmd([[packadd plenary.nvim]])
		vim.cmd([[packadd telescope-fzy-native.nvim]])
		vim.cmd([[packadd telescope-file-browser.nvim]])
	end
	local actions = require("telescope.actions")
	require("telescope").setup({
		defaults = {
			path_display = { "truncate" },
			dynamic_preview_title = true,
			prompt_prefix = "" .. " ",
			selection_caret = " ",
			initial_mode = "insert",
			sorting_strategy = "ascending",
			-- borderchars = {
			-- 	prompt = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" },
			-- 	preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			-- 	results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			-- },
			color_devicons = true,
			preview = {
				filesize_limit = 5,
				timeout = 300,
				treesitter = true,
			},
			history = {
				limit = 100,
			},
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.6,
				},
				vertical = {
					mirror = false,
				},
				width = 0.74,
				height = 0.76,
				preview_cutoff = 120,
			},
			mappings = {
				i = {
					["<C-j>"] = actions.cycle_history_next,
					["<C-k>"] = actions.cycle_history_prev,
					["<leader>f"] = actions.close,

					["<C-Down>"] = actions.cycle_history_next,
					["<C-Up>"] = actions.cycle_history_prev,

					["<CR>"] = actions.select_default,
					["<C-x>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,

					["<A-k>"] = actions.preview_scrolling_up,
					["<A-j>"] = actions.preview_scrolling_down,

					["<PageUp>"] = actions.preview_scrolling_up,
					["<PageDown>"] = actions.preview_scrolling_down,

					["<Tab>"] = actions.move_selection_next,
					["<S-Tab>"] = actions.move_selection_previous,
					["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					["<C-l>"] = actions.complete_tag,
					["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
				},

				n = {
					["<esc>"] = actions.close,
					["q"] = actions.close,
					["<C-f>"] = actions.close,
					["<CR>"] = actions.select_default,
					["o"] = actions.select_default,
					["<C-x>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,

					-- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
					-- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
					["<Tab>"] = actions.move_selection_next,
					["<S-Tab"] = actions.move_selection_previous,
					["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,

					["H"] = actions.move_to_top,
					["M"] = actions.move_to_middle,
					["L"] = actions.move_to_bottom,

					["<Down>"] = actions.move_selection_next,

					["<Up>"] = actions.move_selection_previous,
					["gg"] = actions.move_to_top,
					["G"] = actions.move_to_bottom,

					["<A-k>"] = actions.preview_scrolling_up,
					["<A-j>"] = actions.preview_scrolling_down,

					["<PageUp>"] = actions.preview_scrolling_up,
					["<PageDown>"] = actions.preview_scrolling_down,

					["?"] = actions.which_key,
				},
			},
			file_ignore_patterns = {
				"vendor/*",
				"%.lock",
				"__pycache__/*",
				"%.sqlite3",
				"%.ipynb",
				"node_modules/*",
				"%.jpg",
				"%.jpeg",
				"%.png",
				"%.svg",
				"%.otf",
				"%.ttf",
				".git/",

				"%.webp",

				".dart_tool/",
				".github/",
				".gradle/",
				".idea/",
				".settings/",
				".vscode/",
				"__pycache__/",
				"build/",
				"env/",
				"gradle/",
				"node_modules/",
				"target/",
				"%.pdb",
				"%.dll",
				"%.class",
				"%.exe",
				"%.cache",
				"%.ico",
				"%.pdf",
				"%.dylib",
				"%.jar",
				"%.docx",
				"%.met",
				"smalljre_*/*",
				".vale/",
				"font/",
				".DS_Store",
			},
		},
		extensions = {
			file_browser = {
				dic_icon = "=",
				grouped = true,
				preview = false,
				files = true,
			},
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
			},
		},
		pickers = {
			live_grep = {
				on_input_filter_cb = function(prompt)
					-- AND operator for live_grep like how fzf handles spaces
					return { prompt = prompt:gsub("%s", ".*") }
				end,
			},
		},
	})

	require("telescope").load_extension("file_browser")
	require("telescope").load_extension("fzy_native")
end

function config.nvim_treesitter()
	local ignored = {
		"phpdoc",
		"astro",
		"arduino",
		"beancount",
		"bibtex",
		"bluprint",
		"eex",
		"ecma",
		"elvish",
		"embedded_template",
		"vala",
		"wgsl",
		"verilog",
		"twig",
		"turtle",
		"m68k",
		"hocon",
		"lalrpop",
		"ledger",
		"meson",
		"mehir",
		"rasi",
		"rego",
		"racket",
		"pug",
		"java",
		"tlaplus",
		"supercollider",
		"slint",
		"sparql",
		"rst",
		"rnoweb",
		"m68k",
	}
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "go", "python", "rust", "lua", "proto", "c", "json", "yaml" },
		ignore_install = ignored,
		highlight = {
			enable = true,
			disable = function(lang, bufnr)
				local lines = vim.api.nvim_buf_line_count(bufnr)
				if lang ~= nil and lines >= 1400 then
					vim.cmd([[syntax off]])
					-- vim.cmd([[filetype off]])
					vim.cmd([[set noundofile]])
					vim.cmd([[set noswapfile]])
					vim.cmd([[set noloadplugins]])
					print("Large file, skipped treesitter")
					return true
				else
					return false
				end
			end,
		},
		textobjects = {
			select = {
				enable = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
		},
	})
end

function config.mcc_nvim()
	require("mcc").setup({
		go = {
			{ ";", ":=", ";" },
			{ "7", "&", "7" },
			{ "8", "*", "8" },
		},
	})
end

function config.comment()
	local ok, m = pcall(require, "Comment")

	if not ok then
		return
	end

	m.setup({
		toggler = {
			line = "gcc",
			block = "gcb",
		},
		opleader = {
			line = "gc",

			block = "gb",
		},
		extra = {
			above = "gck",
			below = "gcj",
			eol = "gca",
		},
	})
end

function config.null_ls()
	local null_ls_status_ok, null_ls = pcall(require, "null-ls")
	if not null_ls_status_ok then
		return
	end
	local formatting = null_ls.builtins.formatting
	-- pacman -S prettier
	null_ls.setup({
		debug = false,
		sources = {
			formatting.prettier.with({
				extra_filetypes = { "toml", "solidity" },
				extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
			}),
			formatting.black.with({ args = { "--quiet", "-" } }),
			formatting.golines.with({ args = { "--max-len=80" } }),
			formatting.stylua,
			formatting.isort,
			-- formatting.prettier,
		},
	})
end

function config.trouble()
	vim.cmd([[packadd null-ls.nvim]])
	local trouble = require("trouble")
	local null_ls = require("null-ls")

	trouble.setup({
		source = {
			null_ls.builtins.code_actions.gitsigns,
		},
		position = "bottom",
		height = 7,
		width = 50,
		mode = "workspace_diagnostics",
		auto_close = true,
		action_keys = {
			cspell_good = "f",
			cspell_all_good = "sg",
		},
		use_diagnostic_signs = true,
	})

	trouble.cspell_good = function()
		local line = vim.fn.getline(".")
		local word = string.match(line, "Unknown word %((.+)%) cspell")
		if word ~= nil or word ~= "" then
			vim.cmd("spellgood " .. word:lower())
		end
	end

	trouble.cspell_all_good = function()
		local words = {}
		for _, item in pairs(trouble.get_items()) do
			if item.source == "cspell" then
				local word = string.match(item.text, "Unknown word %((.+)%)")
				if word ~= nil or word ~= "" then
					words[word:lower()] = true
				end
			end
		end

		if vim.tbl_isempty(words) then
			return
		end

		local count = 0
		for word, _ in pairs(words) do
			vim.cmd("silent! spellgood " .. word)
			count = count + 1
		end

		local spell_file = vim.opt.spellfile:get()[1]
		print(string.format("%s word(s) added to the %s.", count, spell_file))
	end
end

function config.dap()
	require("modules.editor.dap")
end

return config
