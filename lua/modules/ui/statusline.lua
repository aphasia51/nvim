if vim.g.galaxyline_loaded ~= nil then
  return
end

local gl = require("galaxyline")
local gls = gl.section
local diagnostic = require("galaxyline.provider_diagnostic")

local colors = {
  bg = "#202328",
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
  blue1 = "#5F8BB2",
  blue2 = "#45B39D",
  red = "#D54E53",
  violet = "#d3869b",
  white = "#C0C0C0",

  yellow1 = "#EABD7B",
  file_name = "#9E67B2",
}

local my_icons = require("galaxyline.provider_fileinfo").define_file_icon()
my_icons["mod"] = { colors.blue2, "" }
my_icons["sum"] = { colors.blue1, "" }

local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 36 then
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

-- insert_right insert given item into galaxyline.right
local function insert_right(element)
  table.insert(gls.right, element)
end

local function insert_mid(element)
  table.insert(gls.mid, element)
end

-- insert_blank_line_at_left insert blank line with
-- line_bg color.
local function insert_blank_line_at_left()
  insert_left({
    Space = {
      provider = function()
        return " "
      end,
      highlight = { colors.bg, colors.bg },
    },
  })
end

local function insert_blank_line_at_right()
  insert_right({
    Space = {
      provider = function()
        return " "
      end,
      highlight = { colors.bg, colors.bg },
    },
  })
end

-----------------------------------------------------
----------------- start insert ----------------------
-----------------------------------------------------
insert_left({
  RainbowRed = {
    provider = function()
      return "▊ "
    end,
    highlight = { colors.purple, colors.bg },
  },
})

insert_left({
  ViMode = {
    provider = function()
      local mode_color = {
        n = colors.white,
        i = colors.green,
        v = colors.red,
        [""] = colors.purple,
        V = colors.purple,
        c = colors.yellow1,
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
    highlight = { colors.bg, colors.bg },
  },
})

insert_blank_line_at_left()
insert_blank_line_at_left()

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
    provider = "FileName",
    condition = buffer_not_empty,
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
    icon = "  ",
    highlight = { colors.green, colors.bg },
  },
})

insert_left({
  DiagnosticHint = {
    provider = DiagnosticHint,
    condition = checkwidth,
    icon = "  ",
    highlight = { colors.white, colors.bg },
  },
})

-- insert_blank_line_at_left()

-- insert_left({
--   FileSize = {
--     provider = "FileSize",
--     condition = function()
--       if (vim.fn.empty(vim.fn.expand("%:t")) ~= 1) and checkwidth() then
--         return true
--       end
--       return false
--     end,
--     highlight = { colors.blue2, colors.bg },
--   },
-- })

insert_blank_line_at_left()

insert_left({
  LineInfo = {
    provider = "LineColumn",
    highlight = { colors.fg, colors.bg },
  },
})

insert_blank_line_at_left()

insert_left({
  PerCent = {
    provider = "LinePercent",
    -- condition = checkwidth,
    highlight = { colors.fg, colors.bg },
  },
})

insert_mid({
  GitIcon = {
    provider = function()
      local condition = require("galaxyline.provider_vcs").get_git_branch("GitBranch")
      local check_width = checkwidth()
      if check_width and condition ~= nil then
        return "  "
      end
      return ""
    end,
    highlight = { colors.orange, colors.bg },
  },
})

insert_mid({
  GitBranch = {
    provider = "GitBranch",
    condition = require("galaxyline.provider_vcs").get_git_branch,
    highlight = { colors.white, colors.bg },
  },
})

insert_mid({
  BlackSpace = {
    provider = function()
      return " "
    end,
    highlight = { colors.bg, colors.bg },
    condition = require("galaxyline.provider_vcs").get_git_branch,
  },
})

insert_mid({

  DiffAdd = {
    provider = "DiffAdd",
    condition = checkwidth,
    icon = "  ",
    highlight = { colors.green, colors.bg },
  },
})

insert_mid({
  DiffModified = {
    provider = "DiffModified",
    condition = checkwidth,
    icon = "  ", --"  ",
    highlight = { colors.violet, colors.bg },
  },
})

insert_mid({
  DiffRemove = {
    provider = "DiffRemove",
    condition = checkwidth,
    icon = "  ",
    highlight = { colors.red, colors.bg },
  },
})

insert_blank_line_at_right()

-- insert_right({
--   LspIcon = {
--     provider = function()
--       local condition = require("galaxyline.provider_lsp").get_lsp_client("Lsp")
--       if condition == "Lsp" then
--         return "  Ls:" --" ⛒ "
--       else
--         return "  Ls:"
--       end
--     end,
--     condition = require("galaxyline.provider_lsp").get_lsp_client and checkwidth,
--     highlight = { colors.green, colors.bg },
--   },
-- })

insert_right({
  LspClient = {
    provider = "GetLspClient",
    -- condition = require("galaxyline.provider_lsp").get_lsp_client and checkwidth,
    separator = "[",
    separator_highlight = { colors.white, colors.bg },
    highlight = { colors.white, colors.bg },
  },
})

-- insert_blank_line_at_right()

insert_right({
  FileEncode = {
    provider = "FileEncode",
    -- condition = require("galaxyline.provider_lsp").get_lsp_client and checkwidth,
    separator = "]",
    separator_highlight = { colors.white, colors.bg },
    highlight = { colors.blue2, colors.bg },
  },
})

insert_right({
  RainbowBlue = {
    provider = function()
      return "▊"
    end,
    separator = " ",
    separator_highlight = { colors.bg, colors.bg },
    highlight = { colors.purple, colors.bg },
  },
})
