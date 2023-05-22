-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto toggle hlsearch
local ns = vim.api.nvim_create_namespace("toggle_hlsearch")
local function toggle_hlsearch(char)
  if vim.fn.mode() == "n" then
    local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
    local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end
vim.on_key(toggle_hlsearch, ns)

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "fugitive",
    "git",
    "spectre_panel",
    "startuptime",
    "toggleterm",
    "tsplayground",
    "vim",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

local api = vim.api
local autocmd = vim.api.nvim_create_autocmd
local my_group = vim.api.nvim_create_augroup('AphasiaGroup', {})

-- telescope preview wrap
vim.cmd([[autocmd User TelescopePreviewerLoaded setlocal wrap]])

-- No annotation in new line
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  group = my_group,
  pattern = '*',
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' }
  end,
})

-- last place
vim.api.nvim_create_autocmd('BufReadPost', {
  group = my_group,
  pattern = '*',
  callback = function()
    if vim.fn.line('\'"') > 0 and vim.fn.line('\'"') <= vim.fn.line('$') then
      vim.fn.setpos('.', vim.fn.getpos('\'"'))
      vim.cmd([[silent! foldopen]])
    end
  end,
})

vim.api.nvim_create_user_command('BufferDelete', function()
  ---@diagnostic disable-next-line: missing-parameter
  local file_exists = vim.fn.filereadable(vim.fn.expand('%p'))
  local modified = vim.api.nvim_buf_get_option(0, 'modified')

  if file_exists == 0 and modified then
    local user_choice =
      vim.fn.input('The file is not saved, whether to force delete? Press enter or input [y/n]:')
    if user_choice == 'y' or string.len(user_choice) == 0 then
      autocmd('bd!')
    end
    return
  end

  local force = not vim.bo.buflisted or vim.bo.buftype == 'nofile'

  vim.cmd(force and 'bd!' or string.format('bp | bd! %s', vim.api.nvim_get_current_buf()))
end, { desc = 'Delete the current Buffer while maintaining the window layout' })

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  group = my_group,
  pattern = '*',
  callback = function()
    if vim.bo.filetype == 'NvimTree' then
      local val = '%#WinbarNvimTreeIcon#   %*'

      local path = vim.fn.getcwd()
      local home = os.getenv('HOME')
      path = path:gsub(home, '~')
      val = val .. '%#WinbarPath#' .. path .. '%*'

      api.nvim_set_hl(0, 'WinbarNvimTreeIcon', { fg = '#98be65' })

      api.nvim_set_hl(0, 'WinbarPath', { fg = '#fab795' })
      api.nvim_win_set_option(0, 'winbar', val)
    end
  end,
})

api.nvim_create_autocmd('Filetype', {
  group = my_group,
  pattern = '*.c,*.cpp,*.lua,*.go,*.rs,*.py,*.ts,*.tsx',
  callback = function()
    vim.cmd('syntax off')
  end,
})
