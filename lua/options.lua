require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

require('dap-go').setup()

local dap = require('dap')
-- adapter
dap.adapters.lldb = {
  name = 'lldb',
  type = 'executable',
  command = ' /Users/los/homebrew/opt/llvm/bin/lldb-vscode ', -- adjust as needed, must be absolute path
}

-- configuration
dap.configurations.lldb = {
  name = 'Launch',
  type = 'lldb',
  request = 'launch',
  program = function()
    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  end,
  cwd = '${workspaceFolder}',
  stopOnEntry = false,
  args = {}
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

