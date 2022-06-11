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

local function footer()
  local total_plugins = #vim.tbl_keys(packer_plugins)
  --local datetime = os.date("📆 %d-%m-%Y  🕐 %H:%M:%S")
  return "  🛵 "
    .. total_plugins
    .. " plugins"
    .. "  📢 Nvim -v "
    .. vim.version().major
    .. "."
    .. vim.version().minor
    .. "."
    .. vim.version().patch
end

local function pick_color()
  local colors = { "String", "Identifier", "Keyword", "Number" }
  return colors[math.random(#colors)]
end

-- Set menu
dashboard.section.buttons.val = {
	dashboard.button("f", " 🔭  Find file", ":Telescope find_files<CR>"),
	dashboard.button("p", " 🤿  Find word", ":Telescope live_grep<CR>"),
	dashboard.button("r", " 📝  Recent", ":Telescope oldfiles<CR>"),
	dashboard.button("q", " 🚫  Quit NVIM", ":qa<CR>"),
}

dashboard.section.header.opts.hl = pick_color()

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Constant"

alpha.setup(dashboard.opts)
