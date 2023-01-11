local package = require("core.pack").package
local conf = require("modules.ui.config")

package({
  "aphasia51/zephyr-nvim",
  config = conf.zephyr,
  event = { "BufRead", "BufNewFile" }
})

package({
  "glepnir/galaxyline.nvim",
  config = conf.galaxyline,
  event = { "BufRead", "BufNewFile" },
  -- event = { "VimEnter" },
  dependencies = "kyazdani42/nvim-web-devicons",
  lazt = true
})

package({
  "lukas-reineke/indent-blankline.nvim",
  event = { "VeryLazy" },
  config = conf.indent_blankline,
})
