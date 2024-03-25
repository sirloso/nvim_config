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

