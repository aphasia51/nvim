local M = {}

function M.get_nvim_version()
  local version = vim.version()
  return string.format("%d.%d.%d", version.major, version.minor, version.patch)
end

return M
