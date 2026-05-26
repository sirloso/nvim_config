return {
  -- Copilot
  { "github/copilot.vim" },

  -- Formatting
  -- {
  --   "stevearc/conform.nvim",
  --   config = function()
  --     require("configs.conform")
  --   end,
  -- },

  -- Outline
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    config = true,
  },

  -- LazyGit
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = { { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- File explorer (keeping yours over LazyVim's neo-tree)
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = { side = "right" },
      git = { ignore = false },
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {},
        cssls = {},
        rust_analyzer = {},
        clangd = {},
        pyright = {},
        cmake = {},
        dockerls = {},
        gopls = {},
        autotools_ls = {},
        sqlls = {},
        taplo = {},
        graphql = {},
        ast_grep = {},
        eslint = {},
        htmx = {},
        lua_ls = {},
        solidity_ls = {},
        tsserver = {},
        ruff = {},
      },
    },
  },

  -- LSPSaga
  {
    "nvimdev/lspsaga.nvim",
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      lightbulb = {
        enable = false,
      },
    },
  },

  -- Virtual types
  -- {
  --   "jubnzv/virtual-types.nvim",
  --   config = function()
  --     require("virtual-types").setup()
  --   end,
  -- },

  -- Litee call tree
  {
    "ldelossa/litee.nvim",
    config = function()
      require("litee.lib").setup()
    end,
  },
  {
    "ldelossa/litee-calltree.nvim",
    dependencies = { "ldelossa/litee.nvim" },
    config = function()
      require("litee.calltree").setup()
    end,
  },

  -- DAP core
  {
    "mfussenegger/nvim-dap",
  },
  {
    "nvim-neotest/nvim-nio",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup({
        dap_configurations = {
          {
            type = "go",
            name = "Debug test (package)",
            request = "launch",
            mode = "test",
            program = "${fileDirname}", -- package dir, not the file
          },
        },
      })
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
  },
  {
    "ldelossa/nvim-dap-projects",
  },

  -- Go
  { "fatih/vim-go" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
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
        "c",
        "cpp",
      },
    },
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            layout = {
              layout = {
                position = "right",
              },
            },
          },
        },
      },
    },
  },
}
