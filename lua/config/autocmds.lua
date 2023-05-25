local api = vim.api
-- local autocmd = vim.api.nvim_create_autocmd
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

vim.api.nvim_create_autocmd('TextYankPost', {
  group = my_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 400 })
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

api.nvim_create_autocmd('Filetype', {
  group = my_group,
  pattern = '*.c,*.cpp,*.lua,*.go,*.rs,*.py,*.ts,*.tsx',
  callback = function()
    vim.cmd('syntax off')
  end,
})

vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  pattern = { '*' },
  callback = function()
    local disable_file_types = {
      'toggleterm',
      'translate',
    }
    local directory = vim.fn.fnamemodify(vim.fn.expand('%'), ':p:h')
    if
      vim.fn.isdirectory(directory) == 0
      and not vim.tbl_contains(disable_file_types, vim.bo.filetype)
    then
      vim.fn.mkdir(directory, 'p')
    end
    vim.cmd('silent! wall')
  end,
  nested = true,
})
