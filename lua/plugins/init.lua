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
    lazy = false
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    opts = {
      view = {
        side = "right"
      }
    }
  },
  {
    "hedyhli/outline.nvim",
    cmd = {"Outline","OutlineOpen"},
    keys = {
      {"n", "<C><S>o", ":OutlineOpen<CR>"},
      {"n", "<leader>Oc", ":OutlineClose<CR>"}
    },
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
}
