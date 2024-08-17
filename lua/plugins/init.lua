return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre' -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "github/copilot.vim",
  },
  {
    "nvim-tree/nvim-tree.lua",
    -- lazy = false,
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
    end,
    lazy = false
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
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("dap-virtual-text").setup()
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults 
        "vim",
        "lua",
        "vimdoc",

        -- web dev 
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "python",
        "rust",
        "go",
        "solidity",
        "json",
        "dockerfile",
        "markdown",
        "sql",
        "proto",
        "graphql",
        -- low level
        "c",
        "cpp"
      },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  {
    "terrortylor/nvim-comment",
    lazy=false,
    config = function()
      require("nvim_comment").setup()
    end
  },
  {
    'ldelossa/nvim-dap-projects'
  },
  {
    'fatih/vim-go'
  }
}
