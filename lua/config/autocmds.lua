-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_user_command("MasonSaveList", function()
  local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
  local packages = vim.fn.readdir(mason_packages)
  table.sort(packages)
  local outfile = vim.fn.stdpath("config") .. "/installed_mason.txt"
  vim.fn.writefile(packages, outfile)
  vim.notify("Saved " .. #packages .. " Mason packages to " .. outfile)
end, { desc = "Save the list of installed Mason packages to installed_mason.txt" })
