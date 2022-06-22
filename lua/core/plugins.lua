-- vim:foldmethod=marker
---@diagnostic disable: different-requires
-- Automatically download packer.nvim if it doesn't exist
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
  vim.cmd "packadd packer.nvim"
end

-- Automatically run :PackerCompile after every time this file is changed
vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "packer_user_config",
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile",
})

local packer = require "packer"

-- Use packer.nvim to manage all of the plugins

return packer.startup {
  function(use)
    use { "wbthomason/packer.nvim" }

    -- *** editor *** --

    use {
      "jose-elias-alvarez/null-ls.nvim",
      config = function ()
        require "editor.null-ls"
      end,
      after = { "nvim-lspconfig" },
    }
    use {
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
      ft = "markdown",
      config= function()
        vim.g.mkdp_browser = "firefox"
        vim.g.mkdp_open_to_the_world = 1
        vim.g.mkdp_port = "57843"
        vim.g.mkdp_page_title = 'MD-Aphasia'
      end,
    }
    --use {
    --  "davidgranstrom/nvim-markdown-preview",
    --  ft = { "markdown" },
    --  cmd = { "MarkdownPreview" },
    --  config = function ()
    --    vim.g.nvim_markdown_preview_theme = 'solarized-light'
    --  end
    --}

    use {
      "neovim/nvim-lspconfig",
      config = function()
        require "editor.lspconfig"
      end,
      event = { "BufRead", "BufNewFile" },
      after = { "impatient.nvim" },
    }

    use {
      "williamboman/nvim-lsp-installer",
      after = { "nvim-lspconfig", "cmp-nvim-lsp" },
    }

    use {
      'windwp/nvim-autopairs',
      config = function ()
        require "editor.autopairs"
      end,
    }


    use {
      "rafamadriz/friendly-snippets",
      event = { "InsertEnter", "CmdlineEnter" },
      --after = { "nvim-lspconfig", "nvim-cmp" }
    }

      -- the completion core
    use {
      "hrsh7th/nvim-cmp",
      after = { "vim-vsnip" },
      --event = "InsertEnter",
      config = function()
        require "editor.cmp"
      end,
    }

      -- completion source for system path
    use {
      "hrsh7th/cmp-path",
      after = { "nvim-cmp" }
    }

      -- completion source for lspconfig

    use {
      "hrsh7th/cmp-nvim-lsp",
      --event = { "BufReadPre" },
      after = { "nvim-cmp" }
    }
      -- completion source for word in current buffer
    use {
      "hrsh7th/cmp-buffer", after = { "nvim-cmp" }
    }

    --  -- completion source for vsnip snippet plugin
    use {
      "hrsh7th/cmp-vsnip",
      after = { "nvim-cmp" }
    }

      -- the snippet core
    use {
      "hrsh7th/vim-vsnip",
      after = { "friendly-snippets" }
    }

    use {
      "hrsh7th/cmp-cmdline",
      after = { "nvim-cmp" }
    }

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("editor.trouble")
      end,
      cmd = "TroubleToggle"
    }

    use {
      "ray-x/go.nvim",
      ft = { "go" },
      config = function ()
        require "tools.go"
      end,
      event = { "BufRead" }
    }

    use {
      "glepnir/smartinput.nvim",
      ft = "go",
      config = function()
        require "editor.smart_input"
      end
    }

    use {
      "anuvyklack/pretty-fold.nvim",
      requires = { "anuvyklack/nvim-keymap-amend" },
      event = { "BufReadPre" },
      config = function ()
        require "editor.pretty-fold"
      end
    }

    -- *** UI *** --
    use {
      "onsails/lspkind-nvim",
      config = function()
        require "ui.lspkind"
      end,
      event = "InsertEnter"
    }

    use {
      "ray-x/lsp_signature.nvim",
      after = { "nvim-lspconfig" },
    }

    use {
      "glepnir/lspsaga.nvim",
      branch = "features",
      after = { "nvim-lspconfig", "nvim-cmp" },
    }

    use {
	    "nvim-treesitter/nvim-treesitter",
	    --event = { "BufReadPre", "BufNewFile" },
      --run = ":TSUpdate",
	    config = function ()
	        require "ui.treesitter"
	    end,
      --after = { "impatient" }
    }

    use {
      "kyazdani42/nvim-web-devicons",
      after = { "impatient.nvim" },
    }

    -- Theme
    use {
      "glepnir/zephyr-nvim",
      config = function ()
        require "ui.theme"
      end,
      --after = "nvim-treesitter" with this, icons are no color
    }
    use {
      "akinsho/nvim-bufferline.lua",
      config = function()
        require("ui.bufferline")
      end,
      --event = "BufReadPre",
      after = { "nvim-web-devicons" },
    }

    use {
      "glepnir/galaxyline.nvim",
      config = function ()
        require "ui.galaxyline"
      end,
      event = { "BufRead", "BufNewFile" },
      requires = { 'kyazdani42/nvim-web-devicons' },
    }

    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function ()
        require "ui.indent_blankline"
      end,
      event = { "BufRead", "BufNewFile" },
    }

    -- *** Tools *** --

    use {
      "akinsho/toggleterm.nvim",
      config = function ()
        require "tools.toggleterm"
      end
    }

    use {
      "numToStr/Comment.nvim",
      event = "BufRead",
      config = function ()
        require "editor.comment"
      end
    }

    use {
      "lewis6991/impatient.nvim",
      config = function ()
        require "tools.impatient"
      end
    }
    use {
      "nvim-lua/plenary.nvim",
      after = { "impatient.nvim" },
    }

    use {
      "rainbowhxch/accelerated-jk.nvim",
      --after = { "impatient.nvim" },
      --event = { "BufReadPre", "BufNewFile" }
    }

    --use {
    --  --"goolord/alpha-nvim",
    --  "glepnir/dashboard-nvim",
    --  config = function()
    --    require("tools.dashboard")
    --  end,
    --}

    use {
      "ethanholz/nvim-lastplace",
      config = function ()
        require "tools.lastplace"
      end
    }

    use {
      "norcalli/nvim-colorizer.lua",
      config = function ()
        require "tools.colorizer"
      end,
      event = { "BufReadPre" }
    }

    use {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        config = function ()
            require "tools.telescope"
        end,
        --requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter"}
    }

    --use {
    --  "nathom/filetype.nvim",
    --  config = function ()
    --    require "tools.filetype"
    --  end
    --}

    use {
      "simrat39/symbols-outline.nvim",
      cmd = "SymbolsOutline",
      config = function ()
        require "tools.symbolsoutline"
      end
    }

    --use {
    --  'kevinhwang91/nvim-bqf',
    --  config = function ()
    --    require "tools.bqf"
    --  end
    --}

    use {
      "skywind3000/asyncrun.vim",
      cmd = { "AsyncRun" }
    }

    use {
      "skywind3000/asynctasks.vim",
      requires = "skywind3000/asyncrun.vim",
      cmd = { "AsyncTask" },
      config = function ()
        vim.g.asyncrun_open = 7
        vim.g.asynctasks_term_rows = 8
        vim.g.asynctasks_term_cols = 80
      end
    }

    use {
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("tools.nvim_tree")
      end,
      --requires = {
      --  'kyazdani42/nvim-web-devicons',
      --},
      after = { "nvim-web-devicons" },
      cmd = {
        "NvimTreeFindFile",
        "NvimTreeToggle",
        "NvimTreeRefresh"
      },
    }

    use {
      "dstein64/vim-startuptime",
      cmd = { "StartupTime" }
    }

  end
}
