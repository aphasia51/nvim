local au = vim.api.nvim_create_autocmd

-- go settings
au({"BufWritePre"}, { pattern = "*.go", command = ":silent! lua require('go.format').goimport()" })

--vim.o.updatetime = 250
--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.cmd([[autocmd User TelescopePreviewerLoaded setlocal wrap]])

-- alpha
vim.cmd([[autocmd User AlphaReady set laststatus=0 | autocmd BufUnload <buffer> set laststatus=0]])
--vim.cmd([[autocmd CursorMoved lua vim.api.nvim_buf_delete(1, {})]])

vim.cmd [[
  hi DiffAdd ctermbg=4 guibg=#283b4D guifg=NONE
  hi DiffDelete ctermfg=12 ctermbg=6 guibg=#3F2D3D  guifg=NONE
  hi DiffChange ctermbg=5 guibg=#272D43 guifg=NONE
  hi DiffText cterm=bold ctermbg=9 guibg=#394b70 guifg=NONE
  hi Folded guibg=#2c313a
  hi Search guibg=#515C6A guifg=NONE
  hi IncSearch guibg=#515C6A guifg=NONE
]]
