local package = require("core.pack").package
local conf = require("modules.editor.config")

package({
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	config = conf.telescope,
	requires = {
		{ "nvim-lua/plenary.nvim", opt = true },
		{ "nvim-telescope/telescope-fzy-native.nvim", opt = true },
		{ "nvim-telescope/telescope-file-browser.nvim", opt = true },
	},
})

package({
	"nvim-treesitter/nvim-treesitter",
	event = { "BufRead", "BufNewFile" },
	run = ":TSUpdate",
	after = "telescope.nvim",
	config = conf.nvim_treesitter,
})

package({ "glepnir/mcc.nvim", ft = { "c", "cpp", "go", "rust" }, config = conf.mcc_nvim })

package({
	"numToStr/Comment.nvim",
	event = "BufRead",
	config = conf.comment,
})

package({
	"jose-elias-alvarez/null-ls.nvim",
	config = conf.null_ls,
	event = { "InsertEnter" },
})

package({
	"folke/trouble.nvim",
	requires = "kyazdani42/nvim-web-devicons",
	config = conf.trouble,
	cmd = "TroubleToggle",
})

package({
	"iamcco/markdown-preview.nvim",
	run = function()
		vim.fn["mkdp#util#install"]()
	end,
	ft = { "markdown" },
	config = function()
		vim.g.mkdp_browser = "firefox"
		vim.g.mkdp_open_to_the_world = 1
		vim.g.mkdp_port = "57843"
		vim.g.mkdp_page_title = "MD-Aphasia"
	end,
})

package({
	"mfussenegger/nvim-dap",
	module = "dap",
	ft = { "go" },
	requires = {
		{ "rcarriga/nvim-dap-ui", ft = { "go" } },
		{ "leoluz/nvim-dap-go", ft = { "go" } },
		{ "theHamsta/nvim-dap-virtual-text", ft = { "go" } },
	},
	config = conf.dap,
})
