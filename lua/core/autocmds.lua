local au = vim.api.nvim_create_autocmd

-- go settings
au({"BufWritePre"}, { pattern = "*.go", command = ":silent! lua require('go.format').gofmt()" })

--vim.o.updatetime = 250
--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

