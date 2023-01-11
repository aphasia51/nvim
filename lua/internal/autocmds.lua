-- local au = vim.api.nvim_create_autocmd
local api = vim.api
local autocmd = vim.api.nvim_create_autocmd
local my_group = vim.api.nvim_create_augroup("AphasiaGroup", {})

-- telescope preview wrap
vim.cmd([[autocmd User TelescopePreviewerLoaded setlocal wrap]])

-- alpha
-- vim.cmd([[autocmd User AlphaReady set laststatus=0 | autocmd BufUnload <buffer> set laststatus=2]])

-- No annotation in new line
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = my_group,
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
  end,
})

-- last place
vim.api.nvim_create_autocmd("BufReadPost", {
  group = my_group,
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.fn.setpos(".", vim.fn.getpos("'\""))
      vim.cmd [[silent! foldopen]]
    end
  end,
})

vim.api.nvim_create_user_command("BufferDelete", function()
  ---@diagnostic disable-next-line: missing-parameter
  local file_exists = vim.fn.filereadable(vim.fn.expand("%p"))
  local modified = vim.api.nvim_buf_get_option(0, "modified")

  if file_exists == 0 and modified then
    local user_choice = vim.fn.input("The file is not saved, whether to force delete? Press enter or input [y/n]:")
    if user_choice == "y" or string.len(user_choice) == 0 then
      autocmd("bd!")
    end
    return
  end

  local force = not vim.bo.buflisted or vim.bo.buftype == "nofile"

  vim.cmd(force and "bd!" or string.format("bp | bd! %s", vim.api.nvim_get_current_buf()))
end, { desc = "Delete the current Buffer while maintaining the window layout" })

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = my_group,
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "NvimTree" then
      local val = "%#WinbarNvimTreeIcon#   %*"

      local path = vim.fn.getcwd()
      local home = os.getenv("HOME")
      path = path:gsub(home, "~")
      val = val .. "%#WinbarPath#" .. path .. "%*"

      api.nvim_set_hl(0, "WinbarNvimTreeIcon", { fg = "#98be65" })

      api.nvim_set_hl(0, "WinbarPath", { fg = "#fab795" })
      api.nvim_win_set_option(0, "winbar", val)
    end
  end,
})

api.nvim_create_autocmd("Filetype", {
  group = my_group,
  pattern = "*.c,*.cpp,*.lua,*.go,*.rs,*.py,*.ts,*.tsx",
  callback = function()
    vim.cmd("syntax off")
  end,
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = my_group,
--   pattern = "*.go",
--   callback = function()
--     if not packer_plugins["lspconfig"] then
--       return
--     end
--     local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
--     params.context = { only = { "source.organizeImports" } }
--
--     local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
--     for _, res in pairs(result or {}) do
--       for _, r in pairs(res.result or {}) do
--         if r.edit then
--           vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
--         else
--           vim.lsp.buf.execute_command(r.command)
--         end
--       end
--     end
--   end,
-- })

-- 反卷小助手
-- local work_time = 1000 * 60 * 20
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   group = my_group,
--   pattern = "*",
--   callback = function()
--     local timer = vim.loop.new_timer()
--     timer:start(
--       work_time,
--       work_time,
--       vim.schedule_wrap(function()
--         vim.notify("别TM的卷了, 停下来歇会儿")
--       end)
--     )
--   end,
-- })
