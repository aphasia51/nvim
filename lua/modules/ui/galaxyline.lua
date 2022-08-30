if vim.g.galaxyline_loaded ~= nil then
	return
end

local gl = require("galaxyline")
local gls = gl.section
local diagnostic = require("galaxyline.provider_diagnostic")

-- VistaPlugin = extension.vista_nearest

local colors = {
	bg = "#2F3445", --#3E4452
	fg = "#8FBCBB",
	black = "#1F253A",
	yellow = "#DC7633",
	cyan = "#70C0BA",
	dimblue = "#83A598",
	green = "#98C379",
	orange = "#FF8800",
	purple = "#C678DD",
	magenta = "#C858E9",
	blue = "#73BA9F",
	red = "#D54E53",
	violet = "#d3869b",
	white = "#C0C0C0",

	lsp = "#EABD7B",
	file_name = "#9E67B2",
}

--  local custom = {
--    fg = "#24292f",
--    bg = "#bbd6ee",
--    black = "#9fc5e8",

--    yellow = "#dbab09",
--    cyan = "#0598bc",
--    green = "#28a745",
--    orange = "#d18616",
--    magenta = "#5a32a3",
--    purple = "#5a32a3",

--    blue = "#0366d6",
--    red = "#d73a49",
--  }

--local function has_file_type()
--	local f_type = vim.bo.filetype
--	if not f_type or f_type == "" then
--		return false
--	end
--	return true
--end

local checkwidth = function()
	local squeeze_width = vim.fn.winwidth(0) / 2
	if squeeze_width > 40 then
		return true
	end
	return false
end
local buffer_not_empty = function()
	if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
		return true
	end
	return false
end

-- insert_left insert item at the left panel
local function insert_left(element)
	table.insert(gls.left, element)
end

-- insert_blank_line_at_left insert blank line with
-- line_bg color.
local function insert_blank_line_at_left()
	insert_left({

		Space = {

			provider = function()
				return " "
			end,

			-- highlight = { colors.bg, colors.bg },
		},
	})
end

-- insert_right insert given item into galaxyline.right
local function insert_right(element)
	table.insert(gls.right, element)
end

-----------------------------------------------------
----------------- start insert ----------------------
-----------------------------------------------------
-- { mode panel start
insert_blank_line_at_left()

insert_left({
	--ViMode = {
	--	icon = function()
	--		local icons = {
	--			n = ' ',
	--			i = ' ',
	--			c = 'ﲵ ',
	--			V = ' ',
	--			[''] = ' ',
	--			v = ' ',
	--			C = 'ﲵ ',
	--			R = '﯒ ',
	--			t = ' ',
	--		}
	--		return icons[vim.fn.mode()]
	--	end,
	--	provider = function()
	--		-- auto change color according the vim mode
	--		local alias = {
	--			n = 'N',
	--			i = 'I',
	--			c = 'C',
	--			V = 'VL',
	--			[''] = 'V',
	--			v = 'V',
	--			C = 'C',
	--			['r?'] = ':CONFIRM',

	--			rm = '--MORE',
	--			R = 'R',
	--			Rv = 'R&V',
	--			s = 'S',
	--			S = 'S',
	--			['r'] = 'HIT-ENTER',
	--			[''] = 'SELECT',
	--			t = 'T',
	--			['!'] = 'SH',
	--		}

	--		local mode_color = {
	--			n = colors.purple,
	--			i = colors.green,
	--			v = colors.blue,
	--			[''] = colors.blue,
	--			V = colors.blue,
	--			c = colors.magenta,
	--			no = colors.red,
	--			s = colors.orange,
	--			S = colors.orange,
	--			[''] = colors.orange,
	--			ic = colors.yellow,
	--			R = colors.purple,
	--			Rv = colors.purple,
	--			cv = colors.red,
	--			ce = colors.red,
	--			r = colors.cyan,
	--			rm = colors.cyan,
	--			['r?'] = colors.cyan,
	--			['!'] = colors.red,
	--			t = colors.red,
	--		}

	--		local vim_mode = vim.fn.mode()
	--		vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim_mode])
	--		return alias[vim_mode]
	--	end,
	--	highlight = { colors.bg, colors.bg },
	--},

	ViMode = {
		provider = function()
			-- auto change color according the vim mode
			local mode_color = {
				n = colors.purple,
				i = colors.green,
				v = colors.blue,
				[""] = colors.blue,
				V = colors.blue,
				c = colors.magenta,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				[""] = colors.orange,
				ic = colors.yellow,
				R = colors.purple,
				Rv = colors.purple,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				["r?"] = colors.cyan,
				["!"] = colors.red,
				t = colors.red,
			}

			local vim_mode = vim.fn.mode()
			local icons = require("core.settings").icons
			vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim_mode])
			return icons[vim_mode]
		end,
		highlight = { bg=colors.bg },
	},
})

insert_blank_line_at_left()

--insert_left({
--  EndingSepara = {
--    provider = function()
--      return " "
--    end,
--    highlight = { colors.bg },
--  },
--})

-- mode panel end}

-- {information panel start
--insert_left({
--  StartSeparate = {
--    provider = function()
--      return " "
--    end,
--    highlight = { colors.bg },
--  },
--})
--
--insert_left({
--  GitIcon = {
--    provider = function()
--      return "  "
--    end,
--    condition = require("galaxyline.providers.vcs").get_git_branch, --check_git_workspace,
--    highlight = { colors.orange, colors.bg },
--  },
--})

--
--insert_left({
--  GitBranch = {
--    provider = "GitBranch",
--    condition = require("galaxyline.providers.vcs").get_git_branch,
--    highlight = { colors.white, colors.bg },
--  },
--})
--
--insert_blank_line_at_left()
--
--local checkwidth = function()
--  local squeeze_width = vim.fn.winwidth(0) / 2
--  if squeeze_width > 40 then
--    return true
--  end
--  return false
--end
--
--insert_left({
--  DiffAdd = {
--    provider = "DiffAdd",

--    condition = checkwidth,

--    icon = "  ",

--    highlight = { colors.green, colors.bg },
--  },
--})
--
--insert_left({

--  DiffModified = {
--    provider = "DiffModified",
--    condition = checkwidth,
--    icon = " ",--"  ",
--    highlight = { colors.orange, colors.bg },
--  },

--})
--
--insert_left({
--  DiffRemove = {
--    provider = "DiffRemove",

--    condition = checkwidth,

--    icon = "  ",

--    highlight = { colors.red, colors.bg },
--  },
--})

--insert_left({
--	EndingSepara = {
--		provider = function()
--			return " "
--		end,
--		highlight = { colors.bg },
--
--		--condition = require("galaxyline.providers.vcs").get_git_branch,
--	},
--})
-- mode panel end}

-- {information panel start
insert_left({
	StartSeparate = {
		provider = function()
			return " "
		end,
		highlight = { colors.bg },
		--condition = require("galaxyline.providers.vcs").get_git_branch,
	},
})

--insert_left({
--  DarkSepara = {
--    provider = function()
--      return "/ "
--    end,
--    condition = require("galaxyline.providers.vcs").get_git_branch,
--    highlight = { colors.blue, colors.bg },
--  },
--})

insert_left({
	FileIcon = {
		provider = "FileIcon",
		condition = buffer_not_empty,

		highlight = {
			require("galaxyline.provider_fileinfo").get_file_icon_color,
			colors.bg,
		},
	},
})

insert_left({
	BufferType = {
		-- provider = "FileName",
		provider = "FilePath",
		-- condition = has_file_type,
		condition = buffer_not_empty,
		highlight = { colors.white, colors.bg },
	},
})

insert_left({
	FileSizeIcon = {
		provider = function()
			local condition = require("galaxyline.provider_fileinfo").get_file_size()
			if condition == "" then
				return " ⛯ No Size "
			else
				return " ⛯ "
			end
		end,
		highlight = { colors.violet, colors.bg },
	},
})

insert_left({
	FileSize = {
		provider = "FileSize",
		condition = function()
			if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
				return true
			end
			return false
		end,
		highlight = { colors.white, colors.bg },
	},
})

local DiagnosticError = diagnostic.get_diagnostic_error
local DiagnosticWarn = diagnostic.get_diagnostic_warn
local DiagnosticHint = diagnostic.get_diagnostic_hint
local DiagnosticInfo = diagnostic.get_diagnostic_info

insert_left({
	DiagnosticError = {
		provider = DiagnosticError,
		icon = "  ",
		highlight = { colors.red, colors.bg },
	},
})

insert_left({
	DiagnosticWarn = {
		provider = DiagnosticWarn,
		condition = checkwidth,
		icon = "  ",
		highlight = { colors.yellow, colors.bg },
	},
})

insert_left({
	DiagnosticInfo = {
		provider = DiagnosticInfo,
		condition = checkwidth,
		highlight = { colors.green, colors.bg },
		icon = "  ",
	},
})

insert_left({
	DiagnosticHint = {
		provider = DiagnosticHint,
		condition = checkwidth,
		highlight = { colors.white, colors.bg },

		icon = "  ",
	},
})

--insert_left({
--  TriangleSeparate = {
--    provider = function()
--      return ""
--    end,
--    highlight = { colors.bg, colors.black },
--  },
--})

--insert_left({

--  BlackSpace = {
--    provider = function()

--      return " "
--    end,
--    highlight = { colors.bg, colors.bg },
--  },
--})

insert_left({
	DarkSepara = {
		provider = function()
			return ""
		end,
		highlight = { colors.bg },
	},
})
-- left information panel end}

-- {information panel start
insert_right({
	StartSeparate = {
		provider = function()
			return " "
		end,
		highlight = { colors.bg },
		condition = require("galaxyline.provider_vcs").get_git_branch,
	},
})

insert_right({
	GitIcon = {
		provider = function()
			return "  "
		end,
		condition = require("galaxyline.provider_vcs").get_git_branch, --check_git_workspace,
		highlight = { colors.orange, colors.bg },
	},
})

insert_right({
	GitBranch = {
		provider = "GitBranch",

		condition = require("galaxyline.provider_vcs").get_git_branch,

		highlight = { colors.white, colors.bg },
	},
})

insert_right({
	BlackSpace = {
		provider = function()
			return " "
		end,
		highlight = { colors.bg, colors.bg },
		condition = require("galaxyline.provider_vcs").get_git_branch,
	},
})

--insert_blank_line_at_left()

insert_right({

	DiffAdd = {
		provider = "DiffAdd",
		condition = checkwidth,
		icon = "  ",
		highlight = { colors.green, colors.bg },
	},
})

insert_right({

	DiffModified = {
		provider = "DiffModified",

		condition = checkwidth,
		icon = "  ", --"  ",
		highlight = { colors.orange, colors.bg },
	},
})

insert_right({
	DiffRemove = {
		provider = "DiffRemove",
		condition = checkwidth,
		icon = "  ",

		highlight = { colors.red, colors.bg },
	},
})

insert_right({
	EndingSepara = {
		provider = function()
			return " "
		end,
		highlight = { colors.bg },

		condition = require("galaxyline.provider_vcs").get_git_branch,
	},
})

insert_right({
	StartSeparate = {
		provider = function()
			return " "
		end,
		highlight = { colors.bg },
		condition = require("galaxyline.provider_lsp").get_lsp_client,
	},
})

insert_right({
	LspIcon = {
		provider = function()
			local condition = require("galaxyline.provider_lsp").get_lsp_client("Lsp")
			if condition == "Lsp" then
				return " ⛒ "
			else
				return "  "
			end
		end,
		-- condition = require('galaxyline.provider_lsp').get_lsp_client,
		highlight = { colors.green, colors.bg },
	},
})

insert_right({
	LspClient = {
		provider = "GetLspClient",
		condition = require("galaxyline.provider_lsp").get_lsp_client,
		highlight = { colors.purple, colors.bg },
	},
})

insert_right({
	EndingSepara = {
		provider = function()
			return " "
		end,
		highlight = { colors.bg },
		condition = require("galaxyline.provider_lsp").get_lsp_client,
	},
})

insert_right({
	Start = {
		provider = function()
			return " "
		end,
		highlight = { colors.bg },
	},
})

insert_right({
	LineInfo = {
		provider = "LineColumn",
		--separator = "  ",
		--separator_highlight = { colors.green, colors.bg },
		highlight = { colors.fg, colors.bg },
	},
})

insert_right({
	RightEndingSepara = {
		provider = function()
			return " "
		end,
		highlight = { colors.bg, colors.black },
	},
})

--insert_right({
--  GetLspClient = {
--    provider = "GetLspClient",
--    separator = " ",--" LSP: ",
--    separator_highlight = { colors.lsp, colors.black },
--    condition = checkwidth,
--    highlight = { colors.yellow, colors.black },
--  },
--})

insert_right({
	PerCent = {
		provider = "LinePercent",
		--separator = " ",
		--separator_highlight = { colors.yellow, colors.black },
		condition = checkwidth,
		highlight = { colors.white, colors.black },
	},
})

--insert_right({
--	FileFormat = {
--
--		provider = "FileFormat",
--		separator = " ",
--		condition = checkwidth,
--		separator_highlight = { colors.violet, colors.black },
--		highlight = { colors.violet, colors.black },
--	},
--})

--insert_right({
--	RightSpace = {
--		provider = function()
--			return " "
--		end,
--		highlight = { colors.black, colors.black },
--	},
--})
