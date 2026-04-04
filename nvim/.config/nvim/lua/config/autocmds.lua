-- Autocmds are automatically loaded on the VeryLazy event
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Convert tabs to spaces on save for specific filetypes
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.rb", "*.java", "*.kt" },
  callback = function()
    vim.cmd([[%s/\t\+/  /e]])
  end,
})
