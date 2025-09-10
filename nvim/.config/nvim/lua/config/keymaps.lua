-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Unindent in insert mode with Shift-Tab
vim.keymap.set("i", "<S-Tab>", "<C-d>", { noremap = true, silent = true, desc = "Unindent" })

-- Unindent in visual mode with Shift-Tab (optional)
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true, desc = "Unindent" })

-- Normal mode: indent/unindent but keep cursor in place
vim.keymap.set("n", "<Tab>", ">>_", { noremap = true, silent = true, desc = "Indent line" })
vim.keymap.set("n", "<S-Tab>", "<<_", { noremap = true, silent = true, desc = "Unindent line" })

----- WinShift.nvim -----
-------------------------
-- 1. Focus between splits (already in LazyVim by default, but we add descriptions)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

-- 2. Move entire windows (WinShift.nvim required)
vim.keymap.set("n", "<A-h>", "<Cmd>WinShift left<CR>", { desc = "Move window left" })
vim.keymap.set("n", "<A-j>", "<Cmd>WinShift down<CR>", { desc = "Move window down" })
vim.keymap.set("n", "<A-k>", "<Cmd>WinShift up<CR>", { desc = "Move window up" })
vim.keymap.set("n", "<A-l>", "<Cmd>WinShift right<CR>", { desc = "Move window right" })

-- 3. Resize splits (Alt+Shift+hjkl)
vim.keymap.set("n", "<A-S-h>", "<Cmd>vertical resize -2<CR>", { desc = "Shrink window horizontally" })
vim.keymap.set("n", "<A-S-l>", "<Cmd>vertical resize +2<CR>", { desc = "Grow window horizontally" })
vim.keymap.set("n", "<A-S-j>", "<Cmd>resize +2<CR>", { desc = "Grow window vertically" })
vim.keymap.set("n", "<A-S-k>", "<Cmd>resize -2<CR>", { desc = "Shrink window vertically" })
-------------------------
-------------------------
