local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap('', '<Space>', '<Nop>', opts)

-- ============================ --
-- ***        Normal        *** --
-- ============================ --
-- Quickly quit
keymap('n', 'Q', '<cmd>q<CR>', opts)
keymap('n', '<C-s>', ':w<CR>', { noremap = true })

-- Delete a word backwards
-- keymap('n', 'dw', 'vb"_d', opts)
keymap('n', 'db', 'ldb', opts)

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
keymap('n', '<A-[>', ':vertical resize -3<CR>', opts)
keymap('n', '<A-]>', ':vertical resize +3<CR>', opts)

keymap('n', 'j', 'gj', opts)
keymap('n', 'k', 'gk', opts)

-- Fast to move
--keymap("n", "H", "5h", opts)
keymap('n', 'J', '5j', opts)
keymap('n', 'K', '5k', opts)
--keymap("n", "L", "5l", opts)

keymap('n', '.', '$', opts)
keymap('n', ',', '^', opts)

-- ============================ --
-- ***        Insert        *** --
-- ============================ --
-- Press jk fast to enter
keymap('i', 'jk', '<ESC>', opts)

keymap('i', '<C-C>', '<C-C>', opts)

-- insert new line next
keymap('i', '<C-j>', '<C-o>o', opts)
-- insert new line above
keymap('i', '<C-k>', '<C-o>O', opts)
-- corsur move to head
keymap('i', '<C-a>', '<Esc>^i', opts)
-- cursor move to end
keymap('i', '<C-l>', '<Esc>$a', opts)
-- corsur move
keymap('i', '<C-b>', '<Left>', opts)
keymap('i', '<C-f>', '<Right>', opts)
keymap('i', '<C-n>', '<Down>', opts)
keymap('i', '<C-p>', '<Up>', opts)
-- delete all str after cursor
keymap('i', '<C-d>', '<C-o>d$', opts)
-- move hole line
keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', opts)
keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', opts)
-- esc and format
keymap('i', '<C-s>', '<ESC>:w<CR>', { noremap = true })

-- ============================ --
-- ***        Visual        *** --
-- ============================ --

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Fast to move
keymap('v', '<A-h>', '5h', opts)
keymap('v', '<A-j>', '5j', opts)
keymap('v', '<A-k>', '5k', opts)
keymap('v', '<A-l>', '5l', opts)

-- Visual Block --
-- Move text up and down
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)

keymap('v', '.', '$', opts)
keymap('v', ',', '0', opts)

-- ============================ --
-- ***   Plugins keymaps    *** --
-- ============================ --

keymap('n', '<leader>n', '<cmd>Neotree reveal toggle<CR>', opts)

-- Telescope
keymap(
  'n',
  '<Leader>l',
  '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>',
  opts
)
keymap('n', '<Leader>ff', '<cmd>Telescope live_grep<CR>', opts)
keymap('n', '<Leader>d', '<cmd>Telescope diagnostics<CR>', opts)
-- keymap("n", "<leader>s", "<cmd>Telescope git_status<CR>", opts)
keymap('n', '<Leader>g', '<cmd>Telescope git_commits<CR>', opts)
keymap('n', '<Leader>b', '<cmd>Telescope buffers<CR>', opts)
keymap('n', '<Leader>t', '<cmd>TodoTelescope<CR>', opts)
keymap('n', '<leader>c', '<cmd>Telescope current_buffer_fuzzy_find<CR>', opts)
keymap('n', '<Leader>m', '<cmd>Telescope file_browser<CR>', opts)

-- Flybuf
keymap('n', '<Leader>j', '<cmd>FlyBuf<CR>', opts)

-- Quickfix close
keymap('n', '<S-z>', '<cmd>cclose<CR>', opts)
-- keymap("n", "<S-z>", "<cmd>only<CR>", opts)
-- keymap("n", "<S-z>", "<cmd>tabc<CR>", opts)

keymap('n', 'r', '<cmd>ExecutorRun<CR>', opts)
keymap('n', '<leader>r', '<cmd>ExecutorToggleDetail<CR>', opts)

-- Import packages in go files
keymap('n', '<leader>e', ":<cmd>lua require'internal.func'.import()<CR><CR>", opts)

-- Format Python File
keymap('n', '<leader>f', '<cmd>lua require("utils.fmt").format_files()<CR>', opts)

-- Trouble
keymap('n', '<leader>d', '<cmd>TroubleToggle<CR>', opts)

--toggleterm
keymap('n', 'tt', '<cmd>ToggleTerm<CR>', opts)
keymap('n', '<leader>t', '<cmd>ToggleTerm direction=horizontal<CR>', opts)

-- UndotreeToggle
keymap('n', '<C-u>', '<cmd>UndotreeToggle<CR>', opts)

-- Lsp definition
keymap('n', '<Leader>o', '<cmd>Lspsaga outline<CR>', opts)
keymap('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
keymap('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
keymap('n', 'gh', '<cmd>Lspsaga hover_doc<CR>', opts)
keymap('n', 'ga', '<cmd>Lspsaga code_action<CR>', opts)
keymap('n', 'gd', '<cmd>Lspsaga peek_definition<CR>', opts)
keymap('n', 'gp', '<cmd>Lspsaga goto_definition<CR>', opts)
keymap('n', 'gr', '<cmd>Lspsaga rename<CR>', opts)
keymap('n', 'gf', '<cmd>Lspsaga finder<CR>', opts)
keymap('n', 'gi', '<cmd>Lspsaga finder imp<CR>', opts)
keymap('n', '<Leader>dw', '<cmd>Lspsaga show_workspace_diagnostics<CR>', opts)
keymap('n', '<Leader>db', '<cmd>Lspsaga show_buf_diagnostics<CR>', opts)

-- Diffview
keymap('n', 'do', '<cmd>DiffviewOpen<CR>', opts)
keymap('n', 'dc', '<cmd>DiffviewClose<CR>', opts)
keymap('n', 'dh', '<cmd>DiffviewFileHistory<CR>', opts)
keymap('n', '[g', '<cmd>lua require"gitsigns".prev_hunk()<CR>', opts)
keymap('n', ']g', '<cmd>lua require"gitsigns".next_hunk()<CR>', opts)
