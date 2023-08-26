require('config.options')
require('config.lazy')
require('config.autocmds')
require('config.keymaps')

-- local function get_buffer_tab_count()
--     local buffer_count = vim.fn.len(vim.fn.tabpagebuflist(vim.fn.tabpagenr()))
--     local tab_count = vim.fn.tabpagenr('$')
--     return "Buffers: " .. buffer_count .. " | Tabs: " .. tab_count
-- end
--
-- local function status_line()
--   local winbar = "!require('lspsaga.symbol.winbar').get_bar()"
--   local right_align = '%='
--   local line_no = '%10([%l/%L%)]'
--   local pct_thru_file = '%5p%%'
--
--   return string.format('%s%s%s%s%s',winbar, right_align, get_buffer_tab_count(), line_no, pct_thru_file)
-- end
--
--
-- vim.opt.winbar = status_line()
-- demo
