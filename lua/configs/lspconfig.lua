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
  "deno_ls",
  "buf_ls",
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

-- Helper function to get Deno path
local function get_deno_cmd()
  local handle = io.popen("which deno")
  local result = handle:read("*a")
  handle:close()
  -- Remove trailing newline
  result = result:gsub("[\n\r]", "")
  return result
end

-- Get Deno path
local deno_path = get_deno_cmd()

lspconfig.denols.setup {
  cmd = { deno_path, "lsp" },  -- Specify the exact path to your Deno binary
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- Disable TypeScript server if it's causing issues
    if client.name == "tsserver" then
      client.stop()
    end
  end,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  init_options = {
    enable = true,
    lint = true,
    unstable = false,
    suggest = {
      imports = {
        hosts = {
          ["https://deno.land"] = true,
          ["https://cdn.nest.land"] = true,
          ["https://crux.land"] = true
        }
      }
    }
  }
}
