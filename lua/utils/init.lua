local M = {}

function M.get_nvim_version()
  local version = vim.version()
  return string.format('%d.%d.%d', version.major, version.minor, version.patch)
end

_G.exec_filetype = function(group)
  group = type(group) == 'string' and { group } or group
  local curbuf = vim.api.nvim_get_current_buf()
  for _, g in ipairs(group) do
    vim.api.nvim_exec_autocmds('FileType', { group = g, pattern = vim.bo[curbuf].filetype })
  end
end

return M
