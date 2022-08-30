local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- *** Normal *** --
-- Quickly quit
keymap("n", "Q", "<cmd>q<CR>", opts)

-- Better window navigation

keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)

-- Delect the word under cursor and into insert mode
keymap("n", "da", "dawi", opts)

-- Resize with arrows
keymap("n", "<C-k>", ":resize -2<CR>", opts)

keymap("n", "<C-j>", ":resize +2<CR>", opts)
keymap("n", "<C-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-l>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "m", ":bnext<CR>", opts)
keymap("n", "z", ":bprevious<CR>", opts)

-- Delete current buffer
keymap("n", "<leader>bd", ":bd!<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Fast to move
--keymap("n", "H", "5h", opts)
keymap("n", "J", "5j", opts)
keymap("n", "K", "5k", opts)
--keymap("n", "L", "5l", opts)

keymap("n", ".", "$", opts)
keymap("n", ",", "^", opts)

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
keymap("n", ";l", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", ";d", "<cmd>Telescope diagnostics<CR>", opts)
keymap("n", ";s", "<cmd>Telescope git_status<CR>", opts)
keymap("n", ";c", "<cmd>Telescope git_commits<CR>", opts)
keymap("n", ";b", "<cmd>Telescope buffers<CR>", opts)

-- Quickfix close
keymap("n", "<S-z>", "<cmd>cclose<CR>", opts)
-- keymap("n", "<S-z>", "<cmd>only<CR>", opts)
-- keymap("n", "<S-z>", "<cmd>tabc<CR>", opts)

-- Bufferline
keymap("n", "<TAB>", "<cmd>BufferLineCycleNext<CR>", opts)
keymap("n", "<S-TAB>", "<cmd>BufferLineCyclePrev<CR>", opts)
keymap("n", "<leader>c", "<cmd>BufferLineCloseRight<CR>", opts)

keymap("n", "gg", "<cmd>0<CR>", opts)

-- AsyncTasks run
keymap("n", "r", "<cmd>AsyncTask file-run<CR>", opts)
keymap("n", "<leader>r", ":AsyncTask file-build<CR>", opts)
keymap("n", "<leader>e", ":SqlsExecuteQuery<CR>", opts)

-- keymap('n', '<A-m>', '<cmd>NvimTreeToggle<CR>', opts)
keymap("n", "<A-m>", "<cmd>Telescope file_browser<CR>", opts)

-- Symbols outline
keymap("n", "<leader>o", "<cmd>SymbolsOutline<CR>", opts)

-- Null-ls
keymap("n", "<leader>f", "<cmd>lua require'internal.formatter'.format()<CR>", opts)

-- Trouble
keymap("n", "<leader>d", "<cmd>TroubleToggle<CR>", opts)

--toggleterm
keymap("n", ";e", "<cmd>ToggleTerm<CR>", opts)

-- Quick save
keymap("n", "<C-s>", "<cmd>write<CR>", opts)

-- Lsp definition
keymap("n", "de", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

-- Lsp saga
keymap("n", '[e', "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", ']e', "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", 'K', "<cmd>Lspsaga hover_doc<CR>", opts)
keymap("n", 'ga', "<cmd>Lspsaga code_action<CR>", opts)
keymap("n", 'gd', "<cmd>Lspsaga preview_definition<CR>", opts)
keymap("n", 'gs', "<cmd>Lspsaga signature_help<CR>", opts)
keymap("n", 'gr', "<cmd>Lspsaga rename<CR>", opts)
keymap("n", 'gh', "<cmd>Lspsaga lsp_finder<CR>", opts)
