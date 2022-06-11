local au = vim.api.nvim_create_autocmd

-- go settings
au({"BufWritePre"}, { pattern = "*.go", command = ":silent! lua require('go.format').goimport()" })

--vim.o.updatetime = 250
--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.cmd([[autocmd User TelescopePreviewerLoaded setlocal wrap]])

-- alpha
vim.cmd([[autocmd User AlphaReady set laststatus=0 | autocmd BufUnload <buffer> set laststatus=0]])
--vim.cmd([[autocmd CursorMoved lua vim.api.nvim_buf_delete(1, {})]])


