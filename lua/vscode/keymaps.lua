local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options) end
  vim.keymap.set(mode, lhs, rhs, options)
end

map('n', 'L', '$')
map('v', 'L', "$")
map('n', 'H', '^')
map('v', 'H', "^")
map('n', ";", ":")
-- map('n', '{', "{zz")
-- map('n', '}', "}zz")
map('n', "<BS>", ':noh<CR>')

-- Quickly quit
map("n", "Q", "<cmd>q><CR>")

-- Faster move

-- *** Normal *** --

-- Quickly quit
map("n", "Q", "<cmd>q<CR>")

-- Better window navigation
map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")

-- Delect the word under cursor and into insert mode
map("n", "da", "dawi")

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
map("n", "m", ":bnext<CR>")
map("n", "z", ":bprevious<CR>")

-- Insert --
-- Press jk fast to esc
--map("i", "jk", "<ESC>")

-- Fast to move
--map("n", "H", "5h")
map("n", "J", "5j")
map("n", "K", "5k")
--map("n", "L", "5l")

map("n", ".", "$")
map("n", ",", "^")

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Fast to move
map("v", "<A-h>", "5h")
map("v", "<A-j>", "5j")
map("v", "<A-k>", "5k")
map("v", "<A-l>", "5l")

-- Visual Block --
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")

map("v", ".", "$")
map("v", ",", "0")
