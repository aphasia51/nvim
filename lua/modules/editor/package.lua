local package = require("core.pack").package
local conf = require("modules.editor.config")

package({
	"nvim-telescope/telescope.nvim",
	cmd = { "Telescope" },
	config = conf.telescope,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzy-native.nvim" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
	},
})

package({
	"nvim-treesitter/nvim-treesitter",
	event = { "BufRead", "BufNewFile" },
	build = ":TSUpdate",
	config = conf.nvim_treesitter,
})

package({ "glepnir/mutchar.nvim", ft = { "go" }, config = conf.mutchar })

package({
	"numToStr/Comment.nvim",
	event = { "VeryLazy" },
 	config = conf.comment,
})

package({
	"jose-elias-alvarez/null-ls.nvim",
  enabled = false,
	config = conf.null_ls,
	event = { "InsertEnter", "BufNewFile" },
	dependencies = {
		"nvim-lua/plenary.nvim"
	}
})

package({
	"folke/trouble.nvim",
	config = conf.trouble,
  -- event = { "VeryLazy" },
	cmd = { "TroubleToggle" },
})

package({
	"mfussenegger/nvim-dap",
  enabled = false,
	module = false,
	dependencies = {
		{ "rcarriga/nvim-dap-ui", ft = { "go" } },
		{ "leoluz/nvim-dap-go", ft = { "go" } },
		{ "theHamsta/nvim-dap-virtual-text", ft = { "go" } },
	},
	config = conf.dap,
	ft = { "go" },
})
