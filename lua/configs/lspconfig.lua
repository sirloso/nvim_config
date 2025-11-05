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
  "graphql",
  "html",
  "htmx",
  "lua_ls",
  "sqlls",
  "deno_ls",
  "buf",
  "solidity_ls",
  "typescript",
  "typescriptreact",
  "typescript.tsx"
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

local function get_buf_cmd()
  local handle = io.popen("which buf")
  local result = handle:read("*a")
  handle:close()
  -- Remove trailing newline
  result = result:gsub("[\n\r]", "")
  return result
end

-- Get Deno path
-- local deno_path = get_deno_cmd()
local buf_path = get_buf_cmd()

-- lspconfig.denols.setup {
--   cmd = { deno_path, "lsp" },  -- Specify the exact path to your Deno binary
--   capabilities = capabilities,
--   on_attach = on_attach,
--   root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
--   init_options = {
--     enable = true,
--     lint = true,
--     unstable = false,
--     suggest = {
--       imports = {
--         hosts = {
--           ["https://deno.land"] = true,
--           ["https://cdn.nest.land"] = true,
--           ["https://crux.land"] = true
--         }
--       }
--     }
--   }
-- }

lspconfig.clangd.setup {
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }, -- Remove 'proto' from this list
}

lspconfig.bufls.setup{
  filetypes = { "proto" },
  cmd = { buf_path, "beta", "lsp"},
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
