local package = require("core.pack").package
local conf = require("modules.ui.config")

package({ "aphasia51/zephyr-nvim", config = conf.zephyr })

package({
  "glepnir/galaxyline.nvim",
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
  "akinsho/bufferline.nvim",
  disable = true,
  requires = "kyazdani42/nvim-web-devicons",
  config = conf.bufferline,
  event = { "BufRead", "BufNewFile" },
})
