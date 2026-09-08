return {
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
      local claude_code = require("claude-code")

      claude_code.setup({
        window = {
          position = "vertical",
        },
        keymaps = {
          toggle = {
            normal = false,
            terminal = false,
          },
        },
      })

      -- Instead of a split, open Claude Code by swapping the current
      -- window's buffer (and swap back on toggle-off).
      local function toggle_claude_in_place()
        local bufnr = claude_code.claude_code.instances[claude_code.claude_code.current_instance]

        if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
          if vim.api.nvim_get_current_buf() == bufnr then
            vim.cmd("buffer #")
          else
            vim.cmd("buffer " .. bufnr)
            vim.cmd("startinsert")
          end
          return
        end

        -- First run: let the plugin create the terminal (it will open a
        -- split), then close that split and take over the buffer here.
        local origin_win = vim.api.nvim_get_current_win()
        claude_code.toggle()

        vim.schedule(function()
          local new_bufnr = claude_code.claude_code.instances[claude_code.claude_code.current_instance]
          if not new_bufnr then
            return
          end
          local wins = vim.fn.win_findbuf(new_bufnr)
          for _, win in ipairs(wins) do
            if win ~= origin_win then
              vim.api.nvim_win_close(win, true)
            end
          end
          vim.api.nvim_set_current_win(origin_win)
          vim.cmd("buffer " .. new_bufnr)
          vim.cmd("startinsert")
        end)
      end

      vim.keymap.set({ "n" }, "<C-,>", toggle_claude_in_place, { desc = "Toggle Claude Code (in place)" })
      vim.keymap.set("t", "<C-,>", toggle_claude_in_place, { desc = "Toggle Claude Code (in place)" })
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
}
