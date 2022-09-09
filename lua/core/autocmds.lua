-- local au = vim.api.nvim_create_autocmd
local api = vim.api
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
			vim.cmd("silent! foldopen")
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
			vim.cmd("bd!")
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
