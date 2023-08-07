local M = {}

function M.format_files()
  local ft = vim.bo.filetype
  if ft == 'python' then
    vim.cmd('!black %')
  else
    vim.cmd('GuardFmt')
  end
end

return M
