require "nvchad.options"


local rustScript = require("rust")
require('dap-go').setup()

local dap = require('dap')
local mason_registry = require("mason-registry")
local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
local codelldb_path = codelldb_root .. "adapter/codelldb"
-- local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"
--

-- adapter
dap.adapters.codelldb = {
  name = 'codelldb',
  type = 'server',
  port = "${port}",
  host = "127.0.0.1",
  executable = {
    command = codelldb_path,
    args = {"--port", "${port}"},
  }
}

-- configuration
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
dap.configurations.c = dap.configurations.cpp


dap.configurations.rust = {
  {
    name = "Launch bins",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug', 'file')
    end,
    cwd = '${workspaceFolder}',
    args = function()
      return vim.fn.input('args for executable: ')
    end,
    stopOnEntry = false,
  },
  {
    name = "Launch specific test",
    type = "codelldb",
    request = "launch",
    program = function()
      rustScript.build_rust_tests()
      local last_test = rustScript.run_last_test()
      return last_test
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
