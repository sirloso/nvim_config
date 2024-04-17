require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<C-s>", "<cmd> w <cr>")
map("n", "<leader>C", ":OutlineOpen<CR>")
-- map leader + oc to close outline
map("n", "<leader>Oc", ":OutlineClose<CR>")

-- overrides <leader>b to open bufferline to <leader>bn
map("n", "<leader>bn", ":Buffer New<CR>")

-- quit mapping
map("n", "<leader>q", ":q<CR>")

-- go to reference
map("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>")

-- add break point
map("n", "<C-b>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
-- open dap-ui
map("n", "<C-d>t", "<cmd>lua require'dapui'.toggle()<CR>")
-- close dap-go
map("n", "<leader>go", "<cmd>lua require('dap').continue()<CR>")
-- debug test above cursor
map("n", "<C-d>lt", "<cmd>lua require'dap-go'.debug_test()<CR>")
