-- vim.g.minimap_width = 20
vim.cmd([[nmap <F12> :MinimapToggle<CR>]])
local w = vim.api.nvim_call_function("winwidth", { 0 })
if w > 180 then
  vim.g.minimap_width = 12
elseif w > 120 then
  vim.g.minimap_width = 10
elseif w > 80 then
  vim.g.minimap_width = 7
else
  vim.g.minimap_width = 2
end


vim.g.minimap_auto_start = 1
vim.g.minimap_auto_start_win_enter = 1
