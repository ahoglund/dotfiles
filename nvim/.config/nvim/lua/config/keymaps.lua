-- Keymaps are automatically loaded on the VeryLazy event
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Save (supplement LazyVim's <C-s>)
vim.keymap.set({ "i", "x", "n", "s" }, "<leader>w", "<cmd>w!<cr>", { desc = "Save file" })

-- Clear search highlights (LazyVim uses <esc>; this adds Ctrl+B for muscle memory)
vim.keymap.set("n", "<C-b>", "<cmd>nohlsearch<cr><cmd>call clearmatches()<cr>", { desc = "Clear search highlights" })

-- Vertical split
vim.keymap.set("n", "<leader>vs", "<cmd>vsplit<cr>", { desc = "Vertical split" })

-- vim-test (all under <leader>t prefix to avoid conflicts with LazyVim's <leader>g git bindings)
vim.keymap.set("n", "<leader>tt", "<cmd>TestNearest<cr>", { desc = "Test Nearest" })
vim.keymap.set("n", "<leader>tT", "<cmd>TestFile<cr>", { desc = "Test File" })
vim.keymap.set("n", "<leader>ta", "<cmd>TestSuite<cr>", { desc = "Test Suite" })
vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>", { desc = "Test Last" })
vim.keymap.set("n", "<leader>tg", "<cmd>TestVisit<cr>", { desc = "Test Visit" })
