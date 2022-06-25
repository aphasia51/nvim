local au = vim.api.nvim_create_autocmd

-- go settings
au({"BufWritePre"}, { pattern = "*.go", command = ":silent! lua require('go.format').goimport()" })

--vim.o.updatetime = 250
--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.cmd([[autocmd User TelescopePreviewerLoaded setlocal wrap]])

-- alpha
vim.cmd([[autocmd User AlphaReady set laststatus=0 | autocmd BufUnload <buffer> set laststatus=0]])
--vim.cmd([[autocmd CursorMoved lua vim.api.nvim_buf_delete(1, {})]])

--vim.cmd [[
--  "LSP 提示改为下划线
--  hi DiagnosticUnderlineWarn gui=undercurl
--  hi DiagnosticUnderlineError gui=undercurl
--  hi DiagnosticUnderlineInfo gui=undercurl
--  hi DiagnosticUnderlineHint gui=undercurl
--
--  " 新一行 不带上行的注释
--  augroup newlineWithoutComment
--    autocmd BufEnter * set fo-=c fo-=r fo-=o
--  augroup end
--]]

-- vim.cmd([[autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]])

vim.cmd [[
    augroup SqlsCommands
        autocmd!
        autocmd FileType sql nmap <silent><LocalLeader>rr <Plug>(sqls-execute-query)
        autocmd FileType sql vmap <silent><LocalLeader>rr <Plug>(sqls-execute-query)
        autocmd FileType sql nmap <silent><LocalLeader>rv <Plug>(sqls-execute-query-vertical)
        autocmd FileType sql vmap <silent><LocalLeader>rv <Plug>(sqls-execute-query-vertical)
        autocmd FileType sql nmap <silent><LocalLeader>sd <Plug>(sqls-switch-database)
        autocmd FileType sql nmap <silent><LocalLeader>sc <Plug>(sqls-switch-connection)
    augroup END
]]
