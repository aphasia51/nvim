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

-- Faster move
keymap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
keymap('n', 'k', '<Plug>(accelerated_jk_gk)', {})

-- Better window navigation
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)

-- Delect the word under cursor and into insert mode
keymap("n", "da", "dawi", opts)

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
keymap("n", ";b", "<cmd>Telescope git_branches<CR>", opts)
keymap("n", ";c", "<cmd>Telescope git_commits<CR>", opts)

-- Quickfix close
keymap("n", "<S-z>", "<cmd>cclose<CR>", opts)
-- keymap("n", "<S-z>", "<cmd>only<CR>", opts)
-- keymap("n", "<S-z>", "<cmd>tabc<CR>", opts)

-- Bufferline
keymap("n", "<TAB>", "<cmd>BufferLineCycleNext<CR>", opts)
keymap("n", "<leader>c", "<cmd>BufferLineCloseRight<CR>", opts)

-- Asyncrun
-- AsyncTasks run
keymap("n", "r", "<cmd>AsyncTask file-run<CR>", opts)
keymap("n", "<leader>r", ":AsyncTask file-build<CR>", opts)
keymap("n", "<leader>e", ":SqlsExecuteQuery<CR>", opts)


-- Nvim-Tree
keymap("n", "<A-m>", "<cmd>NvimTreeToggle<CR>", opts)
keymap("n", "<A-n>", "<cmd>NvimTreeFindFile<CR>", opts)

-- Symbols outline
keymap("n", "<leader>o", "<cmd>SymbolsOutline<CR>", opts)

-- Null-ls
--keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--keymap("n", "gf", "<cmd>lua require('go.format').goimport()<CR>", opts)
keymap("n", "<leader>f", "<cmd>lua require'magic.format'.format()<CR>", opts)

-- Lsp
keymap("n", "dk", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- keymap("n", "do", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
-- keymap("n", "dp", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

-- Trouble
keymap("n", "<leader>d", "<cmd>TroubleToggle<CR>", opts)

-- Quick run
keymap("n", "<A-r>", "<cmd> lua require'magic.quickrun'.run_command()<CR>", opts)

--toggleterm
keymap("n", "<leader>t", "<cmd>ToggleTerm<CR>", opts)

-- lsp_saga
keymap("n", "gd", "<cmd>Lspsaga signature_help<CR><CR>", opts)
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
-- keymap("n", "gd", "<cmd>Lspsaga preview_definition<CR>", opts)
keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
keymap("n", "dp", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", "do", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)

-- DBUI
keymap("n", "<leader>db", "<cmd>Lspsaga lsp_finder<CR>", opts)

-- Diffview
keymap("n", "<leader>do", "<cmd>DiffviewOpen<CR>", opts)
keymap("n", "<leader>df", "<cmd>DiffviewFileHistory<CR>", opts)

-- Gitsigns
keymap("n", "<leader>g", "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", opts)
keymap("n", "<leader>gp", "<cmd>lua require 'gitsigns'.next_hunk()<CR>", opts)
keymap("n", "<leader>go", "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", opts)
keymap("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", opts)
keymap("n", "<leader>gS", "<cmd>lua require 'gitsigns'.stage_buffer()<CR>", opts)
keymap("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", opts)
keymap("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", opts)
keymap("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", opts)
