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
keymap("n", "<S-c>", "<cmd>wq<CR>", opts)

-- Delete a word backwards
keymap("n", "dw", 'vb"_d', opts)

-- Better window navigation
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)

-- hop
keymap("n", "f", "<cmd>HopWord<CR>", opts)
keymap("n", "F", "<cmd>HopLine<CR>", opts)

-- Resize with arrows
keymap("n", "<C-k>", ":resize -2<CR>", opts)

keymap("n", "<C-j>", ":resize +2<CR>", opts)
keymap("n", "<C-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-l>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
-- keymap("n", "<C-[>", ":bnext<CR>", opts)
keymap("n", "<C-]>", ":bprevious<CR>", opts)
keymap("n", "<leader>nd", ":bd!<CR>", opts)

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
keymap("n", "<C-f>", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<C-l>", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<C-s>", "<cmd>Telescope diagnostics<CR>", opts)
-- keymap("n", "<leader>s", "<cmd>Telescope git_status<CR>", opts)
keymap("n", "<C-g>", "<cmd>Telescope git_commits<CR>", opts)
keymap("n", "<C-b>", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<C-d>", "<cmd>TodoTelescope<CR>", opts)
-- keymap("n", "<leader>;", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts)
keymap("n", "<C-m>", "<cmd>Telescope file_browser<CR>", opts)

-- Quickfix close
keymap("n", "<S-z>", "<cmd>cclose<CR>", opts)
-- keymap("n", "<S-z>", "<cmd>only<CR>", opts)
-- keymap("n", "<S-z>", "<cmd>tabc<CR>", opts)

-- Bufferline
-- keymap("n", "<TAB>", "<cmd>BufferLineCycleNext<CR>", opts)
-- keymap("n", "<S-TAB>", "<cmd>BufferLineCyclePrev<CR>", opts)
-- keymap("n", "<leader>c", "<cmd>BufferLineCloseRight<CR>", opts)

-- AsyncTasks run
keymap("n", "r", "<cmd>AsyncTask file-run<CR>", opts)
keymap("n", "<leader>r", ":AsyncTask file-build<CR>", opts)
-- keymap("n", "<leader>e", ":SqlsExecuteQuery<CR>", opts)

-- Symbols outline
keymap("n", "<leader>o", "<cmd>SymbolsOutline<CR>", opts)

-- Import packages in go files
keymap("n", "<leader>e", ":<cmd>lua require'internal.func'.import()<CR><CR>", opts)

-- Null-ls
-- keymap("n", "<leader>f", "<cmd>lua require'internal.keyfmt'.format()<CR>", opts)
keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

-- Trouble
keymap("n", "<leader>d", "<cmd>TroubleToggle<CR>", opts)

--toggleterm
keymap("n", ";e", "<cmd>ToggleTerm<CR>", opts)

-- UndotreeToggle
keymap("n", "<C-u>", "<cmd>UndotreeToggle<CR>", opts)

-- Quick save
keymap("n", "<S-s>", "<cmd>w<CR>", opts)

-- Lsp definition
keymap("n", "de", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

-- Lsp saga
keymap("n", "gp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "gn", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", "gh", "<cmd>Lspsaga hover_doc<CR>", opts)
keymap("n", "ga", "<cmd>Lspsaga code_action<CR>", opts)
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
keymap("n", "gs", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap("n", "go", "<cmd>Lspsaga outline<CR>", opts)
keymap("n", "gt", "<cmd>Lspsaga term_toggle<CR>", opts)

--Dap
keymap("n", "db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<F4>", "<cmd>lua require'dap'.terminate()<CR>", opts)
keymap("n", "<F7>", "<cmd>lua require'dap'.step_back()<CR>", opts)
keymap("n", "<F8>", "<cmd>lua require'dap'.continue()<CR>", opts)
keymap("n", "<F9>", "<cmd>lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F5>", "<cmd>lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F6>", "<cmd>lua require'dap'.step_out()<CR>", opts)
keymap("n", "du", "<cmd>DapUiToggle<CR>", opts)
