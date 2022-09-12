local cache_dir = os.getenv("HOME") .. "/.cache/nvim/"

vim.opt.directory = cache_dir .. "swag/"
vim.opt.undodir = cache_dir .. "undo/"
vim.opt.backupdir = cache_dir .. "backup/"
vim.opt.viewdir = cache_dir .. "view/"
vim.opt.spellfile = cache_dir .. "spell/en.uft-8.add"
-- utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"
vim.o.scrolloff = 6
vim.o.sidescrolloff = 6
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true
vim.wo.signcolumn = "yes:1"
vim.wo.colorcolumn = "80"
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
-- >> << 时移动长度
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
-- 空格替代tab
vim.o.expandtab = true
vim.bo.expandtab = true
-- 新行对齐当前行
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.cmdheight = 1
vim.opt.cmdwinheight = 5
vim.opt.equalalways = false
vim.opt.display = "lastline"
vim.opt.pumblend = 10
vim.opt.winblend = 10
-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true
-- 折行
vim.wo.wrap = true
-- 光标在行首尾时<Left><Right>可以跳到下一行
vim.o.whichwrap = "<,>,[,]"
-- 允许隐藏被修改过的buffer
vim.o.hidden = true
-- Fold
vim.opt.foldenable = true
vim.opt.foldlevelstart = 1
vim.opt.foldcolumn = "0"

vim.o.mouse = "a"
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.opt.undofile = true
-- smaller updatetime
vim.o.updatetime = 300
vim.opt.magic = true
vim.o.timeoutlen = 500
vim.o.splitbelow = true
vim.o.splitright = true
vim.g.completeopt = "menu,menuone,noselect,noinsert"
vim.opt.termguicolors = true
vim.o.list = true
vim.opt.listchars = "tab:  ,nbsp:+,trail:▫,extends:→,precedes:←"
vim.o.fillchars = "vert:|,fold: "
vim.o.wildmenu = true
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.pumheight = 10
vim.o.showtabline = 0
vim.o.showmode = false
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.o.iminsert = 0
vim.o.grepprg = "rg --vimgrep"
vim.o.grepformat = "%f:%l:%c:%m"
vim.opt.runtimepath:remove({ "/etc/xdg/nvim", "/etc/xdg/nvim/after", "/usr/share/vim/vimfiles" })
vim.opt.wildignore:append("*/.git/*,*/__pycache__/*,*.pyc,*/node_modules/*," .. "*.jpg,*.bmp,*.gif,*.png,*.jpeg")

vim.g.python_host_skip_check = 1
vim.g.python3_host_skip_check = 1
vim.g.python_host_prog = "/usr/bin/python"
vim.g.python3_host_prog = "/usr/sbin/python3"
vim.g.loaded_python_provider = 0

vim.g.vsnip_snippet_dir = vim.fn.expand("~/.config/nvim/vsnip")
