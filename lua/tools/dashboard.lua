vim.cmd [[packadd nvim-tree.lua]]
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
" ┏━━━┓━━━━┏┓━━━━━━━━━━━━━━━━━━ ",
" ┃┏━┓┃━━━━┃┃━━━━━━━━━━━━━━━━━━ ",
" ┃┃━┃┃┏━━┓┃┗━┓┏━━┓━┏━━┓┏┓┏━━┓━ ",
" ┃┗━┛┃┃┏┓┃┃┏┓┃┗━┓┃━┃━━┫┣┫┗━┓┃━ ",
" ┃┏━┓┃┃┗┛┃┃┃┃┃┃┗┛┗┓┣━━┃┃┃┃┗┛┗┓ ",
" ┗┛━┗┛┃┏━┛┗┛┗┛┗━━━┛┗━━┛┗┛┗━━━┛ ",
" ━━━━━┃┃━━━━━━━━━━━━━━━━━━━━━━ ",
" ━━━━━┗┛━━━━━━━━━━━━━━━━━━━━━━ ",
}

local function getGreeting(name)
	local tableTime = os.date("*t")
	local hour = tableTime.hour
	local greetingsTable = {
		[1] = "  It's bedtime",
		[2] = "  Good morning",
		[3] = "  Good afternoon",
		[4] = "  Good evening",
		[5] = "望 Good night",
	}
	local greetingIndex = ""
	if hour == 23 or hour < 7 then
		greetingIndex = 1
	elseif hour < 12 then
		greetingIndex = 2
	elseif hour >= 12 and hour < 18 then
		greetingIndex = 3
	elseif hour >= 18 and hour < 21 then
		greetingIndex = 4
	elseif hour >= 21 then
		greetingIndex = 5
	end
	return greetingsTable[greetingIndex] .. ", " .. name
end

local userName = "Emuel"
local greeting = getGreeting(userName)

local greetHeading = {
	type = "text",
	val = greeting,
	opts = {
		position = "center",
		hl = "String",
	},
}

local function footer()
  local total_plugins = #vim.tbl_keys(packer_plugins)
  --local datetime = os.date("📆 %Y-%m-%d  %H:%M:%S")
  return "  🛵 Loaded "
    .. total_plugins
    .. " plugins\n"
    .. "\n"
    --.. datetime
    --.. "  📢 Nvim -v "
    --.. vim.version().major
    --.. "."
    --.. vim.version().minor
    --.. "."
    --.. vim.version().patch
end

-- Set menu
dashboard.section.buttons.val = {
	dashboard.button("f", " 🔭  Find file", ":Telescope find_files<CR>"),
	dashboard.button("p", " 🤿  Find word", ":Telescope live_grep<CR>"),
	dashboard.button("r", " 📝  Recent", ":Telescope oldfiles<CR>"),
	dashboard.button("q", " 🚫  Quit NVIM", ":qa<CR>"),
}

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Constant"

alpha.setup(dashboard.opts)

--dashboard.opts.opts.noautocmd = true


