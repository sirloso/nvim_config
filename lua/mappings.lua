require "nvchad.mappings"

-- set folding behavior
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<C-s>", "<cmd> w <cr>")
map("n", "<leader>C", ":Outline<CR>")
-- map leader + oc to close outline
-- map("n", "<leader>Oc", ":OutlineClose<CR>")

-- overrides <leader>b to open bufferline to <leader>bn
map("n", "<leader>bn", ":Buffer New<CR>")

-- quit mapping
map("n", "<leader>q", ":q<CR>")

-- show refernces list
map("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>")
-- show refernces list in telescope
map("n", "<leader>fr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>")
-- add break point
map("n", "<C-b>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
-- open dap-ui
map("n", "<C-d>t", "<cmd>lua require'dapui'.toggle()<CR>")
-- close dap-go
map("n", "<leader>go", "<cmd>lua require('dap').continue()<CR>")
-- debug test above cursor
map("n", "<C-d>lt", "<cmd>lua require'dap-go'.debug_test()<CR>")

-- horizontal split
map("n", "<C-w>c", "<cmd>:split<CR>")
-- format json
--
map('n',"<leader>jq",":%!jq '.'")

-- remove in line virtual 
vim.diagnostic.config({
  virtual_text = false, -- Turn off inline diagnostics
})

-- move lsp diagnostics to popup window
map( 'n', '<Leader>di', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })

-- overwrite new terminal so it's always present in tabs
map( 'n', '<Leader>v', ':term<cr>')

map( 'n', '<S-K>', ':lua vim.lsp.buf.hover()<cr>')

map("n", "<C-d>d", "<cmd>:DapNew<CR>")
