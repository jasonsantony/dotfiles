-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Esc remap
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })

-- Unindent in insert mode with Shift-Tab
vim.keymap.set("i", "<S-Tab>", "<C-d>", { noremap = true, silent = true, desc = "Unindent" })

-- Unindent in visual mode with Shift-Tab (optional)
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true, desc = "Unindent" })

-- Normal mode: indent/unindent but keep cursor in place
vim.keymap.set("n", "<Tab>", ">>_", { noremap = true, silent = true, desc = "Indent line" })
vim.keymap.set("n", "<S-Tab>", "<<_", { noremap = true, silent = true, desc = "Unindent line" })

----- Window management -----
-----------------------------
-- 1. Focus between splits (already in LazyVim by default, but we add descriptions)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

-- 2. Move entire windows (WinShift.nvim required)
vim.keymap.set("n", "<C-S-h>", "<Cmd>WinShift left<CR>", { desc = "Move window left" })
vim.keymap.set("n", "<C-S-j>", "<Cmd>WinShift down<CR>", { desc = "Move window down" })
vim.keymap.set("n", "<C-S-k>", "<Cmd>WinShift up<CR>", { desc = "Move window up" })
vim.keymap.set("n", "<C-S-l>", "<Cmd>WinShift right<CR>", { desc = "Move window right" })
-----------------------------
-----------------------------

-- Make <leader><space> open Snacks buffer picker
vim.keymap.set("n", "<leader><space>", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })
