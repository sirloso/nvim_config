-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "rust_analyzer",
  "clangd",
  "pyright",
  "cmake",
  "dockerls",
  "gopls",
  "autotools_ls",
  "sqlls",
  "taplo",
  "graphql",
  "ast_grep",
  "eslint",
  "graphql",
  "html",
  "htmx",
  "lua_ls",
  "sqlls",
  "solidity_ls"
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.clangd.setup {
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }, -- Remove 'proto' from this list
}

local function get_python_path()
  -- Check for UV's default .venv location
  local uv_venv = vim.fn.getcwd() .. '/.venv/bin/python'
  if vim.fn.executable(uv_venv) == 1 then
    return uv_venv
  end

  -- Check for traditional venv location
  local venv_path = vim.fn.getcwd() .. '/venv/bin/python'
  if vim.fn.executable(venv_path) == 1 then
    return venv_path
  end

  -- Fallback to system Python
  return vim.fn.exepath("python3") or vim.fn.exepath("python")
end

-- Configure Pyright with venv support
-- Pyright is the stable, mature choice for Python type checking
lspconfig.pyright.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  before_init = function(_, config)
    local python_path = get_python_path()
    config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
      python = {
        pythonPath = python_path,
      }
    })
  end,
  settings = {
    python = {
      pythonPath = get_python_path(),
      analysis = {
        typeCheckingMode = "basic", -- or "standard" or "strict"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      }
    }
  }
}
