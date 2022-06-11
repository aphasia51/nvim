local au = vim.api.nvim_create_autocmd

-- go settings
au({"BufWritePre"}, { pattern = "*.go", command = ":silent! lua require('go.format').goimport()" })

--vim.o.updatetime = 250
--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.cmd([[autocmd User TelescopePreviewerLoaded setlocal wrap]])
vim.cmd([[autocmd FileType alpha set laststatus=0 | autocmd BufUnload <buffer> set laststatus=1]])
