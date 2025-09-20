-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Prevent `d` from copying to clipboard
vim.keymap.set("n", "d", '"_d', { noremap = true, silent = true })
vim.keymap.set("v", "d", '"_d', { noremap = true, silent = true })

-- Paste without yanking replaced content in visual mode
vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })

-- Center screen when scrolling up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C -u>zz")
