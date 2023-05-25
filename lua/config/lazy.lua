--- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  concurrency = 24,
  defaults = { lazy = true, version = nil },
  install = { missing = true, colorscheme = { "zephyr" } },
  ui = { border = "rounded" },
  dev = { path = '~/workspace/lua' },
  lockfile = "~/.local/share/nvim" .. "/lazy-lock.json",
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        'gzip',
        'matchit',
        -- 'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'shada',
        'editorconfig',
        'health',
        'man',
        'nvim',
        'rplugin',
        'spellfile',
        'zipPlugin',
      },
    },
  },
})
vim.keymap.set("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Plugin Manager" })
