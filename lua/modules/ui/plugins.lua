local package = require("core.pack").package
local conf = require("modules.ui.config")

package({ "~/software/zephyr-nvim", config = conf.zephyr })

package({
	"glepnir/galaxyline.nvim",
	branch = "main",
	config = conf.galaxyline,
	event = { "BufReadPre", "BufNewFile" },
	requires = "kyazdani42/nvim-web-devicons",
})

package({
	"lukas-reineke/indent-blankline.nvim",
	event = "BufRead",
	config = conf.indent_blankline,
})

package({
	"kyazdani42/nvim-tree.lua",
	cmd = "NvimTreeToggle",
	config = conf.nvim_tree,
	requires = "kyazdani42/nvim-web-devicons",
})

package({
	"akinsho/bufferline.nvim",
	disable = true,
	requires = "kyazdani42/nvim-web-devicons",
	config = conf.bufferline,
	event = { "BufRead", "BufNewFile" },
})
