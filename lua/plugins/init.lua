return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre' -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  }, {
    "github/copilot.vim",
    lazy = false
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    opts = {
      view = {
        side = "right"
      },
      git = {
        ignore = false
      }
    }
  },
  {
    "hedyhli/outline.nvim",
    cmd = {"Outline","OutlineOpen"},
    config = function()
      require("outline").setup()
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    require = {"mfussenegger/nvim-dap","nvim-neotest/nvim-nio"},
    config = function()
      require("dapui").setup()
    end
  },
  {
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup()
    end
  },
  {
    "nvim-neotest/nvim-nio",
    config = function()
      require("nvim-nio").setup()
    end
  },
  {
    "ldelossa/litee.nvim",
    config = function()
      require("litee.lib").setup()
    end
  },
  {
    "ldelossa/litee-calltree.nvim",
    config = function()
      require("litee.calltree").setup()
    end
  },
  { 'alexghergh/nvim-tmux-navigation',
    config = function()
      require'nvim-tmux-navigation'.setup {
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          last_active = "<C-\\>",
          next = "<C-Space>",
        }
      }
    end
  },
  {
    'jubnzv/virtual-types.nvim',
    config = function ()
      require('virtual-types').setup()
    end
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup()
    end,
    require = {
      'nvim-treesitter/nvim-treesitter',
    }
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  }
}
