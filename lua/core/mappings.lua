local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- *** Normal *** --

-- Quickly quit
keymap("n", "Q", "<cmd>q<CR>", opts)

-- Better window navigation
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "m", ":bnext<CR>", opts)
keymap("n", "z", ":bprevious<CR>", opts)

-- Delete current buffer
keymap("n", "<leader>bd", ":bd!<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Fast to move
keymap("n", "H", "5h", opts)
keymap("n", "J", "5j", opts)
keymap("n", "K", "5k", opts)
keymap("n", "L", "5l", opts)

keymap("n", ".", "$", opts)
keymap("n", ",", "0", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Fast to move
keymap("v", "<A-h>", "5h", opts)
keymap("v", "<A-j>", "5j", opts)
keymap("v", "<A-k>", "5k", opts)
keymap("v", "<A-l>", "5l", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

keymap("v", ".", "$", opts)
keymap("v", ",", "0", opts)

-- *** Plugins keymaps *** --

-- Telescope
keymap("n", ";f", "<cmd>Telescope find_files<CR>", opts)
keymap("n", ";l", "<cmd>lua require('telescope.builtin').grep_string { search = vim.fn.expand('<cword>') }<CR>", opts)
keymap("n", ";d", "<cmd>Telescope diagnostics<CR>", opts)

-- Quickfix close
keymap("n", "<S-z>", "<cmd>cclose<CR>", opts)

-- Bufferline
keymap("n", "<TAB>", "<cmd>BufferLineCycleNext<CR>", opts)
keymap("n", "<A-c>", "<cmd>BufferLineCloseRight<CR>", opts)

-- Asyncrun
-- AsyncTasks run
keymap("n", "r", ":AsyncTask file-run<CR>", opts)
keymap("n", "<leader>r", ":AsyncTask file-build<CR>", opts)

-- Nvim-Tree
keymap("n", "<A-m>", "<cmd>NvimTreeToggle<CR>", opts)
keymap("n", "<A-n>", "<cmd>NvimTreeFindFile<CR>", opts)

-- Symbols outline
keymap("n", "so", "<cmd>SymbolsOutline<CR>", opts)

-- Null-ls
keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

-- Lsp
keymap("n", "ck", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

-- Trouble
keymap("n", "<leader>d", "<cmd>TroubleToggle<CR>", opts)
