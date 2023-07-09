local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local rounded_left = {
  provider = function()
    return ''
  end,
  hl = { fg = '#01394a' },
}

local rounded_right = {
  provider = function()
    return ''
  end,
  hl = { fg = '#01394a' },
}

local ViMode = {
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()
  end,
  static = {
    mode_names = {
      ['n'] = 'Normal',
      ['no'] = 'O-Pending',
      ['nov'] = 'O-Pending',
      ['noV'] = 'O-Pending',
      ['no\x16'] = 'O-Pending',
      ['niI'] = 'Normal',
      ['niR'] = 'Normal',
      ['niV'] = 'Normal',
      ['nt'] = 'Normal',
      ['ntT'] = 'Normal',
      ['v'] = 'Visual',
      ['vs'] = 'Visual',
      ['V'] = 'V-Line',
      ['Vs'] = 'V-Line',
      ['\x16'] = 'V-Block',
      ['\x16s'] = 'V-Block',
      ['s'] = 'Select',
      ['S'] = 'S-Line',
      ['\x13'] = 'S-Block',
      ['i'] = 'Insert',
      ['ic'] = 'Insert',
      ['ix'] = 'Insert',
      ['R'] = 'Replace',
      ['Rc'] = 'Replace',
      ['Rx'] = 'Replace',
      ['Rv'] = 'V-Replace',
      ['Rvc'] = 'V-Replace',
      ['Rvx'] = 'V-Replace',
      ['c'] = 'Command',
      ['cv'] = 'Ex',
      ['ce'] = 'Ex',
      ['r'] = 'Replace',
      ['rm'] = 'More',
      ['r?'] = 'Confirm',
      ['!'] = 'Shell',
      ['t'] = 'Terminal',
    },
    mode_colors = {
      n = 'red',
      i = 'green',
      v = 'cyan',
      V = 'cyan',
      ['\22'] = 'cyan',
      c = 'orange',
      s = 'purple',
      S = 'purple',
      ['\19'] = 'purple',
      R = 'orange',
      r = 'orange',
      ['!'] = 'red',
      t = 'red',
    },
  },
  provider = function(self)
    return '%2(' .. self.mode_names[self.mode] .. '%)'
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { bg = '#01394a', fg = self.mode_colors[mode], bold = true }
  end,
  update = {
    'ModeChanged',
    pattern = '*:*',
    callback = vim.schedule_wrap(function()
      vim.cmd('redrawstatus')
    end),
  },
}

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon, self.icon_color =
      require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. ' ')
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileName = {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ':.')
    if filename == '' then
      return '[No Name]'
    end
    if not conditions.width_percent_below(#filename, 0.25) then
      filename = vim.fn.pathshorten(filename)
    end
    return filename
  end,
  hl = { fg = 'grey' },
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = ' [+] ',
    hl = { fg = 'white' },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = '  ',

    hl = { fg = 'orange' },
  },
}

local FileNameModifer = {
  hl = function()
    if vim.bo.modified then
      return { fg = 'orange', bold = true, force = true }
    end
  end,
}

FileNameBlock = utils.insert(
  FileNameBlock,
  FileIcon,
  utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
  FileFlags,
  { provider = '%<' } -- this means that the statusline is cut here when there's not enough space
)

local Ruler = {
  provider = '%7(%l:%3L%) %P',
  hl = { fg = '#e95678' },
}

local Diagnostics = {
  condition = conditions.has_diagnostics,
  update = { 'DiagnosticChanged', 'BufEnter' },
  on_click = {
    callback = function()
      require('trouble').toggle({ mode = 'document_diagnostics' })
    end,
    name = 'heirline_diagnostics',
  },
  static = {},
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  {
    provider = function(self)
      return self.errors > 0 and (' ' .. self.errors .. ' ')
    end,
    hl = 'DiagnosticError',
  },
  {
    provider = function(self)
      return self.warnings > 0 and (' ' .. self.warnings .. ' ')
    end,
    hl = 'DiagnosticWarn',
  },
  {
    provider = function(self)
      return self.info > 0 and (' ' .. self.info .. ' ')
    end,
    hl = 'DiagnosticInfo',
  },
  {
    provider = function(self)
      return self.hints > 0 and (' ' .. self.hints)
    end,
    hl = 'DiagnosticHint',
  },
}

local LSPActive = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },
  provider = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      table.insert(names, server.name)
    end
    return '[' .. table.concat(names, ' ') .. ']'
  end,
  hl = { fg = 'green', bold = true },
}

local Git = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0
      or self.status_dict.removed ~= 0
      or self.status_dict.changed ~= 0
  end,

  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ('  ' .. count)
    end,
    hl = { fg = '#98be65' },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ('  ' .. count)
    end,
    hl = { fg = '#61afef' },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ('  ' .. count)
    end,
    hl = { fg = '#e95678' },
  },
  {
    provider = function(self)
      return '  ' .. self.status_dict.head
    end,
    hl = { bold = true, fg = '#CBA6F7' },
  },
}

local FileEncoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
    return enc and enc:upper()
  end,
  hl = { bg = 'NONE' },
}

local Align = { provider = '%=', hl = { bg = 'NONE' } }
local Space = { provider = ' ', hl = { bg = 'NONE' } }

local conf_statusline = {
  rounded_left,
  ViMode,
  rounded_right,
  Space,
  FileNameBlock,
  Space,
  Ruler,
  Align,
  Diagnostics,
  Align,
  LSPActive,
  Git,
  Space,
  FileEncoding,
}

require('heirline').setup({
  statusline = conf_statusline,
})
