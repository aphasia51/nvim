local M = {}

function M.format()
  local cmd = nil
  local file_type = vim.fn.expand("%:e")
  if file_type == 'go' then
    cmd = require('go.format').goimport()
  else
    cmd = vim.lsp.buf.formatting()
  end
  return cmd
end

return M
