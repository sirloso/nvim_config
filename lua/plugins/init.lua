return {
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
      require("claude-code").setup({
        window = {
          position = "tab split", -- full-editor tab instead of a side/bottom split
          split_ratio = 1.0, -- fill the tab; the plugin resizes by this ratio after splitting
        },
      })
    end,
  },
  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "jq" },
      },
    },
  },

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
      bigfile = {
        size = 1.5 * 1024 * 1024, -- 1.5MB, raise as needed
      },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
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

  -- Mason: install everything listed in installed_mason.txt (synced across machines)
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local file = vim.fn.stdpath("config") .. "/installed_mason.txt"
      local ok, lines = pcall(vim.fn.readfile, file)
      if not ok then
        return
      end
      opts.ensure_installed = opts.ensure_installed or {}
      local seen = {}
      for _, pkg in ipairs(opts.ensure_installed) do
        seen[pkg] = true
      end
      for _, line in ipairs(lines) do
        local pkg = vim.trim(line)
        if pkg ~= "" and not pkg:match("^#") and not seen[pkg] then
          seen[pkg] = true
          table.insert(opts.ensure_installed, pkg)
        end
      end
    end,
  },
}
