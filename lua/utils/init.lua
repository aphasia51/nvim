local M = {}

function M.get_nvim_version()
  local version = vim.version()
  return string.format('%d.%d.%d', version.major, version.minor, version.patch)
end

function M.format_files()
  local ft = vim.bo.filetype
  if ft == 'python' then
    vim.cmd('!black %')
  else
    vim.cmd('GuardFmt')
  end
end

return M
