require("nvim-treesitter.configs").setup({
  --yati = { enable = true },
  -- indent = {
  --   enable = true
  -- },
  ensure_installed = { "go", "python", "lua", "bash" },
  highlight = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["al"] = "@call.outer",
        ["il"] = "@call.inner",
        ["ap"] = "@parameter.outer",
        ["ip"] = "@parameter.inner",
        ["ao"] = "@condition.outer",
        ["io"] = "@condition.inner",
        ["as"] = "@statement.outer",
      },
    },
  },
})
